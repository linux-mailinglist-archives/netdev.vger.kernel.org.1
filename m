Return-Path: <netdev+bounces-84037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE508955B5
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 15:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED58AB2B06D
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 13:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B1A85289;
	Tue,  2 Apr 2024 13:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e1X9DR4S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181058529D
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 13:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712065297; cv=none; b=FM9xHPurrgl/EAAIgEYYjCZUUSfquDIdFNbfzPgTtYEPSn0tpZWrpXkVuyduqlHF3jG0sp9EPDbg9RvRUO1AdHtY52f9dFStNFwV1xpmCYRWAszaE1iVwr5maFRjcB422FzysMJZBlW5xo2oZhRQM5Y5MHapSqdcO3dCmWFVxAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712065297; c=relaxed/simple;
	bh=e7shh6yvPp1H4Y9GQe3wl5NHoVp7Q6tMX29LS/sgd6w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZfM0gA5oh//MScRZuBKaganj3NEiPBtnGLduRv2t9whi1KwnLKtDfwuaFhaDbrfsHrQ2OAOnJkMw6KElgIxT95Q1C2R6m2gs/LQGwA8Cxxa5034Z8brclpuPm6eMXGKhXhDGdqUcLLewug6HgQH7NY4B0ZrRovAKuqb8/bpdRN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e1X9DR4S; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6144de213f3so67122687b3.3
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 06:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712065295; x=1712670095; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E5/Tfr7oT3omjdwQVsb0qbCvSVq7DuG2CimWzMCciK8=;
        b=e1X9DR4S2G++Kbn+wmg4aBxDagSDPJOVUIdXr68PNg6zAL/CfukHs9WlZRG9hXqMoN
         /NyTvOVB42aImeke6iO0r81ku+cE4hPwvZM7YHwttizB6X2dN5B4aD8Adp7ZqanYsoRh
         4ByIM9EnM3mb9mIFktLrrcCcdfA0vmmHBxFMwGZoTXXF8Kn2yV9kbTyZqqDP/onMbMmY
         cXkNsk2eOq5sft75qCts+qWue8IrQBmzyD5Dw142QLf4D2AWWFpozKVsgSh0ukTI79mE
         mPSMzPridMGNwMFrHpma/DF2yOj8iLP0tzXFV3UBeABxtGxW9gQ9Lo+iAh24Jg94N6qp
         eleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712065295; x=1712670095;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E5/Tfr7oT3omjdwQVsb0qbCvSVq7DuG2CimWzMCciK8=;
        b=G7NubSdAxMcRMEnoPxPNBuk3YYGfz4KGDDNUniHqOCy9P5KFa8KXQ6gX5H0rwxgSwK
         G1CpCrzPDFIJyNWcYo4CP1aODeLPQbIgOAySyv2/s89tm7b5E6p25HcuqED6STorhuMm
         eLUaaUFcW55cBidDiGG5gmJhw/id6TRORpcaU+4bAA9i8IMvM5sEn1AJgiQbipfxqycx
         rDHIz2MJAItN08KEt9CO/4pNZh64GH3FA9K4HYpwKglma4HdiUYd+1THdP+hFY8kSy0S
         /3nqzo42iGZFS3G3lw5BLSj3y5P0G6J5O1exRln+MGPrgbnVorvrnkP3l/92u0HT57zd
         4wtw==
X-Forwarded-Encrypted: i=1; AJvYcCUyKLZWAqWp2JcV0rnn8zwqO9Hlp41w7dFv54D7Y7ImblJp8h5OS3oIy3HBh8Vej2C38r08VrVh0sFeuMjwXqxYzEbzlPg8
X-Gm-Message-State: AOJu0YwEnfIU/rjpuYfibfoVijzbvmShVYZb5mpeN91Rbdt+TzKEnEDn
	JUuV8Wy4FV+FONAwcy50AVTmhmxpbL4x/vrqGpcaWQONWSmV9nPoHb6VpfRf9aGFuFLFwIQ01uu
	t2Ie4TQgYQA==
X-Google-Smtp-Source: AGHT+IFKEothRvOQHcOYwimWRtFX0X5DplDu/F7VcaXZoVJYN4vUeuWHVTHzGtsRtnsCUZprc3xDJPSTBByR0w==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:a045:0:b0:615:4295:2871 with SMTP id
 x66-20020a81a045000000b0061542952871mr73462ywg.7.1712065295027; Tue, 02 Apr
 2024 06:41:35 -0700 (PDT)
Date: Tue,  2 Apr 2024 13:41:33 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240402134133.2352776-1-edumazet@google.com>
Subject: [PATCH net] net/sched: fix lockdep splat in qdisc_tree_reduce_backlog()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

qdisc_tree_reduce_backlog() is called with the qdisc lock held,
not RTNL.

We must use qdisc_lookup_rcu() instead of qdisc_lookup()

syzbot reported:

WARNING: suspicious RCU usage
6.1.74-syzkaller #0 Not tainted
-----------------------------
net/sched/sch_api.c:305 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:

rcu_scheduler_active = 2, debug_locks = 1
3 locks held by udevd/1142:
  #0: ffffffff87c729a0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:306 [inline]
  #0: ffffffff87c729a0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
  #0: ffffffff87c729a0 (rcu_read_lock){....}-{1:2}, at: net_tx_action+0x64a/0x970 net/core/dev.c:5282
  #1: ffff888171861108 (&sch->q.lock){+.-.}-{2:2}, at: spin_lock include/linux/spinlock.h:350 [inline]
  #1: ffff888171861108 (&sch->q.lock){+.-.}-{2:2}, at: net_tx_action+0x754/0x970 net/core/dev.c:5297
  #2: ffffffff87c729a0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:306 [inline]
  #2: ffffffff87c729a0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
  #2: ffffffff87c729a0 (rcu_read_lock){....}-{1:2}, at: qdisc_tree_reduce_backlog+0x84/0x580 net/sched/sch_api.c:792

stack backtrace:
CPU: 1 PID: 1142 Comm: udevd Not tainted 6.1.74-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Call Trace:
 <TASK>
  [<ffffffff85b85f14>] __dump_stack lib/dump_stack.c:88 [inline]
  [<ffffffff85b85f14>] dump_stack_lvl+0x1b1/0x28f lib/dump_stack.c:106
  [<ffffffff85b86007>] dump_stack+0x15/0x1e lib/dump_stack.c:113
  [<ffffffff81802299>] lockdep_rcu_suspicious+0x1b9/0x260 kernel/locking/lockdep.c:6592
  [<ffffffff84f0054c>] qdisc_lookup+0xac/0x6f0 net/sched/sch_api.c:305
  [<ffffffff84f037c3>] qdisc_tree_reduce_backlog+0x243/0x580 net/sched/sch_api.c:811
  [<ffffffff84f5b78c>] pfifo_tail_enqueue+0x32c/0x4b0 net/sched/sch_fifo.c:51
  [<ffffffff84fbcf63>] qdisc_enqueue include/net/sch_generic.h:833 [inline]
  [<ffffffff84fbcf63>] netem_dequeue+0xeb3/0x15d0 net/sched/sch_netem.c:723
  [<ffffffff84eecab9>] dequeue_skb net/sched/sch_generic.c:292 [inline]
  [<ffffffff84eecab9>] qdisc_restart net/sched/sch_generic.c:397 [inline]
  [<ffffffff84eecab9>] __qdisc_run+0x249/0x1e60 net/sched/sch_generic.c:415
  [<ffffffff84d7aa96>] qdisc_run+0xd6/0x260 include/net/pkt_sched.h:125
  [<ffffffff84d85d29>] net_tx_action+0x7c9/0x970 net/core/dev.c:5313
  [<ffffffff85e002bd>] __do_softirq+0x2bd/0x9bd kernel/softirq.c:616
  [<ffffffff81568bca>] invoke_softirq kernel/softirq.c:447 [inline]
  [<ffffffff81568bca>] __irq_exit_rcu+0xca/0x230 kernel/softirq.c:700
  [<ffffffff81568ae9>] irq_exit_rcu+0x9/0x20 kernel/softirq.c:712
  [<ffffffff85b89f52>] sysvec_apic_timer_interrupt+0x42/0x90 arch/x86/kernel/apic/apic.c:1107
  [<ffffffff85c00ccb>] asm_sysvec_apic_timer_interrupt+0x1b/0x20 arch/x86/include/asm/idtentry.h:656

Fixes: d636fc5dd692 ("net: sched: add rcu annotations around qdisc->qdisc_sleeping")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 65e05b0c98e461953aa8d98020142f0abe3ad8a7..60239378d43fb7adfe3926f927f3883f09673c16 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -809,7 +809,7 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n, int len)
 		notify = !sch->q.qlen && !WARN_ON_ONCE(!n &&
 						       !qdisc_is_offloaded);
 		/* TODO: perform the search on a per txq basis */
-		sch = qdisc_lookup(qdisc_dev(sch), TC_H_MAJ(parentid));
+		sch = qdisc_lookup_rcu(qdisc_dev(sch), TC_H_MAJ(parentid));
 		if (sch == NULL) {
 			WARN_ON_ONCE(parentid != TC_H_ROOT);
 			break;
-- 
2.44.0.478.gd926399ef9-goog


