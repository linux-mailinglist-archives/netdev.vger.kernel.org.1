Return-Path: <netdev+bounces-277979-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Ns8I5Kj3GkEUgkAu9opvQ
	(envelope-from <netdev+bounces-277979-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:04:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E966A3E8C1E
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D1E430053E4
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 07:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD4139B484;
	Mon, 13 Apr 2026 07:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1Wz9YAA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1540394496
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 07:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776067072; cv=none; b=Us2Q9vcxzPXYtS/iK3en9UpqCQxuYA9dIhFU941QcDckYCUYX5AZ+G9efa98QmIIhqqU9rkuR5SIQ4hcdb61Ecgjqki0LntBd5IfRnoKL7i5ad5zDvgZ2rIhLio0StaXb1TwOhU9wv/V56ffK/DmA7iW7oIClSDOLBFEd1IYh+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776067072; c=relaxed/simple;
	bh=gW3Lkm7SSCYRdc6k9/0nWACHg157MVESZ7CwXbjGq6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QhL5QmAVaQ5hfOkarEj1pFooP7TmprluRDwYNPr8FsTvHqoBijWr4hS6FKzoHyYeUXi+d/pzovJDWNrFsvTK7MEopo6qtDDkfOujHe7Qw90cFOjcTG7EClNsWfwiE4wU2WOX7kYQKBe1g7uKd7lCZST2CLlYi2eMY8TEue6YkaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1Wz9YAA; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2addb31945aso24956005ad.1
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 00:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776067070; x=1776671870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O9MzXZJ+25eqcp6ZmgpEPZPZ00SPhuKmmGjkCyomBMw=;
        b=J1Wz9YAAZJT8Hh7y/gvIwoJ6Bbgy3ZcyVyWnfB2kbkW1HgNEOl8wzpGqVh5pIneY3h
         eU7fIOG4+HGUB9w/scfvAhah4Wihge0j5atnZmldKaLlizqQvnCmED16Ta6OpORWOhoj
         P+I6WtxgH3kly9RENAQzoFmbb5q8pVJx338Hgji+L5TCGm1C/BCvawNXGXENM+9uJSRB
         4qyPyP35qDAV3wTgipBzliffcbmCbHDqcs/MIaHInALC01avNmH6eDxWRi7mOH0ipM7p
         p201FULuwknRe1Uu9DmWfOTxzLrn5FOCS2d0czG/N82Rf7AZp1BEtj44DGBnKF0Og2nS
         ihbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776067070; x=1776671870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9MzXZJ+25eqcp6ZmgpEPZPZ00SPhuKmmGjkCyomBMw=;
        b=UyfFjIQLvNPTFVZQTz8cRrdQA7tX/QUpj5XhKFTLKpXpD3bmMBhQAqxFnJtwAnqAQh
         EXBD2DMxJIIvVAUXyHPp63gFukoZsBGanVfK08wI/BOmDDS1BuSyaDbpaVWoArOVNffP
         VHtIo0lNyn/7oF50k3ZeqJwur8WZ5GZmq0wp//5hQESGZAW2qi9g6kp3jE5p6/RfeCBz
         cUoYmKQbJbznk2UgW8446cGP0Yjj9QqRpQRjStTpN21Op8B6rKakA/fuHIc74omYOHnQ
         hObOCBdE5g1HoZ3p8AyKJiMXmsH79BJKcALG+8Ri2vB5MBMp2Gjx1qtXv5cVEYt+VSXS
         cESQ==
X-Forwarded-Encrypted: i=1; AFNElJ+JX6K0C05KOlJWuo5biyiFWmB+PVk0+HvA0uvhuopENqrNC5EP7BJJCJI6rsmiMyXhY6mPEnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsQVFB7uloiKPKBDz2K7NSQg5teQqAsR77jSNHzAn98Ma5+btk
	2dpxZXvjAXDNiL3l3FX7VihYR+6HBIaZ5Ea17C4zoIru599+SkrB7SEA
X-Gm-Gg: AeBDiesuL7SsbiaH2acd/CtNMDn+csiOw+oD7jrzCj+VDKfMufrNmLB0l8jVdIPU1xt
	mmu5m80t8Qr77WUDH2H0P3KyO8hiMbFdcjxARVLBOEFZLK3Lqq2dc9NNeERLdwc3PKd20q0fkxO
	FpniEd0SZMOum3bfvD3ujwRbI22FktFC/G6eSDOGA8sRjI6Y7LJ1PNGdpnns35GtZj1BX25hu3N
	t2kobYqLaMiRqvIDj3+JIt8gHqX8vznR/mCMIfwPZZz2Q8XDJX/W3EB8BtWaBB9WzEFnfblMhSZ
	AdT+p4mBIWEeFJmj5W3x10Wr9mVJ+dfxB2sGuEkHVHYr1Ygcjqi61cyCpNFFKozZs36kd5S3dms
	e8uDwkFipd1Frh0wQQZXjBqLXaun7+jMNN4cnPC4+IA0YVO1xO4aHF2O5mb/1A2/XEo94YXI/AP
	PvfnEtUXhw2RGN/1i0GlJNmgx3HohNlfP7
X-Received: by 2002:a17:903:38cc:b0:2b0:60f1:de58 with SMTP id d9443c01a7336-2b2d5a95893mr129444395ad.45.1776067069932;
        Mon, 13 Apr 2026 00:57:49 -0700 (PDT)
Received: from localhost.localdomain ([117.186.117.206])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b462830bc5sm14152705ad.50.2026.04.13.00.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 00:57:49 -0700 (PDT)
From: "Kito Xu (veritas501)" <hxzene@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Kito Xu (veritas501)" <hxzene@gmail.com>
Subject: [PATCH] net/sched: sch_dualpi2: fix NULL pointer dereference in dualpi2_change()
Date: Mon, 13 Apr 2026 15:57:40 +0800
Message-ID: <20260413075740.2234828-1-hxzene@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nokia-bell-labs.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-277979-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hxzene@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E966A3E8C1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

dualpi2_change() uses a trim loop to enforce the new queue limit after a
configuration change. The loop calls qdisc_dequeue_internal(sch, true)
which only dequeues from the C-queue (sch->q) and the requeue list
(sch->gso_skb). It does not dequeue from the L-queue (q->l_queue).

However, the loop continuation condition checks qdisc_qlen(sch), which
reflects the total packet count across both queues because
dualpi2_enqueue_skb() manually increments sch->q.qlen for L-queue
packets (line 418). Similarly, q->memory_used accounts for memory from
both queues.

When all packets reside in the L-queue and the C-queue is empty, the
loop condition remains true but qdisc_dequeue_internal() returns NULL.
The subsequent skb->truesize dereference causes a NULL pointer oops.

An unprivileged user can trigger this from a user namespace:

  1. unshare(CLONE_NEWUSER | CLONE_NEWNET)
  2. Create a dummy device and attach dualpi2 qdisc
  3. Send ECT(1)-marked packets to fill the L-queue
  4. Reduce the qdisc limit via RTM_NEWQDISC

[   17.521319] Oops: general protection fault, probably for non-canonical address 0xdffffc000000001a: 0000 [#1] SMP KASAN NOPTI
[   17.525206] KASAN: null-ptr-deref in range [0x00000000000000d0-0x00000000000000d7]
[   17.527710] CPU: 3 UID: 1000 PID: 171 Comm: poc Not tainted 7.0.0-rc7-next-20260410 #10 PREEMPTLAZY
[   17.530795] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   17.533301] RIP: 0010:dualpi2_change+0xd09/0x1c00
[   17.535472] Code: ef 83 e7 07 83 c7 03 44 38 cf 7c 09 45 84 c9 0f 85 fb 06 00 00 4c 8d 96 d0 00 00 00 44 8b 8b 5c 02 00 00 4c 89 d7 48 c1 ef 03 <0f> b6 3c 2f 40 84 ff 74 0a 40 80 ff 03 0f 8e fc 06 00 00 4c 89 c7
[   17.540294] RSP: 0018:ffffc90000bb7360 EFLAGS: 00000202
[   17.542574] RAX: 0000000000014c3a RBX: ffff88800fe18000 RCX: ffffed1001fc3010
[   17.543461] RDX: ffff88800fe1825c RSI: 0000000000000000 RDI: 000000000000001a
[   17.544145] RBP: dffffc0000000000 R08: 0000000000000028 R09: 0000000000171240
[   17.546982] R10: 00000000000000d0 R11: ffff88800fe18080 R12: ffff88800fe180d0
[   17.549652] R13: ffff88800fe1825c R14: ffff88800fe18014 R15: ffff88800fe180f8
[   17.552566] FS:  000000002b3533c0(0000) GS:ffff8880e260f000(0000) knlGS:0000000000000000
[   17.555942] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   17.556472] CR2: dffffc000000001a CR3: 000000000fb01000 CR4: 00000000003006f0
[   17.559321] Call Trace:
[   17.560392]  <TASK>
[   17.560993]  ? __asan_memset+0x23/0x50
[   17.562609]  ? __pfx_dualpi2_change+0x10/0x10
[   17.564265]  ? mutex_lock+0x7e/0xd0
[   17.565628]  ? __pfx_mutex_lock+0x10/0x10
[   17.566886]  ? nla_strcmp+0x20/0x100
[   17.568354]  tc_modify_qdisc+0x4ee/0x1d60
[   17.570211]  ? __pfx_tc_modify_qdisc+0x10/0x10
[   17.571293]  ? __pfx_stack_trace_save+0x10/0x10
[   17.572894]  ? mutex_lock+0x7e/0xd0
[   17.573548]  ? __pfx_mutex_lock+0x10/0x10
[   17.574583]  ? security_capable+0x80/0x110
[   17.576051]  rtnetlink_rcv_msg+0x548/0xc10
[   17.577902]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[   17.579170]  netlink_rcv_skb+0x12a/0x390
[   17.580902]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[   17.581817]  ? __pfx_netlink_rcv_skb+0x10/0x10
[   17.583064]  ? __kasan_slab_alloc+0x89/0x90
[   17.584753]  netlink_unicast+0x5b8/0x980
[   17.585677]  ? __pfx_netlink_unicast+0x10/0x10
[   17.587312]  ? rpm_suspend+0x492/0xe70
[   17.588612]  ? __pfx___alloc_skb+0x10/0x10
[   17.590473]  ? __check_object_size+0x45e/0x650
[   17.592327]  ? rpm_suspend+0x492/0xe70
[   17.593589]  netlink_sendmsg+0x722/0xbb0
[   17.594452]  ? __pfx_netlink_sendmsg+0x10/0x10
[   17.595192]  ? __import_iovec+0x33d/0x5b0
[   17.596582]  ? __pfx_netlink_sendmsg+0x10/0x10
[   17.598003]  ____sys_sendmsg+0x8cf/0xb30
[   17.599168]  ? __pfx_____sys_sendmsg+0x10/0x10
[   17.599921]  ? __pfx_copy_msghdr_from_user+0x10/0x10
[   17.601616]  ? update_cfs_rq_load_avg+0x5a/0x560
[   17.602924]  ___sys_sendmsg+0x104/0x190
[   17.604318]  ? update_irq_load_avg+0xbd/0x18b0
[   17.604977]  ? __pfx____sys_sendmsg+0x10/0x10
[   17.606505]  __sys_sendmsg+0x124/0x1c0
[   17.607877]  ? __pfx___sys_sendmsg+0x10/0x10
[   17.609867]  ? __pfx_handle_softirqs+0x10/0x10
[   17.611017]  do_syscall_64+0x64/0x680
[   17.612277]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   17.614334] RIP: 0033:0x429d6b
[   17.615451] Code: 48 89 e5 48 83 ec 20 89 55 ec 48 89 75 f0 89 7d f8 e8 99 e5 02 00 8b 55 ec 48 8b 75 f0 41 89 c0 8b 7d f8 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 2d 44 89 c7 48 89 45 f8 e8 f1 e5 02 00 48 8b
[   17.619777] RSP: 002b:00007fff81a32560 EFLAGS: 00000293 ORIG_RAX: 000000000000002e
[   17.621686] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 0000000000429d6b
[   17.623171] RDX: 0000000000000000 RSI: 00007fff81a325e0 RDI: 0000000000000003
[   17.625433] RBP: 00007fff81a32580 R08: 0000000000000000 R09: 00007fff81a32797
[   17.627317] R10: 0000000000000000 R11: 0000000000000293 R12: 00007fff81a32a38
[   17.629562] R13: 00007fff81a32a48 R14: 00000000004c4848 R15: 0000000000000001
[   17.630409]  </TASK>
[   17.631205] Modules linked in:
[   17.633251] ---[ end trace 0000000000000000 ]---
[   17.634487] RIP: 0010:dualpi2_change+0xd09/0x1c00
[   17.636511] Code: ef 83 e7 07 83 c7 03 44 38 cf 7c 09 45 84 c9 0f 85 fb 06 00 00 4c 8d 96 d0 00 00 00 44 8b 8b 5c 02 00 00 4c 89 d7 48 c1 ef 03 <0f> b6 3c 2f 40 84 ff 74 0a 40 80 ff 03 0f 8e fc 06 00 00 4c 89 c7
[   17.641850] RSP: 0018:ffffc90000bb7360 EFLAGS: 00000202
[   17.643001] RAX: 0000000000014c3a RBX: ffff88800fe18000 RCX: ffffed1001fc3010
[   17.645928] RDX: ffff88800fe1825c RSI: 0000000000000000 RDI: 000000000000001a
[   17.647603] RBP: dffffc0000000000 R08: 0000000000000028 R09: 0000000000171240
[   17.649912] R10: 00000000000000d0 R11: ffff88800fe18080 R12: ffff88800fe180d0
[   17.652899] R13: ffff88800fe1825c R14: ffff88800fe18014 R15: ffff88800fe180f8
[   17.655310] FS:  000000002b3533c0(0000) GS:ffff8880e260f000(0000) knlGS:0000000000000000
[   17.656751] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   17.659213] CR2: dffffc000000001a CR3: 000000000fb01000 CR4: 00000000003006f0
[   17.661915] Kernel panic - not syncing: Fatal exception in interrupt
[   17.665688] Kernel Offset: disabled
[   17.665980] Rebooting in 1 seconds..

Fix this by adding a NULL check after qdisc_dequeue_internal(). When
the C-queue is exhausted but L-queue packets keep qdisc_qlen(sch) above
the limit, the loop breaks safely. Remaining excess L-queue packets will
be drained by the normal dequeue path.

Fixes: 320d031ad6e4 ("sched: Struct definition and parsing of dualpi2 qdisc")
Signed-off-by: Kito Xu (veritas501) <hxzene@gmail.com>
---
 net/sched/sch_dualpi2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index fe6f5e889625..746c0e506024 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -870,6 +870,9 @@ static int dualpi2_change(struct Qdisc *sch, struct nlattr *opt,
 	       q->memory_used > q->memory_limit) {
 		struct sk_buff *skb = qdisc_dequeue_internal(sch, true);
 
+		if (!skb)
+			break;
+
 		q->memory_used -= skb->truesize;
 		qdisc_qstats_backlog_dec(sch, skb);
 		rtnl_qdisc_drop(skb, sch);
-- 
2.43.0


