Return-Path: <netdev+bounces-163024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEB8A28CD5
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 14:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F35A218886C5
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 13:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FF014A4CC;
	Wed,  5 Feb 2025 13:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="unCykXic"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55955142E86;
	Wed,  5 Feb 2025 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738763669; cv=fail; b=HgfKIPk3oaJ3oJKGdNMQgA38cuACwZ/sMkm66WYfuNz/G92zPwKtlxP9nMf9ZcnMDorV7Yw4keyfDhKcWSHuXqLN/kmZZ4Xn027QTB8khB2e1s+bCrRzi09aexAVUVfKOM/gJ6PQ4GHZDEe9nOb6zxIdfkaCYVzxEaY9sak3LsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738763669; c=relaxed/simple;
	bh=OuKjFk66bOEHRa1Lo+XGMBUh5Wb3Sa7etoSnxk2nVdE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HqMD7Il0nXt/ilUoIupuDHIifGrldfTvv85kl/goUeB4Z+q+siWiOYagrFFeWPspjNBmh+OzRQsLlKhueTk3eR84i6ngjhG6gfAgzOvQzP+yGNqIIO3hMZwxoiY5eepzuRlZken0B7SKwAEkLvSwc2yeBYqNELnMt38F5+EUCJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=unCykXic; arc=fail smtp.client-ip=40.107.93.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xOJZ9O0YM/EnGwG2ZZH3Yf06a+MHsTZzq02B2bzTQvHxaNc2s/Kjk0c2PcMY9x4ftDVJ861pF84/ruEVJX1gWP5EcNyHqkCjEh5fUHt7aT372Uh8zQBhPIEAaSNBUzjxaAlF1rWtTJOVlTpxKrjT/aWKTn7zz32w0GOskGVqe3obeqTCNzk4v5JQJKcesSa9Wk8fU7CWn3HkRpC60MoE1/bpB8GIALgdWgh8J33JBJULca3iaWpI4e3L/aCviYT9N8MiPjDxtDDPE+jX90TpqRA70qpxpIjptIMcPEhbxZDYmn+ezecahN6XTG5k3L00u2M7Z9dbN2+jxN95UYFgKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mRuMijF8SF1Uq8DRGIS7VpVlXWhmSRxWcJXF6rp9Jg=;
 b=nRlSao4FvrdqfucPlv/QK29q4X31Bwyy0iKeZTPcz3UtadjKTDwDHovHjDEOCYscFqphhfLHZf4FZ9LHScDESSb/d3h0KPiRznPcndn+Ziu0chMgTM6xvDCLfHPicDwXmV582gpmUqQ1TVm0EA/A0gAg1t7ku39SVskQs/FstGAuceowaT/uiS3uvhNnR2fRlXZaclTFQASqpxbn0TYgqipt8FGbVU38jWIe56wQdDAxhuTJV6Vxn5L3FkDj+bCKwATqcOjcmJfSJ4vt8iNReDWZSZX1Aibt+M9JG9LZinNNZERD+RpKagcuTPnT1Cvv3qIkQ/W9EQpT0mVpWYb7xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mRuMijF8SF1Uq8DRGIS7VpVlXWhmSRxWcJXF6rp9Jg=;
 b=unCykXicJRIyxrAHzmisnmMqaLSoCd+iKnJ/xPqEvB/wTeOdtorZ4nzXUjea1uVRKRdde7+/g+/KpvoXJmtMsCAEXSD7Ztrp0tlc6ATKlhtff4Y03wzQpUVBarBdPQVkxWbvMe1NkcUEkliWigAauR9NPd++pE6fJ+a2RqParDKiW26G9AtPzQ7Yib5YhAUKCii5QQEUMo//Wk/v7jx/+jj61yWV8nVkBCOJl3Sg+JFua1rrP6tXAPLcVmKbx38Tw/ar2Nnw/JXvSQubIyKUr6YJ9UZY40R7EvYoh9HbWXupZqdXUD5Zqq/Q9kM8YeFy2b55poMOQs5oCo35DLYffg==
Received: from CH2PR02CA0008.namprd02.prod.outlook.com (2603:10b6:610:4e::18)
 by SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 13:54:24 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::35) by CH2PR02CA0008.outlook.office365.com
 (2603:10b6:610:4e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 13:54:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 13:54:24 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 5 Feb 2025
 05:54:02 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 5 Feb
 2025 05:54:02 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 5 Feb
 2025 05:53:58 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Tariq
 Toukan" <tariqt@nvidia.com>, Edward Cree <ecree.xilinx@gmail.com>, Ahmed Zaki
	<ahmed.zaki@intel.com>, <linux-doc@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net-next v2 1/2] ethtool: Symmetric OR-XOR RSS hash
Date: Wed, 5 Feb 2025 15:53:40 +0200
Message-ID: <20250205135341.542720-2-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250205135341.542720-1-gal@nvidia.com>
References: <20250205135341.542720-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|SN7PR12MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: 635f755a-59ed-4f8f-60e2-08dd45ec993d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s6ZIL44/UYEdRb0Im45MtQnW/Bs2oc13y2HQOV7lfLOO2PydQcnTdeiyw2Ml?=
 =?us-ascii?Q?YgqDpSPcH1g9xt1Q7LrpET8ASDCszRaH4+Ao7GeaBJgXj5bQaUEod2Mn7j3R?=
 =?us-ascii?Q?E7vMbGNY92fmAFkMMu/jj+VUf6ZlLB54gNdV7Wv/uc+2OdN6gjfvAZHxtOxW?=
 =?us-ascii?Q?Q8EZSCZyvJ34GIu880mdQykmSQLNd/fCKEIuUWjZEu6VAm4XfAbesvCqEN2j?=
 =?us-ascii?Q?aII/4HAPPoy+KXxBuEsKaF/EAmv0qmjXzgEBW7qPsv8RNjfgSAJ8TQmp7KYA?=
 =?us-ascii?Q?IKoB+T+G7PE7oldFu1GukTjfDFF0rm1C7uVu+UCIjaL/gbqknIxQOl/hTbvP?=
 =?us-ascii?Q?X+GZ8rfCH3LYunEewIoczMWijybx1bXEdC1Kl2tBskS9ptuxD6PgQHPS2n1E?=
 =?us-ascii?Q?mWTAC0AXE0ljvSfhh0qmCgxYIio+T/35ow2ojr4r6y3+4l9euD4kr4ncgUkw?=
 =?us-ascii?Q?KsNWBBZYrMXKe3QksDmubc+R/bZPERXyRYGW1vbuKxpjW3AGPzFpgFg2Bt74?=
 =?us-ascii?Q?CfmiHu/M4kiFGQSGacGo0AHeObGY8PEaQ4fDy6KQlcGc/CMXx1w06fAKT/fF?=
 =?us-ascii?Q?49d/YzC2GasCLMMYhEbs5rq0dno25/nTwK4Jd47xqF0wBLvQG2p6/6ZwBzAE?=
 =?us-ascii?Q?ILtM3WSd2WPz+eMc5JzQ55A3rPg+QL9kuZIyfwxvhW1ooZKjqfjJPdUXy1IR?=
 =?us-ascii?Q?RlSZADlVWDn461RqplmhzfT6yMrcpfK3gC34DUZ01Sd23jWbtg+v2bz54w8F?=
 =?us-ascii?Q?dDYiDmz2kaA0MzWsQO6c2SdSuvvESYbdWux7S5IA68zs7wvd3XKdHLAlHDIM?=
 =?us-ascii?Q?a7v6RcpDINxNPYr9AAjlaKlTUosqlkeSo5RaABEbVAOb4Krwz/dBYD6S91GX?=
 =?us-ascii?Q?hP6NiZ29/yI/MAXaEGGGvpUf/dbIi0YJXxNFE1L6dgQL946yhsPLVdx1ifeX?=
 =?us-ascii?Q?/Uh8MlugvGxUnRHqYaAjKSkMZMHekNHq3ARbt09nRtyupNdiyWmjLCp+sgeL?=
 =?us-ascii?Q?dMLf0kz8q2Le7VMMkgZjDzY+M5vivYNOgtrS1LGNlUz2johCLe4rPus0qUIZ?=
 =?us-ascii?Q?rsfdgQjeq78gRfraSLv+trvdoNXwJOoZ/msDZgxpHXUq9TU6ieSiUlz5RB8f?=
 =?us-ascii?Q?/D/aXuqz+JbcPECPsOsFkDegDfeiMAfl5lp41PFw8I0sRMHJOcULxafG5hJS?=
 =?us-ascii?Q?vN86OVDAi6dmXOxproqeZEFpuRPCjKh7eMNhrgPsctqnFAfJP3us5V9aD/nS?=
 =?us-ascii?Q?SMmlWw/mBt9xQnFmVyLP7q00YZ+FRACvky4Y2H58zX4w4qevtvkh383rTP4l?=
 =?us-ascii?Q?CK0E0MSBw6G3oyjd+4Gv6wU3QNEDyr59pT/QGD2ieDNQvuLCDgv50+9ts7mK?=
 =?us-ascii?Q?VlJ1SmzshrwXEJ/6PaV8UDgSSmc9J6Nsl2LhvZRoxkIMbahaaf1OpnfEzX6Z?=
 =?us-ascii?Q?tDH18AiyIdz4/PKpqTmr6ZZJ658z2VAa3+GYbxIFWEGKE8SCJ6OQfG2n1Naq?=
 =?us-ascii?Q?PsJ4ggvzgjum9Co=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 13:54:24.0294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 635f755a-59ed-4f8f-60e2-08dd45ec993d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7835

Add an additional type of symmetric RSS hash type: OR-XOR.
The "Symmetric-OR-XOR" algorithm transforms the input as follows:

(SRC_IP | DST_IP, SRC_IP ^ DST_IP, SRC_PORT | DST_PORT, SRC_PORT ^ DST_PORT)

Change 'cap_rss_sym_xor_supported' to 'supported_input_xfrm', a bitmap
of supported RXH_XFRM_* types.

Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
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
index 870994cc3ef7..0548745d1c36 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -768,8 +768,7 @@ struct kernel_ethtool_ts_info {
  * @cap_rss_ctx_supported: indicates if the driver supports RSS
  *	contexts via legacy API, drivers implementing @create_rxfh_context
  *	do not have to set this bit.
- * @cap_rss_sym_xor_supported: indicates if the driver supports symmetric-xor
- *	RSS.
+ * @supported_input_xfrm: supported types of input xfrm from %RXH_XFRM_*.
  * @rxfh_per_ctx_key: device supports setting different RSS key for each
  *	additional context. Netlink API should report hfunc, key, and input_xfrm
  *	for every context, not just context 0.
@@ -997,7 +996,7 @@ struct kernel_ethtool_ts_info {
 struct ethtool_ops {
 	u32     cap_link_lanes_supported:1;
 	u32     cap_rss_ctx_supported:1;
-	u32	cap_rss_sym_xor_supported:1;
+	u32	supported_input_xfrm:8;
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


