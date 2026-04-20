Return-Path: <netdev+bounces-279945-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wF87BBmk5mkIzQEAu9opvQ
	(envelope-from <netdev+bounces-279945-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 00:09:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F14434831
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 00:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7279A30065FE
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 22:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A573A6F06;
	Mon, 20 Apr 2026 22:09:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB7735AC2C
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 22:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776722966; cv=none; b=UmqWmo67htx7r8LH0/fEeG5MU5+MmoAjIOWNnIhwTsYA/3UeUCDbRO4EWLSKR7Ivkw+cgPeKqFPBya6lAv/yxmYuAF+ETgsBHTzESM+8v7EGpHBC7XHSEkuS9BtVsv9+3mdGDZyDfNUbtbHgK7wOVzruXu7r6t7KUFdwK/za/F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776722966; c=relaxed/simple;
	bh=hrFHtqLbDq9M1V1QGwN0glJ8tclczOC6jmqxV/uNhYY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iy0Mf9pZQSYtfSYJ4M92DCDqEfFM6hd69gqdUkWyYBSeBbIsQzQ4X6aljwTcMyl48XOvKQmlESgJ1RcVHj31ldeODVSNlpk1k/0S8iaEfXu0rcwYexgm4tfC9arrBPiaxrnUyiNMfBisyZnMSM4CMpFhxagrkIWzdplknLseoD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-68d5974b947so6937709eaf.1
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 15:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776722964; x=1777327764;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hCgfnVADftIsIAYtvNsVF78ADGo857Z72sg3ZFoPg9w=;
        b=h70nVAxG863GTpebRxwZXntOHJ3YVLy1gaTxV6sxFzNBhz7Vx1kqBTQNGOz7ll9dVp
         Ppdvkzgb5y0rdH/ekKMyyMOvi9gIj4LDKaJuUCVcAmv5JuNojK9yfoIIQyl0ssYMjeA3
         QDsXQoyb5wvogcEZyh6D5IoVq4szkJLbRs5y1acHyPxODH3nlLxdtco+uzWswtdOvcWy
         vikbGryDjoOuFSLZyk5JAfyz1BaywjByUqdTRNI0lEDy0V66QSqybSc7uH5KMo/QXvSl
         GfRm6/dHuGolp7+pPaO1MvZFakasUaM/qcXFxhx1DCT/5TGO8Y9eewuJr/NxLZsIGyed
         rd7A==
X-Forwarded-Encrypted: i=1; AFNElJ+t+W5BZEmwRYUm02UPD5v09AeZFFaJavrLeSUkv5OlktfqApnQYIaRrhlkjO+xbYyaxkLuzvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwcAOzHx9FxgQIOA5yKsZWPnMVOxRnGHyc2apBCS0ALFG+wVqr
	j3zobZzFWzr7Oj6VbLmKGoCoAhkp36//985f6sTlXhPz4MfPuSC2OwYO4nMJZcHecVyEnuWFuCF
	gv57bvkr9KC2soMWmr9dB7cA9ppwUMmdOBiMZMjguNDG6xFvhCxesEmzaXhA=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:ee05:0:b0:694:8b08:b916 with SMTP id
 006d021491bc7-6948b08bcb0mr2461508eaf.35.1776722964168; Mon, 20 Apr 2026
 15:09:24 -0700 (PDT)
Date: Mon, 20 Apr 2026 15:09:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69e6a414.050a0220.24bfd3.002d.GAE@google.com>
Subject: [syzbot] [kvm?] [net?] [virt?] BUG: sleeping function called from
 invalid context in vhost_get_avail_idx
From: syzbot <syzbot+6985cb8e543ea90ba8ee@syzkaller.appspotmail.com>
To: eperezma@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=7e54da1916e8d11f];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-279945-lists,netdev=lfdr.de,6985cb8e543ea90ba8ee];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,storage.googleapis.com:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,appspotmail.com:email];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: A4F14434831
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    8541d8f725c6 Merge tag 'mtd/for-7.1' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=136454ce580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7e54da1916e8d11f
dashboard link: https://syzkaller.appspot.com/bug?extid=6985cb8e543ea90ba8ee
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d264ce580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143ec1ba580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-8541d8f7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/22dfea2c37c2/vmlinux-8541d8f7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e2f93ad68fe3/bzImage-8541d8f7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6985cb8e543ea90ba8ee@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at drivers/vhost/vhost.c:1527
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6110, name: vhost-6109
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
2 locks held by vhost-6109/6110:
 #0: ffff888055624cb0 (&vq->mutex/1){+.+.}-{4:4}, at: handle_tx+0x2d/0x160 drivers/vhost/net.c:971
 #1: ffff888055620248 (&vq->mutex){+.+.}-{4:4}, at: vhost_net_busy_poll+0x9c/0x730 drivers/vhost/net.c:554
Preemption disabled at:
[<ffffffff88f1a006>] vhost_net_busy_poll+0x1c6/0x730 drivers/vhost/net.c:563
CPU: 0 UID: 0 PID: 6110 Comm: vhost-6109 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 __might_resched.cold+0x1ec/0x232 kernel/sched/core.c:9162
 __might_fault+0x8b/0x140 mm/memory.c:7322
 vhost_get_avail_idx+0x31c/0x4f0 drivers/vhost/vhost.c:1527
 vhost_vq_avail_empty drivers/vhost/vhost.c:3206 [inline]
 vhost_vq_avail_empty+0xa9/0xe0 drivers/vhost/vhost.c:3199
 vhost_net_busy_poll+0x297/0x730 drivers/vhost/net.c:574
 vhost_net_tx_get_vq_desc drivers/vhost/net.c:610 [inline]
 get_tx_bufs.constprop.0+0x338/0x600 drivers/vhost/net.c:650
 handle_tx_copy+0x28c/0x12e0 drivers/vhost/net.c:778
 handle_tx+0x139/0x160 drivers/vhost/net.c:985
 vhost_run_work_list+0x183/0x220 drivers/vhost/vhost.c:454
 vhost_task_fn+0x156/0x430 kernel/vhost_task.c:49
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

