Return-Path: <netdev+bounces-80184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EA187D61A
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 22:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97DF21C2208D
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 21:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A4C5478B;
	Fri, 15 Mar 2024 21:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Baj8LWoT"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED1918035
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 21:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710538013; cv=none; b=eH6vk5D9Kr4UdAO0eIykJPxfpz+RcQQIrPpPh/J3+D46J3SmsFu1jmrgj6zjlTaNPG5vTJfxAyD5O8uINbQbSEnnvJoKMRwyNM+myURT2Ssq1rj3GlrDSMnBer1zMqvC/iLwIw+a6vq8KCpZ/d2+UqaYYtfsC/Pq0xOoWEN+Hkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710538013; c=relaxed/simple;
	bh=fwO8Pvq5SguzauvM7K6iEnLhOW7Kbb0nLF5oZ1mUIBI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xx9r8VaTOCQFm0pytsg/tgnAiK0Sj+8B4ZWJLgAWaWxpV4z11sdI5Yok2qTcmO/7x2SP+SE4Rn9yTHCsh3vEzBrxsRed8+9J23qM92YI/lwjNL94bgY1eMvA0XCRm2U7vMbHVodAkeaz+BVfGou6Mj3YRRPAyWAMxJXDlotkFCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Baj8LWoT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42FInvIh022327;
	Fri, 15 Mar 2024 21:26:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=WaTPXPGrOTCCTI0799tm1Zgru4EqM7w4LzqQYMS44dg=;
 b=Baj8LWoTd5dhMM8l3pBHyB2RZw5US+W7Zq7d71FZps+N7Wc1lqDPBKfZMRkCSBdQZC2c
 AepEjE0snyAJAHUTbGWHYBjfWazyF15x5Z9jQqZcjtzUc59FeZvcZfkFLOhH7nAQUJrd
 Q3izs9E/vARjmwEnPUNPYy9Nw2ZMXLHRatIquCmE2srHKisWgxjlDsZhivwhezcim9uh
 Od6sa5oyKhMuz8w8K9Djv0mE2ZHZPgF/ReaABuHKNRxmYrO1+exiJbcgz1Ov6+2JGGRo
 4KxDMybsptt8LT5ws15FRA9A+BcwZWNvusZPWq4NaNqTHULQeUv6P9rto3tEqaTu/0XX hA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wvtx6t9jv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 21:26:35 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42FLQYEh026966;
	Fri, 15 Mar 2024 21:26:35 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wvtx6t9jp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 21:26:34 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42FJIN9c032187;
	Fri, 15 Mar 2024 21:26:34 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wvsyashfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 21:26:34 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42FLQSBT44761528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Mar 2024 21:26:30 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9068558070;
	Fri, 15 Mar 2024 21:26:28 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C7F658062;
	Fri, 15 Mar 2024 21:26:27 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.67.38.237])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 Mar 2024 21:26:26 +0000 (GMT)
From: Thinh Tran <thinhtr@linux.ibm.com>
To: jacob.e.keller@intel.com, kuba@kernel.org
Cc: netdev@vger.kernel.org, VENKATA.SAI.DUGGI@ibm.com, abdhalee@in.ibm.com,
        aelior@marvell.com, davem@davemloft.net, drc@linux.vnet.ibm.com,
        edumazet@google.com, manishc@marvell.com, pabeni@redhat.com,
        simon.horman@corigine.com, skalluru@marvell.com,
        Thinh Tran <thinhtr@linux.ibm.com>
Subject: [PATCH v11] net-next/bnx2x: refactor common code to bnx2x_stop_nic()
Date: Fri, 15 Mar 2024 16:26:25 -0500
Message-Id: <20240315212625.1589-1-thinhtr@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -tF1Va_cUT3Yq5RztzwOfJ48Vag0n1jC
X-Proofpoint-ORIG-GUID: IMWt924lc6o66WoaG1nagtSdfCDrQpbK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-15_08,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403150170

Refactor common code which disables and releases HW interrupts, deletes
NAPI objects, into a new bnx2x_stop_nic() function.

Fixes: bf23ffc8a9a7 ("bnx2x: new flag for track HW resource allocation")
v11: updated with coding style per Jacob's suggestion
     this patch targets net-next

Signed-off-by: Thinh Tran <thinhtr@linux.ibm.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

---
 .../net/ethernet/broadcom/bnx2x/bnx2x_cmn.c   | 29 ++++++++++++-------
 .../net/ethernet/broadcom/bnx2x/bnx2x_cmn.h   |  1 +
 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  | 25 +++-------------
 .../net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c  | 12 ++------
 4 files changed, 25 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
index c9b6acd8c892..a413b555059e 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -3098,17 +3098,8 @@ int bnx2x_nic_unload(struct bnx2x *bp, int unload_mode, bool keep_link)
 		if (!CHIP_IS_E1x(bp))
 			bnx2x_pf_disable(bp);
 
-		if (!bp->nic_stopped) {
-			/* Disable HW interrupts, NAPI */
-			bnx2x_netif_stop(bp, 1);
-			/* Delete all NAPI objects */
-			bnx2x_del_all_napi(bp);
-			if (CNIC_LOADED(bp))
-				bnx2x_del_all_napi_cnic(bp);
-			/* Release IRQs */
-			bnx2x_free_irq(bp);
-			bp->nic_stopped = true;
-		}
+		/* Disable HW interrupts, delete NAPIs, Release IRQs */
+		bnx2x_stop_nic(bp, 1);
 
 		/* Report UNLOAD_DONE to MCP */
 		bnx2x_send_unload_done(bp, false);
@@ -5138,3 +5129,19 @@ void bnx2x_schedule_sp_rtnl(struct bnx2x *bp, enum sp_rtnl_flag flag,
 	   flag);
 	schedule_delayed_work(&bp->sp_rtnl_task, 0);
 }
+
+void bnx2x_stop_nic(struct bnx2x *bp, int disable_hw)
+{
+	if (bp->nic_stopped)
+		return;
+
+	/* Disable HW interrupts, NAPI */
+	bnx2x_netif_stop(bp, disable_hw);
+	/* Delete all NAPI objects */
+	bnx2x_del_all_napi(bp);
+	if (CNIC_LOADED(bp))
+		bnx2x_del_all_napi_cnic(bp);
+	/* Release IRQs */
+	bnx2x_free_irq(bp);
+	bp->nic_stopped = true;
+}
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
index 0bc1367fd649..a35a02299b33 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
@@ -553,6 +553,7 @@ void bnx2x_free_skbs(struct bnx2x *bp);
 void bnx2x_netif_stop(struct bnx2x *bp, int disable_hw);
 void bnx2x_netif_start(struct bnx2x *bp);
 int bnx2x_load_cnic(struct bnx2x *bp);
+void bnx2x_stop_nic(struct bnx2x *bp, int disable_hw);
 
 /**
  * bnx2x_enable_msix - set msix configuration.
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 0d8e61c63c7c..ff75c883cffe 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -9474,18 +9474,8 @@ void bnx2x_chip_cleanup(struct bnx2x *bp, int unload_mode, bool keep_link)
 		}
 	}
 
-	if (!bp->nic_stopped) {
-		/* Disable HW interrupts, NAPI */
-		bnx2x_netif_stop(bp, 1);
-		/* Delete all NAPI objects */
-		bnx2x_del_all_napi(bp);
-		if (CNIC_LOADED(bp))
-			bnx2x_del_all_napi_cnic(bp);
-
-		/* Release IRQs */
-		bnx2x_free_irq(bp);
-		bp->nic_stopped = true;
-	}
+	/* Disable HW interrupts, delete NAPIs, Release IRQs */
+	bnx2x_stop_nic(bp, 1);
 
 	/* Reset the chip, unless PCI function is offline. If we reach this
 	 * point following a PCI error handling, it means device is really
@@ -14241,16 +14231,9 @@ static pci_ers_result_t bnx2x_io_slot_reset(struct pci_dev *pdev)
 		}
 		bnx2x_drain_tx_queues(bp);
 		bnx2x_send_unload_req(bp, UNLOAD_RECOVERY);
-		if (!bp->nic_stopped) {
-			bnx2x_netif_stop(bp, 1);
-			bnx2x_del_all_napi(bp);
 
-			if (CNIC_LOADED(bp))
-				bnx2x_del_all_napi_cnic(bp);
-
-			bnx2x_free_irq(bp);
-			bp->nic_stopped = true;
-		}
+		/* Disable HW interrupts, delete NAPIs, Release IRQs */
+		bnx2x_stop_nic(bp, 1);
 
 		/* Report UNLOAD_DONE to MCP */
 		bnx2x_send_unload_done(bp, true);
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c
index 8946a931e87e..e92e82423096 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c
@@ -529,16 +529,8 @@ void bnx2x_vfpf_close_vf(struct bnx2x *bp)
 	bnx2x_vfpf_finalize(bp, &req->first_tlv);
 
 free_irq:
-	if (!bp->nic_stopped) {
-		/* Disable HW interrupts, NAPI */
-		bnx2x_netif_stop(bp, 0);
-		/* Delete all NAPI objects */
-		bnx2x_del_all_napi(bp);
-
-		/* Release IRQs */
-		bnx2x_free_irq(bp);
-		bp->nic_stopped = true;
-	}
+	/* Disable HW interrupts, delete NAPIs, Release IRQs */
+	bnx2x_stop_nic(bp, 0);
 }
 
 static void bnx2x_leading_vfq_init(struct bnx2x *bp, struct bnx2x_virtf *vf,
-- 
2.25.1


