Return-Path: <netdev+bounces-70364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4FB84E89D
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 20:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47D231F26ADC
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 19:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF310364C1;
	Thu,  8 Feb 2024 18:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lBtaRNPI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F7936137
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 18:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707418554; cv=none; b=a9N0WZzJa3kmOv+GlJHPQljJMsARB1mx/rCJTT0ac8ffBEomW9X3+VDWap6AaC21lD/nFh5rzG+uTQUfha2+/vGDm7MgN3B7/X3f37k4Ihl9gsA9OKqvCJEX/HAYcdlglZga9BSscpJ1JxiaEEDu/EobmxFa9yZsMPNE3m8wk/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707418554; c=relaxed/simple;
	bh=KztBA/abl2hjycWS33L2FBCLP0fmSNi2+MIEcIq87oE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PhZLas4qXrmbrMCojFXGkoan8VPBYj1MdU8la/PM3JmfSB0yrzrmcoMF4NweKONW/vEW1q+cfgu5mvFr0XjgEGnXXaFQCI3FlAi8jw8EqFS96Or4ybIHuRmugyFUOtCzmBZjtWeFkiJMfa1eM0cyS8XYNCYlb3Phd6mhf3OaQQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lBtaRNPI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418I2Sdv030061;
	Thu, 8 Feb 2024 18:55:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=GSRLGIo7qsDj7J6VwFVttdc6Ip1pQnZOVRZ3QuoUkUM=;
 b=lBtaRNPItH/5ycx5fzChg9iYt18uzj3zHjCOsOellyIL2ErWSN/Md0wGgeCPdHXTRw4U
 gMi59HaH2uaHit/qz4KTahpbEg2i6SxnYZy/irOVYHDGDEV0tmhvNnsJO0Y1NrZN0Fxb
 NSTHv1OGoU+THMAX3h0FT0I5yL0LusUlyFnOgOhGlHL3HLXLTEKsx1RyodDF8oEUh8RC
 P0enqzvrRveR38XGzVzC2nmSYYYzTj9qrsL0zFhLsswQPVx+cZDYHgMhCTUzXw5k3AHY
 KxFZBqC7kpjatTiftcvlD8+VKv5sXgEZ/HUWZcvPaAzVWe6qoK3t6/GbFt7Ul++/UReP /g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w52xqjrdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 18:55:45 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 418ItioF029239;
	Thu, 8 Feb 2024 18:55:44 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w52xqjrdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 18:55:44 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 418HGOHP008818;
	Thu, 8 Feb 2024 18:55:44 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w206yxms7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 18:55:44 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 418ItftN17433236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Feb 2024 18:55:41 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 31D455805E;
	Thu,  8 Feb 2024 18:55:41 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E32505805A;
	Thu,  8 Feb 2024 18:55:40 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.41.99.4])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Feb 2024 18:55:40 +0000 (GMT)
From: Thinh Tran <thinhtr@linux.vnet.ibm.com>
To: kuba@kernel.org
Cc: netdev@vger.kernel.org, aelior@marvell.com, davem@davemloft.net,
        manishc@marvell.com, pabeni@redhat.com, skalluru@marvell.com,
        simon.horman@corigine.com, edumazet@google.com,
        VENKATA.SAI.DUGGI@ibm.com, drc@linux.vnet.ibm.com, abdhalee@in.ibm.com,
        Thinh Tran <thinhtr@linux.vnet.ibm.com>
Subject: [PATCH v8 2/2] net/bnx2x: refactor common code to bnx2x_stop_nic()
Date: Thu,  8 Feb 2024 12:55:16 -0600
Message-Id: <1149c0efc9b000bf6c28807b3f1d173079e807bd.1707414045.git.thinhtr@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1707414045.git.thinhtr@linux.vnet.ibm.com>
References: <cover.1707414045.git.thinhtr@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Y-TxjPTYBrCdFiJ68vCY_MU0RmZqNg1r
X-Proofpoint-GUID: xo_oM-Rra8qg-hGddhzhnZO6p8XQPK2G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_08,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=925 impostorscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080099

Refactor common code which disables and releases HW interrupts, deletes
NAPI objects, into a new bnx2x_stop_nic() function.

Signed-off-by: Thinh Tran <thinhtr@linux.vnet.ibm.com>

---
 .../net/ethernet/broadcom/bnx2x/bnx2x_cmn.c   | 28 +++++++++++--------
 .../net/ethernet/broadcom/bnx2x/bnx2x_cmn.h   |  1 +
 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  | 25 +++--------------
 .../net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c  | 12 ++------
 4 files changed, 24 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
index e9c1e1bb5580..e34aff5fb782 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -3097,17 +3097,8 @@ int bnx2x_nic_unload(struct bnx2x *bp, int unload_mode, bool keep_link)
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
@@ -5139,3 +5130,18 @@ void bnx2x_schedule_sp_rtnl(struct bnx2x *bp, enum sp_rtnl_flag flag,
 	   flag);
 	schedule_delayed_work(&bp->sp_rtnl_task, 0);
 }
+
+void bnx2x_stop_nic(struct bnx2x *bp, int disable_hw)
+{
+	if (!bp->nic_stopped) {
+		/* Disable HW interrupts, NAPI */
+		bnx2x_netif_stop(bp, disable_hw);
+		/* Delete all NAPI objects */
+		bnx2x_del_all_napi(bp);
+		if (CNIC_LOADED(bp))
+			bnx2x_del_all_napi_cnic(bp);
+		/* Release IRQs */
+		bnx2x_free_irq(bp);
+		bp->nic_stopped = true;
+	}
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


