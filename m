Return-Path: <netdev+bounces-100362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 267EA8DAF51
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 23:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7DDE2859EA
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 21:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867C813C8E3;
	Mon,  3 Jun 2024 21:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yp3UelN1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E4C13BC12
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 21:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717449839; cv=fail; b=tx6yr5YR5EpKAvDGTdQLYeh+EGeLR+t7R9kAYFlmPgRYpJA8fmaqOQTj6a1J6hPyA6OTAShcOKJCVL2LtNIKT2gFrK7NcGpw07n3nA4iBg4FkGkvDHpUc3wqI8uMf7thwocCn8WPaqzF+eg1e3vvLEgsF65toqWNZgrNKHGv6cM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717449839; c=relaxed/simple;
	bh=ghZQBU8icZY4F6e5S3tK/Dk4ppNJPavgPl8CXFxEjzA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BfA5+nwcQn9bLLRZEWOG3YpuwIOdlaq/HJqdODfIp9oaHAXsKq6Z5yLKqE/i5y3S9PxsT5ifxiV+ydv3GrsZrc7HC395mQQsD6rwSvHZEmlLa1WBG7LOnMc86sSDQNuVCgMtW//hkUPDYKllRugA39IGL39qPCRtjbfuOscMltI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yp3UelN1; arc=fail smtp.client-ip=40.107.93.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUyZgRC73iLnkUIS7OSTUhUnqQNALLtUohNJPQh7eDLexhtMoxySx1FNGMP94L32YZyt5GPKfRNwJaaP4K+Jd89G0kCx3BiSrtwNT3clX+ETqwLrn8gqEAKs8BDnpzzSG2eyR6hOThLOe8BMpMYCFYz8pPRne3oG6L4nk3TeOrXmd13oR56QIEWN0Zjzm0/3iuTg9jsITLRQKWCmfuKQWL2m46le50VqIAS50wgRXwcYZv/9/6VWaTS4TFBb6rcY+wF6qSiwtDraX5sF48F4XaFnrPMpTP8czAe7qskK6m7XAbMIS1eAkIp8MWE0lpXJFZSPnQhxdZCwXK6wuC4M8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8loLAjIp1BiRjK7VzCn/rZhfo0ImD+XTMXWMsHEHSg=;
 b=UAocvgyFk1uSdMDfkLBXcVuS5yKiTJJ2vAy6RIiHVXYglz+FDBiyuoIzR712FAk8TXjuajxF0qe9QIYvMM6dmoM6sAI7p3Y6oewtK62IJmCsb1T8bLWLq5VYeQMDIMcVdShEigNLWwDHDWCKpNpo9COtGvq2vLzW1ZYRVi3XrXEZ/pSVgaoc0T/WpK5BT80nOQ6CpJ28gWvsXiY84M3vfhkYlugKVrvZuiM0J5NhmYL7g+0uIOUUMG5Aps9rkw3aG+GmLV4CvW19eogv6HVIPepaPDmHR2RPvNijBh1o6LNyDlI0MfLj7cyr4mfvpz1LWWdobrGyls3ta0Z0GBbSAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8loLAjIp1BiRjK7VzCn/rZhfo0ImD+XTMXWMsHEHSg=;
 b=Yp3UelN1DT8lRcMsjpHAIztCTe/GQ4b1cDmy+v6KMqCOc+seYM88jYAf88PTyms+MqCDsI+VbFBWZN5qROLf4nk7VZjXoKsmyFWQVQ+gIsgh+2jtwnc7UAPPg14QsQ5RWBrHcAaLrgTAt6vyKj1HEOonK+y4hPCJ7wIIotYwGyX3OyT6NBEoN0Rq3VPZkQKV/zHkSztmJgXkHt1jG27nImVLaaMWgS3izjtn0Vb+WjmiJ7Tjgw3EizEBoCg7/kN5p8cTjqC2r5n6p4ymzAk6F4q80awF3i+UFhwsVT/rLZZt9woQAS3ARFeyLjkaPPvpSeI3HZeei5gZ/1B3R76R1A==
Received: from SJ0PR13CA0195.namprd13.prod.outlook.com (2603:10b6:a03:2c3::20)
 by CH2PR12MB4088.namprd12.prod.outlook.com (2603:10b6:610:a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Mon, 3 Jun
 2024 21:23:51 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::6b) by SJ0PR13CA0195.outlook.office365.com
 (2603:10b6:a03:2c3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.13 via Frontend
 Transport; Mon, 3 Jun 2024 21:23:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 21:23:50 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Jun 2024
 14:23:41 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 3 Jun 2024 14:23:41 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 3 Jun 2024 14:23:38 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Yoray Zack
	<yorayz@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 08/14] net/mlx5e: SHAMPO, Skipping on duplicate flush of the same SHAMPO SKB
Date: Tue, 4 Jun 2024 00:22:13 +0300
Message-ID: <20240603212219.1037656-9-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|CH2PR12MB4088:EE_
X-MS-Office365-Filtering-Correlation-Id: e3ef1cf4-8704-4cb2-b600-08dc8413769d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZncE8760gdc2cv6NdBHu1b8VEVwZ5J6GoKEwSdAlTdBunCxvyQ86KcIsTXFK?=
 =?us-ascii?Q?GIljojq6URfsG1DEKhlH54I4lQ06hBg8qPw/EsRdnGNqJUcKq9y5cjJP1CR0?=
 =?us-ascii?Q?BmeIVWO9gvTc+MTIALvze6rUOKqbSBKi1weQW4NjYkTOZGA/DW69sdrTwjW8?=
 =?us-ascii?Q?c1wRXhhOALB74L/m8XfUCYHjEZqkUXZRTAlN92hZveQ+TzFjabg2/mfhsD96?=
 =?us-ascii?Q?2l6uNsyBT981WSND5QvQ6vjNhbJ4HEydzYoOKUuCUnnaaNw9Y7FjQ711WDHT?=
 =?us-ascii?Q?+ArrKy/Nvb9HPXbLdCzuv1DpGcKLE42ih/5WUyzMRCdXeMc0RiN+74plXSZh?=
 =?us-ascii?Q?NrC7pIu/kN8TaZd16V2cJhh4jHEyIbSgOzVjFbxXH7GW6josw02WrYe7CYk+?=
 =?us-ascii?Q?ZkwhTrhOHEgzJNi5c+STquD1fyP50ob+EhNV81ROq9YHQRjTHcJhDayt69PE?=
 =?us-ascii?Q?sCj140lLvrhEnO8vRumuFY9QBz1ViUYHShua41pXwjQE+WwtxGTYiigFEj8F?=
 =?us-ascii?Q?Z9lo5baAv1hqfXyLunMyNZnvwi+GI1OyA5qkam19e9GLFc9rS0LcRAl5CIcl?=
 =?us-ascii?Q?Xtqi0Ptro9U8Rna5zQwH+2c/wPIdsJHr9MGpqj/Rn9rwaTwv91VNycwuePaj?=
 =?us-ascii?Q?ecCKFHLakDvvW8uYDo9vGnAf4W59JeCnVbXuaFWuVuh0nZe9QajxyY//Ylyp?=
 =?us-ascii?Q?/MjEPp3Yk9qhvsfVvohcTBqVtXVVQdvBqNT4UFmE1cDcnI5fjSLuXUkjqOS7?=
 =?us-ascii?Q?42WOBMhVhBnVHjC/O8mrbjuD72wStucwZyd2zzzN4koyiMp6pRs2pKRZ/v6Z?=
 =?us-ascii?Q?8e8WMElo9G2kiNjfXMRMmIiS5lSxPdIZY/UsMQrLSicaJcVUUNMH+8FUFIZz?=
 =?us-ascii?Q?GlUl62eplF82HxwfrHKAXDdoQKsYSKiNZ6F4T6qoc0GvjnnCERpLbh8HweEE?=
 =?us-ascii?Q?WMbfZGIkYIEhmKwPZK5gl+RVYxiXzJX2G/IXBF3imCGwhSQ/LC01P6uGodea?=
 =?us-ascii?Q?WE530Gv+sU0gaXX/LN/Qhgdv4TJHrfU3iseSfaacnPpRQlNTBtXTs9lGaBn/?=
 =?us-ascii?Q?THQn9lXwHvtkAI62cUHI6EuPVVBd9m/qTxwJpCymlEbEDt0KJ7+OltX01p7v?=
 =?us-ascii?Q?Cgm4aRZauV3AnaALyWTy4hrXwe7MkAxyVl+JJRt/LbDhoawzM300Tppxo/cZ?=
 =?us-ascii?Q?5mIb9LVr4XpaUycgq1+QTF/6dxfsJWql5YQofsWW03b5Ke+ea8hx7gsAAwbA?=
 =?us-ascii?Q?AD0OuQZgkygG/WjWIJv19Ia4DYkDrwytGZLvFucpMHH1pyqpDkBq5VB0W/oI?=
 =?us-ascii?Q?wGYicBTZHIhaIump1sz2gT/cnP9kVx34bSDvUELEss95HzljmVL1wI0SSibd?=
 =?us-ascii?Q?LKGVdCn/W/WJMHugiBFWK3mA2FLb?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 21:23:50.8747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ef1cf4-8704-4cb2-b600-08dc8413769d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4088

From: Yoray Zack <yorayz@nvidia.com>

SHAMPO SKB can be flushed in mlx5e_shampo_complete_rx_cqe().
If the SKB was flushed, rq->hw_gro_data->skb was also set to NULL.

We can skip on flushing the SKB in mlx5e_shampo_flush_skb
if rq->hw_gro_data->skb == NULL.

Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 1e3a5b2afeae..3f76c33aada0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -2334,7 +2334,7 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
 	}
 
 	mlx5e_shampo_complete_rx_cqe(rq, cqe, cqe_bcnt, *skb);
-	if (flush)
+	if (flush && rq->hw_gro_data->skb)
 		mlx5e_shampo_flush_skb(rq, cqe, match);
 free_hd_entry:
 	if (likely(head_size))
-- 
2.44.0


