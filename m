Return-Path: <netdev+bounces-273862-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPLHBlKJzGlXTgYAu9opvQ
	(envelope-from <netdev+bounces-273862-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 04:56:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 832163740FF
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 04:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88C0730F17E4
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 02:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4672B35F5F1;
	Wed,  1 Apr 2026 02:50:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F5B334C33
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 02:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775011836; cv=none; b=CyGmNVOsoMltwelp3P9m6bdi9lChVYQtCTQtjdRTytyu+pUqZu+rhDEVkgEqSnEyO89xiE0AdvOM4s/6PGpQgg4BeYry88e3/rK0rJFG3w1sHqR9nQ90EFupFMMhvNKZ3JxclCuWBPQOnMjfVJWm7GpllyB1LgsE19Y91Ivg8Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775011836; c=relaxed/simple;
	bh=d9XvbMpZMXsr5WuyC8py5aQskAdWjW8sRlYYjCmr0oE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=blm9ZanwfII6nJ0u55l0fkJrOJkIS14dEWrGs/Pn5ZllbJ4OaGbpGKWgA8q3k9NEL9UhpWzqkx/lyFDcATPnccAIzmgs/MnyWlYsogoVp9msSkjXa4XpqPwpXbksP6XAJkETbBaktNLOmY/zxDg6cFLU80zqEDiFXkXd1cHKH8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-67e0d20af55so13822662eaf.2
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 19:50:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775011825; x=1775616625;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2UlQ8q0G556gJ98oihFFGOlpIfop0IQ16E/lf62l3L4=;
        b=N0VovO0/qzE7k7ywOpuLpwxzVfqSl94hmVxbgPq+90VoVqo/j97fe0E6ItEBcQCcqK
         xUxod8rcIEFpkxFrlC+tcdKh2v5WAmZU2YPyvfgnb94Eiq2wzd6AXe31nqGM8d27jfpA
         67zOGxBqFA1DHgrg0dNf669+6UbjzZFGXAig0DkXIJYuIofK54PZ8wlxNZ7M8Lg5TbT/
         5u88fqL5QZGWb+0r7JJwSFRqvH6lICK4UGsKXrb46R5AOCXnNNxaoywdGgdA5SDTjzwq
         aLuH7+dQf4K8zgO3DqlP772lDZE0L1DIJvRGYo1ogq+m98Ndr28PYIBganmodTbRXXyf
         JgBw==
X-Forwarded-Encrypted: i=1; AJvYcCXysdMS0NvKEC9h/UtPwXYApZ1lnBUA/jeYlsvRYkFz4H+UBo3etYab2TDLOW5bnHtFeNViPjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNOXwYiF44CqmYXJ3/nby9L65t5e6zV8FQcQ/3bEELr/o7Z6ZY
	RKPbGW0Hz1pro0N0udiLx3A30iUnTlrNnTRB8yYdPVIEsZUXVsHeMQY0SARz4qF9ARfderIcAbF
	Bxz6bNQqni7OiKggZqNtcvJlbTY1tZvGbDV0c9TAYF7Ej4PaUlxTmd+Q7azQ=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:209:b0:67b:d91e:55 with SMTP id
 006d021491bc7-67fabbdb6edmr954163eaf.7.1775011825255; Tue, 31 Mar 2026
 19:50:25 -0700 (PDT)
Date: Tue, 31 Mar 2026 19:50:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69cc87f1.050a0220.183828.0038.GAE@google.com>
Subject: [syzbot] [net?] WARNING: refcount bug in dev_deactivate_many
From: syzbot <syzbot+1bd67523d909320dd9e2@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=5a3e5e8c17cc174e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-273862-lists,netdev=lfdr.de,1bd67523d909320dd9e2];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,googlegroups.com:email,appspotmail.com:email,goo.gl:url]
X-Rspamd-Queue-Id: 832163740FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    f242ac4a0944 Merge tag 'x86-urgent-2026-03-29' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=165f90f2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a3e5e8c17cc174e
dashboard link: https://syzkaller.appspot.com/bug?extid=1bd67523d909320dd9e2
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a3583806d09a/disk-f242ac4a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0718400bb1a9/vmlinux-f242ac4a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b22f3be2e373/bzImage-f242ac4a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1bd67523d909320dd9e2@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: decrement hit 0; leaking memory.
WARNING: lib/refcount.c:31 at refcount_warn_saturate+0x7c/0x130 lib/refcount.c:31, CPU#0: kworker/u8:5/93
Modules linked in:
CPU: 0 UID: 0 PID: 93 Comm: kworker/u8:5 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Workqueue: events_unbound linkwatch_event
RIP: 0010:refcount_warn_saturate+0x7c/0x130 lib/refcount.c:31
Code: c0 51 1a 8c e8 25 17 12 fd 83 fd 02 0f 84 a1 00 00 00 76 27 83 fd 03 74 7d 83 fd 04 75 3e e8 fb 1b 12 fd 48 8d 3d b4 57 ed 0b <67> 48 0f b9 3a e8 ea 1b 12 fd 5b 5d c3 cc cc cc cc 85 ed 74 3a e8
RSP: 0018:ffffc9000215f878 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88802a98c664 RCX: ffffffff84f6dbcb
RDX: ffff88801e7924c0 RSI: ffffffff84f6dbe5 RDI: ffffffff90e433a0
RBP: 0000000000000004 R08: 0000000000000005 R09: 0000000000000004
R10: 0000000000000004 R11: 0000000000000000 R12: 1ffff9200042bf14
R13: ffff88802a98c664 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88812433c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2ff15ff8 CR3: 000000003954a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __refcount_dec include/linux/refcount.h:461 [inline]
 refcount_dec include/linux/refcount.h:476 [inline]
 ref_tracker_free+0x5cd/0x6c0 lib/ref_tracker.c:303
 netdev_tracker_free include/linux/netdevice.h:4456 [inline]
 netdev_put include/linux/netdevice.h:4473 [inline]
 netdev_put include/linux/netdevice.h:4469 [inline]
 netdev_watchdog_down net/sched/sch_generic.c:575 [inline]
 dev_deactivate_many+0x28f/0xfc0 net/sched/sch_generic.c:1337
 dev_deactivate+0xf8/0x1c0 net/sched/sch_generic.c:1368
 linkwatch_do_dev net/core/link_watch.c:184 [inline]
 linkwatch_do_dev+0xce/0x110 net/core/link_watch.c:166
 __linkwatch_run_queue+0x3a9/0x900 net/core/link_watch.c:240
 linkwatch_event+0x8f/0xc0 net/core/link_watch.c:314
 process_one_work+0xa23/0x19a0 kernel/workqueue.c:3276
 process_scheduled_works kernel/workqueue.c:3359 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3440
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
----------------
Code disassembly (best guess):
   0:	c0 51 1a 8c          	rclb   $0x8c,0x1a(%rcx)
   4:	e8 25 17 12 fd       	call   0xfd12172e
   9:	83 fd 02             	cmp    $0x2,%ebp
   c:	0f 84 a1 00 00 00    	je     0xb3
  12:	76 27                	jbe    0x3b
  14:	83 fd 03             	cmp    $0x3,%ebp
  17:	74 7d                	je     0x96
  19:	83 fd 04             	cmp    $0x4,%ebp
  1c:	75 3e                	jne    0x5c
  1e:	e8 fb 1b 12 fd       	call   0xfd121c1e
  23:	48 8d 3d b4 57 ed 0b 	lea    0xbed57b4(%rip),%rdi        # 0xbed57de
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	e8 ea 1b 12 fd       	call   0xfd121c1e
  34:	5b                   	pop    %rbx
  35:	5d                   	pop    %rbp
  36:	c3                   	ret
  37:	cc                   	int3
  38:	cc                   	int3
  39:	cc                   	int3
  3a:	cc                   	int3
  3b:	85 ed                	test   %ebp,%ebp
  3d:	74 3a                	je     0x79
  3f:	e8                   	.byte 0xe8


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

