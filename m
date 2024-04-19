Return-Path: <netdev+bounces-89758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E518AB733
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 00:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDCBDB2185A
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 22:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25D913D289;
	Fri, 19 Apr 2024 22:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aOmLQCrt"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E637D139583
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 22:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713565419; cv=none; b=pXHpKjC3VL1C4pJJTuc/kphp8Mh9xWQKr8J7lAA8QPZ0zbknFlMAc5euN+nhahfAnTvj0eC86aNbsrYGn6mg7Fyili92moMNnVGefLSV2WXJXjpIMGDV3CQTCj/VaxhqAgICAZUWFByIIhA+b018bFAb9xFnnLm+f3Q6Q6SSZok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713565419; c=relaxed/simple;
	bh=epINgrZ7UBXC/8YgnrPnisTj6hy/OowgY5UMWi6TDT4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=t/duvZzsSahu0FNhADvZQuabqatpepDKoYqkuvxcvTRJLJkhXRulBq1a+8wQHwlIPlIEtbeXCFGXDCg8+C5CoE/XBPN3XGgL357zy3OKo5TjWUGHk9tRtzErOsf1zaiuJ2kUh4J27OaDu202qq6HoWIVGREMRQByD8q6aP+bVWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aOmLQCrt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43JMC122025805
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 22:23:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=2/fNqb7KNnvzK7FCaXPcHU4nwlmyGTu9T/brQ/y3gds=;
 b=aOmLQCrtE9m6jMJ7J5G6lFjANcY/nJ4CwHp2S+V0gef0BKnN5IYize+HUF7xkiMmWu3h
 pXA/emcihMfqGwzJk1ukDlI8jVAJrxvR/LfpK2nNnmkziTWysUMb51HleUHGukn/TC5Q
 +JpyzfrgPUSEFbOUAUPxVhH8/aGhl7/uKZaaR47sZVFY7b+VZTqrBkoIsfXGhyrqKHTt
 9QVLk97OqFMlhxV6UkMnhLt5HWtcoOlxD2Sq2yti9JIQXpcR3U9U56DVUU4d6EKQ7owp
 4WcO4Bj3ddGJS3H0wYUN9Mx8ZB+WS4ur0eF4pwp4YnVxyqDnTOZ93pVKNpAmeBFExykT 5A== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xm0ysg1a5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 22:23:35 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43JLYTJN027866
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 22:23:34 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xkbmpebvn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 22:23:34 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43JMNWp529164044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 22:23:34 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BFCD58061
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 22:23:32 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B78CC58043
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 22:23:31 +0000 (GMT)
Received: from localhost (unknown [9.61.41.207])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 22:23:31 +0000 (GMT)
From: David J Wilder <dwilder@us.ibm.com>
To: netdev@vger.kernel.org
Subject: [RFC PATCH] net: skb: Increasing allocation in __napi_alloc_skb() to 2k when needed.
Date: Fri, 19 Apr 2024 15:23:28 -0700
Message-Id: <20240419222328.3231075-1-dwilder@us.ibm.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cAlcjVh2UijzmoC3pWlCB1kFE7_UHq7k
X-Proofpoint-ORIG-GUID: cAlcjVh2UijzmoC3pWlCB1kFE7_UHq7k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_15,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 clxscore=1011 phishscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404190174

When testing CONFIG_MAX_SKB_FRAGS=45 on ppc64le and x86_64 I ran into a
couple of issues.

__napi_alloc_skb() assumes its smallest fragment allocations will fit in
1K. When CONFIG_MAX_SKB_FRAGS is increased this may no longer be true
resulting in __napi_alloc_skb() reverting to using page_frag_alloc().
This results in the return of the bug fixed in:
Commit 3226b158e67c ("net: avoid 32 x truesize under-estimation for
tiny skbs")

That commit insured that "small skb head fragments are kmalloc backed,
so that other objects in the slab page can be reused instead of being held
as long as skbs are sitting in socket queues."

On ppc64le the warning from napi_get_frags_check() is displayed when
CONFIG_MAX_SKB_FRAGS is set to 45. The purpose of the warning is to detect
when an increase of MAX_SKB_FRAGS has reintroduced the aforementioned bug.
Unfortunately on x86_64 this warning is not seen, even though it should be.
I found the warning was disabled by:
commit dbae2b062824 ("net: skb: introduce and use a single page frag
cache")

This RFC patch to __napi_alloc_skb() determines if an skbuff allocation
with a head fragment of size GRO_MAX_HEAD will fit in a 1k allocation,
increasing the allocation to 2k if needed.

I have functionally tested this patch, performance testing is still needed.

TBD: Remove the limitation on 4k page size from the single page frag cache
allowing ppc64le (64K page size) to benefit from this change.

TBD: I have not address the warning in napi_get_frags_check() on x86_64.
Will the warning still be needed once the other changes are completed?

Signed-off-by: David J Wilder <dwilder@us.ibm.com>
---
 net/core/skbuff.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b99127712e67..e3b6115a2edc 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -232,18 +232,18 @@ static void skb_under_panic(struct sk_buff *skb, unsigned int sz, void *addr)
  * page - to avoid excessive truesize underestimation
  */
 
-struct page_frag_1k {
+struct page_frag_small {
 	void *va;
 	u16 offset;
 	bool pfmemalloc;
 };
 
-static void *page_frag_alloc_1k(struct page_frag_1k *nc, gfp_t gfp)
+static void *page_frag_alloc_small(struct page_frag_small *nc, gfp_t gfp, unsigned int len)
 {
 	struct page *page;
 	int offset;
 
-	offset = nc->offset - SZ_1K;
+	offset = nc->offset - len;
 	if (likely(offset >= 0))
 		goto use_frag;
 
@@ -253,8 +253,8 @@ static void *page_frag_alloc_1k(struct page_frag_1k *nc, gfp_t gfp)
 
 	nc->va = page_address(page);
 	nc->pfmemalloc = page_is_pfmemalloc(page);
-	offset = PAGE_SIZE - SZ_1K;
-	page_ref_add(page, offset / SZ_1K);
+	offset = PAGE_SIZE - len;
+	page_ref_add(page, offset / len);
 
 use_frag:
 	nc->offset = offset;
@@ -268,10 +268,10 @@ static void *page_frag_alloc_1k(struct page_frag_1k *nc, gfp_t gfp)
 #define NAPI_HAS_SMALL_PAGE_FRAG	0
 #define NAPI_SMALL_PAGE_PFMEMALLOC(nc)	false
 
-struct page_frag_1k {
+struct page_frag_small {
 };
 
-static void *page_frag_alloc_1k(struct page_frag_1k *nc, gfp_t gfp_mask)
+static void *page_frag_alloc_small(struct page_frag_small *nc, gfp_t gfp_mask, unsigned int len)
 {
 	return NULL;
 }
@@ -280,7 +280,7 @@ static void *page_frag_alloc_1k(struct page_frag_1k *nc, gfp_t gfp_mask)
 
 struct napi_alloc_cache {
 	struct page_frag_cache page;
-	struct page_frag_1k page_small;
+	struct page_frag_small page_small;
 	unsigned int skb_count;
 	void *skb_cache[NAPI_SKB_CACHE_SIZE];
 };
@@ -787,6 +787,7 @@ EXPORT_SYMBOL(__netdev_alloc_skb);
  *
  *	%NULL is returned if there is no free memory.
  */
+
 struct sk_buff *__napi_alloc_skb(struct napi_struct *napi, unsigned int len,
 				 gfp_t gfp_mask)
 {
@@ -794,6 +795,7 @@ struct sk_buff *__napi_alloc_skb(struct napi_struct *napi, unsigned int len,
 	struct sk_buff *skb;
 	bool pfmemalloc;
 	void *data;
+	unsigned int size = SZ_1K;
 
 	DEBUG_NET_WARN_ON_ONCE(!in_softirq());
 	len += NET_SKB_PAD + NET_IP_ALIGN;
@@ -801,9 +803,14 @@ struct sk_buff *__napi_alloc_skb(struct napi_struct *napi, unsigned int len,
 	/* If requested length is either too small or too big,
 	 * we use kmalloc() for skb->head allocation.
 	 * When the small frag allocator is available, prefer it over kmalloc
-	 * for small fragments
+	 * for small fragments. Larger MAX_SKB_FRAGS values may require more
+	 * than a 1K allocation found by testing SKB_WITH_OVERHEAD(GRO_MAX_HEAD).
 	 */
-	if ((!NAPI_HAS_SMALL_PAGE_FRAG && len <= SKB_WITH_OVERHEAD(1024)) ||
+
+	if (SKB_WITH_OVERHEAD(1024) < (MAX_HEADER + 128 + NET_SKB_PAD + NET_IP_ALIGN))
+		size = SZ_2K;
+
+	if ((!NAPI_HAS_SMALL_PAGE_FRAG && len <= SKB_WITH_OVERHEAD(size)) ||
 	    len > SKB_WITH_OVERHEAD(PAGE_SIZE) ||
 	    (gfp_mask & (__GFP_DIRECT_RECLAIM | GFP_DMA))) {
 		skb = __alloc_skb(len, gfp_mask, SKB_ALLOC_RX | SKB_ALLOC_NAPI,
@@ -818,7 +825,7 @@ struct sk_buff *__napi_alloc_skb(struct napi_struct *napi, unsigned int len,
 	if (sk_memalloc_socks())
 		gfp_mask |= __GFP_MEMALLOC;
 
-	if (NAPI_HAS_SMALL_PAGE_FRAG && len <= SKB_WITH_OVERHEAD(1024)) {
+	if (NAPI_HAS_SMALL_PAGE_FRAG && len <= SKB_WITH_OVERHEAD(size)) {
 		/* we are artificially inflating the allocation size, but
 		 * that is not as bad as it may look like, as:
 		 * - 'len' less than GRO_MAX_HEAD makes little sense
@@ -829,13 +836,10 @@ struct sk_buff *__napi_alloc_skb(struct napi_struct *napi, unsigned int len,
 		 *   little networking, as that implies no WiFi and no
 		 *   tunnels support, and 32 bits arches.
 		 */
-		len = SZ_1K;
-
-		data = page_frag_alloc_1k(&nc->page_small, gfp_mask);
+		data = page_frag_alloc_small(&nc->page_small, gfp_mask, size);
 		pfmemalloc = NAPI_SMALL_PAGE_PFMEMALLOC(nc->page_small);
 	} else {
 		len = SKB_HEAD_ALIGN(len);
-
 		data = page_frag_alloc(&nc->page, len, gfp_mask);
 		pfmemalloc = nc->page.pfmemalloc;
 	}
-- 
2.39.3


