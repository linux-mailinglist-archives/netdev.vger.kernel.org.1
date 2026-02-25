Return-Path: <netdev+bounces-260916-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJgdHmDrnmk/XwQAu9opvQ
	(envelope-from <netdev+bounces-260916-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 13:30:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C30CA1975C0
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 13:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4638319CE8E
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 12:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615D83B52FB;
	Wed, 25 Feb 2026 12:24:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D143B52F8
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 12:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772022271; cv=none; b=eqPrsTQurMAaVoWTC8qua1aZ6CRIq8j5b824f5q4/pBuDZlIliBW5qe/U7wqhzEg/Dubm9Om8I2VSzCoey6J/Fx+9zkaUOkep8PVXmcctYu/60Wr2HqXxn4xCFMbNjGyl6Iow4loS0yebC0gcYWpKUgYcLTPh87SDVJx62ppRls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772022271; c=relaxed/simple;
	bh=w0RkkI60n0NfVjeD3GCvWy9379xhuF9l5DYLh+Frc74=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lcHVojBZEeZbjUbvb8umaKp5HXlNZRwOc/TiqADg78331nusFXYGj20FJZsxWDkZlBitnRV1P/mAft9Gw1U5/qcqELEgUiFemSZHEvxmvbJ8fT8cGWoHmUSQZnvDUQ/MODSSbzPoG0ZuGl0vC6HfWsFqbocnhjowuYFNRraW088=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7d4be1dee67so109938540a34.1
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 04:24:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772022269; x=1772627069;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vxgM2+7tBarSdr5Mf2egulRHzkOHvLOxJK/f02SHmAk=;
        b=PjD9lzgbFC5mBSMlu/G5JZ8e5P0ZPFytaEWlQBn/1Uvsbf+UbKP3jAovlpLTPl2mQE
         QC5P79cCIVYzNw645no+KoUF6Jn1sFMQ7Y3bFJKCe7u2u78AiqySH+CLSI6Na9Dw/guD
         z5/XqMuzVpoQHGPGk7kzboaFEOcQzyxE+z613HvhrxUoGUmbXB5ij0XaF9KIZ7g3oP9x
         YNEhR9jkfo6fjVBuMz7bZLGET92qCAx/QfRDPBhhxxyFUgYw2GSlU1rHHBSc6GRaa1SU
         LaynG1VdgO3jRLLyNEscLuOhyKTzY91MKlhCSWH+L/I9lJhxzdTVg/OVfJ4gj9tBB/jV
         KC+w==
X-Forwarded-Encrypted: i=1; AJvYcCX/h6xo0c4kOqOsAeK2pJyA/tT6ezgXT90J407JVUoqn9OW4dD6XiKWCO/3lR1eNYwdWoJ5O3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs+gEmB9M0JV/Ly+3ZMGwba2RZSp57J5i7dF7U4WUdNSZbDXXC
	axeZMfXm8Sxhy/f60+LChHQSXr+lDMtwfg/gU8wksUa62RcTcuVPcHPSJAPRlk/gTMD6u2UUzFp
	EZUp8Psp+5Teb8EfbT+O/EunCP2KIFCt8BOVrRxqpnPen8t/hB1cVhwNUVPI=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:16a3:b0:679:94ff:6ea7 with SMTP id
 006d021491bc7-679c4251e3dmr8290560eaf.15.1772022268917; Wed, 25 Feb 2026
 04:24:28 -0800 (PST)
Date: Wed, 25 Feb 2026 04:24:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <699ee9fc.050a0220.1cd54b.0009.GAE@google.com>
Subject: [syzbot] [net?] [bpf?] KCSAN: data-race in sk_psock_drop / unix_stream_sendmsg
From: syzbot <syzbot+87f770387a9e5dc6b79b@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, jakub@cloudflare.com, john.fastabend@gmail.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=70c3ed59b49365c3];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,vger.kernel.org,iogearbox.net,davemloft.net,google.com,cloudflare.com,gmail.com,redhat.com,googlegroups.com];
	TAGGED_FROM(0.00)[bounces-260916-lists,netdev=lfdr.de,87f770387a9e5dc6b79b];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlegroups.com:email,syzkaller.appspot.com:url,appspotmail.com:email,goo.gl:url];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: C30CA1975C0
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    23b0f90ba871 Merge tag 'sysctl-7.00-rc1' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13f3695a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=70c3ed59b49365c3
dashboard link: https://syzkaller.appspot.com/bug?extid=87f770387a9e5dc6b79b
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ae3bcc875a04/disk-23b0f90b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1a4dbd53da8f/vmlinux-23b0f90b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3c3824777f5c/bzImage-23b0f90b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+87f770387a9e5dc6b79b@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in sk_psock_drop / unix_stream_sendmsg

write to 0xffff88810220dc08 of 8 bytes by task 3611 on cpu 1:
 sk_psock_stop_verdict net/core/skmsg.c:1311 [inline]
 sk_psock_drop+0x12f/0x270 net/core/skmsg.c:896
 sk_psock_put include/linux/skmsg.h:506 [inline]
 sock_map_unref+0x2a5/0x300 net/core/sock_map.c:185
 __sock_map_delete net/core/sock_map.c:426 [inline]
 sock_map_delete_from_link net/core/sock_map.c:439 [inline]
 sock_map_unlink net/core/sock_map.c:1608 [inline]
 sock_map_remove_links+0x228/0x340 net/core/sock_map.c:1623
 sock_map_close+0xa1/0x340 net/core/sock_map.c:1684
 unix_release+0x4e/0x80 net/unix/af_unix.c:1183
 __sock_release net/socket.c:662 [inline]
 sock_close+0x6b/0x150 net/socket.c:1455
 __fput+0x29b/0x650 fs/file_table.c:469
 fput_close_sync+0xad/0x190 fs/file_table.c:574
 __do_sys_close fs/open.c:1509 [inline]
 __se_sys_close fs/open.c:1494 [inline]
 __x64_sys_close+0x55/0xf0 fs/open.c:1494
 x64_sys_call+0x275d/0x3020 arch/x86/include/generated/asm/syscalls_64.h:4
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88810220dc08 of 8 bytes by task 3605 on cpu 0:
 unix_stream_sendmsg+0x7f8/0xbb0 net/unix/af_unix.c:2480
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0x5af/0x600 net/socket.c:2592
 ___sys_sendmsg+0x195/0x1e0 net/socket.c:2646
 __sys_sendmsg net/socket.c:2678 [inline]
 __do_sys_sendmsg net/socket.c:2683 [inline]
 __se_sys_sendmsg net/socket.c:2681 [inline]
 __x64_sys_sendmsg+0xd4/0x160 net/socket.c:2681
 x64_sys_call+0x194c/0x3020 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0xffffffff8486dd00 -> 0xffffffff8472c9f0

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 3605 Comm: syz.4.30 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
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

