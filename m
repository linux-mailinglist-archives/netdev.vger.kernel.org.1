Return-Path: <netdev+bounces-189217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F5EAB12A7
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 13:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 060D352581B
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 11:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C2029372F;
	Fri,  9 May 2025 11:51:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E9A2918DC;
	Fri,  9 May 2025 11:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746791510; cv=none; b=g58jOhqCjQA3T0PAG62RYbcA7erifuI9gyLiYtDyLP6MXQkN/+F61ne8UKSFaVSMWtsaIl4NQ4NUxmojKXM6F7By+BWp5L3sItjJb1CzN0uajiOcp02ZhQTJD4UPUOyI4dB5y8oF/UgW3uzXc2SpUp7+4M8fMYNgKJ6uB3OZTmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746791510; c=relaxed/simple;
	bh=P4lYjrKn+hBN6dkHzEPzkQ/tgiyPOVAU0Xr1rVFaLVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=J4GirDSsHbCyOOU923tYEhy9fPtkWnGv9TrreCAhJpeYo4E9bOFDBrzxynd6CxkptsEQNSIYqSzfre6vqzVexdRLdQGtectwn7PPEqGJUUKv/k/TzArSqidPJ2os53HO9VpSXjZwA3m3WfFMLSBxprb/F4EAkjQi8U48MqP9qG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-8c-681dec494b65
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
Subject: [RFC 17/19] netmem: remove __netmem_get_pp()
Date: Fri,  9 May 2025 20:51:24 +0900
Message-Id: <20250509115126.63190-18-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250509115126.63190-1-byungchul@sk.com>
References: <20250509115126.63190-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsXC9ZZnka7XG9kMg+N3OC3mrF/DZrH6R4XF
	8gc7WC2+/LzNbrF44TdmiznnW1gsnh57xG5xf9kzFos97duZLXpbfjNbNO1YwWRxYVsfq8Xl
	XXPYLO6t+c9qcWyBmMW3028YLdbvu8Fq8fvHHDYHIY8tK28yeeycdZfdY8GmUo/NK7Q8um5c
	YvbYtKqTzWPTp0nsHneu7WHzODHjN4vHzh2fmTw+Pr3F4vF+31U2j8+b5AJ4o7hsUlJzMstS
	i/TtErgyZv2dyVLwlbNiw6uXjA2MCzi6GDk5JARMJJ68+8EGY3fP/8YCYrMJqEvcuPGTGcQW
	ETCU+PzoOFCci4NZYCGzxJXFP9lBEsICphKPlvcxgtgsAqoSTZPPgzXzCphJLO+6DzVUXmL1
	hgNAgzg4OIHi/R/VQcJCQK3LpixgA5kpIfCfTWL+t8PsEPWSEgdX3GCZwMi7gJFhFaNQZl5Z
	bmJmjoleRmVeZoVecn7uJkZgFCyr/RO9g/HTheBDjAIcjEo8vBbPZTOEWBPLiitzDzFKcDAr
	ifA+75TJEOJNSaysSi3Kjy8qzUktPsQozcGiJM5r9K08RUggPbEkNTs1tSC1CCbLxMEp1cDI
	7WvWfvzH0mcpoa0v2btlTzznKOa0ytKXScnN2DZznxJL69NTb2/npZnsnsJhVpB4ZZNvF+sT
	LgGPw9eX2P4+c/yN4I4zVu1NH5iYom3zDVRcEpZUxZR4Ogn/VmR8tzbbwepHtmzp5CePvTQN
	t20v36LstEzooaBqn/5dxw0+8qtk34lHHVJiKc5INNRiLipOBAD2TInOfgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsXC5WfdrOv5RjbD4NsNC4s569ewWaz+UWGx
	/MEOVosvP2+zWyxe+I3ZYs75FhaLp8cesVvcX/aMxWJP+3Zmi96W38wWTTtWMFkcnnuS1eLC
	tj5Wi8u75rBZ3Fvzn9Xi2AIxi2+n3zBarN93g9Xi9485bA7CHltW3mTy2DnrLrvHgk2lHptX
	aHl03bjE7LFpVSebx6ZPk9g97lzbw+ZxYsZvFo+dOz4zeXx8eovF4/2+q2wei198YPL4vEku
	gC+KyyYlNSezLLVI3y6BK2PW35ksBV85Kza8esnYwLiAo4uRk0NCwESie/43FhCbTUBd4saN
	n8wgtoiAocTnR8eB4lwczAILmSWuLP7JDpIQFjCVeLS8jxHEZhFQlWiafB6smVfATGJ51302
	iKHyEqs3HAAaxMHBCRTv/6gOEhYCal02ZQHbBEauBYwMqxhFMvPKchMzc0z1irMzKvMyK/SS
	83M3MQJDelntn4k7GL9cdj/EKMDBqMTDa/FcNkOINbGsuDL3EKMEB7OSCO/zTpkMId6UxMqq
	1KL8+KLSnNTiQ4zSHCxK4rxe4akJQgLpiSWp2ampBalFMFkmDk6pBsZ+iYUbfFVOLEpT+CZp
	YDR11bEL5zkK0nl0m4xF+My4ld2i1/5N1DqhLlbRaLLo6aMDAttjGRd0BossU/jEHlC/gHNR
	zNl/pbwrPh0Lt2BlFbypFK6wNO1ZxIxdPxtPPPb/WrvxjLOQ4r5b23b4ntld6je14/vCWU+3
	fD4/ZR7Dy3Je1t2cx5cpsRRnJBpqMRcVJwIA+dmTaWUCAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

There are no users of __netmem_get_pp().  Remove it.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/net/netmem.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index ce3765e675d19..00064e766b889 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -190,22 +190,6 @@ static inline struct netmem_desc *__netmem_clear_lsb(netmem_ref netmem)
 	return (struct netmem_desc *)((__force unsigned long)netmem & ~NET_IOV);
 }
 
-/**
- * __netmem_get_pp - unsafely get pointer to the &page_pool backing @netmem
- * @netmem: netmem reference to get the pointer from
- *
- * Unsafe version of netmem_get_pp(). When @netmem is always page-backed,
- * e.g. when it's a header buffer, performs faster and generates smaller
- * object code (avoids clearing the LSB). When @netmem points to IOV,
- * provokes invalid memory access.
- *
- * Return: pointer to the &page_pool (garbage if @netmem is not page-backed).
- */
-static inline struct page_pool *__netmem_get_pp(netmem_ref netmem)
-{
-	return __netmem_to_page(netmem)->pp;
-}
-
 static inline struct page_pool *netmem_get_pp(netmem_ref netmem)
 {
 	return __netmem_clear_lsb(netmem)->pp;
-- 
2.17.1


