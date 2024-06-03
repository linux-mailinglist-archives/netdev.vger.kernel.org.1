Return-Path: <netdev+bounces-100356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC598DAF1C
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 23:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61C94281777
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 21:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F386C13BADF;
	Mon,  3 Jun 2024 21:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cFsiAQgd"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786BE13BAD9
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 21:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717449822; cv=fail; b=nhQCIC+YZ+9XH1VV1OuWloRZG3EuVO/t7topoxrmfYJkE8LONGlvklS4DJ34/81LbrvysuPkpjT4FRwGaw2sZIx+YjBMiyfNmhxn0JPSLr9WHulmIkdB9QaFZWihFzhA9+Tysc6f3NBoPHv3bIuGyrD1GUQDQODxe3tMi5FKbmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717449822; c=relaxed/simple;
	bh=5rvU00bqniOq/QkJOLJKmhg+nrRkFWKgEOe9LPleFS8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rDGrHhQld/4n/dbigIhTeVZZcWJ/6vI4yq9yyNMC9Ts178014q2qfE/V0OJlmca3UGeRFfR/2qt+e3xUjcPu1y+KsvWQsZqU39y8hcBql35AsEqFsHjXjS2YzmZb6OzYnxeq5Fb6+5dIr1dqSdpaZu3xrHS6sXOSPtgJX67ACxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cFsiAQgd; arc=fail smtp.client-ip=40.107.94.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6+i3yEzDZ7q6eLUU049no9xSz+ZUV1APmw6bHtbY4ls07Q9zfP7O//nQ7Ag20+xcL6CbR2+stYIP2/27xtP31Y13LeWZ4P1tb9xxORfZPwdgOgWGuZ/N30FE4L9ZGtgVWjPpTW7ddEMrHkHmd4FAr479ytPEJmM7h3P6cWymKb1m59CsWuQn54wz1gjNQ7hBpKs9N0azdJvgXuWwjAeU81eGDDp+KYng1mumtiV+/CVlx2v482YKwlGQ4WHe3YImo2WEAG3PNJ0Lftp0ak8RdOXhu4VjFD+0d53g5TIOhDnKAvbjfoxPmIzzHO6407hBw0rx98FRT8W4gkxIU+4tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Su+vmJLlvWp2n8EK/A2I/74lxbjC9nxgafEP1iqUJOU=;
 b=OTmXZzKjKLjI4CRRMMiLjuFUKNMhjTtNRWmGV1Mel8Azgxm1Ze/V5XGBaVADi5+iDE4CxYqUsAwL2T0VmI4vHwA62mJONRm4dmml49yQ64t2geAT9LRrG5tblRPn/P2JHI0Zxt6JRSVnVnnEJJZPbA/zdvhMHw/ojteRBtELlFmdRqxtSemvt0okuuK5fY2tGmHKP4ejM0iM6FbPlj2hwXq0ZRjDFwbeoUX4r640cqP274j93m16/6s9hgVCtwyaGUfld4k2kjetsUPNwaG+WYZ/7N384ixSpYdfqR19ofsx0s6t2z/LFkPuHPEKXuNqdA+WLnWBJXGksoOWst3ohA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Su+vmJLlvWp2n8EK/A2I/74lxbjC9nxgafEP1iqUJOU=;
 b=cFsiAQgdHOTcPGngK4fVQk7ptD7ume7NNmJL4mGqLPqFEJrv4LdhTywApy+jxERkAyAsQL/dgR7rFX1FAONPbSlIPItatnGgkhkfuW45/gzNTAXcx3Qh8wMPHPEf5KavcKG2shGsezd7Z6IZp2vZXrGjj8uwkCAeXAb2ZeekIxUbOEw+i3PqS1kT4JpUnJ5H9MYPx+1GpjxD4dx/F3SbYtg8SBRb6I7JO4PniyyPIIdJ4nyliKZ9JqIcH05sdzbtVFQp1bp2qQx6kNi/G/SaFYmfkYF2ohAetX8nRsutpgFa18Y3fHGIeKzUT4K0GKSThCRCfxsmFPFnGFEWgWqZdg==
Received: from SA0PR11CA0081.namprd11.prod.outlook.com (2603:10b6:806:d2::26)
 by CH0PR12MB8532.namprd12.prod.outlook.com (2603:10b6:610:191::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Mon, 3 Jun
 2024 21:23:38 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:806:d2:cafe::91) by SA0PR11CA0081.outlook.office365.com
 (2603:10b6:806:d2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Mon, 3 Jun 2024 21:23:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 21:23:37 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Jun 2024
 14:23:26 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 3 Jun 2024 14:23:26 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 3 Jun 2024 14:23:24 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 03/14] net/mlx5e: SHAMPO, Fix invalid WQ linked list unlink
Date: Tue, 4 Jun 2024 00:22:08 +0300
Message-ID: <20240603212219.1037656-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240603212219.1037656-1-tariqt@nvidia.com>
References: <20240603212219.1037656-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|CH0PR12MB8532:EE_
X-MS-Office365-Filtering-Correlation-Id: 272390bb-9f17-46e2-8e05-08dc84136ec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|36860700004|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J3rcdhn9bnG3PlFZwtVLQCcpJiM9j9JQOOVkMPNx7M8Gzvq63jCQMlLHmz0i?=
 =?us-ascii?Q?pVYf2F3YGbWlrlgxD2OZAgPyDifY9DpUiYk2vMZfx1jM0LwpALr3H63/AzqT?=
 =?us-ascii?Q?PcMArkg0Td5N08SE9/pgMbpX6izprUizrj3H9QaUBpDlifEqZAToS6itloEL?=
 =?us-ascii?Q?hSxO40dvXacp2uC9ypVVyp+2oGaaiE76W8Dj20HjL1+77aTLOriPH4F1zCFI?=
 =?us-ascii?Q?2F9sHqJ6g72En5P6g+1l6MdVxjGbxzdbIhIiRw3tIDkD4rf5pAsi+vslgAut?=
 =?us-ascii?Q?sLZCeKSBxpKtCg7em4jV9UcQKMPHqevHVUyM4MFmykAwwL6AW9+yV9VDIKwL?=
 =?us-ascii?Q?p78xDr5g0DaaWHSyshz2nqRjDB42wAR9X37mdCrTGBnAf1xb4aA/jtZgsGYg?=
 =?us-ascii?Q?juXyQxh21Bo4IdwSjJe8f2W2ZS0ZWPC1rCaUT1LUQIfJ+2vQ2uhkgBPAdSAI?=
 =?us-ascii?Q?leEVbOgIe71ZpXpWu328lAc7JOcAt3GLVQsNxfbKrorFpKDzXznrQ91ZekXD?=
 =?us-ascii?Q?XWlyIy2hZ0R2C8eNIjUXVMCRX4ONHbk12j+8lhC9SRCJykoAD/0AWRAN6RVY?=
 =?us-ascii?Q?CdJPBzLi1+CJjotD1pe7E/81E/Lyc3evyPtBLP4sczMC9RQzdQ3GUF4eHlRj?=
 =?us-ascii?Q?CH3Km+9leeG+KJ1Wr16yIGXlO0NPvTYdUv9CTqHvXSR5VvqipRLWgIPanHTk?=
 =?us-ascii?Q?dDutcbwe3kBNc2z1eztJhzDTNt6X8EQ//JruPouOQlhcyAJQ0B0yoRO2Cynp?=
 =?us-ascii?Q?B0AR+X9k9u89SXBkS3Thu/FDEy096GfqWRjtudfZCyVdzIcGwyFvQ64PFwAo?=
 =?us-ascii?Q?mdxv68luMcuMJnM+qoYMgPfbTfgiRd/0++y6L/vaOyShFAB+MVZRsuZdSpKV?=
 =?us-ascii?Q?raGL+WWV/Zzdpn7SoqlhAAx0+ZghNF3kGfOglFgLyQHWTNhx0pWrKxag+4WJ?=
 =?us-ascii?Q?8ya6vI43I1idx0ayTv+Ke31PkvGVzM5PQIRkg3AWI5Jw9zB96AT2+u12Josu?=
 =?us-ascii?Q?/AWzzW8FWRD/06fIUpNJSeyxYYHlttbg24q6CP3LdXAZF5ooDvJsfehpmFNS?=
 =?us-ascii?Q?t0xKJ7iTYJGBeZe0xUC0YI2pyoNrK6KC+k9VIcxSkSHX9tW3q9NhyEMfFpi9?=
 =?us-ascii?Q?bxurAAXkhSA3FcUmmU8n67FZI1/0nqLGcsPVS9+LzZ0q5ZUWZm+f9ZETR7K+?=
 =?us-ascii?Q?GkRK+ZmTqAd8ZtxFobiJo1IyHRiFzOZYDk1V8o68b4OdY54coLDiSPbmnbMc?=
 =?us-ascii?Q?8GFEdfcqHxf/umTgk1foo6qs9bcU1fV/i5ZWbIrjkk9BfNskkT3+q/027Glg?=
 =?us-ascii?Q?vZ00Et8p8DvneDkw+mov8wHyY0pQaVyzUtzYN9SICqXwCYWq7M8V5Lmkq5fs?=
 =?us-ascii?Q?WHZCkUuRBhIzjV9SnYYMKGMn9f75?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 21:23:37.6006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 272390bb-9f17-46e2-8e05-08dc84136ec2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8532

From: Dragos Tatulea <dtatulea@nvidia.com>

When all the strides in a WQE have been consumed, the WQE is unlinked
from the WQ linked list (mlx5_wq_ll_pop()). For SHAMPO, it is possible
to receive CQEs with 0 consumed strides for the same WQE even after the
WQE is fully consumed and unlinked. This triggers an additional unlink
for the same wqe which corrupts the linked list.

Fix this scenario by accepting 0 sized consumed strides without
unlinking the WQE again.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 1ddfa00f923f..b3ef0dd23729 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -2375,6 +2375,9 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
 	if (likely(wi->consumed_strides < rq->mpwqe.num_strides))
 		return;
 
+	if (unlikely(!cstrides))
+		return;
+
 	wq  = &rq->mpwqe.wq;
 	wqe = mlx5_wq_ll_get_wqe(wq, wqe_id);
 	mlx5_wq_ll_pop(wq, cqe->wqe_id, &wqe->next.next_wqe_index);
-- 
2.44.0


