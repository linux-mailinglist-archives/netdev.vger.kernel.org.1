Return-Path: <netdev+bounces-214300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB12B28CF5
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 12:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6B21B64BA8
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 10:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D975F293B5C;
	Sat, 16 Aug 2025 10:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UIFnvw7N"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B4C291C31
	for <netdev@vger.kernel.org>; Sat, 16 Aug 2025 10:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755340699; cv=none; b=ZSZfY+BTWBNP4BBfNFcTHta007n66YrYB8lw+r5w4EkNVFVN6SF+1exgOv7byfuFQhdMjB9k5fTcTXZIwFUFi5X//xxe3pI6mhb1M6/szdKLENZNcUtKPGZz+daWaodLFE83nmr8YPlh+ugVXSdcpDjgt1m1bfdoKklFrN3/GKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755340699; c=relaxed/simple;
	bh=ekx8YSOc7g6jM4/k8aaZwSazUxe/M8O4Al5/LfbvT28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyb3efsdFiwx+MUtRie0etM8dmpJwd15GOgCuB6mlnQYwOXQfBTuwVBMV9mLVZNSnlF6YP95yhoPzs3RRdka6WbrnudL1krM0Oh4jKGC6GjgY21CAQjYHppb2Q5zMbcSJxE/XmbqR0GiDQDewqwA/CdEK2dW9rOYCp1ZuBieQko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UIFnvw7N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755340697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WVcBDRwWsttWGK38lVHrVbMK6gqAO5C0KIt3MgVZUK8=;
	b=UIFnvw7NjVftyT0n7odJ2BhaiF0TwR9gI/e5eNeKwb/hPKHc8VavRdh5Rzt6CuQoJdQXFq
	7ze4uNJvPhUTHyYwyb6mJNkeJFJawpkAkpA9JXXrPZX5L7y4mTfjVj14HNdLr8Jzkoq7ZZ
	DtJ4o4Z9ySm+UP0t3XBPf4bMsE9jiKo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-8JGTqqTnNTKxxmCS3NdMbQ-1; Sat, 16 Aug 2025 06:38:15 -0400
X-MC-Unique: 8JGTqqTnNTKxxmCS3NdMbQ-1
X-Mimecast-MFC-AGG-ID: 8JGTqqTnNTKxxmCS3NdMbQ_1755340695
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45a1b05d8d0so15003175e9.1
        for <netdev@vger.kernel.org>; Sat, 16 Aug 2025 03:38:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755340695; x=1755945495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVcBDRwWsttWGK38lVHrVbMK6gqAO5C0KIt3MgVZUK8=;
        b=XS0oGX6j7OijOuG8mFU9SYKb+8zDIShEWygxuSXh+P+LlZaPj3Qlwz02JQUsz2L8jd
         i9Ur5emQUe/8cDKnZEscHVdb96txcLDU4lus5cJwjKYD8x/984HOp5xJwAPCmmkLAswN
         MUsI+coV6Dzpp4SBjmTqw9cgLA3ww6k2VlD34aBbE70ZhUZeaZmceMAdqH+EXe3HS/M/
         3Y632kXMCvx2zgDQ/WN5egmysb6Vs5Zec7lhYoRphO5fpS8w0BBgTAGCmrCjsy9KmqgA
         yfPISa24O7S3y+k1WGVPQ0sXewmcnLdWB/Kq9Pw20pcb2WVq1CFjfl/rD+rLr92HFazH
         J1pg==
X-Forwarded-Encrypted: i=1; AJvYcCV5IKtjgVuV1Kp2dXRX0w1VNOYJ46pFLJI+d7s8xTwXmkGNQidq/CYrHzPOx3Mzrx7qsUIAQzk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz1p2aT83jK5K08en3zWjg8mgrAhT7wRXeAzbae2bmZ/fhFOi7
	d6OROnqknyPQQtUPUn2D7qHP2zZ5bHSDpansBL4KnSCJE2eEEJ6W147O12xaz20QP67vjLMS6dY
	0HgVPWU3Q1hQrBRjvolFJ87bRySjcP8rg2pr25meygPT0Aig2I3CXiiF3LQ==
X-Gm-Gg: ASbGnctnIEbA7CTYNkXDdYLc3N2kxgBpqaJL8dMXN4+hMc/xEOuFXbwWD89UnBo7Auz
	rp3fEuX4IlsLF0z7CtbciIerTV/FnPx1DShhTTPof6QfLfsoK+kCCISGhxbvk1XHcoG5gQy+AT4
	TpEH2DVn1+IHtfddfr6d/QJehSc2WF9ZWMv73AdfLh/OQOZulvE0UAPizrDuvpJWXBXwHFGEIgc
	4AUdkMUIYVk5JK8TW8qDu3nD2RZsKUqlvS9JzO9DwOrOr8yKyq1vUHVbghdLs90g8pnxOMqcOQD
	z8CTn57QDkY6eygOhDNfQ8y0ZBhf6EaJyhY=
X-Received: by 2002:a05:600c:4f53:b0:459:d780:3604 with SMTP id 5b1f17b1804b1-45a24220467mr38335025e9.3.1755340694656;
        Sat, 16 Aug 2025 03:38:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpyVsdecoZjN3XgasLnVr8q4r9q39UzUvK2o47D3rxm95PhfzS+mCEvAW9UWwlVcWzucaPIA==
X-Received: by 2002:a05:600c:4f53:b0:459:d780:3604 with SMTP id 5b1f17b1804b1-45a24220467mr38334835e9.3.1755340694248;
        Sat, 16 Aug 2025 03:38:14 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73cf:b700:6c5c:d9e7:553f:9f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6bd337sm91741855e9.4.2025.08.16.03.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 03:38:13 -0700 (PDT)
Date: Sat, 16 Aug 2025 06:38:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hillf Danton <hdanton@sina.com>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v4 9/9] vsock/virtio: Allocate nonlinear SKBs for
 handling large transmit buffers
Message-ID: <20250816063802-mutt-send-email-mst@kernel.org>
References: <20250717090116.11987-1-will@kernel.org>
 <20250717090116.11987-10-will@kernel.org>
 <20250813132554.4508-1-hdanton@sina.com>
 <20250815120747.4634-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815120747.4634-1-hdanton@sina.com>

On Fri, Aug 15, 2025 at 08:07:46PM +0800, Hillf Danton wrote:
> On Fri, 15 Aug 2025 06:22:56 -0400 "Michael S. Tsirkin" wrote:
> > On Wed, Aug 13, 2025 at 09:25:53PM +0800, Hillf Danton wrote:
> > > On Wed, 13 Aug 2025 04:41:09 -0400 "Michael S. Tsirkin" wrote:
> > > > On Thu, Jul 17, 2025 at 10:01:16AM +0100, Will Deacon wrote:
> > > > > When transmitting a vsock packet, virtio_transport_send_pkt_info() calls
> > > > > virtio_transport_alloc_linear_skb() to allocate and fill SKBs with the
> > > > > transmit data. Unfortunately, these are always linear allocations and
> > > > > can therefore result in significant pressure on kmalloc() considering
> > > > > that the maximum packet size (VIRTIO_VSOCK_MAX_PKT_BUF_SIZE +
> > > > > VIRTIO_VSOCK_SKB_HEADROOM) is a little over 64KiB, resulting in a 128KiB
> > > > > allocation for each packet.
> > > > > 
> > > > > Rework the vsock SKB allocation so that, for sizes with page order
> > > > > greater than PAGE_ALLOC_COSTLY_ORDER, a nonlinear SKB is allocated
> > > > > instead with the packet header in the SKB and the transmit data in the
> > > > > fragments. Note that this affects both the vhost and virtio transports.
> > > > > 
> > > > > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > > > > Signed-off-by: Will Deacon <will@kernel.org>
> > > > 
> > > > So this caused a regression, see syzbot report:
> > > > 
> > > > https://lore.kernel.org/all/689a3d92.050a0220.7f033.00ff.GAE@google.com
> > > > 
> > > > I'm inclined to revert unless we have a fix quickly.
> > > > 
> > > Because recomputing skb len survived the syzbot test [1], Will looks innocent.
> > > 
> > > [1] https://lore.kernel.org/lkml/689c8d08.050a0220.7f033.014a.GAE@google.com/
> > 
> > I'm not sure I follow that patch though. Do you mind submitting
> > with an explanation in the commit log?
> > 
> It is a simple debug patch to test if Will's work is good at least in the
> syzbot scenario, but stil a couple miles away from a patch with the SOB tag.

Oh that makes sense then.


