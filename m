Return-Path: <netdev+bounces-121685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE5595E101
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 06:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0D1D1C20EBD
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 04:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA781D69E;
	Sun, 25 Aug 2024 04:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="f5zIobax";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="XJbJMqnN"
X-Original-To: netdev@vger.kernel.org
Received: from mx2.ucr.edu (mx2.ucr.edu [138.23.62.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A8F250EC
	for <netdev@vger.kernel.org>; Sun, 25 Aug 2024 04:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724559302; cv=none; b=YGdQQoOtXXyvn8LO8gt70rqp4ElK9HLRHOMCJRtCxTGtD86pP3N2r56g6bZVu4KNtGDN8jiWwZVez6geShsHlYgLxeOE9HRWJhzJOpNrpZZnAl+uFqetA3nC22rMec0ZUwnEzKKDhxqXEVNDyLWBeBMrzQcX2yZS5Fqu0MepNek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724559302; c=relaxed/simple;
	bh=L4pwj5e/Du/ZHfMerLHq/vRTblg6mzfiuz1IZooeInk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=dIjJOW+GEBxbiClZxWW9CwCTPis31TqKlV7HZKy6XHT+dU1XCZz3T1Imrh53h9lTgww1wvfyQ16/fFpjSfWzpKbugLMK4V9VJn6d3ei6eAInK7FPDGqqvNglUelkj+xfeet4oJzmN1k9msIKiZfidvMAWyHWreFi/8ZECl36MB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=f5zIobax; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=XJbJMqnN; arc=none smtp.client-ip=138.23.62.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724559300; x=1756095300;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:content-transfer-encoding:
   x-cse-connectionguid:x-cse-msgguid;
  bh=L4pwj5e/Du/ZHfMerLHq/vRTblg6mzfiuz1IZooeInk=;
  b=f5zIobaxgqHCJK6I+dTf496/g4YDeRG+njXnk40qFlI3pMetpOPil/59
   u2d4FDnu2zB4PMGlkQBgODpDN4FUk2Kyhpei+55dk3jljv9hb3Aj9sxg4
   vYLz4E58X4gbsYyu9ja6T+uP1r0lA4TM07jhCx5S+t9JHbdGhQ8Zf5OyM
   3yVWnrwnWROHIyprcCFCc/htxnLL1q6YdCGhHfgFzfsMJS52+OKJ+aQWK
   AvM6PRvOUulhXu+EZQHbgjbhGkoWIblR2ArCnpWjNABhujwQvrqndnTz0
   coG9jNIzFEe3FxnA3kqwgsTlOu6psw1Mgw4t8weWpfyAVXmg89U8n5GA0
   g==;
X-CSE-ConnectionGUID: //IeNWAiTfW+/vY5I2EuFA==
X-CSE-MsgGUID: 3N7DWckzSrOw43GpQvk0gw==
Received: from mail-ot1-f69.google.com ([209.85.210.69])
  by smtp2.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 24 Aug 2024 21:14:59 -0700
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-70cb2cd0cf4so4633926a34.3
        for <netdev@vger.kernel.org>; Sat, 24 Aug 2024 21:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724559299; x=1725164099; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4JHLAS9LFKUJx31SZDetF9WNVyX8R0blvVKxB0DviL8=;
        b=XJbJMqnNcC8OxMrlB2Hut708nxV25bHyQj9Kts/2N5MVw9JAS7Y/a6CFlIm2UpXM+u
         zg5SejD4Rm2nWEo5z6UEpxTVYQHy8/UsNNHSJNHubVusNs4S/T/iVkJ4R9140zJ9J35J
         P5GomhE7ley+0hswbIG4qVRewT1kNDhH9eTXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724559299; x=1725164099;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4JHLAS9LFKUJx31SZDetF9WNVyX8R0blvVKxB0DviL8=;
        b=rMmpNVL9NmiqaZtDcN0PWEz2JeYTdgvGharob1HnH+cc7bncqB6a9WZ33owzkVxa5r
         U54uaBT5taiWnuhcgFSnAV3zeHgOY0tGSx4kwzNJ/6donK4m5ZFWtJ/D4pucRTDeBFAa
         Meeea07lEfi3aLCs6YSf82JS1YUr1DxYMjSgMfcdwTlfk1BT8a7r5XNWFw663sgSYaBK
         NKSHr4X16pfZ6NQQrAF19vBezfCgG4pkTFqUbFw+Wdya6RcsZWE1YmVO0L+bsQL+GVSk
         ufA9u47PMK007PTpUVWIuD77JpTPdHDGj4PzHxmF4L/RxAlct5Hod8/UVVAh8hQXMfoo
         /cYA==
X-Forwarded-Encrypted: i=1; AJvYcCWyWYmUN4LPpg99B+8evtbHmN1UAnO1mLIRwvD92J8mZSSntiYiLMX3N47NTTPB3yO9fEANeXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYMUrPa5KaDL826L3UtjhgblwvVyn5Ekz0NDMGFMMQjC8w0gNn
	lXuc7AfiaVv6K8QgoXWORYA6k7m+bkGW3zz3okFdu3+15Se7mjDsikpc9rCMqXHsDZcchMejrLt
	GdSVp+QVfT2CGOzRq7k31F+t5BCV1B/b47DBn2+PmVJGziRKfidZ35p1bZ32bv+Oqdt+QVYIU2I
	hlQ1fmK3BOdocLXKs/BeqiT9t748zqAw==
X-Received: by 2002:a05:6830:4989:b0:703:6641:cea5 with SMTP id 46e09a7af769-70e0eb37e5bmr8708480a34.16.1724559299012;
        Sat, 24 Aug 2024 21:14:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxPHBCKI46nI/OXfg8etlSxv0aFfYfimbk9eAadzbb0zpTySvht50sBxkQI4YKVHEE0cb9T1zzLhMZjNP8G3Y=
X-Received: by 2002:a05:6830:4989:b0:703:6641:cea5 with SMTP id
 46e09a7af769-70e0eb37e5bmr8708459a34.16.1724559298687; Sat, 24 Aug 2024
 21:14:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Sat, 24 Aug 2024 21:14:48 -0700
Message-ID: <CALAgD-7C3t=vRTvpnVvsZ_1YhgiiynDaX_ud0O6pxSBn3suADQ@mail.gmail.com>
Subject: BUG: general protection fault in batadv_bla_del_backbone_claims
To: mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc, 
	sven@narfation.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	b.a.t.m.a.n@lists.open-mesh.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

We found a bug in Linux 6.10 using syzkaller. It is probably a null
pointer dereference bug.
In line 307 of net/batman-adv/bridge_loop_avoidance, when executing
"hash =3D backbone_gw->bat_priv->bla.claim_hash;", it does not check if
"backbone_gw->bat_priv=3D=3DNULL".

The bug report and syzkaller reproducer are as follows:

bug report:

Oops: general protection fault, probably for non-canonical address
0xdffffc000000004a: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000250-0x0000000000000257]
CPU: 0 PID: 45 Comm: kworker/u4:3 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014
Workqueue: bat_events batadv_bla_periodic_work
RIP: 0010:batadv_bla_del_backbone_claims+0x4e/0x360
net/batman-adv/bridge_loop_avoidance.c:307
Code: 18 48 83 c3 18 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89
df e8 01 72 33 f7 bd 50 02 00 00 48 03 2b 48 89 e8 48 c1 e8 03 <42> 80
3c 20 00 74 08 48 89 ef e8 e3 71 33 f7 48 8b 6d 00 48 85 ed
RSP: 0018:ffffc9000090f9b0 EFLAGS: 00010202
RAX: 000000000000004a RBX: ffff88802cd7c018 RCX: ffff888015370000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88802cd7c000
RBP: 0000000000000250 R08: ffffffff8ac0433d R09: 1ffff110059af805
R10: dffffc0000000000 R11: ffffed10059af806 R12: dffffc0000000000
R13: ffff88802cd7c008 R14: 00000000ffffcf80 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000556956047f2c CR3: 000000000d932000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 batadv_bla_purge_backbone_gw+0x285/0x4c0
net/batman-adv/bridge_loop_avoidance.c:1254
 batadv_bla_periodic_work+0xc3/0xa80 net/batman-adv/bridge_loop_avoidance.c=
:1445
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
 worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
 kthread+0x2eb/0x380 kernel/kthread.c:389
 ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:batadv_bla_del_backbone_claims+0x4e/0x360
net/batman-adv/bridge_loop_avoidance.c:307
Code: 18 48 83 c3 18 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89
df e8 01 72 33 f7 bd 50 02 00 00 48 03 2b 48 89 e8 48 c1 e8 03 <42> 80
3c 20 00 74 08 48 89 ef e8 e3 71 33 f7 48 8b 6d 00 48 85 ed
RSP: 0018:ffffc9000090f9b0 EFLAGS: 00010202
RAX: 000000000000004a RBX: ffff88802cd7c018 RCX: ffff888015370000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88802cd7c000
RBP: 0000000000000250 R08: ffffffff8ac0433d R09: 1ffff110059af805
R10: dffffc0000000000 R11: ffffed10059af806 R12: dffffc0000000000
R13: ffff88802cd7c008 R14: 00000000ffffcf80 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000556956047f2c CR3: 000000000d932000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0: 18 48 83             sbb    %cl,-0x7d(%rax)
   3: c3                   ret
   4: 18 48 89             sbb    %cl,-0x77(%rax)
   7: d8 48 c1             fmuls  -0x3f(%rax)
   a: e8 03 42 80 3c       call   0x3c804212
   f: 20 00                 and    %al,(%rax)
  11: 74 08                 je     0x1b
  13: 48 89 df             mov    %rbx,%rdi
  16: e8 01 72 33 f7       call   0xf733721c
  1b: bd 50 02 00 00       mov    $0x250,%ebp
  20: 48 03 2b             add    (%rbx),%rbp
  23: 48 89 e8             mov    %rbp,%rax
  26: 48 c1 e8 03           shr    $0x3,%rax
* 2a: 42 80 3c 20 00       cmpb   $0x0,(%rax,%r12,1) <-- trapping instructi=
on
  2f: 74 08                 je     0x39
  31: 48 89 ef             mov    %rbp,%rdi
  34: e8 e3 71 33 f7       call   0xf733721c
  39: 48 8b 6d 00           mov    0x0(%rbp),%rbp
  3d: 48 85 ed             test   %rbp,%rbp


Syzkaller reproducer:
# {Threaded:false Repeat:true RepeatTimes:0 Procs:1 Slowdown:1
Sandbox:none SandboxArg:0 Leak:false NetInjection:false
NetDevices:true NetReset:false Cgroups:false BinfmtMisc:true
CloseFDs:true KCSAN:false DevlinkPCI:false NicVF:false USB:true
VhciInjection:false Wifi:true IEEE802154:false Sysctl:false Swap:true
UseTmpDir:true HandleSegv:true Trace:false
LegacyOptions:{Collide:false Fault:false FaultCall:0 FaultNth:0}}
write$syz_spec_1342568572_346(0xffffffffffffffff,
&(0x7f0000000080)=3D{{0x0, 0x4, 0x6}, {0x5, 0x0, 0x111, 0xe,
"c2beae5c4e"}}, 0x20)
write$syz_spec_18446744072532934322_80(0xffffffffffffffff,
&(0x7f0000000000)=3D"2b952480c7ca55097d1707935ba64b20f3026c03d658026b81bf26=
4340512b3cb4e01afda2de754299ea7a113343ab7b9bda2fc0a2e2cdbfecbca0233a0772b12=
ebde5d98a1203cb871672dff7e4c86ec1dccef0a76312fbe8d45dc2bd0f8fc2ebeb2a6be6a3=
00916c5281da2c1ef64d66267091b82429976c019da3645557ed1d439c5a637f6bf58c53bc4=
14539dd87c69098d671402586b631f9ac5c2fe9cedc281a6f005b5c4d1dd5ed9be400",
0xb4)
r0 =3D syz_open_dev$sg(&(0x7f0000000180), 0x0, 0x109400)
ioctl$syz_spec_1724254976_2866(r0, 0x1, &(0x7f0000000080)=3D{0x0, 0x2,
[0x85, 0x8, 0x15, 0xd]})
ioctl$TIOCSTI(0xffffffffffffffff, 0x5412, 0x0)
openat$ttynull(0xffffffffffffff9c, &(0x7f00000000c0), 0x109841, 0x0)
r1 =3D openat$ttynull(0xffffffffffffff9c, 0x0, 0x109841, 0x0)
ioctl$TIOCSTI(r1, 0x5412, 0x0)
syz_open_dev$tty20(0xc, 0x4, 0x1)
write$syz_spec_1342568572_233(0xffffffffffffffff, 0x0, 0x0)
ioctl$syz_spec_1101043199_396(0xffffffffffffffff, 0x80104d12, 0x0)
ioctl$syz_spec_1342803520_149(0xffffffffffffffff, 0x5501, 0xf9d)
write$syz_spec_18446744073706268967_8(0xffffffffffffffff,
&(0x7f00000002c0)=3D0xfd80, 0xfffffc34)
ioctl$syz_spec_18446744073707301390_3197(0xffffffffffffffff, 0xc0a85320, 0x=
0)
ioctl$syz_spec_18446744073707301390_3092(0xffffffffffffffff, 0x40a85321, 0x=
0)
openat$ppp(0xffffffffffffff9c, &(0x7f0000000100), 0x200, 0x0)
mmap$IORING_OFF_SQ_RING(&(0x7f00003ff000/0xc00000)=3Dnil, 0xc00000, 0xe,
0x9a172, 0xffffffffffffffff, 0x0)
mmap$IORING_OFF_SQES(&(0x7f0000000000/0xc00000)=3Dnil, 0xc00000,
0x1000019, 0x42832, 0xffffffffffffffff, 0x10000000)




--=20
Yours sincerely,
Xingyu

