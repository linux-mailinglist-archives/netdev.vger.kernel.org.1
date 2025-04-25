Return-Path: <netdev+bounces-185796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF11CA9BC18
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 03:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FCAF3B3297
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 01:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1B6C2EF;
	Fri, 25 Apr 2025 01:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pktihD7d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67111EF1D;
	Fri, 25 Apr 2025 01:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745543015; cv=none; b=UvVQNDP4hl57TpG5A5PachKQ1YFGLl8xSq/3/8nSbYs4GsDCsPxmWYii8FQIZMBynQXgZXCZaVkHzVptXTXELPe7rv5xLCXs+kds86UC7yU94IQtdSmtjllLSMMlb8TQEVjxYcNReRKrar/9aSQsiPYfYu6n1n9pRACGAJztqRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745543015; c=relaxed/simple;
	bh=yy+VuSc3Fx0mRi+RTnQZNXeln2i/gLwDFQIeSQEDxnA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nCD4QvfStd/S1qGii+tKo06ZfiKOQ9TXpczjsv4oF5X3BjzXUY1u0UshAqMuf5W68PF4maAmuQ8h2xki0fOAlfCsb6PRhLyr7xsHwiyROxSNnCXNcVMPilnAjN1e0zbNSg5Shelg3/m6sNJHNyQqWv4rsQKHqTpibDbHwSsXDo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pktihD7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2DAC4CEE3;
	Fri, 25 Apr 2025 01:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745543015;
	bh=yy+VuSc3Fx0mRi+RTnQZNXeln2i/gLwDFQIeSQEDxnA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pktihD7do4jfpD4mk1hZOjAyS5YcYd8Fw5XK2UywqIyjcSEDkT9PCmYwRMe+Py9xN
	 vLvQaxaXXXLQ/nDojg8euNrFrC9wIp7eg5LuTL3P6r5/tLYR75sOsPm+yVSSUDZ7Dj
	 0cWcY16/rjvAgY0rqIAKtQ1EOgfUYCN+weN/dBAbkG9v9J5qkUVOwB3nMi4UTYhh08
	 RryYt+m26YUc65zjL+H1t9wXJ3sm5zWbwFERZaj3Xec28fWFeCLwFMSq5wwPcnQCgi
	 VEbY31thX8G1b+A+uBgn/Kizm2YR/HsVpb3Mm65P1gx/7aBCt3MmBd16UJTx7UO5Hn
	 T/vDf07kt/ihA==
Date: Thu, 24 Apr 2025 18:03:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Simon Horman <horms@kernel.org>, Romain Gantois
 <romain.gantois@bootlin.com>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>
Subject: Re: [PATCH net-next v7 1/3] net: ethtool: Introduce per-PHY DUMP
 operations
Message-ID: <20250424180333.035ff7d3@kernel.org>
In-Reply-To: <20250422161717.164440-2-maxime.chevallier@bootlin.com>
References: <20250422161717.164440-1-maxime.chevallier@bootlin.com>
	<20250422161717.164440-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Apr 2025 18:17:14 +0200 Maxime Chevallier wrote:
> +/* perphy ->start() handler for GET requests */

Just because I think there are real bugs, I will allow myself an
uber-nit of asking to spell the perphy as per-PHY or such in the
comment? :)

> +static int ethnl_perphy_start(struct netlink_callback *cb)
> +{
> +	struct ethnl_perphy_dump_ctx *phy_ctx = ethnl_perphy_dump_context(cb);
> +	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
> +	struct ethnl_dump_ctx *ctx = &phy_ctx->ethnl_ctx;
> +	struct ethnl_reply_data *reply_data;
> +	const struct ethnl_request_ops *ops;
> +	struct ethnl_req_info *req_info;
> +	struct genlmsghdr *ghdr;
> +	int ret;
> +
> +	BUILD_BUG_ON(sizeof(*ctx) > sizeof(cb->ctx));
> +
> +	ghdr = nlmsg_data(cb->nlh);
> +	ops = ethnl_default_requests[ghdr->cmd];
> +	if (WARN_ONCE(!ops, "cmd %u has no ethnl_request_ops\n", ghdr->cmd))
> +		return -EOPNOTSUPP;
> +	req_info = kzalloc(ops->req_info_size, GFP_KERNEL);
> +	if (!req_info)
> +		return -ENOMEM;
> +	reply_data = kmalloc(ops->reply_data_size, GFP_KERNEL);
> +	if (!reply_data) {
> +		ret = -ENOMEM;
> +		goto free_req_info;
> +	}
> +
> +	/* Don't ignore the dev even for DUMP requests */

another nit, this comment wasn't super clear without looking at the dump
for non-per-phy case. Maybe:

	/* Unlike per-dev dump, don't ignore dev. The dump handler
	 * will notice it and dump PHYs from given dev.
	 */
?

> +	ret = ethnl_default_parse(req_info, &info->info, ops, false);
> +	if (ret < 0)
> +		goto free_reply_data;
> +
> +	ctx->ops = ops;
> +	ctx->req_info = req_info;
> +	ctx->reply_data = reply_data;
> +	ctx->pos_ifindex = 0;
> +
> +	return 0;
> +
> +free_reply_data:
> +	kfree(reply_data);
> +free_req_info:
> +	kfree(req_info);
> +
> +	return ret;
> +}
> +
> +static int ethnl_perphy_dump_one_dev(struct sk_buff *skb,
> +				     struct net_device *dev,
> +				     struct ethnl_perphy_dump_ctx *ctx,
> +				     const struct genl_info *info)
> +{
> +	struct ethnl_dump_ctx *ethnl_ctx = &ctx->ethnl_ctx;
> +	struct phy_device_node *pdn;
> +	int ret = 0;
> +
> +	if (!dev->link_topo)
> +		return 0;

Now for the bugs..

> +	xa_for_each_start(&dev->link_topo->phys, ctx->pos_phyindex, pdn,
> +			  ctx->pos_phyindex) {
> +		ethnl_ctx->req_info->phy_index = ctx->pos_phyindex;
> +
> +		/* We can re-use the original dump_one as ->prepare_data in
> +		 * commands use ethnl_req_get_phydev(), which gets the PHY from
> +		 * the req_info->phy_index
> +		 */
> +		ret = ethnl_default_dump_one(skb, dev, ethnl_ctx, info);
> +		if (ret)
> +			break;

		return ret;

> +	}

	ctx->pos_phyindex = 0;

	return 0;

IOW I don't see you resetting the pos_phyindex, so I think you'd only
dump correctly the first device? The next device will try to dump its
PHYs starting from the last index of the previous dev's PHY? [1]

> +	return ret;
> +}
> +
> +static int ethnl_perphy_dump_all_dev(struct sk_buff *skb,
> +				     struct ethnl_perphy_dump_ctx *ctx,
> +				     const struct genl_info *info)
> +{
> +	struct ethnl_dump_ctx *ethnl_ctx = &ctx->ethnl_ctx;
> +	struct net *net = sock_net(skb->sk);
> +	netdevice_tracker dev_tracker;
> +	struct net_device *dev;
> +	int ret = 0;
> +
> +	rcu_read_lock();
> +	for_each_netdev_dump(net, dev, ethnl_ctx->pos_ifindex) {
> +		netdev_hold(dev, &dev_tracker, GFP_ATOMIC);
> +		rcu_read_unlock();
> +
> +		/* per-PHY commands use ethnl_req_get_phydev(), which needs the
> +		 * net_device in the req_info
> +		 */
> +		ethnl_ctx->req_info->dev = dev;
> +		ret = ethnl_perphy_dump_one_dev(skb, dev, ctx, info);
> +
> +		rcu_read_lock();
> +		netdev_put(dev, &dev_tracker);

missing

		ethnl_ctx->req_info->dev = NULL;

right? Otherwise if we need to send multiple skbs the "continuation"
one will think we're doing a filtered dump.

Looking at commits 7c93a88785dae6 and c0111878d45e may be helpful,
but I doubt you can test it on a real system, filling even 4kB
may be hard for small messages :(

> +		if (ret < 0 && ret != -EOPNOTSUPP) {
> +			if (likely(skb->len))
> +				ret = skb->len;
> +			break;
> +		}
> +		ret = 0;

[1] or you can clear the pos_index here

> +	}
> +	rcu_read_unlock();
> +
> +	return ret;
> +}
> +
> +/* perphy ->dumpit() handler for GET requests. */
> +static int ethnl_perphy_dumpit(struct sk_buff *skb,
> +			       struct netlink_callback *cb)
> +{
> +	struct ethnl_perphy_dump_ctx *ctx = ethnl_perphy_dump_context(cb);
> +	struct ethnl_dump_ctx *ethnl_ctx = &ctx->ethnl_ctx;
> +	int ret = 0;
> +
> +	if (ethnl_ctx->req_info->dev) {
> +		ret = ethnl_perphy_dump_one_dev(skb, ethnl_ctx->req_info->dev,
> +						ctx, genl_info_dump(cb));
> +		if (ret < 0 && ret != -EOPNOTSUPP && likely(skb->len))
> +			ret = skb->len;
> +
> +		netdev_put(ethnl_ctx->req_info->dev,
> +			   &ethnl_ctx->req_info->dev_tracker);

You have to release this in .done
dumpit gets called multiple times until we run out of objects to dump.
OTOH user may close the socket without finishing the dump operation.
So all .dumpit implementations must be "balanced". The only state we
should touch in them is the dump context to know where to pick up from
next time.

> +	} else {
> +		ret = ethnl_perphy_dump_all_dev(skb, ctx, genl_info_dump(cb));
> +	}
> +
> +	return ret;
> +}

