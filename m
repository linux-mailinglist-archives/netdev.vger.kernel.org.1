Return-Path: <netdev+bounces-240218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D287C71AA7
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 02:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0443B349E02
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 01:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2435F25A626;
	Thu, 20 Nov 2025 01:11:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B171C254B18;
	Thu, 20 Nov 2025 01:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763601097; cv=none; b=uAmc8TZa8wf76XoM7rzHtvjYqFO8R+uxoXaqe0d6IAZaL0/K+jqf30dN8dTOlHnbSp842TCyPVxxHNxEGeRWeEPZRH6ad9RtMP8v+80rw43cvdPHFL0llhkgAvOMN+ngvf9wGcHx00wtBLvCns6THJ6YT+B6npJ1uRKpvinJRqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763601097; c=relaxed/simple;
	bh=tvJu9MYFspPxUcYcup8DqmUw+hO8Akr3THQmq0yUIo8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=a3xEptVMKbTBUbcrSce0XC50L5w6o/0Rxz6QmXEuL3UbZ0riMDHZjiamzTqXUwrDiv8ws0HQzTRQg3gFFs35kYUEowwNtO1d2PEtyTdseY/diARyL2hzSVAWxvwN9GLOSnO/DhNMKmP3Du0s5q5LkxtF87ELni+ctseuhtg8NEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-09-691e6ac0bb8f
From: Byungchul Park <byungchul@sk.com>
To: kuba@kernel.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	harry.yoo@oracle.com,
	hawk@kernel.org,
	andrew+netdev@lunn.ch,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	ziy@nvidia.com,
	willy@infradead.org,
	toke@redhat.com,
	asml.silence@gmail.com,
	alexanderduyck@fb.com,
	kernel-team@meta.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mohsin.bashr@gmail.com,
	almasrymina@google.com
Subject: [PATCH net-next] eth: fbnic: access @pp through netmem_desc instead of page
Date: Thu, 20 Nov 2025 10:11:18 +0900
Message-Id: <20251120011118.73253-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsXC9ZZnoe7BLLlMg+/HuS32NS1jtlj9o8Ji
	+YMdrBZzVm1jtJhzvoXF4uv6X8wWT489Yre4v+wZi8We9u3MFvsurmGzuLCtj9Vie8MDdovL
	u+awWdxb85/V4uSslSwWH0+cYLQ4tkDM4tvpN4wWlw4/YrGY3djHaPH7B1DZ7KP32B3EPLas
	vMnkMbH5HbvHzll32T0WbCr12LxCy2PTqk42j02fJgGFd3xm8jh3scKjt/kdm8fHp7dYPN7v
	u8rmcWbBEXaPz5vkAviiuGxSUnMyy1KL9O0SuDLu9WxjK3jNUbHqSwtrA+Me9i5GTg4JAROJ
	vg/tzF2MHGD2nquKIGE2AXWJGzd+MoPYIgK6Egc6JwPZXBzMAp+YJSYvus4EkhAWCJH4v3oD
	mM0ioCrRsPEHC4jNK2Aq8fL8LlaI+fISqzccAGuWEGhnl1i+5Q5UQlLi4IobLBMYuRcwMqxi
	FMrMK8tNzMwx0cuozMus0EvOz93ECIyCZbV/oncwfroQfIhRgINRiYc34phsphBrYllxZe4h
	RgkOZiURXlVHmUwh3pTEyqrUovz4otKc1OJDjNIcLErivEbfylOEBNITS1KzU1MLUotgskwc
	nFINjN6h16cvWWSzsTIiT1u/nJtRbsV2GS7V67dip3zc/it7T2zRm4O7rdf2fpcTvW4q86Cj
	rH+HiP/MGqadX1U4oo4Ya/hWOLleWxyo57/rh1X36nYZj4LQwgsp+y//szCVOB6cMLsyxiZc
	1Dful23rUja9lnmlyh3RL+4e2R399X5FwbKOlvIfSizFGYmGWsxFxYkAVscVQX4CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAwFlApr9CAMS0gMaCGludGVybmFsIgYKBApOO4MtwGoeaTCcrzA4voKmAzir
	+Hg4p+C4BTicqrYBOJzPhAQ49a/6AzjlxuIHON+m5gQ4vIe3Azi+0awGOMOdyQU40LaOBTi3
	gOAHONO6nAY43qz/BTjJmqkEOPHIyAE4xqAWOPbL7AE40sPiBDibgY4BOPv4nAY4m8XeB0AX
	SLSp2QJIkYPuB0i5mt0HSKCydUizqCpIsqqJBkiy8pIHSLm48wJIztF4SI2D7gZI8eXaBEjv
	vtUGSKPo8AJIzKDEB0jzsh5QD1oKPGRlbGl2ZXIvPmAKaN6MtgZw6wh4qvSEBYABvAeKAQgI
	GBA0GLzVIYoBCQgGECcY2Nj5A4oBCQgUEC0YwImTA4oBCggDEPIDGJOi1wKKAQkIExBUGP+r
	sAKKAQkIBBAlGICx+ASKAQkIDRA1GOnPugWKAQkIGBAfGKuwwAOQAQigAQCqARRpbnZtYWls
	NS5za2h5bml4LmNvbbIBBgoEpn38kbgB9NNHwgEQCAEiDA1Yxh1pEgVhdnN5bcIBGAgDIhQN
	JUEcaRINZGF5emVyb19ydWxlc8IBGwgEIhcNSldlYBIQZ2F0ZWtlZXBlcl9ydWxlc8IBAggJ
	GoABoJHbR2sVUCzxuoDwxyMmkqBXF4al3Xu+/KeWDFycuLHThKC1KVAB4UhuTInEILi7Yc9F
	LSPhohFt3YrI6sYdAyb4t6hro/hiVt9dUMepBuE0D0Iykco+5aIwqZWeTTBz+t7PiBCCGmPc
	hiTD6LBvqu4JFXow8q8jzbRTUA5WRDgiBHNoYTEqA3JzYZmxZ6JlAgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

To eliminate the use of struct page in page pool, the page pool users
should use netmem descriptor and APIs instead.

Make fbnic access @pp through netmem_desc instead of page.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
Changes from rfc:
	1. Use pp_page_to_nmdesc(page)->pp instead a wrong approach,
	   ring->page_pool. (feedbacked by Jakub)
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index c2d7b67fec28..56744e3a14ec 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -653,7 +653,8 @@ static void fbnic_clean_twq1(struct fbnic_napi_vector *nv, bool pp_allow_direct,
 				 FBNIC_TWD_TYPE_AL;
 		total_bytes += FIELD_GET(FBNIC_TWD_LEN_MASK, twd);
 
-		page_pool_put_page(page->pp, page, -1, pp_allow_direct);
+		page_pool_put_page(pp_page_to_nmdesc(page)->pp, page, -1,
+				   pp_allow_direct);
 next_desc:
 		head++;
 		head &= ring->size_mask;
-- 
2.17.1


