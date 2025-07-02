Return-Path: <netdev+bounces-203435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBC2AF5F28
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 18:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32BB07AB63F
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 16:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D50F1EE019;
	Wed,  2 Jul 2025 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="blHLxU37"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBDF1DE2A5
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 16:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751475078; cv=none; b=p+FMa+MxxhAGuTyBygaI4HnN2hlNcDjXZs5uZxP3C9nYLW+YTLj+mvNQTQbD6Zn7rlNjR8MXxqIhOp9l7MWJCyyskH1kmCiwRm2TiqIWhGBA0bPwAP38OhRKYTdo6F0f6U3RQKVCZmFRPnrqyAGpF2vEM6ySV9hZFwWuWBcLhCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751475078; c=relaxed/simple;
	bh=vb//Qo24WW6S8QPbUQgG5ByNtX4L0YdqgqXP0MjGKWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ToH64DCfRoNTFDswAkIDbYVm46N46Hmh9kzNn73sobhnciyF1AiUGy+4tzo1r/BfDBbg6jKcWSx9gZCk8/zkMGeAwilERW1pvhIE2gGW2Wuh5yDHGPpu3sThEmpgiJHZKIUTsvr+PqrkbHZPkvNpbmJZ903aM7qFggY53cfStq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=blHLxU37; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751475075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xpfWH72ogCTg47ecP2Ua5CQ85Iecj8xXO5x3bBkcgCk=;
	b=blHLxU37YUFkI3bg7H+naGM0VC+IgvyqR60WyGZH4VR1Nyh9YiXXWDVFQ+CoRQWAI05Elh
	ckInTcB8OywNTOnEMrfkgockwoFfMQ/mWBOUpODo7bhMnm+U0KqEJBlyWabj8AzfqPrNAe
	PKcdSpG4efiivslS99RhQYUfcuLffkc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-KuFWgH6eNu-f-BtU-B2OxQ-1; Wed, 02 Jul 2025 12:51:14 -0400
X-MC-Unique: KuFWgH6eNu-f-BtU-B2OxQ-1
X-Mimecast-MFC-AGG-ID: KuFWgH6eNu-f-BtU-B2OxQ_1751475073
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4fac7fa27so1694619f8f.0
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 09:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751475073; x=1752079873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpfWH72ogCTg47ecP2Ua5CQ85Iecj8xXO5x3bBkcgCk=;
        b=l4kT0BR7hNaxbwQzFT1Q5p6t+0KoaURI/+/08ikdRyzmoUAcYD9JVhceSynA9wHidO
         EK8AAIbX3vo86jYUc/ks/qy4LhEA5B5rgjFA/FUd5HqudA2rFGWEIDDK+Tus0EPnybSB
         /X5NO8AdORXVKnmuQ4/X/ZOvNGK/xfPrq92xPnnBFQBMcDM5vo6MiIROXHkMxCQa4u3D
         tBnyGiVmpUC57MSDVk6zHEAvlw/uZ6Go4Wre+yCi4kUL14cL45vOV5cYxAsdh4HiDaHy
         TMuNjrYYSmR3JMnolvZcbckU3FuMsrXe2JOEOe/x1a45yUeUnnGI1AM7F2ZCcSoXkiDe
         xM2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVdK8eY4PNF2zDpYagbH9wEzBHm44zprGaF6QajXYb9CPljAp1qNXPfx0U7D7kQqPvkauc8JGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyukKwygIng/x20+T6MU00eqPWB1/c/2tfvEUpNKXTh8eobALgp
	B+JhmC65O7N08vuiC7fYxXVPBFYS2xiAg0XJGeovWGVDw0acGMOwSxIKmWshagEQ2Z05OJRDW1f
	m29lIPbIkHbsJTHyjf0EbFfxc7ns4DcqQf/XvCjaVuUPXHTAtaqQSkh00kA==
X-Gm-Gg: ASbGncvd5cWkboo0poyUvbTNUgXC2X4WKqrG8Q5vf1s55IoPezjt04s3z9sKVHZDusW
	PN2qnSiZWx+aOergXEXkuD9cyiM0QNZqhtCrF0zAz7EtT/9xm+5GxZd3S/ubqdNwWqbykQ/tAdx
	qKbNrhDkZrmLltUC7NFG/HzcHSdQQ4DG1B/Zk3l4mxYciXFt7IhIsklhS996wUWEHze3UeyRv0I
	dtG8qNY8Luv+d8dGPVa2xQ26n2/q1xQSrmHasQJVmyzJYpXkAC97EBZBPkY95+eatJg5/3k3ely
	A3TBtytDKs+AF5KS128ZfqsMpAw=
X-Received: by 2002:a05:6000:1acc:b0:3a5:3a03:79c1 with SMTP id ffacd0b85a97d-3b2015e2547mr3077875f8f.48.1751475072835;
        Wed, 02 Jul 2025 09:51:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvxMRKysuQdHGrGs7w7B21ZCIsLANcSN4jMzO65KTRNFi6asbCS0Y0iZ5KuPAG39RZBqRDZg==
X-Received: by 2002:a05:6000:1acc:b0:3a5:3a03:79c1 with SMTP id ffacd0b85a97d-3b2015e2547mr3077832f8f.48.1751475072278;
        Wed, 02 Jul 2025 09:51:12 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.161.84])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c80b516sm16110429f8f.41.2025.07.02.09.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 09:51:11 -0700 (PDT)
Date: Wed, 2 Jul 2025 18:50:59 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v2 6/8] vhost/vsock: Allocate nonlinear SKBs for handling
 large receive buffers
Message-ID: <bborsmywroqnwopuadqovhjvdt2fexhwjy2h3higczb7rwojnf@mg5xrk4mgnwx>
References: <20250701164507.14883-1-will@kernel.org>
 <20250701164507.14883-7-will@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250701164507.14883-7-will@kernel.org>

On Tue, Jul 01, 2025 at 05:45:05PM +0100, Will Deacon wrote:
>When receiving a packet from a guest, vhost_vsock_handle_tx_kick()
>calls vhost_vsock_alloc_linear_skb() to allocate and fill an SKB with
>the receive data. Unfortunately, these are always linear allocations and
>can therefore result in significant pressure on kmalloc() considering
>that the maximum packet size (VIRTIO_VSOCK_MAX_PKT_BUF_SIZE +
>VIRTIO_VSOCK_SKB_HEADROOM) is a little over 64KiB, resulting in a 128KiB
>allocation for each packet.
>
>Rework the vsock SKB allocation so that, for sizes with page order
>greater than PAGE_ALLOC_COSTLY_ORDER, a nonlinear SKB is allocated
>instead with the packet header in the SKB and the receive data in the
>fragments. Move the VIRTIO_VSOCK_SKB_HEADROOM check out of the
>allocation function and into the single caller that needs it and add a
>debug warning if virtio_vsock_skb_rx_put() is ever called on an SKB with
>a non-zero length, as this would be destructive for the nonlinear case.
>
>Signed-off-by: Will Deacon <will@kernel.org>
>---
> drivers/vhost/vsock.c        | 11 +++++------
> include/linux/virtio_vsock.h | 32 +++++++++++++++++++++++++-------
> 2 files changed, 30 insertions(+), 13 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index b13f6be452ba..f3c2ea1d0ae7 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -344,11 +344,12 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
>
> 	len = iov_length(vq->iov, out);
>
>-	if (len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
>+	if (len < VIRTIO_VSOCK_SKB_HEADROOM ||
>+	    len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
> 		return NULL;
>
> 	/* len contains both payload and hdr */
>-	skb = virtio_vsock_alloc_linear_skb(len, GFP_KERNEL);
>+	skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
> 	if (!skb)
> 		return NULL;
>
>@@ -377,10 +378,8 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
>
> 	virtio_vsock_skb_rx_put(skb);
>
>-	nbytes = copy_from_iter(skb->data, payload_len, &iov_iter);
>-	if (nbytes != payload_len) {
>-		vq_err(vq, "Expected %zu byte payload, got %zu bytes\n",
>-		       payload_len, nbytes);
>+	if (skb_copy_datagram_from_iter(skb, 0, &iov_iter, payload_len)) {
>+		vq_err(vq, "Failed to copy %zu byte payload\n", payload_len);
> 		kfree_skb(skb);
> 		return NULL;
> 	}
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 6d4a933c895a..ad69668f6b91 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -51,29 +51,47 @@ static inline void virtio_vsock_skb_rx_put(struct sk_buff *skb)
> {
> 	u32 len;
>
>+	DEBUG_NET_WARN_ON_ONCE(skb->len);
> 	len = le32_to_cpu(virtio_vsock_hdr(skb)->len);
>-	skb_put(skb, len);
>+
>+	if (skb_is_nonlinear(skb))
>+		skb->len = len;
>+	else
>+		skb_put(skb, len);
> }

>
>-static inline struct sk_buff *virtio_vsock_alloc_skb(unsigned int size, gfp_t mask)
>+static inline struct sk_buff *
>+__virtio_vsock_alloc_skb_with_frags(unsigned int header_len,
>+				    unsigned int data_len,
>+				    gfp_t mask)
> {
> 	struct sk_buff *skb;
>+	int err;
>
>-	if (size < VIRTIO_VSOCK_SKB_HEADROOM)
>-		return NULL;

I would have made this change in a separate patch, but IIUC the only 
other caller is virtio_transport_alloc_skb() where this condition is 
implied, right?

I don't know, maybe we could have one patch where you touch this and 
virtio_vsock_skb_rx_put(), and another where you introduce nonlinear 
allocation for vhost/vsock.  What do you think? (not a strong opinion, 
just worried about doing 2 things in a single patch)

Thanks,
Stefano

>-
>-	skb = alloc_skb(size, mask);
>+	skb = alloc_skb_with_frags(header_len, data_len,
>+				   PAGE_ALLOC_COSTLY_ORDER, &err, mask);
> 	if (!skb)
> 		return NULL;
>
> 	skb_reserve(skb, VIRTIO_VSOCK_SKB_HEADROOM);
>+	skb->data_len = data_len;
> 	return skb;
> }
>
> static inline struct sk_buff *
> virtio_vsock_alloc_linear_skb(unsigned int size, gfp_t mask)
> {
>-	return virtio_vsock_alloc_skb(size, mask);
>+	return __virtio_vsock_alloc_skb_with_frags(size, 0, mask);
>+}
>+
>+static inline struct sk_buff *virtio_vsock_alloc_skb(unsigned int size, gfp_t mask)
>+{
>+	if (size <= SKB_WITH_OVERHEAD(PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
>+		return virtio_vsock_alloc_linear_skb(size, mask);
>+
>+	size -= VIRTIO_VSOCK_SKB_HEADROOM;
>+	return __virtio_vsock_alloc_skb_with_frags(VIRTIO_VSOCK_SKB_HEADROOM,
>+						   size, mask);
> }
>
> static inline void
>-- 
>2.50.0.727.gbf7dc18ff4-goog
>


