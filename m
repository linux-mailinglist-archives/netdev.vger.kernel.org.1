Return-Path: <netdev+bounces-96565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A808C674A
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 15:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 121E41F24810
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 13:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C79685C4E;
	Wed, 15 May 2024 13:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0biqTXUF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9C68595C
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 13:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715779423; cv=none; b=hQOeD9km0aWQfL//S2P1I3Foas92Kqo9L/cfm6aw4i6GPz8vwHYgrObzl4MMqWnHECVcz0H3F0Us/56sN/RvzBiA2H96iI+j+aynhPiOq0nP+VTXF+3a3NddOPaqazebov3rnWLw149riDlRXGwxnaDqXYBq4xPETR3OfUan27Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715779423; c=relaxed/simple;
	bh=/Fn+JE02PGtB60rbxbFDOK1lugDzDlc47hMekr5Z2Zw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IfzVoir3pKe632l8mLmpXriWYIElru6TV816l5sV9jxgpCKN/xDXQU9mZTCZd7g39q96Y4mJXwX+z7VPWYGdfwmmF6w4Yjf2hx5vfbNyl6Ivpmipt7JoCAiBC7Fxvm1e/vUfK3opbfo0yIxOimsecXBTIQ77ZjyKmJ4rBiH3UrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0biqTXUF; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be530d024so120555417b3.2
        for <netdev@vger.kernel.org>; Wed, 15 May 2024 06:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715779420; x=1716384220; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7S26aTNNpcoU71ByNeJa3ykL8EiKJD4Wc47OQUK+O8k=;
        b=0biqTXUFNRO2iOEaU/Uc6tqJ0Ay3ADWqMuWEx4X6WSveB+Oh2S749bVjzfUtJAgPwM
         6n3a4GVzAr23BATzo41c+koIfI4TSlVuOQ1SjbR/OjbKfp5rUKqSygJXR7ljaX5zZXYd
         lQBNQ+TafpLoplLlzQcvuOYM5cA1JHEbaeocxR9MsH9UCBY/dg7nbGgfCRPLublhgDEM
         xwC3Vjz2A/inPGowVYuKjW3QIZbqrEsUnqCv5Yfc67K75hkojBLUj6Nvg9Zm4dWFFwAH
         qDw2D14SfctanmjteOw8hqb08vZ8gq9BpPhZQ/OgczZubCuzJ3REJl/ctMSHk+jVJQwO
         mUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715779420; x=1716384220;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7S26aTNNpcoU71ByNeJa3ykL8EiKJD4Wc47OQUK+O8k=;
        b=sjFWP6HxMwtdCjscQAFBWwXGjfUGfaE4flhqrUSn07sodmwgvgi8iELszg7CcDK/L8
         VHNbcDMc2D2Lo4K3cLqRRxEKujm1lL6eB9SL8sQnU/0FClPcCrhsscf0uASJ1pQkggu5
         qcgFtWQxZrBqqNBSYggeC0CuvUYUoLzr1g6GlmoS1czVCPbS9ZxnYTV+E4KKKcjlXf8j
         yXdJrPf3kO9XdV62LdzyWe5QrfVWROJYUxEzYoA3Km3a5sPACIH6Vkfj3oVUCRg3iEAD
         a0RWV9jglk4bfiJewQObAqhFjP796Fp478598+Ka43N66bynan1EyPHIdACqaRr/vVVq
         o6DA==
X-Gm-Message-State: AOJu0YzdYZCtopui+Wkh2Ac/NGGZIQ4pcRrr1O6bvALrmADV4hA0JR9r
	l+WI/rnBRnQGY/zByVSRo8k2OpINW4RImMNPnbvPRh+XWP58Tq0RPP7vROOGiRBC+LZRNDH6BrL
	mhE1eFtmCzg==
X-Google-Smtp-Source: AGHT+IGp5926Z0lKiYFQpoO+xP6RfZWGWQCMU9QrJccBe09Ypi3BI/uFM+gss43SsTbr/sHo/f0r6/UZdd0ihA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:a186:0:b0:de1:d49:7ff6 with SMTP id
 3f1490d57ef6-dee4f37adeemr1322301276.7.1715779420523; Wed, 15 May 2024
 06:23:40 -0700 (PDT)
Date: Wed, 15 May 2024 13:23:39 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240515132339.3346267-1-edumazet@google.com>
Subject: [PATCH net] netfilter: nfnetlink_queue: acquire rcu_read_lock() in instance_destroy_rcu()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Jozsef Kadlecsik <kadlec@netfilter.org>
Cc: netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

syzbot reported that nf_reinject() could be called without rcu_read_lock() :

WARNING: suspicious RCU usage
6.9.0-rc7-syzkaller-02060-g5c1672705a1a #0 Not tainted

net/netfilter/nfnetlink_queue.c:263 suspicious rcu_dereference_check() usage!

other info that might help us debug this:

rcu_scheduler_active = 2, debug_locks = 1
2 locks held by syz-executor.4/13427:
  #0: ffffffff8e334f60 (rcu_callback){....}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
  #0: ffffffff8e334f60 (rcu_callback){....}-{0:0}, at: rcu_do_batch kernel/rcu/tree.c:2190 [inline]
  #0: ffffffff8e334f60 (rcu_callback){....}-{0:0}, at: rcu_core+0xa86/0x1830 kernel/rcu/tree.c:2471
  #1: ffff88801ca92958 (&inst->lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
  #1: ffff88801ca92958 (&inst->lock){+.-.}-{2:2}, at: nfqnl_flush net/netfilter/nfnetlink_queue.c:405 [inline]
  #1: ffff88801ca92958 (&inst->lock){+.-.}-{2:2}, at: instance_destroy_rcu+0x30/0x220 net/netfilter/nfnetlink_queue.c:172

stack backtrace:
CPU: 0 PID: 13427 Comm: syz-executor.4 Not tainted 6.9.0-rc7-syzkaller-02060-g5c1672705a1a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <IRQ>
  __dump_stack lib/dump_stack.c:88 [inline]
  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
  lockdep_rcu_suspicious+0x221/0x340 kernel/locking/lockdep.c:6712
  nf_reinject net/netfilter/nfnetlink_queue.c:323 [inline]
  nfqnl_reinject+0x6ec/0x1120 net/netfilter/nfnetlink_queue.c:397
  nfqnl_flush net/netfilter/nfnetlink_queue.c:410 [inline]
  instance_destroy_rcu+0x1ae/0x220 net/netfilter/nfnetlink_queue.c:172
  rcu_do_batch kernel/rcu/tree.c:2196 [inline]
  rcu_core+0xafd/0x1830 kernel/rcu/tree.c:2471
  handle_softirqs+0x2d6/0x990 kernel/softirq.c:554
  __do_softirq kernel/softirq.c:588 [inline]
  invoke_softirq kernel/softirq.c:428 [inline]
  __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
  irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
  sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>

Fixes: 9872bec773c2 ("[NETFILTER]: nfnetlink: use RCU for queue instances hash")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/netfilter/nfnetlink_queue.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 00f4bd21c59b419e96794127693c21ccb05e45b0..f1c31757e4969e8f975c7a1ebbc3b96148ec9724 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -169,7 +169,9 @@ instance_destroy_rcu(struct rcu_head *head)
 	struct nfqnl_instance *inst = container_of(head, struct nfqnl_instance,
 						   rcu);
 
+	rcu_read_lock();
 	nfqnl_flush(inst, NULL, 0);
+	rcu_read_unlock();
 	kfree(inst);
 	module_put(THIS_MODULE);
 }
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


