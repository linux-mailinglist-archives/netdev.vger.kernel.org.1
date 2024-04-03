Return-Path: <netdev+bounces-84332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD2F896A31
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 11:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 052921F22CA0
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 09:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B6673510;
	Wed,  3 Apr 2024 09:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fjaYLWKh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731FA7351A
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 09:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712135528; cv=none; b=BxFYyEWCBvOMcFQSw4HYYAWY60BVkSP9ZJ53DQ3NNg7KXrERApLtqPuRnFThYIwcsRA2uKFES/xBrIWYJ9yHkacpxSVaBOWVeFtVqNb4XaugQ7A0zZqdP2UmKqKALSE17Ged1aGEdmSXSo+OHvzJJo6gqEfcXjig6KYYxedBdHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712135528; c=relaxed/simple;
	bh=RJhEaRMalWxTpkdmNf5hmMoHqVFLnYA/lCnJ2XqAPoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMcgdICArZ88VV0m7hjTxouyYhMvFqxOOuiBTJmTYe5SpCe97VVMwKGWUTOZZ3GogdoVGdDcYUfSQE4qELlGEy+qtlmQ6f69QH2ZMIj90JX80JLkUd8Qzbf9rFfoBok6JXbJApz09U14OzbcefTjfRw8rVlcR36yYvusWCrUjBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fjaYLWKh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712135525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J15c54CCcMIO06nn28Cf6nmwQhphnGFVtOwKdjyD5N8=;
	b=fjaYLWKhyqXHArs3Va/pcwcwDpHGixg/FigI6IxN6mEzpVtfGsnukkxHfp6+3dTk0dZMF3
	Upv5y73cXMeHEUUHU2ZudmhrIYjAf7K4DAr/Afr1l99xvvtMOxVIxCEZ8uryF4biygbGwD
	tVTFka2eO0hKkjaA8Ll3qXERu4FCI1g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-2Tm5QR1MOOmMYdlQmBWBUw-1; Wed, 03 Apr 2024 05:12:03 -0400
X-MC-Unique: 2Tm5QR1MOOmMYdlQmBWBUw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-41407fd718dso33306485e9.1
        for <netdev@vger.kernel.org>; Wed, 03 Apr 2024 02:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712135520; x=1712740320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J15c54CCcMIO06nn28Cf6nmwQhphnGFVtOwKdjyD5N8=;
        b=MGIcAMopVLu1/MxzSM6qNCfLrMB754LjIZqVhbNc75AUOSNWHmPbclTr8R1fDqBGT0
         MWjH+VLCniyJRQkkMPUe1pOboYjyQC7dntMtF/khTSad5REkUNcpquOGmknLQMbEb0yP
         bMbQRxD101CLfVh4tysnrb4w+a8v33EN0zCTxxamnRknlfcHd9p/xumQLIIlFBzR/l7d
         nMnjniDL3FSYihrieAtJVoXONalhBr3vT746t7U3NazxXSyWjdnf3pXGkrczwy4CLVaQ
         w7E9Jf0AwoSj9NBRpkH8CLRvIisq7e/5cIXsbgRrSAUJIuZv3hFUVpaAabHDEfVCIF2T
         fW1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4KBpkpzA4CYPMTOfPnrKDcW++iZcWllc49AeMu35d5XKwcXBW18icHQLb4CLVtqmcWT+5sLRD+R1MhkRbjEOfqUcwLhpj
X-Gm-Message-State: AOJu0YyljnpB59RpGD9P44SkN/uxM30kSxLCyzCDWTQVwV+xzLGiSxO3
	7j1zdNpjj5sz0V5Uab4xWonxCkTJjOnb4pgTlK+GzAcYWdl12pRafk8sxMND0Fp/11LFONu0BpJ
	xhgxszL5iJmgzravegMDqzWf9ZLYMqHYRP4jrThnkSvrDmxxq9InFNQ==
X-Received: by 2002:a7b:c4d3:0:b0:415:511c:f801 with SMTP id g19-20020a7bc4d3000000b00415511cf801mr9480649wmk.34.1712135520580;
        Wed, 03 Apr 2024 02:12:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFih+RhMxkofK6JyLWYdlvz/egMC2LyfXQGxRu0dp4sZN6dWaGuQ8viRWVji43UT/hB7g2ow==
X-Received: by 2002:a7b:c4d3:0:b0:415:511c:f801 with SMTP id g19-20020a7bc4d3000000b00415511cf801mr9480631wmk.34.1712135520213;
        Wed, 03 Apr 2024 02:12:00 -0700 (PDT)
Received: from sgarzare-redhat ([185.95.145.60])
        by smtp.gmail.com with ESMTPSA id fa14-20020a05600c518e00b004159df274d5sm5705687wmb.6.2024.04.03.02.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 02:11:59 -0700 (PDT)
Date: Wed, 3 Apr 2024 11:11:53 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <luigi.leonardi@outlook.com>
Cc: kvm@vger.kernel.org, jasowang@redhat.com, 
	virtualization@lists.linux.dev, mst@redhat.com, kuba@kernel.org, xuanzhuo@linux.alibaba.com, 
	netdev@vger.kernel.org, stefanha@redhat.com, pabeni@redhat.com, davem@davemloft.net, 
	edumazet@google.com
Subject: Re: [PATCH net-next 2/3] vsock/virtio: add SIOCOUTQ support for all
 virtio based transports
Message-ID: <3n325gojjzphouapo36aowmcgt3iqjrqrmckqjjqgqmhvjdz4x@4givlk4egii3>
References: <20240402150539.390269-1-luigi.leonardi@outlook.com>
 <AS2P194MB2170BA1D5A32BDF70C4547B19A3E2@AS2P194MB2170.EURP194.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <AS2P194MB2170BA1D5A32BDF70C4547B19A3E2@AS2P194MB2170.EURP194.PROD.OUTLOOK.COM>

On Tue, Apr 02, 2024 at 05:05:38PM +0200, Luigi Leonardi wrote:
>This patch introduce support for stream_bytes_unsent in all
>virtio based transports: virtio-transport, vhost-vsock and
>vsock-loopback
>
>For all transports the unsent bytes counter is incremented
>in virtio_transport_send_pkt_info.
>
>In the virtio-transport (G2H) the counter is decremented each time the host
>notifies the guest that it consumed the skbuffs.
>In vhost-vsock (H2G) the counter is decremented after the skbuff is queued
>in the virtqueue.
>In vsock-loopback the counter is decremented after the skbuff is
>dequeued.
>
>Signed-off-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>---
> drivers/vhost/vsock.c                   |  3 ++-
> include/linux/virtio_vsock.h            |  7 ++++++
> net/vmw_vsock/virtio_transport.c        |  3 ++-
> net/vmw_vsock/virtio_transport_common.c | 30 +++++++++++++++++++++++++
> net/vmw_vsock/vsock_loopback.c          |  6 +++++
> 5 files changed, 47 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index ec20ecff85c7..9732ab944e5b 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -244,7 +244,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 					restart_tx = true;
> 			}
>
>-			consume_skb(skb);
>+			virtio_transport_consume_skb_sent(skb, true);
> 		}
> 	} while(likely(!vhost_exceeds_weight(vq, ++pkts, total_len)));
> 	if (added)
>@@ -430,6 +430,7 @@ static struct virtio_transport vhost_transport = {
> 		.stream_rcvhiwat          = virtio_transport_stream_rcvhiwat,
> 		.stream_is_active         = virtio_transport_stream_is_active,
> 		.stream_allow             = virtio_transport_stream_allow,
>+		.stream_bytes_unsent      = virtio_transport_bytes_unsent,
>
> 		.seqpacket_dequeue        = virtio_transport_seqpacket_dequeue,
> 		.seqpacket_enqueue        = virtio_transport_seqpacket_enqueue,
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index c82089dee0c8..cdce8b051f98 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -134,6 +134,8 @@ struct virtio_vsock_sock {
> 	u32 peer_fwd_cnt;
> 	u32 peer_buf_alloc;
>
>+	atomic_t bytes_unsent;
>+
> 	/* Protected by rx_lock */
> 	u32 fwd_cnt;
> 	u32 last_fwd_cnt;
>@@ -193,6 +195,11 @@ s64 virtio_transport_stream_has_data(struct vsock_sock *vsk);
> s64 virtio_transport_stream_has_space(struct vsock_sock *vsk);
> u32 virtio_transport_seqpacket_has_data(struct vsock_sock *vsk);
>
>+int virtio_transport_bytes_unsent(struct vsock_sock *vsk);
>+
>+void virtio_transport_consume_skb_sent(struct sk_buff *skb,
>+				       bool dealloc);
>+
> int virtio_transport_do_socket_init(struct vsock_sock *vsk,
> 				 struct vsock_sock *psk);
> int
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 1748268e0694..d3dd0d49c2b3 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -310,7 +310,7 @@ static void virtio_transport_tx_work(struct work_struct *work)
>
> 		virtqueue_disable_cb(vq);
> 		while ((skb = virtqueue_get_buf(vq, &len)) != NULL) {
>-			consume_skb(skb);
>+			virtio_transport_consume_skb_sent(skb, true);
> 			added = true;
> 		}
> 	} while (!virtqueue_enable_cb(vq));
>@@ -518,6 +518,7 @@ static struct virtio_transport virtio_transport = {
> 		.stream_rcvhiwat          = virtio_transport_stream_rcvhiwat,
> 		.stream_is_active         = virtio_transport_stream_is_active,
> 		.stream_allow             = virtio_transport_stream_allow,
>+		.stream_bytes_unsent      = virtio_transport_bytes_unsent,
>
> 		.seqpacket_dequeue        = virtio_transport_seqpacket_dequeue,
> 		.seqpacket_enqueue        = virtio_transport_seqpacket_enqueue,
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 16ff976a86e3..3a08e720aa9c 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -419,6 +419,9 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> 		 */
> 		rest_len -= ret;
>
>+		if (info->op == VIRTIO_VSOCK_OP_RW)
>+			atomic_add(ret, &vvs->bytes_unsent);
>+
> 		if (WARN_ONCE(ret != skb_len,
> 			      "'send_pkt()' returns %i, but %zu expected\n",
> 			      ret, skb_len))
>@@ -463,6 +466,24 @@ void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *
> }
> EXPORT_SYMBOL_GPL(virtio_transport_inc_tx_pkt);
>
>+void virtio_transport_consume_skb_sent(struct sk_buff *skb, bool dealloc)
>+{
>+	struct sock *s = skb->sk;
>+
>+	if (s) {
>+		struct vsock_sock *vs = vsock_sk(s);
>+		struct virtio_vsock_sock *vvs;
>+
>+		vvs = vs->trans;
>+		if (skb->len)
>+			atomic_sub(skb->len, &vvs->bytes_unsent);

We incremented it only for VIRTIO_VSOCK_OP_RW, should we check the
same here?

>+	}
>+
>+	if (dealloc)
             ^
What about rename it in `consume`?

The rest LGTM.

Thanks,
Stefano

>+		consume_skb(skb);
>+}
>+EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
>+
> u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
> {
> 	u32 ret;
>@@ -891,6 +912,7 @@ int virtio_transport_do_socket_init(struct vsock_sock *vsk,
> 		vsk->buffer_size = VIRTIO_VSOCK_MAX_BUF_SIZE;
>
> 	vvs->buf_alloc = vsk->buffer_size;
>+	atomic_set(&vvs->bytes_unsent, 0);
>
> 	spin_lock_init(&vvs->rx_lock);
> 	spin_lock_init(&vvs->tx_lock);
>@@ -1090,6 +1112,14 @@ void virtio_transport_destruct(struct vsock_sock *vsk)
> }
> EXPORT_SYMBOL_GPL(virtio_transport_destruct);
>
>+int virtio_transport_bytes_unsent(struct vsock_sock *vsk)
>+{
>+	struct virtio_vsock_sock *vvs = vsk->trans;
>+
>+	return atomic_read(&vvs->bytes_unsent);
>+}
>+EXPORT_SYMBOL_GPL(virtio_transport_bytes_unsent);
>+
> static int virtio_transport_reset(struct vsock_sock *vsk,
> 				  struct sk_buff *skb)
> {
>diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
>index 6dea6119f5b2..35fd4e47b5bf 100644
>--- a/net/vmw_vsock/vsock_loopback.c
>+++ b/net/vmw_vsock/vsock_loopback.c
>@@ -77,6 +77,7 @@ static struct virtio_transport loopback_transport = {
> 		.stream_rcvhiwat          = virtio_transport_stream_rcvhiwat,
> 		.stream_is_active         = virtio_transport_stream_is_active,
> 		.stream_allow             = virtio_transport_stream_allow,
>+		.stream_bytes_unsent      = virtio_transport_bytes_unsent,
>
> 		.seqpacket_dequeue        = virtio_transport_seqpacket_dequeue,
> 		.seqpacket_enqueue        = virtio_transport_seqpacket_enqueue,
>@@ -123,6 +124,11 @@ static void vsock_loopback_work(struct work_struct *work)
> 	spin_unlock_bh(&vsock->pkt_queue.lock);
>
> 	while ((skb = __skb_dequeue(&pkts))) {
>+		/* Decrement the bytes_sent counter without deallocating skb
>+		 * It is freed by the receiver.
>+		 */
>+		virtio_transport_consume_skb_sent(skb, false);
>+
> 		virtio_transport_deliver_tap_pkt(skb);
> 		virtio_transport_recv_pkt(&loopback_transport, skb);
> 	}
>-- 
>2.34.1
>
>


