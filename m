Return-Path: <netdev+bounces-233099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E917C0C496
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 09:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60D73B74F7
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 08:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1539D2E7BC0;
	Mon, 27 Oct 2025 08:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g9txRzDr"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010056.outbound.protection.outlook.com [52.101.56.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F06F2E7BC3
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 08:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761553481; cv=fail; b=cbyEcGhzH4naci6V+sPG0ePM5bKHbp64CgA1SmFWMBwZNeFj+WNGtD6mSsnxhrmIA6OOmV1cUllzwAGKxKjXU0NxmN/iXgJdwZ3ThK3p/lW68JxVZXkHrV98X3KMburIdwliiUM2tcmhDjRt7Fv3NSnmCOhXG7+fZ4odmyUjwi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761553481; c=relaxed/simple;
	bh=QLOU652K9j7uyPz8bPO3ZLMP3VK8fCAfTLxMmCtfqlQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i3amFW1mWTbd41oA44QstsG3AD8vzms4vl8R1pgAn8e7gksKh04A4QC5XMyI3Y01fj/gbxu5na61jzPFYeQ9JMrb7EOsuP4CLYSzBxnzs3slIktnb66Sgqm4P/DbiYRZCfTGwo55XEfRVvQUY7E9Vo/LByuEDtezH2oM0dmRr5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g9txRzDr; arc=fail smtp.client-ip=52.101.56.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZ2FRzRFEFSjwPxmnlYsUGbLR677D0s9USRgy0cS7YmCy/8++sk6yxSxlxEpE2u7wjqy3m+xkkZF26dVBKhTjEPkR+1X7rUEUScJe7X8Xa4p+tvyvWVebA4RHD7pemvmoCIZha21Oti29Lj6YiQjIjy1h8kTx+rq8eIxbyGqLNuu/NVLzdmLgXtRVvrK6eRqj4iu3gL2VtEYltC4trm9rUnlsG6KIABe0xOv2aHqr2OO736fGyIX+08Bsft6c+CSjYb4ILa927FCMKTJ/XUbsvxt1VKiT7FC8R/NGJbRmam58IfMTSmvVagHMJEFHduFwr9QSyGfMzDg1YnCW9rg2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gvbdr5CIEyt7y7InUqlM7Xyak9dPE6wcp3FJw9azjqU=;
 b=phsG/XUzPTJChVLOnQYqBIIEUmex6TkU66fevqO7dZ1w0PKmN8pHrcV779Y6oYljnz27MEKpPErebe05uR1Rcuhbyo3vLgrQqxePEyexeCWcW7V3I3A/ZsBC+HUU8gshGmCOrYSxjdFzmjjSHow4dKB6Iu0HY+M1brGOA0FIB3CkOOQ7IwRO4Cu2njKJC990eS/T4mHalkp2cD74T3Rv4K1rj9ppTuHRbN3CNHg00tU6AyvXp3z47puvYbc2iRS2Kdgh9OPIZ6M9Hm2jsZPkoBkGd2yTGIYFdx68QpZG1Rj2WMTPTFFpsY5pQ2fkQe3VWi8O9JJZ7rciJz9jSeXrzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gvbdr5CIEyt7y7InUqlM7Xyak9dPE6wcp3FJw9azjqU=;
 b=g9txRzDrVnzPEJNhxiR0zyC5AvuzAVDqOURNELl28sxYtXmFEz6TDHOGMEju82GW25ox6as1hDltfvKtgqNbmOLgSnIqmLL/gn8eZWXjfL3w1GDaCR7psixeWTCJrhplinAy56KZzfCx2dVSD1dR42EIqWZbfhKkdTYqkBDRvi46e7z0VUD1kwTrAtW3MxjgKFSkpMlfoB6OtZPjy9MdVLKAoJhzSm5sScvV7jAgMaAiZcx2T+1SqyGhs6qWQ+YSnX0GnYkYp5NxHGb3x0tbm7tL/AY5JL7HNlT47NwmyaqMArDjV6ehpYGOCZPYeQmZY+4vZor6xNZZGMIfQ3KpyQ==
Received: from BYAPR04CA0024.namprd04.prod.outlook.com (2603:10b6:a03:40::37)
 by CYXPR12MB9388.namprd12.prod.outlook.com (2603:10b6:930:e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Mon, 27 Oct
 2025 08:24:33 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:40:cafe::e8) by BYAPR04CA0024.outlook.office365.com
 (2603:10b6:a03:40::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Mon,
 27 Oct 2025 08:24:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 08:24:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 27 Oct
 2025 01:24:18 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 01:24:13 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <dsahern@kernel.org>,
	<petrm@nvidia.com>, <willemb@google.com>, <daniel@iogearbox.net>,
	<fw@strlen.de>, <ishaangandhi@gmail.com>, <rbonica@juniper.net>,
	<tom@herbertland.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v2 0/3] icmp: Add RFC 5837 support
Date: Mon, 27 Oct 2025 10:22:29 +0200
Message-ID: <20251027082232.232571-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.51.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|CYXPR12MB9388:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c0f8f5-af98-461b-2353-08de153241ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?utejhU0KWGAmr0l8ucCyrLC6dvNB4QB7ziF4P9kTKNK7fOlVnYIoLmf/h7xw?=
 =?us-ascii?Q?1rN5EAtYeqLVJ4tcV9mkZtHTtKD/kSKAZvvaoTHCRvrhrCXvW5C16aO4GTn4?=
 =?us-ascii?Q?679eajjWDMbP3wvoQXXwKK9BcqBIQ6RVwLeZ/4NRo8M/9rtB8J9dKU/8pFxz?=
 =?us-ascii?Q?gbukkGO1gUEQZpeParS4ScJVrX1QRExq/J9RKuQUEToRql0mXZhrtIt9Soc9?=
 =?us-ascii?Q?gwO+o8gJRdWXh/1/VKvFM33iZRRR/vx0Tb493JyUYOgWbfWd3U0ZwPo+ua0O?=
 =?us-ascii?Q?9tGrOBK0a8mJ7L5BoQypU3UU9XPinwpkBJ2gAYyWegti/Od3hDXWCnpElCni?=
 =?us-ascii?Q?XTumntmRJP2wbC5X8W4AZtRX2Ai85827df121gIjHdRUdfINbPyCJExQ0GBT?=
 =?us-ascii?Q?LCqOkE7WyXxw9AwnBuDwCzA1oxPrLJOKQz8f9anGDukLtz4EFhaAHgeR6FYU?=
 =?us-ascii?Q?QJKN7slOH7gO+RjtaBPYX5eshJqpNIZ3j5NqGB1e/TnKPP8avFALjCvNzX/Y?=
 =?us-ascii?Q?70yicZapEcCwOfPis7qCGqgYnc59C/9ks3XiV9CZfcfXYjqYYcjvHyV2BrF7?=
 =?us-ascii?Q?nT6ijPB50BOqdrPsqeuvC5LsYnc0l5L1KPyfyUbo/8NQaQigRM+u7GSommMj?=
 =?us-ascii?Q?WB1Z+sSbu0v4hSDnP2U+MrPMZDjtkMLSSKvpDG7sFso3CYFsQwoSTL3Om7OH?=
 =?us-ascii?Q?rKqLCx9dyOn3tywl51bMm84e3Qyjit43N/lQ4Gwa0VPY3r9r4ki91EjP+2kg?=
 =?us-ascii?Q?p0jvM9z38dvkMk0bFv8E+qAZS0XJO8VeTYjlG8aIBvSwQr9JzpWw4qZjYeR8?=
 =?us-ascii?Q?FnVYJ31+OF8pko++xMLSOILpzYAa6ZdAHlvBN0R3Bhg3NULKDynD8sVmRhOQ?=
 =?us-ascii?Q?Zo3vfdO52EGk8NE79b08FS/sqPlRcLG1EiFPC7Pnv5SzGo+8th7LwBSY8XyZ?=
 =?us-ascii?Q?kSUDl4b1b073ISSunn+K39F140RMZY+Z7E8ovi9+kbQIxHaFByyrUIR6N/lU?=
 =?us-ascii?Q?qmbPXMSwVwlgfdta5IBuMDPg+72xERzWI8XaZH1dD74Y21REqlY6tqiXNiVv?=
 =?us-ascii?Q?52dJwrM/bPFRSF/hiBmIvoWPjL8q2/LjAHhoNnap1f2/yqGhY3P/9FW6J+ST?=
 =?us-ascii?Q?hLgQLUL9OK1DAXjOKFd33NuZjNTaTq9iEbY7Okx/KSlCDJTlq08TdNVVDYd1?=
 =?us-ascii?Q?rQ5YLYJJL7IANT5rWo2l/DabAv9T3bCmXu68EKZiStFSUjizI+vYV30OGXFu?=
 =?us-ascii?Q?ZNdwrmoa5B3fSOU0+ufh3f2aTogedjOz22nD0B7HyBkBy5K5z8JO3dDFMwos?=
 =?us-ascii?Q?P7MRzKcI30SQmeF4V3VOnykKBqu4Z1fOdNnv9EYXqeDoYqQR0BSW9w08QVmR?=
 =?us-ascii?Q?xsJ/GUsX6ELn0YocIZ39Qot7WVUxypR4FT6UaG+rMswHbYdREtfp2ns30twr?=
 =?us-ascii?Q?dJR9Ryqu9QYAEmtgb07/Dk+BT0i6ItTxcJs5lzGxqWfAY83m0r4NBS1sZhAE?=
 =?us-ascii?Q?lwJVOrWjkuiNArAx6XeXDz6CxipEGCJDb2Iiz8ZQAFKdK2Jbv8gygH0F/hH7?=
 =?us-ascii?Q?J9NGfesSuJqHiZhrV6i8f7Y7LVhgWP2AQRM206nh?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 08:24:32.8770
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c0f8f5-af98-461b-2353-08de153241ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9388

tl;dr
=====

This patchset extends certain ICMP error messages (e.g., "Time
Exceeded") with incoming interface information in accordance with RFC
5837 [1]. This is required for more meaningful traceroute results in
unnumbered networks. Like other ICMP settings, the feature is controlled
via a per-{netns, address family} sysctl. The interface and the
implementation are designed to support more ICMP extensions.

Motivation
==========

Over the years, the kernel was extended with the ability to derive the
source IP of ICMP error messages from the interface that received the
datagram which elicited the ICMP error [2][3][4]. This is especially
important for "Time Exceeded" messages as it allows traceroute users to
trace the actual packet path along the network.

The above scheme does not work in unnumbered networks. In these
networks, only the loopback / VRF interface is assigned a global IP
address while router interfaces are assigned IPv6 link-local addresses.
As such, ICMP error messages are generated with a source IP derived from
the loopback / VRF interface, making it impossible to trace the actual
packet path when parallel links exist between routers.

The problem can be solved by implementing the solution proposed by RFC
4884 [5] and RFC 5837. The former defines an ICMP extension structure
that can be appended to selected ICMP messages and carry extension
objects. The latter defines an extension object called the "Interface
Information Object" (IIO) that can carry interface information (e.g.,
name, index, MTU) about interfaces with certain roles such as the
interface that received the datagram which elicited the ICMP error.

The payload of the datagram that elicited the error (potentially padded
/ trimmed) along with the ICMP extension structure will be queued to the
error queue of the originating socket, thereby allowing traceroute
applications to parse and display the information encoded in the ICMP
extension structure. Example:

 # traceroute6 -e 2001:db8:1::3
 traceroute to 2001:db8:1::3 (2001:db8:1::3), 30 hops max, 80 byte packets
  1  2001:db8:1::2 (2001:db8:1::2) <INC:11,"eth1",mtu=1500>  0.214 ms  0.171 ms  0.162 ms
  2  2001:db8:1::3 (2001:db8:1::3) <INC:12,"eth2",mtu=1500>  0.154 ms  0.135 ms  0.127 ms

 # traceroute -e 192.0.2.3
 traceroute to 192.0.2.3 (192.0.2.3), 30 hops max, 60 byte packets
  1  192.0.2.2 (192.0.2.2) <INC:11,"eth1",mtu=1500>  0.191 ms  0.148 ms  0.144 ms
  2  192.0.2.3 (192.0.2.3) <INC:12,"eth2",mtu=1500>  0.137 ms  0.122 ms  0.114 ms

Implementation
==============

As previously stated, the feature is controlled via a per-{netns,
address} sysctl. Specifically, a bit mask where each bit controls the
addition of a different ICMP extension to ICMP error messages.
Currently, only a single value is supported, to append the incoming
interface information.

Key points:

1. Global knob vs finer control. I am not aware of users who require
finer control, but it is possible that some users will want to avoid
appending ICMP extensions when the packet is sent out of a specific
interface (e.g., the management interface) or to a specific subnet. This
can be accomplished via a tc-bpf program that trims the ICMP extension
structure. An example program can be found here [6].

2. Split implementation between IPv4 / IPv6. While the implementation is
currently similar, there are some differences between both address
families. In addition, some extensions (e.g., RFC 8883 [7]) are
IPv6-specific. Given the above and given that the implementation is not
very complex, it makes sense to keep both implementations separate.

3. Compatibility with legacy applications. RFC 4884 from 2007 extended
certain ICMP messages with a length field that encodes the length of the
"original datagram" field, so that applications will be able to tell
where the "original datagram" ends and where the ICMP extension
structure starts.

Before the introduction of the IP{,6}_RECVERR_RFC4884 socket options
[8][9] in 2020 it was impossible for applications to know where the ICMP
extension structure starts and to this day some applications assume that
it starts at offset 128, which is the minimum length of the "original
datagram" field as specified by RFC 4884.

Therefore, in order to be compatible with both legacy and modern
applications, the datagram that elicited the ICMP error is trimmed /
padded to 128 bytes before appending the ICMP extension structure.

This behavior is specifically called out by RFC 4884: "Those wishing to
be backward compatible with non-compliant TRACEROUTE implementations
will include exactly 128 octets" [10].

Note that in 128 bytes we should be able to include enough headers for
the originating node to match the ICMP error message with the relevant
socket. For example, the following headers will be present in the
"original datagram" field when a VXLAN encapsulated IPv6 packet elicits
an ICMP error in an IPv6 underlay: IPv6 (40) | UDP (8) | VXLAN (8) | Eth
(14) | IPv6 (40) | UDP (8). Overall, 118 bytes.

If the 128 bytes limit proves to be insufficient for some use case, we
can consider dedicating a new bit in the previously mentioned sysctl to
allow for more bytes to be included in the "original datagram" field.

4. Extensibility. This patchset adds partial support for a single ICMP
extension. However, the interface and the implementation should be able
to support more extensions, if needed. Examples:

* More interface information objects as part of RFC 5837. We should be
  able to derive the outgoing interface information and nexthop IP from
  the dst entry attached to the packet that elicited the error.

* Node identification object (e.g., hostname / loopback IP) [11].

* Extended Information object which encodes aggregate header limits as
  part of RFC 8883.

A previous proposal from Ishaan Gandhi and Ron Bonica is available here
[12].

Testing
=======

The existing traceroute selftest is extended to test that ICMP
extensions are reported correctly when enabled. Both address families
are tested and with different packet sizes in order to make sure that
trimming / padding works correctly. Tested that packets are parsed
correctly by the IP{,6}_RECVERR_RFC4884 socket options using Willem's
selftest [13].

Changelog
=========

Changes since v1 [14]:

* Patches #1-#2: Added a comment about field ordering and review tags.

* Patch #3: Converted "sysctl" to "echo" when testing the return value.
  Added a check to skip the test if traceroute version is older
  than 2.1.5.

[1] https://datatracker.ietf.org/doc/html/rfc5837
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1c2fb7f93cb20621772bf304f3dba0849942e5db
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fac6fce9bdb59837bb89930c3a92f5e0d1482f0b
[4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4a8c416602d97a4e2073ed563d4d4c7627de19cf
[5] https://datatracker.ietf.org/doc/html/rfc4884
[6] https://gist.github.com/idosch/5013448cdb5e9e060e6bfdc8b433577c
[7] https://datatracker.ietf.org/doc/html/rfc8883
[8] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eba75c587e811d3249c8bd50d22bb2266ccd3c0f
[9] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=01370434df85eb76ecb1527a4466013c4aca2436
[10] https://datatracker.ietf.org/doc/html/rfc4884#section-5.3
[11] https://datatracker.ietf.org/doc/html/draft-ietf-intarea-extended-icmp-nodeid-04
[12] https://lore.kernel.org/netdev/20210317221959.4410-1-ishaangandhi@gmail.com/
[13] https://lore.kernel.org/netdev/aPpMItF35gwpgzZx@shredder/
[14] https://lore.kernel.org/netdev/20251022065349.434123-1-idosch@nvidia.com/

Ido Schimmel (3):
  ipv4: icmp: Add RFC 5837 support
  ipv6: icmp: Add RFC 5837 support
  selftests: traceroute: Add ICMP extensions tests

 Documentation/networking/ip-sysctl.rst    |  34 +++
 include/linux/icmp.h                      |  32 +++
 include/net/netns/ipv4.h                  |   1 +
 include/net/netns/ipv6.h                  |   1 +
 net/core/dev.c                            |   1 +
 net/ipv4/icmp.c                           | 191 ++++++++++++-
 net/ipv4/sysctl_net_ipv4.c                |  11 +
 net/ipv6/af_inet6.c                       |   1 +
 net/ipv6/icmp.c                           | 214 ++++++++++++++-
 tools/testing/selftests/net/traceroute.sh | 313 ++++++++++++++++++++++
 10 files changed, 796 insertions(+), 3 deletions(-)

-- 
2.51.0


