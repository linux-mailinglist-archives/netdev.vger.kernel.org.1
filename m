Return-Path: <netdev+bounces-201877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A60AEB52C
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 12:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 286763A5C65
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 10:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B034D293C51;
	Fri, 27 Jun 2025 10:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G8kyI+Gm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1297E264A83
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 10:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751020624; cv=none; b=MstiVibY2jSbILbWT48xb04rAEXpTegZwHbdqnH/sXg/ztHfKEm2czr0EcUh4PVmzoPLK0op+x6hrhkh8bFSRMa7A9jDI3fJtI/UDMKshB4kW40q9QqUiUOsjvsmuPWxLtHTUEMi3vU5zFKy7GKpKpab9MHZWtkfvpcI/OaWbc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751020624; c=relaxed/simple;
	bh=PftrHSJSMYZ7m6RfvegnAyP7tt3C2p8CyLScg97a/jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLrz1PLnikrQcNtTA6fle0H7/zEGQYlT04VAgEvsUysy9p2xa9s8bIBDTAabwr4ggsJ035+iAom+o9IBtrv8M73BwyQ60ldpfM1zYY1bVXTICnAjdb70MkAuHr4Oi+qpqN5m6t5IpZRSbELulSNgWCmobQhjAFRushMmq4Ag6Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G8kyI+Gm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751020621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xM08rJUXb05AQG4eXstXXPFP8RjwRrIPi+WmNXcJ64I=;
	b=G8kyI+GmNQn9bQGPAAM4zkejLir4dd89djKd9yZJmx0nopOjJEYDFsm3hN8cfQghD/85YX
	fh33jsEhn5ktKUXuWjbaZMvqwgrHloSYUBOAyht0H0+Gph7cZLKx4bIbZk9pHHisB/EBe4
	LXHertnkCQ3Ifb0+J4HwsqpBnnhsdpE=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-ySD8J0sTMYO-V0ART-fFMg-1; Fri, 27 Jun 2025 06:37:00 -0400
X-MC-Unique: ySD8J0sTMYO-V0ART-fFMg-1
X-Mimecast-MFC-AGG-ID: ySD8J0sTMYO-V0ART-fFMg_1751020619
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b31bc3128fcso2569526a12.0
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 03:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751020619; x=1751625419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xM08rJUXb05AQG4eXstXXPFP8RjwRrIPi+WmNXcJ64I=;
        b=VeTegPe5tlJAspBCzxWrU51qw02s2Tncq+dQbN/Fi6PydJdQAlh4GLbAhpoE/3ZDB5
         6aVUlezBkUEiOsGz5lwA6rk1VY+OG+9r7nZefedKI3a/n/zO/AW/y8YEYrHVyXDecIwL
         nd/rp9q23FUujMZ9Xq+2ecM6148NHlUPWlChHO33Mcv8eaYJXexQxJNINF6JPo7DRZa5
         wKIwmN1/ZyultV9VECxrtSkTLslB5K7z3t/gRYAQkafqrOS9mb4RIq+16Vu9vj6PB62J
         LIzJgyIwjt0xU5qOQZRwPVu0tkcY7+QG8+6+lZQzLazLqlsT+k17IbTrOVkvvrugPI/a
         ahhA==
X-Forwarded-Encrypted: i=1; AJvYcCUFPhari3zVtrMWAXf8J26tDznh2YH6s2mo9UPr2bD/x9qee5baz/KwllpOWEtJx43dCynBHh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfM5l+e5Oemf4ue87GJVz4eDaG33wB4i38PAPDh4atq65Rb5z2
	Sbxw9wrS57UXOh+qOv42b+8z/hIJyf86yCXL8OJf5/CXsyWqw2CkGkQ3gj2fWZbyFdxQjwOB1iO
	AU42VBuyIHNn4apk+UZahSSl58Q0ApU45wEx+jsjOcPH8gCOyZXXYKlIC8Q==
X-Gm-Gg: ASbGncs1WBqXH9mBTPkbnp1oNMCJaK5To2nkd08ruWhUey6kxBaHBw6zQE7D99LGQzO
	2V3JljBbC83lAnMYxgIznRYUsEjfJi2nccY3WX4j5tx7xe84jEog/VFKCnjRQ61Ao5Kwy0XsiVS
	m49VlI12SJUVlp6oHjOKNbhTOIK4vdmnCSLcKnaNOkVU9XSUd+MKWfHInVzPKyQGuUUL0ActWGg
	SWjOwup0x+cnhpZedmPINF4wRroT2ybRB2hA7qVDj0xNIvAhy8igvTbX/Eg3yxfJjJou3rWkFDH
	GOMZZigpxAG8kMHNfojY+zon7kM=
X-Received: by 2002:a17:90b:54d0:b0:311:f99e:7f4b with SMTP id 98e67ed59e1d1-318c926568dmr3705116a91.28.1751020619068;
        Fri, 27 Jun 2025 03:36:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2NSMNCRnsJPJF7ZAu3FfPcP3Jvs8X5CeYQn6CTkxq0SuisV7Qqhbya1ObUs6rSXJylkxq5w==
X-Received: by 2002:a17:90b:54d0:b0:311:f99e:7f4b with SMTP id 98e67ed59e1d1-318c926568dmr3705073a91.28.1751020618513;
        Fri, 27 Jun 2025 03:36:58 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.150.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-318c14e1f8fsm2013391a91.24.2025.06.27.03.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 03:36:58 -0700 (PDT)
Date: Fri, 27 Jun 2025 12:36:46 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH 1/5] vhost/vsock: Avoid allocating arbitrarily-sized SKBs
Message-ID: <7byn5byoqlpcebhahnkpln3o2w2es2ae3jpzocffkni3mfhcd5@b5hfo66jn64o>
References: <20250625131543.5155-1-will@kernel.org>
 <20250625131543.5155-2-will@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250625131543.5155-2-will@kernel.org>

On Wed, Jun 25, 2025 at 02:15:39PM +0100, Will Deacon wrote:
>vhost_vsock_alloc_skb() returns NULL for packets advertising a length
>larger than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE in the packet header. However,
>this is only checked once the SKB has been allocated and, if the length
>in the packet header is zero, the SKB may not be freed immediately.
>
>Hoist the size check before the SKB allocation so that an iovec larger
>than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + the header size is rejected
>outright. The subsequent check on the length field in the header can
>then simply check that the allocated SKB is indeed large enough to hold
>the packet.

LGTM, but should we consider this as stable material adding a Fixes tag?

Thanks,
Stefano

>
>Signed-off-by: Will Deacon <will@kernel.org>
>---
> drivers/vhost/vsock.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 802153e23073..66a0f060770e 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -344,6 +344,9 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
>
> 	len = iov_length(vq->iov, out);
>
>+	if (len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
>+		return NULL;
>+
> 	/* len contains both payload and hdr */
> 	skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
> 	if (!skb)
>@@ -367,8 +370,7 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
> 		return skb;
>
> 	/* The pkt is too big or the length in the header is invalid */
>-	if (payload_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE ||
>-	    payload_len + sizeof(*hdr) > len) {
>+	if (payload_len + sizeof(*hdr) > len) {
> 		kfree_skb(skb);
> 		return NULL;
> 	}
>-- 
>2.50.0.714.g196bf9f422-goog
>
>


