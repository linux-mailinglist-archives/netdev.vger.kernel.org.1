Return-Path: <netdev+bounces-219585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7186B420A5
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 15:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C9A93BC43D
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 13:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB34307AF6;
	Wed,  3 Sep 2025 13:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DYzZzi0J"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B1A307AC4
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 13:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756905065; cv=none; b=LqbwXVNJA8KmsYuPnj9K6PzPqmCYxsosPw3LaxCQPG6gyVAQiucDBH4xHWFSVk8rXlq+kM9PUmPfjez8oObpH4nDjSd4X3SjGsGJRNL3Q9OSbh+JBb/Pvx++9kzxdNk2lH981B4C0ngi+vi8C2mmYGWmjDsjtd/eaXanRz581ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756905065; c=relaxed/simple;
	bh=Y/X2fWSGYvLP2GbzQgVsXw6QemqhTogGncbWhT+ee+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjzFPQf8qT94/xXhxw/inENWejxXdNs811IibP/Im3WpI3++tCl+hXhyzfTSLhWlOlug9oAk6cAmnvIvE4vnFBkkkxia0gszRxbTQ7q+NWp0bN9WLxK2kUJsL3evVSxd/Nk9V3oruBQMXH+mHDSY9rwAfA8vtQXrG+KN3ZPAqxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DYzZzi0J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756905062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fu1nRMO4mP7hG3XcSYcXuE1KvbxzA7CKEO6dC9YqXJc=;
	b=DYzZzi0JTIwF4Zo0mBvkE8Y0inn1Cv27e64YH4EQDYW3ehiwPvvOqwewlYNI9skeTtEl6d
	V04nTJ764DeBaoKRv4Qmd67fZRFwfVKz/+qVKfp2yWuY35Si+Wgc2MmEC7beVMjLsyUo3Z
	rmZvn6WIHfKUh5Yx+vlQK9tM0GGvX0Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-P2Z38pHDNs2uh6Vji1V3FQ-1; Wed, 03 Sep 2025 09:10:59 -0400
X-MC-Unique: P2Z38pHDNs2uh6Vji1V3FQ-1
X-Mimecast-MFC-AGG-ID: P2Z38pHDNs2uh6Vji1V3FQ_1756905057
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3d226c3a689so1735129f8f.0
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 06:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756905057; x=1757509857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fu1nRMO4mP7hG3XcSYcXuE1KvbxzA7CKEO6dC9YqXJc=;
        b=PpRqUhhXw3VuPvgILiYopy1l2dHNJF2AiqzIroVU3hyRFDIdrOe1eSUk8Scms7rhBC
         qvGTGDI3vdwvvbh8HAWVb9+wlg1HNTEjOsMd2v7fs5/rAKSNbvIG8ger4hRCTpQ7+LBY
         8qdPTPuKk6r2bSKgzqw/XvXSBuWri3i9M9D7s5MMGfXLgz5mO5Aio9K5yLvDxHW5gbed
         SA820Rbw8aI2YoUwwHVJfNUhmHP4L2L5DR9dDEaNerEbwk6r6bxwfJn2y+bQATTtsF8d
         jyQt70pNvdYv+T1xKPLhtChhp8YglC8t6Gj/4877EWnNFBiM7JzLAuMr+LHeeL2eJZe+
         Jmlw==
X-Forwarded-Encrypted: i=1; AJvYcCXQsxy49eeDRuAwzAYjJhfwEwKYkrlEc8lJAoADZNty+jc13Tsh7dqB1nEIuhMaw0Au6K4inZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBUq27YPQQVi7DV7ghTw6v1RWrc1Y/EFwDP1e/OSNNvwTfjB2l
	eKxFxjmdyqpUtUky334cIkQ/AYjLIAEwmDkms+chuMaquz0BUrvnNelgFd8LtrFtaQ3yOTDLW/J
	eHuybZQiwwZ6LZ3V8+zqUCGX1nevtph/fBFz9ku4xlsJKeXgnLNZvuSpvwQ==
X-Gm-Gg: ASbGncvs72xOReGImAgmV/nZene3LBWBV0gOevkMPkYFpJMbN8lkh0DDl/vrI+V4RWv
	HrKFnngdP0QiCFzFLsJz4Wk8sGEdST8fP02JEqiv7NSQBji3vNxcCwwHF7JapZaiXuudhYT0DjD
	CMAw7glmIw7GM3CxvJ8WEqJfQuOrkROOvGjBlc5DcRIC/BWN97uMnkR/UGzCzedS6hrD8au4FqT
	py7ZbQxd2Xsc3mcGzckkb4KpecxtOTy09a/nDbZLLup1WaHeGwVqUDbxZbeVaktaNImzKzFDLVW
	eYTg8hi3vHOcCknbm5n0azaSSr+AbQ==
X-Received: by 2002:a05:6000:3110:b0:3cc:29e8:d52f with SMTP id ffacd0b85a97d-3d1dea86a76mr12153289f8f.38.1756905057082;
        Wed, 03 Sep 2025 06:10:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFb0624kVbYkja7DUsEoelJ71o6GXCbvgslVOj9fGNi28SVeur6o32uG23Fh/vV7MnRvsF1pw==
X-Received: by 2002:a05:6000:3110:b0:3cc:29e8:d52f with SMTP id ffacd0b85a97d-3d1dea86a76mr12153241f8f.38.1756905056517;
        Wed, 03 Sep 2025 06:10:56 -0700 (PDT)
Received: from redhat.com ([2a0e:41b:f000:0:c4d3:2073:6af0:f91d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e92a42asm237242065e9.20.2025.09.03.06.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 06:10:56 -0700 (PDT)
Date: Wed, 3 Sep 2025 09:10:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	eperezma@redhat.com, stephen@networkplumber.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>
Subject: Re: [PATCH 2/4] netdev queue flow control for TUN
Message-ID: <20250903090723-mutt-send-email-mst@kernel.org>
References: <20250902080957.47265-1-simon.schippers@tu-dortmund.de>
 <20250902080957.47265-3-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902080957.47265-3-simon.schippers@tu-dortmund.de>

On Tue, Sep 02, 2025 at 10:09:55AM +0200, Simon Schippers wrote:
> The netdev queue is stopped in tun_net_xmit after inserting an SKB into
> the ring buffer if the ring buffer became full because of that. If the
> insertion into the ptr_ring fails, the netdev queue is also stopped and
> the SKB is dropped. However, this never happened in my testing. To ensure
> that the ptr_ring change is available to the consumer before the netdev
> queue stop, an smp_wmb() is used.
> 
> Then in tun_ring_recv, the new helper wake_netdev_queue is called in the
> blocking wait queue and after consuming an SKB from the ptr_ring. This
> helper first checks if the netdev queue has stopped. Then with the paired
> smp_rmb() it is known that tun_net_xmit will not produce SKBs anymore.
> With that knowledge, the helper can then wake the netdev queue if there is
> at least a single spare slot in the ptr_ring by calling ptr_ring_spare
> with cnt=1.
> 
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>


Oh you just want to know if produce will succeed?
Kind of a version of peek but for producer?

So all this cuteness of looking at the consumer is actually not necessary,
and bad for cache.

You just want this:


Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
index 551329220e4f..de25fe81dd4e 100644
--- a/include/linux/ptr_ring.h
+++ b/include/linux/ptr_ring.h
@@ -96,6 +96,14 @@ static inline bool ptr_ring_full_bh(struct ptr_ring *r)
 	return ret;
 }
 
+static inline int __ptr_ring_produce_peek(struct ptr_ring *r)
+{
+	if (unlikely(!r->size) || r->queue[r->producer])
+		return -ENOSPC;
+
+	return 0;
+}
+
 /* Note: callers invoking this in a loop must use a compiler barrier,
  * for example cpu_relax(). Callers must hold producer_lock.
  * Callers are responsible for making sure pointer that is being queued
@@ -103,8 +111,10 @@ static inline bool ptr_ring_full_bh(struct ptr_ring *r)
  */
 static inline int __ptr_ring_produce(struct ptr_ring *r, void *ptr)
 {
-	if (unlikely(!r->size) || r->queue[r->producer])
-		return -ENOSPC;
+	int r = __ptr_ring_produce_peek(r);
+
+	if (r)
+		return r;
 
 	/* Make sure the pointer we are storing points to a valid data. */
 	/* Pairs with the dependency ordering in __ptr_ring_consume. */



Add some docs, and call this, then wake.  No?

-- 
MST


