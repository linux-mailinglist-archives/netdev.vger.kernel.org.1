Return-Path: <netdev+bounces-207048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 649B2B05743
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 11:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8A4F7A9E69
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 09:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6CA2D12E9;
	Tue, 15 Jul 2025 09:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qj1Shhzr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D35213E7A
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 09:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573483; cv=none; b=WEGhYX7bb9QWYCcxf7DFBBZDHM4yItIVwI6wU8iftl0Zm9P2F/zlObNBqKIGEAclAD1TksLD/vZdUYsFmY9AUFQq47GmJY1I2SOuB8wlyItUqWnGTwhrMB7GE3+RQFtMur7gQMv/ecHczYqEhUIUIpLvXsKZvQq1ADHm0mwFvD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573483; c=relaxed/simple;
	bh=KB31fWp1xQrgG040Mlf2ElwUzGbs6A/75GH2CHRZv9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1qPOZkbpyKa3nF+MBcl3bG36M/AggDvEKbU6+2U0EGiZrXxeLkNw/kbMc58KoVdUpS4Q062fJz6/RhHNxjpfkA4XPB/eCMMMoYtIoYZCDArtD13hgvt2HhwFTMsVC9gV1Av27VpohfzcQhCRvUq4EMp8GxctmdVEfY79/gGsjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qj1Shhzr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752573481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z1VeWdPuiBqILm73rm3vCe0GB4AUiqLL2VU0aM8SPXo=;
	b=Qj1Shhzr/lGPq0mEQEgxP9bCRdCTFp0s3RDyuD7gH9yQ6iqwk9u52ShVQ6A97DzTIIUUdr
	E5A4Q8yx+MSDwZMX3ElwaqNIiyo0KeMKYV+eXd4S91Vj1Svt/hfENnWg8hBcGZnn7yyGE3
	fCAwb8QyCA9ydR+525qs06YC2dvaWOg=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-IbrLdj2xNSu9ci96dc2qXw-1; Tue, 15 Jul 2025 05:57:59 -0400
X-MC-Unique: IbrLdj2xNSu9ci96dc2qXw-1
X-Mimecast-MFC-AGG-ID: IbrLdj2xNSu9ci96dc2qXw_1752573478
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-748f30d56d1so2345724b3a.3
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 02:57:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752573478; x=1753178278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1VeWdPuiBqILm73rm3vCe0GB4AUiqLL2VU0aM8SPXo=;
        b=D/dxEeB01oLmbt2eh+rHhC51fICMDw0S42SWNq2e7EjmOVvc3Fs4i8aWOTK/SOxtrp
         O6Y04Eq3phyu/lX3bjlrA8Si9r+AGu8aD9OIvddJghhRvT9PVBJ4+RBl0tLy9pv3gbfq
         VBBSxifdbXl+3lG4uhA5iwu9NHKy3CSDjr4NtG3NieJI/qfYl2v5P4XKgZl5McFCMc7e
         GNGkImn/O+hqwQ1sXTQ9qjLIzn3P71p4z7lvMlu9Z3+pHQaJYkiUODEdfEb2jDzAqrwZ
         eDrsmWngkF0uW8b61zR6FamvuoawdtfVOxYBMQGKQEYW6rhRLYpFey18E7vnUsaQFiY+
         MD+g==
X-Forwarded-Encrypted: i=1; AJvYcCU6nZwx1ZkJUasV7sXjZN+QBW2YuoXWvL3GpDD53CKdlJS5Urk8meRXK5PlYarkGfGThuB1xIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT3xZBaJkgKHy7dI326jTVK9BURikzuZP6vtA6nupGmNqZiX8m
	W0Y9uceTFtq37iXNHQEvi2nufj0D47ezg+md9AWAY5et2/+8id9TvDUYkLdmIqHnHlJkCQGUKNR
	fJej/S8Q9SOQnV/biLWyO0NzW0dA1CkLiULYdYgufWMMmEzem9tds1PQMh5KiWSJbTQ==
X-Gm-Gg: ASbGncvgLLASTvcYE8YKcWf9CpFgGuvTD0zZ2OR3hx3AZDdQZpE7Xuxh+QHwVhlI1mE
	gPzEfaLybwoTEJasboAa/iTtoyfHDoDcFHNHqmxe4BGfYOa8f8f4m4cNffIhxn0VOxH+8MEiXEA
	mKK07dk/bQ2KVlyZuTk+CRonDybrq/BykL0Pv0Bm3R0f44zHE+E1sLKEoH9wSycNIyPb+m6ftny
	L0kRG6MfEyx01hUmK/UoOBSIO9FppYCvhmfHKsj69axWESy0mvZjPpp+6V4ogCpawbS/xq73mL1
	m3iQzOASsr6XIfTKc+I1i1UzdsuBMifHR1ZIBG/jQQ==
X-Received: by 2002:a05:6a20:914e:b0:21f:4ecc:11ab with SMTP id adf61e73a8af0-2317dbd4f1dmr22897058637.9.1752573478211;
        Tue, 15 Jul 2025 02:57:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWQGcFR1RyTALwdsG+0AcGsG1+kH2rVM1KjDsLtN/xS5dDJPTTql59MnYtr/kxTQlIq0P5Iw==
X-Received: by 2002:a05:6a20:914e:b0:21f:4ecc:11ab with SMTP id adf61e73a8af0-2317dbd4f1dmr22897034637.9.1752573477769;
        Tue, 15 Jul 2025 02:57:57 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.142.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e064a9sm11751862b3a.47.2025.07.15.02.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 02:57:56 -0700 (PDT)
Date: Tue, 15 Jul 2025 11:57:50 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v3 6/9] vsock/virtio: Move SKB allocation lower-bound
 check to callers
Message-ID: <kcntvqjud6wixfoq6w2heqqdblurjigzaasz7333fsd2p22vai@ettf5254doz5>
References: <20250714152103.6949-1-will@kernel.org>
 <20250714152103.6949-7-will@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250714152103.6949-7-will@kernel.org>

On Mon, Jul 14, 2025 at 04:21:00PM +0100, Will Deacon wrote:
>virtio_vsock_alloc_linear_skb() checks that the requested size is at
>least big enough for the packet header (VIRTIO_VSOCK_SKB_HEADROOM).
>
>Of the three callers of virtio_vsock_alloc_linear_skb(), only
>vhost_vsock_alloc_skb() can potentially pass a packet smaller than the
>header size and, as it already has a check against the maximum packet
>size, extend its bounds checking to consider the minimum packet size
>and remove the check from virtio_vsock_alloc_linear_skb().
>
>Signed-off-by: Will Deacon <will@kernel.org>
>---
> drivers/vhost/vsock.c        | 3 ++-
> include/linux/virtio_vsock.h | 3 ---
> 2 files changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 1ad96613680e..24b7547b05a6 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -344,7 +344,8 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
>
> 	len = iov_length(vq->iov, out);
>
>-	if (len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
>+	if (len < VIRTIO_VSOCK_SKB_HEADROOM ||
>+	    len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
> 		return NULL;
>
> 	/* len contains both payload and hdr */
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 4504ea29ff82..36dd0cd55368 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -57,9 +57,6 @@ virtio_vsock_alloc_linear_skb(unsigned int size, gfp_t mask)
> {
> 	struct sk_buff *skb;
>
>-	if (size < VIRTIO_VSOCK_SKB_HEADROOM)
>-		return NULL;
>-
> 	skb = alloc_skb(size, mask);
> 	if (!skb)
> 		return NULL;
>-- 
>2.50.0.727.gbf7dc18ff4-goog
>


