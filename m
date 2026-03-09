Return-Path: <netdev+bounces-265526-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKpWAWy8rmn6IQIAu9opvQ
	(envelope-from <netdev+bounces-265526-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 13:26:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0319B238CA0
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 13:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 44A42300C6FD
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 12:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682B63A63E8;
	Mon,  9 Mar 2026 12:13:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB52A2D8760
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 12:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773058425; cv=none; b=q0qDYQE1S/YfhMZbqil99IwnsKgl+yX+aaJbhd7ef+LGypkRkFyRIhzwe1fe30cGkivelFt6s2hcZy9ku1ILEgHYKjp8hpAq1PZugjzPREWOOwJ46vucq7sOZ+TBdIh2xn3ECgKz4FWeMMBddERQZEBWJt+VafHSKt+GDPZneqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773058425; c=relaxed/simple;
	bh=PSve9+OZ0uIyrVvrL+k8kYaMyjyZV5bNHKf4r6mYMjg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sknKlnhYReEo90nukrGO1bv0QJWETtsxz9vTvb1G1OYGD2UmOBEmoflXq87n+tR2fDK9+Owa9ZvB+s6i+gMg/au9DRR5Kr33nxvpJa7u0g8BYcexdhyQKQJTnO3+0RFVcBrbktt33HvDGvS3cxjyliWfh7KOw3EegpgcGmup6Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-672c40f3873so198184909eaf.2
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 05:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773058423; x=1773663223;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TqsjNRI5k7LetfZtjLKtuc4uxl4nwGBY89RPRBdE1pE=;
        b=TgWCZL8qK+1iS2//oB+GoQ4Oxho5az9aOYeFhKDI7y+b4gsa4bN3TE7fwGjCSiV6rs
         DdI5/rEnmT/Hn32LY9VHOcepjmomHWp5ldXoDp/DBQwxpCUi7VP66zLj5dtmySAAQexE
         epZZW0wscv4boki5asJE5WxNa2rSjrJwWZDfiSI6PYYDNyKixknxYzAsqQWUKd5GSdY9
         SinMns4sZHeGAo7lmFg+73xR/MpzjR/yFRa8/eOXKbcUJtDnVNVt9WaECYbKG1znK0To
         zNd5Er+l3gkCN6ruwI4GE3z9t1YnUCpPybVshoSZ5LZLYob1tH7pNCMmlV4SlPufZGEk
         Adgg==
X-Forwarded-Encrypted: i=1; AJvYcCWGTsJtFH7PfbQ8vkUBh5Kak95qweIYsWQq1GaUR9J5dzgFkpH7vUf7rqSmEquVBphXKmOCIsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZbrbEu6Xhrevmdd5QOY9oVXslud6pb219PqhCzPIWAMLySolu
	uLYgfNiucowAHm8obZiW6CxNUd7RJ3qhnJnawhldGS22MnS5fA6oYUGvTtUBRz26bct99h9gX2l
	P/rPoCFnuDIvd3DFKLeU1cfl2M57VvqYB8/rDAoq9Y5t2fongLWZsmhtIlRs=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:c92:b0:67b:adbe:c3cb with SMTP id
 006d021491bc7-67badbec51bmr3811015eaf.56.1773058422821; Mon, 09 Mar 2026
 05:13:42 -0700 (PDT)
Date: Mon, 09 Mar 2026 05:13:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69aeb976.a70a0220.52840.0015.GAE@google.com>
Subject: [syzbot] [net?] KASAN: null-ptr-deref Write in send_to_lecd
From: syzbot <syzbot+e1d2b89a60c8bb9a7f33@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 0319B238CA0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=976ba5a93c4add9e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-265526-lists,netdev=lfdr.de,e1d2b89a60c8bb9a7f33];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.938];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,appspotmail.com:email,googlegroups.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,goo.gl:url,syzkaller.appspot.com:url]
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    014441d1e4b2 Merge tag 'i2c-for-7.0-rc3' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11230d52580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=976ba5a93c4add9e
dashboard link: https://syzkaller.appspot.com/bug?extid=e1d2b89a60c8bb9a7f33
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c6996386f74c/disk-014441d1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/50d7e742ec37/vmlinux-014441d1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8b042e15289c/bzImage-014441d1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e1d2b89a60c8bb9a7f33@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read_write include/linux/instrumented.h:112 [inline]
BUG: KASAN: null-ptr-deref in atomic_add include/linux/atomic/atomic-instrumented.h:104 [inline]
BUG: KASAN: null-ptr-deref in atm_force_charge include/linux/atmdev.h:261 [inline]
BUG: KASAN: null-ptr-deref in send_to_lecd+0x2ef/0x5e0 net/atm/lec.c:535
Write of size 4 at addr 0000000000000140 by task dhcpcd/28797

CPU: 1 UID: 101 PID: 28797 Comm: dhcpcd Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 kasan_report+0xdf/0x1e0 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:186 [inline]
 kasan_check_range+0x10f/0x1e0 mm/kasan/generic.c:200
 instrument_atomic_read_write include/linux/instrumented.h:112 [inline]
 atomic_add include/linux/atomic/atomic-instrumented.h:104 [inline]
 atm_force_charge include/linux/atmdev.h:261 [inline]
 send_to_lecd+0x2ef/0x5e0 net/atm/lec.c:535
 lec_arp_resolve net/atm/lec.c:1791 [inline]
 lec_start_xmit+0x1252/0x2070 net/atm/lec.c:285
 __netdev_start_xmit include/linux/netdevice.h:5292 [inline]
 netdev_start_xmit include/linux/netdevice.h:5301 [inline]
 xmit_one net/core/dev.c:3871 [inline]
 dev_hard_start_xmit+0x121/0x7d0 net/core/dev.c:3887
 sch_direct_xmit+0x1b2/0xc60 net/sched/sch_generic.c:347
 qdisc_restart net/sched/sch_generic.c:412 [inline]
 __qdisc_run+0x52d/0x1b10 net/sched/sch_generic.c:420
 qdisc_run include/net/pkt_sched.h:120 [inline]
 qdisc_run include/net/pkt_sched.h:117 [inline]
 __dev_xmit_skb net/core/dev.c:4196 [inline]
 __dev_queue_xmit+0x196d/0x4800 net/core/dev.c:4802
 dev_queue_xmit include/linux/netdevice.h:3384 [inline]
 packet_xmit+0x243/0x310 net/packet/af_packet.c:275
 packet_snd net/packet/af_packet.c:3076 [inline]
 packet_sendmsg+0x32f4/0x53c0 net/packet/af_packet.c:3108
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 sock_write_iter+0x524/0x5a0 net/socket.c:1195
 do_iter_readv_writev+0x6ee/0x920 fs/read_write.c:829
 vfs_writev+0x360/0xe10 fs/read_write.c:1059
 do_writev+0x28a/0x340 fs/read_write.c:1105
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f53f6e3c407
Code: 48 89 fa 4c 89 df e8 38 aa 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007fff9cf80170 EFLAGS: 00000202 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00007f53f6db2780 RCX: 00007f53f6e3c407
RDX: 0000000000000002 RSI: 00007fff9cf801d0 RDI: 0000000000000003
RBP: 0000000000000188 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007fff9cf80210
R13: 0000562512791790 R14: 00007fff9cf80260 R15: 00007fff9cf90430
 </TASK>
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

