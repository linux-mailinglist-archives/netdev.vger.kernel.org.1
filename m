Return-Path: <netdev+bounces-130404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEC098A651
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25FCC283425
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78725199FA1;
	Mon, 30 Sep 2024 13:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0zFMj2wM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01A8191F81
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 13:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727704406; cv=fail; b=UYHnkELy6ewmccOtCUEbiLkoSGOp8nVdTDJm2cDEj+4IgnMGtqM1GmvSM21VXwblTJkW8a7QUJnhAd/IonDa7+bMZLivY3fCnJsLU+hz24fh6nC9P+B9pD4cX0wqBDvnXjVad/AeYSLs+1EI7tHsxpr8oqpe81yJ/xOFMIgeCXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727704406; c=relaxed/simple;
	bh=Sv2mycHhzFpVHsrctE7MCekDFFjNnnCL3dK4OGEkgkQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JsxGxtdxNyXyQkjRXbJxTwdm69e4Wj0NCWfKWYlFLRd1tP9L2VVu2X4p1Tb29iqk32dsF/1GLF/3KyUvFPhoUGI1BnBLOd/BiRbHWjmvpuCqw1Z0dDq3tzi9IwvBv5RBvm7y+eWSq0BiZxOILdPAhh0hK1Azt168RwGWIY9hXVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0zFMj2wM; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T5CPN1Cjn6EENEGzvWZrqWWCmgZbTg3n9fZbR1oq6eMN5W3MmAI7zDgxTJjehVrCyLDqrhgOWAWodzMv5+HPi77PiF+aS5XUGuc5WwdJSC+l5oP++tCpHdOD9etbdFoZBZT7mkKkXnmRnJwu4ODC7qRZDODkUhosAG+R5M2fjdD2tBYrvJJ3cKLRHdEC9uGOmyTZqZklHl4UTSl4Wd68+obn9PofVkdlGADyKpGQsRX6AJeVCB3stOO3z+P8jYDiCv8oaoPvpeV/P9dEXqIyJa8ijddQfbn9Lo2rKer9UP+8/QgSViQ8l1NCBy+VfL/rmZMqEWHijJ7KTH7J9nIknA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zISJWpQ2SpzB5m7k/RMqxVfAEusBDzbIBbzcmBv56k=;
 b=AC9x+VYpSyXf7UxnkADPhJF3Ugk6OLghpU9VbWarDQShFFYJuyLP/1MLADp5UXgW7CVy0TsWLxCFFem83vJfFSI5fUtK7kb5s4MmIBtfLBCIhcprXC2wJ49AlbDyicAFgglSbdJ7Qo4t7yChxeP+lQIqAhwb75QOklNmO93kK6bMtPOx/F44TPUPTpV2FcUkMho3cw+YEJEwK3BHA1WqZ3WlAY43P/CFtJhLLTk4weviLtdCd+DTJap199pdoEm92sssjlmw60ZsjvwCnkq+7P6/T3rAW3z/Gy7pLp+KsCAZ5Fqc8w1NdMTY5TXgdjHWWkQ2Kf6uPyl8i3wj7nV1/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zISJWpQ2SpzB5m7k/RMqxVfAEusBDzbIBbzcmBv56k=;
 b=0zFMj2wMjx9skOKZ0DtQRgP8f1jMtIh1MVRNMmXFjvigcWLEecvxpu0K4wtMUV9LRREJRJ+i2maKlJOVdx88l0zO9W3APi2021gSaD9rjxrj+dh65mmhyvzzjAilkQ+R6PBkAvhpnUU/gf06z1YzdkbuD1/eYs+BYxnWFS/d1IQ=
Received: from BL1PR13CA0067.namprd13.prod.outlook.com (2603:10b6:208:2b8::12)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 13:53:21 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::18) by BL1PR13CA0067.outlook.office365.com
 (2603:10b6:208:2b8::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15 via Frontend
 Transport; Mon, 30 Sep 2024 13:53:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 13:53:20 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 08:53:18 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 08:53:18 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 30 Sep 2024 08:53:17 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <jacob.e.keller@intel.com>
Subject: [PATCH v4 net-next 3/7] sfc: add n_rx_overlength to ethtool stats
Date: Mon, 30 Sep 2024 14:52:41 +0100
Message-ID: <7b1009e8f49eb27f9d07935c3e1a90b765354098.1727703521.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1727703521.git.ecree.xilinx@gmail.com>
References: <cover.1727703521.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: d2f8bd9a-00c0-4dd7-80cb-08dce1573e89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5IFGyBsd93/ZkMJwPx3wUAPh5X3UrKx6L7n0DQjA9grQhzZer5FfA/RIGfZJ?=
 =?us-ascii?Q?nTHMwiuzNqkzwEm96QM8BY4uCkgxxD/JGpZnDclGexGCxMzHR7GgajfbG5cs?=
 =?us-ascii?Q?5Xj31l4bbuMGLZ5YKC1aY3aUPZqMlLZj1kAixsTjSL42PP8Zi1FaNNrpXUPd?=
 =?us-ascii?Q?Bd97JYvnF6Au+GqX18h1Dk9Eqj/SdYTDntqtO5BIPbbGe3bHOTcg+Sx787PQ?=
 =?us-ascii?Q?+3jv245MbGiaAUNc2FuxQjlG9VVHOtXV3B8e72yP/gweBxwaSedcALKY3vkS?=
 =?us-ascii?Q?vyop5jZBqBFnTPO5cIV2PcO6RTlNlargiaJMemih2LLpjE2B1xnFsf3FwUOD?=
 =?us-ascii?Q?E61/CBKU5CkwHWEJtK5Lt8FXuRUdICSOyvB383C+bkpMKaWEXFeHSPR22X6z?=
 =?us-ascii?Q?p/24K33WBQlwL2S90YuGuF6R3PNRO69xSFP5D8EO7GkH+bsaddf2qm6z5iQt?=
 =?us-ascii?Q?CstqyiKJnGmsdzlKYVwnYuSeR3Ul+f9B0y9egnv3zuY78OmnnjjPzY+dNK6S?=
 =?us-ascii?Q?Wq8QLsRNkr2MdMyGchZKwKxtpr+NomqrBkn6OTZ2EhC8TaOPjRU5K90FjgCn?=
 =?us-ascii?Q?Yc8yCK4n+AZo/pROO8LI8kWq6XZZy/o5P/Dg0O95lFsg9YZEnlTnJkzIFlqb?=
 =?us-ascii?Q?eXb/yDakXDNOO5l6jNkJ66c0JqzpW6+pgjBJkLBrcXk56k3tWB6Kt24GZ8kq?=
 =?us-ascii?Q?ni68LCBNP1SpMZ9JdWftiFpl9/T7jwZHCaG2JgByoa20JC97SbUPDwvJ+ZWq?=
 =?us-ascii?Q?FTKAGrY4FHKEnzvpfTWBFZfjWChQscVWbqpXUmT98sr/5OHu7M2sjJSOEzNS?=
 =?us-ascii?Q?h73/SYrAsYUEyUj7tluQ7ZjK5lf6g+CYZFV4JJROSaSLWATUCjmLivxG5Byr?=
 =?us-ascii?Q?mOki83Dt/9p5BhzhOBx8P0h8+2j8SrCNe34jwEheGpmwNIzIDohTyyYJpOl/?=
 =?us-ascii?Q?/Hac9HVJAxhL5XxTxjKW21btQ+cSGduuFDVG064Pd9a4plthQJDiADOmy3zK?=
 =?us-ascii?Q?FQw4rbNR7dh0iQvvM5Uq3NS/trFkUcfvJoL8R9bexfnQbk5JaPsuTFzejBHF?=
 =?us-ascii?Q?4SSd/ttiRXCaSvicVot8b+eAWcME2MlAbE6szHyfWOa68tyrV6DgIQgJQe00?=
 =?us-ascii?Q?IdIRE1FW6jrrHBcUyfCY4PNU5Oo8b4uzvkcLVNDyH9O+CTYzPleam8grv9Np?=
 =?us-ascii?Q?pmOS1dmslZHK6P+FRBRlN+sjDVhSqMb5rcdu53NVFlj219YcQoYCELUuHb6u?=
 =?us-ascii?Q?de5f6BxZm+GZYiuygJyLsrX9n1u1cpGMIEmAr3eaRV0lzdwT2Na4uTuPC7gF?=
 =?us-ascii?Q?rhx72Kyzbn5izoXQ905+zIxOQVd+7CveZJWgu3Q8QKixJ9p8iJciZJqC4bCn?=
 =?us-ascii?Q?pfng80bJRFazVCDr6z9FOPqSoL0YGGQGkc1zRUjbIpacgvSalusbGHb6vDNb?=
 =?us-ascii?Q?3tUbwIUnukiJxlIMOlwgt8OdceekLFHn?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 13:53:20.6589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f8bd9a-00c0-4dd7-80cb-08dce1573e89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354

From: Edward Cree <ecree.xilinx@gmail.com>

The previous patch changed when we increment the RX queue's rx_packets
 counter, to match the semantics of netdev per-queue stats.  The
 differences between the old and new counts are scatter errors (which
 produce a WARN_ON) and this counter, which is incremented by
 efx_rx_packet__check_len() when an RX packet (which was placed in a
 single buffer by SG, i.e. n_frags == 1) has a length (from the RX
 event) which is too long to fit in the RX buffer.  If this occurs, we
 drop the packet and fire a ratelimited netif_err().
The counter previously was not reported anywhere; add it to ethtool -S
 output to ensure users still have this information.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/ethtool_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/sfc/ethtool_common.c b/drivers/net/ethernet/sfc/ethtool_common.c
index a8baeacd83c0..ae32e08540fa 100644
--- a/drivers/net/ethernet/sfc/ethtool_common.c
+++ b/drivers/net/ethernet/sfc/ethtool_common.c
@@ -83,6 +83,7 @@ static const struct efx_sw_stat_desc efx_sw_stat_desc[] = {
 	EFX_ETHTOOL_UINT_CHANNEL_STAT(rx_outer_tcp_udp_chksum_err),
 	EFX_ETHTOOL_UINT_CHANNEL_STAT(rx_eth_crc_err),
 	EFX_ETHTOOL_UINT_CHANNEL_STAT(rx_frm_trunc),
+	EFX_ETHTOOL_UINT_CHANNEL_STAT(rx_overlength),
 	EFX_ETHTOOL_UINT_CHANNEL_STAT(rx_merge_events),
 	EFX_ETHTOOL_UINT_CHANNEL_STAT(rx_merge_packets),
 	EFX_ETHTOOL_UINT_CHANNEL_STAT(rx_xdp_drops),

