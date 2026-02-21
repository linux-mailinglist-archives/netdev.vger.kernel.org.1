Return-Path: <netdev+bounces-259836-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPf0CaAwmmnnZQMAu9opvQ
	(envelope-from <netdev+bounces-259836-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 23:24:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5002316E1ED
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 23:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4F8C3028ED3
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 22:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4014B30C345;
	Sat, 21 Feb 2026 22:24:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19F93C17
	for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 22:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771712669; cv=none; b=Q9O8FDY90n1RSXYgFqImVLZTBpoTMVs53jCCuNGM27QaxYKVNvbzaGHLJwl0rTZ5ce0DiziqGO/0LTKF3mtnLAV3zuedvL4scE+xhhu6Sl6yErBRKtjiWgIOwinfxtu9+EP2P2wjc6WCIbpPbGbuAhH5lwhhQ8hhbz/d9+daL2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771712669; c=relaxed/simple;
	bh=aeh6i58Bb1YcPIZer3SR6lHi/FLThxRL4BocdX+ERdM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YlJfUD6vO3MZzx2aVmm6yYHutOl11O9v2eWItOpVqIU2G7ffj/3wll2az53azcD2KUCAE3K9euulUPOKguK3sh77dQ14OE4nSjuD/XMfpVMcqKrrmcK6WmbDCm6uCXoV2gD8HXafrIMCs7F2wByr8WAame3D9Hk5ZP32VYeCgss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-679943693c0so53497581eaf.3
        for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 14:24:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771712667; x=1772317467;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b4I97kyRF6zNjRiiT3Q6lTqxeSzAqTCbveJzfDz68tI=;
        b=XPGzzgR6tViuCEHo/YLDDfMVIlHElRW1NMS04LIQj8y+0B5NdwS7nA9nboMLvMOS3v
         knqEWO1DyIhdN40OyJsJ/uBMQDblYw/YGBAjpzNYT4eAqC2I17NLr35fs52kjbB8MBX/
         IW0Lxy0jLQhxaetKbU8mKY/EhPfNl0JksWS6MMTqcSkmQgZNICJ2Csnc46h//+pjTt8S
         oqPeFG2aDwj5nnaO5omPur2WOk5ax/wYbvI+OlJE3SdItHNXGHDFQvigMfFYarCrKwIT
         J7C+wDxodj560Re+x5h9thq9NfYBV/ck8i/+HhLpd1JtPdVc7VzhbsGt9pEHG7SUumUS
         NVfA==
X-Forwarded-Encrypted: i=1; AJvYcCUXCqeceFsv1vR5bzDmd2bnQDnw2RCeh8uffazDKbmcF/gYw+AvoRKHkcZKR+V9SZAB1wMdPWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNFKO+kbt3NfGW+tMwP0xiYqfMdJICLPctYLCn6mWefPuA7Rwl
	S5woBky5SNl8R147pTfkCbS3ZvacF5UVBCYXmxWrn/ib5nIRBAahURl50gamq8Tr1G/5m+KBHTF
	K10241pIhYSFRb4yZ7a3H8IkRTtvFbMdrLYmnOeEIv7fXaiLgcE9Nm9mY2iY=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:16a3:b0:679:94ff:6ea7 with SMTP id
 006d021491bc7-679c4251e3dmr2394455eaf.15.1771712666946; Sat, 21 Feb 2026
 14:24:26 -0800 (PST)
Date: Sat, 21 Feb 2026 14:24:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <699a309a.a70a0220.2c38d7.0165.GAE@google.com>
Subject: [syzbot] [net?] [trace?] WARNING: refcount bug in call_timer_fn (4)
From: syzbot <syzbot+07dcf509f4c013e25dc5@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, peterz@infradead.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=38a0c4cddc846161];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259836-lists,netdev=lfdr.de,07dcf509f4c013e25dc5];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,syzkaller.appspot.com:url,goo.gl:url,googlegroups.com:email,storage.googleapis.com:url]
X-Rspamd-Queue-Id: 5002316E1ED
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    8b690556d8fe Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11715658580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=38a0c4cddc846161
dashboard link: https://syzkaller.appspot.com/bug?extid=07dcf509f4c013e25dc5
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3ca2379f6d75/disk-8b690556.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ce7e9a97f8b4/vmlinux-8b690556.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0936d2c0b069/bzImage-8b690556.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+07dcf509f4c013e25dc5@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 1 PID: 29 at lib/refcount.c:28 refcount_warn_saturate+0x11a/0x1d0 lib/refcount.c:28
Modules linked in:
CPU: 1 UID: 0 PID: 29 Comm: ktimers/1 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:refcount_warn_saturate+0x11a/0x1d0 lib/refcount.c:28
Code: c0 30 3d 8b e8 c7 91 09 fd 90 0f 0b 90 90 eb d7 e8 ab 4a 45 fd c6 05 10 1a 47 0a 01 90 48 c7 c7 20 31 3d 8b e8 a7 91 09 fd 90 <0f> 0b 90 90 eb b7 e8 8b 4a 45 fd c6 05 ed 19 47 0a 01 90 48 c7 c7
RSP: 0018:ffffc90000a3f888 EFLAGS: 00010246
RAX: 74da3aaac3757600 RBX: 0000000000000003 RCX: ffff88801be99e00
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000100
RBP: ffffc90000a3f990 R08: 0000000000000000 R09: 0000000000000100
R10: dffffc0000000000 R11: ffffed101712487b R12: 1ffff92000147f18
R13: ffff88805d5311b8 R14: ffff88805d531020 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff888126ef7000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000404030 CR3: 000000000d3a6000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 call_timer_fn+0x17e/0x5f0 kernel/time/timer.c:1747
 expire_timers kernel/time/timer.c:1798 [inline]
 __run_timers kernel/time/timer.c:2372 [inline]
 __run_timer_base+0x648/0x970 kernel/time/timer.c:2384
 run_timer_base kernel/time/timer.c:2393 [inline]
 run_timer_softirq+0xb7/0x180 kernel/time/timer.c:2403
 handle_softirqs+0x22f/0x710 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 run_ktimerd+0xcf/0x190 kernel/softirq.c:1138
 smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
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

