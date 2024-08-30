Return-Path: <netdev+bounces-123659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF59B966099
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 13:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E17A1C23080
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 11:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5581A4B61;
	Fri, 30 Aug 2024 11:24:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86F718EFD2;
	Fri, 30 Aug 2024 11:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725017091; cv=none; b=r3IAjduBekUuPHZqgnYIuho3h5yJ97DDkVby7+so1k2OxIReF7e+BESajjpm4Hb9ng3Nm2QaubJUuUwN4sbavbUyzsbEwb2GgqoXm7JTA+Ywnhkv3tE8FyjreRXe/CBr4mzl4pflfq/0AAiHnQhQfJm7epst6ZWofNSe+xSXQHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725017091; c=relaxed/simple;
	bh=YjChblqT8ejnQeRyDEtAzIoxui/q2RWJulwMvUn6uPU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kMI50Qj8Z0yrEKRE0jlEeKn252LtkB5PoUY6wk9orJBhPF9M8mie7T2XPoIsfeQ9y+B5izqPTBhaGU0Ks+jG063o0GNmjVyfXMV9vZLG8TsnJouleYsUpCa6Vn/JDt1eMiSyrhdn+MdYvJXiG16ThALmlI+0z8g8C8oG402OHLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WwG1d1YSFz1HHpv;
	Fri, 30 Aug 2024 19:21:25 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 39AF114011F;
	Fri, 30 Aug 2024 19:24:47 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 30 Aug 2024 19:24:47 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Max
 Filippov <jcmvbkbc@gmail.com>, Chris Zankel <chris@zankel.net>
Subject: [PATCH net-next v16 05/14] xtensa: remove the get_order() implementation
Date: Fri, 30 Aug 2024 19:18:35 +0800
Message-ID: <20240830111845.1593542-6-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240830111845.1593542-1-linyunsheng@huawei.com>
References: <20240830111845.1593542-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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


