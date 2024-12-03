Return-Path: <netdev+bounces-148525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0633F9E1F62
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13A741620C9
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E451F471B;
	Tue,  3 Dec 2024 14:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hwl+/sx1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B91D1F4704
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 14:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236464; cv=fail; b=LMff+1eUKWRqRoG5+5+jXtzOlK48wIbpYVQc9fdz6nDTK0+yVOfLNgo++s7saFA1wDaulPnKW6bb2G6v4dBtZafvB5XvwuCNkSrSt7DeA+V0GmZz2UtdM9fLp+PYTH9AfY2gMvokfRDf9yGsmR4PhKvVXpTMXQfncA72il18kIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236464; c=relaxed/simple;
	bh=T8iT9phBv37iNdABTyeuE8eejXsAiPv0QYh6EYQB7DM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lln9ONr9yjaZQODtSnjetemND5GqDMZgjsqX4K3Bkti5IGqvb37FtM6HFdkkrwdnSBuH/jSkgpdvKD/Ezyi0ewbGvQUFEskWcZvO+jfpArtz1igeuIspp6dB01TpbGD9WgvBWjFuAGaRxIEJcKhLr2qzUpu88FQPWOWemN10gbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hwl+/sx1; arc=fail smtp.client-ip=40.107.243.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tlqCC+xMw/E7p1xsig1rLjz9c8hdATM0q5l1U9H96GofDSoS1qdseBOxRbN9M87hw7ZrhGFdR1UKvytbBb+zAEvCsPSUOa8nVq25IhsUdHLKWXfOLz6n60MOUyPpFroMy0qSRpUNQozElgzNNrcgbvLb6Z1FiubP+jzydFpx3sF7oxMfiu3nv/2xqNaVWY35dC+Z9Xt76PpUA9N3sn6MqJlBHbJc+H8i0Gkmhv55CtD/f9UE9nAhd0FzYTm3JetEsOVz6zZz21gv5G0i9PCLvZaBcStsuaun5q12O5GxmxEpuCh7mbpkUkEAWPoCHZPMCDQm5Bdag6cbr05ooI17FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+emqNud73HhDRSXa6wN83d3Wv270bttByeO81HEQv4A=;
 b=Icnd6DXgseRzU8mfnkasiDy93kjeRx7KKZ9uBWSEZUyXr50xQagLcVK+DYe8pNaYzBkmS8DLO+Wzia2gzKYY0XNOz9kKdgB3thOAbU4YKyk1aXCw+a2OLkRCr3QioVmckIruWW5aMIhg1rvyd3oRJgrMTWIwCQzWeWs140BrFXYDm4nUikq0UYutuI8SxmtNWFHAZQwqZS2PaPTlhbwRKLLzkkvB4KnUUhGk7bhYcQLkYUQo5ziQqtvzxHL2TeFph6W++/ZG1E4/sstXb9Ux6tLteElzy00LrZZQnYwzhpgrqQ7fJKJc+t54sG77YeZUdiilbFmJrHicGwPUNJqY7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+emqNud73HhDRSXa6wN83d3Wv270bttByeO81HEQv4A=;
 b=hwl+/sx1RpjM9+Wlu2/a2YvYz+QpF3d54wOKosaU00X+482Ow451J0u8GTml34ZFAEHpICNMpT4krz1+GMOxOlQ8ctb3238CqIxex91KkhtZPKpaFLhUpf5h07hctgSpB96pE6a9AXL9+llmZ4W1MtKdAn2Ldrs6Y6FF+du9iBBNYvQKmK6UQLNoEbTOUZWW9y/iEwiKqNhNZEGYnk0GDM0lqiaWITi1nKO17hVE7fqpAg/lL034rCwjEsj+KS+uB2PUEEN9NIKi1RYYPFVazf47VPBvV9jNVYJrjQtL257Y3Hh9PNk4hyo9OkbT/SsIHEL19953ixMpj7UJ1rvchA==
Received: from SJ0P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::28)
 by CH3PR12MB8210.namprd12.prod.outlook.com (2603:10b6:610:129::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 14:34:14 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::b6) by SJ0P220CA0018.outlook.office365.com
 (2603:10b6:a03:41b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Tue,
 3 Dec 2024 14:34:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 14:34:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 06:33:54 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 06:33:49 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Menglong Dong <menglong8.dong@gmail.com>, "Guillaume
 Nault" <gnault@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v1 08/11] vxlan: Add an attribute to make VXLAN header validation configurable
Date: Tue, 3 Dec 2024 15:30:34 +0100
Message-ID: <801cb1b16de3ac7138027d0fe9923a9abcfa7612.1733235367.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|CH3PR12MB8210:EE_
X-MS-Office365-Filtering-Correlation-Id: 99a28ff3-d41c-4b36-3adf-08dd13a78f19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+jEr4BlRZbpTLbABhKxyeAdcczAsyLRAXmk9s+hcNWWbgxhvlP1ZhAKPLpjh?=
 =?us-ascii?Q?hIBFGhU5zfr3lDNftYV6oTZxnPkzUX2AIhyxmgfMpPQaeOYEQ15baElKyf7g?=
 =?us-ascii?Q?+GVSO66BNtxiEmoc8vRBdAwsaNfcb5mPxZa+gtPhcRp0AeB8q1y6RK8VTUFb?=
 =?us-ascii?Q?ZZoaAkZltaalcrLAfYB4uvPyxSrwYq6jjjrcDoOm6V0xCWmvXKqI2IyXY6Lr?=
 =?us-ascii?Q?VYLj/E8+DyYRFXBOMqEyhShk/BjNRXRRICKYQhiShEV//xyCT18hxl+xrfA2?=
 =?us-ascii?Q?7zrrd/x49Z4aPWtxjOtiMMpJlkdf7SHpSdF1+lAOozDPuI44QV+DSdc3ejov?=
 =?us-ascii?Q?m+DT1cy7Mu8PjUNVJXYT+ZUBjw77uNQm08NqHtjTgSwsNG1hpinYqBqu+DQU?=
 =?us-ascii?Q?S1t/uLZ4Yoxlu77t+br4Ed1zA5Jee94GDXweJd/GRVgnrOal/F68G2C9N3qU?=
 =?us-ascii?Q?BGioNo9GOX6Nd5J14nzdmOP8LWBoP2jqxjwLsvcSMzjCVSsSUTOhspFU3Im9?=
 =?us-ascii?Q?v83ixmMVvGY9g39kZ6ibouaa6i9dsprv6dU/gkAXsoJyPPN+8wK4IJk2MibU?=
 =?us-ascii?Q?dsrGRNfa9NWqWcEHV/Y9OgTzyX0OxZ/5iffGaGat6t4YvNQnBKmwoNkBQXXJ?=
 =?us-ascii?Q?cQg/bka8c9q5oisc/jQy/PaBtXuZ3SgAqTjjfG22WBbqlU28rGs8JO0Rhvib?=
 =?us-ascii?Q?DR6Zp3+/cK7JvegTW1rKwvwP79nJ0qel04Yu1Pm6DkiIyLE8am66L78I1Sp4?=
 =?us-ascii?Q?ThX+lUSo+qqJUheApB4wCXNg4IQ2qEJza4YEhsk30rlrYBTroSZtplVRNWo+?=
 =?us-ascii?Q?ydUOhYTtkm038tFoLaNsivbgk3viQp+EXx0DQ0yMY1aao0qHEyr6SYPp3oqR?=
 =?us-ascii?Q?L32+8NN3rV1sR8LaUnbhpM0iLH/2ZYWX3sihnBhrOf7YqEFrIRt37qR6pobs?=
 =?us-ascii?Q?ngXiy0D3rRYegLPL6583s+iyJTm2TBF9L5aXtdGk3w4M1RdJcn0xZCmyqnRQ?=
 =?us-ascii?Q?csSma1fYzfTBhuaRmNAqSGFfkXdLioAXnU1xroZ2ESrBKgS8vkkbqSVbtRe9?=
 =?us-ascii?Q?TXFzLfkn1y9ynYIOnu5Hj104IhRfah5PC6cnHdUjBo3BoXNUiZP3ByUOWgv4?=
 =?us-ascii?Q?TOMnU4Qk38uN7Hmw439uXoAKHBFMp9t83TjTsKQIuD93evOWHCQsuk/v/lPy?=
 =?us-ascii?Q?5SMP1UoDgW4mmP+l9BvVOU0OSCaKXlX0PoC9345lsYUGDo0Nx80QhGksF5VZ?=
 =?us-ascii?Q?BvJHjQK+y3oorf33uE5y78mUzUTqQdqu8d+esAC8rPhqFqub+wmxzc2AGNh/?=
 =?us-ascii?Q?LOPz4/qTkv1mkuadtssBSBUHA2UNiEIDucb87Y5XEGIPy0WY/oNCpvtn2qmq?=
 =?us-ascii?Q?+E00w06fs0TF8i08s/xY519R/BLO0gu+pwtz6sYVwiPA/Pe5mZhdvPcYAblA?=
 =?us-ascii?Q?7C8TkUqae79nYl0NjjyPn/DV4Gsc6pYH?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 14:34:13.6490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a28ff3-d41c-4b36-3adf-08dd13a78f19
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8210

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
CC: Andrew Lunn <andrew+netdev@lunn.ch>
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


