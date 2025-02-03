Return-Path: <netdev+bounces-162146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D94B5A25DDE
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 16:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B422F18874DA
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 15:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783FA208969;
	Mon,  3 Feb 2025 15:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IWZ9F1XC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994D52080EC;
	Mon,  3 Feb 2025 15:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738594915; cv=fail; b=XFUQtBFQ7tLz178pe8obs5+ymP75a58FRB5yo3+LPpzwuIgXIKhKGlNAlnNEL8NktatQfCWBSKzij1LT4FubqNZT2sLyj/SUJguznzlGsqxc6WFVMmUjROKClD4FnCYIFkDGySqF+a+n8mweF+NYw1QuGVdMnFYzbd3yIdMHHa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738594915; c=relaxed/simple;
	bh=zq5yFT37iTn6sYMowjHuRpxeHQtO1zggrqqXtcsx4VY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s185SwaceyrzHUKfrIhN67y6Nih1A1ATN5AM7Eme+tt84+R9lPEqtGcBeLdJVNHbN/OOx7NI/IFsDIXw5bIU3DgYLJzz0QIET8LyWgBAp0OaWfZwb0XzAPxqTeTMBEfujr0ute6f8o+etH7ZHQ/JOb3s3+UZMCpsOFPfXrtrlYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IWZ9F1XC; arc=fail smtp.client-ip=40.107.94.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lNjbecYMym6Ylmh97yrIGvoaBu3YjQCrZpAUQH6JsGJAUi76c/VPxjGNQvwYq5h5NBllUQvzd193AzgAqAl6ICOttVoUD6Eo1BSr8dS//IXNF+Twsu23nGYFDQeo5gmWsNqkPCveYN3OYaCiiPmCOc9yqaO9mepYZl5zrxk8vE7wtwk08XduPevSvk0bh6JgG4cz3SyuSN06UH+dFEAniwneFUgR0SVCbFcy+F/OZKFzQuo03v5y9Kp94yk6bK0LCXMcFaIBrmKHPx/7KHzTOd67TrRDu+F+XO5w5lds1UgMGZ1Pfei6DWkP2JOZld3tRkMdMPGmO98PmSN5pGpzxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iH8UtwnnTY3dcUNKkCjhVPWsaZQeYEvqdH4SXKf3Rk8=;
 b=qEAj9GM3c0Acik6cnNYZLUepvoOwusWJ9N6z/BtAxV6Ykru2Q15dlrVwHW/JlzeXInVfCVLzRyGqyUWtlm1+aQ0oIgGcSpLH8/7/8ypMdBgibLM2owgQNEHWHU7tiAQF6hCAW8f0Mj1uAMGAt21qS651NSk6eoSDYGQvGn3AaaRSdpFbrtohrBY24J07EL+OR3Pdog+c7K7CEOzYNs87GCX+DmLEadQ8M/kkARNhM5br+HVvNZXltkfV5o+G1YNLpz97h11dvmYdJEvq128CkER35JxQpTAPR4EOqZzwzMjHpacWTQfxChELOeBmgONJjMcMWt7+zYMteEYwO39jEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iH8UtwnnTY3dcUNKkCjhVPWsaZQeYEvqdH4SXKf3Rk8=;
 b=IWZ9F1XCgcj6nrKi4pZx7ROAjn3X/4iSob95Pa6gd8pGRu+EVNWsTy5TDFvlIoe1PWiYASqNYWbYXimwTVla4pdCVer0rOVb92aEQZzZT32OaBMZ9NBJUgdOgIOJpW7mtUQcY9TNWRyGcDnaIeZGKG5BWsLXWhqXTXZ4Z5rKN2T4Pccn7uftz0QaKIO9RffrQp/bV5VkD8AX6fOVu0mzTL8lsw3N8pTytmyKYjiOcadtsMzPNheHfvfrFIOIhE7CGxUYt1U0p1t7ExJS5se14PRKK1ur5a+3F52wr33M2DW3FQK2L9oMiodAjh8/P8kCrZROhO1YMWncxt1aIJWr6Q==
Received: from SN7PR04CA0167.namprd04.prod.outlook.com (2603:10b6:806:125::22)
 by SN7PR12MB7227.namprd12.prod.outlook.com (2603:10b6:806:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 15:01:50 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:125:cafe::e7) by SN7PR04CA0167.outlook.office365.com
 (2603:10b6:806:125::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.21 via Frontend Transport; Mon,
 3 Feb 2025 15:01:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 15:01:49 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Feb 2025
 07:01:29 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Feb
 2025 07:01:28 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 3 Feb
 2025 07:01:25 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Tariq
 Toukan" <tariqt@nvidia.com>, Edward Cree <ecree.xilinx@gmail.com>, Ahmed Zaki
	<ahmed.zaki@intel.com>, <linux-doc@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net-next 1/2] ethtool: Symmetric OR-XOR RSS hash
Date: Mon, 3 Feb 2025 17:00:38 +0200
Message-ID: <20250203150039.519301-2-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250203150039.519301-1-gal@nvidia.com>
References: <20250203150039.519301-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|SN7PR12MB7227:EE_
X-MS-Office365-Filtering-Correlation-Id: 3224729b-4af7-4741-1e69-08dd4463af69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RAg5LAV+MGeMniyWo4gevbhwIvC4smYKVyEE8A0B65g+NQMG+dCA6KPGLQrg?=
 =?us-ascii?Q?REKZLJfdGZ9tDK5GpYx9IlSWPDr+YDiVLWZOmSsZPaN5138OTZHEVaucy+F1?=
 =?us-ascii?Q?SJKsCrboh6M3+sO9fucCUWQo5y7GQZ4sLmevxOxTTc4ilDc51DRyHww2EP3L?=
 =?us-ascii?Q?j7+EW3tpWhtlbB4Dy0okhMKlR3mDBf2uLx2VyuKNxdEnAAoPN/GArLZO+zV0?=
 =?us-ascii?Q?J275bf5rIQSp+zyV+RhjZ4GrSYlKDL3tZB8kPyXpLlw3YIDxHm2hGsPnl7Ye?=
 =?us-ascii?Q?Q4QlRcuMyBZBWB//MT1E+L8fxBOfiq9MIhCeJXoBGzFl2ySLRWAcMLIFzDE8?=
 =?us-ascii?Q?q1q39coW/gmEP/gj/pG2Hamc+9+9hdwc+NQbmJoWQwDBCAoGmCqHuJUFiE0w?=
 =?us-ascii?Q?4waiH0fdJ4XJ3bPrPrqZ0fuk6PVMwaH8tTawGV/hTow5IzBP0XAyOuzCicac?=
 =?us-ascii?Q?uB+hdHOBLNsy1pju6YcCQ/uK/nDJDarwT2ClWPDlixzI/86x5lqpi0cTMsB0?=
 =?us-ascii?Q?pu7v/Xu0tjCLSXyyckqntVIbHphZT5ospoDFetbogFU14G8DhTLphYMzqRnw?=
 =?us-ascii?Q?enVCUqHrOtipltA36dTyu+JlzzVAEvOgPub2J8VY/adBcw4XYbV7ylJYWdho?=
 =?us-ascii?Q?F6lsGkKL68XWkgE+9FLiWnwTY1rsm3My83KfkPvMQomRP03/cbWhfqs8nSEu?=
 =?us-ascii?Q?RvDjFTvGPol43DMaCAt7VDGMRBEe+2gB3aGCth8icJKspivgOTNxaxEmEhKt?=
 =?us-ascii?Q?0G7k7wVAibbUgWO6cdxXVDecy03RJ1zlAixOP7lduaBhEN/pbxc81SYwNton?=
 =?us-ascii?Q?GbUDhjika0wi/kTCgDaxDR6yNWuFIiXKeARjYm3labU4Inmge6D9c2w5HX8z?=
 =?us-ascii?Q?6b1rP9/FkEc7SiJ5wLPhHygEDovtEPeWbDAwTIHCBoVPzBcqfVz2k5otNm1k?=
 =?us-ascii?Q?3MTVbC+pRAEBwXXqW01hWJPOZ1TUimZxF0CTj+10PcW23l2taDjd6PU/n/dB?=
 =?us-ascii?Q?BTrMOJtxYSR+Kpwl+57OmmSifXW0dlvO2dLhPXbwAAJq694RJ6wzfwKKu43o?=
 =?us-ascii?Q?Q4Ew9mhJn9sJ49T4rpZizoXuF9hg01fH9knkdVd34jAnN/O+8ryYtK98I1WL?=
 =?us-ascii?Q?RqLmS9oLAoCZRZxxpRUydKsYdlNKa0eC7DpFJReJSqi8jKzr1oZr7aYs8TAc?=
 =?us-ascii?Q?1+hkPUYRBJ5S9YlbFjbzNwRF+GGwaXFZjTU50s0Wgnp8/4I8HQS65OsG80JG?=
 =?us-ascii?Q?M3/a3YxQHkYdFz6N9t9wU6pW+gKhVMag/pXajZ6f5ePejelSqiCKxZSHVbIv?=
 =?us-ascii?Q?oZVfcnVvjYw/Z0gXx59WlGIYbmkFtVzdaJYK0siFlf5KESUdDYc+RwLhgpdS?=
 =?us-ascii?Q?rCYoKm6uc7mbLDw36G/iWjiKLAc2fZS8+18VSvzf7g+dpMaqv9OYu5xRJxL6?=
 =?us-ascii?Q?Jxhggh25ZhpX7Ux9GD3uwSfu2/qO+35O8gp8avijoyk5dBqJBtfa5x53CWki?=
 =?us-ascii?Q?MeocOJeFG/wbJ7w=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 15:01:49.0425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3224729b-4af7-4741-1e69-08dd4463af69
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7227

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
 include/uapi/linux/ethtool.h                   |  7 ++++---
 net/ethtool/ioctl.c                            |  8 ++++----
 7 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 3770a2294509..aba83d97ff90 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1934,7 +1934,7 @@ ETHTOOL_A_RSS_INDIR attribute returns RSS indirection table where each byte
 indicates queue number.
 ETHTOOL_A_RSS_INPUT_XFRM attribute is a bitmap indicating the type of
 transformation applied to the input protocol fields before given to the RSS
-hfunc. Current supported option is symmetric-xor.
+hfunc. Current supported option is symmetric-xor and symmetric-or-xor.
 
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
index 64301ddf2f59..846cf5a34c67 100644
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
index d1089b88efc7..b10ecc503b26 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -2263,12 +2263,13 @@ static inline int ethtool_validate_duplex(__u8 duplex)
 #define WOL_MODE_COUNT		8
 
 /* RSS hash function data
- * XOR the corresponding source and destination fields of each specified
- * protocol. Both copies of the XOR'ed fields are fed into the RSS and RXHASH
- * calculation. Note that this XORing reduces the input set entropy and could
+ * XOR/OR the corresponding source and destination fields of each specified
+ * protocol. Both copies of the XOR/OR'ed fields are fed into the RSS and RXHASH
+ * calculation. Note that this operation reduces the input set entropy and could
  * be exploited to reduce the RSS queue spread.
  */
 #define	RXH_XFRM_SYM_XOR	(1 << 0)
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


