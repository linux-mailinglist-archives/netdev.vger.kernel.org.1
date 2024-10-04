Return-Path: <netdev+bounces-131927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D3098FF56
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 11:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35F351C218F8
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 09:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF2F140E30;
	Fri,  4 Oct 2024 09:09:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE2E130499;
	Fri,  4 Oct 2024 09:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728032941; cv=none; b=WwvCqaUOIKgKaMhOxFrq3MXjVWjnZSXfuPq8W8RO+60ZpHF+dc+FhlzGxOjfihFFZLWPfdqm82qTQhjmMZe9fN0I7wIOG4EoYhaXF5vNxWrc3HhQ/NqrQkksqNjxctJ0F9qVoASkUoQFgoSnhOXXMEIM1gqQjsupPbUHXHkI4q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728032941; c=relaxed/simple;
	bh=jA9cvQzhT0L0YJ+uSQlv9y8ql/jyQ3Bbi3MHkJDhyzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0Z/6zIIA/dBMGLvrG9hPIDdq4neeSh0qYM1GfZcOQkVRWdt9I490UULv0O4iC/0QHMQ48zPjODVRy70qYIdp4+csvi+JN0jyfz3R7xyXfhFGWQ8gOvSlm5+I/xJnVuMdMPaEwz9SSyytoCTVdpwX9/WQTBH21RRA8Fd315TY+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c5bca6603aso2289100a12.1;
        Fri, 04 Oct 2024 02:08:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728032937; x=1728637737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqFOLnwrLmVaxGEEvSvC1Rqbr7B97eKRhgdC1WbPjtw=;
        b=s7ciTwQ2umJGrUXOCS1VEBglm0bEN+TUCG8hQGrccjCowdDJcbSXiv9oEEAFA0/maO
         L+LYSfp9TTDMqD7ZQ97tBWQGaic6jDfdAwHXxauEUyWfL38PEYDagp26z/Cp//2Ep8yM
         eH0kpnTzViCSXpAz3MfdVzpkX2VG4vWMsk7Ih2b70DrHrrB4qVaxoXW4cFpAeL3Rj31V
         yoQAw9ZoodnDLfqgcYdbecequdp4D93b2c+cfr5autt4V1EumC++R+3lyxZXlt1yj2uC
         ND2tNvKsOfUKm806ipfutrhXLLGmPAvtjpPRbJtwuCIKjmEqlxVqLSh4PAfEWdq/ghSs
         lFGA==
X-Forwarded-Encrypted: i=1; AJvYcCWu0iEXqPAJk/N0UTZ/uA87xBhUS91KDKhyf0NmKW2GodCnaWRCmfccriNgt1E2smKG3ULUUni8@vger.kernel.org, AJvYcCXy21oD7uIiqEdSav+DV2gIxjkgFyH5oVGlnptuSqU5oFgwhj3UYhKqzibcroOEPXGKOYvFv7mH21Dm8TE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoOlt7Zjeoizr6+cR5egQ6Xrp6RAGE7QsC79B7nCcEclzxkTUN
	LfIEk1rTiaBdg0toxdNGVVqErpWFViN0krBdtCHkEAg5c8UAC2yi
X-Google-Smtp-Source: AGHT+IHw/7NxMNCqrEqX6RB8QnB5+SwcW8FQaNQBUgHUhqIcLgaPoGfpW6YQuquKtLfYkd4NN7doLw==
X-Received: by 2002:a05:6402:35c4:b0:5c8:8bdb:d711 with SMTP id 4fb4d7f45d1cf-5c8d2e35961mr1315282a12.20.1728032936045;
        Fri, 04 Oct 2024 02:08:56 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8ca3dfe5csm1619018a12.35.2024.10.04.02.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 02:08:55 -0700 (PDT)
Date: Fri, 4 Oct 2024 02:08:52 -0700
From: Breno Leitao <leitao@debian.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: gregkh@linuxfoundation.org, pmladek@suse.com, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, kuba@kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, vschneid@redhat.com, axboe@kernel.dk
Subject: Re: 6.12-rc1: Lockdep regression bissected
 (virtio-net/console/scheduler)
Message-ID: <20241004-blazing-rousing-lynx-8c4dc9@leitao>
References: <20241003-savvy-efficient-locust-ae7bbc@leitao>
 <20241003153231.GV5594@noisy.programming.kicks-ass.net>
 <20241003-mahogany-quail-of-reading-eeee7e@leitao>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003-mahogany-quail-of-reading-eeee7e@leitao>

Hello Peter,

On Thu, Oct 03, 2024 at 08:41:53AM -0700, Breno Leitao wrote:
> > > Here is the full log, based on commit 7ec462100ef91 ("Merge tag
> > > 'pull-work.unaligned' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs")
> > 
> > This looks like the normal lockdep splat you get when the scheduler does
> > printk. I suspect you tripped a WARN, but since you only provided the
> > lockdep output and not the whole log, I cannot tell.
> 
> Thanks for the quick answer. I didn't see a warning before the lockdep
> splat, at least in the usual way I am familiar with. Let me past the
> full log below.
> 
> > There is a fix in:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/urgent
> > 
> > that might, or might not help. I can't tell.
> 
> Thanks. I will try it soon.

I've just tested your branch "sched/urgent", and the problem is still
there. I've tested against:

	d4ac164bde7a ("sched/eevdf: Fix wakeup-preempt by checking cfs_rq->nr_running")

Here is the full log:

	 Linux version 6.12.0-rc1-kbuilder-virtme-00033-gd4ac164bde7a (leit@devvm32600.lla0.foo.com) (clang version 20.0.0git (https://github.com/llvm/llvm-project.git d0f67773b213383b6e1c9331fb00f2d4c14bfcb2), LLD 18.0.0) #50 SMP PREEMPT_DYNAMIC Fri Oct  4 01:54:44 PDT 2024
	 Command line: virtme_hostname=virtme-ng nr_open=2500000 virtme_link_mods=/home/leit/Devel/upstream/.virtme_mods/lib/modules/0.0.0 console=hvc0 earlyprintk=serial,ttyS0,115200 virtme_console=ttyS0 psmouse.proto=exps "virtme_stty_con=rows 43 cols 235 iutf8" TERM=xterm-256color virtme.dhcp net.ifnames=0 biosdevname=0 virtme_chdir=home/leit/Devel/upstream netconsole=+6666@2401:db00:3120:21a9:face:0000:0270:0000/eth0,1514@2803:6080:a89c:a670::1/02:90:fb:66:aa:e5 init=/home/leit/venv/lib/python3.8/site-packages/virtme/guest/bin/virtme-ng-init
	 BIOS-provided physical RAM map:
	 BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
	 BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
	 BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
	 BIOS-e820: [mem 0x0000000000100000-0x00000000bffdffff] usable
	 BIOS-e820: [mem 0x00000000bffe0000-0x00000000bfffffff] reserved
	 BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
	 BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
	 BIOS-e820: [mem 0x0000000100000000-0x00000002bfffffff] usable
	 BIOS-e820: [mem 0x000000fd00000000-0x000000ffffffffff] reserved
	 printk: legacy bootconsole [earlyser0] enabled
	 NX (Execute Disable) protection: active
	 APIC: Static calls initialized
	 SMBIOS 2.8 present.
	 DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
	 DMI: Memory slots populated: 1/1
	 e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
	 e820: remove [mem 0x000a0000-0x000fffff] usable
	 last_pfn = 0x2c0000 max_arch_pfn = 0x10000000000
	 MTRR map: 4 entries (3 fixed + 1 variable; max 19), built from 8 variable MTRRs
	 x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
	 last_pfn = 0xbffe0 max_arch_pfn = 0x10000000000
	 found SMP MP-table at [mem 0x000f5470-0x000f547f]
	 RAMDISK: [mem 0xbf218000-0xbffdffff]
	 ACPI: Early table checksum verification disabled
	 ACPI: RSDP 0x00000000000F5270 000014 (v00 BOCHS )
	 ACPI: RSDT 0x00000000BFFE2C55 000038 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
	 ACPI: FACP 0x00000000BFFE2889 000074 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
	 ACPI: DSDT 0x00000000BFFE0040 002849 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
	 ACPI: FACS 0x00000000BFFE0000 000040
	 ACPI: APIC 0x00000000BFFE28FD 000110 (v03 BOCHS  BXPC     00000001 BXPC 00000001)
	 ACPI: HPET 0x00000000BFFE2A0D 000038 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
	 ACPI: SRAT 0x00000000BFFE2A45 0001E8 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
	 ACPI: WAET 0x00000000BFFE2C2D 000028 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
	 ACPI: Reserving FACP table memory at [mem 0xbffe2889-0xbffe28fc]
	 ACPI: Reserving DSDT table memory at [mem 0xbffe0040-0xbffe2888]
	 ACPI: Reserving FACS table memory at [mem 0xbffe0000-0xbffe003f]
	 ACPI: Reserving APIC table memory at [mem 0xbffe28fd-0xbffe2a0c]
	 ACPI: Reserving HPET table memory at [mem 0xbffe2a0d-0xbffe2a44]
	 ACPI: Reserving SRAT table memory at [mem 0xbffe2a45-0xbffe2c2c]
	 ACPI: Reserving WAET table memory at [mem 0xbffe2c2d-0xbffe2c54]
	 ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
	 ACPI: SRAT: Node 0 PXM 0 [mem 0x00100000-0xbfffffff]
	 ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x2bfffffff]
	 NUMA: Node 0 [mem 0x00001000-0x0009ffff] + [mem 0x00100000-0xbfffffff] -> [mem 0x00001000-0xbfffffff]
	 NUMA: Node 0 [mem 0x00001000-0xbfffffff] + [mem 0x100000000-0x2bfffffff] -> [mem 0x00001000-0x2bfffffff]
	 NODE_DATA(0) allocated [mem 0x2bebf6ac0-0x2bebfbdff]
	 Zone ranges:
	   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
	   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
	   Normal   [mem 0x0000000100000000-0x00000002bfffffff]
	   Device   empty
	 Movable zone start for each node
	 Early memory node ranges
	   node   0: [mem 0x0000000000001000-0x000000000009efff]
	   node   0: [mem 0x0000000000100000-0x00000000bffdffff]
	   node   0: [mem 0x0000000100000000-0x00000002bfffffff]
	 Initmem setup node 0 [mem 0x0000000000001000-0x00000002bfffffff]
	 On node 0, zone DMA: 1 pages in unavailable ranges
	 On node 0, zone DMA: 97 pages in unavailable ranges
	 On node 0, zone Normal: 32 pages in unavailable ranges
	 kasan: KernelAddressSanitizer initialized
	 ACPI: PM-Timer IO Port: 0x608
	 ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
	 IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
	 ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
	 ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
	 ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
	 ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
	 ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
	 ACPI: Using ACPI (MADT) for SMP configuration information
	 ACPI: HPET id: 0x8086a201 base: 0xfed00000
	 TSC deadline timer available
	 CPU topo: Max. logical packages:   1
	 CPU topo: Max. logical dies:       1
	 CPU topo: Max. dies per package:   1
	 CPU topo: Max. threads per core:   1
	 CPU topo: Num. cores per package:    20
	 CPU topo: Num. threads per package:  20
	 CPU topo: Allowing 20 present CPUs plus 0 hotplug CPUs
	 [mem 0xc0000000-0xfeffbfff] available for PCI devices
	 clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
	 setup_percpu: NR_CPUS:512 nr_cpumask_bits:20 nr_cpu_ids:20 nr_node_ids:1
	 percpu: Embedded 89 pages/cpu s326416 r8192 d29936 u524288
	 pcpu-alloc: s326416 r8192 d29936 u524288 alloc=1*2097152
	 pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07
	 pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15
	 pcpu-alloc: [0] 16 17 18 19
	 Kernel command line: virtme_hostname=virtme-ng nr_open=2500000 virtme_link_mods=/home/leit/Devel/upstream/.virtme_mods/lib/modules/0.0.0 console=hvc0 earlyprintk=serial,ttyS0,115200 virtme_console=ttyS0 psmouse.proto=exps "virtme_stty_con=rows 43 cols 235 iutf8" TERM=xterm-256color virtme.dhcp net.ifnames=0 biosdevname=0 virtme_chdir=home/leit/Devel/upstream netconsole=+6666@2401:db00:3120:21a9:face:0000:0270:0000/eth0,1514@2803:6080:a89c:a670::1/02:90:fb:66:aa:e5 init=/home/leit/venv/lib/python3.8/site-packages/virtme/guest/bin/virtme-ng-init
	 Unknown kernel command line parameters "virtme_hostname=virtme-ng nr_open=2500000 virtme_link_mods=/home/leit/Devel/upstream/.virtme_mods/lib/modules/0.0.0 virtme_console=ttyS0 virtme_stty_con=rows 43 cols 235 iutf8 biosdevname=0 virtme_chdir=home/leit/Devel/upstream", will be passed to user space.
	 random: crng init done
	 Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
	 Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
	 Fallback order for Node 0: 0
	 Built 1 zonelists, mobility grouping on.  Total pages: 2621310
	 Policy zone: Normal
	 mem auto-init: stack:off, heap alloc:off, heap free:off
	 stackdepot: allocating hash table via alloc_large_system_hash
	 stackdepot hash table entries: 1048576 (order: 12, 16777216 bytes, linear)
	 software IO TLB: area num 32.
	 SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=20, Nodes=1
	 allocated 20971520 bytes of page_ext
	 ftrace: allocating 58899 entries in 231 pages
	 ftrace: allocated 231 pages with 6 groups
	 Dynamic Preempt: none
	 Running RCU self tests
	 Running RCU synchronous self tests
	 rcu: Preemptible hierarchical RCU implementation.
	 rcu: 	RCU event tracing is enabled.
	 rcu: 	RCU lockdep checking is enabled.
	 rcu: 	RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=20.
	 rcu: 	RCU callback double-/use-after-free debug is enabled.
	 rcu: 	RCU debug extended QS entry/exit.
		Trampoline variant of Tasks RCU enabled.
		Rude variant of Tasks RCU enabled.
		Tracing variant of Tasks RCU enabled.
	 rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
	 rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=20
	 Running RCU synchronous self tests
	 RCU Tasks: Setting shift to 5 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=20.
	 RCU Tasks Rude: Setting shift to 5 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=20.
	 RCU Tasks Trace: Setting shift to 5 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=20.
	 NR_IRQS: 33024, nr_irqs: 584, preallocated irqs: 16
	 rcu: srcu_init: Setting srcu_struct sizes based on contention.
	 kfence: initialized - using 2097152 bytes for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
	 Console: colour *CGA 80x25
	 Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
	 ... MAX_LOCKDEP_SUBCLASSES:  8
	 ... MAX_LOCK_DEPTH:          48
	 ... MAX_LOCKDEP_KEYS:        8192
	 ... CLASSHASH_SIZE:          4096
	 ... MAX_LOCKDEP_ENTRIES:     1048576
	 ... MAX_LOCKDEP_CHAINS:      1048576
	 ... CHAINHASH_SIZE:          524288
	  memory used by lock dependency info: 106625 kB
	  memory used for stack traces: 4224 kB
	  per task-struct memory footprint: 1920 bytes
	 ACPI: Core revision 20240827
	 clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
	 APIC: Switch to symmetric I/O mode setup
	 ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
	 tsc: Unable to calibrate against PIT
	 tsc: using HPET reference calibration
	 tsc: Detected 1199.814 MHz processor
	 clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x114b6c033ac, max_idle_ns: 440795260201 ns
	 Calibrating delay loop (skipped), value calculated using timer frequency.. 2399.62 BogoMIPS (lpj=1199814)
	 x86/cpu: User Mode Instruction Prevention (UMIP) activated
	 numa_add_cpu cpu 0 node 0: mask now 0
	 Last level iTLB entries: 4KB 512, 2MB 255, 4MB 127
	 Last level dTLB entries: 4KB 512, 2MB 255, 4MB 127, 1GB 0
	 Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
	 Spectre V2 : Mitigation: Retpolines
	 Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
	 Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
	 Spectre V2 : Enabling Restricted Speculation for firmware calls
	 Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
	 Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
	 Speculative Return Stack Overflow: IBPB-extending microcode not applied!
	 Speculative Return Stack Overflow: WARNING: See https://kernel.org/doc/html/latest/admin-guide/hw-vuln/srso.html for mitigation options.
	 Speculative Return Stack Overflow: Vulnerable: Safe RET, no microcode
	 x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
	 x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
	 x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
	 x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
	 x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
	 x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
	 x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
	 x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
	 x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
	 x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
	 x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
	 x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
	 x86/fpu: Enabled xstate features 0x2e7, context size is 2440 bytes, using 'compacted' format.
	 debug: unmapping init [mem 0xffffffff883ea000-0xffffffff883f6fff]
	 pid_max: default: 32768 minimum: 301
	 LSM: initializing lsm=capability,bpf,ima
	 LSM support for eBPF active
	 Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
	 Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
	 Running RCU synchronous self tests
	 Running RCU synchronous self tests
	 smpboot: CPU0: AMD EPYC-Milan Processor (family: 0x19, model: 0x1, stepping: 0x1)
	 psi: inconsistent task state! task=1:swapper/0 cpu=0 psi_flags=4 clear=0 set=4
	 Running RCU Tasks wait API self tests
	 Running RCU Tasks Rude wait API self tests
	 Running RCU Tasks Trace wait API self tests
	 Performance Events: Fam17h+ core perfctr, AMD PMU driver.
	 ... version:                0
	 ... bit width:              48
	 ... generic registers:      6
	 ... value mask:             0000ffffffffffff
	 ... max period:             00007fffffffffff
	 ... fixed-purpose events:   0
	 ... event mask:             000000000000003f
	 Callback from call_rcu_tasks_trace() invoked.
	 signal: max sigframe size: 2976
	 rcu: Hierarchical SRCU implementation.
	 rcu: 	Max phase no-delay instances is 400.
	 Timer migration: 2 hierarchy levels; 8 children per group; 2 crossnode level
	 smp: Bringing up secondary CPUs ...
	 smpboot: x86: Booting SMP configuration:
	 .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9 #10 #11 #12 #13 #14 #15 #16
	 Callback from call_rcu_tasks() invoked.
	  #17 #18 #19
	 numa_add_cpu cpu 1 node 0: mask now 0-1
	 numa_add_cpu cpu 2 node 0: mask now 0-2
	 numa_add_cpu cpu 3 node 0: mask now 0-3
	 numa_add_cpu cpu 4 node 0: mask now 0-4
	 numa_add_cpu cpu 5 node 0: mask now 0-5
	 numa_add_cpu cpu 6 node 0: mask now 0-6
	 numa_add_cpu cpu 7 node 0: mask now 0-7
	 numa_add_cpu cpu 8 node 0: mask now 0-8
	 numa_add_cpu cpu 9 node 0: mask now 0-9
	 numa_add_cpu cpu 10 node 0: mask now 0-10
	 numa_add_cpu cpu 11 node 0: mask now 0-11
	 numa_add_cpu cpu 12 node 0: mask now 0-12
	 numa_add_cpu cpu 13 node 0: mask now 0-13
	 numa_add_cpu cpu 14 node 0: mask now 0-14
	 numa_add_cpu cpu 15 node 0: mask now 0-15
	 numa_add_cpu cpu 16 node 0: mask now 0-16
	 numa_add_cpu cpu 17 node 0: mask now 0-17
	 numa_add_cpu cpu 18 node 0: mask now 0-18
	 numa_add_cpu cpu 19 node 0: mask now 0-19
	 smp: Brought up 1 node, 20 CPUs
	 smpboot: Total of 20 processors activated (49565.36 BogoMIPS)
	 Memory: 8470476K/10485240K available (57344K kernel code, 19394K rwdata, 22616K rodata, 7488K init, 167972K bss, 1964852K reserved, 0K cma-reserved)
	 devtmpfs: initialized
	 x86/mm: Memory block size: 128MB
	 Running RCU synchronous self tests
	 Running RCU synchronous self tests
	 DMA-API: preallocated 65536 debug entries
	 DMA-API: debugging enabled by kernel config
	 clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
	 futex hash table entries: 8192 (order: 8, 1048576 bytes, linear)
	 pinctrl core: initialized pinctrl subsystem
	 NET: Registered PF_NETLINK/PF_ROUTE protocol family
	 audit: initializing netlink subsys (disabled)
	 audit: type=2000 audit(1728032147.986:1): state=initialized audit_enabled=0 res=1
	 thermal_sys: Registered thermal governor 'step_wise'
	 thermal_sys: Registered thermal governor 'user_space'
	 cpuidle: using governor menu
	 PCI: Using configuration type 1 for base access
	 PCI: Using configuration type 1 for extended access
	 kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
	 HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
	 HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
	 HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
	 HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
	 cryptd: max_cpu_qlen set to 1000
	 raid6: avx512x4 gen() 33291 MB/s
	 raid6: avx512x2 gen() 32437 MB/s
	 raid6: avx512x1 gen() 25182 MB/s
	 raid6: avx2x4   gen() 22536 MB/s
	 raid6: avx2x2   gen() 19688 MB/s
	 raid6: avx2x1   gen() 15251 MB/s
	 raid6: using algorithm avx512x4 gen() 33291 MB/s
	 raid6: .... xor() 6618 MB/s, rmw enabled
	 raid6: using avx512x2 recovery algorithm
	 ACPI: Added _OSI(Module Device)
	 ACPI: Added _OSI(Processor Device)
	 ACPI: Added _OSI(3.0 _SCP Extensions)
	 ACPI: Added _OSI(Processor Aggregator Device)
	 ACPI: 1 ACPI AML tables successfully acquired and loaded
	 ACPI: Interpreter enabled
	 ACPI: PM: (supports S0 S3 S5)
	 ACPI: Using IOAPIC for interrupt routing
	 PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
	 PCI: Using E820 reservations for host bridge windows
	 ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
	 acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
	 PCI host bridge to bus 0000:00
	 pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
	 pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
	 pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
	 pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfffff window]
	 pci_bus 0000:00: root bus resource [mem 0xc000000000-0xc07fffffff window]
	 pci_bus 0000:00: root bus resource [bus 00-ff]
	 pci 0000:00:00.0: [8086:1237] type 00 class 0x060000 conventional PCI endpoint
	 pci 0000:00:01.0: [8086:7000] type 00 class 0x060100 conventional PCI endpoint
	 pci 0000:00:01.1: [8086:7010] type 00 class 0x010180 conventional PCI endpoint
	 pci 0000:00:01.1: BAR 4 [io  0xc060-0xc06f]
	 pci 0000:00:01.1: BAR 0 [io  0x01f0-0x01f7]: legacy IDE quirk
	 pci 0000:00:01.1: BAR 1 [io  0x03f6]: legacy IDE quirk
	 pci 0000:00:01.1: BAR 2 [io  0x0170-0x0177]: legacy IDE quirk
	 pci 0000:00:01.1: BAR 3 [io  0x0376]: legacy IDE quirk
	 pci 0000:00:01.3: [8086:7113] type 00 class 0x068000 conventional PCI endpoint
	 pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
	 pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
	 pci 0000:00:02.0: [1af4:105a] type 00 class 0x018000 conventional PCI endpoint
	 pci 0000:00:02.0: BAR 1 [mem 0xfebc0000-0xfebc0fff]
	 pci 0000:00:02.0: BAR 4 [mem 0xc000000000-0xc000003fff 64bit pref]
	 pci 0000:00:03.0: [8086:25ab] type 00 class 0x088000 conventional PCI endpoint
	 pci 0000:00:03.0: BAR 0 [mem 0xfebc1000-0xfebc100f]
	 pci 0000:00:04.0: [1af4:1003] type 00 class 0x078000 conventional PCI endpoint
	 pci 0000:00:04.0: BAR 0 [io  0xc000-0xc03f]
	 pci 0000:00:04.0: BAR 1 [mem 0xfebc2000-0xfebc2fff]
	 pci 0000:00:04.0: BAR 4 [mem 0xc000004000-0xc000007fff 64bit pref]
	 pci 0000:00:05.0: [1af4:1000] type 00 class 0x020000 conventional PCI endpoint
	 pci 0000:00:05.0: BAR 0 [io  0xc040-0xc05f]
	 pci 0000:00:05.0: BAR 1 [mem 0xfebc3000-0xfebc3fff]
	 pci 0000:00:05.0: BAR 4 [mem 0xc000008000-0xc00000bfff 64bit pref]
	 pci 0000:00:05.0: ROM [mem 0xfeb80000-0xfebbffff pref]
	 ACPI: PCI: Interrupt link LNKA configured for IRQ 10
	 ACPI: PCI: Interrupt link LNKB configured for IRQ 10
	 ACPI: PCI: Interrupt link LNKC configured for IRQ 11
	 ACPI: PCI: Interrupt link LNKD configured for IRQ 11
	 ACPI: PCI: Interrupt link LNKS configured for IRQ 9
	 iommu: Default domain type: Translated
	 iommu: DMA domain TLB invalidation policy: lazy mode
	 SCSI subsystem initialized
	 libata version 3.00 loaded.
	 ACPI: bus type USB registered
	 usbcore: registered new interface driver usbfs
	 usbcore: registered new interface driver hub
	 usbcore: registered new device driver usb
	 pps_core: LinuxPPS API ver. 1 registered
	 pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
	 PTP clock support registered
	 EDAC MC: Ver: 3.0.0
	 PCI: Using ACPI for IRQ routing
	 PCI: pci_cache_line_size set to 64 bytes
	 e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
	 e820: reserve RAM buffer [mem 0xbffe0000-0xbfffffff]
	 clocksource: Switched to clocksource tsc-early
	 VFS: Disk quotas dquot_6.6.0
	 VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
	 pnp: PnP ACPI init
	 pnp 00:02: [dma 2]
	 pnp: PnP ACPI: found 5 devices
	 clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
	 NET: Registered PF_INET protocol family
	 IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
	 tcp_listen_portaddr_hash hash table entries: 8192 (order: 7, 589824 bytes, linear)
	 Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
	 TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
	 TCP bind hash table entries: 65536 (order: 11, 9437184 bytes, vmalloc hugepage)
	 TCP: Hash tables configured (established 131072 bind 65536)
	 MPTCP token hash table entries: 16384 (order: 8, 1441792 bytes, linear)
	 UDP hash table entries: 8192 (order: 8, 1310720 bytes, linear)
	 UDP-Lite hash table entries: 8192 (order: 8, 1310720 bytes, linear)
	 NET: Registered PF_UNIX/PF_LOCAL protocol family
	 NET: Registered PF_XDP protocol family
	 pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
	 pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
	 pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
	 pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfffff window]
	 pci_bus 0000:00: resource 8 [mem 0xc000000000-0xc07fffffff window]
	 pci 0000:00:01.0: PIIX3: Enabling Passive Release
	 pci 0000:00:00.0: Limiting direct PCI/PCI transfers
	 PCI: CLS 0 bytes, default 64
	 PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
	 software IO TLB: mapped [mem 0x00000000bb218000-0x00000000bf218000] (64MB)
	 Trying to unpack rootfs image as initramfs...
	 Initialise system trusted keyrings
	 workingset: timestamp_bits=40 max_order=22 bucket_order=0
	 fuse: init (API version 7.41)
	 SGI XFS with ACLs, security attributes, realtime, verbose warnings, quota, no debug enabled
	 NET: Registered PF_ALG protocol family
	 xor: automatically using best checksumming function   avx
	 Key type asymmetric registered
	 Asymmetric key parser 'x509' registered
	 Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
	 io scheduler mq-deadline registered
	 io scheduler kyber registered
	 debug: unmapping init [mem 0xff110000bf218000-0xff110000bffdffff]
	 ACPI: _SB_.LNKB: Enabled at IRQ 10
	 virtiofs virtio0: virtio_fs_setup_dax: No cache capability
	 ACPI: _SB_.LNKD: Enabled at IRQ 11
	 ACPI: _SB_.LNKA: Enabled at IRQ 10
	 Serial: 8250/16550 driver, 16 ports, IRQ sharing enabled
	 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
	 tsc: Refined TSC clocksource calibration: 1199.960 MHz
	 clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x114bf5f8779, max_idle_ns: 440795246166 ns
	 clocksource: Switched to clocksource tsc
	 printk: legacy console [hvc0] enabled
	 printk: legacy bootconsole [earlyser0] disabled
	 wireguard: WireGuard 1.0.0 loaded. See www.wireguard.com for information.
	 wireguard: Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
	 igb: Intel(R) Gigabit Ethernet Network Driver
	 igb: Copyright (c) 2007-2014 Intel Corporation.
	 ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver
	 ixgbe: Copyright (c) 1999-2016 Intel Corporation.
	 usbcore: registered new interface driver ark3116
	 usbserial: USB Serial support registered for ark3116
	 usbcore: registered new interface driver pl2303
	 usbserial: USB Serial support registered for pl2303
	 i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
	 serio: i8042 KBD port at 0x60,0x64 irq 1
	 serio: i8042 AUX port at 0x60,0x64 irq 12
	 rtc_cmos 00:04: RTC can wake from S4
	 rtc_cmos 00:04: registered as rtc0
	 rtc_cmos 00:04: setting system clock to 2024-10-04T08:55:52 UTC (1728032152)
	 rtc_cmos 00:04: alarms up to one day, y3k, 242 bytes nvram, hpet irqs
	 input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
	 i2c_dev: i2c /dev entries driver
	 device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
	 device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@lists.linux.dev
	 amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled
	 usbcore: registered new interface driver usbhid
	 usbhid: USB HID core driver
	 Initializing XFRM netlink socket
	 NET: Registered PF_INET6 protocol family
	 Segment Routing with IPv6
	 In-situ OAM (IOAM) with IPv6
	 NET: Registered PF_PACKET protocol family
	 Key type dns_resolver registered
	 NET: Registered PF_VSOCK protocol family
	 start plist test
	 end plist test
	 IPI shorthand broadcast: enabled
	 sched_clock: Marking stable (6385031761, -10224835)->(6687265139, -312458213)
	 registered taskstats version 1
	 Loading compiled-in X.509 certificates
	 virtme initramfs: initramfs does not have module crypto-pkcs1pad(rsa,sha512)
	 virtme initramfs: initramfs does not have module crypto-pkcs1pad(rsa,sha512)-all
	 Loaded X.509 cert 'Build time autogenerated kernel key: 1a58da0881b870ef3decd7cf414d45e41b0e363a'
	 Demotion targets for Node 0: null
	 kmemleak: Automatic memory scanning thread started
	 kmemleak: Kernel memory leak detector initialized (mem pool available: 197817)
	 page_owner is disabled
	 Btrfs loaded, assert=on, zoned=no, fsverity=yes
	 ima: No TPM chip found, activating TPM-bypass!
	 ima: Allocated hash algorithm: sha256
	 ima: No architecture policies found
	 netpoll: netconsole: local port 6666
	 netpoll: netconsole: local IPv6 address 2401:db00:3120:21a9:face:0:270:0
	 netpoll: netconsole: interface 'eth0'
	 netpoll: netconsole: remote port 1514
	 netpoll: netconsole: remote IPv6 address 2803:6080:a89c:a670::1
	 netpoll: netconsole: remote ethernet address 02:90:fb:66:aa:e5
	 netpoll: netconsole: device eth0 not up yet, forcing it
	 printk: legacy console [netcon_ext0] enabled

	 =====================================================
	 WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
	 6.12.0-rc1-kbuilder-virtme-00033-gd4ac164bde7a #50 Not tainted
	 -----------------------------------------------------
	 swapper/0/1 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
	 ff1100010a260518 (_xmit_ETHER#2){+.-.}-{2:2}, at: virtnet_poll_tx (./include/linux/netdevice.h:4361 drivers/net/virtio_net.c:2969) 

	and this task is already holding:
	 ffffffff86f2b5b8 (target_list_lock){....}-{2:2}, at: write_ext_msg (drivers/net/netconsole.c:?) 
	 which would create a new lock dependency:
	  (target_list_lock){....}-{2:2} -> (_xmit_ETHER#2){+.-.}-{2:2}

	but this new dependency connects a HARDIRQ-irq-safe lock:
	  (console_owner){-...}-{0:0}

	... which became HARDIRQ-irq-safe at:
	 lock_acquire (kernel/locking/lockdep.c:5825) 
	 console_flush_all (kernel/printk/printk.c:1905 kernel/printk/printk.c:3086 kernel/printk/printk.c:3180) 
	 console_unlock (kernel/printk/printk.c:3239 kernel/printk/printk.c:3279) 
	 wake_up_klogd_work_func (kernel/printk/printk.c:4466) 
	 irq_work_single (kernel/irq_work.c:222) 
	 irq_work_tick (kernel/irq_work.c:? kernel/irq_work.c:277) 
	 update_process_times (kernel/time/timer.c:2524) 
	 tick_handle_periodic (kernel/time/tick-common.c:120) 
	 __sysvec_apic_timer_interrupt (./arch/x86/include/asm/jump_label.h:27 ./include/linux/jump_label.h:207 ./arch/x86/include/asm/trace/irq_vectors.h:41 arch/x86/kernel/apic/apic.c:1044) 
	 sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1037 arch/x86/kernel/apic/apic.c:1037) 
	 asm_sysvec_apic_timer_interrupt (./arch/x86/include/asm/idtentry.h:702) 
	 memset (arch/x86/lib/memset_64.S:38) 
	 __unwind_start (arch/x86/kernel/unwind_orc.c:?) 
	 arch_stack_walk (./arch/x86/include/asm/unwind.h:50 arch/x86/kernel/stacktrace.c:24) 
	 stack_trace_save (kernel/stacktrace.c:123) 
	 kasan_save_stack (mm/kasan/common.c:48) 
	 __kasan_record_aux_stack (mm/kasan/generic.c:541) 
	 call_rcu (./arch/x86/include/asm/irqflags.h:26 ./arch/x86/include/asm/irqflags.h:87 ./arch/x86/include/asm/irqflags.h:123 kernel/rcu/tree.c:3087 kernel/rcu/tree.c:3190) 
	 kfree (mm/slub.c:2271 mm/slub.c:4580 mm/slub.c:4728) 
	 __kthread_create_on_node (kernel/kthread.c:479) 
	 __kthread_create_worker (kernel/kthread.c:882) 
	 kthread_create_worker (kernel/kthread.c:919) 
	 wq_cpu_intensive_thresh_init (kernel/workqueue.c:7817) 
	 workqueue_init (kernel/workqueue.c:?) 
	 kernel_init_freeable (init/main.c:1566) 
	 kernel_init (init/main.c:1471) 
	 ret_from_fork (arch/x86/kernel/process.c:153) 
	 ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 

	to a HARDIRQ-irq-unsafe lock:
	  (_xmit_ETHER#2){+.-.}-{2:2}

	... which became HARDIRQ-irq-unsafe at:
	 ...
	 lock_acquire (kernel/locking/lockdep.c:5825) 
	 _raw_spin_trylock (./include/linux/spinlock_api_smp.h:90 kernel/locking/spinlock.c:138) 
	 virtnet_poll (./include/linux/netdevice.h:4384 drivers/net/virtio_net.c:2768 drivers/net/virtio_net.c:2821) 
	 __napi_poll (net/core/dev.c:6771) 
	 net_rx_action (net/core/dev.c:6840 net/core/dev.c:6962) 
	 handle_softirqs (./arch/x86/include/asm/jump_label.h:27 ./include/linux/jump_label.h:207 ./include/trace/events/irq.h:142 kernel/softirq.c:555) 
	 do_softirq (kernel/softirq.c:455) 
	 __local_bh_enable_ip (kernel/softirq.c:?) 
	 virtnet_open (./include/linux/bottom_half.h:? drivers/net/virtio_net.c:2619 drivers/net/virtio_net.c:2876 drivers/net/virtio_net.c:2925) 
	 __dev_open (net/core/dev.c:1476) 
	 dev_open (net/core/dev.c:1513) 
	 netpoll_setup (net/core/netpoll.c:701) 
	 init_netconsole (drivers/net/netconsole.c:1261 drivers/net/netconsole.c:1312) 
	 do_one_initcall (init/main.c:1269) 
	 do_initcall_level (init/main.c:1330) 
	 do_initcalls (init/main.c:1344) 
	 kernel_init_freeable (init/main.c:1582) 
	 kernel_init (init/main.c:1471) 
	 ret_from_fork (arch/x86/kernel/process.c:153) 
	 ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 

	other info that might help us debug this:

	 Chain exists of:
	console_owner --> target_list_lock --> _xmit_ETHER#2

	  Possible interrupt unsafe locking scenario:

		CPU0                    CPU1
		----                    ----
	   lock(_xmit_ETHER#2);
					local_irq_disable();
					lock(console_owner);
					lock(target_list_lock);
	   <Interrupt>
	     lock(console_owner);

	*** DEADLOCK ***

	 6 locks held by swapper/0/1:
	 #0: ffffffff861afda8 (console_mutex){+.+.}-{3:3}, at: register_console (kernel/printk/printk.c:113 kernel/printk/printk.c:3933) 
	 #1: ffffffff861b0400 (console_lock){+.+.}-{0:0}, at: _printk (kernel/printk/printk.c:2435) 
	 #2: ffffffff861afe10 (console_srcu){....}-{0:0}, at: console_flush_all (./include/linux/rcupdate.h:? ./include/linux/srcu.h:267 kernel/printk/printk.c:288 kernel/printk/printk.c:3157) 
	 #3: ffffffff861b03a0 (console_owner){-...}-{0:0}, at: console_flush_all (./include/linux/rcupdate.h:? ./include/linux/srcu.h:267 kernel/printk/printk.c:288 kernel/printk/printk.c:3157) 
	 #4: ffffffff86930cc0 (printk_legacy_map-wait-type-override){....}-{3:3}, at: console_flush_all (./include/linux/rcupdate.h:? ./include/linux/srcu.h:267 kernel/printk/printk.c:288 kernel/printk/printk.c:3157) 
	 #5: ffffffff86f2b5b8 (target_list_lock){....}-{2:2}, at: write_ext_msg (drivers/net/netconsole.c:?) 

	the dependencies between HARDIRQ-irq-safe lock and the holding lock:
	  -> (console_owner){-...}-{0:0} ops: 1984 {
	     IN-HARDIRQ-W at:
	 lock_acquire (kernel/locking/lockdep.c:5825) 
	 console_flush_all (kernel/printk/printk.c:1905 kernel/printk/printk.c:3086 kernel/printk/printk.c:3180) 
	 console_unlock (kernel/printk/printk.c:3239 kernel/printk/printk.c:3279) 
	 wake_up_klogd_work_func (kernel/printk/printk.c:4466) 
	 irq_work_single (kernel/irq_work.c:222) 
	 irq_work_tick (kernel/irq_work.c:? kernel/irq_work.c:277) 
	 update_process_times (kernel/time/timer.c:2524) 
	 tick_handle_periodic (kernel/time/tick-common.c:120) 
	 __sysvec_apic_timer_interrupt (./arch/x86/include/asm/jump_label.h:27 ./include/linux/jump_label.h:207 ./arch/x86/include/asm/trace/irq_vectors.h:41 arch/x86/kernel/apic/apic.c:1044) 
	 sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1037 arch/x86/kernel/apic/apic.c:1037) 
	 asm_sysvec_apic_timer_interrupt (./arch/x86/include/asm/idtentry.h:702) 
	 memset (arch/x86/lib/memset_64.S:38) 
	 __unwind_start (arch/x86/kernel/unwind_orc.c:?) 
	 arch_stack_walk (./arch/x86/include/asm/unwind.h:50 arch/x86/kernel/stacktrace.c:24) 
	 stack_trace_save (kernel/stacktrace.c:123) 
	 kasan_save_stack (mm/kasan/common.c:48) 
	 __kasan_record_aux_stack (mm/kasan/generic.c:541) 
	 call_rcu (./arch/x86/include/asm/irqflags.h:26 ./arch/x86/include/asm/irqflags.h:87 ./arch/x86/include/asm/irqflags.h:123 kernel/rcu/tree.c:3087 kernel/rcu/tree.c:3190) 
	 kfree (mm/slub.c:2271 mm/slub.c:4580 mm/slub.c:4728) 
	 __kthread_create_on_node (kernel/kthread.c:479) 
	 __kthread_create_worker (kernel/kthread.c:882) 
	 kthread_create_worker (kernel/kthread.c:919) 
	 wq_cpu_intensive_thresh_init (kernel/workqueue.c:7817) 
	 workqueue_init (kernel/workqueue.c:?) 
	 kernel_init_freeable (init/main.c:1566) 
	 kernel_init (init/main.c:1471) 
	 ret_from_fork (arch/x86/kernel/process.c:153) 
	 ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
	     INITIAL USE at:
	   }
	 ... key at: console_owner_dep_map+0x0/0x60 
	 -> (target_list_lock){....}-{2:2} ops: 3 {
	    INITIAL USE at:
	 lock_acquire (kernel/locking/lockdep.c:5825) 
	 _raw_spin_lock_irqsave (./include/linux/spinlock_api_smp.h:110 kernel/locking/spinlock.c:162) 
	 init_netconsole (drivers/net/netconsole.c:1327) 
	 do_one_initcall (init/main.c:1269) 
	 do_initcall_level (init/main.c:1330) 
	 do_initcalls (init/main.c:1344) 
	 kernel_init_freeable (init/main.c:1582) 
	 kernel_init (init/main.c:1471) 
	 ret_from_fork (arch/x86/kernel/process.c:153) 
	 ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
	  }
	 ... key at: target_list_lock+0x18/0x60 
	  ... acquired at:
	 lock_acquire (kernel/locking/lockdep.c:5825) 
	 _raw_spin_lock_irqsave (./include/linux/spinlock_api_smp.h:110 kernel/locking/spinlock.c:162) 
	 write_ext_msg (drivers/net/netconsole.c:?) 
	 console_flush_all (kernel/printk/printk.c:3009 kernel/printk/printk.c:3093 kernel/printk/printk.c:3180) 
	 console_unlock (kernel/printk/printk.c:3239 kernel/printk/printk.c:3279) 
	 vprintk_emit (kernel/printk/printk.c:?) 
	 _printk (kernel/printk/printk.c:2435) 
	 register_console (kernel/printk/printk.c:4070) 
	 init_netconsole (drivers/net/netconsole.c:1344) 
	 do_one_initcall (init/main.c:1269) 
	 do_initcall_level (init/main.c:1330) 
	 do_initcalls (init/main.c:1344) 
	 kernel_init_freeable (init/main.c:1582) 
	 kernel_init (init/main.c:1471) 
	 ret_from_fork (arch/x86/kernel/process.c:153) 
	 ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 


	the dependencies between the lock to be acquired
	  and HARDIRQ-irq-unsafe lock:
	 -> (_xmit_ETHER#2){+.-.}-{2:2} ops: 7 {
	    HARDIRQ-ON-W at:
	 lock_acquire (kernel/locking/lockdep.c:5825) 
	 _raw_spin_trylock (./include/linux/spinlock_api_smp.h:90 kernel/locking/spinlock.c:138) 
	 virtnet_poll (./include/linux/netdevice.h:4384 drivers/net/virtio_net.c:2768 drivers/net/virtio_net.c:2821) 
	 __napi_poll (net/core/dev.c:6771) 
	 net_rx_action (net/core/dev.c:6840 net/core/dev.c:6962) 
	 handle_softirqs (./arch/x86/include/asm/jump_label.h:27 ./include/linux/jump_label.h:207 ./include/trace/events/irq.h:142 kernel/softirq.c:555) 
	 do_softirq (kernel/softirq.c:455) 
	 __local_bh_enable_ip (kernel/softirq.c:?) 
	 virtnet_open (./include/linux/bottom_half.h:? drivers/net/virtio_net.c:2619 drivers/net/virtio_net.c:2876 drivers/net/virtio_net.c:2925) 
	 __dev_open (net/core/dev.c:1476) 
	 dev_open (net/core/dev.c:1513) 
	 netpoll_setup (net/core/netpoll.c:701) 
	 init_netconsole (drivers/net/netconsole.c:1261 drivers/net/netconsole.c:1312) 
	 do_one_initcall (init/main.c:1269) 
	 do_initcall_level (init/main.c:1330) 
	 do_initcalls (init/main.c:1344) 
	 kernel_init_freeable (init/main.c:1582) 
	 kernel_init (init/main.c:1471) 
	 ret_from_fork (arch/x86/kernel/process.c:153) 
	 ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
	    IN-SOFTIRQ-W at:
	 lock_acquire (kernel/locking/lockdep.c:5825) 
	 _raw_spin_lock (./include/linux/spinlock_api_smp.h:133 kernel/locking/spinlock.c:154) 
	 virtnet_poll_tx (./include/linux/netdevice.h:4361 drivers/net/virtio_net.c:2969) 
	 __napi_poll (net/core/dev.c:6771) 
	 net_rx_action (net/core/dev.c:6840 net/core/dev.c:6962) 
	 handle_softirqs (./arch/x86/include/asm/jump_label.h:27 ./include/linux/jump_label.h:207 ./include/trace/events/irq.h:142 kernel/softirq.c:555) 
	 do_softirq (kernel/softirq.c:455) 
	 __local_bh_enable_ip (kernel/softirq.c:?) 
	 virtnet_open (drivers/net/virtio_net.c:2637 drivers/net/virtio_net.c:2877 drivers/net/virtio_net.c:2925) 
	 __dev_open (net/core/dev.c:1476) 
	 dev_open (net/core/dev.c:1513) 
	 netpoll_setup (net/core/netpoll.c:701) 
	 init_netconsole (drivers/net/netconsole.c:1261 drivers/net/netconsole.c:1312) 
	 do_one_initcall (init/main.c:1269) 
	 do_initcall_level (init/main.c:1330) 
	 do_initcalls (init/main.c:1344) 
	 kernel_init_freeable (init/main.c:1582) 
	 kernel_init (init/main.c:1471) 
	 ret_from_fork (arch/x86/kernel/process.c:153) 
	 ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
	    INITIAL USE at:
	 lock_acquire (kernel/locking/lockdep.c:5825) 
	 _raw_spin_trylock (./include/linux/spinlock_api_smp.h:90 kernel/locking/spinlock.c:138) 
	 virtnet_poll (./include/linux/netdevice.h:4384 drivers/net/virtio_net.c:2768 drivers/net/virtio_net.c:2821) 
	 __napi_poll (net/core/dev.c:6771) 
	 net_rx_action (net/core/dev.c:6840 net/core/dev.c:6962) 
	 handle_softirqs (./arch/x86/include/asm/jump_label.h:27 ./include/linux/jump_label.h:207 ./include/trace/events/irq.h:142 kernel/softirq.c:555) 
	 do_softirq (kernel/softirq.c:455) 
	 __local_bh_enable_ip (kernel/softirq.c:?) 
	 virtnet_open (./include/linux/bottom_half.h:? drivers/net/virtio_net.c:2619 drivers/net/virtio_net.c:2876 drivers/net/virtio_net.c:2925) 
	 __dev_open (net/core/dev.c:1476) 
	 dev_open (net/core/dev.c:1513) 
	 netpoll_setup (net/core/netpoll.c:701) 
	 init_netconsole (drivers/net/netconsole.c:1261 drivers/net/netconsole.c:1312) 
	 do_one_initcall (init/main.c:1269) 
	 do_initcall_level (init/main.c:1330) 
	 do_initcalls (init/main.c:1344) 
	 kernel_init_freeable (init/main.c:1582) 
	 kernel_init (init/main.c:1471) 
	 ret_from_fork (arch/x86/kernel/process.c:153) 
	 ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
	  }
	 ... key at: netdev_xmit_lock_key+0x10/0x480 
	  ... acquired at:
	 lock_acquire (kernel/locking/lockdep.c:5825) 
	 _raw_spin_lock (./include/linux/spinlock_api_smp.h:133 kernel/locking/spinlock.c:154) 
	 virtnet_poll_tx (./include/linux/netdevice.h:4361 drivers/net/virtio_net.c:2969) 
	 netpoll_poll_dev (net/core/netpoll.c:167 net/core/netpoll.c:180 net/core/netpoll.c:210) 
	 netpoll_send_skb (net/core/netpoll.c:360 net/core/netpoll.c:386) 
	 netpoll_send_udp (net/core/netpoll.c:494) 
	 write_ext_msg (drivers/net/netconsole.c:?) 
	 console_flush_all (kernel/printk/printk.c:3009 kernel/printk/printk.c:3093 kernel/printk/printk.c:3180) 
	 console_unlock (kernel/printk/printk.c:3239 kernel/printk/printk.c:3279) 
	 vprintk_emit (kernel/printk/printk.c:?) 
	 _printk (kernel/printk/printk.c:2435) 
	 register_console (kernel/printk/printk.c:4070) 
	 init_netconsole (drivers/net/netconsole.c:1344) 
	 do_one_initcall (init/main.c:1269) 
	 do_initcall_level (init/main.c:1330) 
	 do_initcalls (init/main.c:1344) 
	 kernel_init_freeable (init/main.c:1582) 
	 kernel_init (init/main.c:1471) 
	 ret_from_fork (arch/x86/kernel/process.c:153) 
	 ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 


	stack backtrace:
	 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
	 Call Trace:
	  <TASK>
	 dump_stack_lvl (lib/dump_stack.c:123) 
	 validate_chain (kernel/locking/lockdep.c:? kernel/locking/lockdep.c:2888 kernel/locking/lockdep.c:3165 kernel/locking/lockdep.c:3280 kernel/locking/lockdep.c:3904) 
	 __lock_acquire (kernel/locking/lockdep.c:?) 
	 lock_acquire (kernel/locking/lockdep.c:5825) 
	 ? virtnet_poll_tx (./include/linux/netdevice.h:4361 drivers/net/virtio_net.c:2969) 
	 _raw_spin_lock (./include/linux/spinlock_api_smp.h:133 kernel/locking/spinlock.c:154) 
	 ? virtnet_poll_tx (./include/linux/netdevice.h:4361 drivers/net/virtio_net.c:2969) 
	 virtnet_poll_tx (./include/linux/netdevice.h:4361 drivers/net/virtio_net.c:2969) 
	 ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182) 
	 netpoll_poll_dev (net/core/netpoll.c:167 net/core/netpoll.c:180 net/core/netpoll.c:210) 
	 netpoll_send_skb (net/core/netpoll.c:360 net/core/netpoll.c:386) 
	 netpoll_send_udp (net/core/netpoll.c:494) 
	 write_ext_msg (drivers/net/netconsole.c:?) 
	 ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182) 
	 ? console_flush_all (./include/linux/rcupdate.h:? ./include/linux/srcu.h:267 kernel/printk/printk.c:288 kernel/printk/printk.c:3157) 
	 ? console_flush_all (./include/linux/rcupdate.h:? ./include/linux/srcu.h:267 kernel/printk/printk.c:288 kernel/printk/printk.c:3157) 
	 console_flush_all (kernel/printk/printk.c:3009 kernel/printk/printk.c:3093 kernel/printk/printk.c:3180) 
	 ? console_flush_all (./include/linux/rcupdate.h:? ./include/linux/srcu.h:267 kernel/printk/printk.c:288 kernel/printk/printk.c:3157) 
	 console_unlock (kernel/printk/printk.c:3239 kernel/printk/printk.c:3279) 
	 vprintk_emit (kernel/printk/printk.c:?) 
	 ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182) 
	 _printk (kernel/printk/printk.c:2435) 
	 ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182) 
	 register_console (kernel/printk/printk.c:4070) 
	 ? configfs_register_subsystem (./include/linux/instrumented.h:96 ./include/linux/atomic/atomic-arch-fallback.h:2278 ./include/linux/atomic/atomic-instrumented.h:1384 fs/configfs/dir.c:174 fs/configfs/dir.c:1909) 
	 init_netconsole (drivers/net/netconsole.c:1344) 
	 ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182) 
	 do_one_initcall (init/main.c:1269) 
	 ? __pfx_init_netconsole (drivers/net/netconsole.c:1301) 
	 ? stack_depot_save_flags (lib/stackdepot.c:662) 
	 ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182) 
	 ? kasan_save_track (./arch/x86/include/asm/current.h:49 mm/kasan/common.c:60 mm/kasan/common.c:69) 
	 ? kasan_save_track (mm/kasan/common.c:48 mm/kasan/common.c:68) 
	 ? __kasan_kmalloc (mm/kasan/common.c:398) 
	 ? __kmalloc_noprof (./include/linux/kasan.h:257 mm/slub.c:4265 mm/slub.c:4277) 
	 ? do_initcalls (init/main.c:1341) 
	 ? kernel_init_freeable (init/main.c:1582) 
	 ? kernel_init (init/main.c:1471) 
	 ? ret_from_fork (arch/x86/kernel/process.c:153) 
	 ? ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
	 ? asm_sysvec_apic_timer_interrupt (./arch/x86/include/asm/idtentry.h:702) 
	 ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182) 
	 ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4471) 
	 ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182) 
	 ? asm_sysvec_apic_timer_interrupt (./arch/x86/include/asm/idtentry.h:702) 
	 ? __pfx_ignore_unknown_bootoption (init/main.c:1315) 
	 ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182) 
	 ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182) 
	 ? parse_args (kernel/params.c:153 kernel/params.c:186) 
	 ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182) 
	 ? rcu_is_watching (./include/linux/context_tracking.h:128 kernel/rcu/tree.c:737) 
	 do_initcall_level (init/main.c:1330) 
	 ? kernel_init (init/main.c:1471) 
	 do_initcalls (init/main.c:1344) 
	 kernel_init_freeable (init/main.c:1582) 
	 ? __pfx_kernel_init (init/main.c:1461) 
	 kernel_init (init/main.c:1471) 
	 ret_from_fork (arch/x86/kernel/process.c:153) 
	 ? __pfx_kernel_init (init/main.c:1461) 
	 ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
	  </TASK>
	 printk: legacy console [netcon0] enabled
	 netconsole: network logging started
	 clk: Disabling unused clocks

Thanks
--breno

