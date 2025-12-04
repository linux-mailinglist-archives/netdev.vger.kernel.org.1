Return-Path: <netdev+bounces-243506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 993E3CA2BD6
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 09:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77ECF304E51E
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 08:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AB3325739;
	Thu,  4 Dec 2025 08:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S42a9EKj"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013051.outbound.protection.outlook.com [40.93.201.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651AA32470E
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 08:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764835302; cv=fail; b=DQtFo94V8pnuleT+cJOt5LRGyrrWIi7Fg3qfRrF1hH/V6J5YT0ThiCZ9XyUakUTBL2XCK9P3QhbCtGQsOamCOubrAiLcLQ8FjPINIGX6G8Het53GRGtVn/YtzgX7lnqnLso2XRIaFxRDXV5atlNlMmh/ccERl4529QXXWQhC5yY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764835302; c=relaxed/simple;
	bh=kjY6208Wyrh8BOyIZnrF91vDIBPYHWTErXr/fXMtGNw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZFMA7Ty6xgSXuRQdKixiunFmuA3dBl7/QM9n/k9nzcyrK+9YKvaFraPXFdXzV9Zjxu1JGGP/FmPPSvyAOPNm8Lov8BSdRRiwmU4dIiH0OLEsqZu4t/X36kEnD1c934Rf+Le39IlCTk8MR8eU4zoIvaQ8NCl0U/3vMRX2+DFccp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S42a9EKj; arc=fail smtp.client-ip=40.93.201.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QzI8FJURlbhzX474FHVx1nFIX4z2Yp1unwVNB7zgG2eEt71znIc+GgoBqyR3ZnN1KEZBx6jnjJ8YaR9tDm/jVWJXmrZP1NX0V2KRHJoG9O7k1nQWqVVW6wCHkKR/FxNG2f4Ze5X6ij3lK4mSn1Jn0nmfwKXocQQBOc9ul1bufc5n07kfpy54fxwuVs5j7voWj7mTl1qvaPGhhkditTUFBAV1UbgPjvk8qHSGvrJf2RPL0Jb4sC10a7nbs3RFmbhyQPBYActLmm3074CicmUmgE5Ybfn5Q3t4ak+BNNXlt+o1uHz8A6RfUevjjoXlAPbXq47v1jQUHKhLS8q+1ExvFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMbgZb2ZOivV86voEHaHj+Pdg5sh5S4W+XYYIGTqZBc=;
 b=CBeGKkTvNCIde63pEXksnxYkjBFtjezcoCmk8IrEkMuzAvKw5Z/k3GtCkzrzsJ7t5JARSY5f/t7FvKTAw+/vmYxXWBSTBkgtyAz8Sv3DV2ySjY5IEsIKNrPmIYH+RQMqVf6N9myZOtMqNhKSbnGkl+UxGWp5b4YnLUwrV/HsBz6huPp0xeZ6V3LKiRukNP/zPgEWwt5iEloZcH/Tov4FKRJus8dvseKwWLewUgVRsaR0uclxJEJVJrxOVtWPAQ5cprd4vGdTyFL3M2KgklODf3AyZpmdNWAJAz77K0uhTCGPNbrL1J990mMTHjQKNXMwoSdV6vjKa2eWcAUCy4B/RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=suse.cz smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMbgZb2ZOivV86voEHaHj+Pdg5sh5S4W+XYYIGTqZBc=;
 b=S42a9EKj+Bipvhy4VxA0HbcMs6wJtknZrHpAQnUDC/mre6I5G/Ra5SmN4Zvu7qBUfncOVqKTW9aqNp/y1hwfLFCNIxr4EoiHwlUaoezG0wzt5kx2HPmjZntXhhvunYq4IL+K4A8GWYna3DBCSfBpxLoakEa+nOdlfl8RhMeI2DROr/UW4qEWVBdUQtSagBfwJymsOXE0LdXotBp3Yd7Ho5jk20tVyGkgyoLkTarOSadSI+LPBb9wiEe+UdZdwHj6ABwpG7skxvTUfEoK75ej0SC65kPCJ1gUQWA5DWO/A9IuBbYa10vFDm0w8aa1iTlLme9i0vL2U0hRgbV8sKsqhQ==
Received: from BYAPR02CA0012.namprd02.prod.outlook.com (2603:10b6:a02:ee::25)
 by SN7PR12MB8433.namprd12.prod.outlook.com (2603:10b6:806:2e5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 08:01:24 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a02:ee:cafe::1b) by BYAPR02CA0012.outlook.office365.com
 (2603:10b6:a02:ee::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Thu, 4
 Dec 2025 08:01:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Thu, 4 Dec 2025 08:01:23 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 00:01:02 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 00:01:02 -0800
Received: from fedora.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 4 Dec 2025 00:01:00 -0800
From: Carolina Jubran <cjubran@nvidia.com>
To: Michal Kubecek <mkubecek@suse.cz>, "John W . Linville"
	<linville@tuxdriver.com>
CC: <netdev@vger.kernel.org>, Yael Chemla <ychemla@nvidia.com>, "Carolina
 Jubran" <cjubran@nvidia.com>
Subject: [PATCH ethtool 1/2] update UAPI header copies
Date: Thu, 4 Dec 2025 09:59:29 +0200
Message-ID: <20251204075930.979564-2-cjubran@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20251204075930.979564-1-cjubran@nvidia.com>
References: <20251204075930.979564-1-cjubran@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|SN7PR12MB8433:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f0dc7c3-853a-4246-59dc-08de330b5147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yKpN6v9dbMyTRwZHMMyCl4V2R1BH8Hou0wTeMVxuBLnc84ghSNS8Z6vS4pP3?=
 =?us-ascii?Q?MopN71FLs2vvnp+/pNACm6XwaGVH2meWNL3WzP1SKW43+iorlbGziA5QBoEi?=
 =?us-ascii?Q?CKgw2+t3nmnoYu31430xZY4j8LmLMz5Uoq98g3xT8NnTgpWm6VNgKBGFTGSo?=
 =?us-ascii?Q?SiWEJzBColdH50HUOp25zsV1RcIqo62eZBpa2eKENGTWE+f03OkYc0eA95QG?=
 =?us-ascii?Q?oJvXjrcGIzRc7fKqO1919tT+SpxgA43185N8X4evUCGCObcSgc0qEMBHzCET?=
 =?us-ascii?Q?QKyrAe2d5BiV5MVX5jsxs38VS65ijOTxOuY9+Op29N/OhZlF4atTLRS8urdK?=
 =?us-ascii?Q?5nGtSWSj9/PzwI0/wdxlhQrSQaQ6jfR+ywoSB+CjXwUMQwa8FGuf9eQNILpK?=
 =?us-ascii?Q?3dzRCXhT0yd1tjfGjJZ3+Qy8TjmP+lEcZEXhlm/QGgyg0zxWl9V9GUe+ZUbs?=
 =?us-ascii?Q?TeSr8LQg9+lQzurw6jT//bryGl7tNsLoFuXsihVGkRH5FDhdN+5k5zdex6mK?=
 =?us-ascii?Q?RIzNzp9wnxGJ4RxoZyexDPVyhgRrCzIwD0Xj7bved6jmi1rg7d4CPR39MFK+?=
 =?us-ascii?Q?JnzTVXKna/499096JRJfofOe5ql4cAcieZnodaYp9NL1ifcjAta3pSrXIQmH?=
 =?us-ascii?Q?pW1ZEC+/L0j8JzppqktbQWUMxxb/Lxh49BjKIZYFsqutPBFE0wI/ybDHqvPz?=
 =?us-ascii?Q?PoAxLoyGtu3nckxTQ5okVf/Uu1SMaSlKNqYZJzTG0jBHLi/Whzay6jgduycT?=
 =?us-ascii?Q?d54H92N7jYGVEYWsNvC7CCafNeFfb/Mq5eKrmVc6DiQFU2nu6jfwfOuzbEZa?=
 =?us-ascii?Q?DDcldnnc4LXGO2A8xK9mFxGqe/CsHiR2chG/tf37x8/aMZIkEJS8p6p8JTHS?=
 =?us-ascii?Q?0s8jyf+T0lLrN18liJMSCZ1ra8b0sIzDtSoDXgpiP1cLBoJSmRI7X3nURkD5?=
 =?us-ascii?Q?ybsCeViJaG1aX4BiZkgYHoogYwH12itQoMJgI7PLXlT039MTSwfvsB1hc7W/?=
 =?us-ascii?Q?TTeGu2Rt0N/fwN13bpDZPUpNPedD5ZZf8g5EYBvtKpG7tNhsm8pjOTxuelRz?=
 =?us-ascii?Q?fbO6CJ7HsPCPbvWZNvqPmVJ6KvmmARrVj4dv+XO467EQhcW3OW0ZtdxEmxzX?=
 =?us-ascii?Q?/oMBUCjxldta8ROpyk7dJYNXXDNvKfwxTMtlhAKKotDDuuKJZhRbenlZKveI?=
 =?us-ascii?Q?vca05v4UUpj+j3NaOihBmHOow87oAoyyo9nDoKhCTSoLkvIe4FmKHm+A3kUp?=
 =?us-ascii?Q?2bPxxbjI5dydItZ53xjKYS16qWHm+OVtJ/ixaFXtcpYrGFNT4HmUffL8kbos?=
 =?us-ascii?Q?156svo2ATc0fZbc+euSKCxuuoh9rty/pK4cdPVzF5mzNFZqb66tIWkwQakY5?=
 =?us-ascii?Q?keeGC97ktDKCLCgW9GyoAm1c9bMEP185zLt6gOr0NnFDlyYEpI1ib65joQ0P?=
 =?us-ascii?Q?XrNvjO5ISdBEAVl0h11bLrrIxr7g+5UHDdHR4HeRicTwr+l1VPO9sRrz7NNx?=
 =?us-ascii?Q?elD23zrs+EPsLH9sfTI1tUr0XwZQW71HrqsoApVn2TeuTuHujx2+mM5q0xB3?=
 =?us-ascii?Q?HZuo8OqO+FgkGQtQ7as=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 08:01:23.3702
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0dc7c3-853a-4246-59dc-08de330b5147
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8433

From: Yael Chemla <ychemla@nvidia.com>

Update to kernel commit 491c5dc98b84.

Signed-off-by: Yael Chemla <ychemla@nvidia.com>
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
---
 uapi/linux/ethtool.h                   |  6 ++++
 uapi/linux/ethtool_netlink_generated.h | 47 ++++++++++++++++++++++++++
 uapi/linux/if_ether.h                  |  2 ++
 uapi/linux/if_link.h                   |  3 ++
 uapi/linux/stddef.h                    |  1 -
 5 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/uapi/linux/ethtool.h b/uapi/linux/ethtool.h
index 4a4b77b..046eb22 100644
--- a/uapi/linux/ethtool.h
+++ b/uapi/linux/ethtool.h
@@ -2075,6 +2075,10 @@ enum ethtool_link_mode_bit_indices {
 	ETHTOOL_LINK_MODE_800000baseDR4_2_Full_BIT	 = 118,
 	ETHTOOL_LINK_MODE_800000baseSR4_Full_BIT	 = 119,
 	ETHTOOL_LINK_MODE_800000baseVR4_Full_BIT	 = 120,
+	ETHTOOL_LINK_MODE_1600000baseCR8_Full_BIT	 = 121,
+	ETHTOOL_LINK_MODE_1600000baseKR8_Full_BIT	 = 122,
+	ETHTOOL_LINK_MODE_1600000baseDR8_Full_BIT	 = 123,
+	ETHTOOL_LINK_MODE_1600000baseDR8_2_Full_BIT	 = 124,
 
 	/* must be last entry */
 	__ETHTOOL_LINK_MODE_MASK_NBITS
@@ -2188,6 +2192,7 @@ enum ethtool_link_mode_bit_indices {
 #define SPEED_200000		200000
 #define SPEED_400000		400000
 #define SPEED_800000		800000
+#define SPEED_1600000		1600000
 
 #define SPEED_UNKNOWN		-1
 
@@ -2378,6 +2383,7 @@ enum {
 #define	RXH_L4_B_0_1	(1 << 6) /* src port in case of TCP/UDP/SCTP */
 #define	RXH_L4_B_2_3	(1 << 7) /* dst port in case of TCP/UDP/SCTP */
 #define	RXH_GTP_TEID	(1 << 8) /* teid in case of GTP */
+#define	RXH_IP6_FL	(1 << 9) /* IPv6 flow label */
 #define	RXH_DISCARD	(1 << 31)
 
 #define	RX_CLS_FLOW_DISC	0xffffffffffffffffULL
diff --git a/uapi/linux/ethtool_netlink_generated.h b/uapi/linux/ethtool_netlink_generated.h
index 98d12b0..4a84b21 100644
--- a/uapi/linux/ethtool_netlink_generated.h
+++ b/uapi/linux/ethtool_netlink_generated.h
@@ -561,12 +561,24 @@ enum {
 	ETHTOOL_A_TUNNEL_INFO_MAX = (__ETHTOOL_A_TUNNEL_INFO_CNT - 1)
 };
 
+enum {
+	ETHTOOL_A_FEC_HIST_PAD = 1,
+	ETHTOOL_A_FEC_HIST_BIN_LOW,
+	ETHTOOL_A_FEC_HIST_BIN_HIGH,
+	ETHTOOL_A_FEC_HIST_BIN_VAL,
+	ETHTOOL_A_FEC_HIST_BIN_VAL_PER_LANE,
+
+	__ETHTOOL_A_FEC_HIST_CNT,
+	ETHTOOL_A_FEC_HIST_MAX = (__ETHTOOL_A_FEC_HIST_CNT - 1)
+};
+
 enum {
 	ETHTOOL_A_FEC_STAT_UNSPEC,
 	ETHTOOL_A_FEC_STAT_PAD,
 	ETHTOOL_A_FEC_STAT_CORRECTED,
 	ETHTOOL_A_FEC_STAT_UNCORR,
 	ETHTOOL_A_FEC_STAT_CORR_BITS,
+	ETHTOOL_A_FEC_STAT_HIST,
 
 	__ETHTOOL_A_FEC_STAT_CNT,
 	ETHTOOL_A_FEC_STAT_MAX = (__ETHTOOL_A_FEC_STAT_CNT - 1)
@@ -791,6 +803,39 @@ enum {
 	ETHTOOL_A_PSE_NTF_MAX = (__ETHTOOL_A_PSE_NTF_CNT - 1)
 };
 
+enum {
+	ETHTOOL_A_MSE_CAPABILITIES_MAX_AVERAGE_MSE = 1,
+	ETHTOOL_A_MSE_CAPABILITIES_MAX_PEAK_MSE,
+	ETHTOOL_A_MSE_CAPABILITIES_REFRESH_RATE_PS,
+	ETHTOOL_A_MSE_CAPABILITIES_NUM_SYMBOLS,
+
+	__ETHTOOL_A_MSE_CAPABILITIES_CNT,
+	ETHTOOL_A_MSE_CAPABILITIES_MAX = (__ETHTOOL_A_MSE_CAPABILITIES_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_MSE_SNAPSHOT_AVERAGE_MSE = 1,
+	ETHTOOL_A_MSE_SNAPSHOT_PEAK_MSE,
+	ETHTOOL_A_MSE_SNAPSHOT_WORST_PEAK_MSE,
+
+	__ETHTOOL_A_MSE_SNAPSHOT_CNT,
+	ETHTOOL_A_MSE_SNAPSHOT_MAX = (__ETHTOOL_A_MSE_SNAPSHOT_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_MSE_HEADER = 1,
+	ETHTOOL_A_MSE_CAPABILITIES,
+	ETHTOOL_A_MSE_CHANNEL_A,
+	ETHTOOL_A_MSE_CHANNEL_B,
+	ETHTOOL_A_MSE_CHANNEL_C,
+	ETHTOOL_A_MSE_CHANNEL_D,
+	ETHTOOL_A_MSE_WORST_CHANNEL,
+	ETHTOOL_A_MSE_LINK,
+
+	__ETHTOOL_A_MSE_CNT,
+	ETHTOOL_A_MSE_MAX = (__ETHTOOL_A_MSE_CNT - 1)
+};
+
 enum {
 	ETHTOOL_MSG_USER_NONE = 0,
 	ETHTOOL_MSG_STRSET_GET = 1,
@@ -843,6 +888,7 @@ enum {
 	ETHTOOL_MSG_RSS_SET,
 	ETHTOOL_MSG_RSS_CREATE_ACT,
 	ETHTOOL_MSG_RSS_DELETE_ACT,
+	ETHTOOL_MSG_MSE_GET,
 
 	__ETHTOOL_MSG_USER_CNT,
 	ETHTOOL_MSG_USER_MAX = (__ETHTOOL_MSG_USER_CNT - 1)
@@ -903,6 +949,7 @@ enum {
 	ETHTOOL_MSG_RSS_CREATE_ACT_REPLY,
 	ETHTOOL_MSG_RSS_CREATE_NTF,
 	ETHTOOL_MSG_RSS_DELETE_NTF,
+	ETHTOOL_MSG_MSE_GET_REPLY,
 
 	__ETHTOOL_MSG_KERNEL_CNT,
 	ETHTOOL_MSG_KERNEL_MAX = (__ETHTOOL_MSG_KERNEL_CNT - 1)
diff --git a/uapi/linux/if_ether.h b/uapi/linux/if_ether.h
index a1aff8e..2c0ca40 100644
--- a/uapi/linux/if_ether.h
+++ b/uapi/linux/if_ether.h
@@ -92,6 +92,7 @@
 #define ETH_P_ETHERCAT	0x88A4		/* EtherCAT			*/
 #define ETH_P_8021AD	0x88A8          /* 802.1ad Service VLAN		*/
 #define ETH_P_802_EX1	0x88B5		/* 802.1 Local Experimental 1.  */
+#define ETH_P_MXLGSW	0x88C3		/* MaxLinear GSW DSA [ NOT AN OFFICIALLY REGISTERED ID ] */
 #define ETH_P_PREAUTH	0x88C7		/* 802.11 Preauthentication */
 #define ETH_P_TIPC	0x88CA		/* TIPC 			*/
 #define ETH_P_LLDP	0x88CC		/* Link Layer Discovery Protocol */
@@ -114,6 +115,7 @@
 #define ETH_P_QINQ1	0x9100		/* deprecated QinQ VLAN [ NOT AN OFFICIALLY REGISTERED ID ] */
 #define ETH_P_QINQ2	0x9200		/* deprecated QinQ VLAN [ NOT AN OFFICIALLY REGISTERED ID ] */
 #define ETH_P_QINQ3	0x9300		/* deprecated QinQ VLAN [ NOT AN OFFICIALLY REGISTERED ID ] */
+#define ETH_P_YT921X	0x9988		/* Motorcomm YT921x DSA [ NOT AN OFFICIALLY REGISTERED ID ] */
 #define ETH_P_EDSA	0xDADA		/* Ethertype DSA [ NOT AN OFFICIALLY REGISTERED ID ] */
 #define ETH_P_DSA_8021Q	0xDADB		/* Fake VLAN Header for DSA [ NOT AN OFFICIALLY REGISTERED ID ] */
 #define ETH_P_DSA_A5PSW	0xE001		/* A5PSW Tag Value [ NOT AN OFFICIALLY REGISTERED ID ] */
diff --git a/uapi/linux/if_link.h b/uapi/linux/if_link.h
index b450757..d05f5cc 100644
--- a/uapi/linux/if_link.h
+++ b/uapi/linux/if_link.h
@@ -379,6 +379,8 @@ enum {
 	IFLA_DPLL_PIN,
 	IFLA_MAX_PACING_OFFLOAD_HORIZON,
 	IFLA_NETNS_IMMUTABLE,
+	IFLA_HEADROOM,
+	IFLA_TAILROOM,
 	__IFLA_MAX
 };
 
@@ -1562,6 +1564,7 @@ enum {
 	IFLA_BOND_SLAVE_AD_ACTOR_OPER_PORT_STATE,
 	IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE,
 	IFLA_BOND_SLAVE_PRIO,
+	IFLA_BOND_SLAVE_ACTOR_PORT_PRIO,
 	__IFLA_BOND_SLAVE_MAX,
 };
 
diff --git a/uapi/linux/stddef.h b/uapi/linux/stddef.h
index e1fcfcf..48ee443 100644
--- a/uapi/linux/stddef.h
+++ b/uapi/linux/stddef.h
@@ -3,7 +3,6 @@
 #define _LINUX_STDDEF_H
 
 
-
 #ifndef __always_inline
 #define __always_inline __inline__
 #endif
-- 
2.38.1


