Return-Path: <netdev+bounces-26937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6434A779863
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 22:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 181AB282423
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 20:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C90329A2;
	Fri, 11 Aug 2023 20:15:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC44C8468
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 20:15:51 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC56B35A3
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 13:15:48 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BJs3Ex032420;
	Fri, 11 Aug 2023 20:15:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=nYzbAa3rDBM3I2s+RfKpQeVgUkDaoWLwIYbrMYjMQ+s=;
 b=GF9Aw4Q8oY+L9F/hRxjlWtObPVUJGyMfBzaEmf2tNp4Te+maS7bWvlLzYrVZPQzweMdK
 ahauCKCvm3lQ24WYX+RtQP5SkNwSQL2fK4vHdJPOp29yoSKce2Q+GTdVi89II+ak5P7Q
 nsVYXbE4OImT7ZmI2nEe68RGV2ddcRY8Mgx+rmH3s1LTDb6X2bG/eN14+AFFhGKKgzIL
 lffnCLkqVvgQ0jUZGHFc3PnelzNsyDs/23Kkm65opgZP863Lw4QA2FuEiTPI4kwdEOjA
 yBClg5t9yGlcq4ECWLZ2oqLMTtJU3ywqb4k7E9hYUAdm11DqZOkNbspwm1c8j4JlD3Dh og== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sduhtrhh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Aug 2023 20:15:42 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37BJuxSL007772;
	Fri, 11 Aug 2023 20:15:42 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sduhtrhgx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Aug 2023 20:15:42 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37BIf5kE007543;
	Fri, 11 Aug 2023 20:15:41 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sa15066wb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Aug 2023 20:15:41 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37BKFeg23998292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Aug 2023 20:15:40 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE0B758052;
	Fri, 11 Aug 2023 20:15:40 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91ACD5805D;
	Fri, 11 Aug 2023 20:15:40 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.53.174.71])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Aug 2023 20:15:40 +0000 (GMT)
From: Thinh Tran <thinhtr@linux.vnet.ibm.com>
To: kuba@kernel.org
Cc: aelior@marvell.com, davem@davemloft.net, edumazet@google.com,
        manishc@marvell.com, netdev@vger.kernel.org, pabeni@redhat.com,
        skalluru@marvell.com, VENKATA.SAI.DUGGI@ibm.com,
        Thinh Tran <thinhtr@linux.vnet.ibm.com>
Subject: [Patch v5 1/4] bnx2x: new the bp->nic_stopped variable for checking NIC status
Date: Fri, 11 Aug 2023 15:15:09 -0500
Message-Id: <20230811201512.461657-2-thinhtr@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230811201512.461657-1-thinhtr@linux.vnet.ibm.com>
References: <20230728211133.2240873-1-thinhtr@linux.vnet.ibm.com>
 <20230811201512.461657-1-thinhtr@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wMVXbbHQEIOsadHXwKBthYnXTfwWdaTS
X-Proofpoint-ORIG-GUID: XrcgOpDAVkT5yh83Bpx2gUtWVNQWuXml
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_12,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308110184
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Introducing 'nic_stopped' to verify the NIC's status before disabling
NAPI and freeing IRQs

Signed-off-by: Thinh Tran <thinhtr@linux.vnet.ibm.com>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h   |  2 ++
 .../net/ethernet/broadcom/bnx2x/bnx2x_cmn.c   | 21 +++++++-----
 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  | 32 +++++++++++--------
 .../net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c  | 17 ++++++----
 4 files changed, 44 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
index de24ba76bfba..a00f1e1316bb 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
@@ -1509,6 +1509,8 @@ struct bnx2x {
 	bool			cnic_loaded;
 	struct cnic_eth_dev	*(*cnic_probe)(struct net_device *);
 
+	bool                    nic_stopped;
+
 	/* Flag that indicates that we can start looking for FCoE L2 queue
 	 * completions in the default status block.
 	 */
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
index f34e008e12d4..feb0c23788ab 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -2703,6 +2703,7 @@ int bnx2x_nic_load(struct bnx2x *bp, int load_mode)
 	bnx2x_add_all_napi(bp);
 	DP(NETIF_MSG_IFUP, "napi added\n");
 	bnx2x_napi_enable(bp);
+	bp->nic_stopped = false;
 
 	if (IS_PF(bp)) {
 		/* set pf load just before approaching the MCP */
@@ -2948,6 +2949,7 @@ load_error2:
 load_error1:
 	bnx2x_napi_disable(bp);
 	bnx2x_del_all_napi(bp);
+	bp->nic_stopped = true;
 
 	/* clear pf_load status, as it was already set */
 	if (IS_PF(bp))
@@ -3083,14 +3085,17 @@ int bnx2x_nic_unload(struct bnx2x *bp, int unload_mode, bool keep_link)
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
index 7516a2fb80ba..755e3bf8f44a 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -9475,15 +9475,18 @@ unload_error:
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
@@ -14256,13 +14259,16 @@ static pci_ers_result_t bnx2x_io_slot_reset(struct pci_dev *pdev)
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
index 7c96f943c6f3..0802462b4d16 100644
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


