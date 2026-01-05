Return-Path: <netdev+bounces-246928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B188BCF277A
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 09:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28B9630242B1
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 08:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C47A32C33F;
	Mon,  5 Jan 2026 08:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P/s++VPr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uMRMouiJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE60313E07
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 08:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601439; cv=none; b=UX0thXo2WMYR0xbPfZx6ahLV6/OLmZmrtbVCyBD79VsruhQPXKx09jxaaKv6A5orwDTVFNyX4ploNzEQUWTZ+5TWZGtC5V3ZX/MECy9yENIF5rtZM3PHXfbxjuvc8487BCmSeTBpG8nnxVnaKOz/xwuudzWZ7k+ocAqOHnEX+es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601439; c=relaxed/simple;
	bh=5+AqmnW4PA/6edyK6U8dTvigNJLqhC7cXNvV8IIXjTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NkmtQTnV9leA0fmmA+Smti3TV/F+tZPtI5WzHZA8oBhzAWW6R412H452EoTyPACNP3K9uEId6dSg2n8nffaCp7NVSo7NtxdZYsgmlW0zJZcb4xo0zgrwxVDtAS9VEuHYtRo3Iry19ccIVC/G7DeyrM1kV1Z2Nk0dN14OH5rZBXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P/s++VPr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uMRMouiJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767601433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F5gbCeCGdOPWPA7+HFhpRVcPZoxhZ6OosT4+6pGbwi0=;
	b=P/s++VPrzgH8UbDdhU2sFxkqthx7rYXzr5csAkEcxqXOp4eXYa3FwJsL1qQ6+DjcrBx7t3
	dAUAuDcy9c6eLSEwGX8kiMebi9NA1Semp+HNKUXy81GeLpHDv1wW4Gne8Idlp9RiP0Elyk
	i65aS9REjjRigKE2LsoAF++yOYZjEb4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-0Krtc56QN1uSb7kyP1B_WA-1; Mon, 05 Jan 2026 03:23:51 -0500
X-MC-Unique: 0Krtc56QN1uSb7kyP1B_WA-1
X-Mimecast-MFC-AGG-ID: 0Krtc56QN1uSb7kyP1B_WA_1767601430
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477a11d9e67so88358275e9.2
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 00:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767601430; x=1768206230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F5gbCeCGdOPWPA7+HFhpRVcPZoxhZ6OosT4+6pGbwi0=;
        b=uMRMouiJplEJw0f5B11uiIHSrH3LOhXawBmO9iJbtMCtXnX76GJLVIoCkShGK39nz3
         yp/NJ7wiFbxpJw2CqA2z5GllV5j3v4RQodT9PE3uofpmD/LQL4+/+ePrrpw1yinD3uu8
         XIxgLJ0DWDIUKFBxq5afHUXbvrWFgjVsEY80bWFw3F61Un3Tpu0pJG5jVHbyKeznPoC1
         kivOJYvUuXJZkuX8nyKEn4HczMNlKVdhiVmQXmTptPA1XNeK/R3VbMXt8ZnWptwL4v2a
         tfGAc6lMpotFue6H+9pQit71eSYmLEbJa+KluiO5wx5Ofeip7XGSq9shXAFsF7BCYI6S
         7Wsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767601430; x=1768206230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5gbCeCGdOPWPA7+HFhpRVcPZoxhZ6OosT4+6pGbwi0=;
        b=an9clP8UQ38P9kJ6pisQqnyPvPdP+notBTUDAP73XH8wSRXIbG5nmMaKwEetfc1I9+
         ns9DH/dBL4m8qBbD7l1MqtWaAQaimqK6U7bQijNUuIZo16G2YPQRc3TmQIWwtkFznMOd
         5bxzTbnz+GMtM0tL3IhS0QJpz4wF9lVf7RvcQc5I2t/ToZsap5TMnGMaVlxLGNR3wbrk
         ExkyxhXAQ+xZxNAtWjlHpQ97dDJy2Krqr6Renx+Z6tFUV2p5eAUemCYauHuc2bSZHr+P
         HBbptCCRJpxJ/2JrJaE7gsex4UHLoYv+3Neq84a5OmdnZbwOUkZ+ns6+AedmV9gd9WgG
         /5qw==
X-Forwarded-Encrypted: i=1; AJvYcCVlxs23vXAYMzXnjuslQgTnCIWRu7B6aARuHUpWwN/4R34n92T61AB8uSkKdX4B6yK1jxYbOKE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuuyk2y/z7qSBp/u3/taPPHS+koy5iWk0NSKzWQG6/MEkUmLH8
	LTAZYZj8CMmlo3/s6w1pQA9bsKDEg+qjLF8cE0dqcij8glp9xyL82z5vtoq7Sgtcr4Ipro2WxW7
	ei2TqRV5/DVdSCtHPRiTw0EvpFlI/H2Mpf2kV1JcvzQHCcST+Yc6QLK7A0g==
X-Gm-Gg: AY/fxX5r8RSL9hRkqEmFxvpk+F6z6VN9qOtFovWdeHRVK6+//WY2+g62rpRcePq9r0L
	LrGva0OhfJ1fMAJZ8AXk270AjILBdmVm7xXvUeNgIBHR6wwnXYYzRPGaa8ppuae42pG1PEQUHWa
	zzDu1TYZx0BNolSFks9BhiXBq7ogyeLVU5trYt3eEbr8yIkeYNNakgphPhjeJx6U5hTnYON6P3A
	Dd9yK1LrtL1y/UQwp1uBVCai9MXux40HdN6Vz1k5yQjFj7SRRWypHIzPk5ktHjdAQQ+tggM3p29
	8OT6ZOG4RCF4Y4ZCvUHh3HlZg1F0CCmoBY6bIV4V+P0vwe30XBYYVts/N6DYQob8+xFXaUw+RZw
	PZXlMPxJLFG3h/6tEmNVza61xJScymtDE8g==
X-Received: by 2002:a05:600c:45d3:b0:47d:4044:4ada with SMTP id 5b1f17b1804b1-47d40444b44mr461187945e9.13.1767601429687;
        Mon, 05 Jan 2026 00:23:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMwRI3MA2DTNX2WICs7qzlXbxMYmhW2AMGnc8lzpwkl8AC0h1+xs4bbHr0vh3wAjjaNt43Dw==
X-Received: by 2002:a05:600c:45d3:b0:47d:4044:4ada with SMTP id 5b1f17b1804b1-47d40444b44mr461187535e9.13.1767601429208;
        Mon, 05 Jan 2026 00:23:49 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6ce21fcdsm154121375e9.0.2026.01.05.00.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 00:23:48 -0800 (PST)
Date: Mon, 5 Jan 2026 03:23:45 -0500
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
	kvm@vger.kernel.org, netdev@vger.kernel.org,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Enrico Weigelt, metux IT consult" <info@metux.net>,
	Viresh Kumar <vireshk@kernel.org>,
	Linus Walleij <linusw@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH v2 14/15] gpio: virtio: fix DMA alignment
Message-ID: <ba7e025a6c84aed012421468d83639e5dae982b0.1767601130.git.mst@redhat.com>
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

The res and ires buffers in struct virtio_gpio_line and struct
vgpio_irq_line respectively are used for DMA_FROM_DEVICE via
virtqueue_add_sgs().  However, within these structs, even though these
elements are tagged as ____cacheline_aligned, adjacent struct elements
can share DMA cachelines on platforms where ARCH_DMA_MINALIGN >
L1_CACHE_BYTES (e.g., arm64 with 128-byte DMA alignment but 64-byte
cache lines).

The existing ____cacheline_aligned annotation aligns to L1_CACHE_BYTES
which is not always sufficient for DMA alignment. For example, with
L1_CACHE_BYTES = 32 and ARCH_DMA_MINALIGN = 128
  - irq_lines[0].ires at offset 128
  - irq_lines[1].type at offset 192
both in same 128-byte DMA cacheline [128-256)

When the device writes to irq_lines[0].ires and the CPU concurrently
modifies one of irq_lines[1].type/disabled/masked/queued flags,
corruption can occur on non-cache-coherent platforms.

Fix by using __dma_from_device_group_begin()/end() annotations on the
DMA buffers. Drop ____cacheline_aligned - it's not required to isolate
request and response, and keeping them would increase the memory cost.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/gpio/gpio-virtio.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
index 17e040991e46..b70294626770 100644
--- a/drivers/gpio/gpio-virtio.c
+++ b/drivers/gpio/gpio-virtio.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/completion.h>
+#include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/gpio/driver.h>
 #include <linux/io.h>
@@ -24,8 +25,11 @@
 struct virtio_gpio_line {
 	struct mutex lock; /* Protects line operation */
 	struct completion completion;
-	struct virtio_gpio_request req ____cacheline_aligned;
-	struct virtio_gpio_response res ____cacheline_aligned;
+
+	__dma_from_device_group_begin();
+	struct virtio_gpio_request req;
+	struct virtio_gpio_response res;
+	__dma_from_device_group_end();
 	unsigned int rxlen;
 };
 
@@ -37,8 +41,10 @@ struct vgpio_irq_line {
 	bool update_pending;
 	bool queue_pending;
 
-	struct virtio_gpio_irq_request ireq ____cacheline_aligned;
-	struct virtio_gpio_irq_response ires ____cacheline_aligned;
+	__dma_from_device_group_begin();
+	struct virtio_gpio_irq_request ireq;
+	struct virtio_gpio_irq_response ires;
+	__dma_from_device_group_end();
 };
 
 struct virtio_gpio {
-- 
MST


