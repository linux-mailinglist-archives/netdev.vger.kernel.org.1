Return-Path: <netdev+bounces-148459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BB29E1E6B
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAC4DB43A2F
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 12:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86FB1E883E;
	Tue,  3 Dec 2024 12:16:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E44C1E8845;
	Tue,  3 Dec 2024 12:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733228163; cv=none; b=qHwma+kN+5Z854rpd+B7fLRUSRGMzebhATpClvvlmD5t8TdjY6aiUnAErR9rT6jXFR1y2aFnuIAHlXsRP56pQh6ad358wzkUXCTAc25JgOUjzqGP3LP/dQ2kyPyTe/9OoF4drNs9mtUK+o47fRNijf6MvgqOuCP08Al1jlsYhqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733228163; c=relaxed/simple;
	bh=VL8KzFSp4HaCLHZ/JReNICkEZcdZkb1hTI3ISigYdIg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=W80FVBsftZ2WQUF59zQJqizP4VRFDbgnCWzMapBesedfKJNWVcTPlH4zx/R5cXPuexns8yhk8Lo8TE+dhSR3HjJE+61dpU1d+uRqNM5OgbpmuxkzelsAf1VG7x727M2F97LhuCG4ajPlbdPRP5ufGbEviM9ujRabEbGIgLearVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-53de579f775so7612914e87.2;
        Tue, 03 Dec 2024 04:16:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733228159; x=1733832959;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvocHw0jF6Q5uMDvQyRVyuvjxqLHotu49zLE2kFFmmA=;
        b=l8xOymFqGSrr5yrsN0VJu72p1+h4wTgVSdsGmsi3binXc6BYJ9GH69QsLNH7QsIHiR
         AEp5xiXEL2dpVMeqGbHRumbOwYWw/Pf8tC0sRAGUPM+p5pXvbIchyYL4o2VIfo6TYXBH
         brG5ozw9M0DC5x9lqqt7WB0HXIJiMm7tsFrvek2pkh2luy1DPwxwPc94Caa584osfPqb
         sCv1tgJSUa2yPXseSW7M0/yhfzqPPpkhx9OSJukmBf8i7wXszUFiQsSo0/rK5QNn9eBx
         ORZtJ4r+uAIK05U3xI321sRoZRwrh43oQBcsYQRemrnIiTDypVbz7/GFoo4V7aBP777X
         MSZg==
X-Forwarded-Encrypted: i=1; AJvYcCVR9DwmNRjaGbTCA8WRvCD38jEMJlKfUmabIPajba6fXkNjGwaBx86ivXkOZdDdfGm2G3w7Z878IscArlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWwO/azNyisFWWn+txNR3kFdTtOAQaNojPJDi7HnZtdHwBkeCO
	iQ0GDGP2YAgS65ePKov1/ld9IIZVE28HPJcKGBPDjDhqmWrKER6EBmnMd6wL
X-Gm-Gg: ASbGncsCO6W6f5z8b9EK60VNYs4vLEx+EhgPMsl7LEz0iphSbvpPD3RcCIGOUVjJJWz
	TIxxv13skoW1he1Kld7jr3e9b2yUjjP2yFS43WITM8v7UD08javkZ9/+2JyycU07WbI/rA31yiB
	GjCOZXt5RSOl0gpRhTnKdvopQAQyq+U6mZTo2EviS98MHAJ5aIEV8SLN+oDyyUGM0YnGaFKd9Du
	Fs2CUi7fANrWnV4t6A9Q0C6TNHAruzTVO359UK9sBD7wBwjd/64AUAdPCKXfDmTM19iVcPPBGq6
	6uIPxw==
X-Google-Smtp-Source: AGHT+IEy+zezbGhnuil3Gf8iy0ULSRx7rRVEMcPgIjyfvhxns3PNGdcyIv+pI9VX80/4ZeXljRn/5g==
X-Received: by 2002:a05:6512:3f0e:b0:53d:ed0f:ca8 with SMTP id 2adb3069b0e04-53e129ef7d7mr2049937e87.6.1733228158306;
        Tue, 03 Dec 2024 04:15:58 -0800 (PST)
Received: from [192.168.0.13] (ip-86-49-44-151.bb.vodafone.cz. [86.49.44.151])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996de557sm613905666b.69.2024.12.03.04.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 04:15:57 -0800 (PST)
Message-ID: <672d143c-7ccd-4b77-a843-24d0d60ada14@ovn.org>
Date: Tue, 3 Dec 2024 13:15:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [v6.12] BUG: KASAN: slab-use-after-free in
 dst_destroy+0x2e2/0x340
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <d1a7dea8-ce20-4c6f-beed-8a28b07e9468@ovn.org>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <d1a7dea8-ce20-4c6f-beed-8a28b07e9468@ovn.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/3/24 12:58, Ilya Maximets wrote:
> Hello there.  I was running some tests with openvswitch+ipsec on v6.12 tag
> and got the KASAN UAF splat provided below.  It doesn't seem to be related
> to anything specific to openvswitch module, more like core parts of networking.
> At lest, at the first glance.
> 
> For the context, what I'm running is an OVS system test that creates 20 network
> namespaces, starts OVS and Libreswan in each of them, creates a full mesh of
> Geneve tunnels with IPsec (a separate tunnel between each pair of namespaces),
> then checks that pings work through all the tunnels and then deletes all the
> ports, OVS datapath and namespaces.  While removing namespaces, I see the
> following KASAN report in the logs:
> 

The decoded trace:

Dec 03 05:46:17 kernel: genev_sys_6081 (unregistering): left promiscuous mode
Dec 03 05:46:17 kernel: br-ipsec: left promiscuous mode
Dec 03 05:46:17 kernel: ovs-system: left promiscuous mode
Dec 03 05:46:18 kernel: ==================================================================
Dec 03 05:46:18 kernel: BUG: KASAN: slab-use-after-free in dst_destroy (net/core/dst.c:112) 
Dec 03 05:46:18 kernel: Read of size 8 at addr ffff8882137ccab0 by task swapper/37/0
Dec 03 05:46:18 kernel:
Dec 03 05:46:18 kernel: CPU: 37 UID: 0 PID: 0 Comm: swapper/37 Kdump: loaded Not tainted 6.12.0 #67
Dec 03 05:46:18 kernel: Hardware name: Red Hat KVM/RHEL, BIOS 1.16.1-1.el9 04/01/2014
Dec 03 05:46:18 kernel: Call Trace:
Dec 03 05:46:18 kernel:  <IRQ>
Dec 03 05:46:18 kernel: dump_stack_lvl (lib/dump_stack.c:124) 
Dec 03 05:46:18 kernel: print_address_description.constprop.0 (mm/kasan/report.c:378) 
Dec 03 05:46:18 kernel: ? dst_destroy (net/core/dst.c:112) 
Dec 03 05:46:18 kernel: print_report (mm/kasan/report.c:489) 
Dec 03 05:46:18 kernel: ? dst_destroy (net/core/dst.c:112) 
Dec 03 05:46:18 kernel: ? kasan_addr_to_slab (mm/kasan/common.c:37) 
Dec 03 05:46:18 kernel: kasan_report (mm/kasan/report.c:603) 
Dec 03 05:46:18 kernel: ? dst_destroy (net/core/dst.c:112) 
Dec 03 05:46:18 kernel: ? rcu_do_batch (kernel/rcu/tree.c:2567) 
Dec 03 05:46:18 kernel: dst_destroy (net/core/dst.c:112) 
Dec 03 05:46:18 kernel: rcu_do_batch (kernel/rcu/tree.c:2567) 
Dec 03 05:46:18 kernel: ? __pfx_rcu_do_batch (kernel/rcu/tree.c:2491) 
Dec 03 05:46:18 kernel: ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4339 kernel/locking/lockdep.c:4406) 
Dec 03 05:46:18 kernel: rcu_core (kernel/rcu/tree.c:2825) 
Dec 03 05:46:18 kernel: handle_softirqs (kernel/softirq.c:554) 
Dec 03 05:46:18 kernel: __irq_exit_rcu (kernel/softirq.c:589 kernel/softirq.c:428 kernel/softirq.c:637) 
Dec 03 05:46:18 kernel: irq_exit_rcu (kernel/softirq.c:651) 
Dec 03 05:46:18 kernel: sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1049 arch/x86/kernel/apic/apic.c:1049) 
Dec 03 05:46:18 kernel:  </IRQ>
Dec 03 05:46:18 kernel:  <TASK>
Dec 03 05:46:18 kernel: asm_sysvec_apic_timer_interrupt (./arch/x86/include/asm/idtentry.h:702) 
Dec 03 05:46:18 kernel: RIP: 0010:default_idle (./arch/x86/include/asm/irqflags.h:37 ./arch/x86/include/asm/irqflags.h:92 arch/x86/kernel/process.c:743) 
Dec 03 05:46:18 kernel: Code: 00 4d 29 c8 4c 01 c7 4c 29 c2 e9 6e ff ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 90 0f 00 2d c7 c9 27 00 fb f4 <fa> c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 90
All code
========
   0:   00 4d 29                add    %cl,0x29(%rbp)
   3:   c8 4c 01 c7             enterq $0x14c,$0xc7
   7:   4c 29 c2                sub    %r8,%rdx
   a:   e9 6e ff ff ff          jmpq   0xffffffffffffff7d
   f:   90                      nop
  10:   90                      nop
  11:   90                      nop
  12:   90                      nop
  13:   90                      nop
  14:   90                      nop
  15:   90                      nop
  16:   90                      nop
  17:   90                      nop
  18:   90                      nop
  19:   90                      nop
  1a:   90                      nop
  1b:   90                      nop
  1c:   90                      nop
  1d:   90                      nop
  1e:   90                      nop
  1f:   66 90                   xchg   %ax,%ax
  21:   0f 00 2d c7 c9 27 00    verw   0x27c9c7(%rip)        # 0x27c9ef
  28:   fb                      sti    
  29:   f4                      hlt    
  2a:*  fa                      cli             <-- trapping instruction
  2b:   c3                      retq   
  2c:   cc                      int3   
  2d:   cc                      int3   
  2e:   cc                      int3   
  2f:   cc                      int3   
  30:   66 66 2e 0f 1f 84 00    data16 nopw %cs:0x0(%rax,%rax,1)
  37:   00 00 00 00 
  3b:   0f 1f 40 00             nopl   0x0(%rax)
  3f:   90                      nop

Code starting with the faulting instruction
===========================================
   0:   fa                      cli    
   1:   c3                      retq   
   2:   cc                      int3   
   3:   cc                      int3   
   4:   cc                      int3   
   5:   cc                      int3   
   6:   66 66 2e 0f 1f 84 00    data16 nopw %cs:0x0(%rax,%rax,1)
   d:   00 00 00 00 
  11:   0f 1f 40 00             nopl   0x0(%rax)
  15:   90                      nop
Dec 03 05:46:18 kernel: RSP: 0018:ffff888100d2fe00 EFLAGS: 00000246
Dec 03 05:46:18 kernel: RAX: 00000000001870ed RBX: 1ffff110201a5fc2 RCX: ffffffffb61a3e46
Dec 03 05:46:18 kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffb3d4d123
Dec 03 05:46:18 kernel: RBP: 0000000000000000 R08: 0000000000000001 R09: ffffed11c7e1835d
Dec 03 05:46:18 kernel: R10: ffff888e3f0c1aeb R11: 0000000000000000 R12: 0000000000000000
Dec 03 05:46:18 kernel: R13: ffff888100d20000 R14: dffffc0000000000 R15: 0000000000000000
Dec 03 05:46:18 kernel: ? ct_kernel_exit.constprop.0 (kernel/context_tracking.c:148) 
Dec 03 05:46:18 kernel: ? cpuidle_idle_call (kernel/sched/idle.c:186) 
Dec 03 05:46:18 kernel: default_idle_call (./include/linux/cpuidle.h:143 kernel/sched/idle.c:118) 
Dec 03 05:46:18 kernel: cpuidle_idle_call (kernel/sched/idle.c:186) 
Dec 03 05:46:18 kernel: ? __pfx_cpuidle_idle_call (kernel/sched/idle.c:168) 
Dec 03 05:46:18 kernel: ? lock_release (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5848) 
Dec 03 05:46:18 kernel: ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4347 kernel/locking/lockdep.c:4406) 
Dec 03 05:46:18 kernel: ? tsc_verify_tsc_adjust (arch/x86/kernel/tsc_sync.c:59) 
Dec 03 05:46:18 kernel: do_idle (kernel/sched/idle.c:326) 
Dec 03 05:46:18 kernel: cpu_startup_entry (kernel/sched/idle.c:423 (discriminator 1)) 
Dec 03 05:46:18 kernel: start_secondary (arch/x86/kernel/smpboot.c:202 arch/x86/kernel/smpboot.c:282) 
Dec 03 05:46:18 kernel: ? __pfx_start_secondary (arch/x86/kernel/smpboot.c:232) 
Dec 03 05:46:18 kernel: ? soft_restart_cpu (arch/x86/kernel/head_64.S:452) 
Dec 03 05:46:18 kernel: common_startup_64 (arch/x86/kernel/head_64.S:414) 
Dec 03 05:46:18 kernel:  </TASK>
Dec 03 05:46:18 kernel:
Dec 03 05:46:18 kernel: Allocated by task 12184:
Dec 03 05:46:18 kernel: kasan_save_stack (mm/kasan/common.c:48) 
Dec 03 05:46:18 kernel: kasan_save_track (./arch/x86/include/asm/current.h:49 mm/kasan/common.c:60 mm/kasan/common.c:69) 
Dec 03 05:46:18 kernel: __kasan_slab_alloc (mm/kasan/common.c:319 mm/kasan/common.c:345) 
Dec 03 05:46:18 kernel: kmem_cache_alloc_noprof (mm/slub.c:4085 mm/slub.c:4134 mm/slub.c:4141) 
Dec 03 05:46:18 kernel: copy_net_ns (net/core/net_namespace.c:421 net/core/net_namespace.c:480) 
Dec 03 05:46:18 kernel: create_new_namespaces (kernel/nsproxy.c:110) 
Dec 03 05:46:18 kernel: unshare_nsproxy_namespaces (kernel/nsproxy.c:228 (discriminator 4)) 
Dec 03 05:46:18 kernel: ksys_unshare (kernel/fork.c:3313) 
Dec 03 05:46:18 kernel: __x64_sys_unshare (kernel/fork.c:3382) 
Dec 03 05:46:18 kernel: do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
Dec 03 05:46:18 kernel: entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
Dec 03 05:46:18 kernel:
Dec 03 05:46:18 kernel: Freed by task 11:
Dec 03 05:46:18 kernel: kasan_save_stack (mm/kasan/common.c:48) 
Dec 03 05:46:18 kernel: kasan_save_track (./arch/x86/include/asm/current.h:49 mm/kasan/common.c:60 mm/kasan/common.c:69) 
Dec 03 05:46:18 kernel: kasan_save_free_info (mm/kasan/generic.c:582) 
Dec 03 05:46:18 kernel: __kasan_slab_free (mm/kasan/common.c:271) 
Dec 03 05:46:18 kernel: kmem_cache_free (mm/slub.c:4579 mm/slub.c:4681) 
Dec 03 05:46:18 kernel: cleanup_net (net/core/net_namespace.c:456 net/core/net_namespace.c:446 net/core/net_namespace.c:647) 
Dec 03 05:46:18 kernel: process_one_work (kernel/workqueue.c:3229) 
Dec 03 05:46:18 kernel: worker_thread (kernel/workqueue.c:3304 kernel/workqueue.c:3391) 
Dec 03 05:46:18 kernel: kthread (kernel/kthread.c:389) 
Dec 03 05:46:18 kernel: ret_from_fork (arch/x86/kernel/process.c:147) 
Dec 03 05:46:18 kernel: ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
Dec 03 05:46:18 kernel:
Dec 03 05:46:18 kernel: Last potentially related work creation:
Dec 03 05:46:18 kernel: kasan_save_stack (mm/kasan/common.c:48) 
Dec 03 05:46:18 kernel: __kasan_record_aux_stack (mm/kasan/generic.c:541) 
Dec 03 05:46:18 kernel: insert_work (./include/linux/instrumented.h:68 ./include/asm-generic/bitops/instrumented-non-atomic.h:141 kernel/workqueue.c:788 kernel/workqueue.c:795 kernel/workqueue.c:2186) 
Dec 03 05:46:18 kernel: __queue_work (kernel/workqueue.c:2340) 
Dec 03 05:46:18 kernel: queue_work_on (kernel/workqueue.c:2391) 
Dec 03 05:46:18 kernel: xfrm_policy_insert (net/xfrm/xfrm_policy.c:1610) 
Dec 03 05:46:18 kernel: xfrm_add_policy (net/xfrm/xfrm_user.c:2116) 
Dec 03 05:46:18 kernel: xfrm_user_rcv_msg (net/xfrm/xfrm_user.c:3321) 
Dec 03 05:46:18 kernel: netlink_rcv_skb (net/netlink/af_netlink.c:2536) 
Dec 03 05:46:18 kernel: xfrm_netlink_rcv (net/xfrm/xfrm_user.c:3344) 
Dec 03 05:46:18 kernel: netlink_unicast (net/netlink/af_netlink.c:1316 net/netlink/af_netlink.c:1342) 
Dec 03 05:46:18 kernel: netlink_sendmsg (net/netlink/af_netlink.c:1886) 
Dec 03 05:46:18 kernel: sock_write_iter (net/socket.c:729 net/socket.c:744 net/socket.c:1165) 
Dec 03 05:46:18 kernel: vfs_write (fs/read_write.c:590 fs/read_write.c:683) 
Dec 03 05:46:18 kernel: ksys_write (fs/read_write.c:736) 
Dec 03 05:46:18 kernel: do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
Dec 03 05:46:18 kernel: entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
Dec 03 05:46:18 kernel:
Dec 03 05:46:18 kernel: Second to last potentially related work creation:
Dec 03 05:46:18 kernel: kasan_save_stack (mm/kasan/common.c:48) 
Dec 03 05:46:18 kernel: __kasan_record_aux_stack (mm/kasan/generic.c:541) 
Dec 03 05:46:18 kernel: insert_work (./include/linux/instrumented.h:68 ./include/asm-generic/bitops/instrumented-non-atomic.h:141 kernel/workqueue.c:788 kernel/workqueue.c:795 kernel/workqueue.c:2186) 
Dec 03 05:46:18 kernel: __queue_work (kernel/workqueue.c:2340) 
Dec 03 05:46:18 kernel: queue_work_on (kernel/workqueue.c:2391) 
Dec 03 05:46:18 kernel: __xfrm_state_insert (./include/linux/workqueue.h:723 net/xfrm/xfrm_state.c:1150 net/xfrm/xfrm_state.c:1145 net/xfrm/xfrm_state.c:1513) 
Dec 03 05:46:18 kernel: xfrm_state_update (./include/linux/spinlock.h:396 net/xfrm/xfrm_state.c:1940) 
Dec 03 05:46:18 kernel: xfrm_add_sa (net/xfrm/xfrm_user.c:912) 
Dec 03 05:46:18 kernel: xfrm_user_rcv_msg (net/xfrm/xfrm_user.c:3321) 
Dec 03 05:46:18 kernel: netlink_rcv_skb (net/netlink/af_netlink.c:2536) 
Dec 03 05:46:18 kernel: xfrm_netlink_rcv (net/xfrm/xfrm_user.c:3344) 
Dec 03 05:46:18 kernel: netlink_unicast (net/netlink/af_netlink.c:1316 net/netlink/af_netlink.c:1342) 
Dec 03 05:46:18 kernel: netlink_sendmsg (net/netlink/af_netlink.c:1886) 
Dec 03 05:46:18 kernel: sock_write_iter (net/socket.c:729 net/socket.c:744 net/socket.c:1165) 
Dec 03 05:46:18 kernel: vfs_write (fs/read_write.c:590 fs/read_write.c:683) 
Dec 03 05:46:18 kernel: ksys_write (fs/read_write.c:736) 
Dec 03 05:46:18 kernel: do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
Dec 03 05:46:18 kernel: entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
Dec 03 05:46:18 kernel:
Dec 03 05:46:18 kernel: The buggy address belongs to the object at ffff8882137cb680
which belongs to the cache net_namespace of size 6720
Dec 03 05:46:18 kernel: The buggy address is located 5168 bytes inside of
freed 6720-byte region [ffff8882137cb680, ffff8882137cd0c0)
Dec 03 05:46:18 kernel:
Dec 03 05:46:18 kernel: The buggy address belongs to the physical page:
Dec 03 05:46:18 kernel: page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2137c8
Dec 03 05:46:18 kernel: head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
Dec 03 05:46:18 kernel: memcg:ffff88812794d901
Dec 03 05:46:18 kernel: flags: 0x17ffffc0000040(head|node=0|zone=2|lastcpupid=0x1fffff)
Dec 03 05:46:18 kernel: page_type: f5(slab)
Dec 03 05:46:18 kernel: raw: 0017ffffc0000040 ffff888100053980 dead000000000122 0000000000000000
Dec 03 05:46:18 kernel: raw: 0000000000000000 0000000080040004 00000001f5000000 ffff88812794d901
Dec 03 05:46:18 kernel: head: 0017ffffc0000040 ffff888100053980 dead000000000122 0000000000000000
Dec 03 05:46:18 kernel: head: 0000000000000000 0000000080040004 00000001f5000000 ffff88812794d901
Dec 03 05:46:18 kernel: head: 0017ffffc0000003 ffffea00084df201 ffffffffffffffff 0000000000000000
Dec 03 05:46:18 kernel: head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
Dec 03 05:46:18 kernel: page dumped because: kasan: bad access detected
Dec 03 05:46:18 kernel:
Dec 03 05:46:18 kernel: Memory state around the buggy address:
Dec 03 05:46:18 kernel:  ffff8882137cc980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
Dec 03 05:46:18 kernel:  ffff8882137cca00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
Dec 03 05:46:18 kernel: >ffff8882137cca80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
Dec 03 05:46:18 kernel:                                      ^
Dec 03 05:46:18 kernel:  ffff8882137ccb00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
Dec 03 05:46:18 kernel:  ffff8882137ccb80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
Dec 03 05:46:18 kernel: ==================================================================

Best regards, Ilya Maximets.

