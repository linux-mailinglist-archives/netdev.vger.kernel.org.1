Return-Path: <netdev+bounces-70790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BBD850683
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 22:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F2102824A0
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 21:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7023C5F872;
	Sat, 10 Feb 2024 21:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="dDYl9ANz"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C503612E
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 21:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707601443; cv=pass; b=KL18TXMzkCSYb9bl9quSjdIHLwWH+UuHiyf/Xi6qb3uN9BfIfMEP7NHdAyGmErRkrSz6MLWtxmgEz40D/PrAOXn2TUBPCMi1rmYl8u/2I6UrXJr0C9ZcDyEZqmanPXQRFQuEIcxeoE81Uv65XcBBKWysi6PKpX+BNTpVR6UDSo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707601443; c=relaxed/simple;
	bh=K9XFfHlG2SVL8/knCyI5HzVjgYbR/B4NwKuI0m2/zeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UwlBJb4p/lxjaLEIWHT9Z1N5aEjGSkUGTbMboa52lAHQC4FZt0wSXh1z1a65uZ/FlXni0LtkFRCbO8jlUlJ/9goUqCLB7hkz9C1r27VPkLoKygPnpOmdElBHqSblVIKsjUcVNpkKIn1ae0oDQPil3tVeI25e0jsPtNwg2d2y8pM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=dDYl9ANz; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1707601428; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=X8QFLLoQRxRMJGszq4+duoJnnbpu7DxeMtGTsHMuMsJzDYM7ccxu88sGYQ/ztskL92kh45MEOr4o2CnzaZhpQQS3KqCyFqWRqJ7kfBGBupQu/7NyGMgfL1yFAv/3braJa54vlFehheNIou/jkZKRni4HdNxjCghw7WLS/QLfqO4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1707601428; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jHRe/26FZ/Y3HhCBKBYfHAi9G5zOHmAnNZUFlW6Xkik=; 
	b=kWkZM+kwYgH6QW5hLbwJzZO3QWa5vVQ6Pz8rGxOaaeMLrmljKxj9gUvrOXIZp7RURqrvmdOZWKf4nj7FLuG7Cbm+PspE5/JHK9eKrWxZnDwgQ5pnJJcMg1qUd/UXW7GTltcdsFWMZy2ch6oCt9S9tDi4/wWnrTdCUfRvRZ8Cwco=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1707601428;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=jHRe/26FZ/Y3HhCBKBYfHAi9G5zOHmAnNZUFlW6Xkik=;
	b=dDYl9ANzBPARoUi6+LDqTFaIJnyaE6p+RmMFQ0WMOCPtY/f8z8SBF606CsXwpTDJ
	U5SSaVVFv8itrWSYnwjvLB1d5d2DRaUqhPKEEXkK8AdVueucWfRp2cR4Jg5kRJ8Yg3G
	+2qMb6jiQJlcdSHXw4+2s/4rb1J1RDgQqgGkWFaUH5JWUIXYg3PG91pJqCqpMbK8R+Y
	l/AR9v8v4k8+jKebw5AEckgwnCpQxweL49Q9PbD3niqDovrG60w+XFamcmyZws45bR1
	CKUto0Vl17g1EB1TkWiRODQg/HrDCpypVV7e8ExX9W6dj7lX9uPXlKZS++/hBzNXnc0
	FXhgDUKWwg==
Received: from [192.168.1.225] (83.8.237.114.ipv4.supernova.orange.pl [83.8.237.114]) by mx.zohomail.com
	with SMTPS id 1707601426182524.3647492351637; Sat, 10 Feb 2024 13:43:46 -0800 (PST)
Message-ID: <420b3c0a-6321-494b-9181-ff7dd4e1849c@machnikowski.net>
Date: Sat, 10 Feb 2024 22:43:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 2/3] netdevsim: forward skbs from one
 connected port to another
Content-Language: en-US
To: David Wei <dw@davidwei.uk>, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20240210003240.847392-1-dw@davidwei.uk>
 <20240210003240.847392-3-dw@davidwei.uk>
From: Maciek Machnikowski <maciek@machnikowski.net>
In-Reply-To: <20240210003240.847392-3-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External



On 10/02/2024 01:32, David Wei wrote:
> Forward skbs sent from one netdevsim port to its connected netdevsim
> port using dev_forward_skb, in a spirit similar to veth.
> 
> Add a tx_dropped variable to struct netdevsim, tracking the number of
> skbs that could not be forwarded using dev_forward_skb().
> 
> The xmit() function accessing the peer ptr is protected by an RCU read
> critical section. The rcu_read_lock() is functionally redundant as since
> v5.0 all softirqs are implicitly RCU read critical sections; but it is
> useful for human readers.
> 
> If another CPU is concurrently in nsim_destroy(), then it will first set
> the peer ptr to NULL. This does not affect any existing readers that
> dereferenced a non-NULL peer. Then, in unregister_netdevice(), there is
> a synchronize_rcu() before the netdev is actually unregistered and
> freed. This ensures that any readers i.e. xmit() that got a non-NULL
> peer will complete before the netdev is freed.
> 
> Any readers after the RCU_INIT_POINTER() but before synchronize_rcu()
> will dereference NULL, making it safe.
> 
> The codepath to nsim_destroy() and nsim_create() takes both the newly
> added nsim_dev_list_lock and rtnl_lock. This makes it safe with
> concurrent calls to linking two netdevsims together.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  drivers/net/netdevsim/netdev.c    | 28 +++++++++++++++++++++++-----
>  drivers/net/netdevsim/netdevsim.h |  1 +
>  2 files changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> index 9063f4f2971b..13d3e1536451 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -29,19 +29,37 @@
>  static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  {
>  	struct netdevsim *ns = netdev_priv(dev);
> +	unsigned int len = skb->len;
> +	struct netdevsim *peer_ns;
> +	int ret = NETDEV_TX_OK;
>  
>  	if (!nsim_ipsec_tx(ns, skb))
>  		goto out;
>  
> +	rcu_read_lock();
> +	peer_ns = rcu_dereference(ns->peer);
> +	if (!peer_ns)
> +		goto out_stats;
Change ret to NET_XMIT_DROP to correctly count packets as dropped

> +
> +	skb_tx_timestamp(skb);
> +	if (unlikely(dev_forward_skb(peer_ns->netdev, skb) == NET_RX_DROP))
> +		ret = NET_XMIT_DROP;
> +
> +out_stats:
> +	rcu_read_unlock();
>  	u64_stats_update_begin(&ns->syncp);
> -	ns->tx_packets++;
> -	ns->tx_bytes += skb->len;
> +	if (ret == NET_XMIT_DROP) {
> +		ns->tx_dropped++;
add dev_kfree_skb(skb);

Thanks,
Maciek

> +	} else {
> +		ns->tx_packets++;
> +		ns->tx_bytes += len;
> +	}
>  	u64_stats_update_end(&ns->syncp);
> +	return ret;
>  
>  out:
>  	dev_kfree_skb(skb);
> -
> -	return NETDEV_TX_OK;
> +	return ret;
>  }
>  
>  static void nsim_set_rx_mode(struct net_device *dev)
> @@ -70,6 +88,7 @@ nsim_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
>  		start = u64_stats_fetch_begin(&ns->syncp);
>  		stats->tx_bytes = ns->tx_bytes;
>  		stats->tx_packets = ns->tx_packets;
> +		stats->tx_dropped = ns->tx_dropped;
>  	} while (u64_stats_fetch_retry(&ns->syncp, start));
>  }
>  
> @@ -302,7 +321,6 @@ static void nsim_setup(struct net_device *dev)
>  	eth_hw_addr_random(dev);
>  
>  	dev->tx_queue_len = 0;
> -	dev->flags |= IFF_NOARP;
>  	dev->flags &= ~IFF_MULTICAST;
>  	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE |
>  			   IFF_NO_QUEUE;
> diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
> index c8b45b0d955e..553c4b9b4f63 100644
> --- a/drivers/net/netdevsim/netdevsim.h
> +++ b/drivers/net/netdevsim/netdevsim.h
> @@ -98,6 +98,7 @@ struct netdevsim {
>  
>  	u64 tx_packets;
>  	u64 tx_bytes;
> +	u64 tx_dropped;
>  	struct u64_stats_sync syncp;
>  
>  	struct nsim_bus_dev *nsim_bus_dev;

