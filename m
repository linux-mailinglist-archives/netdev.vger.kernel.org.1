Return-Path: <netdev+bounces-98627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC88F8D1ECD
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 16:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65F891F2359D
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F6016F910;
	Tue, 28 May 2024 14:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q3WfD4NV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AD716D9AF
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906581; cv=fail; b=G+MIQ7uHVmGgQetbChNvjI2HfcZCwIAEDM53yXYS1AJDxTrVZBYumoqYFeZSUyKNv//eENB0M32b5oT23rQbu3MaL/eMvo4L3XrjuCndeldXQOFzKm20NZ5StB7H+rYI+iRvC0/Z0aVL6ZQv2yNuBhoIffIDC7VMU1ucJ7SiegA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906581; c=relaxed/simple;
	bh=uu/yk4WtbSG4IwMQPdz16Ei0a7Zvgx7eWo2VwzEeu7k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uekDwFSCDPClZpigQIE99K2tOU6zT13zhN4An38Xci8O6QY2WuIdHf1N0GFSAfhdVGrT67LbvSWxFQbXT60mVlOvVbwSV105n2VqrhirdArA3fpoBKKgnIy8ChAw6C4cLWn+oDjv+WXvw4M3PqX9ZDAmflgLxIlAkcm7xiUZ9kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q3WfD4NV; arc=fail smtp.client-ip=40.107.243.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVQdUWgK0tYNTVnYRZGXrxs43s/cLBlgxrsw/w7iSEVRsbaHS/omm+hEbhfWahTSq3Gv5z1f07bxOSZqEWsfKlkDKSlyOfBWJUVWDMQQce9p66qD4z5SEdV3P5nJ4vsSRsy7hrWErHzT/Fg1WNdSKUDa0vXzmSQhue1RCnjTvhz+LFHm6ovbelutWxE+4qbhUwsV8G2KjDUSv+g69x+/iOypVABHiKlQTPP6YlPnvONxDojo+ZXqXfCROdnJnTydF2md/LQmSRxae4chCZGHqQPc6Xe8UK9hx3BiUoEX5cUEJsSGyhPvLHiEwjiVAUPBpD+BI7kPuwc1hvOwf0DgFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EONykFh9Re/dti8AKEgY6Ixv/AVZdXBdUY3nCjPO36o=;
 b=hGHL+ooEFT4diw2IzcKWB2Nqkf6eUjjrpENO5z84MER/zzKIYPJMoIwbSbH8WkLizSV6jxR7VVn7Pw4UDMZXFrluAPSFQ8MojuEqtfIiSvW/Lxcq8ZgUts5kLFrl2Hpw9IA36+lWfljtlAWs6+R2kf5Q5iJYAAanp5qqBbyAV4s7VrMKOF9FX5OfunGr1lgc6eAwaYoFwhVzOwwg1o1Eu87RI5UPHhE+k5LF7c5qePxct3gZp6/A1jjMjvky+p19ZMhjVemVVlAjNgTV1YA3mSQLNSm4Quy6hen7gSAj6CdO7hsyu9BaZjs/fDkeO05jty0z99zoLb+y9tSy7VrFKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EONykFh9Re/dti8AKEgY6Ixv/AVZdXBdUY3nCjPO36o=;
 b=Q3WfD4NVO2XZTj6ki45HbMV4ev9L06P/6Rkns7mBnw+PNsZiUmnqtmcbiVnh/XAc4cJid76Q0aJ2xASfnxw1Rm6TPptXSgjcHMSnDNVWfEV69kk8hP6y7CxoJevk+qq+Vs42Vjgn0TskPdhvBFgW7xlx3vcbrRb2gOASrWaLOxLGF/2RfMTaZA+QXYOhXqdElVMhUqkA0F9WLWyhTGxtB4U07EPG55V2fFiWCj6rsBGHZ64FQQ3ZYaOD8NoK+NnlL19DxqxuYmq7eVENSY2NNE780UrFfiu5kFE+XHwAt1hzNavYdcVTvXfcX3cuwVAwmMaICwJBxtt4Kh/sO6Q/pQ==
Received: from BN9PR03CA0455.namprd03.prod.outlook.com (2603:10b6:408:139::10)
 by DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 14:29:35 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:139:cafe::d8) by BN9PR03CA0455.outlook.office365.com
 (2603:10b6:408:139::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.18 via Frontend
 Transport; Tue, 28 May 2024 14:29:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 14:29:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 07:29:13 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 07:29:12 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 28 May
 2024 07:29:10 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 05/15] net/mlx5e: SHAMPO, Disable gso_size for non GRO packets
Date: Tue, 28 May 2024 17:27:57 +0300
Message-ID: <20240528142807.903965-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240528142807.903965-1-tariqt@nvidia.com>
References: <20240528142807.903965-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|DM6PR12MB4041:EE_
X-MS-Office365-Filtering-Correlation-Id: 3151217d-711d-4303-03be-08dc7f2298f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e2+3PbNdX3CKFFHKEl3LXVs/f0C3ignM41jxkK/HlBp50naMVATUbxWPUgxP?=
 =?us-ascii?Q?L5q/HZnAUUUxFb9WDgZzd+bqEuq2Cgb77o/n9BOqFYQ6SyRSqHiyTZo1nLWj?=
 =?us-ascii?Q?dAkb4UQ7cy0AdPxBQFWOJrkv48SacsNRav2mAj7tg1U9W1y6iICROPevLL4r?=
 =?us-ascii?Q?n2OwX9WVn5e4Gsk/4AFmZKQ6vfuT42EICP2dculdtH/J0+YuLtQBXB9KN0Gr?=
 =?us-ascii?Q?l385wPr0A/6dzeW5Vb1RnmEQtsYpxAAihEoKHCCPsTp7DURr9vA01X2A4buH?=
 =?us-ascii?Q?5YAKbTtRUPoRVeWskKcf245MtSNl02RAbb9ADbPzESythKuyf9uN+IPuGCpv?=
 =?us-ascii?Q?nPZJIOVxzASV98GB8ypJoMz3Owb59izFxVAko3JGdwfmf3LBOMdXlksrbo+s?=
 =?us-ascii?Q?ABNL3+YhISdUVQUpxVYf32FtVxjiRI7zNlnCcU+/XW+O2A0e0PoNvYE+n35M?=
 =?us-ascii?Q?ttTGMcr0KMfQ2y8RNbdCY0MEmGprThk5SiBhP25vJY/TFZh9SE9Esy6vNKyM?=
 =?us-ascii?Q?Pi3msPikReCGgUoSCByo8Fx6oWGu4BXMXmD4vwlywtp2vxeoiTjw78YT28/e?=
 =?us-ascii?Q?qzyrbHhTBEmR/R0wED10b8acI5p+BsTgsmZPu/RHUG32KR7JpwpWxb/z/V8/?=
 =?us-ascii?Q?fzIvvKlMnthEPLQvGptp0rGort+msDoS/3ihO/4ustY2Nwib3OfV/Gyw0RKb?=
 =?us-ascii?Q?Fro5/cD23natByeneM7Upopv199bWKVWnuABTE4RIzKl6pFjksiaovDwUkpR?=
 =?us-ascii?Q?2X2jxJyeW/pJlFabKtH0BFw8jGrS/cVBk148ZO5kyZ0AI0zylt6Tzi9fH69W?=
 =?us-ascii?Q?DIPf83hm2tbSXt+WSOIFbyalqLiv5+nYj+fJqsv32fTvu+AbeFq329biit1g?=
 =?us-ascii?Q?vpYvzvtuNOpkSEe64GLe8MBm/H1D5TukXc9OnTLCZ+pQ297/hRPJTiveWuTI?=
 =?us-ascii?Q?O4R0sbvK8GKQRjt0Iba5dCjb7kyqT9iw8BeD6BEiVOVl2JyQsJ/x62nhvwr+?=
 =?us-ascii?Q?2FZP+jNiW5XC3tB6dkiZvtHDD6qETTYWcSGae60lRkBwrpsGVgX21aN7MP0i?=
 =?us-ascii?Q?BGEZoLV3hvttwfwD23EiWAT4wglNAwAMN/Tlh7uZGc1bR8pi1h4Ga6YuArnX?=
 =?us-ascii?Q?Mvy9i2evCO5t3qQfZ8nlTGd22sWBc1wt8Af27LpNfTvCtibr4M0ZZMFQ/1hB?=
 =?us-ascii?Q?ERQ94uOllrVhADCw+LWEbm2v/PxRLkA/r+2JIWazAw/X40cTU2Z2QT0Vd6Bh?=
 =?us-ascii?Q?zywphMqiJOnQdLDWhoYld/05PSuUNgnYH1UuJnFtpTI/ynFYRQWB0+l/xHKB?=
 =?us-ascii?Q?+Y0wXoxt/BcDGP+WV+VdpfgwjSpBaCGE9qeQ0ZGHOC0CEJ/HiXTPBqiA36EH?=
 =?us-ascii?Q?B7jvUmc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 14:29:34.9677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3151217d-711d-4303-03be-08dc7f2298f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041

From: Dragos Tatulea <dtatulea@nvidia.com>

When HW GRO is enabled, forwarding of packets is broken due to gso_size
being set incorrectly on non GRO packets.

Non GRO packets have a skb GRO count of 1. mlx5 always sets gso_size on
the skb, even for non GRO packets. It leans on the fact that gso_size is
normally reset in napi_gro_complete(). But this happens only for packets
from GRO'able protocols (TCP/UDP) that have a gro_receive() handler.

The problematic scenarios are:

1) Non GRO protocol packets are received, validate_xmit_skb() will drop
   them (see EPROTONOSUPPORT in skb_mac_gso_segment()). The fix for
   this case would be to not set gso_size at all for SHAMPO packets with
   header size 0.

2) Packets from a GRO'ed protocol (TCP) are received but immediately
   flushed because they are not GRO'able (TCP SYN for example).
   mlx5e_shampo_update_hdr(), which updates the remaining GRO state on
   the skb, is not called because skb GRO count is 1. The fix here would
   be to always call mlx5e_shampo_update_hdr(), regardless of skb GRO
   count. But this call is expensive

The unified fix for both cases is to reset gso_size before calling
napi_gro_receive(). It is a change that is more effective (no call to
mlx5e_shampo_update_hdr() necessary) and simple (smallest code
footprint).

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index b3ef0dd23729..a13fa760f948 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -2267,6 +2267,8 @@ mlx5e_shampo_flush_skb(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe, bool match)
 		mlx5e_shampo_align_fragment(skb, rq->mpwqe.log_stride_sz);
 	if (NAPI_GRO_CB(skb)->count > 1)
 		mlx5e_shampo_update_hdr(rq, cqe, match);
+	else
+		skb_shinfo(skb)->gso_size = 0;
 	napi_gro_receive(rq->cq.napi, skb);
 	rq->hw_gro_data->skb = NULL;
 }
-- 
2.31.1


