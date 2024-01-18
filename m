Return-Path: <netdev+bounces-64207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54123831C07
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 16:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03232280EA1
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 15:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03D51E4AF;
	Thu, 18 Jan 2024 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVprdMgL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432D925764
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 15:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705590546; cv=none; b=qiuBal3f+PyKI0Xb7WMLjP+CVF1uzGN0/0fVRptTooj/6f7vl8BIKMG1Lz/80SY1ksXV/0P04XoiNOB3CPu+mo2pqTfNM9fPLqr0mAYGWKlj28K/dIG5/FgIfA51TRI2mGs4mpXaY312PqNFkd94lt3Hz0F1Hc14LFlOwdsxGjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705590546; c=relaxed/simple;
	bh=jM+sU7CMmEaazsxrPfyhuwqkP6Chv5ZW4K6DWkue8AM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 From:Date:Message-ID:Subject:To:Cc:Content-Type; b=pdFfUCAz9Xo5cXPb0GDvJtiUfYEs0XaxCjrZxDcXCu2+dnbpjeXJjhYdRs9tKcSuwq5GTecUIJ0ggbUimG872ZIylbUZSHJPfdwoeKeb+cc/UDttwzRJsXDqrN40Kj7dfxPWFA7zf947xuv964NJzORw1qDr1qxeQ5bP5otcTg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVprdMgL; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7cd5ab5d5bbso4214823241.3
        for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 07:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705590544; x=1706195344; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qxq1wC5qkMYikGAP5fW0wlbwReN/ffTHtDwd6SUWekE=;
        b=IVprdMgLbrMXi1aaygJwJeV7scHdBH1kZGbLrKo8xUGbdVBXH334Kf3WC1y2fovqGM
         /PFzkAR+ywHYww2Wbrs8UiDm5uK6v3b+trrQx6sDpA6RLGQl+18nz1a1Zzt7siwJSswv
         lz+lb2MV1ToA71EKY4XDsMD62EDFyuat0Kn8wjY31PrUHTSRm9I9YL30lr7MxfLOvrR5
         6exX1woOjfCoLRgeVv4txijeD/aIXPrud+yuAKSI1pWTv+k6ksAlgzyPkmW6hiM6idlj
         SS52QSK27faoI7yaCAFlRSTlG6j4rQM4kxPh2nGAiwym/7syKdcsV9qn81czi5CTdOnN
         UWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705590544; x=1706195344;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qxq1wC5qkMYikGAP5fW0wlbwReN/ffTHtDwd6SUWekE=;
        b=SYGLcjd+CPHK/xGLLKr4ld4UqezH9EJi4KPWsd9OcxP4xHlu2jKJrmccRNcM31dvIL
         PPJWph8z4ii2IhAvbmiFdvxlt9aTVQ75wmPHjRsC6Rd48MBeT17GpzqCVp8Xy2Y1xTuk
         UV/cuCXHOsx87gMGxd2pBFqHxrA38uRmVE7hp5MnYQgu+tTqSa4uXB2UKvx/WGJ6a1Tm
         jy00K1vy9lzPqhlxFRVAxj/tpgZbz/Fxc5B66stoOGjDZgpSF4sF0LY/YhNC26UuUj8p
         +ELs7RVQy3uUr9Z/oSnfMkNF3yOIjA2Kcv3FazJJ9PeQ9+sOPp0WHV8y5tSFCs1B6LBF
         uZKQ==
X-Gm-Message-State: AOJu0YyctW0SVREz0ZEraACtZVhrJNmg3fdCWcECkbvw5jE8zX+Y9o8k
	UtCmbx5cRRokAPpmqUNQSWtHMN+LWUc9RcoIwCtF+nX0NamuIFha/dKEJn/OtLD6aIJFh4vVVJ8
	ggazrX41CUxBh6MvfP1O+LBZwyFrD3HzBYYU=
X-Google-Smtp-Source: AGHT+IEIFuuGhdu048xDK/6vj7iYStPyHgeqd1XzJ3UXNnO3JqxsNVlhEUvekcdo7VJJ37dhyB2aLNqL3BwbATccuXM=
X-Received: by 2002:a1f:4cc2:0:b0:4b7:2fbf:c36b with SMTP id
 z185-20020a1f4cc2000000b004b72fbfc36bmr585653vka.24.1705590543584; Thu, 18
 Jan 2024 07:09:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ian Kumlien <ian.kumlien@gmail.com>
Date: Thu, 18 Jan 2024 16:08:52 +0100
Message-ID: <CAA85sZvvHtrpTQRqdaOx6gd55zPAVsqMYk_Lwh4Md5knTq7AyA@mail.gmail.com>
Subject: [mlx5e] FYI dmesg is filled with mlx5e_page_release_fragmented.isra
 warnings in 6.6.12
To: Linux Kernel Network Developers <netdev@vger.kernel.org>
Cc: saeedm@nvidia.com
Content-Type: text/plain; charset="UTF-8"

[ 1068.937101] ------------[ cut here ]------------
[ 1068.937977] WARNING: CPU: 0 PID: 0 at
include/net/page_pool/helpers.h:130
mlx5e_page_release_fragmented.isra.0+0x46/0x50 [mlx5_core]
[ 1068.939407] Modules linked in: echainiv(E) esp4(E)
xfrm_interface(E) xfrm6_tunnel(E) tunnel4(E) tunnel6(E) xt_policy(E)
xt_physdev(E) xt_nat(E) xt_REDIRECT(E) xt_comment(E) xt_connmark(E)
xt_mark(E) vxlan(E) ip6_udp_tunnel(E) udp_tunnel(E)
nfnetlink_cttimeout(E) xt_conntrack(E) nft_chain_nat(E)
xt_MASQUERADE(E) nf_conntrack_netlink(E) xt_addrtype(E) nft_compat(E)
nf_tables(E) nfnetlink(E) br_netfilter(E) bridge(E) 8021q(E) garp(E)
mrp(E) stp(E) llc(E) overlay(E) bonding(E) cfg80211(E) rfkill(E)
ipmi_ssif(E) intel_rapl_msr(E) intel_rapl_common(E) sb_edac(E)
x86_pkg_temp_thermal(E) intel_powerclamp(E) vfat(E) fat(E) coretemp(E)
kvm_intel(E) kvm(E) iTCO_wdt(E) mlx5_ib(E) intel_pmc_bxt(E)
iTCO_vendor_support(E) acpi_ipmi(E) i2c_algo_bit(E) ipmi_si(E)
irqbypass(E) ib_uverbs(E) drm_shmem_helper(E) ipmi_devintf(E)
ioatdma(E) rapl(E) i2c_i801(E) intel_cstate(E) ib_core(E)
intel_uncore(E) pcspkr(E) drm_kms_helper(E) joydev(E) lpc_ich(E)
hpilo(E) acpi_tad(E) ipmi_msghandler(E) acpi_power_meter(E) dca(E)
i2c_smbus(E) xfs(E)
[ 1068.939782]  drm(E) openvswitch(E) nf_conncount(E) nf_nat(E)
ext4(E) mbcache(E) jbd2(E) mlx5_core(E) sd_mod(E) t10_pi(E) sg(E)
crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E)
polyval_generic(E) serio_raw(E) ghash_clmulni_intel(E) mlxfw(E) tg3(E)
hpsa(E) tls(E) hpwdt(E) scsi_transport_sas(E) psample(E) wmi(E)
pci_hyperv_intf(E) dm_mirror(E) dm_region_hash(E) dm_log(E) dm_mod(E)
nf_conntrack(E) libcrc32c(E) crc32c_intel(E) nf_defrag_ipv6(E)
nf_defrag_ipv4(E) ip6_tables(E) fuse(E)
[ 1068.947864] CPU: 0 PID: 0 Comm: swapper/0 Kdump: loaded Tainted: G
      W   E      6.6.12-1.el9.elrepo.x86_64 #1
[ 1068.949014] Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360
Gen9, BIOS P89 11/23/2021
[ 1068.949552] RIP:
0010:mlx5e_page_release_fragmented.isra.0+0x46/0x50 [mlx5_core]
[ 1068.951033] Code: f7 da f0 48 0f c1 56 28 48 39 c2 78 1d 74 05 c3
cc cc cc cc 48 8b bf 60 04 00 00 b9 01 00 00 00 ba ff ff ff ff e9 da
f7 f3 da <0f> 0b c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90
90 90
[ 1068.952632] RSP: 0018:ffffb3a800003df0 EFLAGS: 00010297
[ 1068.953301] RAX: 000000000000003d RBX: ffff987f51b78000 RCX: 0000000000000050
[ 1068.954279] RDX: 0000000000000000 RSI: ffffdb5246508580 RDI: ffff987f51b78000
[ 1068.955358] RBP: ffff987fcdb0b540 R08: 0000000000000006 R09: ffff988ec44830c0
[ 1068.957674] R10: 0000000000000000 R11: ffff987fcab77040 R12: 0000000000000040
[ 1068.958669] R13: 0000000000000040 R14: ffff987fcdb0b168 R15: 000000000000003c
[ 1068.959828] FS:  0000000000000000(0000) GS:ffff988ebfc00000(0000)
knlGS:0000000000000000
[ 1068.960466] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1068.961350] CR2: 00007f173925a4e0 CR3: 0000001067a1e006 CR4: 00000000001706f0
[ 1068.962230] Call Trace:
[ 1068.962478]  <IRQ>
[ 1068.963055]  ? __warn+0x80/0x130
[ 1068.963073]  ? mlx5e_page_release_fragmented.isra.0+0x46/0x50 [mlx5_core]
[ 1068.964275]  ? report_bug+0x1c3/0x1d0
[ 1068.964585]  ? handle_bug+0x42/0x70
[ 1068.965228]  ? exc_invalid_op+0x14/0x70
[ 1068.965538]  ? asm_exc_invalid_op+0x16/0x20
[ 1068.965854]  ? mlx5e_page_release_fragmented.isra.0+0x46/0x50 [mlx5_core]
[ 1068.966518]  mlx5e_free_rx_mpwqe+0x18e/0x1c0 [mlx5_core]
[ 1068.967221]  mlx5e_post_rx_mpwqes+0x1a5/0x280 [mlx5_core]
[ 1068.967810]  mlx5e_napi_poll+0x143/0x710 [mlx5_core]
[ 1068.968416]  ? __netif_receive_skb_one_core+0x92/0xa0
[ 1068.968799]  __napi_poll+0x2c/0x1b0
[ 1068.970066]  net_rx_action+0x2a7/0x370
[ 1068.971012]  ? mlx5_cq_tasklet_cb+0x78/0x180 [mlx5_core]
[ 1068.971683]  __do_softirq+0xf0/0x2ee
[ 1068.972002]  __irq_exit_rcu+0x83/0xf0
[ 1068.972338]  common_interrupt+0xb8/0xd0
[ 1068.972738]  </IRQ>
[ 1068.973324]  <TASK>
[ 1068.974019]  asm_common_interrupt+0x22/0x40
[ 1068.974412] RIP: 0010:cpuidle_enter_state+0xc8/0x430
[ 1068.974787] Code: 0e c0 47 ff e8 99 f0 ff ff 8b 53 04 49 89 c5 0f
1f 44 00 00 31 ff e8 87 99 46 ff 45 84 ff 0f 85 3f 02 00 00 fb 0f 1f
44 00 00 <45> 85 f6 0f 88 6e 01 00 00 49 63 d6 4c 2b 2c 24 48 8d 04 52
48 8d
[ 1068.976473] RSP: 0018:ffffffff9ca03e48 EFLAGS: 00000246
[ 1068.976872] RAX: ffff988ebfc00000 RBX: ffff988ebfc3da78 RCX: 000000000000001f
[ 1068.977869] RDX: 0000000000000000 RSI: ffffffff9c30e0ff RDI: ffffffff9c2e82f0
[ 1068.978824] RBP: 0000000000000004 R08: 000000f8e18f1bef R09: 0000000000000018
[ 1068.979802] R10: 0000000000009441 R11: ffff988ebfc317e4 R12: ffffffff9ceaf6c0
[ 1068.980841] R13: 000000f8e18f1bef R14: 0000000000000004 R15: 0000000000000000
[ 1068.981801]  ? cpuidle_enter_state+0xb9/0x430
[ 1068.982669]  cpuidle_enter+0x29/0x40
[ 1068.983003]  cpuidle_idle_call+0x10a/0x170
[ 1068.983349]  do_idle+0x7e/0xe0
[ 1068.984015]  cpu_startup_entry+0x26/0x30
[ 1068.984333]  rest_init+0xcd/0xd0
[ 1068.985008]  arch_call_rest_init+0xa/0x30
[ 1068.985326]  start_kernel+0x332/0x410
[ 1068.985628]  x86_64_start_reservations+0x14/0x30
[ 1068.986337]  x86_64_start_kernel+0x8e/0x90
[ 1068.986653]  secondary_startup_64_no_verify+0x18f/0x19b
[ 1068.987068]  </TASK>
[ 1068.987305] ---[ end trace 0000000000000000 ]---

