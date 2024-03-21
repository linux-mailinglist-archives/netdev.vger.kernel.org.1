Return-Path: <netdev+bounces-81118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7813F885FC7
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 18:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3381B227AD
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 17:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62FA56768;
	Thu, 21 Mar 2024 17:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V6xkdXPb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3323984D
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 17:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711042298; cv=fail; b=VlM30Q/dSIwQ54jxbZGbijBOleAU1Jct6pu/N6jCt3JKlurKAmIORMjNS30V4gWuIadNz2clFhDDlZnnzE5s1PbRLRvW+EgGamrmkKEDgYkVOvx0MNIKmGjNnOkgwhqbbNA7XtCpsyj24i2BZSmfg2Hk6xYHIlEawvNFLJ32Sf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711042298; c=relaxed/simple;
	bh=HAl3H80qzbckBrDEGINssDANMtVCwehn+HBH6NGK5/s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IUhGd06ll42E+rFQs9SPTqheG8EknHAgKKT1sPd1WHJxAm48OKJLa7AGypnHaZTu+uPnoa7p3PXlZqBfYf2MOO9SeJNd//1iQrFQ+Q3CgvY5MTevCLiitBqdfc6AznVJy/e4j7O/rktnXfdxSyIRh0n6FfZX1A+hEuGyMKDEI0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V6xkdXPb; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LtywjZfsuR2bduKgwtGNN5h+CCziPfzhc8D+Fr+q0cH3xmV2FcAnMqACNKXGK5EeMbRtL5gMiSGG/2c3Jy+2Wta8ASCQpJWq+hIxA1ATj1xdD7XYG4KLTX5+36x8nky6KnCSpywnzCFjhGOWEEo4GyeDb9gz0H/O3DVcoK8mbNueXKGQVoviYefgTKZPfJHTeBeaNc71RVx27scHEKPzsamprtFXZ6yo90aga5ZcX6fedD/tnqA++RN+A3KHyb9Z59D0PpeKdUQgPD+kQp42cn1Ckrr7g064iIKCsrt99cDChSOiwA7bo3ITdwC+32i87iN/yywtqmFy25gioHQBow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAWJhC6Vt+P7vxEMiF9cT8VT5IDXcs1OcWCf8DIT9PU=;
 b=U1IdrrPJFW/+LJ6ZU0sV/l4YRxmNAWqw62D01cEY6dOTQGDJwbi8bNTYbqaXja46b1Gm6gEH2K1cRoPprjo50HpiiZ6PgzD8u1VQQwePZh3bZdzPf5YtAqmhg7cc8w9RcQXR4qg1M085icFV/EwHeh7dC99V21WIDdbVpgnznoVvsIxKxTrfYC5VfIHLV7lrTPstbFZkUo6lSioz3qU7U6HoXRU5GjNoAn4jS6XtYATN21vXZw8A3Io4T6Dec3htZyGBrTjULo9DpBKV14O0DJ5BI7vLUfn+n/9h3f83awzaVXR0k946lDF7rRW6azsIaFoRWoZB/zTIT/mv8WZJtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAWJhC6Vt+P7vxEMiF9cT8VT5IDXcs1OcWCf8DIT9PU=;
 b=V6xkdXPbDyRZ9QReCXDuJmc+bBpsAYxy5Efbku4w30KejgzRn91xjDccAoh7C6ArIbG7cjgLMEFqeZdG+tX3v0x5sY2WiH0vh0+dNcMXe+g+9NsflUdQLYOqjPDoGRCp6wHep7Ztt0N2ECRKBnmdvExqV9QnRkIMnpybM/Imgajc8iexieElfPQ9stZ1bN0jU/MhbZ2Z2sPnGDzOp3kzM6MxjjS4SQ448boDzFIFdKE96MVH437RW+hd6xoQcs9IVWZBYFy1oaqhqdVP3V4FysTsYTEd4MKjfK/rB3R1309DPTsNBF2irRtG1rKX2eutY3KqJhFfVDWwPTk7XFg+Ew==
Received: from DM5PR07CA0093.namprd07.prod.outlook.com (2603:10b6:4:ae::22) by
 BL3PR12MB6522.namprd12.prod.outlook.com (2603:10b6:208:3be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Thu, 21 Mar
 2024 17:31:32 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:4:ae:cafe::85) by DM5PR07CA0093.outlook.office365.com
 (2603:10b6:4:ae::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 21 Mar 2024 17:31:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Thu, 21 Mar 2024 17:31:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 21 Mar
 2024 10:31:12 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Thu, 21 Mar 2024 10:31:09 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <gal@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net] ipv6: Fix address dump when IPv6 is disabled on an interface
Date: Thu, 21 Mar 2024 19:30:42 +0200
Message-ID: <20240321173042.2151756-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|BL3PR12MB6522:EE_
X-MS-Office365-Filtering-Correlation-Id: 02485a5a-2ab0-47de-b051-08dc49ccbfbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hBf5tWTHnNZOPr++tByWUZV+Znd7aU67fmmvMoFlDZczhexW+OfInxRmk7JUW77kaXfc0iL2Wa03THCC89kd/syAHIsCZgk+kmSa/AfJFr0glG/H67ueXfTU3IrPcCNo05AZ+GKuudBWPC1MlJPOz95nI9dx6g28Y6WM2F8cVNF8cXnrH1m+bkED12NZh0wX+cctgjG0kQtx2g+7klr1J3Wb3SCJzJQOuxBpI7MFBd2U/e/LgB31yMBVHB+UY6rc3g7zFH5RZJT8rKrWWRHyFVbxu8rJjxmw1x8q9GnoWEvaziJnkGWtpCLTiYC52kucvpX2e/hiZf7adlnwJuI4qB7JiOWSHyYOIrVPEVGAGFbSW6bnQH/wSVLgDLPyoKSEGf5NATOCkkFJu4twS2o8bpFWIif+b+1xSN1zregdjrVil9+pqmqFpjxkqsP0Rs+SVKN7YDPWiN9XsZQeK1HSe+ZuCMD0AirlVVDlwuU2JL69twIzhqttBLUuH9Vi7oh2/qGv82YZiZm3chYduSozW5Dv/T99wlDQ7een2eINIJyqpTbySO4zupUO6cwTYisk/OgkODi2WSoA5qo3VBMGD2t5aCCJz/YIvIbu1F5+qJ4w9qqOO0SOS10mVGuIRA401lscL4PSmLyOTPTPgQ2tRvUhSgcJbr8zPkOpN1+NLEJlt2U/F1YTXUkIik6Ov4cCyY7XvWYNwdXzxF3pdEaas1F04Es3i9cDQdkyMSbZkXunk0wEII3RjXcWOabH9Zn1
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 17:31:31.7370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02485a5a-2ab0-47de-b051-08dc49ccbfbf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6522

Cited commit started returning an error when user space requests to dump
the interface's IPv6 addresses and IPv6 is disabled on the interface.
Restore the previous behavior and do not return an error.

Before cited commit:

 # ip address show dev dummy1
 2: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
     link/ether 1a:52:02:5a:c2:6e brd ff:ff:ff:ff:ff:ff
     inet6 fe80::1852:2ff:fe5a:c26e/64 scope link proto kernel_ll
        valid_lft forever preferred_lft forever
 # ip link set dev dummy1 mtu 1000
 # ip address show dev dummy1
 2: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1000 qdisc noqueue state UNKNOWN group default qlen 1000
     link/ether 1a:52:02:5a:c2:6e brd ff:ff:ff:ff:ff:ff

After cited commit:

 # ip address show dev dummy1
 2: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
     link/ether 1e:9b:94:00:ac:e8 brd ff:ff:ff:ff:ff:ff
     inet6 fe80::1c9b:94ff:fe00:ace8/64 scope link proto kernel_ll
        valid_lft forever preferred_lft forever
 # ip link set dev dummy1 mtu 1000
 # ip address show dev dummy1
 RTNETLINK answers: No such device
 Dump terminated

With this patch:

 # ip address show dev dummy1
 2: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
     link/ether 42:35:fc:53:66:cf brd ff:ff:ff:ff:ff:ff
     inet6 fe80::4035:fcff:fe53:66cf/64 scope link proto kernel_ll
        valid_lft forever preferred_lft forever
 # ip link set dev dummy1 mtu 1000
 # ip address show dev dummy1
 2: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1000 qdisc noqueue state UNKNOWN group default qlen 1000
     link/ether 42:35:fc:53:66:cf brd ff:ff:ff:ff:ff:ff

Fixes: 9cc4cc329d30 ("ipv6: use xa_array iterator to implement inet6_dump_addr()")
Reported-by: Gal Pressman <gal@nvidia.com>
Closes: https://lore.kernel.org/netdev/7e261328-42eb-411d-b1b4-ad884eeaae4d@linux.dev/
Tested-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
A similar change was done for IPv4 in commit cdb2f80f1c10 ("inet: use
xa_array iterator to implement inet_dump_ifaddr()"), but I'm not aware
of a way to disable IPv4 other than unregistering the interface, so I
don't see a reason to change the IPv4 code.
---
 net/ipv6/addrconf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 247bd4d8ee45..92db9b474f2b 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -5416,10 +5416,11 @@ static int inet6_dump_addr(struct sk_buff *skb, struct netlink_callback *cb,
 
 		err = 0;
 		if (fillargs.ifindex) {
-			err = -ENODEV;
 			dev = dev_get_by_index_rcu(tgt_net, fillargs.ifindex);
-			if (!dev)
+			if (!dev) {
+				err = -ENODEV;
 				goto done;
+			}
 			idev = __in6_dev_get(dev);
 			if (idev)
 				err = in6_dump_addrs(idev, skb, cb,
-- 
2.43.0


