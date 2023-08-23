Return-Path: <netdev+bounces-29835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0943784DF8
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 02:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AAAE281222
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 00:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454E37E2;
	Wed, 23 Aug 2023 00:51:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891EC10E3
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 00:51:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C896BC433C8;
	Wed, 23 Aug 2023 00:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692751873;
	bh=eRHArnhd385DnQtcHW1suLPoM+yScVfvIU1ViDzrBMw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KSNgOFVoNyvzJbz/HCGdhzi5o17zr7Nzqp6fWIoL/KjL1PuBv9fn2XnPolv3K0RGs
	 CJ1xUqnHEkuxYaiZJ8C3jS3rILcrnKqvGcvL6nCJ5XZWdcyK9OQS8DKz4uAqAHmt5j
	 wb0rwyiLnG6r0ITTklwuCMZ383Q5Yvi25WcwOKCKjQ1unVX5kxHFe4wd2Iqxv9KX+a
	 1lXjo8drYesfTYmulv/6vxrEN+aBzEi667NdXm7fKMhuyXXlC0upyu8YbolMC4uXI5
	 hj4PoLCWkmht884M/2X0Ph81QGbAQGr5scMUnys4YrukQCb05ibcqSFKgFSB/dpJ96
	 I9rJDr/JqHZOA==
Date: Tue, 22 Aug 2023 17:51:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Amritha Nambiar <amritha.nambiar@intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, sridhar.samudrala@intel.com
Subject: Re: [net-next PATCH v2 5/9] netdev-genl: Add netlink framework
 functions for napi
Message-ID: <20230822175111.78d4fe32@kernel.org>
In-Reply-To: <169266033666.10199.3744908214828788701.stgit@anambiarhost.jf.intel.com>
References: <169266003844.10199.10450480941022607696.stgit@anambiarhost.jf.intel.com>
	<169266033666.10199.3744908214828788701.stgit@anambiarhost.jf.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Aug 2023 16:25:36 -0700 Amritha Nambiar wrote:
> Implement the netdev netlink framework functions for
> napi support. The netdev structure tracks all the napi
> instances and napi fields. The napi instances and associated
> queue[s] can be retrieved this way.
> 
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>

> @@ -119,14 +134,158 @@ int netdev_nl_dev_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>  	return skb->len;
>  }
>  
> +static int
> +netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
> +			const struct genl_info *info)
> +{
> +	struct netdev_rx_queue *rx_queue, *rxq;
> +	struct netdev_queue *tx_queue, *txq;
> +	unsigned int rx_qid, tx_qid;
> +	void *hdr;
> +
> +	if (!napi->dev)
> +		return -EINVAL;

WARN_ON_ONCE()? If this can be assumed not to happen.

> +	hdr = genlmsg_iput(rsp, info);
> +	if (!hdr)
> +		return -EMSGSIZE;
> +
> +	if (nla_put_u32(rsp, NETDEV_A_NAPI_NAPI_ID, napi->napi_id))

napi_id can be zero.

> +		goto nla_put_failure;
> +
> +	if (nla_put_u32(rsp, NETDEV_A_NAPI_IFINDEX, napi->dev->ifindex))
> +		goto nla_put_failure;

>  int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info)
>  {
> -	return -EOPNOTSUPP;
> +	struct net_device *netdev;
> +	struct sk_buff *rsp;
> +	u32 napi_id;
> +	int err;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_NAPI_NAPI_ID))
> +		return -EINVAL;
> +
> +	napi_id = nla_get_u32(info->attrs[NETDEV_A_NAPI_NAPI_ID]);
> +
> +	rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
> +	if (!rsp)
> +		return -ENOMEM;
> +
> +	rtnl_lock();
> +
> +	netdev = dev_get_by_napi_id(napi_id);

Why lookup the dev and not the NAPI?

> +	if (netdev)
> +		err  = netdev_nl_napi_fill(netdev, rsp, info, napi_id);
> +	else
> +		err = -ENODEV;
> +
> +	rtnl_unlock();
> +
> +	if (err)
> +		goto err_free_msg;
> +
> +	return genlmsg_reply(rsp, info);
> +
> +err_free_msg:
> +	nlmsg_free(rsp);
> +	return err;
> +}
> +
> +static int
> +netdev_nl_napi_dump_one(struct net_device *netdev, struct sk_buff *rsp,
> +			const struct genl_info *info, int *start)
> +{
> +	struct napi_struct *napi, *n;
> +	int err = 0;
> +	int i = 0;
> +
> +	list_for_each_entry_safe(napi, n, &netdev->napi_list, dev_list) {

Why _safe()? I think you need _rcu() instead?

> +		if (i < *start) {
> +			i++;
> +			continue;
> +		}
> +		err = netdev_nl_napi_fill_one(rsp, napi, info);
> +		if (err)
> +			break;
> +		*start = ++i;

Why count them instead of relying on the IDs?

>  int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>  {
> -	return -EOPNOTSUPP;
> +	const struct genl_dumpit_info *info = genl_dumpit_info(cb);

You can get genl_info_dump(cb) here, you don't use the genl_dumpit_info
AFAICT, only info->info.

