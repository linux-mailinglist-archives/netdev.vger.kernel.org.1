Return-Path: <netdev+bounces-108386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FC6923A9C
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 11:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 719181C22B13
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 09:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC01156F55;
	Tue,  2 Jul 2024 09:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NFXeIihp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C703156980
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 09:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719913764; cv=none; b=WF+1x9sHZyVU9/1FBVm9pGnovM0f19bXHJP/b2/SKkXBgHSndWFKs/4T7z/q6IlzJAB18U2jf1UqajAqiVVyzzBA0houYPPprgVtNRLaheCUryt4n7+LAMxOpRlBttU1l6YrNMe9fJ+NjrEbU5LiV4XmhY3A6FBlP7Xo7DXv4to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719913764; c=relaxed/simple;
	bh=ChOuMiwGOzBpP3sNCHMWI4qVZ4l5LHUl3YiuYdFClBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0CpbeSLOjKMh5LGR+c9p9CrpkEK+J+hAxpAYLPucb6UCnb1gSrsq6dLy/iQRCudfacYfxpWlEhxoZWxACamCQDqOaYzRPpQ8UWZ9hW2pS8uh9MM+9dCnjM+SDtgA91L8exKmQ2co9amGWAfbmfzA3pwjiEt911SQsRVZb+6lW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NFXeIihp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719913761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I5C9hn1xC00HSAhZfwY+mFDAG9W+9IK6IOhPCt4SQMQ=;
	b=NFXeIihp63Rr/OD4jRKaPb0cGW6shn8FFQQDy7dsG2tEGp8CZ3ZZ35y8EpjqkzrB3746wE
	bDj5EiQ9CzJ2LnBTbhyVm51qLkuL60XHPsmLcG3RUICIVV7n1KVB9Itm1aQ46Nki3Kw8fu
	GbfmKCHCMujSjbUBMLtLiZlIreksrXU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-OGKbIp2-P0-1sDVHTZHPiQ-1; Tue, 02 Jul 2024 05:49:19 -0400
X-MC-Unique: OGKbIp2-P0-1sDVHTZHPiQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b5cec74f1dso4452956d6.3
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 02:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719913759; x=1720518559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5C9hn1xC00HSAhZfwY+mFDAG9W+9IK6IOhPCt4SQMQ=;
        b=H4e/6+bxvPD1CELyU5A34XPYcQQ08R1H3Oc3D4Y1sfgUtbUcgD//C1dVdyTtbGDj7c
         J4/MIrVWciIJJ7ZzPI0Aj4szeVHyS3igta9gOaPRySV8Vq02YxVl90N7J4XbE24IZjFn
         89VzDj29TnegPXWjL2yDUvvYhzMjSuJ373cRcCTzmfWzIIxqPT+zUvN9JbeTb1yFE8PB
         aheC83AtFJUD/iBxnngHILKT3uMnm8g8d/FOwsBnVVcSUA/IP5NNP1j1hQxrZr5MSbKI
         Rjiwv6hXuCyUiCj+oJkXfXQPVti1QbQc7Ueeg47PWTXMvRb59wJEg5B7ZqI0QYYMPZbV
         KgfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWB+kJ5Uyx3SzUuVsFI1n+W4Eu6lD04tyHlfmiiKDcjcQEYMh0o67a8qPCO8kI0XzpluN0eNyDkzouhCV7HtiKFe5hQA3n9
X-Gm-Message-State: AOJu0YzBfhJfDOYPS00djcsc5xrvQrIpctANj69D0TiqC83arDEdaCU3
	gLBAD1XSVMNMAqSfOmuetTr9o3BsREDBXlSpI8k4JusJwusia+Ipm9ZLmp0d8PBT1athp/lsWXM
	jcDxRT7nIlE3fHuajJsv29FOEYimbKbbttdh3vZhruRx8NpWEZJGQCg==
X-Received: by 2002:a05:6214:3005:b0:6b5:42b7:122 with SMTP id 6a1803df08f44-6b5b717b58bmr97377536d6.60.1719913759505;
        Tue, 02 Jul 2024 02:49:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgjbJl5pAjHk9X3v0oZqCcimvYtk9tuAmSK1l2XBB63KoGDxZm9QoDjYoqcF0qXR1twRoDnw==
X-Received: by 2002:a05:6214:3005:b0:6b5:42b7:122 with SMTP id 6a1803df08f44-6b5b717b58bmr97377396d6.60.1719913759015;
        Tue, 02 Jul 2024 02:49:19 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.133.110])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e5f39c1sm41979666d6.97.2024.07.02.02.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 02:49:18 -0700 (PDT)
Date: Tue, 2 Jul 2024 11:49:09 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: luigi.leonardi@outlook.com, Stefan Hajnoczi <stefanha@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Marco Pinna <marco.pinn95@gmail.com>
Subject: Re: [PATCH PATCH net-next v2 1/2] vsock/virtio: refactor
 virtio_transport_send_pkt_work
Message-ID: <5togzaghzoau7jxkbqpn6ydp45oc3rbwrmavtrimhpfxo5wxdi@hav2bj3l4ozo>
References: <20240701-pinna-v2-0-ac396d181f59@outlook.com>
 <20240701-pinna-v2-1-ac396d181f59@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240701-pinna-v2-1-ac396d181f59@outlook.com>

On Mon, Jul 01, 2024 at 04:28:02PM GMT, Luigi Leonardi via B4 Relay wrote:
>From: Marco Pinna <marco.pinn95@gmail.com>
>
>Preliminary patch to introduce an optimization to the
>enqueue system.
>
>All the code used to enqueue a packet into the virtqueue
>is removed from virtio_transport_send_pkt_work()
>and moved to the new virtio_transport_send_skb() function.
>
>Co-developed-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>Signed-off-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>Signed-off-by: Marco Pinna <marco.pinn95@gmail.com>
>---
> net/vmw_vsock/virtio_transport.c | 133 +++++++++++++++++++++------------------
> 1 file changed, 73 insertions(+), 60 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 43d405298857..a74083d28120 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -94,6 +94,77 @@ static u32 virtio_transport_get_local_cid(void)
> 	return ret;
> }
>
>+/* Caller need to hold vsock->tx_lock on vq */
>+static int virtio_transport_send_skb(struct sk_buff *skb, struct virtqueue *vq,
>+				     struct virtio_vsock *vsock, bool *restart_rx)
>+{
>+	int ret, in_sg = 0, out_sg = 0;
>+	struct scatterlist **sgs;
>+	bool reply;
>+
>+	reply = virtio_vsock_skb_reply(skb);
>+	sgs = vsock->out_sgs;
>+	sg_init_one(sgs[out_sg], virtio_vsock_hdr(skb),
>+		    sizeof(*virtio_vsock_hdr(skb)));
>+	out_sg++;
>+
>+	if (!skb_is_nonlinear(skb)) {
>+		if (skb->len > 0) {
>+			sg_init_one(sgs[out_sg], skb->data, skb->len);
>+			out_sg++;
>+		}
>+	} else {
>+		struct skb_shared_info *si;
>+		int i;
>+
>+		/* If skb is nonlinear, then its buffer must contain
>+		 * only header and nothing more. Data is stored in
>+		 * the fragged part.
>+		 */
>+		WARN_ON_ONCE(skb_headroom(skb) != sizeof(*virtio_vsock_hdr(skb)));
>+
>+		si = skb_shinfo(skb);
>+
>+		for (i = 0; i < si->nr_frags; i++) {
>+			skb_frag_t *skb_frag = &si->frags[i];
>+			void *va;
>+
>+			/* We will use 'page_to_virt()' for the userspace page
>+			 * here, because virtio or dma-mapping layers will call
>+			 * 'virt_to_phys()' later to fill the buffer descriptor.
>+			 * We don't touch memory at "virtual" address of this page.
>+			 */
>+			va = page_to_virt(skb_frag_page(skb_frag));
>+			sg_init_one(sgs[out_sg],
>+				    va + skb_frag_off(skb_frag),
>+				    skb_frag_size(skb_frag));
>+			out_sg++;
>+		}
>+	}
>+
>+	ret = virtqueue_add_sgs(vq, sgs, out_sg, in_sg, skb, GFP_KERNEL);
>+	/* Usually this means that there is no more space available in
>+	 * the vq
>+	 */
>+	if (ret < 0)
>+		return ret;
>+
>+	virtio_transport_deliver_tap_pkt(skb);
>+
>+	if (reply) {
>+		struct virtqueue *rx_vq = vsock->vqs[VSOCK_VQ_RX];
>+		int val;
>+
>+		val = atomic_dec_return(&vsock->queued_replies);
>+
>+		/* Do we now have resources to resume rx processing? */
>+		if (val + 1 == virtqueue_get_vring_size(rx_vq))
>+			*restart_rx = true;
>+	}

Looking more closely at this patch, perhaps we can leave reply handling 
out of this refactoring, as it is only needed in the worker.

IIUC, this is to prevent the RX worker from leaving room for the TX 
worker by handling too many replies. So when we have a large enough 
number of replies (equal to the size of the RX queue) in the queue of 
the TX worker ready to be queued in the virtqueue, we stop the RX worker 
and restart it only when the TX worker has had a chance to send replies.

@Stefan can you confirm this since you were involved in the original 
implementation?

If we skip the worker, we don't need this.
Moreover, we know well that the worker has no queued elements, so we 
will only go to increment `queued_replies` and then decrement it 
immediately afterwards.

Thanks,
Stefano

>+
>+	return 0;
>+}
>+
> static void
> virtio_transport_send_pkt_work(struct work_struct *work)
> {
>@@ -111,77 +182,19 @@ virtio_transport_send_pkt_work(struct work_struct *work)
> 	vq = vsock->vqs[VSOCK_VQ_TX];
>
> 	for (;;) {
>-		int ret, in_sg = 0, out_sg = 0;
>-		struct scatterlist **sgs;
> 		struct sk_buff *skb;
>-		bool reply;
>+		int ret;
>
> 		skb = virtio_vsock_skb_dequeue(&vsock->send_pkt_queue);
> 		if (!skb)
> 			break;
>
>-		reply = virtio_vsock_skb_reply(skb);
>-		sgs = vsock->out_sgs;
>-		sg_init_one(sgs[out_sg], virtio_vsock_hdr(skb),
>-			    sizeof(*virtio_vsock_hdr(skb)));
>-		out_sg++;
>-
>-		if (!skb_is_nonlinear(skb)) {
>-			if (skb->len > 0) {
>-				sg_init_one(sgs[out_sg], skb->data, skb->len);
>-				out_sg++;
>-			}
>-		} else {
>-			struct skb_shared_info *si;
>-			int i;
>-
>-			/* If skb is nonlinear, then its buffer must contain
>-			 * only header and nothing more. Data is stored in
>-			 * the fragged part.
>-			 */
>-			WARN_ON_ONCE(skb_headroom(skb) != sizeof(*virtio_vsock_hdr(skb)));
>-
>-			si = skb_shinfo(skb);
>-
>-			for (i = 0; i < si->nr_frags; i++) {
>-				skb_frag_t *skb_frag = &si->frags[i];
>-				void *va;
>-
>-				/* We will use 'page_to_virt()' for the userspace page
>-				 * here, because virtio or dma-mapping layers will call
>-				 * 'virt_to_phys()' later to fill the buffer descriptor.
>-				 * We don't touch memory at "virtual" address of this page.
>-				 */
>-				va = page_to_virt(skb_frag_page(skb_frag));
>-				sg_init_one(sgs[out_sg],
>-					    va + skb_frag_off(skb_frag),
>-					    skb_frag_size(skb_frag));
>-				out_sg++;
>-			}
>-		}
>-
>-		ret = virtqueue_add_sgs(vq, sgs, out_sg, in_sg, skb, GFP_KERNEL);
>-		/* Usually this means that there is no more space available in
>-		 * the vq
>-		 */
>+		ret = virtio_transport_send_skb(skb, vq, vsock, &restart_rx);
> 		if (ret < 0) {
> 			virtio_vsock_skb_queue_head(&vsock->send_pkt_queue, skb);
> 			break;
> 		}
>
>-		virtio_transport_deliver_tap_pkt(skb);
>-
>-		if (reply) {
>-			struct virtqueue *rx_vq = vsock->vqs[VSOCK_VQ_RX];
>-			int val;
>-
>-			val = atomic_dec_return(&vsock->queued_replies);
>-
>-			/* Do we now have resources to resume rx processing? */
>-			if (val + 1 == virtqueue_get_vring_size(rx_vq))
>-				restart_rx = true;
>-		}
>-
> 		added = true;
> 	}
>
>
>-- 
>2.45.2
>
>


