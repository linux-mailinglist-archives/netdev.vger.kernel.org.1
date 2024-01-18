Return-Path: <netdev+bounces-64210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93569831C8E
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 16:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4353C28102D
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 15:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1349128DA0;
	Thu, 18 Jan 2024 15:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWinFRiz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FEA288DC
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 15:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705591648; cv=none; b=KVVBpgFYihGb2RBtwcnsFp4B6pl0AW/fkFS5NxQaUiIZpeVJwY3p5hGN2ed4YR+sYlSekCScidg+v+ZS2pbUUppr27wg+hyp/IWODcCvXX3k/0vmHYAuFhteZr70mJeZeRIXXg4ooN8rR6J7pbKK06EWtX7XMVH13NzrTLuWRzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705591648; c=relaxed/simple;
	bh=grS8ceYUdjKqmaOoRcqNg9lFXy+lp6xO3KbSztWR5vc=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=eT7u6senzpNuotqQOJTzo09szQEPdgV8BQinGYQVAzBm/FKX/sMsvysdXt6juDbx83ChmONu2yLxprogh3V4p2ORFn+Fn7IRARFQhv6vGptXkGnFeAxedyU8V9cezFbIjLJVMLgFaH9hur/fbub1EPO6LjsTTkG7PafLPJtlLw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWinFRiz; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4b73e952ef2so2231312e0c.2
        for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 07:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705591645; x=1706196445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1POn09qNCXSuWXxyGGrt+EHblhZ2mxGP+09junNFsic=;
        b=UWinFRiz6aJl2+c6YqjG6GXhPLYYNCPiq0FGWJwkUjzGEgduzJ1jJX903N2am+TGf1
         4cQ/8SZsOPJXZYzYMTaCu+xFKoYCs//YDGevQOSGVB4JfaeIZp9q8C/4eHv5s1qmSKBz
         /kvpn5kMR7TUlfz8YWt43IKk6m9FCtPHpdOnnFBoZR9DTr1lEc0zSTcdymKCnzZHDXGp
         XsbQ/DAw+w30lAG7NqTd4/sLXi0r3TehKhe35Lx5NAm/G9ZnkqvyjptBCrvnrkTWBRJ+
         GFnbl3sjFBoQciuncxegnUx0CDd9wdNDWkDPficF1fFmvPrV6AEB2BUiMGPgjDYaJxui
         8sVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705591645; x=1706196445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1POn09qNCXSuWXxyGGrt+EHblhZ2mxGP+09junNFsic=;
        b=mcIbSbr5KNnx841d/OTUWh2nV+VLq7DMl2MyGU8NdMWXOKHmpfix88dM6NLC5G8jdt
         LbrcYaEQG7CPZcUMxJqQpwT3tRzkqs5n4zlDyh1iUgOTWyaCw6+49C1njM4h9NS9IsYE
         id+t01bCOpPuxvFF4zaLbR16DIT4IWDw0VqAvkVOgeU61S7atT1SMtYQpMcsNa+grLly
         glsoNx00Gpz0ix+j9UdOZ4OHLRuDuUfoq9bMclQpUVi5TC+VpU6ruN94VHoXK53cWzuC
         U0Kv8bbUBDu9ymT5b3Aj79mef93yHN8pJiGHguKooVlssFkTCQqkcKMhp/lpLDtZyt/c
         FfpA==
X-Gm-Message-State: AOJu0YzkZxDMUEXQYvRqo+68qF9tz1iyLOrO3UngXzQgXNyF6U2AVjWj
	P+PgZDNxiVRX0n+xEA9acAmrK8vT1dwnbZUz3qydzJIlodHpHLPzYGISa6ReRCH+kxPU7lxxaOQ
	f9vPzC+4OzxP3uWjon/oHweaXsEcNcg+9
X-Google-Smtp-Source: AGHT+IFYJd+BzkBcT5W3txgtLObiSfcPtX/ThzGOpN8Gcf9lGCDrbUnxEuA2UayZBVcVlIvODLZvcVsHPSmWfjXigDw=
X-Received: by 2002:a1f:ed82:0:b0:4b6:cdb7:9818 with SMTP id
 l124-20020a1fed82000000b004b6cdb79818mr485596vkh.8.1705591645017; Thu, 18 Jan
 2024 07:27:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA85sZvvHtrpTQRqdaOx6gd55zPAVsqMYk_Lwh4Md5knTq7AyA@mail.gmail.com>
In-Reply-To: <CAA85sZvvHtrpTQRqdaOx6gd55zPAVsqMYk_Lwh4Md5knTq7AyA@mail.gmail.com>
From: Ian Kumlien <ian.kumlien@gmail.com>
Date: Thu, 18 Jan 2024 16:27:13 +0100
Message-ID: <CAA85sZtZ9cL4g-SFSS-pTL11JocoOc4BAU7b4uj26MNckp41wQ@mail.gmail.com>
Subject: Re: [mlx5e] FYI dmesg is filled with mlx5e_page_release_fragmented.isra
 warnings in 6.6.12
To: Linux Kernel Network Developers <netdev@vger.kernel.org>
Cc: saeedm@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ok, so after about 200 of these, we had a full kernel oops. more
graceful than earlier kernels but...

On Thu, Jan 18, 2024 at 4:08=E2=80=AFPM Ian Kumlien <ian.kumlien@gmail.com>=
 wrote:
>
> [ 1068.937101] ------------[ cut here ]------------
> [ 1068.937977] WARNING: CPU: 0 PID: 0 at
> include/net/page_pool/helpers.h:130
> mlx5e_page_release_fragmented.isra.0+0x46/0x50 [mlx5_core]
> [ 1068.939407] Modules linked in: echainiv(E) esp4(E)
> xfrm_interface(E) xfrm6_tunnel(E) tunnel4(E) tunnel6(E) xt_policy(E)
> xt_physdev(E) xt_nat(E) xt_REDIRECT(E) xt_comment(E) xt_connmark(E)
> xt_mark(E) vxlan(E) ip6_udp_tunnel(E) udp_tunnel(E)
> nfnetlink_cttimeout(E) xt_conntrack(E) nft_chain_nat(E)
> xt_MASQUERADE(E) nf_conntrack_netlink(E) xt_addrtype(E) nft_compat(E)
> nf_tables(E) nfnetlink(E) br_netfilter(E) bridge(E) 8021q(E) garp(E)
> mrp(E) stp(E) llc(E) overlay(E) bonding(E) cfg80211(E) rfkill(E)
> ipmi_ssif(E) intel_rapl_msr(E) intel_rapl_common(E) sb_edac(E)
> x86_pkg_temp_thermal(E) intel_powerclamp(E) vfat(E) fat(E) coretemp(E)
> kvm_intel(E) kvm(E) iTCO_wdt(E) mlx5_ib(E) intel_pmc_bxt(E)
> iTCO_vendor_support(E) acpi_ipmi(E) i2c_algo_bit(E) ipmi_si(E)
> irqbypass(E) ib_uverbs(E) drm_shmem_helper(E) ipmi_devintf(E)
> ioatdma(E) rapl(E) i2c_i801(E) intel_cstate(E) ib_core(E)
> intel_uncore(E) pcspkr(E) drm_kms_helper(E) joydev(E) lpc_ich(E)
> hpilo(E) acpi_tad(E) ipmi_msghandler(E) acpi_power_meter(E) dca(E)
> i2c_smbus(E) xfs(E)
> [ 1068.939782]  drm(E) openvswitch(E) nf_conncount(E) nf_nat(E)
> ext4(E) mbcache(E) jbd2(E) mlx5_core(E) sd_mod(E) t10_pi(E) sg(E)
> crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E)
> polyval_generic(E) serio_raw(E) ghash_clmulni_intel(E) mlxfw(E) tg3(E)
> hpsa(E) tls(E) hpwdt(E) scsi_transport_sas(E) psample(E) wmi(E)
> pci_hyperv_intf(E) dm_mirror(E) dm_region_hash(E) dm_log(E) dm_mod(E)
> nf_conntrack(E) libcrc32c(E) crc32c_intel(E) nf_defrag_ipv6(E)
> nf_defrag_ipv4(E) ip6_tables(E) fuse(E)
> [ 1068.947864] CPU: 0 PID: 0 Comm: swapper/0 Kdump: loaded Tainted: G
>       W   E      6.6.12-1.el9.elrepo.x86_64 #1
> [ 1068.949014] Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360
> Gen9, BIOS P89 11/23/2021
> [ 1068.949552] RIP:
> 0010:mlx5e_page_release_fragmented.isra.0+0x46/0x50 [mlx5_core]
> [ 1068.951033] Code: f7 da f0 48 0f c1 56 28 48 39 c2 78 1d 74 05 c3
> cc cc cc cc 48 8b bf 60 04 00 00 b9 01 00 00 00 ba ff ff ff ff e9 da
> f7 f3 da <0f> 0b c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90
> 90 90
> [ 1068.952632] RSP: 0018:ffffb3a800003df0 EFLAGS: 00010297
> [ 1068.953301] RAX: 000000000000003d RBX: ffff987f51b78000 RCX: 000000000=
0000050
> [ 1068.954279] RDX: 0000000000000000 RSI: ffffdb5246508580 RDI: ffff987f5=
1b78000
> [ 1068.955358] RBP: ffff987fcdb0b540 R08: 0000000000000006 R09: ffff988ec=
44830c0
> [ 1068.957674] R10: 0000000000000000 R11: ffff987fcab77040 R12: 000000000=
0000040
> [ 1068.958669] R13: 0000000000000040 R14: ffff987fcdb0b168 R15: 000000000=
000003c
> [ 1068.959828] FS:  0000000000000000(0000) GS:ffff988ebfc00000(0000)
> knlGS:0000000000000000
> [ 1068.960466] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1068.961350] CR2: 00007f173925a4e0 CR3: 0000001067a1e006 CR4: 000000000=
01706f0
> [ 1068.962230] Call Trace:
> [ 1068.962478]  <IRQ>
> [ 1068.963055]  ? __warn+0x80/0x130
> [ 1068.963073]  ? mlx5e_page_release_fragmented.isra.0+0x46/0x50 [mlx5_co=
re]
> [ 1068.964275]  ? report_bug+0x1c3/0x1d0
> [ 1068.964585]  ? handle_bug+0x42/0x70
> [ 1068.965228]  ? exc_invalid_op+0x14/0x70
> [ 1068.965538]  ? asm_exc_invalid_op+0x16/0x20
> [ 1068.965854]  ? mlx5e_page_release_fragmented.isra.0+0x46/0x50 [mlx5_co=
re]
> [ 1068.966518]  mlx5e_free_rx_mpwqe+0x18e/0x1c0 [mlx5_core]
> [ 1068.967221]  mlx5e_post_rx_mpwqes+0x1a5/0x280 [mlx5_core]
> [ 1068.967810]  mlx5e_napi_poll+0x143/0x710 [mlx5_core]
> [ 1068.968416]  ? __netif_receive_skb_one_core+0x92/0xa0
> [ 1068.968799]  __napi_poll+0x2c/0x1b0
> [ 1068.970066]  net_rx_action+0x2a7/0x370
> [ 1068.971012]  ? mlx5_cq_tasklet_cb+0x78/0x180 [mlx5_core]
> [ 1068.971683]  __do_softirq+0xf0/0x2ee
> [ 1068.972002]  __irq_exit_rcu+0x83/0xf0
> [ 1068.972338]  common_interrupt+0xb8/0xd0
> [ 1068.972738]  </IRQ>
> [ 1068.973324]  <TASK>
> [ 1068.974019]  asm_common_interrupt+0x22/0x40
> [ 1068.974412] RIP: 0010:cpuidle_enter_state+0xc8/0x430
> [ 1068.974787] Code: 0e c0 47 ff e8 99 f0 ff ff 8b 53 04 49 89 c5 0f
> 1f 44 00 00 31 ff e8 87 99 46 ff 45 84 ff 0f 85 3f 02 00 00 fb 0f 1f
> 44 00 00 <45> 85 f6 0f 88 6e 01 00 00 49 63 d6 4c 2b 2c 24 48 8d 04 52
> 48 8d
> [ 1068.976473] RSP: 0018:ffffffff9ca03e48 EFLAGS: 00000246
> [ 1068.976872] RAX: ffff988ebfc00000 RBX: ffff988ebfc3da78 RCX: 000000000=
000001f
> [ 1068.977869] RDX: 0000000000000000 RSI: ffffffff9c30e0ff RDI: ffffffff9=
c2e82f0
> [ 1068.978824] RBP: 0000000000000004 R08: 000000f8e18f1bef R09: 000000000=
0000018
> [ 1068.979802] R10: 0000000000009441 R11: ffff988ebfc317e4 R12: ffffffff9=
ceaf6c0
> [ 1068.980841] R13: 000000f8e18f1bef R14: 0000000000000004 R15: 000000000=
0000000
> [ 1068.981801]  ? cpuidle_enter_state+0xb9/0x430
> [ 1068.982669]  cpuidle_enter+0x29/0x40
> [ 1068.983003]  cpuidle_idle_call+0x10a/0x170
> [ 1068.983349]  do_idle+0x7e/0xe0
> [ 1068.984015]  cpu_startup_entry+0x26/0x30
> [ 1068.984333]  rest_init+0xcd/0xd0
> [ 1068.985008]  arch_call_rest_init+0xa/0x30
> [ 1068.985326]  start_kernel+0x332/0x410
> [ 1068.985628]  x86_64_start_reservations+0x14/0x30
> [ 1068.986337]  x86_64_start_kernel+0x8e/0x90
> [ 1068.986653]  secondary_startup_64_no_verify+0x18f/0x19b
> [ 1068.987068]  </TASK>
> [ 1068.987305] ---[ end trace 0000000000000000 ]---

