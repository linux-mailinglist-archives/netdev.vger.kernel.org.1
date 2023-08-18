Return-Path: <netdev+bounces-28849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBD4781016
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83CAA2823AE
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 16:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76861AA88;
	Fri, 18 Aug 2023 16:15:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB82F1AA84
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 16:15:08 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73617421B
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 09:15:04 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37IFwndq004749;
	Fri, 18 Aug 2023 16:15:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=wnV0VR+qP370a+4IX6B1urU0CUsGP1iluferStgUTPc=;
 b=PnwyagVwwugvA/p4XJ3CPSWJF4dZeKSX7lIDl0yz7JE/0eBwRm/urDIl3qMnjGaCi/pf
 2hp2qPiv6+onw1z7iqTED5DRzAInCbR957VZfUyLnsJnLsQqIR/CssU+FUcw3v0HzHQD
 QHz5KfSEVKA016Y60RMMIGvZDpD4qb9iobsLhWcXD96qu86ktXuuJXHQxC1Fxj+ozLok
 hekLle3fKkRmS4sHCoWedf7Vt8bvGlItbBnWulHzX+7s5ZHN3fqSENOJUhgS38BaZCT8
 T6YyXnPkRsQycU3pziYM+VAg1R6ibpTw+ABM10pPkqrQJxIbMYA0Ry7L/0Sn4JR5a5+K tQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sjbrr8h0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Aug 2023 16:15:00 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37IG07sx010232;
	Fri, 18 Aug 2023 16:14:59 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sjbrr8h07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Aug 2023 16:14:59 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37IF1Jci018885;
	Fri, 18 Aug 2023 16:14:58 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3seq427qpv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Aug 2023 16:14:58 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37IGEvbs459376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Aug 2023 16:14:58 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D45BF58055;
	Fri, 18 Aug 2023 16:14:57 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94C4F58043;
	Fri, 18 Aug 2023 16:14:57 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.53.174.71])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Aug 2023 16:14:57 +0000 (GMT)
From: Thinh Tran <thinhtr@linux.vnet.ibm.com>
To: kuba@kernel.org
Cc: aelior@marvell.com, davem@davemloft.net, edumazet@google.com,
        manishc@marvell.com, netdev@vger.kernel.org, pabeni@redhat.com,
        skalluru@marvell.com, VENKATA.SAI.DUGGI@ibm.com,
        Thinh Tran <thinhtr@linux.vnet.ibm.com>
Subject: [Patch v6 4/4] bnx2x: prevent excessive debug information during a TX timeout
Date: Fri, 18 Aug 2023 11:14:43 -0500
Message-Id: <20230818161443.708785-5-thinhtr@linux.vnet.ibm.com>
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
X-Proofpoint-GUID: JVx_3w1NDMfp1BEUK6NUIMC0h2JJYGm7
X-Proofpoint-ORIG-GUID: 9hvh1U0gb36aFVZqg20d-BrV11yXJFf5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_20,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=992
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308180147
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Reduce debug output when a TX timeout occurs to avoid overflowing the
system log buffer.

Signed-off-by: Thinh Tran <thinhtr@linux.vnet.ibm.com>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c  | 6 ++++++
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
index e34aff5fb782..73546497d978 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -4983,6 +4983,12 @@ void bnx2x_tx_timeout(struct net_device *dev, unsigned int txqueue)
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
index 13d2a7761c24..236cd40d7381 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -10266,12 +10266,6 @@ static void bnx2x_sp_rtnl_task(struct work_struct *work)
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


