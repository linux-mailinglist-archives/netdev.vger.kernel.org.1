Return-Path: <netdev+bounces-246918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDFECF26E7
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 09:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 63BE930081AA
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 08:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1C8314A85;
	Mon,  5 Jan 2026 08:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CXScU0yU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FzAXECaK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD3D31A818
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 08:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601395; cv=none; b=a0wId63/xCI5sZ9iqnUZVsSauUPPjlahvmH/UsHz81qvJt4BgW4/XcaVbyLaUDRlVr1ZsUdFtajxSO+e86hxmifAZzx/lUcw18FclIGBYtlLXihS2nzS8Hdpw4CYglYNCA76IGEVVAjdWxv1yYis6kqT6uovbQMufzSIBGrxrN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601395; c=relaxed/simple;
	bh=3EF4beueqssYSrJr7jAiyWtRxi/ynmIi31SbgxtAbxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkeZ0ZQOmeLYYFACeRiM7a0Oy/YOGAWdK1MRXmQ/3CbYUvlakUYCeBjW4lx3gSg9e5igrqQ4BFO+Un5JC5vX8pBfOsSWIb1LniHGOo2ClZLs3dEWLRI5u7AzbkqeHbzhqKngh7Q1KAf6b1w91K9fH550jWYHBZ6bkQajzpuu9Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CXScU0yU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FzAXECaK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767601393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jlkdUJvLxIuG9RkypEQ1odBgc8hsD/vyeqVzWJtThQg=;
	b=CXScU0yUsmYCDOQB5xcdy0Uho4lF1jibqQahcGQdTvyIccbDT2wuFdB11xq1JpPjGJzk/Y
	Bm9W8uHu4qIh+sUlesivb/ObpdYppppXs0HPLI4MgrPdyZRIyWvXJs/j1G1KjVt49LkFkq
	MRyJ+XzZN6fmEh2yyAUbYl88NlCkweA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-aMmJRi9uO0GwPLEZAOsdFg-1; Mon, 05 Jan 2026 03:23:12 -0500
X-MC-Unique: aMmJRi9uO0GwPLEZAOsdFg-1
X-Mimecast-MFC-AGG-ID: aMmJRi9uO0GwPLEZAOsdFg_1767601391
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43101a351c7so11004970f8f.2
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 00:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767601391; x=1768206191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jlkdUJvLxIuG9RkypEQ1odBgc8hsD/vyeqVzWJtThQg=;
        b=FzAXECaK9cpyvzSFZy2EhuHAzlJYHYh1Ucgh0W27TOzjOUZxhoOG8f84Akx1O9zwx4
         CC0i5zi+JAF8JUzNa7jRnGOZgifzp6xP185MLdaxTMhpb3BVub6wsldVxzkRMP7sKCTF
         Wh/9qnZIFH/gtILXIgimM1Q5mF9HE/JX85wGVPpWlctAAhY18PWOK37gvJbETMTa+Spt
         42RiCPItEDLPj+tnu4dl2DVDx41dLyN2aEcuuR2R8kpPrI9Bdk9r7F9OUYvygjmLA4ap
         M0wbuEybZHozcmrIpXIOxIo5REsr3F6Y+qMZG2Jrxljck8M9b1jbMaSbfzVjBHILnQ7A
         q+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767601391; x=1768206191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jlkdUJvLxIuG9RkypEQ1odBgc8hsD/vyeqVzWJtThQg=;
        b=wE1t8/evpmig43Q2ilg9KVKCWtpGbYCugCaZQrfItsu3VhRt4uTG9cI/mojoAf09V+
         URfER8n9fzf4PTtHdGYGn5Vy+ejiAawwnKRYVXNnYO6mXGMcF6Rtd87T0k0x1+h3PIt5
         v3hbW1x0nQ8Z0EozaEoIb81WOwX5aBueGueLrWxdmvge8yhC+BYe3AB7cV/UUP2riYGA
         eOA+zwb7WQWr5CCuoRLyskIjCuzer/q5i1Sp36OusvLYxXMESNiAsabI0FG83bl5dehg
         /7baAMtxVGELsZI0eGujOTuwoSI3BWrKKVfvPylamKzFoJYTNmFLuSeHsGMSmOqOajs2
         nKJw==
X-Forwarded-Encrypted: i=1; AJvYcCVJR5VSKWLLo3Gw0oy8YCG3VOCp8d/vv+x6D1qWgiQZqRhg97GVkMksYS8lC/mqZpRxMKPn8p0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL+HGHlDUWKKlflpxiPEBL6uZv5CgP8YS1/DrbLTpFY+p5byfL
	LASW2USDTv9rialxp3NoinA5dC1S9m251KRC2atD3WTYHA3uMW2Tj3Xz4pdBjCuuXXK7i0c31bU
	Ln8iTV1Jfg/2yqf7ZuGn7xNowV9sG7mqepDCpSkyjqSyXm/5H8VJSRHxTVg==
X-Gm-Gg: AY/fxX4naqj4fx6VVf4mqbGfFWdp0K3j0UsLcLWsC38tt5k6q0GsXuZfPYmE6L6NQ/x
	7kb8GRwUSPh9bkC31SaGPS6R0+FoIsPO7UPxshHIUovK12PzqLT/AKwiXCKngb/MuW6pSabjshb
	WUyGpzOowIik4uPX+4lDHyJModu+TOvZRskB4hQ++dyIGq3TflDi0OQyjvxQyiqlevlZ22HvBDv
	2oTRaGd0dZ0AQ7ocR7XaaBh2dyhv7N9DzY9YifOdz1CgA9+c13KJrv0Nj8pgpTKr8V5dFqWVp2K
	mkIA/tJjKj+GmtONnIKSSpY9srJH2SG0M6RD71WCImIRpctVUg36ZXlwsmfj/Yep8yZpup0UhDc
	A/HW0QAITj6PFOZXEXMAMoGzIuBPE+uoNCQ==
X-Received: by 2002:a05:6000:2c03:b0:42f:bbc6:edc1 with SMTP id ffacd0b85a97d-4324e4c1230mr54966713f8f.1.1767601390676;
        Mon, 05 Jan 2026 00:23:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwk1Ttr1N2m9x2GBHG1pWtih6zeyM7Sr9HAGjGkjK9L3/ihsrFeD/P27Wy0cj6YonFT6KolQ==
X-Received: by 2002:a05:6000:2c03:b0:42f:bbc6:edc1 with SMTP id ffacd0b85a97d-4324e4c1230mr54966659f8f.1.1767601390077;
        Mon, 05 Jan 2026 00:23:10 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa64cesm99604028f8f.35.2026.01.05.00.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 00:23:09 -0800 (PST)
Date: Mon, 5 Jan 2026 03:23:05 -0500
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
Subject: [PATCH v2 04/15] docs: dma-api: document DMA_ATTR_CPU_CACHE_CLEAN
Message-ID: <0720b4be31c1b7a38edca67fd0c97983d2a56936.1767601130.git.mst@redhat.com>
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

Document DMA_ATTR_CPU_CACHE_CLEAN as implemented in the
previous patch.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 Documentation/core-api/dma-attributes.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/core-api/dma-attributes.rst b/Documentation/core-api/dma-attributes.rst
index 0bdc2be65e57..1d7bfad73b1c 100644
--- a/Documentation/core-api/dma-attributes.rst
+++ b/Documentation/core-api/dma-attributes.rst
@@ -148,3 +148,12 @@ DMA_ATTR_MMIO is appropriate.
 For architectures that require cache flushing for DMA coherence
 DMA_ATTR_MMIO will not perform any cache flushing. The address
 provided must never be mapped cacheable into the CPU.
+
+DMA_ATTR_CPU_CACHE_CLEAN
+------------------------
+
+This attribute indicates the CPU will not dirty any cacheline overlapping this
+DMA_FROM_DEVICE/DMA_BIDIRECTIONAL buffer while it is mapped. This allows
+multiple small buffers to safely share a cacheline without risk of data
+corruption, suppressing DMA debug warnings about overlapping mappings.
+All mappings sharing a cacheline should have this attribute.
-- 
MST


