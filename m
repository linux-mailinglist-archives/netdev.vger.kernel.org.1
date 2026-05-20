Return-Path: <netdev+bounces-289925-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGcOIfqkDWpM0wUAu9opvQ
	(envelope-from <netdev+bounces-289925-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:11:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F145F58D604
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7364230665BA
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 11:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20C53D1CDB;
	Wed, 20 May 2026 11:55:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD1D374735
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 11:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779278138; cv=none; b=Vbo/TqunutSG4YB1PMdDeqH2nFreo0JsXr8vs6tU612fkb9udEUFkg7Sl4chLaN9Ti97ZdKNOkxvKyCj+Hs/3XHivc8PACuUJGgybbpBkH2jVUySr67C9tQLNANgBO+dQPML76VEsIj2ro6WoWBeSLgFNDbSlvArDZwb4yMJG4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779278138; c=relaxed/simple;
	bh=hje88MKRm504VTdbSlvpEtbK/6SzAqPKYbeaWtiQV9I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cwDrDpoxyY95CxGA1xLMUta2LHgVh2Kx9J1uDPD1GrjC0QaPGQK2aZWrDzGUGFscq4iokqeshIjZmmdQ9+tr3I8pYuaAzBvOHjjbLE1aGEL9PPpBrkN522wqC4VczWHrFwO7n16wwG07srobW2kQzQMbaXj8Mn0c9BodvRS1UDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-69d0a1cb4a1so13298305eaf.0
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 04:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779278136; x=1779882936;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8GZol9qQ+dw2DLZfx9vE3fAfJaHwkWrSoxo+SKKzVtw=;
        b=b13xm0SygsNSe3WCIO2FftjRN4cXZXsu91F5nRaoea+yi/F4G4mhnNUke0wHmLln/v
         LxlI+sSchBtPYSJRQ7JKe73knPXTbx7uVvfqIgUQJF9ywunctunPmFLpoUOpL+v5zGac
         BZygzEvLdgFEmIyskVY1v2ahk7Ufg9A9qaLeF+JgKt/Rpv+MIfNRbb2T9jrkot/SJhh8
         H0tTdqaTwWAD/guG2FQw78SrygnQy70lWj4r1vG9n6tp/wH0/4U7yHgRKtip5QMqQAU+
         69eivYmqrphKvQ1H4DV7B6Q8cMEvMZAAbtAlKqjwQIzo8sWfaW4+Sl5qycTwu8ZSSfex
         gL1g==
X-Forwarded-Encrypted: i=1; AFNElJ8GNnF6WtkLyjOt+bmSllFRd94SjDbJiu4lbOeJQQn1g3CaHsMNIa7Fa0FVF1dICnDFS+oTkc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSZ9QFrzyUxLryVHyVX/mmyMl4unYPN1TlYQP6QDp1D6Kr2Jda
	Tv+ZFqjQIe6SfGjSLYds6rnj6P1XfclvynJZ0rFX416ntS4CaM1OVsb4BJrd6hgux6/JTCLx91D
	biPSYIhEDPX86wYMwkGCwGfTk1r4AsgIDESLqldOqP7h7AItNeUjg7xJM+1g=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f07:b0:67e:16b4:aa0d with SMTP id
 006d021491bc7-69c9437c154mr13458890eaf.30.1779278136388; Wed, 20 May 2026
 04:55:36 -0700 (PDT)
Date: Wed, 20 May 2026 04:55:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a0da138.170a0220.3cbd30.0141.GAE@google.com>
Subject: [syzbot] [mptcp?] WARNING in mptcp_pm_alloc_anno_list (2)
From: syzbot <syzbot+55c2a5c871441261ed14@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, geliang@kernel.org, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martineau@kernel.org, matttbe@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=cb5b551cf65fa040];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289925-lists,netdev=lfdr.de,55c2a5c871441261ed14];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,goo.gl:url,syzkaller.appspot.com:url,appspotmail.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F145F58D604
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    ab5fce87a778 Merge tag 'perf-tools-fixes-for-v7.1-2026-05-..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=175fcca6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb5b551cf65fa040
dashboard link: https://syzkaller.appspot.com/bug?extid=55c2a5c871441261ed14
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e36518c61bd7/disk-ab5fce87.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cd934c0c8950/vmlinux-ab5fce87.xz
kernel image: https://storage.googleapis.com/syzbot-assets/88cf18661142/bzImage-ab5fce87.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+55c2a5c871441261ed14@syzkaller.appspotmail.com

------------[ cut here ]------------
mptcp_pm_is_kernel(msk)
WARNING: net/mptcp/pm.c:436 at mptcp_pm_alloc_anno_list+0x408/0x4d0 net/mptcp/pm.c:436, CPU#1: kworker/1:6/5792
Modules linked in:
CPU: 1 UID: 0 PID: 5792 Comm: kworker/1:6 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Workqueue: events mptcp_worker
RIP: 0010:mptcp_pm_alloc_anno_list+0x408/0x4d0 net/mptcp/pm.c:436
Code: 8d 7b 30 49 c7 c0 00 6f 64 9b 48 c7 c1 40 f5 28 8d 31 d2 48 c7 c6 b0 43 77 8b e8 c3 b3 7c f6 e9 c6 fc ff ff e8 c9 5b 91 f6 90 <0f> 0b 90 31 db e9 09 fd ff ff 48 c7 c7 c4 39 d8 90 e8 22 27 fe f6
RSP: 0018:ffffc90004187818 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888079295f00 RCX: ffffffff8b772ecf
RDX: ffff888029de1ec0 RSI: ffffffff8b773217 RDI: ffff888029de1ec0
RBP: ffff88807e593100 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: dffffc0000000000 R14: ffff88807e593100 R15: ffff88806a3a5e80
FS:  0000000000000000(0000) GS:ffff88812446d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000020000035e030 CR3: 0000000068e39000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 mptcp_pm_create_subflow_or_signal_addr+0xa7a/0x18a0 net/mptcp/pm_kernel.c:373
 mptcp_pm_nl_subflow_established net/mptcp/pm_kernel.c:443 [inline]
 __mptcp_pm_kernel_worker+0xe5/0x1f0 net/mptcp/pm_kernel.c:1573
 mptcp_pm_worker+0x12b/0x320 net/mptcp/pm.c:1069
 mptcp_worker+0x15d/0x1420 net/mptcp/protocol.c:2976
 process_one_work+0xa0e/0x1980 kernel/workqueue.c:3314
 process_scheduled_works kernel/workqueue.c:3397 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3478
 kthread+0x370/0x450 kernel/kthread.c:436
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

