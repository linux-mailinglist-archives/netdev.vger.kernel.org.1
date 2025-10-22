Return-Path: <netdev+bounces-231548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD9CBFA5CF
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 08:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 20BD83474C3
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 06:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D032D193F;
	Wed, 22 Oct 2025 06:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HYx3BXpN"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012033.outbound.protection.outlook.com [40.107.209.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C222F2608
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 06:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761116156; cv=fail; b=pMVC8DC4VgR+cCm0aatMHcTB7Hh0BMNtu4K/EdMm6rYttcZSQt5vIt4sAM8EpYNVBrhTfFuqYRsq60+D09mjOIJXhC4J1YP+gx8EhD6aPUOPELsj0Gj6wTcMG0mKN5YoxQFUeYkhPvOoDYSb9cgARden6qbLngjfRrpInnzYG28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761116156; c=relaxed/simple;
	bh=fH05CPkYPXaZJfvWtbem0kQBWQpvZ9FPB2JfxPzZ0hE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n9GtLRU35UkPvvC0nDIUxLtGcXjB9/OjGKhFByqgDFVMawMUI7yskM0+vOcO6rm+IXDn3EKvcOutaAAQfP1ric/Z3A0JOtNjDieDD3Zc7Sj0IrCOv3z9gICC3ASI3QYompYVYVxiOSDn9WdNlRh6hEf9I2bSqq6TPgSUDSVantw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HYx3BXpN; arc=fail smtp.client-ip=40.107.209.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oLn48r94b7IoG9SuysnBO2A3IGmjTc6u4hb2zuGgq/Xn8CSlanKXTJUv7wXH2kUpNgvW4sy3kGYuu9FDvC2lnJtKovX1BObOCYt18W312OfB7XkeHD9DXDEQSCyvYv2CGyFqOQ2JuzQpyVxvWTFPEvVcVwLqDZZgsuXRflV8IS2z5bTQbWpVyTZUU0kK6pE5vQTzhQu7tQUzRLGblwzOxPZRKLOpA6LdOBLZ/SCKfqM5V0+e8DlypmgZyf0ZxYyjnT15siTPJNiYNCYuAOhWYYSRs4Ez4UHYTEKYAMJuMzD3dXfzA2xsYc3iAZCtM/JrS9gVpu4gjZ9snC8HcuNcQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQtv9pGdjNzv09trAdU3LQg3BcRx62bWnZ4adTtss5U=;
 b=Rh64UzqoFLN8L7lc79LtTu5+xgTDSbxBjLG9Zn7l2HtcU4AHGBkrHpASdYQfAdpldxvIFyhWAizllpbN36TBRltmIxduE2H0WB9SC9P1Vq5p/+lXJKm7X9ISChGgxBr94V5lSPiuH+0aH0olB8nKf6tlpqcckycGAOL2rVDvyfUo9sSFxBVi1n3eXDn7Nzn/VUpJl34pK21D49yV9ibcusAvJRAW3rTewGCuhzDl9vC+kdB2+kjAX1mBbCUS8LT4tB4rypvOkZPtEKtIjLMlk1YJbqELjh2cUs9ATxMkfILKu8E5p1ASBj8zHW5WbVhz1ouoXmyqEA6Xa2npEiCNhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQtv9pGdjNzv09trAdU3LQg3BcRx62bWnZ4adTtss5U=;
 b=HYx3BXpNJQn3q38HOYwWH0gslcdc98m4AOmGfvSHnAxP6FwgvPCJk+aPXUrBmA3H3DrYmDA26QEG3o6imLgz/YvkwMvSk8Bl0wzjtfb8l7Atqa0aLMq0Ktix+zW95B7n+X7xd8wdYI5Yp5QJxqlA0thFqYiH1/Q6pB77YIxIsnxbOYK8ssMmadcY83pWIryI7ECNKZoahgAYpG8TTjvMk1fn9NpI3WKx7yU7BNnpCvzxhaV2Hdkil8uhI/HABtN/ow0a5BkdoWJnXNdzCMGE56ljBfFMGX/SEJEYiBeWU0umka16JuLHzyC07mpW6hxgWpITpk/WRifUwamFKizjrw==
Received: from SN6PR04CA0095.namprd04.prod.outlook.com (2603:10b6:805:f2::36)
 by PH0PR12MB7887.namprd12.prod.outlook.com (2603:10b6:510:26d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 06:55:49 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:805:f2:cafe::c2) by SN6PR04CA0095.outlook.office365.com
 (2603:10b6:805:f2::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 06:55:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 06:55:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 21 Oct
 2025 23:55:34 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Oct
 2025 23:55:29 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <dsahern@kernel.org>,
	<petrm@nvidia.com>, <willemb@google.com>, <daniel@iogearbox.net>,
	<fw@strlen.de>, <ishaangandhi@gmail.com>, <rbonica@juniper.net>,
	<tom@herbertland.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 1/3] ipv4: icmp: Add RFC 5837 support
Date: Wed, 22 Oct 2025 09:53:47 +0300
Message-ID: <20251022065349.434123-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022065349.434123-1-idosch@nvidia.com>
References: <20251022065349.434123-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|PH0PR12MB7887:EE_
X-MS-Office365-Filtering-Correlation-Id: 757e8abd-342a-4b4c-d5ba-08de113808a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wu5P8ed+8OTNahBEJbUn73xxFT1eGrs2P8UsCeqDyE3QdEc5OnVWp5GsRzCv?=
 =?us-ascii?Q?EZXIqT7xMSKprYbeQx6/iK+ZrVG58MteVmK2fiuGWcLQi5vfUffuzxPeKpee?=
 =?us-ascii?Q?R8fCQQ5G488h3O/KoAfaogi3q0s7/i1qrNi+Pp5rWOQut3KXA49dwZua6zHQ?=
 =?us-ascii?Q?ePbIIBCJ2KHrqpSAY8yj8RCQxhDChijhIbcmTOCO6HI7bP3lJrOgqpBcaOaH?=
 =?us-ascii?Q?xWgRsV0YYxGHOp4PhGAiOO6chJg2xO14S+3S6YujqvrRKQuMqgoA62scTLog?=
 =?us-ascii?Q?5SRqYq6YCV7s0A/JXCZ8cxB8HxGsxIB6518ylNxbfk1jDKPApTdIC9K8vsvq?=
 =?us-ascii?Q?J5924oVccRBabbsP9Z1b0BQPdkvYVzWgpWu7nE/RoalpHzYFdKF5WLeulIuE?=
 =?us-ascii?Q?3lXGs903V1VpJYEjBDHZFjPisOOMaqUWQK4NSUtN3t/7WsQNCDX3Lug+hZC6?=
 =?us-ascii?Q?4EUjRDPA5lzhhQAdCX+B/xAAU2j76y6rj9WgSd1+WSBi8/sucUwCTjQjhCwz?=
 =?us-ascii?Q?sbLdKxs4jHoQPbD19mMIEmiQxchpsRIe6iKPOhODGGRrnZvEL48AYc47HR7U?=
 =?us-ascii?Q?OOtqNSGZzgqE4R/PshNRBWWiYht3WLCMpoykxi/6DZ1fjFAFK1mYPckT+lcc?=
 =?us-ascii?Q?Zni0hecXisD5s/VsuoXDAexQNxALJjbzYkxa/MSWz73ZCs0R4RYmoTIin/eP?=
 =?us-ascii?Q?nY3HTwhJesEzugXMP0ADxK/WWNrLxaL+dar6CT4eMgtuws8kcUVY5C66D9H7?=
 =?us-ascii?Q?WABX74ejYeDsCzHhJZSULtRJPSSpE5mQ/TxlN3/cCPMvoIA/LfVSMa6RbxLu?=
 =?us-ascii?Q?rUehELPD5vMPvH1Xhuz7hv3mprbFRI2LggGoR9tL6GX4aFsbfntYF/KSoT/U?=
 =?us-ascii?Q?xH3mdPAbXZO++nV8XCjxlI5bFq7fHxb71zHNDOgLuEaLmeTYoZ7V/9TSsaFE?=
 =?us-ascii?Q?iyC8j0O3YHnUSlxaHmiX2qNvDLwswRUMQKPa4L+h11DjquzY6ZB7/SwgB/KX?=
 =?us-ascii?Q?jdGdxWcU7gY31crxA3xa3IpkG0ATjHwBh8Uc1EUewo7baCFJt+EwuJm/friO?=
 =?us-ascii?Q?o1iOilU3ZyycrRyGbD+WXGnT0ocNjTl86aR6eLE+hrV4NodkGRQN6uGKqaMh?=
 =?us-ascii?Q?fya7VeYRpBS4GAAAjDIcC7nvOEGg8J6QHOPNI1xzcdyOktRGUwO1YjjZxV6R?=
 =?us-ascii?Q?Jlp88PR90OB3GMUJyKg3mIb7S1MhaxFeA7wCJaEDcITtA1gastVstNhA6g69?=
 =?us-ascii?Q?5PayVnfXNXtbbsPMPsBZtc3VtWVkUICGUy+HysJGYePihn/pqE+yF/Laxbll?=
 =?us-ascii?Q?TSkMZnaaBKfeNXpFYZnrzb1crDgngocbYXktlnBXghu1KkGe50720sCQtYiS?=
 =?us-ascii?Q?+ePKXN3FuZKog0HIWgCFDyQrxOjsEmBINzLdiIs4dG96Dtb4WlVPsb3pMJ7d?=
 =?us-ascii?Q?FuPQdPofqTZsh9TEYoXU/Hdt5ebqMvxTlbb3O9QE0r9YAYwCWn+quwzIQ8UX?=
 =?us-ascii?Q?oUo6y9KZHMk0cyv36rP7QPxdafUsu2eCl5IiAWSFhkPGyehd61M0R0x3lq6S?=
 =?us-ascii?Q?oqni9Bm25aMZe9rKxFw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 06:55:49.2770
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 757e8abd-342a-4b4c-d5ba-08de113808a6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7887

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
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 Documentation/networking/ip-sysctl.rst |  17 +++
 include/linux/icmp.h                   |  32 +++++
 include/net/netns/ipv4.h               |   1 +
 net/ipv4/icmp.c                        | 190 ++++++++++++++++++++++++-
 net/ipv4/sysctl_net_ipv4.c             |  11 ++
 5 files changed, 250 insertions(+), 1 deletion(-)

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
index 1b7fb5d935ed..44c4deb9d9da 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -582,6 +582,184 @@ static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
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
@@ -601,6 +779,7 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 	struct icmp_bxm icmp_param;
 	struct rtable *rt = skb_rtable(skb_in);
 	bool apply_ratelimit = false;
+	struct sk_buff *ext_skb;
 	struct ipcm_cookie ipc;
 	struct flowi4 fl4;
 	__be32 saddr;
@@ -770,7 +949,12 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
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
@@ -785,6 +969,9 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 	trace_icmp_send(skb_in, type, code);
 
 	icmp_push_reply(sk, &icmp_param, &fl4, &ipc, &rt);
+
+	if (ext_skb)
+		consume_skb(ext_skb);
 ende:
 	ip_rt_put(rt);
 out_unlock:
@@ -1502,6 +1689,7 @@ static int __net_init icmp_sk_init(struct net *net)
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


