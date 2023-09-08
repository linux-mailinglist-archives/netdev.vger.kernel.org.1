Return-Path: <netdev+bounces-32678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1911479919F
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 23:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FEB61C20CC9
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 21:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD21430FBF;
	Fri,  8 Sep 2023 21:49:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7C81C39
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 21:49:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D8CC433C9;
	Fri,  8 Sep 2023 21:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694209750;
	bh=4mnPVpyCVE3F/FD7bixq4POO6Pw+/pAH+2ANeTbfmlo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L0u45HU0G8qNBcKYI+LZSDdfnJDUS9FZE9rSrCO9q1vcx14pJRpO83ooGsD+d8dRP
	 INhz3pOR7Cmv9BAJVRy9xdxCshyivVEq0ipq0yGwhzPRe3vjx7jQhaDIkb9+I5p08G
	 gF1H5MdwmZ8INKAZKXcenudXJXbkxSoyvdA1a3vpodHMH44r66kDzy7jssRJSpsMSF
	 Amiik5vl4Ewjn5dpq0uFiF4R8U9Jhff8TEK6pwlZftN+pzEkWrbna2s11NzDZtbQdY
	 2S8u6pYTGZA5CAK7LXgxKdz4ibuWPvD2qp7gnDgb8BBrZKUWXF/QYn3ogd4VzQOS4S
	 Gz5uPud9uJ0Vw==
Date: Fri, 8 Sep 2023 14:49:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, borisp@nvidia.com, galshalom@nvidia.com,
 mgurtovoy@nvidia.com
Subject: Re: [PATCH v14 02/20] netlink: add new family to manage ULP_DDP
 enablement and stats
Message-ID: <20230908144909.5d7a36ce@kernel.org>
In-Reply-To: <20230906113018.2856-3-aaptel@nvidia.com>
References: <20230906113018.2856-1-aaptel@nvidia.com>
	<20230906113018.2856-3-aaptel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Sep 2023 11:30:00 +0000 Aurelien Aptel wrote:
> Add a new netlink family to get/set ULP DDP capabilities on a network
> device and to retrieve statistics.
> 
> The messages use the genetlink infrastructure and are specified in a
> YAML file which was used to generate some of the files in this commit:
> 
> ./tools/net/ynl/ynl-gen-c.py --mode kernel \
>     --spec ./Documentation/netlink/specs/ulp_ddp.yaml --header \
>     -o net/core/ulp_ddp_gen_nl.h
> ./tools/net/ynl/ynl-gen-c.py --mode kernel \
>     --spec ./Documentation/netlink/specs/ulp_ddp.yaml --source \
>     -o net/core/ulp_ddp_gen_nl.c
> ./tools/net/ynl/ynl-gen-c.py --mode uapi \
>     --spec ./Documentation/netlink/specs/ulp_ddp.yaml --header \
>     > include/uapi/linux/ulp_ddp_nl.h  

Looks mostly good, but we lost dump support. TAL at netdev_nl_dev_get_dumpit(), 
the iteration is not that hard, I reckon we should support dumps.

Few extra nits below.

> +static struct ulp_ddp_netdev_caps *netdev_ulp_ddp_caps(struct net_device *dev)
> +{
> +#ifdef CONFIG_ULP_DDP
> +	return &dev->ulp_ddp_caps;
> +#else
> +	return NULL;
> +#endif

Are the ifdefs still needed? Can't we compile out all of the family code
if the config is not selected?

> +/* pre_doit */
> +int ulp_ddp_get_netdev(const struct genl_split_ops *ops,
> +		       struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct reply_data *data;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, ULP_DDP_A_DEV_IFINDEX))
> +		return -EINVAL;
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->ifindex = nla_get_u32(info->attrs[ULP_DDP_A_DEV_IFINDEX]);
> +	data->dev = netdev_get_by_index(genl_info_net(info),
> +					data->ifindex,
> +					&data->tracker,
> +					GFP_KERNEL);
> +

nit pointless empty line.

> +	if (!data->dev) {
> +		kfree(data);
> +		return -EINVAL;

ENOENT ? Maybe also 

		NL_SET_BAD_ATTR(info->extack, info->attrs[ULP_DDP_A_DEV_IFINDEX]) 
?

> +int ulp_ddp_nl_set_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct reply_data *data = info->user_ptr[0];
> +	unsigned long wanted, wanted_mask;
> +	struct sk_buff *rsp;
> +	bool notify;
> +	int ret;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, ULP_DDP_A_DEV_WANTED) ||
> +	    GENL_REQ_ATTR_CHECK(info, ULP_DDP_A_DEV_WANTED_MASK))
> +		return -EINVAL;
> +
> +	rsp = genlmsg_new(reply_size(ULP_DDP_CMD_STATS), GFP_KERNEL);
> +	if (!rsp)
> +		return -EMSGSIZE;
> +
> +	wanted = nla_get_u64(info->attrs[ULP_DDP_A_DEV_WANTED]);
> +	wanted_mask = nla_get_u64(info->attrs[ULP_DDP_A_DEV_WANTED_MASK]);
> +
> +	ret = apply_bits(data, &wanted, &wanted_mask, info->extack);
> +	if (ret < 0)
> +		return ret;

leaks rsp

> +	notify = !!ret;
> +	ret = prepare_data(info, data, ULP_DDP_CMD_SET);
> +	if (ret)
> +		return ret;
> +
> +	ret = fill_data(rsp, data, ULP_DDP_CMD_SET, info->snd_portid, info->snd_seq, 0);

fill_date() can probably use genlmsg_iput() ?
-- 
pw-bot: cr

