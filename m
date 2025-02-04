Return-Path: <netdev+bounces-162598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B541CA274ED
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 15:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50F891885894
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46541213E70;
	Tue,  4 Feb 2025 14:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nJ8hoHtm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DC7213E65
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738680998; cv=fail; b=W86fE4OMbdQq5vsUhBL2SNOZPw89uiAK4vDvh7hL9LCeq32Mek8EB9sdRogT9FiMou8IiGlBopiSzbYnJXRZMuxN/qjNC/XVoSHwqX+JhaSy2XSZJP/KhjaPOGMBb1lCiC1SBr5ZH44CaYy8nHlI4733qIpUbfrPzdnPVhOL3yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738680998; c=relaxed/simple;
	bh=2JYX/ya3+DRcM4h2yy/TmA3lZUVGcrci82YmKsKzJic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E9mtuGfaxRk92GweXoAGCuPzIUAK3n2wauifkFGwoNii6C3D+IqWTadKO/4x7V7NtC+rSp6YINXw/0F7IR9AVpXwwFfoFhOV1ZC+Yn8riB2vMzWZP5r+aFsr60jiVpxIM/a7dzxBIIk4t4bkbcMapN7tEaRKWLs2ipkekgJzK/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nJ8hoHtm; arc=fail smtp.client-ip=40.107.236.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uTJcXkO89krdC/zctZZDbEwdlmKhGiIsH+0JI7LGaa4ExTm6W4FazGtPeKbAeoOBlwTRyJthK+briVQF/EU/QIVyXsZ3pZKgwSZGS3EzEryZnUia9IJ+EEgHJ5Pxf7uSeo3BHYm+zy1UjN01ESM4k8Mk47naSLmr6oO3oQbcUBcu4bCJnzF4kwHcy6JswwcNSONOzrcw20oklQ0Yontu2tewWmMKA7HR3Epk3FRP+s8V0xRfF5LSinzN0jjeXoHGKsjX4HVDtTbTL1PjxYKSla8OSJwG62MGkMHTIm4DqIV5ZCmzA2q/RQpUWdutM6bCIYv5E3VYBrWTAwqMhxAdfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1d1Eh1DcFpRu9Bo42hd8vw3mLKSRt1+nesqGT2gqpMk=;
 b=fAN/MWhCBVjMywaEwoj2WnrLaK2eekJSL7k8fcZ97x2hurQQJQlDmdC9gU8Z1ZDt6cwImuv3oSHZog8IfJgjm9xtjk9El6QTenJt21utbKwlDqYz2N3QfkOyUQePhxq29IpEgd1F2sNvg2pgzI4i4EUOrs43EUmLTn5FMvtyFDJKAGRB5ZrwH7AZ2Dj/Q1T1DlbrZ1k2FVhwdFcxMFtaYFmdms8xekgV+H/SDxePrL/4p8ZGKKFmKgde40QuEXs5EMruaHXdTEGcR1tmEXO8C/jSfuA8WYxclJxH6LbFSkdQfW8AT1GA5g9PEGfYd6p4xl3KBD7MMbJQePWYjmQo7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1d1Eh1DcFpRu9Bo42hd8vw3mLKSRt1+nesqGT2gqpMk=;
 b=nJ8hoHtmTcDB8VNuBWm0pI11RetYQfhI5I4BHZa7HDTWZgiyL6X9UmdaCHGHZXd9v4kARrVfGRcLSdr0Hgg9/GxwFamjeGqe/oQSL1H1IIMxh6bXH3dvK+rC7/ove0R0g5Pvq5t3viDVmCz7AIEAGnPk4Y3ABHkTucYUkJTjoVv5LeYx4E0dTX0nxeWRY+NjqClxNtMKsNP5HLe91OTRWny1oZqiglUUQxBR2PluxI2C/GvoNROHRLJXNhPJX7n0Sc/mu4bTMTvO27MecaflUl0FzrwCAXhfOhe80EGU5C6BvI2gqgRK7yfDqgSQJeK1AE/Nom2HwsIGKfpP8XHi5Q==
Received: from BL1PR13CA0207.namprd13.prod.outlook.com (2603:10b6:208:2be::32)
 by DS0PR12MB7945.namprd12.prod.outlook.com (2603:10b6:8:153::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 14:56:33 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:208:2be:cafe::d0) by BL1PR13CA0207.outlook.office365.com
 (2603:10b6:208:2be::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Tue,
 4 Feb 2025 14:56:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.0 via Frontend Transport; Tue, 4 Feb 2025 14:56:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 06:56:15 -0800
Received: from shredder.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Feb
 2025 06:56:11 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<petrm@nvidia.com>, <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 1/8] vxlan: Annotate FDB data races
Date: Tue, 4 Feb 2025 16:55:42 +0200
Message-ID: <20250204145549.1216254-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204145549.1216254-1-idosch@nvidia.com>
References: <20250204145549.1216254-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|DS0PR12MB7945:EE_
X-MS-Office365-Filtering-Correlation-Id: 61f96c7c-dacf-40ad-1a68-08dd452c1d4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UUDVz/la7ChTljsp2Grepz3ZWC3a7o71x5Wu0LJ5v75X8XX6oUdmHOw1YZAy?=
 =?us-ascii?Q?a5mRxiUSIIuLWyCTR81KpCI3+4nkDDmtyLTozOUPrl8hnKO/f88lER4WgEZY?=
 =?us-ascii?Q?Z9vqhYwA2FB52wVeHN6NMCDCoiUWSwZa0mKyAtCnpixIaER2JnBKwMhLlVTA?=
 =?us-ascii?Q?QPn63j26IP0BbW23K6HW3oakhbTFiMlN5qrD89lRUcGYhAhMcCMHQrAukfo5?=
 =?us-ascii?Q?fxbX9K4nRWxcLAD/ZCYqDB2hCTkCHN0tnKyv282X92AM3rp+ULDaZvXaa0VU?=
 =?us-ascii?Q?GdzZ+t+pkhN6qMhH245FcV3Ext0/vfTphsYBxw9v0JsmyWr28r6j09orwNtM?=
 =?us-ascii?Q?r4yx2onwtn2xC9cDj39D7AL22EsUkhB6btU+cGcUhJKc0YXOjrbMwWu0Qb6T?=
 =?us-ascii?Q?VTMl08ERhsFbf9LL4NBjWiEnBLeuGwwC/JZ7ijXM7aJBU5/1DnRHGXPYX5me?=
 =?us-ascii?Q?oCXMU4rL+RykIf+WbgaoIHgd2+42ApqJl5JzaIYZ3p30UaW4akdmd/9MJTrr?=
 =?us-ascii?Q?MQEtapxxkQ+ATmyE0H0LKYh4PCrU00ShZE1eJXlwnZAIqf0s4p9Z9gDauXWs?=
 =?us-ascii?Q?J4Igfkk4sb1cyYKyaObPMbljtEzGGYQkvze/c8zflCA6XEMxncQ+adH7UGd1?=
 =?us-ascii?Q?P8yJMUVJE+tWH7v27SeEeCflHkvor1/ad5D1YEZpaHyz6N9V/+Bv8XPvQCsH?=
 =?us-ascii?Q?eB/3+du/+BXlgkcfEaTwlCLn7BpayaTFt88SoMW9s/O7RJ8MqHLUWyJS6fk+?=
 =?us-ascii?Q?jlKaZXvNCEJ7hBBuSg2P8jimXosE/KsWaSvIv30oeLSD51Gg09E4lY7nrhwY?=
 =?us-ascii?Q?qouW7k9zsZ1RLx70pwKJy4e3BotG64uKTU23159aMuk91QGcGTaj+SQ19IId?=
 =?us-ascii?Q?xSbCVTVwvoL5styJfSf9YQoP96EcWMLQ3M213ek28I4qEw0FsLPHpx5V7oxb?=
 =?us-ascii?Q?hvWkLywJUFtiwC93M/2578qvrrKEBVYosicegB5rAq8y2cXi9bhwUzJF+Nlh?=
 =?us-ascii?Q?kG1PG9ePXLksJWg9/WaSU685RzJldQEEf9gD871uYSDKNqAypRGoYjGI+p4b?=
 =?us-ascii?Q?YIwwPHfhXPmSuyCi1lpX/233qI4+Wu7PUISLOIIU7WpAkOqXXbJ0aUhtY9iB?=
 =?us-ascii?Q?zC2j1K36V5BlUOTipn7CchjdJtwdUB4LzjO2ER73nx9hwP89f2ec9RBGWpxp?=
 =?us-ascii?Q?7E61zrRaqjHA9NxR1582Rj3SZz99FLVT2LUmqMm2ltxZgOxXBUdwOnVgQ9bZ?=
 =?us-ascii?Q?BDhvB3byMDK/GKcGdPX4KQ9WKeQ1Bi1oAg+wGVQ9UuG/CzXcBid9ZPVqHf7z?=
 =?us-ascii?Q?9b96XuTxId7Zdsw4i3DZAdcyoXWTlFeW3/UKqelPwpoyffnYSAdkUxAhobzv?=
 =?us-ascii?Q?2lYALE7iVGHfhd+UESePJSeQMQzdjOBENpSR33NUA9trRSp1MhdGuZXbxOw7?=
 =?us-ascii?Q?fiDLP5yiXzr0++zurUulbwnqP2JgDAULpwU4n4CqJb1qWY1CtQZ1RMoHhCRQ?=
 =?us-ascii?Q?E53TDvp/OTUV12g=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 14:56:32.6695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f96c7c-dacf-40ad-1a68-08dd452c1d4c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7945

The 'used' and 'updated' fields in the FDB entry structure can be
accessed concurrently by multiple threads, leading to reports such as
[1]. Can be reproduced using [2].

Suppress these reports by annotating these accesses using
READ_ONCE() / WRITE_ONCE().

[1]
BUG: KCSAN: data-race in vxlan_xmit / vxlan_xmit

write to 0xffff942604d263a8 of 8 bytes by task 286 on cpu 0:
 vxlan_xmit+0xb29/0x2380
 dev_hard_start_xmit+0x84/0x2f0
 __dev_queue_xmit+0x45a/0x1650
 packet_xmit+0x100/0x150
 packet_sendmsg+0x2114/0x2ac0
 __sys_sendto+0x318/0x330
 __x64_sys_sendto+0x76/0x90
 x64_sys_call+0x14e8/0x1c00
 do_syscall_64+0x9e/0x1a0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff942604d263a8 of 8 bytes by task 287 on cpu 2:
 vxlan_xmit+0xadf/0x2380
 dev_hard_start_xmit+0x84/0x2f0
 __dev_queue_xmit+0x45a/0x1650
 packet_xmit+0x100/0x150
 packet_sendmsg+0x2114/0x2ac0
 __sys_sendto+0x318/0x330
 __x64_sys_sendto+0x76/0x90
 x64_sys_call+0x14e8/0x1c00
 do_syscall_64+0x9e/0x1a0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x00000000fffbac6e -> 0x00000000fffbac6f

Reported by Kernel Concurrency Sanitizer on:
CPU: 2 UID: 0 PID: 287 Comm: mausezahn Not tainted 6.13.0-rc7-01544-gb4b270f11a02 #5
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014

[2]
 #!/bin/bash

 set +H
 echo whitelist > /sys/kernel/debug/kcsan
 echo !vxlan_xmit > /sys/kernel/debug/kcsan

 ip link add name vx0 up type vxlan id 10010 dstport 4789 local 192.0.2.1
 bridge fdb add 00:11:22:33:44:55 dev vx0 self static dst 198.51.100.1
 taskset -c 0 mausezahn vx0 -a own -b 00:11:22:33:44:55 -c 0 -q &
 taskset -c 2 mausezahn vx0 -a own -b 00:11:22:33:44:55 -c 0 -q &

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 05c10acb2a57..2f2c6606f719 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -227,9 +227,9 @@ static int vxlan_fdb_info(struct sk_buff *skb, struct vxlan_dev *vxlan,
 			be32_to_cpu(fdb->vni)))
 		goto nla_put_failure;
 
-	ci.ndm_used	 = jiffies_to_clock_t(now - fdb->used);
+	ci.ndm_used	 = jiffies_to_clock_t(now - READ_ONCE(fdb->used));
 	ci.ndm_confirmed = 0;
-	ci.ndm_updated	 = jiffies_to_clock_t(now - fdb->updated);
+	ci.ndm_updated	 = jiffies_to_clock_t(now - READ_ONCE(fdb->updated));
 	ci.ndm_refcnt	 = 0;
 
 	if (nla_put(skb, NDA_CACHEINFO, sizeof(ci), &ci))
@@ -434,8 +434,8 @@ static struct vxlan_fdb *vxlan_find_mac(struct vxlan_dev *vxlan,
 	struct vxlan_fdb *f;
 
 	f = __vxlan_find_mac(vxlan, mac, vni);
-	if (f && f->used != jiffies)
-		f->used = jiffies;
+	if (f && READ_ONCE(f->used) != jiffies)
+		WRITE_ONCE(f->used, jiffies);
 
 	return f;
 }
@@ -1009,12 +1009,12 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
 	    !(f->flags & NTF_VXLAN_ADDED_BY_USER)) {
 		if (f->state != state) {
 			f->state = state;
-			f->updated = jiffies;
+			WRITE_ONCE(f->updated, jiffies);
 			notify = 1;
 		}
 		if (f->flags != fdb_flags) {
 			f->flags = fdb_flags;
-			f->updated = jiffies;
+			WRITE_ONCE(f->updated, jiffies);
 			notify = 1;
 		}
 	}
@@ -1048,7 +1048,7 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
 	}
 
 	if (ndm_flags & NTF_USE)
-		f->used = jiffies;
+		WRITE_ONCE(f->used, jiffies);
 
 	if (notify) {
 		if (rd == NULL)
@@ -1481,7 +1481,7 @@ static enum skb_drop_reason vxlan_snoop(struct net_device *dev,
 				    src_mac, &rdst->remote_ip.sa, &src_ip->sa);
 
 		rdst->remote_ip = *src_ip;
-		f->updated = jiffies;
+		WRITE_ONCE(f->updated, jiffies);
 		vxlan_fdb_notify(vxlan, f, rdst, RTM_NEWNEIGH, true, NULL);
 	} else {
 		u32 hash_index = fdb_head_index(vxlan, src_mac, vni);
@@ -2852,7 +2852,7 @@ static void vxlan_cleanup(struct timer_list *t)
 			if (f->flags & NTF_EXT_LEARNED)
 				continue;
 
-			timeout = f->used + vxlan->cfg.age_interval * HZ;
+			timeout = READ_ONCE(f->used) + vxlan->cfg.age_interval * HZ;
 			if (time_before_eq(timeout, jiffies)) {
 				netdev_dbg(vxlan->dev,
 					   "garbage collect %pM\n",
-- 
2.48.1


