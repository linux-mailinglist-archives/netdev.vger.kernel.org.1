Return-Path: <netdev+bounces-246915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A65CCF266F
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 09:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDA6D30CB118
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 08:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977C8314A7B;
	Mon,  5 Jan 2026 08:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SVwXcTAt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QPkFrgpu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8210F31328B
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 08:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601384; cv=none; b=ue7gX7GC5ESxBxL1CcGZjzKfudvjRHxwQZi6p2cJWBsURAqCzRLOdw9NGdyZbjNlqWNZ7htAhdnPOEwMjo7pvBOQOc3/fJpq1lSh1ohUHw/mpPrFDOiLGFxowLCsePY5A2cJYQjaUQkanqF2IYkAFQVkEC18L8C1JyICpCLOpNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601384; c=relaxed/simple;
	bh=OKICx5FGcs8IaWdKqJAnv5nr30MUEvkMmLH/rtLJg90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNPqUaddB8aT8FtTdCxXzCzc6zkuO9csI+W6g8PQSY0+46oELH2U1WM9e4GTRFmKUrGmcUHx1lsfqjoQ2Q6jYIC8/NHfYp163eN/w1rf5391pNiUnnYUtRnRZC/vKK+MfltA48YFAJQk8aYuCh6rmOwGRON2WXxDnmdECKfGI+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SVwXcTAt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QPkFrgpu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767601381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=flvV58rpfI6B2CbimOq4yKlcklsexX+NampJykNGX78=;
	b=SVwXcTAtaSBi6t+FrSK/lOL+tFSm23jb8wofHLL7pKFPnSjVNyRE8qnRWSMo7mz5aa00W1
	xQF/9QAznM683TGBW1sAxjetoBek6NpKxakdJsjgjePBy8ZKtTm4P77AAr1qhqoCSRmJ8x
	vCiOo3U7gh2Oib6nLHZ7OTUietRju30=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-hVmStA1TMMC3FgyNqtiujg-1; Mon, 05 Jan 2026 03:22:59 -0500
X-MC-Unique: hVmStA1TMMC3FgyNqtiujg-1
X-Mimecast-MFC-AGG-ID: hVmStA1TMMC3FgyNqtiujg_1767601378
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47d28e7960fso89204735e9.0
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 00:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767601378; x=1768206178; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=flvV58rpfI6B2CbimOq4yKlcklsexX+NampJykNGX78=;
        b=QPkFrgpuiBMMFofOQ4jAdxxN6c2Vp4oV1Gg7feN7Brwk3IoZE8tlZBtMewNHdCTmcX
         J89iiXHO8XulT7mvkAYigvNB21HwVkC4UaJh+6qLFH044MYI/AJhC1rir05k3E4D5zAC
         l2oMwTUjnPVcCbl4v5p9sk+ENJbiTovejKy4d238LehbX5oug0hjfbk+5CP0WUf7R0W5
         oAt5vX0zoXLVkMJ/lerxu000WlCDJKWa5kUX14ARIXqnfSsN5oTfZjrjrbgv3FTzfJ+d
         ohL+mLUyGVtzNS0/P3hyS1HSdrurjG/swvLj6tE2/lIvMl2g9uBukt4A5C+bA3B/QfIq
         nkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767601378; x=1768206178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flvV58rpfI6B2CbimOq4yKlcklsexX+NampJykNGX78=;
        b=QjH40HljWeflhL6SqcMD3mEUSjFkQp0yKmqY7qKsehurcfml9aaNl9AGs2N5H3K9bu
         yLLWKLWq14tRNEGpmJplmV021Raw6AjjLpy2xn7D1EU2BTWq7TUSaXhnu7F3PqBwVeA+
         C0cz7CipDMd29amIMYlSzPPntWtN/0/76gQcCkvzYcA4eg4Z7mq0cODNCuoZm9aU5hom
         +e7sVuhP/NxAnKKHYsd0qm2tY53WmfJdZU+mRUA3vC1PSCMkcY/tfBm/MOT61rUUcY2j
         pZylLmKzRjIFLFGyOWzWwf0GrCC32weAdTxsc99cs7qOe7rvjgJQ39SG/drWRbAPVmbP
         OSZg==
X-Forwarded-Encrypted: i=1; AJvYcCWVJUaZ3WVu6QSfbIRRSStBI4YSaEfQlAzdt5Mnoh37Fodye9BpHFh1BmxfCn0QOyQ+1QGcL4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLi4t0xLsY+8KobRIPBgkHGnRChV5JDiau5JGsfBNm7gzVr1IH
	Z6t68CSINFQ0XGUnIqN1c2XgYorEqhgpzjtExqXSYt8gss0MKM7uWpw+FsnPfecPQ5bsasOcPyQ
	n2+BC2FohfmPR3Q4mgUxSyyelMjvQ20wCv/n53lrzeqxjFAXC+a75CAAqSw==
X-Gm-Gg: AY/fxX6SzDmB82taGnw+q6T1Du8KA+0rk0d5wM/mz2SwQpzv3xSWDfXlekz+Ixvt7Dh
	2Y7EfBaPR9IgrRu1Lt4HKFv6dz9pmv4MdyWMKad8E12Z3rcEO7gURTo604wuHdKhDhPIlGDOG5H
	tEaI4qd4QXikMzdBvOdwSGXYho7f4V9v0hos10fucVmy2mdr82eZ4ZZk21jiuwoYSzLjV4t1Q/D
	GCPDyjEOILQL30qcAxpaa9uqOtLmKw5/8S466oNDEn2GZU5Z9ZH3T6Ft6dSFUt9ipQqWQwaueqv
	/1HJQNbQ0zC9QkxIVXND0RVmTKCihboqQ3QZn6MDTNpFfVUga2vLoPlwGdsKb3QfuFZa5b9ttxe
	XAH8WQ2fBmEMgekTzMxe6R3Gg/RTH9QE+xw==
X-Received: by 2002:a05:600c:a31a:b0:477:b48d:ba7a with SMTP id 5b1f17b1804b1-47d1afcd9e2mr472221765e9.32.1767601378037;
        Mon, 05 Jan 2026 00:22:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuXSIOihQGqTUh73UD1lwUxn/oQlvSzbaEszKjq8q7pmaQg9MTKbAK1XIofFksKZVCqoImYw==
X-Received: by 2002:a05:600c:a31a:b0:477:b48d:ba7a with SMTP id 5b1f17b1804b1-47d1afcd9e2mr472221315e9.32.1767601377489;
        Mon, 05 Jan 2026 00:22:57 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6d13ed0asm147684535e9.3.2026.01.05.00.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 00:22:57 -0800 (PST)
Date: Mon, 5 Jan 2026 03:22:54 -0500
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
Subject: [PATCH v2 01/15] dma-mapping: add
 __dma_from_device_group_begin()/end()
Message-ID: <19163086d5e4704c316f18f6da06bc1c72968904.1767601130.git.mst@redhat.com>
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

When a structure contains a buffer that DMA writes to alongside fields
that the CPU writes to, cache line sharing between the DMA buffer and
CPU-written fields can cause data corruption on non-cache-coherent
platforms.

Add __dma_from_device_group_begin()/end() annotations to ensure proper
alignment to prevent this:

struct my_device {
	spinlock_t lock1;
	__dma_from_device_group_begin();
	char dma_buffer1[16];
	char dma_buffer2[16];
	__dma_from_device_group_end();
	spinlock_t lock2;
};

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/dma-mapping.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index aa36a0d1d9df..29ad2ce700f0 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -7,6 +7,7 @@
 #include <linux/dma-direction.h>
 #include <linux/scatterlist.h>
 #include <linux/bug.h>
+#include <linux/cache.h>
 
 /**
  * List of possible attributes associated with a DMA mapping. The semantics
@@ -703,6 +704,18 @@ static inline int dma_get_cache_alignment(void)
 }
 #endif
 
+#ifdef ARCH_HAS_DMA_MINALIGN
+#define ____dma_from_device_aligned __aligned(ARCH_DMA_MINALIGN)
+#else
+#define ____dma_from_device_aligned
+#endif
+/* Mark start of DMA buffer */
+#define __dma_from_device_group_begin(GROUP)			\
+	__cacheline_group_begin(GROUP) ____dma_from_device_aligned
+/* Mark end of DMA buffer */
+#define __dma_from_device_group_end(GROUP)			\
+	__cacheline_group_end(GROUP) ____dma_from_device_aligned
+
 static inline void *dmam_alloc_coherent(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp)
 {
-- 
MST


