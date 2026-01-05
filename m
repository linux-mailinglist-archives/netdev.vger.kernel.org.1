Return-Path: <netdev+bounces-246922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B39CF2618
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 09:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2E84300105E
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 08:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2CA328B49;
	Mon,  5 Jan 2026 08:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYx6RUs6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HNFt2K4n"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3363327213
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 08:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601411; cv=none; b=JZLSMG5zho5vfXhHOflThSgVdhAa3wAGG9/nwKjHNBpHvcTx6jkXwOTUoqECYay/CCQZrQSsHcvtCqjj8ZYB3OdU6HtWZIpsuU2bnxrLaofN6FOUQfxHa1CscgKQgIsJuaxD3ImW11Gjt+LA1kKm85u4BpbZUMfb3UQdErxIDxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601411; c=relaxed/simple;
	bh=m98JsLLlZnpLuynLg3Syt9uCZ7QvI0/Lv10M2IDOLnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Evpf/Zz3n4pXzAURMXUy9FHweiASfL547vaDXQPC38I2RI8c8MlMOUEvbQPhTp5Hv4ZlXrlDP8nxurKuU/0nqEfJl7DO6+xzXahUx8/apvYqN6HVSs9OS77nKGbjR8Nas6/NNbqum/7XW18gSaj6BHg7o3nll2OAdvQMNtthq6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cYx6RUs6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HNFt2K4n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767601408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I9g6na9OJuiciu3rQw6J7JsbFxwpCGTH1jubl50jggg=;
	b=cYx6RUs6goTCeNY6aVjYx4YQS+ptNWYGgTbCMRXb5PRiY2lkA1apxrYhN0AxiumV7LBBBx
	FmJcuAkjj68Rrek1YWBGWyn+h/uK9jApFFWVtLwi6OLNalnuM3UW6EYKXmtWaCokZXoNDf
	Di1SYtL7U0HIk1/BBsvLv38zbHZtl+I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-1KdtYD7oNv-zjidfAJVF-A-1; Mon, 05 Jan 2026 03:23:27 -0500
X-MC-Unique: 1KdtYD7oNv-zjidfAJVF-A-1
X-Mimecast-MFC-AGG-ID: 1KdtYD7oNv-zjidfAJVF-A_1767601406
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477cf25ceccso146967655e9.0
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 00:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767601406; x=1768206206; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I9g6na9OJuiciu3rQw6J7JsbFxwpCGTH1jubl50jggg=;
        b=HNFt2K4nrKwtmV5zxL9p1IDWtYF6/CRC55HJdhLX6m3fggaCCbMmekZDKVQeGoSITW
         RZZgbEGUcgdzte4iaGro3BeuE0f77uJN9NyA8u5GtVYMabjpU+1BX3VFPthMgKY5WqaA
         lgIg880J3bPrGGeXDaTu7uxcjT55B6xlWG0BgjSQuQiHROeKazcumFp1r1J1O5O8K7sF
         0jOXhX4tytfpcSJjWoSK1vKehMyplHa4NJ4RsoPN2fhXS8AiOehW+KOCcZkBVWeQ3iMb
         86CMUlvBfaedLWcxKcEEUvjEb5CgXx9M95W6GgTz50qJ8vaUwJXnr6cM4sHTdH2HFzbl
         3pow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767601406; x=1768206206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I9g6na9OJuiciu3rQw6J7JsbFxwpCGTH1jubl50jggg=;
        b=LytFjUtc4Njh4i/LUc4SyL6bvuiW092+K3flUUbj/SZKnlBBo4CfzVPXWu9R+mNnKs
         DQ9KPwpaIV7Odqe9eSJYoyJdtL/p4nRUx4hWwQBt8lv9UK/YDh2piBCHmACKy2fGB2Fv
         QEHDWFBWVNy8jKpldU7uUK4v1KrHG21yXhcMkWokItrh7UTV5REi7gLQ3EgXRC+N+TDD
         i55PsEgZulN40c0RRBvBJTCLOEL2LfkUoqu9qJc47RanP3MBB5GtDGX02G+nqaMnByXC
         MGssUMK7WizkLfDbsHqncxU1YPjHmzTZz4RE/pkzj2V5NyfeN3jIF7Xhwg9Sx8xsuPGd
         WqkA==
X-Forwarded-Encrypted: i=1; AJvYcCWt74IzoC6MVD+b3xMVDoHoJPmDToKTsxd9sUmMAoCFEHtRm4fgCIB+J4VobBtvPXrZr8M9V+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YynS4hbJY8xOIXqcbKNrAA4Ej4YSboFFXUcD5DZbBiBZNqPCelS
	cnxm33oUEvvIPQz7MCUZEs+Gq7igQXkkUJ8T3HrlsRU7ENLkLS4tPfPEvKFSP8u3B2l+E9T/BcF
	NZoJRGcRE5zUU5L6rol2Yt8bl310u82woNA/wGAqpIUxunqRUZV4MsL0R2Q==
X-Gm-Gg: AY/fxX6opGZDv4G+WVS0uOT1lJAW9pfNbGWjUIzzPPy2aboxF0+sUaQxyCqi/vLRe9H
	dGuCxndmPTx3sbYgBXJT8voa//ToeOeOojKfKGr+nyE2UdbrU6ZnGxHWCTMZkaMmsXIIUHxFw3N
	k3MbMUfI0C/Obf8f/JNqTob51ZAhgA3fcs+e8gqidr5xzVpEKyB42VxPWsI87DpvCYmBfC8WEm6
	juCJoMwJD4HOLal2cReAAe8KYMyrkJkxWVAFe36nCuzRhuNbeoYwINAwJe1gxecMdg8XOdhkV3+
	utRSwA/CYJKMmTxl/XxuWU8P1HL11CJofN8TzAYZNGP4ySam1AimlqDei0/B4ki/O/hRWVLOAh9
	YiX5gUb1LSBnd2MUdjpffGMJH6WujW7HSiw==
X-Received: by 2002:a05:600c:4446:b0:475:e007:bae0 with SMTP id 5b1f17b1804b1-47d1956f896mr633168425e9.16.1767601405655;
        Mon, 05 Jan 2026 00:23:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGv7DIcbBq1VkvqQ23EJm44n2GxyGgRTRuTvRGBj8avn63Zc8/z+R9wImAFB24DC8Gpann5cw==
X-Received: by 2002:a05:600c:4446:b0:475:e007:bae0 with SMTP id 5b1f17b1804b1-47d1956f896mr633168065e9.16.1767601405201;
        Mon, 05 Jan 2026 00:23:25 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6c08f56dsm51171265e9.9.2026.01.05.00.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 00:23:24 -0800 (PST)
Date: Mon, 5 Jan 2026 03:23:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Petr Tesarik <ptesarik@suse.com>,
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 08/15] vsock/virtio: use virtqueue_add_inbuf_cache_clean
 for events
Message-ID: <4b5bf63a7ebb782d87f643466b3669df567c9fe1.1767601130.git.mst@redhat.com>
References: <cover.1767601130.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1767601130.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

The event_list array contains 8 small (4-byte) events that share
cachelines with each other. When CONFIG_DMA_API_DEBUG is enabled,
this can trigger warnings about overlapping DMA mappings within
the same cacheline.

The previous patch isolated event_list in its own cache lines
so the warnings are spurious.

Use virtqueue_add_inbuf_cache_clean() to indicate that the CPU does not
write into these fields, suppressing the warnings.

Reported-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vmw_vsock/virtio_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index bb94baadfd8b..ef983c36cb66 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -392,7 +392,7 @@ static int virtio_vsock_event_fill_one(struct virtio_vsock *vsock,
 
 	sg_init_one(&sg, event, sizeof(*event));
 
-	return virtqueue_add_inbuf(vq, &sg, 1, event, GFP_KERNEL);
+	return virtqueue_add_inbuf_cache_clean(vq, &sg, 1, event, GFP_KERNEL);
 }
 
 /* event_lock must be held */
-- 
MST


