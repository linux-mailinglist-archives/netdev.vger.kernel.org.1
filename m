Return-Path: <netdev+bounces-21595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C80763F6A
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 21:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1F581C212F0
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 19:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F0D4CE96;
	Wed, 26 Jul 2023 19:19:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF3D4CE68
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 19:19:50 +0000 (UTC)
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A478E271C
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 12:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1690399188; x=1721935188;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lF8CTnUAZRbA3b9HAtXZQKj6RYRt60rP8Jrkx6clZKc=;
  b=G/bI72tvptxjeFp5mIVruYolMMHBpKD9K+hNXC/WWqsBsSjzN+SOGdwL
   FQD99nZiqtd2jQzMM7n8UH/hkcpn5620n4nkWlsaM7+HcQUWSpkD2IK5R
   ZmZ/yQj/9QJ1ibAndFMSQp8KldcsCNPwK2Rrs0kP0XawaLHL20AH7uAkn
   k=;
X-IronPort-AV: E=Sophos;i="6.01,232,1684800000"; 
   d="scan'208";a="18717985"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-a65ebc6e.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 19:19:45 +0000
Received: from EX19MTAUWB002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
	by email-inbound-relay-iad-1e-m6i4x-a65ebc6e.us-east-1.amazon.com (Postfix) with ESMTPS id 792F46702C;
	Wed, 26 Jul 2023 19:19:44 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 26 Jul 2023 19:19:40 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.26) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 26 Jul 2023 19:19:37 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>, "Jamal
 Hadi Salim" <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, "Jiri
 Pirko" <jiri@resnulli.us>
CC: Vedang Patel <vedang.patel@intel.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>, syzkaller <syzkaller@googlegroups.com>
Subject: [PATCH v2 net] net/sched: taprio: Limit TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME to INT_MAX.
Date: Wed, 26 Jul 2023 12:19:28 -0700
Message-ID: <20230726191928.50768-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.171.26]
X-ClientProxiedBy: EX19D042UWB001.ant.amazon.com (10.13.139.160) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzkaller found zero division error [0] in div_s64_rem() called from
get_cycle_time_elapsed(), where sched->cycle_time is the divisor.

We have tests in parse_taprio_schedule() so that cycle_time will never
be 0, and actually cycle_time is not 0 in get_cycle_time_elapsed().

The problem is that the types of divisor are different; cycle_time is
s64, but the argument of div_s64_rem() is s32.

syzkaller fed this input and 0x100000000 is cast to s32 to be 0.

  @TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME={0xc, 0x8, 0x100000000}

We use s64 for cycle_time to cast it to ktime_t, so let's keep it and
set min/max for cycle_time.

While at it, we prevent overflow in setup_txtime() and add another
test in parse_taprio_schedule() to check if cycle_time overflows.

[0]:
divide error: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 1 PID: 103 Comm: kworker/1:3 Not tainted 6.5.0-rc1-00330-g60cc1f7d0605 #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
Workqueue: ipv6_addrconf addrconf_dad_work
RIP: 0010:div_s64_rem include/linux/math64.h:42 [inline]
RIP: 0010:get_cycle_time_elapsed net/sched/sch_taprio.c:223 [inline]
RIP: 0010:find_entry_to_transmit+0x252/0x7e0 net/sched/sch_taprio.c:344
Code: 3c 02 00 0f 85 5e 05 00 00 48 8b 4c 24 08 4d 8b bd 40 01 00 00 48 8b 7c 24 48 48 89 c8 4c 29 f8 48 63 f7 48 99 48 89 74 24 70 <48> f7 fe 48 29 d1 48 8d 04 0f 49 89 cc 48 89 44 24 20 49 8d 85 10
RSP: 0018:ffffc90000acf260 EFLAGS: 00010206
RAX: 177450e0347560cf RBX: 0000000000000000 RCX: 177450e0347560cf
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000100000000
RBP: 0000000000000056 R08: 0000000000000000 R09: ffffed10020a0934
R10: ffff8880105049a7 R11: ffff88806cf3a520 R12: ffff888010504800
R13: ffff88800c00d800 R14: ffff8880105049a0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88806cf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0edf84f0e8 CR3: 000000000d73c002 CR4: 0000000000770ee0
PKRU: 55555554
Call Trace:
 <TASK>
 get_packet_txtime net/sched/sch_taprio.c:508 [inline]
 taprio_enqueue_one+0x900/0xff0 net/sched/sch_taprio.c:577
 taprio_enqueue+0x378/0xae0 net/sched/sch_taprio.c:658
 dev_qdisc_enqueue+0x46/0x170 net/core/dev.c:3732
 __dev_xmit_skb net/core/dev.c:3821 [inline]
 __dev_queue_xmit+0x1b2f/0x3000 net/core/dev.c:4169
 dev_queue_xmit include/linux/netdevice.h:3088 [inline]
 neigh_resolve_output net/core/neighbour.c:1552 [inline]
 neigh_resolve_output+0x4a7/0x780 net/core/neighbour.c:1532
 neigh_output include/net/neighbour.h:544 [inline]
 ip6_finish_output2+0x924/0x17d0 net/ipv6/ip6_output.c:135
 __ip6_finish_output+0x620/0xaa0 net/ipv6/ip6_output.c:196
 ip6_finish_output net/ipv6/ip6_output.c:207 [inline]
 NF_HOOK_COND include/linux/netfilter.h:292 [inline]
 ip6_output+0x206/0x410 net/ipv6/ip6_output.c:228
 dst_output include/net/dst.h:458 [inline]
 NF_HOOK.constprop.0+0xea/0x260 include/linux/netfilter.h:303
 ndisc_send_skb+0x872/0xe80 net/ipv6/ndisc.c:508
 ndisc_send_ns+0xb5/0x130 net/ipv6/ndisc.c:666
 addrconf_dad_work+0xc14/0x13f0 net/ipv6/addrconf.c:4175
 process_one_work+0x92c/0x13a0 kernel/workqueue.c:2597
 worker_thread+0x60f/0x1240 kernel/workqueue.c:2748
 kthread+0x2fe/0x3f0 kernel/kthread.c:389
 ret_from_fork+0x2c/0x50 arch/x86/entry/entry_64.S:308
 </TASK>
Modules linked in:

Fixes: 4cfd5779bd6e ("taprio: Add support for txtime-assist mode")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Co-developed-by: Eric Dumazet <edumazet@google.com>
---
v2
  * Prevent overflow in setup_txtime() and parse_taprio_schedule()
    and add extack for such cases
    (Added cycle < 0 test in addition to Eric's suggestion)

v1: https://lore.kernel.org/netdev/20230726011432.19250-1-kuniyu@amazon.com/
---
 net/sched/sch_taprio.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 717ae51d94a0..61ec0c237440 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1015,6 +1015,11 @@ static const struct nla_policy taprio_tc_policy[TCA_TAPRIO_TC_ENTRY_MAX + 1] = {
 							      TC_FP_PREEMPTIBLE),
 };
 
+static struct netlink_range_validation_signed taprio_cycle_time_range = {
+	.min = 1,
+	.max = INT_MAX,
+};
+
 static const struct nla_policy taprio_policy[TCA_TAPRIO_ATTR_MAX + 1] = {
 	[TCA_TAPRIO_ATTR_PRIOMAP]	       = {
 		.len = sizeof(struct tc_mqprio_qopt)
@@ -1023,7 +1028,8 @@ static const struct nla_policy taprio_policy[TCA_TAPRIO_ATTR_MAX + 1] = {
 	[TCA_TAPRIO_ATTR_SCHED_BASE_TIME]            = { .type = NLA_S64 },
 	[TCA_TAPRIO_ATTR_SCHED_SINGLE_ENTRY]         = { .type = NLA_NESTED },
 	[TCA_TAPRIO_ATTR_SCHED_CLOCKID]              = { .type = NLA_S32 },
-	[TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME]           = { .type = NLA_S64 },
+	[TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME]           =
+		NLA_POLICY_FULL_RANGE_SIGNED(NLA_S64, &taprio_cycle_time_range),
 	[TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME_EXTENSION] = { .type = NLA_S64 },
 	[TCA_TAPRIO_ATTR_FLAGS]                      = { .type = NLA_U32 },
 	[TCA_TAPRIO_ATTR_TXTIME_DELAY]		     = { .type = NLA_U32 },
@@ -1159,6 +1165,11 @@ static int parse_taprio_schedule(struct taprio_sched *q, struct nlattr **tb,
 			return -EINVAL;
 		}
 
+		if (cycle < 0 || cycle > INT_MAX) {
+			NL_SET_ERR_MSG(extack, "'cycle_time' is too big");
+			return -EINVAL;
+		}
+
 		new->cycle_time = cycle;
 	}
 
@@ -1347,7 +1358,7 @@ static void setup_txtime(struct taprio_sched *q,
 			 struct sched_gate_list *sched, ktime_t base)
 {
 	struct sched_entry *entry;
-	u32 interval = 0;
+	u64 interval = 0;
 
 	list_for_each_entry(entry, &sched->entries, list) {
 		entry->next_txtime = ktime_add_ns(base, interval);
-- 
2.30.2


