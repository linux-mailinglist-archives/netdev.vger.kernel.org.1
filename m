Return-Path: <netdev+bounces-136965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D569A3CA4
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 13:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D830C280DDB
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 11:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142C3206E7D;
	Fri, 18 Oct 2024 11:00:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642DF205AD1;
	Fri, 18 Oct 2024 11:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729249222; cv=none; b=HUVrE7LtLE6OLmxzE7zSZCzcvRLd1239+qs9ga0eVFjGdSCxl3iHRnaEmtn8Sp736HByGQnn7HeMoDS7n2q/BSPu2IOUgKT03m2wIROs1aKu9JfENgabHrTVZft8CaSMMqna7ZyYOovzwECDvq4zI//5rjWDtcybEQLUKomPOkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729249222; c=relaxed/simple;
	bh=yHtnCHg0Gu6pqRoGz7RGYAKv3M4cju4Qz+dhzi79qDk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sQk9keunYSfcXv5QZRBPSfRkJtK44idBh8N2PC55vKDpmw4S9Qtgqq8Ash3fI4jFFysn5GcIuIEjcHMd60CdjqLPSz4A87Jcp/50kXVtUd/yLWD3leqplCw9aSeVPEdrNTCR6TbV8iifx55egcbzxpXxmgAPtUGh9vbWc5wlylY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XVMC95Zzyz1SCxC;
	Fri, 18 Oct 2024 18:59:01 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 2CA071A0188;
	Fri, 18 Oct 2024 19:00:19 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Oct 2024 19:00:18 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Max
 Filippov <jcmvbkbc@gmail.com>, Alexander Duyck <alexanderduyck@fb.com>, Chris
 Zankel <chris@zankel.net>
Subject: [PATCH net-next v22 05/14] xtensa: remove the get_order() implementation
Date: Fri, 18 Oct 2024 18:53:42 +0800
Message-ID: <20241018105351.1960345-6-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241018105351.1960345-1-linyunsheng@huawei.com>
References: <20241018105351.1960345-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

As the get_order() implemented by xtensa supporting 'nsau'
instruction seems be the same as the generic implementation
in include/asm-generic/getorder.h when size is not a constant
value as the generic implementation calling the fls*() is also
utilizing the 'nsau' instruction for xtensa.

So remove the get_order() implemented by xtensa, as using the
generic implementation may enable the compiler to do the
computing when size is a constant value instead of runtime
computing and enable the using of get_order() in BUILD_BUG_ON()
macro in next patch.

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
---
 arch/xtensa/include/asm/page.h | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/arch/xtensa/include/asm/page.h b/arch/xtensa/include/asm/page.h
index 4db56ef052d2..8665d57991dd 100644
--- a/arch/xtensa/include/asm/page.h
+++ b/arch/xtensa/include/asm/page.h
@@ -109,26 +109,8 @@ typedef struct page *pgtable_t;
 #define __pgd(x)	((pgd_t) { (x) } )
 #define __pgprot(x)	((pgprot_t) { (x) } )
 
-/*
- * Pure 2^n version of get_order
- * Use 'nsau' instructions if supported by the processor or the generic version.
- */
-
-#if XCHAL_HAVE_NSA
-
-static inline __attribute_const__ int get_order(unsigned long size)
-{
-	int lz;
-	asm ("nsau %0, %1" : "=r" (lz) : "r" ((size - 1) >> PAGE_SHIFT));
-	return 32 - lz;
-}
-
-#else
-
 # include <asm-generic/getorder.h>
 
-#endif
-
 struct page;
 struct vm_area_struct;
 extern void clear_page(void *page);
-- 
2.33.0


