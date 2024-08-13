Return-Path: <netdev+bounces-118248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A91FD9510BA
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 01:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B35D282190
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 23:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140631AD3FC;
	Tue, 13 Aug 2024 23:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J0WjCtr6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706431AD3E2
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 23:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723592504; cv=fail; b=EBdWkic28ZviiK/PV2zji+HQjfA6DsbJCyzj7il2H7EM7VUEd38XHUh6OM5cTCpP6wFv7PtyKP4j80YRSBUjixNw4NAjxJlWT11oCH8YJ0qscGq+U5DQqUc/17PkItTmlrfb17Og1vQARq+RcT/QOQTwXA/zUeRkCyznYSJSa3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723592504; c=relaxed/simple;
	bh=riPeBLIMq4hqmpfsHTf9nUR++PssTpcQFCEzXT9054Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H/TcvbVm74T2ishDGWGvpMjPHVxORYHGateIAdZYFwWmWqIvDqDDhzrs+PjfOQ0wa5MJmYHs2s2MxDsUhS8BKxziyATFy1D2XOfKCceMXp5CTq6RNxehfJf5KH7R9zK76MCwpl8nKnJJVcliRrFB1WVq2l5G8GlV9B381LUpYOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J0WjCtr6; arc=fail smtp.client-ip=40.107.237.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JY+nqw2r4JhE+9W5SlGhF8+Hh4MXiHLZ+YG8dVQSUh3J+knPfm9+85F6FDx3DmNG6Z3EDE3L1EoqgvyJbF7s//MDwPPZtd2pYzW+1Vf9gdJEAI+9M77oMcZGFK72Et5/20vbM7L4vIoGX9w5Mm1yd1xqkd2KGgauxfeUKf7hkJTSv/g2QX42A2pzE9YC4TARfbu7odZDi6mTq27GQ9Kb3zc/RL0QNhxYFJqK1lkl4fluqReVZzFpZz3BZCLh34NL76Qv6fDCbtpvAmtXDa4vaI+BJqH+c0QMqhD0GH4ZCcgwnX11nStKei9yl4mQ31xsIrc/Te7dkVLdeso1v8FILA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBLpOT/zohZEWSbhCGpdVN/DfxBNaZkXvTpHi1QJVdk=;
 b=N/mENAr1DorWmhiTDuHCac9/KpG1gPUjylu6WzPywGiimdumVR4PwkdTIBu4mMFqKCz2oa14MmOizX1aoini4bj9WoMd4/6P4/tW7ahep7mutkiydHQCCDFwXRBCSEwcO5ywKd1oKKAe9x76DV+1dFHkZmJxXjTFKnZGxi153MqSrATKm+9/2079SUt3bW2fi72MmJOzQyJHBi4y9zEvcH5ucnTp+ScHK9G/L04IbY4OnkdEpl7Bj/nwXkDD0lgUt+NFahZKcd6KJxc1B71+r/juuH9Enf0tzJw7lSH0vWWx8guMh88TLAJ9Xs5GAvLBWa077zv8/UMQBMt60ulYVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBLpOT/zohZEWSbhCGpdVN/DfxBNaZkXvTpHi1QJVdk=;
 b=J0WjCtr66Tc4qdFWeHjgUGWQaKYh4KMVviFocwUkA8FOaXD6z9ONw3GInL0sAKy4pbmTwff4qYzF7AhUJKdYpjUmJmzP1ddS5fo0R2DmgleJK6JErO/YFBqPdDIXSVPXm76LRu42z0a0Vgn7mpiCE/ujxczOUsl/Y6q4ZBgFeGU=
Received: from MW4P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::18)
 by SA1PR12MB7221.namprd12.prod.outlook.com (2603:10b6:806:2bd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 23:41:39 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:303:115:cafe::16) by MW4P220CA0013.outlook.office365.com
 (2603:10b6:303:115::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22 via Frontend
 Transport; Tue, 13 Aug 2024 23:41:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 13 Aug 2024 23:41:38 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 Aug
 2024 18:41:36 -0500
From: Brett Creeley <brett.creeley@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH net 2/2] ionic: Prevent tx_timeout due to frequent doorbell ringing
Date: Tue, 13 Aug 2024 16:41:22 -0700
Message-ID: <20240813234122.53083-3-brett.creeley@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240813234122.53083-1-brett.creeley@amd.com>
References: <20240813234122.53083-1-brett.creeley@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|SA1PR12MB7221:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df1a208-b039-46a4-003f-08dcbbf17a30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vjntq5UoGHp9VhfJPLdf+zwZ9HbflLhq0sbrwqSdzEoJvvAlj5eGrEohax2G?=
 =?us-ascii?Q?ELGiRGamK6bX8BN0+knfUBklXVPcLr6G2C6PXhXBe3qwX9hB88+So7p6jZdu?=
 =?us-ascii?Q?xPc5y+9AyfzqeAbBSipnjNVuQDSlRPOcM5NqwBWNOdlURXbjX3YrPPTXev28?=
 =?us-ascii?Q?1NaTJyt24MibzYkCGTSYtD8w++n66jIQKX2GZFBFiLp4OB9PalY4PwDzzOFQ?=
 =?us-ascii?Q?A4rITWij78Dr1HsE+Jza35nGum/lxW3tYQatGwhJ4gC4PgVkqG++IY82nd60?=
 =?us-ascii?Q?7odQ9Y5f97Z5KSW7YDqTWKZKtAWjeym7M7G9hhGL1+15uWV/psHlOTSjtljL?=
 =?us-ascii?Q?bQtjLKIuy8QA5uo5s/ZgBU1/5EZr6YESln9BnG05V3V8zon4pqq+ekDQJbu4?=
 =?us-ascii?Q?MMmedu6zhTSuDt7JBG8iRwygb6xWeKpFG1BF1ULnP/jhcGxFmqKpOtuWGIJd?=
 =?us-ascii?Q?YvlmenTEc0GYGoXqPFx4L50Y+BqchE9g+2BtSQsNLQ9haAib6RKt2Wqmoimr?=
 =?us-ascii?Q?/yhGZh6HxdssLmU+FMSIQZvVwpOy7Oz5d9xjsi5pn2e2/wafpAoMOQvf7457?=
 =?us-ascii?Q?CUtna0IUwItkJGd14u6LmG7OWh6emAdY9JUapMEwgGrWNy4ugwv0Uj6srf+C?=
 =?us-ascii?Q?5CPViTclGzfKGmJJLpFfyEvIcAURXw/D4ZT087sCLdwGHa50CuNFdLVjoUwe?=
 =?us-ascii?Q?E+uTvWgEMuO8tU5Y1jCG5ZieYVXOt4icmBB4axhmyBEvJi05DY+PHcaT+2/0?=
 =?us-ascii?Q?D5lfVE5/8FMwZtJZl15ImOiuswidLO+n3JC7X0xBPK6J0dsP6P0aGr+pIidN?=
 =?us-ascii?Q?RRUsMlZqeu8OdViZ5N/1yH1DczV7uf7xl5AI0tadg23K4lnxjbdDlkIxqRXL?=
 =?us-ascii?Q?xXZQgJ/sN/o2x48zJqGJ0F2vc9HLiVWrk6TR3dbWrgV/Z3MDo2Cy0rKhJq2c?=
 =?us-ascii?Q?BzCSWWgSyrpt7enkubE5MlQ/0ODfOgxgpHQsvc62Y+DUlPcpuwCRkJUgbL+O?=
 =?us-ascii?Q?iA31v1S0NmCW3wpWyJuc6nW6R2h1bePa9eLxSJQeFdlGN0it2eFVgkckaogr?=
 =?us-ascii?Q?687KRpH6pAxTWKhH9WFiM7aoiwNoafa/h+Yt1l5ByKJ5La8toa4oAJvk22n8?=
 =?us-ascii?Q?hK0EgmiTa6CQNu2mqAosEa8iAWMEdLks65aRJiyug5oX0MBnAhnMiIkcscNC?=
 =?us-ascii?Q?aZdkKuuyJuJ/VHRUlaUvm1AJ0pAyE7kAcYbgsIczNW2VJFK3quHpSD78+Bus?=
 =?us-ascii?Q?JX0igAyhwZin0K+a5NOyue/j7EqHqT7GGVQMwK8gnDxUCxd38aJdeeKwSRVG?=
 =?us-ascii?Q?ZOHyJFEfdjNf685k+ATE5T3Ka72dl4XRaHYpdpGNhkm5e2WoX8h1Bgw9jkVU?=
 =?us-ascii?Q?rUiUhTiuO+eal8/jyBPH04ESBtLbGv1frT+ny+IMIeUUY0Yd3mFBxp8OYumy?=
 =?us-ascii?Q?aAy2bQ5l8su8hPZlCyfImMY8bWkBv5wW?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 23:41:38.9683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df1a208-b039-46a4-003f-08dcbbf17a30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7221

With recent work to the doorbell workaround code a small hole
was introduced that could cause a tx_timeout. This happens if
the rx dbell_deadline goes beyond the netdev watchdog timeout
set by the driver (i.e. 2 seconds). Fix this by changing the
netdev watchdog timeout to 5 seconds and reduce the max rx
dbell_deadline to 4 seconds.

The test that can reproduce the issue being fixed is a
multi-queue send test via pktgen with the "burst" setting to 1.
This causes the queue's doorbell to be rung on every packet
sent to the driver, which may result in the device missing
doorbells due to the high doorbell rate.

Fixes: 4ded136c78f8 ("ionic: add work item for missed-doorbell check")
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_dev.h | 2 +-
 drivers/net/ethernet/pensando/ionic/ionic_lif.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index c647033f3ad2..f2f07bf88545 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -32,7 +32,7 @@
 #define IONIC_ADMIN_DOORBELL_DEADLINE	(HZ / 2)	/* 500ms */
 #define IONIC_TX_DOORBELL_DEADLINE	(HZ / 100)	/* 10ms */
 #define IONIC_RX_MIN_DOORBELL_DEADLINE	(HZ / 100)	/* 10ms */
-#define IONIC_RX_MAX_DOORBELL_DEADLINE	(HZ * 5)	/* 5s */
+#define IONIC_RX_MAX_DOORBELL_DEADLINE	(HZ * 4)	/* 4s */
 
 struct ionic_dev_bar {
 	void __iomem *vaddr;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index aa0cc31dfe6e..86774d9922d8 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -3220,7 +3220,7 @@ int ionic_lif_alloc(struct ionic *ionic)
 	netdev->netdev_ops = &ionic_netdev_ops;
 	ionic_ethtool_set_ops(netdev);
 
-	netdev->watchdog_timeo = 2 * HZ;
+	netdev->watchdog_timeo = 5 * HZ;
 	netif_carrier_off(netdev);
 
 	lif->identity = lid;
-- 
2.17.1


