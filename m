Return-Path: <netdev+bounces-124562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10944969FDF
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E3D7B231C8
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F1955886;
	Tue,  3 Sep 2024 14:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="C+MDPaKT"
X-Original-To: netdev@vger.kernel.org
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [178.154.239.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A881EB21
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 14:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725372488; cv=none; b=jhuQYID7VUX0kzsOTd5UqQpUaTuCERtoOnP1LsusNW9zhYZ2N093562XO4cQqndubP0zP463hHCvQa+5rBKMHHqei8GIg/jssNN0OyqFLwirIPa69AmawGYAKTc3IltJWSRw7pv+UxJX6JpFIj+zCNmlIc9q1T1hC18F0C+8clk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725372488; c=relaxed/simple;
	bh=59F95OUIbpmkMqqAin2tRpgS2e/3I6BPopUerkuQDWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fO6ZoIWMTZghRr2RpLO5xQWMIM7Dp+r6nNOpQTt0INIhgYk+ZLM9pnihcWF3/0SygwjYVGIx6yGqPXOtynATm3SrfqZbBtCdA8cvElSDQZ1wuszETkgh4uNuogOWPau5J1G78UuqJJM1I/k6QNT3skSutb5TVeLZc4KbX4X0tlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=C+MDPaKT; arc=none smtp.client-ip=178.154.239.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:de2c:0:640:e39b:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTPS id 2CDFA60B03;
	Tue,  3 Sep 2024 17:07:58 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id s7cJDQ0oD0U0-6XpbTIw3;
	Tue, 03 Sep 2024 17:07:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1725372477; bh=pgYcVjbF+SL0tSuILQuEGlht62c1dyFS+zOtG2prJtY=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=C+MDPaKTBI18ZHovLV8cBEjeHOgmu3eeuPu7hguoQ1hG2LGFMMYNFg13yW1EN/sRg
	 7JWd/m85RS8cydQ5bIdDAb7oSDzJy/NJGcYc1jGKhV3Mj1TwICDQMSoJDIVhoSxDh1
	 n3LDgQGU7sF+S1ailw28/hipfNsaXjr/YlNSGf2c=
Authentication-Results: mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH net v4 3/3] net: sched: use RCU read-side critical section in taprio_dump()
Date: Tue,  3 Sep 2024 17:07:08 +0300
Message-ID: <20240903140708.3122263-3-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240903140708.3122263-1-dmantipov@yandex.ru>
References: <20240903140708.3122263-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix possible use-after-free in 'taprio_dump()' by adding RCU
read-side critical section there. Never seen on x86 but
found on a KASAN-enabled arm64 system when investigating
https://syzkaller.appspot.com/bug?extid=b65e0af58423fc8a73aa:

[T15862] BUG: KASAN: slab-use-after-free in taprio_dump+0xa0c/0xbb0
[T15862] Read of size 4 at addr ffff0000d4bb88f8 by task repro/15862
[T15862]
[T15862] CPU: 0 UID: 0 PID: 15862 Comm: repro Not tainted 6.11.0-rc1-00293-gdefaf1a2113a-dirty #2
[T15862] Hardware name: QEMU QEMU Virtual Machine, BIOS edk2-20240524-5.fc40 05/24/2024
[T15862] Call trace:
[T15862]  dump_backtrace+0x20c/0x220
[T15862]  show_stack+0x2c/0x40
[T15862]  dump_stack_lvl+0xf8/0x174
[T15862]  print_report+0x170/0x4d8
[T15862]  kasan_report+0xb8/0x1d4
[T15862]  __asan_report_load4_noabort+0x20/0x2c
[T15862]  taprio_dump+0xa0c/0xbb0
[T15862]  tc_fill_qdisc+0x540/0x1020
[T15862]  qdisc_notify.isra.0+0x330/0x3a0
[T15862]  tc_modify_qdisc+0x7b8/0x1838
[T15862]  rtnetlink_rcv_msg+0x3c8/0xc20
[T15862]  netlink_rcv_skb+0x1f8/0x3d4
[T15862]  rtnetlink_rcv+0x28/0x40
[T15862]  netlink_unicast+0x51c/0x790
[T15862]  netlink_sendmsg+0x79c/0xc20
[T15862]  __sock_sendmsg+0xe0/0x1a0
[T15862]  ____sys_sendmsg+0x6c0/0x840
[T15862]  ___sys_sendmsg+0x1ac/0x1f0
[T15862]  __sys_sendmsg+0x110/0x1d0
[T15862]  __arm64_sys_sendmsg+0x74/0xb0
[T15862]  invoke_syscall+0x88/0x2e0
[T15862]  el0_svc_common.constprop.0+0xe4/0x2a0
[T15862]  do_el0_svc+0x44/0x60
[T15862]  el0_svc+0x50/0x184
[T15862]  el0t_64_sync_handler+0x120/0x12c
[T15862]  el0t_64_sync+0x190/0x194
[T15862]
[T15862] Allocated by task 15857:
[T15862]  kasan_save_stack+0x3c/0x70
[T15862]  kasan_save_track+0x20/0x3c
[T15862]  kasan_save_alloc_info+0x40/0x60
[T15862]  __kasan_kmalloc+0xd4/0xe0
[T15862]  __kmalloc_cache_noprof+0x194/0x334
[T15862]  taprio_change+0x45c/0x2fe0
[T15862]  tc_modify_qdisc+0x6a8/0x1838
[T15862]  rtnetlink_rcv_msg+0x3c8/0xc20
[T15862]  netlink_rcv_skb+0x1f8/0x3d4
[T15862]  rtnetlink_rcv+0x28/0x40
[T15862]  netlink_unicast+0x51c/0x790
[T15862]  netlink_sendmsg+0x79c/0xc20
[T15862]  __sock_sendmsg+0xe0/0x1a0
[T15862]  ____sys_sendmsg+0x6c0/0x840
[T15862]  ___sys_sendmsg+0x1ac/0x1f0
[T15862]  __sys_sendmsg+0x110/0x1d0
[T15862]  __arm64_sys_sendmsg+0x74/0xb0
[T15862]  invoke_syscall+0x88/0x2e0
[T15862]  el0_svc_common.constprop.0+0xe4/0x2a0
[T15862]  do_el0_svc+0x44/0x60
[T15862]  el0_svc+0x50/0x184
[T15862]  el0t_64_sync_handler+0x120/0x12c
[T15862]  el0t_64_sync+0x190/0x194
[T15862]
[T15862] Freed by task 6192:
[T15862]  kasan_save_stack+0x3c/0x70
[T15862]  kasan_save_track+0x20/0x3c
[T15862]  kasan_save_free_info+0x4c/0x80
[T15862]  poison_slab_object+0x110/0x160
[T15862]  __kasan_slab_free+0x3c/0x74
[T15862]  kfree+0x134/0x3c0
[T15862]  taprio_free_sched_cb+0x18c/0x220
[T15862]  rcu_core+0x920/0x1b7c
[T15862]  rcu_core_si+0x10/0x1c
[T15862]  handle_softirqs+0x2e8/0xd64
[T15862]  __do_softirq+0x14/0x20

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v4: redesign to preserve original code as much as possible,
    adjust commit message and subject to target net tree
v3: tweak commit message as suggested by Vinicius
v2: added to the series
---
 net/sched/sch_taprio.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 9f4e004cdb8b..8623dc0bafc0 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -2374,9 +2374,6 @@ static int taprio_dump(struct Qdisc *sch, struct sk_buff *skb)
 	struct tc_mqprio_qopt opt = { 0 };
 	struct nlattr *nest, *sched_nest;
 
-	oper = rtnl_dereference(q->oper_sched);
-	admin = rtnl_dereference(q->admin_sched);
-
 	mqprio_qopt_reconstruct(dev, &opt);
 
 	nest = nla_nest_start_noflag(skb, TCA_OPTIONS);
@@ -2397,18 +2394,23 @@ static int taprio_dump(struct Qdisc *sch, struct sk_buff *skb)
 	    nla_put_u32(skb, TCA_TAPRIO_ATTR_TXTIME_DELAY, q->txtime_delay))
 		goto options_error;
 
+	rcu_read_lock();
+
+	oper = rtnl_dereference(q->oper_sched);
+	admin = rtnl_dereference(q->admin_sched);
+
 	if (oper && taprio_dump_tc_entries(skb, q, oper))
-		goto options_error;
+		goto options_error_rcu;
 
 	if (oper && dump_schedule(skb, oper))
-		goto options_error;
+		goto options_error_rcu;
 
 	if (!admin)
 		goto done;
 
 	sched_nest = nla_nest_start_noflag(skb, TCA_TAPRIO_ATTR_ADMIN_SCHED);
 	if (!sched_nest)
-		goto options_error;
+		goto options_error_rcu;
 
 	if (dump_schedule(skb, admin))
 		goto admin_error;
@@ -2416,11 +2418,15 @@ static int taprio_dump(struct Qdisc *sch, struct sk_buff *skb)
 	nla_nest_end(skb, sched_nest);
 
 done:
+	rcu_read_unlock();
 	return nla_nest_end(skb, nest);
 
 admin_error:
 	nla_nest_cancel(skb, sched_nest);
 
+options_error_rcu:
+	rcu_read_unlock();
+
 options_error:
 	nla_nest_cancel(skb, nest);
 
-- 
2.46.0


