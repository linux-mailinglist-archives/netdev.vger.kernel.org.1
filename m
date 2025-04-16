Return-Path: <netdev+bounces-183321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AA3A905A2
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2400019E0B7C
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 14:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FE51BD9D2;
	Wed, 16 Apr 2025 13:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RKAvPT+p"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906C5156F20
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 13:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744811815; cv=none; b=FR39ug1lkxDyLu96V2PLxL0WDkEdZUGCfjhOvqjX14t7LiD6obafhytMBL06sNzj+hsmw4BFzx4XHtM+GDCPoEqAEmXyVerTkDoT0cwiRvABbSNWOCyn35Hwk6eAWqubiqeY7VymqxJbnS1xs3LvHmL6XZ+pba9sMlnO+Kdqfzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744811815; c=relaxed/simple;
	bh=9IXqGz7/97dAlu3CPAMjzoFLk15SVIkoVOTKZbEIcpM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F0TrnJHV9dhLKJTuD/u/F/2LssCxKZfWjAs+058rMwn5LdvEx8YyWJVyvFE8m+CfBqsuwIrIYKNv3DQJ4UazGN8RxWn60St7OKMSgPZdUBizNi50DrjoMRlQH/hs24vsN3dvpeEmwcEAdGRs5sB+zx16+8t4oRdOLZUtB+ADz88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RKAvPT+p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744811812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2zb2lt6s4GxmFeaXQ2LR2QpbEMVI0Udd83Rv96tkVQo=;
	b=RKAvPT+pU8tYQXwbFI7LikMX8C5w/hWoBwaaL//C5O7DGJcsgGVI4umlPJV40StQxg9HEy
	vAPlY3gA1BXz6qMvQp5zMw3m1N4sUaow7dCpuJR9XrAMk9hhE3WHTV0U/erSpXrC1SeKmq
	9lm+QluL6P+MSt00Dq22YtWhDt/i5FU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-YkKPVQ-TOa6fOw_vilhR4Q-1; Wed, 16 Apr 2025 09:56:51 -0400
X-MC-Unique: YkKPVQ-TOa6fOw_vilhR4Q-1
X-Mimecast-MFC-AGG-ID: YkKPVQ-TOa6fOw_vilhR4Q_1744811810
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-54b0e3136ddso355139e87.0
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 06:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744811809; x=1745416609;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2zb2lt6s4GxmFeaXQ2LR2QpbEMVI0Udd83Rv96tkVQo=;
        b=WooevIdNcAJvU3DtKkJf4nImOKRDrr1d+JZvbS30RW7ZSJ44cbhqByndMT9geXgZu3
         CFWsEg3OjhbfQ/WX1EEws3Z+B/wCqFRZmwFdO9GEKgwr08WIgc7y+vkrZpU6M7VUisUA
         3OP/cjvxUurEPdZMfCvVd5kweMAxyOMvY6G7cAGLhOd1J7UAQWwMCwZ89EwOcRoISLsf
         3TNj+yHv3BklpvKya1gOXhKtMbmYx182IDYJU0ft7oLgNz3v3Zws5+b/9svW8SV0UhWQ
         Y7CmXHvLtSU4DCh0edO4XriVyHXgLTyNRH2YlF0UZS2vex++uGr3KSTXrtsv6JBM9LKp
         SulA==
X-Forwarded-Encrypted: i=1; AJvYcCVGIpEtP7U3Whf5gzogCyNJUw+s9qtl9RwoZUNIdOetqsT3bHdRiT75SdSvDBBnJLBh9X6RKHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv1pge+a7Cd9XmqV1VxsoPu6qXJedLxduM2ZOC2T2clcIQPBd1
	7fn9NtDmZ/nFtt8lOR+E0v04hGBzg07s7HbknfMmYbno79p2BiObwy29NvPssgwht5ekbCRI6J7
	+7xk3YimgS1h9+6BToCMQ3PJMXEPjx41bQAckzYllb3/Ef2RgnQOJyQ==
X-Gm-Gg: ASbGncvnBAe34FcZ9aNXwGq201wCbwa16hCx49vX3XtGv78crbG/tb1xnXgDKXRfMIW
	4E1QjC+GCjJdBlABL3C0dCc1FY/2HrbT/Fqopc2Rc/sCw24PxeqltoIhVTp6caaiZdcYBkWtxjb
	uow/IeyamR8qLbHdBq1kEpTx6olh0xR+ivjdXsSEUB2yYc9tkgosmBDLT9cgdnhlIAFUK8lm+ni
	fNMN+Mxat2bc7+SNFMYS1LS+/QhpN6GA4It+s/6kVE+706S0voD96OXBute9qeFZ1Z6eY1HT8eA
	U0teaM04
X-Received: by 2002:a05:6512:31c1:b0:549:8f14:a839 with SMTP id 2adb3069b0e04-54d64b95247mr621845e87.11.1744811809431;
        Wed, 16 Apr 2025 06:56:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVX3/8kuJFFd4NzAMo25LJ0Ly9/TC9S+jk7mqofEjD6pbIQtjg+MzGZEF3d3S6W+UYAmTFcg==
X-Received: by 2002:a05:6512:31c1:b0:549:8f14:a839 with SMTP id 2adb3069b0e04-54d64b95247mr621837e87.11.1744811808984;
        Wed, 16 Apr 2025 06:56:48 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d3d50260csm1733952e87.132.2025.04.16.06.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 06:56:47 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 64492199293D; Wed, 16 Apr 2025 15:56:46 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, Jakub
 Kicinski <kuba@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 tom@herbertland.com, Eric Dumazet <eric.dumazet@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 dsahern@kernel.org, makita.toshiaki@lab.ntt.co.jp,
 kernel-team@cloudflare.com, phil@nwl.cc
Subject: Re: [PATCH net-next V4 2/2] veth: apply qdisc backpressure on full
 ptr_ring to reduce TX drops
In-Reply-To: <174472470529.274639.17026526070544068280.stgit@firesoul>
References: <174472463778.274639.12670590457453196991.stgit@firesoul>
 <174472470529.274639.17026526070544068280.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 16 Apr 2025 15:56:46 +0200
Message-ID: <87tt6oi50h.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> In production, we're seeing TX drops on veth devices when the ptr_ring
> fills up. This can occur when NAPI mode is enabled, though it's
> relatively rare. However, with threaded NAPI - which we use in
> production - the drops become significantly more frequent.
>
> The underlying issue is that with threaded NAPI, the consumer often runs
> on a different CPU than the producer. This increases the likelihood of
> the ring filling up before the consumer gets scheduled, especially under
> load, leading to drops in veth_xmit() (ndo_start_xmit()).
>
> This patch introduces backpressure by returning NETDEV_TX_BUSY when the
> ring is full, signaling the qdisc layer to requeue the packet. The txq
> (netdev queue) is stopped in this condition and restarted once
> veth_poll() drains entries from the ring, ensuring coordination between
> NAPI and qdisc.
>
> Backpressure is only enabled when a qdisc is attached. Without a qdisc,
> the driver retains its original behavior - dropping packets immediately
> when the ring is full. This avoids unexpected behavior changes in setups
> without a configured qdisc.
>
> With a qdisc in place (e.g. fq, sfq) this allows Active Queue Management
> (AQM) to fairly schedule packets across flows and reduce collateral
> damage from elephant flows.
>
> A known limitation of this approach is that the full ring sits in front
> of the qdisc layer, effectively forming a FIFO buffer that introduces
> base latency. While AQM still improves fairness and mitigates flow
> dominance, the latency impact is measurable.
>
> In hardware drivers, this issue is typically addressed using BQL (Byte
> Queue Limits), which tracks in-flight bytes needed based on physical link
> rate. However, for virtual drivers like veth, there is no fixed bandwidth
> constraint - the bottleneck is CPU availability and the scheduler's ability
> to run the NAPI thread. It is unclear how effective BQL would be in this
> context.
>
> This patch serves as a first step toward addressing TX drops. Future work
> may explore adapting a BQL-like mechanism to better suit virtual devices
> like veth.
>
> Reported-by: Yan Zhai <yan@cloudflare.com>
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> ---
>  drivers/net/veth.c |   49 +++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 41 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 7bb53961c0ea..a419d5e198d8 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -308,11 +308,10 @@ static void __veth_xdp_flush(struct veth_rq *rq)
>  static int veth_xdp_rx(struct veth_rq *rq, struct sk_buff *skb)
>  {
>  	if (unlikely(ptr_ring_produce(&rq->xdp_ring, skb))) {
> -		dev_kfree_skb_any(skb);
> -		return NET_RX_DROP;
> +		return NETDEV_TX_BUSY; /* signal qdisc layer */
>  	}
>  
> -	return NET_RX_SUCCESS;
> +	return NET_RX_SUCCESS; /* same as NETDEV_TX_OK */
>  }
>  
>  static int veth_forward_skb(struct net_device *dev, struct sk_buff *skb,
> @@ -346,11 +345,11 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
>  {
>  	struct veth_priv *rcv_priv, *priv = netdev_priv(dev);
>  	struct veth_rq *rq = NULL;
> -	int ret = NETDEV_TX_OK;
> +	struct netdev_queue *txq;
>  	struct net_device *rcv;
>  	int length = skb->len;
>  	bool use_napi = false;
> -	int rxq;
> +	int ret, rxq;
>  
>  	rcu_read_lock();
>  	rcv = rcu_dereference(priv->peer);
> @@ -373,17 +372,41 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
>  	}
>  
>  	skb_tx_timestamp(skb);
> -	if (likely(veth_forward_skb(rcv, skb, rq, use_napi) == NET_RX_SUCCESS)) {
> +
> +	ret = veth_forward_skb(rcv, skb, rq, use_napi);
> +	switch(ret) {
> +	case NET_RX_SUCCESS: /* same as NETDEV_TX_OK */
>  		if (!use_napi)
>  			dev_sw_netstats_tx_add(dev, 1, length);
>  		else
>  			__veth_xdp_flush(rq);
> -	} else {
> +		break;
> +	case NETDEV_TX_BUSY:
> +		/* If a qdisc is attached to our virtual device, returning
> +		 * NETDEV_TX_BUSY is allowed.
> +		 */
> +		txq = netdev_get_tx_queue(dev, rxq);
> +
> +		if (qdisc_txq_has_no_queue(txq)) {
> +			dev_kfree_skb_any(skb);
> +			goto drop;
> +		}
> +		netif_tx_stop_queue(txq);
> +		/* Restore Eth hdr pulled by dev_forward_skb/eth_type_trans */
> +		__skb_push(skb, ETH_HLEN);
> +		if (use_napi)
> +			__veth_xdp_flush(rq);
> +
> +		break;
> +	case NET_RX_DROP: /* same as NET_XMIT_DROP */
>  drop:
>  		atomic64_inc(&priv->dropped);
>  		ret = NET_XMIT_DROP;
> +		break;
> +	default:
> +		net_crit_ratelimited("veth_xmit(%s): Invalid return code(%d)",
> +				     dev->name, ret);
>  	}
> -
>  	rcu_read_unlock();
>  
>  	return ret;
> @@ -874,9 +897,16 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>  			struct veth_xdp_tx_bq *bq,
>  			struct veth_stats *stats)
>  {
> +	struct veth_priv *priv = netdev_priv(rq->dev);
> +	int queue_idx = rq->xdp_rxq.queue_index;
> +	struct netdev_queue *peer_txq;
> +	struct net_device *peer_dev;
>  	int i, done = 0, n_xdpf = 0;
>  	void *xdpf[VETH_XDP_BATCH];
>  
> +	peer_dev = rcu_dereference(priv->peer);
> +	peer_txq = netdev_get_tx_queue(peer_dev, queue_idx);
> +
>  	for (i = 0; i < budget; i++) {
>  		void *ptr = __ptr_ring_consume(&rq->xdp_ring);
>  
> @@ -925,6 +955,9 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>  	rq->stats.vs.xdp_packets += done;
>  	u64_stats_update_end(&rq->stats.syncp);
>  
> +	if (unlikely(netif_tx_queue_stopped(peer_txq)))
> +		netif_tx_wake_queue(peer_txq);
> +

netif_tx_wake_queue() does a test_and_clear_bit() and does nothing if
the bit is not set; so does this optimisation really make any
difference? :)

-Toke


