Return-Path: <netdev+bounces-136221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351239A10D3
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 19:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 760C4B20F85
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 17:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD242139C9;
	Wed, 16 Oct 2024 17:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Es6nXEEn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54372144AE
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 17:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729100295; cv=fail; b=AyDjDSR150xIuohlHnyesWUVLytdRcggYOyjQMRyE16SbgtIWYyt0/KreqVwDw5MBbfWfjHioNLw7cqfh1SsOUqxCfa1XmaGCZA7oKABLn3bvqhM+xhYUE5RPz5JwwmVn190wc4PK4wECX0bXPvOOcLq2WCEz9fUdZjYzCswML4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729100295; c=relaxed/simple;
	bh=2TcKTPp0bKnP/mWG1aiVa/q3LWtt41hAOhsXyxShtXY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N12evEh45r9d4uupB7okeKPp6kdxP5nGrYfNB7oNV52boXvnov19JUkRhuDH1kC4nIFXwAGEKj213pvA5/jTN3Rj2Cfx5oeTNUUTZVIIL7RgVzQq8reKNROnlBTui3EPRlxLUq+5V19cPjFxiwDhvUfzQ7eqPh3VujCSwpWncvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Es6nXEEn; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LBiOuMbEp7eDQf2eY4/NN5KRxnM/SpxU2j0eJ1hmsDhTcrc59YfYMFgvWOADsp+s+Oi3dy8UZCvjXG0O9UHl0NgBO+nA2JSQhxWmOzGD7nMCAo2eTYbkjKmP0yrlomRJFUCA2GgYvRMZ7RdSmlPeLwFctes1OCNSeJiuNE38TIOL8TJDbXjlQItC4YQsp+uqXcWfy7utXA6hwhG60Zd4mU1zedM+3HSpcjFzUpn5G2s1n67vRxSkGofFy0acJs6Hylh5aKO+OJCKaUVo//ec75vAadgJ8ni6fFM28W6cbH3CETXMIDRCw2qicogGf4tOnusakflI3uaAZY+jdpIdVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CV1/mQR5oVJudf1fDkcVH8tyGjewAHXQXSphYh4Ty+I=;
 b=Q2On10WP1VBjUnB3nYWC2LcJNd53jmHf97oeCgkHA+G+rvnJimURmHTE90jxpVeTSntEiaKEqF1NrerSmkYmawAeq41uxv5kTVTrBj40DZoQe3Y0BhcjThSIINmB/cFJ3MTPmLL6uPXH1pUmugKFy6TxtkFCKwQeXky4L3BWpOEGKkPDV4AFSvGaUgLnWhnPqZ7L75jamhnnaKK4B5LrhlN39uQzUJyhCdi9KeeNlLfkN9gUMNQfn4LfucJvivSIS5voWq54/G+DJfRrF75LrtJfx4Zmg9b9ksKHF1R7bYP4c8drc5zWYoIW6Kk1ftqVxN2Y1sURgXjhybtvsO1fRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CV1/mQR5oVJudf1fDkcVH8tyGjewAHXQXSphYh4Ty+I=;
 b=Es6nXEEniN5YVK2Ri5lFv7hy4XtKkdH9TiCQsDpwRch0ndG/8Oz0nc+Tnpf2qGrgMxoD40jnVDYBZALmFG+W86EOGoG0NkKJQRM1dCsaLB/BBl5nvKPHLuXDcfEuWQ6rcszRq97K84jClHW0C+/xiDGW2JFwaDGxsuw62xpvrN1FYGJii7t6woo/otwDV6KW+dFqJYY+hXF787ssujWI2NDLSrrn/hS68mSd+lzgzJXi5SD7ur5o9epFzrR0IfCsB1/4zzr0cORihUv76YSpgTtPM6RP1Ec3aPSnL4Kqlscj1FQilmwNGsoeeRJhTACUjKtLiamF6EJ3/1+A/iOkUQ==
Received: from BN0PR10CA0027.namprd10.prod.outlook.com (2603:10b6:408:143::28)
 by MW6PR12MB8952.namprd12.prod.outlook.com (2603:10b6:303:246::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Wed, 16 Oct
 2024 17:38:05 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:143:cafe::12) by BN0PR10CA0027.outlook.office365.com
 (2603:10b6:408:143::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Wed, 16 Oct 2024 17:38:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 17:38:04 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Oct
 2024 10:37:47 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 16 Oct 2024 10:37:47 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 16 Oct 2024 10:37:43 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Simon Horman <horms@kernel.org>, Daniel Machon
	<daniel.machon@microchip.com>, Moshe Shemesh <moshe@nvidia.com>, Aya Levin
	<ayal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V3 12/15] net/mlx5: Add sync reset drop mode support
Date: Wed, 16 Oct 2024 20:36:14 +0300
Message-ID: <20241016173617.217736-13-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241016173617.217736-1-tariqt@nvidia.com>
References: <20241016173617.217736-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|MW6PR12MB8952:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cddf701-d3f2-47be-8485-08dcee094a84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uxqYVQXUfVOcQttrLmLE7i7qXWVs8sTf4OrAG+kZ/EcaCLhO3wOWRaW6seIq?=
 =?us-ascii?Q?yUalRODiuUYsmoE6NLkw8OmGohj7VfB4QBZtj6LXN7RDgnBDd2R7vpqWIORL?=
 =?us-ascii?Q?/12Yc7htXUe4PidFY4LaHunkCr2vF0MdZqU+Ghr8RIgU3MiE4ddV27iGClC9?=
 =?us-ascii?Q?9OjcMjNiiMWUvtCvPWMOpqQ0GHNQUHnPMFk+g/r81NOM3gGdD8OBqECrgNC1?=
 =?us-ascii?Q?ou56csfntxFZRV10Pwz9RAMWlSBzgntD2Hb6QzLozFfE17tb5D1EHYA29e/A?=
 =?us-ascii?Q?zeThwvHoiARS/+D8NHQBe+k4kP8iCZyY+rJp2Vs5XWrKdRM6Bm8xbgkrUKjp?=
 =?us-ascii?Q?mlNa1CmFmMuw0str9c67ES4/x3yG9CCeP7POeBHTYa6WZXs64J99s+bPya8w?=
 =?us-ascii?Q?MeiCcJt3QH52xp3+ZMIdYk3KTQOQ8BfhSZO+D7Cjy6HeSowGHtK0k0RT59P0?=
 =?us-ascii?Q?jQmYnMlgNPvE/0KXD/sS9I3oIDxQb3KpF9dOABy5jfOU2yoTEv0IYQgD3z9x?=
 =?us-ascii?Q?jmKT9eagUUDtNq6H3xSFBrejmWjgYyjyOUftcyu5wmGip7wJvbjHw3kNU4Aa?=
 =?us-ascii?Q?7rr+6ye6VNxT/vFk7NTYtKYBzHXjz4lOVnNUgGS37CCHrnisRjmtjcPbGu4T?=
 =?us-ascii?Q?AKDJXEv7mwiun+taxZbH2AcBrD/FWmZszaHM4AqE1jbgiK8Uiz3tCj0jTzk+?=
 =?us-ascii?Q?0IWNtSLZ6csQGtIKTIlEjPDzzMApO6V79Q7HIWNfwIPuinTl2PDWPUFJh7ZW?=
 =?us-ascii?Q?jKchG2zteRPvqYRgpM2TaUHa8f7SwIPoe72MUJO00EdhC3/MBsdigmBS/SNg?=
 =?us-ascii?Q?GzurSTsnR2XoA/JQvKvDUoY54h3QtGp4fHf23DlrWBwB4Jd28XPsiwFyPOLj?=
 =?us-ascii?Q?ZS7FU+j34GLi5a9S2Qi3HHL09nh92q9NcLYXfCyRpwG1TNlIKuXuvKn68to8?=
 =?us-ascii?Q?8Bodk6nnrhGmKTlrsCGDs3XAw60SgR3OmzaXI25DDH8uUew0SYsRI9XLtYez?=
 =?us-ascii?Q?SWfKrFbvFVtcViIcBDUbpeBGWxemgMwnJkbcrCFgdY+8+CReQoTBv3BxRUWk?=
 =?us-ascii?Q?TF68RondL5HZSY5PBoGiRNvJTOc/SqbVCQEaA8bHtt8iiSC3X4locrv8AUUI?=
 =?us-ascii?Q?ryUrPRSa26zcWf/ktjd9KGc4csQDG9dvwGi9fuYnQJrHzEUROYuecusGdO+G?=
 =?us-ascii?Q?4AWODW56wcfIqYrpE2BhoMqiHQG/dTKrwqq9ebJ7EOoI+owCkgrtFvpDBr5I?=
 =?us-ascii?Q?4+rLkoofmbQigCJ/W/aco8rR4z45H5RTTl9yPrzH0LjfJrptN4acHqHHJis7?=
 =?us-ascii?Q?VcbWPJ9vLO+CQjX9DZjLNo13eIfiAffgxBAGVqktkIr+4kH0ycb2irtLvwNg?=
 =?us-ascii?Q?cwPT57HEsHIniGSOmBFuO6o2h3Mk?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 17:38:04.9895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cddf701-d3f2-47be-8485-08dcee094a84
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8952

From: Moshe Shemesh <moshe@nvidia.com>

On sync reset flow, firmware may request a PF, which already
acknowledged the unload event, to move to drop mode. Drop mode means
that this PF will reduce polling frequency, as this PF is not going to
have another active part in the reset, but only reload back after the
reset.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Aya Levin <ayal@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index 4f55e55ecb55..566710d34a7b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -35,6 +35,7 @@ struct mlx5_fw_reset {
 enum {
 	MLX5_FW_RST_STATE_IDLE = 0,
 	MLX5_FW_RST_STATE_TOGGLE_REQ = 4,
+	MLX5_FW_RST_STATE_DROP_MODE = 5,
 };
 
 enum {
@@ -616,6 +617,7 @@ static void mlx5_sync_reset_unload_event(struct work_struct *work)
 	struct mlx5_fw_reset *fw_reset;
 	struct mlx5_core_dev *dev;
 	unsigned long timeout;
+	int poll_freq = 20;
 	bool reset_action;
 	u8 rst_state;
 	int err;
@@ -651,7 +653,12 @@ static void mlx5_sync_reset_unload_event(struct work_struct *work)
 			reset_action = true;
 			break;
 		}
-		msleep(20);
+		if (rst_state == MLX5_FW_RST_STATE_DROP_MODE) {
+			mlx5_core_info(dev, "Sync Reset Drop mode ack\n");
+			mlx5_set_fw_rst_ack(dev);
+			poll_freq = 1000;
+		}
+		msleep(poll_freq);
 	} while (!time_after(jiffies, timeout));
 
 	if (!reset_action) {
-- 
2.44.0


