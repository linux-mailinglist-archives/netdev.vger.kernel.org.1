Return-Path: <netdev+bounces-22430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5F5767772
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 23:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 383E12826DB
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 21:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093A61DA42;
	Fri, 28 Jul 2023 21:12:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB95156E6
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 21:12:08 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457D1449C
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 14:12:07 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36SL8Lcj026713;
	Fri, 28 Jul 2023 21:11:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=vutloDwl2/dELbA6V614gZo9lbvPFX1NX/vV6fRvLCA=;
 b=gOfnO5qEoYe4KM60dq3jkAxVLsTN/w9Gb6kKRk5mlSKfHqM+Do3aS6GszwDwE4yO3a2J
 xV1E18+eCE++pajDhiFk56atqX+Rr/5NwM8zpUlRfhGNcetsJb0HqJ5sGyZMJBQLEJmA
 PxT7Z7vsRITZ+Kf7xtCUw9Kh2Owe4M3IMDIX9y8YBROC886JLvbVwSkQWY2d6OUDAGHQ
 Bt4C41W0t5XT8+tHafSn7pfMFq1wqubh9wFzWrGJhEytofUugp62Oz/VUYiIKD2OEfY+
 K972dg7hBqwT2JnWRGj0bw3e20JtJEOM9gSOT+u5WgTqSr0LCxxM/jPI0VwngnLfvd+e uw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s4m7mhq2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jul 2023 21:11:54 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36SL8RTo027619;
	Fri, 28 Jul 2023 21:11:54 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s4m7mhq27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jul 2023 21:11:53 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36SJfmhU014387;
	Fri, 28 Jul 2023 21:11:53 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s0stysnwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jul 2023 21:11:53 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36SLBqTO63832430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Jul 2023 21:11:52 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61BD25805A;
	Fri, 28 Jul 2023 21:11:52 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CC525803F;
	Fri, 28 Jul 2023 21:11:52 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.40.193.89])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Jul 2023 21:11:52 +0000 (GMT)
From: Thinh Tran <thinhtr@linux.vnet.ibm.com>
To: kuba@kernel.org
Cc: aelior@marvell.com, davem@davemloft.net, edumazet@google.com,
        manishc@marvell.com, netdev@vger.kernel.org, pabeni@redhat.com,
        skalluru@marvell.com, drc@linux.vnet.ibm.com, abdhalee@in.ibm.com,
        simon.horman@corigine.com, Thinh Tran <thinhtr@linux.vnet.ibm.com>
Subject: [PATCH v4] bnx2x: Fix error recovering in switch configuration
Date: Fri, 28 Jul 2023 16:11:33 -0500
Message-Id: <20230728211133.2240873-1-thinhtr@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
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
X-Proofpoint-ORIG-GUID: RuC65V7e8wOk8wDvqiIU_zKg2fgPiq79
X-Proofpoint-GUID: _FKcmxOmghAxscN8Qq8ajvGcg--l1lJU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280192
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

Reviewed-by: Simon Horman <simon.horman@corigine.com>

  v4:
   - factoring common code into new function bnx2x_stop_nic()
     that disables and releases IRQs and NAPIs 
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
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h   |  2 ++
 .../net/ethernet/broadcom/bnx2x/bnx2x_cmn.c   | 18 +++++++------
 .../net/ethernet/broadcom/bnx2x/bnx2x_cmn.h   | 18 +++++++++++++
 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  | 25 +++----------------
 .../net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c  |  9 ++-----
 5 files changed, 36 insertions(+), 36 deletions(-)

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
index 6ea5521074d3..b4143c427936 100644
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
@@ -3095,14 +3097,8 @@ int bnx2x_nic_unload(struct bnx2x *bp, int unload_mode, bool keep_link)
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
+		/* Disable HW interrupts, delete NAPIs, Release IRQs */
+		bnx2x_stop_nic(bp);
 
 		/* Report UNLOAD_DONE to MCP */
 		bnx2x_send_unload_done(bp, false);
@@ -4987,6 +4983,12 @@ void bnx2x_tx_timeout(struct net_device *dev, unsigned int txqueue)
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
index d8b1824c334d..f5ecbe8d604a 100644
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
 
@@ -1399,5 +1402,20 @@ void bnx2x_set_os_driver_state(struct bnx2x *bp, u32 state);
  */
 int bnx2x_nvram_read(struct bnx2x *bp, u32 offset, u8 *ret_buf,
 		     int buf_size);
+static inline void bnx2x_stop_nic(struct bnx2x *bp)
+{
+	if (!bp->nic_stopped) {
+		/* Disable HW interrupts, NAPI */
+		bnx2x_netif_stop(bp, 1);
+		/* Delete all NAPI objects */
+		bnx2x_del_all_napi(bp);
+		if (CNIC_LOADED(bp))
+			bnx2x_del_all_napi_cnic(bp);
+		/* Release IRQs */
+		bnx2x_free_irq(bp);
+		bp->nic_stopped = true;
+	}
+}
+
 
 #endif /* BNX2X_CMN_H */
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 1e7a6f1d4223..e40c83b8b32e 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -9474,15 +9474,8 @@ void bnx2x_chip_cleanup(struct bnx2x *bp, int unload_mode, bool keep_link)
 		}
 	}
 
-	/* Disable HW interrupts, NAPI */
-	bnx2x_netif_stop(bp, 1);
-	/* Delete all NAPI objects */
-	bnx2x_del_all_napi(bp);
-	if (CNIC_LOADED(bp))
-		bnx2x_del_all_napi_cnic(bp);
-
-	/* Release IRQs */
-	bnx2x_free_irq(bp);
+	/* Disable HW interrupts, delete NAPIs, Release IRQs */
+	bnx2x_stop_nic(bp);
 
 	/* Reset the chip, unless PCI function is offline. If we reach this
 	 * point following a PCI error handling, it means device is really
@@ -10273,12 +10266,6 @@ static void bnx2x_sp_rtnl_task(struct work_struct *work)
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
@@ -14238,13 +14225,9 @@ static pci_ers_result_t bnx2x_io_slot_reset(struct pci_dev *pdev)
 		}
 		bnx2x_drain_tx_queues(bp);
 		bnx2x_send_unload_req(bp, UNLOAD_RECOVERY);
-		bnx2x_netif_stop(bp, 1);
-		bnx2x_del_all_napi(bp);
-
-		if (CNIC_LOADED(bp))
-			bnx2x_del_all_napi_cnic(bp);
 
-		bnx2x_free_irq(bp);
+		/* Disable HW interrupts, delete NAPIs, Release IRQs */
+		bnx2x_stop_nic(bp);
 
 		/* Report UNLOAD_DONE to MCP */
 		bnx2x_send_unload_done(bp, true);
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c
index 0657a0f5170f..d8af7c453172 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c
@@ -529,13 +529,8 @@ void bnx2x_vfpf_close_vf(struct bnx2x *bp)
 	bnx2x_vfpf_finalize(bp, &req->first_tlv);
 
 free_irq:
-	/* Disable HW interrupts, NAPI */
-	bnx2x_netif_stop(bp, 0);
-	/* Delete all NAPI objects */
-	bnx2x_del_all_napi(bp);
-
-	/* Release IRQs */
-	bnx2x_free_irq(bp);
+	/* Disable HW interrupts, delete NAPIs, Release IRQs */
+	bnx2x_stop_nic(bp);
 }
 
 static void bnx2x_leading_vfq_init(struct bnx2x *bp, struct bnx2x_virtf *vf,
-- 
2.31.1


