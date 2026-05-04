Return-Path: <netdev+bounces-283708-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id O6f2ASw/+GmFrwIAu9opvQ
	(envelope-from <netdev+bounces-283708-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 08:39:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FFA4B8F6B
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 08:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 303A830013BF
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 06:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD39299929;
	Mon,  4 May 2026 06:39:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AEF27380A
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 06:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777876773; cv=none; b=utFiMKzVQOrWXaDQlXkCUwk+dWCMni4u0reqCaIpDckOCEPCGHJeR41J2U2DYa8QLQicOAuTggbxvhc/hsiUJKwEN3xfkgQG8t4wybfcN/AJ64ftiGeZaD5mBnEWrmyKFc6zrVDhLISxn4HFAEDfvBZ3DouwZqReUYoOnaRotO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777876773; c=relaxed/simple;
	bh=1Qs0DDzuGyBjMXbYIUZe00wLbA0MzP8qGoD+rUEysTc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NyYjgMLgxHxtRCNmB2dVmsDjy9eLUcjAQ1daEp+OEohoVsYgzVDAs4tmx26PuI98qBGPdnGWsOCn0E9blRBu17lhlAz/I2edX+QnYLA8gjlrBVOpwp//nMqbw2V6zvNsWA+4fgHz/dDie+2dGuu6sqpJgeCn6o+hU1Zlua6iWqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-46ff0cb3a36so5225896b6e.2
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 23:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777876771; x=1778481571;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vUNdkvrNnYEQQkZBw5+AsByBP+nxlstl8VuB452P2JU=;
        b=oyArVpAjnw88s2Hz3CwNoPo3SDCK2/niAoK+qsXnaz5CxCmT6zTwrgH1acgAqbPA1U
         GA8EWmxafSaPKPu22y0SFNgSXt60bMRrkWZeJpyv1tvx+cOjqY0PVj4lUFPQzxv7HZlZ
         igwBG7iUqft/3lpL8Nag5sV9r//mGO5Nh4vbGCPWjGO2JTU1G8Q7VUkjlPxdG/nvuY82
         kOMZynIOKRtckyV7+I+sk+JiiTmPBrdkzq//DuUcGEoM+3QBxDsHtBCGMVOdcX1idRqa
         yEk8W15svMUFi1qanpZu4OZ4hxJ+FsMV4rQULpd/FijGmW41oNsbaH0Dk2YgkaIH3THH
         twnw==
X-Forwarded-Encrypted: i=1; AFNElJ8Dc+cwGyakbtfZQ2QlknJA0vMLXbgS+DBwlNhPROuboTxxYut793ObI6Q4sqreS8NJAx2uU74=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLT4HyOHMdt7eDLR2rznylxpnuRZ+CNZgRGzEjtNDFrX73dyw+
	e+8zgBDclrvmC7bMCrVycnf1HbM3BF8+uyynoIrfriswt9RQi87ip3l4ZbPSrHhsAH1joyI/gZd
	FhKpPXTNS2jpGo0CeogxedZnpX36uEKl0ew13OEBa2y6qND7s1W8XpT20UIc=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:61e:b0:67b:baae:3339 with SMTP id
 006d021491bc7-69697db76a6mr4298628eaf.45.1777876771001; Sun, 03 May 2026
 23:39:31 -0700 (PDT)
Date: Sun, 03 May 2026 23:39:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69f83f22.170a0220.13cc2.0004.GAE@google.com>
Subject: [syzbot] [net?] general protection fault in rt6_insert_exception
From: syzbot <syzbot+01f005f9c6387ca6f6dd@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: D7FFA4B8F6B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=d0f0911eedbc130a];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
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
	TAGGED_FROM(0.00)[bounces-283708-lists,netdev=lfdr.de,01f005f9c6387ca6f6dd];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,storage.googleapis.com:url,appspotmail.com:email,syzkaller.appspot.com:url]

Hello,

syzbot found the following issue on:

HEAD commit:    66edb901bf87 Merge tag 'v7.1-p3' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15b40d06580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d0f0911eedbc130a
dashboard link: https://syzkaller.appspot.com/bug?extid=01f005f9c6387ca6f6dd
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-66edb901.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8741b8f9dedf/vmlinux-66edb901.xz
kernel image: https://storage.googleapis.com/syzbot-assets/675ec9fff2a9/bzImage-66edb901.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+01f005f9c6387ca6f6dd@syzkaller.appspotmail.com

kvm_intel: set kvm_intel.dump_invalid_vmcs=1 to dump internal KVM state.
Oops: general protection fault, probably for non-canonical address 0xdffffc00000000bc: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x00000000000005e0-0x00000000000005e7]
CPU: 0 UID: 0 PID: 7890 Comm: syz.2.502 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:fib6_mtu net/ipv6/route.c:1648 [inline]
RIP: 0010:rt6_insert_exception+0x9eb/0x10a0 net/ipv6/route.c:1753
Code: 3b 14 cf f7 45 85 f6 0f 85 1d 02 00 00 e8 7d 19 cf f7 48 8d bb e0 05 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 89
RSP: 0000:ffffc9000610f120 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc9000c001000
RDX: 00000000000000bc RSI: ffffffff8a38bc83 RDI: 00000000000005e0
RBP: ffff888052f06000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff888042d16c00
R13: ffff888042d16cc8 R14: 0000000000000001 R15: 0000000000000500
FS:  0000000000000000(0000) GS:ffff88809717d000(0063) knlGS:00000000f540db40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f73c6d50 CR3: 000000006eff0000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 __ip6_rt_update_pmtu+0x555/0xd60 net/ipv6/route.c:2982
 ip6_update_pmtu+0x34f/0x3b0 net/ipv6/route.c:3014
 icmpv6_err+0x2a2/0x3f0 net/ipv6/icmp.c:82
 icmpv6_notify+0x35e/0x820 net/ipv6/icmp.c:1087
 icmpv6_rcv+0x10bf/0x1ae0 net/ipv6/icmp.c:1228
 ip6_protocol_deliver_rcu+0xf97/0x1500 net/ipv6/ip6_input.c:478
 ip6_input_finish+0x1e4/0x4a0 net/ipv6/ip6_input.c:529
 NF_HOOK include/linux/netfilter.h:318 [inline]
 NF_HOOK include/linux/netfilter.h:312 [inline]
 ip6_input+0x105/0x2f0 net/ipv6/ip6_input.c:540
 ip6_mc_input+0x513/0xf50 net/ipv6/ip6_input.c:630
 dst_input include/net/dst.h:480 [inline]
 ip6_rcv_finish net/ipv6/ip6_input.c:119 [inline]
 NF_HOOK include/linux/netfilter.h:318 [inline]
 NF_HOOK include/linux/netfilter.h:312 [inline]
 ipv6_rcv+0x34c/0x3d0 net/ipv6/ip6_input.c:351
 __netif_receive_skb_one_core+0x12d/0x1e0 net/core/dev.c:6202
 __netif_receive_skb+0x1f/0x120 net/core/dev.c:6315
 netif_receive_skb_internal net/core/dev.c:6401 [inline]
 netif_receive_skb+0x13b/0x7f0 net/core/dev.c:6460
 tun_rx_batched.isra.0+0x3f6/0x750 drivers/net/tun.c:1511
 tun_get_user+0x1e31/0x3c20 drivers/net/tun.c:1955
 tun_chr_write_iter+0xdc/0x200 drivers/net/tun.c:2001
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1070 fs/read_write.c:688
 ksys_write+0x12a/0x250 fs/read_write.c:740
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 do_int80_emulation+0x141/0x700 arch/x86/entry/syscall_32.c:172
 asm_int80_emulation+0x1a/0x20 arch/x86/include/asm/idtentry.h:621
RIP: 0023:0xf715616b
Code: 57 56 53 8b 44 24 14 f6 00 08 75 23 8b 44 24 18 8b 5c 24 1c 8b 4c 24 20 8b 54 24 24 8b 74 24 28 8b 7c 24 2c 8b 6c 24 30 cd 80 <5b> 5e 5f 5d c3 5b 5e 5f 5d e9 f7 a1 ff ff 66 90 66 90 66 90 90 53
RSP: 002b:00000000f540d44c EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00000000000000c8 RCX: 0000000080000640
RDX: 000000000000007a RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:fib6_mtu net/ipv6/route.c:1648 [inline]
RIP: 0010:rt6_insert_exception+0x9eb/0x10a0 net/ipv6/route.c:1753
Code: 3b 14 cf f7 45 85 f6 0f 85 1d 02 00 00 e8 7d 19 cf f7 48 8d bb e0 05 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 89
RSP: 0000:ffffc9000610f120 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc9000c001000
RDX: 00000000000000bc RSI: ffffffff8a38bc83 RDI: 00000000000005e0
RBP: ffff888052f06000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff888042d16c00
R13: ffff888042d16cc8 R14: 0000000000000001 R15: 0000000000000500
FS:  0000000000000000(0000) GS:ffff88809717d000(0063) knlGS:00000000f540db40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f73c6d50 CR3: 000000006eff0000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	3b 14 cf             	cmp    (%rdi,%rcx,8),%edx
   3:	f7 45 85 f6 0f 85 1d 	testl  $0x1d850ff6,-0x7b(%rbp)
   a:	02 00                	add    (%rax),%al
   c:	00 e8                	add    %ch,%al
   e:	7d 19                	jge    0x29
  10:	cf                   	iret
  11:	f7 48 8d bb e0 05 00 	testl  $0x5e0bb,-0x73(%rax)
  18:	00 48 b8             	add    %cl,-0x48(%rax)
  1b:	00 00                	add    %al,(%rax)
  1d:	00 00                	add    %al,(%rax)
  1f:	00 fc                	add    %bh,%ah
  21:	ff                   	lcall  (bad)
  22:	df 48 89             	fisttps -0x77(%rax)
  25:	fa                   	cli
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx <-- trapping instruction
  2e:	48 89 f8             	mov    %rdi,%rax
  31:	83 e0 07             	and    $0x7,%eax
  34:	83 c0 03             	add    $0x3,%eax
  37:	38 d0                	cmp    %dl,%al
  39:	7c 08                	jl     0x43
  3b:	84 d2                	test   %dl,%dl
  3d:	0f                   	.byte 0xf
  3e:	85                   	.byte 0x85
  3f:	89                   	.byte 0x89


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

