Return-Path: <netdev+bounces-194585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF6AACAC8F
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 12:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CECD3174006
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 10:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BE31A23B7;
	Mon,  2 Jun 2025 10:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sFWT2U0t"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFFD1474DA;
	Mon,  2 Jun 2025 10:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748860506; cv=none; b=BCvYh1DF2zvfK2x4JExDsCtaeTlHSEUIiYKXxhfFY84LZHwDTd430SA6f/RkrDwvOJ+CWNixIO4bwJK7180XpXHDBIbfiDvPxYVTD3uudHqBbfreVxMmie7AhkrFFhtPDCmSQwYmHgYcX5/M0js4HZCggzWRHctzlsPtVr0zJ0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748860506; c=relaxed/simple;
	bh=8E0T9v34xRXXRTGYhDuC2chi+g4DNJyzdc253h68kVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IyWupGMdkO2Zykc6zuflKpK77ubGU7BqqE/EtBJR3yFjTNnrnkU/yDkU4K4UNVyl/9cF5hHiYnwrfBbtNQmKXpsLVRWlJ00bUaCnTtHq8VGAupjTbRrYU5PLgkPCj+IgbDi9cZpLG54E6IpPTMZpZ7kkoM8rEpyHOu23KMG5GFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sFWT2U0t; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5525tr8k004819;
	Mon, 2 Jun 2025 10:34:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=d10F09HKcE9vaVzFWvr1qZcc2RWk1
	4iuUKZIIZ0UNXs=; b=sFWT2U0tcUzcxbygvZqDNLRPuAru8T+DbpX887WYjeGte
	Sia8d5diuf5bwXWgXQ3ND0gS4TdizmheDNCIkVNQi1gGF9o1utQ0fo8B9tBvx0AR
	8RGHqeskI2wwKi598IJk8gpbczrx/hkz552huOpgzMopK8gFnEgr3oWuSJByRWZa
	bPE+iu598DrtwY3u5UiTiNfID0XhOmC1JiOu0O3FsMgLvOG27FPDjlmIopk2a+X0
	xzXkkupEtC1ZZxzL4eNnuEVsWuoGSzK+0LZuO78dcnHsKXEE4da9X+BjWAJveI2F
	yuyZy5nzBVseblns4XankOdq2SLAjvUwNfdZ6g5UQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ystetbbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Jun 2025 10:34:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5529Iu6N016230;
	Mon, 2 Jun 2025 10:34:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46yr77t4tt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Jun 2025 10:34:53 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 552AYrmZ019775;
	Mon, 2 Jun 2025 10:34:53 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 46yr77t4t9-1;
	Mon, 02 Jun 2025 10:34:53 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: almasrymina@google.com, bcf@google.com, joshwash@google.com,
        willemb@google.com, pkaligineedi@google.com, pabeni@redhat.com,
        kuba@kernel.org, jeroendb@google.com, hramamurthy@google.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org,
        darren.kenny@oracle.com
Subject: [PATCH net v2] gve: add missing NULL check for gve_alloc_pending_packet() in TX DQO
Date: Mon,  2 Jun 2025 03:34:29 -0700
Message-ID: <20250602103450.3472509-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_04,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506020091
X-Proofpoint-ORIG-GUID: 20Yu7RZYW7vRRmyRVOW4vrtwH_FHnZf1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDA5MSBTYWx0ZWRfXyF47Lr94UO4d Hirr2bG1ZdyZbX24qpd2SRfUXzzT/NADrXx4VQ1tQDE4bK0uMfoy6A+4hmnlAPACblaHhQjEfaP CQtT/m6LPREY0rIbzT8Ffs8i+EH5Bl3LT3gqkblKRXZjie4WTTLleQxfuJG/ka/thh7G6TjsxSY
 baP+pMXk0LiwPldbPPvvFXjBQzncIvbDXUBbc9XtQIe1h/xE+ZKFl2lvMtAmSx1Y9ruakcx0p0n OS8Vcqzp3PpU44KzQVIdbeaRKV+VQdwWmeu9B+g8WIPYU0M1rN/aUVY394Ar/JFSmWAggHQIymy RCIXzn0Z5s1jK2T6fVISti1oXhMPgsKurqHRpTi1tHU3eVolwMeXcQhic+U5w3qGbx/HLDXwBBp
 b5izZuHtaekdJ2o6WDDd9NtTvlXMoYHQ+8ot5YvCsWvinDr9MogmUzuGgownGxSkqSnG+8BR
X-Proofpoint-GUID: 20Yu7RZYW7vRRmyRVOW4vrtwH_FHnZf1
X-Authority-Analysis: v=2.4 cv=XpX6OUF9 c=1 sm=1 tr=0 ts=683d7e4f cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=YHu3FHGigSco7_P9gqwA:9

gve_alloc_pending_packet() can return NULL, but gve_tx_add_skb_dqo()
did not check for this case before dereferencing the returned pointer.

Add a missing NULL check to prevent a potential NULL pointer
dereference when allocation fails.

This improves robustness in low-memory scenarios.

Fixes: a57e5de476be ("gve: DQO: Add TX path")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
---
v1->v2
added Fixes tag and [PATCH net v2]
---
 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index a27f1574a733..9d705d94b065 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -764,6 +764,9 @@ static int gve_tx_add_skb_dqo(struct gve_tx_ring *tx,
 	s16 completion_tag;
 
 	pkt = gve_alloc_pending_packet(tx);
+	if (!pkt)
+		return -ENOMEM;
+
 	pkt->skb = skb;
 	completion_tag = pkt - tx->dqo.pending_packets;
 
-- 
2.47.1


