Return-Path: <netdev+bounces-178856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D39EEA79386
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 18:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58B6016D470
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 16:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB4D16DEB3;
	Wed,  2 Apr 2025 16:58:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EBE33993
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 16:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.168.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743613133; cv=none; b=kszxS8ZkUt/Za26R4OzLtGWvguvtnl15piPxMrIrbivJimF0ywtsj/RwSF4Zp+ub1fZozJDvlu1RWjRsq+vUfu6iRhmKaETEvFcUvsS1lPa/q6UVZZ0+Z+OljTgIuPmFubSMmZkvCUs/NtoAgW0PG5A2HzWyZrwOQFd6aH8GexE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743613133; c=relaxed/simple;
	bh=mapKzw5OkN0Nyvk0qJJXGjvvDoiFFNDXN7gci+u4ruY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PpfmyOaa+l4iPBI1reKRlv2oVxisNJ8E2lrG/Q8gf97fJEfVlifYEJzqHvs2wvOf/x6MFSXJ4gLE7YKEKRsWLbf0lWGvkrhMO2KI8KJo8BEmuMPMzCwozV9QSrXYUbQxHZNAuZ7qE5qyPjT3BB3HbVjQK2/9Em1E1n3XE6t7wjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.229.168.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.193.154.185])
	by mtasvr (Coremail) with SMTP id _____wB3JGajbO1noq0tAQ--.38S3;
	Thu, 03 Apr 2025 00:58:12 +0800 (CST)
Received: from localhost (unknown [10.193.154.185])
	by mail-app3 (Coremail) with SMTP id zS_KCgAXw3WfbO1nYb0aAQ--.63831S2;
	Thu, 03 Apr 2025 00:58:07 +0800 (CST)
From: Lin Ma <linma@zju.edu.cn>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	lucien.xin@gmail.com,
	pieter.jansenvanvuuren@netronome.com,
	netdev@vger.kernel.org
Cc: Lin Ma <linma@zju.edu.cn>
Subject: [PATCH net] net: fix geneve_opt length integer overflow
Date: Thu,  3 Apr 2025 00:56:32 +0800
Message-Id: <20250402165632.6958-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.39.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgAXw3WfbO1nYb0aAQ--.63831S2
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/
X-CM-DELIVERINFO: =?B?JftfbwXKKxbFmtjJiESix3B1w3tPqcowV1L23Bze5QtIr9Db75bEBiiEybVhThS0pI
	APHkyPSxI2Xdeyd3ul0ToYuubmJIVStK4mh6XJdk5kYx1nMSL4elsDoPkvYhVj3nTdF8H0
	x+MWzRNJCZLoHhnOF0XzyYr7BDRcMckJpVHlJ7+X
X-Coremail-Antispam: 1Uk129KBj93XoW3Ww1rur43AF1ktFWkAF1UArc_yoW7ZFy7pa
	98GrWxGFs7Kr9xtrnYyF4kJF98t3Z0v3WxWrs7uryxA3WkW3yUGa4rKrWfKFn8uFWUZFW3
	Jwn8t3Wxt3WDZ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjcxG0xvY0x
	0EwIxGrVCF72vEw4AK0wACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jj7KsUUUUU=

struct geneve_opt uses 5 bit length for each single option, which
means every vary size option should be smaller than 128 bytes.

However, all current related Netlink policies cannot promise this
length condition and the attacker can exploit a exact 128-byte size
option to *fake* a zero length option and confuse the parsing logic,
further achieve heap out-of-bounds read.

One example crash log is like below:

[    3.905425] ==================================================================
[    3.905925] BUG: KASAN: slab-out-of-bounds in nla_put+0xa9/0xe0
[    3.906255] Read of size 124 at addr ffff888005f291cc by task poc/177
[    3.906646]
[    3.906775] CPU: 0 PID: 177 Comm: poc-oob-read Not tainted 6.1.132 #1
[    3.907131] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[    3.907784] Call Trace:
[    3.907925]  <TASK>
[    3.908048]  dump_stack_lvl+0x44/0x5c
[    3.908258]  print_report+0x184/0x4be
[    3.909151]  kasan_report+0xc5/0x100
[    3.909539]  kasan_check_range+0xf3/0x1a0
[    3.909794]  memcpy+0x1f/0x60
[    3.909968]  nla_put+0xa9/0xe0
[    3.910147]  tunnel_key_dump+0x945/0xba0
[    3.911536]  tcf_action_dump_1+0x1c1/0x340
[    3.912436]  tcf_action_dump+0x101/0x180
[    3.912689]  tcf_exts_dump+0x164/0x1e0
[    3.912905]  fw_dump+0x18b/0x2d0
[    3.913483]  tcf_fill_node+0x2ee/0x460
[    3.914778]  tfilter_notify+0xf4/0x180
[    3.915208]  tc_new_tfilter+0xd51/0x10d0
[    3.918615]  rtnetlink_rcv_msg+0x4a2/0x560
[    3.919118]  netlink_rcv_skb+0xcd/0x200
[    3.919787]  netlink_unicast+0x395/0x530
[    3.921032]  netlink_sendmsg+0x3d0/0x6d0
[    3.921987]  __sock_sendmsg+0x99/0xa0
[    3.922220]  __sys_sendto+0x1b7/0x240
[    3.922682]  __x64_sys_sendto+0x72/0x90
[    3.922906]  do_syscall_64+0x5e/0x90
[    3.923814]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[    3.924122] RIP: 0033:0x7e83eab84407
[    3.924331] Code: 48 89 fa 4c 89 df e8 38 aa 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 faf
[    3.925330] RSP: 002b:00007ffff505e370 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
[    3.925752] RAX: ffffffffffffffda RBX: 00007e83eaafa740 RCX: 00007e83eab84407
[    3.926173] RDX: 00000000000001a8 RSI: 00007ffff505e3c0 RDI: 0000000000000003
[    3.926587] RBP: 00007ffff505f460 R08: 00007e83eace1000 R09: 000000000000000c
[    3.926977] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffff505f3c0
[    3.927367] R13: 00007ffff505f5c8 R14: 00007e83ead1b000 R15: 00005d4fbbe6dcb8

Fix these issues by enforing correct length condition in related
policies.

Fixes: 925d844696d9 ("netfilter: nft_tunnel: add support for geneve opts")
Fixes: 4ece47787077 ("lwtunnel: add options setting and dumping for geneve")
Fixes: 0ed5269f9e41 ("net/sched: add tunnel option support to act_tunnel_key")
Fixes: 0a6e77784f49 ("net/sched: allow flower to match tunnel options")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
---
 net/ipv4/ip_tunnel_core.c  | 2 +-
 net/netfilter/nft_tunnel.c | 2 +-
 net/sched/act_tunnel_key.c | 2 +-
 net/sched/cls_flower.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index a3676155be78..b6b1bff6f24a 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -451,7 +451,7 @@ static const struct nla_policy
 geneve_opt_policy[LWTUNNEL_IP_OPT_GENEVE_MAX + 1] = {
 	[LWTUNNEL_IP_OPT_GENEVE_CLASS]	= { .type = NLA_U16 },
 	[LWTUNNEL_IP_OPT_GENEVE_TYPE]	= { .type = NLA_U8 },
-	[LWTUNNEL_IP_OPT_GENEVE_DATA]	= { .type = NLA_BINARY, .len = 128 },
+	[LWTUNNEL_IP_OPT_GENEVE_DATA]	= { .type = NLA_BINARY, .len = 127 },
 };
 
 static const struct nla_policy
diff --git a/net/netfilter/nft_tunnel.c b/net/netfilter/nft_tunnel.c
index 681301b46aa4..ec7089ab752c 100644
--- a/net/netfilter/nft_tunnel.c
+++ b/net/netfilter/nft_tunnel.c
@@ -335,7 +335,7 @@ static int nft_tunnel_obj_erspan_init(const struct nlattr *attr,
 static const struct nla_policy nft_tunnel_opts_geneve_policy[NFTA_TUNNEL_KEY_GENEVE_MAX + 1] = {
 	[NFTA_TUNNEL_KEY_GENEVE_CLASS]	= { .type = NLA_U16 },
 	[NFTA_TUNNEL_KEY_GENEVE_TYPE]	= { .type = NLA_U8 },
-	[NFTA_TUNNEL_KEY_GENEVE_DATA]	= { .type = NLA_BINARY, .len = 128 },
+	[NFTA_TUNNEL_KEY_GENEVE_DATA]	= { .type = NLA_BINARY, .len = 127 },
 };
 
 static int nft_tunnel_obj_geneve_init(const struct nlattr *attr,
diff --git a/net/sched/act_tunnel_key.c b/net/sched/act_tunnel_key.c
index ae5dea7c48a8..2cef4b08befb 100644
--- a/net/sched/act_tunnel_key.c
+++ b/net/sched/act_tunnel_key.c
@@ -68,7 +68,7 @@ geneve_opt_policy[TCA_TUNNEL_KEY_ENC_OPT_GENEVE_MAX + 1] = {
 	[TCA_TUNNEL_KEY_ENC_OPT_GENEVE_CLASS]	   = { .type = NLA_U16 },
 	[TCA_TUNNEL_KEY_ENC_OPT_GENEVE_TYPE]	   = { .type = NLA_U8 },
 	[TCA_TUNNEL_KEY_ENC_OPT_GENEVE_DATA]	   = { .type = NLA_BINARY,
-						       .len = 128 },
+						       .len = 127 },
 };
 
 static const struct nla_policy
diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 03505673d523..099ff6a3e1f5 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -766,7 +766,7 @@ geneve_opt_policy[TCA_FLOWER_KEY_ENC_OPT_GENEVE_MAX + 1] = {
 	[TCA_FLOWER_KEY_ENC_OPT_GENEVE_CLASS]      = { .type = NLA_U16 },
 	[TCA_FLOWER_KEY_ENC_OPT_GENEVE_TYPE]       = { .type = NLA_U8 },
 	[TCA_FLOWER_KEY_ENC_OPT_GENEVE_DATA]       = { .type = NLA_BINARY,
-						       .len = 128 },
+						       .len = 127 },
 };
 
 static const struct nla_policy
-- 
2.17.1


