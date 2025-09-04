Return-Path: <netdev+bounces-220038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BFBB44406
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 19:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45AB4A44184
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 17:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A3230BF70;
	Thu,  4 Sep 2025 17:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gNq2GNgE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A0B30BF54
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 17:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757005784; cv=fail; b=JeBbSGJrB7qnNMohXmNyoRbJjYDoR/Ht75MU023HzneQfqhOM1LCpX/JVbFNb7CAw5myT/cmfMeU0qitv/0oyrb+c1cV7bTX72pvYvuCgPSNcQTHDiN1ZgDDHJYKb88mc5L3u3WApARMoCRYpZ+Pi2Qpz+6mJtzYQ2bQOuV92QA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757005784; c=relaxed/simple;
	bh=fzgJY0DiEvi5+OTKBjTEclPM0QejSHM41wHVJMU36XU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N67byKcHxnHWnuOizcos5e9KcojSTBKIBBdO0XhenS7ActGIef53hRJvMBZ6IDMUZmJKOnVObUiN+cJZIJvCK2IKUWJPGZpTxSuG1+/H4EvbsqBZ5nBu9ExwWqhVHi9kWYF8LEtlw8QYskfaeS/abooMUzSL8m2Proel6nVSbOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gNq2GNgE; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jW9hIe7a9mrmZgzn+T56Q9m35QnsUz6aIvgAEnAomtrVbhbktZLXxOLSnOMoISpVoST+LhI8EhVan+Q6mhDlQZtmfxF/PfAEqhPvqZWO9cwTv09HvqurgVnEL31K/iCig4Z1mx9qfIBNRZ7jp+RCMZr+f/1BBSlNsudtwNK370/X+KGiG2O+DhBiscF/1DwwlxMcLo159BBIAqpr9cDD1ZFdn2ykiCcuD42DSW1U1fMiJKjLNKQw0XGjl6cNBZTAI9CjRFIQV4dhivZPrW0xSPx+jehocTUHxLpbaG7afcl+NRvE7oY1w31r6wJ7cnB4Un6IeHscF4eT1KAABKOyMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7R2bTQYqPybaPmHDbq954jrucxdh8d0rDLmRvWJjjPM=;
 b=FUxWuc2hm90SDUPb9Gl3KIXj0wQYkUDKfJcvmPAtGezSLo+jjAjRSlt/2A/ZttoR6uX8CBDA43Z7OYmw7E6sIfuBJJ/213HOGYvNNDCl+Ccrdv//PbFOG+YnpshH9L/Pxc+yd+k4//6s1TkZl0ulFFVb1h8IDY3fFYCLQbDIHJ6o03RrL5u9gP2/+qYPFMqQ50I5PS5dTZ+K/cP04ZDsr+XEUK3cIH0SO5RD8QsV6krJNimtp8tywK9sCt+gzO3dRCvvbKZ7OpboEhZlkTBlCAF7/qdi22PHgqMVhQ6APrP2cWlnwXyZRk4UF54g7SWHG3hnG0GnnvO93kFVJv3gCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7R2bTQYqPybaPmHDbq954jrucxdh8d0rDLmRvWJjjPM=;
 b=gNq2GNgEuthfTt+ooeDSoi9cypiXeZGyQ0jQsz87BnwcLdFqovH4bICV4JlJcCiYSu8VU92cJDrXmz8q1DdHOsoBn2KTtx8Y4LbX9eM/uPFxWk0usQrFA7ZYmvCJ+6VZLz35fWeIBO1dFcNN17eszQu8Lw+JFrT9wpwF9YNNE7s7Pk6YOPZVhLafRBtq40lnJBOTg0avbyzyTXumxF64ZK03XQOUDagOqCE6O3ijNI/tj1xOL/8Xr+70c/Nw2fT7LaosDp8cUtGPjzSEF5yH6B/aAX52Q74wDEyetR6+QOGYRgzmqOmnx1tWeH6K9Xjj1bIg2AMlVoFpXG5b5D9zlA==
Received: from BN9PR03CA0656.namprd03.prod.outlook.com (2603:10b6:408:13b::31)
 by PH0PR12MB7470.namprd12.prod.outlook.com (2603:10b6:510:1e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 17:09:39 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:13b:cafe::d2) by BN9PR03CA0656.outlook.office365.com
 (2603:10b6:408:13b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.19 via Frontend Transport; Thu,
 4 Sep 2025 17:09:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 17:09:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 4 Sep
 2025 10:09:07 -0700
Received: from fedora.docsis.vodafone.cz (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 4 Sep 2025 10:09:02 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
	<bridge@lists.linux.dev>, Petr Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 04/10] net: bridge: BROPT_FDB_LOCAL_VLAN_0: On bridge changeaddr, skip per-VLAN FDBs
Date: Thu, 4 Sep 2025 19:07:21 +0200
Message-ID: <0bd432cf91921ef7c4ed0e129de1d1cd358c716b.1757004393.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|PH0PR12MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: 39db87c7-2b32-4464-b707-08ddebd5d4c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DjULCRdtjwGU1rxAgXyP7GKbH1AlPq5Xs9thbMZrzt/31zKKF3hsKo8xwPaO?=
 =?us-ascii?Q?fUsZfAIw1tRPNt7ikedrcCm0mUn6rJA3yUKovq29NhzQIT2VKoXsC01nf7Xg?=
 =?us-ascii?Q?APukQAsg7H6xX2q6mrbPpnp07zHQ4ETbXbzBbxVyO6vvtLIJ8QrDfhzvKDy9?=
 =?us-ascii?Q?VguCqQ+azJ3QFW0AeKU6rbha+0SDAXjLhBSBXtxivv5jSQnlxgZWsfaonxvI?=
 =?us-ascii?Q?N0tSsRse7KyNKcqVgee1YIUfCR717j1MSFFF4AyfRpS3qrpQ+92BVInq7mn/?=
 =?us-ascii?Q?l5acjG6TXRGG2a+U/8Wra2AfbuGDPPJ34qeGhP7ELPSYxtKazWoqk7/h+V03?=
 =?us-ascii?Q?0gPPuMHkbNa35OtrJQB0CDuXD9lEcXph6iRRVvN8CqK0cjCO5wip6BUPOnPy?=
 =?us-ascii?Q?EfGYNHalE5zp3ypUvYXJpfIxJ6wmfcUimAQKXFL3V/lh5ItBwxo1GCGtiQIB?=
 =?us-ascii?Q?6gRuC9DzsAZk0Jr1PUDrpRIe/g39io269bs6ocQHso8fhreaAhpf1SeoIJDw?=
 =?us-ascii?Q?hXwVDlwc778WVFZe56mUQoieXGYLJVIKMixWlAuGEpboLbJnYmN5SIfAfSrv?=
 =?us-ascii?Q?Urw8UuE8XCr9M86SP+np66qCjrDedtGdVruss0TsFZ33dyzbR9l7GU8Fc1CJ?=
 =?us-ascii?Q?ZjfrhMzL/BWxZV3t6JWMh0RLqmDjjh5a5ldUoyiIZTILqD/GYwoIOFBTchZj?=
 =?us-ascii?Q?P3X8229Uh0PC2zYa0bmdz4DyaqrDvHmrts7wfNM4Zchg94GpQRafDoC9bznc?=
 =?us-ascii?Q?QpqnPlIJ+LaFv0K9XvfmBtyIysmZ3kdGg9G9GfzT50SUPNMQWqQgzZ7EcArJ?=
 =?us-ascii?Q?8SX7Is3yBczyLGrzvuHR12BYPuWpUQaO8Yr2YoW5+zUKfIewoS0/MBhO1jvN?=
 =?us-ascii?Q?upukiegEjTmYNDQ0/kaAMTzUhH7OmM7EWn07NkKROeudAeAgbuPbh1aUobuV?=
 =?us-ascii?Q?+62Gn38j48RdcI0p4U0RxHq8IYzMRr01Ne7vF0iAJJR1HXTefGiRzLT7auTf?=
 =?us-ascii?Q?gpcx0QXzZJ5Q7oHWas6Cl/sYA5jsdB5QxG+f8KnA2ZG/t4wK9JQ4eKZrvA9G?=
 =?us-ascii?Q?lJ0E3RDVrmdOYFgOuTAzJaT1rXtfg4TMVMjQFtbqC8KzgGG5jDM1pgVX4/PZ?=
 =?us-ascii?Q?VjHUfg37UsMx/q8N+Yk7z1/It8LD/HpdIU/CfQIA81Iet3v2oU1jy7C+l3TG?=
 =?us-ascii?Q?zHbq/LhSK3Ov6eeWu187wwLLb11HcNCSjR4vmnlNET6TNM4P/V+iRvTm1nR3?=
 =?us-ascii?Q?5sJgywA423Ch9b3NuvFiW6JtcxLOsaLFiIM4jxTXaf+UevNBmB8b5s/n+NbS?=
 =?us-ascii?Q?1TXW8CxUK/r1ILqJf3XyV2BoPVHYnmCWwj2lOvnJPwQ2wWX9kwVmHSKQX+f1?=
 =?us-ascii?Q?hTAcuu6eYAcX9SlxCVHr3Y6ety3nrIt72Xq3y2dycd1q6Ly+Th4TtiKcV6je?=
 =?us-ascii?Q?OXQp8stKrNBc2qE4hHmjn05zOU471muKyXoDsphOgSy2v4WWZWKNMb7DbRNK?=
 =?us-ascii?Q?QYD/LTerjnc9y6G493jTn9VNfSM1fJAXqaR+?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 17:09:38.4777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39db87c7-2b32-4464-b707-08ddebd5d4c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7470

When BROPT_FDB_LOCAL_VLAN_0 is enabled, the local FDB entries for the
bridge itself should not be created per-VLAN, but instead only on VLAN 0.
When the bridge address changes, the local FDB entries need to be updated,
which is done in br_fdb_change_mac_address().

Bail out early when in VLAN-0 mode, so that the per-VLAN FDB entries are
not created. The per-VLAN walk is only done afterwards.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 net/bridge/br_fdb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 918c37554638..4a20578517a5 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -503,6 +503,9 @@ void br_fdb_change_mac_address(struct net_bridge *br, const u8 *newaddr)
 	struct net_bridge_vlan_group *vg;
 	struct net_bridge_fdb_entry *f;
 	struct net_bridge_vlan *v;
+	bool local_vlan_0;
+
+	local_vlan_0 = br_opt_get(br, BROPT_FDB_LOCAL_VLAN_0);
 
 	spin_lock_bh(&br->hash_lock);
 
@@ -514,7 +517,7 @@ void br_fdb_change_mac_address(struct net_bridge *br, const u8 *newaddr)
 
 	fdb_add_local(br, NULL, newaddr, 0);
 	vg = br_vlan_group(br);
-	if (!vg || !vg->num_vlans)
+	if (!vg || !vg->num_vlans || local_vlan_0)
 		goto out;
 	/* Now remove and add entries for every VLAN configured on the
 	 * bridge.  This function runs under RTNL so the bitmap will not
-- 
2.49.0


