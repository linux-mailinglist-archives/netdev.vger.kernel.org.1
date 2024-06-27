Return-Path: <netdev+bounces-107414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F4491AEBA
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 20:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F80D28A0A5
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 18:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAFA19AA70;
	Thu, 27 Jun 2024 18:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MFKcPrXK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22AE19AA5C
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 18:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719511471; cv=fail; b=GBjnXuOaQaPCjvLQPX83/wdvJSQanygvunAUUanXvkQ99pYszSleoGEq2WJxyr468KPaUNfoUSPeoOwJRNx+3eZ47+SCnySq9+s8BpkQlcclw/pJaMhT+vyq35yL/TEmuBtMZKrPEt9yv+9UH2dCT8epdb5swEtRbair1Ck5fjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719511471; c=relaxed/simple;
	bh=izgBM7UrxIUFUTIjn3r66tKFZKZ25ckV7wt+xeTT5Cw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LBDTpEWx8M2vX3jzP4KOr+NFyEgdD7XICJY/9RzYTgASE5u0yE9Z0v5Z9WCAYMvG2N38IQgjtY7nVJJT5Ntq3yeyfRezPoheOF8kU5LlIXqOunOCp8PNMGWffQl1d/541m//m5nKgR8m/MoR2Nn1sOA7e666ReD57lF0TAhYqOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MFKcPrXK; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iemPUDeKjk8/qpEPVwLFMuX//7+z2BoCMuutZgS/zdUH4PdVS18QK4V0Q4929q102g1ju/cnieluIgV87DxDladApuxOIwPZ1N5eBEWcgLHDFCiltocav1WZe2XO4GiCPdhTFoSGo66YnDFChJk13uwGW8il+grAX2Ho2y35mymu5LpfCj53UFZhKzHQPOhE9QRbubpnJBvxunw60wXD3OUVa/jNYngUtvR3EmhahkzjSYw0PAUrYnanzAz5rt46p80mDkZktH+WKHtsJUfJ5QoI007QL/eWB6uk6ibWJUCItocX5A/N44pBK/2OmVgy9JHOUkOpUtU+Em/EqYwn9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UO7PjPpw07uz0p2M9ZXfLFgYMzDlHf75tvNXyyuDoSQ=;
 b=FC7S+1MdlKRrjCvZKrp33SatqikZrrRBnHoUOlH+QrACsLwz5Uz8mUSeEXOOcgNCWfSkQYq3YSOiVFhtXmyMRxDjsw5vdyfcqXRMhzCh8ce2qnH5mxy7tytmlYXphiayDbRWA5q7VlkhP26bLbT+Q5J31kNHAbSxTSD1XtRWHV3qy4rUCCXhsw/mRZ/uz0x60O4Be/4ABwxaNfI40afII+sQ0tec0iVd68kNVDlyyDJGjxWPJvG1HYIpM6YzVxoOYProc6LoaYJMw4wuBz9qXj0Y9MyR3IYoxo+VJ5CRokvle0L8pAUN1LB9VQRhQDcC0IkpVNlI8IkpvjHnM94Aig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UO7PjPpw07uz0p2M9ZXfLFgYMzDlHf75tvNXyyuDoSQ=;
 b=MFKcPrXKgeBWYGWs2w13mRdMZbZAfZPi2izFFlRpZjxd5unnQiLcGJniiTI1hf8xEE/v7RSy18sy6ud2fCp0qY7Fu4RxGYkQIOmqQNbCVMeaGNfdL0fpyWYfxhmvF3nkvCoFXq6hqfKHsunXEldOJMv0iWSO2PLI8ulgFOYEMyl1udU07BUJKifqPH6AT2n/o6yOQ3iF9ErToQ6AyJse/Wn/54UsxuCzi3aIUl5Hwy3YDG+4pg6EXdxM8j5KDzi6TmLWgLfo6Tg+1vwiySo3GFM7LH/BaLU4699Dohu8H9SXuHaw/SN2WHmH2XXKU1yoDwvKx+KdIO4xG/Z7IysrOQ==
Received: from PH7P220CA0040.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::24)
 by IA1PR12MB8189.namprd12.prod.outlook.com (2603:10b6:208:3f0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 18:04:23 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:510:32b:cafe::5a) by PH7P220CA0040.outlook.office365.com
 (2603:10b6:510:32b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Thu, 27 Jun 2024 18:04:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 18:04:22 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 11:03:54 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 27 Jun 2024 11:03:53 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 27 Jun 2024 11:03:50 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Daniel Jurgens
	<danielj@nvidia.com>, Parav Pandit <parav@nvidia.com>, William Tu
	<witu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net V2 1/7] net/mlx5: IFC updates for changing max EQs
Date: Thu, 27 Jun 2024 21:02:34 +0300
Message-ID: <20240627180240.1224975-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240627180240.1224975-1-tariqt@nvidia.com>
References: <20240627180240.1224975-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|IA1PR12MB8189:EE_
X-MS-Office365-Filtering-Correlation-Id: d07541f7-002c-404c-e9f7-08dc96d392ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bnC9G+31DmeZrYKl4cJoYB/edVPAC8XL/7oJCyA9aZVYHDPptrvC3r+vHTu7?=
 =?us-ascii?Q?SZriDKq5Gxym6ye16t2WtAVMtZyvLdz7H9Iqd0UCbsI9/SMTU6TSXQgOXTsK?=
 =?us-ascii?Q?ZntlUjF81XFkxCQ4sVwDmAXtCNC2kOFV0gyP/f83MlYFYnuvX0H5LsvC37Kx?=
 =?us-ascii?Q?6cOtshkPq2HrCchgMPPM8X4Qil9EMGe4RQDHknwUt4Empu40HNQh0erfT/Sh?=
 =?us-ascii?Q?D5BDjTQBJZQRuLIRgisdBzyMA7HxneNsO+rpmi64F964kCxr3xhx02L5Bcw8?=
 =?us-ascii?Q?oo2SXb1sgXMO01kbc74MiuVwC+fv6EIhvLguZODLt+pWZJzbLuuLjUWs6tvA?=
 =?us-ascii?Q?KKUZGWzeLTBCM9L0sDXnMmkbjZNf0Ph/5uC4OjuXSjb3Ye586B3rlShcFT4a?=
 =?us-ascii?Q?ylmmYPP1pSBytUkPz/f1wATbuWPLPiat4cc4ZLud7oxdqL3ggqkhORT1C78+?=
 =?us-ascii?Q?QzOqdL0pdch6TGnIKQahSKNbCSXgZpDkGi2uop204VNHxVNIjMuQOOhJCviD?=
 =?us-ascii?Q?099X5UjuTW9VuHJWg5UbdXeUCkGz5/NH8UBv+uXyb9kSk7FZJLWVc870WLPI?=
 =?us-ascii?Q?ma4I8dmsLfiV/0JdjkpPnkhn44Lm9xpSY8H8tdzr3mA21vbG6LZyQWq5t9E8?=
 =?us-ascii?Q?MMYydE7ral18auPw0FW7SzayjR0/XPTSxjeIWvOuX8UqUz8dnKBUruze4Gmn?=
 =?us-ascii?Q?oC5mlryTFdgTc4hUgCHSReMX79D2LREsxdZTiVBA120iTApkfWva2driOy/2?=
 =?us-ascii?Q?SJXevMDryZfpLMg1OmD6F0W+zma1wRb8g7zRFA9e8NBlP1ka2BpgOkz4V33c?=
 =?us-ascii?Q?tVZxk+kaamgGxSunRj3hdHiL20he2FIRe/JoD3guHGSFps2rwG1A8HiJpgBh?=
 =?us-ascii?Q?Ou076wd9zMNGKrBbSllpxOckpnpTNA5tgSdDKyOJ1kzsDBsG78YS1FRHdQXu?=
 =?us-ascii?Q?7ndESsvs3YHw4kqobshD6vcnIjG2jKMpBDbGRChqhjuAZ8BDl1uNF34Eygnx?=
 =?us-ascii?Q?FX7YqSXoMPr/etfoA0GShz1gYSdEfuVKYNjpZeq3rom3g8PwRCci/t5pv7W7?=
 =?us-ascii?Q?FOwsnvJNt4V62a7oVg3fl13Pibis95OVgaxi53ZHW2gPo76maJoc+b04D4Qo?=
 =?us-ascii?Q?pmXhAN/jVG3kFXuIHg8rYbyaaR00B9ah7dhmw8KaXHnr6/Jk4NZVxINDnLJ6?=
 =?us-ascii?Q?HVgAaN7gDUQMt+SEixk/aEpAofJOcJS69KzeZJR5vEFgL2ozhPdfGo8a0uf6?=
 =?us-ascii?Q?IiZW4uOcqGL2XMUGx8ZJuMiUBS2Sqt4xJ/nwVhdQH73xhh+yfhQUWe/zor40?=
 =?us-ascii?Q?vPM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 18:04:22.6070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d07541f7-002c-404c-e9f7-08dc96d392ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8189

From: Daniel Jurgens <danielj@nvidia.com>

Expose new capability to support changing the number of EQs available
to other functions.

Fixes: 93197c7c509d ("mlx5/core: Support max_io_eqs for a function")
Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: William Tu <witu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 5df52e15f7d6..d45bfb7cf81d 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -2029,7 +2029,11 @@ struct mlx5_ifc_cmd_hca_cap_2_bits {
 	u8	   pcc_ifa2[0x1];
 	u8	   reserved_at_3f1[0xf];
 
-	u8	   reserved_at_400[0x400];
+	u8	   reserved_at_400[0x40];
+
+	u8	   reserved_at_440[0x8];
+	u8	   max_num_eqs_24b[0x18];
+	u8	   reserved_at_460[0x3a0];
 };
 
 enum mlx5_ifc_flow_destination_type {
-- 
2.31.1


