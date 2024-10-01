Return-Path: <netdev+bounces-130753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6422398B660
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 10:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1020A1F22456
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 08:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDBC1BF7F1;
	Tue,  1 Oct 2024 07:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxadbwLj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51611BE24A;
	Tue,  1 Oct 2024 07:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727769581; cv=none; b=LsLuVLYMxzFExnRQwG9M92nIHNFwpKs83ojO/cPQe3ZKTHNpsEM3SS3rN8R5wjls8/8mhiHQS4zdOZf6ldFuXORD9xw8EoDxI2rDDEt6rLXqsMFOP5SaLsy+kJnRVTmpqGIQP0tnOn6/JWwAjUoQ2BAnYApPhtepweOLc/UVCi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727769581; c=relaxed/simple;
	bh=NtK2hGPktKlyk/2x5sS20q5yngdVO4+KhsIPU4dLYvg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ODLeJ5Je3s1jJLheQdsdD64ljHa+V1DD08oGF2c+GD60W1Hq+qnJppz7E2FbeQ6g/CpTi74RSDn/r4crp44DcgkKxSptinwMWlLcxn0y+w33n+08Yd6n28sgj761/C7oftY+5ufX6kKlKxFQ/WWvP0nscPK6BsZtO6FsevFaYxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OxadbwLj; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2e0a74ce880so4280592a91.2;
        Tue, 01 Oct 2024 00:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727769579; x=1728374379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RznI3L05JK1bZbiyr6s7rPTOWr3vTxyFhoEBxlvv1o=;
        b=OxadbwLjfLHhcMZzRRugjPi8D6CKBVRWTR09L1POpHxrOxT3F6JaIjHgM/nniUgFro
         p6ol70j8OJepyYHjt2AyvL7eZeUl/Ko4SNq5aYDPojNp7wPHACpHl5fesshA2jOtkYcU
         7ThFbLNH+NdA0v3kRfdad+Pc3FY13zmERYgHEezdZI0uZfeGPWxkEZuGflnsbhLxhhKa
         8WnrFyFR+aWaX5rtpLLL+XBGcPf+/YLBHYr1qrH8knaHFvYTP8roqUOpUBPH9/RfUvIm
         1gvOkss3NA1Al5pp2wzx1uasuVooUutqpzzAxVO4mGMsd7sNW4TYnGtSmUjuLiV8DGRy
         alfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727769579; x=1728374379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+RznI3L05JK1bZbiyr6s7rPTOWr3vTxyFhoEBxlvv1o=;
        b=dFsS1YjoYwPXdIPk84Rv+KCqvlPO2Z8/yxf+tsFL/6kKKI2+FjvNn7645iDcQ6XL8y
         fYuZzeI9jVFZhyKSDA7500spZ6E3/p02ChJxw92ER/s0+wCjVF9UOQqjScgsHZyyIhaz
         ZpsX6OJEb63QTuDWtzgcKatbrrq2fPmFNHmox1GGz9ldNFh4ig5q2OXGw4TawAcoIpkc
         khvhfETls/VJeOsHXHMGd9z7nXeyKMPiS+L0w7mpSNRxAgBEbiFdsO1oawXa0jTelCKC
         8coQ3KdjuzG/q2OmikfQnLjbY16JESrWKMuKeS9eLkoqzcIEeiGQ8AExBqGK9anCMyLr
         bWqg==
X-Forwarded-Encrypted: i=1; AJvYcCUsc9qXYYxuOdu8Wjr1czmdpr0ClUmFfwqmZHpvouq853PisDTvGywby5Xr45m4C8x4RXFKhtzrd7n2V6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpPw2K5EDcDnwtEd7Gnibr/RdP4O2sPwHIpWLDlmPPfEBk9y0U
	cpBXG3uY8l6af1RxgPIalh+Ayu5bsyl4Scg11despG8ElJmR3MwN
X-Google-Smtp-Source: AGHT+IHh5Q2dpV31K9qn7qcIqGa0E4bPCLWrnqG8WaQA27bq3t3Jru6lvAgsQ2LJq2Kbe+A5T9B44w==
X-Received: by 2002:a17:90b:3587:b0:2d8:ca33:42a5 with SMTP id 98e67ed59e1d1-2e0b8ee5895mr14441412a91.40.1727769578855;
        Tue, 01 Oct 2024 00:59:38 -0700 (PDT)
Received: from yunshenglin-MS-7549.. ([2409:8a55:301b:e120:88bd:a0fb:c6d6:c4a2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e16d6d2sm13168168a91.2.2024.10.01.00.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 00:59:38 -0700 (PDT)
From: Yunsheng Lin <yunshenglin0825@gmail.com>
X-Google-Original-From: Yunsheng Lin <linyunsheng@huawei.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Alexander Duyck <alexander.duyck@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Chris Zankel <chris@zankel.net>
Subject: [PATCH net-next v19 05/14] xtensa: remove the get_order() implementation
Date: Tue,  1 Oct 2024 15:58:48 +0800
Message-Id: <20241001075858.48936-6-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001075858.48936-1-linyunsheng@huawei.com>
References: <20241001075858.48936-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
2.34.1


