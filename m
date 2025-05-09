Return-Path: <netdev+bounces-189214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFC9AB129B
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 13:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 859034A6685
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 11:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98114292093;
	Fri,  9 May 2025 11:51:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43127290BC4;
	Fri,  9 May 2025 11:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746791508; cv=none; b=L9EF0tUfBj2ZIEuzk6n/wq5AQX5VelNZ8SCH7H2TRt9GPe3s+yCwnZEgkN+TRVlSx+lswptrcxd6ACOFLsaghGGOcJvBM/t/CWJ+1tguoIzVHBU2RzFW6AhiL9DA6hQ/3Z7iOqeJKrXhdkCtot8IlrHqgJGRESJNgYUjJl+C1bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746791508; c=relaxed/simple;
	bh=2iMzVdlFrzD3Fj/Ndyc9URuSD+ZMGnQXSYGq+gYu9Fk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=IEAAgN1JvEDjQ3b0lBKX+qPfM79lqz5prAuoS66WHl4tyBShOhUcP7BXi2beL4qRJE0i6UUqqYI7cnjxWuq8OHdRWJUaCd9P2ztm7et0B+CU6dqfcTT67xrrOVtJkjFW2ExAz0tDuPBHNc0OADb5ZhQm/qb5hlzjJP/+PVhvRzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-7a-681dec491fdd
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
Subject: [RFC 14/19] mm: page_alloc: do not directly access page->pp_magic but use is_pp_page()
Date: Fri,  9 May 2025 20:51:21 +0900
Message-Id: <20250509115126.63190-15-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250509115126.63190-1-byungchul@sk.com>
References: <20250509115126.63190-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsXC9ZZnka7nG9kMg9bXxhZz1q9hs1j9o8Ji
	+YMdrBZfft5mt1i88BuzxZzzLSwWT489Yre4v+wZi8We9u3MFr0tv5ktmnasYLK4sK2P1eLy
	rjlsFvfW/Ge1OLZAzOLb6TeMFuv33WC1+P1jDpuDkMeWlTeZPHbOusvusWBTqcfmFVoeXTcu
	MXtsWtXJ5rHp0yR2jzvX9rB5nJjxm8Vj547PTB4fn95i8Xi/7yqbx+dNcgG8UVw2Kak5mWWp
	Rfp2CVwZS76/ZyvYw1Nx4NE69gbG2VxdjJwcEgImEiev/WWDsc80XmIBsdkE1CVu3PjJDGKL
	CBhKfH50HCjOxcEssJBZ4srin+wgCWGBeIkjm14wgtgsAqoSDzafA4vzCphJnLq5kRFiqLzE
	6g0HgAZxcHACxfs/qoOEhQRMJZZNWcAGMlNC4D+bxPlXs6COkJQ4uOIGywRG3gWMDKsYhTLz
	ynITM3NM9DIq8zIr9JLzczcxAqNgWe2f6B2Mny4EH2IU4GBU4uG1eC6bIcSaWFZcmXuIUYKD
	WUmE93mnTIYQb0piZVVqUX58UWlOavEhRmkOFiVxXqNv5SlCAumJJanZqakFqUUwWSYOTqkG
	RskU7jcWaTXXs743zfPIkItqm+E/VXpF4S7Tt4d41euud9uVCbwM79Pr/LKwfdE88YnKb4V6
	i1R63klctvr+0ON//pvFpf3yBa86RLKP+zndiPtb/UzfIl0r2WGpncKfyhhdh3K2Fi3L87Vm
	TP9tG7dzfdkWNyWreI7n28KQRedtL208IlSnxFKckWioxVxUnAgA7xMAv34CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsXC5WfdrOv5RjbD4MAdLYs569ewWaz+UWGx
	/MEOVosvP2+zWyxe+I3ZYs75FhaLp8cesVvcX/aMxWJP+3Zmi96W38wWTTtWMFkcnnuS1eLC
	tj5Wi8u75rBZ3Fvzn9Xi2AIxi2+n3zBarN93g9Xi9485bA7CHltW3mTy2DnrLrvHgk2lHptX
	aHl03bjE7LFpVSebx6ZPk9g97lzbw+ZxYsZvFo+dOz4zeXx8eovF4/2+q2wei198YPL4vEku
	gC+KyyYlNSezLLVI3y6BK2PJ9/dsBXt4Kg48WsfewDibq4uRk0NCwETiTOMlFhCbTUBd4saN
	n8wgtoiAocTnR8eB4lwczAILmSWuLP7JDpIQFoiXOLLpBSOIzSKgKvFg8zmwOK+AmcSpmxsZ
	IYbKS6zecABoEAcHJ1C8/6M6SFhIwFRi2ZQFbBMYuRYwMqxiFMnMK8tNzMwx1SvOzqjMy6zQ
	S87P3cQIDOlltX8m7mD8ctn9EKMAB6MSD6/Fc9kMIdbEsuLK3EOMEhzMSiK8zztlMoR4UxIr
	q1KL8uOLSnNSiw8xSnOwKInzeoWnJggJpCeWpGanphakFsFkmTg4pRoYH3H7eh/2fvG5VPpo
	98FrtuKWQsekpwUaWn/XvmDimrkoX+1Vy47a/rgH73Y6b2mYx6A7c83X7FSlZu72P8LV0c9v
	PkwV2ZvtvnPBut3ZlbcX6agqrXSZzXxb+9JD/Sz1L/8nHUkWeBn255zU59eRf9/zBGRdZPi5
	1fXGi806J7mUvWQTnlnNVGIpzkg01GIuKk4EANsHcBBlAgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

To simplify struct page, the effort to seperate its own descriptor from
struct page is required and the work for page pool is on going.

To achieve that, all the code should avoid accessing page pool members
of struct page directly, but use safe API for the corresponding purpose,
that is is_pp_page() in this case.

Use is_pp_page() instead of accessing the members directly, when
checking if a page comes from page pool or not.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 mm/page_alloc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a6fe1e9b95941..cf672b9ab7086 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -55,6 +55,7 @@
 #include <linux/delayacct.h>
 #include <linux/cacheinfo.h>
 #include <linux/pgalloc_tag.h>
+#include <net/page_pool/types.h> /* for page pool checking */
 #include <asm/div64.h>
 #include "internal.h"
 #include "shuffle.h"
@@ -899,7 +900,7 @@ static inline bool page_expected_state(struct page *page,
 			page->memcg_data |
 #endif
 #ifdef CONFIG_PAGE_POOL
-			((page->pp_magic & ~0x3UL) == PP_SIGNATURE) |
+			(is_pp_page(page)) |
 #endif
 			(page->flags & check_flags)))
 		return false;
@@ -928,7 +929,7 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
 		bad_reason = "page still charged to cgroup";
 #endif
 #ifdef CONFIG_PAGE_POOL
-	if (unlikely((page->pp_magic & ~0x3UL) == PP_SIGNATURE))
+	if (unlikely(is_pp_page(page)))
 		bad_reason = "page_pool leak";
 #endif
 	return bad_reason;
-- 
2.17.1


