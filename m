Return-Path: <netdev+bounces-205557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60714AFF3F6
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 23:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFC6817B0F2
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 21:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357422356C3;
	Wed,  9 Jul 2025 21:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpNjpXql"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A38DA92E;
	Wed,  9 Jul 2025 21:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752096990; cv=none; b=KfwcrTIFMcxrWEBNTLKK2XmcyvVH1rW8HoOsm9BoPxb2FWfmO6UCzQ0dFE9jurtWL+qC+OmPie4oYOem/Am4+9rRPvu5ynsSQM5DM694bwsfhQdffqQzBdPo6gGlUbThrum5iWJLEzCSi1FUZB//1+Z0Qk8kF0un3zkUnslKDNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752096990; c=relaxed/simple;
	bh=X09/sEb3XhamlC+vt9JdvngiL7149Hhsv9cY4kynNSo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pWhrspTTNKLmyFYZ7/Z9ZZ0TNZG7s5zYd5cfvtesl42f6Y4WMaqRQHkURQkgFFJqPsjPm2An4QTIxm5MsvYLnFreOt4S3AYal7evqe5a5fl9hXe3pkqFe5wx7dzKttIoF1OKKtozy9+8+jFTGtMzPCSiDK8Vxa48AfH3ooRHr14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpNjpXql; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22C7C4CEEF;
	Wed,  9 Jul 2025 21:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752096988;
	bh=X09/sEb3XhamlC+vt9JdvngiL7149Hhsv9cY4kynNSo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YpNjpXql0cENeLUbrpd51BO7B3T+jfccpMyTxMWWNaQdJF4aYQwjmvfCoYMba0JzX
	 0iB1TN6t6G5lZBG4SgE0RXIfFIWTxxlrb4005c9wEg9YHhFjBaQXpyIFSBh9HyKJXF
	 ZHIiR5cQB4gxjY8W+pqtA7eq114vN3SYKk8Qb+TUj4dW9rez5/u2qLmkLnApxwZc3R
	 H0yfpIsY53q2sqzYqoP7xqPAIyhXeWu5Hqromi2RVzkRo0cnG7gdQJIOyovAHIL+CB
	 PlBglwVTvqO/kWSHiStJ50ImpFIrM+s8DHQid+Ut8RkRoWjwWYcJyP2VUSpjxvy3mW
	 c8nk8uwxLqXEQ==
Date: Wed, 9 Jul 2025 14:36:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, dw@davidwei.uk
Subject: Re: [PATCH net-next v2] netdevsim: implement peer queue flow
 control
Message-ID: <20250709143627.5ddbf456@kernel.org>
In-Reply-To: <aG5FrObkP+S8cRZh@gmail.com>
References: <20250703-netdev_flow_control-v2-1-ab00341c9cc1@debian.org>
	<20250708182718.29c4ae45@kernel.org>
	<aG5FrObkP+S8cRZh@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Jul 2025 03:34:20 -0700 Breno Leitao wrote:

> On Tue, Jul 08, 2025 at 06:27:18PM -0700, Jakub Kicinski wrote:
> > On Thu, 03 Jul 2025 06:09:31 -0700 Breno Leitao wrote:  
> > > +static int nsim_napi_rx(struct net_device *dev, struct nsim_rq *rq,
> > > +			struct sk_buff *skb)
> > >  {
> > >  	if (skb_queue_len(&rq->skb_queue) > NSIM_RING_SIZE) {
> > > +		nsim_stop_peer_tx_queue(dev, rq, skb_get_queue_mapping(skb));
> > >  		dev_kfree_skb_any(skb);
> > >  		return NET_RX_DROP;
> > >  	}  
> > 
> > we should probably add:
> > 
> > 	if (skb_queue_len(&rq->skb_queue) > NSIM_RING_SIZE)
> > 		nsim_stop_tx_queue(dev, rq, skb_get_queue_mapping(skb));
> > 
> > after enqueuing the skb, so that we stop the queue before any drops
> > happen  
> 
> Agree, we can stop the queue when queueing the packets instead. Since we
> need to check for the queue numbers, we cannot call nsim_stop_tx_queue()
> straight away. I think we still need to have a helper
> (nsim_stop_tx_queue). This is what I have in mind:

LGTM!

> > > +	if (dev->real_num_tx_queues != peer_dev->num_rx_queues)  
> > 
> > given that we compare real_num_tx_queues I think we should also kick
> > the queues in nsim_set_channels(), like we do in unlink_device_store()  
> 
> Sure. I suppose something like the following. What do you think?
> 
> 	nsim_set_channels(struct net_device *dev, struct ethtool_channels *ch)
> 	{
> 		struct netdevsim *ns = netdev_priv(dev);
> 	+       struct netdevsim *peer;
> 		int err;
> 
> 		err = netif_set_real_num_queues(dev, ch->combined_count,
> 	@@ -113,6 +114,14 @@ nsim_set_channels(struct net_device *dev, struct ethtool_channels *ch)
> 			return err;
> 
> 		ns->ethtool.channels = ch->combined_count;
> 	+
> 	+	synchronize_net();
> 	+       netif_tx_wake_all_queues(dev);
> 	+       rcu_read_lock();
> 	+       peer = rcu_dereference(ns->peer);
> 	+       if (peer)
> 	+               netif_tx_wake_all_queues(peer->netdev);
> 	+       rcu_read_unlock();

That's sufficiently orthogonal to warrant a dedicated function / helper.

In terms of code I think we can skip the whole dance if peer is NULL?

> 		return 0;
> 	}
> 
> 
> Also, with this patch, we will eventually get the following critical
> message:
> 
> 	net_crit_ratelimited("Virtual device %s asks to queue packet!\n", dev->name);
> 
> I am wondering if that alert is not valid anymore, and I can simply
> remove it.

Ah. In nsim_setup() we should remove IFF_NO_QUEUE and stop setting
tx_queue_len to 0

