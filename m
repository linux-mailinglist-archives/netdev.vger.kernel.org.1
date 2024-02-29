Return-Path: <netdev+bounces-76312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B1D86D368
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 20:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72A6FB2417D
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 19:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C790142904;
	Thu, 29 Feb 2024 19:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iXbTWnOK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB2B13C9C6
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 19:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709235625; cv=fail; b=hW1p9yn6oSiRM84kf7FlyACIH1q8dkS9B0D6ENQygZtATph5N7rPdxExhNk6+A0z2BCIG8Da0oGWr4d/5GV0jGyhAK2ANc8lukLLa/RLA9r3hkEwZUyGiziOmMG0ohhxNryCmK9MVOuynQSWDDNEKWghEg1gD/ySEBTW+TSshjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709235625; c=relaxed/simple;
	bh=Z4lwIRBZWb4y4tONc+0P30tthWB6ZCK1BNzVds/CxFE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SNz1LpCgnBfcnarTaybMnlPMFVmFq7g7xgDdmTZXWPFYvwCm9tXtsnmc32TNq9mpWtBIaCa/Je4nrcLaDaL3oS9VupTeTFW9ofMTtC1uJMrsoU+RmkOcNmg7cMOiz0QXwXAfH41hD0hJFM1aTEkhuTC+JiIoPgIxU/cPMmZ/QZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iXbTWnOK; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhFH3ngDvv94/TYsOCrSBgsBxibShtwRRMUlnpRc1YTvd70yWBgXytbLxw+olqoOsgRr5VubboH7dboLGhHkLp+J1GhNYbkWS/Yhs/XVEnezqE2B5PYjp5Csluq4XNokNHINV6lFCEZ1GIianmq6jWaXoo9UpwDPXN+dRHyCQoVUZOUpngna032k3kwxeq8RinvGR4Elkeki4Pu3MBOakuglE1HllaJP4JEzSU1cXgFn4YeJxpyCT3OLRkWfk58UIRUf77IMBmG8qgTNMFG6aU3zPU/tdzT8um+qJOXULZvZx8Vrb5mk4PQ6IbSY6tRqroa6GcObCGop+Ucw0bxRbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vo3guc+BN1bCWyQYJHMUSbtd+rQuASlv8sE7oVL4Lt8=;
 b=b1+2QxWP1iQBQdjihBZ5QWbJRoVwTK73WokPoSF0JFH0eQxYJrsNtzHV4Z+3jSCksRw/CH9zP6fx/JVgpzrqpi0C64IUSDH7AYO3gGEY0bYmaMa6Rnf6+KNcLANAATCvGLUmt75/UI6yi0KNSsWnqudRNoK7AxfqGYqhJ+ot4t+NwI+pCLSsOQ1tBSoCUkged3ca7zKm5NsqXsiJ7fGhSv1CNkYGzUunjhz6Fgc2H4AVt9uduBegKUYrCIIsHNgpKEBdfgJdXQjGi3j1R4OML22DTHLyE3M8EUqJ7wJE12XhKh23gflngGb0/DmBpsVmHZNIB3sSkMArDoOnpN4Iqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vo3guc+BN1bCWyQYJHMUSbtd+rQuASlv8sE7oVL4Lt8=;
 b=iXbTWnOKGA926BFi1YagwYkRpoUAPgiPZGxX+gKXiu3SryPaZJA5ZjhbaItXciI0QYw+j9hM0liL/aVCf0CM8s1g2tr5adKTMVO4D182cfcNsmlU5dVl+iGJgFwy5ENmGgBU3ZDl5bRxXrAE9LliL4rglxq7a9hJFr4MgkT3H7A=
Received: from BLAPR03CA0164.namprd03.prod.outlook.com (2603:10b6:208:32f::20)
 by PH7PR12MB6418.namprd12.prod.outlook.com (2603:10b6:510:1fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.37; Thu, 29 Feb
 2024 19:40:20 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::26) by BLAPR03CA0164.outlook.office365.com
 (2603:10b6:208:32f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32 via Frontend
 Transport; Thu, 29 Feb 2024 19:40:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 29 Feb 2024 19:40:19 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 29 Feb
 2024 13:40:16 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 11/12] ionic: Clean RCT ordering issues
Date: Thu, 29 Feb 2024 11:39:34 -0800
Message-ID: <20240229193935.14197-12-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240229193935.14197-1-shannon.nelson@amd.com>
References: <20240229193935.14197-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|PH7PR12MB6418:EE_
X-MS-Office365-Filtering-Correlation-Id: 1845e31f-a05d-49c7-765f-08dc395e435e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DJuS9xewlve2/14NRGWfgFoVs6dXdoZzviTuWACDtw5tf0GOjNAGefVIegdqQYPty1J/1bM6JjbCGKIxYQ6Yy0RbnWPNragQbjkMY0CN+JpFnqbWplKIakrbdQ0d7bsL46rJ0/QdxWUuQLO32OQslxbgq/jNl8Iudaw06nVomCQU7yeXmI4I62faTMV89U+ZqpdB6Jcic8AGnaBIzsVdQdygux4JvHDy3iaIH0IFgYbZNRkQXIGJoV4bJXj69ND44sPVWgI/k0GzUHV+PIoFCUZKd9oYNcIR8XjHl1ao+JSw60SnxRmpVjGEEfA0odH7bOEHMR0bKTiOkM8adWKVcztjCt1hXM42IXxB5YHtbFGmKDAw6sT4t9UxbrhHL12qaF0tPJyoXyR90dEtt9zWbUhdxLI1cqWiH7vjb6/nYeCXpfLTSf7LWYN0SgCkXtOSUHfOT3aLfmGjJ1d42ohYOyggnUX/7rOjkGVDoq9GSzWtYXrIcYQhi9g5MUKGn3VwTNz4E5PhW0J9xSlK5U3Z3a6OrB3JlvZN6piRLGqvN/VeC1WQowQOiSangIullLt+LMH9bs0qRPWIB4vEeTcRz8qjbzDLc4vgxINr7nRSUWXccHcYpoo6SK9fA81RFNt63TfNAOv+CBdcNi1XVJShdzDncc+B6Fmbv+AvZIp30m3BLK/XJ+WOfv6Chp+D5gr12rFMXxJch7U4jmmgcunL6W+/V1JLvgvXYbQ2vV8l7c7WmHTnjAgWRmmJgz/uQ+9Y
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 19:40:19.9272
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1845e31f-a05d-49c7-765f-08dc395e435e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6418

From: Brett Creeley <brett.creeley@amd.com>

Clean up complaints from an xmastree.py scan.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_debugfs.c | 2 +-
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c    | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_debugfs.c b/drivers/net/ethernet/pensando/ionic/ionic_debugfs.c
index 91327ef670c7..c3ae11a48024 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_debugfs.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_debugfs.c
@@ -113,8 +113,8 @@ static const struct debugfs_reg32 intr_ctrl_regs[] = {
 void ionic_debugfs_add_qcq(struct ionic_lif *lif, struct ionic_qcq *qcq)
 {
 	struct dentry *qcq_dentry, *q_dentry, *cq_dentry;
-	struct dentry *intr_dentry, *stats_dentry;
 	struct ionic_dev *idev = &lif->ionic->idev;
+	struct dentry *intr_dentry, *stats_dentry;
 	struct debugfs_regset32 *intr_ctrl_regset;
 	struct ionic_intr_info *intr = &qcq->intr;
 	struct debugfs_blob_wrapper *desc_blob;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 89a40657c689..6d168ad8c84f 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -40,8 +40,8 @@ static inline void ionic_rxq_post(struct ionic_queue *q, bool ring_dbell,
 
 bool ionic_txq_poke_doorbell(struct ionic_queue *q)
 {
-	unsigned long now, then, dif;
 	struct netdev_queue *netdev_txq;
+	unsigned long now, then, dif;
 	struct net_device *netdev;
 
 	netdev = q->lif->netdev;
@@ -1776,7 +1776,7 @@ static netdev_tx_t ionic_start_hwstamp_xmit(struct sk_buff *skb,
 					    struct net_device *netdev)
 {
 	struct ionic_lif *lif = netdev_priv(netdev);
-	struct ionic_queue *q = &lif->hwstamp_txq->q;
+	struct ionic_queue *q;
 	int err, ndescs;
 
 	/* Does not stop/start txq, because we post to a separate tx queue
@@ -1784,6 +1784,7 @@ static netdev_tx_t ionic_start_hwstamp_xmit(struct sk_buff *skb,
 	 * the timestamping queue, it is dropped.
 	 */
 
+	q = &lif->hwstamp_txq->q;
 	ndescs = ionic_tx_descs_needed(q, skb);
 	if (unlikely(ndescs < 0))
 		goto err_out_drop;
-- 
2.17.1


