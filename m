Return-Path: <netdev+bounces-239759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B99C6C380
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 02:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0860E35BCAC
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 01:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E00F221299;
	Wed, 19 Nov 2025 01:12:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEF422A7F9;
	Wed, 19 Nov 2025 01:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763514744; cv=none; b=R3OE3zkUVsF/1nDj/L23xRKWj2po4EYHPpizlvgMrFHBPpeCw/q7BOL957R4nftRjSgiyI0hpSgib7288jxQlM2yiaX+VtLGchoLGRu023vp7LSP1gOxN9nsX8gGwjrYbGrjqFMlnUlGlQuux4wvPeD9+/nfIOxyHFwb4CMzUzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763514744; c=relaxed/simple;
	bh=QkEi/ceYmjtxEU5KBqH1IlnCXJeZUgN6Wulq4z6R80o=;
	h=From:To:Cc:Subject:Date:Message-Id; b=knVtTe40MMe3iJBbALf4ble0/hRpA71duKCAwWQhDLc1wJDMrAUIzfq9cQfmXEhWhV4D/vHlvo0ABLB0INGwUnMN9UWeoA1L/g6jE8uX9b3glnRE+XRkX/QiRc3W9up9SaZRlkdyyDIL1BNmPVbz0RipY97Uzhwnv1WT0CJRl60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-1c-691d195f68c3
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
	almasrymina@google.com,
	jdamato@fastly.com
Subject: [RFC net-next] eth: fbnic: use ring->page_pool instead of page->pp in fbnic_clean_twq1()
Date: Wed, 19 Nov 2025 10:11:46 +0900
Message-Id: <20251119011146.27493-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsXC9ZZnoW68pGymwf4fahb7mpYxW6z+UWGx
	/MEOVos5q7YxWsw538Ji8XX9L2aLp8cesVvcX/aMxWJP+3ZmixWT/rJb7Lu4hs3iwrY+Vovt
	DQ/YLS7vmsNmcW/Nf1aLk7NWslh8PHGC0eLYAjGLb6ffMFpcOvyIxWJ2Yx+jxe8fQGWzj95j
	dxD32LLyJpPH5Vt72DwmNr9j99g56y67x4JNpR6bV2h5bFrVyeax6dMkoPCOz0we5y5WePQ2
	v2Pz+Pj0FovH+31X2TzOLDjC7vF5k1wAfxSXTUpqTmZZapG+XQJXxowV55gKNnNWbJn6j62B
	8TN7FyMnh4SAicT8T2eZYezZS8+wgthsAuoSN278BIuLCOhKHOicDGRzcTALdLBI/HhzEKxZ
	WCBRYsuMf2BFLAKqEoc/N7KB2LwCphIfJ/dBDZWXWL3hAFizhEA/u8TXj3tYIBKSEgdX3GCZ
	wMi9gJFhFaNQZl5ZbmJmjoleRmVeZoVecn7uJkZgbCyr/RO9g/HTheBDjAIcjEo8vB38splC
	rIllxZW5hxglOJiVRHhVHWUyhXhTEiurUovy44tKc1KLDzFKc7AoifMafStPERJITyxJzU5N
	LUgtgskycXBKNTDGm+xfuGnhL9eoyWYit07o3yt70dxkdMxy0dODnRd5pPf9c5d199atKJl7
	dc6d0oaMFRe3qyb6fXa1WuIiPtFwTUX9fl6n5QsvLD3GPq2lQZp9w0fL/40ep07fXSRi8k5+
	pgqvFU+JgfPENIUcQYULR7K6Nq7bpRh7viJZ7HSNgBGzqf+aHbFKLMUZiYZazEXFiQCWGiPn
	iQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsXC5WfdrBsvKZtpMH2RsMW+pmXMFqt/VFgs
	f7CD1WLOqm2MFnPOt7BYfF3/i9ni6bFH7Bb3lz1jsdjTvp3ZYsWkv+wW+y6uYbM4PPckq8WF
	bX2sFtsbHrBbXN41h83i3pr/rBYnZ61ksfh44gSjxbEFYhbfTr9htLh0+BGLxezGPkaL3z+A
	ymYfvcfuIOGxZeVNJo/Lt/aweUxsfsfusXPWXXaPBZtKPTav0PLYtKqTzWPTp0lA4R2fmTzO
	Xazw6G1+x+bx8ektFo/3+66yeSx+8YHJ48yCI+wenzfJBQhEcdmkpOZklqUW6dslcGXMWHGO
	qWAzZ8WWqf/YGhg/s3cxcnJICJhIzF56hhXEZhNQl7hx4ycziC0ioCtxoHMykM3FwSzQwSLx
	481BsAZhgUSJLTP+gRWxCKhKHP7cyAZi8wqYSnyc3McMMVReYvWGA8wTGDkWMDKsYhTJzCvL
	TczMMdUrzs6ozMus0EvOz93ECAz0ZbV/Ju5g/HLZ/RCjAAejEg/vjwkymUKsiWXFlbmHGCU4
	mJVEeFUdgUK8KYmVValF+fFFpTmpxYcYpTlYlMR5vcJTE4QE0hNLUrNTUwtSi2CyTBycUg2M
	GYt2JXJmzPU+Uu/3ec/vmQ+nTppud+NvxN77myYFTPSbnloopSZ/gun+U33R7XVnQnxVr30K
	lzA2WuoTzyBoOC2nt1mEverBruXap8/tv++ZXCXz2u4vd43PziKjtsfKU+acuJVWsl7m/8sb
	pwoyT1zSSzc3Ly6r95Bvb9TVMPnf8r5ZRN1BiaU4I9FQi7moOBEAOo3XlXACAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

With the planned removal of @pp from struct page, we should access the
page pool pointer through other means.  Use @page_pool in struct
fbnic_ring instead.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
I should admit I'm not used to the following code.  So I'd like to ask
how to alter page->pp to avoid accessing @pp through struct page
directly.  Does the following change work?  Or can you suggest other
ways to achieve it?

	Byungchul
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index b1e8ce89870f..95f158ba6fa2 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -653,7 +653,7 @@ static void fbnic_clean_twq1(struct fbnic_napi_vector *nv, bool pp_allow_direct,
 				 FBNIC_TWD_TYPE_AL;
 		total_bytes += FIELD_GET(FBNIC_TWD_LEN_MASK, twd);
 
-		page_pool_put_page(page->pp, page, -1, pp_allow_direct);
+		page_pool_put_page(ring->page_pool, page, -1, pp_allow_direct);
 next_desc:
 		head++;
 		head &= ring->size_mask;
-- 
2.17.1


