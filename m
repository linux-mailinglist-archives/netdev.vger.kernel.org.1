Return-Path: <netdev+bounces-101466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEDE8FF0B5
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 17:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8ADCB304A9
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CD919A292;
	Thu,  6 Jun 2024 14:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uaoKeRpI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36D01A3BCB
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 14:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717685579; cv=fail; b=JwdlBmiZoVEY2O1uwMpiypWcy27DG0282BSnuiFZfnGBun/tIkTaT3BP2P49WQ1dhSQHnzTUBpLzy9oxCUnHtgSdqzrn8D0KnaOISkHida4vyXRy41pxkSgiCeiItH1EqPwF1JLKh/yCRIjvX9pde2ziZce35NwnoK98jUF8Jis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717685579; c=relaxed/simple;
	bh=JVUozyMqXjuV2jd0QiHCt7tQ6pG7ivNpWwBxEnoWOEU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RIirgtPSeAq2gx9DZlBqev3d0kw3b99dTOw2apDr7woCPJwWqOrPYC657ogIIezcxyhpQ6cxNvW5gT0b2QGylodT9aF1T0NYcsqHPIkrrmKSZqNL+4s01PlkjFOUgOZmu/v1ydItToTflmpJSMA0U35EXDONoH208bLrUNoXqNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uaoKeRpI; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbB/drG2q3gZicz66NAaVq8zShHOcJsXhDg2q4rlpqpX74u6pM/B9ZHTP7KVtiEeGaeRJMNdQ8PDM6QZCLwIUXh5dAtp4jkxEXAdrM47EqWCqwKBu3l7IZOcQUVs+BpZGnYdxfSVi8h6UFvxm2yaYGrOnsecXf1wroaolIZBM1hb6HvDjB2Hxj2VdkjjkZcClhP7+cyTVc3ewez9Sd9hRYo6QU2jzeK8Le/W5AJeJb9WPv7zqzSRdr+yxaAq+UYlKI23AzpGuJTGU2Z/nPZ3ZXYLMd5+A334reAoY1uUKRFD04vEFb2Oyc0RT6GvzM6pb7O1TN2hANJ8+pX9fW40eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HK+qnbULRo5YM+LmSoO38zzTl+sSsSUdFhR/rF0v81I=;
 b=IPWsRx+Wjei6wMOAL8JHvoYVVkuxc2/w+0JRlBC+mfDnCkO1HRGZihpg6r7mPN2rVinlauZgetGZMDhYjxLmsHc2RtVL8GFXdF8oHJ7Y3bA8Qn0PQtdXUs6CeQoGiPpdWPr7ysIzFOpby1bQXfezWHqW7BRFgD2ER4PLvN9yVrYFa6UDmuufUS/YsE40TDlHxw8ndDSnncgjQJAyUxGp3vuxObHmD6v50w7m/AwIv7rDDqO04I+AyUTMNsDZgudIglIf4S0N9y0PH6e/4Ed3ANNX0USj6LoK24Z9WVksxfs765SegfdfLFHm2NZrQObc/1jY423VRlh6GFP9i9g2CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HK+qnbULRo5YM+LmSoO38zzTl+sSsSUdFhR/rF0v81I=;
 b=uaoKeRpIrBTh26ps0xsbA6DD7UVq95muGkEgjF8UditwmGiaZquBDnPg0p8SfcrApuabxuZQQ7kD1rp4FYycopchM08iwS+syTlTg/E3L2hbBo9bWEHrLZGBHaO3i/j02rnY3w6q6IBc8KsQyutUTEWUYtHwesXr7RmknFe9S98wOmRfGnRLGYLrx8/6QGBJafpCO+kGvqer2vaI/flTHSg9BsvPNmNXS8xTO6kYacuB1bvqmoQujW+VGdwpvi4JjS9g/w81zbfu9E6N8+OQCyvZ0gEId3puXIZB1cOENz+prdnSCBj8mOg/q5joz/88z1oxTn06ICIAdMSp0OxXzQ==
Received: from MN2PR13CA0005.namprd13.prod.outlook.com (2603:10b6:208:160::18)
 by MN2PR12MB4142.namprd12.prod.outlook.com (2603:10b6:208:1dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 14:52:54 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:208:160:cafe::30) by MN2PR13CA0005.outlook.office365.com
 (2603:10b6:208:160::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.12 via Frontend
 Transport; Thu, 6 Jun 2024 14:52:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.0 via Frontend Transport; Thu, 6 Jun 2024 14:52:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Jun 2024
 07:52:35 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Jun 2024
 07:52:30 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Amit Cohen <amcohen@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, Alexander Zubkov
	<green@qrator.net>, <mlxsw@nvidia.com>
Subject: [PATCH net 6/6] mlxsw: spectrum_acl: Fix ACL scale regression and firmware errors
Date: Thu, 6 Jun 2024 16:49:43 +0200
Message-ID: <94b8fd1b4c4db16c7df0bb5ecdba731b1d45d4c5.1717684365.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|MN2PR12MB4142:EE_
X-MS-Office365-Filtering-Correlation-Id: 41dcff01-20fb-4316-8f35-08dc86385881
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MwSP6E4NidgfGM9Y4mbRocHMOXYDMq2lJbSpqFOS1VQbNAeAe0IPBwB1K3zx?=
 =?us-ascii?Q?HdBIZrijPuDWUfArcQOhfV7+6RikeCngoahO8MmEjwZmlL9COYfVpxeV3TxF?=
 =?us-ascii?Q?zJ3CIBdl1aQy8YCFmHyOxSETXSAJKw+hzS2T//t/10/U4GH7f3TfmJBJ3xbS?=
 =?us-ascii?Q?gORlX3pZt7/aZw8jMOVHkXxQEWHcRkIzHJXZVP0n2rcfMZbSq6ynVqPKpWQR?=
 =?us-ascii?Q?yLvUK3GPDQLnQbAZmvfOa1Lu5SphSUG7o+ccjrL2Hzm1rUvU7p1Vw7/I0QeV?=
 =?us-ascii?Q?dNVpDDOn9fecFv6pYIf1aSKwTYfEUd+4fcgqykq3MoQWK90bSYoRjI/5cM/G?=
 =?us-ascii?Q?vmgcbIaRgzhE9trdFtOK3+95Tbh+gtpQfeBXmItKKgN9lstDC6qLzmelnpkx?=
 =?us-ascii?Q?lVpQIXkC7BZQTxkGlp6khxDWfIfdc1yFYBlcRKad+MEOTkDmhq3IcMgIn7ep?=
 =?us-ascii?Q?q+UeMWFETDQWWpKQLORzEGR/LJVqQU8yL9hN8nRvRWSVIazqYckVbBFg8pt7?=
 =?us-ascii?Q?pOzFq8xIA1JsT5JzYkTXCfTwPw7gVm6eBCbsZy83MfNDEU/u+RD1N+IlM1G6?=
 =?us-ascii?Q?KKABcTicEL0KvLh9+Ob3g60VTLw/0COirV71x1aCjptHcTfItetX+ZDVo+hO?=
 =?us-ascii?Q?e89im/HoKysfebY8gndd8r5LCLuPw8iDbPoJVIE4eHj5ZQFmR4EWwwTNRTQE?=
 =?us-ascii?Q?8cTN2qPt7X15ydOE5VamcpWKBsJyK6ZcQ1wKhGiMA7Z6tyvzzvD8BE4mulf7?=
 =?us-ascii?Q?hP0nt4dhbXunQfjpUu+JbGA7wXPAQDhXSjQ/T1L2xQ+5Uf5KVUzajCDefrju?=
 =?us-ascii?Q?VPr7E6oFUhY9Z0MaaACs7tmYruWemp86q6+u0CXq5FOTM9WKksriq+s1lPjT?=
 =?us-ascii?Q?/3ueopZKq3ym5JeQFt9lt7g6d2oZYISe+K7UvSi6GP01NpZ5EA/NmG4hrPpb?=
 =?us-ascii?Q?7fxsUG0PLSdE6LDnEdRDp6Cll2JmPGrIiQjLGnZ1a/B39G79b0IvUV/SJ1ss?=
 =?us-ascii?Q?K/amITtAD/KC4FuAF3qE4MxqWRIRkR0SHwSS4Io3CNF58N6FMxbWiqoocr5Z?=
 =?us-ascii?Q?0pLB8O9Oem9BuWlDC0uyj11KI51E/nLlQEm7n/z2gWUVzo8UJDammTMCqIhA?=
 =?us-ascii?Q?zpq/ucWLU6WZPgZzz3IO60/9SQVbQIFLZtBQRWhHl9oCByeMWva05heHbIdB?=
 =?us-ascii?Q?N93fKxRMRQt0I9GLPlcN9egsur7tQ251j5wPdUTOHVS+Y4bTVPTuXnMNUgxu?=
 =?us-ascii?Q?IMfU7dvQYh9WEbRtcyqgHIvp+HgBNEA1klXbNBhtiO9Pn6xJvRCQ61/ePryZ?=
 =?us-ascii?Q?ciouNFRcXVTT1BSdpfE0mLzqF87tuS47+auae7BNJn1u6qAQXOb2NbJG81hO?=
 =?us-ascii?Q?gA4IA6lPip946OhTqgs2gPda45NfiCELiNBnwDHILxGAgFVeGA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 14:52:53.9069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41dcff01-20fb-4316-8f35-08dc86385881
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4142

From: Ido Schimmel <idosch@nvidia.com>

ACLs that reside in the algorithmic TCAM (A-TCAM) in Spectrum-2 and
newer ASICs can share the same mask if their masks only differ in up to
8 consecutive bits. For example, consider the following filters:

 # tc filter add dev swp1 ingress pref 1 proto ip flower dst_ip 192.0.2.0/24 action drop
 # tc filter add dev swp1 ingress pref 1 proto ip flower dst_ip 198.51.100.128/25 action drop

The second filter can use the same mask as the first (dst_ip/24) with a
delta of 1 bit.

However, the above only works because the two filters have different
values in the common unmasked part (dst_ip/24). When entries have the
same value in the common unmasked part they create undesired collisions
in the device since many entries now have the same key. This leads to
firmware errors such as [1] and to a reduced scale.

Fix by adjusting the hash table key to only include the value in the
common unmasked part. That is, without including the delta bits. That
way the driver will detect the collision during filter insertion and
spill the filter into the circuit TCAM (C-TCAM).

Add a test case that fails without the fix and adjust existing cases
that check C-TCAM spillage according to the above limitation.

[1]
mlxsw_spectrum2 0000:06:00.0: EMAD reg access failed (tid=3379b18a00003394,reg_id=3027(ptce3),type=write,status=8(resource not available))

Fixes: c22291f7cf45 ("mlxsw: spectrum: acl: Implement delta for ERP")
Reported-by: Alexander Zubkov <green@qrator.net>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Tested-by: Alexander Zubkov <green@qrator.net>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../mellanox/mlxsw/spectrum_acl_atcam.c       | 18 +++---
 .../mlxsw/spectrum_acl_bloom_filter.c         |  2 +-
 .../mellanox/mlxsw/spectrum_acl_tcam.h        |  9 +--
 .../drivers/net/mlxsw/spectrum-2/tc_flower.sh | 55 +++++++++++++++++--
 4 files changed, 63 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_atcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_atcam.c
index a7473e782b56..07cb1e26ca3e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_atcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_atcam.c
@@ -391,7 +391,8 @@ mlxsw_sp_acl_atcam_region_entry_insert(struct mlxsw_sp *mlxsw_sp,
 	if (err)
 		return err;
 
-	lkey_id = aregion->ops->lkey_id_get(aregion, aentry->enc_key, erp_id);
+	lkey_id = aregion->ops->lkey_id_get(aregion, aentry->ht_key.enc_key,
+					    erp_id);
 	if (IS_ERR(lkey_id))
 		return PTR_ERR(lkey_id);
 	aentry->lkey_id = lkey_id;
@@ -399,7 +400,7 @@ mlxsw_sp_acl_atcam_region_entry_insert(struct mlxsw_sp *mlxsw_sp,
 	kvdl_index = mlxsw_afa_block_first_kvdl_index(rulei->act_block);
 	mlxsw_reg_ptce3_pack(ptce3_pl, true, MLXSW_REG_PTCE3_OP_WRITE_WRITE,
 			     priority, region->tcam_region_info,
-			     aentry->enc_key, erp_id,
+			     aentry->ht_key.enc_key, erp_id,
 			     aentry->delta_info.start,
 			     aentry->delta_info.mask,
 			     aentry->delta_info.value,
@@ -428,7 +429,7 @@ mlxsw_sp_acl_atcam_region_entry_remove(struct mlxsw_sp *mlxsw_sp,
 
 	mlxsw_reg_ptce3_pack(ptce3_pl, false, MLXSW_REG_PTCE3_OP_WRITE_WRITE, 0,
 			     region->tcam_region_info,
-			     aentry->enc_key, erp_id,
+			     aentry->ht_key.enc_key, erp_id,
 			     aentry->delta_info.start,
 			     aentry->delta_info.mask,
 			     aentry->delta_info.value,
@@ -457,7 +458,7 @@ mlxsw_sp_acl_atcam_region_entry_action_replace(struct mlxsw_sp *mlxsw_sp,
 	kvdl_index = mlxsw_afa_block_first_kvdl_index(rulei->act_block);
 	mlxsw_reg_ptce3_pack(ptce3_pl, true, MLXSW_REG_PTCE3_OP_WRITE_UPDATE,
 			     priority, region->tcam_region_info,
-			     aentry->enc_key, erp_id,
+			     aentry->ht_key.enc_key, erp_id,
 			     aentry->delta_info.start,
 			     aentry->delta_info.mask,
 			     aentry->delta_info.value,
@@ -480,15 +481,13 @@ __mlxsw_sp_acl_atcam_entry_add(struct mlxsw_sp *mlxsw_sp,
 	int err;
 
 	mlxsw_afk_encode(afk, region->key_info, &rulei->values,
-			 aentry->ht_key.full_enc_key, mask);
+			 aentry->ht_key.enc_key, mask);
 
 	erp_mask = mlxsw_sp_acl_erp_mask_get(aregion, mask, false);
 	if (IS_ERR(erp_mask))
 		return PTR_ERR(erp_mask);
 	aentry->erp_mask = erp_mask;
 	aentry->ht_key.erp_id = mlxsw_sp_acl_erp_mask_erp_id(erp_mask);
-	memcpy(aentry->enc_key, aentry->ht_key.full_enc_key,
-	       sizeof(aentry->enc_key));
 
 	/* Compute all needed delta information and clear the delta bits
 	 * from the encoded key.
@@ -497,9 +496,8 @@ __mlxsw_sp_acl_atcam_entry_add(struct mlxsw_sp *mlxsw_sp,
 	aentry->delta_info.start = mlxsw_sp_acl_erp_delta_start(delta);
 	aentry->delta_info.mask = mlxsw_sp_acl_erp_delta_mask(delta);
 	aentry->delta_info.value =
-		mlxsw_sp_acl_erp_delta_value(delta,
-					     aentry->ht_key.full_enc_key);
-	mlxsw_sp_acl_erp_delta_clear(delta, aentry->enc_key);
+		mlxsw_sp_acl_erp_delta_value(delta, aentry->ht_key.enc_key);
+	mlxsw_sp_acl_erp_delta_clear(delta, aentry->ht_key.enc_key);
 
 	/* Add rule to the list of A-TCAM rules, assuming this
 	 * rule is intended to A-TCAM. In case this rule does
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
index 95f63fcf4ba1..a54eedb69a3f 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
@@ -249,7 +249,7 @@ __mlxsw_sp_acl_bf_key_encode(struct mlxsw_sp_acl_atcam_region *aregion,
 		memcpy(chunk + pad_bytes, &erp_region_id,
 		       sizeof(erp_region_id));
 		memcpy(chunk + key_offset,
-		       &aentry->enc_key[chunk_key_offsets[chunk_index]],
+		       &aentry->ht_key.enc_key[chunk_key_offsets[chunk_index]],
 		       chunk_key_len);
 		chunk += chunk_len;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.h
index 79a1d8606512..010204f73ea4 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.h
@@ -167,9 +167,9 @@ struct mlxsw_sp_acl_atcam_region {
 };
 
 struct mlxsw_sp_acl_atcam_entry_ht_key {
-	char full_enc_key[MLXSW_REG_PTCEX_FLEX_KEY_BLOCKS_LEN]; /* Encoded
-								 * key.
-								 */
+	char enc_key[MLXSW_REG_PTCEX_FLEX_KEY_BLOCKS_LEN]; /* Encoded key, minus
+							    * delta bits.
+							    */
 	u8 erp_id;
 };
 
@@ -181,9 +181,6 @@ struct mlxsw_sp_acl_atcam_entry {
 	struct rhash_head ht_node;
 	struct list_head list; /* Member in entries_list */
 	struct mlxsw_sp_acl_atcam_entry_ht_key ht_key;
-	char enc_key[MLXSW_REG_PTCEX_FLEX_KEY_BLOCKS_LEN]; /* Encoded key,
-							    * minus delta bits.
-							    */
 	struct {
 		u16 start;
 		u8 mask;
diff --git a/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh b/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh
index 31252bc8775e..4994bea5daf8 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh
@@ -11,7 +11,7 @@ ALL_TESTS="single_mask_test identical_filters_test two_masks_test \
 	multiple_masks_test ctcam_edge_cases_test delta_simple_test \
 	delta_two_masks_one_key_test delta_simple_rehash_test \
 	bloom_simple_test bloom_complex_test bloom_delta_test \
-	max_erp_entries_test max_group_size_test"
+	max_erp_entries_test max_group_size_test collision_test"
 NUM_NETIFS=2
 source $lib_dir/lib.sh
 source $lib_dir/tc_common.sh
@@ -457,7 +457,7 @@ delta_two_masks_one_key_test()
 {
 	# If 2 keys are the same and only differ in mask in a way that
 	# they belong under the same ERP (second is delta of the first),
-	# there should be no C-TCAM spill.
+	# there should be C-TCAM spill.
 
 	RET=0
 
@@ -474,8 +474,8 @@ delta_two_masks_one_key_test()
 	tp_record "mlxsw:*" "tc filter add dev $h2 ingress protocol ip \
 		   pref 2 handle 102 flower $tcflags dst_ip 192.0.2.2 \
 		   action drop"
-	tp_check_hits "mlxsw:mlxsw_sp_acl_atcam_entry_add_ctcam_spill" 0
-	check_err $? "incorrect C-TCAM spill while inserting the second rule"
+	tp_check_hits "mlxsw:mlxsw_sp_acl_atcam_entry_add_ctcam_spill" 1
+	check_err $? "C-TCAM spill did not happen while inserting the second rule"
 
 	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
 		-t ip -q
@@ -1087,6 +1087,53 @@ max_group_size_test()
 	log_test "max ACL group size test ($tcflags). max size $max_size"
 }
 
+collision_test()
+{
+	# Filters cannot share an eRP if in the common unmasked part (i.e.,
+	# without the delta bits) they have the same values. If the driver does
+	# not prevent such configuration (by spilling into the C-TCAM), then
+	# multiple entries will be present in the device with the same key,
+	# leading to collisions and a reduced scale.
+	#
+	# Create such a scenario and make sure all the filters are successfully
+	# added.
+
+	RET=0
+
+	local ret
+
+	if [[ "$tcflags" != "skip_sw" ]]; then
+		return 0;
+	fi
+
+	# Add a single dst_ip/24 filter and multiple dst_ip/32 filters that all
+	# have the same values in the common unmasked part (dst_ip/24).
+
+	tc filter add dev $h2 ingress pref 1 proto ipv4 handle 101 \
+		flower $tcflags dst_ip 198.51.100.0/24 \
+		action drop
+
+	for i in {0..255}; do
+		tc filter add dev $h2 ingress pref 2 proto ipv4 \
+			handle $((102 + i)) \
+			flower $tcflags dst_ip 198.51.100.${i}/32 \
+			action drop
+		ret=$?
+		[[ $ret -ne 0 ]] && break
+	done
+
+	check_err $ret "failed to add all the filters"
+
+	for i in {255..0}; do
+		tc filter del dev $h2 ingress pref 2 proto ipv4 \
+			handle $((102 + i)) flower
+	done
+
+	tc filter del dev $h2 ingress pref 1 proto ipv4 handle 101 flower
+
+	log_test "collision test ($tcflags)"
+}
+
 setup_prepare()
 {
 	h1=${NETIFS[p1]}
-- 
2.45.0


