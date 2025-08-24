Return-Path: <netdev+bounces-216278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D79B32E3B
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 10:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E0833B60CD
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 08:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DE625FA10;
	Sun, 24 Aug 2025 08:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="THM0YfDn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C43425F7A9;
	Sun, 24 Aug 2025 08:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756024829; cv=fail; b=dRARuKzHnT2OtpWFRgmSpJPlxj7EgveSoR/VIECSkSS8n/x9BSOhrx6WPqnsJhKlIwebXyz5GzRXLxD0xa0j4zZzkBag+9nuv7dB6p4Lu33j+z0su1C5fiUeSlqru2R2HsUdhEVbdYLeTxjSnL3091cndwStsZcmLkErq50gq5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756024829; c=relaxed/simple;
	bh=7ChNzEaQLFlsO2WjEH7AXRUiAJQKNfUgOEYuOX6oBHg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qAG9a2/Vl3u13mXdb214SU8vixDCJuVBiIME35BG7g2ux3vgPzC7nNGTjsFgirXiE2RKTkcIqG87ZVed02q52HYit9iGKzm+0KjpeTVPKoDh7Kn7ztHjqJ431nsxhMie65pNTSfzGE7NLSfnDOjOL4rvduTgV80v+5X0rH9Uhac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=THM0YfDn; arc=fail smtp.client-ip=40.107.92.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rJ2sZv4+fJmy2SqY4kKPk2oC1qSmdHG4INFMEDgfmseYKA4fGrap7XiFwuQ48Cm8GNfkDijn8Jxev9yC0mQsFvhpPn3nRrF9NMOdYAKcQSwNJTMWal/4kPndLyxC+bGa6+27iuh9UfdJl6clSi8S7JwswcOSmlDZqwteCtFZ2OAofnmImbsq0mDygwOSmuc75ZFoxZxpVZs8Vud75XQ5dMYJ1jS3JR6fyG2WWY1kYIW0dWQs3o32j7LwzwE7fH4A7oWyE/vwTqrYx4o9MgUVCfBGdHJ/B6qmzXC01Drv0Gj3iBls6BSgF8NezwlsrCLgZxs+M9cPh1/QxmWxFFPTZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oujauajvAA6RUwv7amXBr2Xi9IDx0ezImXkQ1LIG6yo=;
 b=iRbxdNoRdY1n81u2LBiJNWtL2ztoy0uqKxSR7kBaBZIzGAznlTay0uy4fUn+eQrdUC4XR6StV6L1CyiF35xIJwmkBFK3f2IOnyWjK9IGgeS+vuSD6Ty7B1ecKW989y5NsvhcDAdr4ydfs/Pq7lXAUPOWRPu+DxRMCoE9S6AtxJOobxt0ZR02ouS5WP1/Ktq9JF7t42B+1SJQuZZUQTrY9BVcEU55u4YA+ovF6UyRqHd86F1HYK1JePTC4tyQ5ot4y1vW9x7lIXn12CAs0fsdttD9+TK6NpBwP6ZX7OHAMBkfJCfVNeB5R2lYnuRucAWE6dLAxEBbN8IzyQvX2hCAVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oujauajvAA6RUwv7amXBr2Xi9IDx0ezImXkQ1LIG6yo=;
 b=THM0YfDn2uRqcOIAz4+iU6PLCgqDGtafRiLstbSQbd0R696HeCWFCi5m+Fni6FoTjiNku3NpqkKaR7Gkbzad9wlO9SAVOYYL2Puq9Ns9qp5UEZQLeGbLLxD0auolsWbkB1AsRlB5VSrcBY8RFmfvg8MUJNTp/8h7LxEhFQsSyIxfR2bU3QD7oEHF2RSEuSOznzsk1jYwDyXnAaG4IOIXlQxKCPM/tmICkygZymSpGRMuxiKJjPJpnGTxXv+bjSmgltv70yTAL4JSFMc6b8DGVI6M3i2H9yhuhCv76wXT3c9eGXh7sAj0rk/wuqNOid+MCB3ZJm47iwzZw5MhRHYS0w==
Received: from CH0PR03CA0234.namprd03.prod.outlook.com (2603:10b6:610:e7::29)
 by MW3PR12MB4361.namprd12.prod.outlook.com (2603:10b6:303:5a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Sun, 24 Aug
 2025 08:40:23 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::cf) by CH0PR03CA0234.outlook.office365.com
 (2603:10b6:610:e7::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Sun,
 24 Aug 2025 08:40:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Sun, 24 Aug 2025 08:40:21 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 01:40:04 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 01:40:04 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 24
 Aug 2025 01:40:00 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Lama Kayal
	<lkayal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Vlad Dogaru
	<vdogaru@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: [PATCH net 03/11] net/mlx5: HWS, Fix uninitialized variables in mlx5hws_pat_calc_nop error flow
Date: Sun, 24 Aug 2025 11:39:36 +0300
Message-ID: <20250824083944.523858-4-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250824083944.523858-1-mbloch@nvidia.com>
References: <20250824083944.523858-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|MW3PR12MB4361:EE_
X-MS-Office365-Filtering-Correlation-Id: f2cdef3d-1669-49bf-3d67-08dde2e9dd15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?70uMi6ia7T/98Z2ea6ePCm8rvF/KiK7200ED1mVJEZztlcFncgAZ/Bgd4+Ye?=
 =?us-ascii?Q?R0U0yw7TY+qFtGYmmz44AuadTbTOe9ckRSxw4kumc2uHHXgrnQgADdQLODEz?=
 =?us-ascii?Q?stKC4zaE6kMryexCnISM9wrIJVHEv8h+SzDh7KW9U66gQyNPP4pBW9bjXwYA?=
 =?us-ascii?Q?jSMt0vTsyFhyUIVtmVfgHHM7lHA4KKnomQfMWeMb22sgslZzg+7xRS4vIA0t?=
 =?us-ascii?Q?nuiGwRx3hgs+68aDy6O0s1SO1ryzedS5G97VHij4ZgyvPQUFJ16fhExnM4hz?=
 =?us-ascii?Q?uqg7FyZctbh9j5KSuFvmheB2xQFR4BZI+2E3hDhfy2SYGe4jaXkHr7gMkMjn?=
 =?us-ascii?Q?KHKt+Vse0KbgH9zThCMbOEfn8qcOFvNW39QGQlH4ZQN7qiWt5Khol+g+eVFn?=
 =?us-ascii?Q?cuh+QaWzttG2UXfNqOX4BiTgdnhH1k0RaVVWbkj+U67uZthcetUWLweOkQho?=
 =?us-ascii?Q?Pz9QwqS2tv4NN6Fyz0VPH7VfufU8dG7ihqiEBXgCS/AEbOI/bSBsufuA987K?=
 =?us-ascii?Q?ldlC/wCCJqkt8+sqxqWjUcUMYp158vUxUHogkroiPb/3Skj1P3VWB8YQ76ss?=
 =?us-ascii?Q?e+P0tkEPZA1OZ3nYoxCRZsQaTg+IcrzOCHvbKrqNA4mMge/2fM9HAy3S3nmL?=
 =?us-ascii?Q?H3WFy5s/kk0gNP/4XvKIqbNPJ1XtYZ5vVb0Myv+cpGI5/can5HIE/IlcXr/N?=
 =?us-ascii?Q?tjf2WvB06DepO6r2GX8f4JSzPJ2v9AE80Cz29e89ACmF3jQVAyQwcTIfownR?=
 =?us-ascii?Q?AFCKgkQ7y3UbY/ngqXEgoe8J+czfXm6igN3ZbImtfGoLUEsgTc7os6nReqI1?=
 =?us-ascii?Q?GiH6VNTKPMFFW6K8q7zMAlRdfQwT+rR/0sN7VSTo5s7hwZqSDiUVMT4kflAV?=
 =?us-ascii?Q?zpRimuN4KA7WduxgEEzQ9B6HNbBwIE3uzsO9T0zGUQMBwwpjclQbuLb/i0d5?=
 =?us-ascii?Q?6cjGnNARVFfw+R7Ik7qOlCiboHzqtJsDBi6+2MmrVYYEiCqhA7y4PBaBrACI?=
 =?us-ascii?Q?5zYGqsy2hwZKpF/q7kUg3AF0L5kBOXdG/yAjXwbv8AMz1ky7QoYLDBWydn8J?=
 =?us-ascii?Q?y6v7GPpGih+VgNTbeN/UMo7AGVANfqoEieN3LMYUagweWR4YOMEMvFnzyOeF?=
 =?us-ascii?Q?7mBw1aPdOHhSfFbCQGMpwZFUGqubaKyP+q04tDdOxTNBt8A1Vi26p+u2rYuY?=
 =?us-ascii?Q?zJ3s8RJoGM3P3/wFpHBL29LXb8xLzy3hxxhFEH03NR3TvKef82atEzqHxXZo?=
 =?us-ascii?Q?Eqt9ZMRFFlikPdC0FX/q8EJUYDIWqS7gesEI4JLk8WFNAwx63uL2teqP6KCS?=
 =?us-ascii?Q?d0UKwy0Xr6RAZ079SZ820Fe4c1RKGPokWAYwYsiwJ6euTsnVIvU1JM4fJjuS?=
 =?us-ascii?Q?vKz66q/PnwjoyQ97UqLsZ3TeNzE8y2Rilymc4BAUzJBKogTYjFodCo4k/Fj/?=
 =?us-ascii?Q?2ADA8M9Fd1EJsUlKpeodRt6ERU6H1/W5Eh6tgQPDYJq3pmYVGQINSd92HJwK?=
 =?us-ascii?Q?A8qWkmaVQXezQrgNngbv651MVCE/6ss2fKuv?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2025 08:40:21.8918
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2cdef3d-1669-49bf-3d67-08dde2e9dd15
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4361

From: Lama Kayal <lkayal@nvidia.com>

In mlx5hws_pat_calc_nop(), src_field and dst_field are passed to
hws_action_modify_get_target_fields() which should set their values.
However, if an invalid action type is encountered, these variables
remain uninitialized and are later used to update prev_src_field
and prev_dst_field.

Initialize both variables to INVALID_FIELD to ensure they have
defined values in all code paths.

Fixes: 01e035fd0380 ("net/mlx5: HWS, handle modify header actions dependency")
Signed-off-by: Lama Kayal <lkayal@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c    | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c
index 51e4c551e0ef..622fd579f140 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c
@@ -527,7 +527,6 @@ int mlx5hws_pat_calc_nop(__be64 *pattern, size_t num_actions,
 			 u32 *nop_locations, __be64 *new_pat)
 {
 	u16 prev_src_field = INVALID_FIELD, prev_dst_field = INVALID_FIELD;
-	u16 src_field, dst_field;
 	u8 action_type;
 	bool dependent;
 	size_t i, j;
@@ -539,6 +538,9 @@ int mlx5hws_pat_calc_nop(__be64 *pattern, size_t num_actions,
 		return 0;
 
 	for (i = 0, j = 0; i < num_actions; i++, j++) {
+		u16 src_field = INVALID_FIELD;
+		u16 dst_field = INVALID_FIELD;
+
 		if (j >= max_actions)
 			return -EINVAL;
 
-- 
2.34.1


