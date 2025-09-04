Return-Path: <netdev+bounces-220039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30ECFB44408
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 19:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E41D2A442D8
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 17:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1305730C341;
	Thu,  4 Sep 2025 17:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pQwOU3Da"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7308F309DD2
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757005785; cv=fail; b=mgfKyrLHJPPQYE0B5pl/H4KS6v7o/fx/tWu6skhPi5L0Mzy4wCl4kYj4cvwfJjH72q8lWXYfuuQXJVukoVso5eWUt8HOLtil2MSNG+JFbtE0HdOsoFl6X0pZjHrR5JJbwalC2zULKvCNN4ur7PpXig5nRnzO2aC39OZXeYjJJm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757005785; c=relaxed/simple;
	bh=VLsFcmUsVRVNSIX0nH/c9sQUfM3fFNCeqxD1MZYKBZI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JBCAM6LMRI2MEVbdX98QkSQ/qy92VzJpwuPJEaRidM0YRmYLox02ROQfWSKd4crUd1hX56kFiRm/GdL/L8L9ZTRPcqIU5hQmIrHs449ZL+UByNLhaxYAAyuDj3k416oHt8oWlh1+lK8yZ4ye2oOloP+VqffFPGHa7RNZ7lf27ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pQwOU3Da; arc=fail smtp.client-ip=40.107.244.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZvU1J5pXb8ldxlU+mDctnDlrbmD0C93lHAcK7MdqEYfso4RSdzA6WDv/hZnKW+usfe/GHFmfMFzdIwkE693YAOg8LWiU/pwT4mc1g/5R1U2DtYHDL6jquMlqmF8RCDrMEfnhF1BmEziHpIwJQB5Prcd5a+PriqTkZH65LM7g6Td8RqnHsF/wdApNLcz4n1hGu9EUjR7I6FrMQIm1Y3i487Hn35WRspAC9fTn3W/yEduiB5d7/XQs4AnWI/Fo64nCXnIbrTx/rgGDQ3mZT9WDvqCAGnMpztX65S3uOFh5Azp8UOETgRHz6A9mcVsSPjVUcpuxbT0ho0iaR144ELe5Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NypB7HNzBw6tajBlh/7PK/5h+rxImaB8f5t0Ch/Jd+M=;
 b=XrXuM915mrBquhbnMSoxtFI2KNEIOdHNwsuEq03dXrJOHyxrVP8RgC/iS3xJybjlRBTUKs5X4cSw3935B39/jBb8HifrtZsRjp+v7bnog7nqBPB91QawtfhGPNGBAWy6WaT15XVyBFAs+TVZsv6ZNFTU3WTKM+jGzKwoPISGpef9cdyffxKsaZD4A27or/9OwqUCVNrcJdvw+d32/IDmrbmi2amD2PAMXooYT0h9JY8CWkcC6FYvzscY4sqYxEXb2VDpJwsdHKga1gJQA3WHy+tQlAK1ggjiL5VWuk7WEeHHLbLUkSGeEBxsSlMCfzkh32d0VQdw97PhOzbzjqPRhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NypB7HNzBw6tajBlh/7PK/5h+rxImaB8f5t0Ch/Jd+M=;
 b=pQwOU3Dar7q38u6Y+w39eTmct3IDyWAfieKCqwH9Eh4TFHAap9GlKHooLU6mmXPJRFe6tRqCHYU6Kx2gcxD01phEF6q02ELTbjFzfSO3wrGIRLUaDOjMmROYhxoM4ap4Q14sPQVp6HJLkrY/eThnNGU0FzcMbGEeiu8WO/EoJTm5/KUHumQBjTiK78a9Y6pCeE4yfjvrLmk6O+ftf525KwIBfgXQw7MqUroJCdYQ9LMrpE9YHIDiZzqq6pNB20WQ0wFyU1QrxwyTiGMhEE4a7Ih2pyAbqK36edXZLDedylATPDIeExT/a2NWuf5CPI/jJrw26rk+683oxR2PXS19gg==
Received: from BN6PR17CA0035.namprd17.prod.outlook.com (2603:10b6:405:75::24)
 by DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 17:09:41 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:405:75:cafe::d0) by BN6PR17CA0035.outlook.office365.com
 (2603:10b6:405:75::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Thu,
 4 Sep 2025 17:09:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 17:09:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 4 Sep
 2025 10:09:12 -0700
Received: from fedora.docsis.vodafone.cz (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 4 Sep 2025 10:09:07 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
	<bridge@lists.linux.dev>, Petr Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 05/10] net: bridge: BROPT_FDB_LOCAL_VLAN_0: Skip local FDBs on VLAN creation
Date: Thu, 4 Sep 2025 19:07:22 +0200
Message-ID: <bb13ba01d58ed6d5d700e012c519d38ee6806d22.1757004393.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757004393.git.petrm@nvidia.com>
References: <cover.1757004393.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|DS2PR12MB9615:EE_
X-MS-Office365-Filtering-Correlation-Id: d0579649-6727-4f85-c9b5-08ddebd5d59d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gw57wqYlKmVB7bKZSsmFGPrDR1kFlxETxnrqgLsqC/1zC/miVVzbclgEjiil?=
 =?us-ascii?Q?EjZWH41YXtBYOnkQqMfBcnYqr7m7/f3GUqECQmZMqGCRvZDWdR9S+Q/gdJOK?=
 =?us-ascii?Q?4dOYeFLLvmShp+7u72Fp7sDxAmrvNYO9ThAKrgVOFqVPiWaNAHNfFLNHG2Iy?=
 =?us-ascii?Q?m7fZ49k8sEOQ5DGhxB9rL+KitEaPxcnujOIUPNAllrlYzOparTG85AKjLEBB?=
 =?us-ascii?Q?rHDJlhbv2RTY72b8seVbPDT9pikZG1t+lA4uYg3Z/6l4odnujbJjerSJxitW?=
 =?us-ascii?Q?mur8bgHFLGsj5sythQ/skYCwymePqk+T+hT3pScDwEJxd8DbBrNGxJoCXlv7?=
 =?us-ascii?Q?RLjPVS3te2JmjXvHaEDdIOPeYB+bOKYZ7mZytEEPZJRYSnHCGVhPvS13QThm?=
 =?us-ascii?Q?prY+xlVsjXqi2Jpt3PCQWfxMpOgHvdzeoZ8MdDlL4cH6odAoKbirQ6qjJMxt?=
 =?us-ascii?Q?Ahb+yo0twp+4V4+4yaQlIZbPvC013bYhmOBA/StbhSmhbUrAnqL8tjUp+bl7?=
 =?us-ascii?Q?Vo5mmlpiGvrUwgNnqY7y6F2SvPZTgYPN3CYDhbl7SSIfSLWuHrYqki1RmWGr?=
 =?us-ascii?Q?8qUikwQ1dhfLcglAqcmQY/j0eg5c5HxeUDCaJqiZ3YVhbFOC11V01zHtMYPp?=
 =?us-ascii?Q?LTvZ5+Drf0zOIz6PlnRUqavZy2QPsfEXLfkmVcnShWoVky04An9gcFhWPoXs?=
 =?us-ascii?Q?nPpFi4OJY3Qnq5cngbEz9EYxsaWYe7Q+QiQCCO3CaAlOHkpHmOl+TwCjeVBo?=
 =?us-ascii?Q?c068m8Kr4JHQGbCclXhmyg7wQ6tW/czp05nvasRFQ1Vpin1RnClJNSqM+NfO?=
 =?us-ascii?Q?bNPNYrQ6LmheVQ9qf4ILs5jYRHgcq9q6DCHVcQkL0Ln6hkk53FkWJe2GiXu5?=
 =?us-ascii?Q?uAy8StTktgAShhdX89VQwI7k46W0uFJFgAiuYEIjx8G18yQfqIjIYoV925yt?=
 =?us-ascii?Q?W/6adk2kGxiTmd/mvtiS12CtkJnnxGyd3qVxuYLQfZpRgOzVFD/1ZIE4x9wX?=
 =?us-ascii?Q?/Wwr7KBlsH+gA5xniz50HOSfZRR9koRcxojX2ZW/mIeRNe4H/CeSX/r5Jknp?=
 =?us-ascii?Q?kwqdCnJ1UBmDCUbEvOxtRvud9bABodB9oO4NMgfjAp41lv/2oIbd5EMPzoIC?=
 =?us-ascii?Q?/Id9kKNnvdaW19IbwpU5bp7/2SBDeEUcNjQjc3ol2BkG2ayWcBtx7VslIGnH?=
 =?us-ascii?Q?lJylaLyd3XnBkWklmqI0HxB2Z/fB/jp4advwFCNfV4hQEh1jpT1pMB+ILHBi?=
 =?us-ascii?Q?vlYEzxDLfv13fD22GoBKLU+KbE/Fh++lsBSBp5A29IgbJUvLUoDKGJ/1/ODR?=
 =?us-ascii?Q?jzGU77YEiiMISKCQFaiLS4khhKwA7tPngKNyW6SQATw294BQUPsTjU36Bw1I?=
 =?us-ascii?Q?1VlxUA9ITxWOsJtiGrBk9GwgDAO9gc6QNImMHTONy8wSVX49jrlF+MLzPoBh?=
 =?us-ascii?Q?BTxLI3hZy39/m5S5lPNgFznIU6rEwDL2qO50d9+zKzXBSyzstBxSV1FejGN9?=
 =?us-ascii?Q?4AZGj5nDVO5JrMR3GnF8e5AT2tfTl9OlFuid?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 17:09:39.8979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0579649-6727-4f85-c9b5-08ddebd5d59d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9615

When BROPT_FDB_LOCAL_VLAN_0 is enabled, the local FDB entries for the
member ports as well as the bridge itself should not be created per-VLAN,
but instead only on VLAN 0.

Thus when a VLAN is added for a port or the bridge itself, a local FDB
entry with the corresponding address should not be added when in the VLAN-0
mode.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 net/bridge/br_vlan.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 939a3aa78d5c..ae911220cb3c 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -331,10 +331,12 @@ static int __vlan_add(struct net_bridge_vlan *v, u16 flags,
 
 	/* Add the dev mac and count the vlan only if it's usable */
 	if (br_vlan_should_use(v)) {
-		err = br_fdb_add_local(br, p, dev->dev_addr, v->vid);
-		if (err) {
-			br_err(br, "failed insert local address into bridge forwarding table\n");
-			goto out_filt;
+		if (!br_opt_get(br, BROPT_FDB_LOCAL_VLAN_0)) {
+			err = br_fdb_add_local(br, p, dev->dev_addr, v->vid);
+			if (err) {
+				br_err(br, "failed insert local address into bridge forwarding table\n");
+				goto out_filt;
+			}
 		}
 		vg->num_vlans++;
 	}
-- 
2.49.0


