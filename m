Return-Path: <netdev+bounces-126120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D19396FE79
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 01:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15584289B5E
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 23:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE9A15ECD7;
	Fri,  6 Sep 2024 23:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vZLda7GX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FC115B15D
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 23:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725665207; cv=fail; b=LYXT8iILskFWGW/uDHsrJcsm2Y+/3vmjcHbKmDdgblDxwM3ip1jeOP3cDx+vT+SUUXHTE2DtGjiC54mS9rRzaq6GFKZY0XdM7a1Sm4fm5Wb4s21Z/uS2dJGzit0G2LvmuASCc6nimDyBJYS2foMsR5npitAMBdxJ8H/guGnxnio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725665207; c=relaxed/simple;
	bh=EifgC7wuYchGB6lRz7K10XrJxp7sDpBs/4LBBIt4tcI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aSGe1UMV1FZe9xanUFhhN7o6+lxFTJdDPBwa5RdwMZeQkRXSDbGqNkCNhfdHyA2CXAm32iB9HTV8VOJick9CanCidM3w1NRjPRJ7UoIRMolQYfCP/G5cxkd78VM/xJzgQ5oWo0oN4MM0xRtUWmw4JNo/nW9ZZAisYcTA5MRnlbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vZLda7GX; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Npvdw0S/QOv0HSK0H+TVE7V+CvsKaK3Mb+aPmaE5sKhnpivvBjYSzU9uYqZjh26oDyhzNRXEgnzyCkQzUpoeL/gTdnikLcC84vpXYOpz+05ijcBFdZsr4LXlbBBZ510eMpll7DvAp2skzq8Sc49pLTgglzvI+yExEw5q6c3q+n5Tw0JS4dLe4fLJ/VwGm9QxY3XxZM/fvLjpQvqrLad81QUrsw7vzmpp7alIeObpeFOsdzhripxafTJITdhkhc2T02JgK6cixM1wM7f4qNXNuza+S/3k0FAyndAa5tw8qMtIj1KjLILBogTaK1lKwOmpp18eqiZDCo1Nl0y+jvUx6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfUDM545Wj3CTKEshVQwJJzWX1t+D2LNqFTybP5ZFKY=;
 b=PYgqQSixM/yaDCX5PvsuYI5Madf4J1uheVnZ/EInvmPIWHXmCdDH7vLw62yvN25uq+8v2Uj3FR9K8YLFly/MlWK+GvYrPklZeyiTO/URqjkMuJSHd47SDunHaKmcTi32MsJQl8OjAjefBt/LYKHoCItvkzQ2gdALsQyzBGo1UiXdZcuRPHiN9K5cS35l8YBOXc28HTBcV1yvRYu1LCU5Esd9R3Dcgsjrp/JKZ16/tsoJXWGuB7UysdtVA8qogYCi9WXFcxeh064Ue7sUSnUTLgFpKnS0MpkN7ptOYavpKLCtJ/zbTUK4ihr0wh/VugrbZmmL3+Py9+W9yk/L4oY43A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfUDM545Wj3CTKEshVQwJJzWX1t+D2LNqFTybP5ZFKY=;
 b=vZLda7GX/6RtzO+oGZNdF9LuavxaAPrpmgUugYLwhpqPUfr4atmOpIdSOvoH3hQ8GigsNzR4GHSXIL4DgvMNP6YduWFF8AnKH1X/zM0rHEymsJnza+mjhAbXPyevUaMBwbTl6NuIW0QgahqEdlDwBU7DjCDkq7Vvl3vCpTY8tzE=
Received: from PH7PR17CA0066.namprd17.prod.outlook.com (2603:10b6:510:325::15)
 by CH3PR12MB8482.namprd12.prod.outlook.com (2603:10b6:610:15b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Fri, 6 Sep
 2024 23:26:40 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:510:325:cafe::11) by PH7PR17CA0066.outlook.office365.com
 (2603:10b6:510:325::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17 via Frontend
 Transport; Fri, 6 Sep 2024 23:26:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 23:26:40 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 18:26:38 -0500
From: Brett Creeley <brett.creeley@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH v3 net-next 7/7] ionic: Allow XDP program to be hot swapped
Date: Fri, 6 Sep 2024 16:26:23 -0700
Message-ID: <20240906232623.39651-8-brett.creeley@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240906232623.39651-1-brett.creeley@amd.com>
References: <20240906232623.39651-1-brett.creeley@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|CH3PR12MB8482:EE_
X-MS-Office365-Filtering-Correlation-Id: ea3a777c-383f-4448-e409-08dccecb5c60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BgrhnrBvproo3Sr69I9W6+38KchSVKYsRPne98gSt0k8c0Sk6rjfEpvo2OTl?=
 =?us-ascii?Q?XQBEUdPExfofPCGdjzdnGQGAa2R9nBgegrW7dA6DVea5OHLNT5ORtCMgIwBp?=
 =?us-ascii?Q?ooraNR8X6uULQmzIixvUtZNLL7uEQ+Cx8vwLmf8ZjGpwY4uqd49QBPQDUt99?=
 =?us-ascii?Q?a9ShDOkn6e4+5V5r015UWFIbt4dZWkZ/YknerzBC26w+9gNPeiSxN1bmvZMZ?=
 =?us-ascii?Q?dDpGxtXhf90Xe/aWvskla3COe2FhJm+nQE/kPy3Dpq/+TNWmV0pOyYMGJZSO?=
 =?us-ascii?Q?dW50EY7wPhXxHBwx1sgRNC8Lq6IiMjBQngCjtUThcieMBHfTgA5m2hiBPhoA?=
 =?us-ascii?Q?AgWGtz5f9jBgK7UnnVziY6J71uC8SkOWFAVd9dm3WKRtXl+kcq5yC3UHieCG?=
 =?us-ascii?Q?WbGzx8AV36ev3sDT5ZZ0zimAJsvRRXUzvxIPu0z3FqoXjqfEZtNvoh/FiQJ0?=
 =?us-ascii?Q?IrVL4RLahD94lLjtjDXNoY1LJfSYh2l7jl5Wqt0JcGDr6zwed11eQw8tXXrp?=
 =?us-ascii?Q?NLkDbT+HEMbuJoSmDCqN/LnyGtuwQ4ie9KuWU7Xf8hrUBxRYjMrooV5LDw/6?=
 =?us-ascii?Q?NlBkfsSQWJi96ktpW62m7nX6DsEQWD4UHg8utkqkUD4HS1VAiH8CU4xinxs0?=
 =?us-ascii?Q?fUseMq+/zZv1OetVN4YZtFg6bbaG9dYleklCYPIH4paxErThb5HJJYSzho0B?=
 =?us-ascii?Q?eKr3Dapt5J6pMxOeN7m3CyEWd2wKVFK7gFw4uicV+q0qLsZDuvlaa/0P0cRk?=
 =?us-ascii?Q?gpPt6DjWyIfLtAER7djtMfOUA6sFn3pVhG4Zc72oHPYL3AhVP8Kl0ykEZp/w?=
 =?us-ascii?Q?7NmhgU3M47kDyK3+iSRBFjh5m4/LMuZCq21WzNYEXW87iR9NxTCBwLrIBFir?=
 =?us-ascii?Q?VopG0umhEd0M4hY7fdQ373Fxw+3pSxHjoyk5YN4LR4KHbf5jfq0+n1t7Av6l?=
 =?us-ascii?Q?PyE+Rmd2Erj4SVXzr8cDxfGGXfPuJjAgxI9X7XZoMEdm1nec1kJUu3yvv4k3?=
 =?us-ascii?Q?atAiOiK7GC8zUOZPGbEWnt42Sax7yBa2TOpjx0Nmj2NIIB3WEFnREZGTBDUq?=
 =?us-ascii?Q?6ssFha+6UDxw8SPo3j0XeOmGAZm3xHNhwzx1/Z0YDCITNfoK6qrOiXIysC3A?=
 =?us-ascii?Q?gORGg8JksjyC3Ao8ug4bomU86X49SAfJQzUNgKHFxAVyK/KFcrXQYhL+12Vz?=
 =?us-ascii?Q?b9FRQ2ooZGdMKcuzcJw5XCeCsaogyy8GbWnzwKX7sVeIkiWu+Q/LHw4pMMnp?=
 =?us-ascii?Q?4b3eN96fwSnXuNW4YbPpIbTXWJ+G27ouiJqHqE3k4HppcQdgFxlI/NTZJJ8K?=
 =?us-ascii?Q?S4+Vth/FZDrWeNphpqsajNi7aLUjSHheEEkYC77CUFUoJuB5jfyNAq5X/OHK?=
 =?us-ascii?Q?UNt7e+j6wLZgEFeZiPOBmheBYqnaA+AKJO2p2AnXhEip24v5M0FB52VkXMk1?=
 =?us-ascii?Q?BOvuVjkcyxvr6kPIx/BItJGLviAlqnY/?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 23:26:40.2523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3a777c-383f-4448-e409-08dccecb5c60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8482

Using examples of other driver(s), add the ability to hot-swap an XDP
program without having to reconfigure the queues. To prevent the
q->xdp_prog to be read/written more than once use READ_ONCE() and
WRITE_ONCE() on the q->xdp_prog.

The q->xdp_prog was being checked in multiple different for loops in the
hot path. The change to allow xdp_prog hot swapping created the
possibility for many READ_ONCE(q->xdp_prog) calls during a single napi
callback. Refactor the Rx napi handling to allow a previous
READ_ONCE(q->xdp_prog) (or NULL for hwstamp_rxq) to be passed into the
relevant functions.

Also, move other Rx related hotpath handling into the newly created
ionic_rx_cq_service() function to reduce the scope of the xdp_prog
local variable and put all Rx handling in one function similar to Tx.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_lif.c   | 12 ++--
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 58 +++++++++++++------
 .../net/ethernet/pensando/ionic/ionic_txrx.h  |  4 +-
 3 files changed, 52 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 59d3eea2c0bc..a3965532464f 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -1074,7 +1074,7 @@ int ionic_lif_create_hwstamp_rxq(struct ionic_lif *lif)
 			goto err_qcq_init;
 
 		if (test_bit(IONIC_LIF_F_UP, lif->state)) {
-			ionic_rx_fill(&rxq->q);
+			ionic_rx_fill(&rxq->q, NULL);
 			err = ionic_qcq_enable(rxq);
 			if (err)
 				goto err_qcq_enable;
@@ -2190,7 +2190,8 @@ static int ionic_txrx_enable(struct ionic_lif *lif)
 			goto err_out;
 		}
 
-		ionic_rx_fill(&lif->rxqcqs[i]->q);
+		ionic_rx_fill(&lif->rxqcqs[i]->q,
+			      READ_ONCE(lif->rxqcqs[i]->q.xdp_prog));
 		err = ionic_qcq_enable(lif->rxqcqs[i]);
 		if (err)
 			goto err_out;
@@ -2203,7 +2204,7 @@ static int ionic_txrx_enable(struct ionic_lif *lif)
 	}
 
 	if (lif->hwstamp_rxq) {
-		ionic_rx_fill(&lif->hwstamp_rxq->q);
+		ionic_rx_fill(&lif->hwstamp_rxq->q, NULL);
 		err = ionic_qcq_enable(lif->hwstamp_rxq);
 		if (err)
 			goto err_out_hwstamp_rx;
@@ -2746,7 +2747,7 @@ static void ionic_xdp_rxqs_prog_update(struct ionic_lif *lif)
 	for (i = 0; i < lif->ionic->nrxqs_per_lif && lif->rxqcqs[i]; i++) {
 		struct ionic_queue *q = &lif->rxqcqs[i]->q;
 
-		q->xdp_prog = xdp_prog;
+		WRITE_ONCE(q->xdp_prog, xdp_prog);
 	}
 }
 
@@ -2777,6 +2778,9 @@ static int ionic_xdp_config(struct net_device *netdev, struct netdev_bpf *bpf)
 
 	if (!netif_running(netdev)) {
 		old_prog = xchg(&lif->xdp_prog, bpf->prog);
+	} else if (lif->xdp_prog && bpf->prog) {
+		old_prog = xchg(&lif->xdp_prog, bpf->prog);
+		ionic_xdp_rxqs_prog_update(lif);
 	} else {
 		struct ionic_queue_params qparams;
 
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 35e3751dd5a7..0eeda7e502db 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -602,7 +602,8 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 
 static void ionic_rx_clean(struct ionic_queue *q,
 			   struct ionic_rx_desc_info *desc_info,
-			   struct ionic_rxq_comp *comp)
+			   struct ionic_rxq_comp *comp,
+			   struct bpf_prog *xdp_prog)
 {
 	struct net_device *netdev = q->lif->netdev;
 	struct ionic_qcq *qcq = q_to_qcq(q);
@@ -631,8 +632,8 @@ static void ionic_rx_clean(struct ionic_queue *q,
 	stats->pkts++;
 	stats->bytes += len;
 
-	if (q->xdp_prog) {
-		if (ionic_run_xdp(stats, netdev, q->xdp_prog, q, desc_info->bufs, len))
+	if (xdp_prog) {
+		if (ionic_run_xdp(stats, netdev, xdp_prog, q, desc_info->bufs, len))
 			return;
 		synced = true;
 		headroom = XDP_PACKET_HEADROOM;
@@ -718,7 +719,7 @@ static void ionic_rx_clean(struct ionic_queue *q,
 		napi_gro_frags(&qcq->napi);
 }
 
-bool ionic_rx_service(struct ionic_cq *cq)
+static bool __ionic_rx_service(struct ionic_cq *cq, struct bpf_prog *xdp_prog)
 {
 	struct ionic_rx_desc_info *desc_info;
 	struct ionic_queue *q = cq->bound_q;
@@ -740,11 +741,16 @@ bool ionic_rx_service(struct ionic_cq *cq)
 	q->tail_idx = (q->tail_idx + 1) & (q->num_descs - 1);
 
 	/* clean the related q entry, only one per qc completion */
-	ionic_rx_clean(q, desc_info, comp);
+	ionic_rx_clean(q, desc_info, comp, xdp_prog);
 
 	return true;
 }
 
+bool ionic_rx_service(struct ionic_cq *cq)
+{
+	return __ionic_rx_service(cq, NULL);
+}
+
 static inline void ionic_write_cmb_desc(struct ionic_queue *q,
 					void *desc)
 {
@@ -755,7 +761,7 @@ static inline void ionic_write_cmb_desc(struct ionic_queue *q,
 		memcpy_toio(&q->cmb_txq[q->head_idx], desc, sizeof(q->cmb_txq[0]));
 }
 
-void ionic_rx_fill(struct ionic_queue *q)
+void ionic_rx_fill(struct ionic_queue *q, struct bpf_prog *xdp_prog)
 {
 	struct net_device *netdev = q->lif->netdev;
 	struct ionic_rx_desc_info *desc_info;
@@ -783,7 +789,7 @@ void ionic_rx_fill(struct ionic_queue *q)
 
 	len = netdev->mtu + VLAN_ETH_HLEN;
 
-	if (q->xdp_prog) {
+	if (xdp_prog) {
 		/* Always alloc the full size buffer, but only need
 		 * the actual frag_len in the descriptor
 		 * XDP uses space in the first buffer, so account for
@@ -964,6 +970,32 @@ static void ionic_xdp_do_flush(struct ionic_cq *cq)
 	}
 }
 
+static unsigned int ionic_rx_cq_service(struct ionic_cq *cq,
+					unsigned int work_to_do)
+{
+	struct ionic_queue *q = cq->bound_q;
+	unsigned int work_done = 0;
+	struct bpf_prog *xdp_prog;
+
+	if (work_to_do == 0)
+		return 0;
+
+	xdp_prog = READ_ONCE(q->xdp_prog);
+	while (__ionic_rx_service(cq, xdp_prog)) {
+		if (cq->tail_idx == cq->num_descs - 1)
+			cq->done_color = !cq->done_color;
+
+		cq->tail_idx = (cq->tail_idx + 1) & (cq->num_descs - 1);
+
+		if (++work_done >= work_to_do)
+			break;
+	}
+	ionic_rx_fill(q, xdp_prog);
+	ionic_xdp_do_flush(cq);
+
+	return work_done;
+}
+
 int ionic_rx_napi(struct napi_struct *napi, int budget)
 {
 	struct ionic_qcq *qcq = napi_to_qcq(napi);
@@ -974,12 +1006,8 @@ int ionic_rx_napi(struct napi_struct *napi, int budget)
 	if (unlikely(!budget))
 		return budget;
 
-	work_done = ionic_cq_service(cq, budget,
-				     ionic_rx_service, NULL, NULL);
+	work_done = ionic_rx_cq_service(cq, budget);
 
-	ionic_rx_fill(cq->bound_q);
-
-	ionic_xdp_do_flush(cq);
 	if (work_done < budget && napi_complete_done(napi, work_done)) {
 		ionic_dim_update(qcq, IONIC_LIF_F_RX_DIM_INTR);
 		flags |= IONIC_INTR_CRED_UNMASK;
@@ -1020,12 +1048,8 @@ int ionic_txrx_napi(struct napi_struct *napi, int budget)
 	if (unlikely(!budget))
 		return budget;
 
-	rx_work_done = ionic_cq_service(rxcq, budget,
-					ionic_rx_service, NULL, NULL);
-
-	ionic_rx_fill(rxcq->bound_q);
+	rx_work_done = ionic_rx_cq_service(rxcq, budget);
 
-	ionic_xdp_do_flush(rxcq);
 	if (rx_work_done < budget && napi_complete_done(napi, rx_work_done)) {
 		ionic_dim_update(rxqcq, 0);
 		flags |= IONIC_INTR_CRED_UNMASK;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.h b/drivers/net/ethernet/pensando/ionic/ionic_txrx.h
index 9e73e324e7a1..b2b9a2dc9eb8 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.h
@@ -4,9 +4,11 @@
 #ifndef _IONIC_TXRX_H_
 #define _IONIC_TXRX_H_
 
+struct bpf_prog;
+
 void ionic_tx_flush(struct ionic_cq *cq);
 
-void ionic_rx_fill(struct ionic_queue *q);
+void ionic_rx_fill(struct ionic_queue *q, struct bpf_prog *xdp_prog);
 void ionic_rx_empty(struct ionic_queue *q);
 void ionic_tx_empty(struct ionic_queue *q);
 int ionic_rx_napi(struct napi_struct *napi, int budget);
-- 
2.17.1


