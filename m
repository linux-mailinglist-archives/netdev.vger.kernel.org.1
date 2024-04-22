Return-Path: <netdev+bounces-90189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 349F78AD0BA
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 17:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BAAFB25F64
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 15:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF272153569;
	Mon, 22 Apr 2024 15:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kn9HjQRd"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152F91534F4
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 15:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799757; cv=fail; b=A80QrfXSzHemtdmeCBEHQargnXFiNQSs/+2UZPa3nVlVCmUH09scy2YKaCY7nUZK5QKWIq2U2fbeOrX+fMAOWwru7y0jVp/xYw978sr9kyXu6FCLlHFCX+P8LroS/VDzrypnDx5Hlw7Q0uSdh0i/eT3b3bLMKYKLfiJTsdAdoWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799757; c=relaxed/simple;
	bh=zjmDg7kQ95x+wvWuB+2TCy4i/6gAUTWSOYtvhLoWiXk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rxgf3CXncxnnSz+CR8fsYug1vB2K/JepLqlAzgt8QAoY4y4Pwf/ZICq730HiD19Vknscgy2hN7NPVdBhzeopqtKjyRwPl+6zsY5dOX9iN17/MJtO3LKr0QfYKYzPOGilfKpHmDmf7SPDWU4clqDUSLcsbB9R+jwBU5FYyD55VGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kn9HjQRd; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBFoz1QPGkHAba4SLRReKwtYdUCTzAQFMLi0Ta1VHf1rHJiVQqp9T99NbS+TgLoEPzTNJmagbB4WARzlBl21zFo2zDhpCgXapXJd9Uuu+SWxQaKYqrznMVILKCA8tjqinyviylMbVXY+I6/r/Nfqn2vhPI133kLC8eBVp2eOEwrE8HV5YLAJ2/37qRmn76RvEpNHMQHsiH8ceaAKxnfbtyyhUkuXUnBhj2YsTmlaN1ar6kYnimFbfq6rmjjQiMXwgAaAyR0mdXiqx0AizOvTv9CIs5+O7JA3YEkeEFus1hJedVra3bOzfQLJaFyNXSR/hnENBkma+iUPsbldyU5nRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNT04N5LC1Hh67iscuF1FoHCvNFzSTFAdHmYzlGRBAE=;
 b=N62owu4mngnoT4jqFhg0FCrbVfpMtsElWEmQm8M8ML3ViKuP8jlq4mt34ePkqxJBlS1YaGvoE8ZYpC9IWfAzj8LP50WgzuQtTKMsWmEn29fg/MrdVTBcKw7p1ce6aHrAH7YbduUp/vi1F1h012Q4gIVGKhCTtD63wPM+qksketuJ58Y0sFilXqm5FuS5a7opIlxKhpzOyRzy53n/56jc9fYyVwTJ6MPVJo8VhBXMTaEUj9Omk+hsscOuEED+w96dngQyBW0PD2Iap38MLNMEJBsn/n8EwD+u8FfGg+f4p9FviixHo6trcwisVkUlOZVW/5RcX975P4VjH55SEoVTLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNT04N5LC1Hh67iscuF1FoHCvNFzSTFAdHmYzlGRBAE=;
 b=kn9HjQRdRukZe5kHivVV1bykjaXCAbeC7BIcy73luZqwdBhkTJMXKNARkykDEhu8EiN8JzExW+OVm6WElkdfaJhfSzau/RHvwO4OPtjyHCbaZlgiSvz1znbCkkouhi0s3oU1pUmQq77Igh+Sh/10a/RDhyR/mDu9SkZJWdNmAJV8df3v+pcxhpsPxEv1QyV9xlxffG11qKwMNPGm7kouxrRYv+TYiIUWK/hvCB9G8qOcRR+8ugO4SyT8SqDxwIbim2TJ2UfsJyddGeIIty2UX+bWYi9I4VCfO4svsbjTUUyorQDq3W3JkE5e7s/f3OYGFMO+yvWmDtrT48Po8HnLjw==
Received: from BN0PR03CA0049.namprd03.prod.outlook.com (2603:10b6:408:e7::24)
 by DM4PR12MB7672.namprd12.prod.outlook.com (2603:10b6:8:103::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:29:13 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:408:e7:cafe::dd) by BN0PR03CA0049.outlook.office365.com
 (2603:10b6:408:e7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Mon, 22 Apr 2024 15:29:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:29:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 22 Apr
 2024 08:28:55 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 22 Apr
 2024 08:28:51 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, "Petr
 Machata" <petrm@nvidia.com>, Alexander Zubkov <green@qrator.net>,
	<mlxsw@nvidia.com>
Subject: [PATCH net 2/9] mlxsw: spectrum_acl_tcam: Fix race during rehash delayed work
Date: Mon, 22 Apr 2024 17:25:55 +0200
Message-ID: <1ec1d54edf2bad0a369e6b4fa030aba64e1f124b.1713797103.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713797103.git.petrm@nvidia.com>
References: <cover.1713797103.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|DM4PR12MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: b2b20f75-da54-4e38-6bf7-08dc62e0f6bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uJzGfVS8GSpRDc45RTJb551SE6Qk1/sc5LPrdZnUD9iDtl0DWG94i1B9/3le?=
 =?us-ascii?Q?9kGCP0IwSuXlegg3imD7mWlWgdthYQQA4nTiauakHbPHj3lsnOOgge3X88rg?=
 =?us-ascii?Q?Ono8DcRnNMm5ov+Mhrj2lEE5bBQXABEHwUVyX7qvGR6iEvVlVBZBSXT4gUiX?=
 =?us-ascii?Q?Tz1NKeVq5KIJBr3xsiLlndMNyBq1PDBGKkP3Dlmdn/JwBdPs1quGLP8fZmSs?=
 =?us-ascii?Q?1A34QcV0+EIcztWaQ3wCkpkR1h1mwtSnTgKaGfWPubq18PVhdfqmc8L+s1XK?=
 =?us-ascii?Q?Y+eLilXkcfz/tPzUxi4+Ue8HiE6299H5Fxpfd2Ug5Qtsmby6lhydSkeR2gG5?=
 =?us-ascii?Q?jV6ndwQHrpuQl5a5lslT/+CgJjtwOMnCaW8iT3yVCZ48zLUalhkNNOAtu6Je?=
 =?us-ascii?Q?lhDuW/MWIh3NNOAsu8HsajwBZ88OTpklzg1mYaV30FNqbvaNbYuP0dPq7k7n?=
 =?us-ascii?Q?nuCVsUe5jLawX4DD2UWswCjZqxqFDUc7WvHnofXQ6VbBtSnGUtp6PbDBN7yw?=
 =?us-ascii?Q?FoFQogHmpU1DYgKAq2bfd6npoea7/pN1duTBrE9k8PRwXtnpTHS3KRCjy3z0?=
 =?us-ascii?Q?7FQKJTqxlJE0a7SPpI3wsE67YjYrGeBIi1PlL5jH9ayDwIx0LM7QRybnv15D?=
 =?us-ascii?Q?QLHPV4HqodN1b7NWc4W3OJu6WS9wCR+LvhgPIdCYtkcmHkQoydznEkNwjaLe?=
 =?us-ascii?Q?SC5nIlfT7HVK6E/FbrdbasDwRvVwgLad2aplOIEBuWMDKUQ/M2qkO8pNLKau?=
 =?us-ascii?Q?L8i4v6F+hk7wJ4buHvsIVTb5aWUzeK8xa6vqgWc3yLRbR0x8rNljrsKHd9Dp?=
 =?us-ascii?Q?LyuFyJXrxZ1wYvAOC/4Zeqr88Mdr3ylz/E5mjErSMPirXG6Q2Zv4jqgUkvG4?=
 =?us-ascii?Q?BdpvtA8Pt91Xhw5qkaPHCkuFzk1SRQ2m7bWc5RkYaPCg0EQEyREfn3Yusn5g?=
 =?us-ascii?Q?VA5r5UR9Z6BvoKabTbzZQDBzCEWFAQMvyeTbKWsjNcy5/pOHA/2gv9zF919G?=
 =?us-ascii?Q?0mxO/2CNXNjrGRnCWVbpQT8gFDUr8rTJLTI8+DRzYX0SVPwAQY7vwT1RvvbD?=
 =?us-ascii?Q?stps3WaxIze8lA/Ju53U9pm0dUdlJ552l6x/uT8zkWRSfkdIgzUcMVpN0AnB?=
 =?us-ascii?Q?otVArh5g/WyrquqLQPB13tbiufVQqPrIxPsy2SFufCPsVQQoWpdtS5/UBFO6?=
 =?us-ascii?Q?TLo29LpOEfVdnE56RFJoY9IxtI/YHdzH+fjOwC6hC0a9y+2vdCdlNcDAUB5f?=
 =?us-ascii?Q?xKEpRYeAijAD1lwJBwGLy37/C8midQ2jnd83PyiywA3RT7CaiTewvHXkfMCF?=
 =?us-ascii?Q?ACOkS4xUSoD28mQCHFVTyteZcXxAfzwu7wOpRdyCg2nVYdr2nDnHoqVPe81E?=
 =?us-ascii?Q?j4YHteXGFd1FQICekAXrAOUiLppC?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:29:12.9516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b20f75-da54-4e38-6bf7-08dc62e0f6bf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7672

From: Ido Schimmel <idosch@nvidia.com>

The purpose of the rehash delayed work is to reduce the number of masks
(eRPs) used by an ACL region as the eRP bank is a global and limited
resource.

This is done in three steps:

1. Creating a new set of masks and a new ACL region which will use the
   new masks and to which the existing filters will be migrated to. The
   new region is assigned to 'vregion->region' and the region from which
   the filters are migrated from is assigned to 'vregion->region2'.

2. Migrating all the filters from the old region to the new region.

3. Destroying the old region and setting 'vregion->region2' to NULL.

Only the second steps is performed under the 'vregion->lock' mutex
although its comments says that among other things it "Protects
consistency of region, region2 pointers".

This is problematic as the first step can race with filter insertion
from user space that uses 'vregion->region', but under the mutex.

Fix by holding the mutex across the entirety of the delayed work and not
only during the second step.

Fixes: 2bffc5322fd8 ("mlxsw: spectrum_acl: Don't take mutex in mlxsw_sp_acl_tcam_vregion_rehash_work()")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Alexander Zubkov <green@qrator.net>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
index b6a4652a6475..9c0c728bb42d 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
@@ -718,7 +718,9 @@ static void mlxsw_sp_acl_tcam_vregion_rehash_work(struct work_struct *work)
 			     rehash.dw.work);
 	int credits = MLXSW_SP_ACL_TCAM_VREGION_REHASH_CREDITS;
 
+	mutex_lock(&vregion->lock);
 	mlxsw_sp_acl_tcam_vregion_rehash(vregion->mlxsw_sp, vregion, &credits);
+	mutex_unlock(&vregion->lock);
 	if (credits < 0)
 		/* Rehash gone out of credits so it was interrupted.
 		 * Schedule the work as soon as possible to continue.
@@ -1323,7 +1325,6 @@ mlxsw_sp_acl_tcam_vregion_migrate(struct mlxsw_sp *mlxsw_sp,
 	int err, err2;
 
 	trace_mlxsw_sp_acl_tcam_vregion_migrate(mlxsw_sp, vregion);
-	mutex_lock(&vregion->lock);
 	err = mlxsw_sp_acl_tcam_vchunk_migrate_all(mlxsw_sp, vregion,
 						   ctx, credits);
 	if (err) {
@@ -1343,7 +1344,6 @@ mlxsw_sp_acl_tcam_vregion_migrate(struct mlxsw_sp *mlxsw_sp,
 			/* Let the rollback to be continued later on. */
 		}
 	}
-	mutex_unlock(&vregion->lock);
 	trace_mlxsw_sp_acl_tcam_vregion_migrate_end(mlxsw_sp, vregion);
 	return err;
 }
-- 
2.43.0


