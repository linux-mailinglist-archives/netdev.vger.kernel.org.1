Return-Path: <netdev+bounces-285176-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFVwDt9F/Gn9NgAAu9opvQ
	(envelope-from <netdev+bounces-285176-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 09:57:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F286E4E44CB
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 09:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E7A90301060F
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 07:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C8037997A;
	Thu,  7 May 2026 07:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eJWQ2zoB"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013040.outbound.protection.outlook.com [40.93.201.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CA934E75E
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 07:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778140626; cv=fail; b=UdUn0cyc/6sWEirJ0TLowoPF4gyYbcWuEBjZqbUEcW0Bu2hmuFAkM13LJq6vYmHbGZILHfoPNpfxN1831Ua300mcD96+JFa+mysS3gcMqPrqDiR+6UB9n/+qbgHmMh8uP1mHfNdhMNf+OnvYrgA+yikHMSQBVmeK2QYpoAVWgjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778140626; c=relaxed/simple;
	bh=syVAQpfplGV3FtbCxwfYO+cmW6VtZ4MRgvNSlj+2qSs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sLWxBZ4LZjSqRwKLjDXKEV09+mjcK7Cr9ncWz1c3Vo99Uwk5tDdGrvprp1Toh1G8MMCUkaKwpdhyQwzrECgYnKg02N9dhO+/bi4aD5vvuu+86nsevkYmujV7pDI5Q9Xfv/dSXTVhGY5JO3NK8/ximdeOp9NYHpmuI0L9IqdsYvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eJWQ2zoB; arc=fail smtp.client-ip=40.93.201.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pUD0dM5/CKFtybbQLIX/aJv92K1zgEDo0sP/VFcmfrfEwwvqG8UKtCCmNGCCsRaf02oNraJrybH65LsUy069EQQ1dnhj4gyDM3FtMpuL3TzzjOGUDhN207ci+py89OTxtL8nZ7IwrJ5cOOqQSddPMpY8mRiQK+oXOJUNEspPVxibHeXQxm6l8tcfvEctdB05OeNrrcwkagX6zonRx4a1MU/fuEtj4iorU/S3YVPdKXfqO+zWYDNC/FDYmfHPPn2qf06k2LUumPkTYYWZjJNzIEGY87UhXYUj/8JSUVmK1+g9SVe0vgIhofOqhgkPuQHeSYc0zvXseoLqGLOMuKrV7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiTIIRDJB604ne0SY0P0lnXrUb5OeHJQJNEcoWGgjUU=;
 b=sc/HgvvI1U2fsFNVT1gNCvwJccordTlhrEnZLvBU6oH1i/cVgawkM65TZMv1IaY//s4k3JqpQApgTAmtXpqpMbX9G/wOupyEVI4SXsScA0DR9mEf8JXiKVhR5EtJteYzOINc+7ZFxBD/BuDwCTNa7y3ywSouus/Yd2EO1Ev1Un+PqXIWbUWtSfHvbalekyg0jrGIPn17CN4dH8iQnlFxlTyEw0YKpJMkNQfO4v6afHZieERpdpuCmBStsAM79l0xqmW1/szMahMfcx7QtC6IuUkl053ttf4FrnDxTOhabiAFy4QfL0CxjSh/UWDB4FXztsKxsl0BK/IYow6OswgfKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiTIIRDJB604ne0SY0P0lnXrUb5OeHJQJNEcoWGgjUU=;
 b=eJWQ2zoBYCqLObnUirKqwMTWxwPWojcL2WW2Cf+j2P630iEeP/KZd5x/jo3M48UDyavd6OI4KAgdLOExgb+4zW8drwpNsuTkC494XNpKxu48PrQLzEnDBX5dcwsSMaF75ZO3+dGvw0y9uzwQ3WPm9ereo5bNEFFntriQfFiau5wn1CLF7aeAtbGZf6H034wkZ59wK2SGZX6GWc9LWclhCqX+mxjebySNA0zInaXdZVuP4gI/1fS4ad3QfNwY11gXotJ0XQQ0X8nDx0LXvJOEMbK3FkExleCiS2Jxw9sgI17AhCiaEFGU8GVwFHaj3p4PW2O3jXrqL1L6qwyUte02Hg==
Received: from MN0P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::29)
 by BN7PPF0D942FA9A.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6c7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Thu, 7 May
 2026 07:56:59 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:531:cafe::36) by MN0P222CA0022.outlook.office365.com
 (2603:10b6:208:531::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.16 via Frontend Transport; Thu,
 7 May 2026 07:56:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 07:56:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 7 May
 2026 00:56:41 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 7 May 2026 00:56:38 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Simon Horman <horms@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH v3 net-next 3/3] ipv4: Add __must_check to nexthop removal functions
Date: Thu, 7 May 2026 10:56:06 +0300
Message-ID: <20260507075606.322405-4-cratiu@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507075606.322405-1-cratiu@nvidia.com>
References: <20260507075606.322405-1-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|BN7PPF0D942FA9A:EE_
X-MS-Office365-Filtering-Correlation-Id: 33b28ec7-3307-499e-1963-08deac0e3775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	T5gf+VVVhn3sOCWUIlYKCQrFFB4hTIJ0GhFcEVV+BLNaBvgWdda/ZyYCytm+7csW/WjLt1PRqfgba9wYEQScLSJKR3uOPxnbZmrpEaZ6UIbYmXy2T3/A9H32wSb2DBF+/7mCxH7/Fw0pYXmJBIpPTqFd850NMAvGBtcRuH768oMP/iIIyfQO6hQQIGzM34mcRxSjEKa6pkWQNlkaxTISA734K1WHzUU28R8dVT9gYy17ZPBKAwVoigZKXAvg9JaVeW6kSQL4EVKKehY6XLYFtm/iSTIfZy++v1XURDeRLZq21Yeegs8Lf/YYebzjx6v+ylJKivwwL0rsyMKgk5uMTgBnTBJLlPwbWhaCtkyqS+lufZeW7z415X9eImr2xzDO45p4kOk4+peGbRplhFOsG2tw8rjfvDpc2oEMK7L+f0i077TvVsKV0pvH+aqZjXY0bXuIaT3/kPORypix3P776T9ndvwgkBil4GjB6+r9i2ffp/yXa7xkSezs5YOR8m8Zc5P5NueQcQmfB3Ht5Q5y5Nhb+LcNBulvlyCj7W5EGzQc13XtWxRUEJe6RlXrMtJ+jzHGDGGu1NMv1V9fP6CnVhQ6eKgW/4QYlJKkgdBgcjAQksHljPX8q+QnF0dmIt8JhPLaah94BLS0zhJFVHwpKmhfVypZAmO6Lq4wR1Y9StSvyTi/ALmnXyLzav1a1ELS+c2+qu+e3JPcdgEiLBsdcnQ7pblqBVxbdspcbVawFsU=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rD7e9gmInACCXHSqItsGrrZ3Ni+DwvP/YfkytFZ1mt0LgUfnZM+hjY25pNure4rtSMKCWrBbPnK7MY7MPlYnkImzJzfv2LDseO1UBjZtUUY4jIyFbTD2CV53CQscObVVHJtwVQzzRu8Hb/U2NFIlD2CMYy4+WG11jIHPec3FiSngrzj16q7O0SGqfvPSEv/XSwjMV/0H7VzfV+Je3TUdxVdGPDh+00l2RKszYArmi6vRzFI/9ZBex9xiIwgzYUK8nfcwJUUdM1DT1oOdNOAxWYGQVsMQGheMyolJ3aVUIUTIBtogWuIuHg+QCBz4J4ptNIi7uEpZjzwDP46sMlefT7oH7PAeB9fy8QlGyW0cPA+kBSO9YM/Dvf7+pb70/hA8LmzBg7HBtoZFsfTMzcNONw0Zwl/AvNzhN7kuHJTjelRiFSngFsQQxjvqwOkAReDl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 07:56:59.1288
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b28ec7-3307-499e-1963-08deac0e3775
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF0D942FA9A
X-Rspamd-Queue-Id: F286E4E44CB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285176-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

These functions return a signal whether FIB flushing is required which
must not be ignored. Use the compiler to help with enforcing this
requirement in the future.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 net/ipv4/nexthop.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 703954c490d0..6205bd57aa85 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -20,8 +20,8 @@
 #define NH_RES_DEFAULT_IDLE_TIMER	(120 * HZ)
 #define NH_RES_DEFAULT_UNBALANCED_TIMER	0	/* No forced rebalancing. */
 
-static bool remove_nexthop(struct net *net, struct nexthop *nh,
-			   struct nl_info *nlinfo);
+static bool __must_check remove_nexthop(struct net *net, struct nexthop *nh,
+					struct nl_info *nlinfo);
 
 #define NH_DEV_HASHBITS  8
 #define NH_DEV_HASHSIZE (1U << NH_DEV_HASHBITS)
@@ -2016,9 +2016,9 @@ static void nh_hthr_group_rebalance(struct nh_group *nhg)
 	}
 }
 
-static bool remove_nh_grp_entry(struct net *net, struct nh_grp_entry *nhge,
-				struct nl_info *nlinfo,
-				struct list_head *deferred_free)
+static bool __must_check
+remove_nh_grp_entry(struct net *net, struct nh_grp_entry *nhge,
+		    struct nl_info *nlinfo, struct list_head *deferred_free)
 {
 	struct nh_grp_entry *nhges, *new_nhges;
 	struct nexthop *nhp = nhge->nh_parent;
@@ -2095,8 +2095,9 @@ static bool remove_nh_grp_entry(struct net *net, struct nh_grp_entry *nhge,
 	return false;
 }
 
-static bool remove_nexthop_from_groups(struct net *net, struct nexthop *nh,
-				       struct nl_info *nlinfo)
+static bool __must_check
+remove_nexthop_from_groups(struct net *net, struct nexthop *nh,
+			   struct nl_info *nlinfo)
 {
 	struct nh_grp_entry *nhge, *tmp;
 	LIST_HEAD(deferred_free);
@@ -2146,7 +2147,8 @@ static void remove_nexthop_group(struct nexthop *nh, struct nl_info *nlinfo)
 }
 
 /* not called for nexthop replace */
-static bool __remove_nexthop_fib(struct net *net, struct nexthop *nh)
+static bool __must_check __remove_nexthop_fib(struct net *net,
+					      struct nexthop *nh)
 {
 	bool need_flush = !list_empty(&nh->fi_list);
 	struct fib6_info *f6i;
@@ -2177,8 +2179,8 @@ static bool __remove_nexthop_fib(struct net *net, struct nexthop *nh)
 	return need_flush;
 }
 
-static bool __remove_nexthop(struct net *net, struct nexthop *nh,
-			     struct nl_info *nlinfo)
+static bool __must_check __remove_nexthop(struct net *net, struct nexthop *nh,
+					  struct nl_info *nlinfo)
 {
 	bool need_flush = __remove_nexthop_fib(net, nh);
 
@@ -2197,8 +2199,8 @@ static bool __remove_nexthop(struct net *net, struct nexthop *nh,
 	return need_flush;
 }
 
-static bool remove_nexthop(struct net *net, struct nexthop *nh,
-			   struct nl_info *nlinfo)
+static bool __must_check remove_nexthop(struct net *net, struct nexthop *nh,
+					struct nl_info *nlinfo)
 {
 	bool need_flush;
 
-- 
2.53.0


