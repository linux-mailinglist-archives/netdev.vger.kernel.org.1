Return-Path: <netdev+bounces-207047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EA5B05740
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 11:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E7BE3B1A7F
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 09:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31892D5C76;
	Tue, 15 Jul 2025 09:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I23m+c+8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1056E1E487
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 09:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573424; cv=none; b=nel3xYvnA2Glm0fZbl7nqemHAdlBRff7wuEY10ZwoB4E2258iHvnqtenWr+reif7lPdKUJwYcJGF+tO06GAuBuObSBbO/9bWKySasbTHUiaf4hLra9sEeaqtEeQ9TjrGVGNKa1LifeLQTWUZFauS6vFHB27WhOWKbTna8iI2ryU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573424; c=relaxed/simple;
	bh=GTkmoLyiu/GJjZVIYcBGrKULeDnljvGjgDN6z5K2onc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWFGZnOh5HUx9EisH9bM/7NtRKkdYx1HA0ViNYVRDwfxz/+65qjfDXQQJdvJouOz5wRklSYyxeHi5HfO2x8JD/N8ChMH3AedPzesVQsp8GwoTJ+7eTx+sgwysU1+8Wm3Siju/vv7lI1vnP++HaTv7vZFZdMLVQExo23FgxHoXpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I23m+c+8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752573421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EsjnNQfJ6mAkewo+n/SUTwvK6JE8ja4wWBuZ4cMAwJg=;
	b=I23m+c+8auFF5rSk1320BbC06+VAmej9oTF0UDHg0yaVWWMw8ZAPq1CDyoJn+av+bJFeFc
	CGal+8RjOSBDnwaauSzyNWHirmfzcHMAg5uG8yqHw82W6ioRsvb7zQ6VT6vc/yQkCtsHQ5
	C5V8554VBh++T8fRwTwov3rzbYXVqFc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-k2NOtU_dMyadf0XE7F1HKA-1; Tue, 15 Jul 2025 05:56:59 -0400
X-MC-Unique: k2NOtU_dMyadf0XE7F1HKA-1
X-Mimecast-MFC-AGG-ID: k2NOtU_dMyadf0XE7F1HKA_1752573419
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e271738501so458442085a.1
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 02:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752573419; x=1753178219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EsjnNQfJ6mAkewo+n/SUTwvK6JE8ja4wWBuZ4cMAwJg=;
        b=rJhDKzEAq5b0vr9ntA6I75SWlpqpamMAP8kFIryuoXNPhf+Doa3cr/l6GxglelT2SL
         ZgwXSqgFERQZ02Vw6SnFT48Ia55RBvD2pLnnyQK24Zuyq2Zn33Hrew+TfxcLKN7IsjVz
         Z8zn1qo840AHVDSDROVp2ELTdXa3/MOVzYmkwyHl1r1JXx4QDQ5fNcol/b3C6fLws4Bj
         2j6FfFReiS0Sfq/WutRjeat/Uf+59GJ7Cp46NgxKqyyjFJEiCWGJolgwHf+S11d42JDE
         sHuVbLSMUN7Dae4LESCm2XoFgjVGJMbP6haS2z8FkN2iPngf0640pcVV0iFLAp2q/xnu
         RwXA==
X-Forwarded-Encrypted: i=1; AJvYcCVTopXU0VdKxFDEyUVxv6IJiuZVNehzobSTKsr3QXoJUV8m6E4QKasg0fMo6Cy0jtFhevJCVfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBxn8WvsibR77q4pi0fxRPSWln8iJfbc6peXvJvxmdHHugLi9q
	na0w6AemGI+BIQUkQD2HMy3m8f+zk0mynZ6d9y9PNH9/SNleIwfY9SP7HkrLCSh8h8GYQ7MOx4F
	O/jtu35fz/ib3277ar4bzgyiR09B7d/m+euNB9Vx2hFziReeQW5cRHyBscg==
X-Gm-Gg: ASbGnctuSf2vmvOEqJo1FXQ1wIZOsjpTWQaQFBViOl0M8RckRw7AdYSktPG0xRo0Abh
	BSFh8OJ2jsPvvKl05WVeQOOTXqsr6UaJ98diPuPsh64d7/zay+37PUKcxcTRZk22TVVntOCrqGs
	nd3AoMRz7tE2UKifpiQi1SfBKTRo6cZou0I7/3pBY+r9D/HGmgDZM0iyKW64QFHRLP1wR7gYBBJ
	4pkQm5Ck837DkMO7IKdAYKuuO2hG8/dCpNSL0ePWaFCAw+j6YB7DTghT7ANQiMZHFpr/ZoTMFXU
	MIpp+dngQJLTszMLiY2OACmc37UjfEs0Rm1PC6H9xA==
X-Received: by 2002:a05:620a:4544:b0:7d3:8ca0:65c6 with SMTP id af79cd13be357-7ddea60f268mr2162301085a.20.1752573418497;
        Tue, 15 Jul 2025 02:56:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoYyKYcEuilw8G0A/GVrUc5/QquW6KQ2Wasy0gXOfk/DlYj91vAPMPzfdBpSrzjF93b3y3YA==
X-Received: by 2002:a05:620a:4544:b0:7d3:8ca0:65c6 with SMTP id af79cd13be357-7ddea60f268mr2162298885a.20.1752573418062;
        Tue, 15 Jul 2025 02:56:58 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.142.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e1ddbde3ffsm283891485a.76.2025.07.15.02.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 02:56:57 -0700 (PDT)
Date: Tue, 15 Jul 2025 11:56:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v3 5/9] vsock/virtio: Rename virtio_vsock_alloc_skb()
Message-ID: <6vknr2ruy4cu3kdxdt2zcigm3jyex5ntxqbqnxe4cbf2uci247@6opbwa5o6rk3>
References: <20250714152103.6949-1-will@kernel.org>
 <20250714152103.6949-6-will@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250714152103.6949-6-will@kernel.org>

On Mon, Jul 14, 2025 at 04:20:59PM +0100, Will Deacon wrote:
>In preparation for nonlinear allocations for large SKBs, rename
>virtio_vsock_alloc_skb() to virtio_vsock_alloc_linear_skb() to indicate
>that it returns linear SKBs unconditionally and switch all callers over
>to this new interface for now.
>
>No functional change.
>
>Signed-off-by: Will Deacon <will@kernel.org>
>---
> drivers/vhost/vsock.c                   | 2 +-
> include/linux/virtio_vsock.h            | 3 ++-
> net/vmw_vsock/virtio_transport.c        | 2 +-
> net/vmw_vsock/virtio_transport_common.c | 2 +-
> 4 files changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 4c4a642945eb..1ad96613680e 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -348,7 +348,7 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
> 		return NULL;
>
> 	/* len contains both payload and hdr */
>-	skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
>+	skb = virtio_vsock_alloc_linear_skb(len, GFP_KERNEL);
> 	if (!skb)
> 		return NULL;
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 879f1dfa7d3a..4504ea29ff82 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -52,7 +52,8 @@ static inline void virtio_vsock_skb_rx_put(struct sk_buff *skb, u32 len)
> 	skb_put(skb, len);
> }
>
>-static inline struct sk_buff *virtio_vsock_alloc_skb(unsigned int size, gfp_t mask)
>+static inline struct sk_buff *
>+virtio_vsock_alloc_linear_skb(unsigned int size, gfp_t mask)
> {
> 	struct sk_buff *skb;
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 5416214ae666..c983fd62e37a 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -316,7 +316,7 @@ static void virtio_vsock_rx_fill(struct virtio_vsock *vsock)
> 	vq = vsock->vqs[VSOCK_VQ_RX];
>
> 	do {
>-		skb = virtio_vsock_alloc_skb(total_len, GFP_KERNEL);
>+		skb = virtio_vsock_alloc_linear_skb(total_len, GFP_KERNEL);
> 		if (!skb)
> 			break;
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 1b5d9896edae..c9eb7f7ac00d 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -261,7 +261,7 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
> 	if (!zcopy)
> 		skb_len += payload_len;
>
>-	skb = virtio_vsock_alloc_skb(skb_len, GFP_KERNEL);
>+	skb = virtio_vsock_alloc_linear_skb(skb_len, GFP_KERNEL);
> 	if (!skb)
> 		return NULL;
>
>-- 
>2.50.0.727.gbf7dc18ff4-goog
>


