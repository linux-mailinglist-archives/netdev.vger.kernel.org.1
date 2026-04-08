Return-Path: <netdev+bounces-276299-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLfJIo/51Wn4/gcAu9opvQ
	(envelope-from <netdev+bounces-276299-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 08:45:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9973B7B19
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 08:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F40B63010145
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 06:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5732A1F4CB3;
	Wed,  8 Apr 2026 06:45:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D1A3537FB
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 06:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775630732; cv=none; b=TjgEcoXqa7OxaUEUNi69t+IJrBRWieKCb1eMEPmPcMl0FCQVlzhbhf3daMTBtzcqBi/aoYlGx613wxhrRFlkGSlcP7XEgN0XlfeDf11fqE1ay6AOhTVIBVk+1PR2jS6gVBjkh84FyDF4sKgSEHgm1XqTtOMOOpiXYqqjGWsaU4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775630732; c=relaxed/simple;
	bh=xgEC+WfL2idF4NX3OWD/q4qLDceolgtCSjaHyw0T6To=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=HWAdIi5v96NTW97YszbkP2YEDz5cRIFnMGwbIr8+PR0wp6jFwojbnK/wRFDePVj7PoOujOUDyypJK7CSlZGOzHFIG29/8VsZj2LRNsxf64lH8P4acUfnCGfl9ESF0OcejQhzFkRzVVQ3pHt3kbS7NO1IhvVxQEL9zIutg0ZqOO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7dbb4f8b314so12786089a34.3
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 23:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775630729; x=1776235529;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7rEQTDJ7oEJhY7ymkpvRH1m82lHz0+1l7ZXL1EKQeIg=;
        b=YK9RuOOwYRSC8oDsjRCMGWuZQT0jKa5yTcutDPYNhhf9zehlRtRUlj8/bUum4oJjgF
         XowBbuHf6M+mQfPziHL0mf/v8TJd0RLnNwVmM+jSvq6dny6qC9s1gsbyWYWj/A69B2wL
         BDBZ9B0yMjqdJTVuMiTJ+d0EtbqG4SJpFFWmyndmpcY/DHh+oA881TjHkBNfEVhlIKfV
         /8nTZLmz8EEnz9jKUZYCcGOUUzyTYhcZC7vqWkgn8uw/PmczY7ma/SfmCzmvOtOf6Vjv
         5uI530r/XF0g0iRHX3KTAOeMUro3KUbHm62GwZN3LlmO9lQfkhghawBk3opSXYpsbNP2
         fYcg==
X-Forwarded-Encrypted: i=1; AJvYcCV6AQDKj8PV36UcHB4GObm3LeVg4uEDh/AfoW3aVhI2rV477ROT3bN2qUIZYOcfDrDXwvrps5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrYj3ikYQyjFXEDhgduuV1Klv+NVCf5/nWQ1lpvP+2pP/HJkYz
	y0qTfdEzV7VAHOtyF7jDQ5ArL7xn5NkhssGZYjHTjX9m2+DOaDVB+Whkh5nt7vlYhtiSOaN3OYU
	faK4Qq7kkip5JjyP1YXvY32okqRtmQD9q0ExEdkcn1hju/8O5RyfflQzDmvU=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4b84:b0:67e:366b:53b7 with SMTP id
 006d021491bc7-68220741a9dmr12203235eaf.53.1775630729067; Tue, 07 Apr 2026
 23:45:29 -0700 (PDT)
Date: Tue, 07 Apr 2026 23:45:29 -0700
In-Reply-To: <20260407170214.4157-2-fmancera@suse.de>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69d5f989.a00a0220.468cb.0009.GAE@google.com>
Subject: [syzbot ci] Re: net_sched: fix skb memory leak in deferred qdisc drops
From: syzbot ci <syzbot+ci2b150416153fb292@syzkaller.appspotmail.com>
To: damilola@aterlo.com, davem@davemloft.net, edumazet@google.com, 
	fmancera@suse.de, horms@kernel.org, kuba@kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlegroups.com:email,appspotmail.com:email,syzbot.org:url,googlesource.com:url];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.982];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-276299-lists,netdev=lfdr.de,ci2b150416153fb292];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: CF9973B7B19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

syzbot ci has tested the following series

[v1] net_sched: fix skb memory leak in deferred qdisc drops
https://lore.kernel.org/all/20260407170214.4157-2-fmancera@suse.de
* [PATCH net] net_sched: fix skb memory leak in deferred qdisc drops

and found the following issue:
WARNING: suspicious RCU usage in cake_dequeue

Full report is available here:
https://ci.syzbot.org/series/90acbb62-3e93-4bb7-af7a-51d555f5956b

***

WARNING: suspicious RCU usage in cake_dequeue

tree:      net
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net.git
base:      a9b8b18364fffce4c451e6f6fd218fa4ab646705
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/a5e0fad0-c9c8-4102-b2af-b4d1c7947ee3/config
syz repro: https://ci.syzbot.org/findings/b1dd239a-f59f-414f-8bde-578258899e94/syz_repro

=============================
WARNING: suspicious RCU usage
syzkaller #0 Not tainted
-----------------------------
./include/net/sch_generic.h:581 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
2 locks held by syz.0.51/6016:
 #0: ffffffff8e75e640 (rcu_read_lock_bh){....}-{1:3}, at: local_bh_disable include/linux/bottom_half.h:20 [inline]
 #0: ffffffff8e75e640 (rcu_read_lock_bh){....}-{1:3}, at: rcu_read_lock_bh include/linux/rcupdate.h:903 [inline]
 #0: ffffffff8e75e640 (rcu_read_lock_bh){....}-{1:3}, at: __dev_queue_xmit+0x277/0x3890 net/core/dev.c:4778
 #1: ffff8881ad9e8170 (&sch->root_lock_key#31){+...}-{3:3}, at: spin_lock include/linux/spinlock.h:341 [inline]
 #1: ffff8881ad9e8170 (&sch->root_lock_key#31){+...}-{3:3}, at: __dev_xmit_skb net/core/dev.c:4241 [inline]
 #1: ffff8881ad9e8170 (&sch->root_lock_key#31){+...}-{3:3}, at: __dev_queue_xmit+0xbf2/0x3890 net/core/dev.c:4819

stack backtrace:
CPU: 1 UID: 0 PID: 6016 Comm: syz.0.51 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 lockdep_rcu_suspicious+0x13f/0x1d0 kernel/locking/lockdep.c:6876
 qdisc_root_sleeping include/net/sch_generic.h:581 [inline]
 qdisc_dequeue_drop include/net/sch_generic.h:1173 [inline]
 cake_dequeue+0x23a7/0x4e50 net/sched/sch_cake.c:2240
 dequeue_skb net/sched/sch_generic.c:297 [inline]
 qdisc_restart net/sched/sch_generic.c:402 [inline]
 __qdisc_run+0x26c/0x15d0 net/sched/sch_generic.c:420
 qdisc_run include/net/pkt_sched.h:120 [inline]
 __dev_xmit_skb net/core/dev.c:4286 [inline]
 __dev_queue_xmit+0x1bad/0x3890 net/core/dev.c:4819
 packet_snd net/packet/af_packet.c:3076 [inline]
 packet_sendmsg+0x3eb6/0x50f0 net/packet/af_packet.c:3108
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 __sys_sendto+0x672/0x710 net/socket.c:2206
 __do_sys_sendto net/socket.c:2213 [inline]
 __se_sys_sendto net/socket.c:2209 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2209
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f077b39c819
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f077c28c028 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f077b615fa0 RCX: 00007f077b39c819
RDX: 000000000000fc13 RSI: 0000200000000800 RDI: 0000000000000003
RBP: 00007f077b432c91 R08: 0000000000000000 R09: fffffffffffffef0
R10: 0000000000000880 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f077b616038 R14: 00007f077b615fa0 R15: 00007fffceb20038
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

To test a patch for this bug, please reply with `#syz test`
(should be on a separate line).

The patch should be attached to the email.
Note: arguments like custom git repos and branches are not supported.

