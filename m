Return-Path: <netdev+bounces-211912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E7DB1C6D5
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 15:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FA847A0621
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 13:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06CC256C9E;
	Wed,  6 Aug 2025 13:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bvyfvs/U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB88D7261C
	for <netdev@vger.kernel.org>; Wed,  6 Aug 2025 13:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754487151; cv=none; b=P0UC3GWbYNnT+7JVEYgHP9CEn9ofVo1homcSlbHtAnIYxvCB8AfHpAO7Gz7B2w13fFV4MBqoH+KKfc6PwUsb70IbiZOfcdppv6wXPj+nF/oVyhIZOYP5NpkT/I+6jTOw0afcicTRCo/PCnK5lDVZ8FslNUQmSAAesPdV2OYtCP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754487151; c=relaxed/simple;
	bh=xwRkCmpyqHSRPmxd2ruG4MeaEVYCKxWJ2TdSLQd1ni8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=OKotK/86LuaVzBmXOKiea2aNaIa6xurRoQaQ7uxtwuMWDOEjheYtWdjNXmSOyZ1SCLSW8ZtiIoy59ul7JyMNvcPhnw/+yYYi3/+YDpQ1+6Dh0XfWi5ELm3Z93FJxSP3gAutnCYLtfPcLdJ3RjziZI7gJoCQU/iTzKW+wIMF8pVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bvyfvs/U; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4fc05400905so2178810137.3
        for <netdev@vger.kernel.org>; Wed, 06 Aug 2025 06:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754487149; x=1755091949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujS1cSEf6AaBWvYbBrhPqDYZvEkGO5uQHE5v6ltz24Q=;
        b=Bvyfvs/UDcbYq0uOniToJDQP76QrUvWJlZBtedBz7XwCmbLae0vust1SQdp6Oy1kaP
         qGehjwirN5P0pCRxcZZNjBIqqOh+L3YdSU3OsIJiildnMDCMA5M2G5nmT2QELY6bsgWP
         cSk2q9DpijgeK2N90ot7dlNE8r0Id/HZP3OI76emIexFxbGXulXQeaXUh/kT3UUa4lGM
         4fSSHT1BgYsYwGzlBbBCq5uh4KI9GKCamJcEfpk4ruxwiR69Bg1onjYtfOl0DbFokxFH
         DapgjqoZ5wF2tVmDBsQzqDaChvfx9bz9SC/4f0DHNp/ePvFH3XqKcok0mvOXIRGb0Zua
         CwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754487149; x=1755091949;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ujS1cSEf6AaBWvYbBrhPqDYZvEkGO5uQHE5v6ltz24Q=;
        b=wV+JPSjJe0CTC49EQdhXZAc9FWkBueyIsdjIBe9CcDt96iFxqzWDkwCyPwmyubhVML
         UWeMAGKwOqFrwBh+JoDWoEEAunxq63WGMtTlWTfyru1eLq2ClsVaEUHpuivgYjTBWAVg
         VK3flhGUeDdS2mO52LZ6ie5PCf96qbp5fEkS0+ZM/e3ylYpz0NbWvJMQdFvYSwuSlVp2
         7QD4yeR5QnpQ+xJybAvP9b5WGayTlys1X5QJ/x8QrNI9THhOHwFKgmalgY4qo6IZneP+
         kENlio8x81e60Fr5g2HYZB2V4o5tobe0ye2+lnRtMAP3v2QoayW1QpN0rFbb6YR1HQY1
         kYhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUl6j+X2ceIJ8HT23B24LC4YP8yu56URpgTRm1DEY4AM/QfMnC0kFx9Q4J20W2E2tc8YioYHK0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/s+j4GSuj2l7K0VGu/cLa45/LoNv4vNoxHX1kwHosUbpSAK81
	a8aP432lZA6ZBcpKo3RnllvlFY9zR0xgExQEU9XpmOO7c9bqFjQE2XdCSJpaE3nd
X-Gm-Gg: ASbGnctI2TdafI4L0bLgGGI17OnuL8mV5jeuFinm6Dv0F2qQaXNi2PZfJF7g98auv67
	64EcukzTK7AMsHFAceCf/RVw7X/mdvszgAB6ac+UtEvrnkYBvqeR0z3tmU4MZ13SDQkOKj7bh9/
	KNJD+hmcrVI47A1GsHYk0S1CNzBixOob0eeB6X1jcd57OqzGW6lmLmoM6gvGsdcjDllDjYbn0JT
	WTx45gHCJRn3lvF+44vq/ZUetKVa2CQYHCY4L1HjP7JFfRthwZbXtHZNQqS+a4SyHPFUbU9wcf+
	faSuoj/y7OnFWYLhyHEbGZtmexscFYaIyTYTQMTfyKv++1zOuk2u0A75OMRA6F0r1gRfLLpAaE0
	mi07kvw+3P5Z8MTAHgXk1f25BM07zWzvXxV427uMWv7dI7HGXcBtbn+julq+kTwYr8SweqhnHWB
	zw605L
X-Google-Smtp-Source: AGHT+IE6Yj/4LUB0YKq8UTzLnUpew3RAUXZ+l3r9r4u0fgMPhvC3Yqne5tLjcI1IIZFi6fVgil3D7g==
X-Received: by 2002:a05:6102:d93:b0:4e5:aa74:ac0 with SMTP id ada2fe7eead31-503715d0ff0mr1058390137.8.1754487148429;
        Wed, 06 Aug 2025 06:32:28 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e806ad969dsm320686285a.78.2025.08.06.06.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 06:32:27 -0700 (PDT)
Date: Wed, 06 Aug 2025 09:32:26 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Ramaseuski <jramaseu@redhat.com>, 
 netdev@vger.kernel.org
Cc: kuba@kernel.org, 
 horms@kernel.org, 
 pabeni@redhat.com, 
 Jakub Ramaseuski <jramaseu@redhat.com>, 
 Tianhao Zhao <tizhao@redhat.com>, 
 Michal Schmidt <mschmidt@redhat.com>
Message-ID: <6893596a9b057_1500a329471@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250805121627.311053-1-jramaseu@redhat.com>
References: <20250805121627.311053-1-jramaseu@redhat.com>
Subject: Re: [PATCH net] net: mask NETIF_F_IPV6_CSUM flag on irregular packet
 header size
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Ramaseuski wrote:
> Throughput with GRE on IPv6 drops to 0 on NICs that use ice/bnxt_en
> or any driver with NETIF_F_IP_CSUM and NETIF_F_IPV6_CSUM set and with
> NETIF_F_HW_CSUM unset, see following dmesg output for more info.

HW_CSUM is generally not advertised if IP_CSUM and IPV6_CSUM are.
HW_CSUM is a superset, and generally advisable. But some devices
only support specific protocols..

The pertinent comment here is that SKB_GSO_TCPV6 cannot be segmented
if NETIF_F_IPV6_CSUM is set. And the same for SKB_GSO_UDP_L4 if
ETH_P_IPV6.

> bnxt_en: caps=(0x009201c01dd14833, 0x0000000e401d4869)
> WARNING: CPU: 1 PID: 5273 at net/core/dev.c:3535 skb_warn_bad_offload+0x81/0x140
> Modules linked in: ip6_gre gre ip6_tunnel tunnel6 mlx5_ib mlx5_fwctl macsec fwctl rfkill irdma ib_uverbs ib_core amd_atl intel_rapl_msr intel_rapl_common amd64_edac edac_mce_amd kvm_amd ipmi_ssif mlx5_core kvm mlxfw psample acpi_ipmi ice tls ast irqbypass i40e tg3 bnxt_en rapl wmi_bmof i2c_algo_bit pcspkr acpi_cpufreq pci_hyperv_intf ipmi_si i2c_piix4 gnss k10temp i2c_smbus libie ptdma ipmi_devintf ipmi_msghandler joydev sg loop fuse nfnetlink xfs sd_mod ahci libahci libata ghash_clmulni_intel ccp sp5100_tco wmi dm_mirror dm_region_hash dm_log dm_mod
> CPU: 1 UID: 0 PID: 5273 Comm: iperf3 Kdump: loaded Not tainted 6.16.0-0.rc7.60.eln150.x86_64 #1 PREEMPT(lazy)
> Hardware name: Abacus electric, s.r.o. - servis@abacus.cz Super Server/H12SSW-iN, BIOS 2.7 10/25/2023
> RIP: 0010:skb_warn_bad_offload+0x81/0x140
> Code: 8d 88 18 02 00 00 48 85 c0 48 c7 c0 28 43 41 9e 48 0f 44 c8 48 8d 93 b8 00 00 00 4c 89 c6 48 c7 c7 b3 92 a3 9e e8 cf 0e 4e ff <0f> 0b 48 83 c4 08 5b 5d e9 6d b5 2a ff 80 bb 20 01 00 00 00 74 1d
> RSP: 0018:ffffcfed417aef70 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff8ec94e59c000 RCX: 0000000000000000
> RDX: ffff8ed84e66a500 RSI: 0000000000000001 RDI: ffff8ed84e65c200
> RBP: ffff8ecb1716e0e8 R08: 0000000000000000 R09: 00000000ffff7fff
> R10: ffffffff9f265700 R11: ffffcfed417aee08 R12: ffff8ec94e59c000
> R13: ffffcfed417af023 R14: ffff8ec94e59c000 R15: ffffcfed417af023
> FS:  00007f7ee69516c0(0000) GS:ffff8ed8ae504000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f7ee6950f78 CR3: 000000011436c006 CR4: 0000000000f70ef0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  skb_checksum_help+0x12a/0x1f0
>  ? netif_skb_features+0xc1/0x2e0
>  validate_xmit_skb+0x1a3/0x2d0
>  validate_xmit_skb_list+0x4f/0x80
>  sch_direct_xmit+0x1a2/0x380
>  __dev_xmit_skb+0x242/0x670
>  __dev_queue_xmit+0x3fc/0x7f0
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? ip6_rt_copy_init+0xf0/0x290
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? selinux_ip_postroute+0x1c5/0x420
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ip6_finish_output2+0x25e/0x5d0
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? nf_hook_slow+0x47/0xf0
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ip6_finish_output+0x1fc/0x3f0
>  ip6_tnl_xmit+0x608/0xc00 [ip6_tunnel]
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ip6gre_tunnel_xmit+0x1c0/0x390 [ip6_gre]
>  dev_hard_start_xmit+0x63/0x1c0
>  __dev_queue_xmit+0x6d0/0x7f0
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? chacha_block_generic+0x72/0xd0
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? selinux_ip_postroute+0x1c5/0x420
>  ip6_finish_output2+0x214/0x5d0
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? nf_hook_slow+0x47/0xf0
>  ip6_finish_output+0x1fc/0x3f0
>  ip6_xmit+0x2ca/0x6f0
>  ? __pfx_dst_output+0x10/0x10
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? __sk_dst_check+0x41/0xc0
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? inet6_csk_route_socket+0x12e/0x200
>  inet6_csk_xmit+0xeb/0x150
>  __tcp_transmit_skb+0x555/0xa80
>  tcp_write_xmit+0x32a/0xe90
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? skb_do_copy_data_nocache+0xc9/0x150
>  tcp_sendmsg_locked+0x437/0x1110
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  tcp_sendmsg+0x2f/0x50

Report can be truncated here.

>  sock_write_iter+0x126/0x1a0
>  vfs_write+0x3c8/0x480
>  ksys_write+0xbf/0xf0
>  do_syscall_64+0x7c/0x970
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? syscall_exit_work+0x143/0x1b0
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? do_syscall_64+0xaf/0x970
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? __rseq_handle_notify_resume+0x39/0x60
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? exit_to_user_mode_loop+0xbf/0x120
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? do_syscall_64+0xaf/0x970
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? drain_stock+0x79/0xa0
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? __mem_cgroup_threshold+0x18/0xf0
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? memcg1_check_events+0x60/0x1b0
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? memcg1_commit_charge+0x6f/0x90
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? mod_memcg_lruvec_state+0x1a4/0x200
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? __lruvec_stat_mod_folio+0x85/0xd0
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? __folio_mod_stat+0x2d/0x90
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? folio_add_new_anon_rmap+0x72/0x1b0
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? do_anonymous_page+0x49c/0x710
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? syscall_exit_work+0x143/0x1b0
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? do_syscall_64+0xaf/0x970
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? count_memcg_events+0x14d/0x1a0
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? handle_mm_fault+0x247/0x360
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? do_user_addr_fault+0x20f/0x6a0
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? irqentry_exit_to_user_mode+0x2c/0x180
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x7f7ee713098f
> Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 39 7a f9 ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 8c 7a f9 ff 48
> RSP: 002b:00007f7ee6950e00 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f7ee713098f
> RDX: 0000000000020000 RSI: 00007f7ee6f11000 RDI: 0000000000000005
> RBP: 00007f7ee6f11000 R08: 0000000000000002 R09: 00007f7ee69516c0
> R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000005
> R13: 0000000000020000 R14: 00007ffea6ee3400 R15: 00007ffea6ee3507
>  </TASK>
> ---[ end trace 0000000000000000 ]---
> skb len=7018 headroom=182 headlen=138 tailroom=0
> mac=(182,14) mac_len=0 net=(196,48) trans=244
> shinfo(txflags=0 nr_frags=1 gso(size=1376 type=80 segs=5))
> csum(0x100120 start=288 offset=16 ip_summed=3 complete_sw=0 valid=0 level=0)
> hash(0x7ec90a00 sw=0 l4=1) proto=0x86dd pkttype=0 iif=0
> priority=0x0 mark=0x0 alloc_cpu=1 vlan_all=0x0
> encapsulation=1 inner(proto=0xdd86, mac=248, net=248, trans=288)
> dev name=enp1s0f0np0 feat=0x009201c01dd14833
> sk family=10 type=1 proto=6

In this case we can trim the payload. It can often help debug these
issues, but is not needed to understand the root cause here.

> skb linear:   00000000: e4 3d 1a 7d ec 30 e4 3d 1a 7e 5d 90 86 dd 60 0e
> skb linear:   00000010: 00 0a 1b 34 3c 40 20 11 00 00 00 00 00 00 00 00
> skb linear:   00000020: 00 00 00 00 00 12 20 11 00 00 00 00 00 00 00 00
> skb linear:   00000030: 00 00 00 00 00 11 2f 00 04 01 04 01 01 00 00 00
> skb linear:   00000040: 86 dd 60 0e 00 0a 1b 00 06 40 20 23 00 00 00 00
> skb linear:   00000050: 00 00 00 00 00 00 00 00 00 12 20 23 00 00 00 00
> skb linear:   00000060: 00 00 00 00 00 00 00 00 00 11 bf 96 14 51 13 f9
> skb linear:   00000070: ae 27 a0 a8 2b e3 80 18 00 40 5b 6f 00 00 01 01
> skb linear:   00000080: 08 0a 42 d4 50 d5 4b 70 f8 1a
> skb frag:     00000000: 80 de bb bd 51 f8 32 e7 5d f5 65 65 a1 22 76 05
> skb frag:     00000010: 02 f8 60 25 e6 37 0b b3 90 05 8e 7f f4 c2 5d 9c
> skb frag:     00000020: e3 24 84 ac 0e 03 9d 14 ac 1e e2 18 4c 45 ef 5f
> skb frag:     00000030: db 95 db ab 1f c9 7f 6d 19 70 1f 0c e7 6e fd 6e
> skb frag:     00000040: f4 ff 73 1e 06 8d a8 06 53 ba bf 58 12 cb b9 59
> skb frag:     00000050: f0 71 7e c3 69 0a f5 19 8b b3 eb b1 fa e5 9c 59
> skb frag:     00000060: 40 bb 1d 11 88 f4 c1 cc 77 91 41 2c bb 7e 9d b7
> skb frag:     00000070: ac 50 1a e3 d1 ce f7 f9 58 e4 d5 5c 62 f4 eb 39
> skb frag:     00000080: 0d 13 2a 31 2c ec

> ------------[ cut here ]------------
> 
> Mask NETIF_F_IPV6_CSUM in gso_features_check if the IPv6 header contains
> extension headers. This flag indicates that the network interface
> is capable of computing the checksum only for plain IPv6 headers
> without any extension headers.
> 
> The exception is a BIG TCP extension, which, as stated in 68e068cabd2c6c53:
> "The feature is only enabled on devices that support BIG TCP TSO.
> The header is only present for PF_PACKET taps like tcpdump,
> and not transmitted by physical devices."
> 
> Fixes: 04c20a9356f283da ("net: skip offload for NETIF_F_IPV6_CSUM if ipv6 header contains extension")

That fix is still a valid fix to fall back onto software checksum
offload for non GSO packets.

This fix addresses the same for GSO packets.

That fix is not wrong, and still needed (this patch also does not modify or remove its code).

> Reported-by: Tianhao Zhao <tizhao@redhat.com>
> Suggested-by: Michal Schmidt <mschmidt@redhat.com>
> Signed-off-by: Jakub Ramaseuski <jramaseu@redhat.com>
> ---
> ---
>  net/core/dev.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index b28ce68830b2b..118c433c2cb9b 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3778,6 +3778,10 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
>  		if (!(iph->frag_off & htons(IP_DF)))
>  			features &= ~NETIF_F_TSO_MANGLEID;
>  	}
> +	if (vlan_get_protocol(skb) == htons(ETH_P_IPV6) &&
> +		skb_network_header_len(skb) != sizeof(struct ipv6hdr) &&
> +		!ipv6_has_hopopt_jumbo(skb))
> +		features &= ~NETIF_F_IPV6_CSUM;

Exit the branch as soon as possible. Avoid the Ethernet header lookup
if possible.

And unfortunately transport header cannot be guaranted with
virtio_net_hdr_to_skb.

         /* NETIF_F_IPV6_CSUM does not support IPv6 extension headers,
          * so neither does TSO that depends on it.
          */
         if (features & NETIF_F_IPV6_CSUM &&
             (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
              (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
	       vlan_get_protocol(skb) == htons(ETH_P_IPV6))) &&
              skb_transport_header_was_set(skb) &&
              skb_network_header_len(skb) != sizeof(struct ipv6hdr) &&
              !ipv6_has_hopopt_jumbo(skb))
                 features &= ~(NETIF_F_IPV6_CSUM | NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4);


>  	return features;
>  }
> -- 
> 2.50.1
> 



