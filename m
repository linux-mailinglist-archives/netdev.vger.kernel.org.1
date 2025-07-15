Return-Path: <netdev+bounces-207051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E86EBB05753
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 12:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBDF61AA739B
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 10:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3331D2550CF;
	Tue, 15 Jul 2025 10:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXD6Wngr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7D5226D10
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 10:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573621; cv=none; b=LhiF79ntRwn//H/deoqzWSvuvudjScUvJ5CAV2FaEOM2bQnKEoO8tzyhA6MIHszE7aUV8Aqpdjv15X7V9pJqCp8KCquXYKR1ew7E/ThNqiZ+ZXIFVCsQrYhLHZ62sMIs/rHHw9z8RiTmjYp4SaOLIWa8kK3YBvUvkReFMCB+pHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573621; c=relaxed/simple;
	bh=rRERNh5u97l8jzE7gjjtUkUOQ2wslT8sARlamjvPlzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OE8FBXigSxv1fVMm05+PJetlUqW4jr9MOJGuzsdwMUIYmmJMcNkwnoiqnUrZTwIqWTUoVN6Uk3ixilcy9jyz9ETlLRv/n8ghpCWDqOP8jp9SKb8hjzr5+q6N7XEV7u07pB/I+beE23Jc9I31c6D7UhikeWLmT/buUpZQh/q5pEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cXD6Wngr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752573617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eg250cy9VjDoGFF4U99qUNkf2wzs6t/xzPjF1cEnzC0=;
	b=cXD6Wngry8BCYMtWQz4BOCIFmpJPpSOgjN432hNQMCMJ3Odtn3YjDeB1OyQbtqvl86rhcG
	audzJXvvnji75WR+fiS/qzSRGgFGSQvPo+WFfarTwBz5GpBPuWMSvHjWjDtDg5XK4YVD06
	VHlEh2jqxSo0IWc4UpA7mJq6TmUwzmY=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-7iCX8N0WPb2NerwfKD_NIw-1; Tue, 15 Jul 2025 06:00:15 -0400
X-MC-Unique: 7iCX8N0WPb2NerwfKD_NIw-1
X-Mimecast-MFC-AGG-ID: 7iCX8N0WPb2NerwfKD_NIw_1752573615
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-74d15d8dcd1so4020259b3a.2
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 03:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752573614; x=1753178414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eg250cy9VjDoGFF4U99qUNkf2wzs6t/xzPjF1cEnzC0=;
        b=j7RqTAUTnjsHh+pH7nAJWGzIjp0pjEr83c59nTc1A148/x55IpDubJxfUoTXO+SC6o
         5HQWCRPd0JKCqhb/7UaJU/aJMmKDwHO2A1uX1Y16CnxPUP3xUtTnHcsnYxQf7gLRRvOi
         In94G2D7Qf9NUp1qno3k3AgGhDZs5wYbgR7ATVhjeVVPiIDNOvEMhV4FyXQe40HKXpUv
         Ayo1Y0IpYQqc3n/PU6d8sAhzyuFHfjclh6a+An94eiW/WOJ+Hxp0ylEH395FeDwePp9C
         fD+wK3QzWsBamUj0K5sjXIl5RR8JMBr6tVHU7NeM6TcqI5jJJk4lJ3Z1csUTVzrMpeoT
         UaHA==
X-Forwarded-Encrypted: i=1; AJvYcCXTttkI6ithMpIcImQmIJbf1A4JxyaOnvASNlHiCuLycxMsAcWGGUPDul4V4V0gCBUZW8YwERg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtp6qLUB9RUYqgmBsQAwl6/xA95I6mn19jFUjRHitlP/TgQ7HB
	r33uwP4KQbA5DTJuSRFuak7IfgvInlXWPc+b2uPzGhnx6+FX3r2+i8xcFYIjmbLi2tu5xmiBOuh
	CVrAnMhGXbHxr+9YfvbgbhBeUNsFAyM/4daSqNa0+qvg5FfO5RYhnL/bNmw==
X-Gm-Gg: ASbGncseKo1cFPlmGQzKgY6p42tbc953Y2bjEX2wtAfA7lILLQy/gnDT2wsRup3Y8Nt
	UbkcRKDmNCe+dLXDPQbmfkUcjoL44q/Lc5eMAVz4ZvbhZijx6TakSI9/prIMWQyS/L1OXLYjYtg
	J2IPciVV8V4TrydHZdTpiXQwqat2iiIID+4/htIoNyyjHkaJIVO1Kw/dMHUJMAUSR26WO2vCyQX
	L+WoeDmxqbkpTUlb8V9Ue/meEc4DzXkTHqdMG0sD2XJeo42NgFKdaNlB3zdER5PJlYf7FEDq7l6
	n9m03wLPZYsHM9tMgIobgzatIVWWzMikc0OA3ZtHuw==
X-Received: by 2002:a05:6a21:10b:b0:220:7e77:f4f7 with SMTP id adf61e73a8af0-23137e8e30fmr24760145637.25.1752573614289;
        Tue, 15 Jul 2025 03:00:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYvHM5d2dKS5rNDI58T5AWqkvB1O86ZZsm91t+LrcuzX6CBDe/JvvwAbp/DEJ1Rc6rvUY8UQ==
X-Received: by 2002:a05:6a21:10b:b0:220:7e77:f4f7 with SMTP id adf61e73a8af0-23137e8e30fmr24760031637.25.1752573613623;
        Tue, 15 Jul 2025 03:00:13 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.142.44])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe581a16sm11645042a12.28.2025.07.15.03.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 03:00:12 -0700 (PDT)
Date: Tue, 15 Jul 2025 12:00:05 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v3 7/9] vhost/vsock: Allocate nonlinear SKBs for handling
 large receive buffers
Message-ID: <y5o3b47vimlbzuojy2d5hscewa7ywres7c4yml5zldfvpsjby7@cbi7wfpksu2z>
References: <20250714152103.6949-1-will@kernel.org>
 <20250714152103.6949-8-will@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250714152103.6949-8-will@kernel.org>

On Mon, Jul 14, 2025 at 04:21:01PM +0100, Will Deacon wrote:
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
>fragments. Finally, add a debug warning if virtio_vsock_skb_rx_put() is
>ever called on an SKB with a non-zero length, as this would be
>destructive for the nonlinear case.
>
>Signed-off-by: Will Deacon <will@kernel.org>
>---
> drivers/vhost/vsock.c        |  8 +++-----
> include/linux/virtio_vsock.h | 40 +++++++++++++++++++++++++++++-------
> 2 files changed, 36 insertions(+), 12 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 24b7547b05a6..0679a706ebc0 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -349,7 +349,7 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
> 		return NULL;
>
> 	/* len contains both payload and hdr */
>-	skb = virtio_vsock_alloc_linear_skb(len, GFP_KERNEL);
>+	skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
> 	if (!skb)
> 		return NULL;
>
>@@ -378,10 +378,8 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
>
> 	virtio_vsock_skb_rx_put(skb, payload_len);
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
>index 36dd0cd55368..fa5934ea9c81 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -49,20 +49,46 @@ static inline void virtio_vsock_skb_clear_tap_delivered(struct sk_buff *skb)
>
> static inline void virtio_vsock_skb_rx_put(struct sk_buff *skb, u32 len)
> {
>-	skb_put(skb, len);
>+	DEBUG_NET_WARN_ON_ONCE(skb->len);
>+
>+	if (skb_is_nonlinear(skb))
>+		skb->len = len;
>+	else
>+		skb_put(skb, len);
>+}
>+
>+static inline struct sk_buff *
>+__virtio_vsock_alloc_skb_with_frags(unsigned int header_len,
>+				    unsigned int data_len,
>+				    gfp_t mask)
>+{
>+	struct sk_buff *skb;
>+	int err;
>+
>+	skb = alloc_skb_with_frags(header_len, data_len,
>+				   PAGE_ALLOC_COSTLY_ORDER, &err, mask);
>+	if (!skb)
>+		return NULL;
>+
>+	skb_reserve(skb, VIRTIO_VSOCK_SKB_HEADROOM);
>+	skb->data_len = data_len;
>+	return skb;
> }
>
> static inline struct sk_buff *
> virtio_vsock_alloc_linear_skb(unsigned int size, gfp_t mask)
> {
>-	struct sk_buff *skb;
>+	return __virtio_vsock_alloc_skb_with_frags(size, 0, mask);
>+}
>
>-	skb = alloc_skb(size, mask);
>-	if (!skb)
>-		return NULL;
>+static inline struct sk_buff *virtio_vsock_alloc_skb(unsigned int size, gfp_t mask)
>+{
>+	if (size <= SKB_WITH_OVERHEAD(PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
>+		return virtio_vsock_alloc_linear_skb(size, mask);
>
>-	skb_reserve(skb, VIRTIO_VSOCK_SKB_HEADROOM);
>-	return skb;
>+	size -= VIRTIO_VSOCK_SKB_HEADROOM;
>+	return __virtio_vsock_alloc_skb_with_frags(VIRTIO_VSOCK_SKB_HEADROOM,
>+						   size, mask);
> }
>
> static inline void
>-- 
>2.50.0.727.gbf7dc18ff4-goog
>


