Return-Path: <netdev+bounces-86247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB7889E311
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 21:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE01E1C2124B
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 19:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3C6157E63;
	Tue,  9 Apr 2024 19:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L+ePXoe0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F212157A62
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 19:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712689768; cv=fail; b=kQ3ar4xSRpwubSzFG5KyZQR8YLxFMWSK6mVhKYb8+qMObvwk/G5Sj3+EnTu+UgbutgMIsJDkpEA2OzGSJQaPOaH5IOFL1HPv2tolPCwoCOoIgBohT6neX8yr+JQ9VfchYmSiP2liqX8M6dCf3uFCfoTSWZCD+IulWnSZuV1z6x0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712689768; c=relaxed/simple;
	bh=5eXzUkLVPGtqzNaU0aEC2pJXtIIj6cbIuN8bSoNthGM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t4Kag8lgvu2HCd3sxfzKsjTDA0ki0W8Rg5FD7wXDGT0bl+qaHUjCJLyLOGxx48DgdznVY181bS98gwJ9tx0rxq8EvA18ageGu/ghWnpax9DZ4Fsxp1Qlb98FKh9qHRLzazvGn/v+5eLys5eIDkEa54fUi3LaNEfdHEOHY7TDjPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L+ePXoe0; arc=fail smtp.client-ip=40.107.94.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFjYe4aaFW/4uxAxQX6iXUH2G16wTpGxk+vqWQjcOjBQ+uCg7yVtrwfCTVRK0WH+KeQwlnW2XxBt72zZkevXJQxYbTjNhOkOsNE2dG7dHNGI05Pyqj2hlSId0LW9Vgyb0NdGANcjEgGMeM2HTAp8xuUILLFq1ZsDbuZtqprWRUcfF1hJTXtDvWJER6IGnH9y4v98vhRwsqv5TF6TksqLOAXTdDlsMM9MXxAzCzhB+vZwbCvqLc4/sXIHqT/rmjqtEE7vgNX2CJSWCAfijX8uQP7En6sAt7DdcxK/AxxHLNstA2bfrM5gxdCp/F7k3RXsrYhkO0J+nFxruU2tc0OtSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhLDx/vNc/T0y34K1oGVp1WEXu2dUl3+cYFnIMP/EMU=;
 b=cHOBgARkdb770NsoNkW3FC4CB30O3YCfzlF3WDjs/MWYxnifDOPVcUFx3d8O0TgWSZ8MLPlT+qssy+mp+DIURTYKlCb2yngrf5inD7Hd918qEOhKNWb+n7UlK+2lyceVz3Qlz5ffCvNfEVXL08MoZE2lb3PXeCJaoxjteULyJT8KjjYJUf+H1aegeYlX5v50xvGrFk42MUCUn5Vq1r86myex1BXzA5ktF/U+xwSphAuaShNqvNFs4Y4H/KjA4QT9J0E6iLGzrnwl8tEd36P8rERQ2hoK8qoYEya+w/cXZDAn/r12ezmBeTQtbYEAN4h0y2+6WwrqPleOEP+ALcV7uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhLDx/vNc/T0y34K1oGVp1WEXu2dUl3+cYFnIMP/EMU=;
 b=L+ePXoe0MpTCz/XrQgLp62XDAOX+gQsqW9U0JT5r7GIAAq4bFgoWpPCpln6c78fKhzedNTQoDRN1U/2pD6CiwNBjHEfqOxCLE4v3X6jU9S4VFlKz0PDwhTFH8ywwRtcUxtGA+ociCp1P8KBdgqz1HrHhoXppDhZf8cLkXZ61l50UrIxtJIh2HidPWNpUy0AC0u4euKsVyn6hJJR4CWPtBmYBlZIwb1Ms7yPeCE/WnKPqW1ussLOKMRPEYyFvF6roD+BK4sb0pk8N9LQ+fH5IxpQ6oeSI2NYAjYc9dE/LzI7P9KZ9CzHDMqurb4gx9ojknpE/YZEILQDCkQSzpir4cw==
Received: from CH2PR15CA0018.namprd15.prod.outlook.com (2603:10b6:610:51::28)
 by CH3PR12MB7521.namprd12.prod.outlook.com (2603:10b6:610:143::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 19:09:21 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:610:51:cafe::16) by CH2PR15CA0018.outlook.office365.com
 (2603:10b6:610:51::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.36 via Frontend
 Transport; Tue, 9 Apr 2024 19:09:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7495.0 via Frontend Transport; Tue, 9 Apr 2024 19:09:20 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Apr 2024
 12:08:59 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 9 Apr
 2024 12:08:58 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Tue, 9 Apr
 2024 12:08:55 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net V2 05/12] net/mlx5: Correctly compare pkt reformat ids
Date: Tue, 9 Apr 2024 22:08:13 +0300
Message-ID: <20240409190820.227554-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409190820.227554-1-tariqt@nvidia.com>
References: <20240409190820.227554-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|CH3PR12MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: 42461686-8052-4ff2-9d39-08dc58c88fb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	V5T9MaBWhRmej4Qfyh+MzjZgLxyqUhKZinZkuuyqUH51fRVyKvlgvuqSXRqtBtTqjeIh1cy+I7tpQ4suTsVhSOnWDYIXhzsYmZnG+V7FdxSf9mO9Rdnm/dkyiv0C3sWQI5gLwdKbA+tGgmgFf0LhdwW1KHbGERDNY9s2XwYRxqU2I6+iQhcaSOtmA0OQOiiJURZJF1OinzUTHwQfTQjy178gXGRuemvDf8XIr64w5iFd2xodWGSlK9iKo22xLE23EDCRfLzXwCHW2UN4N83HXJ2TAJiBvHSBm/MJTA9/+H2puyEXRAVgadge+7rwFM/xlB28NEpV6Xzo+eleRNf+gK7DAWAs05jw/aMyiUiOzb51GaqT4yeetR52HY79DE/YGL7wU0uXUBuKUPZFLsiVOfv0tkqXCJZyNTPgbZkPHtlNMiWnV7ndSmy6dyPl54yAXTSqojpzPmi2tL0u+ir/NDd5caRHN++Z1jlWdaTVnAoj22AkvzP6Kzd7WL2YFdjMDd+4qIp6WhZvWCu4qpxPITOFwsGu99E8RaRqUQkLtMPsP1ATirNujuuVxl1o3jeAovWaVpEaLziD7hKXHc+NvkmPhzKGAh4CkyODCeGX+1nXzT4N/LIre5W5aTqe9sdTT1ux22Q4rh3hkFxUGmeB+bk7rYx4D1aJxdJdvoiEYhY7PPbQWSxaXFW6E8Dx55q5lbyOeoGvLgdWPF0lzx+494t8SEXrUmUr8MDvnDjitAcjtWsLiSlIXDBbaUpZL3La
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 19:09:20.5821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42461686-8052-4ff2-9d39-08dc58c88fb3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7521

From: Cosmin Ratiu <cratiu@nvidia.com>

struct mlx5_pkt_reformat contains a naked union of a u32 id and a
dr_action pointer which is used when the action is SW-managed (when
pkt_reformat.owner is set to MLX5_FLOW_RESOURCE_OWNER_SW). Using id
directly in that case is incorrect, as it maps to the least significant
32 bits of the 64-bit pointer in mlx5_fs_dr_action and not to the pkt
reformat id allocated in firmware.

For the purpose of comparing whether two rules are identical,
interpreting the least significant 32 bits of the mlx5_fs_dr_action
pointer as an id mostly works... until it breaks horribly and produces
the outcome described in [1].

This patch fixes mlx5_flow_dests_cmp to correctly compare ids using
mlx5_fs_dr_action_get_pkt_reformat_id for the SW-managed rules.

Link: https://lore.kernel.org/netdev/ea5264d6-6b55-4449-a602-214c6f509c1e@163.com/T/#u [1]

Fixes: 6a48faeeca10 ("net/mlx5: Add direct rule fs_cmd implementation")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 2a9421342a50..cf085a478e3e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -1664,6 +1664,16 @@ static int create_auto_flow_group(struct mlx5_flow_table *ft,
 	return err;
 }
 
+static bool mlx5_pkt_reformat_cmp(struct mlx5_pkt_reformat *p1,
+				  struct mlx5_pkt_reformat *p2)
+{
+	return p1->owner == p2->owner &&
+		(p1->owner == MLX5_FLOW_RESOURCE_OWNER_FW ?
+		 p1->id == p2->id :
+		 mlx5_fs_dr_action_get_pkt_reformat_id(p1) ==
+		 mlx5_fs_dr_action_get_pkt_reformat_id(p2));
+}
+
 static bool mlx5_flow_dests_cmp(struct mlx5_flow_destination *d1,
 				struct mlx5_flow_destination *d2)
 {
@@ -1675,8 +1685,8 @@ static bool mlx5_flow_dests_cmp(struct mlx5_flow_destination *d1,
 		     ((d1->vport.flags & MLX5_FLOW_DEST_VPORT_VHCA_ID) ?
 		      (d1->vport.vhca_id == d2->vport.vhca_id) : true) &&
 		     ((d1->vport.flags & MLX5_FLOW_DEST_VPORT_REFORMAT_ID) ?
-		      (d1->vport.pkt_reformat->id ==
-		       d2->vport.pkt_reformat->id) : true)) ||
+		      mlx5_pkt_reformat_cmp(d1->vport.pkt_reformat,
+					    d2->vport.pkt_reformat) : true)) ||
 		    (d1->type == MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE &&
 		     d1->ft == d2->ft) ||
 		    (d1->type == MLX5_FLOW_DESTINATION_TYPE_TIR &&
-- 
2.44.0


