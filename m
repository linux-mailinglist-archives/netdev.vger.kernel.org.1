Return-Path: <netdev+bounces-246337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F55CE95F6
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 11:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98A10301784B
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 10:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CF72E7F03;
	Tue, 30 Dec 2025 10:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hkow8Crk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="i4RoF07j"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4C32E7BDE
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 10:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767089799; cv=none; b=WVstT8smjEZXNCT+t0yCfy9kEMI2RDnNwkKT29tNH7zzQgQhczJh5Z3IopsVLrWP5OK8C9uVTLMUJL+yfp6gixeXNdWKwoyXOaYAQj6YbuQbXLqWxkx33QazBLSjgpVnFJ/YQqpk6L0q7NrLxbXGKeLKE1zMlZDa1L4Je6WrewI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767089799; c=relaxed/simple;
	bh=ikTC7dMS0j+aOW64LriWXLGZXkKoO1gYmsQNBLOSYxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5WVn/byuyGMFzdagdpC+n4dljNX88VNh9+1wloeYSVR4jPFE8lCQG0saHuipLxssqBDqE3SJiUatTcDsVjDfn1o4YAuO5/DWZi924uZQW/K6cRuaUX22INpAJmhnG9OeOKEfQyD8tbpJ+NQp6/Fy3wq06+yvXAGvovNLI3Cdi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hkow8Crk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=i4RoF07j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767089796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x4agnfRlmC5GgzX5Rd2z2Ldj0cW20QjlA2/E3WP30vs=;
	b=hkow8CrkVcd0/haLmVWfJaO3wPZn9EqzxaBVlJ22Lw+2Cy0U4N5nUG/4UNoaIb8u7vGrKn
	IzHUiIri+MWYH/WXRA58FyNs1m+on2dZyCcpOK59HX7QMvhv9vNtGPhdRGsRbJ8uYiqmes
	Xy7oLS8R2MjBgpjmQsgJMcMhecOFpJo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-Z_7h0p97OWiN9OEF1FU0zg-1; Tue, 30 Dec 2025 05:16:35 -0500
X-MC-Unique: Z_7h0p97OWiN9OEF1FU0zg-1
X-Mimecast-MFC-AGG-ID: Z_7h0p97OWiN9OEF1FU0zg_1767089794
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4792bd2c290so94172635e9.1
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 02:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767089794; x=1767694594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x4agnfRlmC5GgzX5Rd2z2Ldj0cW20QjlA2/E3WP30vs=;
        b=i4RoF07jbiZ9WBc7wJDhu//73X6pQxHb1DqtRSJZsT2eTKQTQoKTjUekZV7lUlwC86
         SAi7JTMipA6B6VaLfUpwhfekUYYlnJzc3vCPjKlkBZRQ7BohHUQczZm+8Cbekj9X8i0r
         Pc5cZkU4g3uzIKARnxfAC0k6ID9y9ce5RoVd+aQ+dDYIqHAuK6U5tqTMjPnd7T1gQMyB
         rR1ZNAZ7DuuGa4AfQXOggLTDQ5LOTQvHnbCxELTxG7/CiVxsZc3O6qpp4gKsvYgaFE7f
         Q+bweP8e9W3rtBvqg0TTbNy+vjrUyx++7R94BPDv6S4+7dPMgkdUvMlmEuRFvTD2nTaT
         Xfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767089794; x=1767694594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4agnfRlmC5GgzX5Rd2z2Ldj0cW20QjlA2/E3WP30vs=;
        b=KLNxvY5s+RHOnMxCQfM1S1oKNPtPwrxV68i8HJSti/fWRu/v8i9yyp3ac5RUUhSUAK
         qdEUhILMbuT7UEa4vpj7TAXDIXbxqwJYkp2EREkfg19tDDZKsL/hpV89JjSe4tQ/utSB
         TbiraLbJjnK61Cc09Vn/3jLKpCj0dPz11AeQ9BBV5Rc1L/atIE6eiAHTXGu4ze+AvuiF
         tKhgzYT238CAPlLs7DoKX2NFWp2vhznFBxm5Jz2TGknEyW2jndDVKxQSwKGEyUNIdydV
         w+qUKA4vF5lsI02p3BRRS/mPvDx7/i8s/TMr3WP5ZQrm0TKh37JTTOGjdd98+Obz9QAZ
         779Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3BVoQzORr0BEXqIwqLvSKbhFbZ5koJoEpR1+O8lpN12vvmn8G5VfxLl2dG7iMhbtbIO72jcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRrYg7tZfNqZ3d7DgWHayGvSMXrh7M+JEUNW8TA6L7wijobnMa
	NsxUSrySO1ttu7rLz0TTz9LHw+uWFoXkZNKnIKMBxHfRQ2V187GBWjKy43kmI+jx0FwRnG+2urc
	5Gf6jvxzd3o/Y/YhkS7tJoGM0PJg6vq/PEMOZVVgsV6RdaECvC1nvu12W4g==
X-Gm-Gg: AY/fxX5mj8as2SnNFIgB+1WwyKUxPNlCgi642y7eYcvCavx+XQwqzlCTpfarihWsre+
	pMxpbxzYWsRGSc/FRz+EYL6AwRPcsaGL5uZo3I7Otd1D+9AqCYymfuYI/5IHmGP6cWSXXAg/8NR
	LyvezV4EBJb+S8alL24UZzZ50N1AJ/0c9vj1EdjQSM62dKHPQtd+iwAQl+sAuG2EmWrsryY6oVn
	1Hio/DnIWPxOZfP93ekQk2LlKOu+7DopDWpocNhP+r67N7YM7dsvlTM9Qr/jqNdlc6qnt3Td14Z
	clHG3cICPFEwZvMtrIMwT1fYhU2RAhphrTZEIbMzqg465s4upo2oDSleuPfbhKP5yHil4k6qnFm
	EMrBZRnWYg8N2o2MTx6VE1x45cQb1QDwA8w==
X-Received: by 2002:a05:600c:8b8c:b0:477:af07:dd1c with SMTP id 5b1f17b1804b1-47d195aaf01mr352317465e9.35.1767089793792;
        Tue, 30 Dec 2025 02:16:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/8/udlvjg5mJuYpI0a3oxpEJUtwKIPq+rFtOrgdem6Ktq8tTHyeQzy9WGlYRf+5N+zum/GQ==
X-Received: by 2002:a05:600c:8b8c:b0:477:af07:dd1c with SMTP id 5b1f17b1804b1-47d195aaf01mr352317095e9.35.1767089793385;
        Tue, 30 Dec 2025 02:16:33 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be27b28a7sm638896415e9.12.2025.12.30.02.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 02:16:33 -0800 (PST)
Date: Tue, 30 Dec 2025 05:16:29 -0500
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
	linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH RFC 13/13] vsock/virtio: reorder fields to reduce struct
 padding
Message-ID: <dc7de7774ae19968549cf17336c15503fa7d10ec.1767089672.git.mst@redhat.com>
References: <cover.1767089672.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1767089672.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

Reorder struct virtio_vsock fields to place the DMA buffer (event_list)
last. This eliminates the need for __dma_from_device_aligned_end padding
after the DMA buffer, since struct tail padding naturally protects it,
making the struct a bit smaller.

Size reduction estimation when ARCH_DMA_MINALIGN=128:
- event_list is 32 bytes
- removing _end saves up to 128-32=96 bytes padding to align next field

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vmw_vsock/virtio_transport.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index f1589db5d190..2e34581f1143 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -60,10 +60,7 @@ struct virtio_vsock {
 	 */
 	struct mutex event_lock;
 	bool event_run;
-	__dma_from_device_aligned_begin
-	struct virtio_vsock_event event_list[8];
 
-	__dma_from_device_aligned_end
 	u32 guest_cid;
 	bool seqpacket_allow;
 
@@ -77,6 +74,10 @@ struct virtio_vsock {
 	 */
 	struct scatterlist *out_sgs[MAX_SKB_FRAGS + 1];
 	struct scatterlist out_bufs[MAX_SKB_FRAGS + 1];
+
+	/* DMA buffer - must be last, aligned for non-cache-coherent DMA */
+	__dma_from_device_aligned_begin
+	struct virtio_vsock_event event_list[8];
 };
 
 static u32 virtio_transport_get_local_cid(void)
-- 
MST


