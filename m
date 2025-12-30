Return-Path: <netdev+bounces-246373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 767C4CEA32D
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 17:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD3903046FA4
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 16:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F22322C65;
	Tue, 30 Dec 2025 16:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q2v1sdAQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QcCA+7eU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B10A322DBB
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 16:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767112842; cv=none; b=JeimoiI4mkrGkeAHMxxLcpycRJ855RKJqe66E4dzZya5YPI6070cBjStOxfpCHVtw3wq0Xxa0zRy7uDWmYWdpUesqECeFI8fSstUpdHpPFX5Cmhi1tyjXXt671g7IBcF2TXGuXeXg4W5uk/ltx9VNfW01c/gmvpEkYyAEp0hzkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767112842; c=relaxed/simple;
	bh=rJvyv/DkZDnTdlk5mMz+iorYKgEElNGmDI1t8E4mVas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcgWk93Ad0np285W+MSy2QmRlTopdhY6jH9An/M1uufMDolz2hQudXluJJ2hUQlYNMBEavLQrr4CmXoDuE/hNHo9QiYJDAmIm+l/AMszL+bbm45TamP+IeQa9Eai3Zt20TPY/9pfktCBCrD1uAjVIxt+NkeKKro2j8QGgX2ze2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q2v1sdAQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QcCA+7eU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767112839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RGewFge/6sMWyfD/6+VNEsuf36DWmJ0Q3xqEbJz+f7M=;
	b=Q2v1sdAQAk/eG/xQ+2oOwrLdVAQveSV8+hvKKFYeiV7fVAei25o+6ncXA7PnVUayaX6099
	J6j0DOV0loUWPeocxFruy5syesmGjdbc7Mddd3MmwTL/BuNgv8rMt4lT29QTM4LSJrpjjB
	AHxqVnumg1TesE9t4Y/X7RAVbsMq/IQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-Pt6Kir4RNnm1gNAdAxs4iA-1; Tue, 30 Dec 2025 11:40:38 -0500
X-MC-Unique: Pt6Kir4RNnm1gNAdAxs4iA-1
X-Mimecast-MFC-AGG-ID: Pt6Kir4RNnm1gNAdAxs4iA_1767112837
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4325ddc5babso3943360f8f.0
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 08:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767112837; x=1767717637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RGewFge/6sMWyfD/6+VNEsuf36DWmJ0Q3xqEbJz+f7M=;
        b=QcCA+7eUvHQSy2dgFoIzSSIP++kP8Av+SYabpYIOYZ7166/HrUbm8Wno+lYddS7XTp
         pu4owh2Z3XIEfihGTtHc0VouJz2I4u6P2oJK77qlOPqpIXGrJuKYJq45XfPN6ZT2q6KF
         7CpCcVP1lwHuwAdPm+yWlId1+YfXzkTXN+2e96HhbGEh8HNerWSrWqwLJAQ8lDLbCZ8I
         i7/KnnYBnZO/cxr1ICKKJvD1hjBvU1YnimyFfTST5YTCCJwLe7fBZrfij1ORvxy5Q3Tx
         srQFSAFtQaumOEHLJiA3iZKM9yr3kTeeG2hdS3jXfIqmNnmCszDLRXgTTDAidcDg4R6o
         yHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767112837; x=1767717637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGewFge/6sMWyfD/6+VNEsuf36DWmJ0Q3xqEbJz+f7M=;
        b=dVSwl0klm9mhNGGjjSFbprpBcWpkcEmkOAZkH5Q3e5cmfsJnSeOODhn3i5zwc5Z7ET
         qocHFB3gDipdxqpIvbeVuiMdAW1nfIyqfbbaHmfneXZ3Z5VHjuJrrptv8GnJ/FAwkgLQ
         qkOJkffrXUyBhlXgWsRSENRHJubxiHlJzwpVYGWJGKDPu3nfnPVEnvZ1NB/C75JsvLtK
         Dw2UHAtF6aLgp8dcCc7zqDzuG7L6Jpw+8ozZBDeVJcgHpDVfjmpSEIoPOKFH/MNCcFNU
         056jrHsnK6RpomHKdGS8mSwZpVvgt+mpt08KvImRrwPY2Y2McXrzFjFjrxwJ4151XsI2
         RcFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRcftYHwoTSLInf8AqXY+X5/oiRQXMbblGeqbzdAiwmgJyadzgEXSo6riqC09vuoy96oJ5GG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Oaaz10gq4Es3awrxnTGJjROOSaWpi+iNqrf3Wb2DH4OVw1YG
	8aNn4gpS3eKIUKfhdgvE1exsK8u1PSEuJkRCtAd9l8yvk6+5zLoOeYPoTNp8MRTogjVOG+9Dxji
	i9pTDqM5XdUkYqzqFsb33TmFPl+2hx6wQcYfBNa4NugL8R6vBpLQjlU1C7Q==
X-Gm-Gg: AY/fxX6aGEgEldYpXWSEKJu9rE/csNBjpLW3hwB5mh+UK04uMQe45UFTBXNSa4U1GLo
	uKYI4p5iB6JDJFK3DQbty0G3NQ0NRyD5We93eYgeO+VmulMz8NXCTz/2lsUB5u4mQ41/e2Nn7bK
	8XruH25XwOOyDpsBEY+N+lLS1Go5d7VlSagmYla7PLqWf+5touSaCnu0nF7KbIoLEZV9YUD51sS
	+vLv5AQlMg4BtywKq+xrdelGimXQb6g85nGJ2OgtugZU1ToKx7N1r4aAVF43Rp10BEQc0pwQpzi
	ONamFhFEr9EwGrN10qBgeFzZAEQvrsLiSa2fQq7BhieZLq8PViBay7DDLg5JwWfP97L6MmIsl6J
	12Gmw/bDNoMkIsYPtnawtl15cXyjOixN1dQ==
X-Received: by 2002:a05:6000:1865:b0:42f:b9f6:f118 with SMTP id ffacd0b85a97d-4324e4cc03bmr47309000f8f.15.1767112837187;
        Tue, 30 Dec 2025 08:40:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJgojb32FwsKVmHhWZwfLhjoCLU41JBrW58xQS8ik2FTwcPC3e2aYiOOV4nGFH+isXC/64yA==
X-Received: by 2002:a05:6000:1865:b0:42f:b9f6:f118 with SMTP id ffacd0b85a97d-4324e4cc03bmr47308928f8f.15.1767112836647;
        Tue, 30 Dec 2025 08:40:36 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1af2bsm69151255f8f.1.2025.12.30.08.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 08:40:36 -0800 (PST)
Date: Tue, 30 Dec 2025 11:40:33 -0500
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
	iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org,
	"Enrico Weigelt, metux IT consult" <info@metux.net>,
	Viresh Kumar <vireshk@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH RFC 15/13] gpio: virtio: reorder fields to reduce struct
 padding
Message-ID: <55e9351282f530e2302e11497c6339c4a2e74471.1767112757.git.mst@redhat.com>
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

Reorder struct virtio_gpio_line fields to place the DMA buffers (req/res)
last. This eliminates the need for __dma_from_device_aligned_end padding
after the DMA buffer, since struct tail padding naturally protects it,
making the struct a bit smaller.

Size reduction estimation when ARCH_DMA_MINALIGN=128:
- request is 8 bytes
- response is 2 bytes
- removing _end saves up to 128-6=122 bytes padding to align rxlen field

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/gpio/gpio-virtio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
index 32b578b46df8..8b30a94e4625 100644
--- a/drivers/gpio/gpio-virtio.c
+++ b/drivers/gpio/gpio-virtio.c
@@ -26,12 +26,11 @@ struct virtio_gpio_line {
 	struct mutex lock; /* Protects line operation */
 	struct completion completion;
 
+	unsigned int rxlen;
+
 	__dma_from_device_aligned_begin
 	struct virtio_gpio_request req;
 	struct virtio_gpio_response res;
-
-	__dma_from_device_aligned_end
-	unsigned int rxlen;
 };
 
 struct vgpio_irq_line {
-- 
MST


