Return-Path: <netdev+bounces-166817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1C9A37686
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 19:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D240816D7A1
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 18:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA8B19D890;
	Sun, 16 Feb 2025 18:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dcpGHwtW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078F67D3F4;
	Sun, 16 Feb 2025 18:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739730327; cv=fail; b=KrWpsXEvFhyPlEOiV5ki3JuxlZS8fTJpCY98lpN+I7ba+Ubva87GPgHta6oiqI2JBPdvBj4QlZ0eFanI/0PVi/4yJq2OEjvkFGFrt9WsMWNhmiNdMqrYoaSbllr/DzZmGrnqiHz6EhO1Ros5zWLQq/4t6GYVYckMmvC1lE9a9x0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739730327; c=relaxed/simple;
	bh=3iq3hGdaMra8OjjoD5XjXjrHYaMCJ7s0TBVxZuWrBC4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N1PXhHBnHvny++M8kg0w4Y3v3VINGyYW7atGtI/+BfkWGoNxsL8ERVNeLSYfj1dKM7Lo+M8vBonx2xPGOYKWl/5J6Owht6VOQmBRj33VGhdoWnfGwp8eTQVXEEt68x51KJk+TIOO9zX7PASXGsyhOqor6rSc4BoeXCm7N98wQ2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dcpGHwtW; arc=fail smtp.client-ip=40.107.237.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UjfQGGOeg/4VSIhMb2fRYc1qC7yaxr0RHkyfO4+spi0FKj/1u9jRs67YMnRsd9a/CZR5f8mDzTyz0+CIgGYSpY61+/KxkZIPyclSlZumwipjMHNxH7U+QTfnBDQkoX8YmMfKCAfVm5mke6GuR8fHz6l3vV0JrY9zcMAYBvnoTPWyV0FvTfJveDxxznrGz3zsYT3Fs2ZOujVjYr8asCJlXs5zFwIhj6Rf4vu9ZibfO+DUxYDOEcJOM6cPV2CAFQn1/DxB3rCMMfoLROpVOE01AiUM6kMMl5V7DfMdtbip4FFjyhpRUz2YIwwn6HilYVWNP5YBSYGixA9ony0zq7LgQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZ+65sI1qm1sg1D0l1nBu+DlElVF0VMXrMhrKUayXLY=;
 b=Tl3RXWJ0CbumpMYW5o/9UnEs/mYYMvO+n/1pwhmO01V32t/y0M547dRfP7jNYMegoRL+HsmH1pgQ6k/gckLryMC8jAHZjbE/jXvhmRmr9lLWugMIOrD7pZSeZSOOPm61I3zexIHGFVikKI/td/x1zSgH9EtOGSB2OCZ3Jy6knex8j1ddykaklZEoiY3/PHk2BcQJfNd2AksXUCzN6keuyOqo4P4GGbv5AUNh4/LLYF9TGast6E+aRqTm/aDLUiO7+osPC/0uQaTAOES4TEWIpOYBIBMrrXf6+u1aavEOJzjBs+Is/YSAm+g7yYtRFreZDQU3Ns1jh00IBRsapO2E1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZ+65sI1qm1sg1D0l1nBu+DlElVF0VMXrMhrKUayXLY=;
 b=dcpGHwtWWSFHOi2q/Xc4Elpsx0F+NqTO6HQm87CfapfVfKeSKn8+RHkC8nFPMHWgPGDILPqHpUKz5HU7qBp8pqZcZg+JMyfNO28PQLZz5K9fJOthZZOA43sKU+SNdS1nUN+chMx6+XtPEQ59z5NU6uBB/x4cFc8k60GQW95A45Eo/X0I6V9cCInxJR/jSiX8FJJlOkO0X651WcWFjfrGpUvwOK+H5iHjugWgdh6pMocJgfpJsP5EF9JyHXUAU65rI90vN6NaNIb10IlKlTxczX4Sq4Yr0SwBYTA729iDivLyPs83JC2IDoVHQm6oB2I0acqt+unM1ul5MC+weXr1mA==
Received: from BN6PR17CA0053.namprd17.prod.outlook.com (2603:10b6:405:75::42)
 by SA1PR12MB5613.namprd12.prod.outlook.com (2603:10b6:806:22b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Sun, 16 Feb
 2025 18:25:20 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:405:75:cafe::86) by BN6PR17CA0053.outlook.office365.com
 (2603:10b6:405:75::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.17 via Frontend Transport; Sun,
 16 Feb 2025 18:25:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Sun, 16 Feb 2025 18:25:19 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 16 Feb
 2025 10:25:07 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 16 Feb
 2025 10:25:07 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 16
 Feb 2025 10:25:03 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Tariq
 Toukan" <tariqt@nvidia.com>, Edward Cree <ecree.xilinx@gmail.com>, Ahmed Zaki
	<ahmed.zaki@intel.com>, <linux-doc@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net-next v3 1/5] ethtool: Symmetric OR-XOR RSS hash
Date: Sun, 16 Feb 2025 20:24:49 +0200
Message-ID: <20250216182453.226325-2-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250216182453.226325-1-gal@nvidia.com>
References: <20250216182453.226325-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|SA1PR12MB5613:EE_
X-MS-Office365-Filtering-Correlation-Id: ddb93a40-55c3-4e9a-3025-08dd4eb744e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mwMOiyREwQ+tbAV1C3e77uo5hcHXUF+zKuR8fMcw/27oO+UytSXeATI3Tpei?=
 =?us-ascii?Q?N0gLH4+FJpJbONOfJ0cgqZ8w9PQSlEtHcBULvCBWAkTkBHqKWnl4qcdmTsHO?=
 =?us-ascii?Q?n8jfe1Q4tOPDnkR7kquz8JX3QJnhKQQlwodbooVxy5XVigDvrE2OJNnKUSLY?=
 =?us-ascii?Q?8+euc+n6nqctOZtQH61vnmzMjWEFkHuo037mYRUDug1Pnt8TlH8Kt9jrYntM?=
 =?us-ascii?Q?o1EfCHWWMg2wbeUqtfIhPYmM7+j7uabOE4Wfpf8RHlBwt2w4HsOYed0707OC?=
 =?us-ascii?Q?qtJu9wyeegr+/hYmeJyH0vLE2Ncypi0vFJHjwkF7bnT1zj43qmZFvJD8cCtm?=
 =?us-ascii?Q?MWoCQ41nOnoMkysEvH77+9PJY9UChWoSueqJ2vw1bc7kK5BbPhzyUSb3+QU+?=
 =?us-ascii?Q?Xc8YQdYwhkgspv5qRjRpQ4IfOyUsP9djFvl2S9iU4ScJzjQQR36/oDUoQfDY?=
 =?us-ascii?Q?r/cNBp4uHqX2yLnG9Ix6/XcsBkWP4Cc+oMLI85rMUkIuKzuKXdmEyW9sEwPs?=
 =?us-ascii?Q?qFzyuxfeELYIE1TST+cs/J63BqesvkYHFaX8jrO7eVfJ/0UgR61jh6+BhfAI?=
 =?us-ascii?Q?jwvcgUQqqITqU3R2MMvzP22qHdrBOhBkM+O5FFrXk9WSAMiTqg23j9Li4fG0?=
 =?us-ascii?Q?ABn26WGqJip7qybMQ15+yop5VSo4vq0+/U80L6mdGTJ9cTfAImVMNUcA+G/2?=
 =?us-ascii?Q?ENT0r1LITYlY/tFoKLV0jWANdf834lB5l9bjTmdFKz0tEU8fSFe4r1llfvkD?=
 =?us-ascii?Q?uA6c7ANpFR+0qFYpfIAzd388ENfM00VW5C8JYRplhcnLcIE9Xa0lzwzqzjR0?=
 =?us-ascii?Q?ijDIk5Txah/cmY2fMdUcJNcWT7jo++mR5SUjnTWrwLPsxoo+Q/4RKItaohUF?=
 =?us-ascii?Q?jRDEWgYT1Oo0N73l5RVTMGKAOg1NkuV50+bopYFJwjPNPciN3VHridQamVel?=
 =?us-ascii?Q?z+OHECPaPULtyi8K0b+KsTe/DBvF9j1dknq3G/T8Cpya3Mk1k6BYTpX4rbvk?=
 =?us-ascii?Q?ey1e/Ntf8MSuFx5ByoA67iNIHrd7OKi3OkKR4f9nJx+ef6UVu2c64y3eMAHp?=
 =?us-ascii?Q?ODsaVvwgNkvA7E694DGZkeMxYaS9R9P0h2zcUWOmF8SQuqvdWFvxkczEqFJ1?=
 =?us-ascii?Q?Wf9WtnQTpvYngnognYDXTi5KWDp9s/yZ5Bx2a/UwzDOpU+Gd9Ea3HeOd9K3L?=
 =?us-ascii?Q?EXQgDceD31QLy2A4L2deXMrHcScnVVYgLq33JTwqIPXtqbxZYjxy907SZCgZ?=
 =?us-ascii?Q?3Ezclw6LFjMwTU8gXjlei3Ov8mF4X7oBJRoptUDFO3YPBS0U/CtA6x55Tcsj?=
 =?us-ascii?Q?ogi7KeHw0KpOMGxY3zXOQ8WTH+KsZjFhgXiBw/3jdiy86sS3gCaJYdk6Ox89?=
 =?us-ascii?Q?S78Lpn9ayHsUa7dj+aInqkUYqlHnyW6bNU1cy31J8/FRV40lHs7aRMEt9cHe?=
 =?us-ascii?Q?tV4nWuwu1oHzp6Yt51oL7GY2tyapZWgUWt1j4ZxrmQpSykM6PAI5NV1TVYz5?=
 =?us-ascii?Q?7q+QbfBBZFk4Da8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2025 18:25:19.6430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb93a40-55c3-4e9a-3025-08dd4eb744e7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5613

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
index 3072634bf049..a02ce2cea852 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -4774,7 +4774,7 @@ static const struct ethtool_ops ice_ethtool_ops = {
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
index d1089b88efc7..2909ac3a3357 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -2269,6 +2269,10 @@ static inline int ethtool_validate_duplex(__u8 duplex)
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
index 7bb94875a7ec..3829e24f9c4c 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1005,11 +1005,11 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
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
@@ -1382,11 +1382,11 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
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


