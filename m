Return-Path: <netdev+bounces-231549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C36D9BFA5DB
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 08:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B51653A68BA
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 06:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686B72F28EA;
	Wed, 22 Oct 2025 06:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zsnfni4W"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010046.outbound.protection.outlook.com [52.101.56.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149412F3624
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 06:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761116164; cv=fail; b=syl8HPundWmt++rVcQVxvawK1IaCvCUuk+MGAnIjQRKRCFLDaYQ14iFOBx0petGgkYQYwEdPUVanGtVUzpLeV7IQ/GwF+90J4zZwSH/Hr0EPZO0qRu7M1At7byk2qdw+xMKBwwfeu6Ikm/BLbZjKENCpbcj2vN83/s2Aj3jiF3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761116164; c=relaxed/simple;
	bh=8ZPRFQzVr/3vA26HyCYqV74DUGX3lfsqDOzPXhHcwCQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q9sOuzjaramjfi1E8pIao95hbaGydAxErGd2DtYQbL5UkRsLn9c7Mc5s00YrdnY2slnblU8hyjIfdxJchRxh15EU7+D2/WUQyWC0Ll+zAAhMA3u/8nho6YMtHp+TSovF20AjownXytXwmE6AfnseN+o9EHY9boTHQXUcCs4buxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Zsnfni4W; arc=fail smtp.client-ip=52.101.56.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yWN3IWVT2TKK379JR0E3nu4Y+nthelIWgIDO7dKqvyFKJ+yAYLhAKNq97lxwnpf8knqorEiBNN+TYqxOjR3y7806Qu9C4zuPk5/Yw9CJ5T8GBr2GN5Y7MwsY4M9Y0Z79l2+n5WLkmkqQ1tqa0dCJ8jm5gv7Thmmg9o8luqP0NW6JaIdKwhyIztCp0+UW7mxZTvCdwN7ewrvyImbHWbwEOsrFfx0QJVdexwgoPWhXPVYwuCM/BZon4CQEbZns88JgDYyvlDSo/Bx7tFrM0+bMFDUfoINUdTRHZNHZUs8ezwNlkpVBg+2S7d/ZVEJLeGgs35KCT+I+a2KXx39S+XK8cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SO5wyLGLUuDeWz4do5TWIyQM05xqmOjskbGAjjSHNss=;
 b=sCK2xNe/+juNqmpOQI8tzlO7gDD17eujHF8KG7pKBQ9EVC3QB7UzqmxcUEq6kWTF4bi3VQdZ7oRdoMzAA7kdC8ryAt0TpNf3l/asR/gNtpashp1heh4Ieybxyk3h2Hhy8FhfgJAeEXCpMFBiBqXPjXr3+3ZEOljkAZIlTzWkEWw+8nKaUiSJNDrzY7CnPxrFWIj0dvuVKqx20SDG7XO6csamSVh+KwILqo53+xWxjW1rC8wyyj9cxOOmra8+2tc1wdTXLRF1DQOL3YO2u3MPwwMZeyygqBeufHjc2ZnQdebyNqYpGW9DcCouJmw6dDeeku4yJrtWgBCMA2M/p77QNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SO5wyLGLUuDeWz4do5TWIyQM05xqmOjskbGAjjSHNss=;
 b=Zsnfni4WX9/pvmWaabEzUKtJsxQP65TvtKwi1IknR1K9mawwNfQtzcXC/5B3Sm48cGi1pSnmw8UHxR5Hn4OedP87PMQwJzY4ZAj5fRCzuuHMDnDMRra+krk0zsO05ZXocThyD2+Xw0xk+OvUG78021/q7nuARaXUM3svjboVdJCwlADP6tvA+dgRniH4JBhL8VLgycB/+lkbdC/dla6nXOc8GE/mDmKBindKUYGRJQyeZZkCn77K/kFDxVL5d4l1JDuF4nxAa4pWk2siGRz17eqPxMO9HUJockFgw6Vggngb7QRb8lniRMK8ySeGVp39xaXOriWFRTb6VncAq10ThQ==
Received: from SA1PR05CA0019.namprd05.prod.outlook.com (2603:10b6:806:2d2::26)
 by DS0PR12MB8217.namprd12.prod.outlook.com (2603:10b6:8:f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 06:55:54 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:2d2:cafe::49) by SA1PR05CA0019.outlook.office365.com
 (2603:10b6:806:2d2::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 06:55:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 06:55:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 21 Oct
 2025 23:55:39 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Oct
 2025 23:55:34 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <dsahern@kernel.org>,
	<petrm@nvidia.com>, <willemb@google.com>, <daniel@iogearbox.net>,
	<fw@strlen.de>, <ishaangandhi@gmail.com>, <rbonica@juniper.net>,
	<tom@herbertland.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 2/3] ipv6: icmp: Add RFC 5837 support
Date: Wed, 22 Oct 2025 09:53:48 +0300
Message-ID: <20251022065349.434123-3-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|DS0PR12MB8217:EE_
X-MS-Office365-Filtering-Correlation-Id: 07f9303d-4228-4d30-0315-08de11380b7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7sABUNDct47/EyDNkMWPbg6KuDMpp3mTwKYnvgjlO9RkvpsX6cYymj8cSFgD?=
 =?us-ascii?Q?uxpW0i86rXZn/zvqTJ2tUWxdIH2CPnIhPUPVCPBGdDfK4tQtzYkouSbQJ4r+?=
 =?us-ascii?Q?uegKWQsCOY4ICBTHRffOca9Hhf1Noe56ZB6FTySffdWzLn4pgYir6amwXh4K?=
 =?us-ascii?Q?7OWdDam47eYrPwjycMSf7MZ1cgk8dM+c5ke5gyKN2OwThyfrw1+2v2X6NbkG?=
 =?us-ascii?Q?oLIv2ou4AOuij16heUKse+FOtQGtGppYRkVmpb6z28wYHMPP+II7kuOrzxGL?=
 =?us-ascii?Q?nMneZ5WOTXWhJYm1zGnVG9xKwumpq0XV6zOfM3JlR35GfA3vO4W4r5SeVlQX?=
 =?us-ascii?Q?Hdemq66eJ/29I6ofD4kLW/i8AGPjHqfQ+uft9pCnayswRMyAIrErzdsRN2H1?=
 =?us-ascii?Q?/MOBqUIvoJfILWNZj8h4FV+euNRcwwmtugkRLJuApBuIaaBHU6zhSOv1KoO+?=
 =?us-ascii?Q?LAldY4KZ8D7qgFJvRB3P7q6eCGg1kap/3Gmkx4ACwk0CN+OUZmRv11gRleeB?=
 =?us-ascii?Q?dkWnL7rDCCCMQkK4G4AstNS2jQGuijsOkqwG/uBF36EgvZ9ub/Lc7Idu+Dcc?=
 =?us-ascii?Q?X7QK1gNaQNLwjzupJojR7/+buB0DGY/4AS5BWZUGHIjWhFftJM/0O7m3Ki0f?=
 =?us-ascii?Q?0SZJfuBqKk8VAiLzaHsyXDmPOYufCbgi1bRgq+Ii+xtPATAT3ksajgxSIGHS?=
 =?us-ascii?Q?aOfBkvjbs+RRpqsWozAFs7yqtdoMaN3R9YiiAF35gSvOU8WS5wnq7g6WlKzp?=
 =?us-ascii?Q?fzchgeKa+fcfJkXndHYhs/mof4rS5nN9MM3ZQL3HF5wcTQk6Q9e/JtxY+Utb?=
 =?us-ascii?Q?uq8sxBUm2yCxzg6Sgoq7ROXdg9ZgsCk2tH19rRjJ8/rLsXGt9j1iloeBHe19?=
 =?us-ascii?Q?M3ztnosmS3jzZzbI2oxVIGsrXdfeb6NBvegNS82RNnb7XJuNI+aDQRokk6Ky?=
 =?us-ascii?Q?YsolBQkkWYYmwCW+xN+3BEtUDsfO6JFlN1lKCQhcVKcaYoeu3HhLixiV4DjU?=
 =?us-ascii?Q?JgxCAfpeR33U04BBHGpwQy6xuvhyvMY9OX3pa1wUWgmPXCHvIcZLHwIP8o0c?=
 =?us-ascii?Q?pyXjDYyKZipoh9bffF6bspDo0Cx8LHaYro90wDDedajT88Bgpl4bXLGAeFRU?=
 =?us-ascii?Q?uEXrChvHFhgwSK0AhHxqwXqoOpGDz9OArbBDLbvfpMLiOXZtWs4CKYhb/oBB?=
 =?us-ascii?Q?M5StF/IvftWDfebe/QMyN+v1+ndEh23fI49YaHBd8kBNY0aoQbq7WLZvSI3A?=
 =?us-ascii?Q?YDJqafDUyo0H4ws3Xw4CKeCTxLgXRgMeqhXfeZSacki7lqUeRcb+by296Urr?=
 =?us-ascii?Q?kBlNEPbS9U+OfC1whxuhD2VcJSN4x+whp/Qtcoti6Jms6g1va/1RFmOAtVnB?=
 =?us-ascii?Q?2qNHbwyp0h25YZfiP3KylfowKd8p7fA4UGqeJyRArkXJ+p9Ifu6gy8EljYPe?=
 =?us-ascii?Q?YV405pHIZceUBG0TWcKOYuTEzwxBiCM8dP8ApULCgCtS6d8bEJQFwscirXcQ?=
 =?us-ascii?Q?3AB3lmqlQ1F5Er1K++ncl6Qqn8x6sOPUB9BY7XVCAFwQyydvKrFGawWR60UG?=
 =?us-ascii?Q?IoS0JYA8bi1b4L85VOg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 06:55:54.0593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f9303d-4228-4d30-0315-08de11380b7f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8217

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
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 Documentation/networking/ip-sysctl.rst |  17 ++
 include/net/netns/ipv6.h               |   1 +
 net/core/dev.c                         |   1 +
 net/ipv6/af_inet6.c                    |   1 +
 net/ipv6/icmp.c                        | 213 ++++++++++++++++++++++++-
 5 files changed, 231 insertions(+), 2 deletions(-)

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
index 56c974cf75d1..b2e958a23d4d 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -444,6 +444,192 @@ static int icmp6_iif(const struct sk_buff *skb)
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
@@ -458,7 +644,9 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 	struct ipv6_pinfo *np;
 	const struct in6_addr *saddr = NULL;
 	bool apply_ratelimit = false;
+	struct sk_buff *ext_skb;
 	struct dst_entry *dst;
+	unsigned int room;
 	struct icmp6hdr tmp_hdr;
 	struct flowi6 fl6;
 	struct icmpv6_msg msg;
@@ -612,8 +800,13 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
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
@@ -635,6 +828,8 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 	}
 
 out_dst_release:
+	if (ext_skb)
+		consume_skb(ext_skb);
 	dst_release(dst);
 out_unlock:
 	icmpv6_xmit_unlock(sk);
@@ -1171,6 +1366,10 @@ int icmpv6_err_convert(u8 type, u8 code, int *err)
 EXPORT_SYMBOL(icmpv6_err_convert);
 
 #ifdef CONFIG_SYSCTL
+
+static u32 icmpv6_errors_extension_mask_all =
+	GENMASK_U8(ICMP_ERR_EXT_COUNT - 1, 0);
+
 static struct ctl_table ipv6_icmp_table_template[] = {
 	{
 		.procname	= "ratelimit",
@@ -1216,6 +1415,15 @@ static struct ctl_table ipv6_icmp_table_template[] = {
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
@@ -1233,6 +1441,7 @@ struct ctl_table * __net_init ipv6_icmp_sysctl_init(struct net *net)
 		table[3].data = &net->ipv6.sysctl.icmpv6_echo_ignore_anycast;
 		table[4].data = &net->ipv6.sysctl.icmpv6_ratemask_ptr;
 		table[5].data = &net->ipv6.sysctl.icmpv6_error_anycast_as_unicast;
+		table[6].data = &net->ipv6.sysctl.icmpv6_errors_extension_mask;
 	}
 	return table;
 }
-- 
2.51.0


