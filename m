Return-Path: <netdev+bounces-168009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C0EA3D230
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 08:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE9C3188D9B5
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 07:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD1B15A85E;
	Thu, 20 Feb 2025 07:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GfVrH8l7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F4E1E0B8A
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 07:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740036417; cv=fail; b=CnLe9NPX1gBkfA2pWHZkuMFkaiEA3Bqm5AhabcKtnTI+2VxTmWNI4KBpuqOQTAuqB3ODOLHtclciYAuUJhcTPPyX8R/2CMfAjmJGSjjmUwAqQ70BtE6wHQDNjY7tDUR7hL2Pm9S3WqfMdLycjqs+ZCP6kdjDN4E6AYnATcx3Mxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740036417; c=relaxed/simple;
	bh=5zjVCogxQxuD50qh0E6uGL8/6DrQ/XiZCE80y1qJeMc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m0pIBkPxLEWjI1RrtXwRbFF12WNRZ2OtmkxgAoCn4IMNfwg/MvfbYoM2p+aS1AoaKzm6/KXKOM5uyZOL5baRpeLvd/OEkTFfCfJhAOsnAhDDzndOYCXp51qc+ynXjtm592NH/aV0Nbjr0pq/vIoDi+Uc74ygkku1ye/q8zAxfEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GfVrH8l7; arc=fail smtp.client-ip=40.107.94.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vf9KYA+eRVttl1a9VwaqGlMeL7t6nRYlVTtu98D6KZ9LIO2PHsPeujGcPY1WWTuGE6M7sYRu9Kh9FGcYkFhJK2no4SYpDddK+3ojSSbtyCkIm5CkhRvLOPVl+sqI0PpolF1A7EkDW4FjhL7fraYBmlNJanhcRizMz5cl2MME1S7bkWZivH6zVzOrlTKJMVgAvcnS8ob7M+Gw4Yzfzxj54POWrRR+uRKq4uWdz6CVrBddiw+rloyJSA408w4DqyXUujgXw79DA0jQUxY5e6qUXRCrdfsXLKkMVKL+deg5ALCtF6e+SdVDhHo6+/GbX2KUVddRKhbdCktb3kni8Z0cZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2YFjHW0zy1Od7McN+Kqn3bBI1GS0I70PL9cwVR3arE=;
 b=uEEbrLiTMM85CURxOI7FD7OaOX96JlWACKC6JFtEyyYUiO5wJk6lWvPhE2C3OPy+XVvwCHEFi6mZjGxKe4bvFfjwpnVJCIYCZDKhtIgaxjfjmnrBqK9yEA9R8H1ICELqeULUH9OIvFXi0i60MJfoqrcTBt/wnRZ+vsKSXnnn6YLkWgRQJhL1COvwVLPCUSNA2AaTED5KqxMh2dmkaZ39fgBV706Y+vRQxJJ0osXZZEvy+Z41minbIhmf5pB5Q6TlefwzOigB7gfJpxyIYSSzENAKX8tJePKNvY16zGG6dLtniFudg20hmBVkVFk6mJMNGk6FX2BSb4xp6X3DWQ0bdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2YFjHW0zy1Od7McN+Kqn3bBI1GS0I70PL9cwVR3arE=;
 b=GfVrH8l7XSrVrhpXEk9BiGGiOeD3W6lAoBhPfzpt7oMQL9MO4kVuVpp22Yr+YCorEyITt0NXz1+awEKkpyB0qbcceEFw3ebbGJHKYlzCewqeV3FsXrqaZzXf8cxH6JhnICBzT+MwMAiZUIZoT0sz/7KeEGhuhWdxeia5ksuEh17lNlW0TamKAJ+5P2lDmeBzLYSZ/8UP/PLDo/M4thvfIEYwYzsC/r1nq7QNlTGfi345Gn2YoPd8SmtM4AlBQ+WPKt4bElGeDlbmbIKnb3hB6rerFWalnUSqQGNaA0RPNo0Li/quAkSssS9K6TCrKHsuK0UseQZyofqyu8o1U1aWqA==
Received: from BYAPR07CA0071.namprd07.prod.outlook.com (2603:10b6:a03:60::48)
 by CY8PR12MB7434.namprd12.prod.outlook.com (2603:10b6:930:52::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 07:26:52 +0000
Received: from BY1PEPF0001AE1C.namprd04.prod.outlook.com
 (2603:10b6:a03:60:cafe::c1) by BYAPR07CA0071.outlook.office365.com
 (2603:10b6:a03:60::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 07:26:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF0001AE1C.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 07:26:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Feb
 2025 23:26:29 -0800
Received: from shredder.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Feb
 2025 23:26:26 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <maheshb@google.com>,
	<lucien.xin@gmail.com>, <fmei@sfs.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net] net: loopback: Avoid sending IP packets without an Ethernet header
Date: Thu, 20 Feb 2025 09:25:59 +0200
Message-ID: <20250220072559.782296-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.48.1
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1C:EE_|CY8PR12MB7434:EE_
X-MS-Office365-Filtering-Correlation-Id: d592cd57-0f8f-4681-2fe9-08dd517ff237
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tJkbKhSgR66zdFpsU2MzEqvNB4fjHlkaA3/MzA0gLbKPhPnNpglalbYuxnLF?=
 =?us-ascii?Q?R4rCxXyYAb5aaDp5tTp4JCV2wZiuNoTceamExqRTSilAPJy3Q2vnAH3QD720?=
 =?us-ascii?Q?c1WURH2po0Mf6wlqF1t1lteO3PxjL+47h0R9hPiis8b4t9SW181NS8Q/nB8n?=
 =?us-ascii?Q?iNQ+AyGaNHB9qkw9c5c3qnzxnpbranHYD68QbWBgdWEFvsLJupNATY5LiIk7?=
 =?us-ascii?Q?eTHaizqN1kZnTU0CgqJ6aC1z0bAQ018L4nenpW3/RpkqF6CwD1EijLNSOERS?=
 =?us-ascii?Q?ADZV1hJ9YGciYe9ecmaIsa1XYOcvT03FYJxC9HhF741P8sTQcY+cGuydkoYM?=
 =?us-ascii?Q?w+VzdueDi14FccfLKDxlp2A2Iuqsxs5epZpQWB2uKd4EfsDFObhrGwJrctAc?=
 =?us-ascii?Q?mWuioUPNRRT+/b8j3y2o0ZWyuiUONJMgXV8D/jO6goP91GdXn4uyyBMSs+b6?=
 =?us-ascii?Q?6oy8YadS6HAlPA34nUX/6ZA3eJU5YqmKByRwBvwA+19eDs4HcX2eUm/B2bCT?=
 =?us-ascii?Q?iaTP2dajAB6HFmran+LXAoSsuF4Mg/dRn84sYQ6n1Kb9nKgKxm9sndIl3PPv?=
 =?us-ascii?Q?ZCi7eFvLBJyBxdpX4OK4uAZHoWCi0qReq/CmUR/ImKkfRQdpb4aLcamQXnIM?=
 =?us-ascii?Q?SAncmeQgb1PHOVoQnAEFfuDraU+8rdFSa68Q8IKFRDi5rnXarElTwXGif+m6?=
 =?us-ascii?Q?UPyrWZOskICWoKscQ/0P2BF3YbavVPQK6dtxpKXcvrm13RQ5ZE8yRJ4tP94W?=
 =?us-ascii?Q?lDSVVTYkFU4yA6UbKdXibdqIQD7U4XdUuyaAM5sjEJYXSPiGXDFELC4H7sCR?=
 =?us-ascii?Q?HajLs87QYOCry4zCALlZXZMvHbrLiJWhy1iWPZK1E06g0ijAB2YntWr/1OTZ?=
 =?us-ascii?Q?OyLgvLT6AvJSeg6XnpJotDV6RJKpj8avYQKuPFyEM/MSg7r4uGaIFhFo4ydk?=
 =?us-ascii?Q?FIdL9tM+T1i1FgVXQl6zYUpY1Bdvb/90uf75hkjhfPaoF7Pb1NX4ZKTp6bjk?=
 =?us-ascii?Q?gJLt6RpaFXWdcWpQyAvd/Q+aXW4iplBLzt6yYQ8hTaw1I7ibC2o49kVUp1jL?=
 =?us-ascii?Q?QN7/u93c+qdgWkgKtLvZnWw7Erg6vPThvBwDBIZsFsLotyGK5nphdUvqzy/4?=
 =?us-ascii?Q?4Hte8xyBXD95Och/kwIqHOGSoLfRX3wN4Fl+Odaipn6MUX7qFZMpyDi+RL5C?=
 =?us-ascii?Q?HKymxoAFSSWcZATmJmVzAvWfG0r9rdlYODagOt6AiM5fSCC5o7m0mzxyuw+7?=
 =?us-ascii?Q?xV6MvpoZhU5wxAS8TTM7jwStodQldwfe66QkihkV4z7rqwB+rgw8cws4IxvF?=
 =?us-ascii?Q?BHtQkiibSAS8s3Plz5qtg5kFIUt4EZjXXD7McbJdglFychCfYvwDl6mO39JJ?=
 =?us-ascii?Q?S60j9WmyLXWleSHJ2dda68SNySPa3gJFUgkO6WQHNE0nUhZIAYA+MZPbyP6g?=
 =?us-ascii?Q?/0gk5DBbjBmlu/ipYHQWnyxRL5OMldPdFNZ4OvH+ew6//aQWEzBl82qgVcky?=
 =?us-ascii?Q?kjHFc0w3EPzy8DI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 07:26:52.1471
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d592cd57-0f8f-4681-2fe9-08dd517ff237
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7434

After commit 22600596b675 ("ipv4: give an IPv4 dev to blackhole_netdev")
IPv4 neighbors can be constructed on the blackhole net device, but they
are constructed with an output function (neigh_direct_output()) that
simply calls dev_queue_xmit(). The latter will transmit packets via
'skb->dev' which might not be the blackhole net device if dst_dev_put()
switched 'dst->dev' to the blackhole net device while another CPU was
using the dst entry in ip_output(), but after it already initialized
'skb->dev' from 'dst->dev'.

Specifically, the following can happen:

    CPU1                                      CPU2

udp_sendmsg(sk1)                          udp_sendmsg(sk2)
udp_send_skb()                            [...]
ip_output()
    skb->dev = skb_dst(skb)->dev
                                          dst_dev_put()
                                              dst->dev = blackhole_netdev
ip_finish_output2()
    resolves neigh on dst->dev
neigh_output()
neigh_direct_output()
dev_queue_xmit()

This will result in IPv4 packets being sent without an Ethernet header
via a valid net device:

tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on enp9s0, link-type EN10MB (Ethernet), snapshot length 262144 bytes
22:07:02.329668 20:00:40:11:18:fb > 45:00:00:44:f4:94, ethertype Unknown
(0x58c6), length 68:
        0x0000:  8dda 74ca f1ae ca6c ca6c 0098 969c 0400  ..t....l.l......
        0x0010:  0000 4730 3f18 6800 0000 0000 0000 9971  ..G0?.h........q
        0x0020:  c4c9 9055 a157 0a70 9ead bf83 38ca ab38  ...U.W.p....8..8
        0x0030:  8add ab96 e052                           .....R

Fix by making sure that neighbors are constructed on top of the
blackhole net device with an output function that simply consumes the
packets, in a similar fashion to dst_discard_out() and
blackhole_netdev_xmit().

Fixes: 8d7017fd621d ("blackhole_netdev: use blackhole_netdev to invalidate dst entries")
Fixes: 22600596b675 ("ipv4: give an IPv4 dev to blackhole_netdev")
Reported-by: Florian Meister <fmei@sfs.com>
Closes: https://lore.kernel.org/netdev/20250210084931.23a5c2e4@hermes.local/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/loopback.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
index c8840c3b9a1b..f1d68153987e 100644
--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -244,8 +244,22 @@ static netdev_tx_t blackhole_netdev_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
+static int blackhole_neigh_output(struct neighbour *n, struct sk_buff *skb)
+{
+	kfree_skb(skb);
+	return 0;
+}
+
+static int blackhole_neigh_construct(struct net_device *dev,
+				     struct neighbour *n)
+{
+	n->output = blackhole_neigh_output;
+	return 0;
+}
+
 static const struct net_device_ops blackhole_netdev_ops = {
 	.ndo_start_xmit = blackhole_netdev_xmit,
+	.ndo_neigh_construct = blackhole_neigh_construct,
 };
 
 /* This is a dst-dummy device used specifically for invalidated
-- 
2.48.1


