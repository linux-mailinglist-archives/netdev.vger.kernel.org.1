Return-Path: <netdev+bounces-95774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E23958C368D
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 14:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D5C91F21F43
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 12:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487EF219ED;
	Sun, 12 May 2024 12:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qOYtLSxh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D081CAAF
	for <netdev@vger.kernel.org>; Sun, 12 May 2024 12:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715517859; cv=fail; b=jSEKDastWjm7oH32N3V64L0e9x81xBcx3B94Djxe5CnSLKbPd9ZmQR5d05Rr/gvtN8uDjsdh8m9nC0ULDAWwWuVkLBK9RNe6mfgKcK4qAOA29AccMXStBExx6YpsTPubGywTkaFkKoY5kFiHDRkKOKTS9y8flOP7j9+YzAJBq0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715517859; c=relaxed/simple;
	bh=jorrVEziA/gbbzknrYW20w4nQv6r9KFll+q/dvLCEVc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T/+qon8DYK+Ife57ShPdLr/McaRFSL7PljUlKaZ63yDaGTVMkWBOzijh/0DhwvDXyCCrPKiQU1iXUqQf/tI0tdLONh8Hrf/f40WKof05mLQsG3Ka0cmT5KDT7+3mHuN+OBnFVAbSPevi8KEnrbuJ5yXIMq/4p2660Loc4Bwll2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qOYtLSxh; arc=fail smtp.client-ip=40.107.223.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oezlZYMxpF9lFYvQF+X1WW0XMuP2/PDgL4frgR6cV3SPBN9ZxdiIVkA5LgtlTKKahN2N93ERoznHdT+6X79uzjBkN9vLvBQOM8adulr4MfOSjazl7EVsltYSvuPHcJ+GQTR/44l7ICVKAY370aX7RKqGuTUhIrMHbEYt0Xh452g+1+ivCdZKYuU6Q5EcIx0kZror5g9m0ipomPJWglteVewx3vKVYmAhkzuNppsebduMNCWYFNDI6LPXd8cJAkH4xEUhiRUYAvLIAHEqbAYasIfCdbE/jImYWP9YGgymPT3bNf288GedY//Y+PiisxqKP4s5nBqyfbfGMnDEUsL12Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXjb9ovptAQZt+1wX14GsVytg9v/iCNPSh75obWL5rg=;
 b=PTIM6VlRhK0MMiN00jw+AQgIRJgI1iQRhHlCjuZvjHVr9g14gF35YjE7KqfO+0NFQIMtpZjjLTYQ4Ng6bEMt/XLS8/l88ZUo9xWaWIGe+mE5FjXlJVBFtW7WtX6yn2vy8zHWn+zhbHsh2JJHLhcxVElzoKHU4SKbTJ/Oll+kdsTY14GVcTAdZ0YcSAKfLN4uEUm0KyAVkdvqUB52Rve0YuSxwkJgmUYl12aqf78wkN9fMZrtchcyHXCfTkPTKQTf4zzWWtoPJbrteNENI1qQE2mIyTy4Jsi1ASwdj87gkHSDASsea2TJZnxQU1QGwav1qSlCAazVSROJRNveATdMJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXjb9ovptAQZt+1wX14GsVytg9v/iCNPSh75obWL5rg=;
 b=qOYtLSxhCED1XatK7OvUn+qkqwHQUYoULuvMYI8QD8+/U5TamdfYX2en499e53QsRMlkGVVJOVjtiCvkVykPmwJtjPIIgObKPW6xquwBnYxCTJdMsCnAvH7MZIBX3d/WEApxLPBPfP0JFyle75XbsohgNUjvajvS9JYD7f0T0IMfJUR8fWXtaVaW31IsllWpx7NDj0cdb7oUsWxdBBS5mdWrrYm0rt0ddzAxtIyOAq0ifaBVr+3p0OPz0a0ATOm5m0TQugwDme253by50U26el+TK/xWPnGaggooXoVQr7+WYD4oGEfpXkY7BudY/6r3IIjNHMOBV47JTGHjFAXJ+g==
Received: from SA1P222CA0053.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::27)
 by PH7PR12MB8428.namprd12.prod.outlook.com (2603:10b6:510:243::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sun, 12 May
 2024 12:44:14 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:806:2d0:cafe::64) by SA1P222CA0053.outlook.office365.com
 (2603:10b6:806:2d0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49 via Frontend
 Transport; Sun, 12 May 2024 12:44:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Sun, 12 May 2024 12:44:13 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 12 May
 2024 05:43:48 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 12 May
 2024 05:43:48 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Sun, 12 May
 2024 05:43:45 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 1/3] net/mlx5: Enable 8 ports LAG
Date: Sun, 12 May 2024 15:43:03 +0300
Message-ID: <20240512124306.740898-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240512124306.740898-1-tariqt@nvidia.com>
References: <20240512124306.740898-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|PH7PR12MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: dde0d0e5-a209-460f-b852-08dc72813a9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F5OJ1Q4/EPKPs8XYWq5tLjeLZAWnz3eYnH60aH761BuVZ5cTiuaBQKMr//g4?=
 =?us-ascii?Q?adjVeriT4IcaU4Z4K4TmKL40rG3qTO7y42YkIasmXg3WDO/cWFtzpGGG6Ilp?=
 =?us-ascii?Q?vHDDLuVgKldOZpKZgHN7l/HF155ktGZcphxe1/J1EqmNyyliEByWEaXsK/gs?=
 =?us-ascii?Q?Q3KHPtqJUNtrtbJgnachl0Y88LPEP2YNfH5FZ9A07Rsu6fZCo0yfkeZ+2qI5?=
 =?us-ascii?Q?M9OaqW40ZOVFm1NdB8+r6lNwIXu5IBvegIV9AeLhTmMpN/REBBf+IOaU/XWp?=
 =?us-ascii?Q?AQBh1caY0SIxQ59o6QSF4EvOj+gJFzVG+CDtMucIQaCM4jRaFRA+TE2KP2RL?=
 =?us-ascii?Q?kZ9mRYE+ChbKkUz2ewXbh1wJ3dPAH+8YD2cS096wAWbrN/l6gVwkpbSgv79H?=
 =?us-ascii?Q?pJBXUlqg1BMwiEYvUu9hQpHpz0k9bX8hlTdrdNEHYsTjZhGNtTcu2n/QVcTN?=
 =?us-ascii?Q?poCIsmCqfaK+VxvJaJdqbnd/ZHqRw+zG5lpNyDPlxheenQLLyUhZ5Jcp8Y3f?=
 =?us-ascii?Q?fzzlzHhpHpkF7R3Ey+YE+VhgeeRRJ9ej0upLrzR4wzkQSnpom84VHi4X3g+2?=
 =?us-ascii?Q?sqGWWKKF7f495bkA3BPwWUMEbWP5goCuv2NsrOAjauE1yRoOryBPksu82yKt?=
 =?us-ascii?Q?RbuWIsbm9mA6VF4VZvU7gddl7DLJEoQvZur3fTcDx8qF/eEP/m40IT7NJ9wB?=
 =?us-ascii?Q?5TOiQ2EQ3gJpC9nTGib1641PN+wI71jm+RIqamfO6narUNM9YLebBL4gzQZH?=
 =?us-ascii?Q?UoCv4c8QudMjHmRWDh3C7nbxCNDt45D+9k+JwTnj6oqZwe6nB6Bm39ExXsnI?=
 =?us-ascii?Q?T7I0O3vdaVUjgu+ehXcWg/0IylYwJJEypxY0Z0f2kEJ0RQ/btvDNfBmaZj0b?=
 =?us-ascii?Q?yt86rmmUzEIcHXHNzHjz8ThaRNKydgnahcyLkVGbqIUk0JahYv9WLaus9PU/?=
 =?us-ascii?Q?7m8ntQBVKuBHyiP1gY5W2c4sU+gwinXeHxbW3I186tXkYGA8F0GvQA47VpVR?=
 =?us-ascii?Q?8mt+IDkuqs47fzo863iCWYk1S40Vuywo3DxLrAvjVFUvi9fe1YU82+5YajRR?=
 =?us-ascii?Q?s8rHsEeNngEYCvf80MiSm1UNPVHnqnmjH9wuvhTiTEzR1rhkOM0YgRgqAUcH?=
 =?us-ascii?Q?EiExV7to5BrVXuclCR4gNLBpCa3fGD0XogQ6HpEHvhNDuesWOR1CJKd/JMb+?=
 =?us-ascii?Q?/gaDRtrAijeqzmSHPQCPUtGaGaWaPg4UFPvbNbdVEAp1xAWbGjhlgNBJ9xMY?=
 =?us-ascii?Q?+EU/VEEvQC0QvXr8rT2HuQo096Rd/n1VZSK5zB8aiwc2CVVKfjvczKz+7hnY?=
 =?us-ascii?Q?mIOQ/IOPAGGZqIHb8v5coo80NUdWBz20OvcvK4UI2Q6UTyRv8/s2dRi6vPyD?=
 =?us-ascii?Q?+/GHv+k=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2024 12:44:13.7967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dde0d0e5-a209-460f-b852-08dc72813a9d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8428

From: Shay Drory <shayd@nvidia.com>

This patch adds to mlx5 drivers support for 8 ports HCAs.
Starting with ConnectX-8 HCAs with 8 ports are possible.

As most driver parts aren't affected by such configuration most driver
code is unchanged.

Specially the only affected areas are:
- Lag
- Multiport E-Switch
- Single FDB E-Switch

All of the above are already factored in generic way, and LAG and VF LAG
are tested, so all that left is to change a #define and remove checks
which are no longer needed.
However, Multiport E-Switch is not tested yet, so it is left untouched.

This patch will allow to create hardware LAG/VF LAG when all 8 ports are
added to the same bond device.

for example, In order to activate the hardware lag a user can execute
the following:

ip link add bond0 type bond
ip link set bond0 type bond miimon 100 mode 2
ip link set eth2 master bond0
ip link set eth3 master bond0
ip link set eth4 master bond0
ip link set eth5 master bond0
ip link set eth6 master bond0
ip link set eth7 master bond0
ip link set eth8 master bond0
ip link set eth9 master bond0

Where eth2, eth3, eth4, eth5, eth6, eth7, eth8 and eth9 are the PFs of
the same HCA.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c | 3 ---
 include/linux/mlx5/driver.h                       | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index 69d482f7c5a2..5e2171ff0a89 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -713,7 +713,6 @@ int mlx5_deactivate_lag(struct mlx5_lag *ldev)
 	return 0;
 }
 
-#define MLX5_LAG_OFFLOADS_SUPPORTED_PORTS 4
 bool mlx5_lag_check_prereq(struct mlx5_lag *ldev)
 {
 #ifdef CONFIG_MLX5_ESWITCH
@@ -739,8 +738,6 @@ bool mlx5_lag_check_prereq(struct mlx5_lag *ldev)
 		if (mlx5_eswitch_mode(ldev->pf[i].dev) != mode)
 			return false;
 
-	if (mode == MLX5_ESWITCH_OFFLOADS && ldev->ports > MLX5_LAG_OFFLOADS_SUPPORTED_PORTS)
-		return false;
 #else
 	for (i = 0; i < ldev->ports; i++)
 		if (mlx5_sriov_is_enabled(ldev->pf[i].dev))
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index bf9324a31ae9..8218588688b5 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -85,7 +85,7 @@ enum mlx5_sqp_t {
 };
 
 enum {
-	MLX5_MAX_PORTS	= 4,
+	MLX5_MAX_PORTS	= 8,
 };
 
 enum {
-- 
2.44.0


