Return-Path: <netdev+bounces-145920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA3C9D151A
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D92CB2E4F2
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC20E1BF7E0;
	Mon, 18 Nov 2024 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V0k8MckE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE2F1BC066
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 16:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945730; cv=fail; b=cBxnH7XFuLt4j5CZb8BF9SpBX9p6vGy0n0rT5UiA6QB/d1CMOQK2sEdcPQtA+tijEmKuFXUHga3YBrcFnIT4J0nHOd0q+7rcjreHplj8TwPBvpylkiz5o44gI66vX8Hh0S8dHMWG4gpiq/ZcUs3ZUzcDqLkOcFW+V0U2cMMM/wA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945730; c=relaxed/simple;
	bh=2hnXyh3K1cmsarmkOXR9hUbg8TjY/2S+QETD6EZymkE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ph9SCFOJjCFuARNKwXTPHnt+1CrUduhcAilkUQ23/m8hAnZDqwLUltMcQWLYiRHBwpuW12LJQHhDOur9JM42EqIrnNUgwutNL1ESUwZN42zphXAK7lTLutoou8CFkILkoNjjOp/8MmDxu0bW0Jgr23IUIfCQTLQmLCyLuDxCW/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V0k8MckE; arc=fail smtp.client-ip=40.107.244.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWhA18z9bIPJ0FGJBZEaa83hTjOZiKwNJW7GRh7UwFIcPOcCSsgvdH7Rm2gW6SBDsSV2c12uBKXpELr2XpFhr/LU3s7lY4iO5FhouDN7PluD7VIIzLWHZdjntO8jvMmDOGDTTOsPC5BMfnbuGr7qndWVBYQ9/ahk9EW3qBfiuUVfYSrRV4jNmCJlbEFsgiSz31ErjlxsLB/4NKCWUE9GLUuZ6GEOdOHB1wg9aoQQiuD2ixvI7f/uEeIcD10plwjFy8BM8r00p6OSr56FtrEnX1ToqhGm7uNHVrgqKuQtuNqsCXozjWqRE2Z1EMTjw2+mvp//U3LlN8bLB47iRXK4cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajpJazY/JHq7XMCujwZjg9t0iRJ5gk94BgNuGapVCC8=;
 b=yCqVfQQRGZfKKtFwVMr+QA38faGCn8ZNHFms3pr/OsgHKK3XxTZUaQmdO02ND3tLr5N+JzISnLzBP3pErzVLT6SXdMpz4K1pQlbKyQHrrBFdCY4plZoTt1vu9vTM4obXtSSQ7gm519mkn10Ju6RfuZDMc5GiLDwbvDn/Y6gT4DBu7aMaurtcyZ6K0nXYJYEhqO2goXOelccAp77kXt498BCboCW0G04Kxud5jBBRxZ9Z/eA0AVqxD2lwgWy8n/38mO0O+1+JQ4FTYnQfMTKn9WUe5GoCZqM3AxDfdX5g1iy0C+ILarAjJcH1hJ2BoePXa0oSkK82m8thLwoJr5/WNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajpJazY/JHq7XMCujwZjg9t0iRJ5gk94BgNuGapVCC8=;
 b=V0k8MckErBv9nZSbau1pWq8BDO0UU32iH3/DEUBoovXbOd6g3SyqRMqAFmxbCaOTRGiQzkt1SSgleg77+OmSYj5juY5xyxCcAr7OWL66oOljGxV9qLtFLFlWARd03X7+9H6qZ/MVnPH2XQRj6XOOfEn5PQj8GDUE+3sMQz64Gl7h+LlRpvmBF9f4OEEFjACawDlefAD3G3g7SIku7+ALa3vHMaxkDYV8374c9eFBSZaTM2Vg+28013XM1JspfG3WBV07vKwTDs61Y4xMlLRYdx+XXLy9J5KVuUPczAz5DiJUDOOGKt68YBsu3OkEN9bK460vMjPJg9L9NOcMKiarig==
Received: from CH2PR15CA0020.namprd15.prod.outlook.com (2603:10b6:610:51::30)
 by SA3PR12MB8763.namprd12.prod.outlook.com (2603:10b6:806:312::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 16:02:00 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::f2) by CH2PR15CA0020.outlook.office365.com
 (2603:10b6:610:51::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Mon, 18 Nov 2024 16:02:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:01:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 18 Nov
 2024 08:01:33 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 18 Nov
 2024 08:01:27 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Menglong Dong <menglong8.dong@gmail.com>, "Guillaume
 Nault" <gnault@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	Breno Leitao <leitao@debian.org>
Subject: [RFC PATCH net-next 05/11] vxlan: Track reserved bits explicitly as part of the configuration
Date: Mon, 18 Nov 2024 17:43:11 +0100
Message-ID: <dca049d75d60d740d0736bfecfa4616be1d2388a.1731941465.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731941465.git.petrm@nvidia.com>
References: <cover.1731941465.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|SA3PR12MB8763:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e6d57ee-c000-4d03-6958-08dd07ea55d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z2eSGsiKVltvRnZn9qOeL/7jA0AaVBsFAGg5crU1yO+yOuuurfDyrUkbmRpr?=
 =?us-ascii?Q?N+txBbYToocuQsCC5y+2YT7XHGJSzgCr/kkxqbFcpwn5c3hcfLHassJJBGZo?=
 =?us-ascii?Q?g72WgH9+5Pnt66US/Ca0PSe7XrEXaBpVMePhdpN6I0ePvhfV8medx5GDD/Y6?=
 =?us-ascii?Q?OdAq303s/AqomnS0rwimwfJ+z+qIDcukvOV7VEIgJbU0Oc5iKRDVWOsbPE9d?=
 =?us-ascii?Q?g+MNBSbwOaQzyL+6HXXGzbZuCdTutRSKSbJe/16/hEN1oTstAzkT3fuEULA+?=
 =?us-ascii?Q?OYhs9fZHFB8PbdMnjMkTjf46KdsETY6QhZy+2pmLFbG6ZrXGk6gO7v3RUCYQ?=
 =?us-ascii?Q?sjFZyCdlG2H0mOmCie20lyfm/BLbbb0GTDaNfmJt7+dpFaafgsSg8z17dUgz?=
 =?us-ascii?Q?S8cgA4YE4DJhZtikscSEFDp/l+d6AaSjdezdwKS6EIBBkWZWl7IDXaao+UXl?=
 =?us-ascii?Q?1LtTjnikCSm5ZwCu5vHPr5o1hVrPomoQGHgL6IjEJRIZMz1YV65AyMFDn+Yo?=
 =?us-ascii?Q?gzf7644YRpwCuRNzBz0OAdcy9ndO8WKwlxwj6WxIOXlWX2XkHfcQb9zlhT+I?=
 =?us-ascii?Q?NeX+KyuZlKqtz28Zccnf3CvCuFNjXwZz2vwvc/t72l26WGLTHRecDKAsZE8K?=
 =?us-ascii?Q?yl344iEai5OlYGXIj4Ni4zpgZWmylACSEWmFQI3NuB+thVo1B9yPA67bgtvN?=
 =?us-ascii?Q?NH2RFZkx5rmpMdN+XqNlzFQxCNSTG3l4XL3l3gER01H6/MAda0tv8C1DrnvE?=
 =?us-ascii?Q?jXrvvVYNtsD5Xo0rg3G1HTw8JZPl2UYGcoTAm6Bc+i5GfOU6sjAbBIWOcQ2i?=
 =?us-ascii?Q?zgLLvomgo4an7dompPpzoQGZm824tCdRYhlGEp93NMrpo30ZtywWNa734TGY?=
 =?us-ascii?Q?q/IVhhymQARoPoOFsS8wTZNpxuaC0c8LkmANRQzM8oZTBDq0G9JeZwCMHLbW?=
 =?us-ascii?Q?pI+Noh8dTqmGvjSKYTHW5TFkQ373dl2vmbVJ04TtwNfd5EKPmoGVC+fQrWf6?=
 =?us-ascii?Q?7PBVINCWvF0F1asj39PkQprzPB/r3X+jgBGuZQzKnY5TcHYi93hiWgq/x4mz?=
 =?us-ascii?Q?q8hrB6+woIzbKLz4In1mnoKi2WmfFRKP+Dd68zufE8BGEn/Q03RrCt2FsLsN?=
 =?us-ascii?Q?39MQl81aX5aLdCLPQVSTZEUGvh0GJ2bQndlNSGzsCU4gqRV9W211PSzsCPvE?=
 =?us-ascii?Q?uQ1J/KM3wu2C4XM1pn8tnWjPVi3l8gbjlSADcf/CNhizYRyVNzyBlQ+ttPn4?=
 =?us-ascii?Q?xW3Q0tv/F2DZJ0+9syxXGdi9uYQLgbpPrK3e7UYQpY+h9FL1t+O59EtnTtRE?=
 =?us-ascii?Q?4gKY/SevBL1FHO2tAAEGxdnChR49kelodL4fK93qrtkJy57APs4wn7WTD1FG?=
 =?us-ascii?Q?g/F140SHKzKi1EAoabkgTmuX+Rtv6fLXuy4lnSgL4cNihx6ArQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:01:59.8691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e6d57ee-c000-4d03-6958-08dd07ea55d0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8763

In order to make it possible to configure which bits in VXLAN header should
be considered reserved, introduce afield  new vxlan_config::reserved_bits.
Have it cover the whole header, except for the VNI-present bit and the bits
for VNI itself, and have individual enabled features clear more bits off
reserved_bits.

(This is expressed as first constructing a used_bits set, and then
inverting it to get the reserved_bits. The set of used_bits will be useful
on its own for validation of user-set reserved_bits in a following patch.)

The patch also moves a comment relevant to the validation from the unparsed
validation site up to the new site. Logically this patch should add the new
comment, and a later patch that removes the unparsed bits would remove the
old comment. But keeping both legs in the same patch is better from the
history spelunking point of view.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
CC: Andrew Lunn <andrew+netdev@lunn.ch>
CC: Menglong Dong <menglong8.dong@gmail.com>
CC: Guillaume Nault <gnault@redhat.com>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Breno Leitao <leitao@debian.org>

 drivers/net/vxlan/vxlan_core.c | 41 +++++++++++++++++++++++++---------
 include/net/vxlan.h            |  1 +
 2 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 95d6b438cb7a..d3d5dfab5f5b 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1710,9 +1710,20 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		goto drop;
 	}
 
-	/* For backwards compatibility, only allow reserved fields to be
-	 * used by VXLAN extensions if explicitly requested.
-	 */
+	if (vh->vx_flags & vxlan->cfg.reserved_bits.vx_flags ||
+	    vh->vx_vni & vxlan->cfg.reserved_bits.vx_vni) {
+		/* If the header uses bits besides those enabled by the
+		 * netdevice configuration, treat this as a malformed packet.
+		 * This behavior diverges from VXLAN RFC (RFC7348) which
+		 * stipulates that bits in reserved in reserved fields are to be
+		 * ignored. The approach here maintains compatibility with
+		 * previous stack code, and also is more robust and provides a
+		 * little more security in adding extensions to VXLAN.
+		 */
+		reason = SKB_DROP_REASON_VXLAN_INVALID_HDR;
+		goto drop;
+	}
+
 	if (vxlan->cfg.flags & VXLAN_F_GPE) {
 		if (!vxlan_parse_gpe_proto(vh, &protocol))
 			goto drop;
@@ -1763,14 +1774,6 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	 */
 
 	if (unparsed.vx_flags || unparsed.vx_vni) {
-		/* If there are any unprocessed flags remaining treat
-		 * this as a malformed packet. This behavior diverges from
-		 * VXLAN RFC (RFC7348) which stipulates that bits in reserved
-		 * in reserved fields are to be ignored. The approach here
-		 * maintains compatibility with previous stack code, and also
-		 * is more robust and provides a little more security in
-		 * adding extensions to VXLAN.
-		 */
 		reason = SKB_DROP_REASON_VXLAN_INVALID_HDR;
 		goto drop;
 	}
@@ -4070,6 +4073,10 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
 			 struct net_device *dev, struct vxlan_config *conf,
 			 bool changelink, struct netlink_ext_ack *extack)
 {
+	struct vxlanhdr used_bits = {
+		.vx_flags = VXLAN_HF_VNI,
+		.vx_vni = VXLAN_VNI_MASK,
+	};
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	int err = 0;
 
@@ -4296,6 +4303,8 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
 				    extack);
 		if (err)
 			return err;
+		used_bits.vx_flags |= VXLAN_HF_RCO;
+		used_bits.vx_vni |= ~VXLAN_VNI_MASK;
 	}
 
 	if (data[IFLA_VXLAN_GBP]) {
@@ -4303,6 +4312,7 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
 				    VXLAN_F_GBP, changelink, false, extack);
 		if (err)
 			return err;
+		used_bits.vx_flags |= VXLAN_GBP_USED_BITS;
 	}
 
 	if (data[IFLA_VXLAN_GPE]) {
@@ -4311,8 +4321,17 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
 				    extack);
 		if (err)
 			return err;
+
+		used_bits.vx_flags |= VXLAN_GPE_USED_BITS;
 	}
 
+	/* For backwards compatibility, only allow reserved fields to be
+	 * used by VXLAN extensions if explicitly requested.
+	 */
+	conf->reserved_bits = (struct vxlanhdr) {
+		.vx_flags = ~used_bits.vx_flags,
+		.vx_vni = ~used_bits.vx_vni,
+	};
 	if (data[IFLA_VXLAN_REMCSUM_NOPARTIAL]) {
 		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_REMCSUM_NOPARTIAL,
 				    VXLAN_F_REMCSUM_NOPARTIAL, changelink,
diff --git a/include/net/vxlan.h b/include/net/vxlan.h
index 33ba6fc151cf..2dd23ee2bacd 100644
--- a/include/net/vxlan.h
+++ b/include/net/vxlan.h
@@ -227,6 +227,7 @@ struct vxlan_config {
 	unsigned int			addrmax;
 	bool				no_share;
 	enum ifla_vxlan_df		df;
+	struct vxlanhdr			reserved_bits;
 };
 
 enum {
-- 
2.47.0


