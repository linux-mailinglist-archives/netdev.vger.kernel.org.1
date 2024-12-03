Return-Path: <netdev+bounces-148679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C949E2D8E
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 21:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63AFE165D59
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 20:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E513209681;
	Tue,  3 Dec 2024 20:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GETezyNY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2CD208982
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 20:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733259022; cv=fail; b=BSdD/z6iv24jZCeIGNapdocYSfAcn5cskEqB+IlFal9WffeGl78uLAa63OVL8AIcJAlypyV9HOjrhnAKOuj3JRyd5rFzoj9pwbK0jSzgXAaHTPPSmRhV+CJYAbmTm0n/d4sIz4VvCu0IUl7kSdBDXxRcX7f/yQqGm5Mp9vBjRBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733259022; c=relaxed/simple;
	bh=iptCM5v3ga8gQ65h6eC02EyYSG3XxTwnm2EBMZr9vbQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dd39b4b3qGOIQRBdYHY4SshB9ZPvqGyOOOCVF/1qI1xfpcXsmGl/9Qds+uTAXTnF0/LOv/2qZfkc2c5zLlX1qwhfeNEPZ0GuVSGG6HFmA7zSD6cvHJHgFmBsQyrOzZdHmVEuNu2CL+FUVZm3Vc6j23PUZEx6i6fz3YJf0CpJg2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GETezyNY; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKJFXidARJAW6t+rqyeHQWGOqz/n0VujgplSiIMWdFTnvQJgcinKcymjs+xbxhF1TSXGrmlmg4+m7N2qpv+RCvZD00NJjk8Wepu6iLwsn8rGkMFEL+ypY+nlcwMY6Vabqx0U7eeukc0xb8xzxNjusAfKndNHfZg2XUgQFTKGSkS6wv3AuGML+3q37uxjGPThg3LrjdE+YTMCxmm6HIIFJjSCyRI+meSTke4kQ3GqI+j6XfjMeTqfnBNZCwLaynF+O2Q1pORlOTCMuE5E5K0bO/JKTC1B4jT3pmP3AgexcyCQ9JZT+Adhq9/xxHlA1hn2y4DqVaE1YHS4JvFdcCbhDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDFlAPiDITW85m0oIbhYBYtoiB1qmxRuRVMLh5ZqSx8=;
 b=IW1jRnIibEqIzRCGVo2eNLF7S5ALdCnlgBwhR7jVbgNoG8k17cvUIn98gDv4AUSyh8sPz4U7NmodSPk/oJcdVtt5dJacFXBk7LH2QiQoG/mJ/F+cFrF3/NhS7oo5b6usREIjo9Sz9zvHHOhwIsov25tWQXY2zgb9UjpMLvzKDnfCofKGdi/iq91KqH6T2xaiJ/neQlK/Xb9mnJFlG4fjpsV0VDgJYt6ej2VpJE8YGNFJqjZn5qS+iysV4OZnZqbmhydJukze11vBEwZLQIvO8ffk7Nd3lFWMFB9OY+oEnvgUAGn8rsbuS+J4BrSGbF2WhhZ83MZiM0lTztH809ilMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDFlAPiDITW85m0oIbhYBYtoiB1qmxRuRVMLh5ZqSx8=;
 b=GETezyNYHHBsNR/efJC/6RKHR179/hhi1HUE+RYep4efaT3j75RGp8nEJ5mmvg1j6nir5RBbhl2WooYNOwM4iQeEZWQfAonYeG07iTxpiLeVT0WKWFTPQOARFuAXVlRupKdN7FpyB1iBr5N9NvmyTPo43G1c0AIFiSNcLyexngWBXNMVikS/6zC8erVJxC4qWMkaJd2tXyPKHD30hPHS6OA9hQ0h8FRXl2c13bbufT/VUXkZE8ikv/DI3nZ2UP5huerSCM4slQSXWAfZpuYViFhzIeIK6r+nSE8OjeRnPGjP+07tDcIaGWSQATkKxOAqk/nQivAJEN6A/mQFV19K3g==
Received: from MN0P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::27)
 by IA1PR12MB7685.namprd12.prod.outlook.com (2603:10b6:208:423::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Tue, 3 Dec
 2024 20:50:15 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:208:52a:cafe::a7) by MN0P221CA0009.outlook.office365.com
 (2603:10b6:208:52a::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Tue,
 3 Dec 2024 20:50:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 20:50:14 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 12:49:55 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 12:49:54 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 3 Dec
 2024 12:49:51 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 1/6] net/mlx5: HWS: Fix memory leak in mlx5hws_definer_calc_layout
Date: Tue, 3 Dec 2024 22:49:15 +0200
Message-ID: <20241203204920.232744-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241203204920.232744-1-tariqt@nvidia.com>
References: <20241203204920.232744-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|IA1PR12MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: 31a71819-78ac-4f05-f0f5-08dd13dc1662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iDy89sQl18KKCjk5dYjNpFOKOEtPKlDo3lpy5jfrokpHaxzwPxsn980tcDfX?=
 =?us-ascii?Q?9JR9QlZhThbiLOm+Puzr6GvovK6jxT0dPa1VBnLF5qde+YBtLVHAzU6N+8vT?=
 =?us-ascii?Q?PsuOfsZ/G3MjBvUHL5gMn9xJ4QsJNE/7GuFEe1Far2Ako1jfSUfTIY/uKoC+?=
 =?us-ascii?Q?iLaTn51uBTRaDxlGYCtyM3EIZ5HlaznlX4zln5LQZOZ7NouqCNO2pq0q8FBi?=
 =?us-ascii?Q?rhs6SLFHZg/cWC3uXld0FE1xKYADDqU28ASw6IIsN/DTMD7Qw+AfitrthBNs?=
 =?us-ascii?Q?gWgqiVlQAEvZDfuBx/jQZ14aRIBpRyWFPfJ+GocR070IePYoIg/uRKMylbDR?=
 =?us-ascii?Q?4/NJTNpkm8oSuLqvYe+7THUuASVSXFoiB8l/Jk2QTWNLhNjukhFaok5HkYdw?=
 =?us-ascii?Q?G9heD5JD9ICUvkF6eFm76wAORPmipp1J8V2H/Deb0BSf9TDAuK2214qB8p5w?=
 =?us-ascii?Q?PPzKuh9iBU9C4duVKlA59ZrcLhd4IK6BXkF21jLuD+Xl6O4FKFfvnLnY61si?=
 =?us-ascii?Q?WXfhkqEEw6fwfbXYwt9Gq5vGfVXAk6agWuFNrCd4GfxrziT6WRw2E2eQt+1s?=
 =?us-ascii?Q?yCvpX9/7hi5kbh1HY1bYP/hiR/fteOHDmDpmhJm5guczFPG8JGDtEvPvlnqe?=
 =?us-ascii?Q?rsHVpzYy4E5aWOdjmI4xYHWaCkOpWr78Kg0hQdscw1rbo+waG6peZJgChyLN?=
 =?us-ascii?Q?LvFZTVyWGZHKK47nqZ4jY1JjXkp1HeDDSl/JoV+u/m+WvybwkENpckoAXSqr?=
 =?us-ascii?Q?Jtty2T4vq8ru9zZ4B/0r9hvU5/gS6GRpu6QVbBdEacuXX1KljRTVieCpQVnr?=
 =?us-ascii?Q?aBadOIiuvt3qgerasJK/adXbSoajsiie+yo2MP54d/0ywlpTv5+V6QLdRgxv?=
 =?us-ascii?Q?Ya2GhU6ZPo26lsjreCz4H91gPte+JXpxAcY1FtGAcPuXGfcHgQRhbi0YMJi/?=
 =?us-ascii?Q?0AYUr23UdQO0eUVnbbh0csxgb+6zQvy7J+NRKaN39cXOD1bmLyNhKFf4P8Xw?=
 =?us-ascii?Q?5CdeYRvCmgNBHk9KarIp4Ss+ImV+DIGIUKBMceQ6rwEeq7/NErfJdMeu2Ktr?=
 =?us-ascii?Q?uJZ8fPMoiBdhqubWLn8AShylOz9Z1E38ydezCVY/kPP9gDsU4xpWSt3KgYOc?=
 =?us-ascii?Q?WiuobteBPHIesXCDxy9TPqu6UVP+jpKX3SY5Q516p/Exd8z1HJO7lvSKXNro?=
 =?us-ascii?Q?uQnJCAKpP0jxOfIcrFgaoSt4gWrvO8yGbvw4iXzzGs/YTLndyg7jBTa7LOtT?=
 =?us-ascii?Q?QFD466+ImC4IVPLQypqsSlBXbpeVQ9aTzjb/PF62lqEVTmqD+XyNG9UtuL6g?=
 =?us-ascii?Q?g/2rsG2VjRHVRRzvmC6oVVaxhyUWAAHOFmK/JySFhe3VtvKs6X8GrdvGwBrD?=
 =?us-ascii?Q?6ql4UsKqD5yN+mUjbWnUXqp6offF/HgQyJ8LR74uAjrOhA0eYALWDOALhB9b?=
 =?us-ascii?Q?QEqhdQ08yZrvBNTYgcPUDyXngawR0OAn?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 20:50:14.3763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a71819-78ac-4f05-f0f5-08dd13dc1662
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7685

From: Cosmin Ratiu <cratiu@nvidia.com>

It allocates a match template, which creates a compressed definer fc
struct, but that is not deallocated.

This commit fixes that.

Fixes: 74a778b4a63f ("net/mlx5: HWS, added definers handling")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c  | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c
index c00010ca86bd..9fb059a6511f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c
@@ -39,6 +39,8 @@ bool mlx5hws_bwc_match_params_is_complex(struct mlx5hws_context *ctx,
 		} else {
 			mlx5hws_err(ctx, "Failed to calculate matcher definer layout\n");
 		}
+	} else {
+		kfree(mt->fc);
 	}
 
 	mlx5hws_match_template_destroy(mt);
-- 
2.44.0


