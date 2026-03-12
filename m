Return-Path: <netdev+bounces-267125-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCzsHJ3csmlMQQAAu9opvQ
	(envelope-from <netdev+bounces-267125-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:32:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC15C27489B
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBA053245CCE
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CB437CD55;
	Thu, 12 Mar 2026 15:26:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C85D36C584
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 15:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773329194; cv=none; b=gOGALYw1pbYGzw6Yg8vKK2PENrdxTZA9z2y/rqrlJTbtKjwl0zfsksGwRxxu5chF6vz5GoDEf7rJ50fMc48NIM3BymYZVelsRc5rXB4qQ3IrnINiW9VMUodWg8YMFOhuXoXyuG6A0wifQtwvcVhRhnIaspl7cdiVS9i+FLgD+f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773329194; c=relaxed/simple;
	bh=GHsK8YuZly8QH9uD0W7Wt/J9nBRPCip4pmNOoLPQ9Sw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=A/Qsuiym5n/Xh7zCKLJt2At2PEEb3xYww5O4z7COfNKyesJMt/XRoxR4u05mTMowt0g4gzf1xh/otSoBQsdEalbxRS0KXItjpjrHVMHA6E+wKAqHrfQSlweX9+JWLunGK2snyM2ELUSJhmTwyWcGq7eqQmc2+ytTFy9a0/TCH+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-66b612efb4aso14780666eaf.0
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 08:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773329192; x=1773933992;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rj9s+mz7zHP4ESHMfr59tdOV8XXR/bIPPqhzBvT0ASY=;
        b=TLeCW40ROiTkjun0oup76Hz0k4sZDHTp44coDO1RAfOWdYPOgIm++OJ7H0uIVzLElk
         Bo+lEWRbDEtMOiZI4ZESHl6/ArKlxDDYBC4tOBNliy7/3jQSJeWXNMgXuNQoughntmxD
         r5CkwYzOs2Xnq/DB7nYliznbxBDrrFI9SQAse7oiuSg0ZR1hHDqTduKBpRWBuiQnL1zq
         t8n7PCJZu0y5+igU2SB+Q9r/87TfauDZm1qRx2jjOlrJQOwL7v8ZwPdcGYRgxlIvHtE0
         ZB+CCXWmWXikcIKhmJjURLl1qEmGHpZAXNe7HZWUVxAWIUFbw/HQcJDbmSfw5brULzEY
         clLg==
X-Forwarded-Encrypted: i=1; AJvYcCUMfx/bY98vLEEGUW6FQagfM20+apz6uDSuiBcYnZLAOu4JfpoLTrXM+bNrX8P424inawotgxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvRhyMHgpkw5v+suqD2yUDkHG9a3GCSwzpeluU9yUYIZ66FS3x
	iiBeamFZCQhyZKAOeJqHpxh4LvNdhd1UyGcaQg32dybkLsf3OzY042pcWMSpu34s9fySDvw7OcR
	kvCW9xh73Lq8qaMEa55LINiqxPkxVVo8mU5RftwqYTH1j2f8wf/6KY8D847U=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:622:b0:67b:ba3d:56ba with SMTP id
 006d021491bc7-67bd0792074mr3020473eaf.29.1773329192102; Thu, 12 Mar 2026
 08:26:32 -0700 (PDT)
Date: Thu, 12 Mar 2026 08:26:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69b2db28.a00a0220.94e15.0025.GAE@google.com>
Subject: [syzbot] [net?] KCSAN: data-race in pfifo_fast_dequeue /
 pfifo_fast_enqueue (6)
From: syzbot <syzbot+b44f2bbe286b9355c563@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=ec543385a37b9f17];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-267125-lists,netdev=lfdr.de,b44f2bbe286b9355c563];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,goo.gl:url,storage.googleapis.com:url,googlegroups.com:email,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: AC15C27489B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    37a93dd5c49b Merge tag 'net-next-7.0' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1244fa52580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ec543385a37b9f17
dashboard link: https://syzkaller.appspot.com/bug?extid=b44f2bbe286b9355c563
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5c78f22cfb6c/disk-37a93dd5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/77c2f419bced/vmlinux-37a93dd5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5640d838c887/bzImage-37a93dd5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b44f2bbe286b9355c563@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in pfifo_fast_dequeue / pfifo_fast_enqueue

write to 0xffff88811d5ccc00 of 8 bytes by interrupt on cpu 0:
 __ptr_ring_zero_tail include/linux/ptr_ring.h:259 [inline]
 __ptr_ring_discard_one include/linux/ptr_ring.h:291 [inline]
 __ptr_ring_consume include/linux/ptr_ring.h:311 [inline]
 __skb_array_consume include/linux/skb_array.h:98 [inline]
 pfifo_fast_dequeue+0x770/0x8f0 net/sched/sch_generic.c:770
 dequeue_skb net/sched/sch_generic.c:297 [inline]
 qdisc_restart net/sched/sch_generic.c:402 [inline]
 __qdisc_run+0x189/0xc80 net/sched/sch_generic.c:420
 qdisc_run include/net/pkt_sched.h:120 [inline]
 net_tx_action+0x379/0x590 net/core/dev.c:5793
 handle_softirqs+0xb9/0x280 kernel/softirq.c:622
 do_softirq+0x45/0x60 kernel/softirq.c:523
 __local_bh_enable_ip+0x70/0x80 kernel/softirq.c:450
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 bpf_test_run+0x2db/0x620 net/bpf/test_run.c:426
 bpf_prog_test_run_skb+0x9a4/0xef0 net/bpf/test_run.c:1159
 bpf_prog_test_run+0x204/0x340 kernel/bpf/syscall.c:4721
 __sys_bpf+0x52e/0x7e0 kernel/bpf/syscall.c:6246
 __do_sys_bpf kernel/bpf/syscall.c:6341 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6339 [inline]
 __x64_sys_bpf+0x41/0x50 kernel/bpf/syscall.c:6339
 x64_sys_call+0x10cb/0x3020 arch/x86/include/generated/asm/syscalls_64.h:322
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88811d5ccc00 of 8 bytes by task 22632 on cpu 1:
 __ptr_ring_produce include/linux/ptr_ring.h:106 [inline]
 ptr_ring_produce include/linux/ptr_ring.h:129 [inline]
 skb_array_produce include/linux/skb_array.h:44 [inline]
 pfifo_fast_enqueue+0xd5/0x2c0 net/sched/sch_generic.c:741
 dev_qdisc_enqueue net/core/dev.c:4144 [inline]
 __dev_xmit_skb net/core/dev.c:4188 [inline]
 __dev_queue_xmit+0x6a4/0x1f20 net/core/dev.c:4795
 dev_queue_xmit include/linux/netdevice.h:3384 [inline]
 __bpf_tx_skb net/core/filter.c:2153 [inline]
 __bpf_redirect_common net/core/filter.c:2197 [inline]
 __bpf_redirect+0x862/0x990 net/core/filter.c:2204
 ____bpf_clone_redirect net/core/filter.c:2487 [inline]
 bpf_clone_redirect+0x20c/0x290 net/core/filter.c:2450
 bpf_prog_53f18857bc887b09+0x22/0x2a
 bpf_dispatcher_nop_func include/linux/bpf.h:1402 [inline]
 __bpf_prog_run include/linux/filter.h:723 [inline]
 bpf_prog_run include/linux/filter.h:730 [inline]
 bpf_test_run+0x29d/0x620 net/bpf/test_run.c:423
 bpf_prog_test_run_skb+0x9a4/0xef0 net/bpf/test_run.c:1159
 bpf_prog_test_run+0x204/0x340 kernel/bpf/syscall.c:4721
 __sys_bpf+0x52e/0x7e0 kernel/bpf/syscall.c:6246
 __do_sys_bpf kernel/bpf/syscall.c:6341 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6339 [inline]
 __x64_sys_bpf+0x41/0x50 kernel/bpf/syscall.c:6339
 x64_sys_call+0x10cb/0x3020 arch/x86/include/generated/asm/syscalls_64.h:322
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0xffff888104a93a00 -> 0x0000000000000000

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 22632 Comm: syz.0.4135 Tainted: G        W           syzkaller #0 PREEMPT(full) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
==================================================================


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

