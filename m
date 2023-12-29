Return-Path: <netdev+bounces-60578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A14F481FF46
	for <lists+netdev@lfdr.de>; Fri, 29 Dec 2023 13:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8227FB2190F
	for <lists+netdev@lfdr.de>; Fri, 29 Dec 2023 12:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B361118E;
	Fri, 29 Dec 2023 12:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8h4uXkt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FD511187
	for <netdev@vger.kernel.org>; Fri, 29 Dec 2023 12:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a2776ce12bcso110816766b.3
        for <netdev@vger.kernel.org>; Fri, 29 Dec 2023 04:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703851218; x=1704456018; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUxYdm+ICQTUWj1mgfyxHWMeFMsMTaTLmbNLT+pIsBc=;
        b=g8h4uXktfg8R//+wdiYkzutMfFb6Qo6K8/BVGH9o4QnPQm8k9LrWZyKZitCBVH9GRC
         hZH3mo9Rdain3dl6ZDohS+cqirE+/xOq3WbgnJE9uVbuzAU85qsDtwY9/RwSBHy5ESri
         OKTwxZIoCMz9bAC+u6llcNqupjHYheqdV9JNoGqpNUNqJJyq4gVq1HhwTEIbUrBD9jDE
         5jMK0k/KuELuRDcoyzPd6YCfwUDPzOyhpiCc2VKzUQSaEECn1YlJtF9eQJd0miMEJYYC
         d+EGaVk5oxSuBWDYFGIux7pERMKEituiibAkxRmjxApclDOLtdaWLWlpfXsPHl0Jh3GV
         bI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703851218; x=1704456018;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUxYdm+ICQTUWj1mgfyxHWMeFMsMTaTLmbNLT+pIsBc=;
        b=e6/NG1yjGrOy+37El9I+YcXOZm3Dp70u8hAqnKgJuvRQZbMAXu29Ze5kta/DehBtKn
         6bw4AvCIgoumIs758CjBAZkXWW0yOYfIifya390Wr6VxxRcjTSCh6NpxLTVbYlpNn+J1
         2dy0ZPcfA/S3tHQtisFOJdHDrPtoqtyYkp+msIXKnVCdGiug8tCRDeYdtROF88W3CEve
         V7jdnnu4mOGTwPQNBbfYQqJXmpigCYO3Zyb/CdGl06YiVYWs3INiz0t3x5ZalUClCfSR
         j6SMNr0hBkQX24LlzrwPc9i6xEEgL38JAH8uxjoQIOFmvPQ55e6bsDH0J2j+63NxUugV
         hnyQ==
X-Gm-Message-State: AOJu0YzyaiN3MqNSzHLoWavQkqUuKbqIJNjXcFwpJzQMgfQoxkwviBSt
	iCdjHy+UC0KkR/oMFHlvl2k=
X-Google-Smtp-Source: AGHT+IEiC5d0mAEYHXXlecqy6cwAlc/nOlq1YNQLfJm/aDe/OHhThKldCneSDu4txrOn144s5N2Rew==
X-Received: by 2002:a17:906:386:b0:a27:4bbe:5ddc with SMTP id b6-20020a170906038600b00a274bbe5ddcmr1880003eja.19.1703851217654;
        Fri, 29 Dec 2023 04:00:17 -0800 (PST)
Received: from smtpclient.apple ([178.254.237.20])
        by smtp.gmail.com with ESMTPSA id mf6-20020a1709071a4600b00a26aa8f3372sm7687678ejc.27.2023.12.29.04.00.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Dec 2023 04:00:17 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: Urgent Bug Report Kernel crash 6.5.2
From: Martin Zaharinov <micron10@gmail.com>
In-Reply-To: <FBF0EB18-E2B6-4076-968A-5F2ABE0F27E4@gmail.com>
Date: Fri, 29 Dec 2023 14:00:05 +0200
Cc: peterz@infradead.org,
 netdev <netdev@vger.kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 patchwork-bot+netdevbpf@kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>,
 kuba+netdrv@kernel.org,
 dsahern@gmail.com,
 Eric Dumazet <edumazet@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7D08EC48-F22C-4CC8-839F-2A9677E93DF0@gmail.com>
References: <64CCB695-BA43-48F5-912A-AFD5B9C103A7@gmail.com>
 <CANn89iL9Twf+Rzm9v_dwsH_iG4YkW3fAc2Hnx2jypN_Qf9oojw@mail.gmail.com>
 <D773F198-BCE3-4D43-9C27-2C2CA34062AC@gmail.com>
 <8E92BAA8-0FC6-4D29-BB4D-B6B60047A1D2@gmail.com>
 <5E63894D-913B-416C-B901-F628BB6C00E0@gmail.com> <87lea4qqun.ffs@tglx>
 <2B5C19AE-C125-45A3-8C6F-CA6BBC01A6D9@gmail.com> <87r0jrp9qi.ffs@tglx>
 <6D816814-1334-4F22-AFF8-B5E42254038E@gmail.com> <87v88ul14z.ffs@tglx>
 <FBF0EB18-E2B6-4076-968A-5F2ABE0F27E4@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Thomas,

One more report from second machine:

[21299.954952] ------------[ cut here ]------------
[21299.955047] WARNING: CPU: 15 PID: 0 at lib/rcuref.c:294 =
rcuref_put_slowpath (lib/rcuref.c:294 (discriminator 1))
[21299.955153] Modules linked in: nft_limit nft_ct nft_nat nft_chain_nat =
nf_tables netconsole coretemp virtio_net net_failover failover =
virtio_pci virtio_pci_legacy_dev virtio_pci_modern_dev virtio =
virtio_ring e1000e e1000 vmxnet3 i40e ixgbe mdio bnxt_en nf_nat_sip =
nf_conntrack_sip nf_nat_pptp nf_conntrack_pptp nf_nat_tftp =
nf_conntrack_tftp nf_nat_ftp nf_conntrack_ftp nf_nat nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 rtc_cmos
[21299.955378] CPU: 15 PID: 0 Comm: swapper/15 Tainted: G           O    =
   6.6.8 #1
[21299.955475] Hardware name: HPE ProLiant DL380 Gen10/ProLiant DL380 =
Gen10, BIOS U30 02/09/2023
[21299.955575] RIP: 0010:rcuref_put_slowpath (lib/rcuref.c:294 =
(discriminator 1))
[21299.955662] Code: 07 83 f8 ff 75 19 ba 00 00 00 e0 f0 0f b1 17 83 f8 =
ff 74 04 31 c0 5b c3 b8 01 00 00 00 5b c3 3d ff ff ff bf 77 14 85 c0 78 =
06 <0f> 0b 31 c0 eb e6 c7 07 00 00 00 a0 31 c0 eb dc 80 3d e2 4e e3 00
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	07                   	(bad)
   1:	83 f8 ff             	cmp    $0xffffffff,%eax
   4:	75 19                	jne    0x1f
   6:	ba 00 00 00 e0       	mov    $0xe0000000,%edx
   b:	f0 0f b1 17          	lock cmpxchg %edx,(%rdi)
   f:	83 f8 ff             	cmp    $0xffffffff,%eax
  12:	74 04                	je     0x18
  14:	31 c0                	xor    %eax,%eax
  16:	5b                   	pop    %rbx
  17:	c3                   	ret
  18:	b8 01 00 00 00       	mov    $0x1,%eax
  1d:	5b                   	pop    %rbx
  1e:	c3                   	ret
  1f:	3d ff ff ff bf       	cmp    $0xbfffffff,%eax
  24:	77 14                	ja     0x3a
  26:	85 c0                	test   %eax,%eax
  28:	78 06                	js     0x30
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	31 c0                	xor    %eax,%eax
  2e:	eb e6                	jmp    0x16
  30:	c7 07 00 00 00 a0    	movl   $0xa0000000,(%rdi)
  36:	31 c0                	xor    %eax,%eax
  38:	eb dc                	jmp    0x16
  3a:	80                   	.byte 0x80
  3b:	3d e2 4e e3 00       	cmp    $0xe34ee2,%eax

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	0f 0b                	ud2
   2:	31 c0                	xor    %eax,%eax
   4:	eb e6                	jmp    0xffffffffffffffec
   6:	c7 07 00 00 00 a0    	movl   $0xa0000000,(%rdi)
   c:	31 c0                	xor    %eax,%eax
   e:	eb dc                	jmp    0xffffffffffffffec
  10:	80                   	.byte 0x80
  11:	3d e2 4e e3 00       	cmp    $0xe34ee2,%eax
[21299.955793] RSP: 0018:ffff96a7c0578c30 EFLAGS: 00010246
[21299.955879] RAX: 0000000000000000 RBX: ffff8b75d1e49a80 RCX: =
ffff8b75c6667c80
[21299.955974] RDX: ffff8b84bfbe4f08 RSI: 00000000fffffe01 RDI: =
ffff8b75d1e49a80
[21299.956070] RBP: ffff8b84bfbe4f08 R08: ffff8b84bfbe4f08 R09: =
0000000000000001
[21299.956167] R10: 0000000000028530 R11: 0000000000000001 R12: =
ffff8b75d1e49a40
[21299.956261] R13: ffff8b75d1e49aa8 R14: ffff8b84bfbe4f08 R15: =
00000000c26ab667
[21299.956358] FS:  0000000000000000(0000) GS:ffff8b84bfbc0000(0000) =
knlGS:0000000000000000
[21299.956457] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[21299.956540] CR2: 00007f2e185c73c8 CR3: 0000000950014003 CR4: =
00000000003706e0
[21299.956635] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
[21299.956730] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
[21299.956826] Call Trace:
[21299.956905]  <IRQ>
[21299.956983] ? __warn (kernel/panic.c:235 kernel/panic.c:673)
[21299.957065] ? report_bug (lib/bug.c:180 lib/bug.c:219)
[21299.957147] ? handle_bug (arch/x86/kernel/traps.c:237)
[21299.957228] ? exc_invalid_op (arch/x86/kernel/traps.c:258 =
(discriminator 1))
[21299.957308] ? asm_exc_invalid_op =
(./arch/x86/include/asm/idtentry.h:568)
[21299.957393] ? rcuref_put_slowpath (lib/rcuref.c:294 (discriminator =
1))
[21299.957476] dst_release (net/core/dst.c:166 (discriminator 1))
[21299.957559] rt_cache_route (net/ipv4/route.c:1499)
[21299.957641] rt_set_nexthop.isra.0 (net/ipv4/route.c:1606 =
(discriminator 1))
[21299.957722] ip_route_input_slow (./include/net/lwtunnel.h:140 =
net/ipv4/route.c:1875 net/ipv4/route.c:2154 net/ipv4/route.c:2337)
[21299.957804] ? free_unref_page (./include/linux/list.h:150 =
(discriminator 1) ./include/linux/list.h:169 (discriminator 1) =
mm/page_alloc.c:2377 (discriminator 1) mm/page_alloc.c:2428 =
(discriminator 1))
[21299.957889] ip_route_input_noref (net/ipv4/route.c:2499)
[21299.957972] ip_rcv_finish_core.isra.0 (net/ipv4/ip_input.c:367 =
(discriminator 1))
[21299.958058] ip_rcv (net/ipv4/ip_input.c:448 =
./include/linux/netfilter.h:304 ./include/linux/netfilter.h:298 =
net/ipv4/ip_input.c:569)
[21299.958139] ? ip_rcv_core (net/ipv4/ip_input.c:436)
[21299.958220] process_backlog (net/core/dev.c:5997)
[21299.958302] __napi_poll (net/core/dev.c:6556)
[21299.958384] net_rx_action (net/core/dev.c:6625 net/core/dev.c:6756)
[21299.958466] __do_softirq (./arch/x86/include/asm/preempt.h:27 =
kernel/softirq.c:564)
[21299.958549] irq_exit_rcu (kernel/softirq.c:436 kernel/softirq.c:641 =
kernel/softirq.c:653)
[21299.958631] sysvec_call_function_single (arch/x86/kernel/smp.c:262 =
(discriminator 47))
[21299.958714]  </IRQ>
[21299.958792]  <TASK>
[21299.958869] asm_sysvec_call_function_single =
(./arch/x86/include/asm/idtentry.h:656)
[21299.958953] RIP: 0010:acpi_safe_halt =
(./arch/x86/include/asm/irqflags.h:37 =
./arch/x86/include/asm/irqflags.h:72 drivers/acpi/processor_idle.c:113)
[21299.959038] Code: ed c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 65 48 =
8b 04 25 40 32 02 00 48 8b 00 a8 08 75 0c eb 07 0f 00 2d 57 0f 2c 00 fb =
f4 <fa> c3 0f 1f 00 0f b6 47 08 3c 01 74 0b 3c 02 74 05 8b 7f 04 eb 9f
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	ed                   	in     (%dx),%eax
   1:	c3                   	ret
   2:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   9:	00 00 00 00
   d:	66 90                	xchg   %ax,%ax
   f:	65 48 8b 04 25 40 32 	mov    %gs:0x23240,%rax
  16:	02 00
  18:	48 8b 00             	mov    (%rax),%rax
  1b:	a8 08                	test   $0x8,%al
  1d:	75 0c                	jne    0x2b
  1f:	eb 07                	jmp    0x28
  21:	0f 00 2d 57 0f 2c 00 	verw   0x2c0f57(%rip)        # 0x2c0f7f
  28:	fb                   	sti
  29:	f4                   	hlt
  2a:*	fa                   	cli    		<-- trapping instruction
  2b:	c3                   	ret
  2c:	0f 1f 00             	nopl   (%rax)
  2f:	0f b6 47 08          	movzbl 0x8(%rdi),%eax
  33:	3c 01                	cmp    $0x1,%al
  35:	74 0b                	je     0x42
  37:	3c 02                	cmp    $0x2,%al
  39:	74 05                	je     0x40
  3b:	8b 7f 04             	mov    0x4(%rdi),%edi
  3e:	eb 9f                	jmp    0xffffffffffffffdf

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	fa                   	cli
   1:	c3                   	ret
   2:	0f 1f 00             	nopl   (%rax)
   5:	0f b6 47 08          	movzbl 0x8(%rdi),%eax
   9:	3c 01                	cmp    $0x1,%al
   b:	74 0b                	je     0x18
   d:	3c 02                	cmp    $0x2,%al
   f:	74 05                	je     0x16
  11:	8b 7f 04             	mov    0x4(%rdi),%edi
  14:	eb 9f                	jmp    0xffffffffffffffb5
[21299.959162] RSP: 0018:ffff96a7c015be80 EFLAGS: 00000246
[21299.959247] RAX: 0000000000004000 RBX: 0000000000000001 RCX: =
000000000000001f
[21299.959343] RDX: ffff8b84bfbc0000 RSI: ffff8b75c76ba000 RDI: =
ffff8b75c76ba064
[21299.959437] RBP: ffffffffae216ea0 R08: ffffffffae216ea0 R09: =
0000000000000003
[21299.959533] R10: 0000000000000002 R11: 0000000000000008 R12: =
0000000000000001
[21299.959630] R13: ffffffffae216f08 R14: ffffffffae216f20 R15: =
0000000000000000
[21299.959725] acpi_idle_enter (drivers/acpi/processor_idle.c:709)
[21299.959807] cpuidle_enter_state (drivers/cpuidle/cpuidle.c:267)
[21299.959890] cpuidle_enter (drivers/cpuidle/cpuidle.c:390 =
(discriminator 2))
[21299.959975] do_idle (kernel/sched/idle.c:134 kernel/sched/idle.c:215 =
kernel/sched/idle.c:282)
[21299.960058] cpu_startup_entry (kernel/sched/idle.c:379)
[21299.960140] start_secondary (arch/x86/kernel/smpboot.c:326)
[21299.960223] secondary_startup_64_no_verify =
(arch/x86/kernel/head_64.S:433)
[21299.960306]  </TASK>
[21299.960384] ---[ end trace 0000000000000000 ]---

> On 22 Dec 2023, at 19:26, Martin Zaharinov <micron10@gmail.com> wrote:
>=20
> Hi Thomas,
>=20
> this is with applyed patch from you.
> See logs
>=20
>=20
> [43040.198064] ------------[ cut here ]------------
> [43040.198407] WARNING: CPU: 47 PID: 0 at lib/rcuref.c:294 =
rcuref_put_slowpath+0x2f/0x70
> [43040.198685] Modules linked in: pppoe pppox ppp_generic slhc =
nft_limit nft_ct nft_nat nft_chain_nat nf_tables netconsole tg3 igb =
i2c_algo_bit e1000e bnxt_en mlx5_core mlxfw mlx4_en mlx4_core i40e ixgbe =
mdio nf_nat_sip nf_conntrack_sip nf_nat_pptp nf_conntrack_pptp =
nf_nat_tftp nf_conntrack_tftp nf_nat_ftp nf_conntrack_ftp nf_nat =
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipmi_devintf ipmi_msghandler =
rtc_cmos
> [43040.199478] CPU: 47 PID: 0 Comm: swapper/47 Tainted: G           O  =
     6.6.8 #1
> [43040.199660] Hardware name: VMware, Inc. VMware Virtual =
Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
> [43040.199886] RIP: 0010:rcuref_put_slowpath+0x2f/0x70
> [43040.200028] Code: 07 83 f8 ff 75 19 ba 00 00 00 e0 f0 0f b1 17 83 =
f8 ff 74 04 31 c0 5b c3 b8 01 00 00 00 5b c3 3d ff ff ff bf 77 14 85 c0 =
78 06 <0f> 0b 31 c0 eb e6 c7 07 00 00 00 a0 31 c0 eb dc 80 3d e2 4e e3 =
00
> [43040.200387] RSP: 0018:ffffa39d83e88c30 EFLAGS: 00010246
> [43040.200528] RAX: 0000000000000000 RBX: ffff9c58e966b840 RCX: =
ffff9c5bc4e35680
> [43040.200700] RDX: ffff9c5fafde4f08 RSI: 00000000fffffe01 RDI: =
ffff9c58e966b840
> [43040.200871] RBP: ffff9c5fafde4f08 R08: ffff9c5fafde4f08 R09: =
0000000000000001
> [43040.201044] R10: 00000000000286e0 R11: 0000000000000001 R12: =
ffff9c58e966b800
> [43040.201255] R13: ffff9c58e966b868 R14: ffff9c5fafde4f08 R15: =
000000008f5de42b
> [43040.201439] FS:  0000000000000000(0000) GS:ffff9c5fafdc0000(0000) =
knlGS:0000000000000000
> [43040.201642] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [43040.201799] CR2: 00007f1401217714 CR3: 0000000464b94003 CR4: =
00000000001706e0
> [43040.201994] Call Trace:
> [43040.202095]  <IRQ>
> [43040.202187]  ? __warn+0x6c/0x130
> [43040.202301]  ? report_bug+0x1b8/0x200
> [43040.202418]  ? handle_bug+0x36/0x70
> [43040.202534]  ? exc_invalid_op+0x17/0x1a0
> [43040.202652]  ? asm_exc_invalid_op+0x16/0x20
> [43040.202781]  ? rcuref_put_slowpath+0x2f/0x70
> [43040.202909]  dst_release+0x1c/0x40
> [43040.203026]  rt_cache_route+0xbd/0xf0
> [43040.203143]  rt_set_nexthop.isra.0+0x1b6/0x450
> [43040.203272]  ip_route_input_slow+0x5d9/0xcc0
> [43040.203401]  ? nf_conntrack_udp_packet+0x17c/0x240 [nf_conntrack]
> [43040.203581]  ip_route_input_noref+0xe0/0xf0
> [43040.203704]  ip_rcv_finish_core.isra.0+0xbb/0x440
> [43040.203855]  ip_rcv+0xd5/0x110
> [43040.203962]  ? ip_rcv_core+0x360/0x360
> [43040.204079]  process_backlog+0x107/0x210
> [43040.204201]  __napi_poll+0x20/0x180
> [43040.204315]  net_rx_action+0x29f/0x380
> [43040.204432]  __do_softirq+0xd0/0x202
> [43040.204549]  irq_exit_rcu+0x82/0xa0
> [43040.204667]  common_interrupt+0x7a/0xa0
> [43040.204786]  </IRQ>
> [43040.204876]  <TASK>
> [43040.204965]  asm_common_interrupt+0x22/0x40
> [43040.205090] RIP: 0010:acpi_safe_halt+0x1b/0x20
> [43040.205220] Code: ed c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 65 =
48 8b 04 25 40 32 02 00 48 8b 00 a8 08 75 0c eb 07 0f 00 2d 57 0f 2c 00 =
fb f4 <fa> c3 0f 1f 00 0f b6 47 08 3c 01 74 0b 3c 02 74 05 8b 7f 04 eb =
9f
> [43040.205578] RSP: 0018:ffffa39d8234fe80 EFLAGS: 00000246
> [43040.205718] RAX: 0000000000004000 RBX: 0000000000000001 RCX: =
000000000000001f
> [43040.205890] RDX: ffff9c5fafdc0000 RSI: ffff9c5882e95800 RDI: =
ffff9c5882e95864
> [43040.206063] RBP: ffffffffa9216ea0 R08: ffffffffa9216ea0 R09: =
0000000000000003
> [43040.206246] R10: 0000000000000002 R11: 0000000000000008 R12: =
0000000000000001
> [43040.206419] R13: ffffffffa9216f08 R14: ffffffffa9216f20 R15: =
0000000000000000
> [43040.206593]  acpi_idle_enter+0x77/0xc0
> [43040.206711]  cpuidle_enter_state+0x69/0x6a0
> [43040.206835]  cpuidle_enter+0x24/0x40
> [43040.206954]  do_idle+0x1a7/0x210
> [43040.207066]  cpu_startup_entry+0x21/0x30
> [43040.207188]  start_secondary+0xe1/0xf0
> [43040.207310]  secondary_startup_64_no_verify+0x166/0x16b
> [43040.207451]  </TASK>
> [43040.207542] ---[ end trace 0000000000000000 ]---
>=20
>=20
>=20
> [43040.198064] ------------[ cut here ]------------
> [43040.198407] WARNING: CPU: 47 PID: 0 at lib/rcuref.c:294 =
rcuref_put_slowpath (lib/rcuref.c:294 (discriminator 1))
> [43040.198685] Modules linked in: pppoe pppox ppp_generic slhc =
nft_limit nft_ct nft_nat nft_chain_nat nf_tables netconsole tg3 igb =
i2c_algo_bit e1000e bnxt_en mlx5_core mlxfw mlx4_en mlx4_core i40e ixgbe =
mdio nf_nat_sip nf_conntrack_sip nf_nat_pptp nf_conntrack_pptp =
nf_nat_tftp nf_conntrack_tftp nf_nat_ftp nf_conntrack_ftp nf_nat =
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipmi_devintf ipmi_msghandler =
rtc_cmos
> [43040.199478] CPU: 47 PID: 0 Comm: swapper/47 Tainted: G           O  =
     6.6.8 #1
> [43040.199660] Hardware name: VMware, Inc. VMware Virtual =
Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
> [43040.199886] RIP: 0010:rcuref_put_slowpath (lib/rcuref.c:294 =
(discriminator 1))
> [43040.200028] Code: 07 83 f8 ff 75 19 ba 00 00 00 e0 f0 0f b1 17 83 =
f8 ff 74 04 31 c0 5b c3 b8 01 00 00 00 5b c3 3d ff ff ff bf 77 14 85 c0 =
78 06 <0f> 0b 31 c0 eb e6 c7 07 00 00 00 a0 31 c0 eb dc 80 3d e2 4e e3 =
00
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>   0: 07                    (bad)
>   1: 83 f8 ff              cmp    $0xffffffff,%eax
>   4: 75 19                 jne    0x1f
>   6: ba 00 00 00 e0        mov    $0xe0000000,%edx
>   b: f0 0f b1 17           lock cmpxchg %edx,(%rdi)
>   f: 83 f8 ff              cmp    $0xffffffff,%eax
>  12: 74 04                 je     0x18
>  14: 31 c0                 xor    %eax,%eax
>  16: 5b                    pop    %rbx
>  17: c3                    ret
>  18: b8 01 00 00 00        mov    $0x1,%eax
>  1d: 5b                    pop    %rbx
>  1e: c3                    ret
>  1f: 3d ff ff ff bf        cmp    $0xbfffffff,%eax
>  24: 77 14                 ja     0x3a
>  26: 85 c0                 test   %eax,%eax
>  28: 78 06                 js     0x30
>  2a:* 0f 0b                 ud2     <-- trapping instruction
>  2c: 31 c0                 xor    %eax,%eax
>  2e: eb e6                 jmp    0x16
>  30: c7 07 00 00 00 a0     movl   $0xa0000000,(%rdi)
>  36: 31 c0                 xor    %eax,%eax
>  38: eb dc                 jmp    0x16
>  3a: 80                    .byte 0x80
>  3b: 3d e2 4e e3 00        cmp    $0xe34ee2,%eax
>=20
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   0: 0f 0b                 ud2
>   2: 31 c0                 xor    %eax,%eax
>   4: eb e6                 jmp    0xffffffffffffffec
>   6: c7 07 00 00 00 a0     movl   $0xa0000000,(%rdi)
>   c: 31 c0                 xor    %eax,%eax
>   e: eb dc                 jmp    0xffffffffffffffec
>  10: 80                    .byte 0x80
>  11: 3d e2 4e e3 00        cmp    $0xe34ee2,%eax
> [43040.200387] RSP: 0018:ffffa39d83e88c30 EFLAGS: 00010246
> [43040.200528] RAX: 0000000000000000 RBX: ffff9c58e966b840 RCX: =
ffff9c5bc4e35680
> [43040.200700] RDX: ffff9c5fafde4f08 RSI: 00000000fffffe01 RDI: =
ffff9c58e966b840
> [43040.200871] RBP: ffff9c5fafde4f08 R08: ffff9c5fafde4f08 R09: =
0000000000000001
> [43040.201044] R10: 00000000000286e0 R11: 0000000000000001 R12: =
ffff9c58e966b800
> [43040.201255] R13: ffff9c58e966b868 R14: ffff9c5fafde4f08 R15: =
000000008f5de42b
> [43040.201439] FS:  0000000000000000(0000) GS:ffff9c5fafdc0000(0000) =
knlGS:0000000000000000
> [43040.201642] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [43040.201799] CR2: 00007f1401217714 CR3: 0000000464b94003 CR4: =
00000000001706e0
> [43040.201994] Call Trace:
> [43040.202095]  <IRQ>
> [43040.202187] ? __warn (kernel/panic.c:235 kernel/panic.c:673)
> [43040.202301] ? report_bug (lib/bug.c:180 lib/bug.c:219)
> [43040.202418] ? handle_bug (arch/x86/kernel/traps.c:237)
> [43040.202534] ? exc_invalid_op (arch/x86/kernel/traps.c:258 =
(discriminator 1))
> [43040.202652] ? asm_exc_invalid_op =
(./arch/x86/include/asm/idtentry.h:568)
> [43040.202781] ? rcuref_put_slowpath (lib/rcuref.c:294 (discriminator =
1))
> [43040.202909] dst_release (net/core/dst.c:166 (discriminator 1))
> [43040.203026] rt_cache_route (net/ipv4/route.c:1499)
> [43040.203143] rt_set_nexthop.isra.0 (net/ipv4/route.c:1606 =
(discriminator 1))
> [43040.203272] ip_route_input_slow (./include/net/lwtunnel.h:140 =
net/ipv4/route.c:1875 net/ipv4/route.c:2154 net/ipv4/route.c:2337)
> [43040.203401] ? nf_conntrack_udp_packet =
(net/netfilter/nf_conntrack_proto_udp.c:124) nf_conntrack
> [43040.203581] ip_route_input_noref (net/ipv4/route.c:2499)
> [43040.203704] ip_rcv_finish_core.isra.0 (net/ipv4/ip_input.c:367 =
(discriminator 1))
> [43040.203855] ip_rcv (net/ipv4/ip_input.c:448 =
./include/linux/netfilter.h:304 ./include/linux/netfilter.h:298 =
net/ipv4/ip_input.c:569)
> [43040.203962] ? ip_rcv_core (net/ipv4/ip_input.c:436)
> [43040.204079] process_backlog (net/core/dev.c:5997)
> [43040.204201] __napi_poll (net/core/dev.c:6556)
> [43040.204315] net_rx_action (net/core/dev.c:6625 net/core/dev.c:6756)
> [43040.204432] __do_softirq (./arch/x86/include/asm/preempt.h:27 =
kernel/softirq.c:564)
> [43040.204549] irq_exit_rcu (kernel/softirq.c:436 kernel/softirq.c:641 =
kernel/softirq.c:653)
> [43040.204667] common_interrupt (arch/x86/kernel/irq.c:247 =
(discriminator 47))
> [43040.204786]  </IRQ>
> [43040.204876]  <TASK>
> [43040.204965] asm_common_interrupt =
(./arch/x86/include/asm/idtentry.h:640)
> [43040.205090] RIP: 0010:acpi_safe_halt =
(./arch/x86/include/asm/irqflags.h:37 =
./arch/x86/include/asm/irqflags.h:72 drivers/acpi/processor_idle.c:113)
> [43040.205220] Code: ed c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 65 =
48 8b 04 25 40 32 02 00 48 8b 00 a8 08 75 0c eb 07 0f 00 2d 57 0f 2c 00 =
fb f4 <fa> c3 0f 1f 00 0f b6 47 08 3c 01 74 0b 3c 02 74 05 8b 7f 04 eb =
9f
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>   0: ed                    in     (%dx),%eax
>   1: c3                    ret
>   2: 66 66 2e 0f 1f 84 00 data16 cs nopw 0x0(%rax,%rax,1)
>   9: 00 00 00 00
>   d: 66 90                 xchg   %ax,%ax
>   f: 65 48 8b 04 25 40 32 mov    %gs:0x23240,%rax
>  16: 02 00
>  18: 48 8b 00              mov    (%rax),%rax
>  1b: a8 08                 test   $0x8,%al
>  1d: 75 0c                 jne    0x2b
>  1f: eb 07                 jmp    0x28
>  21: 0f 00 2d 57 0f 2c 00 verw   0x2c0f57(%rip)        # 0x2c0f7f
>  28: fb                    sti
>  29: f4                    hlt
>  2a:* fa                    cli     <-- trapping instruction
>  2b: c3                    ret
>  2c: 0f 1f 00              nopl   (%rax)
>  2f: 0f b6 47 08           movzbl 0x8(%rdi),%eax
>  33: 3c 01                 cmp    $0x1,%al
>  35: 74 0b                 je     0x42
>  37: 3c 02                 cmp    $0x2,%al
>  39: 74 05                 je     0x40
>  3b: 8b 7f 04              mov    0x4(%rdi),%edi
>  3e: eb 9f                 jmp    0xffffffffffffffdf
>=20
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   0: fa                    cli
>   1: c3                    ret
>   2: 0f 1f 00              nopl   (%rax)
>   5: 0f b6 47 08           movzbl 0x8(%rdi),%eax
>   9: 3c 01                 cmp    $0x1,%al
>   b: 74 0b                 je     0x18
>   d: 3c 02                 cmp    $0x2,%al
>   f: 74 05                 je     0x16
>  11: 8b 7f 04              mov    0x4(%rdi),%edi
>  14: eb 9f                 jmp    0xffffffffffffffb5
> [43040.205578] RSP: 0018:ffffa39d8234fe80 EFLAGS: 00000246
> [43040.205718] RAX: 0000000000004000 RBX: 0000000000000001 RCX: =
000000000000001f
> [43040.205890] RDX: ffff9c5fafdc0000 RSI: ffff9c5882e95800 RDI: =
ffff9c5882e95864
> [43040.206063] RBP: ffffffffa9216ea0 R08: ffffffffa9216ea0 R09: =
0000000000000003
> [43040.206246] R10: 0000000000000002 R11: 0000000000000008 R12: =
0000000000000001
> [43040.206419] R13: ffffffffa9216f08 R14: ffffffffa9216f20 R15: =
0000000000000000
> [43040.206593] acpi_idle_enter (drivers/acpi/processor_idle.c:709)
> [43040.206711] cpuidle_enter_state (drivers/cpuidle/cpuidle.c:267)
> [43040.206835] cpuidle_enter (drivers/cpuidle/cpuidle.c:390 =
(discriminator 2))
> [43040.206954] do_idle (kernel/sched/idle.c:134 =
kernel/sched/idle.c:215 kernel/sched/idle.c:282)
> [43040.207066] cpu_startup_entry (kernel/sched/idle.c:379)
> [43040.207188] start_secondary (arch/x86/kernel/smpboot.c:326)
> [43040.207310] secondary_startup_64_no_verify =
(arch/x86/kernel/head_64.S:433)
> [43040.207451]  </TASK>
> [43040.207542] ---[ end trace 0000000000000000 ]---
>=20
>> On 19 Dec 2023, at 16:26, Thomas Gleixner <tglx@linutronix.de> wrote:
>>=20
>> On Tue, Dec 19 2023 at 11:25, Martin Zaharinov wrote:
>>>> On 12 Dec 2023, at 20:16, Thomas Gleixner <tglx@linutronix.de> =
wrote:
>>>> Btw, how easy is this to reproduce?
>>>=20
>>> Its not easy this report is generate on machine with 5-6k users , =
with
>>> traffic and one time is show on 1 day , other show after 4-5 days=E2=80=
=A6
>>=20
>> I love those bugs ...
>>=20
>>> Apply this patch and will upload image on one machine as fast as
>>> possible and when get any reports will send you.
>>=20
>> Let's see how that goes!
>>=20
>> Thanks,
>>=20
>>       tglx
>=20


