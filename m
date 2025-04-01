Return-Path: <netdev+bounces-178695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87090A78502
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 00:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AB8216C5D3
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 22:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7355B1EE03C;
	Tue,  1 Apr 2025 22:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Naq2ygTf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ED01C863F
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 22:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743548149; cv=fail; b=bIug2iGtPmRYHejXUzgCQmyBEG7fH7Nb8l8wxffj26K62QzStiSrsgXNH8mNdahgfhGQDhVEWfd6Lbc+6C3vNBlaNkKueLhBPB10ey1uRGTQXROT+QsVNeFeuA5FQ+PCSvJp5OtnwF1IXVbY2n7s04AHSR0nAEU2iK/8igQteY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743548149; c=relaxed/simple;
	bh=y4vpATe5z3j6V+1B/2kpN1voo/r7CEPJTIEmJJg3Tbk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kyz6nlPrInmWRN0xkoODuYb6U3TPUa81OguVrMIpoTxJyLmN7pmnaJgu95DsEm1WMzCsDz8Ho7eUa6BvKVNj2jpaR6+/FZU6V6sjbWqs2lWlibDs1T864UNK9TyOsGhjkUtAxXyTFP1LOGl09hS+1S+dIWDqreMDZ5hz/GdMqyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Naq2ygTf; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIP6+3wEspkiWb5o0JmQQcbgj2iOIGv+8jfmQ7pzsa7kO3+yQ6Isqt7JcPWxQSZAAHlGp3JFv9Cnh4Vm9GKp8nEN16bd32ywtdP+ZXMZ5oy0ZvFAfpalpAY4MzOF34apGZcEP2klL+XcZez2V8HfoW52asNuwJchcQnpF5VjioihmqwV0tryY/N3V2fe4ETKm9xBvHRQEgSnpHaO46+HDxSVgO8HNoRlOeB5UXZpVmrGtdqGdEF3wxy0j5wghg2ErWHbKpVVT/f2dJ6E9XaPmjTFGaCEtZK6cu8rRbk8cWSX8VJWsFEkkA2GCuFQVkOKcmBK2NL7dfABJfCfvXI6cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oV7kCTXFRM2ksqnERWk4glveT7DaOUVXOvg5y8zflLk=;
 b=w0MHC6Bwk2q7A0qPohLuFDf2H9k5dnn+m5YcJfCDLqDhVSwAo98pSytC3RFrURulbT4Qkru9+fkRtU2A4i/64biUX0gvOaL/JSD4wu0fojZfL4ZIYEusKJMx4EptK1cCmETNPUmWIY4L4jq60UQFWLa0bADwkRANKvZ3bqyOWz92HibzWMA0MquRL4N9S5vwSUKzTPoChJeSfaIwM7+TplHHH98mNRVqyzEAlHrUz/Qz0/XcUGA4m/J87lEQ9ebBFt7wpAA3uJvP0ESB5cO/VS3dXPLN8cD8DPbZLEkd66hyVX3GhiTkBNjZyGhzCHPtNOWs4DRRUonqQa9DnKb9zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oV7kCTXFRM2ksqnERWk4glveT7DaOUVXOvg5y8zflLk=;
 b=Naq2ygTfP0DrtoFwJOKYJ4lh2j8WR0zHdxeNAnlzD6rVBoJ5qMsMYIXxxjioYr3UY6t5U0DkQ7+XHQBVoAIzU7fiGyfyX4eqCU2Z9cSeenmt0bIjus/lr4QUr4RIdWzxmk4OKZjUS0cTBfCySWmD9PVGTVjW9RZNodk2wGiDCuM=
Received: from MW4PR04CA0215.namprd04.prod.outlook.com (2603:10b6:303:87::10)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.52; Tue, 1 Apr
 2025 22:55:42 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:87:cafe::cf) by MW4PR04CA0215.outlook.office365.com
 (2603:10b6:303:87::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.54 via Frontend Transport; Tue,
 1 Apr 2025 22:55:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.2 via Frontend Transport; Tue, 1 Apr 2025 22:55:41 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Apr
 2025 17:55:40 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 1 Apr 2025 17:55:39 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<andrew+netdev@lunn.ch>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>, Kyungwook
 Boo <bookyungwook@gmail.com>
Subject: [PATCH net] sfc: fix NULL dereferences in ef100_process_design_param()
Date: Tue, 1 Apr 2025 23:54:39 +0100
Message-ID: <20250401225439.2401047-1-edward.cree@amd.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|MN2PR12MB4063:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c17c671-cd13-4065-e1d4-08dd717053c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xbqXGSHYS8nd7Zrfjj4a4/GXPszK4XRIURz+YOqdxeZ47aihHeDjEae6G40l?=
 =?us-ascii?Q?0zLNIwytEGkKOp5NjldhPVNbGuSMCncaBfbOOYEAaYkQeMcFnfBzF690FE3q?=
 =?us-ascii?Q?TTm2xlmA/xkLq0EZ0EtpvxBtN9/XmCHNNyMtrRKpI2+Xva94xjW8uYtXXR7D?=
 =?us-ascii?Q?KwYcF46Wyged3xNsf4zFed3VGU8t1g6knv2u0I4+LG4WubJxjzdMFO0D+Vn2?=
 =?us-ascii?Q?4qEa1QtzreElUo+fRxF7qLTMKxhZlZH4FNMUzeFzYAw7uA/lVv3Cg2C6Y8eM?=
 =?us-ascii?Q?RdpkA5AZsHqoQ9AQ/c8cFXz1jpZFcQoqVNZlbPBhJF/scErHdP2dQ6vdaqGF?=
 =?us-ascii?Q?3WM/1mtpE1tTyKF/q1/cTgg69EXsT8FXdbT4DkdaQv5E+ooC61qQ+lyOcK//?=
 =?us-ascii?Q?rXqKPk/HKfXcI5YHB7H6Im1ImoJCZW5iekYfKzntJ9TQbKDjCTaJmFFFwO61?=
 =?us-ascii?Q?xA3sutrWwEcs+o+gxN747cF+9xS/rgCvtzy1Sd/NXWxeGvjL5n7/rYxlBDYw?=
 =?us-ascii?Q?b7a5WSkL4WHaDW0S113rFtrsvCsjKVk2F+jpxmY1NnKWu1SmkLI/M62vweRN?=
 =?us-ascii?Q?lnG4T5MtIKDe4s5sPxOJspkHs+hwSV23z0reZFbdYU8s2DtOyW5hQBQ+aFlL?=
 =?us-ascii?Q?yRhSa0/R0x4dmImmQbbkTBOeEyXFi7nkP77IyjB7bFxHg/QHF4HoBkGK6gns?=
 =?us-ascii?Q?TF19ETKGyWPStKcQTMZ4mKSzk7xzZnWk8DuWieFUezZ7lC57SY4DCrHBh8oq?=
 =?us-ascii?Q?CRssmMeJEt37mXGWeMyMvCL5ao0SMEQZ+3ed97i6VvnqFcqkfUl7Kbkm5enp?=
 =?us-ascii?Q?POS4Pa5ic7HqB4FKQJ1XwvZEZQUHumrlGav5TSmAU3WGzuKkIJR6j3toF3CC?=
 =?us-ascii?Q?ajb38RubfOjMDRkS/8/TqpE1/IwbZhB0tJ0L76oMwK2aoiyn3qTaftRv6K/R?=
 =?us-ascii?Q?6a8vqYm3ZLXnPuHMBZ0vQJXaW9kkLf/6jBm3aMoGa/CR6ffiy447saLFRQCx?=
 =?us-ascii?Q?aHaxkIo3uhKqhhHA+c+zoVo0sdq7clMctxqSxF6CAP7vklXHwpP210/vl4rc?=
 =?us-ascii?Q?EAnaDCYAcWyqEvafd1yYKw9dVvaCkew+5kkqpn+86W7SXDulkm+E6AW39InG?=
 =?us-ascii?Q?lTPX5Ofq12olqkXH+vyfus4JJaG3an39sUzZJXrMbmyaSMk/VNbYRXvKA2Ym?=
 =?us-ascii?Q?zXRgJTdgVmTevo2x/tCAx9PB/WfW+BNZ4sVDqS9oizbT86aV08CwVZMqxQ6X?=
 =?us-ascii?Q?5FQsB0WexnUJILBfiQA/pATupcOtC8Zv89elEsLoMLr+SXPA+my3RV8brRMg?=
 =?us-ascii?Q?HZe0IMAVPp1EWg2QVXMAqQ2vWUNaHYj5m/ebUeG/4yjwYDCdZKHkCkketlIP?=
 =?us-ascii?Q?tnM9mKh7xbkBtxPGMvJSOAML4YezzZj0GPV8zmXOkk0U/gRffNRaq6iqJ+5J?=
 =?us-ascii?Q?u2My4DVhPd638VIvuX2ln6CLZ3j35S04jZnLa9Epq5vKAQhccuin6A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 22:55:41.0753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c17c671-cd13-4065-e1d4-08dd717053c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063

From: Edward Cree <ecree.xilinx@gmail.com>

Since cited commit, ef100_probe_main() and hence also
 ef100_check_design_params() run before efx->net_dev is created;
 consequently, we cannot netif_set_tso_max_size() or _segs() at this
 point.
Move those netif calls to ef100_probe_netdev(), and also replace
 netif_err within the design params code with pci_err.

Reported-by: Kyungwook Boo <bookyungwook@gmail.com>
Fixes: 98ff4c7c8ac7 ("sfc: Separate netdev probe/remove from PCI probe/remove")
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/ef100_netdev.c |  6 ++--
 drivers/net/ethernet/sfc/ef100_nic.c    | 47 +++++++++++--------------
 2 files changed, 24 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ef100_netdev.c b/drivers/net/ethernet/sfc/ef100_netdev.c
index d941f073f1eb..3a06e3b1bd6b 100644
--- a/drivers/net/ethernet/sfc/ef100_netdev.c
+++ b/drivers/net/ethernet/sfc/ef100_netdev.c
@@ -450,8 +450,9 @@ int ef100_probe_netdev(struct efx_probe_data *probe_data)
 	net_dev->hw_enc_features |= efx->type->offload_features;
 	net_dev->vlan_features |= NETIF_F_HW_CSUM | NETIF_F_SG |
 				  NETIF_F_HIGHDMA | NETIF_F_ALL_TSO;
-	netif_set_tso_max_segs(net_dev,
-			       ESE_EF100_DP_GZ_TSO_MAX_HDR_NUM_SEGS_DEFAULT);
+	nic_data = efx->nic_data;
+	netif_set_tso_max_size(efx->net_dev, nic_data->tso_max_payload_len);
+	netif_set_tso_max_segs(efx->net_dev, nic_data->tso_max_payload_num_segs);
 
 	rc = efx_ef100_init_datapath_caps(efx);
 	if (rc < 0)
@@ -477,7 +478,6 @@ int ef100_probe_netdev(struct efx_probe_data *probe_data)
 	/* Don't fail init if RSS setup doesn't work. */
 	efx_mcdi_push_default_indir_table(efx, efx->n_rx_channels);
 
-	nic_data = efx->nic_data;
 	rc = ef100_get_mac_address(efx, net_dev->perm_addr, CLIENT_HANDLE_SELF,
 				   efx->type->is_vf);
 	if (rc)
diff --git a/drivers/net/ethernet/sfc/ef100_nic.c b/drivers/net/ethernet/sfc/ef100_nic.c
index 62e674d6ff60..3ad95a4c8af2 100644
--- a/drivers/net/ethernet/sfc/ef100_nic.c
+++ b/drivers/net/ethernet/sfc/ef100_nic.c
@@ -887,8 +887,7 @@ static int ef100_process_design_param(struct efx_nic *efx,
 	case ESE_EF100_DP_GZ_TSO_MAX_HDR_NUM_SEGS:
 		/* We always put HDR_NUM_SEGS=1 in our TSO descriptors */
 		if (!reader->value) {
-			netif_err(efx, probe, efx->net_dev,
-				  "TSO_MAX_HDR_NUM_SEGS < 1\n");
+			pci_err(efx->pci_dev, "TSO_MAX_HDR_NUM_SEGS < 1\n");
 			return -EOPNOTSUPP;
 		}
 		return 0;
@@ -901,32 +900,28 @@ static int ef100_process_design_param(struct efx_nic *efx,
 		 */
 		if (!reader->value || reader->value > EFX_MIN_DMAQ_SIZE ||
 		    EFX_MIN_DMAQ_SIZE % (u32)reader->value) {
-			netif_err(efx, probe, efx->net_dev,
-				  "%s size granularity is %llu, can't guarantee safety\n",
-				  reader->type == ESE_EF100_DP_GZ_RXQ_SIZE_GRANULARITY ? "RXQ" : "TXQ",
-				  reader->value);
+			pci_err(efx->pci_dev,
+				"%s size granularity is %llu, can't guarantee safety\n",
+				reader->type == ESE_EF100_DP_GZ_RXQ_SIZE_GRANULARITY ? "RXQ" : "TXQ",
+				reader->value);
 			return -EOPNOTSUPP;
 		}
 		return 0;
 	case ESE_EF100_DP_GZ_TSO_MAX_PAYLOAD_LEN:
 		nic_data->tso_max_payload_len = min_t(u64, reader->value,
 						      GSO_LEGACY_MAX_SIZE);
-		netif_set_tso_max_size(efx->net_dev,
-				       nic_data->tso_max_payload_len);
 		return 0;
 	case ESE_EF100_DP_GZ_TSO_MAX_PAYLOAD_NUM_SEGS:
 		nic_data->tso_max_payload_num_segs = min_t(u64, reader->value, 0xffff);
-		netif_set_tso_max_segs(efx->net_dev,
-				       nic_data->tso_max_payload_num_segs);
 		return 0;
 	case ESE_EF100_DP_GZ_TSO_MAX_NUM_FRAMES:
 		nic_data->tso_max_frames = min_t(u64, reader->value, 0xffff);
 		return 0;
 	case ESE_EF100_DP_GZ_COMPAT:
 		if (reader->value) {
-			netif_err(efx, probe, efx->net_dev,
-				  "DP_COMPAT has unknown bits %#llx, driver not compatible with this hw\n",
-				  reader->value);
+			pci_err(efx->pci_dev,
+				"DP_COMPAT has unknown bits %#llx, driver not compatible with this hw\n",
+				reader->value);
 			return -EOPNOTSUPP;
 		}
 		return 0;
@@ -946,10 +941,10 @@ static int ef100_process_design_param(struct efx_nic *efx,
 		 * So the value of this shouldn't matter.
 		 */
 		if (reader->value != ESE_EF100_DP_GZ_VI_STRIDES_DEFAULT)
-			netif_dbg(efx, probe, efx->net_dev,
-				  "NIC has other than default VI_STRIDES (mask "
-				  "%#llx), early probing might use wrong one\n",
-				  reader->value);
+			pci_dbg(efx->pci_dev,
+				"NIC has other than default VI_STRIDES (mask "
+				"%#llx), early probing might use wrong one\n",
+				reader->value);
 		return 0;
 	case ESE_EF100_DP_GZ_RX_MAX_RUNT:
 		/* Driver doesn't look at L2_STATUS:LEN_ERR bit, so we don't
@@ -961,9 +956,9 @@ static int ef100_process_design_param(struct efx_nic *efx,
 		/* Host interface says "Drivers should ignore design parameters
 		 * that they do not recognise."
 		 */
-		netif_dbg(efx, probe, efx->net_dev,
-			  "Ignoring unrecognised design parameter %u\n",
-			  reader->type);
+		pci_dbg(efx->pci_dev,
+			"Ignoring unrecognised design parameter %u\n",
+			reader->type);
 		return 0;
 	}
 }
@@ -999,13 +994,13 @@ static int ef100_check_design_params(struct efx_nic *efx)
 	 */
 	if (reader.state != EF100_TLV_TYPE) {
 		if (reader.state == EF100_TLV_TYPE_CONT)
-			netif_err(efx, probe, efx->net_dev,
-				  "truncated design parameter (incomplete type %u)\n",
-				  reader.type);
+			pci_err(efx->pci_dev,
+				"truncated design parameter (incomplete type %u)\n",
+				reader.type);
 		else
-			netif_err(efx, probe, efx->net_dev,
-				  "truncated design parameter %u\n",
-				  reader.type);
+			pci_err(efx->pci_dev,
+				"truncated design parameter %u\n",
+				reader.type);
 		rc = -EIO;
 	}
 out:

