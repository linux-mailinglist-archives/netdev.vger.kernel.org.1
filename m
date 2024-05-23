Return-Path: <netdev+bounces-97765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE978CD0D1
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 13:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E79B7B20CA7
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 11:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B649413D284;
	Thu, 23 May 2024 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OQp5+Kxl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2845346AF
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716462244; cv=fail; b=hmmN6ZIDf/x0xi2Zr4BFkEF0JsVFaGBctmMQ6bclCyEmp5Cs+I9/1GjB1D3gWRr1FtEv34Y+z0IEjwi0lj4TDHAYFmXSY5TJ3CymjEkfJzs4Sss9nnOg+cwIokmeuB/Al1rkiiXYF0X35o7nGB2o4db5Nc8+CC5uKdbQW0oejpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716462244; c=relaxed/simple;
	bh=v8tMDHA9r1y5N0DbVwjl6kc6WtS2cruu+kXbJ+bJHGU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K1jSsZYN3JnQ+FYbHgvSq5x5ja8J6+Q842BgApPU1RGZkmixe0pRpsFA5byuWyYUAWJLF0xYmyKbq+BXMX3zeC5sLmZ1cu5ITiEmMA0tQByrA1VdvJHnBl3YsVDfTlGz58OGxgDcBS+d79YYO0lcCxyhUWrz0xtae1Mqg6Z1WJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OQp5+Kxl; arc=fail smtp.client-ip=40.107.243.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J37qot/HmXCJBmPuPZqfobtyvZJLYe9XAjNJDWIlgH6eJiMDR1oykdGAQYolhTMf6ERipvxYNxD5B5Rx2AZG9yMCz4+14wVpTv7plmA1faqkokRPH/PcHgbosG6iLvT1CDyHidMmlDR/3W4QeXE8OcYquDBN6XgKnNOX/CgInxrdrPhQJRzsbFuw2XQV5SDQ+2Vsyn7zX2ua14U2cJo8pXq764EWx67dDGMJK3iUWqRry65oKMrfURDs95VFuH0d7dH6+uyD8xJs0DwLsnXoBR34Z2y+09/W5fLI5gx2YnhUNnFxxgOW1HObnaEzTFv2SUz58Dy6idZAXPB7Qz7A5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrodwG/qrW48eyeky5WcKC1jFDDKLBAMdxX9yh7vXMo=;
 b=g5l77UyYeo0glCMn8TqHRaiSh2kRlUQXA3eI7BCvVQm1yWFnBT2KteolYtr0gXtvafGN1VU+aDng4URx+gqNlU/Rcu7ADfkHwJmD0G3iBGewaY/0jqByKS0p28uCUyxRjMpz0OrtYTcthP//rEYbH5pEbSudUUJgbpUskNQIDjvcYuQF4o3R/HUtHRfNdPskbAAGwqCFqcOB0dgZJxTwh06W9BmAbEpFPj6eB4MplIQLEQbVX6iS/nmfYBxoubtHwZ+BCmcrU6/zBJAHzUGczTLsdv5V7dx7OHQfBgZKzGZl0rucd+zrNWpmMATWrJX5ZK09EiXOQGJiPZW2gRjlQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrodwG/qrW48eyeky5WcKC1jFDDKLBAMdxX9yh7vXMo=;
 b=OQp5+Kxl0l99/BVJd2A74/2bm8wSZKlIjGBzYIdJA7pnecSUFirVcLXZlnpQ6gdadglR3F+Ale4cQdn20VxhCnPUmE5wMvufXjD4a40vrmSe3dl1a4845LxxEpDl6yhdowhgOLmoLH90A9K0kpShLpFBf1FFNG9qP4QkpP8D4SuW3vm2GAs8NkEX6EcIS7Bpywd5NHde/PH0f+JRVLLEu2F+nVJ014h5EA/S1KVbZRTnV7+E1N3FhZ+qWdGLYih+7NG+IpuIHCjZpCAilNrdgVMMyu0AVrbP9xRvZ19AHpvFb7xHLRnUU2ewFt5Lk6MLuPNCpFmTj7kdbZXt+N9mLw==
Received: from SA0PR11CA0110.namprd11.prod.outlook.com (2603:10b6:806:d1::25)
 by IA1PR12MB6089.namprd12.prod.outlook.com (2603:10b6:208:3ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 11:03:59 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:d1:cafe::be) by SA0PR11CA0110.outlook.office365.com
 (2603:10b6:806:d1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.29 via Frontend
 Transport; Thu, 23 May 2024 11:03:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 11:03:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 23 May
 2024 04:03:44 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 23 May 2024 04:03:41 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <petrm@nvidia.com>,
	<cjubran@nvidia.com>, <ysafadi@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net] ipv4: Fix address dump when IPv4 is disabled on an interface
Date: Thu, 23 May 2024 14:02:57 +0300
Message-ID: <20240523110257.334315-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.45.1
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|IA1PR12MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: 8220c551-484e-4c19-6396-08dc7b180bc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2RVflwcxWWdG2caW0FXmdWBPFlZ5ARLHFm12jZY8kbninCIRj7uahsyVoeP0?=
 =?us-ascii?Q?6iXX2if0emkll6zoBVuokE3ib572c7ASCtyxxNVBlSp033PvvJRaDsBtro3V?=
 =?us-ascii?Q?PkKfSNVezXhHov6JSjGQnjhb1+JewwUbpXvJ1pkkW0TDFdqvdxi6EAh3Cc7k?=
 =?us-ascii?Q?VgNuUMerlWrE8LK8PYkYmXoc8LJMIShTy8RgDOfBtVIw3QGHMd/VcBsLE2wl?=
 =?us-ascii?Q?Y/ySHSxW64EVfcAMYDXE5a3icoDcRuUdgeYJOeEsR5otrIDFR4I2Hv+Uxw+/?=
 =?us-ascii?Q?aA2WIW135Vd/UDlGCxBNZqtJaheLFJTvsSDej1dkMl7g/qoWCfV1dD/7lDnj?=
 =?us-ascii?Q?1P5GhP9451cZhWudQh5Dj8p0hs9IFWqtfg3PazvgKo279Mp2Q39LK9hWjiuc?=
 =?us-ascii?Q?dDzXxaOcmERIJbQT6+hkLAse4doMpGF27TMp4WuQXeKb8z0xgsl7Lm9vXn9f?=
 =?us-ascii?Q?5wXInWowPkJr58qDbHzMgfMPyYZMBleN/nKdD/UKgXfjepeuXnp41wcot+Oi?=
 =?us-ascii?Q?suzGhV4sTuBNTSmR6TRi6w63uwJuEuI4GxtLxJm7Q5r3RMoyStpnPezKsL1t?=
 =?us-ascii?Q?NEFnUmGFr6wjUZFy/zETzrA//WPAQurwKQVxLfGjQ4/JbT9gmQR1TOdOGNyI?=
 =?us-ascii?Q?6Sg0pNrFegUsGXXCdGWt2VDsRBwIMIwINQPc//3oeVtR0h56S6ufRbbAUZqW?=
 =?us-ascii?Q?MoP7u7qC8jnORby3T9M6m7fOwiUkBLFi47P9VIlENepxLW9v+TjZvtSIeTp3?=
 =?us-ascii?Q?xBFJvN5U4bSZHV+19NgYVT/IaR9WYk2hvmf3hZhV/SLvm6xXMYogDxG2n0Fu?=
 =?us-ascii?Q?d1KcZB7Kw/FBOEUuj6gKX0GjNuGtnT7yOUh63dDyQP4dudioy+5rumBL1Gwi?=
 =?us-ascii?Q?61SpM+AjfboHoye2ILPmNNG32ZeUsWiZAuvVFhNKaN40uq+RonsR/OWQwcwV?=
 =?us-ascii?Q?QraVtSPew4bN+hnH608/+5YgoPxMMbD/JZYKlzoF2mKScoEujZpyj2EEiQY9?=
 =?us-ascii?Q?JUOjaQlYKXz75+GHJHUn34RdxlTlg4O+juco8dMtB+4fpp1eQXZP0vX8tyN7?=
 =?us-ascii?Q?S70XK0LV9GbETQ0rPSPT8/r9araNhme6WoSBFK5bNAsd9waOzXuPhyDbTVQv?=
 =?us-ascii?Q?sUDZ2r4XMS6CM7MvTa4Jvyr8H872W2asjbYcMzDQUGhrAbfwymoWDoCn3tTT?=
 =?us-ascii?Q?SFqlyevmjvVZ3O4RJFnR87vhomboumvtubRTCIS/dhJTCMCJKbcXgezu51E/?=
 =?us-ascii?Q?3cYciIFzz59CKl50oXilhpHw4oZ1PkpeT1t2AYNdFYW2qTlmtREAmXl1Hghl?=
 =?us-ascii?Q?IX9IBSG0MmV4jAXXo2RIBLzGzKLghaAk7zKojuv06zicb7fYzlbyTCmOkoRH?=
 =?us-ascii?Q?cLM6epCqOwMLzJM1A2gO3MiwPaEr?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 11:03:58.5278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8220c551-484e-4c19-6396-08dc7b180bc5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6089

Cited commit started returning an error when user space requests to dump
the interface's IPv4 addresses and IPv4 is disabled on the interface.
Restore the previous behavior and do not return an error.

Before cited commit:

 # ip address show dev dummy1
 10: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
     link/ether e2:40:68:98:d0:18 brd ff:ff:ff:ff:ff:ff
     inet6 fe80::e040:68ff:fe98:d018/64 scope link proto kernel_ll
        valid_lft forever preferred_lft forever
 # ip link set dev dummy1 mtu 67
 # ip address show dev dummy1
 10: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 67 qdisc noqueue state UNKNOWN group default qlen 1000
     link/ether e2:40:68:98:d0:18 brd ff:ff:ff:ff:ff:ff

After cited commit:

 # ip address show dev dummy1
 10: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
     link/ether 32:2d:69:f2:9c:99 brd ff:ff:ff:ff:ff:ff
     inet6 fe80::302d:69ff:fef2:9c99/64 scope link proto kernel_ll
        valid_lft forever preferred_lft forever
 # ip link set dev dummy1 mtu 67
 # ip address show dev dummy1
 RTNETLINK answers: No such device
 Dump terminated

With this patch:

 # ip address show dev dummy1
 10: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
     link/ether de:17:56:bb:57:c0 brd ff:ff:ff:ff:ff:ff
     inet6 fe80::dc17:56ff:febb:57c0/64 scope link proto kernel_ll
        valid_lft forever preferred_lft forever
 # ip link set dev dummy1 mtu 67
 # ip address show dev dummy1
 10: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 67 qdisc noqueue state UNKNOWN group default qlen 1000
     link/ether de:17:56:bb:57:c0 brd ff:ff:ff:ff:ff:ff

I fixed the exact same issue for IPv6 in commit c04f7dfe6ec2 ("ipv6: Fix
address dump when IPv6 is disabled on an interface"), but noted [1] that
I am not doing the change for IPv4 because I am not aware of a way to
disable IPv4 on an interface other than unregistering it. I clearly
missed the above case.

[1] https://lore.kernel.org/netdev/20240321173042.2151756-1-idosch@nvidia.com/

Fixes: cdb2f80f1c10 ("inet: use xa_array iterator to implement inet_dump_ifaddr()")
Reported-by: Carolina Jubran <cjubran@nvidia.com>
Reported-by: Yamen Safadi <ysafadi@nvidia.com>
Tested-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/devinet.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 96accde527da..e827da128c5f 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -1887,10 +1887,11 @@ static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
 			goto done;
 
 		if (fillargs.ifindex) {
-			err = -ENODEV;
 			dev = dev_get_by_index_rcu(tgt_net, fillargs.ifindex);
-			if (!dev)
+			if (!dev) {
+				err = -ENODEV;
 				goto done;
+			}
 			in_dev = __in_dev_get_rcu(dev);
 			if (!in_dev)
 				goto done;
-- 
2.45.1


