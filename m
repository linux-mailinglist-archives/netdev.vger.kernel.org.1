Return-Path: <netdev+bounces-233101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC9BC0C49C
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 09:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A82119A09DA
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 08:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5E72E7F11;
	Mon, 27 Oct 2025 08:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bN11CMRy"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010014.outbound.protection.outlook.com [52.101.56.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641062E7BA7
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 08:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761553493; cv=fail; b=f2HlF27iuVXiFNDGbZQ2uDrF4uvg+ltFrqeTKYpoMjRmEintmsQovq/N0jUpJcIoe2qz3XgXgZQasIE+WxK/Ldu6ttnA/tpOqnedDo2hIGEZDRqGOeEE99Wi7rQByIUaMhULfJNFaUR1YTz8sVtVgJPPTIo6Fusqd3edPaPnZ6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761553493; c=relaxed/simple;
	bh=wYegj+OGnw+pvx68izjKqQBHLW13xVm49DPgjmRBQ3o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dhiIVQVNB6OsLrwkCpsZOWCWBWbjHe+tLXR633dLeSIa9EPTBLwPggtgRS8zNLE89nzd8Oi3BpAOF6j7PAZl5Hsbg6nSeXIxNSebpCH+ldgBDYm7uRXEZeMwYmalk7TJL1F3ewM7FjKJDiQVEbWvD30ypVWkY7bl38gReXwpuJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bN11CMRy; arc=fail smtp.client-ip=52.101.56.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ItWwa/sG6gzBB4NVB62n0+jixNjVA98Suv44SzEZjUJ95DSkL7wGfthKtbJ/Btw9WGkvmmldeGtzp6bxccF5cyj1ZYRO/toMpmyoeMsVhykSQ3z41EYdLNgOz56pXIdNsTz1VB5s0/ZaQvtnfp2QX3mJ1vXHQhFU1b/SjIzGnxviUjfm+xDSNGn0CEUJivVEuFeaYahNvUdO1kVMFzYhN9d6E4UXXSC6gJ/9cMd7VO3mdM9WwCHn/1On4g35XzXTjp2KE4b0BTJ2HIXV8oBv8oo1t/P8pPAbyAQsVz5mO2k2fRX7X11xrMxk4eN4QYjPPHa5nQFZN+K0740WJctcog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPr0pYiAcUIL9DMbN1806tof6O0L+Shk62VcYP90fmE=;
 b=qFs9211+rKIJ9gOvwmi3UV6vOF5+zNlS6CmiM5AXxW2N3Ou54VAolNV/DI3US/io3iIP/oUkodg4OA8FBHbHFPZhYhyxWjGMnTDcwrMwK75ndUL0WM04RDQpsO+nO5BORBmgi6qKY0wsQVyXAawVpfS6zpX4KifH5OKWBB4qkGe67FmXjn+K623TD3KC+hL4kL6uzEYpeaHmJM95BTQSoFcdYpxaWgAK7YHvHjnnVb1y1YuUxtkyNl7gZdSOiDuZUeR1AL4Vsp7jUF9rTCzbwmUz8fDLHuLSHrteh1NlBdWULeb+fdgR/Z+bHjT0z1XV8RX4h/IPAeRWBVZ8F6P99w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPr0pYiAcUIL9DMbN1806tof6O0L+Shk62VcYP90fmE=;
 b=bN11CMRyqOIkoTLstXOk9Lit2K0N9ljqPlxb4XPN5B7oQyuO06t1fzJaLaiKoWrvrsLdaRA8WUGUSbnWtgeg9Z2E2NV2zuJIqWd46Qg3j5uwf1qzF2ZkrVN7OUA7CxVmXyBKsg4bkk4x5pi6xBE6dYyLqpNa2Dn47PGDOB/k5c5YCubIevmv5ZomQKSVGRJRv0BOdt0zKrDQZtilblXtOBVzN1mQGIY+pYSpE7nrfB5ZOCjTmhA+J4tB81h6BMehR7S6JLfqGiq2CIdmRELmQwSvWCCo0E8JaAYlRABAznkGBDiZC7h6ceAJQtKdJcZOd2eA9qnEJ9pNb9evVS+wOQ==
Received: from BYAPR04CA0006.namprd04.prod.outlook.com (2603:10b6:a03:40::19)
 by CH2PR12MB9542.namprd12.prod.outlook.com (2603:10b6:610:27d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Mon, 27 Oct
 2025 08:24:43 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:40:cafe::aa) by BYAPR04CA0006.outlook.office365.com
 (2603:10b6:a03:40::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Mon,
 27 Oct 2025 08:24:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 08:24:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 27 Oct
 2025 01:24:27 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 01:24:22 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <dsahern@kernel.org>,
	<petrm@nvidia.com>, <willemb@google.com>, <daniel@iogearbox.net>,
	<fw@strlen.de>, <ishaangandhi@gmail.com>, <rbonica@juniper.net>,
	<tom@herbertland.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v2 2/3] ipv6: icmp: Add RFC 5837 support
Date: Mon, 27 Oct 2025 10:22:31 +0200
Message-ID: <20251027082232.232571-3-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|CH2PR12MB9542:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b762301-dd36-4472-520a-08de15324806
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OxZ9BdMbAaiGJdqCmQWFZAXFy2P1eAv3pHJamt01EfMI4R7pjPWJNFsSSGFa?=
 =?us-ascii?Q?e+euS1ztxwKtacDvuESXji+/HSkmi6z8KEgxFoXhH9m4lcxnuS/pshf1gzaa?=
 =?us-ascii?Q?xAYok3t0pG0XNLf09+E0AewPSHg//J7cn0D+N9MprfjvvPmed4K7vPMJojkp?=
 =?us-ascii?Q?x9fXuvYreVdrFs2l57y5ROJlVRjuiAOH/nnHDg8oObrb6CpRXEBsLcShWzQQ?=
 =?us-ascii?Q?H5BqisT6wXqBj2DrYt+ilTIl6WR8HUr+CB1c7IApStdfskE1aLTePk7yic6R?=
 =?us-ascii?Q?YVltP+AbtGhGXLOAwM48qRmioj1V05qPJg94OCk8ATpEhk617t8G4Alz3PkK?=
 =?us-ascii?Q?Di0VcbuNbYRZN5FM9qweBDshyEpYts5UsMIZ1sjDDApNAu4Zs5224IjhFL3j?=
 =?us-ascii?Q?9QKaZYRiA0eHIVC6ioz/YwKseFcUcYphrZak+CCNIxI7Sh6lHm50W6Jekz5D?=
 =?us-ascii?Q?npNoFWE7YoM4r1xiWGbo7LszZX3le6/T+lFdYYxP2ofw/mZuRcz89To7jTlv?=
 =?us-ascii?Q?LeEhxtRCLXX/Mz28oIMskh21aoVgM6Jr3d5uL3Yv99/HGN36E3IaJjhtI3mh?=
 =?us-ascii?Q?F4F8erJeRssKrGl1tw9qqpp6RdbnJWpDbkPC6Vc/2FJWZBpuHICL2IacBpQ3?=
 =?us-ascii?Q?ckiFQSIt+6gVxRo0/Mlajniq50TPaSUEs/8fgF12VRfwyIrIs0ETWl3pTXyW?=
 =?us-ascii?Q?Z11wD8qdgoi/5y/O6+kzGCpDfE8zM/GgPPWNl0vrljDv/AoDd95wBoTckoDu?=
 =?us-ascii?Q?sxzxU/SR2q8XFe3fUvRvXRy0kcTGIYtp05bvDlw0og0lMDKIoNKyILCqShZX?=
 =?us-ascii?Q?RvbYi4cmc4wSCng7q1aJBAKVDdkjArvtlQ/V+lARzsOpbW8wmCuDeKEm3Y41?=
 =?us-ascii?Q?lxGFvGsWcvM+U5hFPIfXo/jx0gBQKrXqcStrl41u+H04p/Rukj0/hwZIU1q1?=
 =?us-ascii?Q?5jE3cNjtwmJMtgyoXzqnRwjgYQCVb5LO21sir7ZIEjX5yRQz9iwdELIKj8W6?=
 =?us-ascii?Q?XjKhrYn3k5OgHgunsIxhi4uOD7D0U+yiWZq7ZiQH+b++xBvPNa58Hu9Horzj?=
 =?us-ascii?Q?Pu+hMWFQEjhI1FIZ/8zlX/2jCm3ZsXACGH+VRUzyRZAKRLlWZ3bBN0Qp53rU?=
 =?us-ascii?Q?rT7mhxaAv/IGUtL++Zy736thnBQGOtcDkJh3pzPZbCIMFyBbaINBDE8Ky8oX?=
 =?us-ascii?Q?ftJde7O4L+tF7xAkklwGE3lplbIRQb7nvapU/v5OQMWpw9BuOUdjOGE4Dm/y?=
 =?us-ascii?Q?L0Z/N1UG8EzTmvudTnpcvwPV0lRiP+mctPI3efe7C4p8bhQWDIgkTzdDrMEC?=
 =?us-ascii?Q?GU+xqY6mCrt54ppOmB8vRdiYtcnr/5ijW+52e+qITENJZlgt4EPFlfZ9ZAdF?=
 =?us-ascii?Q?TBLKrVRLB4QrooQsWKTkiFsvngPZSRseJFFt1Er9kaxs5JHsHZe8M8RdvZxF?=
 =?us-ascii?Q?aLdHYzCA9IMfuAUGhGpf04h8+VrA+PSWayK9BUWImbTviP94gItgZ8w6Oaw8?=
 =?us-ascii?Q?eFUejIqvDEJ1r6tn2Dh55Bncwnp020MVTIUvAna9hm8pOyhSQhG1vluw0W0+?=
 =?us-ascii?Q?HQB8S6gCMSfFThTeK/Y=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 08:24:43.2832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b762301-dd36-4472-520a-08de15324806
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9542

Add the ability to append the incoming IP interface information to
ICMPv6 error messages in accordance with RFC 5837 and RFC 4884. This is
required for more meaningful traceroute results in unnumbered networks.

The feature is disabled by default and controlled via a new sysctl
("net.ipv6.icmp.errors_extension_mask") which accepts a bitmask of ICMP
extensions to append to ICMP error messages. Currently, only a single
value is supported, but the interface and the implementation should be
able to support more extensions, if needed.

Clone the skb and copy the relevant data portions before modifying the
skb as the caller of icmp6_send() still owns the skb after the function
returns. This should be fine since by default ICMP error messages are
rate limited to 1000 per second and no more than 1 per second per
specific host.

Trim or pad the packet to 128 bytes before appending the ICMP extension
structure in order to be compatible with legacy applications that assume
that the ICMP extension structure always starts at this offset (the
minimum length specified by RFC 4884).

Since commit 20e1954fe238 ("ipv6: RFC 4884 partial support for SIT/GRE
tunnels") it is possible for icmp6_send() to be called with an skb that
already contains ICMP extensions. This can happen when we receive an
ICMPv4 message with extensions from a tunnel and translate it to an
ICMPv6 message towards an IPv6 host in the overlay network. I could not
find an RFC that supports this behavior, but it makes sense to not
overwrite the original extensions that were appended to the packet.
Therefore, avoid appending extensions if the length field in the
provided ICMPv6 header is already filled.

Export netdev_copy_name() using EXPORT_IPV6_MOD_GPL() to make it
available to IPv6 when it is built as a module.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
    v2:
    * Add a comment about field ordering.

 Documentation/networking/ip-sysctl.rst |  17 ++
 include/net/netns/ipv6.h               |   1 +
 net/core/dev.c                         |   1 +
 net/ipv6/af_inet6.c                    |   1 +
 net/ipv6/icmp.c                        | 214 ++++++++++++++++++++++++-
 5 files changed, 232 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index ece1187ba0f1..7cd35bfd39e6 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -3279,6 +3279,23 @@ error_anycast_as_unicast - BOOLEAN
 
 	Default: 0 (disabled)
 
+errors_extension_mask - UNSIGNED INTEGER
+	Bitmask of ICMP extensions to append to ICMPv6 error messages
+	("Destination Unreachable" and "Time Exceeded"). The original datagram
+	is trimmed / padded to 128 bytes in order to be compatible with
+	applications that do not comply with RFC 4884.
+
+	Possible extensions are:
+
+	==== ==============================================================
+	0x01 Incoming IP interface information according to RFC 5837.
+	     Extension will include the index, IPv6 address (if present),
+	     name and MTU of the IP interface that received the datagram
+	     which elicited the ICMP error.
+	==== ==============================================================
+
+	Default: 0x00 (no extensions)
+
 xfrm6_gc_thresh - INTEGER
 	(Obsolete since linux-4.14)
 	The threshold at which we will start garbage collecting for IPv6
diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
index 47dc70d8100a..08d2ecc96e2b 100644
--- a/include/net/netns/ipv6.h
+++ b/include/net/netns/ipv6.h
@@ -56,6 +56,7 @@ struct netns_sysctl_ipv6 {
 	u8 skip_notify_on_dev_down;
 	u8 fib_notify_on_flag_change;
 	u8 icmpv6_error_anycast_as_unicast;
+	u8 icmpv6_errors_extension_mask;
 };
 
 struct netns_ipv6 {
diff --git a/net/core/dev.c b/net/core/dev.c
index 378c2d010faf..e6cc0fbc5e2a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1163,6 +1163,7 @@ void netdev_copy_name(struct net_device *dev, char *name)
 		strscpy(name, dev->name, IFNAMSIZ);
 	} while (read_seqretry(&netdev_rename_lock, seq));
 }
+EXPORT_IPV6_MOD_GPL(netdev_copy_name);
 
 /**
  *	netdev_get_name - get a netdevice name, knowing its ifindex.
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 1b0314644e0c..44d7de1eec4f 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -960,6 +960,7 @@ static int __net_init inet6_net_init(struct net *net)
 	net->ipv6.sysctl.icmpv6_echo_ignore_multicast = 0;
 	net->ipv6.sysctl.icmpv6_echo_ignore_anycast = 0;
 	net->ipv6.sysctl.icmpv6_error_anycast_as_unicast = 0;
+	net->ipv6.sysctl.icmpv6_errors_extension_mask = 0;
 
 	/* By default, rate limit error messages.
 	 * Except for pmtu discovery, it would break it.
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 56c974cf75d1..5d2f90babaa5 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -444,6 +444,193 @@ static int icmp6_iif(const struct sk_buff *skb)
 	return icmp6_dev(skb)->ifindex;
 }
 
+struct icmp6_ext_iio_addr6_subobj {
+	__be16 afi;
+	__be16 reserved;
+	struct in6_addr addr6;
+};
+
+static unsigned int icmp6_ext_iio_len(void)
+{
+	return sizeof(struct icmp_extobj_hdr) +
+		/* ifIndex */
+		sizeof(__be32) +
+		/* Interface Address Sub-Object */
+		sizeof(struct icmp6_ext_iio_addr6_subobj) +
+		/* Interface Name Sub-Object. Length must be a multiple of 4
+		 * bytes.
+		 */
+		ALIGN(sizeof(struct icmp_ext_iio_name_subobj), 4) +
+		/* MTU */
+		sizeof(__be32);
+}
+
+static unsigned int icmp6_ext_max_len(u8 ext_objs)
+{
+	unsigned int ext_max_len;
+
+	ext_max_len = sizeof(struct icmp_ext_hdr);
+
+	if (ext_objs & BIT(ICMP_ERR_EXT_IIO_IIF))
+		ext_max_len += icmp6_ext_iio_len();
+
+	return ext_max_len;
+}
+
+static struct in6_addr *icmp6_ext_iio_addr6_find(const struct net_device *dev)
+{
+	struct inet6_dev *in6_dev;
+	struct inet6_ifaddr *ifa;
+
+	in6_dev = __in6_dev_get(dev);
+	if (!in6_dev)
+		return NULL;
+
+	/* It is unclear from RFC 5837 which IP address should be chosen, but
+	 * it makes sense to choose a global unicast address.
+	 */
+	list_for_each_entry_rcu(ifa, &in6_dev->addr_list, if_list) {
+		if (ifa->flags & (IFA_F_TENTATIVE | IFA_F_DADFAILED))
+			continue;
+		if (ipv6_addr_type(&ifa->addr) != IPV6_ADDR_UNICAST ||
+		    ipv6_addr_src_scope(&ifa->addr) != IPV6_ADDR_SCOPE_GLOBAL)
+			continue;
+		return &ifa->addr;
+	}
+
+	return NULL;
+}
+
+static void icmp6_ext_iio_iif_append(struct net *net, struct sk_buff *skb,
+				     int iif)
+{
+	struct icmp_ext_iio_name_subobj *name_subobj;
+	struct icmp_extobj_hdr *objh;
+	struct net_device *dev;
+	struct in6_addr *addr6;
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
+	addr6 = icmp6_ext_iio_addr6_find(dev);
+	if (addr6) {
+		struct icmp6_ext_iio_addr6_subobj *addr6_subobj;
+
+		addr6_subobj = skb_put_zero(skb, sizeof(*addr6_subobj));
+		addr6_subobj->afi = htons(ICMP_AFI_IP6);
+		addr6_subobj->addr6 = *addr6;
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
+static void icmp6_ext_objs_append(struct net *net, struct sk_buff *skb,
+				  u8 ext_objs, int iif)
+{
+	if (ext_objs & BIT(ICMP_ERR_EXT_IIO_IIF))
+		icmp6_ext_iio_iif_append(net, skb, iif);
+}
+
+static struct sk_buff *
+icmp6_ext_append(struct net *net, struct sk_buff *skb_in,
+		 struct icmp6hdr *icmp6h, unsigned int room, int iif)
+{
+	unsigned int payload_len, ext_max_len, ext_len;
+	struct icmp_ext_hdr *ext_hdr;
+	struct sk_buff *skb;
+	u8 ext_objs;
+	int nhoff;
+
+	switch (icmp6h->icmp6_type) {
+	case ICMPV6_DEST_UNREACH:
+	case ICMPV6_TIME_EXCEED:
+		break;
+	default:
+		return NULL;
+	}
+
+	/* Do not overwrite existing extensions. This can happen when we
+	 * receive an ICMPv4 message with extensions from a tunnel and
+	 * translate it to an ICMPv6 message towards an IPv6 host in the
+	 * overlay network.
+	 */
+	if (icmp6h->icmp6_datagram_len)
+		return NULL;
+
+	ext_objs = READ_ONCE(net->ipv6.sysctl.icmpv6_errors_extension_mask);
+	if (!ext_objs)
+		return NULL;
+
+	ext_max_len = icmp6_ext_max_len(ext_objs);
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
+	icmp6_ext_objs_append(net, skb, ext_objs, iif);
+
+	/* Do not send an empty extension structure. */
+	ext_len = skb_tail_pointer(skb) - (unsigned char *)ext_hdr;
+	if (ext_len == sizeof(*ext_hdr))
+		goto free_skb;
+
+	ext_hdr->checksum = ip_compute_csum(ext_hdr, ext_len);
+	/* The length of the original datagram in 64-bit words (RFC 4884). */
+	icmp6h->icmp6_datagram_len = ICMP_EXT_ORIG_DGRAM_MIN_LEN / sizeof(u64);
+
+	return skb;
+
+free_skb:
+	consume_skb(skb);
+	return NULL;
+}
+
 /*
  *	Send an ICMP message in response to a packet in error
  */
@@ -458,7 +645,9 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 	struct ipv6_pinfo *np;
 	const struct in6_addr *saddr = NULL;
 	bool apply_ratelimit = false;
+	struct sk_buff *ext_skb;
 	struct dst_entry *dst;
+	unsigned int room;
 	struct icmp6hdr tmp_hdr;
 	struct flowi6 fl6;
 	struct icmpv6_msg msg;
@@ -612,8 +801,13 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 	msg.offset = skb_network_offset(skb);
 	msg.type = type;
 
-	len = skb->len - msg.offset;
-	len = min_t(unsigned int, len, IPV6_MIN_MTU - sizeof(struct ipv6hdr) - sizeof(struct icmp6hdr));
+	room = IPV6_MIN_MTU - sizeof(struct ipv6hdr) - sizeof(struct icmp6hdr);
+	ext_skb = icmp6_ext_append(net, skb, &tmp_hdr, room, parm->iif);
+	if (ext_skb)
+		msg.skb = ext_skb;
+
+	len = msg.skb->len - msg.offset;
+	len = min_t(unsigned int, len, room);
 	if (len < 0) {
 		net_dbg_ratelimited("icmp: len problem [%pI6c > %pI6c]\n",
 				    &hdr->saddr, &hdr->daddr);
@@ -635,6 +829,8 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 	}
 
 out_dst_release:
+	if (ext_skb)
+		consume_skb(ext_skb);
 	dst_release(dst);
 out_unlock:
 	icmpv6_xmit_unlock(sk);
@@ -1171,6 +1367,10 @@ int icmpv6_err_convert(u8 type, u8 code, int *err)
 EXPORT_SYMBOL(icmpv6_err_convert);
 
 #ifdef CONFIG_SYSCTL
+
+static u32 icmpv6_errors_extension_mask_all =
+	GENMASK_U8(ICMP_ERR_EXT_COUNT - 1, 0);
+
 static struct ctl_table ipv6_icmp_table_template[] = {
 	{
 		.procname	= "ratelimit",
@@ -1216,6 +1416,15 @@ static struct ctl_table ipv6_icmp_table_template[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
+	{
+		.procname	= "errors_extension_mask",
+		.data		= &init_net.ipv6.sysctl.icmpv6_errors_extension_mask,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= &icmpv6_errors_extension_mask_all,
+	},
 };
 
 struct ctl_table * __net_init ipv6_icmp_sysctl_init(struct net *net)
@@ -1233,6 +1442,7 @@ struct ctl_table * __net_init ipv6_icmp_sysctl_init(struct net *net)
 		table[3].data = &net->ipv6.sysctl.icmpv6_echo_ignore_anycast;
 		table[4].data = &net->ipv6.sysctl.icmpv6_ratemask_ptr;
 		table[5].data = &net->ipv6.sysctl.icmpv6_error_anycast_as_unicast;
+		table[6].data = &net->ipv6.sysctl.icmpv6_errors_extension_mask;
 	}
 	return table;
 }
-- 
2.51.0


