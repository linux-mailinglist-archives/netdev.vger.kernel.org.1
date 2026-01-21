Return-Path: <netdev+bounces-251891-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIUKEDvecGnCaQAAu9opvQ
	(envelope-from <netdev+bounces-251891-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 15:10:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C22582DA
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 15:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 21D69700F8B
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 13:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C9F331A78;
	Wed, 21 Jan 2026 13:35:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD832FC874
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 13:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769002528; cv=none; b=ko07Y909HeiSnkWCn3BDbURQ9bXBFvpyyGZR//hwbpxki1EovOx7oEv+pCNLisUyHJjhQIWd0prbvzsnPZofffxWj3oeXu2mrb226h4lXNLtkIsDRl/HiYj8yZ9cMQsbMZGTwLGvPQLpi9mx3j4qh+onGVX+eQAtQ/iiUjzOGLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769002528; c=relaxed/simple;
	bh=DAMSM75OcpULNAlZR0RaY0aEjdaRoLtxpze29C5gx5M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mhCTe8M/2xZsM07yLf/tAVU1QcGHY6KS1gdBCFzszLHmffJP+g7mjKhzZrU3yc0vLQ4g0iZweHtEta8KSRmmylq3T4nPS2M1D20tund5Xy3vVM7JBrhNjemV7LpE4y8qD7vuidME5vjtt7gcvIxl3JAKGSD+y7hftySfUzco+Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-6611c5723e0so9836827eaf.1
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 05:35:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769002525; x=1769607325;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=53JzOWPeoVrxy4qopP5RdUY6pGflKuhaRCQZhYCcfoY=;
        b=bhQ885A3QW2cwm1NPAWXYx5y6B9Zx4aFXxPOgHSwyBC9Kl/f+FmZ86Hdx+2dlwvMZU
         i1WvWVLqKMNWmveZV5ooD/f1HQcFWe1ahb5uPp9GBCVBoTLsNW/TvmLCVwTkMlWyD1lJ
         p1KN5iUTt6wD2E6uCmxG6zfyOx4Vx94b9SDgGwytATGRqx31Q2rl02HBvBRGduIEVHdE
         rfigIcY+RGgL7vIwsuzwJU4kCfHqkyoxC48AQEjPffHdn6rlTZTZVySj27tGbUtTPexz
         0cCz8wse3oMk/KzbsSM/VipQVmnlc/d8IJUHD4FEhDy2W2yPHIHltHxzBxVOfuX6TMnA
         hdhA==
X-Forwarded-Encrypted: i=1; AJvYcCXUi9/3ki9uINR6sIcnYw040hpWk5MpkcVw/wsv+V2s8kPa8PdKL5fqgNTxh7L8NRLTDQhMsXI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc8QekoNF8f2X4THoR739zUtYnxDpQaVbskT8kCsS8jny3eQ/c
	zpE2RBsftQcoqjZiT+g5I6/RNvpz3N7lDKzCwAzPT9L8AX5sZe2G0qIB7pRFyyD/hTInwnTEmNJ
	RyKaXyWJDO5EkvoiNH+TGFtt5/Cn+K/KuWwGu45T45IJP9o7ju16d5TLfYoI=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1391:b0:660:ffff:da11 with SMTP id
 006d021491bc7-662affaebfdmr2032067eaf.26.1769002525269; Wed, 21 Jan 2026
 05:35:25 -0800 (PST)
Date: Wed, 21 Jan 2026 05:35:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6970d61d.050a0220.706b.0010.GAE@google.com>
Subject: [syzbot] [net?] general protection fault in ife_tlv_meta_encode
From: syzbot <syzbot+5cf914f193dffde3bd3c@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	yotam.gi@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=ae589cd0a6acd9be];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : No valid SPF, No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,mojatatu.com,vger.kernel.org,redhat.com,googlegroups.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-251891-lists,netdev=lfdr.de,5cf914f193dffde3bd3c];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,googlegroups.com:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,goo.gl:url,appspotmail.com:email,syzkaller.appspot.com:url];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: D4C22582DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    c03e9c42ae8f Merge tag 'dma-mapping-6.19-2026-01-20' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12ce73fa580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ae589cd0a6acd9be
dashboard link: https://syzkaller.appspot.com/bug?extid=5cf914f193dffde3bd3c
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-c03e9c42.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b6abca6c0155/vmlinux-c03e9c42.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1bcd936b6484/bzImage-c03e9c42.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5cf914f193dffde3bd3c@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 3 UID: 0 PID: 8990 Comm: syz.0.696 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ife_tlv_meta_encode+0x41/0xa0 net/ife/ife.c:166
Code: 89 d5 53 89 f3 c1 e3 10 e8 8c ed 71 f6 0f b7 c5 4c 89 ea 44 8d 78 07 83 c0 04 48 c1 ea 03 09 c3 48 b8 00 00 00 00 00 fc ff df <0f> b6 14 02 4c 89 e8 0f cb 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75
RSP: 0018:ffffc900038cf238 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000010008 RCX: ffffc900038cf290
RDX: 0000000000000000 RSI: ffffffff8b4c7434 RDI: 0000000000000000
RBP: 0000000000000004 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000001000 R11: 000000000000001e R12: ffffc900038cf290
R13: 0000000000000000 R14: 0000000000000004 R15: 000000000000000b
FS:  0000000000000000(0000) GS:ffff8880979f6000(0063) knlGS:00000000f544db40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f544cfac CR3: 000000006a9f4000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 ife_encode_meta_u32+0x153/0x180 net/sched/act_ife.c:101
 tcf_ife_encode net/sched/act_ife.c:841 [inline]
 tcf_ife_act+0x1022/0x1de0 net/sched/act_ife.c:877
 tc_act include/net/tc_wrapper.h:130 [inline]
 tcf_action_exec+0x1c0/0xa20 net/sched/act_api.c:1152
 tcf_exts_exec include/net/pkt_cls.h:349 [inline]
 mall_classify+0x1a0/0x2a0 net/sched/cls_matchall.c:42
 tc_classify include/net/tc_wrapper.h:197 [inline]
 __tcf_classify net/sched/cls_api.c:1764 [inline]
 tcf_classify+0x7f2/0x1380 net/sched/cls_api.c:1860
 multiq_classify net/sched/sch_multiq.c:39 [inline]
 multiq_enqueue+0xe0/0x510 net/sched/sch_multiq.c:66
 dev_qdisc_enqueue+0x45/0x250 net/core/dev.c:4147
 __dev_xmit_skb net/core/dev.c:4262 [inline]
 __dev_queue_xmit+0x2998/0x46c0 net/core/dev.c:4798
 dev_queue_xmit include/linux/netdevice.h:3381 [inline]
 packet_xmit+0x23e/0x350 net/packet/af_packet.c:275
 packet_snd net/packet/af_packet.c:3076 [inline]
 packet_sendmsg+0x26e3/0x54a0 net/packet/af_packet.c:3108
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0xa5d/0xc30 net/socket.c:2592
 ___sys_sendmsg+0x134/0x1d0 net/socket.c:2646
 __sys_sendmsg+0x16d/0x220 net/socket.c:2678
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0xe8/0x680 arch/x86/entry/syscall_32.c:307
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/syscall_32.c:332
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf705d579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f544d55c EFLAGS: 00000296 ORIG_RAX: 0000000000000172
RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00000000800000c0
RDX: 0000000000000004 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ife_tlv_meta_encode+0x41/0xa0 net/ife/ife.c:166
Code: 89 d5 53 89 f3 c1 e3 10 e8 8c ed 71 f6 0f b7 c5 4c 89 ea 44 8d 78 07 83 c0 04 48 c1 ea 03 09 c3 48 b8 00 00 00 00 00 fc ff df <0f> b6 14 02 4c 89 e8 0f cb 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75
RSP: 0018:ffffc900038cf238 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000010008 RCX: ffffc900038cf290
RDX: 0000000000000000 RSI: ffffffff8b4c7434 RDI: 0000000000000000
RBP: 0000000000000004 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000001000 R11: 000000000000001e R12: ffffc900038cf290
R13: 0000000000000000 R14: 0000000000000004 R15: 000000000000000b
FS:  0000000000000000(0000) GS:ffff8880979f6000(0063) knlGS:00000000f544db40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f544cfac CR3: 000000006a9f4000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	89 d5                	mov    %edx,%ebp
   2:	53                   	push   %rbx
   3:	89 f3                	mov    %esi,%ebx
   5:	c1 e3 10             	shl    $0x10,%ebx
   8:	e8 8c ed 71 f6       	call   0xf671ed99
   d:	0f b7 c5             	movzwl %bp,%eax
  10:	4c 89 ea             	mov    %r13,%rdx
  13:	44 8d 78 07          	lea    0x7(%rax),%r15d
  17:	83 c0 04             	add    $0x4,%eax
  1a:	48 c1 ea 03          	shr    $0x3,%rdx
  1e:	09 c3                	or     %eax,%ebx
  20:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  27:	fc ff df
* 2a:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx <-- trapping instruction
  2e:	4c 89 e8             	mov    %r13,%rax
  31:	0f cb                	bswap  %ebx
  33:	83 e0 07             	and    $0x7,%eax
  36:	83 c0 03             	add    $0x3,%eax
  39:	38 d0                	cmp    %dl,%al
  3b:	7c 04                	jl     0x41
  3d:	84 d2                	test   %dl,%dl
  3f:	75                   	.byte 0x75


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

