Return-Path: <netdev+bounces-167099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26623A38D48
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 21:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CB8B3AD354
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 20:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22339238D2D;
	Mon, 17 Feb 2025 20:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cOaLmJGy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDB4219A8A;
	Mon, 17 Feb 2025 20:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739823930; cv=fail; b=VKDOLPicEZRRLNHVerwkm4EvLvsyRDRuWb4oq9fO+z04o47CHl/JTAFm1PTBFOLblBRL4aH4rbNEjb6KMFDuohYUruH2SbyI09WqE135JjIxNRKxIbw4vapn7+HN4wGutvSxXEXbItGGjDQFWDGHeFHNqBBkCOtDdOwS05TUIzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739823930; c=relaxed/simple;
	bh=B/HK2blB0fe7fuT31wQBugu1pMfJflv1DRZQ3QHmOXg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xy0bHLvKcwDRN0QIppzY4iLmjhq78FSwk2gWGLXyj4kDCddg225VuFcOPfNiC0YiJAFOjCucVvitaTaDzCRR6q97r8sjs0E6rF4B6lVU9AZnAg7+Qt10v/cV/O+D0IWpuO2IcoBvt1tq8tD6wnS0hd5gl8ZnIBSj3/VVXGVyhIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cOaLmJGy; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ai9iDP5ne3CvjOPbTns0Ao2k8zD2kdzhytKqWj1Hov6Q4pei6182/INAvBq7AfjT931UHsbM4jtRP+hAuzuUXpPzqoXppEn2x9D59iWZnG7pn9Wp3CEnUeB6k2A29d1uJTs0fMOUKr98jV7LFB4+qG6eZXYvv9TiOBQwZYQWsSfMqQ1Zn+0BT+AWIUKGpDse/3caTfv40B4GTY4yBz3QL/YKA+DhBMgjK9M+pem3f2+b6nqSSQ+RP1VXIsJ2U/0lKsexRTsE1igXU6kjqKHbsKgTpCMC7zGfOFlkioq5+QwYy9wVgzHj/1pPX2SM0TovVhugCCOivriF6VqrcYvq6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khFJ5ANYoG1KpIp7nE+IWmNiVyAlRmvDG4nj+hgsC/Q=;
 b=C2IhL2Z96bKfoDWnnOvHMNerHNoKFh3jy8mcDJVmR6OWkuejKqW5wnV9A4pLsFNLSnA92z79ATiCqsCD+M+UGm+igQy7V//cCy/BzyWLGj62o4FcA/aD2p2ufeWPbzonFZIbU0HHyWDktJA27Wf+7L22DeN5EOJS0lHSBVRQxTjLs271k9dGogC7bHz2/aenxAYs+5qnotIJK3NRrMTxUKqg0Yf+bmtBIddffZ09dnOwQWx91SzOi6y6UCJsTmQ8PnBfKazvlM8NbIfTr3O5PVVGtmqe2OPk5yzS7GuVdceeMX8NS1qjOvdEckA6bSza5/Uw58p4BzwXFf6m00XuRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khFJ5ANYoG1KpIp7nE+IWmNiVyAlRmvDG4nj+hgsC/Q=;
 b=cOaLmJGyLvChn/0ZS1UdMsEmXOb1zXMOQ+7L+rv2djT5Tdc714fm2N8fkaP3O/c+3D+4qF4Mybjf/KoeE2wc+NZc2qpX4TQT1YevKwa7opVvLEHmbnXBiTlatl0ASltDEyTqcf4cOmI8BxERSsd8wG7IygVhsYLRPfXCRDLdVV8gvaWIxBHOJosiBaXC24+IH7+5x3DGGEmsdcsDypR3gTEoO0qJDF4gVu3oVmMLGwQK1JbYdO3+HSerLOKZhOVw6SNUdKvDe2dXhFjrpvKiDsjspsGES5XREa+TZzhPgUyjosOxD2mLpN8wEPCE+hRhz4jxIeqny1Ue8l/ZA8IB2Q==
Received: from BYAPR06CA0050.namprd06.prod.outlook.com (2603:10b6:a03:14b::27)
 by SJ1PR12MB6337.namprd12.prod.outlook.com (2603:10b6:a03:456::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 17 Feb
 2025 20:25:24 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:14b:cafe::9e) by BYAPR06CA0050.outlook.office365.com
 (2603:10b6:a03:14b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.20 via Frontend Transport; Mon,
 17 Feb 2025 20:25:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Mon, 17 Feb 2025 20:25:24 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Feb
 2025 12:25:14 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 17 Feb 2025 12:25:14 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 17 Feb 2025 12:25:09 -0800
From: Gal Pressman <gal@nvidia.com>
To: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Tariq Toukan <tariqt@nvidia.com>, Louis Peens <louis.peens@corigine.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, "Pravin B
 Shelar" <pshelar@ovn.org>, Yotam Gigi <yotam.gi@gmail.com>, Jamal Hadi Salim
	<jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
	<jiri@resnulli.us>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, <dev@openvswitch.org>,
	<linux-hardening@vger.kernel.org>, Ilya Maximets <i.maximets@ovn.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next v3 1/2] ip_tunnel: Use ip_tunnel_info() helper instead of 'info + 1'
Date: Mon, 17 Feb 2025 22:25:02 +0200
Message-ID: <20250217202503.265318-2-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250217202503.265318-1-gal@nvidia.com>
References: <20250217202503.265318-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|SJ1PR12MB6337:EE_
X-MS-Office365-Filtering-Correlation-Id: 972d1a07-591d-4bd6-1e8f-08dd4f9135dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tp8gTaJWLiRp4501G0VmmHii/sYcZofa0e5iY1WAWA9ebKtjg2sUWX3GWDqt?=
 =?us-ascii?Q?7ygNzIzKNQW7uYgs9+rjS6w/xSJm8OGpG6GDZzDF6D6oPHAUagsFFExq8f2z?=
 =?us-ascii?Q?AtWtT7dIvvxvsWTv1gkvuky6EJs9OqFLx1FES7xz14AKOtZ0SrMEbJflkKJp?=
 =?us-ascii?Q?dfVVWWLPCm5eO5iwx5vugjy0YLMEUxWavhi1Lo3WZq1NN2ah8Sd/Kfvay0w0?=
 =?us-ascii?Q?r3U1RwezWrXwiMfCs1iC9zc8udLNvAbockPpcCy/+jm5EE14yr0NMP8Gi8/X?=
 =?us-ascii?Q?ItGEJO732b+eMWo3uHALEF7FGeJD0ljlV5Y5zXY2YzLK9VKuRTpE8zAYXAbv?=
 =?us-ascii?Q?TtMWnD2IvKXu0D1YOX9rFnqR9kCf4Tv34279vTUb87g9KX+0KR7aVlY74oyK?=
 =?us-ascii?Q?ZYyoQasabeJIeYif1ZBYlG9D+JgakzAYDd2kHLUYyBSTRn20ZkfxhvhO27NY?=
 =?us-ascii?Q?uKIjiSmYq4bZgo1J6ZFrJcOQEUeSP23l/2gN7MlCBcVp+KGaxTiiFyRw1BVV?=
 =?us-ascii?Q?f0ePgy0RdEoSabHhx4ZKtVEanAlIZVew7ZBjICJdN74NaVfMK8VeciP+5+0v?=
 =?us-ascii?Q?QtyW9EY5EqQ73K+aIro43SOU+NbWioWUe1Q1oIlG38J8eBY/FT35iJ3rRGzr?=
 =?us-ascii?Q?GIeuWmFFevK/a+BYAHjTn5eFo3uD+Y+8iuw2YZ+qBOxiWG8AUbM7dI9JAcC9?=
 =?us-ascii?Q?AN6Igrm6eHdRt/cR5NkfAQzxetkTigTpYEicCw/gHysevp4e/rI2zXAKuyiD?=
 =?us-ascii?Q?TpwcrywFJiee2beR7IZnNbKucOGiFxT1yy11RelowZ+pp1ohsYlcdEnye7Gd?=
 =?us-ascii?Q?pEPzUrWhOYdcuNYANx/hyLpNBjnUcd5pSBSb61lwwRTEvoFgXgKAgBAdFs8e?=
 =?us-ascii?Q?bftpP7K7LRmRCr+HvmnFFBgwutIGIEcK4acM9EDrkYDvcxw9x1Fyr4q974Qj?=
 =?us-ascii?Q?+d15OOLnQUX3OLqxmPweRf8g3p33ZkZFh0hhRf8+dqlHWIsZq8Rg+foOs8V5?=
 =?us-ascii?Q?hUAD4OTDEW1QxP1svp589zA2K3ae2UOdEzQPb8s3r6oYpyEA9asd3a8T/XJd?=
 =?us-ascii?Q?n/u3yaoutQ6W1AzQRdbZ/nbMameaCLx/xY2hgJVKg6bB59I2ONZhOKt6lt3E?=
 =?us-ascii?Q?OBq38sJANpjL9Nv7H8GUmUnYcFyvucjx27PKCSpJNA6aQCkTQFNWlH0VKCal?=
 =?us-ascii?Q?1HYxfN3UjgxBkt85S0mNptSRdd4Iz22X8DQUyHLwojmA38t4qIiOigBGPtNO?=
 =?us-ascii?Q?BZjLo9g5TR9uZcF/EvYMqKXGivFJIn9u7ObweGh0dpgUm8wHu5/3uwPLB6nw?=
 =?us-ascii?Q?+lJWlFhv34BnZO1TRw81QvUSs1azTltAM/JAvI1hdou3UN1pEI69GFTyewG/?=
 =?us-ascii?Q?dh3U8kBxH/JXmvIDqw5/l2AsiCgAFc3DjIJiat3Lxo0BAxuwFiyNdDokkDiR?=
 =?us-ascii?Q?exOpJEGo1W+xOsnY2yNuT2vlvb8gaLVonMrr6JszUKDS9vH47CKQDtfu6Gik?=
 =?us-ascii?Q?aIyI1j5L1mkSQtc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 20:25:24.8636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 972d1a07-591d-4bd6-1e8f-08dd4f9135dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6337

Tunnel options should not be accessed directly, use the ip_tunnel_info()
accessor instead.

Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 include/net/ip_tunnels.h   | 2 +-
 net/sched/act_tunnel_key.c | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 1aa31bdb2b31..7b54cea5de27 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -650,7 +650,7 @@ static inline void iptunnel_xmit_stats(struct net_device *dev, int pkt_len)
 static inline void ip_tunnel_info_opts_get(void *to,
 					   const struct ip_tunnel_info *info)
 {
-	memcpy(to, info + 1, info->options_len);
+	memcpy(to, ip_tunnel_info_opts(info), info->options_len);
 }
 
 static inline void ip_tunnel_info_opts_set(struct ip_tunnel_info *info,
diff --git a/net/sched/act_tunnel_key.c b/net/sched/act_tunnel_key.c
index af7c99845948..6d97be6bc7fa 100644
--- a/net/sched/act_tunnel_key.c
+++ b/net/sched/act_tunnel_key.c
@@ -572,7 +572,7 @@ static int tunnel_key_geneve_opts_dump(struct sk_buff *skb,
 				       const struct ip_tunnel_info *info)
 {
 	int len = info->options_len;
-	u8 *src = (u8 *)(info + 1);
+	u8 *src = (u8 *)ip_tunnel_info_opts(info);
 	struct nlattr *start;
 
 	start = nla_nest_start_noflag(skb, TCA_TUNNEL_KEY_ENC_OPTS_GENEVE);
@@ -603,7 +603,8 @@ static int tunnel_key_geneve_opts_dump(struct sk_buff *skb,
 static int tunnel_key_vxlan_opts_dump(struct sk_buff *skb,
 				      const struct ip_tunnel_info *info)
 {
-	struct vxlan_metadata *md = (struct vxlan_metadata *)(info + 1);
+	struct vxlan_metadata *md =
+		(struct vxlan_metadata *)ip_tunnel_info_opts(info);
 	struct nlattr *start;
 
 	start = nla_nest_start_noflag(skb, TCA_TUNNEL_KEY_ENC_OPTS_VXLAN);
@@ -622,7 +623,8 @@ static int tunnel_key_vxlan_opts_dump(struct sk_buff *skb,
 static int tunnel_key_erspan_opts_dump(struct sk_buff *skb,
 				       const struct ip_tunnel_info *info)
 {
-	struct erspan_metadata *md = (struct erspan_metadata *)(info + 1);
+	struct erspan_metadata *md =
+		(struct erspan_metadata *)ip_tunnel_info_opts(info);
 	struct nlattr *start;
 
 	start = nla_nest_start_noflag(skb, TCA_TUNNEL_KEY_ENC_OPTS_ERSPAN);
-- 
2.40.1


