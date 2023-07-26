Return-Path: <netdev+bounces-21436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 008BE7639B6
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 16:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEE32280C08
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 14:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88F51DA45;
	Wed, 26 Jul 2023 14:58:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD70C1DA22
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 14:58:19 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FB7C1
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 07:58:18 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-573cacf4804so83129127b3.1
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 07:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690383497; x=1690988297;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lBhaCl8hvaO5jdm15wrzz1B5v3mtcR3NB5eQ6Ev+f8k=;
        b=VQrXyOLYjRljirRGNue5Ze/fScjnvfQdT6p9FM5EjRnzKRTU+wr1Td9iPc2BJ2pLto
         lnGDlEJPDzy7baH2uiqyLxV/3xYZQBIYOsxwJf5DJmuDMFXEGKLGOmhZ1eSm84MmYpVE
         i0f04PGF8YNeRwWLk9Ijp7EuB+YlM2KkhkAWzxosMo6umHpJJ/Gc/mDwSVZEir2Se7UW
         9XDpei+xdJI5WT9arZnLj/I4ywOVpR284eSSvMRUxzl1DrKyLkXo5deuIJ18ljF5OKtM
         UJGpIeWa0cjW0MS8irse8GBC3ZCN9RWsblhqrKsqZyzS3YZJf4OLKlL4BEF6xJxKz9+C
         NMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690383497; x=1690988297;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lBhaCl8hvaO5jdm15wrzz1B5v3mtcR3NB5eQ6Ev+f8k=;
        b=JDETzUsC7tVGxKBqiAbfU9sTwy5a9ouJbRqLHCy4yv8KcmO+nDwxku6Doxzc3ydw0T
         WhWDCrL8HEJHTWws38dX/a9cjwMW38U0pCqo48zRN8JeO7Z6bTzCasl+kj9zJ/Ba9+UH
         mWtJoDEXE24BpFMmVaM7lAtCXJ+0mx9UMOHi34g/yQhA7okqRNi0GgUSNsYtDP+hd1zC
         JEH0rzZmEtvf94qqMQOZlAzRLvOXQym7a0kJyr1UgN+lLup0O0ahKojPzTRUenf1Na0X
         JWwvyAahnEUjFE9fet4K+wRjqygZXyVSTnDTXgofYPzdyzr9E9nsPsHWhl834putZjPA
         5VRg==
X-Gm-Message-State: ABy/qLYIwIpRi4kvfIzUBbX5toIp9Hq0k8ucd0fpLm3FEP2MBUF2bnNE
	zm3MgTp/RzXdKcBydesJGnD1bMbSg0Tj6A==
X-Google-Smtp-Source: APBJJlG/zq2UmA4gheKN7bDk0oA2Lo4/JEJcxrmW73g/lx5coPEzfmIisd1sEZLAKvYFtgqlDd0a5IJ4VfhzpA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:ac04:0:b0:576:6e4e:b87f with SMTP id
 k4-20020a81ac04000000b005766e4eb87fmr19827ywh.10.1690383497414; Wed, 26 Jul
 2023 07:58:17 -0700 (PDT)
Date: Wed, 26 Jul 2023 14:58:15 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230726145815.943910-1-edumazet@google.com>
Subject: [PATCH v2 net] net: flower: fix stack-out-of-bounds in fl_set_key_cfm()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Zahari Doychev <zdoychev@maxlinear.com>, Simon Horman <simon.horman@corigine.com>, 
	Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Typical misuse of

	nla_parse_nested(array, XXX_MAX, ...);

array must be declared as

	struct nlattr *array[XXX_MAX + 1];

v2: Based on feedbacks from Ido Schimmel and Zahari Doychev,
I also changed TCA_FLOWER_KEY_CFM_OPT_MAX and cfm_opt_policy
definitions.

syzbot reported:

BUG: KASAN: stack-out-of-bounds in __nla_validate_parse+0x136/0x2bd0 lib/nlattr.c:588
Write of size 32 at addr ffffc90003a0ee20 by task syz-executor296/5014

CPU: 0 PID: 5014 Comm: syz-executor296 Not tainted 6.5.0-rc2-syzkaller-00307-gd192f5382581 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
Call Trace:
<TASK>
__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
print_address_description mm/kasan/report.c:364 [inline]
print_report+0x163/0x540 mm/kasan/report.c:475
kasan_report+0x175/0x1b0 mm/kasan/report.c:588
kasan_check_range+0x27e/0x290 mm/kasan/generic.c:187
__asan_memset+0x23/0x40 mm/kasan/shadow.c:84
__nla_validate_parse+0x136/0x2bd0 lib/nlattr.c:588
__nla_parse+0x40/0x50 lib/nlattr.c:700
nla_parse_nested include/net/netlink.h:1262 [inline]
fl_set_key_cfm+0x1e3/0x440 net/sched/cls_flower.c:1718
fl_set_key+0x2168/0x6620 net/sched/cls_flower.c:1884
fl_tmplt_create+0x1fe/0x510 net/sched/cls_flower.c:2666
tc_chain_tmplt_add net/sched/cls_api.c:2959 [inline]
tc_ctl_chain+0x131d/0x1ac0 net/sched/cls_api.c:3068
rtnetlink_rcv_msg+0x82b/0xf50 net/core/rtnetlink.c:6424
netlink_rcv_skb+0x1df/0x430 net/netlink/af_netlink.c:2549
netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
netlink_unicast+0x7c3/0x990 net/netlink/af_netlink.c:1365
netlink_sendmsg+0xa2a/0xd60 net/netlink/af_netlink.c:1914
sock_sendmsg_nosec net/socket.c:725 [inline]
sock_sendmsg net/socket.c:748 [inline]
____sys_sendmsg+0x592/0x890 net/socket.c:2494
___sys_sendmsg net/socket.c:2548 [inline]
__sys_sendmsg+0x2b0/0x3a0 net/socket.c:2577
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f54c6150759
Code: 48 83 c4 28 c3 e8 d7 19 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe06c30578 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f54c619902d RCX: 00007f54c6150759
RDX: 0000000000000000 RSI: 0000000020000280 RDI: 0000000000000003
RBP: 00007ffe06c30590 R08: 0000000000000000 R09: 00007ffe06c305f0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f54c61c35f0
R13: 00007ffe06c30778 R14: 0000000000000001 R15: 0000000000000001
</TASK>

The buggy address belongs to stack of task syz-executor296/5014
and is located at offset 32 in frame:
fl_set_key_cfm+0x0/0x440 net/sched/cls_flower.c:374

This frame has 1 object:
[32, 56) 'nla_cfm_opt'

The buggy address belongs to the virtual mapping at
[ffffc90003a08000, ffffc90003a11000) created by:
copy_process+0x5c8/0x4290 kernel/fork.c:2330

Fixes: 7cfffd5fed3e ("net: flower: add support for matching cfm fields")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Zahari Doychev <zdoychev@maxlinear.com>
Cc: Simon Horman <simon.horman@corigine.com>
Cc: Ido Schimmel <idosch@nvidia.com>
---
 include/uapi/linux/pkt_cls.h | 4 +++-
 net/sched/cls_flower.c       | 5 +++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
index 7865f5a9885b9bc12332448418cfef8214391f09..4f3932bb712dcd9d5b5b5eb2252efee784abc7e5 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -710,9 +710,11 @@ enum {
 	TCA_FLOWER_KEY_CFM_OPT_UNSPEC,
 	TCA_FLOWER_KEY_CFM_MD_LEVEL,
 	TCA_FLOWER_KEY_CFM_OPCODE,
-	TCA_FLOWER_KEY_CFM_OPT_MAX,
+	__TCA_FLOWER_KEY_CFM_OPT_MAX,
 };
 
+#define TCA_FLOWER_KEY_CFM_OPT_MAX (__TCA_FLOWER_KEY_CFM_OPT_MAX - 1)
+
 #define TCA_FLOWER_MASK_FLAGS_RANGE	(1 << 0) /* Range-based match */
 
 /* Match-all classifier */
diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 8da9d039d964ea417700a2f59ad95a9ce52f5eab..9f0711da9c95907cf5c7fdbef74538a59f8b1a36 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -776,7 +776,8 @@ mpls_stack_entry_policy[TCA_FLOWER_KEY_MPLS_OPT_LSE_MAX + 1] = {
 	[TCA_FLOWER_KEY_MPLS_OPT_LSE_LABEL]    = { .type = NLA_U32 },
 };
 
-static const struct nla_policy cfm_opt_policy[TCA_FLOWER_KEY_CFM_OPT_MAX] = {
+static const struct nla_policy
+cfm_opt_policy[TCA_FLOWER_KEY_CFM_OPT_MAX + 1] = {
 	[TCA_FLOWER_KEY_CFM_MD_LEVEL]	= NLA_POLICY_MAX(NLA_U8,
 						FLOW_DIS_CFM_MDL_MAX),
 	[TCA_FLOWER_KEY_CFM_OPCODE]	= { .type = NLA_U8 },
@@ -1709,7 +1710,7 @@ static int fl_set_key_cfm(struct nlattr **tb,
 			  struct fl_flow_key *mask,
 			  struct netlink_ext_ack *extack)
 {
-	struct nlattr *nla_cfm_opt[TCA_FLOWER_KEY_CFM_OPT_MAX];
+	struct nlattr *nla_cfm_opt[TCA_FLOWER_KEY_CFM_OPT_MAX + 1];
 	int err;
 
 	if (!tb[TCA_FLOWER_KEY_CFM])
-- 
2.41.0.487.g6d72f3e995-goog


