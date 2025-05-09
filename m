Return-Path: <netdev+bounces-189208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3038BAB1299
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 13:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69232A041C9
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 11:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC68F2918C5;
	Fri,  9 May 2025 11:51:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838F528FFED;
	Fri,  9 May 2025 11:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746791507; cv=none; b=STBnbqrlqU/YJGGVK0jCQnT574fK833OQyqkBs3taipzS0ifgANPhQEgpq/lleTG0iwG/i2XkMv/zqz1yLtZeuQkEe6KhDhb7aaDqqS1GUabYHZtTVos2NfWDL1GQVQFjzRnckqB6JHg6w+WMaOJM3dd09lgu7aH6iJze7sX2Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746791507; c=relaxed/simple;
	bh=Bad1PLduXW27p+j9Xa6JrsTsCSPwcFD0YvcDAM5wysQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=FJ1KTpP+W653rYHdM/Lh9pl0/bcxen+lHCAR2QFUmxyaWrCfRblRVtDPANPHTX/4Yj9BT/dgkOnBUz543Ouruh7vbCOhBJRyCenVf01vcXvwJGQyBeTWDtFZx2PxhW/fAemHbbj1Gx96P8CFW8SHH9Wf807z0X3H3vChF/UNpNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-62-681dec49e1aa
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
Subject: [RFC 10/19] page_pool: rename __page_pool_alloc_pages_slow() to __page_pool_alloc_netmems_slow()
Date: Fri,  9 May 2025 20:51:17 +0900
Message-Id: <20250509115126.63190-11-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250509115126.63190-1-byungchul@sk.com>
References: <20250509115126.63190-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsXC9ZZnoa7nG9kMg2/NahZz1q9hs1j9o8Ji
	+YMdrBZfft5mt1i88BuzxZzzLSwWT489Yre4v+wZi8We9u3MFr0tv5ktmnasYLK4sK2P1eLy
	rjlsFvfW/Ge1OLZAzOLb6TeMFuv33WC1+P1jDpuDkMeWlTeZPHbOusvusWBTqcfmFVoeXTcu
	MXtsWtXJ5rHp0yR2jzvX9rB5nJjxm8Vj547PTB4fn95i8Xi/7yqbx+dNcgG8UVw2Kak5mWWp
	Rfp2CVwZvW1zGAuOclbMXp/RwNjH0cXIySEhYCJx6/c7dhi77+5iZhCbTUBd4saNn2C2iICh
	xOdHx1m6GLk4mAUWMktcWfwTrEFYIFPi6sTnTF2MHBwsAqoSt9aAzeQVMJNYfPIyE8RMeYnV
	Gw4wg5RwAsX7P6qDhIUETCWWTVnABlHyn03iySkvCFtS4uCKGywTGHkXMDKsYhTKzCvLTczM
	MdHLqMzLrNBLzs/dxAgM/2W1f6J3MH66EHyIUYCDUYmH1+K5bIYQa2JZcWXuIUYJDmYlEd7n
	nTIZQrwpiZVVqUX58UWlOanFhxilOViUxHmNvpWnCAmkJ5akZqemFqQWwWSZODilGhi1FQ+L
	rLObE71FfILzw3O/zL+nzawseGfKe1u79Geql5Bt/a52ycymMs2rZwRvZNnLfJavr7KPqFJz
	7Lt4vG6uRsf9huMn8kXvNdy8mh51Wt6k/6blzb6IPT2ves/48myefrDo7gMTH9PY4xuX7OJa
	MuNi7c3GBXJ2Jhw33ma9mpjblWirmK3EUpyRaKjFXFScCACh66yiewIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsXC5WfdrOv5RjbDoOmajMWc9WvYLFb/qLBY
	/mAHq8WXn7fZLRYv/MZsMed8C4vF02OP2C3uL3vGYrGnfTuzRW/Lb2aLph0rmCwOzz3JanFh
	Wx+rxeVdc9gs7q35z2pxbIGYxbfTbxgt1u+7wWrx+8ccNgdhjy0rbzJ57Jx1l91jwaZSj80r
	tDy6blxi9ti0qpPNY9OnSewed67tYfM4MeM3i8fOHZ+ZPD4+vcXi8X7fVTaPxS8+MHl83iQX
	wBfFZZOSmpNZllqkb5fAldHbNoex4Chnxez1GQ2MfRxdjJwcEgImEn13FzOD2GwC6hI3bvwE
	s0UEDCU+PzrO0sXIxcEssJBZ4srin+wgCWGBTImrE58zdTFycLAIqErcWgM2h1fATGLxyctM
	EDPlJVZvOMAMUsIJFO//qA4SFhIwlVg2ZQHbBEauBYwMqxhFMvPKchMzc0z1irMzKvMyK/SS
	83M3MQLDeVntn4k7GL9cdj/EKMDBqMTDa/FcNkOINbGsuDL3EKMEB7OSCO/zTpkMId6UxMqq
	1KL8+KLSnNTiQ4zSHCxK4rxe4akJQgLpiSWp2ampBalFMFkmDk6pBkbvt0efW76vldkv2vjm
	QEjCkUtXFus9ZU51ZNg8i7fP8PfF58p1V3a5P1R4YBF5+H61Cc/v1c7SF2eGXzkxwzBDrezq
	pIX7fk/atf8f38cVW+oYlFo2TX9t4huwgTuJT7iGXe5f0KSGPVVTbYMNvk6zc2Rj0eG2n7Ni
	h7PDjPBH51NXZynqtvxVYinOSDTUYi4qTgQAAsLWhmMCAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Now that __page_pool_alloc_pages_slow() is for allocating netmem, not
struct page, rename it to __page_pool_alloc_netmems_slow() to reflect
what it does.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 net/core/page_pool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index f858a5518b7a4..b61c1038f4c68 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -523,7 +523,7 @@ static netmem_ref __page_pool_alloc_large_netmem(struct page_pool *pool,
 }
 
 /* slow path */
-static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
+static noinline netmem_ref __page_pool_alloc_netmems_slow(struct page_pool *pool,
 							gfp_t gfp)
 {
 	const int bulk = PP_ALLOC_CACHE_REFILL;
@@ -595,7 +595,7 @@ netmem_ref page_pool_alloc_netmems(struct page_pool *pool, gfp_t gfp)
 	if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops)
 		netmem = pool->mp_ops->alloc_netmems(pool, gfp);
 	else
-		netmem = __page_pool_alloc_pages_slow(pool, gfp);
+		netmem = __page_pool_alloc_netmems_slow(pool, gfp);
 	return netmem;
 }
 EXPORT_SYMBOL(page_pool_alloc_netmems);
-- 
2.17.1


