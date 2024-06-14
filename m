Return-Path: <netdev+bounces-103638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8583908D99
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 16:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53A961F241D9
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 14:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1182107B6;
	Fri, 14 Jun 2024 14:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQuyxCKF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2808C129
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 14:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718375843; cv=none; b=KukuLBPxvzMzZ160AZ0eu8/33MA5vS33V0h4uaO6KYyFgHKyCyam6IwpksKFb4E98Q4+LxGJWaVdSe7l2tjMKFe86QJgu+a/CiO3z432XxlWX5IE5cqiGL5FDCCJNhpK7Zo2cPOgLfvTejGJ0V0qmdiVdavk8uBnV/CXbpkvxN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718375843; c=relaxed/simple;
	bh=T6yv7I5syZZgcNs6PyKRhYS3KfDAA6mZlqzAdOn36Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilrplrfc1aRr7Hz6W2X+S2mDW8ymm1JLC9jdBEnk/A9oHBBjcNT+O6w++BU7LLpBZBZSul1BLWCMt4TDZVqH02T7cSZSxPWAmKrk4KcHsyhvEiIvb9XKBeUXES/HajH+dv/qeJSbW6LFTDnT96SztArqmk5JBjvhovBiSQ3ysl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DQuyxCKF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718375839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8VKKhGKwr7TjIxs7MZnTi0KjppWjoseUD7kZ6OFw6gE=;
	b=DQuyxCKFMcZ3MhP6zRFSlNMXiw+WsZksP46V/5Uhv+gF3uJTEqgszfXbV515PoFakhJ9+/
	vL4rDhX63E28mRz15fmqe9QUCUadAHylsvwqWgRddjEraJ6T4Yv14+DHvbfX64s1638Dpf
	I36YTL9/Mrs4l3oI+MFEMg7ckDmt+eg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-VtiiJyBcP8qWwfIWdcr20A-1; Fri, 14 Jun 2024 10:37:18 -0400
X-MC-Unique: VtiiJyBcP8qWwfIWdcr20A-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-57caaaecc6fso1325878a12.2
        for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 07:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718375837; x=1718980637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8VKKhGKwr7TjIxs7MZnTi0KjppWjoseUD7kZ6OFw6gE=;
        b=r2eJfMDpqGXNGDlObiDoGC6M/1Bmd29QNsSgKRl3e4d4RhlejPWmktW32/IdNHnScF
         ZXP2zWb9nWnQFND4p3zRO65V5JCPyQwu0cgmn+9mbx1pM34Ri5xWvb/kkkPVpinGDxfM
         lPmp2Iq+LAjB7qv5Jhl4KhRp4zemm8O6+fZ8MBOsG/Bl23UTlk/7xJZ0jsNuppsWVjt5
         5bjwyaP+jjZTq9kMlnCZrR+7E837Ng52cEuMkHZXifv7TjZwzZy6T1xGVhAv6OV4Hcwo
         uPrZvGWEt01OZw+WXDbQHC0EKZhrcs8Wg+WvUrMoRrothnzzAWzd3tf60FLYsIdp7TBQ
         v5UA==
X-Forwarded-Encrypted: i=1; AJvYcCW1/qP3+wPqoKBFyV0dJmzp5z7tMeHaFPkihgy9hqMfpIn4Qm3BvFvS9HiAXUvzNybZXoFiufmsruB/k42vTcGnpbWTiCKy
X-Gm-Message-State: AOJu0YxZOOklZqsGU+/GvvBYLboYWoYW62h0DFWtEhUK3D5vA6QHO1X1
	o2rmUc1KOp+DIHXm8ooAZLGCMPW7IZMeGu1SP6p2hlr00RAJZME0SKsbijU58y6URrKA12/xeO4
	RGI9L/BVdiB0kJFSkPARRcBAltCLSimCbGlWuZgfTYSv/yF8p5qoWRg==
X-Received: by 2002:a50:96c3:0:b0:57c:4867:6738 with SMTP id 4fb4d7f45d1cf-57cbd6496b2mr2142629a12.2.1718375837184;
        Fri, 14 Jun 2024 07:37:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMIPk9ZbvfOHdHDxFf5K+8em8CG7gzR2Iqm6IoVMPzEdsKvGKc6eizF14fWO0h+dFsk3GJ0w==
X-Received: by 2002:a50:96c3:0:b0:57c:4867:6738 with SMTP id 4fb4d7f45d1cf-57cbd6496b2mr2142622a12.2.1718375836770;
        Fri, 14 Jun 2024 07:37:16 -0700 (PDT)
Received: from sgarzare-redhat ([147.229.117.1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72da156sm2342251a12.22.2024.06.14.07.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 07:37:16 -0700 (PDT)
Date: Fri, 14 Jun 2024 16:37:12 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <luigi.leonardi@outlook.com>
Cc: edumazet@google.com, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, kuba@kernel.org, kvm@vger.kernel.org, stefanha@redhat.com, 
	pabeni@redhat.com, davem@davemloft.net, Marco Pinna <marco.pinn95@gmail.com>
Subject: Re: [PATCH net-next 1/2] vsock/virtio: refactor
 virtio_transport_send_pkt_work
Message-ID: <i5ofr6nj2fmxqeaswucvhbtvgglhvurzslsismthlrr77v7bsk@aishfdtaq4vb>
References: <20240614135543.31515-1-luigi.leonardi@outlook.com>
 <AS2P194MB21702C53FEFDC2F8283B5A789AC22@AS2P194MB2170.EURP194.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <AS2P194MB21702C53FEFDC2F8283B5A789AC22@AS2P194MB2170.EURP194.PROD.OUTLOOK.COM>

On Fri, Jun 14, 2024 at 03:55:42PM GMT, Luigi Leonardi wrote:
>From: Marco Pinna <marco.pinn95@gmail.com>
>
>This is a preliminary patch to introduce an optimization to
>the enqueue system.
>
>All the code used to enqueue a packet into the virtqueue
>is removed from virtio_transport_send_pkt_work()
>and moved to the new virtio_transport_send_skb() function.
>
>Co-developed-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>Signed-off-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>Signed-off-by: Marco Pinna <marco.pinn95@gmail.com>
>---
> net/vmw_vsock/virtio_transport.c | 134 +++++++++++++++++--------------
> 1 file changed, 74 insertions(+), 60 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 43d405298857..c930235ecaec 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -94,6 +94,78 @@ static u32 virtio_transport_get_local_cid(void)
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
>+			 * We don't touch memory at "virtual" address of 
>this page.
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
>+		goto out;

We use the `out` label just here, so what about remove it since we just 
return ret?

I mean:

	if (ret < 0)
		return ret;

...

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
>+

	return 0;
}

>+out:
>+	return ret;
>+}
>+
> static void
> virtio_transport_send_pkt_work(struct work_struct *work)
> {
>@@ -111,77 +183,19 @@ virtio_transport_send_pkt_work(struct work_struct *work)
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
>+		ret = virtio_transport_send_skb(skb, vq, vsock, &restart_rx);
>

nit: I'd remove this new line here.

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
>-		ret = virtqueue_add_sgs(vq, sgs, out_sg, in_sg, skb, 
>GFP_KERNEL);
>-		/* Usually this means that there is no more space 
>available in
>-		 * the vq
>-		 */
> 		if (ret < 0) {
> 			virtio_vsock_skb_queue_head(&vsock->send_pkt_queue, skb);
> 			break;
> 		}
>-
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

nit: maybe I'd move the empty line here.


Our usual style is:
         ret = foo();
         if (ret < 0) {
             //error handling
         }

         next_stuff...

Thanks,
Stefano

> 		added = true;
> 	}
>
>-- 
>2.45.2
>


