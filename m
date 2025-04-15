Return-Path: <netdev+bounces-182623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADE2A895C4
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 09:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E9CA3AD770
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 07:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B09127A91C;
	Tue, 15 Apr 2025 07:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XXrsP9vI"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8FB2741D9
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 07:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744703841; cv=none; b=rd50WYQ2kZLcTNnlQx3SepIDsqnYV5ZvUWkLFVfX5P+1k+ntBIQbrSJK3e4IcAFgIHw6/vTe1wTtKUjlHg1WmCh9KZLkpU3RH6GhQcC98OMX63BjqlNX29JRN0uPcPiXVzsWdFJaZW0PjwnLnoWQJ5yPg1iyjQoJgjhR8rj5hlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744703841; c=relaxed/simple;
	bh=giz4j0di8x45JX73tax93daXh1FYeT2OGhiA13DCy8s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=G9tK052sklRB8m/8NGlNOW+sjuImU2k3AZR11E0uXXnS6Oej/snUibd8dDgs9GUdE5MNhVTTVLZHG5hhirLZGV6QJ8r3Pj7ITKby6DchT6N4XoV4eNu4klSajl0T262xKLk8whvq1oSU4OgUtGpDwCnV6pTnX3YGEfJPC1ZlhRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=XXrsP9vI; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250415075717euoutp0193136bdddd0d4b03095de2e3b721d982~2buVdRpYz0212202122euoutp01q
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 07:57:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250415075717euoutp0193136bdddd0d4b03095de2e3b721d982~2buVdRpYz0212202122euoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1744703837;
	bh=9e45tl3U5WqXrDT4GuRVMJTLipa5Aiiyo/TQqLRuxYI=;
	h=From:To:Cc:Subject:Date:References:From;
	b=XXrsP9vIqG7N0koJpar/bNTL5b3vhlfJCl3KOeUts1YgmcLrc1Dc7pjUJXaqDidgH
	 O0b4ctRgRHX1gKC66L0aSCU/Vva5thrK7xJs3W9FHaGMrW6KDdDAaS+if8S3V89J19
	 BjqqEktsHtAmZvJtc4XCu5QKh+QElj6evW6AyeG8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250415075716eucas1p2e23a083b2029042bde0ef625ddf6c700~2buVJ_HJ90425804258eucas1p2t;
	Tue, 15 Apr 2025 07:57:16 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id EF.D4.20821.C511EF76; Tue, 15
	Apr 2025 08:57:16 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250415075716eucas1p1a5343f5dec617f82f5adca300eb47485~2buU04X9B0922709227eucas1p1W;
	Tue, 15 Apr 2025 07:57:16 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250415075716eusmtrp2d73e5d5dff4a01c76aa99e83e0ec6853~2buU0WEku1629716297eusmtrp2f;
	Tue, 15 Apr 2025 07:57:16 +0000 (GMT)
X-AuditID: cbfec7f2-b09c370000005155-62-67fe115c1524
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 7F.A5.19920.C511EF76; Tue, 15
	Apr 2025 08:57:16 +0100 (BST)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250415075715eusmtip2be9d337bade51635ff7398aa409cc095~2buUTUpvU0228102281eusmtip2M;
	Tue, 15 Apr 2025 07:57:15 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Christoph Hellwig
	<hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>
Subject: [PATCH] dma-mapping: avoid potential unused data compilation
 warning
Date: Tue, 15 Apr 2025 09:56:59 +0200
Message-Id: <20250415075659.428549-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUwTURSFfTNDOzS2DgXlirg1gMGELRodxRBxHTXBPTHuVScVpVVbUDQG
	KyhCFQJEQEqxRSTKamQLoohtVMQNkIiKGhAJCIS6gCiLIO0I8u/c876Te27ySFycZuNEBiqC
	WaVCGiThCYiSx33VHjvthmTe7y+50THhyRidlfMIo/t7aLqmJNaGrivT8ei8hx/59GPDFNr4
	rcVmKcnkXs1FTEF2NI+5WrWR+VKYgpi779Q8JrYoGzHdBTM28LcLlhxggwKPs0ovv72Cg4aE
	LuJo88TQ1/FfMTV6ItAgWxKo+WA21yINEpBi6iaCmAfpODf0IMhs1+EWSkx1I2hL3TqauBBT
	h3HQDQTl18qJsURh02W+heJRPqDp0vA0iCQdqIVwO2+HhcGpdgStzy9ZGXtqPQzU9hIWTVCu
	UFkbjyxaSPlBdUQaj9s2EyqML3DOt4OqlBYrj4/4EcWp1qpAFZGQXPoI4wIrwKAdRJy2h47K
	Ij6nnWH4jh7jAhcQGAYa/w1xCNRtDf8SvvDhZb+1Nk65w60yL872h1TdL8xiAyWCt112XAkR
	JJQk45wthKhIMUe7gbYyf2ytseYVzmkGjH+GrLiY2gUxhUFxaJZ23GXacZdp/1cwIDwbObIh
	KrmMVfko2BOeKqlcFaKQee4/Ii9AIz/o2VDlj1KU1vHd04QwEpkQkLjEQShY3i8TCw9IT55i
	lUf2KEOCWJUJTSMJiaPwWsV5mZiSSYPZwyx7lFWOvmKkrZMam4zqJbrGiZG5UbNzmvFFIvtd
	K5sg4NOZPbXqVebnLSnM7fX6vLtNzu/2J62L/ZmY4Xv6zf2Za34114uWlbbTa/ycDERr96DE
	peZzv6leKM93eNpQygz62O9+XXZun0dYp+jVvc78lCy9zl10VqNzybyy19ScmBhK9KLrHra/
	M6YuyOevOr3Uf1uPOP2E4GZvgLc+uFGxc2H1j+GMenBvWhxuPjzf++WNt/5eCt/NfcfO5a77
	U945oS7b7BGtX83kdcwJ9RrQbXZqM55qDWtLav0KxdsDQ7F5fFNSxcfJwwFJhxzLtxFg6t7S
	tzZKPn2Sa1hxXHzDpovarJ+NVQ7RcXIJoToo9ZmLK1XSv55yjl2wAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsVy+t/xe7oxgv/SDRrfC1j0Nk1nsli5+iiT
	xa8vFhYXtvWxWlzeNYfNYu2Ru+wWxxaIWRz88ITVgcNjzbw1jB6bVnWyecw7GejxYvNMRo/d
	NxvYPPq2rGL0+LxJLoA9Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384m
	JTUnsyy1SN8uQS9jwaS3LAWPeCquTnzP1MB4gquLkZNDQsBEor33MlMXIxeHkMBSRolPq6ay
	QyRkJE5Oa2CFsIUl/lzrYoMo+sQoMXvdH2aQBJuAoUTXW5AEJ4eIgKXEut03WECKmAXeMkps
	3vmYCSQhLOArcerNQ0YQm0VAVeL4xYlgNq+AncT55rlsEBvkJfYfPMsMEReUODnzCQuIzQwU
	b946m3kCI98sJKlZSFILGJlWMYqklhbnpucWG+oVJ+YWl+al6yXn525iBIb/tmM/N+9gnPfq
	o94hRiYOxkOMEhzMSiK8XM6/0oV4UxIrq1KL8uOLSnNSiw8xmgLdN5FZSjQ5HxiBeSXxhmYG
	poYmZpYGppZmxkrivG6Xz6cJCaQnlqRmp6YWpBbB9DFxcEo1MO3YKq1uLVt/V8gy6JGyQo5T
	8ixl2fStb3inBbIxBem+Wrj1ptZOg08vfwvtZyrgU4o34n15VEZ9af6BsjeTeKNzfbf/4Njl
	+ko+X/l74Ibv9hM2Pr42v5FDOFxaYfXZv7UbHht9ku37Lmd04k5M59xLspuCgzctSHdXmW/+
	VYj9eSNT0+XCHdd+nTmbtObm/yUlB/7Ir65vj2ied8ktrvbRx7bC1X/LufZqyvyNOXDgYUAZ
	/yGv9BI2tvZ3W0VPZro2spZkZiWXd3R0L/6YdEBk49vUzIOfX3y6qJ/k0JNowZvvsGj6DV1F
	ppll4pViYVzzQy5WPZ+y4k7mjvUq+st+WLHuTfdMWrfVz1H5rRJLcUaioRZzUXEiALgxxXAI
	AwAA
X-CMS-MailID: 20250415075716eucas1p1a5343f5dec617f82f5adca300eb47485
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250415075716eucas1p1a5343f5dec617f82f5adca300eb47485
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250415075716eucas1p1a5343f5dec617f82f5adca300eb47485
References: <CGME20250415075716eucas1p1a5343f5dec617f82f5adca300eb47485@eucas1p1.samsung.com>

When CONFIG_NEED_DMA_MAP_STATE is not defined, dma-mapping clients might
report unused data compilation warnings for dma_unmap_*() calls
arguments. Redefine macros for those calls to let compiler to notice that
it is okay when the provided arguments are not used.

Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 include/linux/dma-mapping.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index b79925b1c433..85ab710ec0e7 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -629,10 +629,14 @@ static inline int dma_mmap_wc(struct device *dev,
 #else
 #define DEFINE_DMA_UNMAP_ADDR(ADDR_NAME)
 #define DEFINE_DMA_UNMAP_LEN(LEN_NAME)
-#define dma_unmap_addr(PTR, ADDR_NAME)           (0)
-#define dma_unmap_addr_set(PTR, ADDR_NAME, VAL)  do { } while (0)
-#define dma_unmap_len(PTR, LEN_NAME)             (0)
-#define dma_unmap_len_set(PTR, LEN_NAME, VAL)    do { } while (0)
+#define dma_unmap_addr(PTR, ADDR_NAME)           \
+	({ typeof(PTR) __p __maybe_unused = PTR; 0; })
+#define dma_unmap_addr_set(PTR, ADDR_NAME, VAL)  \
+	do { typeof(PTR) __p __maybe_unused = PTR; } while (0)
+#define dma_unmap_len(PTR, LEN_NAME)             \
+	({ typeof(PTR) __p __maybe_unused = PTR; 0; })
+#define dma_unmap_len_set(PTR, LEN_NAME, VAL)    \
+	do { typeof(PTR) __p __maybe_unused = PTR; } while (0)
 #endif
 
 #endif /* _LINUX_DMA_MAPPING_H */
-- 
2.34.1


