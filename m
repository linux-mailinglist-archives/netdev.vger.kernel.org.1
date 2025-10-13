Return-Path: <netdev+bounces-228837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A86BD4E54
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 18:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CED218A22DD
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 16:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F9C30E0D6;
	Mon, 13 Oct 2025 16:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QO8j/6JQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0BB26E708
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760371528; cv=none; b=iYyx57ZE07QLfbrjLBaFwSk8PTs3XNZyx18eGkPUjtrx3GP/D2c4zA2iQ0nPw9CFq23jh/T5JOX08pt1CdiEeO6PfGWGtuo/tFixTHpY8y6KQ7bWsoB7ZlikIOnUkVbS04rr+tT/8D48+aEHKMgSiYX7ytjJrBZWXlKs3A0nR7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760371528; c=relaxed/simple;
	bh=ec+LhHERerMS1Do4twVrrlRs0AUZDfIXfoB9VsKkduM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iG9oa/sItszod43vQ8HT4hFSpk0yVuhUvVM4LQk3LMqDHuJR7Bc/c/InCfJxKPSRzJc47eLju7NYtUOhLgxyV27rTLLVyYwbELvs6+jzlMoj/Z8BWcd9JnNMC8E2yXnLVjzVLprSFJX7l8zXUG8Uk0UEYGNUx3kyFRSyDN3slIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QO8j/6JQ; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DFu3NL023552;
	Mon, 13 Oct 2025 16:05:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=1kPr7fdJfI8/VofnmH2pSfsc96ceG
	+0gTDljoEhRUrM=; b=QO8j/6JQ6p+az9Uyyfq5kl14q17zdzWcGIuo28m+fewDw
	ENy+JW97vYCItWKJoilqcwtmGybqWpSdgsTBaP7oFsvjcPLJfjjy3480aP/J2LYq
	uf8UNTtGFqe8+fkD9/cjnF+SFUGfUdYY1OVLVaiTESsilWW82euHlW0mgcfo+844
	Apfm+OAIa82eC4Te5PhuxMQhlsVq00jmZGeIx7NHW7MfHvTvi3x4WnRijjVcrc6L
	yZwl+oU6lJ0+iZm8ExkVaOlsfj6mduUziYzMq6oYi+GEVCv/jsRk6U7WWfX0Z/6g
	nvWYNjn1o/duBEyPxgKxrHelfa0sepL7qpnJiedJA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qf9btkp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 16:05:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59DEejhX037503;
	Mon, 13 Oct 2025 16:05:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp7ru7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 16:05:11 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59DG1OvI017175;
	Mon, 13 Oct 2025 16:05:10 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 49qdp7ru76-1;
	Mon, 13 Oct 2025 16:05:10 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: alexanderduyck@fb.com, kuba@kernel.org, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        horms@kernel.org, kernel-team@meta.com, netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com
Subject: [PATCH net-next] eth: fbnic: fix various typos in comments and strings
Date: Mon, 13 Oct 2025 09:05:02 -0700
Message-ID: <20251013160507.768820-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510130073
X-Proofpoint-GUID: 50LB_t6BMxUiqPYPO0OGK7-UfKaPRXMu
X-Proofpoint-ORIG-GUID: 50LB_t6BMxUiqPYPO0OGK7-UfKaPRXMu
X-Authority-Analysis: v=2.4 cv=QfNrf8bv c=1 sm=1 tr=0 ts=68ed2338 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=sirZCL6Mtk_vwygu7mMA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfXyxTiQhjhDqqc
 0U+z0bEXGCJjaoAZfE/PG588QjDRuW5CFQ5yf3IR7pJ6yviv1utD9HPZlGK1MMUNkn9IxBOrxx4
 PKrBGdzUK6BxoWz1u/fGktZT996P17fRnuG9ydp7jGtk609fM/a42D8rrtAZVbir328P7ezP43U
 lJvZa8VEtRdey+Xb+fiiKWo5QCnV9NyIM7kncEjhQMgqT8nehGC9CHsVobelM3gDuMgQBnfH+iM
 tFpvmh+kvrPbrBb+BYsDXA1KaOQY7ioNzQwSitPqdAVgL8ZDOxphDdKdauusxBfCbvasYF253mf
 DU6Uay36otQI0+VK8PHA3fxKe7UaHICHaljMjP+JT+rSZdubRbde0Rz/O0EiP5Ks4l8qmLpbHIz
 YZl+shH/KkbYys3OP6NJ2mOIc5CcEg==

Fix several minor typos and grammatical errors in comments and log
(in fbnic firmware, PCI, and time modules)

Changes include:
 - "cordeump" -> "coredump"
 - "of" -> "off" in RPC config comment
 - "healty" -> "healthy" in firmware heartbeat comment
 - "Firmware crashed detected!" -> "Firmware crash detected!"
 - "The could be caused" -> "This could be caused"
 - "lockng" -> "locking" in fbnic_time.c

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c   | 6 +++---
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c  | 6 +++---
 drivers/net/ethernet/meta/fbnic/fbnic_time.c | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index c87cb9ed09e7..1166fa17438d 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -878,11 +878,11 @@ fbnic_fw_parse_coredump_info_resp(void *opaque, struct fbnic_tlv_msg **results)
  * @fbd: FBNIC device structure
  * @cmpl_data: Completion struct to store coredump
  * @offset: Offset into coredump requested
- * @length: Length of section of cordeump to fetch
+ * @length: Length of section of coredump to fetch
  *
  * Return: zero on success, negative errno on failure
  *
- * Asks the firmware to provide a section of the cordeump back in a message.
+ * Asks the firmware to provide a section of the coredump back in a message.
  * The response will have an offset and size matching the values provided.
  */
 int fbnic_fw_xmit_coredump_read_msg(struct fbnic_dev *fbd,
@@ -1868,7 +1868,7 @@ int fbnic_fw_xmit_rpc_macda_sync(struct fbnic_dev *fbd)
 	if (err)
 		goto free_message;
 
-	/* Send message of to FW notifying it of current RPC config */
+	/* Send message off to FW notifying it of current RPC config */
 	err = fbnic_mbx_map_tlv_msg(fbd, msg);
 	if (err)
 		goto free_message;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index a7a6b4db8016..4620f1847f2e 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -185,7 +185,7 @@ static void fbnic_health_check(struct fbnic_dev *fbd)
 {
 	struct fbnic_fw_mbx *tx_mbx = &fbd->mbx[FBNIC_IPC_MBX_TX_IDX];
 
-	/* As long as the heart is beating the FW is healty */
+	/* As long as the heart is beating the FW is healthy */
 	if (fbd->fw_heartbeat_enabled)
 		return;
 
@@ -196,7 +196,7 @@ static void fbnic_health_check(struct fbnic_dev *fbd)
 	if (tx_mbx->head != tx_mbx->tail)
 		return;
 
-	fbnic_devlink_fw_report(fbd, "Firmware crashed detected!");
+	fbnic_devlink_fw_report(fbd, "Firmware crash detected!");
 	fbnic_devlink_otp_check(fbd, "error detected after firmware recovery");
 
 	if (fbnic_fw_config_after_crash(fbd))
@@ -378,7 +378,7 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
  * @pdev: PCI device information struct
  *
  * Called by the PCI subsystem to alert the driver that it should release
- * a PCI device.  The could be caused by a Hot-Plug event, or because the
+ * a PCI device.  This could be caused by a Hot-Plug event, or because the
  * driver is going to be removed from memory.
  **/
 static void fbnic_remove(struct pci_dev *pdev)
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_time.c b/drivers/net/ethernet/meta/fbnic/fbnic_time.c
index 39d99677b71e..db7748189f45 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_time.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_time.c
@@ -253,7 +253,7 @@ static void fbnic_ptp_reset(struct fbnic_dev *fbd)
 
 void fbnic_time_init(struct fbnic_net *fbn)
 {
-	/* This is not really a statistic, but the lockng primitive fits
+	/* This is not really a statistic, but the locking primitive fits
 	 * our usecase perfectly, we need an atomic 8 bytes READ_ONCE() /
 	 * WRITE_ONCE() behavior.
 	 */
-- 
2.50.1


