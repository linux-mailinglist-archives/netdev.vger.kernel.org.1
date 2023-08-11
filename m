Return-Path: <netdev+bounces-26939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B20A0779868
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 22:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E25E81C2179B
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 20:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E2F2AB58;
	Fri, 11 Aug 2023 20:16:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693A08468
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 20:16:04 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2C23596
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 13:16:01 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BJrV53030928;
	Fri, 11 Aug 2023 20:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=dM7LjCgUI9C+X8fVNPvJuXklr68b8usCTEkOOGYV0zw=;
 b=HDi+tA1Eq2fSc9LcnVjH9EHtYQ+GCneCznho6qVGbPepbe9NdveguaQWKfbWsZQH4DHI
 VvL1K9TYsff/o1uxLgX4MZREAsSB5GysZaTBD/TLqgwgnsUgsxd22pPbsR61J3/++UgV
 TwuYd9XjYSZvo8+9i0xM+rBAUlH/r6Ux2Gd1GAq5qmqDEa7QK8gTEAG9UTxmuDga5iOq
 c1kaGfznbY5I40z4csarDU8S2yQPku0A3148ziL/pZnNBK1XTppgQ/E9fhIRBjKLJub+
 4ytqP3f/sblBhe/dqseNc854Ko6H+yHitSLHb4SfWXrMxM0PZc2UIbXODaGeXbYHBdFw Fg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sduhtrht6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Aug 2023 20:15:55 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37BK8EeK015433;
	Fri, 11 Aug 2023 20:15:55 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sduhtrhs1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Aug 2023 20:15:55 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37BKC7dd015366;
	Fri, 11 Aug 2023 20:15:53 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sb3f3qeva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Aug 2023 20:15:53 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37BKFrQ77995932
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Aug 2023 20:15:53 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 177BF58056;
	Fri, 11 Aug 2023 20:15:53 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD9F258052;
	Fri, 11 Aug 2023 20:15:52 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.53.174.71])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Aug 2023 20:15:52 +0000 (GMT)
From: Thinh Tran <thinhtr@linux.vnet.ibm.com>
To: kuba@kernel.org
Cc: aelior@marvell.com, davem@davemloft.net, edumazet@google.com,
        manishc@marvell.com, netdev@vger.kernel.org, pabeni@redhat.com,
        skalluru@marvell.com, VENKATA.SAI.DUGGI@ibm.com,
        Thinh Tran <thinhtr@linux.vnet.ibm.com>
Subject: [Patch v5 4/4] bnx2x: prevent excessive debug information during a TX timeout
Date: Fri, 11 Aug 2023 15:15:12 -0500
Message-Id: <20230811201512.461657-5-thinhtr@linux.vnet.ibm.com>
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
X-Proofpoint-GUID: 5_GF-QzI50eAhde8mDuXmSDJ0X-puRDE
X-Proofpoint-ORIG-GUID: 2At8SkSc0A9KPTXbHhbVlBO2bt6uN6ah
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

Signed-off-by: Thinh Tran <thinhtr@linux.vnet.ibm.com>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c  | 6 ++++++
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
index 5296f5b8426b..814350d10b7a 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -4971,6 +4971,12 @@ void bnx2x_tx_timeout(struct net_device *dev, unsigned int txqueue)
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
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 7add3a420534..5c1bde0f15f3 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -10267,12 +10267,6 @@ static void bnx2x_sp_rtnl_task(struct work_struct *work)
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
-- 
2.27.0


