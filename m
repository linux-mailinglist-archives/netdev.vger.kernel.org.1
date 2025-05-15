Return-Path: <netdev+bounces-190799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C323CAB8E09
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 19:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F70B4A7DD2
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 17:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53A22571B4;
	Thu, 15 May 2025 17:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KrQnH/yc"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7201361
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747331092; cv=none; b=ckx0T99MN2YaQIH+ppuvJs+IEPetoHKttM9j8lavymwJLC3By2y69/c4EOhXLryOIgwUi7rC/g5X/e5CHClsWqYtjP3NDNGIq+CjAa98liQtvcMZxN711VyQpOaTTafkuG9pFwnVa9MpVsWDgIdMNcPjgEYEAGlZVwUBRYeddyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747331092; c=relaxed/simple;
	bh=kK2lj+e6xxhWZUwytsNe/uzyvOE5+kAFhtGnEuJJ8mQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HdPBh6LCQZe5tcMlI+wjpv+I7yRFn5QV/4kObo4ILdfCd14QdWn8Xi98zXpPu8G8bXxdMQe3gz/JLnUJD4q5WO+LoXznHeXCV35YzHRxq30VK5+ofEjXlEfCP9C9wxVQhB/ZLdUwTFy27/ZJCAW7517qkYrl1B21hEiAQd/fvaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=KrQnH/yc; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEiONm006623;
	Thu, 15 May 2025 10:44:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=yGj5t3XC3/gIGFa14uuchE4UI69RIQ/hpGYeWKYMCHg=; b=KrQ
	nH/ycyoCus2YMlsCDW/6eMmnZQV/rO1WEnv/N0HPExMb8B3roxGUntBlq2BTuWrA
	/d4z+trKHE6o80Dtw4bm1OjBk/BXP7fe+JyC1Nq+PH5TInNJG4I900ii/pgeaZNI
	colzL6WbNGw4TlWcZf877qdYa2dKHHkLF9Bjhg5lOVaxKrD2JLU8/xVvOYSv1vbc
	ZXUKFKHKftcxQozQ9hncKf+qWv2o+SehKD246JaeDtvip3eQh8rZ3kNvcxduFPZy
	YB0Fio5br8uL+TinjXsl85TRwolEWs/B1kP6NTwZenD1TVDdIcpQMKQCZ5ZgwjEg
	LR873jT34ERzIpEjZ/g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46nj9y0fhx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 10:44:42 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 15 May 2025 10:44:28 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 15 May 2025 10:44:28 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 4EA6B3F7044;
	Thu, 15 May 2025 10:44:23 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <bbhushan2@marvell.com>, <jerinj@marvell.com>
CC: <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [net-next PATCH] octeontx2-pf: Add tracepoint for NIX_PARSE_S
Date: Thu, 15 May 2025 23:14:08 +0530
Message-ID: <1747331048-15347-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: dRcw-mecRwDObhm3ltbtyMu6Kvfvoszu
X-Proofpoint-GUID: dRcw-mecRwDObhm3ltbtyMu6Kvfvoszu
X-Authority-Analysis: v=2.4 cv=Tq3mhCXh c=1 sm=1 tr=0 ts=6826280a cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=1CXHG1wxi1rnVOajPykA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE3NSBTYWx0ZWRfXwu4fc6KszPIp 4y68FtnPvCeCN2ANGreWh8R4JkqN573HpfEpBq31VMckvaj1T8wyxgWIBJBe9TeMI0nKniLvSsc 3+3VN+kPJIhPDwG8JCSZxGQjLpG+bs17/CawBAVTZP4b9Lf5dn0zGBR77L4pEIfXBxMUuV1grSv
 W/sMAXUwhqw6/NvLhY8aaP/1jbIPbsNpHozok+1PPqfKoTlVTSSuz8vRx2CoFDmegzV4VEVjWNl b+Gijtthv7fryk6Y42Sw6X7YOlEzJM0LTAJ4wwp4CydR0hJU/UDeMrnqDFPDXfGpUNNC0Wg1LQQ vfeqsiWDUwrt4t7sHnpuJMiO7LBgUW1Qc99k+I/w/erNXkAdJFQhabY0JV5GH5/MBWiSSZQfK0q
 IXCsxx5SEgZL7z1E1nWAn7+A5XvvvVUyFsC28dUcyT/K8P3K86Ky7eTdcN5gJVoFosqCtXCO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01

The NIX_PARSE_S structure populated by hardware in the
NIX RX CQE has parsing information for the received packet.
A tracepoint to dump the all words of NIX_PARSE_S
is helpful in debugging packet parser.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/rvu_trace.c  |  1 +
 .../net/ethernet/marvell/octeontx2/af/rvu_trace.h  | 26 ++++++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.c |  6 ++++-
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.c
index 5f69380..19e0d16 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.c
@@ -12,3 +12,4 @@ EXPORT_TRACEPOINT_SYMBOL(otx2_msg_alloc);
 EXPORT_TRACEPOINT_SYMBOL(otx2_msg_interrupt);
 EXPORT_TRACEPOINT_SYMBOL(otx2_msg_process);
 EXPORT_TRACEPOINT_SYMBOL(otx2_msg_status);
+EXPORT_TRACEPOINT_SYMBOL(otx2_parse_dump);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h
index db02b4d..4cd0fc4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h
@@ -133,6 +133,32 @@ TRACE_EVENT(otx2_msg_status,
 		      __get_str(str), __entry->num_msgs)
 );
 
+TRACE_EVENT(otx2_parse_dump,
+	    TP_PROTO(const struct pci_dev *pdev, char *msg, u64 *word),
+	    TP_ARGS(pdev, msg, word),
+	    TP_STRUCT__entry(__string(dev, pci_name(pdev))
+			     __string(str, msg)
+			     __field(u64, w0)
+			     __field(u64, w1)
+			     __field(u64, w2)
+			     __field(u64, w3)
+			     __field(u64, w4)
+			     __field(u64, w5)
+	    ),
+	    TP_fast_assign(__assign_str(dev);
+			   __assign_str(str);
+			   __entry->w0 = *(word + 0);
+			   __entry->w1 = *(word + 1);
+			   __entry->w2 = *(word + 2);
+			   __entry->w3 = *(word + 3);
+			   __entry->w4 = *(word + 4);
+			   __entry->w5 = *(word + 5);
+	    ),
+	    TP_printk("[%s] nix parse %s W0:%#llx W1:%#llx W2:%#llx W3:%#llx W4:%#llx W5:%#llx\n",
+		      __get_str(dev), __get_str(str), __entry->w0, __entry->w1, __entry->w2,
+		      __entry->w3, __entry->w4, __entry->w5)
+);
+
 #endif /* __RVU_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 9593627..99ace38 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -335,6 +335,7 @@ static void otx2_rcv_pkt_handler(struct otx2_nic *pfvf,
 	struct nix_rx_parse_s *parse = &cqe->parse;
 	struct nix_rx_sg_s *sg = &cqe->sg;
 	struct sk_buff *skb = NULL;
+	u64 *word = (u64 *)parse;
 	void *end, *start;
 	u32 metasize = 0;
 	u64 *seg_addr;
@@ -342,9 +343,12 @@ static void otx2_rcv_pkt_handler(struct otx2_nic *pfvf,
 	int seg;
 
 	if (unlikely(parse->errlev || parse->errcode)) {
-		if (otx2_check_rcv_errors(pfvf, cqe, cq->cq_idx))
+		if (otx2_check_rcv_errors(pfvf, cqe, cq->cq_idx)) {
+			trace_otx2_parse_dump(pfvf->pdev, "Err:", word);
 			return;
+		}
 	}
+	trace_otx2_parse_dump(pfvf->pdev, "", word);
 
 	if (pfvf->xdp_prog)
 		if (otx2_xdp_rcv_pkt_handler(pfvf, pfvf->xdp_prog, cqe, cq,
-- 
2.7.4


