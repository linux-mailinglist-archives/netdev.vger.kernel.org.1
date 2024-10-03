Return-Path: <netdev+bounces-131661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB4D98F2D6
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 17:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BF7E1F22515
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 15:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55961A4F07;
	Thu,  3 Oct 2024 15:42:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47C21A4E98;
	Thu,  3 Oct 2024 15:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970121; cv=none; b=OTQxxE6BuR5c0qWKdo3B1y+x8xSAm0AZgkK2lvH/6as5uXDnAW3VIaweWEufGDvsEekqnIOo/KUNbawLL0/GuhNqjtnHRVG5upTOWpTHsLfabgrvKAUjf2VwzmtNlzyFByLM3jrusscwS7Bp1OwpwFLz5qupoT2rE/7NlSViwno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970121; c=relaxed/simple;
	bh=HYAJPJXK0LP9Kro9fg6LcvSfukMkJ6ReFKePXdhl0V8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SoqUaEooE7iknNWQDV8/rT1TjgineCrUnGZk+J5FRQmUQew9zvXkWo9SwE4Q/HNp+Ypm/o/ShXW1GqaTrCaa4yrQ88RVfIlKVKQqLxk1tY+tlsBIh9F8zAhEnYmM8cSbxL4RenalCDJ+0ZuuWeVJXBtgRR3WCDsxtsTnbWzpIz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fad100dd9fso18038731fa.3;
        Thu, 03 Oct 2024 08:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727970117; x=1728574917;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a56tdiuqQd0cg26UifcWFQrTkSicP25Xc2WgHjTlido=;
        b=gKjbTpX6GsiC8McMCLKPbVfGDRR3MhK4Y7MSHFz0XbaXI3For+e237Qjy0j5udPR/2
         cvNbZ505eMykr/f0hk10NdzUDuNJLE+RvHxwMeWKbOlliOReee8vNP9HqYwblYEVjEjM
         +gMYE+5XxMfqWBQ5Whxe6GRpXFsf4PayuK1IFJW3VQ+f+XP9x6iOmT+7jNHVkuiasSuO
         ub1qRS56SB9OPShZBZ22hMfCJmbUcp7fQ/EbRPQawWG9Joau9PMlJ9ZCaPPljIwBDFDY
         jABM684Y4cefFuhjHJQKrjU7sPW3V2sZk7Uo7cSS2GsWQMZJV45CuBodk2ebc3tKNgzx
         E5Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVgGX3C1Qm4nThiQu2oJTz79S8WhqqBA8LqrtnBBbpHdV7wUzOgGKMKgi+CBo+CIsmBhDxDxKtvRWA/Ur8=@vger.kernel.org, AJvYcCXcVWrZlyzv9X99VWAndK/o+HP3UuG9b2ICAzzZTlLZjpx8rmwC2sKwj82Da9FfHaSPX2IU81+G@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt8pIdYYB4juAh+mCy+fPKIfTH0kDywH+cTwC6u7wXCwcXUEZ6
	jAR1EVjnpXWjJfBkYacJUiEQVvP0Kb9ZQ2fMzcIbdiscUSqN322O
X-Google-Smtp-Source: AGHT+IHhtVnOjdB+C5nejpiv6X3a2tpTa7QUKwietJ4zEbmH/kJJWuMkovraJxjgvazISP3jB6bThQ==
X-Received: by 2002:a2e:4e02:0:b0:2f7:712d:d08 with SMTP id 38308e7fff4ca-2fae105a2ccmr50396361fa.23.1727970116408;
        Thu, 03 Oct 2024 08:41:56 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-112.fbsv.net. [2a03:2880:30ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99103b3160sm99276866b.108.2024.10.03.08.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 08:41:55 -0700 (PDT)
Date: Thu, 3 Oct 2024 08:41:53 -0700
From: Breno Leitao <leitao@debian.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: gregkh@linuxfoundation.org, pmladek@suse.com, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, kuba@kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, vschneid@redhat.com, axboe@kernel.dk
Subject: Re: 6.12-rc1: Lockdep regression bissected
 (virtio-net/console/scheduler)
Message-ID: <20241003-mahogany-quail-of-reading-eeee7e@leitao>
References: <20241003-savvy-efficient-locust-ae7bbc@leitao>
 <20241003153231.GV5594@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241003153231.GV5594@noisy.programming.kicks-ass.net>

Hello Peter,

On Thu, Oct 03, 2024 at 05:32:31PM +0200, Peter Zijlstra wrote:
> On Thu, Oct 03, 2024 at 07:51:20AM -0700, Breno Leitao wrote:
> > Upstream kernel (6.12-rc1) has a new lockdep splat, that I am sharing to
> > get more visibility:
> > 
> > 	WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
> > 
> > This is happening because the HARDIRQ-irq-unsafe "_xmit_ETHER#2" lock is
> > acquired in virtnet_poll_tx() while holding the HARDIRQ-irq-safe, and
> > lockdep doesn't like it much.
> > 
> > I've bisected the problem, and weirdly enough, this problem started to
> > show up after a unrelated(?) change in the scheduler:
> > 
> > 	52e11f6df293e816a ("sched/fair: Implement delayed dequeue")
> > 
> > At this time, I have the impression that the commit above exposed the
> > problem that was there already.
> > 
> > Here is the full log, based on commit 7ec462100ef91 ("Merge tag
> > 'pull-work.unaligned' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs")
> 
> This looks like the normal lockdep splat you get when the scheduler does
> printk. I suspect you tripped a WARN, but since you only provided the
> lockdep output and not the whole log, I cannot tell.

Thanks for the quick answer. I didn't see a warning before the lockdep
splat, at least in the usual way I am familiar with. Let me past the
full log below.

> There is a fix in:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/urgent
> 
> that might, or might not help. I can't tell.

Thanks. I will try it soon.

I just booted a clean VM, here is the full log:

	 Linux version 6.11.0-rc1-kbuilder-00044-g152e11f6df29 (leit@devvm32600.lla0.foobar.com) (clang version 20.0.0git (https://github.com/llvm/llvm-project.git d0f67773b213383b6e1c9331fb00f2d4c14bfcb2), LLD 18.0.0) #47 SMP Thu Oct  3 07:23:47 PDT 2024
	 Command line: virtme_hostname=virtme-ng nr_open=2500000 virtme_link_mods=/home/leit/Devel/upstream/.virtme_mods/lib/modules/0.0.0 console=hvc0 earlyprintk=serial,ttyS0,115200 virtme_console=ttyS0 psmouse.proto=exps "virtme_stty_con=rows 45 cols 101 iutf8" TERM=xterm-256color virtme.dhcp net.ifnames=0 biosdevname=0 virtme_chdir=home/leit/Devel/upstream netconsole=+6666@2401:db00:3120:21a9:1111:0000:0270:0000/eth0,1514@2803:6080:a89c:a670::1/02:90:fb:66:aa:e5 init=/home/leit/venv/lib/python3.8/site-packages/virtme/guest/bin/virtme-ng-init
	 KERNEL supported cpus:
	   Intel GenuineIntel
	   AMD AuthenticAMD
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
	 Hypervisor detected: KVM
	 kvm-clock: Using msrs 4b564d01 and 4b564d00
	 kvm-clock: using sched offset of 932970338 cycles
	 clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
	 tsc: Detected 1199.999 MHz processor
	 e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
	 e820: remove [mem 0x000a0000-0x000fffff] usable
	 last_pfn = 0x2c0000 max_arch_pfn = 0x400000000
	 MTRR map: 4 entries (3 fixed + 1 variable; max 19), built from 8 variable MTRRs
	 x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
	 last_pfn = 0xbffe0 max_arch_pfn = 0x400000000
	 Using GB pages for direct mapping
	 RAMDISK: [mem 0xbf996000-0xbffdffff]
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
	 SRAT: PXM 0 -> APIC 0x00 -> Node 0
	 SRAT: PXM 0 -> APIC 0x01 -> Node 0
	 SRAT: PXM 0 -> APIC 0x02 -> Node 0
	 SRAT: PXM 0 -> APIC 0x03 -> Node 0
	 SRAT: PXM 0 -> APIC 0x04 -> Node 0
	 SRAT: PXM 0 -> APIC 0x05 -> Node 0
	 SRAT: PXM 0 -> APIC 0x06 -> Node 0
	 SRAT: PXM 0 -> APIC 0x07 -> Node 0
	 SRAT: PXM 0 -> APIC 0x08 -> Node 0
	 SRAT: PXM 0 -> APIC 0x09 -> Node 0
	 SRAT: PXM 0 -> APIC 0x0a -> Node 0
	 SRAT: PXM 0 -> APIC 0x0b -> Node 0
	 SRAT: PXM 0 -> APIC 0x0c -> Node 0
	 SRAT: PXM 0 -> APIC 0x0d -> Node 0
	 SRAT: PXM 0 -> APIC 0x0e -> Node 0
	 SRAT: PXM 0 -> APIC 0x0f -> Node 0
	 SRAT: PXM 0 -> APIC 0x10 -> Node 0
	 SRAT: PXM 0 -> APIC 0x11 -> Node 0
	 SRAT: PXM 0 -> APIC 0x12 -> Node 0
	 SRAT: PXM 0 -> APIC 0x13 -> Node 0
	 ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
	 ACPI: SRAT: Node 0 PXM 0 [mem 0x00100000-0xbfffffff]
	 ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x2bfffffff]
	 NUMA: Node 0 [mem 0x00000000-0x0009ffff] + [mem 0x00100000-0xbfffffff] -> [mem 0x00000000-0xbfffffff]
	 NUMA: Node 0 [mem 0x00000000-0xbfffffff] + [mem 0x100000000-0x2bfffffff] -> [mem 0x00000000-0x2bfffffff]
	 NODE_DATA(0) allocated [mem 0x2bfffa000-0x2bfffdfff]
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
	 kvm-guest: APIC: eoi() replaced with kvm_guest_apic_eoi_write()
	 kvm-guest: KVM setup pv remote TLB flush
	 kvm-guest: setup PV sched yield
	 [mem 0xc0000000-0xfeffbfff] available for PCI devices
	 Booting paravirtualized kernel on KVM
	 clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
	 setup_percpu: NR_CPUS:512 nr_cpumask_bits:20 nr_cpu_ids:20 nr_node_ids:1
	 percpu: Embedded 82 pages/cpu s299008 r8192 d28672 u524288
	 pcpu-alloc: s299008 r8192 d28672 u524288 alloc=1*2097152
	 pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07
	 pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15
	 pcpu-alloc: [0] 16 17 18 19
	 Kernel command line: virtme_hostname=virtme-ng nr_open=2500000 virtme_link_mods=/home/leit/Devel/upstream/.virtme_mods/lib/modules/0.0.0 console=hvc0 earlyprintk=serial,ttyS0,115200 virtme_console=ttyS0 psmouse.proto=exps "virtme_stty_con=rows 45 cols 101 iutf8" TERM=xterm-256color virtme.dhcp net.ifnames=0 biosdevname=0 virtme_chdir=home/leit/Devel/upstream netconsole=+6666@2401:db00:3120:21a9:face:0000:0270:0000/eth0,1514@2803:6080:a89c:a670::1/02:90:fb:66:aa:e5 init=/home/leit/venv/lib/python3.8/site-packages/virtme/guest/bin/virtme-ng-init
	 Unknown kernel command line parameters "virtme_hostname=virtme-ng nr_open=2500000 virtme_link_mods=/home/leit/Devel/upstream/.virtme_mods/lib/modules/0.0.0 virtme_console=ttyS0 virtme_stty_con=rows 45 cols 101 iutf8 biosdevname=0 virtme_chdir=home/leit/Devel/upstream", will be passed to user space.
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
	 ftrace: allocating 46490 entries in 182 pages
	 ftrace: allocated 182 pages with 5 groups
	 Running RCU self tests
	 Running RCU synchronous self tests
	 rcu: Hierarchical RCU implementation.
	 rcu: 	RCU lockdep checking is enabled.
	 rcu: 	RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=20.
		Rude variant of Tasks RCU enabled.
		Tracing variant of Tasks RCU enabled.
	 rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
	 rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=20
	 Running RCU synchronous self tests
	 RCU Tasks Rude: Setting shift to 5 and lim to 1 rcu_task_cb_adjust=1.
	 RCU Tasks Trace: Setting shift to 5 and lim to 1 rcu_task_cb_adjust=1.
	 NR_IRQS: 33024, nr_irqs: 584, preallocated irqs: 16
	 rcu: srcu_init: Setting srcu_struct sizes based on contention.
	 kfence: initialized - using 2097152 bytes for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
	 Console: colour *CGA 80x25
	 Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
	 ... MAX_LOCKDEP_SUBCLASSES:  8
	 ... MAX_LOCK_DEPTH:          48
	 ... MAX_LOCKDEP_KEYS:        8192
	 ... CLASSHASH_SIZE:          4096
	 ... MAX_LOCKDEP_ENTRIES:     32768
	 ... MAX_LOCKDEP_CHAINS:      65536
	 ... CHAINHASH_SIZE:          32768
	  memory used by lock dependency info: 6429 kB
	  memory used for stack traces: 4224 kB
	  per task-struct memory footprint: 1920 bytes
	 ACPI: Core revision 20240322
	 clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
	 APIC: Switch to symmetric I/O mode setup
	 x2apic enabled
	 APIC: Switched APIC routing to: physical x2apic
	 kvm-guest: APIC: send_IPI_mask() replaced with kvm_send_ipi_mask()
	 kvm-guest: APIC: send_IPI_mask_allbutself() replaced with kvm_send_ipi_mask_allbutself()
	 kvm-guest: setup PV IPIs
	 ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
	 tsc: Marking TSC unstable due to TSCs unsynchronized
	 Calibrating delay loop (skipped) preset value.. 2399.99 BogoMIPS (lpj=1199999)
	 x86/cpu: User Mode Instruction Prevention (UMIP) activated
	 Last level iTLB entries: 4KB 512, 2MB 255, 4MB 127
	 Last level dTLB entries: 4KB 512, 2MB 255, 4MB 127, 1GB 0
	 Spectre V2 : User space: Vulnerable
	 Speculative Store Bypass: Vulnerable
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
	 Freeing SMP alternatives memory: 48K
	 pid_max: default: 32768 minimum: 301
	 LSM: initializing lsm=capability,ima
	 Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
	 Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
	 Running RCU synchronous self tests
	 Running RCU synchronous self tests
	 smpboot: CPU0: AMD EPYC-Milan Processor (family: 0x19, model: 0x1, stepping: 0x1)
	 psi: inconsistent task state! task=1:swapper/0 cpu=0 psi_flags=4 clear=0 set=4
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
	 signal: max sigframe size: 3376
	 rcu: Hierarchical SRCU implementation.
	 rcu: 	Max phase no-delay instances is 400.
	 Timer migration: 2 hierarchy levels; 8 children per group; 2 crossnode level
	 smp: Bringing up secondary CPUs ...
	 smpboot: x86: Booting SMP configuration:
	 .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9 #10 #11 #12 #13 #14 #15 #16
	 Callback from call_rcu_tasks_rude() invoked.
	  #17 #18 #19
	 smp: Brought up 1 node, 20 CPUs
	 smpboot: Total of 20 processors activated (47999.96 BogoMIPS)
	 Memory: 10121020K/10485240K available (18432K kernel code, 9105K rwdata, 6216K rodata, 1884K init, 21012K bss, 350648K reserved, 0K cma-reserved)
	 devtmpfs: initialized
	 x86/mm: Memory block size: 128MB
	 Running RCU synchronous self tests
	 Running RCU synchronous self tests
	 clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
	 futex hash table entries: 8192 (order: 8, 1048576 bytes, linear)
	 NET: Registered PF_NETLINK/PF_ROUTE protocol family
	 DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic allocations
	 DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
	 DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
	 audit: initializing netlink subsys (disabled)
	 audit: type=2000 audit(1727965453.220:1): state=initialized audit_enabled=0 res=1
	 thermal_sys: Registered thermal governor 'step_wise'
	 thermal_sys: Registered thermal governor 'user_space'
	 cpuidle: using governor menu
	 dca service started, version 1.12.1
	 PCI: Using configuration type 1 for base access
	 PCI: Using configuration type 1 for extended access
	 kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
	 HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
	 HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
	 HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
	 HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
	 cryptd: max_cpu_qlen set to 1000
	 raid6: avx512x4 gen() 31451 MB/s
	 raid6: avx512x2 gen() 34478 MB/s
	 raid6: avx512x1 gen() 31905 MB/s
	 raid6: avx2x4   gen() 34476 MB/s
	 raid6: avx2x2   gen() 37438 MB/s
	 raid6: avx2x1   gen() 32283 MB/s
	 raid6: using algorithm avx2x2 gen() 37438 MB/s
	 raid6: .... xor() 29574 MB/s, rmw enabled
	 raid6: using avx512x2 recovery algorithm
	 ACPI: Added _OSI(Module Device)
	 ACPI: Added _OSI(Processor Device)
	 ACPI: Added _OSI(3.0 _SCP Extensions)
	 ACPI: Added _OSI(Processor Aggregator Device)
	 ACPI: 1 ACPI AML tables successfully acquired and loaded
	 ACPI: Interpreter enabled
	 ACPI: PM: (supports S0 S5)
	 ACPI: Using IOAPIC for interrupt routing
	 PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
	 PCI: Using E820 reservations for host bridge windows
	 ACPI: Enabled 2 GPEs in block 00 to 0F
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
	 PCI: Using ACPI for IRQ routing
	 PCI: pci_cache_line_size set to 64 bytes
	 e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
	 e820: reserve RAM buffer [mem 0xbffe0000-0xbfffffff]
	 hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
	 hpet0: 3 comparators, 64-bit 100.000000 MHz counter
	 clocksource: Switched to clocksource kvm-clock
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
	 Trying to unpack rootfs image as initramfs...
	 software IO TLB: mapped [mem 0x00000000bb996000-0x00000000bf996000] (64MB)
	 kvm_intel: VMX not supported by CPU 1
	 kvm_amd: TSC scaling supported
	 kvm_amd: Nested Virtualization enabled
	 kvm_amd: Nested Paging enabled
	 kvm_amd: LBR virtualization supported
	 Freeing initrd memory: 6440K
	 Initialise system trusted keyrings
	 workingset: timestamp_bits=43 max_order=22 bucket_order=0
	 9p: Installing v9fs 9p2000 file system support
	 NET: Registered PF_ALG protocol family
	 xor: automatically using best checksumming function   avx
	 Key type asymmetric registered
	 Asymmetric key parser 'x509' registered
	 Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
	 io scheduler mq-deadline registered
	 io scheduler kyber registered
	 ioatdma: Intel(R) QuickData Technology Driver 5.00
	 ACPI: \_SB_.LNKB: Enabled at IRQ 10
	 ACPI: \_SB_.LNKD: Enabled at IRQ 11
	 ACPI: \_SB_.LNKA: Enabled at IRQ 10
	 Serial: 8250/16550 driver, 16 ports, IRQ sharing enabled
	 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
	 printk: legacy console [hvc0] enabled
	 printk: legacy bootconsole [earlyser0] disabled
	 brd: module loaded
	 usbcore: registered new interface driver ark3116
	 usbserial: USB Serial support registered for ark3116
	 usbcore: registered new interface driver pl2303
	 usbserial: USB Serial support registered for pl2303
	 i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
	 serio: i8042 KBD port at 0x60,0x64 irq 1
	 serio: i8042 AUX port at 0x60,0x64 irq 12
	 rtc_cmos 00:04: RTC can wake from S4
	 rtc_cmos 00:04: registered as rtc0
	 rtc_cmos 00:04: setting system clock to 2024-10-03T14:24:13 UTC (1727965453)
	 rtc_cmos 00:04: alarms up to one day, y3k, 242 bytes nvram, hpet irqs
	 i6300ESB timer 0000:00:03.0: initialized. heartbeat=30 sec (nowayout=0)
	 input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
	 usbcore: registered new interface driver usbhid
	 usbhid: USB HID core driver
	 Initializing XFRM netlink socket
	 NET: Registered PF_INET6 protocol family
	 Segment Routing with IPv6
	 In-situ OAM (IOAM) with IPv6
	 NET: Registered PF_PACKET protocol family
	 9pnet: Installing 9P2000 support
	 Key type dns_resolver registered
	 IPI shorthand broadcast: enabled
	 AES CTR mode by8 optimization enabled
	 registered taskstats version 1
	 Loading compiled-in X.509 certificates
	 virtme initramfs: initramfs does not have module crypto-pkcs1pad(rsa,sha512)
	 virtme initramfs: initramfs does not have module crypto-pkcs1pad(rsa,sha512)-all
	 Loaded X.509 cert 'Build time autogenerated kernel key: 1a58da0881b870ef3decd7cf414d45e41b0e363a'
	 Demotion targets for Node 0: null
	 kmemleak: Kernel memory leak detector initialized (mem pool available: 15766)
	 kmemleak: Automatic memory scanning thread started
	 Btrfs loaded, zoned=no, fsverity=yes
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
	 6.11.0-rc1-kbuilder-00044-g152e11f6df29 #47 Not tainted
	 -----------------------------------------------------
	 swapper/0/1 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
	 ffff8881027702d8 (_xmit_ETHER#2){+.-.}-{3:3}, at: virtnet_poll_tx+0x94/0x210

	 and this task is already holding:
	 ffffffff8325b808 (target_list_lock){....}-{3:3}, at: write_ext_msg+0x4e/0x3a0
	 which would create a new lock dependency:
	  (target_list_lock){....}-{3:3} -> (_xmit_ETHER#2){+.-.}-{3:3}

	 but this new dependency connects a HARDIRQ-irq-safe lock:
	  (console_owner){-...}-{0:0}

	 ... which became HARDIRQ-irq-safe at:
	   lock_acquire+0xe6/0x240
	   console_flush_all+0x31d/0x580
	   console_unlock+0x49/0x160
	   wake_up_klogd_work_func+0x68/0xa0
	   irq_work_run_list+0x9b/0xe0
	   update_process_times+0x88/0xa0
	   tick_handle_periodic+0x22/0x80
	   __sysvec_apic_timer_interrupt+0x74/0x1c0
	   sysvec_apic_timer_interrupt+0x6c/0x80
	   asm_sysvec_apic_timer_interrupt+0x1a/0x20
	   clear_page_erms+0xb/0x10
	   alloc_pages_bulk_noprof+0x48d/0x690
	   __vmalloc_node_range_noprof+0x3ad/0x7c0
	   dup_task_struct+0x12a/0x2a0
	   copy_process+0x17a/0x1380
	   kernel_clone+0x97/0x340
	   kernel_thread+0xb8/0xe0
	   kthreadd+0x201/0x240
	   ret_from_fork+0x34/0x40
	   ret_from_fork_asm+0x11/0x20

	 to a HARDIRQ-irq-unsafe lock:
	  (_xmit_ETHER#2){+.-.}-{3:3}

	 ... which became HARDIRQ-irq-unsafe at:
	 ...
	   lock_acquire+0xe6/0x240
	   _raw_spin_trylock+0x45/0x60
	   virtnet_poll+0xa2/0xe90
	   __napi_poll+0x28/0x210
	   net_rx_action+0x1de/0x3c0
	   handle_softirqs+0x187/0x460
	   do_softirq+0x68/0xc0
	   __local_bh_enable_ip+0xee/0x100
	   virtnet_open+0x1ad/0x320
	   __dev_open+0xdb/0x170
	   dev_open+0x30/0x90
	   netpoll_setup+0x188/0x420
	   init_netconsole+0x136/0x360
	   do_one_initcall+0xee/0x310
	   do_initcall_level+0xa1/0x110
	   do_initcalls+0x43/0x70
	   kernel_init_freeable+0x17e/0x200
	   kernel_init+0x1a/0x130
	   ret_from_fork+0x34/0x40
	   ret_from_fork_asm+0x11/0x20

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

	 5 locks held by swapper/0/1:
	  #0: ffffffff82a835f8 (console_mutex){+.+.}-{4:4}, at: register_console+0x47/0x350
	  #1: ffffffff82a839e8 (console_lock){+.+.}-{0:0}, at: _printk+0x5d/0x80
	  #2: ffffffff82a83630 (console_srcu){....}-{0:0}, at: console_flush_all+0x6a/0x580
	  #3: ffffffff83183ea0 (console_owner){-...}-{0:0}, at: console_flush_all+0x6a/0x580
	  #4: ffffffff8325b808 (target_list_lock){....}-{3:3}, at: write_ext_msg+0x4e/0x3a0

	 the dependencies between HARDIRQ-irq-safe lock and the holding lock:
	  -> (console_owner){-...}-{0:0} ops: 2584 {
	     IN-HARDIRQ-W at:
			       lock_acquire+0xe6/0x240
			       console_flush_all+0x31d/0x580
			       console_unlock+0x49/0x160
			       wake_up_klogd_work_func+0x68/0xa0
			       irq_work_run_list+0x9b/0xe0
			       update_process_times+0x88/0xa0
			       tick_handle_periodic+0x22/0x80
			       __sysvec_apic_timer_interrupt+0x74/0x1c0
			       sysvec_apic_timer_interrupt+0x6c/0x80
			       asm_sysvec_apic_timer_interrupt+0x1a/0x20
			       clear_page_erms+0xb/0x10
			       alloc_pages_bulk_noprof+0x48d/0x690
			       __vmalloc_node_range_noprof+0x3ad/0x7c0
			       dup_task_struct+0x12a/0x2a0
			       copy_process+0x17a/0x1380
			       kernel_clone+0x97/0x340
			       kernel_thread+0xb8/0xe0
			       kthreadd+0x201/0x240
			       ret_from_fork+0x34/0x40
			       ret_from_fork_asm+0x11/0x20
	     INITIAL USE at:
	   }
	   ... key      at: [<ffffffff83183ea0>] console_owner_dep_map+0x0/0x28
	 -> (target_list_lock){....}-{3:3} ops: 3 {
	    INITIAL USE at:
			    lock_acquire+0xe6/0x240
			    _raw_spin_lock_irqsave+0x5a/0x90
			    init_netconsole+0x23b/0x360
			    do_one_initcall+0xee/0x310
			    do_initcall_level+0xa1/0x110
			    do_initcalls+0x43/0x70
			    kernel_init_freeable+0x17e/0x200
			    kernel_init+0x1a/0x130
			    ret_from_fork+0x34/0x40
			    ret_from_fork_asm+0x11/0x20
	  }
	  ... key      at: [<ffffffff8325b808>] target_list_lock+0x18/0x40
	  ... acquired at:
	    _raw_spin_lock_irqsave+0x5a/0x90
	    write_ext_msg+0x4e/0x3a0
	    console_flush_all+0x332/0x580
	    console_unlock+0x49/0x160
	    vprintk_emit+0x226/0x350
	    _printk+0x5d/0x80
	    register_console+0x2d0/0x350
	    init_netconsole+0x2a6/0x360
	    do_one_initcall+0xee/0x310
	    do_initcall_level+0xa1/0x110
	    do_initcalls+0x43/0x70
	    kernel_init_freeable+0x17e/0x200
	    kernel_init+0x1a/0x130
	    ret_from_fork+0x34/0x40
	    ret_from_fork_asm+0x11/0x20


	 the dependencies between the lock to be acquired
	  and HARDIRQ-irq-unsafe lock:
	 -> (_xmit_ETHER#2){+.-.}-{3:3} ops: 5 {
	    HARDIRQ-ON-W at:
			     lock_acquire+0xe6/0x240
			     _raw_spin_trylock+0x45/0x60
			     virtnet_poll+0xa2/0xe90
			     __napi_poll+0x28/0x210
			     net_rx_action+0x1de/0x3c0
			     handle_softirqs+0x187/0x460
			     do_softirq+0x68/0xc0
			     __local_bh_enable_ip+0xee/0x100
			     virtnet_open+0x1ad/0x320
			     __dev_open+0xdb/0x170
			     dev_open+0x30/0x90
			     netpoll_setup+0x188/0x420
			     init_netconsole+0x136/0x360
			     do_one_initcall+0xee/0x310
			     do_initcall_level+0xa1/0x110
			     do_initcalls+0x43/0x70
			     kernel_init_freeable+0x17e/0x200
			     kernel_init+0x1a/0x130
			     ret_from_fork+0x34/0x40
			     ret_from_fork_asm+0x11/0x20
	    IN-SOFTIRQ-W at:
			     lock_acquire+0xe6/0x240
			     _raw_spin_lock+0x30/0x40
			     virtnet_poll_tx+0x94/0x210
			     __napi_poll+0x28/0x210
			     net_rx_action+0x1de/0x3c0
			     handle_softirqs+0x187/0x460
			     do_softirq+0x68/0xc0
			     __local_bh_enable_ip+0xee/0x100
			     virtnet_open+0x89/0x320
			     __dev_open+0xdb/0x170
			     dev_open+0x30/0x90
			     netpoll_setup+0x188/0x420
			     init_netconsole+0x136/0x360
			     do_one_initcall+0xee/0x310
			     do_initcall_level+0xa1/0x110
			     do_initcalls+0x43/0x70
			     kernel_init_freeable+0x17e/0x200
			     kernel_init+0x1a/0x130
			     ret_from_fork+0x34/0x40
			     ret_from_fork_asm+0x11/0x20
	    INITIAL USE at:
			    lock_acquire+0xe6/0x240
			    _raw_spin_trylock+0x45/0x60
			    virtnet_poll+0xa2/0xe90
			    __napi_poll+0x28/0x210
			    net_rx_action+0x1de/0x3c0
			    handle_softirqs+0x187/0x460
			    do_softirq+0x68/0xc0
			    __local_bh_enable_ip+0xee/0x100
			    virtnet_open+0x1ad/0x320
			    __dev_open+0xdb/0x170
			    dev_open+0x30/0x90
			    netpoll_setup+0x188/0x420
			    init_netconsole+0x136/0x360
			    do_one_initcall+0xee/0x310
			    do_initcall_level+0xa1/0x110
			    do_initcalls+0x43/0x70
			    kernel_init_freeable+0x17e/0x200
			    kernel_init+0x1a/0x130
			    ret_from_fork+0x34/0x40
			    ret_from_fork_asm+0x11/0x20
	  }
	  ... key      at: [<ffffffff84a45430>] netdev_xmit_lock_key+0x10/0x390
	  ... acquired at:
	    _raw_spin_lock+0x30/0x40
	    virtnet_poll_tx+0x94/0x210
	    netpoll_poll_dev+0x15d/0x240
	    netpoll_send_skb+0x268/0x350
	    netpoll_send_udp+0x3f7/0x470
	    write_ext_msg+0xe2/0x3a0
	    console_flush_all+0x332/0x580
	    console_unlock+0x49/0x160
	    vprintk_emit+0x226/0x350
	    _printk+0x5d/0x80
	    register_console+0x2d0/0x350
	    init_netconsole+0x2a6/0x360
	    do_one_initcall+0xee/0x310
	    do_initcall_level+0xa1/0x110
	    do_initcalls+0x43/0x70
	    kernel_init_freeable+0x17e/0x200
	    kernel_init+0x1a/0x130
	    ret_from_fork+0x34/0x40
	    ret_from_fork_asm+0x11/0x20


	 stack backtrace:
	 CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0-rc1-kbuilder-00044-g152e11f6df29 #47
	 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
	 Call Trace:
	  <TASK>
	  dump_stack_lvl+0x9f/0xf0
	  __lock_acquire+0x2cd0/0x2d10
	  ? virtnet_poll_tx+0x94/0x210
	  lock_acquire+0xe6/0x240
	  ? virtnet_poll_tx+0x94/0x210
	  ? lock_acquire+0xe6/0x240
	  ? down_trylock+0x12/0x30
	  _raw_spin_lock+0x30/0x40
	  ? virtnet_poll_tx+0x94/0x210
	  virtnet_poll_tx+0x94/0x210
	  netpoll_poll_dev+0x15d/0x240
	  netpoll_send_skb+0x268/0x350
	  netpoll_send_udp+0x3f7/0x470
	  write_ext_msg+0xe2/0x3a0
	  console_flush_all+0x332/0x580
	  ? console_flush_all+0x6a/0x580
	  console_unlock+0x49/0x160
	  ? __down_trylock_console_sem+0x9e/0xe0
	  vprintk_emit+0x226/0x350
	  _printk+0x5d/0x80
	  register_console+0x2d0/0x350
	  init_netconsole+0x2a6/0x360
	  ? option_setup+0x30/0x30
	  do_one_initcall+0xee/0x310
	  ? __lock_acquire+0xe4b/0x2d10
	  ? __lock_acquire+0xe4b/0x2d10
	  ? stack_depot_save_flags+0x60d/0x6c0
	  ? asm_sysvec_call_function+0x1a/0x20
	  ? parse_args+0x11d/0x420
	  ? parse_args+0x16b/0x420
	  do_initcall_level+0xa1/0x110
	  ? kernel_init+0x1a/0x130
	  do_initcalls+0x43/0x70
	  kernel_init_freeable+0x17e/0x200
	  ? rest_init+0x1f0/0x1f0
	  kernel_init+0x1a/0x130
	  ret_from_fork+0x34/0x40
	  ? rest_init+0x1f0/0x1f0
	  ret_from_fork_asm+0x11/0x20
	  </TASK>
	 printk: legacy console [netcon0] enabled
	 netconsole: network logging started
	 Unstable clock detected, switching default tracing clock to "global"
	 If you want to keep using the local clock, then add:
	   "trace_clock=local"
	 on the kernel command line
	 clk: Disabling unused clocks
	 Freeing unused decrypted memory: 2036K
	 Freeing unused kernel image (initmem) memory: 1884K
	 Write protecting the kernel read-only data: 26624k
	 Freeing unused kernel image (rodata/data gap) memory: 1976K
	 Run /init as init process
	   with arguments:
	     /init
	   with environment:
	     HOME=/
	     TERM=xterm-256color
	     virtme_hostname=virtme-ng
	     nr_open=2500000
	     virtme_link_mods=/home/leit/Devel/upstream/.virtme_mods/lib/modules/0.0.0
	     virtme_console=ttyS0
	     virtme_stty_con=rows 45 cols 101 iutf8
	     biosdevname=0
	     virtme_chdir=home/leit/Devel/upstream
	 virtme initramfs: loading fuse.ko...
	 fuse: module verification failed: signature and/or required key missing - tainting kernel
	 fuse: init (API version 7.40)
	 virtme initramfs: loading virtiofs.ko...
	 virtme initramfs: mounting hostfs...
	 virtme initramfs: done; switching to real root
	 virtme-ng-init: /etc/tmpfiles.d/chef.conf:13: Line references path below legacy directory /var/run/, updating /var/run/ccache → /run/ccache; please update the tmpfiles.d/ drop-in file accordingly.
	 virtme-ng-init: setting up network device eth0
	 virtme-ng-init: WARNING: failed to run: "busybox" udhcpc -i eth0 -n -q -f -s /home/leit/venv/lib/python3.8/site-packages/virtme/guest/virtme-udhcpc-script
	 virtme-ng-init: Starting systemd-udevd version v255.5-1.4.hs+fb.el9
	 virtme-ng-init: triggering udev coldplug
	 input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
	 ACPI: button: Power Button [PWRF]
	 virtme-ng-init: waiting for udev to settle
	 Linux agpgart interface v0.103
	 virtme-ng-init: udev is done
	 virtme-ng-init: initialization done

