Return-Path: <netdev+bounces-39788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 858EA7C47C2
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 04:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7927280F5F
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 02:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0439A4689;
	Wed, 11 Oct 2023 02:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMLalnLT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2755211C
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 02:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302E9C433C7;
	Wed, 11 Oct 2023 02:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696991156;
	bh=0SClLoNr+b/0clcqYloD/uKGqFSEky+QyM4FxNxQmj8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZMLalnLTurcmE0us+rtoENNaZH9nPBPP8iZxfpBAOCnbaa+/Ipjf86ViZmeO1Obi/
	 6jRFvyX/Gd1pP4xQlZK6hudS5NRH2OlvOJgAte3x1kAE8FiKugRz2EGJvLln4pe2Lz
	 dT4z1S30EpS2U0LHsW8PURKSnEdTSDBNxo8Mbvz4Fdq09CRP/c3l/biIEdE6Pb54UF
	 MNVSVQWguZBBvrQs1Z1+KEctqMEBevYBKd958SCe+s+nS2hKwiyME0ZuFgnwZTc7Ok
	 EYpTizLpE5uGP/WZzbenNo2d9MKA0+uqCYab0FRay4+jr5bBzOAqst1i9MAAvrSI4x
	 J457OZb/6c7AQ==
Date: Tue, 10 Oct 2023 19:25:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Amritha Nambiar <amritha.nambiar@intel.com>
Cc: netdev@vger.kernel.org, sridhar.samudrala@intel.com
Subject: Re: [net-next PATCH v4 04/10] netdev-genl: Add netlink framework
 functions for queue
Message-ID: <20231010192555.3126ca42@kernel.org>
In-Reply-To: <169658369951.3683.3529038539593903265.stgit@anambiarhost.jf.intel.com>
References: <169658340079.3683.13049063254569592908.stgit@anambiarhost.jf.intel.com>
	<169658369951.3683.3529038539593903265.stgit@anambiarhost.jf.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 06 Oct 2023 02:14:59 -0700 Amritha Nambiar wrote:
> +static int
> +netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
> +			 u32 q_idx, u32 q_type, const struct genl_info *info)
> +{
> +	struct netdev_rx_queue *rxq;
> +	struct netdev_queue *txq;
> +	void *hdr;
> +
> +	hdr = genlmsg_iput(rsp, info);
> +	if (!hdr)
> +		return -EMSGSIZE;
> +
> +	if (nla_put_u32(rsp, NETDEV_A_QUEUE_QUEUE_ID, q_idx))
> +		goto nla_put_failure;
> +
> +	if (nla_put_u32(rsp, NETDEV_A_QUEUE_QUEUE_TYPE, q_type))
> +		goto nla_put_failure;
> +
> +	if (nla_put_u32(rsp, NETDEV_A_QUEUE_IFINDEX, netdev->ifindex))
> +		goto nla_put_failure;

You can combine these ifs in a single one using ||

> +	switch (q_type) {
> +	case NETDEV_QUEUE_TYPE_RX:
> +		rxq = __netif_get_rx_queue(netdev, q_idx);
> +		if (rxq->napi && nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID,

> +static int netdev_nl_queue_validate(struct net_device *netdev, u32 q_id,
> +				    u32 q_type)
> +{
> +	switch (q_type) {
> +	case NETDEV_QUEUE_TYPE_RX:
> +		if (q_id >= netdev->real_num_rx_queues)
> +			return -EINVAL;
> +		return 0;
> +	case NETDEV_QUEUE_TYPE_TX:
> +		if (q_id >= netdev->real_num_tx_queues)
> +			return -EINVAL;
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;

Doesn't the netlink policy prevent this already?

> +	}
> +}

>  int netdev_nl_queue_get_doit(struct sk_buff *skb, struct genl_info *info)
>  {
> -	return -EOPNOTSUPP;
> +	u32 q_id, q_type, ifindex;
> +	struct net_device *netdev;
> +	struct sk_buff *rsp;
> +	int err;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_QUEUE_ID))
> +		return -EINVAL;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_QUEUE_TYPE))
> +		return -EINVAL;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_IFINDEX))
> +		return -EINVAL;

You can combine these checks in a single if using ||

> +	q_id = nla_get_u32(info->attrs[NETDEV_A_QUEUE_QUEUE_ID]);
> +
> +	q_type = nla_get_u32(info->attrs[NETDEV_A_QUEUE_QUEUE_TYPE]);
> +
> +	ifindex = nla_get_u32(info->attrs[NETDEV_A_QUEUE_IFINDEX]);

No need for the empty lines between these.

> +	rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
> +	if (!rsp)
> +		return -ENOMEM;
> +
> +	rtnl_lock();
> +
> +	netdev = __dev_get_by_index(genl_info_net(info), ifindex);
> +	if (netdev)
> +		err  = netdev_nl_queue_fill(rsp, netdev, q_id, q_type, info);

double space after =

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
> +netdev_nl_queue_dump_one(struct net_device *netdev, struct sk_buff *rsp,
> +			 const struct genl_info *info, unsigned int *start_rx,
> +			 unsigned int *start_tx)
> +{

Hm. Not sure why you don't operate directly on ctx here.
Why pass the indexes by pointer individually?

> +	int err = 0;
> +	int i;
> +
> +	for (i = *start_rx; i < netdev->real_num_rx_queues;) {
> +		err = netdev_nl_queue_fill_one(rsp, netdev, i,
> +					       NETDEV_QUEUE_TYPE_RX, info);
> +		if (err)
> +			goto out_err;

return, no need to goto if all it does is returns

> +		*start_rx = i++;
> +	}
> +	for (i = *start_tx; i < netdev->real_num_tx_queues;) {
> +		err = netdev_nl_queue_fill_one(rsp, netdev, i,
> +					       NETDEV_QUEUE_TYPE_TX, info);
> +		if (err)
> +			goto out_err;
> +		*start_tx = i++;
> +	}
> +out_err:
> +	return err;
>  }
>  
>  int netdev_nl_queue_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>  {
> -	return -EOPNOTSUPP;
> +	struct netdev_nl_dump_ctx *ctx = netdev_dump_ctx(cb);
> +	const struct genl_info *info = genl_info_dump(cb);
> +	struct net *net = sock_net(skb->sk);
> +	unsigned int rxq_idx = ctx->rxq_idx;
> +	unsigned int txq_idx = ctx->txq_idx;
> +	struct net_device *netdev;
> +	u32 ifindex = 0;
> +	int err = 0;
> +
> +	if (info->attrs[NETDEV_A_QUEUE_IFINDEX])
> +		ifindex = nla_get_u32(info->attrs[NETDEV_A_QUEUE_IFINDEX]);
> +
> +	rtnl_lock();
> +	if (ifindex) {
> +		netdev = __dev_get_by_index(net, ifindex);
> +		if (netdev)
> +			err = netdev_nl_queue_dump_one(netdev, skb, info,
> +						       &rxq_idx, &txq_idx);
> +		else
> +			err = -ENODEV;
> +	} else {
> +		for_each_netdev_dump(net, netdev, ctx->ifindex) {
> +			err = netdev_nl_queue_dump_one(netdev, skb, info,
> +						       &rxq_idx, &txq_idx);
> +

unnecessary new line

> +			if (err < 0)
> +				break;
> +			if (!err) {

it only returns 0 or negative errno, doesn't it?

> +				rxq_idx = 0;
> +				txq_idx = 0;
> +			}
> +		}
> +	}
> +	rtnl_unlock();
> +
> +	if (err != -EMSGSIZE)
> +		return err;
> +
> +	ctx->rxq_idx = rxq_idx;
> +	ctx->txq_idx = txq_idx;
> +	return skb->len;
>  }
>  
>  static int netdev_genl_netdevice_event(struct notifier_block *nb,
> 


