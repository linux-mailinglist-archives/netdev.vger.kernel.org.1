Return-Path: <netdev+bounces-189210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1015AB1295
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 13:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 632224A6873
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 11:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD912918CF;
	Fri,  9 May 2025 11:51:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837A728FFEC;
	Fri,  9 May 2025 11:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746791507; cv=none; b=V59zYtRRjKywWXXKV9zf14DTz5qUxu4z4MbDmm+vaCTSNw1ZliMxzfqb4GNhpInb9R1z85YXEcDWeC4tUQT6gro2mPWqfbQctW78ifMgdBYrbE+X5H3x4cI0cE3jvWDPNtub1gJYEG/wSpfg5AsN7zjqy4uSFb0rjDt7JgN6+aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746791507; c=relaxed/simple;
	bh=DA9jKs0Qda8IqZ65NNV2UZpPRNKW+Kk9K4H926UA2rU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Whk+25ir61+//RueZK9a8cCaR9StcvZ7DccvICnzmXl5FCBVM+uR3cY5lflbGJSodBRz5hDoPn8JOFckGBMKdzY8J5lq8wArZEi7fQ5S0UzLcneSdv/ekCkDqhGFqKbQCc+HrnlNDavaxbjihqvlpCwlRTUy8/YwwNV3h8lTO94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-56-681dec4911e8
From: Byungchul Park <byungchul@sk.com>
To: willy@infradead.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	kuba@kernel.org,
	almasrymina@google.com,
	ilias.apalodimas@linaro.org,
	harry.yoo@oracle.com,
	hawk@kernel.org,
	akpm@linux-foundation.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	john.fastabend@gmail.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	pabeni@redhat.com,
	vishal.moola@gmail.com
Subject: [RFC 08/19] page_pool: rename __page_pool_release_page_dma() to __page_pool_release_netmem_dma()
Date: Fri,  9 May 2025 20:51:15 +0900
Message-Id: <20250509115126.63190-9-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250509115126.63190-1-byungchul@sk.com>
References: <20250509115126.63190-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsXC9ZZnoa7nG9kMg3vN8hZz1q9hs1j9o8Ji
	+YMdrBZfft5mt1i88BuzxZzzLSwWT489Yre4v+wZi8We9u3MFr0tv5ktmnasYLK4sK2P1eLy
	rjlsFvfW/Ge1OLZAzOLb6TeMFuv33WC1+P1jDpuDkMeWlTeZPHbOusvusWBTqcfmFVoeXTcu
	MXtsWtXJ5rHp0yR2jzvX9rB5nJjxm8Vj547PTB4fn95i8Xi/7yqbx+dNcgG8UVw2Kak5mWWp
	Rfp2CVwZay4vZSt4yFmxZ8MZtgbGeRxdjJwcEgImEp9PTWSEsZd8uc0GYrMJqEvcuPGTGcQW
	ETCU+PzoOEsXIxcHs8BCZokri3+ygySEBTIlvty/BdbMIqAq8ezgNlYQm1fAVOL0k6WsEEPl
	JVZvOAA0iIODU8BMov+jOkhYCKhk2ZQFbCAzJQSa2SXOLVjBBlEvKXFwxQ2WCYy8CxgZVjEK
	ZeaV5SZm5pjoZVTmZVboJefnbmIERsGy2j/ROxg/XQg+xCjAwajEw2vxXDZDiDWxrLgy9xCj
	BAezkgjv806ZDCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8Rt/KU4QE0hNLUrNTUwtSi2CyTByc
	Ug2M4dG8Pi/iLucUyVf4HvtU7/pmD+vWc1W6Fpw2R44IP82Peic8eetBRh2bvhtCdtWvj7B/
	Mv8p9vTrlntT5u0P47zLZj/NQfGA/KKtaaqxQkIObxVeJK2781FC5ZBfu7ejn1v0f5dH+cYe
	wYVphnm3tTirJ86+6e3Om3KIT/EX7/LdIWw760qUWIozEg21mIuKEwG94xq1fgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsXC5WfdrOv5RjbD4PYPUYs569ewWaz+UWGx
	/MEOVosvP2+zWyxe+I3ZYs75FhaLp8cesVvcX/aMxWJP+3Zmi96W38wWTTtWMFkcnnuS1eLC
	tj5Wi8u75rBZ3Fvzn9Xi2AIxi2+n3zBarN93g9Xi9485bA7CHltW3mTy2DnrLrvHgk2lHptX
	aHl03bjE7LFpVSebx6ZPk9g97lzbw+ZxYsZvFo+dOz4zeXx8eovF4/2+q2wei198YPL4vEku
	gC+KyyYlNSezLLVI3y6BK2PN5aVsBQ85K/ZsOMPWwDiPo4uRk0NCwERiyZfbbCA2m4C6xI0b
	P5lBbBEBQ4nPj46zdDFycTALLGSWuLL4JztIQlggU+LL/VuMIDaLgKrEs4PbWEFsXgFTidNP
	lrJCDJWXWL3hANAgDg5OATOJ/o/qIGEhoJJlUxawTWDkWsDIsIpRJDOvLDcxM8dUrzg7ozIv
	s0IvOT93EyMwpJfV/pm4g/HLZfdDjAIcjEo8vBbPZTOEWBPLiitzDzFKcDArifA+75TJEOJN
	SaysSi3Kjy8qzUktPsQozcGiJM7rFZ6aICSQnliSmp2aWpBaBJNl4uCUamDkE1FWNdsfGegT
	fJhfLODmCjnJp9miH4NnVr02056ztzx+lQS/SFfP/IcuNw78WLw2cJEm56X6/T3T1jSLz33h
	K6W8xHdRrdDluoeXJTaxsrTzlzEoxvY9vJrEMz/g5+ctt41Y7nq/FZw0K2yTZ/WVyIZ/Wazv
	lh8OvPR2qdnhZoO4WM1V2/4psRRnJBpqMRcVJwIAp1mvwmUCAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Now that __page_pool_release_page_dma() is for releasing netmem, not
struct page, rename it to __page_pool_release_netmem_dma() to reflect
what it does.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 net/core/page_pool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 311d0ef620ea1..47164d561d1aa 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -653,7 +653,7 @@ void page_pool_clear_pp_info(netmem_ref netmem)
 	netmem_set_pp(netmem, NULL);
 }
 
-static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
+static __always_inline void __page_pool_release_netmem_dma(struct page_pool *pool,
 							 netmem_ref netmem)
 {
 	dma_addr_t dma;
@@ -687,7 +687,7 @@ static void page_pool_return_netmem(struct page_pool *pool, netmem_ref netmem)
 	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops)
 		put = pool->mp_ops->release_netmem(pool, netmem);
 	else
-		__page_pool_release_page_dma(pool, netmem);
+		__page_pool_release_netmem_dma(pool, netmem);
 
 	/* This may be the last page returned, releasing the pool, so
 	 * it is not safe to reference pool afterwards.
-- 
2.17.1


