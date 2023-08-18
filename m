Return-Path: <netdev+bounces-28845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8827578100A
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 978711C2162A
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 16:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF07219BB8;
	Fri, 18 Aug 2023 16:15:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAC4182B5
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 16:15:03 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850EC3C21
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 09:15:00 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37IGCLlF027469;
	Fri, 18 Aug 2023 16:14:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=5MgDJwb3huQIuSkQiYsB8RAwW3FBQYwykrRCcjUNhUk=;
 b=TH3oCiPEemLY0KpyFBLq8kQ25I6sxWZUot6xEjRObbRobIgUPmePU3CemgCMAP2ioBZw
 Bc7cY+kRr4cs5MwnndFKELxht8+n9x0QFdemnHibTYig0uSXpbrgeUiMJgGZ7uAnHKW5
 FMZ6glRSl053R1vCDeUjpkL3IxYplbJj0t66EOpEgKi+MCXTYKax87+xyGUhJK81Radi
 RtU7VEnpra+0tvC5MZ9UHSfXXBz6hWfs7i3hZElTbYVelt/ahffb9qr6HcZ3oIouCQML
 /V8XQlYLWkSmdKoc67qQd2ApqhG5qfTa9mgkrAL2oXf+ALclxe78YtKj0MlEfOD6HQMr ag== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sjby101y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Aug 2023 16:14:56 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37IGDKD4029419;
	Fri, 18 Aug 2023 16:14:56 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sjby101xn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Aug 2023 16:14:56 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37IFdDd0018848;
	Fri, 18 Aug 2023 16:14:54 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3seq427qpd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Aug 2023 16:14:54 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37IGEswF23266046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Aug 2023 16:14:54 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AADF5805E;
	Fri, 18 Aug 2023 16:14:54 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAA9358043;
	Fri, 18 Aug 2023 16:14:53 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.53.174.71])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Aug 2023 16:14:53 +0000 (GMT)
From: Thinh Tran <thinhtr@linux.vnet.ibm.com>
To: kuba@kernel.org
Cc: aelior@marvell.com, davem@davemloft.net, edumazet@google.com,
        manishc@marvell.com, netdev@vger.kernel.org, pabeni@redhat.com,
        skalluru@marvell.com, VENKATA.SAI.DUGGI@ibm.com,
        Thinh Tran <thinhtr@linux.vnet.ibm.com>
Subject: [Patch v6 1/4] bnx2x: new flag for track HW resource
Date: Fri, 18 Aug 2023 11:14:40 -0500
Message-Id: <20230818161443.708785-2-thinhtr@linux.vnet.ibm.com>
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
X-Proofpoint-ORIG-GUID: kzwnhT3Y9yq25dLHo3zOUAleItoAumvY
X-Proofpoint-GUID: a_1272dRsG35gbBnY9uwv1-WwU-5z9u7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_20,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=950 mlxscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308180147
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Add a new flag, nic_stopped, to track NIC resource usage (HW interrupts,
NAPI objection allocation).

Signed-off-by: Thinh Tran <thinhtr@linux.vnet.ibm.com>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h   |  2 ++
 .../net/ethernet/broadcom/bnx2x/bnx2x_cmn.c   | 21 +++++++-----
 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  | 32 +++++++++++--------
 .../net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c  | 17 ++++++----
 4 files changed, 44 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
index 8bcde0a6e011..e2a4e1088b7f 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
@@ -1508,6 +1508,8 @@ struct bnx2x {
 	bool			cnic_loaded;
 	struct cnic_eth_dev	*(*cnic_probe)(struct net_device *);
 
+	bool                    nic_stopped;
+
 	/* Flag that indicates that we can start looking for FCoE L2 queue
 	 * completions in the default status block.
 	 */
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
index 6ea5521074d3..e9c1e1bb5580 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -2715,6 +2715,7 @@ int bnx2x_nic_load(struct bnx2x *bp, int load_mode)
 	bnx2x_add_all_napi(bp);
 	DP(NETIF_MSG_IFUP, "napi added\n");
 	bnx2x_napi_enable(bp);
+	bp->nic_stopped = false;
 
 	if (IS_PF(bp)) {
 		/* set pf load just before approaching the MCP */
@@ -2960,6 +2961,7 @@ int bnx2x_nic_load(struct bnx2x *bp, int load_mode)
 load_error1:
 	bnx2x_napi_disable(bp);
 	bnx2x_del_all_napi(bp);
+	bp->nic_stopped = true;
 
 	/* clear pf_load status, as it was already set */
 	if (IS_PF(bp))
@@ -3095,14 +3097,17 @@ int bnx2x_nic_unload(struct bnx2x *bp, int unload_mode, bool keep_link)
 		if (!CHIP_IS_E1x(bp))
 			bnx2x_pf_disable(bp);
 
-		/* Disable HW interrupts, NAPI */
-		bnx2x_netif_stop(bp, 1);
-		/* Delete all NAPI objects */
-		bnx2x_del_all_napi(bp);
-		if (CNIC_LOADED(bp))
-			bnx2x_del_all_napi_cnic(bp);
-		/* Release IRQs */
-		bnx2x_free_irq(bp);
+		if (!bp->nic_stopped) {
+			/* Disable HW interrupts, NAPI */
+			bnx2x_netif_stop(bp, 1);
+			/* Delete all NAPI objects */
+			bnx2x_del_all_napi(bp);
+			if (CNIC_LOADED(bp))
+				bnx2x_del_all_napi_cnic(bp);
+			/* Release IRQs */
+			bnx2x_free_irq(bp);
+			bp->nic_stopped = true;
+		}
 
 		/* Report UNLOAD_DONE to MCP */
 		bnx2x_send_unload_done(bp, false);
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 1e7a6f1d4223..0d8e61c63c7c 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -9474,15 +9474,18 @@ void bnx2x_chip_cleanup(struct bnx2x *bp, int unload_mode, bool keep_link)
 		}
 	}
 
-	/* Disable HW interrupts, NAPI */
-	bnx2x_netif_stop(bp, 1);
-	/* Delete all NAPI objects */
-	bnx2x_del_all_napi(bp);
-	if (CNIC_LOADED(bp))
-		bnx2x_del_all_napi_cnic(bp);
+	if (!bp->nic_stopped) {
+		/* Disable HW interrupts, NAPI */
+		bnx2x_netif_stop(bp, 1);
+		/* Delete all NAPI objects */
+		bnx2x_del_all_napi(bp);
+		if (CNIC_LOADED(bp))
+			bnx2x_del_all_napi_cnic(bp);
 
-	/* Release IRQs */
-	bnx2x_free_irq(bp);
+		/* Release IRQs */
+		bnx2x_free_irq(bp);
+		bp->nic_stopped = true;
+	}
 
 	/* Reset the chip, unless PCI function is offline. If we reach this
 	 * point following a PCI error handling, it means device is really
@@ -14238,13 +14241,16 @@ static pci_ers_result_t bnx2x_io_slot_reset(struct pci_dev *pdev)
 		}
 		bnx2x_drain_tx_queues(bp);
 		bnx2x_send_unload_req(bp, UNLOAD_RECOVERY);
-		bnx2x_netif_stop(bp, 1);
-		bnx2x_del_all_napi(bp);
+		if (!bp->nic_stopped) {
+			bnx2x_netif_stop(bp, 1);
+			bnx2x_del_all_napi(bp);
 
-		if (CNIC_LOADED(bp))
-			bnx2x_del_all_napi_cnic(bp);
+			if (CNIC_LOADED(bp))
+				bnx2x_del_all_napi_cnic(bp);
 
-		bnx2x_free_irq(bp);
+			bnx2x_free_irq(bp);
+			bp->nic_stopped = true;
+		}
 
 		/* Report UNLOAD_DONE to MCP */
 		bnx2x_send_unload_done(bp, true);
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c
index 0657a0f5170f..8946a931e87e 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c
@@ -529,13 +529,16 @@ void bnx2x_vfpf_close_vf(struct bnx2x *bp)
 	bnx2x_vfpf_finalize(bp, &req->first_tlv);
 
 free_irq:
-	/* Disable HW interrupts, NAPI */
-	bnx2x_netif_stop(bp, 0);
-	/* Delete all NAPI objects */
-	bnx2x_del_all_napi(bp);
-
-	/* Release IRQs */
-	bnx2x_free_irq(bp);
+	if (!bp->nic_stopped) {
+		/* Disable HW interrupts, NAPI */
+		bnx2x_netif_stop(bp, 0);
+		/* Delete all NAPI objects */
+		bnx2x_del_all_napi(bp);
+
+		/* Release IRQs */
+		bnx2x_free_irq(bp);
+		bp->nic_stopped = true;
+	}
 }
 
 static void bnx2x_leading_vfq_init(struct bnx2x *bp, struct bnx2x_virtf *vf,
-- 
2.27.0


