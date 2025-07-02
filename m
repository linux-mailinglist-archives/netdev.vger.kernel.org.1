Return-Path: <netdev+bounces-203512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A29AF63BE
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 23:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BCF8520E4E
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 21:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54489220F23;
	Wed,  2 Jul 2025 21:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O84DrKlU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9CB1E5711;
	Wed,  2 Jul 2025 21:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751490434; cv=none; b=KxLf5RFVEC29pCp2TLWV4PJS2mrLljPXavcK4EwNKEnbSC2MTF2m685unzCw9XQ7oK5m3m64epU/zOdnye/uVzcurYFhsjR7hO0w7GmqWo916EFDJyaayWnY+5nLFgDk0vnDA58whWQfbYAVzAyQT3TIC6sG+bLf8f0HdvUNwBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751490434; c=relaxed/simple;
	bh=TyhQ0oEweF8WrmC/HiunY3p0d3snoCt53CLFHfUzCwI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=imNYOomfSfEoehoXefXQeIN/EuV5E8LmOCNMHWIFUol60VvqbtvU+OwNRCymdD3xXTooIga8M416hk7Fk49vVVgVtF6RqGlxbpJFd8emH4G7wjvQu5+b8D+jNEye/IGDsl8fAa9HZ1aqv68j1CohHBaeKwiXUIe8Ue/rFiDVff4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O84DrKlU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464E5C4CEE7;
	Wed,  2 Jul 2025 21:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751490433;
	bh=TyhQ0oEweF8WrmC/HiunY3p0d3snoCt53CLFHfUzCwI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O84DrKlUVzlLq9YCWdCTO+8N4ei50n3uc/ttvxLy23A7DzpLYhs9eusQeaAMVc1Wh
	 KJxkFHK0BIOg67XbTd5Ba/+R4DvyEkir9lddxzSfDsJdBwKLRoSebDEilCWPN3mp75
	 qNdkFJqoyl7ePHMEe1/Fn6Enb7uK/NJ2yT6T4Xp6O8XgF4c/YlA9cF+PHHhUB6MGr9
	 yR5VrZTLRLMYKRhlTUYSSkhaU6tKBjnJVkMK/Q80f2imLbnhpk8eYqirLbNK1mqZGo
	 /RaeIGqHCIGE0KhRAFMzKWMtIhYIzThsQHQvxnHQzuYTgH5adOU0K+9aKqRLC487od
	 PRrk8DkjCPcVA==
Date: Wed, 2 Jul 2025 14:07:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dw@davidwei.uk, kernel-team@meta.com
Subject: Re: [PATCH net-next] netdevsim: implement peer queue flow control
Message-ID: <20250702140712.55570adf@kernel.org>
In-Reply-To: <20250701-netdev_flow_control-v1-1-240329fc91b1@debian.org>
References: <20250701-netdev_flow_control-v1-1-240329fc91b1@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 01 Jul 2025 11:10:56 -0700 Breno Leitao wrote:
> +static void nsim_wake_queue(struct net_device *net, struct netdev_queue *txq, void *unused)
> +{
> +	if (!(netif_tx_queue_stopped(txq)))
> +		return;
> +	netif_tx_wake_queue(txq);
> +}
> +
> +static void nsim_wake_all_queues(struct net_device *dev, struct net_device *peer_dev)
> +{
> +	netdev_for_each_tx_queue(peer_dev, nsim_wake_queue, NULL);
> +	netdev_for_each_tx_queue(dev, nsim_wake_queue, NULL);

I think you can use netif_tx_wake_all_queues() directly in the caller

> +}
> +
>  static ssize_t unlink_device_store(const struct bus_type *bus, const char *buf, size_t count)
>  {
>  	struct netdevsim *nsim, *peer;
> @@ -367,6 +380,9 @@ static ssize_t unlink_device_store(const struct bus_type *bus, const char *buf,
>  	RCU_INIT_POINTER(nsim->peer, NULL);
>  	RCU_INIT_POINTER(peer->peer, NULL);
>  
> +	synchronize_net();
> +	nsim_wake_all_queues(dev, peer->netdev);
> +
>  out_put_netns:
>  	put_net(ns);
>  	rtnl_unlock();


> -static int nsim_napi_rx(struct nsim_rq *rq, struct sk_buff *skb)
> +static void nsim_start_peer_tx_queue(struct net_device *dev, struct nsim_rq *rq)
> +{
> +	struct netdevsim *ns = netdev_priv(dev);
> +	struct net_device *peer_dev;
> +	struct netdevsim *peer_ns;
> +	struct netdev_queue *txq;
> +	u16 idx;
> +
> +	idx = rq->napi.index;
> +	peer_ns = rcu_dereference(ns->peer);
> +	if (!peer_ns)
> +		return;
> +
> +	/* TX device */
> +	peer_dev = peer_ns->netdev;
> +
> +	if (dev->real_num_tx_queues != peer_dev->num_rx_queues)
> +		return;
> +
> +	txq = netdev_get_tx_queue(peer_dev, idx);
> +	if (!(netif_tx_queue_stopped(txq)))
> +		return;
> +
> +	netif_tx_wake_queue(txq);
> +}
> +
> +static void nsim_stop_peer_tx_queue(struct net_device *dev, struct nsim_rq *rq,
> +				    u16 idx)
> +{
> +	struct netdevsim *ns = netdev_priv(dev);
> +	struct net_device *peer_dev;
> +	struct netdevsim *peer_ns;
> +
> +	peer_ns = rcu_dereference(ns->peer);
> +	if (!peer_ns)
> +		return;
> +
> +	/* TX device */
> +	peer_dev = peer_ns->netdev;

For the wake we need to find the peer, that's true. But stop happens in
the Tx path IOW we're coming from nsim_start_xmit() which had the
right Tx device already, right? The peer we'll get here was the original
dev that was padded to nsim_start_xmit(), we just need to pass it into
nsim_napi_rx().

> +	/* If different queues size, do not stop, since it is not
> +	 * easy to find which TX queue is mapped here
> +	 */
> +	if (dev->real_num_tx_queues != peer_dev->num_rx_queues)
> +		return;
> +
> +	netif_subqueue_try_stop(peer_dev, idx,
> +				NSIM_RING_SIZE - skb_queue_len(&rq->skb_queue),
> +				NSIM_RING_SIZE / 2);
> +}
> +
> +static int nsim_napi_rx(struct net_device *dev, struct nsim_rq *rq,
> +			struct sk_buff *skb)
>  {
>  	if (skb_queue_len(&rq->skb_queue) > NSIM_RING_SIZE) {
> +		rcu_read_lock();
> +		nsim_stop_peer_tx_queue(dev, rq, skb_get_queue_mapping(skb));
> +		rcu_read_unlock();
>  		dev_kfree_skb_any(skb);
>  		return NET_RX_DROP;
>  	}
> @@ -51,7 +106,7 @@ static int nsim_napi_rx(struct nsim_rq *rq, struct sk_buff *skb)
>  static int nsim_forward_skb(struct net_device *dev, struct sk_buff *skb,
>  			    struct nsim_rq *rq)
>  {
> -	return __dev_forward_skb(dev, skb) ?: nsim_napi_rx(rq, skb);
> +	return __dev_forward_skb(dev, skb) ?: nsim_napi_rx(dev, rq, skb);
>  }
>  
>  static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
> @@ -351,6 +406,9 @@ static int nsim_rcv(struct nsim_rq *rq, int budget)
>  			dev_dstats_rx_dropped(dev);
>  	}
>  
> +	rcu_read_lock();
> +	nsim_start_peer_tx_queue(dev, rq);
> +	rcu_read_unlock();
>  	return i;
>  }
>  
> 
> ---
> base-commit: f6e98f17ad6829c48573952ede3f52ed00c1377f
> change-id: 20250630-netdev_flow_control-2b2d37965377
> 
> Best regards,
> --  
> Breno Leitao <leitao@debian.org>
> 


