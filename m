Return-Path: <netdev+bounces-130756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A622A98B666
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 10:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D66C31C2204A
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 08:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5FD1BFE11;
	Tue,  1 Oct 2024 07:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWMqbYNl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A3D1BE854;
	Tue,  1 Oct 2024 07:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727769595; cv=none; b=e4nSFpbZxAL9Dwo84UZQTBxMyXjrk7ToJkefSwLldbh4UMLEnA3MoHQT/2PWbXl5sTyvyBD3q4bSe2ok836uDHPm5JZ2U+lT7p4/uwi4cXhUv1DwluOzYyhkgdnnHEWyFCLeJRUMP2kJdHqzTOmqwpguoejtj+ko+drwaqA63aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727769595; c=relaxed/simple;
	bh=0T9b0cXCJeMC0LrjWkbUmMV7IjhitTOlxdGgdVtqZqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VQ2M3eRc8U0A/UUx/C8oQd6+0RcJlHepETo0n8kOK4hGDf3T9/VBIYHs0UsDSjGz1ams8nMv18W5R9kfMY/WWUzCQ30PkDmc0b0VYjA4M21+YPh6DDXh/fF9YRkgOTqeHWI0runXrZFs6K7CZAhG/2Q4lZPVSTEySKYJi1yxK14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWMqbYNl; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-7d916b6a73aso3330165a12.1;
        Tue, 01 Oct 2024 00:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727769593; x=1728374393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADg4SjL/TdWbtGYAOROzU48mvQIzqBv73gL/8ReCbpM=;
        b=FWMqbYNlTO5TvZEXWGTB1Bpeaxq+CPZMFBFv3NsPg2iJ3LIv/gMptI1Fn7Nq8DcNpH
         dr4jUvf2zfoYLFONW+8gbdL5XB8ZW63+QQuevcfY9OSooc6vVGoBN7Q2VsjYpw8EiXwX
         dvHtnaN5qOFWrFTpRjHb6tZytnWbPRDjRjv2LjCaMkwR/LzM2TBBJk/JFH8JNlBF/Q28
         5tvll3NO3MYMStpdrF6qF2BRT8fkXeoKq5CIG+T4Gdixs+QBNgwx+1k5ZxTRSdvFJnZQ
         +K/+TVyfrFfrvRhWJ5vr/frBn7qFU4II3E3G2FRq3g8jeAoAY+tFhob76PLMbX4jNcdy
         eNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727769593; x=1728374393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADg4SjL/TdWbtGYAOROzU48mvQIzqBv73gL/8ReCbpM=;
        b=t3nmR+Gy95wtlphnR8NN/77JaPhoJYa/kVHqtyamPIDRotCwiN2JKVU01o6AP6o17X
         JAhq80Qvoi/fYALRJmsa8lnb0S1Y0FUCOxU82Rsy6BWH985mDv2MOBr01BY35Nxglpi2
         6ZcAvxF1/0HJ9+LG7hOXCdgpdF0xZQ8RAF2KkiBsBwvj6XTr5bFBMUnWtMD7/148ORWD
         1QHar49biOQ1GoYSZtedIGdT5wr5l5eAk2FchvxMNO4eAsBmZXMF2u9hiYm6/vgADrpq
         ywZL5gXaAuGuSS9rSsKJLz/Q1Bonsy3WrzefRB34VScs1SBniI0SkVub3K5AfAuL5M9O
         sv4A==
X-Forwarded-Encrypted: i=1; AJvYcCW9xTl2sgOqGrRGo2ls3US2RnYE8wjV6P3zPaSN1VuUEa53MTan1qeqrw5kUm0OjVA0hYEYZ1jGMOkKJQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLK0Nrn0w/yf7335ednhTD3ozSiZ/Dlrdcg5Hlx/rzrg2x+n5p
	wUm6FjuVj2xiEmTqB0H9RDVJ5PIYxseEqRekETpOoYKPkzUSepcO
X-Google-Smtp-Source: AGHT+IEMEMikIwAsGNCUaKklqicU3DUMXbKshUu12qfRtEdI3bF5DTyiGRaQfG0r7h/YT39HL2cwqg==
X-Received: by 2002:a05:6a20:cf84:b0:1cf:49a6:9933 with SMTP id adf61e73a8af0-1d4fa6c2f99mr18322559637.20.1727769593548;
        Tue, 01 Oct 2024 00:59:53 -0700 (PDT)
Received: from yunshenglin-MS-7549.. ([2409:8a55:301b:e120:88bd:a0fb:c6d6:c4a2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e16d6d2sm13168168a91.2.2024.10.01.00.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 00:59:53 -0700 (PDT)
From: Yunsheng Lin <yunshenglin0825@gmail.com>
X-Google-Original-From: Yunsheng Lin <linyunsheng@huawei.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Alexander Duyck <alexander.duyck@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Subject: [PATCH net-next v19 08/14] mm: page_frag: use __alloc_pages() to replace alloc_pages_node()
Date: Tue,  1 Oct 2024 15:58:51 +0800
Message-Id: <20241001075858.48936-9-linyunsheng@huawei.com>
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

It seems there is about 24Bytes binary size increase for
__page_frag_cache_refill() after refactoring in arm64 system
with 64K PAGE_SIZE. By doing the gdb disassembling, It seems
we can have more than 100Bytes decrease for the binary size
by using __alloc_pages() to replace alloc_pages_node(), as
there seems to be some unnecessary checking for nid being
NUMA_NO_NODE, especially when page_frag is part of the mm
system.

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 mm/page_frag_cache.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index 6f6e47bbdc8d..a5448b44068a 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -61,11 +61,11 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
 	gfp_mask = (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
 		   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
-	page = alloc_pages_node(NUMA_NO_NODE, gfp_mask,
-				PAGE_FRAG_CACHE_MAX_ORDER);
+	page = __alloc_pages(gfp_mask, PAGE_FRAG_CACHE_MAX_ORDER,
+			     numa_mem_id(), NULL);
 #endif
 	if (unlikely(!page)) {
-		page = alloc_pages_node(NUMA_NO_NODE, gfp, 0);
+		page = __alloc_pages(gfp, 0, numa_mem_id(), NULL);
 		order = 0;
 	}
 
-- 
2.34.1


