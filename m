Return-Path: <netdev+bounces-128613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797F797A94E
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 00:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C35E1C21204
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 22:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA0A139578;
	Mon, 16 Sep 2024 22:47:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E935F1B85C1
	for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 22:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726526851; cv=none; b=T1ZDpNY0ccJzfslSZtJBraIwx6bwuedxTleBKQVL6lbV6xUZhKgB3oDzuuSvXar3s7TVbOT6GD5qlIegP5P8pMVYTwEpQxsoJdx8nBFQe1iLkCCc84kvpT7J+Hdlm17uwnbJC1F+IMc/jqvAmSECtE1MSvd3Hozo6v0ijsmuX2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726526851; c=relaxed/simple;
	bh=41Ybt8dNS9KycTHyJBL1FKkrujB8ri1h9w/FQGcqRrg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PEfsZvmYFzZsevEZBJqq4A7kTltupL5kxqtMoLvz619RdMz3jwviF7nDaOcogVzz5jVRH8IYG7HkX1s6vCTU0/3CxrCaMG4YxVY+UugYITZc7+b+MQbCf9NijFEodxkvG9z5iSONz651LtKmLNXj7wYK76bwHQFrxRq5ElD5NM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a0ab3fe36dso9336725ab.0
        for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 15:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726526849; x=1727131649;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+U/UV4SyzRkEESoWYzGS9RxixgPfLq0YizcwZSgxfNA=;
        b=kRohH1rA+hmXMl3DU4fWAlUOarwySbg7qigRYEkwcEOFQQLPsWlBtP1b4dWl82O5YV
         EM53HtXCbY/HpZWjg69cupTij5qDpkBaRTg9ZBELHbj21D+c4sFRKOKXtXEgu/uB7Vtm
         rBzPAk3tWddRy6Dbk1hWhFMVUfqCym8C0KIoJ6yaxabnvMgs5UBJTSh8mH5znaIyVTh4
         evHXwbbY/wE4BP2IQP9iIw/hVIHt166bq/cXIoY0wdb0teSgIpIezUcc84cXmkXeFKcp
         H0YSpKrePEhQ3E5RS1EeFZwh6KwayL6PWpI5cG5MpmMVyRhyuBPlBkzX9CjFOXGh4d0p
         ghvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs462o8rAd9s7WIX5MaMQm5aknxQFCRUykj/eZ/ePEfjUnQh32tAXpWuD2XVELtko3Q3PK/ac=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWKpdc85cgoyIX5KWv0nC5Mdqri1D9a+4ggDkmzqAP4BPGMjb8
	q/V5AaTAxzYUp/hFSBhBMbeaCl0DosB1g4C6T9Y+/WzpGf2mgIYRa/TSjinOGklHuc13cf3TFw/
	apxBmiOsltSE/h+dvvx60ND7DL1RQkXsNtgV24Ue1RJiMAWy3AgTGsQ8=
X-Google-Smtp-Source: AGHT+IFmTK6OY5rLLPTuEKv2PGFM2Vk+PG/0p9ljO5RS5zqaROfGKOD7zY3ghyhnr4nLWaVCSXor0PUVcHyw1/OEKyYVqoSNwDXe
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d88:b0:395:e85e:f2fa with SMTP id
 e9e14a558f8ab-3a084611b38mr133380235ab.1.1726526849054; Mon, 16 Sep 2024
 15:47:29 -0700 (PDT)
Date: Mon, 16 Sep 2024 15:47:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000088906d0622445beb@google.com>
Subject: [syzbot] [net?] UBSAN: shift-out-of-bounds in xfrm_selector_match (2)
From: syzbot <syzbot+cc39f136925517aed571@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3561373114c8 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14a36a8b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=be4832509d93a86b
dashboard link: https://syzkaller.appspot.com/bug?extid=cc39f136925517aed571
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/494b5ef0e99e/disk-35613731.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2ec90c91c7b4/vmlinux-35613731.xz
kernel image: https://storage.googleapis.com/syzbot-assets/59a0684dc747/bzImage-35613731.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cc39f136925517aed571@syzkaller.appspotmail.com

------------[ cut here ]------------
UBSAN: shift-out-of-bounds in ./include/net/xfrm.h:900:23
shift exponent -96 is negative
CPU: 1 UID: 0 PID: 12120 Comm: syz.1.1258 Not tainted 6.11.0-rc7-syzkaller-01543-g3561373114c8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_shift_out_of_bounds+0x3c8/0x420 lib/ubsan.c:468
 addr4_match include/net/xfrm.h:900 [inline]
 __xfrm4_selector_match net/xfrm/xfrm_policy.c:222 [inline]
 xfrm_selector_match+0xe9b/0x1030 net/xfrm/xfrm_policy.c:247
 xfrm_state_look_at+0xe8/0x480 net/xfrm/xfrm_state.c:1172
 xfrm_state_find+0x199f/0x4d70 net/xfrm/xfrm_state.c:1280
 xfrm_tmpl_resolve_one net/xfrm/xfrm_policy.c:2481 [inline]
 xfrm_tmpl_resolve net/xfrm/xfrm_policy.c:2532 [inline]
 xfrm_resolve_and_create_bundle+0x6d2/0x2c90 net/xfrm/xfrm_policy.c:2826
 xfrm_lookup_with_ifid+0x334/0x1ee0 net/xfrm/xfrm_policy.c:3160
 xfrm_lookup net/xfrm/xfrm_policy.c:3289 [inline]
 xfrm_lookup_route+0x3c/0x1c0 net/xfrm/xfrm_policy.c:3300
 ip_route_connect include/net/route.h:333 [inline]
 __ip4_datagram_connect+0x96c/0x1260 net/ipv4/datagram.c:49
 __ip6_datagram_connect+0x194/0x1230
 ip6_datagram_connect net/ipv6/datagram.c:279 [inline]
 ip6_datagram_connect_v6_only+0x63/0xa0 net/ipv6/datagram.c:291
 __sys_connect_file net/socket.c:2067 [inline]
 __sys_connect+0x2df/0x310 net/socket.c:2084
 __do_sys_connect net/socket.c:2094 [inline]
 __se_sys_connect net/socket.c:2091 [inline]
 __x64_sys_connect+0x7a/0x90 net/socket.c:2091
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe6d677def9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe6d751f038 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007fe6d6936130 RCX: 00007fe6d677def9
RDX: 000000000000001c RSI: 0000000020000000 RDI: 0000000000000007
RBP: 00007fe6d67f0b76 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fe6d6936130 R15: 00007ffcce438838
 </TASK>
---[ end trace ]---


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

