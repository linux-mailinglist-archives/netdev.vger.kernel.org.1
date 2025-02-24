Return-Path: <netdev+bounces-169126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E583CA42A35
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 18:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAFB516BE72
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 17:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA22D264A86;
	Mon, 24 Feb 2025 17:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tY59wFdf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBACD263F3A;
	Mon, 24 Feb 2025 17:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419093; cv=fail; b=p0QMBoAAIE3bLdG0vGiMlvEI6qyhLvxV2lHhXJSaWGRjQWoIrXmNTOQyAOHySbbHbjLhTH1TIUzEymHPCvpUb3E1q8N8y9/Bj/6Pjvj78k68mwdG9G6TSQdGab+ccaJEfCZU1FxVIqYQ7KX0OHXYnoxQcKU+hYz686BqhImw7yQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419093; c=relaxed/simple;
	bh=YgEIc3IpXQRikw83X+Gpa6nrPZQK9W1l5rKCJ33Y0aw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PA0eOpmlipH3Fzq/Z+lLGTJSE8FFYb0nD6ZoEXZZGDbtM9Pw1JMO7IFBJZlbTE3qNvBsJvovKEzZ2IwCi/M+u63Eo3jEsZZ99AG6Rn/n1DTFVpWCjUD9TkRKKJpr1Cvo9NFxfa8ulGSjyH7lsInImhKxWAeHhw0XHkruXFyCTaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tY59wFdf; arc=fail smtp.client-ip=40.107.223.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ko8zGZFasWYafxzi7AxeUiSxnxucXXmZUndk4vhhi0vEP0iscEzOfowFri9UxyyivsYLhTltETUxo8OO7l1UZrNKQKQ6DIDAoWXCsU7yZeS+fP4ik2KpHIYB0N3lKecixb8yyTej+KZf9HI+wXxN7tpuiz/95HrTbzqkdMFUcD/EWMbgeFoCQORRqRM0uoYFvfYq+bSkKYRMaazM08pzyh0OcgjYuu+OGbp08oxTlAYYIaxMzTmmxPkBjW3kf9h5kELFJHuGaY0MPRSX4D/hS+uqLx9t9SlcgSFeFnIGQxPHAF7rynp8JQ7rjpZe6u9f52SmcIlhVil3QzZUpHNOig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxOUnxRy3HkuD2hcEEpoTfaXt/d2K9DzymZd10IbFlg=;
 b=VtF2tOirxr3Fve7ikx2HzM5nG4+NdLjLKYUSEQECQ1cOHPkdJm18mZqsPxrag9vSCoaN8hDPKwZFdhI4DaDI9PDbXm7KmBSorMj0rlsooXsGpOceE6asGzmcCEpTRNV/S/5bHEmVCjBmgFmvEgWV4gRdsYC7IPXtrUiNAcqbuHXLYK/sHThzrP8BVfzBjOqKoooKyjLhe06xcPbjxw2cHWYtUsPZLMoDNgVk6Zv4bWuqNTfNUfULjJZiv2VW4cuQGGRElLjp0ztqSj1G/ceL3mTX+XCPga/+OSi7nnJzXjVlfO8n9M+8QeqoT7Zk1anOH+DUQWchlC/i3ZTzItVQKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxOUnxRy3HkuD2hcEEpoTfaXt/d2K9DzymZd10IbFlg=;
 b=tY59wFdfGb/mbxvUr1VMoFD8D6ybzty1uZReji6+eho53jaln1ssZ7HuBk6uucPJfF3XZh/EDFiYD3oIIkU/E+bx7ytiqYGIkDZnXneVJYcl5khHqmfl49KR4POWqLY50Vnm6s3RxjRoXqgiQ0HLJvmJ5rJtQnI1gN68PuhBbU3wOSvVVCGu8NqB3jEi0mat1uSm7b5y/Yl7+8z18RXmMG9mi3EmFjtOJ66EeFKrt697QujSxWWGN+c5gjnWqSMorgrPgqvbQlbj6XK1HHD8wp/HxAEWwidBx3Eh8LHVBOxP1yyoF7eSzt/lEXLrSK7rqAqNuwU/uXI1wKYHAE1Jnw==
Received: from BL0PR0102CA0027.prod.exchangelabs.com (2603:10b6:207:18::40) by
 PH7PR12MB7940.namprd12.prod.outlook.com (2603:10b6:510:275::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Mon, 24 Feb
 2025 17:44:43 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:207:18:cafe::fc) by BL0PR0102CA0027.outlook.office365.com
 (2603:10b6:207:18::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Mon,
 24 Feb 2025 17:44:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.0 via Frontend Transport; Mon, 24 Feb 2025 17:44:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Feb
 2025 09:44:25 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Feb
 2025 09:44:25 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 24
 Feb 2025 09:44:21 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Tariq
 Toukan" <tariqt@nvidia.com>, Edward Cree <ecree.xilinx@gmail.com>, Ahmed Zaki
	<ahmed.zaki@intel.com>, <linux-doc@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net-next v5 1/4] ethtool: Symmetric OR-XOR RSS hash
Date: Mon, 24 Feb 2025 19:44:13 +0200
Message-ID: <20250224174416.499070-2-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250224174416.499070-1-gal@nvidia.com>
References: <20250224174416.499070-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|PH7PR12MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: 672d62d0-42af-43a7-3040-08dd54faeb90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b7cXcycC9LljpzDxO+NW2sNx5CWgWkaUdyRiI0QpPpnfkiSo/JYCgNHU7WxF?=
 =?us-ascii?Q?Bd6v1Tes+y7avgRPqHkT4J21bVAvdJsBZzZodDTUS/dCZbkBy2GO4pLQGlHM?=
 =?us-ascii?Q?lZxlUQCcoxbXkjuoeT314H50efoaXaqU30OFyG8apZsgC//mPI0ASUTmwbcU?=
 =?us-ascii?Q?8XCwxpHXlEe8jw75ODEhQnN1DytrzmM1PPFdYxW4c2RVFiOn8DFjYtLBUtCz?=
 =?us-ascii?Q?ghM5+Y6cgb2WZu/Rre77bMqYFXv7MDD/oFzg5QTzJezGXFCRbiPAUi2WPvbR?=
 =?us-ascii?Q?oIF2PtwP+QFFZQtomrcLcfAPe5Hrdkj05I2i4xdkCa3OQ/LSzz9nEXam82ml?=
 =?us-ascii?Q?HRLmK1SGMoa3V+nUDJZwsXaUmimYP8G7ejzcGMXlTXsks7BYZ0wXFcqav9lv?=
 =?us-ascii?Q?bZzTVsoRHaXUEAGzfhDHGY/7ocsPbpm8RdL1CYfAhp6Ipt/a2fZQGi6gw03G?=
 =?us-ascii?Q?53g71eRR8RIPytdclzfJQ5lNVkezzd02Kpz3nC2UvZcmwUWOSr/xyEMdyAHr?=
 =?us-ascii?Q?5sTlorTAKRJtADV4YXerSop95heLG1yEBVodBQ476TVp+Z1Q6qc8jnkcjEfg?=
 =?us-ascii?Q?UmJduaxlsXUz2nyzwa8qtYtnTvWx/W4779f+fMUn+KRwKSlHERDyS83QA2Fq?=
 =?us-ascii?Q?kGHb3B5y/8bL0NDZDAP+FARsCIKAXwN8jpp12ztL3TJubVmRat4RjaIIxRL5?=
 =?us-ascii?Q?dPbz35WlxCKfWbmDpyCjMy8t7Zk7kdeEbq03Pu6hSUmiVJmDb4fGD05GKgX9?=
 =?us-ascii?Q?mClOy8k2xtWCMu8E0R2w+pwDDbtji9Z/0l760uywuty1g3GAuY8AKA/slYlC?=
 =?us-ascii?Q?0Lm2IOQN7t1Z/D8WCvcWWL5SXY3TW2ZEjN7+tKixBDLMeXylChuaEuCrHz2q?=
 =?us-ascii?Q?rHChrT04oGXW4RL9magzGPv4ZNu1m6v/1RFjnh3BZYpAXSpc/9deuHg/L/oD?=
 =?us-ascii?Q?k0EJ0u/Xcs/zfc8fQSMA6HoLbhR5Kfs1O/Hw84fA8KDlz0MpFFWnVvN5Pjxv?=
 =?us-ascii?Q?vrKxi9ar3pR+cwvbXbIc/BjJiTohc5AQbrleoRpCOnNvK7kxFXLOsG77/Obw?=
 =?us-ascii?Q?NsoIi1yBEGx1/q8fechW2Ke3om4GkUl8TLZtWI0xuvIxc2K39iPLe31aVy4V?=
 =?us-ascii?Q?oGDC6NY5+Wcz2bAhOKa2h/rpAjnlv6erTdzfeRMjaIcSW/4Rug2sZLlHI+Cq?=
 =?us-ascii?Q?A5hXFUW7VZ2GpHC5wlMg3W+TcI1T0Iy4Z4KO2rIADBWqBTBPnRoHMmS49dol?=
 =?us-ascii?Q?IexguUuK2ylhvlnBXFUgubGcMvIf1n9WHnge+hmcz+tH/G7aTCdXiI/XWANp?=
 =?us-ascii?Q?P/7p0sbEylVX+WzlS1bvBtQmNcSOoyW4/ZR80EF2NvUdWKZUMYSMKxyWaV1K?=
 =?us-ascii?Q?xmHRy+FsgNHl4Y703OQJYMtNcuVB/UQu9lQBlXbbDEJER2pQQm1P7Tl0Ispe?=
 =?us-ascii?Q?uecZrtieNqzoxhJz1aPn7ZdMg5MpSsxpup6gkcSASC9+LOUCxZGKLySN/Dcl?=
 =?us-ascii?Q?SKUwe5tkFYpbDr8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 17:44:42.4943
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 672d62d0-42af-43a7-3040-08dd54faeb90
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7940

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
 Documentation/networking/scaling.rst           | 15 +++++++++++----
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c |  2 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c   |  2 +-
 include/linux/ethtool.h                        |  5 ++---
 include/uapi/linux/ethtool.h                   |  4 ++++
 net/ethtool/ioctl.c                            |  8 ++++----
 7 files changed, 24 insertions(+), 14 deletions(-)

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
index 4eb50bcb9d42..6984700cec6a 100644
--- a/Documentation/networking/scaling.rst
+++ b/Documentation/networking/scaling.rst
@@ -49,14 +49,21 @@ destination address) and TCP/UDP (source port, destination port) tuples
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
 
+The "Symmetric-OR-XOR" algorithm, on the other hand, transforms the input as
+follows::
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


