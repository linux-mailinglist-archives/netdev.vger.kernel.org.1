Return-Path: <netdev+bounces-148157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E989E08F9
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 17:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01A61281EA0
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 16:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E624B1D9320;
	Mon,  2 Dec 2024 16:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="thgwTcoS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAE42E3EE
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 16:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733158070; cv=fail; b=RbhS3DlkkUh/TM04aZ4GUh68ritCkOhFpMTka7vuEg7LOks3STv+YTuVldHJ2GoGE1ndP08Qc7HTZR1exNGR/zTJdFdoqJ81xYUMMAEyLJ5xTHwVRPUNadgP1LM8XnvACBeYtcMqgenepvSRQBRTpScxm2k3Jrwr/JHhrAYYLuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733158070; c=relaxed/simple;
	bh=Z0mDKT8Qpk2SBW0u4H6CXuk/KJrIBowuOIxuNnYmSAE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FG5/LaMi0XWE2gYqxK9m2i17v8J7Q6MPtrrv0V15Ymu1pk2R0Qol9sinIIOTkWp56pn3cHj2CixVs+t3nj2g29PUBX/CKtZwpq4RyR+cKfdNgfh/tKryCxOsYcOgbWX3w3ljYe07G98LHukEgWauU/HisUdWzOhWm7aedPMuAug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=thgwTcoS; arc=fail smtp.client-ip=40.107.237.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uDVjO/llAfrRlaaX4/47sOLeuMoEDQ1fzIuqTEj6LosPJO3FPJWz+Zc0N6ErhU3kfnTfKlvxZ6qJ9bRhe9leXxTCfNi57qHJMNu2l+xou3yoqiu3+WGwl7/3F3VWuQ8JZXTWfwegMsgwMqNNMcs5YjQ3KCt1dUEK4z7ztZzTweWmJdd9OUX6ePsM5kMJvxVGiJXav/RaZUK4IowJslFzOkiAEMvpfqjVj+JZEbeo7YS34JIPH0wj2Okw0WZVA6EOYSZXKX5wjaDzSvGZTnD4nAYQmIr/Og1bCrC7g6vZ0UiEuanhX2MD/cawWJkh32lEGZ+rOKyuOXIe1izBeE4M9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9LqMZFoochjETufU6hYZ4lcm/CMt1/riFcju8jBjWg=;
 b=cPHydROFfTQj0L9kTAxoiszHF6sK8cxil/HKkSlrDK5mmr3vWxVqLUUvQzBCMigjn0jn8egONg5Nh2pwXfhQRu3nS+akXsmGA+28WErUllS6oJJG45Kq/DZZuE2Ka39qkuHKpUDOqynGy7OpGgqgIC7hOG2wMHG3e6gikQQ0LXKP3zphiGQTOQVs6k565xmLOyeeh5mRhAAt46OGYCddkL6Zmvnm1DggyqqhxKExqxF3dr2oB+z7OCELkdc4Oy4vhjrsR/dmVhXR77k+H3X4/iiNKqMvH0yiQvgWh5hthKnNdVCxHC4ojgpLk2uUjSxB+6DlKTbHHwFHHVNWWXO4xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9LqMZFoochjETufU6hYZ4lcm/CMt1/riFcju8jBjWg=;
 b=thgwTcoSmDAXiYokx+6lrPsBFVxHuz4wRLDrYfBzF3313X6IYO5SO6kqCFct0fbVPUUDPQ/jkafwtd4WwyDXPwXP3LBN7wMiZvZ+QkOP7BVNMVzE+OJX6JI6JsmmzFNZ/haE93/QfAazhi9jCkq9O0AftwHbHzeyvnpGCuVgCUE7XDX9DIMXA9EIOQOqR+g1KQp3b+goc4uPtxZSeUwPmqlghKh0HeJ6N414xM6bhIqyfAoTzrFzSP3hNayuHfmGcp13p6pFa5yRtRTzwgYd3B2v+xB+CkVxVKgpdyeyFAyF0E0cpCufWvjeRbUr7MO3DZR0aPjygchaNyR+gk7JCg==
Received: from BL1PR13CA0269.namprd13.prod.outlook.com (2603:10b6:208:2ba::34)
 by SJ2PR12MB8136.namprd12.prod.outlook.com (2603:10b6:a03:4f8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 16:47:44 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:208:2ba:cafe::fd) by BL1PR13CA0269.outlook.office365.com
 (2603:10b6:208:2ba::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.7 via Frontend Transport; Mon, 2
 Dec 2024 16:47:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 16:47:43 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 2 Dec 2024
 08:47:21 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 2 Dec 2024
 08:47:20 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 2 Dec
 2024 08:47:18 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Edward Cree <ecree.xilinx@gmail.com>, Simon Horman
	<horms@kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net] ethtool: Fix access to uninitialized fields in set RXNFC command
Date: Mon, 2 Dec 2024 18:48:05 +0200
Message-ID: <20241202164805.1637093-1-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|SJ2PR12MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: 28d3e395-e63c-4e63-9f3d-08dd12f10ae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FLh12lfkX+QORN8uL5wrYAoZcTUxrtvwFnzVgwFb9A3PeOc+vmqryzx7Okme?=
 =?us-ascii?Q?CBY7rxigQ8p4GAtu1/kd+UtI1+5dPrCYy6AQylXTUhVg1oi+fXeGJnxs+BvP?=
 =?us-ascii?Q?0jvM3aUglhdOUT9ycMA+c4yYvINGNYuBlE8ex/afWY7w9oimsvEMU6JqLH3R?=
 =?us-ascii?Q?cILUYwfpt0OTRv9fjaLvq4QQL6EqjCk20lAtHvX5F0QJlYyJNNfVNGs9SRSq?=
 =?us-ascii?Q?wrfMJkCIIE9D485QlsXMp5F/FmiL/q7WoJM2/L0ZrO9c4GtS4G7AKIawzsl1?=
 =?us-ascii?Q?UDK65HVU30uStH7kd1eP8bnxAR0KRe/aJsofXQJwjSfRHg9JgJeQXfXwqLAe?=
 =?us-ascii?Q?e3Bgh/HAR3q27qi6U+S1guTJ2SEoGIFCRqRvLgrR3ttXOa0LUvUjiVhp4PXo?=
 =?us-ascii?Q?3yS26cjoP/hHcukwVfdoPTxXOrPXpge+otFKeAKBITBuRrftLjKgxWuYYXxd?=
 =?us-ascii?Q?aeoe2a2aApfzczU/6iOIqtzZ7KVRCa60hTGHtGngSAcWIGrs+F/K6GkFy9ak?=
 =?us-ascii?Q?hF+TA8L+yomXtpr62+dJOD5bRiY81Yrtsc/P8DeUApyX78cXOa++j6D62r4I?=
 =?us-ascii?Q?bHQZbaf99gRUPW0R4aodVPudrYtX1IKKS14wtglbc06eoOXIfNsAxey0+48w?=
 =?us-ascii?Q?9NcY4Ox2CYnwlsFT/DE+JTxi+tAlSfMw3tR+4tn8FywnDnl1/LwtKpGO4yZn?=
 =?us-ascii?Q?IrrqMPHJGBINDmQUSUvjQSFVXaxyf0l+nlvSgfbIVMxgxSFa5hJ3TL9gWQl5?=
 =?us-ascii?Q?fMROnxffVESonD/5FpVUrB7IuXsxjKFwfWb9vaSZY2+s1VYCyOrfT43qNpm0?=
 =?us-ascii?Q?AOgpG5/PckNXrC3wG0aaUBgyDfAGoCIbU4JnTG38Ct3s9YejuTb3EJny3k9O?=
 =?us-ascii?Q?zyreQyMMoXNzBoFMHakMvygKPccb4+r4UwjrAVihKbrVpaSUl2sYijroPQyx?=
 =?us-ascii?Q?5hKnUqbyjrhYmiHxIdWtvp/CpQXDw2UFzG0wc6rFgPUogh7+RT2T2iZqgHmP?=
 =?us-ascii?Q?d6myyCBRwgHAZZSXhXZJlr/MHh8OrCF9W2ikcdUfcVcjSm/mKRsJk3+KpKgi?=
 =?us-ascii?Q?MMfuWBZYkTWFsTJWuj3JFwzUy3rGAOhNLUrcCZN5LFpzKN0+Lldb6Z7Lz7G1?=
 =?us-ascii?Q?m51MJpiiTVHVrznxI7OLLwvjYW6yogvCQayn1FmoBh1ZJnBjhLjuaU4/22uG?=
 =?us-ascii?Q?Yi9Av/IG661ggYOP77qiCY4+Yt8vrdyKiO5R0a+mGBkhOELRXxwhiVqkm6mO?=
 =?us-ascii?Q?u4qUCxFxhlL7RJKVb2prYjV5a5DR9EC4YjvqaO5o5OVQgtSm3r8xUFrCze34?=
 =?us-ascii?Q?KhEon2l4XC7MaJq0XnOIL99EBB8fkSinASj0YncwOSSGxigdTqb7QOm5YqDz?=
 =?us-ascii?Q?zHqUXf+cKDEVR1J8ezZ1NWkdq+fB8KZqeY0mQNlzB4VnZKN3FFB+ZuItX2Ue?=
 =?us-ascii?Q?ccAydsjXGisvMBcXyGV1bKw4NgwKl12e?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 16:47:43.3595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d3e395-e63c-4e63-9f3d-08dd12f10ae6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8136

The check for non-zero ring with RSS is only relevant for
ETHTOOL_SRXCLSRLINS command, in other cases the check tries to access
memory which was not initialized by the userspace tool. Only perform the
check in case of ETHTOOL_SRXCLSRLINS.

Without this patch, filter deletion (for example) could statistically
result in a false error:
  # ethtool --config-ntuple eth3 delete 484
  rmgr: Cannot delete RX class rule: Invalid argument
  Cannot delete classification rule

Fixes: 9e43ad7a1ede ("net: ethtool: only allow set_rxnfc with rss + ring_cookie if driver opts in")
Link: https://lore.kernel.org/netdev/871a9ecf-1e14-40dd-bbd7-e90c92f89d47@nvidia.com/
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 net/ethtool/ioctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 61df8ce44379..7bb94875a7ec 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -993,7 +993,8 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
 		return rc;
 
 	/* Nonzero ring with RSS only makes sense if NIC adds them together */
-	if (info.flow_type & FLOW_RSS && !ops->cap_rss_rxnfc_adds &&
+	if (cmd == ETHTOOL_SRXCLSRLINS && info.flow_type & FLOW_RSS &&
+	    !ops->cap_rss_rxnfc_adds &&
 	    ethtool_get_flow_spec_ring(info.fs.ring_cookie))
 		return -EINVAL;
 
-- 
2.40.1


