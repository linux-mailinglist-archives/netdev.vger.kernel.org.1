Return-Path: <netdev+bounces-101908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CC090086E
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 17:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 479F91C20E24
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 15:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C694319A28C;
	Fri,  7 Jun 2024 15:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vaeis4Nn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067B515B134
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 15:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717773298; cv=fail; b=nZX4JIc/v8qai7sVDAaoU571sMiPunIAVzxYIioTLl/jrW2qawAyVl5BAWV5nNimdgjShVM5uBbitjohVJAwtnfQ1Gq9Gn/b6CxpzpB6xjgaDrmsFH2cBBHxooQkbRJhR0xey7FhSXkkc1OBiOYg5Ge4+nx1eL2tbioGU8aoHV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717773298; c=relaxed/simple;
	bh=sJKXc6Ds6xXtX1oM31uU5JNTerUvLiEqeApYzErPBBE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rTdWx5faa1VLKNnqNqr4sbgId61WUJT/mDVBv9r+GPpADCV84Ytozi+W/slUvHl1Zm/0YVieZpPpu5FJobRoF0JEOVc4Np8DM/idLVGMdI3HaMXHxJBcFoUmdemGQjIdCMFdRCz/P1lRaUV6WkVVhZwSRLw8RiHkHLJh/K7zuPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vaeis4Nn; arc=fail smtp.client-ip=40.107.223.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IANUAa/kRdZcaE5UZS/Bbzf/9EG61xoVF/lM0ejt0xuQodqj1+Z1fSs5L/WM7q/wp3RP7EDwlBnQ4Cl7SJLVdtsceqzA3egQdFJAfzIu1TJASgC8Xf9OROIG9VMPyXHlYWXzU0mnaCf0QEPW8uLKipPEjTvWpAumegjw/r8aNYe/VVfQgb8/XvwLT90kO0qDBqxPsqvMHo6gxMjUIbfzUMjLDo31DhX9rHlHarm4t+BNK6kY4h8yhTtFU4krLBSRGwz2N3cyMCbtgsF/A/revd2JAHGSy83L3Lwk1hvwCAcc5Pi2BkGb41rLuMmogxcKIUEUTVxCipCmXzEYFqjxWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L95kBzA3w62b6G9R8rhcWKxSO/6rgs+hVKjG+ZRzyN0=;
 b=Emwc2cwZUnNZVMP5z7Yuj9GaugvRjB9iYpjkgx+jeMgNkt4/uIML54crnOzelfw4HzzXKhbFC+Vzwx+4JJNaoSRYaiTgKQV39FIbV8GxeQaroPnoWJi9sE6vhUAuEseCPdbNpqcj7zZ6N57t3YwaLlbylYH8eURlJUciqpfyVE+Run7mbkS4G3r3UQqYNgi9ehST+9HpvswF+XZ2GDdzOhkqUY5duZx64FkCiSWkAaH3X/GBHMX9nQXxendm7XKKOWo/fEYcmEFIuhfvL8/w3GrzHiG6RfVk2jN5jHwKhKbslNZb7ct/1IcFsImJjGrNEO9fUmkplZpWEGmG+WbYTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L95kBzA3w62b6G9R8rhcWKxSO/6rgs+hVKjG+ZRzyN0=;
 b=Vaeis4NnhnwK8zT2l3hAzeoEEVedKXO7YIFWRc7BJO7yrZDoAc+JCZWmaoBxLKNBmZlL6A6dn+uvMWe1rulBBHGsKgat3sbL+xXzivLK1drynNjLIyRGvwmqiqaEba9zjG9XbVuqnbOO1aVcnE2yYfHjE6W99nLCaQKBt/zhT6qvW6HUg9HIPScCh0P5EuO9DnBlMxzlPTVtwOlw2Cptd47zOMNwebxTmznOIkjwNOYqWQx1SvKrbz1l9rVgdohOyMd9Le6Fwv+aZxcOmy38HgXmY+5p49l4H0TTYSqL412NVBH5/O8Qex1dwizs39AfcA8vXbiHVB2kwK5rX83b1Q==
Received: from BL1PR13CA0169.namprd13.prod.outlook.com (2603:10b6:208:2bd::24)
 by DM4PR12MB6037.namprd12.prod.outlook.com (2603:10b6:8:b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Fri, 7 Jun
 2024 15:14:50 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::db) by BL1PR13CA0169.outlook.office365.com
 (2603:10b6:208:2bd::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.12 via Frontend
 Transport; Fri, 7 Jun 2024 15:14:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Fri, 7 Jun 2024 15:14:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Jun 2024
 08:14:34 -0700
Received: from yaviefel.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Jun 2024
 08:14:30 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v2 1/5] net: ipv4,ipv6: Pass multipath hash computation through a helper
Date: Fri, 7 Jun 2024 17:13:53 +0200
Message-ID: <20240607151357.421181-2-petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240607151357.421181-1-petrm@nvidia.com>
References: <20240607151357.421181-1-petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|DM4PR12MB6037:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dc04971-093b-4fee-ea14-08dc87049338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|82310400017|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wSH8CLx1Bvb70B+iQpieJMPpbrY6CawYaJBzI0+fxaL44A9uvrdqbeUHlSrd?=
 =?us-ascii?Q?ok2F/j+c5fPVSQMHy9yBevLVq+O0GrGmaOkozkiDp3TMMLlJ9QuXo++OOfF9?=
 =?us-ascii?Q?PFzWFybGk8bYtVdCG0TTE1y5iIjdWdmBHpzgPyLfO4lBBIo/2M8JSB5kBWM6?=
 =?us-ascii?Q?B++xm/arlmZ6bpFK8r2h2LPCofpY1dUK5kj3pRduXo1YeBJYxv2zpmA4Lj5Y?=
 =?us-ascii?Q?B8W3sS3okGqsi6A3Yg/WuydgaR1+GowAD5IjyW+MPghKOHnZs6BUhWNuft3N?=
 =?us-ascii?Q?1wdFbzEvhRZX9Q1Kc8L7B6nzm7Er5A2ULy34q2ZXm0TbL7coJ0ZWO0+MOkNy?=
 =?us-ascii?Q?ny0pRSDPXXwt6cYhnSMdwAkq06jDTHmGFP7e2H6SG3k6Ot9zEz9V7LQHuuAB?=
 =?us-ascii?Q?Mw9YcgM8xMP27TBx14BEz7yIb5cAZ1YjGNzaoLr9RF2QBLfT3c81WRek22Mm?=
 =?us-ascii?Q?6UXKZUoMG71N/5MSFRzykrjAkWJNefxreLY0mjArHj0fwlVT+kzC6EIs/0F8?=
 =?us-ascii?Q?GDjKGFS6yD/LNUF0Z9QJThIQyL8Uk5yc+mPhd3GvJSRMWJoW3oYjZJIj8mHe?=
 =?us-ascii?Q?vLeAqeBZTBkmS/+b6002qNzvcf1WIqnO20hti3YRK9dQpvfdp0+jvbMgOHD1?=
 =?us-ascii?Q?tnSvKoIwD60+Zxa7VQgQiPuUqtxW3M+facjLoAl4Ncjle4D4BcpunHrhR+ZG?=
 =?us-ascii?Q?VtrmmsC4Ab7aTPIAAVrBThOvc2nNB7+0OgFuxoN8/OyBnRWKkOed/hhzIvrc?=
 =?us-ascii?Q?lX/RLsMUd4qeBHCc+hG5WSFptgCRFk+bHtPc+ewLZyuN43sKhYdHR8aa/Q1p?=
 =?us-ascii?Q?LynfItGmjvoHVqHsX2hiBKhJ67TuvePL6+J1CQANyFnzZjFEG6sh5bDBTdBm?=
 =?us-ascii?Q?SDo4ea2CEIzKZp6F6HaY7NkA5QX64hOnXGFbcIuUzuMgmUFX7xUYNa+cSPve?=
 =?us-ascii?Q?gWFr4QO2TcXNcMPuAdNuyj5pPXTY7qeLom4Xe1oA22HCFSZXKeQjrd45HAkF?=
 =?us-ascii?Q?dNOH2WqQfJqcojfAM4Lt3/ncdjjdd84hwdjN4Gk/kpeo8nPcM9R9o7/EWFQ9?=
 =?us-ascii?Q?xcw7vaRgONYJT5mi/sK3gPHL9+MW5A/iNCDUOBh8zd7Wrj3vimXFw/SDDghJ?=
 =?us-ascii?Q?6F09VioD69F8CYVteDMk8zvpJjRPwE2AmlzNsLy2UXniiEUyxH5wTBJWtg2v?=
 =?us-ascii?Q?idxhNA9h/LRvnNtDIoZjj447EEl0B6EJeSOVdhXImFxHygf2SnQb7N6zi+M3?=
 =?us-ascii?Q?fqdffR/ZqQUdhy7oDZP13CUuOnria4D9u0QaOkLAqdkMVxrw6QdypjgZZnBU?=
 =?us-ascii?Q?NnEqpQegv0V06OVKCG8/f5E93Of4MzEDzPMu5jB+r3gb+Wvfsk8tWzY7reB9?=
 =?us-ascii?Q?NX3886EPQAxHOxopqlU0BsSuZbSO19OK6SFOsVdnTny9SCuGLQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(82310400017)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 15:14:49.7492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc04971-093b-4fee-ea14-08dc87049338
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6037

The following patches will add a sysctl to control multipath hash
seed. In order to centralize the hash computation, add a helper,
fib_multipath_hash_from_keys(), and have all IPv4 and IPv6 route.c
invocations of flow_hash_from_keys() go through this helper instead.

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
index cb0bdf34ed50..54512acbead7 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1923,7 +1923,7 @@ static u32 fib_multipath_custom_hash_outer(const struct net *net,
 		hash_keys.ports.dst = keys.ports.dst;
 
 	*p_has_inner = !!(keys.control.flags & FLOW_DIS_ENCAPSULATION);
-	return flow_hash_from_keys(&hash_keys);
+	return fib_multipath_hash_from_keys(net, &hash_keys);
 }
 
 static u32 fib_multipath_custom_hash_inner(const struct net *net,
@@ -1972,7 +1972,7 @@ static u32 fib_multipath_custom_hash_inner(const struct net *net,
 	if (hash_fields & FIB_MULTIPATH_HASH_FIELD_INNER_DST_PORT)
 		hash_keys.ports.dst = keys.ports.dst;
 
-	return flow_hash_from_keys(&hash_keys);
+	return fib_multipath_hash_from_keys(net, &hash_keys);
 }
 
 static u32 fib_multipath_custom_hash_skb(const struct net *net,
@@ -2009,7 +2009,7 @@ static u32 fib_multipath_custom_hash_fl4(const struct net *net,
 	if (hash_fields & FIB_MULTIPATH_HASH_FIELD_DST_PORT)
 		hash_keys.ports.dst = fl4->fl4_dport;
 
-	return flow_hash_from_keys(&hash_keys);
+	return fib_multipath_hash_from_keys(net, &hash_keys);
 }
 
 /* if skb is set it will be used and fl4 can be NULL */
@@ -2030,7 +2030,7 @@ int fib_multipath_hash(const struct net *net, const struct flowi4 *fl4,
 			hash_keys.addrs.v4addrs.src = fl4->saddr;
 			hash_keys.addrs.v4addrs.dst = fl4->daddr;
 		}
-		mhash = flow_hash_from_keys(&hash_keys);
+		mhash = fib_multipath_hash_from_keys(net, &hash_keys);
 		break;
 	case 1:
 		/* skb is currently provided only when forwarding */
@@ -2064,7 +2064,7 @@ int fib_multipath_hash(const struct net *net, const struct flowi4 *fl4,
 			hash_keys.ports.dst = fl4->fl4_dport;
 			hash_keys.basic.ip_proto = fl4->flowi4_proto;
 		}
-		mhash = flow_hash_from_keys(&hash_keys);
+		mhash = fib_multipath_hash_from_keys(net, &hash_keys);
 		break;
 	case 2:
 		memset(&hash_keys, 0, sizeof(hash_keys));
@@ -2095,7 +2095,7 @@ int fib_multipath_hash(const struct net *net, const struct flowi4 *fl4,
 			hash_keys.addrs.v4addrs.src = fl4->saddr;
 			hash_keys.addrs.v4addrs.dst = fl4->daddr;
 		}
-		mhash = flow_hash_from_keys(&hash_keys);
+		mhash = fib_multipath_hash_from_keys(net, &hash_keys);
 		break;
 	case 3:
 		if (skb)
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index ad5fff5a210c..1916de615398 100644
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


