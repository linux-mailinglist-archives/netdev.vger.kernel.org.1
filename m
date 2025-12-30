Return-Path: <netdev+bounces-246325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FB2CE9575
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 11:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A6663044850
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 10:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF00257821;
	Tue, 30 Dec 2025 10:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gSkCZylG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="e4sZk6/R"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1EF283C93
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 10:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767089755; cv=none; b=PtC447YqQ8bQw00iyVq5obBVFl7weE7vHcnnP4edySRcj30sD0LmgMmft7nHTTs8fg+dAigqDrjqTeFQd7Y+vFWRHkokk4zeAX2cyMBH16C+0jBY1I6sPLQyxX9PP6ofuVbPXjwdKF6qgwLaSRFy+5QKfrHRImEVy2klKT5hr/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767089755; c=relaxed/simple;
	bh=D8i5fx1UC1/6nmNgw58hQGeu+7fSwjalMhDNBy/e6FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJUCnj6638fS2Ej4PL2rKgpBg9d4hiR0pzZzGcp7Gl1oS6VfoL+wNNMxlXovFm59hGeGO4Jb0RWJRyLclzON7EHQ627Hgg58BVovQcOqf6v4I1JuGd3FiWk5EoqWb3mGrgdkKh76a+vx7qpQ69dfcar82W/BzJ0Ra6GNE1eFCl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gSkCZylG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=e4sZk6/R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767089752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HL5OM1OGVzMUVxTMh8EvcAcQ4aesQjltxTtrn5MVxlA=;
	b=gSkCZylG1ZqrEKBJfUt0mD8o0Umh+yupxPCi7dKfALjqGCXRXnGluwo4loO0pcZ+ZWLgZp
	wvZDtEPeWlzEcQyMiaEYQYQ5S+OAD9B6MEInBBOcm08JEDjR8WWqSsYF2/yTlFUUzFp07m
	P87jgHtjMxzGKFEE0gfDSFLt/aP76vk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-uq62rMI6MFCi53C-3mW6QA-1; Tue, 30 Dec 2025 05:15:51 -0500
X-MC-Unique: uq62rMI6MFCi53C-3mW6QA-1
X-Mimecast-MFC-AGG-ID: uq62rMI6MFCi53C-3mW6QA_1767089750
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477c49f273fso125577505e9.3
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 02:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767089750; x=1767694550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HL5OM1OGVzMUVxTMh8EvcAcQ4aesQjltxTtrn5MVxlA=;
        b=e4sZk6/RCGmihD7DRl0FPvrBMhX7FlCiK5jw2Ehcy4uyEkJDxBNSSuXCw+3H+s2kBE
         ErVQKx7Yv4v17Egvx4AZxXajguw1+W+IUVZK/qX6xQottVcMy5WGGE/kj4YnfceXDhP4
         z5LZEOGjnU5xDthLT0rcWUcUXSXstq9TRB4/0eGzwx8O2V652sedBSp0IoGeKWv95ThD
         tQwGj+oW3bom2TW7jOkejhzJqnTUDAIO++WNc6hSeUbncxMgBnghFQMnIZarDVPCd8Ep
         gRXzfLru+mP9vMTt2cqG+VxFBAe4/jhg3sX20/vDU2xDIgqoaAMlKQB+XbBZXnyKiceZ
         HGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767089750; x=1767694550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HL5OM1OGVzMUVxTMh8EvcAcQ4aesQjltxTtrn5MVxlA=;
        b=dVpW3SOCFVfP1SDRamTbLR93eCZscTVLGAl/QPZU5XRB9Bh7OK0sbd/hqVKoftWmAl
         CS2DeqV9GMhJYWT1nP2uOh5sCRKHMC9Kpr1SoPP+0pceswPGdHw7giXvH0w9nCKf3CNH
         T7QKcc6tBkdF6dG+UAcJk7ztAq5k0098hDfp7Es10ktp4aAXF3gT+pnRUMHthqkTQJuP
         B2xhvu0fy+xHNKkmPWGLEb5wiwiQY1Wvz5nZt1dZ6RzPQLaCAkUsn7O3SGROdyEkZULU
         xDiqz0/n6bWkOAgBVBSiLCs5Ejai3yqF9V4h+ENRvNty/AgCMhk92u80HLC6MYkrl4vX
         la3A==
X-Forwarded-Encrypted: i=1; AJvYcCVQGAflWSGSF2u+bKtHlq1LkCdqR3fnEJ9oJoTE19GKzuCHfZ6vTj3TAlV5Y3Jc2/W/4/gk2rc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9JvzaD/Y2X+3F1FC/udU6DXoW6b/a96lFBS4O3RbNj2HEqLIa
	lWkcP9v12mHpnQJgWETWSp2iNfIAV8rsifJgU55d7/zle3z8Gw5hrFTQzUXC76A+9jZae7uzQmG
	8+YT1BS2x+iWN1nEgV5vM658fQhptebhzJOkdCFPjpXzEdh5ipPrLlq/6zg==
X-Gm-Gg: AY/fxX5GVl5VHPJ3y7aRj5lgg7bdbWFJCMNIY7pC8SM61ZSiDKPK7fF2cbdzcIZUTUp
	JO2YcLM0j8wwwYKUm6730/clTFBSZoNcAVAeBAlBK1Z/4dNUOrblCY8rA8gc1kKuPgt1I7StDUP
	2MMReMzRHh5qTUu6Ta49RD56NTHAt1lYqrr+EUcWXljXqE1WCvA1xEkj/8eyG9j7VvSJRXpuX7n
	82vUBJ5O0o4hXO6gJEavbR+TaQXEtUQhIjbVThB0rByCns+fFg2WcGt2/tMf7l68Ohw4V6gQy/p
	AChmpHRH0qzwZbfZoL+bNhLuroSgVsoj12R98F+dtC36E1SELJUilFj0WU4O3B5usgZ6yMkDDE9
	fWPdVox7tJVJg+tsqxDDS8COj6CoQ/2lcSA==
X-Received: by 2002:a05:600c:8b8c:b0:477:af07:dd1c with SMTP id 5b1f17b1804b1-47d195aaf01mr352297095e9.35.1767089749992;
        Tue, 30 Dec 2025 02:15:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGA32W4P8fpeNgmYgRIg4EUZ5pS0m5VtW0uNekoNCHVjCXEfha8FeJZQUcsP4e9hP9jnxKeEQ==
X-Received: by 2002:a05:600c:8b8c:b0:477:af07:dd1c with SMTP id 5b1f17b1804b1-47d195aaf01mr352296575e9.35.1767089749551;
        Tue, 30 Dec 2025 02:15:49 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d193e329asm588350835e9.15.2025.12.30.02.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 02:15:49 -0800 (PST)
Date: Tue, 30 Dec 2025 05:15:46 -0500
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
Subject: [PATCH RFC 01/13] dma-mapping: add __dma_from_device_align_begin/end
Message-ID: <ca12c790f6dee2ca0e24f16c0ebf3591867ddc4a.1767089672.git.mst@redhat.com>
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

When a structure contains a buffer that DMA writes to alongside fields
that the CPU writes to, cache line sharing between the DMA buffer and
CPU-written fields can cause data corruption on non-cache-coherent
platforms.

Add __dma_from_device_aligned_begin/__dma_from_device_aligned_end
annotations to ensure proper alignment to prevent this:

struct my_device {
	spinlock_t lock1;
	__dma_from_device_aligned_begin char dma_buffer1[16];
	char dma_buffer2[16];
	__dma_from_device_aligned_end spinlock_t lock2;
};

When the DMA buffer is the last field in the structure, just
__dma_from_device_aligned_begin is enough - the compiler's struct
padding protects the tail:

struct my_device {
	spinlock_t lock;
	struct mutex mlock;
	__dma_from_device_aligned_begin char dma_buffer1[16];
	char dma_buffer2[16];
};

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/dma-mapping.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index aa36a0d1d9df..47b7de3786a1 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -703,6 +703,16 @@ static inline int dma_get_cache_alignment(void)
 }
 #endif
 
+#ifdef ARCH_HAS_DMA_MINALIGN
+#define ____dma_from_device_aligned __aligned(ARCH_DMA_MINALIGN)
+#else
+#define ____dma_from_device_aligned
+#endif
+/* Apply to the 1st field of the DMA buffer */
+#define __dma_from_device_aligned_begin ____dma_from_device_aligned
+/* Apply to the 1st field beyond the DMA buffer */
+#define __dma_from_device_aligned_end ____dma_from_device_aligned
+
 static inline void *dmam_alloc_coherent(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp)
 {
-- 
MST


