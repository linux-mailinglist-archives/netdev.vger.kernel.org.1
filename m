Return-Path: <netdev+bounces-232572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30337C06B4E
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 16:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21DB13A7361
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 14:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26108314A69;
	Fri, 24 Oct 2025 14:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QWmua2NW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F5D3074AE
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 14:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761316417; cv=none; b=j1+HeGOkVZLvZSoSAz3bor0ovbpX3iyfndQgiS3mn01BZpL9VsAZ1e36iKEqZyk8iElD8bI/3KpO+Yyxy5cTykNPdSlGFeZYhVVwZ9S4/m6HviVC0MGWynBlkbzFCcN8mFWHLuuHva+3BE9lvLneI3S7qkluf8xCOHEsaMAXdYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761316417; c=relaxed/simple;
	bh=St2tGCQEewbnfrbUK5ouJM4MBPRSJieB8IQU4yLWqf4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RtYh7897G1EYYDcixpS4/NBcjE9z8MArDI1aIZYpKdISBpmhPlRyoQ0bOHhldjrer/7XTH1zGsKWUjcIDTA+OZUpoveXf3qEf1m7NVZlEV7vozeiV88kOjMMlehze0UzLkOcSNMo+Yub/CyhoMgahaAPJIquoQPq+HCcYI1gH3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QWmua2NW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761316414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qMR4VmIIzn/w/4nNJSUeQgFleHSwnzkaVnDEewrnAfI=;
	b=QWmua2NWfwpSQJ4qBGBbEepLWsTznEHDfzXVzWccjzDkFVK4kc788pQk5ZyQhtqFuwakTm
	2NUHI/T3gRw+61g3c/SYWJUSa7wf3esow7k4Wkjm53jSbSzgjGwDBl8JwdGX/ZEtu5dfPj
	Y4PeiDa/MtFbqd4R7ZRu7RFYrTbDw9c=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-Ub03aIp2O2y0Y-aVf0fWTw-1; Fri, 24 Oct 2025 10:33:32 -0400
X-MC-Unique: Ub03aIp2O2y0Y-aVf0fWTw-1
X-Mimecast-MFC-AGG-ID: Ub03aIp2O2y0Y-aVf0fWTw_1761316412
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b5c6c817a95so167127166b.0
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 07:33:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761316411; x=1761921211;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qMR4VmIIzn/w/4nNJSUeQgFleHSwnzkaVnDEewrnAfI=;
        b=r8F0iJo8R+neoMWwhlJ6o5yCq3jR3k35Qm3hgl0qP1yB8BH4XDiss9Jh5c0v2HzOpv
         kkiZRZuXceKh09Q5hOJdLlemL5ocXaI3nYxIcB322vTQg2JKOMwovCBMFLT8HnvLIyFg
         8qOGcPzTxk6XMmfxywJz9Cy3MGQJepzo33vLfY01zbWXsGzkVotWDVbMuq4LkMeIJhUS
         JAjbHw/HMvW6w4WSmk1fbkW/9081WY0hJti/qKGSQMozyj1ciT0OKFXoHq4qwFOzxt2Y
         8P7QXC4zyKl8Cun7Wq06401Wd4chzd+V1ScLLYoOjxvJD9r+Q8f1gUY0Sh6DuSanwWIO
         hHVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFhz07J6EPR3KWEbSvcdJglR9IKkqtT+6Ka5fm2WaKjd3VGH0UFsz+uUDDo9Y8ZNYl8BEoVjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyALuOjUpt9tK0rB0VcFY5kOkN9+MS+9OZ2lhyvaV8wsfVyCoe8
	uALE3E24o+Orprh0ql4bcfBahe8gh+jStBT/VwsOPX9vMLYyTQU9v/3ocRb8xuSc0QHz8lqfxHK
	TfWadPPEoTqo8ZUB5uxH2Zd8g0YBw0eW+N5Sj3g+fY+LM7NUZ7Fl/0KWUPA==
X-Gm-Gg: ASbGncvTeX/dxiHwN6YRBnZwEphO+8e0vMcgl9tZVciBUKZ46uvFHjgsDQpGrGszaLW
	1G7Rhm4kx0Qr0DYIXkUQrHqcYvc/KJCG6TQMAVTYAeMWhs4lGtK/tWVFhvQZa/yG/qbNA3Jj6D0
	ZH14YS0evQUCjvJBtwM75lFUHwJOlireQpnxm7qnt8M7e8qxMqAz2WxZELv6rAK0wvL1Jx8c6cT
	ZcBOisTu2r0hleZgNpUg2szJyJ3IoRMckjvpZOEpmspwNByqeovPXkZUsDC24RBM38kHPDGT6fE
	xpOBXdWdvGU6l8KQGbxCMB+3GzD1eHt1qTThD1Sk1D6U4MVBJShwmO/UlBgDIU+xggGrMYbZeVT
	MbhZ0gYs7uHJMHyAHVU72Xek=
X-Received: by 2002:a17:907:3daa:b0:b3d:656b:9088 with SMTP id a640c23a62f3a-b64749416admr3903160366b.54.1761316411539;
        Fri, 24 Oct 2025 07:33:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJLEAmzEsqCaXOpu82Aaw82/w7mLyOC9azKvS1K33FnRFrN1PBJiJg/V40XnFDES8K3O5Haw==
X-Received: by 2002:a17:907:3daa:b0:b3d:656b:9088 with SMTP id a640c23a62f3a-b64749416admr3903157466b.54.1761316411041;
        Fri, 24 Oct 2025 07:33:31 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e3f322cf3sm4399668a12.29.2025.10.24.07.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 07:33:30 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 8F4982EA579; Fri, 24 Oct 2025 16:33:29 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 makita.toshiaki@lab.ntt.co.jp
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Eric Dumazet
 <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 ihor.solodrai@linux.dev, toshiaki.makita1@gmail.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH net V1 3/3] veth: more robust handing of race to avoid
 txq getting stuck
In-Reply-To: <176123158453.2281302.11061466460805684097.stgit@firesoul>
References: <176123150256.2281302.7000617032469740443.stgit@firesoul>
 <176123158453.2281302.11061466460805684097.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 24 Oct 2025 16:33:29 +0200
Message-ID: <871pmsfjye.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> Commit dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to
> reduce TX drops") introduced a race condition that can lead to a permanently
> stalled TXQ. This was observed in production on ARM64 systems (Ampere Altra
> Max).
>
> The race occurs in veth_xmit(). The producer observes a full ptr_ring and
> stops the queue (netif_tx_stop_queue()). The subsequent conditional logic,
> intended to re-wake the queue if the consumer had just emptied it (if
> (__ptr_ring_empty(...)) netif_tx_wake_queue()), can fail. This leads to a
> "lost wakeup" where the TXQ remains stopped (QUEUE_STATE_DRV_XOFF) and
> traffic halts.
>
> This failure is caused by an incorrect use of the __ptr_ring_empty() API
> from the producer side. As noted in kernel comments, this check is not
> guaranteed to be correct if a consumer is operating on another CPU. The
> empty test is based on ptr_ring->consumer_head, making it reliable only for
> the consumer. Using this check from the producer side is fundamentally racy.
>
> This patch fixes the race by adopting the more robust logic from an earlier
> version V4 of the patchset, which always flushed the peer:
>
> (1) In veth_xmit(), the racy conditional wake-up logic and its memory barrier
> are removed. Instead, after stopping the queue, we unconditionally call
> __veth_xdp_flush(rq). This guarantees that the NAPI consumer is scheduled,
> making it solely responsible for re-waking the TXQ.

This makes sense.

> (2) On the consumer side, the logic for waking the peer TXQ is centralized.
> It is moved out of veth_xdp_rcv() (which processes a batch) and placed at
> the end of the veth_poll() function. This ensures netif_tx_wake_queue() is
> called once per complete NAPI poll cycle.

So is this second point strictly necessary to fix the race, or is it
more of an optimisation?

> (3) Finally, the NAPI completion check in veth_poll() is updated. If NAPI is
> about to complete (napi_complete_done), it now also checks if the peer TXQ
> is stopped. If the ring is empty but the peer TXQ is stopped, NAPI will
> reschedule itself. This prevents a new race where the producer stops the
> queue just as the consumer is finishing its poll, ensuring the wakeup is not
> missed.

Also makes sense...

> Fixes: dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to reduce TX drops")
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> ---
>  drivers/net/veth.c |   42 +++++++++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 3976ddda5fb8..1d70377481eb 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -392,14 +392,12 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
>  		}
>  		/* Restore Eth hdr pulled by dev_forward_skb/eth_type_trans */
>  		__skb_push(skb, ETH_HLEN);
> -		/* Depend on prior success packets started NAPI consumer via
> -		 * __veth_xdp_flush(). Cancel TXQ stop if consumer stopped,
> -		 * paired with empty check in veth_poll().
> -		 */
>  		netif_tx_stop_queue(txq);
> -		smp_mb__after_atomic();
> -		if (unlikely(__ptr_ring_empty(&rq->xdp_ring)))
> -			netif_tx_wake_queue(txq);
> +		/* Handle race: Makes sure NAPI peer consumer runs. Consumer is
> +		 * responsible for starting txq again, until then ndo_start_xmit
> +		 * (this function) will not be invoked by the netstack again.
> +		 */
> +		__veth_xdp_flush(rq);

Nit: I'd lose the "Handle race:" prefix from the comment; the rest of
the comment is clear enough without it, and since there's no explanation
of *which* race is being handled, it is just confusing, IMO.

>  		break;
>  	case NET_RX_DROP: /* same as NET_XMIT_DROP */
>  drop:
> @@ -900,17 +898,9 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>  			struct veth_xdp_tx_bq *bq,
>  			struct veth_stats *stats)
>  {
> -	struct veth_priv *priv = netdev_priv(rq->dev);
> -	int queue_idx = rq->xdp_rxq.queue_index;
> -	struct netdev_queue *peer_txq;
> -	struct net_device *peer_dev;
>  	int i, done = 0, n_xdpf = 0;
>  	void *xdpf[VETH_XDP_BATCH];
>  
> -	/* NAPI functions as RCU section */
> -	peer_dev = rcu_dereference_check(priv->peer, rcu_read_lock_bh_held());
> -	peer_txq = peer_dev ? netdev_get_tx_queue(peer_dev, queue_idx) : NULL;
> -
>  	for (i = 0; i < budget; i++) {
>  		void *ptr = __ptr_ring_consume(&rq->xdp_ring);
>  
> @@ -959,11 +949,6 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>  	rq->stats.vs.xdp_packets += done;
>  	u64_stats_update_end(&rq->stats.syncp);
>  
> -	if (peer_txq && unlikely(netif_tx_queue_stopped(peer_txq))) {
> -		txq_trans_cond_update(peer_txq);
> -		netif_tx_wake_queue(peer_txq);
> -	}
> -
>  	return done;
>  }
>  
> @@ -971,12 +956,20 @@ static int veth_poll(struct napi_struct *napi, int budget)
>  {
>  	struct veth_rq *rq =
>  		container_of(napi, struct veth_rq, xdp_napi);
> +	struct veth_priv *priv = netdev_priv(rq->dev);
> +	int queue_idx = rq->xdp_rxq.queue_index;
> +	struct netdev_queue *peer_txq;
>  	struct veth_stats stats = {};
> +	struct net_device *peer_dev;
>  	struct veth_xdp_tx_bq bq;
>  	int done;
>  
>  	bq.count = 0;
>  
> +	/* NAPI functions as RCU section */
> +	peer_dev = rcu_dereference_check(priv->peer, rcu_read_lock_bh_held());
> +	peer_txq = peer_dev ? netdev_get_tx_queue(peer_dev, queue_idx) : NULL;
> +
>  	xdp_set_return_frame_no_direct();
>  	done = veth_xdp_rcv(rq, budget, &bq, &stats);
>  
> @@ -986,7 +979,8 @@ static int veth_poll(struct napi_struct *napi, int budget)
>  	if (done < budget && napi_complete_done(napi, done)) {
>  		/* Write rx_notify_masked before reading ptr_ring */
>  		smp_store_mb(rq->rx_notify_masked, false);
> -		if (unlikely(!__ptr_ring_empty(&rq->xdp_ring))) {
> +		if (unlikely(!__ptr_ring_empty(&rq->xdp_ring) ||
> +			     (peer_txq && netif_tx_queue_stopped(peer_txq)))) {
>  			if (napi_schedule_prep(&rq->xdp_napi)) {
>  				WRITE_ONCE(rq->rx_notify_masked, true);
>  				__napi_schedule(&rq->xdp_napi);
> @@ -998,6 +992,12 @@ static int veth_poll(struct napi_struct *napi, int budget)
>  		veth_xdp_flush(rq, &bq);
>  	xdp_clear_return_frame_no_direct();
>  
> +	/* Release backpressure per NAPI poll */
> +	if (peer_txq && netif_tx_queue_stopped(peer_txq)) {
> +		txq_trans_cond_update(peer_txq);
> +		netif_tx_wake_queue(peer_txq);
> +	}
> +
>  	return done;
>  }
>  


