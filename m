Return-Path: <netdev+bounces-257490-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LNiJy6nhWmYEgQAu9opvQ
	(envelope-from <netdev+bounces-257490-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 09:32:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5D2FB8A7
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 09:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8567300D300
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 08:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47030349AF9;
	Fri,  6 Feb 2026 08:32:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009DF31B124
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 08:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770366734; cv=none; b=bbzqanq7yKYcLcT+0Qt5L1qnxJoHRGZhV9dnHz1EXlTPjkXRoizWBP5mZTVz4TBZ0PXyIlk2LWbfbkCIZ3hIJIOgOHrdob+lNwi2OprRuXuK+nL8vAxfYFQW/JCXqdGEmPOwVUkS4BpP8JRMb7Lf13bkt0pLiw+kVVCKD4drfd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770366734; c=relaxed/simple;
	bh=L5b8qOVQgNvhOSD+v+84L84qH7uRefmcsqF3UxEZMpE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Lea7Dl68u23skt9Ljo+8kzqykpkzN1WB+G0lX2kzNh6Ihdk10jPfu5APr5TbFpdgb+N/mgkPFdOvZ0luEitIjveyVRNKGyLnJkP5UjjJbQt3evivtYWIjX5diBEW967E8KmbEoEbjJxNgZdAJJnfUh9E26/+H7rW1R9Trz0kHrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-66308f16e13so580890eaf.0
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 00:32:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770366733; x=1770971533;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dPmTo2ri7jG36KtEfZNF+L2qJMQS+9NuLWlVMlY7PME=;
        b=BWsPdtoOhloFkeuPuJolzoVZOWZZ0n+B+KvA9scVzkzDjQa8TR13H+nfkliHj0B2Dd
         knNAoQGH7rY9g1iaJpy2TfLj+NxIC/T2vlbErQhLf6kwuyzQItHK+uzWiMnYUXI7sT4x
         yP5PUJqPNcED8cM9olJjWM5cGV92co5j0T0ev938QR2vINp7X9G8s906+ZnTRSCGd1aA
         J8+6k6r2MX4xaFJKdQgcwOp8Gn7eKOg4Uc4EoOcBMPp8z0QyURtUxmwQY+IiTSrp/a3H
         K+u2mseG0QI5QQxo6a6ieVGDl1ufUlXrqgafEnxfL+aGqIqXzvZOc7I4Ir21ZX/HseC2
         Wi2w==
X-Forwarded-Encrypted: i=1; AJvYcCWexYVAem23iW6co84zKhvG+A+XLk86X0x+QCo9U4MPAGwPOh/nMMqwQJqdTYQP37xZ/31rYk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFTIuGSoM5iSIoZjpRF80nZSBtHK2DFW6CICGDD0awQx9ZLSOZ
	1JoA5Kw2cSd5t0W71qEIY44x2mvOD3FRB+B5JVsDT0kANhj2dIEwWLjvk7UPsu7P+TwwSoksi2V
	B/hUDt1ynilSAR7DvTpgqj3qlpsAbTAOabZ68COHBIcB6lDJTJsUerDrWnus=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:3093:b0:663:8c6:978c with SMTP id
 006d021491bc7-66d0c75d6a8mr1083916eaf.65.1770366732936; Fri, 06 Feb 2026
 00:32:12 -0800 (PST)
Date: Fri, 06 Feb 2026 00:32:12 -0800
In-Reply-To: <177032644012.1975497.16411100029657607833.stgit@firesoul>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6985a70c.050a0220.3b3015.0034.GAE@google.com>
Subject: [syzbot ci] Re: net: sched: refactor qdisc drop reasons into
 dedicated tracepoint
From: syzbot ci <syzbot+ci335f183b8446659a@syzkaller.appspotmail.com>
To: atenart@redhat.com, bpf@vger.kernel.org, carges@cloudflare.com, 
	davem@davemloft.net, edumazet@google.com, eric.dumazet@gmail.com, 
	hawk@kernel.org, horms@kernel.org, jhs@mojatatu.com, jiri@resnulli.us, 
	kernel-team@cloudflare.com, kuba@kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, toke@toke.dk, xiyou.wangcong@gmail.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-257490-lists,netdev=lfdr.de,ci335f183b8446659a];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,vger.kernel.org,cloudflare.com,davemloft.net,google.com,gmail.com,kernel.org,mojatatu.com,resnulli.us,toke.dk];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,googlegroups.com:email,googlesource.com:url,syzbot.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0D5D2FB8A7
X-Rspamd-Action: no action

syzbot ci has tested the following series

[v2] net: sched: refactor qdisc drop reasons into dedicated tracepoint
https://lore.kernel.org/all/177032644012.1975497.16411100029657607833.stgit@firesoul
* [PATCH net-next v2 1/6] net: sched: introduce qdisc-specific drop reason tracing
* [PATCH net-next v2 2/6] net: sched: sfq: convert to qdisc drop reasons
* [PATCH net-next v2 3/6] net: sched: sch_cake: use enum qdisc_drop_reason for cobalt_should_drop
* [PATCH net-next v2 4/6] net: sched: rename QDISC_DROP_CAKE_FLOOD to QDISC_DROP_FLOOD_PROTECTION
* [PATCH net-next v2 5/6] net: sched: rename QDISC_DROP_FQ_* to generic names
* [PATCH net-next v2 6/6] net: sched: sch_dualpi2: use qdisc_dequeue_drop() for dequeue drops

and found the following issue:
WARNING in __dev_queue_xmit

Full report is available here:
https://ci.syzbot.org/series/51381d54-6fc9-4542-a8cd-eac656a11965

***

WARNING in __dev_queue_xmit

tree:      net-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net-next.git
base:      7a4cd71fa4514cd85df39b3cf99da8142660cdcd
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/17bc5e9e-8ccc-4afb-a291-312bbc43df20/config
C repro:   https://ci.syzbot.org/findings/20939160-05e8-4589-a6d5-6a253d5e39b0/c_repro
syz repro: https://ci.syzbot.org/findings/20939160-05e8-4589-a6d5-6a253d5e39b0/syz_repro

syzkaller0: entered promiscuous mode
syzkaller0: entered allmulticast mode
------------[ cut here ]------------
reason && reason < __QDISC_DROP_REASON
WARNING: net/sched/sch_generic.c:50 at tcf_kfree_skb_list+0xd6/0x100 net/sched/sch_generic.c:50, CPU#0: syz.0.17/5949
Modules linked in:
CPU: 0 UID: 0 PID: 5949 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:tcf_kfree_skb_list+0xd6/0x100 net/sched/sch_generic.c:50
Code: 89 e8 e8 5d 00 00 00 31 ff 4c 89 e6 ba 40 00 00 00 e8 be e6 d6 ff 4c 8b 24 24 4d 85 e4 74 27 e9 6e ff ff ff e8 1b f3 50 f8 90 <0f> 0b 90 eb c4 44 89 e9 80 e1 07 80 c1 03 38 c1 7c 96 4c 89 ef e8
RSP: 0018:ffffc90003e67360 EFLAGS: 00010293
RAX: ffffffff89718645 RBX: ffff8881133cc000 RCX: ffff8881738b9d40
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 000000000002ffff
RBP: 0000000000000001 R08: ffff88811571195b R09: 1ffff11022ae232b
R10: dffffc0000000000 R11: ffffed1022ae232c R12: ffff88810a9bca80
R13: 0000000000000002 R14: ffff888109569400 R15: ffff888115711800
FS:  000055558d217500(0000) GS:ffff88818e31a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000001410 CR3: 0000000166b9c000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 __dev_xmit_skb net/core/dev.c:4272 [inline]
 __dev_queue_xmit+0x18e5/0x3180 net/core/dev.c:4797
 packet_snd net/packet/af_packet.c:3077 [inline]
 packet_sendmsg+0x3eb6/0x50f0 net/packet/af_packet.c:3109
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:742
 ____sys_sendmsg+0x4d7/0x810 net/socket.c:2592
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2646
 __sys_sendmsg net/socket.c:2678 [inline]
 __do_sys_sendmsg net/socket.c:2683 [inline]
 __se_sys_sendmsg net/socket.c:2681 [inline]
 __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2681
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6544b9acb9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc871586c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f6544e15fa0 RCX: 00007f6544b9acb9
RDX: 0000000000000004 RSI: 00002000000000c0 RDI: 0000000000000008
RBP: 00007f6544c08bf7 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f6544e15fac R14: 00007f6544e15fa0 R15: 00007f6544e15fa0
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

