Return-Path: <netdev+bounces-109364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1BE92828C
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 09:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB6F11F24AD6
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 07:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382F1144D1C;
	Fri,  5 Jul 2024 07:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rSdie5K+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C9413C9CD
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 07:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720163728; cv=fail; b=tSoRg5ZRwb4hDxThFBLDxNDoj2/pH3x5boHPaoOe4aWUV8bmvaX58NokJ+J/ZmM2KDfiPjd/IfUVW+ZETHQXD1qjcLtuxNnvTiD+zxXDTX9kNQJ7xdxaGSuDUTxsDgMyq/74Jdzu3agghd5oHZRe/SkmkpxVpPuWPs3r64gpiuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720163728; c=relaxed/simple;
	bh=AnhjgvGIV82k24KRmrNwKdWUz1xIsA9OC2t7P6HGyWc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Al/PnlH3KAF2iBfSYfunKxKoLbL94atPTFfuzwS8f+8Pf6eTksvm2CI7VUVq+c96J96bzXtVd2BO/SCaNYQn6faPmN5nwiB7gjTrxHL4L/gkdQVQUYMVowbkkHd86Oz90RQ9U1lfVDJA/kcxWvDQqEUNGm+viKoHWtLWZEOyBFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rSdie5K+; arc=fail smtp.client-ip=40.107.236.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcxrKroXl2pM/OQNH+NOjfyo7LRQEVAfCUM/9EDLj+iyF3At9wQrKBfal7yVbOp1LVPYA8bkcABTHMUWlONjRKzY9N64HuxHEZK/c/M4zq5T5bJWBcWrvXwgFPzfjZ/oO06p9bWDfzB674g20cCScxKJK5Y++Dc/P/IvegzmgHdp50XIBs8uCN42huLrodhUczKQSWRC3XShSxR7SRMHZcdcVOePeqDtdwnZIPpg8Q7LhPG5HHPhGeGsMlmy8+iXvcsx/e21npmhY8V/TrnBwB1bnmbnqtYzU+/ScQfefy54UbpEoAMLgMaE4nDUOG9rsAqQJmiMGb9VJdr45vq3EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHKFhVc/yEW9RV8BNv/0lEwVfAPcgMqyKxr9icBTMBQ=;
 b=NdjPRwnRVnLr7tBx8g3LcaZILNfeTmLo42nwtTB1Xj1V7m6Zu3zxBzcJBOsMIbk67ttw+0CiHEmsQXN45exWSBJMUU7GkFoBYSJKWc9uvWm4l+f+FNF3yl9E4z1PKlEBRtGN21bgr2Xe1un9DZHcD/fhAH1T66xn45bSLsRGGhB+gNpbTT11ociMyv7aiIjNc1fzhushpzQNt6+Fvpi2On694UW6HyheCbkD8k8dXjQhRh8+hLU50bmUIQksIleEMxGWCgwbiLsCevxGoQaRp4XQxVg5fPIGvzuhCrbDsweUpXtwumj8+GY83vA396gb2eSYKjhhqTzQQAL2uY6rtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHKFhVc/yEW9RV8BNv/0lEwVfAPcgMqyKxr9icBTMBQ=;
 b=rSdie5K+ZL2guTPz4YwSbgsM5cK6GC39lMaeEgersk+V9y/w8QAww/w7aNIp93WJTkJ7z+8N0iME6w7S7V8ui+9wbAOeAti8igqiQtUnj+cBrML4cDiI6yYzzHE04lo/P0HLef+CQM/aDFXDtxs5FQ5MSYRz/iq/7HPi3DMOZm3FRoHSiApIHqm6RtL2XREEfxSecgmSR2AkBSnT7VR7BDCsM/dxlTn+FiKxAzYzJt8AZ9NU/Tb/S/TnlvX5gVrhiTz7YX/45GLHyiUdVoOm4DD/0IwoioUOTj2MKv9kCqROpRrFBIsikKsVEQaJ+ugix1jLB7dVbuKkfgFVOeHSiA==
Received: from SN4PR0501CA0132.namprd05.prod.outlook.com
 (2603:10b6:803:42::49) by SA0PR12MB4445.namprd12.prod.outlook.com
 (2603:10b6:806:95::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Fri, 5 Jul
 2024 07:15:23 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:803:42:cafe::e7) by SN4PR0501CA0132.outlook.office365.com
 (2603:10b6:803:42::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.12 via Frontend
 Transport; Fri, 5 Jul 2024 07:15:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.18 via Frontend Transport; Fri, 5 Jul 2024 07:15:23 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Jul 2024
 00:15:12 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Jul 2024
 00:15:11 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 5 Jul
 2024 00:15:08 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Daniel Jurgens
	<danielj@nvidia.com>, William Tu <witu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 01/10] net/mlx5: IFC updates for SF max IO EQs
Date: Fri, 5 Jul 2024 10:13:48 +0300
Message-ID: <20240705071357.1331313-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240705071357.1331313-1-tariqt@nvidia.com>
References: <20240705071357.1331313-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|SA0PR12MB4445:EE_
X-MS-Office365-Filtering-Correlation-Id: 6799c171-ef56-4c2e-4bf9-08dc9cc23cac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I2YY+fxFNq6Si7VKk6q8QLyHSWW6/T5VsTkU/475rG4P4XoPyjK48svySRCI?=
 =?us-ascii?Q?C/JgeikLV4KCDAfjAZr2Aw0/sWnEIzEjqB+xmk85hXVQoHjmftYOHnyoQaec?=
 =?us-ascii?Q?WGcal85nuhQkoT4u+QLSVS4ocQbFRSIHee+2oTYW4MBN/FNrsDQX6S1iv9w8?=
 =?us-ascii?Q?tCeYeYDJv5wFAMQR101A2CdFT+6q8RQtYl+2kltxAhnidBXwbLUEWJFInWVJ?=
 =?us-ascii?Q?iPs+kElQxbf/Bqf4GR1RK1s2J/4oO8TD82L17IyqMVFcyeYY9wGWxwpqBtju?=
 =?us-ascii?Q?yH43rFRnbJQzJLwp3tHY3Hp0QjJ9DRB56frcCoiUVKRS4vFl44LH+BJREPDp?=
 =?us-ascii?Q?ex7xSOpc1XY5BO0hdG7bi0urmOvQ+SXby+KqWZWzm3taoXkV3HuQfiU4p0n2?=
 =?us-ascii?Q?MCQ3BZmZWxwRzDufMpwX1eAtcyTZOat0KPFr2FOncDbfzJElcCWLs7ehK7N5?=
 =?us-ascii?Q?xvYMLFSu7v/48SzpbmUeL8kgE5T4RBIxTxHmCxJU4G4eDTio4YV1zll71rsW?=
 =?us-ascii?Q?poPiBo0jYGhuq2yxyqubMmoKdoAB8nVaOLhlaKxUyGnNoeqyGKnHD5dylaFq?=
 =?us-ascii?Q?m/QlNLsRYxJMdfDvjxr+PC/5R9ipCOVeUwRX+bwNDe49HfzTdItFFXv+pWkp?=
 =?us-ascii?Q?+6IhZQcreE7qcoICCEABpFoMZCVlzkwpKbxL5M2eniuEGopaRmTTT9vWPUEX?=
 =?us-ascii?Q?Itljy57Fu8GJKfs5may5lRgAfzGnif7NF3WXLmyAg8nPBxTuSB6+yLJJquue?=
 =?us-ascii?Q?5KEAe7Ywx37GVHduTKiqNBLIhVoETlPKH1G90uJ3U8Y3rh9/2u90lk2TtVVu?=
 =?us-ascii?Q?CKQnlOgoXASY1HzN7j95cMaI2jHPAF9O2v6y0FYubb7YTSHUckFLpOZxgJTb?=
 =?us-ascii?Q?MDmk0ngYIaYw6ud5DkvTT7gAEUhFbn0j0JJtbJtH2WLHe9MUZEb5ASXU9VWT?=
 =?us-ascii?Q?ydbwJ2vix7TjyWsYh4XBsBmNudtrqbj09+ybkbQ1TQtryuZN7PykceY+Ahm0?=
 =?us-ascii?Q?p5+1+9zEL96NhwtJbBKkMCdkRy++UCsPctbu0GG5kJFIoVbZKIJSci96t7nE?=
 =?us-ascii?Q?sFi25yc/V0bwJ0QZSsZFp4c+lvS2CslJK7yM4866gLBW/jsp1qDd9104zB0B?=
 =?us-ascii?Q?p30MIkVM5zo3LLKpycj7sNJAkA2IswMiw91cELysNOGLOIjt0Zi0nc2c2E/X?=
 =?us-ascii?Q?qwZ2BsH7bWG4HtPWPvwshSgmrZoWEm/zoBC7t9l6h/qmb8Dn9BxAJ+8JOMNk?=
 =?us-ascii?Q?cjnPm7IzOLi0e+9hiy081MkZq8LKKBnW4SCmqbmIyWi9Xj/cYvVlcHHu2YoF?=
 =?us-ascii?Q?ZTIdUMgNRyx1M4XKDo5xW/i5LJKJ5bay3TxFAGc6hSgXHfv1Oj4/7iie0TuC?=
 =?us-ascii?Q?eotmMZFn2ht6+Cn3URb4qtG24WeF3d4yX+0SJlF/5u/TvJ9iiblhqMcf5ErW?=
 =?us-ascii?Q?p8w145hXv1+8t4s6Fj+K5oVxoQpPHRET?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 07:15:23.3874
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6799c171-ef56-4c2e-4bf9-08dc9cc23cac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4445

From: Daniel Jurgens <danielj@nvidia.com>

Expose a new cap sf_eq_usage. The vhca_resource_manager can write this
cap, indicating the SF driver should use max_num_eqs_24b to determine
how many EQs to use.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: William Tu <witu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index fdad0071d599..360d42f041b0 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1994,7 +1994,9 @@ struct mlx5_ifc_cmd_hca_cap_2_bits {
 	u8	   migration_tracking_state[0x1];
 	u8	   reserved_at_ca[0x6];
 	u8	   migration_in_chunks[0x1];
-	u8	   reserved_at_d1[0xf];
+	u8	   reserved_at_d1[0x1];
+	u8	   sf_eq_usage[0x1];
+	u8	   reserved_at_d3[0xd];
 
 	u8	   cross_vhca_object_to_object_supported[0x20];
 
-- 
2.44.0


