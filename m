Return-Path: <netdev+bounces-207041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF94B056FF
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 11:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31874188F64A
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 09:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403A72D4B47;
	Tue, 15 Jul 2025 09:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fAJGalPM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9085A2561AE
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 09:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572849; cv=none; b=sKLBzWEABGEd4wOvkIAlaYNzxLv7hxuvNzeRuUjQK8FJnzTa7LJbqJm2BQHiEAX0J3FEfYeUwTq5uLwsTsXD7j7muL7UKllDlOEgR+o6d6LvpIg3h4GrK0L7n1vVHkZaFWEVE0KVO8MXijFYTsdvHT/UuSShF5U/tu5aRiOAOfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572849; c=relaxed/simple;
	bh=9lxLx87i+PuaUy4b5HDvysuGPPM11GdUfv0DuiWleUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IX+AfJCPvewbdDiLc1HojlHd5BL7LxwVKJjpUpGEK46Lrlt7Pg9admrkBqyEI48ZwbbKSBm9rj85xMzeev2wyV3VVX0srwyKuOLcLnPqmABxDWvoBveIibjXdIspOBD8NHdNedMpRJk1RdOojPLzw0BlfPrWBY8VPZJ8Jd4HYrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fAJGalPM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752572846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zv21o4YQGbJUN8noeML7Ss7jbQevDPMoV/ulGUv/mjg=;
	b=fAJGalPMp8/fxmh+/o/ffKqpA1S75GriNZkVLZd0iE9NUdCWCC/9BhQGWr2mTTWhDvBrQ8
	IktmEJ1T0cSQ/AwfBRlKwI5jxNYQi4BKNmLOnRjPo9XQN3LC0tO+zOUBAzipKgVQ3S9LhN
	IL2v5Ydj8MEVn73CIELw2vtWor8TIxU=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-uQthJ4pwNE6QnH2uSdHN-Q-1; Tue, 15 Jul 2025 05:47:24 -0400
X-MC-Unique: uQthJ4pwNE6QnH2uSdHN-Q-1
X-Mimecast-MFC-AGG-ID: uQthJ4pwNE6QnH2uSdHN-Q_1752572843
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2382607509fso31790155ad.3
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 02:47:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752572843; x=1753177643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zv21o4YQGbJUN8noeML7Ss7jbQevDPMoV/ulGUv/mjg=;
        b=Y4FEV2SBYtDydi053qLSwBtfO3mL5E4Gmv3hvfpRtOtktMvQYXHbMPu9BSLXkZOOL0
         dg/v2VjXSsa0+oxiWkkq6sbWc7f8P7niarrYzVhU3Vwc33cWNX58wsttmXuosr2nz4qR
         wrzSCyyUDj8vCxYFHCuXzDiwUKnC+IbaTNPKHuvvqSpn4G0MgYlSmMT0A7X647jDc7je
         T7QxstrBPLGYGklaLqGki5MByQbXP0Kw3oczfXrx3qjVbMxnCCcSyTvqiBKoGKGahaNG
         +L+Tw9XtLKGMKb58Tk494iaMRYhL5dorR5hDYhwDTIFImoytHhO1t3lTui0Hm1DJeiLF
         g1/w==
X-Forwarded-Encrypted: i=1; AJvYcCXA9mO01n5kowPJCRrEv0V9ro8ataDGYRgmCuPesZJ1RJ4gLcQLO26LyQFEuHqDJ8EZ/Ql4iFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM2XT282WaUq/RDsUplAloD1j8wlH2VeR03RsvN9rdtZfC0hpj
	MNxWvgyj7BACDjNmloUWBQC4jym/hHtsCyZYhrHTZccunWjdumHWIAX9CWpHsd0hqOkckvLxfIP
	//DyKTzxgAxOmwsjh5raAjk6+89HIy9QBf9s6iedm0SiyGW3+IHngMlecPA==
X-Gm-Gg: ASbGncvDnIXlhBH9+rLX+cqa3FqpkLlvTY3DyoGELyxKgQUvBOw9j2eXv5zEUqvvgGO
	E3C+On9T01I7IUUQaZWiEBWDluUKrGA5sDNO1f2Y8qkdVhD/aORs+1+DynrkFPYKJeHH+AbBzAy
	/eQKIGuT6DoUPk4xxkhQoTE4l/3v5sqsrUU7bG5JyJwJyx1BKqdRhoq4P4o1lxHyHXgcHhUrGFU
	j4+fFJm5YScJdvsPk76nd5R33q4yXvSMQ8Br0Mq96P1LZ8FUkgQ+YPgTCJFcMx58TfhWM2Ii79t
	sQczWVpID7/HNs/Ff8gdLvCg3AcVq20Q9gyqfjNj1g==
X-Received: by 2002:a17:903:8c3:b0:235:f45f:ed49 with SMTP id d9443c01a7336-23e1b170830mr31658675ad.33.1752572842977;
        Tue, 15 Jul 2025 02:47:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFw6Q76ji3E4T0X070GuEwtmCWmxMCF8YU2BHFI5N2HYUKvQ3kiM+lmllOTIzW1Yz+SYAp4Q==
X-Received: by 2002:a17:903:8c3:b0:235:f45f:ed49 with SMTP id d9443c01a7336-23e1b170830mr31658265ad.33.1752572842509;
        Tue, 15 Jul 2025 02:47:22 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.142.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42b3c3fsm113125655ad.88.2025.07.15.02.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 02:47:21 -0700 (PDT)
Date: Tue, 15 Jul 2025 11:47:12 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/9] vhost/vsock: Avoid allocating arbitrarily-sized
 SKBs
Message-ID: <h3zu2fsjvuftgv5gmkluyqipcak47a2koh54idqqfmstos44o5@c4so6ajec72k>
References: <20250714152103.6949-1-will@kernel.org>
 <20250714152103.6949-2-will@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250714152103.6949-2-will@kernel.org>

On Mon, Jul 14, 2025 at 04:20:55PM +0100, Will Deacon wrote:
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
>
>Cc: <stable@vger.kernel.org>
>Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
>Signed-off-by: Will Deacon <will@kernel.org>
>---
> drivers/vhost/vsock.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

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
>2.50.0.727.gbf7dc18ff4-goog
>


