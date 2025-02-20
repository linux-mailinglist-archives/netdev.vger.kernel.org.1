Return-Path: <netdev+bounces-168114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D43A3D8DC
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 12:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 061BD175733
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 11:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B908C1F03E2;
	Thu, 20 Feb 2025 11:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YfibOgxm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A461F2B83;
	Thu, 20 Feb 2025 11:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740051318; cv=fail; b=PsrJJbmHSSyOB/bYqUXdV91juQP8ZrfU1aLjdIZKOLDQMFCmni2yV2/etz7xtJqEuACVk3rJO52f5sz730qDo9RrkXn63n6+FcD4FTglBBbtP8jDFRBTPEzGD41xwHXXKUhMzud1GcKv/pVmn0ijma1rcWkDfp59PkdmayIBfBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740051318; c=relaxed/simple;
	bh=I8Apxcw69Gtc0uI6hx7CUFAqg2SiGCLYt8jgjy/rqX8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U+X+yBJPi2rMqk9Yu+WyXBGnwiF1j+dHHsI1V/YtnDPpPLHhy0ZyuZE5apn8Jp61DoZmnn8hJJ/XiEWaZ+W6gcO8U5aU/IvB6Wmw41NKlmtAJf+oJ2K7G2voI6N2mJZs7FDhig+XCnF9neppzS9BLEmE7hs4VIoRl3irQZOT4BQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YfibOgxm; arc=fail smtp.client-ip=40.107.236.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zy6YkaZRy9ZN3XSF2GzUImgqdKxWyY8XbzgoyN4+V4qgEarHtfnFJYyHOxj65TMRkCz3MvL/7GjsLTo8FbdTnEYt4jSD29C315Xj50Ym8EtbzLf/iUucBM3JP8Iof4iQ8QjYT87+a1ZGs8elmViNTWXTeZr5+bzlgnNt7t+VYqOk2cuIejXEzAEfzsRrjnXWvFRBCtgf48/CdhKnLfw7QZxyeat+m3X69TeKoUTl6ZTcNXCRZFfW/GJy4aXCbHZHivy8MARI8gV7alQQAeHoKpsrirU4HZtiHSzQjXmFWR1zqeHVxjydVLHo8i+dMKCxDUTjFe25xXWzIdP8woyjwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBTFi+Fi8wT3ecbvsPQ2Fyns+ZWDDAzUUZBcHGXdFlY=;
 b=Zq5IeXIc1MPi4M9iOTF8daujJQ9EulvEcgjH3oBvfVGxJD5SS3PKfYr+FfqV6Rzn64e18fFyTga8hKM6DvEB0/5TYZIlTSyMcWhyO3jPpqhDWfqQRHG2O2JnHW4/jiJ/vE2L6VKEpPrVLqJVnDI57B/xSHFWQqUdxfQQ++NvJRMq2VbNiDU1YoaiyVBDmje8xjCwSauxmgEnil5c18EZRritkTHdOXNjhJnOvp1lS5xktm9qwbOtVGHkYVA1fNt7ITDdZrmeOJ1vNfUvXTGJB5fplR969sg0wTScAdNkN1f7fYEGL5ZpVjP9eS6xyVSq1vbpZ7cwcmdGm4NbKHaFBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBTFi+Fi8wT3ecbvsPQ2Fyns+ZWDDAzUUZBcHGXdFlY=;
 b=YfibOgxmjlvkL1IaDUS1lgKpTJmhJiGQK2ccsGxNm4xHRWWqd0k8+oiPSVKIZ3XnkuxvKDTETYWDt9/gCX+onAxBZBq8SljRmg5n5ZlQmXXYst0IO7W7gUdM3NSnUNQ+EuswuodDghQvspzY2/wxBmEwr6qcnCDfjiLTo/CmoFBxe9B8qzLlMSjcxxvbovX94t3rQJaUo+Ooe1yN0Hli2Dsl6JXw7MeyxDAFeHCeY/SdYo/L4SnMiEqHkEb1DolNmA9AGiWGUcCmK81QNuap164Dd+eOc8Txzi7DPhwUAKReRYHNieymbauuXnHdXr7IecqCGO/DNlpFD+O4oPfj4w==
Received: from MN2PR04CA0031.namprd04.prod.outlook.com (2603:10b6:208:d4::44)
 by DS0PR12MB8480.namprd12.prod.outlook.com (2603:10b6:8:159::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 11:35:12 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:208:d4:cafe::7d) by MN2PR04CA0031.outlook.office365.com
 (2603:10b6:208:d4::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 11:35:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.2 via Frontend Transport; Thu, 20 Feb 2025 11:35:11 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Feb
 2025 03:34:53 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 20 Feb
 2025 03:34:52 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 20
 Feb 2025 03:34:48 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Tariq
 Toukan" <tariqt@nvidia.com>, Edward Cree <ecree.xilinx@gmail.com>, Ahmed Zaki
	<ahmed.zaki@intel.com>, <linux-doc@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net-next v4 1/5] ethtool: Symmetric OR-XOR RSS hash
Date: Thu, 20 Feb 2025 13:34:31 +0200
Message-ID: <20250220113435.417487-2-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250220113435.417487-1-gal@nvidia.com>
References: <20250220113435.417487-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|DS0PR12MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a024396-66f1-478d-2aa9-08dd51a2a30c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XoRKNS0FgCIy1poV0FgkvG1+n7IBNQZCk5WX3kjX1IXpA+6LYBhZj/+0Ek7w?=
 =?us-ascii?Q?VfppZS/p5uAFEfLHdAlzincWn6NGuF4ING/EyTiIAgjbP1hZXnk5eiBACyyv?=
 =?us-ascii?Q?p3S43RsGr2VyQ9SF4eTWNpMLcGzH9JoLCURsF9mLcyA63XqQD9Ju2QphEtRC?=
 =?us-ascii?Q?t5BHCMVa+3JI5kNQFaQg5Sqgs4HaeXc+C0nwtUcQ9AlDjyDrqiB1mEdnsmVA?=
 =?us-ascii?Q?aP/oqvdpCazS6IWOqyB/FJiSum6yeZmmsL7ioANUtBZGh8YnBmUji1Y+RDKv?=
 =?us-ascii?Q?yL/LlFlPtCtkP1Qn1IZS8pSejSXfXaPWpN62px1TTWphJoG8Un+qiZcyH/sB?=
 =?us-ascii?Q?N1/2Z06QPaIXVqp2Tcz9b+skN4BeX96sijR2K/q3Lt8iac5PutjzN9BBA2jZ?=
 =?us-ascii?Q?O/2HNVlvHEIkVx1YWLA9NXEdzT3IwsBrlu1ezO0/96hDFyHX/8GVt1946MQk?=
 =?us-ascii?Q?ox6m7il3NAqkEojmw1ey9E/Yh2OlYVkMvY/5X2Rn9vsLKQsiVvxJLubjPP9w?=
 =?us-ascii?Q?uldumnAEQxYdrQAcJzani2v4pFiMXwtsvGhLvFA7XUwnd0e927aEmZxh2U7P?=
 =?us-ascii?Q?RUdcSemU+emV4TdE4M7ujZGOrZkhSbe01Q7EHrux+dIs3/rVW+aPSRGA9bnW?=
 =?us-ascii?Q?cXKuVe+mhOH4yZop+LDBLST98RTc8s49AjLZDtzmgztxi3bYphMdxVjlerQ+?=
 =?us-ascii?Q?uP/Mv0NotRvq5hQH1jaHjGU8lch1oOD+Ky2gU7XErCua9iXYXJ4pWCGNmgQE?=
 =?us-ascii?Q?yP4MUon3cAs/U39kA5zm8PmuRmZYkS6D8csHa4M/rF92DuT+COBbvsNNLpBB?=
 =?us-ascii?Q?S31vqc+vcXWQVWcBgtE2xohZdgvIPS9X4Sy2G6gFXWIvkC5h7jK4up2maDvB?=
 =?us-ascii?Q?88J1eoGn4tYQONv5JGqvDuMGHzqGedpZYRZZKzFsAikl2t/isH5ETZ6iXWip?=
 =?us-ascii?Q?3TIaENZum+1H7MnqN7gUv+X96+KyivxVfmfn78l+cGBiHgweERNZT80jZ9vv?=
 =?us-ascii?Q?6kOeJdURvSmwOpKHJf81G5wYwgLTSkqh9DQWGN+RX6NzjqYCu+18pL41RWMI?=
 =?us-ascii?Q?oyq9BoSkXN/qUt8+DJG5QBJ6GH9BxTNyeve/KY8f7vsE+/6m8ovLzowOsnyY?=
 =?us-ascii?Q?XJjMUX78ZO5uKlTKsCK10IvnU8ih6agzIiN68cFLBTu97NDvKcEXWKZLsb/n?=
 =?us-ascii?Q?N7mIWCZ1o181EzmSVIgM8AGiVOyC+LQEC/NqeiaN3EWVFFS67HpTcjIrzECM?=
 =?us-ascii?Q?oMn4VxBtybZNqf1py5HdY4ceoaQDIH/b7kZiu7sGbKgbDFOn69g/+zpPOcM7?=
 =?us-ascii?Q?koPRohgR7O0ST3Bpp5QAw2M72k92ZuqGlGxfrF7liRt3TSVWomkgB0K8elgR?=
 =?us-ascii?Q?9sexZoP0dtUNDOc/xj5fURQ2Nj+roBeJ+EZ+tCF9NABOeqUABsDwRmy7Jirf?=
 =?us-ascii?Q?4CuBTNYJWvu+JBPPnIg8/V9uuszbdlQrZi6Lkm3TAJy1bLJCc2rdSIUjno9F?=
 =?us-ascii?Q?UUTuXmnz4639C5U=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 11:35:11.6013
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a024396-66f1-478d-2aa9-08dd51a2a30c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8480

Add an additional type of symmetric RSS hash type: OR-XOR.
The "Symmetric-OR-XOR" algorithm transforms the input as follows:

(SRC_IP | DST_IP, SRC_IP ^ DST_IP, SRC_PORT | DST_PORT, SRC_PORT ^ DST_PORT)

Change 'cap_rss_sym_xor_supported' to 'supported_input_xfrm', a bitmap
of supported RXH_XFRM_* types.

Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>
---
 Documentation/networking/ethtool-netlink.rst   |  2 +-
 Documentation/networking/scaling.rst           | 14 ++++++++++----
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c |  2 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c   |  2 +-
 include/linux/ethtool.h                        |  5 ++---
 include/uapi/linux/ethtool.h                   |  4 ++++
 net/ethtool/ioctl.c                            |  8 ++++----
 7 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 3770a2294509..b6e9af4d0f1b 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1934,7 +1934,7 @@ ETHTOOL_A_RSS_INDIR attribute returns RSS indirection table where each byte
 indicates queue number.
 ETHTOOL_A_RSS_INPUT_XFRM attribute is a bitmap indicating the type of
 transformation applied to the input protocol fields before given to the RSS
-hfunc. Current supported option is symmetric-xor.
+hfunc. Current supported options are symmetric-xor and symmetric-or-xor.
 
 PLCA_GET_CFG
 ============
diff --git a/Documentation/networking/scaling.rst b/Documentation/networking/scaling.rst
index 4eb50bcb9d42..d8971ce07628 100644
--- a/Documentation/networking/scaling.rst
+++ b/Documentation/networking/scaling.rst
@@ -49,14 +49,20 @@ destination address) and TCP/UDP (source port, destination port) tuples
 are swapped, the computed hash is the same. This is beneficial in some
 applications that monitor TCP/IP flows (IDS, firewalls, ...etc) and need
 both directions of the flow to land on the same Rx queue (and CPU). The
-"Symmetric-XOR" is a type of RSS algorithms that achieves this hash
-symmetry by XORing the input source and destination fields of the IP
-and/or L4 protocols. This, however, results in reduced input entropy and
-could potentially be exploited. Specifically, the algorithm XORs the input
+"Symmetric-XOR" and "Symmetric-OR-XOR" are types of RSS algorithms that
+achieve this hash symmetry by XOR/ORing the input source and destination
+fields of the IP and/or L4 protocols. This, however, results in reduced
+input entropy and could potentially be exploited.
+
+Specifically, the "Symmetric-XOR" algorithm XORs the input
 as follows::
 
     # (SRC_IP ^ DST_IP, SRC_IP ^ DST_IP, SRC_PORT ^ DST_PORT, SRC_PORT ^ DST_PORT)
 
+The "Symmetric-OR-XOR" algorithm transforms the input as follows::
+
+    # (SRC_IP | DST_IP, SRC_IP ^ DST_IP, SRC_PORT | DST_PORT, SRC_PORT ^ DST_PORT)
+
 The result is then fed to the underlying RSS algorithm.
 
 Some advanced NICs allow steering packets to queues based on
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 74a1e9fe1821..288bb5b2e72e 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -1808,7 +1808,7 @@ static int iavf_set_rxfh(struct net_device *netdev,
 static const struct ethtool_ops iavf_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE,
-	.cap_rss_sym_xor_supported = true,
+	.supported_input_xfrm	= RXH_XFRM_SYM_XOR,
 	.get_drvinfo		= iavf_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
 	.get_ringparam		= iavf_get_ringparam,
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index b0805704834d..7c2dc347e4e5 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -4770,7 +4770,7 @@ static const struct ethtool_ops ice_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE |
 				     ETHTOOL_COALESCE_RX_USECS_HIGH,
-	.cap_rss_sym_xor_supported = true,
+	.supported_input_xfrm	= RXH_XFRM_SYM_XOR,
 	.rxfh_per_ctx_key	= true,
 	.get_link_ksettings	= ice_get_link_ksettings,
 	.set_link_ksettings	= ice_set_link_ksettings,
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 870994cc3ef7..7f222dccc7d1 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -763,13 +763,12 @@ struct kernel_ethtool_ts_info {
 
 /**
  * struct ethtool_ops - optional netdev operations
+ * @supported_input_xfrm: supported types of input xfrm from %RXH_XFRM_*.
  * @cap_link_lanes_supported: indicates if the driver supports lanes
  *	parameter.
  * @cap_rss_ctx_supported: indicates if the driver supports RSS
  *	contexts via legacy API, drivers implementing @create_rxfh_context
  *	do not have to set this bit.
- * @cap_rss_sym_xor_supported: indicates if the driver supports symmetric-xor
- *	RSS.
  * @rxfh_per_ctx_key: device supports setting different RSS key for each
  *	additional context. Netlink API should report hfunc, key, and input_xfrm
  *	for every context, not just context 0.
@@ -995,9 +994,9 @@ struct kernel_ethtool_ts_info {
  * of the generic netdev features interface.
  */
 struct ethtool_ops {
+	u32     supported_input_xfrm:8;
 	u32     cap_link_lanes_supported:1;
 	u32     cap_rss_ctx_supported:1;
-	u32	cap_rss_sym_xor_supported:1;
 	u32	rxfh_per_ctx_key:1;
 	u32	cap_rss_rxnfc_adds:1;
 	u32	rxfh_indir_space;
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 2feba0929a8a..84833cca29fe 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -2289,6 +2289,10 @@ static inline int ethtool_validate_duplex(__u8 duplex)
  * be exploited to reduce the RSS queue spread.
  */
 #define	RXH_XFRM_SYM_XOR	(1 << 0)
+/* Similar to SYM_XOR, except that one copy of the XOR'ed fields is replaced by
+ * an OR of the same fields
+ */
+#define	RXH_XFRM_SYM_OR_XOR	(1 << 1)
 #define	RXH_XFRM_NO_CHANGE	0xff
 
 /* L2-L4 network traffic flow types */
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 271c7cef9ef3..77d714874eca 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1011,11 +1011,11 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
 		if (rc)
 			return rc;
 
-		/* Sanity check: if symmetric-xor is set, then:
+		/* Sanity check: if symmetric-xor/symmetric-or-xor is set, then:
 		 * 1 - no other fields besides IP src/dst and/or L4 src/dst
 		 * 2 - If src is set, dst must also be set
 		 */
-		if ((rxfh.input_xfrm & RXH_XFRM_SYM_XOR) &&
+		if ((rxfh.input_xfrm & (RXH_XFRM_SYM_XOR | RXH_XFRM_SYM_OR_XOR)) &&
 		    ((info.data & ~(RXH_IP_SRC | RXH_IP_DST |
 				    RXH_L4_B_0_1 | RXH_L4_B_2_3)) ||
 		     (!!(info.data & RXH_IP_SRC) ^ !!(info.data & RXH_IP_DST)) ||
@@ -1388,11 +1388,11 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		return -EOPNOTSUPP;
 	/* Check input data transformation capabilities */
 	if (rxfh.input_xfrm && rxfh.input_xfrm != RXH_XFRM_SYM_XOR &&
+	    rxfh.input_xfrm != RXH_XFRM_SYM_OR_XOR &&
 	    rxfh.input_xfrm != RXH_XFRM_NO_CHANGE)
 		return -EINVAL;
 	if (rxfh.input_xfrm != RXH_XFRM_NO_CHANGE &&
-	    (rxfh.input_xfrm & RXH_XFRM_SYM_XOR) &&
-	    !ops->cap_rss_sym_xor_supported)
+	    rxfh.input_xfrm & ~ops->supported_input_xfrm)
 		return -EOPNOTSUPP;
 	create = rxfh.rss_context == ETH_RXFH_CONTEXT_ALLOC;
 
-- 
2.40.1


