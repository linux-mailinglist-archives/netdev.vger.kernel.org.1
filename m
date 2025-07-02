Return-Path: <netdev+bounces-203434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EE8AF5EE3
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 18:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C32593A56C4
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 16:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896812F509E;
	Wed,  2 Jul 2025 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZNj/P2Fs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8E92F508F
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751474452; cv=none; b=e/qSxeGqXMKV22zhh48o0dJ1BQZOFA2W6/7cODNd3846XhEJHDCB+o7ZW8HUY6WkcmeP66c5lq1yE3R0QdNKwokQnHtxNCQedLTFfCRuTsv8y7O5zBDD92CodkQQilGDourc7NqDJ0ZsAWZ397UfPEnxRC5xB53D0OcS1kg2PDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751474452; c=relaxed/simple;
	bh=3GK1ycy0hQOJv/ORyYe46/AezZlfuxduyUJ3kxm9gpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVLa8+QO+NrQeEdHl0YVN+idYMhSJzgB1PumNbK+op7Q3OsVrFGYjl8JEtCiGIzYUE0pEF9XH3vroy2GXlW/IdobFjNXLEEc0TYNbHJ/WmhLXD0xHY2XrS5VtSCUofXkXjZeOpL4E6JU45pUVRZulZFSRhReeAnf0LxlmWCMCso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZNj/P2Fs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751474449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DxX5SXQow8cTQNbRkntUDQ1P4SHS3PGAaksdc4s5nHk=;
	b=ZNj/P2Fsdu2q4N03nQZkULr0r8K0gmRFBZYkQUpL86QVXLRl5+bFHjZQD4CAXul6IAsKdg
	bmnD7A93BlI8eD8y0HGzhcAmTNG+ZZSo0ZmS1PkFWx7kOLgToBJ3kVPBIHfaPupfV6jfDa
	ITW0SktSFscyZnNg8pSWBikjQ+guJkc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-vAefwfNfPzGuV34obqvxzg-1; Wed, 02 Jul 2025 12:40:48 -0400
X-MC-Unique: vAefwfNfPzGuV34obqvxzg-1
X-Mimecast-MFC-AGG-ID: vAefwfNfPzGuV34obqvxzg_1751474447
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4539b44e7b1so26035035e9.1
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 09:40:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751474447; x=1752079247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxX5SXQow8cTQNbRkntUDQ1P4SHS3PGAaksdc4s5nHk=;
        b=WsFlbysOXV8kRTcljvV3rQ2Wz+EEgJ+dooD2b3I8Zhwkkc6XIbv5Kc5pVRyqbWIqug
         +7RMUDclauYaYjYSTB+DCOr2YDIWv8Gq5e1M/73HGq2cpG+IPJOTyj6BRfENlITkxHij
         HW+r4sDMWKWqIPyU3sE6EQEj5F7nhSZqwjiXItuGPLk30NYBGrs1/wLRWLj+yJc7T73T
         vB/5LL3ex11sMlQDC6N0pnH3nAYtFIVWh5pVK79g8dPJHfvvwOIyT676KA907M76ETJl
         BIQ9X1LBlNEHp5QwjLypzA0RNYfJrICYqmmUxH2AbKqJKmPdartMPPBQGeMdeog1MFi6
         Rmvg==
X-Forwarded-Encrypted: i=1; AJvYcCVOb2khR04t258yggoqzvu9541k/E5hoPzUQIYgq6MlFS0ASN4yj7e7Fh/X9Ddp2oZJqkUDZlk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7h7KCoa1f0ygJFJjdUbcxkz7OT7m8G2PKOwJeeWPJv3c4TKOH
	ljGB5K0pJ6UWXE1sYXIvHm0gsqdGezpjzmcQBRhfw1QSs7zb2sFIr2qP6CIgPhLib8tf8R1aJbu
	ciyrlxveo0DEmc6ON3rRUrSEQJ2yVO3Z39OsX2JW7sIzFKbaqCy15IQqjUZTUDyvlww==
X-Gm-Gg: ASbGncs8CPBLX4WAk3Bl8Y1+8L20QSN+5GnpuS/Vg0NlKvJyUV/aD3LbljtERezuMyz
	jHP2igkJQtQewg2fDIA7oxIxjeB3bUcibMjgF5ktH7f+czgucgwxyB13cvLm24ANqwpLLZp13/H
	96T6l030Je67oDAaperWvHmrpY7yujXQspm+txlgXDHNLLD+9oG/RBkWkqSEVkAuzeQOXn8y8P2
	eSWub5yJV9YoZM+HPibbPHCMh2eKKqfdbyenUgLE+56bGR6bSokBg2S71J158iPz/iZMZbOWK7H
	VMJhjPhWgHvnmUxmll6YBTwuOD4=
X-Received: by 2002:a05:6000:2dc1:b0:3a4:f6ba:51da with SMTP id ffacd0b85a97d-3b1fea8ef71mr3497625f8f.15.1751474446693;
        Wed, 02 Jul 2025 09:40:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPi3384hIJUmYDYO2pgwjdEGaDjqPoPnERpOL82BtRro5gn96IZO94uo7p9t+UDNHVK/P2qg==
X-Received: by 2002:a05:6000:2dc1:b0:3a4:f6ba:51da with SMTP id ffacd0b85a97d-3b1fea8ef71mr3497589f8f.15.1751474446109;
        Wed, 02 Jul 2025 09:40:46 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.161.84])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e52bbfsm16674212f8f.65.2025.07.02.09.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 09:40:45 -0700 (PDT)
Date: Wed, 2 Jul 2025 18:40:17 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v2 5/8] vsock/virtio: Add vsock helper for linear SKB
 allocation
Message-ID: <vaq3g5wtt657w532itcpdwsvf742cglvuckiqcyueg7y72wtko@yg7swar2xnwh>
References: <20250701164507.14883-1-will@kernel.org>
 <20250701164507.14883-6-will@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250701164507.14883-6-will@kernel.org>

On Tue, Jul 01, 2025 at 05:45:04PM +0100, Will Deacon wrote:
>In preparation for nonlinear allocations for large SKBs, introduce a
>new virtio_vsock_alloc_linear_skb() helper to return linear SKBs
>unconditionally and switch all callers over to this new interface for
>now.
>
>No functional change.
>
>Signed-off-by: Will Deacon <will@kernel.org>
>---
> drivers/vhost/vsock.c                   | 2 +-
> include/linux/virtio_vsock.h            | 6 ++++++
> net/vmw_vsock/virtio_transport.c        | 2 +-
> net/vmw_vsock/virtio_transport_common.c | 2 +-
> 4 files changed, 9 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 66a0f060770e..b13f6be452ba 100644
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
>index 1b5731186095..6d4a933c895a 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -70,6 +70,12 @@ static inline struct sk_buff *virtio_vsock_alloc_skb(unsigned int size, gfp_t ma
> 	return skb;
> }
>
>+static inline struct sk_buff *
>+virtio_vsock_alloc_linear_skb(unsigned int size, gfp_t mask)
>+{
>+	return virtio_vsock_alloc_skb(size, mask);

Why not just renaming virtio_vsock_alloc_skb in this patch?

In that way we are sure when building this patch we don't leave any 
"old" virtio_vsock_alloc_skb() around.

Thanks,
Stefano

>+}
>+
> static inline void
> virtio_vsock_skb_queue_head(struct sk_buff_head *list, struct sk_buff *skb)
> {
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 3daba06ed499..2959db0404ed 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -321,7 +321,7 @@ static void virtio_vsock_rx_fill(struct virtio_vsock *vsock)
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


