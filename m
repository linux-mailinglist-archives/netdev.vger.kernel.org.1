Return-Path: <netdev+bounces-232121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60FDC01599
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 15:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AB0E3AE1E9
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 13:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA5C314B85;
	Thu, 23 Oct 2025 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AhuTSbGY"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11948314A8B
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225926; cv=none; b=eWXNCnNdcsUZe5l+/nrTvLfRmR/jzkj5qIBiYCD76dqVKa8sNfOrbyVBf0nmun1ijheh25IoeQts7fQoAv1ijh+vKcj9SHqfUtG2vQcij34OrJSN0JzlYJ6WYKkV2isTEiA6H+Oqz4fNNghMW3nqk/Is3tREXjl2QYlgSY4q/+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225926; c=relaxed/simple;
	bh=y1KBOkGWo+cxp0tw+MUOUkNhsEp131n/hQPCYy/su8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7fgiNXm3eAe9L/TexdXtTWEFf3EUpGTtgJrUgGaA30IeS2aCsZsTIzXCupI3+jZl5J3DWNjkS/f/MdN4NHHpkYdPOTEB+KJg3oskDYJpylgi7tWarsFrMawafbrppK5b2dZ2mMhTmJ+NIW152eQb4YcNmG/yA/ZEVHzu+nJKFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AhuTSbGY; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NAhPWC029748;
	Thu, 23 Oct 2025 13:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=oErhq
	fUltZJjpz0K0emhvcrC3uZvk6hI0+0/6ttMvGY=; b=AhuTSbGYwfLHdwb/DGd5x
	DZzqYK//V6KkPM6W7ov1w4e+7irzsJG05ArCAEOhShk4LWsAGI5lDPUOiz1XtXRG
	wLj2vl4mS/1RhMqpe6PnbFNHOrn4kCy7m/DRFo3HSz59xf5EjO6y2B85P9kFuyQh
	125X4GCQOlvXhpE/UGZV7Xd7LG5u5zLwkaLe4qpLwxWVThJVNzwK+qavMEkdTxjP
	JL7VpRvfzK1Ltkn8FrcNKu0kn2FiYNBWclaMKLAvn4F/tfjzeno3SXp5MEzklZ7s
	GxPaGt+oRm0SzPqdFT27TIq/v/tsZ/V3fENfSNBxa//gFz/7//kbkyEPQFi/Iknn
	Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xvcyagmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 13:25:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59NCZvcW012006;
	Thu, 23 Oct 2025 13:25:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bet7vj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 13:25:11 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59NDOxMv039830;
	Thu, 23 Oct 2025 13:25:11 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 49v1bet7v1-2;
	Thu, 23 Oct 2025 13:25:10 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
        andrew+netdev@lunn.ch, kuba@kernel.org, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH net-next v2 2/2] idpf: fix typos and correct doc comments in idpf driver
Date: Thu, 23 Oct 2025 06:25:03 -0700
Message-ID: <20251023132507.1102549-2-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251023132507.1102549-1-alok.a.tiwari@oracle.com>
References: <20251023132507.1102549-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510230122
X-Authority-Analysis: v=2.4 cv=GqlPO01C c=1 sm=1 tr=0 ts=68fa2cb8 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=CDr7rAr7om32PigXHikA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA3MyBTYWx0ZWRfX9eU3RtQIaJ9Q
 tjH7L4E5UpFa7/yp8Cg5LlnP/LyvyHeI2w/A1IGA30kSwfB8jlIt/086xy9P5RhNm4Czeeg7eMt
 pRQrl75Mh+DhZtnk3PQpIx99HoRymSJAhkJDK5ElXCg/qss8+VH41ndEAs5KCzW5q/9duyZykGA
 NLEnLxgmKMYjDXIhxCuiKhzQphrbQJFqCfK85WRa1ZZijBjWHgQOOijp6Z8o/N36ePCCTDPVKjM
 JyD5h/A3Y5fAGzxdDlLcM8vwmMV+abVoh5S601ikvvbkMZEo4hrWjc5yuE+MXd9XvXxVtY8kd3O
 QlQB+uh5U3Mq3kSC8l7V/PIug7Kyf0KhIweXTMFRwk+Aru6brseqAVLjyuHcWf5xm7NT4E2ew5y
 N5/+LDU3g/+W+A+CPkGqOYezbVcFHg==
X-Proofpoint-GUID: C305eqO858MWffxZG8XelQfHhaOFBno4
X-Proofpoint-ORIG-GUID: C305eqO858MWffxZG8XelQfHhaOFBno4

- Corrected a typo: "controq" -> "control"
- Updated return value description to accurately reflect behaviour:
  changed "Returns true if there's any budget left" ->
  "Returns number of packets cleaned from this queue"
- use "Returns:" instead of "Returns" aligning with kernel-doc

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
v1 -> v2
(idpf_singleq_txrx.c)
"Returns" -> "Returns:" aligning with kernel-doc
---
 drivers/net/ethernet/intel/idpf/idpf_controlq.c     |  2 +-
 drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_controlq.c b/drivers/net/ethernet/intel/idpf/idpf_controlq.c
index 67894eda2d29..59558e2f45cf 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_controlq.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_controlq.c
@@ -92,7 +92,7 @@ static void idpf_ctlq_init_rxq_bufs(struct idpf_ctlq_info *cq)
  * @hw: pointer to hw struct
  * @cq: pointer to the specific Control queue
  *
- * The main shutdown routine for any controq queue
+ * The main shutdown routine for any control queue
  */
 static void idpf_ctlq_shutdown(struct idpf_hw *hw, struct idpf_ctlq_info *cq)
 {
diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index 61e613066140..3f0745d04b86 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -10,7 +10,7 @@
  * @skb: pointer to skb
  * @off: pointer to struct that holds offload parameters
  *
- * Returns 0 or error (negative) if checksum offload cannot be executed, 1
+ * Returns: 0 or error (negative) if checksum offload cannot be executed, 1
  * otherwise.
  */
 static int idpf_tx_singleq_csum(struct sk_buff *skb,
@@ -407,7 +407,7 @@ static void idpf_tx_singleq_build_ctx_desc(struct idpf_tx_queue *txq,
  * @skb: send buffer
  * @tx_q: queue to send buffer on
  *
- * Returns NETDEV_TX_OK if sent, else an error code
+ * Returns: NETDEV_TX_OK if sent, else an error code
  */
 netdev_tx_t idpf_tx_singleq_frame(struct sk_buff *skb,
 				  struct idpf_tx_queue *tx_q)
@@ -585,7 +585,7 @@ static bool idpf_tx_singleq_clean(struct idpf_tx_queue *tx_q, int napi_budget,
  * @budget: Used to determine if we are in netpoll
  * @cleaned: returns number of packets cleaned
  *
- * Returns false if clean is not complete else returns true
+ * Returns: false if clean is not complete else returns true
  */
 static bool idpf_tx_singleq_clean_all(struct idpf_q_vector *q_vec, int budget,
 				      int *cleaned)
@@ -886,7 +886,7 @@ static void idpf_rx_buf_hw_update(struct idpf_rx_queue *rxq, u32 val)
  * @rx_q: queue for which the hw buffers are allocated
  * @cleaned_count: number of buffers to replace
  *
- * Returns false if all allocations were successful, true if any fail
+ * Returns: false if all allocations were successful, true if any fail
  */
 bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_rx_queue *rx_q,
 				      u16 cleaned_count)
@@ -1029,7 +1029,7 @@ static void idpf_xdp_run_pass(struct libeth_xdp_buff *xdp,
  * @rx_q: rx queue to clean
  * @budget: Total limit on number of packets to process
  *
- * Returns true if there's any budget left (e.g. the clean is finished)
+ * Returns: number of packets cleaned from this queue
  */
 static int idpf_rx_singleq_clean(struct idpf_rx_queue *rx_q, int budget)
 {
@@ -1111,7 +1111,7 @@ static int idpf_rx_singleq_clean(struct idpf_rx_queue *rx_q, int budget)
  * @budget: Used to determine if we are in netpoll
  * @cleaned: returns number of packets cleaned
  *
- * Returns false if clean is not complete else returns true
+ * Returns: false if clean is not complete else returns true
  */
 static bool idpf_rx_singleq_clean_all(struct idpf_q_vector *q_vec, int budget,
 				      int *cleaned)
-- 
2.50.1


