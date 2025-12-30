Return-Path: <netdev+bounces-246333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5427CE967A
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 11:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7884830038FD
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 10:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABF72EC0A3;
	Tue, 30 Dec 2025 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GG1e92xf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VPE/dp7E"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23832E175F
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 10:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767089785; cv=none; b=ERSZyU2n3EDaZKQCT36/6rW1JjzxjKMzZiT/cXDYCywRCKAA5YjO6DRML+U/RIP5b8aSOoJCBDGzEO5RJclwlVgI1l7VBE/SYsLP210oBBateO5Cx2edUf7Qam37gqdCi2gU/X83KFZznd+w3GOBLVRDgRkfbddN6J4E7l60WvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767089785; c=relaxed/simple;
	bh=RzxSFhz+bpkLtGdr/5qvrDQOf7DHug0oDxHEj4NfN04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7WGB8rXI01RcwkqZ8DyMlJoL9cMhmNCcwDI6e9kKlnLA5A000YOKjHil2+h5n8KWu5ASnibtfSn4xsY8JCRnmjs5+ePyQluNW77zXM7wZd3igfaaVav/yXy6fr1baCJbyt6kvSEXyLWaw12fkrEliYycO7DrspN5I2jD2l18lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GG1e92xf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VPE/dp7E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767089781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qjCbMizY1BaJF5yBWOLXV7DyUl9vbunxYIEFqfWmhYA=;
	b=GG1e92xfXwhdCfXUvWy8J123z+Vg7kCtHuNr/m3hKaNvn9RGC4OKv0ohda0Zxj4wQREy1p
	xe3xJ6sid7rHsX0+C6Pm/J5LoNli5rVoinLSSXriVcYFI7GrbodDENgbELVi+Zy+NJcMRI
	0sNj8PIu0WwXd5jsawV79NcWpsa05Kg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-0V73Y6ObNOOiw4u2iRSq9Q-1; Tue, 30 Dec 2025 05:16:20 -0500
X-MC-Unique: 0V73Y6ObNOOiw4u2iRSq9Q-1
X-Mimecast-MFC-AGG-ID: 0V73Y6ObNOOiw4u2iRSq9Q_1767089779
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4779d8fd4ecso49772005e9.1
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 02:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767089779; x=1767694579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qjCbMizY1BaJF5yBWOLXV7DyUl9vbunxYIEFqfWmhYA=;
        b=VPE/dp7EiLdV7Zd4+7q0LB6HkY0Dm7ay5Zf2PQw9wOoG4M70mB4zef1xVoJ8OcF5di
         9DycO/ppjRTvKJ2s4Rxl7DlzcmVynApx9nEE9Vb0yDrHpQzGTmSZlVMXTOxwgAXYqhEA
         LpIUzXeekbRKdVrnA3gLm9iAWUwcDHZyJ592nL3IWXrrlToH0Uswqa2WQ+KB5zhyGXnd
         dVQsn7dSSdnPovLKxAjIkxFXsbhSvzQHhF1/arVybtPswx/xuHSLxxiYjd9kYrEBHHVK
         M2gSZSdf5wENx4VPi3wyMOh8S4LovIHB5Lw8kvlo6EEjCh2/YwZo1jYnhS/Dkesg+noP
         80xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767089779; x=1767694579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qjCbMizY1BaJF5yBWOLXV7DyUl9vbunxYIEFqfWmhYA=;
        b=QIWSewFnj4WzdLV9/qYHKvaMacyFqfKKlIIb0By18fY9zCVDVNnfYwjhKXEixBTiyK
         JMyQVsGwvzI8nMKFrdArSlGMRaisbjPtcS1/SKNdgSQj4dTYv2bZb8KRINkq4jFzSF85
         0f88tglZtIBvXbfK0xLYSasnLM+DlIFu1Sesm+fFoyCJHzb9HjdvXC/zs74KLEg/7/Vr
         ysOR1w2Kpl4DQ1HinZ4w2yyfqHscnMaFOMWyXzMInt+dnQXiWe7kxppX9Q4znt61c5Un
         T8uBmYoyzBiCklXp2IOlpbCFn1g4WkEt4fv2+WzYcA06VFIKsRPL8UO9GDHpL9/XbDFw
         CC/Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2WTPZWLvYEgU1OmgBprC0n55nfs8jyynpqtm7OEaLI9FbCgL7dll4I1MdW6xIKlvv2D3EFY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnNmmL4ZwWkHGyRBtufbuMm2boN0B56oLUFFg4ZIuMwIUh68ET
	xdBrzgRoXWxmPvpEEsiAaJYzeLAEbqDqNr+ohMRpIfhG+SCN/hDVU23xT5Nb579O6tqm4orYtte
	3wEHNzSSyWULozRD9FRXbCoEVATxo7DRzqVJqmAy7c+AtFbQg3GgPvEc5WA==
X-Gm-Gg: AY/fxX4poT4IG+tWysrUw4BH8qi5NWkH31MuyX7BtUIc8hweU6a71qWU8vjL8OCUpiw
	UDjqAacwjsWjCummjK2WZOcmmLfw/pbs72aqPGPa4DHJplQj101s18AwWjjngkgIW6ZI1IolPTC
	yTaC43lZ0qW6xgogLrBCaMScHFqEbkNSCKW9RtlyuqAb27PkQ8e9sUWZk6gBhg22rWPQ8LuTO07
	K6jcDP2RZA12JVB9qlZ+yAfjHrX4Ea/RtYOTVXnXGHJwc1J/OumRDfEZfNuDCd7ecX9nTxWzfLF
	JwmTt3qjGmEcEuzrBnoYPA+5qyD9bnVjYze1RmY4i2/TTTA+TpwwMHFBzopyR2B8BHQGTEyohzS
	w5U+tCUlA03xAVpMAyAHKU0iqdvoGU2cLfw==
X-Received: by 2002:a05:600c:c04b:10b0:47d:333d:99c with SMTP id 5b1f17b1804b1-47d333d09b9mr218755365e9.18.1767089778577;
        Tue, 30 Dec 2025 02:16:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFT+g6nqLgyQkQdYiav+FpD+RF51wbupLPftlD1j+tQDbY3ul4LGHX6uIhkOPdx1xlKUXo8aA==
X-Received: by 2002:a05:600c:c04b:10b0:47d:333d:99c with SMTP id 5b1f17b1804b1-47d333d09b9mr218754935e9.18.1767089778175;
        Tue, 30 Dec 2025 02:16:18 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3aea77bsm247750305e9.17.2025.12.30.02.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 02:16:17 -0800 (PST)
Date: Tue, 30 Dec 2025 05:16:14 -0500
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
Subject: [PATCH RFC 09/13] virtio_input: fix DMA alignment for evts
Message-ID: <5f57d7dc13920517b3ed3e56d815ad1ba4cf36ce.1767089672.git.mst@redhat.com>
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

On non-cache-coherent platforms, when a structure contains a buffer
used for DMA alongside fields that the CPU writes to, cacheline sharing
can cause data corruption.

The evts array is used for DMA_FROM_DEVICE operations via
virtqueue_add_inbuf(). The adjacent lock and ready fields are written
by the CPU during normal operation. If these share cachelines with evts,
CPU writes can corrupt DMA data.

Add __dma_from_device_aligned_begin/end annotations to ensure evts is
isolated in its own cachelines.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_input.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index d0728285b6ce..774494754a99 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -4,6 +4,7 @@
 #include <linux/virtio_config.h>
 #include <linux/input.h>
 #include <linux/slab.h>
+#include <linux/dma-mapping.h>
 
 #include <uapi/linux/virtio_ids.h>
 #include <uapi/linux/virtio_input.h>
@@ -16,7 +17,9 @@ struct virtio_input {
 	char                       serial[64];
 	char                       phys[64];
 	struct virtqueue           *evt, *sts;
+	__dma_from_device_aligned_begin
 	struct virtio_input_event  evts[64];
+	__dma_from_device_aligned_end
 	spinlock_t                 lock;
 	bool                       ready;
 };
-- 
MST


