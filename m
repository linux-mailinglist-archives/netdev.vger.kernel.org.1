Return-Path: <netdev+bounces-51835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DC87FC664
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 21:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B7121C238C7
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 20:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358AC44377;
	Tue, 28 Nov 2023 20:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="mu35PtE5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2785210E
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 12:49:57 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-67a0d865738so30228296d6.1
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 12:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701204596; x=1701809396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YSGX0jW3To7/xuABL7QXXsr1KCFhu7Z9tThr0mLMrMc=;
        b=mu35PtE5c/9BIjstdYyMmHY7Fsp4p47cAFfxKfLsRGnfxku0i2aSW554C1uqlvpsQG
         7n+YTN7UVvy9Da+sXvjnrRbhflbjotnxSYc46MNpmRLi4IO0BtuqyB4DTLVKFRZBCQT6
         Gem7H6rBonm0+z37Y3eiO2PmFX83B5wvl1i16H3zAMIqCd+ebFYbcpQsJs88KGdQ3aQo
         dilQXr6/WXD8tF4AcdIY0AMHMjtiN5cKy4+xcwwc8ETsP9hjskymCjjVw3r727nJcZ4l
         P7VdPRIIVUXbGZOMRd7My622YMXRlrcltPLBtBUm4FJxlJ4gez9R4x93FrfNE6OSIGVC
         3cTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701204596; x=1701809396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSGX0jW3To7/xuABL7QXXsr1KCFhu7Z9tThr0mLMrMc=;
        b=ITrfGhb/4VFtxhGWmB+FY/Lf+tz53Kf9iekHT8mTToYyRD0d6GLKxCF+1YhWrJfrmP
         KSoPMP6KKQla7bygwZ7Ve1j1qWlhHHLv0sDGMMLDLOH5IwATmxYsOQJ/f/NQmqbe+WEo
         ap+itCPF+9Mqjn2yLJBt2fda0JHA3HuhshbAsIfoR/1LfTAwQOxv1mftAR9BnL58B/Y3
         Iudb2m0lGKOYzbPQBtQMBqIzu+bbAJNlbnrLqG4QgoXUhpnY5nztECjDiVy2kxWdqsyd
         d3wFlEYI0Y8dgnQ5zmGU4Eu6l5wY9If+7UGjJ+IBvcrR9rjV5IAjEbYksZy8+I+N2sHp
         Hhkw==
X-Gm-Message-State: AOJu0YyzvOcJjS/kY+wl3GsWGl2+BWOpZSXBoBXxjsBejRTb9QXSUkqj
	sqFaye20DDYnn2n/md2yZKiCjA==
X-Google-Smtp-Source: AGHT+IH3XyzLx3HqaxxWdryJd33MqMJHkx6z6Xt3swBEGkMdx9JQSLka9GW0WH1FkTVqo27TzFUimQ==
X-Received: by 2002:a05:6214:246f:b0:67a:4ba1:84d5 with SMTP id im15-20020a056214246f00b0067a4ba184d5mr7928400qvb.16.1701204596396;
        Tue, 28 Nov 2023 12:49:56 -0800 (PST)
Received: from soleen.c.googlers.com.com (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id d11-20020a0cfe8b000000b0067a56b6adfesm1056863qvs.71.2023.11.28.12.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 12:49:56 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	alex.williamson@redhat.com,
	alim.akhtar@samsung.com,
	alyssa@rosenzweig.io,
	asahi@lists.linux.dev,
	baolu.lu@linux.intel.com,
	bhelgaas@google.com,
	cgroups@vger.kernel.org,
	corbet@lwn.net,
	david@redhat.com,
	dwmw2@infradead.org,
	hannes@cmpxchg.org,
	heiko@sntech.de,
	iommu@lists.linux.dev,
	jasowang@redhat.com,
	jernej.skrabec@gmail.com,
	jgg@ziepe.ca,
	jonathanh@nvidia.com,
	joro@8bytes.org,
	kevin.tian@intel.com,
	krzysztof.kozlowski@linaro.org,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	lizefan.x@bytedance.com,
	marcan@marcan.st,
	mhiramat@kernel.org,
	mst@redhat.com,
	m.szyprowski@samsung.com,
	netdev@vger.kernel.org,
	pasha.tatashin@soleen.com,
	paulmck@kernel.org,
	rdunlap@infradead.org,
	robin.murphy@arm.com,
	samuel@sholland.org,
	suravee.suthikulpanit@amd.com,
	sven@svenpeter.dev,
	thierry.reding@gmail.com,
	tj@kernel.org,
	tomas.mudrunka@gmail.com,
	vdumpa@nvidia.com,
	virtualization@lists.linux.dev,
	wens@csie.org,
	will@kernel.org,
	yu-cheng.yu@intel.com
Subject: [PATCH 16/16] vfio: account iommu allocations
Date: Tue, 28 Nov 2023 20:49:38 +0000
Message-ID: <20231128204938.1453583-17-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommu allocations should be accounted in order to allow admins to
monitor and limit the amount of iommu memory.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 drivers/vfio/vfio_iommu_type1.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index eacd6ec04de5..b2854d7939ce 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1436,7 +1436,7 @@ static int vfio_iommu_map(struct vfio_iommu *iommu, dma_addr_t iova,
 	list_for_each_entry(d, &iommu->domain_list, next) {
 		ret = iommu_map(d->domain, iova, (phys_addr_t)pfn << PAGE_SHIFT,
 				npage << PAGE_SHIFT, prot | IOMMU_CACHE,
-				GFP_KERNEL);
+				GFP_KERNEL_ACCOUNT);
 		if (ret)
 			goto unwind;
 
@@ -1750,7 +1750,8 @@ static int vfio_iommu_replay(struct vfio_iommu *iommu,
 			}
 
 			ret = iommu_map(domain->domain, iova, phys, size,
-					dma->prot | IOMMU_CACHE, GFP_KERNEL);
+					dma->prot | IOMMU_CACHE,
+					GFP_KERNEL_ACCOUNT);
 			if (ret) {
 				if (!dma->iommu_mapped) {
 					vfio_unpin_pages_remote(dma, iova,
@@ -1845,7 +1846,8 @@ static void vfio_test_domain_fgsp(struct vfio_domain *domain, struct list_head *
 			continue;
 
 		ret = iommu_map(domain->domain, start, page_to_phys(pages), PAGE_SIZE * 2,
-				IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE, GFP_KERNEL);
+				IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE,
+				GFP_KERNEL_ACCOUNT);
 		if (!ret) {
 			size_t unmapped = iommu_unmap(domain->domain, start, PAGE_SIZE);
 
-- 
2.43.0.rc2.451.g8631bc7472-goog


