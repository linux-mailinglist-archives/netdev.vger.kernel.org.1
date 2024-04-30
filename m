Return-Path: <netdev+bounces-92559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 629A38B7E3F
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 19:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 800A41C21209
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 17:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAB317B4E1;
	Tue, 30 Apr 2024 17:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BmCtr7xA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791BE179654
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 17:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714497104; cv=none; b=iPi5FVlsoX1hXTQtbiXJtZfjQjCdgjAfZEK081a3DGlBhcMrAcYFlgJEaiVfimYKXyrqf4QH0zb8T3Vv4dqNyBnKnEXYC/pd08kZVHjq2Ds7iS0iMVXtu0qZ6O1fNmLESQoO3rNHn4SapxKCjaIrBHrFw3FYQOxxZCAq5H2lIA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714497104; c=relaxed/simple;
	bh=8X0UHY77IM6d1PXdNcSq6p0Xp+tqUykLoEp0INvARGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fmCm/EG7iM1OhwTnqUuqsO3bdKuMkD/1uVzUfPYEzYUoCWjRsdEMxjdbxSQl34wVqN+avoB2xUiC45XP8XwF5YqfrAm37gTs4ecV2zVc3o2a+1zTOh+mM3cKOIBAZ4i7OroFDHtaCUpt0PGJVhcA2vc/wC/Ok3jBziNZ/PJ1pFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BmCtr7xA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714497101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H+yz/Du7bMZUkgZkgBc01otupz3qNmd+HiaOEpj7YFQ=;
	b=BmCtr7xA41+gVbOzwTqeFNLzk4jM0MeATCxbFr6QF2nh+3tf/LrlZurXi69AVQiFCKnvWj
	O2ls7v9z2LJhh+dLE7tOqkn0PR40gfke5KrCu76dRezu8vgbMq/kcFjtTvLYFprOE5+JP0
	1OflI+vbqnfnztjiwLMytltZ0opjGho=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-1Ma40_K5NviGnz7q7K-hlQ-1; Tue,
 30 Apr 2024 13:11:37 -0400
X-MC-Unique: 1Ma40_K5NviGnz7q7K-hlQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52ADB29AC016;
	Tue, 30 Apr 2024 17:11:33 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.225.235])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 326F72166B36;
	Tue, 30 Apr 2024 17:11:30 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net/sched: unregister lockdep keys in qdisc_create/qdisc_alloc error path
Date: Tue, 30 Apr 2024 19:11:13 +0200
Message-ID: <2aa1ca0c0a3aa0acc15925c666c777a4b5de553c.1714496886.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Naresh and Eric report several errors (corrupted elements in the dynamic
key hash list), when running tdc.py or syzbot. The error path of
qdisc_alloc() and qdisc_create() frees the qdisc memory, but it forgets
to unregister the lockdep key, thus causing use-after-free like the
following one:

 ==================================================================
 BUG: KASAN: slab-use-after-free in lockdep_register_key+0x5f2/0x700
 Read of size 8 at addr ffff88811236f2a8 by task ip/7925

 CPU: 26 PID: 7925 Comm: ip Kdump: loaded Not tainted 6.9.0-rc2+ #648
 Hardware name: Supermicro SYS-6027R-72RF/X9DRH-7TF/7F/iTF/iF, BIOS 3.0  07/26/2013
 Call Trace:
  <TASK>
  dump_stack_lvl+0x7c/0xc0
  print_report+0xc9/0x610
  kasan_report+0x89/0xc0
  lockdep_register_key+0x5f2/0x700
  qdisc_alloc+0x21d/0xb60
  qdisc_create_dflt+0x63/0x3c0
  attach_one_default_qdisc.constprop.37+0x8e/0x170
  dev_activate+0x4bd/0xc30
  __dev_open+0x275/0x380
  __dev_change_flags+0x3f1/0x570
  dev_change_flags+0x7c/0x160
  do_setlink+0x1ea1/0x34b0
  __rtnl_newlink+0x8c9/0x1510
  rtnl_newlink+0x61/0x90
  rtnetlink_rcv_msg+0x2f0/0xbc0
  netlink_rcv_skb+0x120/0x380
  netlink_unicast+0x420/0x630
  netlink_sendmsg+0x732/0xbc0
  __sock_sendmsg+0x1ea/0x280
  ____sys_sendmsg+0x5a9/0x990
  ___sys_sendmsg+0xf1/0x180
  __sys_sendmsg+0xd3/0x180
  do_syscall_64+0x96/0x180
  entry_SYSCALL_64_after_hwframe+0x71/0x79
 RIP: 0033:0x7f9503f4fa07
 Code: 0a 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b9 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74 24 10
 RSP: 002b:00007fff6c729068 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
 RAX: ffffffffffffffda RBX: 000000006630c681 RCX: 00007f9503f4fa07
 RDX: 0000000000000000 RSI: 00007fff6c7290d0 RDI: 0000000000000003
 RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000078
 R10: 000000000000009b R11: 0000000000000246 R12: 0000000000000001
 R13: 00007fff6c729180 R14: 0000000000000000 R15: 000055bf67dd9040
  </TASK>

 Allocated by task 7745:
  kasan_save_stack+0x1c/0x40
  kasan_save_track+0x10/0x30
  __kasan_kmalloc+0x7b/0x90
  __kmalloc_node+0x1ff/0x460
  qdisc_alloc+0xae/0xb60
  qdisc_create+0xdd/0xfb0
  tc_modify_qdisc+0x37e/0x1960
  rtnetlink_rcv_msg+0x2f0/0xbc0
  netlink_rcv_skb+0x120/0x380
  netlink_unicast+0x420/0x630
  netlink_sendmsg+0x732/0xbc0
  __sock_sendmsg+0x1ea/0x280
  ____sys_sendmsg+0x5a9/0x990
  ___sys_sendmsg+0xf1/0x180
  __sys_sendmsg+0xd3/0x180
  do_syscall_64+0x96/0x180
  entry_SYSCALL_64_after_hwframe+0x71/0x79

 Freed by task 7745:
  kasan_save_stack+0x1c/0x40
  kasan_save_track+0x10/0x30
  kasan_save_free_info+0x36/0x60
  __kasan_slab_free+0xfe/0x180
  kfree+0x113/0x380
  qdisc_create+0xafb/0xfb0
  tc_modify_qdisc+0x37e/0x1960
  rtnetlink_rcv_msg+0x2f0/0xbc0
  netlink_rcv_skb+0x120/0x380
  netlink_unicast+0x420/0x630
  netlink_sendmsg+0x732/0xbc0
  __sock_sendmsg+0x1ea/0x280
  ____sys_sendmsg+0x5a9/0x990
  ___sys_sendmsg+0xf1/0x180
  __sys_sendmsg+0xd3/0x180
  do_syscall_64+0x96/0x180
  entry_SYSCALL_64_after_hwframe+0x71/0x79

Fix this ensuring that lockdep_unregister_key() is called before the
qdisc struct is freed, also in the error path of qdisc_create() and
qdisc_alloc().

Fixes: af0cb3fa3f9e ("net/sched: fix false lockdep warning on qdisc root lock")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://lore.kernel.org/netdev/20240429221706.1492418-1-naresh.kamboju@linaro.org/
CC: Naresh Kamboju <naresh.kamboju@linaro.org>
CC: Eric Dumazet <edumazet@google.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 net/sched/sch_api.c     | 1 +
 net/sched/sch_generic.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 60239378d43f..6292d6d73b72 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1389,6 +1389,7 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 		ops->destroy(sch);
 	qdisc_put_stab(rtnl_dereference(sch->stab));
 err_out3:
+	lockdep_unregister_key(&sch->root_lock_key);
 	netdev_put(dev, &sch->dev_tracker);
 	qdisc_free(sch);
 err_out2:
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 31dfd6c7405b..d3f6006b563c 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -982,6 +982,7 @@ struct Qdisc *qdisc_alloc(struct netdev_queue *dev_queue,
 
 	return sch;
 errout1:
+	lockdep_unregister_key(&sch->root_lock_key);
 	kfree(sch);
 errout:
 	return ERR_PTR(err);
-- 
2.44.0


