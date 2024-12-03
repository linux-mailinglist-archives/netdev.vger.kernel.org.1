Return-Path: <netdev+bounces-148523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DDD9E1F5B
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62360166A5B
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FE31F7550;
	Tue,  3 Dec 2024 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dxp8LEpQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974E91F7093
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 14:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236456; cv=fail; b=IuslIWOW+aQyX/ayNauJwQR7g/ICJN3Iai2TRCaxhC+hFbEocWgMTZKGLlCWfgp47Jf1LL30kBwAEeOZNLHD/q1d3usEblabBvTVKWFWLNkVz+fkm/GuZqsmLZkgjPAxvrHx3opyaZBOHxrCdwbfku3qF6ZkejvyIdP+Bp1/s2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236456; c=relaxed/simple;
	bh=RxcewKR0DN5QRSwdc82XfUmx2DDuwVChRJ5JAw42/ko=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jlf0o5JcvJq6efZaEOd4hp/NEa7teRdNXGunyykJT8LRJZOVrzl46fZDkixUL3PlghFt/A4ELVau8MaPe/ORadxfOclQ0LoJtKE/ED+Ff5/+tSYTp6bP7I72x/MY7AB0BqPWi4oU/mbQPAtV21P8+TBdxZ8sJyaf010pK/cnn7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dxp8LEpQ; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M9b2NBENpiLZlZNRalVn7SKpIhcSV0lQwOwjWzh6lcR2Nw9jwcPe6EJREU1qIVrKcf72THdyRcP28l4EgPTpiyUK8kNvpt96XKwqt2/wR+KnOL1HxlX2kwqhYYXouFaOCfZnINx/4Xp0MKZt3pI4VlAzUaNd5kRFan6UvupWe8p3wj/bcAhQzh7MDkg/TAExfCW9QxBA6GqwZ3lEdv2bhcfcPOzjczO3TQLdYolEgSxKORiekghk50kWHLON2SuEbqVVSgFANe92TqFv6qEa8x7mfOsF2wzd+PRilYlHDmX6aWKahsMgWIuw103Nei22yKlk3P6S9xOOAN770A+bcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPATP31c5msu3dI4IKPzlhwyb3B2rGG+qBxUlaoEIcc=;
 b=ui6BAMUIqslF5ka77BBHeJYviABrlEvzRO8G1QSp+WvIrNJiS9F95JiRnvh0EC9PQRxV0im8hSThISYcfqVQntoGtN4MdJLu5Gq3g+RkyLgeBIwan/jvQ4/43jzbLDXzti2ODb4zPfYNVsQD+pq5ACi2HHP6es0ROQHz0qj6FnQDLsEUi5rKDYH1HmECzbxs0cpcA8MbPwdoOuIcKjMS+DRt1ZAPBZknKcDI+1iwSrAlGXk5djUBXvy9wFpQcOh9gGJMSzGNGiJ7zL5avb5cdNeXUCWVUi3NTOO4rbcAbTw58c2DoCHORnHEXfYsZyjkO6ctqmp1SepPKMG/A5BIoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPATP31c5msu3dI4IKPzlhwyb3B2rGG+qBxUlaoEIcc=;
 b=Dxp8LEpQRd9kz3W/0PoZKNa6vYmxqT5c1weIqO+Zl6ntBhfNN5nZLcD4xTVE1ss5FnVawPA7uBWagy/iDTdWYW2lPNY7CEeRM0tfK6kyvlGjo/wuKkjBHV43WT7p8OhQu+dNWtIXXqbwTm90zZ8cOzi5GIJ5VyT49gA0pJXvp1z1Z/UvK6xOjEQUvkzeM9UE0OJDU6Tlg+sw3+v1mPDdbrY5RfBVANA3TRQ/Xpl7AP1Vazaid9piB1nGOf+LasIp4yxqMnVK298+KrZFgnDh4KqjS50H3pc6VVOmX+w9Qp08M5TWpx6s2AgmbazduYZmRSwElLXPeeFFgq0AWTYJeQ==
Received: from SJ0P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::19)
 by SA1PR12MB6869.namprd12.prod.outlook.com (2603:10b6:806:25d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 14:34:07 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::30) by SJ0P220CA0015.outlook.office365.com
 (2603:10b6:a03:41b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Tue,
 3 Dec 2024 14:34:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 14:34:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 06:33:49 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 06:33:43 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Menglong Dong <menglong8.dong@gmail.com>, "Guillaume
 Nault" <gnault@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v1 07/11] vxlan: vxlan_rcv(): Drop unparsed
Date: Tue, 3 Dec 2024 15:30:33 +0100
Message-ID: <82440b6b3471ed1c0bf01cca6be90bb4c9b413e2.1733235367.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1733235367.git.petrm@nvidia.com>
References: <cover.1733235367.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|SA1PR12MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: 61e04c79-bce3-444b-b4fe-08dd13a78b66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?awtENVAPQU7EwXyfoj9uaJP+yIGdHo65GFZSbLHctSfKgj8wvBeKeykK3Eo+?=
 =?us-ascii?Q?4IyTwTbmJmNnYebfXMPCdPx6/Q8nyjpk0UJ8+/tS3d65aRcDQrrCR/NdDQP1?=
 =?us-ascii?Q?b5X+VCjjPHOk+qF5yH2pRbhAHGZ0Njo0dfLpzo/3vEqkCNdn+xSMZFxxk4EK?=
 =?us-ascii?Q?bbxxh+Y902wk4C8A1bclyj+qLUcMYWvcjNMc70p4gUSCN/IfIFS92WZmvUlI?=
 =?us-ascii?Q?ZabSQK6lQRN3T5GLE2GDQSEfjACJaC/VqA77Uo5Ec8j3QTpd1VTorzhgtPxw?=
 =?us-ascii?Q?LRmWdsSOBgYjhcVXF3rTggolMFAYJ5wjL/44gE3COriyAcmvf+IJZPW5Vti3?=
 =?us-ascii?Q?oZZedpvUQEzYHD+3i3nnUeXBLdFohmHi+4WoMSxrk7XGTs8EWrFbos5cLGzS?=
 =?us-ascii?Q?CImGB7WogoM4CkhtXgwozXZERJaWTAGUIyuzTTXC31N9ynaZPo+twucDWyFN?=
 =?us-ascii?Q?4bILPkSZ7D1+PURknpMEtcOIeP2MfsKhsz4ZwvZeMsdgLxNG3y1XOZ6tUoFe?=
 =?us-ascii?Q?ESfwZ95e40LpUD5UzBK6M250cn/85vm2URNsum+KDuKeiu1v+VPi1dAgzw5B?=
 =?us-ascii?Q?TcWwR62BaxpcJ+lK+v63OUWWO8UDdSNaDWaQ3MXJCIubzugSZvQ7uy0Cyu7K?=
 =?us-ascii?Q?g37dL6bBHFTgxB08ICkx9+jVtwNLmwECH8BrpDPWI+1nlz2Ha0p0VmQBdip4?=
 =?us-ascii?Q?pQnGn+YyP7k3G4grpHZ9Cmx0JLOw6h5ztlxE8dJC08rmgGP0lTl9eCIoNbhb?=
 =?us-ascii?Q?J7gZbns0hWL6DjjTILfGu+AOhu4583dwoms6XE2hYTod6AqsmYMhoVc+rM6u?=
 =?us-ascii?Q?FAtxXwSfZUJZWiljYeDWVkjHI5c+vGtFSovXJn1RLcujzaQiX1GJq9KPdymQ?=
 =?us-ascii?Q?ftTOBfuwuVGFQnan3MLDAsSUSlvqC0pYtPDBjfx8Ne41XcvUvcsLr6QjhLO6?=
 =?us-ascii?Q?5guVu0FZ4yOLr+YFQEwkMWtCjoxIB9lyyVaw6SBt9ER/dYAVRFhk5mEmbBrb?=
 =?us-ascii?Q?gxx8FDb4mG/maoeyiMRWoePaKXfz/0m63v5Zl3x7O0Q0r/mDT+vbC/B4HmiZ?=
 =?us-ascii?Q?wrwrV/81/dVMhx9yFxYdN9Pjl6kZVWXivqs9EB2AJiBt6Ksk2hKdidDCHKck?=
 =?us-ascii?Q?PhhGBlcMUBPj1Z6ClEyXPjO4YD+mA4S8QUSIOHIMEFWBE8tjlOJbyINJSJ1q?=
 =?us-ascii?Q?Q1KM75NtrUTCXyKEmrY8PIOacpTDJQ98urDtnzUweGfGDJ+L7jPEe/FWHjLL?=
 =?us-ascii?Q?NmVvHn5iTE40A4OBobXnjHQ4kCT9KvvzXdYizdAV2sgwrul53Dl4rxxU4yfz?=
 =?us-ascii?Q?Y/AjCPcCj7ok2Rs7gM4VctR7QLgTSA08r1qV5KkLH9TyNOniPr0EGZZlp7OC?=
 =?us-ascii?Q?p9Rv+dacjK8U1uEK5pghdfq3ZCqO48NKRPQJo/y+46WzLsxEtZmJxDM1HRMy?=
 =?us-ascii?Q?SeI2Uc1+AtaQB08HMgDW5tNxO6l07Hjw?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 14:34:07.4458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61e04c79-bce3-444b-b4fe-08dd13a78b66
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6869

The code currently validates the VXLAN header in two ways: first by
comparing it with the set of reserved bits, constructed ahead of time
during the netdevice construction; and second by gradually clearing the
bits off a separate copy of VXLAN header, "unparsed". Drop the latter
validation method.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
CC: Andrew Lunn <andrew+netdev@lunn.ch>
CC: Menglong Dong <menglong8.dong@gmail.com>
CC: Guillaume Nault <gnault@redhat.com>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Breno Leitao <leitao@debian.org>

 drivers/net/vxlan/vxlan_core.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index b8afdcbdf235..b79cc5da35c9 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1670,7 +1670,6 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	const struct vxlanhdr *vh;
 	struct vxlan_dev *vxlan;
 	struct vxlan_sock *vs;
-	struct vxlanhdr unparsed;
 	struct vxlan_metadata _md;
 	struct vxlan_metadata *md = &_md;
 	__be16 protocol = htons(ETH_P_TEB);
@@ -1685,7 +1684,6 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	if (reason)
 		goto drop;
 
-	unparsed = *vxlan_hdr(skb);
 	vh = vxlan_hdr(skb);
 	/* VNI flag always required to be set */
 	if (!(vh->vx_flags & VXLAN_HF_VNI)) {
@@ -1695,8 +1693,6 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		/* Return non vxlan pkt */
 		goto drop;
 	}
-	unparsed.vx_flags &= ~VXLAN_HF_VNI;
-	unparsed.vx_vni &= ~VXLAN_VNI_MASK;
 
 	vs = rcu_dereference_sk_user_data(sk);
 	if (!vs)
@@ -1731,7 +1727,6 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	if (vxlan->cfg.flags & VXLAN_F_GPE) {
 		if (!vxlan_parse_gpe_proto(vh, &protocol))
 			goto drop;
-		unparsed.vx_flags &= ~VXLAN_GPE_USED_BITS;
 		raw_proto = true;
 	}
 
@@ -1745,8 +1740,6 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		reason = vxlan_remcsum(skb, vxlan->cfg.flags);
 		if (unlikely(reason))
 			goto drop;
-		unparsed.vx_flags &= ~VXLAN_HF_RCO;
-		unparsed.vx_vni &= VXLAN_VNI_MASK;
 	}
 
 	if (vxlan_collect_metadata(vs)) {
@@ -1769,19 +1762,12 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		memset(md, 0, sizeof(*md));
 	}
 
-	if (vxlan->cfg.flags & VXLAN_F_GBP) {
+	if (vxlan->cfg.flags & VXLAN_F_GBP)
 		vxlan_parse_gbp_hdr(skb, vxlan->cfg.flags, md);
-		unparsed.vx_flags &= ~VXLAN_GBP_USED_BITS;
-	}
 	/* Note that GBP and GPE can never be active together. This is
 	 * ensured in vxlan_dev_configure.
 	 */
 
-	if (unparsed.vx_flags || unparsed.vx_vni) {
-		reason = SKB_DROP_REASON_VXLAN_INVALID_HDR;
-		goto drop;
-	}
-
 	if (!raw_proto) {
 		reason = vxlan_set_mac(vxlan, vs, skb, vni);
 		if (reason)
-- 
2.47.0


