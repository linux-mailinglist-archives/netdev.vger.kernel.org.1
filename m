Return-Path: <netdev+bounces-133271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E8F9956AA
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 20:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 091C11C23534
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D8E215031;
	Tue,  8 Oct 2024 18:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mxWp24SU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CA9212D09
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 18:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412434; cv=fail; b=cHizrNHTUzo1AwZ3Y1ZUdhzoYf9OmEVoXIAajM2/XtnMsiuO4hosgTGUoepiIH2BobQ9u9BpQxTltN9jyPDZzbIbPl3Jrrlaz2SLImlL4o17hUFALo7Esz3O3cQFbJG8mV1j+i7wOUoeDDMAlz4uNETfjogurU8Ab3c2kN/99Tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412434; c=relaxed/simple;
	bh=2ajWwBoqxqfQvOzuss5drpMDkshc1p7P2ozKojAYilc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NhMd9fWppW3jYx/LMs+nzicSUN5HPOdg/h297e6kqxvdMvUdzX5kYwVTDiCNf8up7f6yGwpzSbmvJaf+OW1idzFVFzHNOFw6InvoHTVv1Hf0VsmPqR4o1Nrdbr+kbB7+kcHBtZuH3mUa71TB0xpTB0YrTPg8u7upP2/3SWDT0oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mxWp24SU; arc=fail smtp.client-ip=40.107.101.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBiKQQHpdZz9kl0ZwCB0PX++3PY4Hv6NBJVeROi2j/KQUOovDXpDGTBkKzssH7clRwQ+n7wvqeMClRAepZKg9AZ99XaU4xwteELEn4zAMByjCudnDwdjJzPQ+oT6AFEcCYkRtLYQVmKDzworXLL493VaqGMrsY0oY+ZbZMgwqB/TCdM0CMRadbvCU7xQ4+iGkOJZA6mJVoHAbZjhB/i7goKDGxFlhl+uIA0Tp3T7i/ine3AwgZaOxXKptkgFdLOg7JPPd2wA35OJis0dhQa/jS0LkwecbBD56VOd8vXCYNp3jbY6vXWjz2ToHqaHUNqQwpsRdKB+7z2z7xljysLUew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XjjOEDhaMTknoGh75d2pMLhHpUFmbuZ61wyybAKhirk=;
 b=ZEjj4S8V1sHzJ/34ac9mkRaJXbpeBzYOi170ulJ7gLhIzXFt4SjCpy5UTm3ASpEv1zRCWWHbX2jENU9didN6PhBWO6dVPdsPiq/2u8TsQTgj13TtOicEflXaw03kneq27ocjOvLYEyT7s7pcXlymLVusY50HXIPllpRhlw9tpvI4/MPbiKac+DuULhmjtj3sUbTTTjLUpWILRF+6wa8oGHxt7/ZMXicXfxMsY6kGfH0gvGQhU4qXW60yh1CKXboXbBI1qDJMGvNWfUHtA2QDczPd2KUBSNBo/k0dHT2jucpWurL3Kpzx/LFNYgXBUglUf0XS5B7fuM8Q+We5uo5jsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjjOEDhaMTknoGh75d2pMLhHpUFmbuZ61wyybAKhirk=;
 b=mxWp24SU0juXhVpIyV+I48G8uB4aKH7iUjogtfsYfMGyYL7RMj7lCagsVDaroFa/WpwgIC0Iexzeyn7cH1xjH3Ks1Uvy+wBJvjA9i9to/VB36FtOlfeBXRUo3M0Y6ozmPHqvZRGenYCn9ojl29wZUienWrQhAypHoUIIhmv5o1QapmWFyuefvMHRIy3ghh9EcAlkSdV/3mliLeg2fpj66Z3oxi4q+t3+k8sGqqEtRmbw5f/N0zq2Q04Iu8xUbuJ0Lcpstsah9WPlqmss2gYn6NgeVQ7F9NIjo40Ug3hdRxxIB97zWzj3IiceGFiYR0m7SZ+EOraKMg9qRVoAox6Qew==
Received: from CH2PR05CA0068.namprd05.prod.outlook.com (2603:10b6:610:38::45)
 by DS7PR12MB5861.namprd12.prod.outlook.com (2603:10b6:8:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 18:33:47 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:38:cafe::c1) by CH2PR05CA0068.outlook.office365.com
 (2603:10b6:610:38::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Tue, 8 Oct 2024 18:33:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 18:33:47 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Oct 2024
 11:33:33 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Oct 2024
 11:33:32 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 8 Oct
 2024 11:33:30 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 11/14] net/mlx5: qos: Store rate groups in a qos domain
Date: Tue, 8 Oct 2024 21:32:19 +0300
Message-ID: <20241008183222.137702-12-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241008183222.137702-1-tariqt@nvidia.com>
References: <20241008183222.137702-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|DS7PR12MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: 34dd8372-6382-48e4-d68b-08dce7c7bf2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D67JpWdRy2YF1qaR+qt4OZV4L98uURHM0LpSZ8Hnn1BDMmY1euZXObni9D34?=
 =?us-ascii?Q?PdRytBDAm2MBaLmbFxSlKEJUCLXY/4gABy00XTs0ZVfntDA4gT45ri6RpUrf?=
 =?us-ascii?Q?w6Xdxryhd7nRhUE0d3rSgelrivyPo9KpI+RxZ8umLyjDtV1h2lHJsGWPv+1t?=
 =?us-ascii?Q?4vf731S93JKwNnL0WAudkMliJgKw3c2ZdbRBYvWlfrRxW9mIPjjdV0qgYaYU?=
 =?us-ascii?Q?d+nG9INRpxdQ1ESyoSDW9/D9KmMCfURg5YH/A24UgeOoPYydDyou7R17Y5WS?=
 =?us-ascii?Q?6FS95yP6J6LMdh2KWodwZDZYp4aZxP3xEYQ9ZqufObn5rUqkyc3+WLCwAxwn?=
 =?us-ascii?Q?zukHLyykDMqvQ6jONk4nfInnxaXHmS5HkFVHlMX8ZaU0hxG2cqvvANpzxV4a?=
 =?us-ascii?Q?C5yIjSyAumkHyYxVuV7MIOyaoKevGSNYTW05T9kkbATq9JpJk19CGUhQgdxA?=
 =?us-ascii?Q?4fOqaDCMVxzwFoIFZ9CMTKCZYwCNiSOZVFlu2kxwEUe/IjOi31Z/lztW61W2?=
 =?us-ascii?Q?vIj0R9gqBvJ0U+5cHrS4UCGZnW5fCoGwSCF6ByEdofjkccWwzZZD6hTwfxNP?=
 =?us-ascii?Q?zxozbyB7FS14Q0YYTpFrAczVvWX4pWyi9aC3JSEsJwlfwLGSWgxUhSqHuqin?=
 =?us-ascii?Q?Z8AI3Tlms16lVhipMAjTPG8eB1Soqul2WpeNl0cemz2KsLZvEey6MIBmT9nR?=
 =?us-ascii?Q?cPV+yxlO38+KZO/X8h4oDB90qxQ3Qk+gCFaYlmcuyK4u5I3vKlbLWBWJJHwH?=
 =?us-ascii?Q?Yr1/stUhxSScGNz83pQKw/Jp6covZ5Tx1mOwYfaf+88XOb7RXVB2ODl2kzPB?=
 =?us-ascii?Q?xWd5btCyVQbOzs6V0/FDkMI81atv/BOtBoFVxD3DJXdeEm548gakOcZUZAAc?=
 =?us-ascii?Q?OEB2TrgtBP3JSW3KnPKmQjr4Zfc/HUWiS6ql5Yk6uAt2ZVzLtc8ZEbGPQR2S?=
 =?us-ascii?Q?1BIG+jrNLxoUSDkTxqauifvvAQ0t0pRmHuf+M3qSJrZK7syjZRuUB/NMQZ3+?=
 =?us-ascii?Q?2VzcsPiLT63cW7OH6MNsPbPdn4/+tPJGLiSCrZLz7DVjaH4ZcAJkGcJnZjYw?=
 =?us-ascii?Q?MCiha7urIcfnheu6fOCcH366XwcVRSq3Zg9smvB2JEzUb0+T9PWu7t8KszuN?=
 =?us-ascii?Q?flwswqfsxmCW7aiUngDSBWJ17LFY+VYXJiBg/m78OGDMpQQPkQSWdDDimjiT?=
 =?us-ascii?Q?+6QPhZ9JEygk6oZnnesYTcxdQzy8VmVyFglcBMChbmySJr6XVoVHUU/qzXWf?=
 =?us-ascii?Q?XAm7EQ/iFr9cdF1n1S98gzX36HaymJ20/HACyaxXFZHaajHPbhk+luNqfSEb?=
 =?us-ascii?Q?uw5mPPzTsa84AV118gV9J8NtU7XHRDSZ66Yv1tbr4ILfky4WXp+TdKe3XRVL?=
 =?us-ascii?Q?wiaFvDU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 18:33:47.0453
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34dd8372-6382-48e4-d68b-08dce7c7bf2f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5861

From: Cosmin Ratiu <cratiu@nvidia.com>

Groups are currently maintained as a list in their corresponding
eswitch, protected by the esw state_lock.
The upcoming cross-eswitch scheduling feature cannot work with this
approach, as it would require acquiring multiple eswitch locks (in the
correct order) in order to maintain group membership.

This commit moves the rate groups into a new 'qos domain' struct and
adds explicit qos init/cleanup steps to the eswitch init/cleanup.
Upcoming patches will expand the qos domain struct and allow it to be
shared between eswitches. For now, qos domains are private to each esw
so there's only an extra indirection.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 58 ++++++++++++++++---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.h |  3 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 12 +++-
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  3 +-
 4 files changed, 65 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 5891a68633af..06b3a21a7475 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -11,6 +11,37 @@
 /* Minimum supported BW share value by the HW is 1 Mbit/sec */
 #define MLX5_MIN_BW_SHARE 1
 
+/* Holds rate groups associated with an E-Switch. */
+struct mlx5_qos_domain {
+	/* List of all mlx5_esw_rate_groups. */
+	struct list_head groups;
+};
+
+static struct mlx5_qos_domain *esw_qos_domain_alloc(void)
+{
+	struct mlx5_qos_domain *qos_domain;
+
+	qos_domain = kzalloc(sizeof(*qos_domain), GFP_KERNEL);
+	if (!qos_domain)
+		return NULL;
+
+	INIT_LIST_HEAD(&qos_domain->groups);
+
+	return qos_domain;
+}
+
+static int esw_qos_domain_init(struct mlx5_eswitch *esw)
+{
+	esw->qos.domain = esw_qos_domain_alloc();
+
+	return esw->qos.domain ? 0 : -ENOMEM;
+}
+
+static void esw_qos_domain_release(struct mlx5_eswitch *esw)
+{
+	kfree(esw->qos.domain);
+	esw->qos.domain = NULL;
+}
 
 struct mlx5_esw_rate_group {
 	u32 tsar_ix;
@@ -19,6 +50,7 @@ struct mlx5_esw_rate_group {
 	u32 min_rate;
 	/* A computed value indicating relative min_rate between group members. */
 	u32 bw_share;
+	/* Membership in the qos domain 'groups' list. */
 	struct list_head parent_entry;
 	/* The eswitch this group belongs to. */
 	struct mlx5_eswitch *esw;
@@ -128,10 +160,10 @@ static u32 esw_qos_calculate_min_rate_divider(struct mlx5_eswitch *esw)
 	/* Find max min_rate across all esw groups.
 	 * This will correspond to fw_max_bw_share in the final bw_share calculation.
 	 */
-	list_for_each_entry(group, &esw->qos.groups, parent_entry) {
-		if (group->min_rate < max_guarantee || group->tsar_ix == esw->qos.root_tsar_ix)
-			continue;
-		max_guarantee = group->min_rate;
+	list_for_each_entry(group, &esw->qos.domain->groups, parent_entry) {
+		if (group->esw == esw && group->tsar_ix != esw->qos.root_tsar_ix &&
+		    group->min_rate > max_guarantee)
+			max_guarantee = group->min_rate;
 	}
 
 	if (max_guarantee)
@@ -183,8 +215,8 @@ static int esw_qos_normalize_min_rate(struct mlx5_eswitch *esw, struct netlink_e
 	u32 bw_share;
 	int err;
 
-	list_for_each_entry(group, &esw->qos.groups, parent_entry) {
-		if (group->tsar_ix == esw->qos.root_tsar_ix)
+	list_for_each_entry(group, &esw->qos.domain->groups, parent_entry) {
+		if (group->esw != esw || group->tsar_ix == esw->qos.root_tsar_ix)
 			continue;
 		bw_share = esw_qos_calc_bw_share(group->min_rate, divider, fw_max_bw_share);
 
@@ -452,7 +484,7 @@ __esw_qos_alloc_rate_group(struct mlx5_eswitch *esw, u32 tsar_ix)
 	group->esw = esw;
 	group->tsar_ix = tsar_ix;
 	INIT_LIST_HEAD(&group->members);
-	list_add_tail(&group->parent_entry, &esw->qos.groups);
+	list_add_tail(&group->parent_entry, &esw->qos.domain->groups);
 	return group;
 }
 
@@ -586,7 +618,6 @@ static int esw_qos_create(struct mlx5_eswitch *esw, struct netlink_ext_ack *exta
 		return err;
 	}
 
-	INIT_LIST_HEAD(&esw->qos.groups);
 	if (MLX5_CAP_QOS(dev, log_esw_max_sched_depth)) {
 		esw->qos.group0 = __esw_qos_create_rate_group(esw, extack);
 	} else {
@@ -868,6 +899,17 @@ static int esw_qos_devlink_rate_to_mbps(struct mlx5_core_dev *mdev, const char *
 	return 0;
 }
 
+int mlx5_esw_qos_init(struct mlx5_eswitch *esw)
+{
+	return esw_qos_domain_init(esw);
+}
+
+void mlx5_esw_qos_cleanup(struct mlx5_eswitch *esw)
+{
+	if (esw->qos.domain)
+		esw_qos_domain_release(esw);
+}
+
 /* Eswitch devlink rate API */
 
 int mlx5_esw_devlink_rate_leaf_tx_share_set(struct devlink_rate *rate_leaf, void *priv,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
index c4f04c3e6a59..44fb339c5dcc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
@@ -6,6 +6,9 @@
 
 #ifdef CONFIG_MLX5_ESWITCH
 
+int mlx5_esw_qos_init(struct mlx5_eswitch *esw);
+void mlx5_esw_qos_cleanup(struct mlx5_eswitch *esw);
+
 int mlx5_esw_qos_set_vport_rate(struct mlx5_vport *evport, u32 max_rate, u32 min_rate);
 void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 4a187f39daba..9de819c45d33 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1481,6 +1481,10 @@ int mlx5_eswitch_enable_locked(struct mlx5_eswitch *esw, int num_vfs)
 	MLX5_NB_INIT(&esw->nb, eswitch_vport_event, NIC_VPORT_CHANGE);
 	mlx5_eq_notifier_register(esw->dev, &esw->nb);
 
+	err = mlx5_esw_qos_init(esw);
+	if (err)
+		goto err_qos_init;
+
 	if (esw->mode == MLX5_ESWITCH_LEGACY) {
 		err = esw_legacy_enable(esw);
 	} else {
@@ -1489,7 +1493,7 @@ int mlx5_eswitch_enable_locked(struct mlx5_eswitch *esw, int num_vfs)
 	}
 
 	if (err)
-		goto abort;
+		goto err_esw_enable;
 
 	esw->fdb_table.flags |= MLX5_ESW_FDB_CREATED;
 
@@ -1503,7 +1507,10 @@ int mlx5_eswitch_enable_locked(struct mlx5_eswitch *esw, int num_vfs)
 
 	return 0;
 
-abort:
+err_esw_enable:
+	mlx5_esw_qos_cleanup(esw);
+err_qos_init:
+	mlx5_eq_notifier_unregister(esw->dev, &esw->nb);
 	mlx5_esw_acls_ns_cleanup(esw);
 	return err;
 }
@@ -1631,6 +1638,7 @@ void mlx5_eswitch_disable_locked(struct mlx5_eswitch *esw)
 
 	if (esw->mode == MLX5_ESWITCH_OFFLOADS)
 		devl_rate_nodes_destroy(devlink);
+	mlx5_esw_qos_cleanup(esw);
 }
 
 void mlx5_eswitch_disable(struct mlx5_eswitch *esw)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 567276900a37..e57be2eeec85 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -336,6 +336,7 @@ enum {
 };
 
 struct dentry;
+struct mlx5_qos_domain;
 
 struct mlx5_eswitch {
 	struct mlx5_core_dev    *dev;
@@ -368,12 +369,12 @@ struct mlx5_eswitch {
 		 */
 		refcount_t refcnt;
 		u32 root_tsar_ix;
+		struct mlx5_qos_domain *domain;
 		/* Contains all vports with QoS enabled but no explicit group.
 		 * Cannot be NULL if QoS is enabled, but may be a fake group
 		 * referencing the root TSAR if the esw doesn't support groups.
 		 */
 		struct mlx5_esw_rate_group *group0;
-		struct list_head groups; /* Protected by esw->state_lock */
 	} qos;
 
 	struct mlx5_esw_bridge_offloads *br_offloads;
-- 
2.44.0


