Return-Path: <netdev+bounces-236447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CAAC3C674
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 17:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B076B189B6E1
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 16:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7790351FD8;
	Thu,  6 Nov 2025 16:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ix/2r17g";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iKsVSt5N"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB6E3546E3
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 16:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445859; cv=none; b=eQhjKmhN0dUmip15yzn3SxiSKX6m5usciVZH48roWEjurKVSLdiRXFQq+ZhNc7U41r4gUVljNpE1coQSzcJp4evdyrAiIa+lLO7doVxJcbM+Hx2bmTnx3Su1C5U8CQuLd5mrdGD4v3EoDD6+hq/awMPtv8mvRVoRhRz9vmlLSog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445859; c=relaxed/simple;
	bh=GtjRPF6DweArbtHMO2aemgxvXl0n5TLyq2tqJNlhivM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgCnOlBuAz2gpWSZLq47BC+aib393asTv6aNl0xqaWPpRAYXRc/HxdP5qq8SJ+NXRU8y3xB/1lwd8NM7LaSWUCawcEY1LmcPzK7GC6o3z1O5YLRV3co9nQwJmyLqN9lymF8CO2mFKIg77pek6VvjmMeMAYaf8jsCPeTNQQNRd6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ix/2r17g; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iKsVSt5N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762445856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HE8pWaDjxM5gntEvWaYK9FfKJ/5DWKgS7aJeLXUwhc8=;
	b=ix/2r17gJms8V7x6nW+8jgYUN8hn5qUrg0UQHbCezJ2Zhn/7OoBXKdBdW/NBv4xV2V2JXS
	II6PzZ4u/eUfoY6xZLjVt22P9Utcv4sE9KIklUGF6OL8uUc7BwxXEuYvM9jbzi11D+YvQw
	GlMhXsnc4+2UO0ibt80RHOKj4xD2vlw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-Cw6GNpj9ODy6F99r-6N3VA-1; Thu, 06 Nov 2025 11:17:35 -0500
X-MC-Unique: Cw6GNpj9ODy6F99r-6N3VA-1
X-Mimecast-MFC-AGG-ID: Cw6GNpj9ODy6F99r-6N3VA_1762445854
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4775e00b16fso9069125e9.2
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 08:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762445854; x=1763050654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HE8pWaDjxM5gntEvWaYK9FfKJ/5DWKgS7aJeLXUwhc8=;
        b=iKsVSt5Npxh8mfVnPOCQP/U7IHNG73lzYNn5N4BKAHCbGQmx7nrWVsQ6UF3EJ0xQMb
         7SOdi24OrFPjfVgAaH8kcMdVFCoybqVrZ6feGpBiWYFYFeb+ZSeGSwFeblXBxwa1lSQ+
         7KBlTHkdsUqZqBT0tHk+vcVltBbulxH9SGqLCml5Y4FSFRRfbxaFCgothSO8PnPRniq5
         RnuwtTah23BxLYiDLHJu0Zw+0/axKNPJtjkUETBRJ1qhhglw6WQ4QBf4FFEoKdPlsWZg
         J/sFKu1GmtVmJIlg7OmKM0KeuArcPxgrTRh+HU0I2J9/tWqj/vTBzt5Le3bnhfMtc7Rr
         9tFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762445854; x=1763050654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HE8pWaDjxM5gntEvWaYK9FfKJ/5DWKgS7aJeLXUwhc8=;
        b=JyiAj1uVZt1+OSEBdQex99JPcWLL4NUonGt9Tt0XNTB5DcaoaobKCJH/Q0HkeTFxQ2
         ANdoxWJE1WVhP+5YPrGO0Lg698Zil19swR2W5nlK/ltHoiy11HvYQX1OiBE3msGeyJ/l
         86owI37b3mlEQB7yYJFAdp7iJSOk1A7v+8bn7jWWGo2OEV7blwbZ1llAPNlWOWfZffgE
         U1o3bsYV22Wme01j9csSA3RPMbmCvfiXW/8/q/elZdGrrXvlXHTqDEO12dNn/DCvyZj1
         jJH+FU2Cpf6T/eC/m7n0Jtyj1R3h+7l9k7lrTbb/5mv/EjncABoInvjh6eBgXridL/cT
         YK3w==
X-Forwarded-Encrypted: i=1; AJvYcCXAdCUXN1gOeDji9GrJaHUZiBjbFUuxNhSjDPhMaURbOIxN+LCHZzaTPs9NbKmVMxZw/8/h6PI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNJ5teEt07hDW/nPZTy5iniyWq6HWoWfnk8H+l7/MeIrGuZ+Hp
	K2M0BG56aNXlCPcuNmP6pBF4QHA+SZw/6dG7t2YLwXwmGvIvsnvKHv2sSsYP/dyF2Y2Dst2fzrH
	0KbDb1YS+w9Hta7FS/JTdRtt7/4Llhui1hcAJUILjwhpJ4fcAmxetduJXGQ==
X-Gm-Gg: ASbGnctLQ6y3ynjlb1cd2P7rKSwzzh6LnOLdA0IkXBNR2SQrD0CRHGcSDpk+7hrHfjC
	QzzshWzXlruMdcJq+eFlPBGWIUILV5H7KxJEyiMVnsz7mYOLQrsFAvUOr1Z1gN4rLaUPPvdEFMU
	QwWAgP/zhhoHvTBcCOOl1T20DuKCCCTCKPb19N24vzMtRO4cytk8vM36POhst4Qka2t9XFoRFN1
	BG5AFg0REDochuRShvkAoV7iIQR/e2AC1I7BfpDajVgddC8WHyNLqXrpIOMczYBhLcGlo0A8e0N
	cdqtvmNjKeo7FLu8aoGZCLFH+mGIf2Hp1MdzfT6dA9MxwC/PM+tqCkjcvj2qsSg5gXgu99poaVn
	uWQ==
X-Received: by 2002:a05:600c:4ed4:b0:477:63a4:8419 with SMTP id 5b1f17b1804b1-47763a48438mr23006185e9.12.1762445854305;
        Thu, 06 Nov 2025 08:17:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIyTOWs4nIR7QeOKb8n83iy6iz/GaHMuA92Bwhg2oq7+DwP0ugN/AgSAqGuvWOvF3ICA0YJw==
X-Received: by 2002:a05:600c:4ed4:b0:477:63a4:8419 with SMTP id 5b1f17b1804b1-47763a48438mr23005835e9.12.1762445853789;
        Thu, 06 Nov 2025 08:17:33 -0800 (PST)
Received: from sgarzare-redhat ([78.209.9.120])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477640fba3esm20572515e9.6.2025.11.06.08.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:17:32 -0800 (PST)
Date: Thu, 6 Nov 2025 17:17:27 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v8 03/14] vsock: add netns to vsock skb cb
Message-ID: <q5w5y5qomj54k2tzztsy4pz2h2zqkvgfzkysjiv3uguoufrqy7@tfz7dj6cssxf>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
 <20251023-vsock-vmtest-v8-3-dea984d02bb0@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251023-vsock-vmtest-v8-3-dea984d02bb0@meta.com>

On Thu, Oct 23, 2025 at 11:27:42AM -0700, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add a net pointer and net_mode to the vsock skb and helpers for
>getting/setting them. When skbs are received the transport needs a way
>to tell the vsock layer and/or virtio common layer which namespace and
>what namespace mode the packet belongs to. This will be used by those
>upper layers for finding the correct socket object. This patch stashes
>these fields in the skb control buffer.
>
>This extends virtio_vsock_skb_cb to 24 bytes:
>
>struct virtio_vsock_skb_cb {
>	struct net *               net;                  /*     0     8 */
>	enum vsock_net_mode        net_mode;        /*     8     4 */
>	u32                        offset;               /*    12     4 */
>	bool                       reply;                /*    16     1 */
>	bool                       tap_delivered;        /*    17     1 */
>
>	/* size: 24, cachelines: 1, members: 5 */
>	/* padding: 6 */
>	/* last cacheline: 24 bytes */
>};
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v7:
>- rename `orig_net_mode` to `net_mode`
>- update commit message with a more complete explanation of changes
>
>Changes in v5:
>- some diff context change due to rebase to current net-next
>---
> include/linux/virtio_vsock.h | 23 +++++++++++++++++++++++
> 1 file changed, 23 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 87cf4dcac78a..7f334a32133c 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -10,6 +10,8 @@
> #define VIRTIO_VSOCK_SKB_HEADROOM (sizeof(struct virtio_vsock_hdr))
>
> struct virtio_vsock_skb_cb {
>+	struct net *net;
>+	enum vsock_net_mode net_mode;
> 	u32 offset;
> 	bool reply;
> 	bool tap_delivered;
>@@ -130,6 +132,27 @@ static inline size_t virtio_vsock_skb_len(struct sk_buff *skb)
> 	return (size_t)(skb_end_pointer(skb) - skb->head);
> }
>
>+static inline struct net *virtio_vsock_skb_net(struct sk_buff *skb)
>+{
>+	return VIRTIO_VSOCK_SKB_CB(skb)->net;
>+}
>+
>+static inline void virtio_vsock_skb_set_net(struct sk_buff *skb, struct net *net)
>+{
>+	VIRTIO_VSOCK_SKB_CB(skb)->net = net;
>+}
>+
>+static inline enum vsock_net_mode virtio_vsock_skb_net_mode(struct sk_buff *skb)
>+{
>+	return VIRTIO_VSOCK_SKB_CB(skb)->net_mode;
>+}
>+
>+static inline void virtio_vsock_skb_set_net_mode(struct sk_buff *skb,
>+						      enum vsock_net_mode net_mode)
>+{
>+	VIRTIO_VSOCK_SKB_CB(skb)->net_mode = net_mode;
>+}
>+
> /* Dimension the RX SKB so that the entire thing fits exactly into
>  * a single 4KiB page. This avoids wasting memory due to alloc_skb()
>  * rounding up to the next page order and also means that we
>
>-- 
>2.47.3
>


