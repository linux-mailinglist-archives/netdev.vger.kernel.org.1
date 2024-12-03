Return-Path: <netdev+bounces-148498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08CD9E1D76
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 918CF281198
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 13:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073151E5721;
	Tue,  3 Dec 2024 13:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B9yNAsPn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D0F1EE00D
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 13:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733232204; cv=none; b=XUs4gME5EELUWxiZfxfhNjI4+kT5rjKhdEub/ZHxeZ61GVpwgC3bNyKX8v7GTGFJjKL7YaITrg00PyoCJt/OmCr2Ruamva6IQ3AhhszrgQHOBC0L1f6viz+mRtF0h/yz/TXHRUynO3GgXVkZGflIrxm3T0v6+lR9GQgeWCmAfXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733232204; c=relaxed/simple;
	bh=Nr+dM1lnx6dA95NrBDJySoAkIYZQBZZep833WRZWNcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dN+owGZtqcGUK61f5aagMgv9JJtY/BSoypaLf0L1vLNLTLo1sbN79Q9swv3VXdCEUvKrbFMb1nuvimzaoUJelQgrINQkfVdoqzhtqkMflzpnbSs+FxhGXMOktr51qsPLEckIzLbmdts+L6EWwgP9loZEMZewZt6pKC6M4Xteyz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B9yNAsPn; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d0e75335e3so2972018a12.3
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 05:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733232201; x=1733837001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PbBkZlbczsljYkJKkDmTi4zCydPAq8t8D3jHFuNldM=;
        b=B9yNAsPnqxjSUJGcWri1YdUhOtfoqgslVBspgdwviXoMrzYn0jmTH21V1rqEdOZQjv
         FuCK9SaYN0x7uSKPbTX9jj1hiP41pwmrKvBocCQLuJzMXjhnRIoHcCxsOxqmPXViaAd7
         khFc8IE5tugCbsbRxRj++nqayt8MhakN0fc/tm98UvcJVoOGogUKSYEhkHCMqYfvpGQz
         L72iPXlbGIhEBPYSoCmtL/GN7duFtWVjkZTlI0WhGJAinlykbQKgYlkMluuRHYjXEo/A
         +kWeQElpqzyth6XKVCoQlXC+Gge9EyQ42fH6CkVtGAK9oiU/Ginnlml/uEgqI6E4GBmN
         geYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733232201; x=1733837001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5PbBkZlbczsljYkJKkDmTi4zCydPAq8t8D3jHFuNldM=;
        b=ZA743wygIof8PPpJZf8MPhtGWbfhNKm1z+q8ths1imyBAlI+1X4Uhw0aBzDVCnmuMf
         lrd+yXdpNw8jGOLdYEWltCAlNSYHjr3/rzysttsEakF85M/ygtGsKv2hDv5k3Jgrj8Ip
         BxHQWg6v1/oh1TlBA3fWJSe5jBpE1Y8Ujb01qHM8Xaq2XvfYibBx8XmWZQW8uzlRLnK2
         aNxbHbN4mWRFJuXk28u8ftI4fdUq+4/sgAgRWtMf9l1QRYKLXCw1mt7BrmGScw85QbUm
         o96pduaP3MBo/18nB/CdH2UWj52LyKcmnDfXvr9WQzcBJEzudRLD6JvypU903FdyEyCk
         6jjw==
X-Gm-Message-State: AOJu0YyY6gksW7CgscGl6clvX7iriZawsmkDhNdcR+uoNQAdrD9WaG+5
	/nMgGxDOwPcEe3WxNLnb7wgwkEGxLm96w+/T71jXaU9l4DQ8pbo4HtNJq7bgH+PEA7hegfESGxh
	c1Jm6Yb3M2wIIcfbjQC/YyXffLqV6GDZmx6Pj
X-Gm-Gg: ASbGncuu12JrqlfsnUC6xWnVjGbrPJHUlZsXR4K2TOgJ7tbhuCPYTZuCDXZrX1bDb86
	BePCiOwH8B5EKYQIPLe87jUCl8qeem/fW
X-Google-Smtp-Source: AGHT+IHYI+YpdKmFFyJjukPGyKVqDKngfSq/qqNeLwyp/PuWzwyL8L1/Gmosqf+MkOGLA3zRFHpHLFzz1/gVz/IYfhM=
X-Received: by 2002:a05:6402:2553:b0:5d0:e826:f0f5 with SMTP id
 4fb4d7f45d1cf-5d10cb4d7f8mr2638522a12.7.1733232200594; Tue, 03 Dec 2024
 05:23:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d1a7dea8-ce20-4c6f-beed-8a28b07e9468@ovn.org> <672d143c-7ccd-4b77-a843-24d0d60ada14@ovn.org>
In-Reply-To: <672d143c-7ccd-4b77-a843-24d0d60ada14@ovn.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 3 Dec 2024 14:23:09 +0100
Message-ID: <CANn89i+FPHAz=O-KfUV5nv8KNVPgpx+PX+2xzm0EwTJs8UqqMg@mail.gmail.com>
Subject: Re: [v6.12] BUG: KASAN: slab-use-after-free in dst_destroy+0x2e2/0x340
To: Ilya Maximets <i.maximets@ovn.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 1:15=E2=80=AFPM Ilya Maximets <i.maximets@ovn.org> w=
rote:
>
> On 12/3/24 12:58, Ilya Maximets wrote:
> > Hello there.  I was running some tests with openvswitch+ipsec on v6.12 =
tag
> > and got the KASAN UAF splat provided below.  It doesn't seem to be rela=
ted
> > to anything specific to openvswitch module, more like core parts of net=
working.
> > At lest, at the first glance.
> >
> > For the context, what I'm running is an OVS system test that creates 20=
 network
> > namespaces, starts OVS and Libreswan in each of them, creates a full me=
sh of
> > Geneve tunnels with IPsec (a separate tunnel between each pair of names=
paces),
> > then checks that pings work through all the tunnels and then deletes al=
l the
> > ports, OVS datapath and namespaces.  While removing namespaces, I see t=
he
> > following KASAN report in the logs:
> >
>
> The decoded trace:
>
> Dec 03 05:46:17 kernel: genev_sys_6081 (unregistering): left promiscuous =
mode
> Dec 03 05:46:17 kernel: br-ipsec: left promiscuous mode
> Dec 03 05:46:17 kernel: ovs-system: left promiscuous mode
> Dec 03 05:46:18 kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Dec 03 05:46:18 kernel: BUG: KASAN: slab-use-after-free in dst_destroy (n=
et/core/dst.c:112)
> Dec 03 05:46:18 kernel: Read of size 8 at addr ffff8882137ccab0 by task s=
wapper/37/0
> Dec 03 05:46:18 kernel:
> Dec 03 05:46:18 kernel: CPU: 37 UID: 0 PID: 0 Comm: swapper/37 Kdump: loa=
ded Not tainted 6.12.0 #67
> Dec 03 05:46:18 kernel: Hardware name: Red Hat KVM/RHEL, BIOS 1.16.1-1.el=
9 04/01/2014
> Dec 03 05:46:18 kernel: Call Trace:
> Dec 03 05:46:18 kernel:  <IRQ>
> Dec 03 05:46:18 kernel: dump_stack_lvl (lib/dump_stack.c:124)
> Dec 03 05:46:18 kernel: print_address_description.constprop.0 (mm/kasan/r=
eport.c:378)
> Dec 03 05:46:18 kernel: ? dst_destroy (net/core/dst.c:112)
> Dec 03 05:46:18 kernel: print_report (mm/kasan/report.c:489)
> Dec 03 05:46:18 kernel: ? dst_destroy (net/core/dst.c:112)
> Dec 03 05:46:18 kernel: ? kasan_addr_to_slab (mm/kasan/common.c:37)
> Dec 03 05:46:18 kernel: kasan_report (mm/kasan/report.c:603)
> Dec 03 05:46:18 kernel: ? dst_destroy (net/core/dst.c:112)
> Dec 03 05:46:18 kernel: ? rcu_do_batch (kernel/rcu/tree.c:2567)
> Dec 03 05:46:18 kernel: dst_destroy (net/core/dst.c:112)
> Dec 03 05:46:18 kernel: rcu_do_batch (kernel/rcu/tree.c:2567)
> Dec 03 05:46:18 kernel: ? __pfx_rcu_do_batch (kernel/rcu/tree.c:2491)
> Dec 03 05:46:18 kernel: ? lockdep_hardirqs_on_prepare (kernel/locking/loc=
kdep.c:4339 kernel/locking/lockdep.c:4406)
> Dec 03 05:46:18 kernel: rcu_core (kernel/rcu/tree.c:2825)
> Dec 03 05:46:18 kernel: handle_softirqs (kernel/softirq.c:554)
> Dec 03 05:46:18 kernel: __irq_exit_rcu (kernel/softirq.c:589 kernel/softi=
rq.c:428 kernel/softirq.c:637)
> Dec 03 05:46:18 kernel: irq_exit_rcu (kernel/softirq.c:651)
> Dec 03 05:46:18 kernel: sysvec_apic_timer_interrupt (arch/x86/kernel/apic=
/apic.c:1049 arch/x86/kernel/apic/apic.c:1049)
> Dec 03 05:46:18 kernel:  </IRQ>
> Dec 03 05:46:18 kernel:  <TASK>
> Dec 03 05:46:18 kernel: asm_sysvec_apic_timer_interrupt (./arch/x86/inclu=
de/asm/idtentry.h:702)
> Dec 03 05:46:18 kernel: RIP: 0010:default_idle (./arch/x86/include/asm/ir=
qflags.h:37 ./arch/x86/include/asm/irqflags.h:92 arch/x86/kernel/process.c:=
743)
> Dec 03 05:46:18 kernel: Code: 00 4d 29 c8 4c 01 c7 4c 29 c2 e9 6e ff ff f=
f 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 90 0f 00 2d c7 c9 27 0=
0 fb f4 <fa> c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 90
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   00 4d 29                add    %cl,0x29(%rbp)
>    3:   c8 4c 01 c7             enterq $0x14c,$0xc7
>    7:   4c 29 c2                sub    %r8,%rdx
>    a:   e9 6e ff ff ff          jmpq   0xffffffffffffff7d
>    f:   90                      nop
>   10:   90                      nop
>   11:   90                      nop
>   12:   90                      nop
>   13:   90                      nop
>   14:   90                      nop
>   15:   90                      nop
>   16:   90                      nop
>   17:   90                      nop
>   18:   90                      nop
>   19:   90                      nop
>   1a:   90                      nop
>   1b:   90                      nop
>   1c:   90                      nop
>   1d:   90                      nop
>   1e:   90                      nop
>   1f:   66 90                   xchg   %ax,%ax
>   21:   0f 00 2d c7 c9 27 00    verw   0x27c9c7(%rip)        # 0x27c9ef
>   28:   fb                      sti
>   29:   f4                      hlt
>   2a:*  fa                      cli             <-- trapping instruction
>   2b:   c3                      retq
>   2c:   cc                      int3
>   2d:   cc                      int3
>   2e:   cc                      int3
>   2f:   cc                      int3
>   30:   66 66 2e 0f 1f 84 00    data16 nopw %cs:0x0(%rax,%rax,1)
>   37:   00 00 00 00
>   3b:   0f 1f 40 00             nopl   0x0(%rax)
>   3f:   90                      nop
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:   fa                      cli
>    1:   c3                      retq
>    2:   cc                      int3
>    3:   cc                      int3
>    4:   cc                      int3
>    5:   cc                      int3
>    6:   66 66 2e 0f 1f 84 00    data16 nopw %cs:0x0(%rax,%rax,1)
>    d:   00 00 00 00
>   11:   0f 1f 40 00             nopl   0x0(%rax)
>   15:   90                      nop
> Dec 03 05:46:18 kernel: RSP: 0018:ffff888100d2fe00 EFLAGS: 00000246
> Dec 03 05:46:18 kernel: RAX: 00000000001870ed RBX: 1ffff110201a5fc2 RCX: =
ffffffffb61a3e46
> Dec 03 05:46:18 kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: =
ffffffffb3d4d123
> Dec 03 05:46:18 kernel: RBP: 0000000000000000 R08: 0000000000000001 R09: =
ffffed11c7e1835d
> Dec 03 05:46:18 kernel: R10: ffff888e3f0c1aeb R11: 0000000000000000 R12: =
0000000000000000
> Dec 03 05:46:18 kernel: R13: ffff888100d20000 R14: dffffc0000000000 R15: =
0000000000000000
> Dec 03 05:46:18 kernel: ? ct_kernel_exit.constprop.0 (kernel/context_trac=
king.c:148)
> Dec 03 05:46:18 kernel: ? cpuidle_idle_call (kernel/sched/idle.c:186)
> Dec 03 05:46:18 kernel: default_idle_call (./include/linux/cpuidle.h:143 =
kernel/sched/idle.c:118)
> Dec 03 05:46:18 kernel: cpuidle_idle_call (kernel/sched/idle.c:186)
> Dec 03 05:46:18 kernel: ? __pfx_cpuidle_idle_call (kernel/sched/idle.c:16=
8)
> Dec 03 05:46:18 kernel: ? lock_release (kernel/locking/lockdep.c:467 kern=
el/locking/lockdep.c:5848)
> Dec 03 05:46:18 kernel: ? lockdep_hardirqs_on_prepare (kernel/locking/loc=
kdep.c:4347 kernel/locking/lockdep.c:4406)
> Dec 03 05:46:18 kernel: ? tsc_verify_tsc_adjust (arch/x86/kernel/tsc_sync=
.c:59)
> Dec 03 05:46:18 kernel: do_idle (kernel/sched/idle.c:326)
> Dec 03 05:46:18 kernel: cpu_startup_entry (kernel/sched/idle.c:423 (discr=
iminator 1))
> Dec 03 05:46:18 kernel: start_secondary (arch/x86/kernel/smpboot.c:202 ar=
ch/x86/kernel/smpboot.c:282)
> Dec 03 05:46:18 kernel: ? __pfx_start_secondary (arch/x86/kernel/smpboot.=
c:232)
> Dec 03 05:46:18 kernel: ? soft_restart_cpu (arch/x86/kernel/head_64.S:452=
)
> Dec 03 05:46:18 kernel: common_startup_64 (arch/x86/kernel/head_64.S:414)
> Dec 03 05:46:18 kernel:  </TASK>
> Dec 03 05:46:18 kernel:
> Dec 03 05:46:18 kernel: Allocated by task 12184:
> Dec 03 05:46:18 kernel: kasan_save_stack (mm/kasan/common.c:48)
> Dec 03 05:46:18 kernel: kasan_save_track (./arch/x86/include/asm/current.=
h:49 mm/kasan/common.c:60 mm/kasan/common.c:69)
> Dec 03 05:46:18 kernel: __kasan_slab_alloc (mm/kasan/common.c:319 mm/kasa=
n/common.c:345)
> Dec 03 05:46:18 kernel: kmem_cache_alloc_noprof (mm/slub.c:4085 mm/slub.c=
:4134 mm/slub.c:4141)
> Dec 03 05:46:18 kernel: copy_net_ns (net/core/net_namespace.c:421 net/cor=
e/net_namespace.c:480)
> Dec 03 05:46:18 kernel: create_new_namespaces (kernel/nsproxy.c:110)
> Dec 03 05:46:18 kernel: unshare_nsproxy_namespaces (kernel/nsproxy.c:228 =
(discriminator 4))
> Dec 03 05:46:18 kernel: ksys_unshare (kernel/fork.c:3313)
> Dec 03 05:46:18 kernel: __x64_sys_unshare (kernel/fork.c:3382)
> Dec 03 05:46:18 kernel: do_syscall_64 (arch/x86/entry/common.c:52 arch/x8=
6/entry/common.c:83)
> Dec 03 05:46:18 kernel: entry_SYSCALL_64_after_hwframe (arch/x86/entry/en=
try_64.S:130)
> Dec 03 05:46:18 kernel:
> Dec 03 05:46:18 kernel: Freed by task 11:
> Dec 03 05:46:18 kernel: kasan_save_stack (mm/kasan/common.c:48)
> Dec 03 05:46:18 kernel: kasan_save_track (./arch/x86/include/asm/current.=
h:49 mm/kasan/common.c:60 mm/kasan/common.c:69)
> Dec 03 05:46:18 kernel: kasan_save_free_info (mm/kasan/generic.c:582)
> Dec 03 05:46:18 kernel: __kasan_slab_free (mm/kasan/common.c:271)
> Dec 03 05:46:18 kernel: kmem_cache_free (mm/slub.c:4579 mm/slub.c:4681)
> Dec 03 05:46:18 kernel: cleanup_net (net/core/net_namespace.c:456 net/cor=
e/net_namespace.c:446 net/core/net_namespace.c:647)
> Dec 03 05:46:18 kernel: process_one_work (kernel/workqueue.c:3229)
> Dec 03 05:46:18 kernel: worker_thread (kernel/workqueue.c:3304 kernel/wor=
kqueue.c:3391)
> Dec 03 05:46:18 kernel: kthread (kernel/kthread.c:389)
> Dec 03 05:46:18 kernel: ret_from_fork (arch/x86/kernel/process.c:147)
> Dec 03 05:46:18 kernel: ret_from_fork_asm (arch/x86/entry/entry_64.S:257)
> Dec 03 05:46:18 kernel:
> Dec 03 05:46:18 kernel: Last potentially related work creation:
> Dec 03 05:46:18 kernel: kasan_save_stack (mm/kasan/common.c:48)
> Dec 03 05:46:18 kernel: __kasan_record_aux_stack (mm/kasan/generic.c:541)
> Dec 03 05:46:18 kernel: insert_work (./include/linux/instrumented.h:68 ./=
include/asm-generic/bitops/instrumented-non-atomic.h:141 kernel/workqueue.c=
:788 kernel/workqueue.c:795 kernel/workqueue.c:2186)
> Dec 03 05:46:18 kernel: __queue_work (kernel/workqueue.c:2340)
> Dec 03 05:46:18 kernel: queue_work_on (kernel/workqueue.c:2391)
> Dec 03 05:46:18 kernel: xfrm_policy_insert (net/xfrm/xfrm_policy.c:1610)
> Dec 03 05:46:18 kernel: xfrm_add_policy (net/xfrm/xfrm_user.c:2116)
> Dec 03 05:46:18 kernel: xfrm_user_rcv_msg (net/xfrm/xfrm_user.c:3321)
> Dec 03 05:46:18 kernel: netlink_rcv_skb (net/netlink/af_netlink.c:2536)
> Dec 03 05:46:18 kernel: xfrm_netlink_rcv (net/xfrm/xfrm_user.c:3344)
> Dec 03 05:46:18 kernel: netlink_unicast (net/netlink/af_netlink.c:1316 ne=
t/netlink/af_netlink.c:1342)
> Dec 03 05:46:18 kernel: netlink_sendmsg (net/netlink/af_netlink.c:1886)
> Dec 03 05:46:18 kernel: sock_write_iter (net/socket.c:729 net/socket.c:74=
4 net/socket.c:1165)
> Dec 03 05:46:18 kernel: vfs_write (fs/read_write.c:590 fs/read_write.c:68=
3)
> Dec 03 05:46:18 kernel: ksys_write (fs/read_write.c:736)
> Dec 03 05:46:18 kernel: do_syscall_64 (arch/x86/entry/common.c:52 arch/x8=
6/entry/common.c:83)
> Dec 03 05:46:18 kernel: entry_SYSCALL_64_after_hwframe (arch/x86/entry/en=
try_64.S:130)
> Dec 03 05:46:18 kernel:
> Dec 03 05:46:18 kernel: Second to last potentially related work creation:
> Dec 03 05:46:18 kernel: kasan_save_stack (mm/kasan/common.c:48)
> Dec 03 05:46:18 kernel: __kasan_record_aux_stack (mm/kasan/generic.c:541)
> Dec 03 05:46:18 kernel: insert_work (./include/linux/instrumented.h:68 ./=
include/asm-generic/bitops/instrumented-non-atomic.h:141 kernel/workqueue.c=
:788 kernel/workqueue.c:795 kernel/workqueue.c:2186)
> Dec 03 05:46:18 kernel: __queue_work (kernel/workqueue.c:2340)
> Dec 03 05:46:18 kernel: queue_work_on (kernel/workqueue.c:2391)
> Dec 03 05:46:18 kernel: __xfrm_state_insert (./include/linux/workqueue.h:=
723 net/xfrm/xfrm_state.c:1150 net/xfrm/xfrm_state.c:1145 net/xfrm/xfrm_sta=
te.c:1513)
> Dec 03 05:46:18 kernel: xfrm_state_update (./include/linux/spinlock.h:396=
 net/xfrm/xfrm_state.c:1940)
> Dec 03 05:46:18 kernel: xfrm_add_sa (net/xfrm/xfrm_user.c:912)
> Dec 03 05:46:18 kernel: xfrm_user_rcv_msg (net/xfrm/xfrm_user.c:3321)
> Dec 03 05:46:18 kernel: netlink_rcv_skb (net/netlink/af_netlink.c:2536)
> Dec 03 05:46:18 kernel: xfrm_netlink_rcv (net/xfrm/xfrm_user.c:3344)
> Dec 03 05:46:18 kernel: netlink_unicast (net/netlink/af_netlink.c:1316 ne=
t/netlink/af_netlink.c:1342)
> Dec 03 05:46:18 kernel: netlink_sendmsg (net/netlink/af_netlink.c:1886)
> Dec 03 05:46:18 kernel: sock_write_iter (net/socket.c:729 net/socket.c:74=
4 net/socket.c:1165)
> Dec 03 05:46:18 kernel: vfs_write (fs/read_write.c:590 fs/read_write.c:68=
3)
> Dec 03 05:46:18 kernel: ksys_write (fs/read_write.c:736)
> Dec 03 05:46:18 kernel: do_syscall_64 (arch/x86/entry/common.c:52 arch/x8=
6/entry/common.c:83)
> Dec 03 05:46:18 kernel: entry_SYSCALL_64_after_hwframe (arch/x86/entry/en=
try_64.S:130)
> Dec 03 05:46:18 kernel:
> Dec 03 05:46:18 kernel: The buggy address belongs to the object at ffff88=
82137cb680
> which belongs to the cache net_namespace of size 6720
> Dec 03 05:46:18 kernel: The buggy address is located 5168 bytes inside of
> freed 6720-byte region [ffff8882137cb680, ffff8882137cd0c0)
> Dec 03 05:46:18 kernel:
> Dec 03 05:46:18 kernel: The buggy address belongs to the physical page:
> Dec 03 05:46:18 kernel: page: refcount:1 mapcount:0 mapping:0000000000000=
000 index:0x0 pfn:0x2137c8
> Dec 03 05:46:18 kernel: head: order:3 mapcount:0 entire_mapcount:0 nr_pag=
es_mapped:0 pincount:0
> Dec 03 05:46:18 kernel: memcg:ffff88812794d901
> Dec 03 05:46:18 kernel: flags: 0x17ffffc0000040(head|node=3D0|zone=3D2|la=
stcpupid=3D0x1fffff)
> Dec 03 05:46:18 kernel: page_type: f5(slab)
> Dec 03 05:46:18 kernel: raw: 0017ffffc0000040 ffff888100053980 dead000000=
000122 0000000000000000
> Dec 03 05:46:18 kernel: raw: 0000000000000000 0000000080040004 00000001f5=
000000 ffff88812794d901
> Dec 03 05:46:18 kernel: head: 0017ffffc0000040 ffff888100053980 dead00000=
0000122 0000000000000000
> Dec 03 05:46:18 kernel: head: 0000000000000000 0000000080040004 00000001f=
5000000 ffff88812794d901
> Dec 03 05:46:18 kernel: head: 0017ffffc0000003 ffffea00084df201 fffffffff=
fffffff 0000000000000000
> Dec 03 05:46:18 kernel: head: 0000000000000008 0000000000000000 00000000f=
fffffff 0000000000000000
> Dec 03 05:46:18 kernel: page dumped because: kasan: bad access detected
> Dec 03 05:46:18 kernel:
> Dec 03 05:46:18 kernel: Memory state around the buggy address:
> Dec 03 05:46:18 kernel:  ffff8882137cc980: fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb fb
> Dec 03 05:46:18 kernel:  ffff8882137cca00: fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb fb
> Dec 03 05:46:18 kernel: >ffff8882137cca80: fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb fb
> Dec 03 05:46:18 kernel:                                      ^
> Dec 03 05:46:18 kernel:  ffff8882137ccb00: fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb fb
> Dec 03 05:46:18 kernel:  ffff8882137ccb80: fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb fb
> Dec 03 05:46:18 kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Best regards, Ilya Maximets.

Issue is in xfrm6_net_init() and xfrm4_net_init() :
They copies xfrm6_dst_ops_template into net->xfrm.xfrm6_dst_ops, (or
xfrm4_dst_ops_template to net->xfrm.xfrm4_dst_ops)

But net structure is freed before all the dst callbacks are called.


So when dst_destroy() calls later :

if (dst->ops->destroy)
    dst->ops->destroy(dst);

dst->ops point to the old net->xfrm.xfrm6_dst_ops, which has been freed.

See for a similar issue fixed in , and that I warned XFRM maintainers
at that time:

ac888d58869b net: do not delay dst_entries_add() in dst_release()

A solution could be to queue the 'struct net' to be freed after one
another cleanup_net() round (and existing rcu barrier)

net_free() would need to not directly call kmem_cache_free(net_cachep, net)=
.

I can cook a patch, thanks for the report.

