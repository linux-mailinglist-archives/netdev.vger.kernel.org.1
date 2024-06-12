Return-Path: <netdev+bounces-102968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115CF905ABC
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 20:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77F9FB23C58
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 18:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD682868D;
	Wed, 12 Jun 2024 18:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="AyWnUOKO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2681D39FE5
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 18:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718216569; cv=none; b=rxJSaqO28t8Y2cdpk/SZEP03KRGIlNirmrW9wA2jA7vKX0KM6pJnyglHLDBV+N4fJaKDCoV51CvTlxqvIFe+KYbWfkQRRZBG2qiPV2kOUOSYC+fr1PljvMzyCwdMpUpFXVYuUI+MmQinJbwWy0MdyKcp6bFLQlJxIUHi9p3SIWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718216569; c=relaxed/simple;
	bh=GR3hDXLc3YvECa3famzVdXKhUoz9HTjjNZxPrjI1Nls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DhAo1xLK8SwNgT3ne3dsVTaHv/QBTAWnhlYhfx2k4BqS2gyhCocIbPQ4zGu+dRK0mELkwdEtN1FueM2x4vc0GvPu9NZevUp9lqoZF4u1hcPEgExfDX2oauPgZSWE0d4jVFvCRuyFSVnVPEQtP6bHXWLpV280UhoF6ny/dIZxHkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=AyWnUOKO; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c2c9199568so100513a91.0
        for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 11:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718216567; x=1718821367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFRiPLrG/4qHhSxuPCIcUDtbfK4D5Xp70mUFVEpBX4o=;
        b=AyWnUOKOwQbJ/iX1DCQffMXV1e1yXwHifXJ+aALcx0rwFDNL3QafdwBYKAcaGV8WZF
         a6hSJH166fieAmdTdovgNMKygovyJJ7w5TM2j0EP5hChwRSVje/QxrPOaFdYmFPkSb7Z
         oXTuXT9d8r96B9tV0so0H7C6fv3ZhAKqDx0XWUGz2ckU7gGjIf65nzg1gf3JWDkBaL5o
         URR7RGOowm7ErtiUKlGheW8HwXsgLXjoeFLAPBgT4WUeeq7SnBbFt5TXTCaab+ahZb/r
         0HCwVlTsn3+Ll7/qdDpn4aZhsklHdm+zoGpnatebV3iT2eyHRrYjVlKrO2vAIvKbSRDh
         UTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718216567; x=1718821367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFRiPLrG/4qHhSxuPCIcUDtbfK4D5Xp70mUFVEpBX4o=;
        b=OxP06FgRIeMzvD2A2KAtvcTJ6FxvGc1LYnr4Al/GGv7CRo/jpXHl3aLccyJ/DqDztw
         zp4Laefbt0g6lMgDDFy1J730XFEnAEL5d02/b588B1jXjAt/MFZkcsSqptyKnb4ui0wx
         vnEErem3LumRV28mHyNH5X95zUrKM4PYM6jUtidMattIEdTorQOqvMGKCneUHIEjeKCZ
         S8gBW1at+i6dNny4wHilcXu049R3kbSIgmnPab2uXgVAdT2vbD0EQGUO/0eM69C2d5a3
         wqmfDoXha66J3dPbFMfbR2gJf+ysjBCqD2GAkPx+vI2VObuQg5lEhokpPc/IPuLj/AxL
         zX/w==
X-Forwarded-Encrypted: i=1; AJvYcCW3u3XTq4Sc/KKAaBjcuLwggQ5Akb1lHTTt3EhsTrdcog/B7fKcO8N+PHXmpgJ5EcgaMSBbP432MtK6yDCr4Bt0rJvujNb+
X-Gm-Message-State: AOJu0YwES9t/VdbsAeUHsscEaQbcg0bNhGDFGHiLgBnEroV+DcuZ04u7
	FixgU/PNTQQ93Xj1107w2OG6WExDx2JAN7XHkDhoiH70U0qKfoyQXIDbSyZhUgXdhugtED86vhQ
	1hslOOSU7vTnoECC5pTsj2jpZ+uEaynhHfg9nVw==
X-Google-Smtp-Source: AGHT+IHcBDkll3VstqS4fc48nDJPnv8bq709fqZCeJLCpdpIC6GHYEEr8LFoXx6H43c0kJIjNJrMJZCvfEBRnTCCdwA=
X-Received: by 2002:a17:90b:1c82:b0:2c4:aa69:26c5 with SMTP id
 98e67ed59e1d1-2c4aa6927e4mr2329884a91.28.1718216567232; Wed, 12 Jun 2024
 11:22:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611184716.72113-1-ignat@cloudflare.com> <20240611215457.30251-1-kuniyu@amazon.com>
In-Reply-To: <20240611215457.30251-1-kuniyu@amazon.com>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Wed, 12 Jun 2024 14:22:36 -0400
Message-ID: <CALrw=nEVktSeq4HcLqM0VfTrdHCLHeqi71-fKD8+UcBjtoVaBA@mail.gmail.com>
Subject: Re: [PATCH] net: do not leave dangling sk pointer in inet_create()/inet6_create()
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsa@cumulusnetworks.com, dsahern@kernel.org, 
	edumazet@google.com, kernel-team@cloudflare.com, kraig@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 5:55=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Ignat Korchagin <ignat@cloudflare.com>
> Date: Tue, 11 Jun 2024 19:47:16 +0100
> > It is possible to trigger a use-after-free by:
> >   * attaching an fentry probe to __sock_release() and the probe calling=
 the
> >     bpf_get_socket_cookie() helper
> >   * running traceroute -I 1.1.1.1 on a freshly booted VM
> >
> > A KASAN enabled kernel will log something like below (decoded):
> > [   78.328507][  T299] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [ 78.329018][ T299] BUG: KASAN: slab-use-after-free in __sock_gen_cooki=
e (./arch/x86/include/asm/atomic64_64.h:15 ./include/linux/atomic/atomic-ar=
ch-fallback.h:2583 ./include/linux/atomic/atomic-instrumented.h:1611 net/co=
re/sock_diag.c:29)
> > [   78.329366][  T299] Read of size 8 at addr ffff888007110dd8 by task =
traceroute/299
> > [   78.329366][  T299]
> > [   78.329366][  T299] CPU: 2 PID: 299 Comm: traceroute Tainted: G     =
       E      6.10.0-rc2+ #2
> > [   78.329366][  T299] Hardware name: QEMU Standard PC (i440FX + PIIX, =
1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [   78.329366][  T299] Call Trace:
> > [   78.329366][  T299]  <TASK>
> > [ 78.329366][ T299] dump_stack_lvl (lib/dump_stack.c:117 (discriminator=
 1))
> > [ 78.329366][ T299] print_report (mm/kasan/report.c:378 mm/kasan/report=
.c:488)
> > [ 78.329366][ T299] ? __sock_gen_cookie (./arch/x86/include/asm/atomic6=
4_64.h:15 ./include/linux/atomic/atomic-arch-fallback.h:2583 ./include/linu=
x/atomic/atomic-instrumented.h:1611 net/core/sock_diag.c:29)
> > [ 78.329366][ T299] kasan_report (mm/kasan/report.c:603)
> > [ 78.329366][ T299] ? __sock_gen_cookie (./arch/x86/include/asm/atomic6=
4_64.h:15 ./include/linux/atomic/atomic-arch-fallback.h:2583 ./include/linu=
x/atomic/atomic-instrumented.h:1611 net/core/sock_diag.c:29)
> > [ 78.329366][ T299] kasan_check_range (mm/kasan/generic.c:183 mm/kasan/=
generic.c:189)
> > [ 78.329366][ T299] __sock_gen_cookie (./arch/x86/include/asm/atomic64_=
64.h:15 ./include/linux/atomic/atomic-arch-fallback.h:2583 ./include/linux/=
atomic/atomic-instrumented.h:1611 net/core/sock_diag.c:29)
> > [ 78.329366][ T299] bpf_get_socket_ptr_cookie (./arch/x86/include/asm/p=
reempt.h:94 ./include/linux/sock_diag.h:42 net/core/filter.c:5094 net/core/=
filter.c:5092)
> > [ 78.329366][ T299] bpf_prog_875642cf11f1d139___sock_release+0x6e/0x8e
> > [ 78.329366][ T299] bpf_trampoline_6442506592+0x47/0xaf
> > [ 78.329366][ T299] __sock_release (net/socket.c:652)
> > [ 78.329366][ T299] __sock_create (net/socket.c:1601)
> > [ 78.329366][ T299] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
> > [ 78.329366][ T299] __sys_socket (net/socket.c:1660 net/socket.c:1644 n=
et/socket.c:1706)
> > [ 78.329366][ T299] ? __pfx___sys_socket (net/socket.c:1702)
> > [ 78.329366][ T299] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
> > [ 78.329366][ T299] ? up_read (./arch/x86/include/asm/atomic64_64.h:79 =
./include/linux/atomic/atomic-arch-fallback.h:2749 ./include/linux/atomic/a=
tomic-long.h:184 ./include/linux/atomic/atomic-instrumented.h:3317 kernel/l=
ocking/rwsem.c:1347 kernel/locking/rwsem.c:1622)
> > [ 78.329366][ T299] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
> > [ 78.329366][ T299] ? do_user_addr_fault (arch/x86/mm/fault.c:1419)
> > [ 78.329366][ T299] __x64_sys_socket (net/socket.c:1718)
> > [ 78.329366][ T299] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
> > [ 78.329366][ T299] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/=
entry/common.c:83)
> > [ 78.329366][ T299] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entr=
y_64.S:130)
> > [   78.329366][  T299] RIP: 0033:0x7f4022818ca7
> > [ 78.329366][ T299] Code: 73 01 c3 48 8b 0d 59 71 0c 00 f7 d8 64 89 01 =
48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 29 00 00 00 =
0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 29 71 0c 00 f7 d8 64 89 01 48
> > All code
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >    0: 73 01                   jae    0x3
> >    2: c3                      ret
> >    3: 48 8b 0d 59 71 0c 00    mov    0xc7159(%rip),%rcx        # 0xc716=
3
> >    a: f7 d8                   neg    %eax
> >    c: 64 89 01                mov    %eax,%fs:(%rcx)
> >    f: 48 83 c8 ff             or     $0xffffffffffffffff,%rax
> >   13: c3                      ret
> >   14: 66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
> >   1b: 00 00 00
> >   1e: 0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
> >   23: b8 29 00 00 00          mov    $0x29,%eax
> >   28: 0f 05                   syscall
> >   2a:*        48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax  =
       <-- trapping instruction
> >   30: 73 01                   jae    0x33
> >   32: c3                      ret
> >   33: 48 8b 0d 29 71 0c 00    mov    0xc7129(%rip),%rcx        # 0xc716=
3
> >   3a: f7 d8                   neg    %eax
> >   3c: 64 89 01                mov    %eax,%fs:(%rcx)
> >   3f: 48                      rex.W
> >
> > Code starting with the faulting instruction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >    0: 48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax
> >    6: 73 01                   jae    0x9
> >    8: c3                      ret
> >    9: 48 8b 0d 29 71 0c 00    mov    0xc7129(%rip),%rcx        # 0xc713=
9
> >   10: f7 d8                   neg    %eax
> >   12: 64 89 01                mov    %eax,%fs:(%rcx)
> >   15: 48                      rex.W
> > [   78.329366][  T299] RSP: 002b:00007ffd57e63db8 EFLAGS: 00000246 ORIG=
_RAX: 0000000000000029
> > [   78.329366][  T299] RAX: ffffffffffffffda RBX: 0000000000000001 RCX:=
 00007f4022818ca7
> > [   78.329366][  T299] RDX: 0000000000000001 RSI: 0000000000000002 RDI:=
 0000000000000002
> > [   78.329366][  T299] RBP: 0000000000000002 R08: 0000000000000000 R09:=
 0000564be3dc8ec0
> > [   78.329366][  T299] R10: 0c41e8ba3f6107df R11: 0000000000000246 R12:=
 0000564bbab801e0
> > [   78.329366][  T299] R13: 0000000000000000 R14: 0000564bbab7db18 R15:=
 00007f4022934020
> > [   78.329366][  T299]  </TASK>
> > [   78.329366][  T299]
> > [   78.329366][  T299] Allocated by task 299 on cpu 2 at 78.328492s:
> > [ 78.329366][ T299] kasan_save_stack (mm/kasan/common.c:48)
> > [ 78.329366][ T299] kasan_save_track (mm/kasan/common.c:68)
> > [ 78.329366][ T299] __kasan_slab_alloc (mm/kasan/common.c:312 mm/kasan/=
common.c:338)
> > [ 78.329366][ T299] kmem_cache_alloc_noprof (mm/slub.c:3941 mm/slub.c:4=
000 mm/slub.c:4007)
> > [ 78.329366][ T299] sk_prot_alloc (net/core/sock.c:2075)
> > [ 78.329366][ T299] sk_alloc (net/core/sock.c:2134)
> > [ 78.329366][ T299] inet_create (net/ipv4/af_inet.c:327 net/ipv4/af_ine=
t.c:252)
> > [ 78.329366][ T299] __sock_create (net/socket.c:1572)
> > [ 78.329366][ T299] __sys_socket (net/socket.c:1660 net/socket.c:1644 n=
et/socket.c:1706)
> > [ 78.329366][ T299] __x64_sys_socket (net/socket.c:1718)
> > [ 78.329366][ T299] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/=
entry/common.c:83)
> > [ 78.329366][ T299] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entr=
y_64.S:130)
> > [   78.329366][  T299]
> > [   78.329366][  T299] Freed by task 299 on cpu 2 at 78.328502s:
> > [ 78.329366][ T299] kasan_save_stack (mm/kasan/common.c:48)
> > [ 78.329366][ T299] kasan_save_track (mm/kasan/common.c:68)
> > [ 78.329366][ T299] kasan_save_free_info (mm/kasan/generic.c:582)
> > [ 78.329366][ T299] poison_slab_object (mm/kasan/common.c:242)
> > [ 78.329366][ T299] __kasan_slab_free (mm/kasan/common.c:256)
> > [ 78.329366][ T299] kmem_cache_free (mm/slub.c:4437 mm/slub.c:4511)
> > [ 78.329366][ T299] __sk_destruct (net/core/sock.c:2117 net/core/sock.c=
:2208)
> > [ 78.329366][ T299] inet_create (net/ipv4/af_inet.c:397 net/ipv4/af_ine=
t.c:252)
> > [ 78.329366][ T299] __sock_create (net/socket.c:1572)
> > [ 78.329366][ T299] __sys_socket (net/socket.c:1660 net/socket.c:1644 n=
et/socket.c:1706)
> > [ 78.329366][ T299] __x64_sys_socket (net/socket.c:1718)
> > [ 78.329366][ T299] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/=
entry/common.c:83)
> > [ 78.329366][ T299] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entr=
y_64.S:130)
> > [   78.329366][  T299]
> > [   78.329366][  T299] The buggy address belongs to the object at ffff8=
88007110d80
> > [   78.329366][  T299]  which belongs to the cache PING of size 976
> > [   78.329366][  T299] The buggy address is located 88 bytes inside of
> > [   78.329366][  T299]  freed 976-byte region [ffff888007110d80, ffff88=
8007111150)
> > [   78.329366][  T299]
> > [   78.329366][  T299] The buggy address belongs to the physical page:
> > [   78.329366][  T299] page: refcount:1 mapcount:0 mapping:000000000000=
0000 index:0x0 pfn:0x7110
> > [   78.329366][  T299] head: order:3 mapcount:0 entire_mapcount:0 nr_pa=
ges_mapped:0 pincount:0
> > [   78.329366][  T299] flags: 0x1ffff800000040(head|node=3D0|zone=3D1|l=
astcpupid=3D0x1ffff)
> > [   78.329366][  T299] page_type: 0xffffefff(slab)
> > [   78.329366][  T299] raw: 001ffff800000040 ffff888002f328c0 dead00000=
0000122 0000000000000000
> > [   78.329366][  T299] raw: 0000000000000000 00000000801c001c 00000001f=
fffefff 0000000000000000
> > [   78.329366][  T299] head: 001ffff800000040 ffff888002f328c0 dead0000=
00000122 0000000000000000
> > [   78.329366][  T299] head: 0000000000000000 00000000801c001c 00000001=
ffffefff 0000000000000000
> > [   78.329366][  T299] head: 001ffff800000003 ffffea00001c4401 ffffffff=
ffffffff 0000000000000000
> > [   78.329366][  T299] head: 0000000000000008 0000000000000000 00000000=
ffffffff 0000000000000000
> > [   78.329366][  T299] page dumped because: kasan: bad access detected
> > [   78.329366][  T299]
> > [   78.329366][  T299] Memory state around the buggy address:
> > [   78.329366][  T299]  ffff888007110c80: fc fc fc fc fc fc fc fc fc fc=
 fc fc fc fc fc fc
> > [   78.329366][  T299]  ffff888007110d00: fc fc fc fc fc fc fc fc fc fc=
 fc fc fc fc fc fc
> > [   78.329366][  T299] >ffff888007110d80: fa fb fb fb fb fb fb fb fb fb=
 fb fb fb fb fb fb
> > [   78.329366][  T299]                                                 =
    ^
> > [   78.329366][  T299]  ffff888007110e00: fb fb fb fb fb fb fb fb fb fb=
 fb fb fb fb fb fb
> > [   78.329366][  T299]  ffff888007110e80: fb fb fb fb fb fb fb fb fb fb=
 fb fb fb fb fb fb
> > [   78.329366][  T299] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [   78.366431][  T299] Disabling lock debugging due to kernel taint
> >
> > Fix this by ensuring the error path of inet_create()/inet6_create do no=
t leave
> > a dangling sk pointer after sk was released.
> >
> > Fixes: 086c653f5862 ("sock: struct proto hash function may error")
>
> I think this tag is wrong as bpf_get_socket_cookie() does not exist at
> that time.

OK - will probably replace the tag with the commit that added it.

>
> > Fixes: 610236587600 ("bpf: Add new cgroup attach type to enable sock mo=
difications")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> > ---
> >  net/ipv4/af_inet.c  | 3 +++
> >  net/ipv6/af_inet6.c | 3 +++
> >  2 files changed, 6 insertions(+)
> >
> > diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> > index b24d74616637..db53701db29e 100644
> > --- a/net/ipv4/af_inet.c
> > +++ b/net/ipv4/af_inet.c
> > @@ -378,6 +378,7 @@ static int inet_create(struct net *net, struct sock=
et *sock, int protocol,
> >               err =3D sk->sk_prot->hash(sk);
> >               if (err) {
> >                       sk_common_release(sk);
> > +                     sock->sk =3D NULL;
> >                       goto out;
> >               }
> >       }
>
> You can add a new label and call sk_common_release() and set
> NULL to sock->sk there, then reuse it for other two places.
>
> Same for IPv6.

OK

> And curious if bpf_get_socket_cookie() can be called any socket
> family to trigger the splat.  e.g. ieee802154_create() seems to
> have the same bug.

Just judging from the code - yes, indeed.

> If so, how about clearing sock->sk in sk_common_release() ?

This was my first thought, but I was a bit put off by the fact that
sk_common_release() is called from many places and the sk object
itself is reference counted. So not every call to sk_common_release()
seems to actually free the sk object. Secondly, I was put off by this
comment (which I don't fully understand TBH) [1]

On the other hand - in inet/inet6_create() we definitely know that the
object would be freed, because we just created that.

But if someone more familiar with the code confirms it is
better/possible to do in sk_common_release(), I'm happy to adjust and
it would be cleaner indeed.

> ---8<---
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 8629f9aecf91..bbc94954d9bf 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -3754,6 +3754,9 @@ void sk_common_release(struct sock *sk)
>          * until the last reference will be released.
>          */
>
> +       if (sk->sk_socket)
> +               sk->sk_socket->sk =3D NULL;
> +
>         sock_orphan(sk);
>
>         xfrm_sk_free_policy(sk);
> ---8<---

[1]: https://elixir.bootlin.com/linux/v6.10-rc3/source/include/net/sock.h#L=
1985

