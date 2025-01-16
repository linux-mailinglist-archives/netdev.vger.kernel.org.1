Return-Path: <netdev+bounces-158960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 007C9A13F9A
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 17:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F651188D10E
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 16:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF9722CF2C;
	Thu, 16 Jan 2025 16:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rKAdNyN/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05D222CA0E
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 16:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737045571; cv=fail; b=gCAO0hgDn9v97brN7K/ZB513E3bNFT5tdoymH1QsFEXOYDmXfXf6VSsptffDa+9TtxRK4tJf89z+i5XV8L/b5yEKJUALhQ/vfegAXO5b/D79gbadueIbBCjyJVZLBxaekz2W3cTmAicO0/NJQu9GaSn618mzVJUPD+c0Kf9LHp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737045571; c=relaxed/simple;
	bh=YsE16EGs6nZBbual3ZfiB3w7M/J4y2lP3twJwzMpPfA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pwjrx0JIj+YM/zz8NiSpVCSGALirWthZIA26MMLhwivMFeMp8z4rlfxYgQOvlYIJ9HFDwPGXbN1U1/LR3rJkjncpLlOryds9NOf26A8dGdlr6zYDv+iucGtsGEWH7rs5ZntXJIEWtg/85BE1CDbwAu6UcXCey+6IBqsRfyBfzzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rKAdNyN/; arc=fail smtp.client-ip=40.107.223.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tjfkX0WZ+59EALWOJH4xQs6Lwn08YHKfPSzYIG1y+APE1lMdwJArRLQpxSrFjWqQNCMXh7vubINyExGqYUd+dRVIlyeq1YMsNWB/X6H/l0qFRi8GDC7kB7GxLpCNz1Otb+smQX89ZJ9aifNAItGxX19paTY6Z2iz+LDpwJ3IY8edmvtjdr4rPkq3fXDt7KB+lmFSqmxulX0FIiEVrxxi9A4aBzQqeBBF7K3XLCiZUjMyYzFO8cI2XN+pPpNiQUqRJtjwbXg+nlUE7fodaWIePk0/jzMxEAbvQTzPbEAgalbDaz+NPn6yVFv9VcSLB2dyyi7kWbmNksu1TM+3TPtsaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdRPFsoAQCXTfGjmZK3b2BhhLoleScSWL/h7EKMQRmA=;
 b=iMnm+QxJ6lOCeuKhqKo+O/7FakFIH42SGi71qdL1RrU47ZR5s5dqmAA/jge8Q5i3AW3WHKcOHdCo4M2Hl8tnA+ajGrgBfm2KSj6YsTBsOKI4C71Sr6Ndkrqur19vdAOAexgfeBOucvyKUwWNBAo39F+CIz4jIJGhiqCE6dli7hDybFRS0fmUY8WqC0RgMLblE0MiSu8YD0XMJiCeejsrIFOgsE8c8LCtlbwzak32GSweHyuVsPYd4vtbaFMoFw0zWOrdhl3zUEvt3gB6qI5XhO5Fe/UjUwBpZwt4jzt0fRe562/mmiOYczRBnnK7g+Lxhdk45Cifza0YG7jR9DNtlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdRPFsoAQCXTfGjmZK3b2BhhLoleScSWL/h7EKMQRmA=;
 b=rKAdNyN/5kDrX4ZFcxCNaoKcvEV0S0oQLKrEbDyYWZbl8/DZGlDFkFSUPtyP6paxT/0BXzApLjNdjIMQcV/MRtGjST+R/4L8fxnxYvExGu0K2GwRrxaX+zeph5yGcOj21Tio+4Osi8Z+A/Ozst1pRYb+pWZsWbAtecJCxEc5wT7iWqSWnW3Qpdmw3oIQ3hjC6XomC/l4sdPjh8YbU8wqQg2gX2fhIzWtP3gyO6VgqZMKY+8DoMxxczNESnNFs1r5GUQKPBlhYv7kiCn5ASn83ZhUvDuPVeWJjnc+kaDIKvoLLD/mGWhMk2d/5PlaanSmXXLNpKOdJ77bPmBl3eXjdw==
Received: from SN1PR12CA0083.namprd12.prod.outlook.com (2603:10b6:802:21::18)
 by MN2PR12MB4141.namprd12.prod.outlook.com (2603:10b6:208:1d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 16 Jan
 2025 16:39:26 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:802:21:cafe::47) by SN1PR12CA0083.outlook.office365.com
 (2603:10b6:802:21::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.14 via Frontend Transport; Thu,
 16 Jan 2025 16:39:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Thu, 16 Jan 2025 16:39:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 16 Jan
 2025 08:39:13 -0800
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 16 Jan
 2025 08:39:08 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Richard Cochran <richardcochran@gmail.com>, Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>
Subject: [PATCH net-next 3/5] mlxsw: Define Tx header fields in txheader.h
Date: Thu, 16 Jan 2025 17:38:16 +0100
Message-ID: <2250b5cb3998ab4850fc8251c3a0f5926d32e194.1737044384.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1737044384.git.petrm@nvidia.com>
References: <cover.1737044384.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|MN2PR12MB4141:EE_
X-MS-Office365-Filtering-Correlation-Id: 17ec0895-9cba-4a4f-cefa-08dd364c571a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8pXjOSuQnWrfZrlac2mS2CrKAtjoF4BSe+4UJx5shUzjBtwBltNx7AQK/2tz?=
 =?us-ascii?Q?8225L5b8kk+4gV1CKlQuIhvp1Na4zgq/eO82DN3lE3q8Srjr27IqyXTVklXW?=
 =?us-ascii?Q?FeVYcxiVHd/scNVoHsIauDFC6/kTMfetKiqk1h5QpuWPq7JtgGG3Wu8zXoCc?=
 =?us-ascii?Q?bHVQB3i6OMWs7oCb7ftYP7Erl4A0r0+Z8bH7ro9L+qc9oP9NnOToE7Cns8v3?=
 =?us-ascii?Q?a4Nkb3q6HS5DmwSB95wHzapJk1RV4RtIiBhztICmd68xESqTtmVyycgBKYbi?=
 =?us-ascii?Q?bUPi2BnjcuJ8/6/dkCsxmHqPIPmfYqFXpmgeg3ptS7udZQYNJa3/JVhS0Th3?=
 =?us-ascii?Q?aBUxA9yhOfzO6wW9GsaL/ahzOccje3LzxkU6G7Kq4YjGFHKWIcbID86bQQ2W?=
 =?us-ascii?Q?uIMlMubE0Uh/9k2zz2M9ppY1w0Tym7CTGUSg0/puJLHAGUtq2cgV2X2czBZS?=
 =?us-ascii?Q?SrW4SQsapLKPr1HVylph0yPQ3PXtaU8I9Tn6nWmWPBwbRUJqBAM848DN3Ecb?=
 =?us-ascii?Q?lTUMOYEQeHcLsTClWphMFk4Igetx/SYQy0Jz12GnzbsJJrqLsJxOgpBgNieA?=
 =?us-ascii?Q?5g7yxShIOnIHmx/j5Kz0YXG6xIK39rCZakJKbELB6Qg8c+dGJOiQEpubW2QV?=
 =?us-ascii?Q?2gdwFwRbofggAmXg5sGRejytGVWs1P5Z9P46zw5dhGHo5u2TWD3ap8nlFFY+?=
 =?us-ascii?Q?2hi3vEuWu9cUc8PNpjFFzcbWMC1a2drHiSOPh+yKsXAhbXL6A94lLLRDjEOZ?=
 =?us-ascii?Q?DZEhEn1mkFGZNz6EtV/S5CXa+oKzkRpy86B9P3V9vUBhnuFHj7VSIaF15Zx1?=
 =?us-ascii?Q?afd600TTxYkAmo7oy2dUnxtjoPFQPYHHDj2WDI60EwLU/wj10JzLdk/ePbW8?=
 =?us-ascii?Q?NvFcSB+S8gA1lx9kHZ5UNvE7K5QuyiL0PKO7hzHsPyESFEzmcKup775xuRYg?=
 =?us-ascii?Q?H/YMIFa08Edep+dOPSpfB08uOTA2efNHjOFCFvm4YcLSDJuS7i5vLPf/lKOR?=
 =?us-ascii?Q?y5g54RUTRdreLkOjbd/EnhS3HVSKLn6eVVW6xXjiFask4B3l3ojixGtYdazI?=
 =?us-ascii?Q?f3HSsBMMcChdrrHHPydQHsfxg4snyRtbhe/xIeNmXh/IZDSGpJNthsTBhoy3?=
 =?us-ascii?Q?DA35luLyr9fnw56uK/ezL4slIelR/h1hjEaOGAlbF3xpgnB9ijg9Q37Uyma9?=
 =?us-ascii?Q?/fS6nqWXujjnhRwQ8rvILtYVBnJGDCzdd2r1Z7/aMYmrxEwowwpQTavtiKoK?=
 =?us-ascii?Q?NQ1teiHcFXmgmGaAYAVNFxhxdV2Xi/rsi6JDcdX0BLGGAhMQ0IdJNSjoVKsg?=
 =?us-ascii?Q?PiGjHlDp95VrMwN2b/EtzPt9zd4C5YpQokr5bVRviuc3W6YIesP8A7hl9ERG?=
 =?us-ascii?Q?K4pkgDN2w8UZUs6leFRU6s163Ju0x/y3Qnvfz9Hrx5VUbda+ZfTICAUOWLBq?=
 =?us-ascii?Q?N3Z2jiRYejOLkiD7zIefIpIpWGuntMGuC2PTWUwi3zliYd5Dv8DObWp9yVLg?=
 =?us-ascii?Q?kuPin+3Ete9WMZY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 16:39:26.1705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ec0895-9cba-4a4f-cefa-08dd364c571a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4141

From: Amit Cohen <amcohen@nvidia.com>

The next patch will move Tx header constructing to pci.c. As preparation,
move the definitions of Tx header fields from spectrum.c to txheader.h,
so pci.c will include this header and can access the fields.

Remove 'etclass' which is not used.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 68 -------------------
 .../net/ethernet/mellanox/mlxsw/txheader.h    | 63 +++++++++++++++++
 2 files changed, 63 insertions(+), 68 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 061a3bb81c72..4e4d1d366d6c 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -107,74 +107,6 @@ static const unsigned char mlxsw_sp2_mac_mask[ETH_ALEN] = {
 	0xff, 0xff, 0xff, 0xff, 0xf0, 0x00
 };
 
-/* tx_hdr_version
- * Tx header version.
- * Must be set to 1.
- */
-MLXSW_ITEM32(tx, hdr, version, 0x00, 28, 4);
-
-/* tx_hdr_ctl
- * Packet control type.
- * 0 - Ethernet control (e.g. EMADs, LACP)
- * 1 - Ethernet data
- */
-MLXSW_ITEM32(tx, hdr, ctl, 0x00, 26, 2);
-
-/* tx_hdr_proto
- * Packet protocol type. Must be set to 1 (Ethernet).
- */
-MLXSW_ITEM32(tx, hdr, proto, 0x00, 21, 3);
-
-/* tx_hdr_rx_is_router
- * Packet is sent from the router. Valid for data packets only.
- */
-MLXSW_ITEM32(tx, hdr, rx_is_router, 0x00, 19, 1);
-
-/* tx_hdr_fid_valid
- * Indicates if the 'fid' field is valid and should be used for
- * forwarding lookup. Valid for data packets only.
- */
-MLXSW_ITEM32(tx, hdr, fid_valid, 0x00, 16, 1);
-
-/* tx_hdr_swid
- * Switch partition ID. Must be set to 0.
- */
-MLXSW_ITEM32(tx, hdr, swid, 0x00, 12, 3);
-
-/* tx_hdr_control_tclass
- * Indicates if the packet should use the control TClass and not one
- * of the data TClasses.
- */
-MLXSW_ITEM32(tx, hdr, control_tclass, 0x00, 6, 1);
-
-/* tx_hdr_etclass
- * Egress TClass to be used on the egress device on the egress port.
- */
-MLXSW_ITEM32(tx, hdr, etclass, 0x00, 0, 4);
-
-/* tx_hdr_port_mid
- * Destination local port for unicast packets.
- * Destination multicast ID for multicast packets.
- *
- * Control packets are directed to a specific egress port, while data
- * packets are transmitted through the CPU port (0) into the switch partition,
- * where forwarding rules are applied.
- */
-MLXSW_ITEM32(tx, hdr, port_mid, 0x04, 16, 16);
-
-/* tx_hdr_fid
- * Forwarding ID used for L2 forwarding lookup. Valid only if 'fid_valid' is
- * set, otherwise calculated based on the packet's VID using VID to FID mapping.
- * Valid for data packets only.
- */
-MLXSW_ITEM32(tx, hdr, fid, 0x08, 16, 16);
-
-/* tx_hdr_type
- * 0 - Data packets
- * 6 - Control packets
- */
-MLXSW_ITEM32(tx, hdr, type, 0x0C, 0, 4);
-
 int mlxsw_sp_flow_counter_get(struct mlxsw_sp *mlxsw_sp,
 			      unsigned int counter_index, bool clear,
 			      u64 *packets, u64 *bytes)
diff --git a/drivers/net/ethernet/mellanox/mlxsw/txheader.h b/drivers/net/ethernet/mellanox/mlxsw/txheader.h
index da51dd9d5e44..e78cba5821b6 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/txheader.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/txheader.h
@@ -4,6 +4,69 @@
 #ifndef _MLXSW_TXHEADER_H
 #define _MLXSW_TXHEADER_H
 
+/* tx_hdr_version
+ * Tx header version.
+ * Must be set to 1.
+ */
+MLXSW_ITEM32(tx, hdr, version, 0x00, 28, 4);
+
+/* tx_hdr_ctl
+ * Packet control type.
+ * 0 - Ethernet control (e.g. EMADs, LACP)
+ * 1 - Ethernet data
+ */
+MLXSW_ITEM32(tx, hdr, ctl, 0x00, 26, 2);
+
+/* tx_hdr_proto
+ * Packet protocol type. Must be set to 1 (Ethernet).
+ */
+MLXSW_ITEM32(tx, hdr, proto, 0x00, 21, 3);
+
+/* tx_hdr_rx_is_router
+ * Packet is sent from the router. Valid for data packets only.
+ */
+MLXSW_ITEM32(tx, hdr, rx_is_router, 0x00, 19, 1);
+
+/* tx_hdr_fid_valid
+ * Indicates if the 'fid' field is valid and should be used for
+ * forwarding lookup. Valid for data packets only.
+ */
+MLXSW_ITEM32(tx, hdr, fid_valid, 0x00, 16, 1);
+
+/* tx_hdr_swid
+ * Switch partition ID. Must be set to 0.
+ */
+MLXSW_ITEM32(tx, hdr, swid, 0x00, 12, 3);
+
+/* tx_hdr_control_tclass
+ * Indicates if the packet should use the control TClass and not one
+ * of the data TClasses.
+ */
+MLXSW_ITEM32(tx, hdr, control_tclass, 0x00, 6, 1);
+
+/* tx_hdr_port_mid
+ * Destination local port for unicast packets.
+ * Destination multicast ID for multicast packets.
+ *
+ * Control packets are directed to a specific egress port, while data
+ * packets are transmitted through the CPU port (0) into the switch partition,
+ * where forwarding rules are applied.
+ */
+MLXSW_ITEM32(tx, hdr, port_mid, 0x04, 16, 16);
+
+/* tx_hdr_fid
+ * Forwarding ID used for L2 forwarding lookup. Valid only if 'fid_valid' is
+ * set, otherwise calculated based on the packet's VID using VID to FID mapping.
+ * Valid for data packets only.
+ */
+MLXSW_ITEM32(tx, hdr, fid, 0x08, 16, 16);
+
+/* tx_hdr_type
+ * 0 - Data packets
+ * 6 - Control packets
+ */
+MLXSW_ITEM32(tx, hdr, type, 0x0C, 0, 4);
+
 #define MLXSW_TXHDR_LEN 0x10
 #define MLXSW_TXHDR_VERSION_0 0
 #define MLXSW_TXHDR_VERSION_1 1
-- 
2.47.0


