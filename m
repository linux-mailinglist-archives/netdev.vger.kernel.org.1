Return-Path: <netdev+bounces-299369-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zsbYI5G/L2rjFgUAu9opvQ
	(envelope-from <netdev+bounces-299369-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 11:02:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0EF684D47
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 11:02:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299369-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299369-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4EDA130391CE
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 08:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0104E3C3BFD;
	Mon, 15 Jun 2026 08:56:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC4B3BF680
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 08:56:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781513783; cv=none; b=FOJiKAYQm1qYpc5AL3nAYCdSjwquUHHGkIQPs29/KCh71D+TUdpswH2PFlyr0HkvvJSLWqzKtPRb6EL6fwKNp+t6APIWUDnb4e+bHFvKNQV829PCwYBBY7Iq5gC0Z0HLF0xrepqJnKnvwO9dDqu46v4yDkDleMoqtNof7QxN46Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781513783; c=relaxed/simple;
	bh=BHGcTA9VHKoXauDDELOYtkwvXbv2YLATXkGgKc7/KjM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=M+5Uecv7kEJ6QTK8llkoQlQnGUCT3CaE0Ffy3Qn6PPA6oeu5VVhmMb/t8OpNbL2CBXHT6AShD0Lw0KDbzkPCnEVEzjHBHsIWm2pQKb//q7JvneZapIP9nAi2Bqs+4axsk5NCaNJCtTyuXJ2+EKQyNjz7HDkapY/hEP/tD258onI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.77
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-7e6fa8bba1dso6410964a34.2
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 01:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781513781; x=1782118581;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U8cntZMvuT1SiV/8WeZjdDeTic+Plq8HUrqigZMFvH4=;
        b=nR3fXptfVydA2ML/6pITQOiMQ2wG2ljoN2XVKulBjkc9abqb8BpoqI/buK6CxrPWJ5
         SYcdHrLVAfFRvQGYFJetIq1PN5nJ1VxXRfIM1+0c3wYggFTmftf8xSmkWS1RczhiaUrI
         Ty2GVq8gjeCmhnhUGcmh5St626BpNMfCfz3Y0oJDkdplzPTatuDfE3vncc4/29L+bSdI
         npBPMyjf6dZVUV6NfyKPa2rtmUrmOa9Da1X6wGI4MiuFoBe+vhyvLuKrRy7vdGFd/Trb
         ZSdkTA+jvNRYxUVr6yEtB2zqd6yBjGQTC87TYwwz6lsFahBSz/PeOh2YPZfX3cTPObir
         YQiA==
X-Forwarded-Encrypted: i=1; AFNElJ8DNHB5XaEQb62xCBVyzw2piHQFKUkxdqlvZzNocpD3gUjACAXDWfDuokB62iPhiBHdsmrBALQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwtabsZ78fidg2tcDrWWPTdFHV0g4j7glhkccV927QAHCn58Mf
	S/dBduA1/9RKG2gnO8LKxPGWkg3j2faQab/FKMNWQyvvpQ+3GuFO4K0POMx0BIR/6j+MPVMuXwI
	mniMB7/rxp6PxHeQWsc+x8m3G1Kkroqu0ak3Hv1+bVWSZPSIaYPoP9zhxpso=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3508:b0:482:65b4:4fd6 with SMTP id
 5614622812f47-4872f4a087fmr8543706b6e.20.1781513781549; Mon, 15 Jun 2026
 01:56:21 -0700 (PDT)
Date: Mon, 15 Jun 2026 01:56:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a2fbe35.be3f099c.2836ae.0018.GAE@google.com>
Subject: [syzbot] [net?] UBSAN: shift-out-of-bounds in xfrm_selector_match (3)
From: syzbot <syzbot+9383b1ff0df4b29ca5e6@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=4e828c596d7aa593];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299369-lists,netdev=lfdr.de,9383b1ff0df4b29ca5e6];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:herbert@gondor.apana.org.au,m:horms@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:steffen.klassert@secunet.com,m:syzkaller-bugs@googlegroups.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,appspotmail.com:email,goo.gl:url,storage.googleapis.com:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,googlegroups.com:email];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E0EF684D47

Hello,

syzbot found the following issue on:

HEAD commit:    2b07ea76fd28 Merge tag 'core-urgent-2026-06-13' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11cb4986580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e828c596d7aa593
dashboard link: https://syzkaller.appspot.com/bug?extid=9383b1ff0df4b29ca5e6
compiler:       Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-1~exp1~20260514074407.73), Debian LLD 22.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a90e4670c989/disk-2b07ea76.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e1ad8b2531b9/vmlinux-2b07ea76.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9a927176c534/bzImage-2b07ea76.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9383b1ff0df4b29ca5e6@syzkaller.appspotmail.com

------------[ cut here ]------------
UBSAN: shift-out-of-bounds in ./include/net/xfrm.h:970:23
shift exponent -96 is negative
CPU: 1 UID: 0 PID: 12115 Comm: syz.5.2221 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x30 lib/ubsan.c:233
 __ubsan_handle_shift_out_of_bounds+0x36d/0x400 lib/ubsan.c:494
 addr4_match include/net/xfrm.h:970 [inline]
 __xfrm4_selector_match net/xfrm/xfrm_policy.c:222 [inline]
 xfrm_selector_match+0xd5c/0x1140 net/xfrm/xfrm_policy.c:247
 __xfrm_policy_check+0x5d1/0x37b0 net/xfrm/xfrm_policy.c:3715
 __xfrm_policy_check2 include/net/xfrm.h:1302 [inline]
 xfrm_policy_check+0x475/0x880 include/net/xfrm.h:1307
 vti_rcv_cb+0x3b6/0x770 net/ipv4/ip_vti.c:135
 tunnel4_rcv_cb+0xd6/0x230 net/ipv4/tunnel4.c:124
 xfrm_rcv_cb+0x1c7/0x310 net/xfrm/xfrm_input.c:117
 xfrm_input+0x4738/0x7760 net/xfrm/xfrm_input.c:729
 vti_input+0x21f/0x330 net/ipv4/ip_vti.c:69
 tunnel4_rcv+0xdd/0x2d0 net/ipv4/tunnel4.c:103
 ip_protocol_deliver_rcu+0x2dc/0x440 net/ipv4/ip_input.c:207
 ip_local_deliver_finish+0x3bb/0x6f0 net/ipv4/ip_input.c:241
 NF_HOOK+0x336/0x3c0 include/linux/netfilter.h:318
 NF_HOOK+0x336/0x3c0 include/linux/netfilter.h:318
 __netif_receive_skb_one_core net/core/dev.c:6202 [inline]
 __netif_receive_skb net/core/dev.c:6315 [inline]
 netif_receive_skb_internal net/core/dev.c:6401 [inline]
 netif_receive_skb+0x45b/0xbf0 net/core/dev.c:6460
 tun_rx_batched+0x1de/0x790 drivers/net/tun.c:1487
 tun_get_user+0x2b04/0x4350 drivers/net/tun.c:1955
 tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:2001
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x612/0xba0 fs/read_write.c:688
 ksys_write+0x150/0x270 fs/read_write.c:740
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fca8819ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fca890f6028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fca88416090 RCX: 00007fca8819ce59
RDX: 0000000000000fce RSI: 0000200000000840 RDI: 0000000000000003
RBP: 00007fca88232d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fca88416128 R14: 00007fca88416090 R15: 00007fca8853fa48
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

