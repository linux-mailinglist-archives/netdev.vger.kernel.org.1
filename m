Return-Path: <netdev+bounces-273735-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKVRGFIezGldQAYAu9opvQ
	(envelope-from <netdev+bounces-273735-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 21:19:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 635BB3707E6
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 21:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D6DDD3010220
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 19:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF693A5437;
	Tue, 31 Mar 2026 19:19:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218E93A542A
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 19:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774984767; cv=none; b=uoOPgeP6VVesX9BiMEtabHpXLDbnP/o42WSzqfwoh6SykiIqf8yxkcOlbb53slxAQhADEcIiXpkf6VEKmwWXGy/j6i3/Xd7lSMjHWiRubocVc5JsYiWTJO57CKccqfeYjCd1rZmjtWrd0IXWIZCnGyeWXBK9HtknT2JyYEuyDQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774984767; c=relaxed/simple;
	bh=cYm4fjAVfEXRKliPWVKPszVlCu+ObVVMfppJtsvXcRA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=atdrY9p6kLGJAfiJjgZh5FAsy34ZEnyTzdYwtrtD/v8qHWpv4xgyhrvFtIV/mSKdHTganupW3LRx4Or6RBloZf/0JAYOzgGO5spPpphz5IqB551qZP0F/r41NMhFcjX3P6ol0kt5uO+saH9/tInW88SGCVJPRLRzCnTqdmnMh2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-67e42861891so3316911eaf.3
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 12:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774984765; x=1775589565;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dxygdtr/XoCN3ttfrAWSBKMcr6DAfIGCMOal2m8EL2w=;
        b=fYT0kxuhcsqXveLu2tg1NlfP6LMyulcBCHJuzoB5oOtV+bgapFJuM9PosIuRQIInFC
         uS/1rtIdjc1y/E1C6QG5/mHgji82UHm3ZGooz76aNS/52cci7+oO3EMfR1jS2C/fYn7k
         Aa6Ljq/zDvS0QwMd6WzdS9oAVWCWFBbLgOLRnc27lKplZg9WyslpuLRyt0PCTtaGZb4o
         uY0tG6gbvZ2vI3yznSE28iSPDkycBNfR7XK6UIWvzS4X37J0HDRbofAa8bkTeWnspL8p
         /+gzqrqM4FB2SWJEHD4je7AoSXr2FYxrKJFHiMdvBSlNaYOLrf/rfwttkHppxy4QCSyP
         ldkQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2fIwSk4JaoooUNsnieRhMpcPvsz21JrLYSaQ97zYxmQAcTExj9IZMZK0KjWmkdMW3A9qvBig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5xvno/u8IsHKYo73GY//x06bml+Wvxw8YmvFi4fVEnPFCnFpz
	3oOfGJPI4gdihinE0OerJE1guFbruQ2RZ+CbnGVBUjavhGXnkvTJKBL0HoQZySPHVM3zfJ+DQ6l
	4FZucTWjYxea9lB6qTjQ29wRAkQrUeLKaVQ23P4+hTRJzy7Sl9PFGulodnjc=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:610:b0:67e:967:a303 with SMTP id
 006d021491bc7-67fabac9894mr307752eaf.0.1774984765171; Tue, 31 Mar 2026
 12:19:25 -0700 (PDT)
Date: Tue, 31 Mar 2026 12:19:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69cc1e3d.050a0220.183828.0032.GAE@google.com>
Subject: [syzbot] [net?] KCSAN: data-race in copy_mm / percpu_counter_add_batch
From: syzbot <syzbot+648f94dd38904eae4be7@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=3a78dd265deac3a9];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-273735-lists,netdev=lfdr.de,648f94dd38904eae4be7];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,appspotmail.com:email,googlegroups.com:email,goo.gl:url,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 635BB3707E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    d0c3bcd5b897 Merge tag 'libcrypto-for-linus' of git://git..=
.
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=3D11af0302580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D3a78dd265deac3a=
9
dashboard link: https://syzkaller.appspot.com/bug?extid=3D648f94dd38904eae4=
be7
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-=
1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2fc468d174ba/disk-=
d0c3bcd5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a28862469460/vmlinux-=
d0c3bcd5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/57a109709002/bzI=
mage-d0c3bcd5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+648f94dd38904eae4be7@syzkaller.appspotmail.com

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KCSAN: data-race in copy_mm / percpu_counter_add_batch

read-write to 0xffff88812b22d5c8 of 8 bytes by task 26440 on cpu 0:
 percpu_counter_add_batch+0x105/0x130 lib/percpu_counter.c:107
 percpu_counter_add include/linux/percpu_counter.h:71 [inline]
 percpu_counter_inc include/linux/percpu_counter.h:267 [inline]
 inc_mm_counter include/linux/mm.h:3084 [inline]
 wp_page_copy mm/memory.c:3825 [inline]
 do_wp_page+0x1416/0x2590 mm/memory.c:4241
 handle_pte_fault mm/memory.c:6333 [inline]
 __handle_mm_fault mm/memory.c:6455 [inline]
 handle_mm_fault+0x8cb/0x3020 mm/memory.c:6624
 do_user_addr_fault+0x3fd/0x1050 arch/x86/mm/fault.c:1385
 handle_page_fault arch/x86/mm/fault.c:1474 [inline]
 exc_page_fault+0x62/0xa0 arch/x86/mm/fault.c:1527
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618
 rep_movs_alternative+0x4a/0x90 arch/x86/lib/copy_user_64.S:68
 copy_user_generic arch/x86/include/asm/uaccess_64.h:126 [inline]
 raw_copy_to_user arch/x86/include/asm/uaccess_64.h:147 [inline]
 copy_to_user_iter lib/iov_iter.c:25 [inline]
 iterate_ubuf include/linux/iov_iter.h:30 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:302 [inline]
 iterate_and_advance include/linux/iov_iter.h:330 [inline]
 _copy_to_iter+0x141/0xea0 lib/iov_iter.c:197
 copy_to_iter include/linux/uio.h:220 [inline]
 simple_copy_to_iter net/core/datagram.c:521 [inline]
 __skb_datagram_iter+0x2f4/0x680 net/core/datagram.c:435
 skb_copy_datagram_iter+0x3f/0x120 net/core/datagram.c:535
 skb_copy_datagram_msg include/linux/skbuff.h:4218 [inline]
 unix_stream_read_actor+0x43/0x70 net/unix/af_unix.c:3109
 unix_stream_read_generic+0x6e9/0x1630 net/unix/af_unix.c:3029
 unix_stream_recvmsg+0xff/0x130 net/unix/af_unix.c:3146
 sock_recvmsg_nosec net/socket.c:1078 [inline]
 sock_recvmsg+0xf5/0x120 net/socket.c:1100
 ____sys_recvmsg+0xf5/0x280 net/socket.c:2812
 ___sys_recvmsg+0x11f/0x3b0 net/socket.c:2854
 __sys_recvmsg net/socket.c:2887 [inline]
 __do_sys_recvmsg net/socket.c:2893 [inline]
 __se_sys_recvmsg net/socket.c:2890 [inline]
 __x64_sys_recvmsg+0xd1/0x160 net/socket.c:2890
 x64_sys_call+0x2b1a/0x3020 arch/x86/include/generated/asm/syscalls_64.h:48
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88812b22d100 of 1664 bytes by task 26447 on cpu 1:
 dup_mm kernel/fork.c:1525 [inline]
 copy_mm+0xe1/0x370 kernel/fork.c:1583
 copy_process+0xe22/0x20b0 kernel/fork.c:2223
 kernel_clone+0x16b/0x5d0 kernel/fork.c:2653
 __do_sys_clone kernel/fork.c:2794 [inline]
 __se_sys_clone kernel/fork.c:2778 [inline]
 __x64_sys_clone+0x143/0x180 kernel/fork.c:2778
 x64_sys_call+0x1222/0x3020 arch/x86/include/generated/asm/syscalls_64.h:57
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 26447 Comm: syz.1.8317 Tainted: G        W           syz=
kaller #0 PREEMPT(full)=20
Tainted: [W]=3DWARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 02/12/2026
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Q=EF=BF=BD6=EF=BF=BD`=D2=98 speed is unknown, defaulting to 1000


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

