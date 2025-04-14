Return-Path: <netdev+bounces-182385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15749A889AB
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 19:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1358F17AF2D
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2072628A1CC;
	Mon, 14 Apr 2025 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jBRf93MN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE9428B4F2
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 17:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744651292; cv=fail; b=Hl4WCkwgckmoiI+PdoVUAiCO9b0kemWWMUnjHkdVIpUXSlJQN7GKLD7kQm/0NqW+sGN6YvYZo0XGC2EWsZV1evEaAXu1P+j9TYir7txVuELoJzSZZF6ozF2JyfcEd71kK9BeabdDBCYdSnthXk+ETvf8UcPB4Yw80Ac9jhDP+sY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744651292; c=relaxed/simple;
	bh=+HxifLBqEGrZrTKltl4tHJGtBFZ2eSt/IDVY27ULdu8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ujOlRO9ocuRpVnPj5FkGJ6YHdBIg8wkqX9InwVLodruV2jS4qouer69fvxwWvNi8MDonrGZLP0bLZN/O/HpuyLExnJ3SfukxuvfD3wW7U7L1ZzPCfBO2oqPikKEh1JKBVBZLgd9sqz5floso+trTiHAalEevL/WXhyYqFh9UYDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jBRf93MN; arc=fail smtp.client-ip=40.107.100.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H7YCgRzVbsmd+OI9paq/gYxqF1QQk4m6GC/I5nnCuP2D60v4Nq52HEGQ708nByjJLcp8aKR32CcLVfxqjOrLLhHwrqAZ9NvqPVExyMfyWHDf6A0g3jlylxouKSkHMVe1sLDgiDdsJrgHn+ciIxIf0wx/W5fuDTQZGzmnMc5tzNrJdMtNXXPC3gsby9ENIvJkYzlS/GSMGHJqZXftpdxK6z8jsX4wf95aLq/pIsogNejKx6H7YCn399bdKLSKxow3TiEJ+pmhhM9mgdxYTOwPs9rRyg1WZT/X6ljtKvpp7wwuqhpqKo5rxDb+/ukfQnS7EK0U6ZbmrhROlP1XQPWs1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AErG3QCpBzUN5OBRZGEuuC5S/KMl+LPx+Okb0tSlKVg=;
 b=cBJsqp1ut+KbiJp1smCkQHklGMhza9HIHZVBWmtiCOArVSxxXjRHC0qVP/ZyrcMb8WKuKl/dfB/FvfBFPHU6zVEpsc6N+LiUHXsEyWuxqJexMYiDL7O/zpwtSTFzrtYX1Dk/uDRvNaNWHxhjmZ1NNB593in+Jx79DXy/npwN007rgA/c3Els58xDXCGnH3wWo+xeQxOdGeq5GtLauJs9nVKockqfTgxa0BF9Se4q/5C2sxBhQ2TWgBcgGsR8QwEXZ/Sfj22PS+vMGLITbMwutmmDN25OY2vjjvdM2Zbodk+ZeNp67cQnDWtfhq0RQFiQ7gsqzLw4ltHK33Nhgs53lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AErG3QCpBzUN5OBRZGEuuC5S/KMl+LPx+Okb0tSlKVg=;
 b=jBRf93MNPtm0SbaRrEbCfiggksT4b3e+dUbvHjo+uTsFkmkxsSHHHi3FLm2Pi3N6hghT+DbMjpQauGEZkThhqtozaQfwmZ7dti/p5LEzTeRYapWd6SogmCnwuH5/O79qbrLPuTY3bCtchZ4SfYGLVVapZUjpvlUaWR8yj4tQsZsA7l7oVRmzukBvjWy6ayYmU3siqnmMa+X0kbyarJ/47PSU8WI1FKRaNrKU5o2MvnAUuTo+75lviTDsEqkCmUUw9/gMoKJWHAaD0j21CPR87dehru3uF7hh/p6J/h4F0zoRK/mU2+TrgApGbw5VKU4IrNZ0sBHd3LnzzbHSaXq+7Q==
Received: from BN1PR12CA0015.namprd12.prod.outlook.com (2603:10b6:408:e1::20)
 by SJ2PR12MB8807.namprd12.prod.outlook.com (2603:10b6:a03:4d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Mon, 14 Apr
 2025 17:21:24 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::a7) by BN1PR12CA0015.outlook.office365.com
 (2603:10b6:408:e1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Mon,
 14 Apr 2025 17:21:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 17:21:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Apr
 2025 10:21:11 -0700
Received: from shredder.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 14 Apr
 2025 10:21:09 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <horms@kernel.org>,
	<hanhuihui5@huawei.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 1/2] net: fib_rules: Fix iif / oif matching on L3 master device
Date: Mon, 14 Apr 2025 20:20:21 +0300
Message-ID: <20250414172022.242991-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414172022.242991-1-idosch@nvidia.com>
References: <20250414172022.242991-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|SJ2PR12MB8807:EE_
X-MS-Office365-Filtering-Correlation-Id: cb4b02b9-d602-40e5-53f1-08dd7b78c814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MOzwys9sFMkB47MMNxaOR2PEAxie+Zdq9nZ6N9H1o5XEDSOSjWpU6HqnLHbY?=
 =?us-ascii?Q?2Z0xPVqFDk70iKaKk4o7nb6dEunKcw54BZC8I4xKjFYdnGcjAojKqi1JTlOP?=
 =?us-ascii?Q?8kyEWWKFAa5+/LfdrByZtoO+KMbl1L0sEIaOHHhyxsgXGChDuhIwvPOHHOxv?=
 =?us-ascii?Q?b70dFyae6TxWUdt04VIsLSpNPzdg3QTTopwOIYtvMtN4P3Z+0SoCgn34GQ7g?=
 =?us-ascii?Q?orM1/1N2xU/3hZc+Louxuv5dk2qUgvnNSCKoDUhXlVv6hBDBp9/jwhzhwhzQ?=
 =?us-ascii?Q?yKyjhvDPVr3CzjAK0bW6/GT2vYQDQs6kYSwNCq0NRMiUfM0NBPCqm59gDy34?=
 =?us-ascii?Q?ouYfwG5Qg0QZYoV2hx43bX2KKMMd8xGi+Mi1Iq2HQfM8ZaZb6L6Zt/Lc6DAh?=
 =?us-ascii?Q?Xz9A4OKWxZx7ISxZl+riioQZSr5dI9kaRbhM4t05TuQ2MkYwVeLRuk2IFxcD?=
 =?us-ascii?Q?I2h2Y9sPSVBqAinFGpH80JESsBTUHG1aB8otYrqBP7LpqmDX1s7iToHU1jPd?=
 =?us-ascii?Q?zj3IMMKsqX+0q1iKjREK8jLPUfE/C1QjL8rqRjNWe2y9FplWj27oPq9QslEB?=
 =?us-ascii?Q?AHI5FymO8ILPZwsRKSFLMyH54LN0RJSKEFtoXMyjjD88FFtixjUHwR3xPwHt?=
 =?us-ascii?Q?nf5xCC+Gv2YGPjJ+mw606EW4WqGuG8TZ+aOk0CzLYAbviySzYCR8vZhAgnu4?=
 =?us-ascii?Q?egNF1jszveO2PiQTiE6v5M6rjCpgN433L1tCnx1LbwzNcc1vRTNh54cQrWLK?=
 =?us-ascii?Q?f16LYwKlsFx/XL+qxjjU2cD3NCE+Jw9DUBE8XY9lMM/h+NQaf8lotYQ5obKc?=
 =?us-ascii?Q?WmGNGBPo1Pn7orkY20wM/mH9P9mgHUSZIH/4SOu2HGOQBAGinZ/fEAFzWYZ3?=
 =?us-ascii?Q?LD0f1plzOqzs4tFhEEdhMOeIESOb9WAC8Fy2S6PXRFoXf509cuEl9nNf3o0s?=
 =?us-ascii?Q?GBN/4WEE1raIutS+tHSV6kKeMCr3gyV4iyaH6m3fMIFPdybI89ru+jGCmME6?=
 =?us-ascii?Q?Zp4wlfOrh5xx2JcTxDOd7qOFgzgmIY5ovW7CjTEgQ+Q12/FPQhsAClIYCiXt?=
 =?us-ascii?Q?VOg9VgBuCDHY6vnWBxLz7STkjNZ85z/nTxSdxxo+53dDSfSFwllpX5I0uuFt?=
 =?us-ascii?Q?8qS5rOVg6MqiRQ3MBaf9oSFVzEclVFnx08Q/+hs42aZCa8P6xQFolgcsSZMV?=
 =?us-ascii?Q?M/xN5Ku5OPpw8ZPGz+fqEL91vu0SkuQ+k8X8lXtt56/76pVD68gTWhFF8OSm?=
 =?us-ascii?Q?aVlb6KTTkQw7gA5BPq6MLpQKjBByCwbfdjMrLZ+FW3hrEpxPmtrxo2NYMitw?=
 =?us-ascii?Q?Gx0Oo2qEoGmWA9np7/uxu5chYrf372kCrtjH82c45N8ZEZMcl7tf7zU84o8A?=
 =?us-ascii?Q?g1paSz1hVcRSxKh5zK/Zpe0Q/aNqvz0FbNDxfPEa4tXFk9MdKYJeecLw5MyX?=
 =?us-ascii?Q?L23UA/7sz5oiuiFSuwXR7qAJ6juMwzWxT7yU6fDvs7nE3WxmzeAq7AiEqjj3?=
 =?us-ascii?Q?x49IqO1RGp6JyRZiA3soSb5NkL2yiK5zZnLj?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 17:21:23.7670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4b02b9-d602-40e5-53f1-08dd7b78c814
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8807

Before commit 40867d74c374 ("net: Add l3mdev index to flow struct and
avoid oif reset for port devices") it was possible to use FIB rules to
match on a L3 domain. This was done by having a FIB rule match on iif /
oif being a L3 master device. It worked because prior to the FIB rule
lookup the iif / oif fields in the flow structure were reset to the
index of the L3 master device to which the input / output device was
enslaved to.

The above scheme made it impossible to match on the original input /
output device. Therefore, cited commit stopped overwriting the iif / oif
fields in the flow structure and instead stored the index of the
enslaving L3 master device in a new field ('flowi_l3mdev') in the flow
structure.

While the change enabled new use cases, it broke the original use case
of matching on a L3 domain. Fix this by interpreting the iif / oif
matching on a L3 master device as a match against the L3 domain. In
other words, if the iif / oif in the FIB rule points to a L3 master
device, compare the provided index against 'flowi_l3mdev' rather than
'flowi_{i,o}if'.

Before cited commit, a FIB rule that matched on 'iif vrf1' would only
match incoming traffic from devices enslaved to 'vrf1'. With the
proposed change (i.e., comparing against 'flowi_l3mdev'), the rule would
also match traffic originating from a socket bound to 'vrf1'. Avoid that
by adding a new flow flag ('FLOWI_FLAG_L3MDEV_OIF') that indicates if
the L3 domain was derived from the output interface or the input
interface (when not set) and take this flag into account when evaluating
the FIB rule against the flow structure.

Avoid unnecessary checks in the data path by detecting that a rule
matches on a L3 master device when the rule is installed and marking it
as such.

Tested using the following script [1].

Output before 40867d74c374 (v5.4.291):

default dev dummy1 table 100 scope link
default dev dummy1 table 200 scope link

Output after 40867d74c374:

default dev dummy1 table 300 scope link
default dev dummy1 table 300 scope link

Output with this patch:

default dev dummy1 table 100 scope link
default dev dummy1 table 200 scope link

[1]
 #!/bin/bash

 ip link add name vrf1 up type vrf table 10
 ip link add name dummy1 up master vrf1 type dummy

 sysctl -wq net.ipv4.conf.all.forwarding=1
 sysctl -wq net.ipv4.conf.all.rp_filter=0

 ip route add table 100 default dev dummy1
 ip route add table 200 default dev dummy1
 ip route add table 300 default dev dummy1

 ip rule add prio 0 oif vrf1 table 100
 ip rule add prio 1 iif vrf1 table 200
 ip rule add prio 2 table 300

 ip route get 192.0.2.1 oif dummy1 fibmatch
 ip route get 192.0.2.1 iif dummy1 from 198.51.100.1 fibmatch

Fixes: 40867d74c374 ("net: Add l3mdev index to flow struct and avoid oif reset for port devices")
Reported-by: hanhuihui <hanhuihui5@huawei.com>
Closes: https://lore.kernel.org/netdev/ec671c4f821a4d63904d0da15d604b75@huawei.com/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 include/net/fib_rules.h |  2 ++
 include/net/flow.h      |  1 +
 include/net/l3mdev.h    | 27 +++++++++++++++++++++++
 net/core/fib_rules.c    | 48 ++++++++++++++++++++++++++++++++++-------
 net/l3mdev/l3mdev.c     |  4 +++-
 5 files changed, 73 insertions(+), 9 deletions(-)

diff --git a/include/net/fib_rules.h b/include/net/fib_rules.h
index 5927910ec06e..6e68e359ad18 100644
--- a/include/net/fib_rules.h
+++ b/include/net/fib_rules.h
@@ -45,6 +45,8 @@ struct fib_rule {
 	struct fib_rule_port_range	dport_range;
 	u16			sport_mask;
 	u16			dport_mask;
+	u8                      iif_is_l3_master;
+	u8                      oif_is_l3_master;
 	struct rcu_head		rcu;
 };
 
diff --git a/include/net/flow.h b/include/net/flow.h
index 335bbc52171c..2a3f0c42f092 100644
--- a/include/net/flow.h
+++ b/include/net/flow.h
@@ -38,6 +38,7 @@ struct flowi_common {
 	__u8	flowic_flags;
 #define FLOWI_FLAG_ANYSRC		0x01
 #define FLOWI_FLAG_KNOWN_NH		0x02
+#define FLOWI_FLAG_L3MDEV_OIF		0x04
 	__u32	flowic_secid;
 	kuid_t  flowic_uid;
 	__u32		flowic_multipath_hash;
diff --git a/include/net/l3mdev.h b/include/net/l3mdev.h
index f7fe796e8429..1eb8dad18f7e 100644
--- a/include/net/l3mdev.h
+++ b/include/net/l3mdev.h
@@ -59,6 +59,20 @@ int l3mdev_ifindex_lookup_by_table_id(enum l3mdev_type l3type, struct net *net,
 int l3mdev_fib_rule_match(struct net *net, struct flowi *fl,
 			  struct fib_lookup_arg *arg);
 
+static inline
+bool l3mdev_fib_rule_iif_match(const struct flowi *fl, int iifindex)
+{
+	return !(fl->flowi_flags & FLOWI_FLAG_L3MDEV_OIF) &&
+	       fl->flowi_l3mdev == iifindex;
+}
+
+static inline
+bool l3mdev_fib_rule_oif_match(const struct flowi *fl, int oifindex)
+{
+	return fl->flowi_flags & FLOWI_FLAG_L3MDEV_OIF &&
+	       fl->flowi_l3mdev == oifindex;
+}
+
 void l3mdev_update_flow(struct net *net, struct flowi *fl);
 
 int l3mdev_master_ifindex_rcu(const struct net_device *dev);
@@ -327,6 +341,19 @@ int l3mdev_fib_rule_match(struct net *net, struct flowi *fl,
 {
 	return 1;
 }
+
+static inline
+bool l3mdev_fib_rule_iif_match(const struct flowi *fl, int iifindex)
+{
+	return false;
+}
+
+static inline
+bool l3mdev_fib_rule_oif_match(const struct flowi *fl, int oifindex)
+{
+	return false;
+}
+
 static inline
 void l3mdev_update_flow(struct net *net, struct flowi *fl)
 {
diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index 4bc64d912a1c..7af302080a66 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -257,6 +257,24 @@ static int nla_put_port_range(struct sk_buff *skb, int attrtype,
 	return nla_put(skb, attrtype, sizeof(*range), range);
 }
 
+static bool fib_rule_iif_match(const struct fib_rule *rule, int iifindex,
+			       const struct flowi *fl)
+{
+	u8 iif_is_l3_master = READ_ONCE(rule->iif_is_l3_master);
+
+	return iif_is_l3_master ? l3mdev_fib_rule_iif_match(fl, iifindex) :
+				  fl->flowi_iif == iifindex;
+}
+
+static bool fib_rule_oif_match(const struct fib_rule *rule, int oifindex,
+			       const struct flowi *fl)
+{
+	u8 oif_is_l3_master = READ_ONCE(rule->oif_is_l3_master);
+
+	return oif_is_l3_master ? l3mdev_fib_rule_oif_match(fl, oifindex) :
+				  fl->flowi_oif == oifindex;
+}
+
 static int fib_rule_match(struct fib_rule *rule, struct fib_rules_ops *ops,
 			  struct flowi *fl, int flags,
 			  struct fib_lookup_arg *arg)
@@ -264,11 +282,11 @@ static int fib_rule_match(struct fib_rule *rule, struct fib_rules_ops *ops,
 	int iifindex, oifindex, ret = 0;
 
 	iifindex = READ_ONCE(rule->iifindex);
-	if (iifindex && (iifindex != fl->flowi_iif))
+	if (iifindex && !fib_rule_iif_match(rule, iifindex, fl))
 		goto out;
 
 	oifindex = READ_ONCE(rule->oifindex);
-	if (oifindex && (oifindex != fl->flowi_oif))
+	if (oifindex && !fib_rule_oif_match(rule, oifindex, fl))
 		goto out;
 
 	if ((rule->mark ^ fl->flowi_mark) & rule->mark_mask)
@@ -736,16 +754,20 @@ static int fib_nl2rule_rtnl(struct fib_rule *nlrule,
 		struct net_device *dev;
 
 		dev = __dev_get_by_name(nlrule->fr_net, nlrule->iifname);
-		if (dev)
+		if (dev) {
 			nlrule->iifindex = dev->ifindex;
+			nlrule->iif_is_l3_master = netif_is_l3_master(dev);
+		}
 	}
 
 	if (tb[FRA_OIFNAME]) {
 		struct net_device *dev;
 
 		dev = __dev_get_by_name(nlrule->fr_net, nlrule->oifname);
-		if (dev)
+		if (dev) {
 			nlrule->oifindex = dev->ifindex;
+			nlrule->oif_is_l3_master = netif_is_l3_master(dev);
+		}
 	}
 
 	return 0;
@@ -1336,11 +1358,17 @@ static void attach_rules(struct list_head *rules, struct net_device *dev)
 
 	list_for_each_entry(rule, rules, list) {
 		if (rule->iifindex == -1 &&
-		    strcmp(dev->name, rule->iifname) == 0)
+		    strcmp(dev->name, rule->iifname) == 0) {
 			WRITE_ONCE(rule->iifindex, dev->ifindex);
+			WRITE_ONCE(rule->iif_is_l3_master,
+				   netif_is_l3_master(dev));
+		}
 		if (rule->oifindex == -1 &&
-		    strcmp(dev->name, rule->oifname) == 0)
+		    strcmp(dev->name, rule->oifname) == 0) {
 			WRITE_ONCE(rule->oifindex, dev->ifindex);
+			WRITE_ONCE(rule->oif_is_l3_master,
+				   netif_is_l3_master(dev));
+		}
 	}
 }
 
@@ -1349,10 +1377,14 @@ static void detach_rules(struct list_head *rules, struct net_device *dev)
 	struct fib_rule *rule;
 
 	list_for_each_entry(rule, rules, list) {
-		if (rule->iifindex == dev->ifindex)
+		if (rule->iifindex == dev->ifindex) {
 			WRITE_ONCE(rule->iifindex, -1);
-		if (rule->oifindex == dev->ifindex)
+			WRITE_ONCE(rule->iif_is_l3_master, false);
+		}
+		if (rule->oifindex == dev->ifindex) {
 			WRITE_ONCE(rule->oifindex, -1);
+			WRITE_ONCE(rule->oif_is_l3_master, false);
+		}
 	}
 }
 
diff --git a/net/l3mdev/l3mdev.c b/net/l3mdev/l3mdev.c
index ca10916340b0..5432a5f2dfc8 100644
--- a/net/l3mdev/l3mdev.c
+++ b/net/l3mdev/l3mdev.c
@@ -277,8 +277,10 @@ void l3mdev_update_flow(struct net *net, struct flowi *fl)
 	if (fl->flowi_oif) {
 		dev = dev_get_by_index_rcu(net, fl->flowi_oif);
 		if (dev) {
-			if (!fl->flowi_l3mdev)
+			if (!fl->flowi_l3mdev) {
 				fl->flowi_l3mdev = l3mdev_master_ifindex_rcu(dev);
+				fl->flowi_flags |= FLOWI_FLAG_L3MDEV_OIF;
+			}
 
 			/* oif set to L3mdev directs lookup to its table;
 			 * reset to avoid oif match in fib_lookup
-- 
2.49.0


