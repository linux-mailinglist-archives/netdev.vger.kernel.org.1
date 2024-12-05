Return-Path: <netdev+bounces-149443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8510B9E5A1D
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 16:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94E9C1886660
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 15:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC48F222583;
	Thu,  5 Dec 2024 15:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kbP0+n2t"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0725C222574
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733413461; cv=fail; b=CEyzXjj7huZjb3YkNjFCvC9Xl0WWOiUQWM66RQ6yfjX6O/Zs1reQ55Cymw6jkeAqbNNvJeA1bHVVyklVydDSiaPI1Hi1sV9d9auU6gwesi/TtaMzeOJ6eer0D4gemSIPiVs3wvS7+s4KjlT0MdYERPtQ450vKrDt5UDsf/A4sVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733413461; c=relaxed/simple;
	bh=1ku2EMo6yMHEg5+ip+YnpKpoWv8rx2QkdXEUbVgim0Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iY98klb6o/a2b7J5LzbYDjmRZa2rkU6eK7eeMM4NQJIjlWJtWnypVG6zSKh8HvD9KXAyBRd9Ucvmwg+dWDRVjDwv2ajteAyWVGQJF/9f89FcYUOcDtro/kYn/Q6+lpgilg+LuMOp+N1v3pVEQPVkDBngFlPIdp7QIQzWoZDYnTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kbP0+n2t; arc=fail smtp.client-ip=40.107.223.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJ4KfzncYuTWiFNki2nhdoMsK2RlWLuJggMVdKasRWa3pTJTXFMOR6ubxDpWnAYNd3z5qxdX8BWoHkaumziuWcDwhsVZSeH0eNGYCUXfKTnREEd/o5tYzOb8dJLd7YfOu2QpUyWHMmwDFAP3pMVNnpM5cIqPyE3JPg3FFbtUSiVIJxZHM72dnF9WjBOUxHesTbttjjo59VOEkyIVkr+6WzeXR0z89uV04c2Ln2jjBMQ9M78e+j+UPccsQZOVfAU1SXwAffY44sPtOmOTqRzcibhnEgu3FVY2hhl8lFDGC2Caugm0V92FJG+cw3OucAPLILqB5SBXwtszUSv7bdurMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gO6UD/APZI+e8FHC377Ht/AVvyYItDlRhst5ibeJ5z0=;
 b=v46jRbvp5Cim2Ywn3srfk3+HEfVroK9fMz/uEOIaqf5lIFFEMWE9PTqnFLv4qZ6nVBwkLR0Tv88+pIpsF3w5TLn3sAJv+BTH4HC8hyJR18s7ztDN7c3g2jHLredpwjDpvC1BlIn2kW9wH5No9xxQGB/CUwJJqJCUoG1xvV3zngSOAAUopVTJMC0SFgDdOahzpYhIfidzebKiEPS88IgsJ2+LgfkSXB/0eNr411+Ui033b5iMVYmrXf8RiCNyndkufsdNew9rr72IOazFIpCLxp5cyLEB7AJtZsbj+GdAgcSfptdFqnUAGrtR1/bmE9f4l70dWhMiLmMrpkqmuiEzYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gO6UD/APZI+e8FHC377Ht/AVvyYItDlRhst5ibeJ5z0=;
 b=kbP0+n2tn6MCFRbIv9ANPUBL7f0xUHHH1q41nPbEfANz54rr5TAeVc266tPC0UieVBV76YyhOgKK2GXFZGDhpm7qzKydx0aBF3G6CUaaiYb54oDyT7TYcRigRFL8gVSb1BwAOMwaS1NxVa8bYKTriAKYH0F6YSG4vxlkQAvUAYbEzjP+7MDidiRw/nLdTVKNEfbmwwIKQ5ezF2IWMWs0+Rne3sa4mRDQg1yWbXaouTxjoy8G6OHaGka9E4yyxPfH50Mn9lYhTLuSPfYgCpFHRCUFsVOuw/65qnzDfATMI3PxqjtKiZILdQbQ+4J1yhu4So2qBxBXdxvErdUbXW7L1g==
Received: from SJ0P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::31)
 by BL1PR12MB5708.namprd12.prod.outlook.com (2603:10b6:208:387::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 5 Dec
 2024 15:44:11 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::7b) by SJ0P220CA0011.outlook.office365.com
 (2603:10b6:a03:41b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.21 via Frontend Transport; Thu,
 5 Dec 2024 15:44:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 15:44:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Dec 2024
 07:43:53 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Dec 2024
 07:43:47 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>, Menglong Dong
	<menglong8.dong@gmail.com>, Guillaume Nault <gnault@redhat.com>, "Alexander
 Lobakin" <aleksander.lobakin@intel.com>, Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v2 05/11] vxlan: Track reserved bits explicitly as part of the configuration
Date: Thu, 5 Dec 2024 16:40:54 +0100
Message-ID: <984dbf98d5940d3900268dbffaf70961f731d4a4.1733412063.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|BL1PR12MB5708:EE_
X-MS-Office365-Filtering-Correlation-Id: afd1fef2-3733-4e6c-72a6-08dd1543a60e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a6P1zRK3FYX8uv54kJ+QysMLlK5ZIa8NiX2bWWYGC28Sz5adD1tq3GGwo1Tt?=
 =?us-ascii?Q?fBqTVePq/M2OeA70bFnMdLhHrZ/mREh2gcLM2uDrK6VBnvWCDE6wFQI+8xH0?=
 =?us-ascii?Q?wCxrE4nJpEyzvmHW64LEngL8q30waboYBZaHbwi2bJRPUu7C0aw1DS5ujuKI?=
 =?us-ascii?Q?uM7ozbzgxgIftHCACIubwupCMRHDX4TuJ/YSSTCqhmia24boRytvNO1udf8+?=
 =?us-ascii?Q?FhRtnpC1dWUo8svmWnMYIZkFubFULGx2sxtjjW+dOzSIyt/nXhtmRVz80kjH?=
 =?us-ascii?Q?2y/vo9DzlEgCmJvdGRR37tI/u4X2z6FdCKkvV2oMRH8idMaHvX7vhzpZaUlD?=
 =?us-ascii?Q?5fS0APeAK0Ct4j/dBAmw3/BwbrmCWCdnnAjojsw9mr/hxreNoD3UYtprJeXy?=
 =?us-ascii?Q?0OIhPAgx/1Bx95LmTsgHNdob6OQRFucuIw+ZPpPycMmiBGGaU7Sxo1KkZkr7?=
 =?us-ascii?Q?XVyeVBjc+B/w8ik+Q0hIIkI/4BHddpgKD6WnxO/JxSJTc9idIhktsybT9pcN?=
 =?us-ascii?Q?RKlED+kj/sWbgxLtXVeTcCAyfG1v8Divg9oV6qGvTdsb1+Yd9Dbiw6DMD0s2?=
 =?us-ascii?Q?sy2mBfh4Vx/JlFI3QbuHTn4fqNijyW39oTWQNfw3usZYUAV0/g6TBzBq76dc?=
 =?us-ascii?Q?g70/5whIE46AT3KLFgnt9H2FupJ0T9t8E+7IIwmhn58jzgUskeqdsVVEEVbK?=
 =?us-ascii?Q?xSFBANU79ez0+W3QGvbzLUxxrcA/wfs0mO5k7DClo6L5MnKUttbCq7+E9Vyi?=
 =?us-ascii?Q?A8Wz2H55mc1XSCBwRpcVMw+zx8Jmh+UxRaKogv/Eu3UikZmSqXwQz5tAP7Jr?=
 =?us-ascii?Q?aUkPNynIMc5pBvoX94fpU3mJHOWkruQC8hwuU5IQIW68C8Pmw2ODYzsk1drV?=
 =?us-ascii?Q?A+lXgxS8FIiMnIjRoWK8Oavhay8MLCvMe02EKqwWy44JkVr8DvP3a8pjM8wX?=
 =?us-ascii?Q?UDST8BAxfc6PWgdDAy8r+Jq6PYXovbdYd9D3qVzT9J6v5SvzcAMi2QK9of1n?=
 =?us-ascii?Q?rzNk4Dbk579dOr7vRvVX7GhwSXPLN1aVwWFtQyLKZgEPkvlpLfyiWrAu1oQ1?=
 =?us-ascii?Q?KUaMJ0+t8TnSoXqOJhbxNSyT66u77p34OVYV3Bd+4htVrgzgYyxS1o2CUfAb?=
 =?us-ascii?Q?iRksSXblUXQM9eJwlcejFlPcfZwjFGPltSpFbdaHPkEI6m0FFybgjxx0L67s?=
 =?us-ascii?Q?5TUax9pZYE/pO4k+tXtTTu8yIOwjX01L0/mKUy6V7LP0FO8Sm066/ysv/PYa?=
 =?us-ascii?Q?uoe4NxrKDORgvMrOZIO6xzIPfEbeQOXdCC/YJ/QnBiqWCRGOoYbBPvoDqUV+?=
 =?us-ascii?Q?BWU5bB13ySnA2nX6Cz9q2u5ewhQk7gyHjufRaKeBG3pUD4pIwSGxbsG5T567?=
 =?us-ascii?Q?OeWk2upybC18q38ekbZ2sTw6On461fMGtHEWPWKcLbLiM5n80pnf+IBAC0Fv?=
 =?us-ascii?Q?jr1npus/qRHoHBAabP4Hu5FwdlezOVwc?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 15:44:04.8497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afd1fef2-3733-4e6c-72a6-08dd1543a60e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5708

In order to make it possible to configure which bits in VXLAN header should
be considered reserved, introduce a new field vxlan_config::reserved_bits.
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
CC: Menglong Dong <menglong8.dong@gmail.com>
CC: Guillaume Nault <gnault@redhat.com>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Breno Leitao <leitao@debian.org>

 drivers/net/vxlan/vxlan_core.c | 41 +++++++++++++++++++++++++---------
 include/net/vxlan.h            |  1 +
 2 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 257411d1ccca..f6118de81b8a 100644
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
@@ -4080,6 +4083,10 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
 			 struct net_device *dev, struct vxlan_config *conf,
 			 bool changelink, struct netlink_ext_ack *extack)
 {
+	struct vxlanhdr used_bits = {
+		.vx_flags = VXLAN_HF_VNI,
+		.vx_vni = VXLAN_VNI_MASK,
+	};
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	int err = 0;
 
@@ -4306,6 +4313,8 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
 				    extack);
 		if (err)
 			return err;
+		used_bits.vx_flags |= VXLAN_HF_RCO;
+		used_bits.vx_vni |= ~VXLAN_VNI_MASK;
 	}
 
 	if (data[IFLA_VXLAN_GBP]) {
@@ -4313,6 +4322,7 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
 				    VXLAN_F_GBP, changelink, false, extack);
 		if (err)
 			return err;
+		used_bits.vx_flags |= VXLAN_GBP_USED_BITS;
 	}
 
 	if (data[IFLA_VXLAN_GPE]) {
@@ -4321,8 +4331,17 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
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


