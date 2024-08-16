Return-Path: <netdev+bounces-119057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 364EF953F24
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 03:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E203A2817DA
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 01:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793EE29CEF;
	Fri, 16 Aug 2024 01:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPl6JlHa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3E01D69E;
	Fri, 16 Aug 2024 01:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723773249; cv=none; b=n5YZ3+4/rHqj9Rxo31JFsWtDmfmYZCIpuTWKkxLWGyH+0w2Q7NLxB4Ygwf0Wisz5pFLSHJE4wftyYSyHZK/5m+bu2W53P91HiK/1H+11qIloFVE6VqQ+3Eo9g56RYlIncaeJx4EGFjukfAKmJmTtROp/7c2sMWwpyENqvzp2A0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723773249; c=relaxed/simple;
	bh=99BYQNg5NO2msBnhqePqNcmYZ/gOW68j1ne/IGK9Ddc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zm/PMC6npEVRf+kWKOArUZT8MGJeUPmlAz+iGtgye6FbGNW9JvNKXVnR97kj+ldq+UWCn/AqOSU2X6yW6UVE9iZACiF8hv/BQWrpUUgm/8ioYwSvuVzhJ6Rr29RPtRM3OpLcsDLbu+246PwU4Uamz/PQ5GWJmndE62c5mer5eIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPl6JlHa; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-81fdaccd75eso55966839f.3;
        Thu, 15 Aug 2024 18:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723773247; x=1724378047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ppR2DydiZllP+trAUHg5OhvfbfAwRyROZQsxV3Rnk68=;
        b=gPl6JlHaDb/35+p9B7F/HlcSxxRUDW2JdxUrcMsXNOS7dUOeQzmz6e04+YUhqcNJcP
         l+LzR2FYyhInhED5VEquSv3TozXt6TaALQi/1EV/F3PrDqJEzhIwQSwsgVJU1plkWckN
         tcq5htABcbVXa9yJ/8m1ENkHWHZ1lNidwb5QCtVglVHQciwkmlyInCcKGAS1pyCyVJ/U
         reJ/YjsuOTT4gWVuPpUDd6Yy05feuQMjMPIx38M4nejSLAniWbZZCmyc0dEuv2sKx++E
         3OjdXM4vvQfx6dg4WGWX2CVuUWbdJSW7CZ1qtH1kLh8Q5fiEJPidQRhx5VjWlV+Hg5dt
         tIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723773247; x=1724378047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ppR2DydiZllP+trAUHg5OhvfbfAwRyROZQsxV3Rnk68=;
        b=VbIQ2YzYTtx84VrZpz4xRzuZTBEEezqds8X+Y4k7V00zkO6DKZglarskR/qpY+TNOt
         f34PnWJM5bVfNoFsRG3YN0+vLX246ghYFDomeLmLjxAlsDBeRmwDEGh4JFGhFRvgQ4or
         nckfx81w3ssiV3quQy8X9t+YWF3RLhIE1Jfry2YFVP2TTZxWgLiHX3FFq2dQkBr6UhYZ
         +VAr+J261eVdJtgHVwpUmBqmlyWIMIgpHvWcrDtlReGedyiHYZvui/iDUbofWPwljfZn
         2n+SSheeZ9MiZOsAo3YZz4u3uTXMBgt1iZbJyBl8Uj3vmoir+GDB6xVRhomfBybuSJpc
         tl6Q==
X-Gm-Message-State: AOJu0YzPfAMN+ur3euBhFIxlfR5qc2QGVnlBgtMhTJ4ZvtOdDErLUoOk
	6ALn2q0WG0UHH7/Dd576WML5U663RzB+g2KLGsaurmh5LDySbUrm7Z04Jry7YuGW4hNJ
X-Google-Smtp-Source: AGHT+IHdUxe+HiTeAE6A2ycx1pYgC6oVB2gTttkfxSkK7MWPz7cTsWiRMDM1uoQnqhuKQml8Wj64NQ==
X-Received: by 2002:a05:6602:6d8a:b0:824:d5d2:2c8f with SMTP id ca18e2360f4ac-824f260fd58mr170383539f.1.1723773246636;
        Thu, 15 Aug 2024 18:54:06 -0700 (PDT)
Received: from localhost.localdomain ([190.92.199.119])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-824e9b57727sm89975139f.41.2024.08.15.18.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 18:54:06 -0700 (PDT)
From: yangzhuorao <alex000young@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	security@kernel.org,
	xkaneiki@gmail.com,
	hackerzheng666@gmail.com,
	yangzhuorao <alex000young@gmail.com>
Subject: [PATCH] net: sched: use-after-free in tcf_action_destroy
Date: Fri, 16 Aug 2024 09:53:55 +0800
Message-Id: <20240816015355.688153-1-alex000young@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a uaf bug in net/sched/act_api.c.
When Thread1 call [1] tcf_action_init_1 to alloc act which saves
in actions array. If allocation failed, it will go to err path.
Meanwhile thread2 call tcf_del_walker to delete action in idr.
So thread 1 in err path [3] tcf_action_destroy will cause
use-after-free read bug.

Thread1                            Thread2
 tcf_action_init
  for(i;i<TCA_ACT_MAX_PRIO;i++)
   act=tcf_action_init_1 //[1]
   if(IS_ERR(act))
    goto err
   actions[i] = act
                                   tcf_del_walker
                                    idr_for_each_entry_ul(idr,p,id)
                                     __tcf_idr_release(p,false,true)
                                      free_tcf(p) //[2]
  err:
   tcf_action_destroy
    a=actions[i]
    ops = a->ops //[3]

We add lock and unlock in tcf_action_init and tcf_del_walker function
to aviod race condition.

==================================================================
BUG: KASAN: use-after-free in tcf_action_destroy+0x138/0x150
Read of size 8 at addr ffff88806543e100 by task syz-executor156/295

CPU: 0 PID: 295 Comm: syz-executor156 Not tainted 4.19.311 #2
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xcd/0x110 lib/dump_stack.c:118
 print_address_description+0x60/0x224 mm/kasan/report.c:255
 kasan_report_error mm/kasan/report.c:353 [inline]
 kasan_report mm/kasan/report.c:411 [inline]
 kasan_report.cold+0x9e/0x1c6 mm/kasan/report.c:395
 tcf_action_destroy+0x138/0x150 net/sched/act_api.c:664
 tcf_action_init+0x252/0x330 net/sched/act_api.c:961
 tcf_action_add+0xdb/0x370 net/sched/act_api.c:1326
 tc_ctl_action+0x327/0x410 net/sched/act_api.c:1381
 rtnetlink_rcv_msg+0x79e/0xa40 net/core/rtnetlink.c:4793
 netlink_rcv_skb+0x156/0x420 net/netlink/af_netlink.c:2459
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x4d6/0x690 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x6ce/0xce0 net/netlink/af_netlink.c:1907
 sock_sendmsg_nosec net/socket.c:652 [inline]
 __sock_sendmsg+0x126/0x160 net/socket.c:663
 ___sys_sendmsg+0x7f2/0x920 net/socket.c:2258
 __sys_sendmsg+0xec/0x1b0 net/socket.c:2296
 do_syscall_64+0xbd/0x360 arch/x86/entry/common.c:293
 entry_SYSCALL_64_after_hwframe+0x5c/0xc1
RIP: 0033:0x7fc19796b10d
RSP: 002b:00007fc197910d78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fc1979fe2e0 RCX: 00007fc19796b10d
RDX: 0000000000000000 RSI: 0000000020000480 RDI: 0000000000000004
RBP: 00007fc1979fe2e8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000246 R12: 00007fc1979fe2ec
R13: 00007fc1979fc010 R14: 5c56ebd45a42de31 R15: 00007fc1979cb008

Allocated by task 295:
 __kmalloc+0x89/0x1d0 mm/slub.c:3808
 kmalloc include/linux/slab.h:520 [inline]
 kzalloc include/linux/slab.h:709 [inline]
 tcf_idr_create+0x59/0x5e0 net/sched/act_api.c:361
 tcf_nat_init+0x4b7/0x850 net/sched/act_nat.c:63
 tcf_action_init_1+0x981/0xc90 net/sched/act_api.c:879
 tcf_action_init+0x216/0x330 net/sched/act_api.c:945
 tcf_action_add+0xdb/0x370 net/sched/act_api.c:1326
 tc_ctl_action+0x327/0x410 net/sched/act_api.c:1381
 rtnetlink_rcv_msg+0x79e/0xa40 net/core/rtnetlink.c:4793
 netlink_rcv_skb+0x156/0x420 net/netlink/af_netlink.c:2459
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x4d6/0x690 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x6ce/0xce0 net/netlink/af_netlink.c:1907
 sock_sendmsg_nosec net/socket.c:652 [inline]
 __sock_sendmsg+0x126/0x160 net/socket.c:663
 ___sys_sendmsg+0x7f2/0x920 net/socket.c:2258
 __sys_sendmsg+0xec/0x1b0 net/socket.c:2296
 do_syscall_64+0xbd/0x360 arch/x86/entry/common.c:293
 entry_SYSCALL_64_after_hwframe+0x5c/0xc1

Freed by task 275:
 slab_free_hook mm/slub.c:1391 [inline]
 slab_free_freelist_hook mm/slub.c:1419 [inline]
 slab_free mm/slub.c:2998 [inline]
 kfree+0x8b/0x1a0 mm/slub.c:3963
 __tcf_action_put+0x114/0x160 net/sched/act_api.c:112
 __tcf_idr_release net/sched/act_api.c:142 [inline]
 __tcf_idr_release+0x52/0xe0 net/sched/act_api.c:122
 tcf_del_walker net/sched/act_api.c:266 [inline]
 tcf_generic_walker+0x66a/0x9c0 net/sched/act_api.c:292
 tca_action_flush net/sched/act_api.c:1154 [inline]
 tca_action_gd+0x8b6/0x15b0 net/sched/act_api.c:1260
 tc_ctl_action+0x26d/0x410 net/sched/act_api.c:1389
 rtnetlink_rcv_msg+0x79e/0xa40 net/core/rtnetlink.c:4793
 netlink_rcv_skb+0x156/0x420 net/netlink/af_netlink.c:2459
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x4d6/0x690 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x6ce/0xce0 net/netlink/af_netlink.c:1907
 sock_sendmsg_nosec net/socket.c:652 [inline]
 __sock_sendmsg+0x126/0x160 net/socket.c:663
 ___sys_sendmsg+0x7f2/0x920 net/socket.c:2258
 __sys_sendmsg+0xec/0x1b0 net/socket.c:2296
 do_syscall_64+0xbd/0x360 arch/x86/entry/common.c:293
 entry_SYSCALL_64_after_hwframe+0x5c/0xc1

The buggy address belongs to the object at ffff88806543e100
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 0 bytes inside of
 192-byte region [ffff88806543e100, ffff88806543e1c0)
The buggy address belongs to the page:
flags: 0x100000000000100(slab)
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88806543e000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88806543e080: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff88806543e100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88806543e180: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff88806543e200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Signed-off-by: yangzhuorao <alex000young@gmail.com>
---
 net/sched/act_api.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index ad0773b20d83..d29ea69ba312 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -261,7 +261,7 @@ static int tcf_del_walker(struct tcf_idrinfo *idrinfo, struct sk_buff *skb,
 		goto nla_put_failure;
 	if (nla_put_string(skb, TCA_KIND, ops->kind))
 		goto nla_put_failure;
-
+	rcu_read_lock();
 	idr_for_each_entry_ul(idr, p, id) {
 		ret = __tcf_idr_release(p, false, true);
 		if (ret == ACT_P_DELETED) {
@@ -271,12 +271,14 @@ static int tcf_del_walker(struct tcf_idrinfo *idrinfo, struct sk_buff *skb,
 			goto nla_put_failure;
 		}
 	}
+	rcu_read_unlock();
 	if (nla_put_u32(skb, TCA_FCNT, n_i))
 		goto nla_put_failure;
 	nla_nest_end(skb, nest);
 
 	return n_i;
 nla_put_failure:
+	rcu_read_unlock();
 	nla_nest_cancel(skb, nest);
 	return ret;
 }
@@ -940,7 +942,7 @@ int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
 	err = nla_parse_nested(tb, TCA_ACT_MAX_PRIO, nla, NULL, extack);
 	if (err < 0)
 		return err;
-
+	rcu_read_lock();
 	for (i = 1; i <= TCA_ACT_MAX_PRIO && tb[i]; i++) {
 		act = tcf_action_init_1(net, tp, tb[i], est, name, ovr, bind,
 					rtnl_held, extack);
@@ -953,11 +955,12 @@ int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
 		/* Start from index 0 */
 		actions[i - 1] = act;
 	}
-
+	rcu_read_unlock();
 	*attr_size = tcf_action_full_attrs_size(sz);
 	return i - 1;
 
 err:
+	rcu_read_lock();
 	tcf_action_destroy(actions, bind);
 	return err;
 }
-- 
2.25.1


