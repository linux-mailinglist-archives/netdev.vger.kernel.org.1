Return-Path: <netdev+bounces-104699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8485090E0F1
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 02:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89E7C1C2190E
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 00:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38986566A;
	Wed, 19 Jun 2024 00:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FMXdXuXc"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2085.outbound.protection.outlook.com [40.107.101.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909878F6D
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 00:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718757239; cv=fail; b=QVhElX97g2CVGDWrlZ3dR942ykWpbgAEpMr5RS4ncBZYVtyvPnSHhL4cHvF9CisXKZjeMOQ3z6ybupkqOuyIBa40EVdxfxtekrhItinZ/Rr3wWo7tf+jkeGFPDftUN4kSBlv9i+IfdfbTmmV1xdRgc7qwyUIoWET1OV3q3NZh/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718757239; c=relaxed/simple;
	bh=MfVamlefaV1WIF/C/69cndT3IZ14FZ08FCuWIdzCoAs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YK1dbf9KaEwNcUNemYJtjWloRK+2VfzKaPfx4/c7yGkBla+vAH16XAX0nnR+jnhjIvfokE3q2lfYUsN9upoQZpvHqz6o/jtp4qKIyhQPADRc1tTQF9K0EV7HBlPn4SxDJk4BJfKaUXkclyp7wAQxjGoaCcJQCHV8XHaFSMA7E60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FMXdXuXc; arc=fail smtp.client-ip=40.107.101.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erg9QlxBv0uqfWRHnxfS87V7mRV7GqMw08E+5FZBljtlj7iqwNsZdXjpWtOFXMGnJPBFlTTZMkx5WWvGKhn6aWiHPk6OEx2wC4bT4+bDQZYNreNxnyG7Ak0YFdSt0jI2zIsQX4nR1qCmnbLPTCB/pquy4r4iprtMEXcU34ToeyAgF6aJHYMGidlEC8Xt9klLRBMZDpx5lJKKGI+/Rks5jQbSiomz+2ci6xqubOtRXjpsN3EFlG6uGuaqKWVJ2vXOqqh8bmwHYSgYPGb+4y9+BZ1rgGU5oJzHhpLhW6qd2yNILJjAP3lrsd6bV1QNNcSHvtT9FDsYV11tjfcn+j3VlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFYdi/uRGxPUEepHCoCtFy3NcbEECYgizrL/XlFOqRc=;
 b=A8EExFgGKTAhwdWVvGxCxhjGQONnrsfKjLa/Dv7vHmzzsQL1yNav3snlfXCfAxKEPlXXT5fNikBpEwauF732LbgrFl5gyEDk3YCANRIUro6YCyGakPwPIv11Z8rvnd08J1cg44C5HrQfJIfZVLhyvxClOJdCyu7tEWx5Izxg4MEXj/OaX5AOJ6cQKquux9okCJ1bQuHxmatBtqIprMG1l5twmtdovmZik2LqO/is7h6UKAPkuxQmkkCLoHZBLFXKpTZ+7webo06bd/IjDH+wHoZNPJIBWAaftaopSi/ZNIx/HSKo4UA4OZZtSNC+V7xjLvLAdvI5RODIHlQN+GIW4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFYdi/uRGxPUEepHCoCtFy3NcbEECYgizrL/XlFOqRc=;
 b=FMXdXuXc+UR+Xtw9JSJcdyiLzqF6/OzsapttVg0GguTjoQJ/Fm6r+pVCu6fcm1WxLjImdIJ+2mVPN4lWumgIpKatBVlRElCTFXdSHuTdD/+o3TUvwUPKTZdrxihcvpfLaIDjtJMwu0BNsq6m/ScdGpPM3sneCbUVdm2g4UOv0Ns=
Received: from PH7P220CA0098.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::9)
 by SJ0PR12MB6877.namprd12.prod.outlook.com (2603:10b6:a03:47f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 00:33:54 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:510:32d:cafe::c8) by PH7P220CA0098.outlook.office365.com
 (2603:10b6:510:32d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Wed, 19 Jun 2024 00:33:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 00:33:53 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 19:33:48 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <David.Laight@ACULAB.COM>,
	<andrew@lunn.ch>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v2 net-next 7/8] ionic: Use an u16 for rx_copybreak
Date: Tue, 18 Jun 2024 17:32:56 -0700
Message-ID: <20240619003257.6138-8-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240619003257.6138-1-shannon.nelson@amd.com>
References: <20240619003257.6138-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|SJ0PR12MB6877:EE_
X-MS-Office365-Filtering-Correlation-Id: f9124e65-6c77-4309-79ea-08dc8ff77f73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|82310400023|1800799021|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CrprtqFLuJvcWPRMFOYTSbL1QWimoJuqbmcdTWISvWaKvKwgsuWyvn484COT?=
 =?us-ascii?Q?hw0dnKNniLIY5Dyx0JPJk8w6RmlllIZDR/4dMcJG1qFG9BsEJZqaQpERjtsb?=
 =?us-ascii?Q?p1j4gXTiwcsmpxzZ7U7gmWnCuaQQfXCV9HsQUt4mAlu0XPQENvGuPb6drC/G?=
 =?us-ascii?Q?5fUtoqCJeSGKMcVzo+MkB02+xpVxmEONg8eU3NdQ6qkA8J+1d9eHH65aa1zw?=
 =?us-ascii?Q?X1Q9/2q+Hi3cEySGFzh6X2zbSO81zfJ7/yleFVPyiUSYs72inbcS40Sl4J/2?=
 =?us-ascii?Q?tv7d7yPBDUbQhQYYzaJ0SrVpgFsFADmD3R+vrzlgIo+7g+nZYeF7hZupJeNS?=
 =?us-ascii?Q?SLrk/Xp6waQACWM8hpHXJwXmTa6z1XqfZSH3Og/9+pY7LOd3nlZKUQZt2QKJ?=
 =?us-ascii?Q?7wjxg8nlqHN9YbhNUnrOm7pYCaRW9e0Q5iKIl2otB1YyqRxDjlz1tFt9621B?=
 =?us-ascii?Q?FLQLg8ClLabDWS0pgpsoIGSUN+XmVR/f2MDJV8XCTFqBnPUwtGZM8BwDMH1z?=
 =?us-ascii?Q?m1ySloMq20qCUacDzgQAUHY+DOhh61348D4rFCDmJvx+naWU3Jq3sIyqjmXM?=
 =?us-ascii?Q?LPSMXGVMxU2ot8G19cD9mkFXU5d/BUKV6Wfr7+J7v/f6DEyDyxR05aYU/FXP?=
 =?us-ascii?Q?FgI1gNlVInjawNmRgJ8ihHVUTZE/Ztx4lhnZr0U6YDHGGUFKx5rANLIYATdK?=
 =?us-ascii?Q?2JuI0xRQ2rcg6cclhdHv6E82oyivyKKsrCeJr0tU81XE6v2M68V0U4NSAxaY?=
 =?us-ascii?Q?uNYCdwmfKIFGlUxmytj51LDlvQTkCftZ/5bc3PiZpEdk+eWGGMtKef9d5WdH?=
 =?us-ascii?Q?lACaq5Q32+A+DMLdqomoG0wAlZG2DPenT5fO8qomRkuQ8Y9MRkH5e9URJFAH?=
 =?us-ascii?Q?k3ZCO6Wnbx+CARJR82H2mVYS1+tzh1jQ8ym14EP+EHr6FL1820QpydqudYOz?=
 =?us-ascii?Q?Jxm4FfIhgnA+2no4ZT+cJ7Mdbcwcq4eGib3PXPvq/6ATNTP9C7BAjYLuW028?=
 =?us-ascii?Q?rYVVFwkplrphqCZ650x2x3Hn0SgmG3IpQNqHgP7M9yNchaeF61MW47Cc3DmW?=
 =?us-ascii?Q?Urtw5aOU1fCQbKT6gBy9kqg1YAmc0PZkOBvF7rqkFdHFM5MTXfHryNkZaJ0j?=
 =?us-ascii?Q?Lk29IIdNH86QTI38Z0vNsPlMjK54C5mWABTKz3FdIol/pyaBqxHqBMojQw9S?=
 =?us-ascii?Q?GkwI7mxQuTw22mu6Ky6+pqWTinu69ztcBAVvP6pD73X4c8IqxLB1U+hw1vR/?=
 =?us-ascii?Q?DVIZgIMaCWIJdSe51x1vjIcFCkgQ9Xb1i6FddwGaAx62LsH22lugbI2rOPtP?=
 =?us-ascii?Q?p+0rdMAxw+uDbaXffkHfECQXH1NNv4OhNk3ruCvx3BIf5A2dsJPB5Deu6uFZ?=
 =?us-ascii?Q?qo9o6NVT+kwPeonYk7QgbRZquM3Zib0qmLCd0jTR5hfAwsmpcw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(82310400023)(1800799021)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 00:33:53.6486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9124e65-6c77-4309-79ea-08dc8ff77f73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6877

From: Brett Creeley <brett.creeley@amd.com>

We only support (u16)-1 size for rx_copybreak, so we can reduce the
field size and move a couple other fields around to save a little
space in the ionic_lif struct.

Before:
	/* size: 17440, cachelines: 273, members: 56 */
	/* sum members: 17403, holes: 9, sum holes: 37 */
	/* last cacheline: 32 bytes */

After:
	/* size: 17424, cachelines: 273, members: 56 */
	/* sum members: 17401, holes: 7, sum holes: 23 */
	/* last cacheline: 16 bytes */

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 11 ++++++++++-
 drivers/net/ethernet/pensando/ionic/ionic_lif.h     |  6 +++---
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index 91183965a6b7..185a03514ae3 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -11,6 +11,8 @@
 #include "ionic_ethtool.h"
 #include "ionic_stats.h"
 
+#define IONIC_MAX_RX_COPYBREAK	min(U16_MAX, IONIC_MAX_BUF_LEN)
+
 static void ionic_get_stats_strings(struct ionic_lif *lif, u8 *buf)
 {
 	u32 i;
@@ -872,10 +874,17 @@ static int ionic_set_tunable(struct net_device *dev,
 			     const void *data)
 {
 	struct ionic_lif *lif = netdev_priv(dev);
+	u32 rx_copybreak;
 
 	switch (tuna->id) {
 	case ETHTOOL_RX_COPYBREAK:
-		lif->rx_copybreak = *(u32 *)data;
+		rx_copybreak = *(u32 *)data;
+		if (rx_copybreak > IONIC_MAX_RX_COPYBREAK) {
+			netdev_err(dev, "Max supported rx_copybreak size: %u\n",
+				   IONIC_MAX_RX_COPYBREAK);
+			return -EINVAL;
+		}
+		lif->rx_copybreak = (u16)rx_copybreak;
 		break;
 	default:
 		return -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.h b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
index 40b28d0b858f..5bd501355670 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
@@ -206,10 +206,10 @@ struct ionic_lif {
 	unsigned int nxqs;
 	unsigned int ntxq_descs;
 	unsigned int nrxq_descs;
-	u32 rx_copybreak;
 	u64 rxq_features;
-	u16 rx_mode;
 	u64 hw_features;
+	u16 rx_copybreak;
+	u16 rx_mode;
 	bool registered;
 	u16 lif_type;
 	unsigned int link_down_count;
@@ -225,11 +225,11 @@ struct ionic_lif {
 	u32 info_sz;
 	struct ionic_qtype_info qtype_info[IONIC_QTYPE_MAX];
 
-	u16 rss_types;
 	u8 rss_hash_key[IONIC_RSS_HASH_KEY_SIZE];
 	u8 *rss_ind_tbl;
 	dma_addr_t rss_ind_tbl_pa;
 	u32 rss_ind_tbl_sz;
+	u16 rss_types;
 
 	struct ionic_rx_filters rx_filters;
 	u32 rx_coalesce_usecs;		/* what the user asked for */
-- 
2.17.1


