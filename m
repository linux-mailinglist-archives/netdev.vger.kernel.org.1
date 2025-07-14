Return-Path: <netdev+bounces-206769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C423DB0454D
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 301DD1883ABC
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 16:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FF1255F5C;
	Mon, 14 Jul 2025 16:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="getHtR+k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8AE1DE4E1
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 16:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752509751; cv=none; b=eD5C/ZagNt66uXSV41+Gs5TQ4CqKdD1DiSO+veEP5Q5SqV1LuHLCMnK/4a2cVx79G+4VzHWZ6fQdtLO5DUfL/hUoS4iwFIHurxpzvRXZXyr1GPuJsy6vp4rXCNIReTbJaQGQ058BdDrF4iC/6aOJaszUPSwVrz+SLo0Co+r516w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752509751; c=relaxed/simple;
	bh=WkAZufqFsdmBx9F7JBPs9jhGuXuwwgOVDi3u1WmRi3c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pxeINIt71dOuCB2ziv/msKKxh1pnsP9Le7bcWc9vG5JPzY+/2LVMxthzUMkZNbOdRJnMYDQ6CJ52EwKld1rflJ8l54Yc+uow2bBa9RVxmrYimVpl6y08MPwJppCcQeWL1ao7EXvq/c2SQcWNHug6tkpiCFrvniGHfE9Szf2JNmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=getHtR+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C798C4CEED;
	Mon, 14 Jul 2025 16:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752509750;
	bh=WkAZufqFsdmBx9F7JBPs9jhGuXuwwgOVDi3u1WmRi3c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=getHtR+k9MbTFsHApXYXrM5IEgeMwVctdKzlmK/LnUus84Xjv060iCSgEqtA7Z8l+
	 3TublNOAZsD3kKvp4Im85q/3s11ur9KU2x1CQxczALq9HUIy3RTGo4T6BDlJuS9Hej
	 cE/Nx1KmnPque7GpF+y0kgUo8fRCE52uTxgyM6OB9ma6jMqX16FVYsqd/OF3Fg8ueI
	 h9wTWpNZ43/43fRCI0pKcJKooRMY/AX6nEDhNjPhc2aIfUeaZMXiCdKG1WiJfcrse1
	 3AlIb5Zd6a8KfSjz5WQ3KOq7FangOAyo3ZhmosRkGU+ks+pxkzlRgLhBt8Q7lapYye
	 DQlOM0u+D7bFQ==
Date: Mon, 14 Jul 2025 09:15:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, shuah@kernel.org, kory.maincent@bootlin.com,
 maxime.chevallier@bootlin.com, sdf@fomichev.me, ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next 01/11] ethtool: rss: initial RSS_SET
 (indirection table handling)
Message-ID: <20250714091548.1a7c999b@kernel.org>
In-Reply-To: <cd1af256-1447-4b94-8cf5-8e41014f7bad@nvidia.com>
References: <20250711015303.3688717-1-kuba@kernel.org>
	<20250711015303.3688717-2-kuba@kernel.org>
	<cd1af256-1447-4b94-8cf5-8e41014f7bad@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Jul 2025 14:08:48 +0300 Gal Pressman wrote:
> >  static const struct genl_multicast_group ethtool_nl_mcgrps[] = {
> > diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
> > index 41ab9fc67652..7167fc3c27a0 100644
> > --- a/net/ethtool/rss.c
> > +++ b/net/ethtool/rss.c
> > @@ -218,6 +218,8 @@ rss_prepare(const struct rss_req_info *request, struct net_device *dev,
> >  {
> >  	rss_prepare_flow_hash(request, dev, data, info);
> >  
> > +	if (!dev->ethtool_ops->get_rxfh)
> > +		return 0;  
> 
> What is this for?

Silly drivers which support selecting which fields are hashed, 
but don't have a callback for basic RSS config. I'll add a comment.

> >  	if (request->rss_context)
> >  		return rss_prepare_ctx(request, dev, data, info);
> >  	return rss_prepare_get(request, dev, data, info);
> > @@ -466,6 +468,192 @@ void ethtool_rss_notify(struct net_device *dev, u32 rss_context)
> >  	ethnl_notify(dev, ETHTOOL_MSG_RSS_NTF, &req_info.base);
> >  }
> >  
> > +static int
> > +ethnl_rss_set_validate(struct ethnl_req_info *req_info, struct genl_info *info)
> > +{
> > +	const struct ethtool_ops *ops = req_info->dev->ethtool_ops;
> > +	struct rss_req_info *request = RSS_REQINFO(req_info);
> > +	struct nlattr **tb = info->attrs;
> > +	struct nlattr *bad_attr = NULL;
> > +
> > +	if (request->rss_context && !ops->create_rxfh_context)
> > +		bad_attr = bad_attr ?: tb[ETHTOOL_A_RSS_CONTEXT];  
> 
> If we wish to be consistent with the ioctl flow, we should also check
> that "at least one change was requested".
> 
> i.e., if (!tb[ETHTOOL_A_RSS_INDIR]) return err?

I was wondering about that, netlink ethtool doesn't have such checks
for other ops. I think consistency within the netlink family trumps 
the random check in the ioctl code.

> > +	rxfh->indir_size = data->indir_size;
> > +	alloc_size = array_size(data->indir_size, sizeof(rxfh->indir[0]));
> > +	rxfh->indir = kzalloc(alloc_size, GFP_KERNEL);
> > +	if (!rxfh->indir)
> > +		return -ENOMEM;
> > +
> > +	nla_memcpy(rxfh->indir, tb[ETHTOOL_A_RSS_INDIR], alloc_size);  
> 
> ethnl_update_binary() will take care of the explicit memcmp down the line?
> 
> > +	for (i = 0; i < user_size; i++) {
> > +		if (rxfh->indir[i] < rx_rings.data)
> > +			continue;
> > +
> > +		NL_SET_ERR_MSG_ATTR_FMT(extack, tb[ETHTOOL_A_RSS_INDIR],
> > +					"entry %d: queue out of range (%d)",
> > +					i, rxfh->indir[i]);
> > +		err = -EINVAL;
> > +		goto err_free;
> > +	}
> > +
> > +	if (user_size) {
> > +		/* Replicate the user-provided table to fill the device table */
> > +		for (i = user_size; i < data->indir_size; i++)
> > +			rxfh->indir[i] = rxfh->indir[i % user_size];
> > +	} else {
> > +		for (i = 0; i < data->indir_size; i++)
> > +			rxfh->indir[i] =
> > +				ethtool_rxfh_indir_default(i, rx_rings.data);  
> 
> Unless you wanted the mcmp to also take care of this case?

Yes, and I think the case of upsizing could also result in false
negatives if we don't memcmp() the whole array.

> > +	if (ctx)
> > +		rss_set_ctx_update(ctx, tb, &data, &rxfh);
> > +	else if (indir_reset)
> > +		dev->priv_flags &= ~IFF_RXFH_CONFIGURED;
> > +	else if (indir_mod)
> > +		dev->priv_flags |= IFF_RXFH_CONFIGURED;  
> 
> One can argue that IFF_RXFH_CONFIGURED should be set even if the
> requested table is equal to the default one.

Good catch.

