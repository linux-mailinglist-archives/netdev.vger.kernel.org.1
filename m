Return-Path: <netdev+bounces-218620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33407B3DA49
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 08:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C359C1766FC
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 06:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7055025A354;
	Mon,  1 Sep 2025 06:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KhwmU61I"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF6C25A322
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 06:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756709558; cv=fail; b=d1KfqN4iPPm9mVQcTzHarngy+sK1PtaNpOkKiQlmrlm5DRgijNfnp7mK6PR3f0GRkgn4kgaECInCg91ZTD4CzujWXnhJwcNrLfLrvLGPMQT5NbFMrz8w1ZKzODGLJ4EivtQ6h3DOFDhRNsoDj56zF+/MX2mOF/8Cyw2ZHrmT3/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756709558; c=relaxed/simple;
	bh=AYxGmhMT0zoMWxLBpKX0c8RasdomlANlI/LUdwjiqJY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rkXKz0meTzkt8EKb58NiNoyWjyGEN2rijvOIe7aAay7Jizt3uiscz6e/5mjoKb2RklBp9EMsni9tpJurYbx49cz6bAD2uHgym3dKQCCeOeg4SQt2ZbEKkqsKCyaPcvMzoz9ZFhxzMmXslfIbg/CtPxZ5W3y+9W91jWHIlRwGgiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KhwmU61I; arc=fail smtp.client-ip=40.107.92.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jo9cV76Z4e2CVrs9hU9/Z8VPH0zE9RxxrWbhKmlWOvHMSoKx43oK0ynf1CRGmOFelFMa1r8Y0pbNo788oEPae1JMptCNlwJ1B1fimrrdGphVnAl/Eip5ovCzZmu0pDD3v24rUC0mLh9uYzyLidYZhOX44ArHXStXMOGloZTYTDS6WflM1tnwxzqIGehW/yk/hXcYKYFtqa587uVlRJXXWnutMj36bPSKtRqhLkNO2FQqQY4DWWnLbH1BPhogTaolaQCgSWKlpbMfukGAAZdIYpJ/V9I8cgYFQgz230eZSroqJajvw7yUYIlgX1jSZFPHYrVXwfrNYvbcsia0PiV60w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2l7hNQ89UYZDpjJno/OxtvyClkvFK3BeETCIhKxlP8c=;
 b=Vh601zcKafZsZp/0PLdOhpIJJ5SZlJwEy7Dy068XZR1jGVColnXAfVErf9ja2StvZgU8Ud6vlv0J8zTLPHXAHLApERf5RaqG6OAOM/dkMB7fJg7XNqZbjhi+odIN0jWTQ0lXwg6QoiRWNffNZ6W4kWuS7dXTHZxYaVrayPAER9hfw6K+Jokzza0X//jqbnU1i8OeNUR7yyGnnZWqbsAI3wwszaKWd93ylJfMKQfdAYMDj6vyQs5/gv0wowSQFG07B2KNb5JXHm4qzG+UfTpXYgskjewFUsLICXtWgWj8IkLr8UYIVOJM9M+30ck6bYvxw5c/VnQXBcvAEudgBYXblA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2l7hNQ89UYZDpjJno/OxtvyClkvFK3BeETCIhKxlP8c=;
 b=KhwmU61IA2O2zU00+kuYMvmHFVhKl+4YPem+yGmeM9EhKjnRwdFLkjMT5FFI0rymnO37xFhDCABdzRBP9L2ugSJLmbaD+ZxJjABS+h5Z9yTbTU2E69Up6qZc6C5dfZfT43Z/pSog31gyl7yDtkMbTmWvbT22Hjj/cANwOAOd70i1DBWF9RW4TQSf3lUFhWOvg7G/QwEtYS+lRW574rP+t/Mn8uaq7neRKSynrq4plRyw9CEQOhczqdoepUG7tcnxkYAl0wI9FH0U2O9wlOg5tbqy0TqR0hfoIULD2XYU+XxRzxmDSljOq0HdTLhRrHX4+19iwpe2f62922sJxpsJlw==
Received: from DM6PR08CA0041.namprd08.prod.outlook.com (2603:10b6:5:1e0::15)
 by CH2PR12MB4199.namprd12.prod.outlook.com (2603:10b6:610:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.26; Mon, 1 Sep
 2025 06:52:32 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:5:1e0:cafe::a7) by DM6PR08CA0041.outlook.office365.com
 (2603:10b6:5:1e0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.26 via Frontend Transport; Mon,
 1 Sep 2025 06:52:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Mon, 1 Sep 2025 06:52:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 31 Aug
 2025 23:52:17 -0700
Received: from shredder.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 31 Aug
 2025 23:52:13 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<razor@blackwall.org>, <petrm@nvidia.com>, <mcremers@cloudbear.nl>, "Ido
 Schimmel" <idosch@nvidia.com>
Subject: [PATCH net 1/3] vxlan: Fix NPD when refreshing an FDB entry with a nexthop object
Date: Mon, 1 Sep 2025 09:50:33 +0300
Message-ID: <20250901065035.159644-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901065035.159644-1-idosch@nvidia.com>
References: <20250901065035.159644-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|CH2PR12MB4199:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b5136da-d38a-43d7-aa76-08dde924202c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dVrB5ofUWqHbvyq6M73om4AppoP+9caltTtDkaZv+yy8ce4OudgIk8GlCufD?=
 =?us-ascii?Q?vWSQ3cpz3rRKMq7JEUKrkf88NYOg/5z9y2Uvq3h7k0/4Q+F/+XemJK6LlI0k?=
 =?us-ascii?Q?2dweJtDqt+ufT/Gs40Y0WiVv0zTyX2uDODzAi96dr9zH2Pzxoc4as8hxWqih?=
 =?us-ascii?Q?WwnTXBQK18lt7IZGM4e1smLiS1ZEYOqfryfwDs5+Uz+D6VuJ3asKe/it8Vrv?=
 =?us-ascii?Q?nODcLRy/afHDWAl+BAtsWIR000icDGhcegT9sBvEJKi9t5K1TlogjkzZlQae?=
 =?us-ascii?Q?Z7wjvp07qCc6+k79g7pSb+uUnRMsvXCxmg3WoGtTbyrrGYgmuiN7BTwbGEoh?=
 =?us-ascii?Q?gAaa89Z/Fmq0d2NJUKGbf8EJkQvUQvWQm018yhsAqKTPDcMn7WcvhqArD/dd?=
 =?us-ascii?Q?e7SS4PlfDjTtEvvmXiltFRWaRHzdSO9zMGcwXxZcG8q4bB4pPjlUdrE+vPgU?=
 =?us-ascii?Q?ZABbW9ApDPFoaym+9rJqmhUcfjoQTyE3zqHAgFWTHUfc/rwERH0wVuokccuV?=
 =?us-ascii?Q?qp8pZIkw7vrpCE4Fpa4m7HSncEHGzAYg4YjJtKIaoQECHWREMGjElpPzNYrF?=
 =?us-ascii?Q?hoRJnrXEE6TmvB7ZErUZsj33B4QN4S72D6L9TSc98tpX+MEn+CCW/s16JX30?=
 =?us-ascii?Q?71DDBSKvNEyWPfw1npf34HOtA9NmioUFHYLtQ5jZOBCTYIJIcKMnGiF/rCS0?=
 =?us-ascii?Q?IOMX5YyREIETGWXgY7b1gwDPrE/4+uJ0D6CIG/XIYc2JWPEDJo/PFtPjHjlj?=
 =?us-ascii?Q?icrCcAbTuAgkeFxUQRUhJR30dzSj5+n+ynBiLqwuKvpFAWON6MDYht+eTX0O?=
 =?us-ascii?Q?Hsng7yh8t+AiojsurWj0nEI0aZW5FEh0B8FdqCTzipIv/YThZMGLvxy6fvtO?=
 =?us-ascii?Q?hkhodzTIwyN3XFlEFyGMtw7qHlz69wDEvlIZi5kF7v5CaQjA2aHy0Fb5ywG8?=
 =?us-ascii?Q?GMYhBafBXK5aUBQUQp8hMLfno8R5ntU1ssvNYH8T2hCtPJEMjPua2jeK2bfr?=
 =?us-ascii?Q?sG09/eKybTJ3oa3aM4kQRd6VM8h33smY4a61IAa+fHCF1yEAfecUrRhw/POF?=
 =?us-ascii?Q?+ItSTFVo6VzpR961mpyGuU8FZWxFrRILYS7GJQ45SGWmUkn34CRUK+eVe1Gu?=
 =?us-ascii?Q?B8OlssrSik+MF5WSXg2NHCcztoTmXxaumdhcE0b3E0L8zfiBvILWhFEpWfF5?=
 =?us-ascii?Q?vjsqSMpy7Ef0SgqV0SauSzdzXep/44YWdBRE/lUYxrAKM9bqb6NX3CZaAdZ/?=
 =?us-ascii?Q?s3EB28nI2R5lwaOtxtyYUSpJjkKbaaYFuz+xFrV+R+h1KgzwOyjzx2IiDVc/?=
 =?us-ascii?Q?NsigcicYn8AtOYBCE4pcNnXLjW/8ulhvFxvB146xSKwRdNFE1cjcTlQ2LcQ5?=
 =?us-ascii?Q?2oUyEUfkqmn7waoelOECmSmcSDWjksUzwly3lxQKoVD2mzdXq1UYvKqRMorC?=
 =?us-ascii?Q?maeyG0tfF65NvhH++0Pv5X8QmYi3gTh4VOAN92GvA9CRQ6xgfgDzBNAxV1L3?=
 =?us-ascii?Q?fKeHrLz7P9U0dhtndEvNfSeVvl7I2XNAqwTg?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 06:52:32.2935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5136da-d38a-43d7-aa76-08dde924202c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4199

VXLAN FDB entries can point to either a remote destination or an FDB
nexthop group. The latter is usually used in EVPN deployments where
learning is disabled.

However, when learning is enabled, an incoming packet might try to
refresh an FDB entry that points to an FDB nexthop group and therefore
does not have a remote. Such packets should be dropped, but they are
only dropped after dereferencing the non-existent remote, resulting in a
NPD [1] which can be reproduced using [2].

Fix by dropping such packets earlier. Remove the misleading comment from
first_remote_rcu().

[1]
BUG: kernel NULL pointer dereference, address: 0000000000000000
[...]
CPU: 13 UID: 0 PID: 361 Comm: mausezahn Not tainted 6.17.0-rc1-virtme-g9f6b606b6b37 #1 PREEMPT(voluntary)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-4.fc41 04/01/2014
RIP: 0010:vxlan_snoop+0x98/0x1e0
[...]
Call Trace:
 <TASK>
 vxlan_encap_bypass+0x209/0x240
 encap_bypass_if_local+0xb1/0x100
 vxlan_xmit_one+0x1375/0x17e0
 vxlan_xmit+0x6b4/0x15f0
 dev_hard_start_xmit+0x5d/0x1c0
 __dev_queue_xmit+0x246/0xfd0
 packet_sendmsg+0x113a/0x1850
 __sock_sendmsg+0x38/0x70
 __sys_sendto+0x126/0x180
 __x64_sys_sendto+0x24/0x30
 do_syscall_64+0xa4/0x260
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

[2]
 #!/bin/bash

 ip address add 192.0.2.1/32 dev lo
 ip address add 192.0.2.2/32 dev lo

 ip nexthop add id 1 via 192.0.2.3 fdb
 ip nexthop add id 10 group 1 fdb

 ip link add name vx0 up type vxlan id 10010 local 192.0.2.1 dstport 12345 localbypass
 ip link add name vx1 up type vxlan id 10020 local 192.0.2.2 dstport 54321 learning

 bridge fdb add 00:11:22:33:44:55 dev vx0 self static dst 192.0.2.2 port 54321 vni 10020
 bridge fdb add 00:aa:bb:cc:dd:ee dev vx1 self static nhid 10

 mausezahn vx0 -a 00:aa:bb:cc:dd:ee -b 00:11:22:33:44:55 -c 1 -q

Fixes: 1274e1cc4226 ("vxlan: ecmp support for mac fdb entries")
Reported-by: Marlin Cremers <mcremers@cloudbear.nl>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c    | 8 ++++----
 drivers/net/vxlan/vxlan_private.h | 4 +---
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index f32be2e301f2..0f6a7c89a669 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1445,6 +1445,10 @@ static enum skb_drop_reason vxlan_snoop(struct net_device *dev,
 		if (READ_ONCE(f->updated) != now)
 			WRITE_ONCE(f->updated, now);
 
+		/* Don't override an fdb with nexthop with a learnt entry */
+		if (rcu_access_pointer(f->nh))
+			return SKB_DROP_REASON_VXLAN_ENTRY_EXISTS;
+
 		if (likely(vxlan_addr_equal(&rdst->remote_ip, src_ip) &&
 			   rdst->remote_ifindex == ifindex))
 			return SKB_NOT_DROPPED_YET;
@@ -1453,10 +1457,6 @@ static enum skb_drop_reason vxlan_snoop(struct net_device *dev,
 		if (f->state & (NUD_PERMANENT | NUD_NOARP))
 			return SKB_DROP_REASON_VXLAN_ENTRY_EXISTS;
 
-		/* Don't override an fdb with nexthop with a learnt entry */
-		if (rcu_access_pointer(f->nh))
-			return SKB_DROP_REASON_VXLAN_ENTRY_EXISTS;
-
 		if (net_ratelimit())
 			netdev_info(dev,
 				    "%pM migrated from %pIS to %pIS\n",
diff --git a/drivers/net/vxlan/vxlan_private.h b/drivers/net/vxlan/vxlan_private.h
index 6c625fb29c6c..99fe772ad679 100644
--- a/drivers/net/vxlan/vxlan_private.h
+++ b/drivers/net/vxlan/vxlan_private.h
@@ -61,9 +61,7 @@ static inline struct hlist_head *vs_head(struct net *net, __be16 port)
 	return &vn->sock_list[hash_32(ntohs(port), PORT_HASH_BITS)];
 }
 
-/* First remote destination for a forwarding entry.
- * Guaranteed to be non-NULL because remotes are never deleted.
- */
+/* First remote destination for a forwarding entry. */
 static inline struct vxlan_rdst *first_remote_rcu(struct vxlan_fdb *fdb)
 {
 	if (rcu_access_pointer(fdb->nh))
-- 
2.51.0


