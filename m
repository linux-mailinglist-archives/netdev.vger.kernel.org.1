Return-Path: <netdev+bounces-245640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B7ACD418F
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 15:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46B413006F46
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 14:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E6A2D6E4B;
	Sun, 21 Dec 2025 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bqV4O26H"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011032.outbound.protection.outlook.com [40.107.208.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D5228B4FE
	for <netdev@vger.kernel.org>; Sun, 21 Dec 2025 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766328597; cv=fail; b=ig3865D9tR16POVNftSnDjBg3+K7uDsqjg+MBkXrYUPKTwtFBHXdxqn9a/bMXcCW8jHEiN4w5DVqc8FBfp9VrHvC+h501dFJndDrX3ttympEUMpThjWlgWK4N/WEgm2uVCivkxSOJmGaOGWXztMQDZnJeOxdWV6xJv6nYfbbB/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766328597; c=relaxed/simple;
	bh=KXeCl2HR80bwxPOToGt6iudepGK0ICcITI5G5BUH/4k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rd8RbiVMP/ohLKX4+p/8gLZFLd6oV+8REmjxZAB3YHsA39W2QKR/CAPIP7K2CmZZPNKMJcIKCUgdtdWIRzh/PXpiayBFLq4Kmw2RBowuDoh7PHvGv2KPxEvsk0ggKY9Ls0EayQ3NkHiQhlIkzHiM/poRZh+d12lUTP8t0nuaX8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bqV4O26H; arc=fail smtp.client-ip=40.107.208.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yCg20uspf06d5+xH1BzqJp7sy1wKIMRoNCEBuMqEC64bgcgKCfjhIEJTymgZQPHTcdn5CtIPG9Yh5aeb5Cd0uFlndtAqwMi73G8eCRpnA9We/Cu2h638USdGE4uX5umy7Nic9Xv5jeSqtq2LEf713XxIoIQ9SqXOS29LEWhUcOt8s5W33W2PzyrBhpIuFvPQcz/fYDuuPtrzJ6Pua7QPbxERAGaxWujGIpe0Yv/RYwSJj6A5g21Zp+cV01DBQBVJrWcNiiTcCmn2RNbHtO5ipgymIfwoKiH5XYdmgX4vUdvWDPNFiHqqyUOby4DLbMIE91yK/rvO4H+mVhe1+3jaeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYDKIqFGvMi4B4Pfimkr3DUsXToThwReZstusdOfXkE=;
 b=Zlw4e8GQy8PWHtP3lrViczK04wdrlBLq+bNw3kpZbEqDWweyjxMvdAezKedJNWQVOn9lq90qm7yJV8Vobl1I79ou3lNd2gTUr0CDfARZcXRXOnbKwdEJTB0RXKwGDd6xvUV8MnVVeY5xbo8XM690Y62aoneegPEOydt39h35bBrqa/UAmBzL23K97Jq3W0KzowbHEJ6/hRdjkPCRfJR7HCg4Np4x4WrkC9TggD5t7L3bzEVGirT9DHQuk1V5Dc7u8IDt8GNEqF3/zrKwkFFRIpeLDTFVNv8QestO63MQmbXrZgdBQghAavUddJNUjIcGbeRq/EhTUKHtI0Oqz5VI1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYDKIqFGvMi4B4Pfimkr3DUsXToThwReZstusdOfXkE=;
 b=bqV4O26HVJaIDz3ZxQ2247/hbPoG90nMt4CK5/Mkt94eC2WwZfME23dAZ//Jc0E0LfQ+qjtfc2UC+gNKzQACYASFmH2gMWaghnLCV/6yGNx6yzcaeTVC1ETrRyS1evskzq9AURF/W1HbWF0Q1qyFqCQjNNwgsD3/rSD4tHT/xZ3saLJMr69Tc6ECiktOnCCK4grgD6BdzUshhR2G7uNu5zXERccycPd8mjYH2TR7+Xkx3DS0ZS+ZkEQLaMgl9Q+t4yKc56mQScv2sTWYxvfsXP1grsA9txbVuz9vy0Lw0OxP/64qF5o5ZmWRq4CC4HkijFjDOQ7ZqPwN5/cq6v6CFQ==
Received: from BYAPR05CA0033.namprd05.prod.outlook.com (2603:10b6:a03:c0::46)
 by CY8PR12MB7291.namprd12.prod.outlook.com (2603:10b6:930:54::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Sun, 21 Dec
 2025 14:49:51 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:a03:c0:cafe::14) by BYAPR05CA0033.outlook.office365.com
 (2603:10b6:a03:c0::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Sun,
 21 Dec 2025 14:49:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Sun, 21 Dec 2025 14:49:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 21 Dec
 2025 06:49:37 -0800
Received: from shredder.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 21 Dec
 2025 06:49:34 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <horms@kernel.org>,
	<penguin-kernel@I-love.SAKURA.ne.jp>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 1/2] ipv4: Fix reference count leak when using error routes with nexthop objects
Date: Sun, 21 Dec 2025 16:48:28 +0200
Message-ID: <20251221144829.197694-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.52.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|CY8PR12MB7291:EE_
X-MS-Office365-Filtering-Correlation-Id: 81ec2a44-4187-43db-ac8a-08de40a0323d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LAQNdiMFAi0Rc+AGA7/NbPiihtE34pj2etHlpHyJiZc9SuAYVdRFH7ucCHRe?=
 =?us-ascii?Q?ZVLgIyQuGTGGdsRmYUsZb+aUzyF8ntt9+lYgOOsGMay7zu/1jLgX1dqYkdJS?=
 =?us-ascii?Q?F8oDhP62fy8uR0jTXS+R4l5bR3XMp6QKE27xqkj2f3DupC/SmBIPUBv9Ocu2?=
 =?us-ascii?Q?dVhqdAkXobaYFtSEj+KB+Gnzdg9zcqsnIiS8vNa6vN0H2mPEybyhLf/SmkU5?=
 =?us-ascii?Q?hfDk7V3I12XWWqtBxAKxdLegNBoKTLpPvR8Cy0b3TxzzsrOPBco9UtIc5rq1?=
 =?us-ascii?Q?J/MPn+Ll8CEVoVWWrw88uCaRtZE6cM5XZsiEgJKvV+VZT0FWFVt1tmjXD4pK?=
 =?us-ascii?Q?zmAel38hZzd7aulCRF9N1srSjNB0F2DVEsKTVAhXpGObLQfz+aghEMQCx+5W?=
 =?us-ascii?Q?jxaSLi7mMrakAFGokoQO/yQLVAaNI7U21+eG0jo2IH59+Xq0m3BoBIQMAkSv?=
 =?us-ascii?Q?OT70xtea8MfwQokywqbJF6KfKbPJXs7gvnfXFADTwBrNRiJyNtuVrdq+6s8n?=
 =?us-ascii?Q?suuaRtbuqVWcwD6v3ytpiCW6dCR76q9q0Pe0AKdU1NKTsI5/UHWnrVyWxebX?=
 =?us-ascii?Q?iT3tJBYURRRFaQlxwbUYDcppDvWZnvnktpHFEPus6lBwOfh+PZt+B0ZhHmrK?=
 =?us-ascii?Q?SbNu9HLaG8VutwKGPsEpdvczn0KtPDotdSw8KfkAkDoR0AXYILch7W0Qr+ks?=
 =?us-ascii?Q?U0Okom3CoAfT0OT/OJaT02vnp6nDniRWuAFYeVVWbxAThQAZoxmwDHcWo3vQ?=
 =?us-ascii?Q?Q7kkuknlSeJxiBms1+K+RrzEF4MQysE3xhHEF6axqBUHUa+zhTdCETfJFZLW?=
 =?us-ascii?Q?YlGQP5FrBpBGtfcTvQfaN9FeOi5MtKiQj8xBmb6tVqispI2dARAOo233ZPRY?=
 =?us-ascii?Q?JRCeQHJCSCrUY3Fvm8xtpgxbgYTWM/SvP+BnmXkHzIcy6awbOp48p7zDkSY5?=
 =?us-ascii?Q?iq9SiJgoPQvlKIpQ+nD7s1X7IV5EfFd76C5YFXrA9NTt4psctlR0n9kYFu8Z?=
 =?us-ascii?Q?+ZOh8SC6ZeC8hUrviqYMHisDYiN4G+l2Yyva/+37qNMReZbC4xq0823DrElR?=
 =?us-ascii?Q?5Nca7wmW/hBfjVgJKTV9XTx0kIao5OgSbn0Be2Zjgm3gaBS+EsSQRXpgO2lf?=
 =?us-ascii?Q?NbaeZ1hmEV515m/1me1UZ/sX9XCiQXnW04RAbqi8ubxv7olBxZXqGnWT4NrO?=
 =?us-ascii?Q?ew9P8o2dnuKaYdIaBVG/FPVeN+BKIuFFVCw4XgyDYEcHFVW91VhFCrPFlqxZ?=
 =?us-ascii?Q?LXCmP2vJ7/z6rhKEgxT8Gl5adSBaiGKEHpLoLmf5BH22MYeFoQtkoePAxgVA?=
 =?us-ascii?Q?Oryuh2x3+8h2dfSLsTuJRKde9c84mV6Al9D4zXCtHRZwAgwAFmZ8An5CiRga?=
 =?us-ascii?Q?c+VlQeHdhGxSiAvDwE5DjKJ9BE5qkEPIvTNtPhu5BYfFOXjJjz4XIz37dVS+?=
 =?us-ascii?Q?4JNjW/0ar5KDKRY5L1UC20bEXNpaSuUGjU5nQa3faD6NDGgPe+Ke8+p/Hzi5?=
 =?us-ascii?Q?nl6j8TkEvIKENzDYdU6WkKPTb/Qi5dQifWHUI+CGROppIgEwwbz3UraN3jsE?=
 =?us-ascii?Q?7xq0w4r+dMOn4Wocieg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2025 14:49:51.3609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ec2a44-4187-43db-ac8a-08de40a0323d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7291

When a nexthop object is deleted, it is marked as dead and then
fib_table_flush() is called to flush all the routes that are using the
dead nexthop.

The current logic in fib_table_flush() is to only flush error routes
(e.g., blackhole) when it is called as part of network namespace
dismantle (i.e., with flush_all=true). Therefore, error routes are not
flushed when their nexthop object is deleted:

 # ip link add name dummy1 up type dummy
 # ip nexthop add id 1 dev dummy1
 # ip route add 198.51.100.1/32 nhid 1
 # ip route add blackhole 198.51.100.2/32 nhid 1
 # ip nexthop del id 1
 # ip route show
 blackhole 198.51.100.2 nhid 1 dev dummy1

As such, they keep holding a reference on the nexthop object which in
turn holds a reference on the nexthop device, resulting in a reference
count leak:

 # ip link del dev dummy1
 [   70.516258] unregister_netdevice: waiting for dummy1 to become free. Usage count = 2

Fix by flushing error routes when their nexthop is marked as dead.

IPv6 does not suffer from this problem.

Fixes: 493ced1ac47c ("ipv4: Allow routes to use nexthop objects")
Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Closes: https://lore.kernel.org/netdev/d943f806-4da6-4970-ac28-b9373b0e63ac@I-love.SAKURA.ne.jp/
Reported-by: syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/fib_trie.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index 59a6f0a9638f..7e2c17fec3fc 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -2053,10 +2053,11 @@ int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)
 				continue;
 			}
 
-			/* Do not flush error routes if network namespace is
-			 * not being dismantled
+			/* When not flushing the entire table, skip error
+			 * routes that are not marked for deletion.
 			 */
-			if (!flush_all && fib_props[fa->fa_type].error) {
+			if (!flush_all && fib_props[fa->fa_type].error &&
+			    !(fi->fib_flags & RTNH_F_DEAD)) {
 				slen = fa->fa_slen;
 				continue;
 			}
-- 
2.52.0


