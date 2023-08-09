Return-Path: <netdev+bounces-26081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 756E8776BFB
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 00:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF9F41C213BA
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 22:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597341DDDC;
	Wed,  9 Aug 2023 22:10:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA8C1E509
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 22:10:52 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB171FF
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 15:10:50 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 379LoJhl003843;
	Wed, 9 Aug 2023 22:10:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=tyHdrgUpSi9+bWWeZRXQJjfPKi1bDYEZiTifR7Dxlq4=;
 b=Bq2UYg3c0P4DtepTiXmAGhcgNmO3BY3QHsSwA1obRJ7GQdJlHl0Ke5h9WR8bbGmWfOSs
 Jw2Scp73qYiPio7bf+Q87Uq8UhI9Yz4elM/DzbEj/Vv9qsC0ZhMsl4IXIchKEZgRmtrE
 hQMGnaHhjed52EzxV9KEY/HtGnKea63x9RdmxHDTyHfJngiiG561BLtXmq1iEmqwk0IE
 7uFUcbKcbORDH7Pgf2pkapQJBK6N8oWAr+CLaaV2mMWrjeN2RRkZDD3ajFvadCewEJyE
 sB6quom0M3L8LbziNrt+EMncFIsF2vHz5dYDce0Lj8uQuTKLIPau3rSbOkI6Btg8sDu2 Ig== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sck2e8er5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Aug 2023 22:10:48 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 379Jub5B030374;
	Wed, 9 Aug 2023 22:10:47 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sa1rnm3qv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Aug 2023 22:10:47 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 379MAjkW29557220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Aug 2023 22:10:45 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 614D658060;
	Wed,  9 Aug 2023 22:10:45 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 387F35805A;
	Wed,  9 Aug 2023 22:10:45 +0000 (GMT)
Received: from li-8d37cfcc-31b9-11b2-a85c-83226d7135c9.austin.ibm.com (unknown [9.24.4.46])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Aug 2023 22:10:45 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: haren@linux.ibm.com, ricklind@us.ibm.com, danymadden@us.ibm.com,
        tlfalcon@linux.ibm.com, bjking1@linux.ibm.com,
        Nick Child <nnac123@linux.ibm.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net v2 5/5] ibmvnic: Ensure login failure recovery is safe from other resets
Date: Wed,  9 Aug 2023 17:10:38 -0500
Message-Id: <20230809221038.51296-5-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230809221038.51296-1-nnac123@linux.ibm.com>
References: <20230809221038.51296-1-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YtQjD-ueV62i2tP5_gip3os-IbBzDKOH
X-Proofpoint-ORIG-GUID: YtQjD-ueV62i2tP5_gip3os-IbBzDKOH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_19,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090190
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

If a login request fails, the recovery process should be protected
against parallel resets. It is a known issue that freeing and
registering CRQ's in quick succession can result in a failover CRQ from
the VIOS. Processing a failover during login recovery is dangerous for
two reasons:
 1. This will result in two parallel initialization processes, this can
 cause serious issues during login.
 2. It is possible that the failover CRQ is received but never executed.
 We get notified of a pending failover through a transport event CRQ.
 The reset is not performed until a INIT CRQ request is received.
 Previously, if CRQ init fails during login recovery, then the ibmvnic
 irq is freed and the login process returned error. If failover_pending
 is true (a transport event was received), then the ibmvnic device
 would never be able to process the reset since it cannot receive the
 CRQ_INIT request due to the irq being freed. This leaved the device
 in a inoperable state.

Therefore, the login failure recovery process must be hardened against
these possible issues. Possible failovers (due to quick CRQ free and
init) must be avoided and any issues during re-initialization should be
dealt with instead of being propagated up the stack. This logic is
similar to that of ibmvnic_probe().

Fixes: dff515a3e71d ("ibmvnic: Harden device login requests")
Signed-off-by: Nick Child <nnac123@linux.ibm.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 68 +++++++++++++++++++++---------
 1 file changed, 47 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index e9619957d58a..df76cdaddcfb 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -116,6 +116,7 @@ static void ibmvnic_tx_scrq_clean_buffer(struct ibmvnic_adapter *adapter,
 static void free_long_term_buff(struct ibmvnic_adapter *adapter,
 				struct ibmvnic_long_term_buff *ltb);
 static void ibmvnic_disable_irqs(struct ibmvnic_adapter *adapter);
+static void flush_reset_queue(struct ibmvnic_adapter *adapter);
 
 struct ibmvnic_stat {
 	char name[ETH_GSTRING_LEN];
@@ -1507,8 +1508,8 @@ static const char *adapter_state_to_string(enum vnic_state state)
 
 static int ibmvnic_login(struct net_device *netdev)
 {
+	unsigned long flags, timeout = msecs_to_jiffies(20000);
 	struct ibmvnic_adapter *adapter = netdev_priv(netdev);
-	unsigned long timeout = msecs_to_jiffies(20000);
 	int retry_count = 0;
 	int retries = 10;
 	bool retry;
@@ -1573,6 +1574,7 @@ static int ibmvnic_login(struct net_device *netdev)
 					    "SCRQ irq initialization failed\n");
 				return rc;
 			}
+		/* Default/timeout error handling, reset and start fresh */
 		} else if (adapter->init_done_rc) {
 			netdev_warn(netdev, "Adapter login failed, init_done_rc = %d\n",
 				    adapter->init_done_rc);
@@ -1588,29 +1590,53 @@ static int ibmvnic_login(struct net_device *netdev)
 				    "Freeing and re-registering CRQs before attempting to login again\n");
 			retry = true;
 			adapter->init_done_rc = 0;
-			retry_count++;
 			release_sub_crqs(adapter, true);
-			reinit_init_done(adapter);
-			release_crq_queue(adapter);
-			/* If we don't sleep here then we risk an unnecessary
-			 * failover event from the VIOS. This is a known VIOS
-			 * issue caused by a vnic device freeing and registering
-			 * a CRQ too quickly.
+			/* Much of this is similar logic as ibmvnic_probe(),
+			 * we are essentially re-initializing communication
+			 * with the server. We really should not run any
+			 * resets/failovers here because this is already a form
+			 * of reset and we do not want parallel resets occurring
 			 */
-			msleep(1500);
-			rc = init_crq_queue(adapter);
-			if (rc) {
-				netdev_err(netdev, "login recovery: init CRQ failed %d\n",
-					   rc);
-				return -EIO;
-			}
+			do {
+				reinit_init_done(adapter);
+				/* Clear any failovers we got in the previous
+				 * pass since we are re-initializing the CRQ
+				 */
+				adapter->failover_pending = false;
+				release_crq_queue(adapter);
+				/* If we don't sleep here then we risk an
+				 * unnecessary failover event from the VIOS.
+				 * This is a known VIOS issue caused by a vnic
+				 * device freeing and registering a CRQ too
+				 * quickly.
+				 */
+				msleep(1500);
+				/* Avoid any resets, since we are currently
+				 * resetting.
+				 */
+				spin_lock_irqsave(&adapter->rwi_lock, flags);
+				flush_reset_queue(adapter);
+				spin_unlock_irqrestore(&adapter->rwi_lock,
+						       flags);
+
+				rc = init_crq_queue(adapter);
+				if (rc) {
+					netdev_err(netdev, "login recovery: init CRQ failed %d\n",
+						   rc);
+					return -EIO;
+				}
 
-			rc = ibmvnic_reset_init(adapter, false);
-			if (rc) {
-				netdev_err(netdev, "login recovery: Reset init failed %d\n",
-					   rc);
-				return -EIO;
-			}
+				rc = ibmvnic_reset_init(adapter, false);
+				if (rc)
+					netdev_err(netdev, "login recovery: Reset init failed %d\n",
+						   rc);
+				/* IBMVNIC_CRQ_INIT will return EAGAIN if it
+				 * fails, since ibmvnic_reset_init will free
+				 * irq's in failure, we won't be able to receive
+				 * new CRQs so we need to keep trying. probe()
+				 * handles this similarly.
+				 */
+			} while (rc == -EAGAIN && retry_count++ < retries);
 		}
 	} while (retry);
 
-- 
2.39.3


