Return-Path: <netdev+bounces-138216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8C69ACA0C
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 14:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 872EBB22240
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 12:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815D74436E;
	Wed, 23 Oct 2024 12:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bTI/RtJu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC48196
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 12:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729686664; cv=fail; b=nkdcMp4Prm3F4DXRHkQ1Hg9QI+HzhzeDKHpbST83/E0hE/qVqlTBQsnOJEnfAQ5XOHOgKUa4pCgOfrqy8PzOe7wNbjnVHfCgef7GKmZ1CdIP0V1JEByh8iW3iB0AN28AEeNWvvVvNqtWr2NzaY0J8n8HWpHDBigNr4aF1QAeZIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729686664; c=relaxed/simple;
	bh=5HxQuc+xEkFJLJ5che9kB0dDDPSGTtaC11AWTK17Jhs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lw8QujPA5O47zCQD/54EO2ATQUX+7xSsGFXvPawoCjteq0XRdZFNv/cAFDXFTlnRLzSLi5z0NUDbqiZV5koYDcnNMKaqIHCQ4OkTfgu8lkZTDJ1ril2Lw94IHoBxkv6dgSsG0/zspfx+YHy/Mt3nUx7d8iMgM8u2dPpNxSTnfZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bTI/RtJu; arc=fail smtp.client-ip=40.107.93.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xw8N3wm+f2dqn9j/ob4K5CQ58+V3cOQ36zyef5AUJwPmCxnKOrtzYrp2xCDuyNUbI84F5nehd7YY9/2Ffc+ExoTOUEjrosImtAEEiwiG3J5DW3p/Zh+lD/5rT9Hjfg4VXQyreoAxX81ASSDYT8ga4NfV+xXP9XwzTTdyFbw4x3y4wkCF31ExTXh0b/3AMYce5VoMSnHRc0OUvfw4Xtnmgde287iodStkA62F+/VgJicypFEFUJbZTORo55gY3kOKDa6ubb/62uVResFIzHipWEVtei+8Kvk/Y/3sSmk77Itnzbs59cu/s4HrA6CyNVY11UHumSXVCqxXtV3/VjcyHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BO7F85MTmKxdF+29D63q6VIeJ3PBZOMM/trsEHjvcn8=;
 b=HAc2YGqGiHr531ZbOkv0DzSBSU+rmlii9Gsfv5S+U8mtYX2I1QodZhfU7Um++tKaAQCEJTzHEep9W55qieE61wgslMEn4QOFdnLFOJJhl4s76YnqoRlvEeSPnV20PhiohlVBTC1a+IAbptUgEdmY0zBE+VzuC/8T9CSEx9CfTMqAvluY12Ok/TpkjodcH3yztdCavjZNNA+CDVhvBztPyh18HOUKBbPGq7OFZKLbP3c4oxwNbMubWwfGOygaf1DUp/xmlYAne6zOldzljiu+Tool5l6ZgitUEH01tvcRE4nNUm/Zrt/f6S2VjxTIuk/csq20cyq+pvAVX0yG5KYpyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BO7F85MTmKxdF+29D63q6VIeJ3PBZOMM/trsEHjvcn8=;
 b=bTI/RtJuhw7UDoz/tzGIiz3t3sxELeV4ZsBCPIjYog2FCBPpOLdGsHQadCzrtAPq5zGxPurDg85gZ0XMYmHdl+AvbtpLg1Eyj+hkxMZ9MbZP9FEMd/oN1Bd04fbhDa0Iy2HptvX7NIP5yoImpd17zFddoJkequqBpGydc2NBuEhDCZfj0EBfoLp6LwEongmVh9rf7HTAuVDmoWMwCerNLKWfzZAgbAJ4cNZtCLLU43ZE5dW4e8iwceHkq/4JNAjeHFGifI0sUNRkwzsZOpGHWjMncTn2PMAIzGbK6EOinRZXCHmJf/vIqmhVQwlASDmn0V2vwkhr+kqq3uNSdNvPyA==
Received: from SJ0PR13CA0068.namprd13.prod.outlook.com (2603:10b6:a03:2c4::13)
 by MN2PR12MB4173.namprd12.prod.outlook.com (2603:10b6:208:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 12:30:56 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::1c) by SJ0PR13CA0068.outlook.office365.com
 (2603:10b6:a03:2c4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Wed, 23 Oct 2024 12:30:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 12:30:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 23 Oct
 2024 05:30:40 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 23 Oct
 2024 05:30:36 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <horms@kernel.org>,
	<pshelar@nicira.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net v2] ipv4: ip_tunnel: Fix suspicious RCU usage warning in ip_tunnel_find()
Date: Wed, 23 Oct 2024 15:30:09 +0300
Message-ID: <20241023123009.749764-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.47.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|MN2PR12MB4173:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fd2b63f-8f5c-4335-4838-08dcf35e8a50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WlibVjRT9xbpi6/UmuMPvL+xOQ3GmN3AYrP6VxJJ4LcDeQzaCBKNv7SE8Aqc?=
 =?us-ascii?Q?vDbHZxV41ECEMdu0XEG1IKNTrR1xtZhQrYcIRHcaecm9A1LP0Vyf89oCtDzg?=
 =?us-ascii?Q?c4nCjZskqJmdWmFFDLFYtP8Ulo5to26llv+DubrrLmTeXrhn8kTU+zy05Ud8?=
 =?us-ascii?Q?/DgeOUU0+FVmAbCxA8H+5jCdTk3Q5dl8xGbNm0yqFNsNXCiCVEqs2bFRkcKL?=
 =?us-ascii?Q?qkfCCyViq+W4+IFBzNMqmSEuL9qYLXc6nR7X5isK0JA4joN3GCl7YfH4Cc4u?=
 =?us-ascii?Q?QfaZI0NVw2tMi8+y+GQgGZy5Ps0y1T8OpUwoHeT7aefm5RmqU3oWNarA+n91?=
 =?us-ascii?Q?TeNlaGP7DIjm/VEa6E5qst0JbuLGc6qz485+gIwI5vvgd00MdPgm9UjgbKqv?=
 =?us-ascii?Q?bG94vnxW3F6a4L7gwDB67xgqC1Vy32pFWEaCjr4Lz6KBCS6R5wYW71OZF1zp?=
 =?us-ascii?Q?roLigW3G/dJZ7kzMB1IlYaCEY5TVYjIxt8MbRGs+nQzR7TTapqfuayIeHybO?=
 =?us-ascii?Q?qigAHJztyxZIC/AZ/nVfJC5zW2hmLLuC9pWpITJSicbFIZGInlcp1cv/nJuS?=
 =?us-ascii?Q?locYTxPppbHJ7kWuqHct5j/Pg6+T4JYZ3gQs4rCtQimm++evqsqiysdlmoQ0?=
 =?us-ascii?Q?gvSnmFrIfZ7XNHEQG+gwIJp4NkPEJdhO6DDjSYbbsMl/JmojUlo1AholetsC?=
 =?us-ascii?Q?wrrZ57kBnNcaneZQXh23TbDbTOaWgurTUJCl3WhArKM8D8BeFM81Wq/m2Aff?=
 =?us-ascii?Q?vTX4zqq3mKk68QzsSFCb+lXO1ojQBsEVCQ/LVnB4uR+W5Vhr9+x+/+9nuoSS?=
 =?us-ascii?Q?qq2g7sq1vdRUvnCzvbYcWXTP5d3XZbaEKz2dx7HELoZxaNnOhoBrC7oJc3Cb?=
 =?us-ascii?Q?vQp3G63RvrWtDXc8A7vZ3AAYra019S3JQTK39eqb9E41GxBrRzpOYMvtYDFc?=
 =?us-ascii?Q?qjruMY6P3XMLaG69RWOHXCg6C3v1oeTwxyz31mZKg2TmrMYO7fQ6Q4VOO1SM?=
 =?us-ascii?Q?urgXVlLtptCmzZVGscQ2xPCiq/FLOw8zvh6VbXZn5rdylwdRY59iKL9X2FRt?=
 =?us-ascii?Q?+dKuQ2AXwWWrX+k9QGURKA71edSqX5aKvgMuS1pzJK/g/SV//fn2t9EeziSV?=
 =?us-ascii?Q?5xfDfAcLYXKOWQG+Fe3er9CPfE2yrs/2ROwEUKF7TB6Cm0S8E4IgL2IQeBsI?=
 =?us-ascii?Q?SZUL5ZhI8pCB3MsFVxclLF+0YJgs/JIgi0PF9nuV22xfocobWPQ3j4dSgiIz?=
 =?us-ascii?Q?111cgpvEa+LNUl+XD83W0tOqsbGa/AnxvsoA9U7GMon4iUfqsmAJtvXp4QD+?=
 =?us-ascii?Q?dtHd/uf6IvHQIA8z2BfQ+esMIcTW9872jxQHeA1COxjUXL8M8VTngLirPL6E?=
 =?us-ascii?Q?wl33BuwS448JwvGAGskTHuvPOyAQKDA8Ak6dpGyOY2w/SiBiSQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 12:30:55.2447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd2b63f-8f5c-4335-4838-08dcf35e8a50
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4173

The per-netns IP tunnel hash table is protected by the RTNL mutex and
ip_tunnel_find() is only called from the control path where the mutex is
taken.

Add a lockdep expression to hlist_for_each_entry_rcu() in
ip_tunnel_find() in order to validate that the mutex is held and to
silence the suspicious RCU usage warning [1].

[1]
WARNING: suspicious RCU usage
6.12.0-rc3-custom-gd95d9a31aceb #139 Not tainted
-----------------------------
net/ipv4/ip_tunnel.c:221 RCU-list traversed in non-reader section!!

other info that might help us debug this:

rcu_scheduler_active = 2, debug_locks = 1
1 lock held by ip/362:
 #0: ffffffff86fc7cb0 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x377/0xf60

stack backtrace:
CPU: 12 UID: 0 PID: 362 Comm: ip Not tainted 6.12.0-rc3-custom-gd95d9a31aceb #139
Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
Call Trace:
 <TASK>
 dump_stack_lvl+0xba/0x110
 lockdep_rcu_suspicious.cold+0x4f/0xd6
 ip_tunnel_find+0x435/0x4d0
 ip_tunnel_newlink+0x517/0x7a0
 ipgre_newlink+0x14c/0x170
 __rtnl_newlink+0x1173/0x19c0
 rtnl_newlink+0x6c/0xa0
 rtnetlink_rcv_msg+0x3cc/0xf60
 netlink_rcv_skb+0x171/0x450
 netlink_unicast+0x539/0x7f0
 netlink_sendmsg+0x8c1/0xd80
 ____sys_sendmsg+0x8f9/0xc20
 ___sys_sendmsg+0x197/0x1e0
 __sys_sendmsg+0x122/0x1f0
 do_syscall_64+0xbb/0x1d0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: c54419321455 ("GRE: Refactor GRE tunneling code.")
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
    v2:
    * Add a lockdep expression to hlist_for_each_entry_rcu() instead of
      using hlist_for_each_entry()

 net/ipv4/ip_tunnel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index d591c73e2c0e..25505f9b724c 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -218,7 +218,7 @@ static struct ip_tunnel *ip_tunnel_find(struct ip_tunnel_net *itn,
 
 	ip_tunnel_flags_copy(flags, parms->i_flags);
 
-	hlist_for_each_entry_rcu(t, head, hash_node) {
+	hlist_for_each_entry_rcu(t, head, hash_node, lockdep_rtnl_is_held()) {
 		if (local == t->parms.iph.saddr &&
 		    remote == t->parms.iph.daddr &&
 		    link == READ_ONCE(t->parms.link) &&
-- 
2.47.0


