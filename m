Return-Path: <netdev+bounces-149445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2139E5A23
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 16:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C418C18874DF
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 15:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD091224AEA;
	Thu,  5 Dec 2024 15:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tz4+YlBw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1529D224AE2
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 15:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733413479; cv=fail; b=mcwuI1ciYHghWWnDYsIJSTEfwD8yilQc8kAdq6f+nJxSMTQejD5ltTid+5sv0qF65D2aV1VqLF45inAuur/p1qQT3CYWPRn2SqjmejEgFm/2p63ab13Av5l4/SPuL7rMJ4bKZn697xVs0eLa9R5YoM3RBljhlL20hdw1cx/aF3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733413479; c=relaxed/simple;
	bh=rfo6m9cx3Q1UR6Y6wDIRlDcT1UOgaFxN/W14kiMBoKY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tzV/82o/GT2urBbYljP3ZxwbHX/S2ixve2NQ8cQkVMw41sL2uKecfRizYrJcJ0p/6PBWGkvUnkSVeEbSjNRdmv2V27upG19sWi2wJHEaNy65sr72CJmfLbgblTbniocI0Eq6onxuxEqm7fY+EcAtNbkvWqC4rejKy8xB6hVcrV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tz4+YlBw; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GuG09KzbtkNzpHXIx19I1NioVKoJ05qWipRPRTyWwYHeqhZHiUNTjwL4Ry386SLSDnY368DO+SLvjf1eFLA9S0ORS07ebcnlEKdhqObKbvVtPNf0zzSo849asP5ErjLMrCLClIPpcJqHy5G/Dh0x5qydkcbEaX/QSioRKU9xaXhGeJV2fgMtiQQRefkITDEaOP0EjKIFIl56UBS6mhJcEYB9/KFgyFj48ZWX8TpnF9J4MTDfIzHazJFngG9Gd3n3ue/e16o2MhChGamOIvRYD4jrKnWSO2KC4qczZgCkEbTdl1MjIr2rMdl6yFg7baYedqkluLtlfgiOHln8h7/rDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+QpUgy4gHsVQVd9pjbzpiIxFZaLMXm3n4hZRSQaM7L8=;
 b=kukNSc+9B9Dg9S9hKXvEiS/w/QSPKaP7tnFDzZAbBfinFHzudpP00cW6vVHJWQgeP7oPfYe0mBZ/xwggqvblutlza/2Wa+2KqwBUbFCfjVRcibeKiXM+hyr5R/SMmLVGJh3OsDE+NQ9uInXvt5G+b94iOKOlRp3JCT22AS7qbEWb+glI3j6GYDxbTQpFiqQpJuIdLI9rMvigxbDAsXSGyL15lEUD1aydZW131joqN6TSWn8mndLTtJhgxU+D3w9BZKURjL2vTte3uwxer7S4gWh+ezALnErYbCmNKXL3g1hZo56/6bpJUL5MX8NKxHyHJq3ETXVcprjJkgYiW++NTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QpUgy4gHsVQVd9pjbzpiIxFZaLMXm3n4hZRSQaM7L8=;
 b=Tz4+YlBwp8fbVSb4r84vnYVsyZGnA9uiTvmAjlHqS2V1p3KT7p+xIn3xjKccUV+MWY8Wlvf1FOwgwe1CyuRD7UQsokWI2Uvop2Y0f771995qnOEuLGPKRX+FHfiyr4Abbs4m+iT25rmavHd34r9I1dLaHOrhzdcyh/CrF6HdcA0hV/G68y9LAvpcTHyYRmcC1MhVLgxNck0tDIE2/KT27BCqswCVwzvIJ/Gh5eia/gPg6IeD4I+18OfIfiS7JM15EL8jO+rrycNqzLy6ifZCwxALL0hRZRH6jKa9U2DGH754iuVLbL5xr5xWOFM116oHxf+3vqNHxaAVLBEy0CzwJw==
Received: from MW4PR02CA0004.namprd02.prod.outlook.com (2603:10b6:303:16d::19)
 by MN0PR12MB5740.namprd12.prod.outlook.com (2603:10b6:208:373::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 15:44:29 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:303:16d:cafe::b) by MW4PR02CA0004.outlook.office365.com
 (2603:10b6:303:16d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Thu,
 5 Dec 2024 15:44:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.1 via Frontend Transport; Thu, 5 Dec 2024 15:44:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Dec 2024
 07:44:13 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Dec 2024
 07:44:07 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>, Menglong Dong
	<menglong8.dong@gmail.com>, Guillaume Nault <gnault@redhat.com>, "Alexander
 Lobakin" <aleksander.lobakin@intel.com>, Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v2 08/11] vxlan: Add an attribute to make VXLAN header validation configurable
Date: Thu, 5 Dec 2024 16:40:57 +0100
Message-ID: <c657275e5ceed301e62c69fe8e559e32909442e2.1733412063.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|MN0PR12MB5740:EE_
X-MS-Office365-Filtering-Correlation-Id: 24a4eb5e-7bf4-47cb-322a-08dd1543b42c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M2BL8K64D3xoGAh/PpOsiR39UIc4tEnqhX3TWumjBphfbPnacLsrt9kfxbQG?=
 =?us-ascii?Q?YvT6Y4H6dYmAQ0UXbvXxprnqet+SvQqB2ZmHs75lklAZPhgZZRnRe2/3ElRU?=
 =?us-ascii?Q?joV3EPF3mnK0GYEazE2ZEpniUuKaQoWE8HL9Fl+uLTyqT9oe8Ylx5fVU3lqz?=
 =?us-ascii?Q?6NlVKFT1T+Drg0UmDKr24AIxjGcxIOoaIHUdUtMrAQZtOBa9shZ3//c4/bC1?=
 =?us-ascii?Q?6yeuKxdqR8U88cnq44QnEZQWmgamsLZyq71UpBWjieS0ypNLkcXKfZ+ZBJHF?=
 =?us-ascii?Q?nizM6STVNFd8xAS3Wpo7st5dFvfc1ydXWCMLHU385bdHD0DgEEX19nvxsQcW?=
 =?us-ascii?Q?71f2U6jgZaElAAN4SdWd2hXKcuzDW2MTSwGGfLTlJBIcCeNx62uspXfVJTHX?=
 =?us-ascii?Q?QMnx99e5Iap7qxFCGB4sAtLbqkoLu9S+NCTWefwzhNH7Aw/yw2QrIdBYTAS8?=
 =?us-ascii?Q?lJ62Q6cRXqsCgSFTjTyNkYVBzpl1I9A2Azjsh4qRxNHho3VMNqmXG1wj3O+A?=
 =?us-ascii?Q?5tsPLbL7WgtbWFdn1Z35JEKpf4iPbp2WvfRQ8CnHGdIcn/aZHPiTD5mPjFVh?=
 =?us-ascii?Q?MtE8B+RpsfF3mnLpWsJF8Bi2VDj8ZOgTX+M2xGTRl45n1+1MCFOSpBQlHioU?=
 =?us-ascii?Q?SIkicrqDdnlHlskd44c0qNfUCMMVNSs7+hezbzlgzuQxx8pwx+5v+4ocU/Hk?=
 =?us-ascii?Q?xfwPKYf5RIeym6zJx0R5IhyhJT+Z7eyvQoavw7I9mP8f2fiLH981DRJyhueN?=
 =?us-ascii?Q?NligeE6NXEqdZkxVf9s5qx2ASh6o+6sIRmoluoUgYaAD+2qWv1gwzC0lg3O0?=
 =?us-ascii?Q?cQAc2MlbU0TfHPN1wwT2YiIYEraCId3BMpznr2pBKUkygUcBb3OhYY67hZYZ?=
 =?us-ascii?Q?G/qnCu1Uy2YN+/a61NdV5lUf/XTjSYi0WxzRH+gB4Xq27Z/ENeWPEqxnjcrj?=
 =?us-ascii?Q?SiBNEsWsR9TMJHxD4dB3mAmVNAJmJ+1pDKgWOoj4QjfPrUNworpRjulIXVe4?=
 =?us-ascii?Q?D0p2E5D0xa2ahtqpQE8AOmcGY+GzuXdAyqiObEOHCvlL+xsTgqwBDMOxsX+t?=
 =?us-ascii?Q?bE47NQVwrxWWl56F6JG+SWHfBYBcmq5hITwnyIjIo1wA2/9jyjpUIT8xgBWb?=
 =?us-ascii?Q?tfzwNLjs+XrKgKMTrxqja74soKHUxSrKNpwIqFb+MO7KqW8Vy0Rwi+OETn0c?=
 =?us-ascii?Q?b6TztRvm+9ARzw0Ici7yPkAmhae8B0hDuzQ6voK9sE3ldv70KUGilJHtBUYM?=
 =?us-ascii?Q?/VF4RFtbOmp6yd6HiMwYvia9JjGi8vik8iHj/6G4jLBKgU8wmdqoWyfayYg3?=
 =?us-ascii?Q?iYdSjBPg95ZSPAyxYTPKTPxl23jdBAuwIc+VHIv2WWcH/LItZWvvjeGzfwhq?=
 =?us-ascii?Q?njO2XCTCfrVZ1qTcE7UOFe5EVWzkNtahT73P1rtL0HBw5OecRqZMJoCALOPA?=
 =?us-ascii?Q?MtKk5DGHtjA/I0l6mOgTa0dMycWcqmnP?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 15:44:28.5172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a4eb5e-7bf4-47cb-322a-08dd1543b42c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5740

The set of bits that the VXLAN netdevice currently considers reserved is
defined by the features enabled at the netdevice construction. In order to
make this configurable, add an attribute, IFLA_VXLAN_RESERVED_BITS. The
payload is a pair of big-endian u32's covering the VXLAN header. This is
validated against the set of flags used by the various enabled VXLAN
features, and attempts to override bits used by an enabled feature are
bounced.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
CC: Menglong Dong <menglong8.dong@gmail.com>
CC: Guillaume Nault <gnault@redhat.com>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Breno Leitao <leitao@debian.org>

 drivers/net/vxlan/vxlan_core.c | 53 +++++++++++++++++++++++++++++-----
 include/uapi/linux/if_link.h   |  1 +
 2 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index b79cc5da35c9..38e967e27683 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3438,6 +3438,7 @@ static const struct nla_policy vxlan_policy[IFLA_VXLAN_MAX + 1] = {
 	[IFLA_VXLAN_VNIFILTER]	= { .type = NLA_U8 },
 	[IFLA_VXLAN_LOCALBYPASS]	= NLA_POLICY_MAX(NLA_U8, 1),
 	[IFLA_VXLAN_LABEL_POLICY]       = NLA_POLICY_MAX(NLA_U32, VXLAN_LABEL_MAX),
+	[IFLA_VXLAN_RESERVED_BITS] = NLA_POLICY_EXACT_LEN(sizeof(struct vxlanhdr)),
 };
 
 static int vxlan_validate(struct nlattr *tb[], struct nlattr *data[],
@@ -4325,13 +4326,44 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
 		used_bits.vx_flags |= VXLAN_GPE_USED_BITS;
 	}
 
-	/* For backwards compatibility, only allow reserved fields to be
-	 * used by VXLAN extensions if explicitly requested.
-	 */
-	conf->reserved_bits = (struct vxlanhdr) {
-		.vx_flags = ~used_bits.vx_flags,
-		.vx_vni = ~used_bits.vx_vni,
-	};
+	if (data[IFLA_VXLAN_RESERVED_BITS]) {
+		struct vxlanhdr reserved_bits;
+
+		if (changelink) {
+			NL_SET_ERR_MSG_ATTR(extack,
+					    data[IFLA_VXLAN_RESERVED_BITS],
+					    "Cannot change reserved_bits");
+			return -EOPNOTSUPP;
+		}
+
+		nla_memcpy(&reserved_bits, data[IFLA_VXLAN_RESERVED_BITS],
+			   sizeof(reserved_bits));
+		if (used_bits.vx_flags & reserved_bits.vx_flags ||
+		    used_bits.vx_vni & reserved_bits.vx_vni) {
+			__be64 ub_be64, rb_be64;
+
+			memcpy(&ub_be64, &used_bits, sizeof(ub_be64));
+			memcpy(&rb_be64, &reserved_bits, sizeof(rb_be64));
+
+			NL_SET_ERR_MSG_ATTR_FMT(extack,
+						data[IFLA_VXLAN_RESERVED_BITS],
+						"Used bits %#018llx cannot overlap reserved bits %#018llx",
+						be64_to_cpu(ub_be64),
+						be64_to_cpu(rb_be64));
+			return -EINVAL;
+		}
+
+		conf->reserved_bits = reserved_bits;
+	} else {
+		/* For backwards compatibility, only allow reserved fields to be
+		 * used by VXLAN extensions if explicitly requested.
+		 */
+		conf->reserved_bits = (struct vxlanhdr) {
+			.vx_flags = ~used_bits.vx_flags,
+			.vx_vni = ~used_bits.vx_vni,
+		};
+	}
+
 	if (data[IFLA_VXLAN_REMCSUM_NOPARTIAL]) {
 		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_REMCSUM_NOPARTIAL,
 				    VXLAN_F_REMCSUM_NOPARTIAL, changelink,
@@ -4516,6 +4548,8 @@ static size_t vxlan_get_size(const struct net_device *dev)
 		nla_total_size(0) + /* IFLA_VXLAN_GPE */
 		nla_total_size(0) + /* IFLA_VXLAN_REMCSUM_NOPARTIAL */
 		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_VNIFILTER */
+		/* IFLA_VXLAN_RESERVED_BITS */
+		nla_total_size(sizeof(struct vxlanhdr)) +
 		0;
 }
 
@@ -4618,6 +4652,11 @@ static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
 		       !!(vxlan->cfg.flags & VXLAN_F_VNIFILTER)))
 		goto nla_put_failure;
 
+	if (nla_put(skb, IFLA_VXLAN_RESERVED_BITS,
+		    sizeof(vxlan->cfg.reserved_bits),
+		    &vxlan->cfg.reserved_bits))
+		goto nla_put_failure;
+
 	return 0;
 
 nla_put_failure:
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 2575e0cd9b48..77730c340c8f 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1394,6 +1394,7 @@ enum {
 	IFLA_VXLAN_VNIFILTER, /* only applicable with COLLECT_METADATA mode */
 	IFLA_VXLAN_LOCALBYPASS,
 	IFLA_VXLAN_LABEL_POLICY, /* IPv6 flow label policy; ifla_vxlan_label_policy */
+	IFLA_VXLAN_RESERVED_BITS,
 	__IFLA_VXLAN_MAX
 };
 #define IFLA_VXLAN_MAX	(__IFLA_VXLAN_MAX - 1)
-- 
2.47.0


