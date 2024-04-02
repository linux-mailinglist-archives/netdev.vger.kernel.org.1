Return-Path: <netdev+bounces-84035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8B3895578
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 15:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBF59284A30
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 13:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C6285267;
	Tue,  2 Apr 2024 13:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fkDlNi/C"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6410784FCC
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 13:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064765; cv=fail; b=iYDmtnM9AwCxYryukEeuq6aIonKgt9YuGHdyrKKnby/JilCG4mwLMSUGfr3q5/mMF5EsGwceJ3WDfBgnoCEz4ti9j7/VR6jtm9/fHYOqRVDcZVDdaYakYpSjSRAizMCj/Zq0e0Pp9/NempJncgpvXRohvIUcIdT5lHWOYYTsOFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064765; c=relaxed/simple;
	bh=i3WiLWWw/U1XJBDiqbdWWB7AIJsxgAbbOO+gLee/vsw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tw0SMBbhuM0fmZ4wLS+LIFTDs+sFCGJEAUFJAA3dEbGEKlIfi7c4tPEjbx+rdVECQ9X02uF8/TkoLUSRrUMnd3BfEIdmsnmpXDXpF5WcOJbII7UYLKl1iFYajNkDHEeg35i5a+3wW93yqZqYBOgwX/LmCdWQc43q0J0RFhVLHPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fkDlNi/C; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPcrJDUVMMS+ViyHuf9kwI8HqhlQAThV/Y5J0DGEl9yNvZBAU+VewQ/OZ97BcwPvQ3diFci5nECXqw+UXaKcS8Ip3lnEg/JSkRZZBRFn7Y8tG9rcDtCtl1Pxt03WPaOgYy1pJRtMY/zwADkO5KrzaqL8hrSWH/ITWOqqauUwZR6gl2RklVqIgyhzOdMwsVWHK+SbC5BefyH0kJpHAC2sBkFMtiwXnwjbrrR1P3m/tcqRA6BdiFawmri4afpHtoNznQOkrFx1gUZdtc6j6N+JysijJpBJzCun0fTJlJ+eqFVIF8y8LEie1cYnd3rEqKvZT8xayIw8a5h6d7hkwbKEOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MV4en/8ULq+35GWrwuYQo8yPeubaGb9eLR9fWK408oY=;
 b=OON8yTwohcpcwYhwOxtTMWGwgTYw4v9zDJpWKPKod5feYN2uMmsJBbIsjy/TIWCHiQ5+ny/IbUirSknsISELcBRSG+TIw9PP28uqoYWoBktc+8wd0iZl/RVyWwuOTBQN8vD4Uaew+F65eUhJyugxt51nEfwQnBUXbtfdyxIS1KIN9hl4Cgx1yaMeK4l+VUGQSib+YbccDjtsbCl5wfOOahaeli7wKFJCy/3icsj7BABexbHF3ytxQYAbcw2s7wXLM23hc0syPLyPuhR1oY3Mm6DhAGRwruDeWtNppqvIn/ZPZIOShU7rEZn7Yo2LwIgyT7zs7Iccky73QOXdbM8srA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MV4en/8ULq+35GWrwuYQo8yPeubaGb9eLR9fWK408oY=;
 b=fkDlNi/CIhSK7KZ5qU9bdkdwstlXRIK+IyJT2QBGVeRaqSAtORfgk5u+DhfZU/XxJLGpPh9xQsvdcDYwg9+iK+ABkUTKyHe9XNsaJ4cAT6osZw7NRzz/9wBHMps+uVPV78OBml9TCkUC7q99GpoDKXdWTIuoU/02SpEPDnF5wFfgIMq6lJDlefnDKBkKkRxQLhcWYh8e6sEIwsmW+SI+p4kkLX647RbAXTedpvEZXKdF5ba3Q+E7td897qSgELvVi7znvWQyk2VKSla32RQ1CfqesWwvX5mCOd0IqJBjC8/7Mj3ocYCAg6/kIwq67eGNZPvcNXOZ+HrJeHz9kJq+bg==
Received: from DM6PR14CA0040.namprd14.prod.outlook.com (2603:10b6:5:18f::17)
 by BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:32:38 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:5:18f:cafe::33) by DM6PR14CA0040.outlook.office365.com
 (2603:10b6:5:18f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 13:32:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 13:32:37 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Apr 2024
 06:32:13 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 2 Apr
 2024 06:32:12 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Tue, 2 Apr
 2024 06:32:09 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>, Parav Pandit <parav@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 11/11] net/mlx5: Don't call give_pages() if request 0 page
Date: Tue, 2 Apr 2024 16:30:43 +0300
Message-ID: <20240402133043.56322-12-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402133043.56322-1-tariqt@nvidia.com>
References: <20240402133043.56322-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|BL3PR12MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd36111-4b33-4195-8c2f-08dc53195ced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XT9tTl6MMgwrhUsvSNm5moGfPoEw8/5SGTP1etyLC3HCrV0P5qGNaNtyDOTyPcLl2SMPEYB6+rzX+DN171b1QyigshepyMY0qJhQKbp2Sm1tFo7NKH1HJloy/yhl+9Z57xLU4kGGnxb3FxkiprTD261TxpUd8eaMIbaZIPkBrp1ku/YBJTeH+c5N68p7/5qkaVUoRzXexbSjtsqnIuDVwvzP0xyEDabrcAc4MwLfWmbgQt/IC4DEWYjxz+KavBoQy7fz/3yaKqK1bGLUMhUkpP7xt0MKixSD1qtfbeEO5FXOj2q2eZa1Ga1gchocMbwREnoLj9VGqyKi6KlTOHxtYeaaU5G824QJgSrm56skm6BkfbrTMknBVe+mbOIajISgKxigkS9WxqLoPL0DNxEM3scv9nXIXHkKdfNPP9CnRHBsYKqBmC8AJGuCqvhgMjkCKPQ8lS0ogZP7wnnQS05mYltshtB62CuwqtapgpDnc7eGwyq+RxHM+io6G7xSMBWgvLZ2Rw4xbzeQSF/tAYTB7S+KWBKgl5PybKhQe1/Zod/nPT/o8NshO/zC6tM/4vgz6VCmcBXkt4pttKNNI2BBmZiYJbI1ZEs7AmPrD/wu+EA649OdYqeen6rnkjPvMUWlgVZQ9o6WfezQsAxJ/jPBhmLFNHbDj7pWCq7Epy+3JBpbMWKDuDmeR7b1R3oGibkCU1Q15O+uW+PewwR4VogJvCRMpJGfVw7xlPy3GZhIoPpXIu2GuOvSnydJg+qTDwgB
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:32:37.6721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd36111-4b33-4195-8c2f-08dc53195ced
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6450

From: Jianbo Liu <jianbol@nvidia.com>

Firmware will return 0 on query BOOT/INIT PAGES for non-page supplier
functions (external host PF/VF/SF), so no page is needed to be
allocated for them.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
index dcf58efac159..d894a88fa9f2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
@@ -660,6 +660,9 @@ int mlx5_satisfy_startup_pages(struct mlx5_core_dev *dev, int boot)
 	mlx5_core_dbg(dev, "requested %d %s pages for func_id 0x%x\n",
 		      npages, boot ? "boot" : "init", func_id);
 
+	if (!npages)
+		return 0;
+
 	return give_pages(dev, func_id, npages, 0, mlx5_core_is_ecpf(dev));
 }
 
-- 
2.31.1


