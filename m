Return-Path: <netdev+bounces-19266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F6375A15F
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 00:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B04D21C2116E
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 22:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5475725151;
	Wed, 19 Jul 2023 22:08:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AC017FE9
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 22:08:10 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF2AE52
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 15:08:07 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JM7llk009871;
	Wed, 19 Jul 2023 22:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9Mpmyv4pbaF/3v9tBxbZeN6/QY+RB18xrYTlOxONRKg=;
 b=gbc6sGjTVgJKKOLEZ6dLHJ+nQV0owbGFIGXE8Pfu+GxomyWhpnAJiLeEAvuKmpx83rDu
 +98h4tNRSrc0GupyVHXC0LBVPAqrXuSX93Grllmfo4ZqpFvyFq4Xn+FPwZBRW0XtAkIZ
 L+YwQ/wTBQZc5k1TJE2XECOfHys6w5eyN/4mKw9slTWjEWWPiDSrfFMm1atoCv34l56r
 wDHDhpRkss6ZNoXbjGjV8PoI9PtWcfZH09RPKiM3rOW1/Qat5qfT4ADN49n9Uu6rJZq3
 OVmuUKm/UcFaqj6ThTr0PbXP92nawTIiFvT5bA9aqiTwLF1fbuB8dxJV+w34n9faSyml jA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rxqju8vgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jul 2023 22:08:00 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36JM7njP009988;
	Wed, 19 Jul 2023 22:07:59 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rxqju8uf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jul 2023 22:07:58 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36JL9EaH004156;
	Wed, 19 Jul 2023 22:03:20 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rv8g14gfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jul 2023 22:03:20 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36JM3JiC7733814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jul 2023 22:03:20 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B26765805E;
	Wed, 19 Jul 2023 22:03:19 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 216F25805D;
	Wed, 19 Jul 2023 22:03:19 +0000 (GMT)
Received: from ltc17u3.stglabs.ibm.com (unknown [9.114.219.126])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Jul 2023 22:03:19 +0000 (GMT)
From: Thinh Tran <thinhtr@linux.vnet.ibm.com>
To: kuba@kernel.org
Cc: aelior@marvell.com, davem@davemloft.net, edumazet@google.com,
        manishc@marvell.com, netdev@vger.kernel.org, pabeni@redhat.com,
        skalluru@marvell.com, drc@linux.vnet.ibm.com, abdhalee@in.ibm.com,
        Thinh Tran <thinhtr@linux.vnet.ibm.com>
Subject: [Patch v3] bnx2x: Fix error recovering in switch configuration
Date: Wed, 19 Jul 2023 22:02:01 +0000
Message-Id: <20230719220200.2485377-1-thinhtr@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220916195114.2474829-1-thinhtr@linux.vnet.ibm.com>
References: <20220916195114.2474829-1-thinhtr@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: W4-pES164HKgiFMfj6gUChlV3x_QCod1
X-Proofpoint-GUID: NGkOkMbK_JxK7MsziaZtLJccwddY9Kxs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_16,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 clxscore=1011 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307190199
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


As the BCM57810 and other I/O adapters are connected
through a PCIe switch, the bnx2x driver causes unexpected
system hang/crash while handling PCIe switch errors, if
its error handler is called after other drivers' handlers.

In this case, after numbers of bnx2x_tx_timout(), the
bnx2x_nic_unload() is  called, frees up resources and
calls bnx2x_napi_disable(). Then when EEH calls its
error handler, the bnx2x_io_error_detected() and
bnx2x_io_slot_reset() also calling bnx2x_napi_disable()
and freeing the resources.


Signed-off-by: Thinh Tran <thinhtr@linux.vnet.ibm.com>
Reviewed-by: Manish Chopra <manishc@marvell.com>
Tested-by: Abdul Haleem <abdhalee@in.ibm.com>
Tested-by: David Christensen <drc@linux.vnet.ibm.com>

  v3:
    - no changes, just repatched to the latest driver level 
    - updated the reviewed-by Manish in October, 2022

  v2:
   - Check the state of the NIC before calling disable nappi
     and freeing the IRQ
   - Prevent recurrence of TX timeout by turning off the carrier,
     calling netif_carrier_off() in bnx2x_tx_timeout()
   - Check and bail out early if fp->page_pool already freed

---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h   |  2 +
 .../net/ethernet/broadcom/bnx2x/bnx2x_cmn.c   | 27 +++++++++----
 .../net/ethernet/broadcom/bnx2x/bnx2x_cmn.h   |  3 ++
 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  | 38 +++++++++----------
 .../net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c  | 17 +++++----
 5 files changed, 53 insertions(+), 34 deletions(-)

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
index 6ea5521074d3..97364089ff80 100644
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
@@ -4987,6 +4992,12 @@ void bnx2x_tx_timeout(struct net_device *dev, unsigned int txqueue)
 {
 	struct bnx2x *bp = netdev_priv(dev);
 
+	/* Immediately indicate link as down */
+	bp->link_vars.link_up = 0;
+	bp->force_link_down = true;
+	netif_carrier_off(dev);
+	BNX2X_ERR("Indicating link is down due to Tx-timeout\n");
+
 	/* We want the information of the dump logged,
 	 * but calling bnx2x_panic() would kill all chances of recovery.
 	 */
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
index d8b1824c334d..bc0dee25b804 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
@@ -1015,6 +1015,9 @@ static inline void bnx2x_free_rx_sge_range(struct bnx2x *bp,
 {
 	int i;
 
+	if (!fp->page_pool.page)
+		return;
+
 	if (fp->mode == TPA_MODE_DISABLED)
 		return;
 
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 1e7a6f1d4223..adb1c7a2c367 100644
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
@@ -10273,12 +10276,6 @@ static void bnx2x_sp_rtnl_task(struct work_struct *work)
 		bp->sp_rtnl_state = 0;
 		smp_mb();
 
-		/* Immediately indicate link as down */
-		bp->link_vars.link_up = 0;
-		bp->force_link_down = true;
-		netif_carrier_off(bp->dev);
-		BNX2X_ERR("Indicating link is down due to Tx-timeout\n");
-
 		bnx2x_nic_unload(bp, UNLOAD_NORMAL, true);
 		/* When ret value shows failure of allocation failure,
 		 * the nic is rebooted again. If open still fails, a error
@@ -14238,13 +14235,16 @@ static pci_ers_result_t bnx2x_io_slot_reset(struct pci_dev *pdev)
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
2.25.1


