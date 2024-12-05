Return-Path: <netdev+bounces-149439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F28439E5A1B
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 16:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5416718878D9
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 15:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC78221465;
	Thu,  5 Dec 2024 15:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YaoO7nko"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0DC22145F
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 15:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733413434; cv=fail; b=fzgM0YS+LfWgnp8U28N9JXn4kzN7mkKy9rqjYyBjRGz0SwjGkbvY/Rq4Sr3uCq8N7bRQZGSAIb600D4mom81SnixU15+WBBkkbwYtYAw/FVqMF+fxPBL2E7+XljUMNDH1iseLMmbGdWMGsEmCw1AcVvmH9ZpnrQxTAWgXVv7BoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733413434; c=relaxed/simple;
	bh=PLEiiCE+bz4j72NlZOJc9Gu2rnJa8CZq/6UHEUHmJ5M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CdqGPWEFf5UZm0vdDP6B0QvSl+K8yHrnheVxe4nzyBniW/bCQYHm8bFVf2ZJIGobgebShY/1xYTVQG3Jk0eKTzBa50D41jrup2vjnMiIgF/TYKo72MIWnVyQbLF3n8RhK1h+xQ/uphV1yUwJDEgcSgPLNZiszpoF2bz3J7VOfr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YaoO7nko; arc=fail smtp.client-ip=40.107.100.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rI+mzoIswI3uN7HmsZRPKEVNuIE3w4QL4d8ZhLNUooxol/dK/RqpRI+P5Hruwg+ImTjWLMgn6Epc5t7bK/MLuGzsd9XaMc12Ah66WeHGuH9sA6qr6GQrRFtsXIHPEsxa8fHLOgO3CNt2D48XDelQjaRTyIFSi9eNxU7A01LpKf3s2u6oR2E8nUD4LW3LXW7Ob3vxYLccVDTDUNRC43VTZp3Xo7nUBhv4MtbRJYZ46o8tXBprSyqwm0opoxCzn0OxCqRCKZQ9mmTvnWr+VZAjjm1c3HGwbv3VRT/Kb6r82fal5j6Mrtu5AjOAjaZoICTnhc5YspPHS6QZe9/aJ5Hrrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7uI8ayAsjgSoxg5qjXbGiIQj1i/+fyIShFwYiV88a0=;
 b=Sc2OwIU0SqIoANRArhKK+tLLMQnfsHGPtS/E563hZq+0Eku2qB+GC7k2G5l4SjqB6zMF+aZUE7UVm2e4aJcExqocVLGv0IIZiFZFp1Y/ZKZMkQx8S1VcvsEKx+R+hxp9F/g1Y7VgY3c0/osqNluN6EDn9C3ZK6u92iBkJoeblWp9x6IMejjFSm9aTWS3eTSh34/h12r24jYiUEbP3WsbGIfuKpg08lPhJKrgCby2Fc6LKVHQMYHQkfjEvqHhBIf77/BImh8B2xnMOiVX98+iBSqUtOOCP9Y84XgI5X4EmfeyX4PBzzuU4cWAa/ysjXPe4HjAKfD9qb2MWhMgJ/GiSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7uI8ayAsjgSoxg5qjXbGiIQj1i/+fyIShFwYiV88a0=;
 b=YaoO7nkoFy2kRcou+TB/lQfnea+WgYmVp/oCgW+4XWaSNd5g6vSOT/7Jov94LdhCH1JMpT+yQ/zv5rdIGy3kuhT4vxYIXjihg+ZMI5BCtiAOAWWU+ZDqtUH2Ykeg69CAVt6UfprX1Z2XbQoLfzre5TLLusdyM96gTuJTuxarYxfwVitkBySMf/JVMec3Oh/BLBIjtlMSKVDa5Ckm7w4W/LRbEPolnLaVBSdpSBJb9UlLUlMtF/aCzXejxDDtqZMJpqDHhGZ4hTiVqkg6Eu5jmP42laZzbZ8M8K43KpIJHvlxRaRaX1P3HK7r4yQwaUhfdbCX8rVH/PbFO1lWQJvF7g==
Received: from DM6PR02CA0115.namprd02.prod.outlook.com (2603:10b6:5:1b4::17)
 by IA1PR12MB9500.namprd12.prod.outlook.com (2603:10b6:208:596::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 5 Dec
 2024 15:43:47 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:1b4:cafe::a0) by DM6PR02CA0115.outlook.office365.com
 (2603:10b6:5:1b4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.22 via Frontend Transport; Thu,
 5 Dec 2024 15:43:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 15:43:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Dec 2024
 07:43:33 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Dec 2024
 07:43:27 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>, Menglong Dong
	<menglong8.dong@gmail.com>, Guillaume Nault <gnault@redhat.com>, "Alexander
 Lobakin" <aleksander.lobakin@intel.com>, Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v2 02/11] vxlan: vxlan_rcv() callees: Move clearing of unparsed flags out
Date: Thu, 5 Dec 2024 16:40:51 +0100
Message-ID: <2857871d929375c881b9defe378473c8200ead9b.1733412063.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1733412063.git.petrm@nvidia.com>
References: <cover.1733412063.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|IA1PR12MB9500:EE_
X-MS-Office365-Filtering-Correlation-Id: bd09eac8-f1f2-40f2-94f0-08dd15439b38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G039eePqndu9ddlXHYOAdQBA2WQrXRMwR4e2YGm6W6sUWKIyLi/7XX2aXMoZ?=
 =?us-ascii?Q?lSww8MJz1GCNe2GIGQeRCtAlpg1xlEq62p7Gh18Dttpg/s4ey9+TRlu/wbjP?=
 =?us-ascii?Q?W8PfY9phInCFQvvAsy/oDwrWkvsucju2q4pXY0ky1CIox9+k3vgLmBzK3WLo?=
 =?us-ascii?Q?Ik4SUBuf5R2yAcEJ+cK3lasgnTFKwtWOWAbCRUMFFCrBtJ37zZZPP/WeoWnU?=
 =?us-ascii?Q?0S/s4IK9MwVTMRwZ/XzNkYE3zh5AMZ9xi+1+CDSAD5LQccfsdctnROBqlS89?=
 =?us-ascii?Q?0f5enOPZh8CVvXitarDFyhkOj6klJJwQsCjrJBKN83jSRrCFfrhn7vPjmpqT?=
 =?us-ascii?Q?9u1rJ4fEDkuEinkJaizQrBgY8i97cB7xzKaZUGNpIlk2oJYjIQtvb2h3aTIC?=
 =?us-ascii?Q?0gUulEw1CMHfB1bMSO05MX5bIxAXUTolsmLFJUauP+gP7HxkpwGpOxURkfKt?=
 =?us-ascii?Q?lwv+xYlyVLkVZ2mtY4M3lB+XSSbhjE+GW4RAXIG7UdE30yy5HRBQH40v75p+?=
 =?us-ascii?Q?9H+FnvkDt/IzkcwRhN9OBpAqvjIQuE9GJPcQj0JcwX+k27kIpI4r9tCk5vQA?=
 =?us-ascii?Q?GqRfgSeCwrBpGKK7hQeclnZiFqAEMCMgKxFQp9FI4YKBRxDUgQEes7P//WSf?=
 =?us-ascii?Q?3gYXYtVmONy8mQ6KM9WjhnDCpmBX0R0uMVrj42LYN4GrFP7Xv7AQtsIqO3GH?=
 =?us-ascii?Q?FMl3cbSRufwuRsOwPcejtVLECR1o6WWMvBjycLxG2XV2Z9sJDkXLag/TErIS?=
 =?us-ascii?Q?lO8IxXk3niJuAgVHLmma1+lpyE5uUFhP4G7g8iRP3H/uXlUrqFT9D7ueGh04?=
 =?us-ascii?Q?gCmH4DnBDGXg12abWcHqboLf58YaNS8gOBJO/nPfQNW53DlX3zfkgAlCfM07?=
 =?us-ascii?Q?zzq0C0txoJATQCmMyS2v0TeW+qPrvQssvyUOzKQep6rK7+ZN8WoU0Zy2um+P?=
 =?us-ascii?Q?wZ8oMCVEvKMzc27UEgq9dvM0gE9259O86kU/Q0CJhKP++yt7F9F4bzADMd8h?=
 =?us-ascii?Q?2DKxLCYp6XFk006Pm4qbHiMtxCyzZYevFLQQaxwTR8YKTuOOpNTLqLKwy5pH?=
 =?us-ascii?Q?7u5RsABJLTosR03i/Hg5f4zeIb/4VQnxaWPtrpBgfsxO0x9SoFSfWaWjnNMk?=
 =?us-ascii?Q?C+NQLJNbEsntSP0LvMm5Bv9b/FAX8TRUDSvr6uYLz7E9nyQTDC0ustgc+ui3?=
 =?us-ascii?Q?ElqStSmh5o942zyepg0rrlcsYD+F/yZ4I+RGwBITOresb8avLRuaEjF59kU8?=
 =?us-ascii?Q?tlaPh8YdparTIFtD5CfEYg9gKHaNv2uyJp2XC2ODA8zczH/Oek8DN7KzoPSv?=
 =?us-ascii?Q?eQ+P+E78uILFjEG8b2GcWI86Yy52pYmSSLrSVbORkZNifpz30ZgLTRIpNR4x?=
 =?us-ascii?Q?hBHCU6I5FWt70wvKO+yOf3tDh0MBw9hZtq7dlE9Fr364h4pG7wsjqjRkyj4c?=
 =?us-ascii?Q?eTHkVnePJuVvYa9xQAjYcpu4vGYgUgaL?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 15:43:46.6240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd09eac8-f1f2-40f2-94f0-08dd15439b38
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9500

In order to migrate away from the use of unparsed to detect invalid flags,
move all the code that actually clears the flags from callees directly to
vxlan_rcv().

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
CC: Menglong Dong <menglong8.dong@gmail.com>
CC: Guillaume Nault <gnault@redhat.com>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Breno Leitao <leitao@debian.org>

 drivers/net/vxlan/vxlan_core.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index d07d86ac1f03..ff653b95a6d5 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1562,7 +1562,7 @@ static enum skb_drop_reason vxlan_remcsum(struct vxlanhdr *unparsed,
 	size_t start, offset;
 
 	if (!(unparsed->vx_flags & VXLAN_HF_RCO) || skb->remcsum_offload)
-		goto out;
+		return SKB_NOT_DROPPED_YET;
 
 	start = vxlan_rco_start(unparsed->vx_vni);
 	offset = start + vxlan_rco_offset(unparsed->vx_vni);
@@ -1573,10 +1573,6 @@ static enum skb_drop_reason vxlan_remcsum(struct vxlanhdr *unparsed,
 
 	skb_remcsum_process(skb, (void *)(vxlan_hdr(skb) + 1), start, offset,
 			    !!(vxflags & VXLAN_F_REMCSUM_NOPARTIAL));
-out:
-	unparsed->vx_flags &= ~VXLAN_HF_RCO;
-	unparsed->vx_vni &= VXLAN_VNI_MASK;
-
 	return SKB_NOT_DROPPED_YET;
 }
 
@@ -1588,7 +1584,7 @@ static void vxlan_parse_gbp_hdr(struct vxlanhdr *unparsed,
 	struct metadata_dst *tun_dst;
 
 	if (!(unparsed->vx_flags & VXLAN_HF_GBP))
-		goto out;
+		return;
 
 	md->gbp = ntohs(gbp->policy_id);
 
@@ -1607,8 +1603,6 @@ static void vxlan_parse_gbp_hdr(struct vxlanhdr *unparsed,
 	/* In flow-based mode, GBP is carried in dst_metadata */
 	if (!(vxflags & VXLAN_F_COLLECT_METADATA))
 		skb->mark = md->gbp;
-out:
-	unparsed->vx_flags &= ~VXLAN_GBP_USED_BITS;
 }
 
 static enum skb_drop_reason vxlan_set_mac(struct vxlan_dev *vxlan,
@@ -1734,6 +1728,8 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		reason = vxlan_remcsum(&unparsed, skb, vxlan->cfg.flags);
 		if (unlikely(reason))
 			goto drop;
+		unparsed.vx_flags &= ~VXLAN_HF_RCO;
+		unparsed.vx_vni &= VXLAN_VNI_MASK;
 	}
 
 	if (vxlan_collect_metadata(vs)) {
@@ -1756,8 +1752,10 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		memset(md, 0, sizeof(*md));
 	}
 
-	if (vxlan->cfg.flags & VXLAN_F_GBP)
+	if (vxlan->cfg.flags & VXLAN_F_GBP) {
 		vxlan_parse_gbp_hdr(&unparsed, skb, vxlan->cfg.flags, md);
+		unparsed.vx_flags &= ~VXLAN_GBP_USED_BITS;
+	}
 	/* Note that GBP and GPE can never be active together. This is
 	 * ensured in vxlan_dev_configure.
 	 */
-- 
2.47.0


