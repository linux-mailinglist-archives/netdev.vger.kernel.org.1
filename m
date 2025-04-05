Return-Path: <netdev+bounces-179414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46633A7C79D
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 06:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD161705B0
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 04:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE77D137775;
	Sat,  5 Apr 2025 04:40:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC361CD1F
	for <netdev@vger.kernel.org>; Sat,  5 Apr 2025 04:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743828025; cv=none; b=rP5/zhpNqy3VrJjl/73/c1RFdKnqedqZeYIGQyGbWlo6BFHNSRoJFIknfBQ13iwWILL4AoWvMfnDhP4iJ/SJtYUbRY5xiYxUKqVU7AO6Bp/D1uKjQecqwEwVnGXI8H5iCU1cxUipvKpqfpY9yC8WL63k8GvOHRMlJlvkYsiWtxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743828025; c=relaxed/simple;
	bh=v1caOgm4fpmCGdF1gRlU9xYWPJkOTxoAUVtf7oF1zxg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hSlqhKfGhwtrKcMs7ZdjUi46fIyCaE6N63ijH9g/nBvQlR+Dq2QBxQPiJ0CzrtiMvLtoTt+XJ/Jm0GxD6QB2iiTprzWhP6HG7R5hnoDX9rU4I7glglhND63qmmz1oNwYASFiRgeSyxjj4Y0X8X0w0jg+pVT4bNsJPo4RJuJsLTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3ce8dadfb67so35377705ab.1
        for <netdev@vger.kernel.org>; Fri, 04 Apr 2025 21:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743828023; x=1744432823;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BFFaBriBmJgnYk25YbvDbKaHtKR4RSRpt9Ymik6Fqr0=;
        b=SDUBqWe8657URwNMGoKeeX2e4U6sjfmlk2+X8+LTywSgce8MhriRUefAlIGp0RNC4w
         fCDB7AivcTakLO09E8hFnyAONpwKDXB7dk5i+81TRalx3gkj5W6l2HcPDOC+mbBTBCo+
         n5Ji98bq2rH5I1DBuCiPee5nrAo3u2CPrQW24NfkDm7jbCMQhEea7DSieITmfhq+/xYB
         JXRTflGwZFXqCvX2nYrjvnYgQEpgCRmIpC85r/nl+mOW0cy54Xwf1NGUq+1GjykA5BW0
         DLckJtM8dPn3Nc6jDM4swR6t0EKuuiAUgEs4HkTcvbA124yfz06jWr7BhW6FQIvT8beW
         V3sw==
X-Forwarded-Encrypted: i=1; AJvYcCVd8UtresX7PzQ+OHsXKOkPAbQbQ5EeUB483BYWLcqvVB+pRjPz+L2HCGt0zSXWEJePMYHgujE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN1LpbH+zXLI/vFpbdAIYnXpeDdLppZu+ICK2ScBqudJyNhfYO
	nAuk/Umxpjm3whwhp2b/rxd0D0tsyG1QDadrtTYlkGvjCKdIiYj2vB3xPO4KqC3S1pSsashlK92
	3pBmTr3fEeynNkooWwjjBOCJIC0fgZe3wg4GGVIkxLbN4AzcXsKaEa9A=
X-Google-Smtp-Source: AGHT+IHW1mBYyOKEDn2PwTlxFF5CRpkQgMFG6nagUq72KS6h7iMgo09EPzbXuzf6K0vlvazKz+8UT7nXR4WT0cXdZuVwbSxzXDv0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2785:b0:3d3:d965:62c4 with SMTP id
 e9e14a558f8ab-3d6e5329212mr51377515ab.10.1743828023214; Fri, 04 Apr 2025
 21:40:23 -0700 (PDT)
Date: Fri, 04 Apr 2025 21:40:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f0b437.050a0220.0a13.022c.GAE@google.com>
Subject: [syzbot] [sctp?] KMSAN: uninit-value in sctp_assoc_bh_rcv
From: syzbot <syzbot+773e51afe420baaf0e2b@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	lucien.xin@gmail.com, marcelo.leitner@gmail.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a2cc6ff5ec8f Merge tag 'firewire-updates-6.15' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14bfcfb0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bace10fc34ab2694
dashboard link: https://syzkaller.appspot.com/bug?extid=773e51afe420baaf0e2b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7c6e49399ec3/disk-a2cc6ff5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bd9ebb7bb091/vmlinux-a2cc6ff5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b416a727e72b/bzImage-a2cc6ff5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+773e51afe420baaf0e2b@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in sctp_assoc_bh_rcv+0x38e/0xc50 net/sctp/associola.c:1005
 sctp_assoc_bh_rcv+0x38e/0xc50 net/sctp/associola.c:1005
 sctp_inq_push+0x2ef/0x380 net/sctp/inqueue.c:88
 sctp_backlog_rcv+0x397/0xdb0 net/sctp/input.c:331
 sk_backlog_rcv+0x13b/0x420 include/net/sock.h:1126
 __release_sock+0x1da/0x330 net/core/sock.c:3158
 release_sock+0x6b/0x250 net/core/sock.c:3712
 sctp_wait_for_connect+0x487/0x820 net/sctp/socket.c:9360
 sctp_sendmsg_to_asoc+0x1ec1/0x1f00 net/sctp/socket.c:1885
 sctp_sendmsg+0x32b9/0x4a90 net/sctp/socket.c:2031
 inet_sendmsg+0x25a/0x280 net/ipv4/af_inet.c:851
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x267/0x380 net/socket.c:727
 __sys_sendto+0x594/0x750 net/socket.c:2180
 __do_sys_sendto net/socket.c:2187 [inline]
 __se_sys_sendto net/socket.c:2183 [inline]
 __x64_sys_sendto+0x125/0x1d0 net/socket.c:2183
 x64_sys_call+0x37e7/0x3c80 arch/x86/include/generated/asm/syscalls_64.h:45
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4157 [inline]
 slab_alloc_node mm/slub.c:4200 [inline]
 __do_kmalloc_node mm/slub.c:4330 [inline]
 __kmalloc_node_track_caller_noprof+0x962/0x1260 mm/slub.c:4350
 kmalloc_reserve+0x23e/0x4a0 net/core/skbuff.c:599
 __alloc_skb+0x366/0x7b0 net/core/skbuff.c:668
 alloc_skb include/linux/skbuff.h:1340 [inline]
 sctp_packet_pack net/sctp/output.c:472 [inline]
 sctp_packet_transmit+0x1811/0x4470 net/sctp/output.c:621
 sctp_outq_flush_transports net/sctp/outqueue.c:1173 [inline]
 sctp_outq_flush+0x1b2f/0x6590 net/sctp/outqueue.c:1221
 sctp_outq_uncork+0x9c/0xb0 net/sctp/outqueue.c:764
 sctp_cmd_interpreter net/sctp/sm_sideeffect.c:-1 [inline]
 sctp_side_effects net/sctp/sm_sideeffect.c:1198 [inline]
 sctp_do_sm+0x8c5d/0x93e0 net/sctp/sm_sideeffect.c:1169
 sctp_assoc_bh_rcv+0x8fe/0xc50 net/sctp/associola.c:1052
 sctp_inq_push+0x2ef/0x380 net/sctp/inqueue.c:88
 sctp_backlog_rcv+0x397/0xdb0 net/sctp/input.c:331
 sk_backlog_rcv+0x13b/0x420 include/net/sock.h:1126
 __release_sock+0x1da/0x330 net/core/sock.c:3158
 release_sock+0x6b/0x250 net/core/sock.c:3712
 sctp_wait_for_connect+0x487/0x820 net/sctp/socket.c:9360
 sctp_sendmsg_to_asoc+0x1ec1/0x1f00 net/sctp/socket.c:1885
 sctp_sendmsg+0x32b9/0x4a90 net/sctp/socket.c:2031
 inet_sendmsg+0x25a/0x280 net/ipv4/af_inet.c:851
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x267/0x380 net/socket.c:727
 __sys_sendto+0x594/0x750 net/socket.c:2180
 __do_sys_sendto net/socket.c:2187 [inline]
 __se_sys_sendto net/socket.c:2183 [inline]
 __x64_sys_sendto+0x125/0x1d0 net/socket.c:2183
 x64_sys_call+0x37e7/0x3c80 arch/x86/include/generated/asm/syscalls_64.h:45
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 10529 Comm: syz.3.1552 Tainted: G        W           6.14.0-syzkaller-12966-ga2cc6ff5ec8f #0 PREEMPT(undef) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
=====================================================


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

