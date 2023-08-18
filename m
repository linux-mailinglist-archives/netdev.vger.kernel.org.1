Return-Path: <netdev+bounces-28848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 378BD781015
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5952C1C2167F
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 16:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B94E19BDD;
	Fri, 18 Aug 2023 16:15:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E5419BC2
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 16:15:07 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9823C20
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 09:15:03 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37IFq02m029607;
	Fri, 18 Aug 2023 16:14:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=kdldwyBM+u0e+a3kRtpHx4UZvKJkSp7+hXTgyrlUspI=;
 b=egjTJUzIdEVdohrH4hWbhpOOvovuQ++ZwjumKhz0cNq56lXB6q/aYf2hgLfT17xOIVAl
 v5Me+Iob5YUz49/IjQ86bD8vS4Jue6n7TF2hel4Q5AAKIKuQ3vndm3Q2w94VNzQPIiQn
 3kUsQU4+iXie6yU80TAlIa84744VORGceouLiLXN+8hUE9e+6qIg1NYa7DtJ6B2S1ogr
 TKVNqRWFOgMc5T7Tv13FrLaUoe1iyn1t6JHFYorpRUIlUKP13z9Fz2+VHIGJKWzAQfMZ
 9uGmaiyh29FW6WNN6H0uvRSQwnSDxPN69pASvYj+BBL2zBWgmk8ChEmO7asSPPWZuZDR 0Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sjbnq8muw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Aug 2023 16:14:57 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37IG0B3K023859;
	Fri, 18 Aug 2023 16:14:57 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sjbnq8muh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Aug 2023 16:14:56 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37IF058n013234;
	Fri, 18 Aug 2023 16:14:56 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sepmkfv3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Aug 2023 16:14:56 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37IGEtgB5899004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Aug 2023 16:14:55 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3557C58043;
	Fri, 18 Aug 2023 16:14:55 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFC6258055;
	Fri, 18 Aug 2023 16:14:54 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.53.174.71])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Aug 2023 16:14:54 +0000 (GMT)
From: Thinh Tran <thinhtr@linux.vnet.ibm.com>
To: kuba@kernel.org
Cc: aelior@marvell.com, davem@davemloft.net, edumazet@google.com,
        manishc@marvell.com, netdev@vger.kernel.org, pabeni@redhat.com,
        skalluru@marvell.com, VENKATA.SAI.DUGGI@ibm.com,
        Thinh Tran <thinhtr@linux.vnet.ibm.com>
Subject: [Patch v6 2/4] bnx2x: factor out common code to bnx2x_stop_nic()
Date: Fri, 18 Aug 2023 11:14:41 -0500
Message-Id: <20230818161443.708785-3-thinhtr@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230818161443.708785-1-thinhtr@linux.vnet.ibm.com>
References: <20230728211133.2240873-1-thinhtr@linux.vnet.ibm.com>
 <20230818161443.708785-1-thinhtr@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: scm4H1XPqcg40aVypGPfqvqXsFJ8kQJF
X-Proofpoint-ORIG-GUID: k3Cuhht-9a65taXblQAtfp-91RF0j2PW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_20,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=883 lowpriorityscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308180147
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Refactor common code which disables and releases HW interrupts, deletes
NAPI objects, into a new bnx2x_stop_nic() function.

Signed-off-by: Thinh Tran <thinhtr@linux.vnet.ibm.com>
---
 .../net/ethernet/broadcom/bnx2x/bnx2x_cmn.c   | 28 +++++++++++--------
 .../net/ethernet/broadcom/bnx2x/bnx2x_cmn.h   |  1 +
 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  | 26 +++--------------
 .../net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c  | 12 ++------
 4 files changed, 24 insertions(+), 43 deletions(-)

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
index d8b1824c334d..0ad879a5af95 100644
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
index 0d8e61c63c7c..13d2a7761c24 100644
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
@@ -14241,16 +14231,8 @@ static pci_ers_result_t bnx2x_io_slot_reset(struct pci_dev *pdev)
 		}
 		bnx2x_drain_tx_queues(bp);
 		bnx2x_send_unload_req(bp, UNLOAD_RECOVERY);
-		if (!bp->nic_stopped) {
-			bnx2x_netif_stop(bp, 1);
-			bnx2x_del_all_napi(bp);
-
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
2.27.0


