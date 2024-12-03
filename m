Return-Path: <netdev+bounces-148509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3999E2183
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 16:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02FC5B27373
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86821F426C;
	Tue,  3 Dec 2024 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lZ4uzgZ2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1DD1CF8B
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 14:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733235366; cv=none; b=NxFkFM4Efm7kpoEF0KaAX+FX04Dmhl+n6tqIpc1+PWeVYVC0CLQLBcO8RQkYVabDylCDtvwKmKICAYy4dENPco708E8eMoXmMW1epmwxda87ujUE5vXAz++xx2H9rzZ/fLDBef0fXbuuD8U4oxx6ggK0raLO4rXlUST6a/Dw8G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733235366; c=relaxed/simple;
	bh=+yJCF0wyBw3HlAHPkhcCF4Ss9yRTPCuaqziIxxcsV+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GpEpx8Gwb2yQvr8Xxd1driXVOrIBfmuLFbT8H79IjpSLG/8khfCh7gVnfPIfPPfA6WQFzRD30kllZBdfhbkU837B0cwNLgcIVz5ucmkuq0nuTmSzkCnmhzLKGMmhuiaGHHeADK3Ln4Y2EBg2S4FteloMCClgaBr7ZfifbEsUkcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lZ4uzgZ2; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53de579f775so7845471e87.2
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 06:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733235362; x=1733840162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z0qoKZE2Bwcy7qFFntgyWv9zh0XMllmzCd4RzUqkauc=;
        b=lZ4uzgZ2Af+Kd32KEFwONs9023Nbcf2eHhvpneX+UoJVTuxZd0/JIgRmxBAks9lfo/
         ukQ9+p0ZHop6A37bn/SdnLSY0/iJ7gj74byDgmVtwIxdOqzzu3dYODHsNrF+i1WT/QgQ
         4ZAaANmd7vJ9e2QxM478kErIPihuTmkqyybeKsnNQFJSD5eMb1OICvavWBb2+zYj4aUk
         LiyHWk/kTvmeI1fu0N7GuWbZl1eEmxbK+vL3dlelX/FsGp7ei4/h8Wmyk+eBqoAdGxHx
         yi+liE4rOIR+sRb5OcfUNnkgtjR0FjaUGYkuEI5zrnyeN/Birom1+ycdEhc9Ikjx/BSQ
         uIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733235362; x=1733840162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z0qoKZE2Bwcy7qFFntgyWv9zh0XMllmzCd4RzUqkauc=;
        b=gPoSNbHe7kUK1mJUP+eV8+dEcxnBacvvgdDbX5YqLXKaRbzZGFvBQGpsuiKmw7dFY6
         Zri0yv2eP+M7xbHDUtHGqKvcPp1EnhTzi+zG8R7fJ3U7QqMcku6wHU2kmsaUg3OwOnzi
         Sbz9Yh6gyLTVPwIhxkpJ6dfGxiYHtkDpHiEDYyS5vuxvFIBKaH/6LzpjV28jkJntx4UF
         8lcNIQVJgPzTbGvRiwF6uuTB0xkOgwuPf/m3LrM/gSLtYAYbMlLhugpAbK9W+IoqnSb1
         7Mbv7iySfAIlVq+W3tfoKzkmVyNBGZ4dney0ZFVcDfTkxotAlnBWjLlonVzizGsX5PxF
         vB5A==
X-Gm-Message-State: AOJu0Yz2szm3HMqrzVDUDBD5mykAcd/GDCIW/ej51yx0f5IUAVmsjBml
	HDH7Ml0t9kgLituV1xX+KkZ4iRO+/eTSYLGCFbGdZ0I+fbrZT6nMYY6A4ec885PWV3Uo+PmIFgj
	kR3gve7/5rx48MZFcjE/iK3t4TCaQUnyYgRYR
X-Gm-Gg: ASbGncscOdXWhcEtOtNYRPK6GFJTyO8MV/ETL9xg10gQhjuPpe4Bf6ByWX/Tjc38db7
	wqU5FKTyk53WhwFzpfUGq9OFA5bTa+bp3
X-Google-Smtp-Source: AGHT+IGANknd8dHPgqzgOTMXTFTBckkEyP67YSQ219Kr4lfDzdZFNieOW/+YOzM1m4QuX7IFHZehkNMl1Vtt3jZjR30=
X-Received: by 2002:a05:6512:3993:b0:53d:f09e:9a1d with SMTP id
 2adb3069b0e04-53e12a06c96mr2201970e87.31.1733235361841; Tue, 03 Dec 2024
 06:16:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d1a7dea8-ce20-4c6f-beed-8a28b07e9468@ovn.org> <672d143c-7ccd-4b77-a843-24d0d60ada14@ovn.org>
 <CANn89i+FPHAz=O-KfUV5nv8KNVPgpx+PX+2xzm0EwTJs8UqqMg@mail.gmail.com>
In-Reply-To: <CANn89i+FPHAz=O-KfUV5nv8KNVPgpx+PX+2xzm0EwTJs8UqqMg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 3 Dec 2024 15:15:50 +0100
Message-ID: <CANn89iKKYDVpB=MtmfH7nyv2p=rJWSLedO5k7wSZgtY_tO8WQg@mail.gmail.com>
Subject: Re: [v6.12] BUG: KASAN: slab-use-after-free in dst_destroy+0x2e2/0x340
To: Ilya Maximets <i.maximets@ovn.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 2:23=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Tue, Dec 3, 2024 at 1:15=E2=80=AFPM Ilya Maximets <i.maximets@ovn.org>=
 wrote:
> >
> > On 12/3/24 12:58, Ilya Maximets wrote:
> > > Hello there.  I was running some tests with openvswitch+ipsec on v6.1=
2 tag
> > > and got the KASAN UAF splat provided below.  It doesn't seem to be re=
lated
> > > to anything specific to openvswitch module, more like core parts of n=
etworking.
> > > At lest, at the first glance.
> > >
> > > For the context, what I'm running is an OVS system test that creates =
20 network
> > > namespaces, starts OVS and Libreswan in each of them, creates a full =
mesh of
> > > Geneve tunnels with IPsec (a separate tunnel between each pair of nam=
espaces),
> > > then checks that pings work through all the tunnels and then deletes =
all the
> > > ports, OVS datapath and namespaces.  While removing namespaces, I see=
 the
> > > following KASAN report in the logs:
> > >
> >
> > The decoded trace:
> >
> > Dec 03 05:46:17 kernel: genev_sys_6081 (unregistering): left promiscuou=
s mode
> > Dec 03 05:46:17 kernel: br-ipsec: left promiscuous mode
> > Dec 03 05:46:17 kernel: ovs-system: left promiscuous mode
> > Dec 03 05:46:18 kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > Dec 03 05:46:18 kernel: BUG: KASAN: slab-use-after-free in dst_destroy =
(net/core/dst.c:112)
> > Dec 03 05:46:18 kernel: Read of size 8 at addr ffff8882137ccab0 by task=
 swapper/37/0
> > Dec 03 05:46:18 kernel:
> > Dec 03 05:46:18 kernel: CPU: 37 UID: 0 PID: 0 Comm: swapper/37 Kdump: l=
oaded Not tainted 6.12.0 #67
> > Dec 03 05:46:18 kernel: Hardware name: Red Hat KVM/RHEL, BIOS 1.16.1-1.=
el9 04/01/2014
> > Dec 03 05:46:18 kernel: Call Trace:
> > Dec 03 05:46:18 kernel:  <IRQ>
> > Dec 03 05:46:18 kernel: dump_stack_lvl (lib/dump_stack.c:124)
> > Dec 03 05:46:18 kernel: print_address_description.constprop.0 (mm/kasan=
/report.c:378)
> > Dec 03 05:46:18 kernel: ? dst_destroy (net/core/dst.c:112)
> > Dec 03 05:46:18 kernel: print_report (mm/kasan/report.c:489)
> > Dec 03 05:46:18 kernel: ? dst_destroy (net/core/dst.c:112)
> > Dec 03 05:46:18 kernel: ? kasan_addr_to_slab (mm/kasan/common.c:37)
> > Dec 03 05:46:18 kernel: kasan_report (mm/kasan/report.c:603)
> > Dec 03 05:46:18 kernel: ? dst_destroy (net/core/dst.c:112)
> > Dec 03 05:46:18 kernel: ? rcu_do_batch (kernel/rcu/tree.c:2567)
> > Dec 03 05:46:18 kernel: dst_destroy (net/core/dst.c:112)
> > Dec 03 05:46:18 kernel: rcu_do_batch (kernel/rcu/tree.c:2567)
> > Dec 03 05:46:18 kernel: ? __pfx_rcu_do_batch (kernel/rcu/tree.c:2491)
> > Dec 03 05:46:18 kernel: ? lockdep_hardirqs_on_prepare (kernel/locking/l=
ockdep.c:4339 kernel/locking/lockdep.c:4406)
> > Dec 03 05:46:18 kernel: rcu_core (kernel/rcu/tree.c:2825)
> > Dec 03 05:46:18 kernel: handle_softirqs (kernel/softirq.c:554)
> > Dec 03 05:46:18 kernel: __irq_exit_rcu (kernel/softirq.c:589 kernel/sof=
tirq.c:428 kernel/softirq.c:637)
> > Dec 03 05:46:18 kernel: irq_exit_rcu (kernel/softirq.c:651)
> > Dec 03 05:46:18 kernel: sysvec_apic_timer_interrupt (arch/x86/kernel/ap=
ic/apic.c:1049 arch/x86/kernel/apic/apic.c:1049)
> > Dec 03 05:46:18 kernel:  </IRQ>
> > Dec 03 05:46:18 kernel:  <TASK>
> > Dec 03 05:46:18 kernel: asm_sysvec_apic_timer_interrupt (./arch/x86/inc=
lude/asm/idtentry.h:702)
> > Dec 03 05:46:18 kernel: RIP: 0010:default_idle (./arch/x86/include/asm/=
irqflags.h:37 ./arch/x86/include/asm/irqflags.h:92 arch/x86/kernel/process.=
c:743)
> > Dec 03 05:46:18 kernel: Code: 00 4d 29 c8 4c 01 c7 4c 29 c2 e9 6e ff ff=
 ff 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 90 0f 00 2d c7 c9 27=
 00 fb f4 <fa> c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 =
90
> > All code
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >    0:   00 4d 29                add    %cl,0x29(%rbp)
> >    3:   c8 4c 01 c7             enterq $0x14c,$0xc7
> >    7:   4c 29 c2                sub    %r8,%rdx
> >    a:   e9 6e ff ff ff          jmpq   0xffffffffffffff7d
> >    f:   90                      nop
> >   10:   90                      nop
> >   11:   90                      nop
> >   12:   90                      nop
> >   13:   90                      nop
> >   14:   90                      nop
> >   15:   90                      nop
> >   16:   90                      nop
> >   17:   90                      nop
> >   18:   90                      nop
> >   19:   90                      nop
> >   1a:   90                      nop
> >   1b:   90                      nop
> >   1c:   90                      nop
> >   1d:   90                      nop
> >   1e:   90                      nop
> >   1f:   66 90                   xchg   %ax,%ax
> >   21:   0f 00 2d c7 c9 27 00    verw   0x27c9c7(%rip)        # 0x27c9ef
> >   28:   fb                      sti
> >   29:   f4                      hlt
> >   2a:*  fa                      cli             <-- trapping instructio=
n
> >   2b:   c3                      retq
> >   2c:   cc                      int3
> >   2d:   cc                      int3
> >   2e:   cc                      int3
> >   2f:   cc                      int3
> >   30:   66 66 2e 0f 1f 84 00    data16 nopw %cs:0x0(%rax,%rax,1)
> >   37:   00 00 00 00
> >   3b:   0f 1f 40 00             nopl   0x0(%rax)
> >   3f:   90                      nop
> >
> > Code starting with the faulting instruction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >    0:   fa                      cli
> >    1:   c3                      retq
> >    2:   cc                      int3
> >    3:   cc                      int3
> >    4:   cc                      int3
> >    5:   cc                      int3
> >    6:   66 66 2e 0f 1f 84 00    data16 nopw %cs:0x0(%rax,%rax,1)
> >    d:   00 00 00 00
> >   11:   0f 1f 40 00             nopl   0x0(%rax)
> >   15:   90                      nop
> > Dec 03 05:46:18 kernel: RSP: 0018:ffff888100d2fe00 EFLAGS: 00000246
> > Dec 03 05:46:18 kernel: RAX: 00000000001870ed RBX: 1ffff110201a5fc2 RCX=
: ffffffffb61a3e46
> > Dec 03 05:46:18 kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI=
: ffffffffb3d4d123
> > Dec 03 05:46:18 kernel: RBP: 0000000000000000 R08: 0000000000000001 R09=
: ffffed11c7e1835d
> > Dec 03 05:46:18 kernel: R10: ffff888e3f0c1aeb R11: 0000000000000000 R12=
: 0000000000000000
> > Dec 03 05:46:18 kernel: R13: ffff888100d20000 R14: dffffc0000000000 R15=
: 0000000000000000
> > Dec 03 05:46:18 kernel: ? ct_kernel_exit.constprop.0 (kernel/context_tr=
acking.c:148)
> > Dec 03 05:46:18 kernel: ? cpuidle_idle_call (kernel/sched/idle.c:186)
> > Dec 03 05:46:18 kernel: default_idle_call (./include/linux/cpuidle.h:14=
3 kernel/sched/idle.c:118)
> > Dec 03 05:46:18 kernel: cpuidle_idle_call (kernel/sched/idle.c:186)
> > Dec 03 05:46:18 kernel: ? __pfx_cpuidle_idle_call (kernel/sched/idle.c:=
168)
> > Dec 03 05:46:18 kernel: ? lock_release (kernel/locking/lockdep.c:467 ke=
rnel/locking/lockdep.c:5848)
> > Dec 03 05:46:18 kernel: ? lockdep_hardirqs_on_prepare (kernel/locking/l=
ockdep.c:4347 kernel/locking/lockdep.c:4406)
> > Dec 03 05:46:18 kernel: ? tsc_verify_tsc_adjust (arch/x86/kernel/tsc_sy=
nc.c:59)
> > Dec 03 05:46:18 kernel: do_idle (kernel/sched/idle.c:326)
> > Dec 03 05:46:18 kernel: cpu_startup_entry (kernel/sched/idle.c:423 (dis=
criminator 1))
> > Dec 03 05:46:18 kernel: start_secondary (arch/x86/kernel/smpboot.c:202 =
arch/x86/kernel/smpboot.c:282)
> > Dec 03 05:46:18 kernel: ? __pfx_start_secondary (arch/x86/kernel/smpboo=
t.c:232)
> > Dec 03 05:46:18 kernel: ? soft_restart_cpu (arch/x86/kernel/head_64.S:4=
52)
> > Dec 03 05:46:18 kernel: common_startup_64 (arch/x86/kernel/head_64.S:41=
4)
> > Dec 03 05:46:18 kernel:  </TASK>
> > Dec 03 05:46:18 kernel:
> > Dec 03 05:46:18 kernel: Allocated by task 12184:
> > Dec 03 05:46:18 kernel: kasan_save_stack (mm/kasan/common.c:48)
> > Dec 03 05:46:18 kernel: kasan_save_track (./arch/x86/include/asm/curren=
t.h:49 mm/kasan/common.c:60 mm/kasan/common.c:69)
> > Dec 03 05:46:18 kernel: __kasan_slab_alloc (mm/kasan/common.c:319 mm/ka=
san/common.c:345)
> > Dec 03 05:46:18 kernel: kmem_cache_alloc_noprof (mm/slub.c:4085 mm/slub=
.c:4134 mm/slub.c:4141)
> > Dec 03 05:46:18 kernel: copy_net_ns (net/core/net_namespace.c:421 net/c=
ore/net_namespace.c:480)
> > Dec 03 05:46:18 kernel: create_new_namespaces (kernel/nsproxy.c:110)
> > Dec 03 05:46:18 kernel: unshare_nsproxy_namespaces (kernel/nsproxy.c:22=
8 (discriminator 4))
> > Dec 03 05:46:18 kernel: ksys_unshare (kernel/fork.c:3313)
> > Dec 03 05:46:18 kernel: __x64_sys_unshare (kernel/fork.c:3382)
> > Dec 03 05:46:18 kernel: do_syscall_64 (arch/x86/entry/common.c:52 arch/=
x86/entry/common.c:83)
> > Dec 03 05:46:18 kernel: entry_SYSCALL_64_after_hwframe (arch/x86/entry/=
entry_64.S:130)
> > Dec 03 05:46:18 kernel:
> > Dec 03 05:46:18 kernel: Freed by task 11:
> > Dec 03 05:46:18 kernel: kasan_save_stack (mm/kasan/common.c:48)
> > Dec 03 05:46:18 kernel: kasan_save_track (./arch/x86/include/asm/curren=
t.h:49 mm/kasan/common.c:60 mm/kasan/common.c:69)
> > Dec 03 05:46:18 kernel: kasan_save_free_info (mm/kasan/generic.c:582)
> > Dec 03 05:46:18 kernel: __kasan_slab_free (mm/kasan/common.c:271)
> > Dec 03 05:46:18 kernel: kmem_cache_free (mm/slub.c:4579 mm/slub.c:4681)
> > Dec 03 05:46:18 kernel: cleanup_net (net/core/net_namespace.c:456 net/c=
ore/net_namespace.c:446 net/core/net_namespace.c:647)
> > Dec 03 05:46:18 kernel: process_one_work (kernel/workqueue.c:3229)
> > Dec 03 05:46:18 kernel: worker_thread (kernel/workqueue.c:3304 kernel/w=
orkqueue.c:3391)
> > Dec 03 05:46:18 kernel: kthread (kernel/kthread.c:389)
> > Dec 03 05:46:18 kernel: ret_from_fork (arch/x86/kernel/process.c:147)
> > Dec 03 05:46:18 kernel: ret_from_fork_asm (arch/x86/entry/entry_64.S:25=
7)
> > Dec 03 05:46:18 kernel:
> > Dec 03 05:46:18 kernel: Last potentially related work creation:
> > Dec 03 05:46:18 kernel: kasan_save_stack (mm/kasan/common.c:48)
> > Dec 03 05:46:18 kernel: __kasan_record_aux_stack (mm/kasan/generic.c:54=
1)
> > Dec 03 05:46:18 kernel: insert_work (./include/linux/instrumented.h:68 =
./include/asm-generic/bitops/instrumented-non-atomic.h:141 kernel/workqueue=
.c:788 kernel/workqueue.c:795 kernel/workqueue.c:2186)
> > Dec 03 05:46:18 kernel: __queue_work (kernel/workqueue.c:2340)
> > Dec 03 05:46:18 kernel: queue_work_on (kernel/workqueue.c:2391)
> > Dec 03 05:46:18 kernel: xfrm_policy_insert (net/xfrm/xfrm_policy.c:1610=
)
> > Dec 03 05:46:18 kernel: xfrm_add_policy (net/xfrm/xfrm_user.c:2116)
> > Dec 03 05:46:18 kernel: xfrm_user_rcv_msg (net/xfrm/xfrm_user.c:3321)
> > Dec 03 05:46:18 kernel: netlink_rcv_skb (net/netlink/af_netlink.c:2536)
> > Dec 03 05:46:18 kernel: xfrm_netlink_rcv (net/xfrm/xfrm_user.c:3344)
> > Dec 03 05:46:18 kernel: netlink_unicast (net/netlink/af_netlink.c:1316 =
net/netlink/af_netlink.c:1342)
> > Dec 03 05:46:18 kernel: netlink_sendmsg (net/netlink/af_netlink.c:1886)
> > Dec 03 05:46:18 kernel: sock_write_iter (net/socket.c:729 net/socket.c:=
744 net/socket.c:1165)
> > Dec 03 05:46:18 kernel: vfs_write (fs/read_write.c:590 fs/read_write.c:=
683)
> > Dec 03 05:46:18 kernel: ksys_write (fs/read_write.c:736)
> > Dec 03 05:46:18 kernel: do_syscall_64 (arch/x86/entry/common.c:52 arch/=
x86/entry/common.c:83)
> > Dec 03 05:46:18 kernel: entry_SYSCALL_64_after_hwframe (arch/x86/entry/=
entry_64.S:130)
> > Dec 03 05:46:18 kernel:
> > Dec 03 05:46:18 kernel: Second to last potentially related work creatio=
n:
> > Dec 03 05:46:18 kernel: kasan_save_stack (mm/kasan/common.c:48)
> > Dec 03 05:46:18 kernel: __kasan_record_aux_stack (mm/kasan/generic.c:54=
1)
> > Dec 03 05:46:18 kernel: insert_work (./include/linux/instrumented.h:68 =
./include/asm-generic/bitops/instrumented-non-atomic.h:141 kernel/workqueue=
.c:788 kernel/workqueue.c:795 kernel/workqueue.c:2186)
> > Dec 03 05:46:18 kernel: __queue_work (kernel/workqueue.c:2340)
> > Dec 03 05:46:18 kernel: queue_work_on (kernel/workqueue.c:2391)
> > Dec 03 05:46:18 kernel: __xfrm_state_insert (./include/linux/workqueue.=
h:723 net/xfrm/xfrm_state.c:1150 net/xfrm/xfrm_state.c:1145 net/xfrm/xfrm_s=
tate.c:1513)
> > Dec 03 05:46:18 kernel: xfrm_state_update (./include/linux/spinlock.h:3=
96 net/xfrm/xfrm_state.c:1940)
> > Dec 03 05:46:18 kernel: xfrm_add_sa (net/xfrm/xfrm_user.c:912)
> > Dec 03 05:46:18 kernel: xfrm_user_rcv_msg (net/xfrm/xfrm_user.c:3321)
> > Dec 03 05:46:18 kernel: netlink_rcv_skb (net/netlink/af_netlink.c:2536)
> > Dec 03 05:46:18 kernel: xfrm_netlink_rcv (net/xfrm/xfrm_user.c:3344)
> > Dec 03 05:46:18 kernel: netlink_unicast (net/netlink/af_netlink.c:1316 =
net/netlink/af_netlink.c:1342)
> > Dec 03 05:46:18 kernel: netlink_sendmsg (net/netlink/af_netlink.c:1886)
> > Dec 03 05:46:18 kernel: sock_write_iter (net/socket.c:729 net/socket.c:=
744 net/socket.c:1165)
> > Dec 03 05:46:18 kernel: vfs_write (fs/read_write.c:590 fs/read_write.c:=
683)
> > Dec 03 05:46:18 kernel: ksys_write (fs/read_write.c:736)
> > Dec 03 05:46:18 kernel: do_syscall_64 (arch/x86/entry/common.c:52 arch/=
x86/entry/common.c:83)
> > Dec 03 05:46:18 kernel: entry_SYSCALL_64_after_hwframe (arch/x86/entry/=
entry_64.S:130)
> > Dec 03 05:46:18 kernel:
> > Dec 03 05:46:18 kernel: The buggy address belongs to the object at ffff=
8882137cb680
> > which belongs to the cache net_namespace of size 6720
> > Dec 03 05:46:18 kernel: The buggy address is located 5168 bytes inside =
of
> > freed 6720-byte region [ffff8882137cb680, ffff8882137cd0c0)
> > Dec 03 05:46:18 kernel:
> > Dec 03 05:46:18 kernel: The buggy address belongs to the physical page:
> > Dec 03 05:46:18 kernel: page: refcount:1 mapcount:0 mapping:00000000000=
00000 index:0x0 pfn:0x2137c8
> > Dec 03 05:46:18 kernel: head: order:3 mapcount:0 entire_mapcount:0 nr_p=
ages_mapped:0 pincount:0
> > Dec 03 05:46:18 kernel: memcg:ffff88812794d901
> > Dec 03 05:46:18 kernel: flags: 0x17ffffc0000040(head|node=3D0|zone=3D2|=
lastcpupid=3D0x1fffff)
> > Dec 03 05:46:18 kernel: page_type: f5(slab)
> > Dec 03 05:46:18 kernel: raw: 0017ffffc0000040 ffff888100053980 dead0000=
00000122 0000000000000000
> > Dec 03 05:46:18 kernel: raw: 0000000000000000 0000000080040004 00000001=
f5000000 ffff88812794d901
> > Dec 03 05:46:18 kernel: head: 0017ffffc0000040 ffff888100053980 dead000=
000000122 0000000000000000
> > Dec 03 05:46:18 kernel: head: 0000000000000000 0000000080040004 0000000=
1f5000000 ffff88812794d901
> > Dec 03 05:46:18 kernel: head: 0017ffffc0000003 ffffea00084df201 fffffff=
fffffffff 0000000000000000
> > Dec 03 05:46:18 kernel: head: 0000000000000008 0000000000000000 0000000=
0ffffffff 0000000000000000
> > Dec 03 05:46:18 kernel: page dumped because: kasan: bad access detected
> > Dec 03 05:46:18 kernel:
> > Dec 03 05:46:18 kernel: Memory state around the buggy address:
> > Dec 03 05:46:18 kernel:  ffff8882137cc980: fb fb fb fb fb fb fb fb fb f=
b fb fb fb fb fb fb
> > Dec 03 05:46:18 kernel:  ffff8882137cca00: fb fb fb fb fb fb fb fb fb f=
b fb fb fb fb fb fb
> > Dec 03 05:46:18 kernel: >ffff8882137cca80: fb fb fb fb fb fb fb fb fb f=
b fb fb fb fb fb fb
> > Dec 03 05:46:18 kernel:                                      ^
> > Dec 03 05:46:18 kernel:  ffff8882137ccb00: fb fb fb fb fb fb fb fb fb f=
b fb fb fb fb fb fb
> > Dec 03 05:46:18 kernel:  ffff8882137ccb80: fb fb fb fb fb fb fb fb fb f=
b fb fb fb fb fb fb
> > Dec 03 05:46:18 kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >
> > Best regards, Ilya Maximets.
>
> Issue is in xfrm6_net_init() and xfrm4_net_init() :
> They copies xfrm6_dst_ops_template into net->xfrm.xfrm6_dst_ops, (or
> xfrm4_dst_ops_template to net->xfrm.xfrm4_dst_ops)
>
> But net structure is freed before all the dst callbacks are called.
>
>
> So when dst_destroy() calls later :
>
> if (dst->ops->destroy)
>     dst->ops->destroy(dst);
>
> dst->ops point to the old net->xfrm.xfrm6_dst_ops, which has been freed.
>
> See for a similar issue fixed in , and that I warned XFRM maintainers
> at that time:
>
> ac888d58869b net: do not delay dst_entries_add() in dst_release()
>
> A solution could be to queue the 'struct net' to be freed after one
> another cleanup_net() round (and existing rcu barrier)
>
> net_free() would need to not directly call kmem_cache_free(net_cachep, ne=
t).
>
> I can cook a patch, thanks for the report.

I will test something like :

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 873c0f9fdac66397152dcc66dfffe02c82661b21..fcf5195bafa8d308dbd759b8554=
33166c787fb21
100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -80,6 +80,7 @@ struct net {
                                                 * or to unregister pernet =
ops
                                                 * (pernet_ops_rwsem
write locked).
                                                 */
+       struct llist_node       defer_free_list;
        struct llist_node       cleanup_list;   /* namespaces on death row =
*/

 #ifdef CONFIG_KEYS
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index ae34ac818cda76493abe2f45a1f6f87ac8398934..825281e08cb46b2fc665dce2b55=
8085710e5695c
100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -449,6 +449,21 @@ static struct net *net_alloc(void)
        goto out;
 }

+static LLIST_HEAD(defer_free_list);
+
+static void net_complete_free(void)
+{
+       struct llist_node *kill_list;
+       struct net *net;
+
+       /* Get the list of namespaces to free from last round. */
+       kill_list =3D llist_del_all(&defer_free_list);
+
+       llist_for_each_entry(net, kill_list, defer_free_list)
+               kmem_cache_free(net_cachep, net);
+
+}
+
 static void net_free(struct net *net)
 {
        if (refcount_dec_and_test(&net->passive)) {
@@ -457,7 +472,8 @@ static void net_free(struct net *net)
                /* There should not be any trackers left there. */
                ref_tracker_dir_exit(&net->notrefcnt_tracker);

-               kmem_cache_free(net_cachep, net);
+               /* Wait for an extra rcu_barrier() before final free. */
+               llist_add(&net->defer_free_list, &defer_free_list);
        }
 }

@@ -642,6 +658,8 @@ static void cleanup_net(struct work_struct *work)
         */
        rcu_barrier();

+       net_complete_free();
+
        /* Finally it is safe to free my network namespace structure */
        list_for_each_entry_safe(net, tmp, &net_exit_list, exit_list) {
                list_del_init(&net->exit_list);

