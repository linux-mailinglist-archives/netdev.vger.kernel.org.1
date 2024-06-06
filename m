Return-Path: <netdev+bounces-101465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A24E8FF038
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 17:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C29BF28781C
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AF61A3BB5;
	Thu,  6 Jun 2024 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MM+CG1hr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B8F19A28F
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 14:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717685576; cv=fail; b=WayuKUPy6FBW41LyQGumSmhQBv/22oPbZcr4B/2zgZxIyynWqEvSpom+hHdFHD3CvY4soe0lE0T8/7+3dzG+Jo5AE3QmJ+TNRQDId1yIec4bm2CtlTTEfGo6Qae440rCaEmiKR8Fz2sGQV9qj3vJv3BAdfZ2mKWRbHi2aMvV1Ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717685576; c=relaxed/simple;
	bh=1Ot6dEpZuJPzibSExxFVosMv5G8JiuvW+qDwkHP8zSM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0bR7ZbyrHsp+E5DsCUf8B25gBWeU5v73m+dkAvKwhq8vlpGA7kAk7PVOOkOnFI4W6MgLMSLrnEfevYWk3cXIUc3B0Yq/nA/Ityc5N5+1tORYJ8u1vXHf+XMneZg7ybMIdxS304C+jNZRW/8f+mCuXdnjGCLjDYK+yylZ1pjgA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MM+CG1hr; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7AIFhJjGveDTd1dzuDqdZdX37xIIwrHM+CM0VM1x/da6zx4NhooecNA5lPKpZEVQ1dHsE/I8fsiDes2NJDaA9Mzgm+8QNCWRS4CAyPNkNotQd+scbjiONquZCpK79EqK2U2crW3X8em78IRC3PL/NmLBQrv+NmbYilKZwai7VO7vbKuyEKJB7zRGv13YeMMDLAAV3kQM9ts87uP/RY1x8MJ6crEYKmj5yWE5q7gvCgKmzXnJuXCVnR5pRTQHhuCpGl35CjrwWQdY/76RO52QyrNTmYlg3WPD65f1buswWBcgaCZ5Mq83p1Jtmi/19IMPm7lxwz08DZ1D8HoyXWVNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7AaCTwVGE5lr6hgNG2Py+t/1f29/Om6SOuA4dEMY6I=;
 b=bCbWgfcqgajZc7bDQIgBQqAIXa4lnmGeJD+NN8rJPkLzviToyELCy63bytj1a0iPYfeZ11touvzEP/CeZ+NfTGzmzmLwuB0KIF1bEBfl3QrpSlk6/RtLZKZVot/QCbY+5PqmRgQ5tFwGopy1XV5klb4knpjujJ42orp3YnrxX3CimkkbAuUlaFyy9TXdWOpdg6lZeB8zSTJ8quibLWThoSQWKIL0HkfwIKJBKTTApZDXIXPkpf2uDw6SWxSUUHLtifOkRuMH3KX8LW53VNPc5m9Qdl5tlMpqsw6yca61WxTE7Q2bkT8rJb1k+Q5EnpY9fY2N65MuZ+MchVHLLZg4ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7AaCTwVGE5lr6hgNG2Py+t/1f29/Om6SOuA4dEMY6I=;
 b=MM+CG1hrEqzKbykCpcqXQxxbAcG/HD05d52IrTnW8j7X5ExRebel2yK/ocvIzSWTpCxURCiriJoWoIrT5VPiS5QXTpkwjhJRv7cN9lrOYUxYsnJOYNopidzb5J7dLERSipe7pi9HSEqT0SF1c8z0Z0hnwygbu9TGZl44dbGS34Ld3PaeN6emaFx0ItbjlJqZPdXn6u51c4mwZCz3lyRMzL3ywrjuD7z01HOYzrzHSCPfNUUvGiXbXYziMpU/HaMhSBLB4KbXMe9xBEWsaLhpN3XtsYQ0m9KKDBWvSwyWByYIVthyP9TKdXdmvep5AvuQ95dVUcrJIk/DxHfGhCPq3w==
Received: from PH0PR07CA0052.namprd07.prod.outlook.com (2603:10b6:510:e::27)
 by DS7PR12MB5910.namprd12.prod.outlook.com (2603:10b6:8:7b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.33; Thu, 6 Jun 2024 14:52:51 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:510:e:cafe::1c) by PH0PR07CA0052.outlook.office365.com
 (2603:10b6:510:e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.20 via Frontend
 Transport; Thu, 6 Jun 2024 14:52:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 14:52:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Jun 2024
 07:52:30 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Jun 2024
 07:52:25 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Amit Cohen <amcohen@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, Alexander Zubkov
	<green@qrator.net>, <mlxsw@nvidia.com>
Subject: [PATCH net 5/6] mlxsw: spectrum_acl_erp: Fix object nesting warning
Date: Thu, 6 Jun 2024 16:49:42 +0200
Message-ID: <c0c27909a09b9a47e03beb643b83784f75c7952c.1717684365.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1717684365.git.petrm@nvidia.com>
References: <cover.1717684365.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|DS7PR12MB5910:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e38af9d-0e71-4a82-cf9f-08dc86385692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cFADqFbTnHPmDPMyldrCP2VEllaswXAFn7BZptPtosSY7mWfehIVHQ1Fv6Ta?=
 =?us-ascii?Q?dRnaXr1ruFYDb1E38tl9U77i5e/ZgL6PQtOWsSUxg/KEvWMGR3bqgUYrw9b7?=
 =?us-ascii?Q?CxsXiMOGwxtyFoCtfj7dHhHzkU/Mn9sEvFPp62pCXjGvA/Fdy6XlQ/Uz8AFV?=
 =?us-ascii?Q?aBFv1kzyPaEKzu+EkM8/8oT1Nr1VpF8VD77ZDeRpEWHU0wn+M5ukEaRYTsEv?=
 =?us-ascii?Q?vUos0q7gLTpqR4isqZUbf4ARRZ5lCni6MIp8FfdFj8qDilAIsFJRAjgdBbQ+?=
 =?us-ascii?Q?JNP/3S/IS+rLh5DnXjDSJ52CTtafi+k2DNcb5jySPL1MtevLL2EcHftKgZa4?=
 =?us-ascii?Q?30+exwCcJ1vqL7+P4UvODaRPC3sQOt+E0nxNoH4cSEbR0hGcR/oAK7AwSnrG?=
 =?us-ascii?Q?XN9mBislwx2/PYgyHgbAcio5EPEMYGYb/6y5HLeld8eimsaD28k6GCMyi069?=
 =?us-ascii?Q?1z6IHANiaLUoFfIJF3Y9/WShlmWpVhUAn9wlW9qey5Zc/HRlUU6LG9o/Zwjc?=
 =?us-ascii?Q?oICK0v7MWh0m0WmFLPnjyjTNlr1j5uu7BOADlKhqFSVKi34l/NjQfmqRx+VN?=
 =?us-ascii?Q?PpwXJmeSFe4qcGvF3BZBXKhzhIlX5yHC7xhwahUCI2uo83OXYPoiC42CkE82?=
 =?us-ascii?Q?r0GydWapzCF8qKrvHBR92AD38GGfeA+8Z5BPv111ELsnMxdu3x1z3g9IC1Yj?=
 =?us-ascii?Q?g7hXtizwBC6rN+76wh/LGN5Kwwu5yba3ecYIhvPmhSnJ2jGPGv01YO4x2aKe?=
 =?us-ascii?Q?c2Tvg5vxyhwxsh1irzcpb2YS14oADRbTze0K0zFbbDrGjj3Suw7vrc3mJ8pf?=
 =?us-ascii?Q?i1PwXpD3F2Xl+d12M6DQzFrJTnxB3wWvmBE0BmzAQzrcjLqA2yMeDNMZcupI?=
 =?us-ascii?Q?tvmnbla5sZQUYmQJ8W2evdPDrg15/o5FYSU0p8T1WmDad83gNEww6sQGL8+F?=
 =?us-ascii?Q?s+GEHhD/DehU/L80HUr3fhiNEs6LvRq/+QC2XR8MSp7+9E3eZaWso2Lgb3GE?=
 =?us-ascii?Q?+X9aVcD+gl0ZD6T892KtcnO5ao9DjHzKttfJN8R2ZTWl0wO2/J1KGWceDSUl?=
 =?us-ascii?Q?wcl+jMM8yiFcp49GKq5m3T1Mu6OHbdPmJdA/3SJCYzT6OZ4s83oHHQ8+vw3O?=
 =?us-ascii?Q?W8e5130U72o6hp13S2/q/z6m8QdGCBoiaDdlmgd40g+jcGq6J8Xnc6v6G66A?=
 =?us-ascii?Q?cr5xsFGOs8uQVCUnAQJtc6D800vKbeW30MMwMZlZ9/fju+KgN0jaABpFwLDJ?=
 =?us-ascii?Q?cJuPe30rFwzdBmy4B8KLmKpi3QvLEUPjxPalT89JQKzq9fyZBlaJ8EqXYoAm?=
 =?us-ascii?Q?vN/DGjAsf14jnoA3UHbcfUEn1/lAXihWTy2QmX5+dSC1xk+zDi/dso2QRrMv?=
 =?us-ascii?Q?kvJjIOOm3a/+GILuGxUarmHjAtApLakkUcyOfLvYeMflheHFdQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 14:52:50.6957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e38af9d-0e71-4a82-cf9f-08dc86385692
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5910

From: Ido Schimmel <idosch@nvidia.com>

ACLs in Spectrum-2 and newer ASICs can reside in the algorithmic TCAM
(A-TCAM) or in the ordinary circuit TCAM (C-TCAM). The former can
contain more ACLs (i.e., tc filters), but the number of masks in each
region (i.e., tc chain) is limited.

In order to mitigate the effects of the above limitation, the device
allows filters to share a single mask if their masks only differ in up
to 8 consecutive bits. For example, dst_ip/25 can be represented using
dst_ip/24 with a delta of 1 bit. The C-TCAM does not have a limit on the
number of masks being used (and therefore does not support mask
aggregation), but can contain a limited number of filters.

The driver uses the "objagg" library to perform the mask aggregation by
passing it objects that consist of the filter's mask and whether the
filter is to be inserted into the A-TCAM or the C-TCAM since filters in
different TCAMs cannot share a mask.

The set of created objects is dependent on the insertion order of the
filters and is not necessarily optimal. Therefore, the driver will
periodically ask the library to compute a more optimal set ("hints") by
looking at all the existing objects.

When the library asks the driver whether two objects can be aggregated
the driver only compares the provided masks and ignores the A-TCAM /
C-TCAM indication. This is the right thing to do since the goal is to
move as many filters as possible to the A-TCAM. The driver also forbids
two identical masks from being aggregated since this can only happen if
one was intentionally put in the C-TCAM to avoid a conflict in the
A-TCAM.

The above can result in the following set of hints:

H1: {mask X, A-TCAM} -> H2: {mask Y, A-TCAM} // X is Y + delta
H3: {mask Y, C-TCAM} -> H4: {mask Z, A-TCAM} // Y is Z + delta

After getting the hints from the library the driver will start migrating
filters from one region to another while consulting the computed hints
and instructing the device to perform a lookup in both regions during
the transition.

Assuming a filter with mask X is being migrated into the A-TCAM in the
new region, the hints lookup will return H1. Since H2 is the parent of
H1, the library will try to find the object associated with it and
create it if necessary in which case another hints lookup (recursive)
will be performed. This hints lookup for {mask Y, A-TCAM} will either
return H2 or H3 since the driver passes the library an object comparison
function that ignores the A-TCAM / C-TCAM indication.

This can eventually lead to nested objects which are not supported by
the library [1].

Fix by removing the object comparison function from both the driver and
the library as the driver was the only user. That way the lookup will
only return exact matches.

I do not have a reliable reproducer that can reproduce the issue in a
timely manner, but before the fix the issue would reproduce in several
minutes and with the fix it does not reproduce in over an hour.

Note that the current usefulness of the hints is limited because they
include the C-TCAM indication and represent aggregation that cannot
actually happen. This will be addressed in net-next.

[1]
WARNING: CPU: 0 PID: 153 at lib/objagg.c:170 objagg_obj_parent_assign+0xb5/0xd0
Modules linked in:
CPU: 0 PID: 153 Comm: kworker/0:18 Not tainted 6.9.0-rc6-custom-g70fbc2c1c38b #42
Hardware name: Mellanox Technologies Ltd. MSN3700C/VMOD0008, BIOS 5.11 10/10/2018
Workqueue: mlxsw_core mlxsw_sp_acl_tcam_vregion_rehash_work
RIP: 0010:objagg_obj_parent_assign+0xb5/0xd0
[...]
Call Trace:
 <TASK>
 __objagg_obj_get+0x2bb/0x580
 objagg_obj_get+0xe/0x80
 mlxsw_sp_acl_erp_mask_get+0xb5/0xf0
 mlxsw_sp_acl_atcam_entry_add+0xe8/0x3c0
 mlxsw_sp_acl_tcam_entry_create+0x5e/0xa0
 mlxsw_sp_acl_tcam_vchunk_migrate_one+0x16b/0x270
 mlxsw_sp_acl_tcam_vregion_rehash_work+0xbe/0x510
 process_one_work+0x151/0x370

Fixes: 9069a3817d82 ("lib: objagg: implement optimization hints assembly and use hints for object creation")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Tested-by: Alexander Zubkov <green@qrator.net>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../ethernet/mellanox/mlxsw/spectrum_acl_erp.c    | 13 -------------
 include/linux/objagg.h                            |  1 -
 lib/objagg.c                                      | 15 ---------------
 3 files changed, 29 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_erp.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_erp.c
index d231f4d2888b..9eee229303cc 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_erp.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_erp.c
@@ -1217,18 +1217,6 @@ static bool mlxsw_sp_acl_erp_delta_check(void *priv, const void *parent_obj,
 	return err ? false : true;
 }
 
-static int mlxsw_sp_acl_erp_hints_obj_cmp(const void *obj1, const void *obj2)
-{
-	const struct mlxsw_sp_acl_erp_key *key1 = obj1;
-	const struct mlxsw_sp_acl_erp_key *key2 = obj2;
-
-	/* For hints purposes, two objects are considered equal
-	 * in case the masks are the same. Does not matter what
-	 * the "ctcam" value is.
-	 */
-	return memcmp(key1->mask, key2->mask, sizeof(key1->mask));
-}
-
 static void *mlxsw_sp_acl_erp_delta_create(void *priv, void *parent_obj,
 					   void *obj)
 {
@@ -1308,7 +1296,6 @@ static void mlxsw_sp_acl_erp_root_destroy(void *priv, void *root_priv)
 static const struct objagg_ops mlxsw_sp_acl_erp_objagg_ops = {
 	.obj_size = sizeof(struct mlxsw_sp_acl_erp_key),
 	.delta_check = mlxsw_sp_acl_erp_delta_check,
-	.hints_obj_cmp = mlxsw_sp_acl_erp_hints_obj_cmp,
 	.delta_create = mlxsw_sp_acl_erp_delta_create,
 	.delta_destroy = mlxsw_sp_acl_erp_delta_destroy,
 	.root_create = mlxsw_sp_acl_erp_root_create,
diff --git a/include/linux/objagg.h b/include/linux/objagg.h
index 78021777df46..6df5b887dc54 100644
--- a/include/linux/objagg.h
+++ b/include/linux/objagg.h
@@ -8,7 +8,6 @@ struct objagg_ops {
 	size_t obj_size;
 	bool (*delta_check)(void *priv, const void *parent_obj,
 			    const void *obj);
-	int (*hints_obj_cmp)(const void *obj1, const void *obj2);
 	void * (*delta_create)(void *priv, void *parent_obj, void *obj);
 	void (*delta_destroy)(void *priv, void *delta_priv);
 	void * (*root_create)(void *priv, void *obj, unsigned int root_id);
diff --git a/lib/objagg.c b/lib/objagg.c
index 0f99ea5f5371..363e43e849ac 100644
--- a/lib/objagg.c
+++ b/lib/objagg.c
@@ -906,20 +906,6 @@ static const struct objagg_opt_algo *objagg_opt_algos[] = {
 	[OBJAGG_OPT_ALGO_SIMPLE_GREEDY] = &objagg_opt_simple_greedy,
 };
 
-static int objagg_hints_obj_cmp(struct rhashtable_compare_arg *arg,
-				const void *obj)
-{
-	struct rhashtable *ht = arg->ht;
-	struct objagg_hints *objagg_hints =
-			container_of(ht, struct objagg_hints, node_ht);
-	const struct objagg_ops *ops = objagg_hints->ops;
-	const char *ptr = obj;
-
-	ptr += ht->p.key_offset;
-	return ops->hints_obj_cmp ? ops->hints_obj_cmp(ptr, arg->key) :
-				    memcmp(ptr, arg->key, ht->p.key_len);
-}
-
 /**
  * objagg_hints_get - obtains hints instance
  * @objagg:		objagg instance
@@ -958,7 +944,6 @@ struct objagg_hints *objagg_hints_get(struct objagg *objagg,
 				offsetof(struct objagg_hints_node, obj);
 	objagg_hints->ht_params.head_offset =
 				offsetof(struct objagg_hints_node, ht_node);
-	objagg_hints->ht_params.obj_cmpfn = objagg_hints_obj_cmp;
 
 	err = rhashtable_init(&objagg_hints->node_ht, &objagg_hints->ht_params);
 	if (err)
-- 
2.45.0


