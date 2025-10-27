Return-Path: <netdev+bounces-233100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FF2C0C499
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 09:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE90F19A08C5
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 08:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C382E7BC0;
	Mon, 27 Oct 2025 08:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RMl6mCzR"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010070.outbound.protection.outlook.com [52.101.193.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F93B2E7641
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 08:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761553491; cv=fail; b=OtHzI24CJd7hWlk+hcDnOl3dpcceCNbogub/y4D2cqa9tQOE+NQXrmH7RfBpkrEBTRwsnuyYLo2tTxmPorz2WQlwZ/PHlvW/l6sSzRqynm1jRwbcCtHT/4vLhhjApc4GG4HKRwm/zuL6iDz7WBZU9IPvOMPK2KngeWcpRSFhEnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761553491; c=relaxed/simple;
	bh=abLvuMj3F9tK7q4nMyCvdDSPPsu/A6jyK5wwUw7qV6Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ddgWAqLLpYZmNduDH5sCVqKQHjsGA8k+MyT42rQGHLziMcJFruNShPm9epaBxbpinzYLdnYrGTPb5w++Mvfdi9i7fGf77B7Mp2W+q48unbIHqBSbmBWomuUTiffFJOl/X9/BsHxVhR5LeLF4esxwaedMnmW9jzKE8wzyFNSPAAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RMl6mCzR; arc=fail smtp.client-ip=52.101.193.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lIvaIGLLuUYJx5+uL33dYUQNHUlsbCzTuzHNN1Sz5e5G7t9KyBR9lK1qrGbPOjh75Mz8FbPSOmvIxICKmE2Yi3Ce4wo5yuiRakgfIl2GXgjLh6CKfP8+qF8OqdAwdagxKXHu2D6ANWJiCIfI2yA76HzwjFTa/5zWlBDDEr90atVHwr7DjYg+T0GfCgCsyIiIpX8dklOsGL8Gan0L0s5Zz994l/cPx6fEBmyrlZKAhxvj6CtjkJfc+0P08K2M4cc2R2of/hY/OAii7J31UrvmCu9EUhHEJ5eQkbsZJ2yuCLKaLoXSjzUeH2Dxsivk6reUbBQlFMgVnxX5E3cdiXH0vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vy66yZoqMwlQqgDwHio4osfBngWLEAAwyekFXvpNtBA=;
 b=S+APg8Z9Yiec5zFGPzeNokPIEyrCn23JJz5Ulf/gHWJXB+L18Zg8yLgj2OgN7JwkgSjMZW0r04yQfMTQHLF1Vco4NqXtKJyI6ZClZQPY0tJRqxYhCiKfxUoU/KrrHtey1LBopw9MSTUKUzewbcImCSissftLKgpYTpoYRTYeXY+Ywqva6r3P+zNnqhEHIlmPrfCkD4qbuyUdeXQI/jyG+HXpvNL2CVI8Hmr6MUWnu+OMu0u5rvKwEx+PwiBjVaIeGpKOWgpCg+8UAskJapzeW//b26hnb3vCrbQFDfL1sxWrjtdC2VOp0od0ubF3yap2yuyM53ZczImDKF+5SffpwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vy66yZoqMwlQqgDwHio4osfBngWLEAAwyekFXvpNtBA=;
 b=RMl6mCzRMf9rNeNj7+PzTwv19wAdEoOYIEqKqo5PTIoOBcud+6EreNG38NqBjPK3wSssMB6GEDAiNDd0MoaMDtzyTfSLboy1aPxCf4GQoMBLAzmvw/wW5H7uMIj1a5Rr7HmpmL7KoLl2MpJvQxkyLgkH2f/mg0HdBcbvQOeNGNl74IbBFT8+XS9HpfqAf9GWzs8SZznNxZsBjlUZWX7ARPVTcf5oe+LgCUd71JZ23vpR2rI979I7PYyyr8ueI7fGAPU9yLAOvBsHZgYdtyDY/AwM26mb3L5n3b2lkEtvw03JWmTnjzBM0NOhqxkhuaRQVmAst9wz1dkpmb8M6jliVg==
Received: from BY3PR05CA0022.namprd05.prod.outlook.com (2603:10b6:a03:254::27)
 by IA0PR12MB7750.namprd12.prod.outlook.com (2603:10b6:208:431::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 08:24:38 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::e2) by BY3PR05CA0022.outlook.office365.com
 (2603:10b6:a03:254::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.9 via Frontend Transport; Mon,
 27 Oct 2025 08:24:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 08:24:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 27 Oct
 2025 01:24:22 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 01:24:18 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <dsahern@kernel.org>,
	<petrm@nvidia.com>, <willemb@google.com>, <daniel@iogearbox.net>,
	<fw@strlen.de>, <ishaangandhi@gmail.com>, <rbonica@juniper.net>,
	<tom@herbertland.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v2 1/3] ipv4: icmp: Add RFC 5837 support
Date: Mon, 27 Oct 2025 10:22:30 +0200
Message-ID: <20251027082232.232571-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027082232.232571-1-idosch@nvidia.com>
References: <20251027082232.232571-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|IA0PR12MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: 1582d5cb-5ca3-44fe-cef9-08de153244b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9ZlHxnUTvp5Lzdp8AXeEZWZQt8aKqwfbsZ3nRVCePAhfHxseoD92PGjxSEBv?=
 =?us-ascii?Q?HQDX2cUWwOOdgUJWm5tz22VYoUDZ/21MOBbm8NhMnX9OG8RSjzksA6/it5Pf?=
 =?us-ascii?Q?Mz2aQ/LU8mTiF1/lIW86p0ekKIuHGubMBxCUjGjU83uoLZgZoDujXR14GuFh?=
 =?us-ascii?Q?w5IBRKYEUi06qeXUcHkgrWHEqIkLWuiO+maH8HY96eBtcbcyo1B+nkHVfkQn?=
 =?us-ascii?Q?8/5fkhb1HYSuC3IYE3/TDSbizsN5pn3M+7WkUlo7Nf8up8a6leJNctOtyDqq?=
 =?us-ascii?Q?NHixmif2+BzdyTST8irAQTrApKnKs2qB2TNAcCv45fcmhNoTkcEey0h406SG?=
 =?us-ascii?Q?93unPaMuUeXLP6dpM5Z78RIHY+NdKDmiCf/wJ07o6EHXjfVWHvUNEK5aauTq?=
 =?us-ascii?Q?8Ms1/vALkVK2/lpVPLl48RHYWj7uEEzDUYoTK9S7Ax2CSe0RSp4aRuiBcgqN?=
 =?us-ascii?Q?o5KfNyfPlwyQ/XO5XrPTtO2bxVMBHgiNQN4N1tl235Gow0hYB234XvGUA00b?=
 =?us-ascii?Q?UfYXWyq02Kxk508+y2ozFKqFTM0SpJXQrlxxIilYk4orWWbi+Vh/+ZVTLE1V?=
 =?us-ascii?Q?UcXSnChcCdFnc3zXlOTFCC6W8M2NyP43a8Ioyc8jukbM3LJmACONtFC+cor8?=
 =?us-ascii?Q?OFsdtwgFTXnpTWzW9ZpxC3G798+oY0hSJ/j5rtxMAetaUTFjDESSroukJyB9?=
 =?us-ascii?Q?NbGSFYUWyNGGjmfq9CMrEbqqO5o5T9o+NF//EXrKGDzEUvjIVXpmnqoY8dRd?=
 =?us-ascii?Q?S/xbroIoLrAa8N6dGJeiUDLB/JgvqGIOZdQ6sj4MWh6hSs4xgKQ5UaMZgHX3?=
 =?us-ascii?Q?jDpRdIuSA3J0HIluiq3e8OS97/qXqLJivof3cT3FZcBJi56KsNhdQUy7qjJ7?=
 =?us-ascii?Q?s7K4x8+SdFBF1IDVGLtpej38qAgSfTiM0WYK9JgxUTkP3Dh+T5SbzvF+zoWa?=
 =?us-ascii?Q?ZbW71Wo0FVgJzWUUKpjmSDbMkXWo0zx8rKCT9DcmxUJKkNwP+lAmfoA7c3pg?=
 =?us-ascii?Q?+HgxIlMrkIyMg7b5B721KMH4xrjKNFB1FTBzDQn4M/0aFcTir382mMYIPrdp?=
 =?us-ascii?Q?4N4CBme8+/CBsmtciIUuqQpknmhWT9HAM9Va+J9D9tjWtxbJaTUF8SmdpKi1?=
 =?us-ascii?Q?UgK6+pA/ow5edoKEwt7YxiLMhhIdwK3r80B15PIrtAeYT23H8txz2qb1K/bJ?=
 =?us-ascii?Q?WftG2DHrxPF+QgJvHGJvsrQo2xRMDHOLW/fPRMLFvcVHo8JqGhrv1usy34Ux?=
 =?us-ascii?Q?dSechdXHfW7nKIsT/U0OE3M8RbUkXtk1si09ODtCAqKPuG3bqZ0SnO3yGzAu?=
 =?us-ascii?Q?zbMQoEIaNVJItoKUAKnNE+nT4DjGvh4rrtP/8yKthDAJLofIqMqC9PFO3Dsm?=
 =?us-ascii?Q?yeDVZ+/dn6svHU6leLlwnYNDwDBHclnBWWQ6KFfjU6zf8n24s3apKvpo/mQH?=
 =?us-ascii?Q?ibFLVzqG6fsmeSCK6Y+DXd4F0BVlbEnx5bBY/5lTARlHc1b0WemlpmgS1bRF?=
 =?us-ascii?Q?87w1NFtiwy76QIvcBXBwdyVtJuSiXRhiDBRJA1CTti5KTyNMP3XQ0gVQMWJG?=
 =?us-ascii?Q?ASP9/Jq6yzBn1XH2ypk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 08:24:37.7071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1582d5cb-5ca3-44fe-cef9-08de153244b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7750

Add the ability to append the incoming IP interface information to
ICMPv4 error messages in accordance with RFC 5837 and RFC 4884. This is
required for more meaningful traceroute results in unnumbered networks.

The feature is disabled by default and controlled via a new sysctl
("net.ipv4.icmp_errors_extension_mask") which accepts a bitmask of ICMP
extensions to append to ICMP error messages. Currently, only a single
value is supported, but the interface and the implementation should be
able to support more extensions, if needed.

Clone the skb and copy the relevant data portions before modifying the
skb as the caller of __icmp_send() still owns the skb after the function
returns. This should be fine since by default ICMP error messages are
rate limited to 1000 per second and no more than 1 per second per
specific host.

Trim or pad the packet to 128 bytes before appending the ICMP extension
structure in order to be compatible with legacy applications that assume
that the ICMP extension structure always starts at this offset (the
minimum length specified by RFC 4884).

Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
    v2:
    * Add a comment about field ordering.

 Documentation/networking/ip-sysctl.rst |  17 +++
 include/linux/icmp.h                   |  32 +++++
 include/net/netns/ipv4.h               |   1 +
 net/ipv4/icmp.c                        | 191 ++++++++++++++++++++++++-
 net/ipv4/sysctl_net_ipv4.c             |  11 ++
 5 files changed, 251 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index a06cb99d66dc..ece1187ba0f1 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -1796,6 +1796,23 @@ icmp_errors_use_inbound_ifaddr - BOOLEAN
 
 	Default: 0 (disabled)
 
+icmp_errors_extension_mask - UNSIGNED INTEGER
+	Bitmask of ICMP extensions to append to ICMPv4 error messages
+	("Destination Unreachable", "Time Exceeded" and "Parameter Problem").
+	The original datagram is trimmed / padded to 128 bytes in order to be
+	compatible with applications that do not comply with RFC 4884.
+
+	Possible extensions are:
+
+	==== ==============================================================
+	0x01 Incoming IP interface information according to RFC 5837.
+	     Extension will include the index, IPv4 address (if present),
+	     name and MTU of the IP interface that received the datagram
+	     which elicited the ICMP error.
+	==== ==============================================================
+
+	Default: 0x00 (no extensions)
+
 igmp_max_memberships - INTEGER
 	Change the maximum number of multicast groups we can subscribe to.
 	Default: 20
diff --git a/include/linux/icmp.h b/include/linux/icmp.h
index 0af4d210ee31..043ec5d9c882 100644
--- a/include/linux/icmp.h
+++ b/include/linux/icmp.h
@@ -40,4 +40,36 @@ void ip_icmp_error_rfc4884(const struct sk_buff *skb,
 			   struct sock_ee_data_rfc4884 *out,
 			   int thlen, int off);
 
+/* RFC 4884 */
+#define ICMP_EXT_ORIG_DGRAM_MIN_LEN	128
+#define ICMP_EXT_VERSION_2		2
+
+/* ICMP Extension Object Classes */
+#define ICMP_EXT_OBJ_CLASS_IIO		2	/* RFC 5837 */
+
+/* Interface Information Object - RFC 5837 */
+enum {
+	ICMP_EXT_CTYPE_IIO_ROLE_IIF,
+};
+
+#define ICMP_EXT_CTYPE_IIO_ROLE(ROLE)	((ROLE) << 6)
+#define ICMP_EXT_CTYPE_IIO_MTU		BIT(0)
+#define ICMP_EXT_CTYPE_IIO_NAME		BIT(1)
+#define ICMP_EXT_CTYPE_IIO_IPADDR	BIT(2)
+#define ICMP_EXT_CTYPE_IIO_IFINDEX	BIT(3)
+
+struct icmp_ext_iio_name_subobj {
+	u8 len;
+	char name[IFNAMSIZ];
+};
+
+enum {
+	/* RFC 5837 - Incoming IP Interface Role */
+	ICMP_ERR_EXT_IIO_IIF,
+	/* Add new constants above. Used by "icmp_errors_extension_mask"
+	 * sysctl.
+	 */
+	ICMP_ERR_EXT_COUNT,
+};
+
 #endif	/* _LINUX_ICMP_H */
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 34eb3aecb3f2..0e96c90e56c6 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -135,6 +135,7 @@ struct netns_ipv4 {
 	u8 sysctl_icmp_echo_ignore_broadcasts;
 	u8 sysctl_icmp_ignore_bogus_error_responses;
 	u8 sysctl_icmp_errors_use_inbound_ifaddr;
+	u8 sysctl_icmp_errors_extension_mask;
 	int sysctl_icmp_ratelimit;
 	int sysctl_icmp_ratemask;
 	int sysctl_icmp_msgs_per_sec;
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 1b7fb5d935ed..4abbec2f47ef 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -582,6 +582,185 @@ static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
 	return ERR_PTR(err);
 }
 
+struct icmp_ext_iio_addr4_subobj {
+	__be16 afi;
+	__be16 reserved;
+	__be32 addr4;
+};
+
+static unsigned int icmp_ext_iio_len(void)
+{
+	return sizeof(struct icmp_extobj_hdr) +
+		/* ifIndex */
+		sizeof(__be32) +
+		/* Interface Address Sub-Object */
+		sizeof(struct icmp_ext_iio_addr4_subobj) +
+		/* Interface Name Sub-Object. Length must be a multiple of 4
+		 * bytes.
+		 */
+		ALIGN(sizeof(struct icmp_ext_iio_name_subobj), 4) +
+		/* MTU */
+		sizeof(__be32);
+}
+
+static unsigned int icmp_ext_max_len(u8 ext_objs)
+{
+	unsigned int ext_max_len;
+
+	ext_max_len = sizeof(struct icmp_ext_hdr);
+
+	if (ext_objs & BIT(ICMP_ERR_EXT_IIO_IIF))
+		ext_max_len += icmp_ext_iio_len();
+
+	return ext_max_len;
+}
+
+static __be32 icmp_ext_iio_addr4_find(const struct net_device *dev)
+{
+	struct in_device *in_dev;
+	struct in_ifaddr *ifa;
+
+	in_dev = __in_dev_get_rcu(dev);
+	if (!in_dev)
+		return 0;
+
+	/* It is unclear from RFC 5837 which IP address should be chosen, but
+	 * it makes sense to choose a global unicast address.
+	 */
+	in_dev_for_each_ifa_rcu(ifa, in_dev) {
+		if (READ_ONCE(ifa->ifa_flags) & IFA_F_SECONDARY)
+			continue;
+		if (ifa->ifa_scope != RT_SCOPE_UNIVERSE ||
+		    ipv4_is_multicast(ifa->ifa_address))
+			continue;
+		return ifa->ifa_address;
+	}
+
+	return 0;
+}
+
+static void icmp_ext_iio_iif_append(struct net *net, struct sk_buff *skb,
+				    int iif)
+{
+	struct icmp_ext_iio_name_subobj *name_subobj;
+	struct icmp_extobj_hdr *objh;
+	struct net_device *dev;
+	__be32 data;
+
+	if (!iif)
+		return;
+
+	/* Add the fields in the order specified by RFC 5837. */
+	objh = skb_put(skb, sizeof(*objh));
+	objh->class_num = ICMP_EXT_OBJ_CLASS_IIO;
+	objh->class_type = ICMP_EXT_CTYPE_IIO_ROLE(ICMP_EXT_CTYPE_IIO_ROLE_IIF);
+
+	data = htonl(iif);
+	skb_put_data(skb, &data, sizeof(__be32));
+	objh->class_type |= ICMP_EXT_CTYPE_IIO_IFINDEX;
+
+	rcu_read_lock();
+
+	dev = dev_get_by_index_rcu(net, iif);
+	if (!dev)
+		goto out;
+
+	data = icmp_ext_iio_addr4_find(dev);
+	if (data) {
+		struct icmp_ext_iio_addr4_subobj *addr4_subobj;
+
+		addr4_subobj = skb_put_zero(skb, sizeof(*addr4_subobj));
+		addr4_subobj->afi = htons(ICMP_AFI_IP);
+		addr4_subobj->addr4 = data;
+		objh->class_type |= ICMP_EXT_CTYPE_IIO_IPADDR;
+	}
+
+	name_subobj = skb_put_zero(skb, ALIGN(sizeof(*name_subobj), 4));
+	name_subobj->len = ALIGN(sizeof(*name_subobj), 4);
+	netdev_copy_name(dev, name_subobj->name);
+	objh->class_type |= ICMP_EXT_CTYPE_IIO_NAME;
+
+	data = htonl(READ_ONCE(dev->mtu));
+	skb_put_data(skb, &data, sizeof(__be32));
+	objh->class_type |= ICMP_EXT_CTYPE_IIO_MTU;
+
+out:
+	rcu_read_unlock();
+	objh->length = htons(skb_tail_pointer(skb) - (unsigned char *)objh);
+}
+
+static void icmp_ext_objs_append(struct net *net, struct sk_buff *skb,
+				 u8 ext_objs, int iif)
+{
+	if (ext_objs & BIT(ICMP_ERR_EXT_IIO_IIF))
+		icmp_ext_iio_iif_append(net, skb, iif);
+}
+
+static struct sk_buff *
+icmp_ext_append(struct net *net, struct sk_buff *skb_in, struct icmphdr *icmph,
+		unsigned int room, int iif)
+{
+	unsigned int payload_len, ext_max_len, ext_len;
+	struct icmp_ext_hdr *ext_hdr;
+	struct sk_buff *skb;
+	u8 ext_objs;
+	int nhoff;
+
+	switch (icmph->type) {
+	case ICMP_DEST_UNREACH:
+	case ICMP_TIME_EXCEEDED:
+	case ICMP_PARAMETERPROB:
+		break;
+	default:
+		return NULL;
+	}
+
+	ext_objs = READ_ONCE(net->ipv4.sysctl_icmp_errors_extension_mask);
+	if (!ext_objs)
+		return NULL;
+
+	ext_max_len = icmp_ext_max_len(ext_objs);
+	if (ICMP_EXT_ORIG_DGRAM_MIN_LEN + ext_max_len > room)
+		return NULL;
+
+	skb = skb_clone(skb_in, GFP_ATOMIC);
+	if (!skb)
+		return NULL;
+
+	nhoff = skb_network_offset(skb);
+	payload_len = min(skb->len - nhoff, ICMP_EXT_ORIG_DGRAM_MIN_LEN);
+
+	if (!pskb_network_may_pull(skb, payload_len))
+		goto free_skb;
+
+	if (pskb_trim(skb, nhoff + ICMP_EXT_ORIG_DGRAM_MIN_LEN) ||
+	    __skb_put_padto(skb, nhoff + ICMP_EXT_ORIG_DGRAM_MIN_LEN, false))
+		goto free_skb;
+
+	if (pskb_expand_head(skb, 0, ext_max_len, GFP_ATOMIC))
+		goto free_skb;
+
+	ext_hdr = skb_put_zero(skb, sizeof(*ext_hdr));
+	ext_hdr->version = ICMP_EXT_VERSION_2;
+
+	icmp_ext_objs_append(net, skb, ext_objs, iif);
+
+	/* Do not send an empty extension structure. */
+	ext_len = skb_tail_pointer(skb) - (unsigned char *)ext_hdr;
+	if (ext_len == sizeof(*ext_hdr))
+		goto free_skb;
+
+	ext_hdr->checksum = ip_compute_csum(ext_hdr, ext_len);
+	/* The length of the original datagram in 32-bit words (RFC 4884). */
+	icmph->un.reserved[1] = ICMP_EXT_ORIG_DGRAM_MIN_LEN / sizeof(u32);
+
+	return skb;
+
+free_skb:
+	consume_skb(skb);
+	return NULL;
+}
+
 /*
  *	Send an ICMP message in response to a situation
  *
@@ -601,6 +780,7 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 	struct icmp_bxm icmp_param;
 	struct rtable *rt = skb_rtable(skb_in);
 	bool apply_ratelimit = false;
+	struct sk_buff *ext_skb;
 	struct ipcm_cookie ipc;
 	struct flowi4 fl4;
 	__be32 saddr;
@@ -770,7 +950,12 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 	if (room <= (int)sizeof(struct iphdr))
 		goto ende;
 
-	icmp_param.data_len = skb_in->len - icmp_param.offset;
+	ext_skb = icmp_ext_append(net, skb_in, &icmp_param.data.icmph, room,
+				  parm->iif);
+	if (ext_skb)
+		icmp_param.skb = ext_skb;
+
+	icmp_param.data_len = icmp_param.skb->len - icmp_param.offset;
 	if (icmp_param.data_len > room)
 		icmp_param.data_len = room;
 	icmp_param.head_len = sizeof(struct icmphdr);
@@ -785,6 +970,9 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 	trace_icmp_send(skb_in, type, code);
 
 	icmp_push_reply(sk, &icmp_param, &fl4, &ipc, &rt);
+
+	if (ext_skb)
+		consume_skb(ext_skb);
 ende:
 	ip_rt_put(rt);
 out_unlock:
@@ -1502,6 +1690,7 @@ static int __net_init icmp_sk_init(struct net *net)
 	net->ipv4.sysctl_icmp_ratelimit = 1 * HZ;
 	net->ipv4.sysctl_icmp_ratemask = 0x1818;
 	net->ipv4.sysctl_icmp_errors_use_inbound_ifaddr = 0;
+	net->ipv4.sysctl_icmp_errors_extension_mask = 0;
 	net->ipv4.sysctl_icmp_msgs_per_sec = 1000;
 	net->ipv4.sysctl_icmp_msgs_burst = 50;
 
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 24dbc603cc44..0c7c8f9041cb 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -48,6 +48,8 @@ static int tcp_plb_max_rounds = 31;
 static int tcp_plb_max_cong_thresh = 256;
 static unsigned int tcp_tw_reuse_delay_max = TCP_PAWS_MSL * MSEC_PER_SEC;
 static int tcp_ecn_mode_max = 2;
+static u32 icmp_errors_extension_mask_all =
+	GENMASK_U8(ICMP_ERR_EXT_COUNT - 1, 0);
 
 /* obsolete */
 static int sysctl_tcp_low_latency __read_mostly;
@@ -674,6 +676,15 @@ static struct ctl_table ipv4_net_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE
 	},
+	{
+		.procname	= "icmp_errors_extension_mask",
+		.data		= &init_net.ipv4.sysctl_icmp_errors_extension_mask,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= &icmp_errors_extension_mask_all,
+	},
 	{
 		.procname	= "icmp_ratelimit",
 		.data		= &init_net.ipv4.sysctl_icmp_ratelimit,
-- 
2.51.0


