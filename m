Return-Path: <netdev+bounces-274674-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCyHJvXFzmlfqAYAu9opvQ
	(envelope-from <netdev+bounces-274674-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 21:39:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 072E738DBC9
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 21:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EBE193038D1D
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 19:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF74137B023;
	Thu,  2 Apr 2026 19:39:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E14372678
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 19:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775158769; cv=none; b=h6naw2C9L338OR8e5hh7z5tUtS1Vzx5TcR+KLiZ9ZuYLjb6qM2r8z/5owp4jnIWgFzoJzCzOPlSYRKriCAlYJCNsvRYIcNrFkg22luFcVoZ/H0T1lcIy+A6xFqcwdZ0v3kq5x0JqIhnjBFM2YZhLP5a/HQSdGuUnmb4Xvfpztd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775158769; c=relaxed/simple;
	bh=owzoiyg5uMTi9jBSGwi2a4AWQjD/nULb9+63KUm3krM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Zi102Vte12L+IQXx04E1C2jyZ+OeyMvE2bko6mUpNvT1aSu0sL2S9lOUJmKqRMaAgjarTshHpXZ5L7ViWG9cyzjvyi0GEPkzanaCz7QxglU0T8wemj1NyzmkmrwInA6DJS0BxSQ6ktr8Ti2Qd2pqOALEigEOYNyKq3L+azJBmX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-67deac23e02so2120126eaf.2
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 12:39:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775158767; x=1775763567;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LmNMSticwwy68bmYI4NP8/nV4Ff79a42KYPUtfiNNJ0=;
        b=WNUOcTbdjkhZj4f029Ru/6OPSSNA94kXAH4wW4BY0hFNdRsFAhCajY0qw1cqDH/XjX
         fS+6hNmHLBhcLluuG/DEtdPmRAFryFB6y+1mszxbzFLSgBokKwpnDq6/Gr35dFOQ0Cd8
         MttTAhgesltAWXPtS7SplhGnL9ny56yrzuAJEunGDtzLTDIEGEnFVPdKkR8jbQwET7fF
         I0Cnf+BllWz30LKsI5CBmDv8ypoNA+hpAMhWZYq9R3Q1xvgpyzWxp/9AE9vp5AKdPehy
         engpTuGvPVY8LFA8kgpGUl0JALwl7AStuzJ8RH0ygd4kzI4ij8anGbUQYVwwWouypmU4
         fc/w==
X-Forwarded-Encrypted: i=1; AJvYcCVp25t0kLT2GfziCp1MTeUhC+pjhzJVt1VGvQG9MM74zx42BUArTJGGNJYR8uzNx3KX9HGiSEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxexoFW53kGjzxnJxV9xCWNIj/A3Xz0P/SmUYjDJ+1fKgjUO+UX
	7/mLj6NlFpYKoTw+lV99/Bi9hFu55E5TNt1v42bQslHOnkn1wgqLRnjhnCHpK6Fv+20JtJFSMjO
	wvmFeLPNenyJ1i0fBzpHVCt3ASLflhpcRt2AUOCQPisbdgXVM/bOnpW9oeDY=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:6ac5:b0:67e:370e:d5f1 with SMTP id
 006d021491bc7-682200594e9mr271107eaf.48.1775158767131; Thu, 02 Apr 2026
 12:39:27 -0700 (PDT)
Date: Thu, 02 Apr 2026 12:39:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69cec5ef.050a0220.2dbe29.0009.GAE@google.com>
Subject: [syzbot] [net?] [bpf?] WARNING in sock_map_destroy (3)
From: syzbot <syzbot+b0842d38af58376d1fdc@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, jakub@cloudflare.com, jiayuan.chen@linux.dev, 
	john.fastabend@gmail.com, kuba@kernel.org, kuniyu@amazon.com, 
	kuniyu@google.com, linux-kernel@vger.kernel.org, martin.lau@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	willemb@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,vger.kernel.org,iogearbox.net,davemloft.net,google.com,cloudflare.com,linux.dev,gmail.com,amazon.com,redhat.com,googlegroups.com];
	TAGGED_FROM(0.00)[bounces-274674-lists,netdev=lfdr.de,b0842d38af58376d1fdc];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,storage.googleapis.com:url,linux.dev:email];
	RCPT_COUNT_TWELVE(0.00)[19];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.931];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 072E738DBC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    1b237f190eb3 Linux 6.17-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13551c42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
dashboard link: https://syzkaller.appspot.com/bug?extid=b0842d38af58376d1fdc
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=168d6ef0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f57862580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d708c97252af/disk-1b237f19.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3b964889e9fe/vmlinux-1b237f19.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2d05741e1ef1/bzImage-1b237f19.xz

The issue was bisected to:

commit 8259eb0e06d8f64c700f5fbdb28a5c18e10de291
Author: Jiayuan Chen <jiayuan.chen@linux.dev>
Date:   Fri May 16 14:17:12 2025 +0000

    bpf, sockmap: Avoid using sk_socket after free when sending

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17fbce62580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1407ce62580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1007ce62580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b0842d38af58376d1fdc@syzkaller.appspotmail.com
Fixes: 8259eb0e06d8 ("bpf, sockmap: Avoid using sk_socket after free when sending")

------------[ cut here ]------------
WARNING: CPU: 1 PID: 8459 at net/core/sock_map.c:1667 sock_map_destroy+0x28b/0x2b0 net/core/sock_map.c:1667
Modules linked in:
CPU: 1 UID: 0 PID: 8459 Comm: syz.0.1109 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:sock_map_destroy+0x28b/0x2b0 net/core/sock_map.c:1667
Code: 8b 36 49 83 c6 38 4c 89 f0 48 c1 e8 03 42 80 3c 38 00 74 08 4c 89 f7 e8 93 62 22 f9 4d 8b 3e e9 79 ff ff ff e8 a6 2b c3 f8 90 <0f> 0b 90 eb 9c e8 9b 2b c3 f8 4c 89 e7 be 03 00 00 00 e8 0e 4e bc
RSP: 0018:ffffc9000d067be8 EFLAGS: 00010293
RAX: ffffffff88fb30aa RBX: ffff888024832000 RCX: ffff888024283b80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed100862e946 R12: dffffc0000000000
R13: ffff888024832000 R14: ffffffff995b2208 R15: ffffffff88fb2e20
FS:  0000555579a7d500(0000) GS:ffff8881269c2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002000000048c0 CR3: 000000003713a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 inet_csk_destroy_sock+0x166/0x3a0 net/ipv4/inet_connection_sock.c:1294
 __tcp_close+0xcc1/0xfd0 net/ipv4/tcp.c:3262
 tcp_close+0x28/0x110 net/ipv4/tcp.c:3274
 inet_release+0x144/0x190 net/ipv4/af_inet.c:435
 __sock_release net/socket.c:649 [inline]
 sock_close+0xc0/0x240 net/socket.c:1439
 __fput+0x45b/0xa80 fs/file_table.c:468
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xec/0x110 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f265847ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd158dfbd8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 000000000002ddb0 RCX: 00007f265847ebe9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f26586a7da0 R08: 0000000000000001 R09: 0000000e158dfecf
R10: 0000001b30a20000 R11: 0000000000000246 R12: 00007f26586a5fac
R13: 00007f26586a5fa0 R14: ffffffffffffffff R15: 00007ffd158dfcf0
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

