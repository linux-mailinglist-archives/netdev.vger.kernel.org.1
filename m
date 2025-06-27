Return-Path: <netdev+bounces-201879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE8EAEB542
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 12:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDE487A484E
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 10:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7E9339A8;
	Fri, 27 Jun 2025 10:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PhGApyq7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039802253BC
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 10:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751021162; cv=none; b=bj+GoTtEgESi8Ijoje5mv+Yj5etztV8HrVGw7wD7hW4GexYnG6DHJyidMlxe+CYVx7PwcAVCgiFSXUIY90iuGLzpNtmGuaSQal1haE+K28vaePbpsWIH1KsjPVMFXDXwApImm45S+CqKZfoQ/qUbVYW1ywgnuMzwRhv29zRdXqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751021162; c=relaxed/simple;
	bh=C/KPQHq3boiOOyYKseJ6EOxKOV9EYDs3Tr/NHsprnp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+prsaG79jkg7G0qolH5prZZuutbghrk3f2RBKO17ixY2hGPLEgd1seud5dFu52ZQBVLbxtSstLjPPreMbXpu0NLxvlDiHgxYOKtJegEjT3pQNy5d+vjlvCxoqJam1pU0aFbWbVQouxI7Jkn90P4evynqph87kL937q9rQqXXX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PhGApyq7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751021160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YSDcmP32HC6SX+QgiXKA8vD52iRXQVrx4HQM4vYbyFY=;
	b=PhGApyq7szUccR7I6uUqvWNx5TkQJx2tT9xtBVSm7slL4CvX5qcY9gNoI13/SrZo8Lnh/8
	9AIm3uSvqDYKa7HRjzLSd6EA0hg9IFl6ObsT6RRhPqepJ0+JXfO408LAoOhLdbTbtadHrL
	W7QT+Fla75WdaMH3hMepNv/wkoXMK/c=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-be_vnejqMbCoPNcQ4xHWzw-1; Fri, 27 Jun 2025 06:45:58 -0400
X-MC-Unique: be_vnejqMbCoPNcQ4xHWzw-1
X-Mimecast-MFC-AGG-ID: be_vnejqMbCoPNcQ4xHWzw_1751021157
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-23692793178so18265145ad.0
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 03:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751021157; x=1751625957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSDcmP32HC6SX+QgiXKA8vD52iRXQVrx4HQM4vYbyFY=;
        b=BH8lvBj8bdrIDperJBx1QLFPpdb4A3+m8qsuxxkVjYiDQr4n12uaSv010hkt3c4l1Y
         EpryJeqjitMC15/vMjVZ+NpDxd3c0L3jMjsj5/xOKO8BmJE/0EgX6chOSEwPtk6sfhp0
         vjkOijGhM2riK6MBAYtMZQStEMQqgnk0ozLGcJj0CXLJLcKNQ/5ubKIYboZGJthrUwO8
         pyIhsrsTQlJfFi5azmwJ2PRPKNQ3haM69FU52nY49XhLcDislAWaLkKJcqDy4enY3Vps
         D+VvrFfIeFT1OKspCz8VOaL9WVRBZIDqwwaGAhBIMLX13Obdk3oCa2qLF3Hk/oF1Ub2f
         zqlA==
X-Forwarded-Encrypted: i=1; AJvYcCWhil4udDo9pReKvYRdwmLJEBGloS6l02x/xb/5y60xycM5gxP7fOBs4Yh9dvx9e2RCuAtFojQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCO7b7aFD4e8i8x4KEP0oNg16XwsnRbYIcZ3nYHfy3aGS3g3uq
	Goa+nOvfyygNoZaQd7NhWwFr98ex0pL3+VhuupgfP8uOFiOsheegaRNLT8iwR8LOStuCkf4rOZi
	aLniQOIpJm6PXxw8QBQ9UoCeWLH4DGoiH3W++KEFSMIuwCx01Mv6trH5G8w==
X-Gm-Gg: ASbGncuLHDHod03YbDGcigwlJtfBS3SFFobclKn3dGN8snSVDoAdjoW0FKn5IY0V9Bc
	g5jvgVG1VdAzURNIyoiJUMrWa0Kc3kKnjt+lSv7DhEeO/82kjDp+AxSW8SWxuzqv4dgREnqM8Gw
	jDdqLkEE+qiDoGrWsu38LfADayJkNQ83cXNnXTGMEeXGAQYiZqlP3vdIWQQfiOA/NIM4lML+PIq
	5K2wN6K4g5LSIFEs0FJWS8Ti6T3bMCWriY7NJVTxZV+1uYdsRXbyUBw413uAgwIXD1bQCXXt2T2
	YZtxlX5+GTPjpAWBWSlK7evP/WQ=
X-Received: by 2002:a17:902:ec89:b0:234:8a4a:adad with SMTP id d9443c01a7336-23ac46824a1mr44957065ad.26.1751021157504;
        Fri, 27 Jun 2025 03:45:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOGh1U+3l3EMdNMKJOF70Cr/LIagjk6D2LvbwdUk5eDdvnFLkug9LJltGUvympGN5YEPfRCQ==
X-Received: by 2002:a17:902:ec89:b0:234:8a4a:adad with SMTP id d9443c01a7336-23ac46824a1mr44956715ad.26.1751021157113;
        Fri, 27 Jun 2025 03:45:57 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.150.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2f2569sm14469255ad.64.2025.06.27.03.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 03:45:56 -0700 (PDT)
Date: Fri, 27 Jun 2025 12:45:45 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH 3/5] vhost/vsock: Allocate nonlinear SKBs for handling
 large receive buffers
Message-ID: <orht2imwke5xhnmeewxrbey3xbn2ivjzujksqnrtfe3cjtgrg2@6ls6dyexnkvc>
References: <20250625131543.5155-1-will@kernel.org>
 <20250625131543.5155-4-will@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250625131543.5155-4-will@kernel.org>

On Wed, Jun 25, 2025 at 02:15:41PM +0100, Will Deacon wrote:
>When receiving a packet from a guest, vhost_vsock_handle_tx_kick()
>calls vhost_vsock_alloc_skb() to allocate and fill an SKB with the
>receive data. Unfortunately, these are always linear allocations and can
>therefore result in significant pressure on kmalloc() considering that
>the maximum packet size (VIRTIO_VSOCK_MAX_PKT_BUF_SIZE +
>VIRTIO_VSOCK_SKB_HEADROOM) is a little over 64KiB, resulting in a 128KiB
>allocation for each packet.
>
>Rework the vsock SKB allocation so that, for sizes with page order
>greater than PAGE_ALLOC_COSTLY_ORDER, a nonlinear SKB is allocated
>instead with the packet header in the SKB and the receive data in the
>fragments.
>
>Signed-off-by: Will Deacon <will@kernel.org>
>---
> drivers/vhost/vsock.c        | 15 +++++++++------
> include/linux/virtio_vsock.h | 31 +++++++++++++++++++++++++------
> 2 files changed, 34 insertions(+), 12 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 66a0f060770e..cfa4e1bcf367 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -344,11 +344,16 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
>
> 	len = iov_length(vq->iov, out);
>
>-	if (len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
>+	if (len < VIRTIO_VSOCK_SKB_HEADROOM ||

Why moving this check here?

>+	    len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
> 		return NULL;
>
> 	/* len contains both payload and hdr */
>-	skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
>+	if (len > SKB_WITH_OVERHEAD(PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
>+		skb = virtio_vsock_alloc_skb_with_frags(len, GFP_KERNEL);
>+	else
>+		skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);

Can we do this directly in virtio_vsock_alloc_skb() so we don't need
to duplicate code on virtio/vhost code?

>+
> 	if (!skb)
> 		return NULL;
>
>@@ -377,10 +382,8 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
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
>index 67ffb64325ef..8f9fa1cab32a 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -51,27 +51,46 @@ static inline void virtio_vsock_skb_rx_put(struct sk_buff *skb)
> {
> 	u32 len;
>
>+	DEBUG_NET_WARN_ON_ONCE(skb->len);

Should we mention in the commit message?

> 	len = le32_to_cpu(virtio_vsock_hdr(skb)->len);
>
>-	if (len > 0)

Why removing this check?

Thanks,
Stefano

>+	if (skb_is_nonlinear(skb))
>+		skb->len = len;
>+	else
> 		skb_put(skb, len);
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
>+static inline struct sk_buff *
>+virtio_vsock_alloc_skb_with_frags(unsigned int size, gfp_t mask)
>+{
>+	size -= VIRTIO_VSOCK_SKB_HEADROOM;
>+	return __virtio_vsock_alloc_skb_with_frags(VIRTIO_VSOCK_SKB_HEADROOM,
>+						   size, mask);
>+}
>+
>+static inline struct sk_buff *virtio_vsock_alloc_skb(unsigned int size, gfp_t mask)
>+{
>+	return __virtio_vsock_alloc_skb_with_frags(size, 0, mask);
>+}
>+
> static inline void
> virtio_vsock_skb_queue_head(struct sk_buff_head *list, struct sk_buff *skb)
> {
>-- 
>2.50.0.714.g196bf9f422-goog
>
>


