Return-Path: <netdev+bounces-98994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 909978D3562
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 13:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FFF8289D1A
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 11:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C2917B432;
	Wed, 29 May 2024 11:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uhc2tI8j"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732C016ABEE
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 11:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716981696; cv=fail; b=G5Kw0LIz+NfwzpxJYQRlFoP4tjtS7/hQOYmmeXRQac/NGV4+6gNkUep45YFJ0ibC+UzveBx8UTKBNBbL9kkPYtkDPElUl60tcEKq/Vsq8/tEtAmC7b3hFo3YJQIh3NCl8U7dOetmat3C5X/nPmkTilNlmFDP6VVRaGLL2qDJTV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716981696; c=relaxed/simple;
	bh=Mkp20AOYvdVoC/PDwzRksUhD8i0/unOgNFRlVSMkSQA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HQvmlZ5FfAbONNGpsnJMM61wy8WGOc7sZoUYFWBiFkVPQhtpOSFgTW/iIcY4cjv1q11TykfJ/8fK4Gysb2kHOLFELXdlEJsbV5zidf/n4JMrmZSXUs6EbIKoSoB9VvDSPG5YJDaL1VVp15TFX5qm9BNMnhgbnQPfl69RuVP58xI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uhc2tI8j; arc=fail smtp.client-ip=40.107.93.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7t3PIu3RpN37k0mbCg98WjeHl2hvortGsFv4dCc42+PHpUFIdm5LnXgG+eHEsMv9bg39Cw0AAn2EANDfpEBHl2luDkFmyP4I8QI/ur7cDrfRqN7f7x+Lvnf+nhkdaMOzhZi2Mt8eE44wyMOwkxbiMZ+mavkBk4pAiaEVcfsS7sew4yB/QMAj19Ru9sZQweyB2SD1fWQn6k5YIilGs7cA458acEcPDzrt/ik7nH6tuEtCl4Mcb/QHgjwu8IxOdOVLjIF9cegoyCSa8EcUm0pxAL6NH9jxPxAUtLyDoejd8CDxAJQ27GS3Q8t+WDlwAA8yCg0LkEEIpnQr13W3oPgJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZgYgCu1JLqXiiyYulAcoQisO2Ajfjt3+N0Xuc1NFeo=;
 b=AGU3qhg2zqg+tOpKz6v2NS42vj/Bq+BEnOqsPBqt35eQLvTRo5ensHAWKEsEFk0TQOfMzla5cMGVGbYtrOeBzRNzfMQNw/CgvJAejN86EG20DFp27eeVjWJPwhHDTOSBWJnpELY8KssbWVLWFyfVefXKkrBGVvikPbVeO0Q2MkLUVeWq6S7Zj7m4HfQoaW9ivMnFmp+q7iLCeEWT3c56rkXKMFAvQQvnp6rRNIzfPKLWTfuc+Goarbuy9Ne5rn8hqb+xhhCpugDy6mJuE0a54Uxw79wNfZGsEdhkToksSCaUdJLV87g+7ACv7ELLeJ1W5NhdGVoDHiEwj1MhRPWbgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZgYgCu1JLqXiiyYulAcoQisO2Ajfjt3+N0Xuc1NFeo=;
 b=uhc2tI8jO9Zb7hPKSlBhlhutf3l6805lNFjZ8labWQdL5hssRvEaiowuSyCUyQfs4aHmZDV6GYrba09GB6xPnbUMOpzrhDIsBKCfpkfHr2IJRsUOlvnGLLXZKsRFRw6tpdKmYKshGAVo7KSqbsYMN5b9DvU+ibWrPciCWcuZD506AVBCdhlJJR189s9ZS7JKY+8/FtvrDCclLn7f8uKksJ2cMGv9ze9sw0u2412LoVH3qof6B9+ZUPokbK+0JARLuvYlN/S8yQ0PC6G0fleMYWtPCqoDLQpVbUm7qequo7qdhgIPLtyVWFCBO6vNCGDaOG+sTMKW6rO3wQs+ka8n5A==
Received: from SN6PR16CA0045.namprd16.prod.outlook.com (2603:10b6:805:ca::22)
 by PH8PR12MB6987.namprd12.prod.outlook.com (2603:10b6:510:1be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 29 May
 2024 11:21:30 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:805:ca:cafe::e9) by SN6PR16CA0045.outlook.office365.com
 (2603:10b6:805:ca::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.18 via Frontend
 Transport; Wed, 29 May 2024 11:21:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Wed, 29 May 2024 11:21:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 29 May
 2024 04:21:17 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 29 May
 2024 04:21:13 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>
Subject: [PATCH net-next 1/4] net: ipv4,ipv6: Pass multipath hash computation through a helper
Date: Wed, 29 May 2024 13:18:41 +0200
Message-ID: <20240529111844.13330-2-petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240529111844.13330-1-petrm@nvidia.com>
References: <20240529111844.13330-1-petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|PH8PR12MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: 1749f955-901a-458c-9120-08dc7fd17c3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|36860700004|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qqUy5MHoqkIq1ABZXTS3SqYf5zbiLG84LliTFEdTk6LlLRip4WdjdSVguN9/?=
 =?us-ascii?Q?8WkaQ1l+Itnv5LVccnxNMxgC+bYTPxlrMjYQmfOYGtGciGlwhvkI2XXlTgy9?=
 =?us-ascii?Q?oS4qJOU7Aj1V7wB6Hlvr5Zyi0DOB/cFtJFFpY0Bq9fxlTgLDVUGPH7MVeEuF?=
 =?us-ascii?Q?t1IMhOxrtcpwaOn/peEvisX1B1utmxCTe6IlGMG6A+sixEQvaXOfactDsH63?=
 =?us-ascii?Q?nHY2ysasoOxRZDm2vwDIGSOAjjHdz9cuDN3WkApIpuv03+yqx0VgEcO9cejZ?=
 =?us-ascii?Q?+Rk6Cdj6JdXFdI8SF2SQArKCXnjHv1875BlsRYufXMnMg37F28TQIiV2igkz?=
 =?us-ascii?Q?VTLQHz+RCnjkEpK5njs1gZ8lhsaEMBJs3k8vp+xueulKQo3VIsz69bBm6Niw?=
 =?us-ascii?Q?Y0nTZUNWxcVLfoL89d2IYMn02Yo+Ag1Xacn/jKlUEoSH319QsoUbNrzBXs+Y?=
 =?us-ascii?Q?Q4PjExAivjAhvz1h5Dh/lYrRhrA0U7gIVEi5MX3gAsh9FCCD4elOUikZagBP?=
 =?us-ascii?Q?51Fp+WJTfW1cMKDGQD+KCKsoIslWRZ1Ulbpys8DwqQvhMfz4VJj+sRkJItJL?=
 =?us-ascii?Q?cJFpzgi7S2dcuwWmDbEFxuAipNNH/jelLYvI62NY6z1PArTljrxj57R8yPX2?=
 =?us-ascii?Q?I7yVGkX0T9+YeiRH5G0tIJSSdOfoSmS/LkoF7mgZViNIcakMInMkm0C/ARn5?=
 =?us-ascii?Q?HlCLI6sraQGhPTAAfMFxCy9RWrKrOLDJXPFh0VfA1ZmOCIbOhkn6rQKnSLI6?=
 =?us-ascii?Q?+oSSz1LhGgBTZ4pUP8DYv3J7FpDHQteQ9SFomgtXAgwacAA409tCcaKhbrhd?=
 =?us-ascii?Q?zEjNTSoWX2pgUCII7k9r5W0LfkLZHcwyCfe9RwsBfapJbVjemmdO595IlBFZ?=
 =?us-ascii?Q?Ww59lxhyz231xurmJxNhDF6p9O7H7+z0+9osf3W7PiPuiyk1EP5O4PZO95KZ?=
 =?us-ascii?Q?VcLS5ioUTGvK9qd7SRL8/febKXd/RBXUiHg8/SN7uFtPX+dlHMIqs5lQsgyd?=
 =?us-ascii?Q?uIZ53QxEadHCQbV7NaszC/AErvV7FSfRBQ0Ief1kPny/dUpxb2t933xP8m0m?=
 =?us-ascii?Q?QP+7RL7q4rRlPUHBJD3fhRJmgIGsQ61VW6fcD5ZIwKUw7ETH/A38aPjXgoD4?=
 =?us-ascii?Q?sjf+MpEwn33eI3yGfgBMf82AGEDBENMRBm5x6oagudSZDffq2oL5JI1SlaSU?=
 =?us-ascii?Q?DCgguVXa2/YWmkSyCIDM/8O1nEATcOIjJYP/HdFPBk3Wg67+usJpOXQ7uqYu?=
 =?us-ascii?Q?4vOBcdJxAKC42bs5A9r/62aio6htP4UJO3kzKHG7GbjN4J9jLh3RY5KN3q1C?=
 =?us-ascii?Q?nkHwSQgxPDE+H6aYebkQzwKt3mFK7+9HWbmjTzbr1nBPQhGkcl9p+JGXqU/J?=
 =?us-ascii?Q?eXWmow3cVpxHVsqR9QtIyyubKuIl?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 11:21:28.7532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1749f955-901a-458c-9120-08dc7fd17c3b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6987

The following patches will add a sysctl to control multipath hash seed. On
a system where the seed is not set by hand, the algorithm will need to fall
back to the default system-wide flow hash. In order to centralize this
dispatch, add a helper, fib_multipath_hash_from_keys(), and have all IPv4
and IPv6 route.c invocations of flow_hash_from_keys() go through this
helper instead.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 include/net/ip_fib.h |  7 +++++++
 net/ipv4/route.c     | 12 ++++++------
 net/ipv6/route.c     | 12 ++++++------
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index 9b2f69ba5e49..b8b3c07e8f7b 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -521,6 +521,13 @@ void fib_nhc_update_mtu(struct fib_nh_common *nhc, u32 new, u32 orig);
 int fib_multipath_hash(const struct net *net, const struct flowi4 *fl4,
 		       const struct sk_buff *skb, struct flow_keys *flkeys);
 #endif
+
+static inline u32 fib_multipath_hash_from_keys(const struct net *net,
+					       struct flow_keys *keys)
+{
+	return flow_hash_from_keys(keys);
+}
+
 int fib_check_nh(struct net *net, struct fib_nh *nh, u32 table, u8 scope,
 		 struct netlink_ext_ack *extack);
 void fib_select_multipath(struct fib_result *res, int hash);
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 5fd54103174f..daaccfb37802 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1930,7 +1930,7 @@ static u32 fib_multipath_custom_hash_outer(const struct net *net,
 		hash_keys.ports.dst = keys.ports.dst;
 
 	*p_has_inner = !!(keys.control.flags & FLOW_DIS_ENCAPSULATION);
-	return flow_hash_from_keys(&hash_keys);
+	return fib_multipath_hash_from_keys(net, &hash_keys);
 }
 
 static u32 fib_multipath_custom_hash_inner(const struct net *net,
@@ -1979,7 +1979,7 @@ static u32 fib_multipath_custom_hash_inner(const struct net *net,
 	if (hash_fields & FIB_MULTIPATH_HASH_FIELD_INNER_DST_PORT)
 		hash_keys.ports.dst = keys.ports.dst;
 
-	return flow_hash_from_keys(&hash_keys);
+	return fib_multipath_hash_from_keys(net, &hash_keys);
 }
 
 static u32 fib_multipath_custom_hash_skb(const struct net *net,
@@ -2016,7 +2016,7 @@ static u32 fib_multipath_custom_hash_fl4(const struct net *net,
 	if (hash_fields & FIB_MULTIPATH_HASH_FIELD_DST_PORT)
 		hash_keys.ports.dst = fl4->fl4_dport;
 
-	return flow_hash_from_keys(&hash_keys);
+	return fib_multipath_hash_from_keys(net, &hash_keys);
 }
 
 /* if skb is set it will be used and fl4 can be NULL */
@@ -2037,7 +2037,7 @@ int fib_multipath_hash(const struct net *net, const struct flowi4 *fl4,
 			hash_keys.addrs.v4addrs.src = fl4->saddr;
 			hash_keys.addrs.v4addrs.dst = fl4->daddr;
 		}
-		mhash = flow_hash_from_keys(&hash_keys);
+		mhash = fib_multipath_hash_from_keys(net, &hash_keys);
 		break;
 	case 1:
 		/* skb is currently provided only when forwarding */
@@ -2071,7 +2071,7 @@ int fib_multipath_hash(const struct net *net, const struct flowi4 *fl4,
 			hash_keys.ports.dst = fl4->fl4_dport;
 			hash_keys.basic.ip_proto = fl4->flowi4_proto;
 		}
-		mhash = flow_hash_from_keys(&hash_keys);
+		mhash = fib_multipath_hash_from_keys(net, &hash_keys);
 		break;
 	case 2:
 		memset(&hash_keys, 0, sizeof(hash_keys));
@@ -2102,7 +2102,7 @@ int fib_multipath_hash(const struct net *net, const struct flowi4 *fl4,
 			hash_keys.addrs.v4addrs.src = fl4->saddr;
 			hash_keys.addrs.v4addrs.dst = fl4->daddr;
 		}
-		mhash = flow_hash_from_keys(&hash_keys);
+		mhash = fib_multipath_hash_from_keys(net, &hash_keys);
 		break;
 	case 3:
 		if (skb)
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index bbc2a0dd9314..9d561b9f0f75 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2372,7 +2372,7 @@ static u32 rt6_multipath_custom_hash_outer(const struct net *net,
 		hash_keys.ports.dst = keys.ports.dst;
 
 	*p_has_inner = !!(keys.control.flags & FLOW_DIS_ENCAPSULATION);
-	return flow_hash_from_keys(&hash_keys);
+	return fib_multipath_hash_from_keys(net, &hash_keys);
 }
 
 static u32 rt6_multipath_custom_hash_inner(const struct net *net,
@@ -2421,7 +2421,7 @@ static u32 rt6_multipath_custom_hash_inner(const struct net *net,
 	if (hash_fields & FIB_MULTIPATH_HASH_FIELD_INNER_DST_PORT)
 		hash_keys.ports.dst = keys.ports.dst;
 
-	return flow_hash_from_keys(&hash_keys);
+	return fib_multipath_hash_from_keys(net, &hash_keys);
 }
 
 static u32 rt6_multipath_custom_hash_skb(const struct net *net,
@@ -2460,7 +2460,7 @@ static u32 rt6_multipath_custom_hash_fl6(const struct net *net,
 	if (hash_fields & FIB_MULTIPATH_HASH_FIELD_DST_PORT)
 		hash_keys.ports.dst = fl6->fl6_dport;
 
-	return flow_hash_from_keys(&hash_keys);
+	return fib_multipath_hash_from_keys(net, &hash_keys);
 }
 
 /* if skb is set it will be used and fl6 can be NULL */
@@ -2482,7 +2482,7 @@ u32 rt6_multipath_hash(const struct net *net, const struct flowi6 *fl6,
 			hash_keys.tags.flow_label = (__force u32)flowi6_get_flowlabel(fl6);
 			hash_keys.basic.ip_proto = fl6->flowi6_proto;
 		}
-		mhash = flow_hash_from_keys(&hash_keys);
+		mhash = fib_multipath_hash_from_keys(net, &hash_keys);
 		break;
 	case 1:
 		if (skb) {
@@ -2514,7 +2514,7 @@ u32 rt6_multipath_hash(const struct net *net, const struct flowi6 *fl6,
 			hash_keys.ports.dst = fl6->fl6_dport;
 			hash_keys.basic.ip_proto = fl6->flowi6_proto;
 		}
-		mhash = flow_hash_from_keys(&hash_keys);
+		mhash = fib_multipath_hash_from_keys(net, &hash_keys);
 		break;
 	case 2:
 		memset(&hash_keys, 0, sizeof(hash_keys));
@@ -2551,7 +2551,7 @@ u32 rt6_multipath_hash(const struct net *net, const struct flowi6 *fl6,
 			hash_keys.tags.flow_label = (__force u32)flowi6_get_flowlabel(fl6);
 			hash_keys.basic.ip_proto = fl6->flowi6_proto;
 		}
-		mhash = flow_hash_from_keys(&hash_keys);
+		mhash = fib_multipath_hash_from_keys(net, &hash_keys);
 		break;
 	case 3:
 		if (skb)
-- 
2.45.0


