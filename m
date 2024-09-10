Return-Path: <netdev+bounces-126790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A256C97279E
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 05:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CA841F247F4
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 03:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5508414EC44;
	Tue, 10 Sep 2024 03:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esNGjRNC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B521A20314;
	Tue, 10 Sep 2024 03:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725938583; cv=none; b=kq3PWZt5OuG9lCBx/rOD24mNXwf1nQ1gIHlm+QApy0Twsu2PfGN8yTeB3rYcIEQLZv9wQrxkskaSqt5J191dZeUb++J0J/JChzOuvR7UBBtRqvIH1pNR5qzaPbQFwjbLtESE4L1Rzun8PVZR5r4ttLEg7mvMuH57UQuD0DiS7EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725938583; c=relaxed/simple;
	bh=uQv7gCXI1CdkTrLrNf331jweHDDty/6Jl4p2r4eqNnc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Cc:Date:
	 Message-Id:References:To; b=oTzl13R8+FOVzaH6ODAAkT4/bvhX5yYsq2p2NpFaST2yut7MGq1Uf7leoaN1kQffDyXjYCKNeRe5sLiZ4pMa7Yzlpbj8zj26VYaV22QGrso1rdC43wwYH4vEoWdNpw+qkGIqX/BujjLpsB+BPemixogKCkOGiL3AWtjm1OfXYLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esNGjRNC; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-207115e3056so20499545ad.2;
        Mon, 09 Sep 2024 20:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725938581; x=1726543381; darn=vger.kernel.org;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0spQTLRseGVrGxyiEqlQENKs8kZYBANBeoSh7sevjjE=;
        b=esNGjRNCGp/H7IZGtCEoshcR3AP1T3LY66VogdxNSxzk64celzsMYa/xKhHvPJxZRL
         xlJHiq1/CyrDPYqnY5sZPrvvhLoXk/UtN2gVMAg8bwEEZYuMPQnITfp/Q+rMy4SnGTrk
         OKJFlcm2dT5D9wkCRLyTzru60dKYu3s8d1B1nvtvFt5xwUu3VBNax5kTQDuoLaaOv5eq
         nCkO8x15Dp4DNhyi3Q10O+9/4dydiFdEOejgxGewPLgkq3jg2lO/ihrWzQ+ROfbbd5Mx
         I5WHY9zes8RIOtvEItK4KmFdlDIiJEe7nCuBAKI8Ra8tDWSfvLw/t68gcVktXbWMj9qw
         RxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725938581; x=1726543381;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0spQTLRseGVrGxyiEqlQENKs8kZYBANBeoSh7sevjjE=;
        b=tCQcZiPYFVR8iaQv1iEiOsxQiKNAhEScxfFiw3ngGa1LJAVAaL3bo2HuC/inpZaRIP
         2sD2VeNbjx+c0dwTR9nVeuVSJXjRMoIfS/ySJs8ZbTVuzEzeTlR4vSBOoqcVHJ3kpJI+
         2cxiosyu/PnYBWWJtUhWMPJKzF9yysFT6vRIMhZDYaZfltE0NL5jLuTGqxoz7FLXrdQu
         b3UX9aT0YDLKKOfxqYL8YMmAc3ZygP/Q3fNVJzA+P2/UdO3xM39dZNAn/YY+HI63dJQ9
         +TkBxRHM5Ma0QXjru1z6xsFAH9AH8zVJYtmE/JGCbKMD1FtVwR3fmcDUqcJUHTaVGxt2
         G7fA==
X-Forwarded-Encrypted: i=1; AJvYcCUNCMjS7hJZe07lH4YpV4huFSBCzVlQAzPxc/Xp38hQdVZQptPmwsNGyqojlrBtHFuNJ3EqvsLAVLBCLVM=@vger.kernel.org, AJvYcCWjwYv5SV6YEoEHzakXJTzldiBb9ZY6IHsxCxk7Rf7ks7vE1r5KQri8eg1tsYtjBb0+hXyPkFMP@vger.kernel.org
X-Gm-Message-State: AOJu0YwoVgnIHkAEHLRC8W98NTSDULPbNFisqZX5LnFPl345LmRiKZ2T
	K7OEn6NRtSTDQKzx7VG+uTcJWCjX0aTvSLfiaGmaEu54MSxMhGYyl0hr6ya7NUY=
X-Google-Smtp-Source: AGHT+IFnuqR7YwMKwXoLglTUFo0Ret6nt+Ssx3a6vnIj3KtTdVGvUwEX2vM56xvFg8kTogxcDYiLiA==
X-Received: by 2002:a17:902:c943:b0:207:3a45:2be1 with SMTP id d9443c01a7336-2073a452d89mr46577825ad.51.1725938580762;
        Mon, 09 Sep 2024 20:23:00 -0700 (PDT)
Received: from smtpclient.apple ([2001:e60:a412:c347:8998:c7b2:95e4:f8cc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710eea91asm40201125ad.171.2024.09.09.20.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 20:23:00 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH net] net: prevent NULL pointer dereference in rt_fibinfo_free() and rt_fibinfo_free_cpus()
From: Jeongjun Park <aha310510@gmail.com>
In-Reply-To: <CANn89iLmOgH6RdRc_XGhawM03UEOkUK3QB0wK_Ci_YBVNwhUHQ@mail.gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, kafai@fb.com, weiwan@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 10 Sep 2024 12:22:48 +0900
Message-Id: <03C87C05-301E-4C34-82FF-6517316A11C2@gmail.com>
References: <CANn89iLmOgH6RdRc_XGhawM03UEOkUK3QB0wK_Ci_YBVNwhUHQ@mail.gmail.com>
To: Eric Dumazet <edumazet@google.com>
X-Mailer: iPhone Mail (21F90)


> Eric Dumazet <edumazet@google.com> wrote:
> =EF=BB=BFOn Mon, Sep 9, 2024 at 8:48=E2=80=AFPM Jeongjun Park <aha310510@g=
mail.com> wrote:
>>=20
>> rt_fibinfo_free() and rt_fibinfo_free_cpus() only check for rt and do not=

>> verify rt->dst and use it, which will result in NULL pointer dereference.=

>>=20
>> Therefore, to prevent this, we need to add a check for rt->dst.
>>=20
>> Fixes: 0830106c5390 ("ipv4: take dst->__refcnt when caching dst in fib")
>> Fixes: c5038a8327b9 ("ipv4: Cache routes in nexthop exception entries.")
>> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
>> ---
>=20
> As far as I can tell, your patch is a NOP, and these Fixes: tags seem
> random to me.

I somewhat agree with the opinion that the fixes tag is random.=20
However, I think it is absolutely necessary to add a check for=20
&rt->dst , because the existence of rt does not guarantee that=20
&rt->dst will not be NULL.

>=20
> Also, I am guessing this is based on a syzbot report ?

Yes, but it's not a bug reported to syzbot, it's a bug that=20
I accidentally found in my syzkaller fuzzer. The report is too long
to be included in the patch notes, so I'll attach it to this email.

Report:

Oops: general protection fault, probably for non-canonical address 0xdffffc0=
000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 UID: 0 PID: 4694 Comm: systemd-udevd Not tainted 6.11.0-rc6-00326-gd1=
f2d51b711a #16
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2=
014
RIP: 0010:dst_dev_put+0x26/0x330 net/core/dst.c:149
Code: 90 90 90 90 f3 0f 1e fa 41 57 41 56 49 89 fe 41 55 41 54 55 e8 0b 90 a=
f f8 4c 89 f2 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 da=
 02 00 00 49 8d 7e 3a 4d 8b 26 48 b8 00 00 00
RSP: 0018:ffffc90000007d68 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: ffffffff8976519a
RDX: 0000000000000000 RSI: ffffffff88d97a95 RDI: 0000000000000001
RBP: dffffc0000000000 R08: 0000000000000001 R09: ffffed100c8020c3
R10: 0000000000000000 R11: 0000000000000000 R12: fffffbfff1ab5a81
R13: 0000607f8106c5c8 R14: 0000000000000001 R15: 0000000000000000
FS:  00007f235c5fd8c0(0000) GS:ffff88802c400000(0000) knlGS:0000000000000000=

CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f39c90e5168 CR3: 0000000019688000 CR4: 0000000000750ef0
PKRU: 55555554
Call Trace:
 <IRQ>
 rt_fibinfo_free_cpus.part.0+0xf4/0x1d0 net/ipv4/fib_semantics.c:206
 rt_fibinfo_free_cpus net/ipv4/fib_semantics.c:198 [inline]
 fib_nh_common_release+0x121/0x360 net/ipv4/fib_semantics.c:217
 fib_nh_release net/ipv4/fib_semantics.c:229 [inline]
 free_fib_info_rcu+0x18f/0x4b0 net/ipv4/fib_semantics.c:241
 rcu_do_batch kernel/rcu/tree.c:2569 [inline]
 rcu_core+0x826/0x16d0 kernel/rcu/tree.c:2843
 handle_softirqs+0x1d4/0x870 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]=

 sysvec_apic_timer_interrupt+0x99/0xb0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:7=
02
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [=
inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x3c/0x70 kernel/locking/spinlock.c:19=
4
Code: 74 24 10 e8 d6 03 6f f6 48 89 ef e8 8e 77 6f f6 81 e3 00 02 00 00 75 2=
9 9c 58 f6 c4 02 75 35 48 85 db 74 01 fb bf 01 00 00 00 e8 bf 24 61 f6 65 8b=
 05 c0 79 0b 75 85 c0 74 0e 5b 5d c3 cc cc cc
RSP: 0018:ffffc90001f978f8 EFLAGS: 00000206
RAX: 0000000000000006 RBX: 0000000000000200 RCX: 1ffffffff1fe4be9
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000001
RBP: ffffffff8dbc0ac0 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff8ff2a39f R11: ffffffff815d29ca R12: 0000000000000246
R13: ffff88801e866100 R14: 0000000000000200 R15: 0000000000000000
 rcu_read_unlock_special kernel/rcu/tree_plugin.h:691 [inline]
 __rcu_read_unlock+0x2d9/0x580 kernel/rcu/tree_plugin.h:436
 __netlink_sendskb net/netlink/af_netlink.c:1278 [inline]
 netlink_broadcast_deliver net/netlink/af_netlink.c:1408 [inline]
 do_one_broadcast net/netlink/af_netlink.c:1495 [inline]
 netlink_broadcast_filtered+0x8ec/0xe00 net/netlink/af_netlink.c:1540
 netlink_broadcast net/netlink/af_netlink.c:1564 [inline]
 netlink_sendmsg+0x9ee/0xd80 net/netlink/af_netlink.c:1899
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0xabe/0xc80 net/socket.c:2597
 ___sys_sendmsg+0x11d/0x1c0 net/socket.c:2651
 __sys_sendmsg+0xfe/0x1d0 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcb/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f235c8b0e13
Code: 8b 15 b9 a1 00 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 6=
4 8b 04 25 18 00 00 00 85 c0 75 14 b8 2e 00 00 00 0f 05 48 3d 00 f0 ff ff 77=
 55 c3 0f 1f 40 00 48 83 ec 28 89 54 24 1c 48
RSP: 002b:00007ffe93910d38 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000556a6858ba60 RCX: 00007f235c8b0e13
RDX: 0000000000000000 RSI: 00007ffe93910d60 RDI: 000000000000000e
RBP: 0000556a6858bdc0 R08: 00000000ffffffff R09: 0000556a685488e0
R10: 0000556a6858be38 R11: 0000000000000246 R12: 0000000000008010
R13: 0000556a6856fc30 R14: 0000000000000000 R15: 00007ffe93910df0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:dst_dev_put+0x26/0x330 net/core/dst.c:149
Code: 90 90 90 90 f3 0f 1e fa 41 57 41 56 49 89 fe 41 55 41 54 55 e8 0b 90 a=
f f8 4c 89 f2 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 da=
 02 00 00 49 8d 7e 3a 4d 8b 26 48 b8 00 00 00
RSP: 0018:ffffc90000007d68 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: ffffffff8976519a
RDX: 0000000000000000 RSI: ffffffff88d97a95 RDI: 0000000000000001
RBP: dffffc0000000000 R08: 0000000000000001 R09: ffffed100c8020c3
R10: 0000000000000000 R11: 0000000000000000 R12: fffffbfff1ab5a81
R13: 0000607f8106c5c8 R14: 0000000000000001 R15: 0000000000000000
FS:  00007f235c5fd8c0(0000) GS:ffff88802c400000(0000) knlGS:0000000000000000=

CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f39c90e5168 CR3: 0000000019688000 CR4: 0000000000750ef0
PKRU: 55555554
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	f3 0f 1e fa          	endbr64
   8:	41 57                	push   %r15
   a:	41 56                	push   %r14
   c:	49 89 fe             	mov    %rdi,%r14
   f:	41 55                	push   %r13
  11:	41 54                	push   %r12
  13:	55                   	push   %rbp
  14:	e8 0b 90 af f8       	call   0xf8af9024
  19:	4c 89 f2             	mov    %r14,%rdx
  1c:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  23:	fc ff df
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping inst=
ruction
  2e:	0f 85 da 02 00 00    	jne    0x30e
  34:	49 8d 7e 3a          	lea    0x3a(%r14),%rdi
  38:	4d 8b 26             	mov    (%r14),%r12
  3b:	48                   	rex.W
  3c:	b8                   	.byte 0xb8
  3d:	00 00                	add    %al,(%rax)=

