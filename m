Return-Path: <netdev+bounces-169767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B483BA45A68
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 10:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A31BA169E1A
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 09:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9476023815B;
	Wed, 26 Feb 2025 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KUqtTWm/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3384238158
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 09:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740562781; cv=fail; b=FDS5cUyAVeeOMHu/9Acyotaap7XpmiJ5joQBj9cVn+5uRGXwLKdDv+nSeYWijh8o4nrpq3PKgS54Gr/J0S0q1VKnGLi1BgRoZjlyT8QlboMdTsx8LShQalvz1LQDznwmFUJacVBM0PfrHNtwgM6xGY5RNELJHcuxMzKJEU/X1KI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740562781; c=relaxed/simple;
	bh=S8rS4EZz6jPesRTyUpz50IOHWeH1XjxrOxZWF94QwQI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a8lEUiHoiaF1Rn9YF683liYk81ZIh8LDnXOB1vPjVmW0qb9h+6WwQxX+oELVjiSGd1rJowvq5NsCakJF41kYDoxZlm0vDbZ3jwv1vc9GiSD7AdWbcnIK7nS2aaFgGhZrfzUpF9EAfO4xuXvI9Wn378PUD4TOWxt6MTHlRcp0h4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KUqtTWm/; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QALZstf/NUcW+4WqrS7gK5PgNOmCoWDQnGT1J5zxCDTrMatL+pccseX5sYfq/rJMVPWeYa++aYjX8MGP3wVKdoIOaotkPwFkgaiBEgxJ76gLMZ3E2jaEM+nrBJB6eOsh2g52fK3eEF8g+0+U0+muZVAFx4euPeFCKScJ62xKTzVKyo6FjyNpB2OGbkjlHIyj+6XIHqqhh9kWohq9yQTSjSEXYkgomUC5eGTyKXCSXUf+TwoA316Ndz+6YsvBO0wlXyCW30U0/5ITvolHgpnsCzO8++EOYA44UrIAhl5w/7TyVDbgtNGdDalIHeOzcl1aUz16FIJeeBpikShjkiPGgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8m8cdwv4eF3m3AULLLLL787vIW7J+KioyWUs6HpEZ7A=;
 b=l1zLFxbxDzb5G7keFwZ2hI3f6LltIHHioUuEk6ibVj408b0HlFSc2RXv2WG8uhmU3484GHqWzYBrLrLHg/8p9fQOUwsXhpxpBElnoMl1cEsrioDWBT4yKoyEMUeiO1YTlriA3gCVJ1CmbHwpdeXERN/gn8LHwS06O1TDSZa+pI7jxfmElq3gxVQiqdkX2COguLQ5Zt37cVJxXerohZjqG73mrZCTgTCpco2drvVdeFGn18OfEDRIxsADLorytpvg9FyPDtdJqXelSJrc78mUdku3jebihf8HIHJKZpF0Xhto0/Ex1bc+HypZ7JnFKDVjcHoDc/HmFGM4VzcLRuOpOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8m8cdwv4eF3m3AULLLLL787vIW7J+KioyWUs6HpEZ7A=;
 b=KUqtTWm/aVPCbI3aaYkPc9BmC5XvH/+h1/21ihCFOmXNkDXO9ZXfMrD6CLnjjMafkmJDmdqku6iA2W9dlNDIcohRYn3pCai6Cw7jTWAQ/e1SzlOyrg/IO5m6FxN0dqDbz9duI+F/0wn5+tfEe484gLhhInSWQGPKZl3gBM3OY3Wc/OStk9T4/wG8ZcBG8yEIdwtE2fTXy4PM1ND6u5cpPwK69oPPfz22w/pyhyXFPz88HHhzx68IVhOfQq5a9Ppczoe5ue7oNNTCd3hAERr/nmWdpJFzcAfJjQ0eRmiq0LSn97lD8Br9oT0XQBA/Q4Z0iM6N7oi6Q/8NwNaUsGQsVQ==
Received: from BYAPR01CA0045.prod.exchangelabs.com (2603:10b6:a03:94::22) by
 CY5PR12MB6345.namprd12.prod.outlook.com (2603:10b6:930:22::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.21; Wed, 26 Feb 2025 09:39:36 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::ac) by BYAPR01CA0045.outlook.office365.com
 (2603:10b6:a03:94::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Wed,
 26 Feb 2025 09:39:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 09:39:34 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Feb
 2025 01:39:26 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 01:39:25 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 26
 Feb 2025 01:39:21 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Tariq Toukan <tariqt@nvidia.com>, Edward Cree
	<ecree.xilinx@gmail.com>, Martin Habets <habetsm.xilinx@gmail.com>, "Jamal
 Hadi Salim" <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, "Jiri
 Pirko" <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, Julia Lawall
	<Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next 3/5] sfc: Remove newline at the end of a netlink error message
Date: Wed, 26 Feb 2025 11:39:02 +0200
Message-ID: <20250226093904.6632-4-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250226093904.6632-1-gal@nvidia.com>
References: <20250226093904.6632-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|CY5PR12MB6345:EE_
X-MS-Office365-Filtering-Correlation-Id: 5301bc6f-f1f4-4d47-1b3a-08dd56497ae4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tz1Jcd1rlIB71c1JHjw5vSDjNGmMXKam0s5Qu8//nWRScgWTQXUnYOLnJee7?=
 =?us-ascii?Q?GmXnPdCgOrDGdkS9ba0YE/o4WJ9WZe1v5efoLvoM/hKdZcwqWsFIkDu7l/Lq?=
 =?us-ascii?Q?aQCzPC8B0CUsSvqhC7jKPKd0oEhPLCoPXXnlBOcReV7Cido+wpb3HV3WMu8t?=
 =?us-ascii?Q?Lif8g1G/iYOR/Ko9B6hq/HLv7jTUdIYx1Xk/WODlDzK5CHY/qRbJ4mEJzmO8?=
 =?us-ascii?Q?dZ7L/XI5TVoUnYXmjTFnDvaNKmMh/h6S6k2hNw633FPnaVTYoWz5TuMtOKx4?=
 =?us-ascii?Q?HJtsZDGzgHerZPIDFiwdHJPx3XNVnDaSZRZ1e2cC5Rp7V1+XWFSnfrksw2Yl?=
 =?us-ascii?Q?K9SnGVb3cJ6zqK1dhpqDXGt0tjmXUR2td3cjiLzC2AVERe74at46/xGd98ju?=
 =?us-ascii?Q?GDjrjX73UGPqjS80Pcxz4DtY6jTsokDfHEk391hYP0XOUMFIwDQQJAU3BS73?=
 =?us-ascii?Q?Xs6RKuCpiJDL2j5dD4qCxCRx7GvFx0IVUU+G2wfjLz64P86OK+G4Z1ALDo8/?=
 =?us-ascii?Q?BXFcmk4A1WXY9nqwp79N2bd8JLJuouE+CtOLOiZA4uPv0LjIO+kuhGUC6M95?=
 =?us-ascii?Q?vJnReLVU44yFeEIOCka9hHMLbGAVZLVrgaQdsFewXIpLrIMsHTuyF/zXOwJJ?=
 =?us-ascii?Q?zn4LjbE1fKgjtrLXr1wfIQHh+kj8XAfIozHIP/0YyHve+n49muIjOHAgwt9x?=
 =?us-ascii?Q?MmRV+c0vbbq+jzwljf4ny2MZ4/MidkNv0RL6MxGAEqoQ7m6IU2JPTtnbb7ya?=
 =?us-ascii?Q?dvC/ybgL0wA4JDMb06e6unKyQyGka1vD6Je84SfLIcwuLs99yrs/tVIGWh9P?=
 =?us-ascii?Q?VGFs0QU9TpeRoMJBk+r1CIIufDARaOWcazKJQLWR1YbZOLkXQLjhZcl6e/LC?=
 =?us-ascii?Q?SMVOgu7bs+KN1EIbumv7Tyojpn8xahgaZdYdQhSTKLmsEk6oECgEUZGJANoV?=
 =?us-ascii?Q?soOYySL0p6JwmY9ZaCJ0apI7UMWFuenR81AB/upwokq/leSUlguk8LnmG9y6?=
 =?us-ascii?Q?SbuEwKlkdulkdctwREn4WYB+SxM/f0w44Msj/jEYZsXuJHwLTqnDUosQ5oSf?=
 =?us-ascii?Q?h+5NNC96cvJawMRVzu/P3FPcrsoREh/S9Pq9DPzFhVDBiKRXxNwDjU3MC1UP?=
 =?us-ascii?Q?kbvrgNKRwBWb3c0dYlMvKFnBn4SwbV0/FeZZakUbfZ7C+YPlFMJRUzXRky0A?=
 =?us-ascii?Q?XxWuzXEvVRiDyDNIKV++8rFELyYOv0mGOzpjmXHd4d3ZBS1zmbQ3KpINSjCW?=
 =?us-ascii?Q?8/b0ezFqM6FZFUO01tNl6GEo06qSFtXYHzVg4McJBY5v+GMdjLPUUsgd5h/t?=
 =?us-ascii?Q?sDwT6IQtLr6+TIGwdfxs2gyq4H2XPvqGXUY+7hgd190T3x97fwI2/sjaHTbF?=
 =?us-ascii?Q?hjrc6u371buRcbbmGs51CWQPE8N98bPzBMRzkjKRp3APKpH12GLaL4UmHc6H?=
 =?us-ascii?Q?qWOnNU97dBh/ZQRwtp3BBON5WHf8i5/Dog6E1JZyDXyD75ayL5Kxb3e84PCf?=
 =?us-ascii?Q?A6/KCfCsXKyY/vQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 09:39:34.9599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5301bc6f-f1f4-4d47-1b3a-08dd56497ae4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6345

Netlink error messages should not have a newline at the end of the
string.

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 drivers/net/ethernet/sfc/mae.c | 2 +-
 drivers/net/ethernet/sfc/tc.c  | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/sfc/mae.c b/drivers/net/ethernet/sfc/mae.c
index 50f097487b14..6fd0c1e9a7d5 100644
--- a/drivers/net/ethernet/sfc/mae.c
+++ b/drivers/net/ethernet/sfc/mae.c
@@ -755,7 +755,7 @@ int efx_mae_match_check_caps_lhs(struct efx_nic *efx,
 	rc = efx_mae_match_check_cap_typ(supported_fields[MAE_FIELD_INGRESS_PORT],
 					 ingress_port_mask_type);
 	if (rc) {
-		NL_SET_ERR_MSG_FMT_MOD(extack, "No support for %s mask in field %s\n",
+		NL_SET_ERR_MSG_FMT_MOD(extack, "No support for %s mask in field %s",
 				       mask_type_name(ingress_port_mask_type),
 				       "ingress_port");
 		return rc;
diff --git a/drivers/net/ethernet/sfc/tc.c b/drivers/net/ethernet/sfc/tc.c
index 0d93164988fc..fa94aa3cd5fe 100644
--- a/drivers/net/ethernet/sfc/tc.c
+++ b/drivers/net/ethernet/sfc/tc.c
@@ -1043,7 +1043,7 @@ static int efx_tc_flower_handle_lhs_actions(struct efx_nic *efx,
 				return -EOPNOTSUPP;
 			}
 			if (fa->ct.action) {
-				NL_SET_ERR_MSG_FMT_MOD(extack, "Unhandled ct.action %u for LHS rule\n",
+				NL_SET_ERR_MSG_FMT_MOD(extack, "Unhandled ct.action %u for LHS rule",
 						       fa->ct.action);
 				return -EOPNOTSUPP;
 			}
@@ -1056,7 +1056,7 @@ static int efx_tc_flower_handle_lhs_actions(struct efx_nic *efx,
 			act->zone = ct_zone;
 			break;
 		default:
-			NL_SET_ERR_MSG_FMT_MOD(extack, "Unhandled action %u for LHS rule\n",
+			NL_SET_ERR_MSG_FMT_MOD(extack, "Unhandled action %u for LHS rule",
 					       fa->id);
 			return -EOPNOTSUPP;
 		}
@@ -1581,7 +1581,7 @@ static int efx_tc_flower_replace_foreign_lhs(struct efx_nic *efx,
 
 	type = efx_tc_indr_netdev_type(net_dev);
 	if (type == EFX_ENCAP_TYPE_NONE) {
-		NL_SET_ERR_MSG_MOD(extack, "Egress encap match on unsupported tunnel device\n");
+		NL_SET_ERR_MSG_MOD(extack, "Egress encap match on unsupported tunnel device");
 		return -EOPNOTSUPP;
 	}
 
-- 
2.40.1


