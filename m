Return-Path: <netdev+bounces-286283-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPomF9NvAGrdIwEAu9opvQ
	(envelope-from <netdev+bounces-286283-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 13:45:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E5F503D1D
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 13:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C5B1300BD87
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 11:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F00C2F90E0;
	Sun, 10 May 2026 11:45:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A7B212D7C
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778413521; cv=none; b=uuq6JSSK08pHmv5fIiBWKdqy7QmrzBXjIsvFDwjaCEZRHgE5k3aNkzOFW8n2LprdgW33ySLi3wO6f2Rc6ziCExIIu/mgDfTvtQ/7rVJClZHdJSTF3s97G/3xxsZdK/dl4qF/sYKmTErVXE5U0fnxyHpIPMGiLWxs0r9nxmAAY7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778413521; c=relaxed/simple;
	bh=f7vDKd9emGoBZY0kKk+9Q6i+eApjgd4gnN1hfxTgzLI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=AcqTCrWEReXGfwh4iPqick4cBADk4/Gv35eGarJHRgBUx2xJZ9oTHfx1Ft8OqCf3fnyFABkVvOkVLHja/mdmrhEXb5/VrbkJmApJ6NGBUGDNS5qaNDbmKmL4OwEINOR36q755AjjR6/AIDVgVrMihxykIGMvY4qgUjXTEyYRt0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-69b4c167215so486282eaf.0
        for <netdev@vger.kernel.org>; Sun, 10 May 2026 04:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778413518; x=1779018318;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u1S0jhFosikT+aSVaZZXhcknVPXPdrZL1cz+mO2KiWI=;
        b=n0feCp/vP+5TF+j13f1lyHLBqn/e7zW9HhqcY0H8aDKbXDpMiAf3JEQc3EG1sJhV0N
         5qz1P8BSXG0fC61cb788c2YkH6TXvndwH4W2F36NFJNvqYenSCAuNt3grvqlHrjp5I9G
         1yUWvg4ZA8NbS1WjVcUo6xcm0BFuDPWkwSNIJ3YqgRB/ypxNSSmVEff4oSKXY7lzIK11
         RylazMaY5ABPZC7odGduaGlU4ePMtVLyv8tMny3DYE+z/WZnF73ib5lD60hbvHMeqwIV
         jyfnD279KqwJkyrBvwMwPqotswxMI5kUo5mszijqn2Q2jUv8H9VYWi3q2QZ589+AXal8
         B51g==
X-Forwarded-Encrypted: i=1; AFNElJ+6/hlG/Djyjp+czjIr1+g7iHW53cJ6Kvy55klqSYoeylELaNzIh/gQPPx4g7yHILXzvuHK8NM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8BujJwPrSB/euqMvfqwxryZXLG3FNvN2dkPYTe0VsOyRSW83u
	CMo1DpxwHGrlX7q+/vWCS+C7S7iuFSe1DvnWQ/IDCfaT9BQixT3xHsn8RrAjw6pVUncwdW+Ynn6
	9159l435D3YfOvNe7Bqz3iFmTOSU5gQkQrGxzZvVfm0E2YBUHDGFOupVqWgM=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:d84b:0:b0:695:94b4:d4cc with SMTP id
 006d021491bc7-699ab57164amr5015199eaf.1.1778413518490; Sun, 10 May 2026
 04:45:18 -0700 (PDT)
Date: Sun, 10 May 2026 04:45:18 -0700
In-Reply-To: <67e8340baa2c2772def267a801c8d5b201444d49.1778382236.git.caoruide123@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a006fce.a00a0220.1c3806.000f.GAE@google.com>
Subject: [syzbot ci] Re: net: nsh: limit recursive GSO redispatch
From: syzbot ci <syzbot+ci4085cfa6e79bb05c@syzkaller.appspotmail.com>
To: bird@lzu.edu.cn, caoruide123@gmail.com, davem@davemloft.net, 
	jbenc@redhat.com, lkp@intel.com, lx24@stu.ynu.edu.cn, matttbe@kernel.org, 
	n05ec@lzu.edu.cn, netdev@vger.kernel.org, tomapufckgml@gmail.com, 
	yifanwucs@gmail.com, yuantan098@gmail.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: A6E5F503D1D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-286283-lists,netdev=lfdr.de,ci4085cfa6e79bb05c];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lzu.edu.cn,gmail.com,davemloft.net,redhat.com,intel.com,stu.ynu.edu.cn,kernel.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.901];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlegroups.com:email,appspotmail.com:email,googlesource.com:url,syzbot.org:url]
X-Rspamd-Action: no action

syzbot ci has tested the following series

[v2] net: nsh: limit recursive GSO redispatch
https://lore.kernel.org/all/67e8340baa2c2772def267a801c8d5b201444d49.1778382236.git.caoruide123@gmail.com
* [PATCH net v2 1/1] net: nsh: limit recursive GSO redispatch

and found the following issue:
BUG: using __this_cpu_read() in preemptible code in nsh_gso_segment

Full report is available here:
https://ci.syzbot.org/series/cb23e640-2f7a-42e1-8bad-7249684b1cd5

***

BUG: using __this_cpu_read() in preemptible code in nsh_gso_segment

tree:      net
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net.git
base:      496c0c4c53bbe1bad97e82cd12103df61a6e459d
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/a7e3d1e1-97c4-4876-99c8-658c4cef49c5/config
syz repro: https://ci.syzbot.org/findings/62ca20c2-7c78-4820-b695-f63b15eaf738/syz_repro

BUG: using __this_cpu_read() in preemptible [00000000] code: syz.1.18/5860
caller is dev_xmit_recursion include/linux/netdevice.h:3625 [inline]
caller is nsh_gso_segment+0x535/0xed0 net/nsh/nsh.c:110
CPU: 0 UID: 0 PID: 5860 Comm: syz.1.18 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 check_preemption_disabled+0xd3/0xe0 lib/smp_processor_id.c:47
 dev_xmit_recursion include/linux/netdevice.h:3625 [inline]
 nsh_gso_segment+0x535/0xed0 net/nsh/nsh.c:110
 skb_mac_gso_segment+0x31c/0x690 net/core/gso.c:53
 __skb_gso_segment+0x376/0x540 net/core/gso.c:124
 skb_gso_segment include/net/gso.h:83 [inline]
 validate_xmit_skb+0xa21/0x14a0 net/core/dev.c:4039
 validate_xmit_skb_list net/core/dev.c:4089 [inline]
 __dev_direct_xmit+0x1b4/0x750 net/core/dev.c:4922
 dev_direct_xmit include/linux/netdevice.h:3431 [inline]
 packet_xmit+0x1b4/0x320 net/packet/af_packet.c:285
 packet_snd net/packet/af_packet.c:3082 [inline]
 packet_sendmsg+0x3c81/0x4fb0 net/packet/af_packet.c:3114
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 __sys_sendto+0x672/0x710 net/socket.c:2265
 __do_sys_sendto net/socket.c:2272 [inline]
 __se_sys_sendto net/socket.c:2268 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2268
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcd6a99cdd9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fcd6b903028 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007fcd6ac15fa0 RCX: 00007fcd6a99cdd9
RDX: 00000000000100a6 RSI: 0000200000000180 RDI: 0000000000000005
RBP: 00007fcd6aa32d69 R08: 0000200000000140 R09: 0000000000000014
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fcd6ac16038 R14: 00007fcd6ac15fa0 R15: 00007fff57a83608
 </TASK>
BUG: using __this_cpu_add() in preemptible [00000000] code: syz.1.18/5860
caller is dev_xmit_recursion_inc include/linux/netdevice.h:3631 [inline]
caller is nsh_gso_segment+0x57d/0xed0 net/nsh/nsh.c:113
CPU: 0 UID: 0 PID: 5860 Comm: syz.1.18 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 check_preemption_disabled+0xd3/0xe0 lib/smp_processor_id.c:47
 dev_xmit_recursion_inc include/linux/netdevice.h:3631 [inline]
 nsh_gso_segment+0x57d/0xed0 net/nsh/nsh.c:113
 skb_mac_gso_segment+0x31c/0x690 net/core/gso.c:53
 __skb_gso_segment+0x376/0x540 net/core/gso.c:124
 skb_gso_segment include/net/gso.h:83 [inline]
 validate_xmit_skb+0xa21/0x14a0 net/core/dev.c:4039
 validate_xmit_skb_list net/core/dev.c:4089 [inline]
 __dev_direct_xmit+0x1b4/0x750 net/core/dev.c:4922
 dev_direct_xmit include/linux/netdevice.h:3431 [inline]
 packet_xmit+0x1b4/0x320 net/packet/af_packet.c:285
 packet_snd net/packet/af_packet.c:3082 [inline]
 packet_sendmsg+0x3c81/0x4fb0 net/packet/af_packet.c:3114
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 __sys_sendto+0x672/0x710 net/socket.c:2265
 __do_sys_sendto net/socket.c:2272 [inline]
 __se_sys_sendto net/socket.c:2268 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2268
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcd6a99cdd9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fcd6b903028 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007fcd6ac15fa0 RCX: 00007fcd6a99cdd9
RDX: 00000000000100a6 RSI: 0000200000000180 RDI: 0000000000000005
RBP: 00007fcd6aa32d69 R08: 0000200000000140 R09: 0000000000000014
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fcd6ac16038 R14: 00007fcd6ac15fa0 R15: 00007fff57a83608
 </TASK>
BUG: using __this_cpu_add() in preemptible [00000000] code: syz.1.18/5860
caller is dev_xmit_recursion_dec include/linux/netdevice.h:3636 [inline]
caller is nsh_gso_segment+0x59f/0xed0 net/nsh/nsh.c:115
CPU: 0 UID: 0 PID: 5860 Comm: syz.1.18 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 check_preemption_disabled+0xd3/0xe0 lib/smp_processor_id.c:47
 dev_xmit_recursion_dec include/linux/netdevice.h:3636 [inline]
 nsh_gso_segment+0x59f/0xed0 net/nsh/nsh.c:115
 skb_mac_gso_segment+0x31c/0x690 net/core/gso.c:53
 __skb_gso_segment+0x376/0x540 net/core/gso.c:124
 skb_gso_segment include/net/gso.h:83 [inline]
 validate_xmit_skb+0xa21/0x14a0 net/core/dev.c:4039
 validate_xmit_skb_list net/core/dev.c:4089 [inline]
 __dev_direct_xmit+0x1b4/0x750 net/core/dev.c:4922
 dev_direct_xmit include/linux/netdevice.h:3431 [inline]
 packet_xmit+0x1b4/0x320 net/packet/af_packet.c:285
 packet_snd net/packet/af_packet.c:3082 [inline]
 packet_sendmsg+0x3c81/0x4fb0 net/packet/af_packet.c:3114
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 __sys_sendto+0x672/0x710 net/socket.c:2265
 __do_sys_sendto net/socket.c:2272 [inline]
 __se_sys_sendto net/socket.c:2268 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2268
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcd6a99cdd9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fcd6b903028 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007fcd6ac15fa0 RCX: 00007fcd6a99cdd9
RDX: 00000000000100a6 RSI: 0000200000000180 RDI: 0000000000000005
RBP: 00007fcd6aa32d69 R08: 0000200000000140 R09: 0000000000000014
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fcd6ac16038 R14: 00007fcd6ac15fa0 R15: 00007fff57a83608
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

To test a patch for this bug, please reply with `#syz test`
(should be on a separate line).

The patch should be attached to the email.
Note: arguments like custom git repos and branches are not supported.

