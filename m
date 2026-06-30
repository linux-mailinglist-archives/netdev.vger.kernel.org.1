Return-Path: <netdev+bounces-302980-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qICdMjNgQ2paXgoAu9opvQ
	(envelope-from <netdev+bounces-302980-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 08:20:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CD43C6E0B09
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 08:20:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302980-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-302980-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D200E3006927
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 06:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487C63E00B9;
	Tue, 30 Jun 2026 06:20:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23533E2AD6
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 06:20:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782800422; cv=none; b=pGmTccuPqKEWxMIO2b8zJ2GRtKcM7MRRlJ5r+EQkB85dq7iJpDPNxRFWEKW8xalbcNbRkU+G8ro4cCozvcoMcFEKDcAJF3IIJ9cP4TeS6tnhfxXwiTwqBHjvR9LfVzgIyJiXBemjaJ4AEOlhc1T2D3siIMeMFjdQJYH8fnYJip4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782800422; c=relaxed/simple;
	bh=cEsCrGj+9F9IQFWnuctbba8n0jEKZ3TqDH7l5Qt7IFY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IqpGYg3clykkk4loOsy1D+2pTxin3lupHIw1aDcQXFGAWg8eDog9e1rTed6SAuPpmk3v7z9D7DoeX7Oni8VDo/dvEfvqyTCNSARz3V9d/JuyjrZrMz2ZzPVURcY90cQ/y1gwVXBhzyCZ/XsytHfEl2qsuysi6KUdMYkTTaILII8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-495f6da4e22so137577b6e.3
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 23:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782800420; x=1783405220;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DnbMFUM7qZ+D+NV7cL8jZmwUgpg+omKmeavLOl+0ZQ8=;
        b=i2pTmcoBvnvsuXnRBuBG7jiDNUyM9mAaxl3gfnuPsobHROLxEjTGhqSIZxts/34af4
         97V2kg29nwqtccFO+CAG7R8a4VqdEJqH4AlseJyJ9orMNG5wE1fMHa7/nP/GtG8oxDgT
         n0BBg5DDfl5WPE/GSSl/W7JG08mCg26H5LpDB52ZFkqqWFdU4nTewwMSZJ4pE2oMqAlU
         5HNuXDrNAXVae19UKrn6mK/v0oy4n+xTcl8bleIPCMLo3ZBeu6OTHZNe29bh+fttuWNR
         yE/It7qs9MK0hh+K7B9ZRPsBjPPS1nnvfHKSlIXSjVdemgszQdnThi+AHXQqLh2AZ14x
         0jqA==
X-Forwarded-Encrypted: i=1; AFNElJ9ogc3WqyU6sP2P4eiBfNqQGsnJ4J4qQX6y6uYQBhZR0592YkrKoNMIfacabQj20AnKza9LUI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIsyDxhKkUajqssXYU26C7oAWNTqJZ7PT8hNFTx9JV26oEp7rs
	9CBX/xpdv8YXAt//g5zKrZV3oD0eH676itppFYUWnk7b8mmHcNh8J5VjCAUzwfh+smpguq52/Is
	qnIVSjkQmLp600zrvzEZw8Q7iPELno/oWji/AkmKap6NMwCxePiT2+iqGz9o=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4c84:b0:495:f25f:f333 with SMTP id
 5614622812f47-495f2600e1emr670746b6e.22.1782800419888; Mon, 29 Jun 2026
 23:20:19 -0700 (PDT)
Date: Mon, 29 Jun 2026 23:20:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a436023.b42ede87.8e801.0003.GAE@google.com>
Subject: [syzbot] [bpf?] BUG: using smp_processor_id() in preemptible code in bpf_mem_cache_free_rcu
From: syzbot <syzbot+fd7e415d891073b83e1f@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	memxor@gmail.com, netdev@vger.kernel.org, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=1ce9592ed82f8125];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302980-lists,netdev=lfdr.de,fd7e415d891073b83e1f];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,goo.gl:url,googlegroups.com:email,syzkaller.appspot.com:url,storage.googleapis.com:url,syzkaller.appspotmail.com:from_mime];
	FORGED_RECIPIENTS(0.00)[m:andrii@kernel.org,m:ast@kernel.org,m:bpf@vger.kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:emil@etsalapatis.com,m:jolsa@kernel.org,m:linux-kernel@vger.kernel.org,m:martin.lau@linux.dev,m:memxor@gmail.com,m:netdev@vger.kernel.org,m:song@kernel.org,m:syzkaller-bugs@googlegroups.com,m:yonghong.song@linux.dev,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,vger.kernel.org,iogearbox.net,gmail.com,etsalapatis.com,linux.dev,googlegroups.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	ALIAS_RESOLVED(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD43C6E0B09

Hello,

syzbot found the following issue on:

HEAD commit:    e771677c937d Merge tag 'for-linus-iommufd' of git://git.ke..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=144f8aae580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ce9592ed82f8125
dashboard link: https://syzkaller.appspot.com/bug?extid=fd7e415d891073b83e1f
compiler:       Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-1~exp1~20260514074407.73), Debian LLD 22.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=124c12ae580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b89986580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5c69b301ec25/disk-e771677c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8267811b5065/vmlinux-e771677c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bcc54586e6c4/bzImage-e771677c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fd7e415d891073b83e1f@syzkaller.appspotmail.com

BUG: using smp_processor_id() in preemptible [00000000] code: syz.0.17/5820
caller is bpf_mem_cache_free_rcu+0x48/0xc0 kernel/bpf/memalloc.c:954
CPU: 1 UID: 0 PID: 5820 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 check_preemption_disabled+0xd3/0xe0 lib/smp_processor_id.c:47
 bpf_mem_cache_free_rcu+0x48/0xc0 kernel/bpf/memalloc.c:954
 rhtab_delete_elem+0x185a/0x1b30 kernel/bpf/hashtab.c:2969
 __rhtab_map_lookup_and_delete_batch+0x935/0xcb0 kernel/bpf/hashtab.c:3349
 bpf_map_do_batch+0x445/0x630 kernel/bpf/syscall.c:-1
 __sys_bpf+0x906/0xd90 kernel/bpf/syscall.c:-1
 __do_sys_bpf kernel/bpf/syscall.c:6537 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6534 [inline]
 __x64_sys_bpf+0xba/0xd0 kernel/bpf/syscall.c:6534
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fce2819ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcea2ad4b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fce28415fa0 RCX: 00007fce2819ce59
RDX: 0000000000000038 RSI: 00002000000018c0 RDI: 0000000000000019
RBP: 00007fce28232d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fce28415fac R14: 00007fce28415fa0 R15: 00007fce28415fa0
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

