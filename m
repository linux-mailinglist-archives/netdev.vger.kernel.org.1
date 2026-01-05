Return-Path: <netdev+bounces-246926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5932CF273E
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 09:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B507300CCD7
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 08:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4572232BF35;
	Mon,  5 Jan 2026 08:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJLOHygn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzj8+3r1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C9532A3EB
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 08:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601434; cv=none; b=oF/8xQOBNLFmGaqC/hJgl0rMeFl1wRAtk8T+4Yitld+oN4WZy8JWX7R7GIQKCQo7pGQ46YBikxXHf3cG+dgPl5J1yfRm6Ws81DTTttBCy+vkkaZ4MWlc849HysjXN8j7gglBlOjvfg1Cv4mgUI+NB9m/53+1GPub1bIHsUslqNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601434; c=relaxed/simple;
	bh=aG8SdrVHEUE18T+idL+tMCWXHe6vRndhmeQnti1MW2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tN/BHi5n/yZEEDKEfu967tndrmjyH/FG1eCqrx4j5qsD0CeC8TzB6vQ0PQ1R/Al6+EMBPlJ7RqCDuX6LXm8ya/TmdLr7lzKPBcBc7ITTjgF7wSzxGaZYCbsLJ6yXr7qnbvQ3ixO3KJo897oZlcdhNVZZA/AeZ3FIJGNN4ruifFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IJLOHygn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gzj8+3r1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767601424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1WdygBrbpusefWmIaX+oAwz9bur1qkKHYd3aQzYNeN8=;
	b=IJLOHygn0jycrG+u+R2SxrrlpafXVcHrKb1JC2w8pPPPiq6z9M882Fus/umMrY5tKWf8A1
	c2c/0v7xocDq4o1d18R8L1W5IfUg5RCtcAsMWVq+xvCOQt5sSKnsHDvb9CJHHDCd0fqQtQ
	BPrSf5x8Yxr5NCkUB6i1nKgtt63QsTw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-uscqs8I9Oam_hLWLnbzlVQ-1; Mon, 05 Jan 2026 03:23:43 -0500
X-MC-Unique: uscqs8I9Oam_hLWLnbzlVQ-1
X-Mimecast-MFC-AGG-ID: uscqs8I9Oam_hLWLnbzlVQ_1767601422
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477c49f273fso171311055e9.3
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 00:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767601422; x=1768206222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1WdygBrbpusefWmIaX+oAwz9bur1qkKHYd3aQzYNeN8=;
        b=gzj8+3r1o0cFHAQ7sZymVhJnTPnFxaw9A9PWo+1eUB+fITz0zBpkk7Gog1DH+Y5gTx
         C5oBNRPdIZE6l4XYxGBRtlc9ZkpeI1LFo0IuvtxLUbghkGjxP7rh+gg7pcgkbgvdp6h2
         F1omXaiTwUHKELEBL9PrWIMeYMvvswWmgiDBinTJUcViDLn5p8G7pkcphVbcHSjicmpL
         8U6UBQ2N24AVW3VZvP77apOaWZz5K4ARD/MprGTaZBEjiGGAAzXYZxj36rtIdBNj2qvV
         PutMvcbT5WoxEBVZJ8j2GRbCeunwhkr/Ywqk1TQpyBvwJZ9wIqfvJbKxsce0170fP9b7
         XIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767601422; x=1768206222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WdygBrbpusefWmIaX+oAwz9bur1qkKHYd3aQzYNeN8=;
        b=H/R56VEvMSR3lTjnGrMOhqVH4KmWSMahyUsW3XVmosJbJCNPbJVF3lSUFtgPu21e/k
         vcePqXJcWFtt/VtuFN1/07nxBODX+voHaBMtqQCI22/IT2cYEgW/buTO7ceiyZIP6kw8
         vLwMWu6aBwjXM2OAeZ1eCeWiwTtnGk47LQA6rF+PnDqDs0bWw2n4zDcqvVxAWbI5UlYZ
         kwoFalRe1b1dIN2nNSmgg46/uqi4QX8o9KUBebdqS7AMsctfXqw+E72irlCyI234b1fJ
         34aLk355lEql6Yi/AWETXHTvF6th1BZvMorL7ZBS/KmW5e5v3HXT4RAa5nC8IXId+X8/
         bn+g==
X-Forwarded-Encrypted: i=1; AJvYcCVgS/h2Lm4ja+3fv1vcVfe01uIpLNUhD4Si1/zpndDshTOMOxmwUIJlRCVqsHzQPj9RXHwwdQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY2iZnoR2m1iZnaZZL7XbqOf8hhWdZR7sNEO5aoUyv9dktpnCH
	6SASvJ8Mr8h4K4NfKf1YjaXZ3oqxCFIGbWh3GwRi1Ag95rpeCaVxIhnQJqKX2zq+Ccembs/Ldfh
	eb9v+/+jqWLUWgCPBdu2WyNopDbfpD73ttl1/dHt/SL0SYSnTq5uMDVZlLw==
X-Gm-Gg: AY/fxX4KZ+Qf3s/iR+clljvJTTQHu2EYMRDw17qyn3Aphl6T2Z7Pj0bIAzWuUMIqb3+
	zJdd6dNCRVxZ9mlHQTP/URTZ1mXc0K6iEcVUmXIZwMMdbS7gdYo6lZMsKTd5BMPjxcmuxttEGGb
	dvMTw6KsD4kN8N71AVS3+QuBA0AdX4dS/8/tqSM+YoJp94aJ4cq9FEGtl8UZty8BuxgavICUwrQ
	1ivC7p3/SpB0NM69UrEyfyexyskq5TjifdjKIpcBa3nj0HmYrXq+ba4GhiHZLPcA0COx+AKjAFJ
	SFcwXFHVsFNFh/C5gUreoMtOo1zs4kpGkcHWNkf9lg+7pp0IXVjD4+NZTwgIm2TY8XstcQRuPHi
	NFlVmnD6P7IEgzmquRHixT+fCoAo/oonyGg==
X-Received: by 2002:a05:600c:1e1c:b0:47d:4047:f377 with SMTP id 5b1f17b1804b1-47d4047f3e5mr400614985e9.36.1767601421767;
        Mon, 05 Jan 2026 00:23:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0AgOv9S8mcPvJ16vNEXPXT2v+oy4k5XMxl4opf9hSfJCRKVIgJxqAgfJFXStW11yISqh4Rw==
X-Received: by 2002:a05:600c:1e1c:b0:47d:4047:f377 with SMTP id 5b1f17b1804b1-47d4047f3e5mr400614705e9.36.1767601421303;
        Mon, 05 Jan 2026 00:23:41 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6d33eefesm137323605e9.12.2026.01.05.00.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 00:23:40 -0800 (PST)
Date: Mon, 5 Jan 2026 03:23:37 -0500
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
Subject: [PATCH v2 12/15] virtio_input: use virtqueue_add_inbuf_cache_clean
 for events
Message-ID: <4c885b4046323f68cf5cadc7fbfb00216b11dd20.1767601130.git.mst@redhat.com>
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

The evts array contains 64 small (8-byte) input events that share
cachelines with each other. When CONFIG_DMA_API_DEBUG is enabled,
this can trigger warnings about overlapping DMA mappings within
the same cacheline.

Previous patch isolated the array in its own cachelines,
so the warnings are now spurious.

Use virtqueue_add_inbuf_cache_clean() to indicate that the CPU does not
write into these cache lines, suppressing these warnings.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index 9f13de1f1d77..74df16677da8 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -30,7 +30,7 @@ static void virtinput_queue_evtbuf(struct virtio_input *vi,
 	struct scatterlist sg[1];
 
 	sg_init_one(sg, evtbuf, sizeof(*evtbuf));
-	virtqueue_add_inbuf(vi->evt, sg, 1, evtbuf, GFP_ATOMIC);
+	virtqueue_add_inbuf_cache_clean(vi->evt, sg, 1, evtbuf, GFP_ATOMIC);
 }
 
 static void virtinput_recv_events(struct virtqueue *vq)
-- 
MST


