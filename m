Return-Path: <netdev+bounces-246326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE83DCE9581
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 11:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C535C302E15A
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 10:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EEB2C028F;
	Tue, 30 Dec 2025 10:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hvoCvzfd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="km1vHaGw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3AA2E091C
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 10:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767089759; cv=none; b=WGu6sSvSUDU/J2XkVFM0y6F1oXH+gTGIu60ThpZoNQuCApA0tlRe0kxBr40CIjXDPVw1ZctwVP6KggVQbV6Wp3KoAII3je0U/AAvjrMT8I6fy8E4sgSVZnvZfCs4KGs6mEa/ojbkR4NAEP6wqprp5WDE4gDYHsWz7t4ia5DMbjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767089759; c=relaxed/simple;
	bh=1JUA4c0efATkxneQm73kN9tTpnR2rWTicL6pMgMgIPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sROANW+4NBD0m8U+PNBHBhRQEh6zOem9eo4YaZwFqwZpVMTifb0TBwEfeaurxeeYXtsS4t90rkX3d5CakFHOCwD1oSBNw6khMJP+9GU7QS+IyXYdYVP2vrVeY1+5EJdFRgKU4o83UcBGA2WHRcpKFIC/oXHVrxgvHVNJLWThuSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hvoCvzfd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=km1vHaGw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767089756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lIFloJTLYi5ioijSED2t687CZ+kUT7GxSlzISMtKW5A=;
	b=hvoCvzfdYVI5QnmibP+2Yajm1ZhOWvPiSLWw22wJxk4akt6ZEkoNRCt/E6rQe8E02O2dG1
	u0+tK8UWATMvs3Q7iUbi4PnqB2fic9QoSW+7L/5kdiCPHLjOpweM/DXA0SwBxigpcCz3qn
	5s1u/+cCMULSkZyYkuzBAFP+x5qYBPM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-i7LkxpTDNI23pfxQErdeVQ-1; Tue, 30 Dec 2025 05:15:54 -0500
X-MC-Unique: i7LkxpTDNI23pfxQErdeVQ-1
X-Mimecast-MFC-AGG-ID: i7LkxpTDNI23pfxQErdeVQ_1767089754
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4779d8fd4ecso49770275e9.1
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 02:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767089754; x=1767694554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lIFloJTLYi5ioijSED2t687CZ+kUT7GxSlzISMtKW5A=;
        b=km1vHaGwMEO7mfXobXgRu2GF7yYLs+HkCTr39aGgXIkNfyh4MCjSseN2GIB2WtRFSB
         QYd42Kf3alEVord81XaouvsCcmA3h+Xnno+9YgpNQtjvo4sqLgAY0LhKgNU2UyZJKPu8
         xK8BtD3XMZHDaRUcQwN/nsTpeBiSDoHpB3HTtur7rtj+2Bp8j2u1zc0wiAwPtmrJnI6J
         sT4d82FeSZkdH53JxTvjOAJeLgjdD12T+wgmpkjIpwQC2epj0el+N4GG3yUbrL8VgamH
         nm9NFPzcebrHNzdpgOOBgUyPU9c3UadTicdwhiCKwVZ+iFNiYzE/6lbWPCQPoec4VOn9
         Z75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767089754; x=1767694554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIFloJTLYi5ioijSED2t687CZ+kUT7GxSlzISMtKW5A=;
        b=stGvJubcNtU8MgwHA9NkOP5U+h52IbYShtsmT7rdTjYn/KvInx2iPF/tF2V33LT4PA
         BMYTzD+pA6cFg7PgQRA1NULkShOneuXPQ8Ai38bjlf2XCDm+Ql9/FKX2H2vgeWCkyvwt
         /cq6f/YxscqWCWUzWgUfjsZTUcH/NoPrDp/5hN0tVmJbpogjsuiSTkb1gIsrqVsxA2Te
         Q4FoBnoC09MdD73lKK8LQa4dVXdDQ4k9J6fdad6tN/68/4KYIBGJEqQD7DdmxOC3heBX
         nBd3AWKNkcwYs7xOJlIqySU/F0ncpMIzKfsF5BaLy9Bxu496atg6g+sNsu85uLR9lSCQ
         +xcA==
X-Forwarded-Encrypted: i=1; AJvYcCXaPh3L+yaDU3y7XVkN/TWzYy9/unyylg37NnCq26VGHBGwP0H69gdi2nGU/z8CdK4pdmo+yrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YylJAy65nJDvOPF8QneCqGI6nDJ+uQ3ymbAGLiMbralNfMzqQ/N
	3xJp5wmjLFuyzocU1PFppEfeyN2AxwQELaJ2FBlmD/dgTknUFsUW8V3g0Sd0X+N0nHmD4oWEnHY
	Jzgzr4jn725o53f88uc7ujCgntH/f7SHpFUPoPF8AqSh0xIhdqfuPRShYWg==
X-Gm-Gg: AY/fxX7R3Z+sY5BEh4ukQOm2lPO3ejWH2mEz55NPm4sgp/WgmYE0R++6NaWqdNPkLL6
	98XH7lsytalx3Y0iocmSPKQ8+neTXs5ZUwHVYqMKE+36Y1xrtrAmVClyHL8bkyAB0Ul1gA/mTuC
	kidsGFLE5ZoV/2dSg6fw4IEOLebatgep89mRh+Ecce+Wbz+dmbWrKEfrMLpUNqFRucC2H5MAChO
	r3enmV7Bv1SRTFpPiKLjzgKv3GTo/f9AVWpbTZyEgR2hOSxGFbXEKoGdWOS6z8v+wWTVO18+gEp
	+CINuseNy8HY7Hz/5CrV5+PGwxw7MrDA9d7zxPfgfJUvk3yv9B681+Jw6eH21+7KHnukgZf4+3l
	8ZNRwA6KcFUje/CckmZTRFsUOS5SkZ8uj/A==
X-Received: by 2002:a05:600c:46cf:b0:477:9e0c:f59 with SMTP id 5b1f17b1804b1-47d18b833a6mr393752945e9.2.1767089753558;
        Tue, 30 Dec 2025 02:15:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0nrcJnS7RjupXcIyxgJ/7OwvI0dkgJ3plFmvdD3JvcGLBLhWJUwOhq1auRl2SqH+pkIX7dw==
X-Received: by 2002:a05:600c:46cf:b0:477:9e0c:f59 with SMTP id 5b1f17b1804b1-47d18b833a6mr393752425e9.2.1767089752979;
        Tue, 30 Dec 2025 02:15:52 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be272eaf8sm630001695e9.5.2025.12.30.02.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 02:15:52 -0800 (PST)
Date: Tue, 30 Dec 2025 05:15:49 -0500
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
Subject: [PATCH RFC 02/13] docs: dma-api: document __dma_align_begin/end
Message-ID: <192a335d783a2e54f539dc5ff81bf3207dafa88f.1767089672.git.mst@redhat.com>
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

Document the __dma_align_begin/__dma_align_end annotations
introduced by the previous patch.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 Documentation/core-api/dma-api-howto.rst | 42 ++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/core-api/dma-api-howto.rst b/Documentation/core-api/dma-api-howto.rst
index 96fce2a9aa90..99eda4c5c8e7 100644
--- a/Documentation/core-api/dma-api-howto.rst
+++ b/Documentation/core-api/dma-api-howto.rst
@@ -146,6 +146,48 @@ What about block I/O and networking buffers?  The block I/O and
 networking subsystems make sure that the buffers they use are valid
 for you to DMA from/to.
 
+__dma_from_device_aligned_begin/end annotations
+===============================================
+
+As explained previously, when a structure contains a DMA_FROM_DEVICE buffer
+(device writes to memory) alongside fields that the CPU writes to, cache line
+sharing between the DMA buffer and CPU-written fields can cause data corruption
+on CPUs with DMA-incoherent caches.
+
+The ``__dma_from_device_aligned_begin/__dma_from_device_aligned_end``
+annotations ensure proper alignment to prevent this::
+
+	struct my_device {
+		spinlock_t lock1;
+		__dma_from_device_aligned_begin char dma_buffer1[16];
+		char dma_buffer2[16];
+		__dma_from_device_aligned_end spinlock_t lock2;
+	};
+
+On cache-coherent platforms these macros expand to nothing. On non-coherent
+platforms, they ensure the minimal DMA alignment, which can be as large as 128
+bytes.
+
+.. note::
+
+	To isolate a DMA buffer from adjacent fields, you must apply
+	``__dma_from_device_aligned_begin`` to the first DMA buffer field
+	**and additionally** apply ``__dma_from_device_aligned_end`` to the
+	**next** field in the structure, **beyond** the DMA buffer (as opposed
+	to the last field of the DMA buffer!).  This protects both the head and
+	tail of the buffer from cache line sharing.
+
+	When the DMA buffer is the **last field** in the structure, just
+	``__dma_from_device_aligned_begin`` is enough - the compiler's struct
+	padding protects the tail::
+
+		struct my_device {
+			spinlock_t lock;
+			struct mutex mlock;
+			__dma_from_device_aligned_begin char dma_buffer1[16];
+			char dma_buffer2[16];
+		};
+
 DMA addressing capabilities
 ===========================
 
-- 
MST


