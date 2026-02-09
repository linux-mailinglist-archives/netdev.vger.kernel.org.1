Return-Path: <netdev+bounces-257875-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOwkIRIoiWlt3QQAu9opvQ
	(envelope-from <netdev+bounces-257875-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 01:19:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D343510AB96
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 01:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E0FA3006B1C
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 00:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA151CAA65;
	Mon,  9 Feb 2026 00:19:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEE750276
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 00:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770596367; cv=none; b=GgEGFzwfiw5xnCny7RXuChNmgpJgsjedhqHzs2PU0mhbRtURnGcpwDKjR+7w4aKa9wbJ6/HFix8qA5ZYI3vphHJfCi/IKQ6QPNdUdRTv5/Xij1yZHTNI9a6IyT8tSCIIpk++LIrzM6WOFGT4oyrptcobhTX46HVFvwy0YcAB4Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770596367; c=relaxed/simple;
	bh=lBZM1xgHxBCUp6TL3dMrIYm5rbLw01Sc4Sl4VrHEz4c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ioDNK+OSOtcloX2D3csJOcIoMHG7IVkfNOdXkbTJmzbbquPEA+FqF9HpVxyftHRshXeCjSbyIq4eL7BvfhRelQV3t5RbA7GuC8cjDi8SB3ld1WYZL36E2obWUAA3SwXJ+Iu6h6eysOLuSO6K7LmGm9EdncPSqWSf2mPEn56mtzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-6630d58662aso21346267eaf.0
        for <netdev@vger.kernel.org>; Sun, 08 Feb 2026 16:19:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770596366; x=1771201166;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4y+WWLMCLjTZEHwqj34cXtdE5OheUzgAtMwdsIHOWuo=;
        b=EtBge54S9hdmIPBsWjN+eCSXKSp8YdxzOqeL+PRrTTiuNKwyKG2hWv3rLSJyYaC/PO
         sHJlF5eNgTxtEUW8TzypOVxo8C+2vjBbI4l0mco1kzAwQfqv8szlT9hCpINpN3ZxKUBB
         PeJTJyXHAo1HEc3K+pYCslgP4mNS7BOSh4sw4zduyn97c1AnYtD91x8LVkbA681UnxtC
         sQwLAFFJG/GOZxteJs20nHdOwBzxob/Wn7upaeSgP2DzdjHrJ/tt9hUgV/u3URRJPAG7
         ablQfXEFdTV7dZ3/076hmGAn7RHzXJmx0wM+f/B8bpWxDyKc64dnix/skpnedc/TnG+j
         aomQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUhaf6vB3QsQQFZ49grS9weDKH2fLAhavVwIf9OtO5JZscBRITgiA5hN/MAWam7wDy24sF/Z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTgfXuEovSAEKT7qm5wt37+ceivnfA1aR3jl80bBxEt5zM0L5j
	ocAfbo/AAusBZQwyROCiKkIA6q9v8wm+5J8RUECEJ0EQ1DalNdMIgx6d+oV14ek77EEsUcICMmK
	W60SousMEMxzbVy/1WzkJn+KMxfJ0lKUt9rLkekg8t7+sSOGoVAeqVnoHwtQ=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:180e:b0:662:f347:75ea with SMTP id
 006d021491bc7-66d0a380580mr4564359eaf.28.1770596365790; Sun, 08 Feb 2026
 16:19:25 -0800 (PST)
Date: Sun, 08 Feb 2026 16:19:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6989280d.050a0220.3b3015.0063.GAE@google.com>
Subject: [syzbot] [kernel?] INFO: task hung in rescuer_thread (3)
From: syzbot <syzbot+1d6360305e34d30ab396@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=2c36acc86fd56a9d];
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
	TAGGED_FROM(0.00)[bounces-257875-lists,netdev=lfdr.de,1d6360305e34d30ab396];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,googlegroups.com:email,appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: D343510AB96
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    9a9424c756fe net: usb: sr9700: remove code to drive nonexi..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17040a52580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c36acc86fd56a9d
dashboard link: https://syzkaller.appspot.com/bug?extid=1d6360305e34d30ab396
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115d0a5a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/aca10cd84bc5/disk-9a9424c7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/65bf8ad42e4f/vmlinux-9a9424c7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a69a5e1088ef/bzImage-9a9424c7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1d6360305e34d30ab396@syzkaller.appspotmail.com

INFO: task kworker/R-wg-cr:5992 blocked for more than 149 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/R-wg-cr state:D stack:25984 pid:5992  tgid:5992  ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue:  0x0 (wg-crypt-wg1)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5260 [inline]
 __schedule+0x14ea/0x5050 kernel/sched/core.c:6867
 __schedule_loop kernel/sched/core.c:6949 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:6964
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7021
 __mutex_lock_common kernel/locking/mutex.c:692 [inline]
 __mutex_lock+0x7fe/0x1300 kernel/locking/mutex.c:776
 worker_detach_from_pool kernel/workqueue.c:2730 [inline]
 rescuer_thread+0x593/0x1390 kernel/workqueue.c:3560
 kthread+0x726/0x8b0 kernel/kthread.c:463
 ret_from_fork+0x51b/0xa40 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>

Showing all locks held in the system:
1 lock held by kworker/R-rcu_g/4:
 #0: ffffffff8e3f8c88 (wq_pool_attach_mutex){+.+.}-{4:4}, at: worker_detach_from_pool kernel/workqueue.c:2730 [inline]
 #0: ffffffff8e3f8c88 (wq_pool_attach_mutex){+.+.}-{4:4}, at: rescuer_thread+0x593/0x1390 kernel/workqueue.c:3560


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

