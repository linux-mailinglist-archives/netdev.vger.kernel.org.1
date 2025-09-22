Return-Path: <netdev+bounces-225361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C448B92C36
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 21:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 329CC2A5379
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 19:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F9530CB5C;
	Mon, 22 Sep 2025 19:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="ggS8N9Q1"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC89C1991CA
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 19:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758568842; cv=none; b=h/+yPR0ChpaH2gQMOf3jOZlkfsX/qaD+HNaC5gUX7VRYQ797eIH6F8VZsrF/1RC4GrTPICwY/gnQxtITSL8JOatjT9Qeg1jJInc4irhQLPAjrev+ZONd22g/FZmJsfp5u7RtP479dpABMm4lUQTHttYoZV/iqYF+btQnymWGUzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758568842; c=relaxed/simple;
	bh=YYBexm4SSplS2W9/plZ8oVPARquSisHTLQzXxVJlxA0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AkYXxvMYsNe02hKIDiJat6vWNCWlmx0oAl8dQqVdiKvC+wJA3PUXlicZV36otet8qIWlN0IMa1XE4+kyLg/0RUoJPNMFqPj+Pb5Q/ZtDDS4NopSyLSSHKhJL6owk81VzLnlR8SgijgSG3A6th/Ye//jYvHbEBrjoNfw0v8GIKto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=ggS8N9Q1; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
	by m0050093.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id 58MJ4A7f027202;
	Mon, 22 Sep 2025 20:20:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=jan2016.eng; bh=uKglcS+ldoXj7YshNP6tenjxTT8uvWLsi
	Fcditnih5Q=; b=ggS8N9Q12WXwH1Vql98ftyGHRwdndm56n7F0rG5Pbh2KQmnVS
	HjLd96QXwCbVCgZITHDSgCDMv51sDU45u8uphG+43pWfU0Sxtjv2bc/Y6seoZEQL
	oaOGOkauVvU1YPJlg8SPwO/wZcw7o2RHzhpapS4leTloFON+VSWRUPjhml6/ru0J
	lqqlkNwK58yeb4KYo87NI0imPThWEtQBM/CEysbQw6va3W/HHwUyI+StGe9Zds7A
	SUxA2pmmbY06a5As9TsDJRKQHhJ30IW+3i7jYnGDkF+W+w8mLAQlFsxAflXsFv/C
	Z4R4pvs48S1mE1fgeQaZ6n1nt+ujyUBES1w/w==
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19])
	by m0050093.ppops.net-00190b01. (PPS) with ESMTPS id 49bc9gg6rm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 20:20:18 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
	by prod-mail-ppoint2.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 58MJISUJ009908;
	Mon, 22 Sep 2025 15:20:17 -0400
Received: from prod-mail-relay01.akamai.com ([172.27.118.31])
	by prod-mail-ppoint2.akamai.com (PPS) with ESMTP id 49bcg1r04q-1;
	Mon, 22 Sep 2025 15:20:16 -0400
Received: from bos-lhv9ol.bos01.corp.akamai.com (bos-lhv9ol.bos01.corp.akamai.com [172.28.41.79])
	by prod-mail-relay01.akamai.com (Postfix) with ESMTP id 10FDE87;
	Mon, 22 Sep 2025 19:20:16 +0000 (UTC)
From: Jason Baron <jbaron@akamai.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc: netdev@vger.kernel.org
Subject: [PATCH v2 net] net: allow alloc_skb_with_frags() to use MAX_SKB_FRAGS
Date: Mon, 22 Sep 2025 15:19:57 -0400
Message-Id: <20250922191957.2855612-1-jbaron@akamai.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=723 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509220188
X-Proofpoint-GUID: CCnnNDFcKwpsmFFUVCUUBEojLEFTAUth
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE4NSBTYWx0ZWRfX/IVEwsb7f1FT
 i8JGJN2O/YGzvSro93wT3tsoTkH8aTqHCI1m0KNEfmWYBOT2Wi2wyMB1tSyxFA5p0DFM8yQHsYv
 LeOv35IqukgbAQbyJKafVNG+QktKoZ4T17Dlfn8dDChWmpNdHE1UXBxrELO2Ap3MvTnaOjo0nYC
 RhMSygblHEPUuUJegGbt7Q2SAdIXt9+YBw4R0r+PxG60fjM8nmkBuZvGiNkKhUoXU/NGHfZyR0+
 Mn5YV5nypPFQ26jYw/a+JniyTL0nq3XLvPk5AOsfYhhHUJDVYys3LFWomx7etZXDWzJQ7lx8trX
 ZJ4ACigJ01Wg18ndd0n9NfNHByVmEYs5+akoAsM2bJD0Z2+L206S/ndWgx/+JH0g1ZDC/5srAaV
 rTgW96erZf/NbAXpMCVIKO8+bF/KqQ==
X-Authority-Analysis: v=2.4 cv=DNuCIiNb c=1 sm=1 tr=0 ts=68d1a172 cx=c_pps
 a=BpD+HMUBsFIkYY1OQe22Yw==:117 a=BpD+HMUBsFIkYY1OQe22Yw==:17
 a=yJojWOMRYYMA:10 a=X7Ea-ya5AAAA:8 a=c_KhuYDr2bewFB5Ap5EA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: CCnnNDFcKwpsmFFUVCUUBEojLEFTAUth
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509220185

Currently, alloc_skb_with_frags() will only fill (MAX_SKB_FRAGS - 1)
slots. I think it should use all MAX_SKB_FRAGS slots, as callers of
alloc_skb_with_frags() will size their allocation of frags based
on MAX_SKB_FRAGS.

This issue was discovered via a test patch that sets 'order' to 0
in alloc_skb_with_frags(), which effectively tests/simulates high
fragmentation. In this case sendmsg() on unix sockets will fail every
time for large allocations. If the PAGE_SIZE is 4K, then data_len will
request 68K or 17 pages, but alloc_skb_with_frags() can only allocate
64K in this case or 16 pages.

Fixes: 09c2c90705bb ("net: allow alloc_skb_with_frags() to allocate bigger packets")
Signed-off-by: Jason Baron <jbaron@akamai.com>
---
Changes:
v2: Add Fixes: tag
---
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 23b776cd9879..df942aca0617 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6669,7 +6669,7 @@ struct sk_buff *alloc_skb_with_frags(unsigned long header_len,
 		return NULL;
 
 	while (data_len) {
-		if (nr_frags == MAX_SKB_FRAGS - 1)
+		if (nr_frags == MAX_SKB_FRAGS)
 			goto failure;
 		while (order && PAGE_ALIGN(data_len) < (PAGE_SIZE << order))
 			order--;
-- 
2.25.1


