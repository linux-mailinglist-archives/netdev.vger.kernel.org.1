Return-Path: <netdev+bounces-246424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 719E3CEBDCB
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 12:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23F8930078A3
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 11:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16922C325C;
	Wed, 31 Dec 2025 11:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fBDcFVs0"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010060.outbound.protection.outlook.com [52.101.201.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6383B2DF12F
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767180416; cv=fail; b=up8h8YboX4pJxdqjXMmlZc2x/DPkeQYZpbqwPCigJcbB7XS7TmY6lhfbUr9xzqlqJAuDl27w9vxRgv5suSpRSAdaWnJN0m5K34yhioBdiqfpO7syukT+x0gFIH8XccLUR5kCBjTPia0rGGMETcmufw8w+MP6ZVeQa2LSbmVdHuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767180416; c=relaxed/simple;
	bh=6D16B7m9uQRJNUmyKXmraBn8q8d04KialojlzcSjKuc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Iz4j+sVFjaOXniXPYWOkBZsYjhCHsmfZ8J2nz9HMIjj31zzoKSj3UBzADtYqewziKwDWrW2XT8cQfWuVEZVo19Wdf+qP59EU3zKvqJbUoGjCaanUBL4K2TgXkj3X4iOaMIrmd29V71+99Cy9lklcRSqixrACmcsxs+Zb5mcW4C8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fBDcFVs0; arc=fail smtp.client-ip=52.101.201.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hsXeJ/s+bY+MXKTZ9mPZI1W2+9I42ZToMfcWrs35QgXFzDoYkTlW7vOb+bRYTrGSWKwVo7SeH2MJA7PfPD49nHjTJ7HycMYUP24vJIpRc/tNh9x8ViUH8GUUYswruAZJ1xTgshIdm32qk6BB/u1w37zoFJ0Zrf9dADz14siy0BhsIa3pCNi7kfLXXttnM5njkqkF0AxkqVEH8jklSm8d85golVr8tPEEY40Ofe//RuzBmvXsIEMRspUl+t0o47lFBSZKkF3KWKJvviMhl4bEIcMMrjOU57fSvnS77DCQunugVh+Ddlm6RQzqOE5NKeMajk6ywRj7DCbq7EItIpc6rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSxFbtLhGpXJJDoKz317lJ/8JKwA1YnD6R4kNZXO7bY=;
 b=hkTi96IWDu9BBFmGRDfC4/Hevp8pCZ9dycVtPJX0xnclRbVAUROnMmFQz3lj29i9xjKPOVZMskryJsNqVvvnu2eM+zIr5FItcexKEXetquOWmTFsoz1Eej31EJjNqrrSs5YEjmUWskBHRULJT3TRZH3P1FuO21X2K5mFj+7U8p1nyAf0ahYJmXt0XBRQUJyi91OQ6GWtt8xU2Z0BlZtlzg30Vr9g6bNkqy/HL4mzOY+3ezuAdt7s67PE0TyGd4ArVsN18KB6RaMatObBdaZ2+vi2LRNk+lUcVPAz7Cjv0Qm8MCVvjQjre3+zwh34Oubv1GECKb2EZH0FB/onxjH2eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=suse.cz smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSxFbtLhGpXJJDoKz317lJ/8JKwA1YnD6R4kNZXO7bY=;
 b=fBDcFVs0dz42+5D6BUY1ovVz4t0cLOCqBNDfZWXVP1cmar5+UQRih57G42V8b+elqwmOjB7OI/hPvwN3xhRFtV5SSHlEbReVsWCKnyS0WBLipu9gt5X7W2bbiqFDbaWS1P8xWZCSFfdSh4rHGvU4abTA+W1vPPQuEom8ycX5M9EcqLqGMsslD3A/UU8r6E7Q+pxcM9wVX/Fh+TVXlklQ5/gwE2VE175s/xQYbxhAldbFrA6HoUQ00RKsmeueWabwWcOfLWEscTPeHJH0lFrOs1omkHNNdCiW8FMUd86dW1lD+DnN/TO31F7W0HuZbfMj4n2iG4jQWRWrKDKu6GYYsQ==
Received: from SN7P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::7)
 by BY5PR12MB4243.namprd12.prod.outlook.com (2603:10b6:a03:20f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Wed, 31 Dec
 2025 11:25:39 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:123:cafe::90) by SN7P220CA0002.outlook.office365.com
 (2603:10b6:806:123::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Wed,
 31 Dec 2025 11:25:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Wed, 31 Dec 2025 11:25:38 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 31 Dec
 2025 03:25:32 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 31 Dec 2025 03:25:32 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 31 Dec 2025 03:25:30 -0800
From: Gal Pressman <gal@nvidia.com>
To: Michal Kubecek <mkubecek@suse.cz>, Chintan Vankar <c-vankar@ti.com>,
	<netdev@vger.kernel.org>
CC: Gal Pressman <gal@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>
Subject: [PATCH ethtool] ethtool: Fix declaration after label compilation error
Date: Wed, 31 Dec 2025 13:25:33 +0200
Message-ID: <20251231112533.303145-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|BY5PR12MB4243:EE_
X-MS-Office365-Filtering-Correlation-Id: c7d0b2e5-7f5f-4c17-892b-08de485f530c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CfQcuIEm7EFASqZM8bRRllC2MHgQiJk3qpTMehKRftTmljgsN57QzH08yl9L?=
 =?us-ascii?Q?nxYYNOso+wKnXBvb8cLOt6Ov/I4iaUANPX06wfekDzH+RFVKMyEPhaoTpP8q?=
 =?us-ascii?Q?sHMjthBChw3YbR6DpMH4AJWYOfPMsA5iLD0yq9l+bW9W9glkWUqwbZC4Yk43?=
 =?us-ascii?Q?H8WF0jbsdLGskYyGm+9+8NnpfreLwJfbvc+Wz8I1/Mtew7E4YoGSietYS/5v?=
 =?us-ascii?Q?qut2A26liJ+wZFicE+s6tHSbFNtUewMA1w8AK1Ihg7bfeRJwUeYu+Mk8lhlO?=
 =?us-ascii?Q?izP0FZyFmgqSua4UG+uXy4Gh0CAaHqKBITStrvQfnaNFQjB4eCy2gkpvJcIr?=
 =?us-ascii?Q?JNlWJM1psSWHzWWNMchRdNHoKvkBy5FLwIsbPWmMz+3Ni2i/Fm5qshRiuidW?=
 =?us-ascii?Q?Zuc5Q/GTTUYHIX7zidf30Qx5EMijR4+rGB0YS1Wb3Sk3IH/yTgFFxMKaI+NS?=
 =?us-ascii?Q?HN9fvU3UcaOwUgDbz1fKo415ulliQ0MXr0tC8b6JrtMfynACujMFNZ+2jexG?=
 =?us-ascii?Q?5ZTCgmiEjvpanx85tB3Zl2j47OcDJILvaxZO2dgQO1D/xhAEANDw6+WYuQyy?=
 =?us-ascii?Q?eXwbvrjch90rSpuadJtKaraZ7L2ePf22qkMu3YC+ALITimXBI1O+xwGQvrGG?=
 =?us-ascii?Q?IiWO6Qh1KyaprP0OeuycxeXrN6/7lDSl9K5IO8aZhdV3tLEfabgKJq6CF08v?=
 =?us-ascii?Q?6cWBgUBeqOElWZPojmMC9KD+++idhKX/rs9W2nh3nbUxj6Rd+4bYH24lNmvT?=
 =?us-ascii?Q?aQ3blUe4huUGjrSzjagXovNMEQIoy3hN2Zj7TZHhQhR0ALEZ7OwwAC3qWJ6E?=
 =?us-ascii?Q?iFgqiuzLiU8kmB4zdpJ7hypWjmQLSJFbcoD2qc28g3RUbY4xLfCUZtT6CcgY?=
 =?us-ascii?Q?DQZRYANNF3lZc9Xjvkgj0g+0YekEuWL+iV/EgOyPTj5j6MhJAkYDljUNGg4Z?=
 =?us-ascii?Q?s/urhR/Ol/gvokYMmqO5zmffpfxG5CAG6x9pEJEhUM3tFf4bpbUmqRlhseNm?=
 =?us-ascii?Q?fxugKu20yhYudgftjdvfxkGqpuEEUshaxbsmdSwat78sWdEHPp7nkOYLP/I/?=
 =?us-ascii?Q?8oo71Rhis8rbiBz5ULH1451CNkLgHDAUBfyPeHJvypXfomi6ITB1NP8tc0iy?=
 =?us-ascii?Q?P94C2CrvKzxFukGjKHtTxXF9ztpLS6e7H0hvr8WrVWpY/NMFJaLaP04ck9uV?=
 =?us-ascii?Q?NYW0iBGH/ChKjNqlTeN+wfo1ZSTZRuXpiQClxz2oQxqOYzUWIaaKRjqyLZFD?=
 =?us-ascii?Q?sl6dWlEmWyscicjWCQ46UxZbdefnRMVpmHdR2k7tR3fwEkcaHt661F1ZqrQo?=
 =?us-ascii?Q?rwkd8uI1ZiwlhhOY/tW1+FakKYt3Pn23wl2TeKB939KAIL2D6Vd3h/MugFYO?=
 =?us-ascii?Q?/Fh8RcYhIvU+TxC7T4oqKncz/ZMNNVeHvZM8dzp3WSxeMcedV0p8F6TNyw4b?=
 =?us-ascii?Q?hTKCyFgegfBJOvcFzqZqDmrgFgj77SYQdj+buhnYAw39bQbk4nWKybXB/NPR?=
 =?us-ascii?Q?m9LCsvqlropBLbu3tSWHloKrU8jPimxnofKzKZWvBRaDT8CuwYQBq8bbSJpj?=
 =?us-ascii?Q?mMlQo4Yk7MnfzXkh1lU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2025 11:25:38.4358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d0b2e5-7f5f-4c17-892b-08de485f530c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4243

Wrap case blocks in braces to allow variable declarations after case
labels, fixing C89 compilation errors:

  am65-cpsw-nuss.c: In function 'cpsw_dump_ale':
  am65-cpsw-nuss.c:423:4: error: a label can only be part of a statement and a declaration is not a statement
      u32 oui_entry = cpsw_ale_get_oui_addr(ale_pos);
      ^~~
  am65-cpsw-nuss.c:432:4: error: a label can only be part of a statement and a declaration is not a statement
      u32 vlan_entry_type = cpsw_ale_get_vlan_entry_type(ale_pos);
      ^~~

Fixes: eb91e05c98d4 ("pretty: Add support for TI K3 CPSW registers and ALE table dump")
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 am65-cpsw-nuss.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/am65-cpsw-nuss.c b/am65-cpsw-nuss.c
index de8e3e9d4cc1..fbb20bf271e7 100644
--- a/am65-cpsw-nuss.c
+++ b/am65-cpsw-nuss.c
@@ -419,7 +419,7 @@ void cpsw_dump_ale(struct k3_cpsw_regdump_hdr *ale_hdr, u32 *ale_pos)
 		case ALE_ENTRY_FREE:
 			break;
 
-		case ALE_ENTRY_ADDR:
+		case ALE_ENTRY_ADDR: {
 			u32 oui_entry = cpsw_ale_get_oui_addr(ale_pos);
 
 			if (oui_entry == 0x2)
@@ -427,8 +427,9 @@ void cpsw_dump_ale(struct k3_cpsw_regdump_hdr *ale_hdr, u32 *ale_pos)
 			else
 				cpsw_ale_dump_addr(i, ale_pos);
 			break;
+		}
 
-		case ALE_ENTRY_VLAN:
+		case ALE_ENTRY_VLAN: {
 			u32 vlan_entry_type = cpsw_ale_get_vlan_entry_type(ale_pos);
 
 			if (vlan_entry_type == VLAN_INNER_ENTRY)
@@ -442,6 +443,7 @@ void cpsw_dump_ale(struct k3_cpsw_regdump_hdr *ale_hdr, u32 *ale_pos)
 			else if (vlan_entry_type & VLAN_IPV6_ENTRY_MASK)
 				cpsw_ale_dump_ipv6_entry(i, ale_pos);
 			break;
+		}
 
 		case ALE_ENTRY_VLAN_ADDR:
 			cpsw_ale_dump_vlan_addr(i, ale_pos);
-- 
2.40.1


