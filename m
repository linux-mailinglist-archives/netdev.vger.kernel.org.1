Return-Path: <netdev+bounces-80199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D60CD87D798
	for <lists+netdev@lfdr.de>; Sat, 16 Mar 2024 01:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37E3FB210E3
	for <lists+netdev@lfdr.de>; Sat, 16 Mar 2024 00:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7B9EC7;
	Sat, 16 Mar 2024 00:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnoqMG2R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC44803
	for <netdev@vger.kernel.org>; Sat, 16 Mar 2024 00:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710549575; cv=none; b=FaShFNvEh9fBCjSx0sbZ1651AyDgqG2mEWYo2Lwscfs9UyvIZGQNJNjDjjvvDKkKCORoh9zb70/h9+8MIW+Zdomq1k/qNCzgyExSreBslsRfPFE/SWs7dpo+vzwU01tagN1iK2wn4xO8recjA9HTFc+lhTuWyLDldZcFcZ0VfTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710549575; c=relaxed/simple;
	bh=TEsyW4OK58/jClvCOMN7uaBqMCT7su8kEnzXGZxMEjo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=jnTk5x0rMvetYYZB0BseJB12OUC+zzKzGEZF9a/GaOf85MErmV4pN8hcy2PzRSKPRIe0CP8yB6mQMpwZ0w4h5ifOJ6xayL+Uh1+raJngKpd9k30pPk8MMP7fzTF6x0tPZ76+huU8oMeAXgGylzmqFmY08xWQXtAh9Ennzpd7dUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnoqMG2R; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4d43df40579so266305e0c.0
        for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 17:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710549573; x=1711154373; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rTW4EOX1QbkTl10qRhD/kewcXCfMaoNon5Pu7KoEwww=;
        b=GnoqMG2R0+kKtMdXgdCUEbChEwzyU8aHrmrvn+YW1iQNnxrpMMQSgztpz2eEp0qImN
         wYDNB0IAcO2HTh7SbXpljB50GViQrp6VsQ7muOeyQz57ujFidfG8TFURI+PeobK9SZOK
         NNfsOd5sA/DaZN0pP1fqvzo8kOjHruCG4QluZHR9GTAEsMyrvKd+1EotrhfhgneFNyHM
         b76T4XZ86Wa/q6AyFS+DyOs9jykSZgFV9+IY26FHOTbaeo4ZGCMyjb/ZwVmZIb8FdNYA
         Ix4IgxrATSqUmAqH0RHbe59UZSlfUFEj5mIrQQh5a02rhV4M/lJ1SfVZJNCAtwiudJuX
         dmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710549573; x=1711154373;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rTW4EOX1QbkTl10qRhD/kewcXCfMaoNon5Pu7KoEwww=;
        b=T2HRn0fGfsMaT1jQqSJcArLG/493NNogx/+0I6EGkpTjoErZ2fbpe37ZIQ7vIX5Akt
         l/+mLT0rbZ+dzlz8gDLDhiBNHVRij9LaKknHKGFFQF2Zxxky1hXUabManOYmpyFRzO1C
         9y+fyXwW3/wodcBR3DmMN1ZGtT3RsRhIfV3tRmxi6nDYJacDJ9fbAWqZHrMyXJ1ZX2s3
         SVWz2VAcow5lAQy156GZk/uMftTsuzfQBd+DqajSdQ3BNojm6fFXe9iRdY2WmiYTAQpV
         hsX+Cx7SV/gIcddXPwtwUSrkomgmTaP1HlkXuOgUvX4DuOq1xTwva4irQp9Zex173+e+
         1tBw==
X-Gm-Message-State: AOJu0Yy+Jfti0k5KvOSJla2U4VnCmMZsb5aGux68nQp44V4FD4b8z4Yj
	NHwJ0cDuNPQT7qnbUsv4oMyNraix3cotlbB53bKuQqJyxuVTGckjrBEAhyJIf6rtz1hJXNfZpq/
	LnjP2YTGnFFSvSWD9Ti+Vak5I55PWXAd26Q8=
X-Google-Smtp-Source: AGHT+IHfFGJ9pfDVPtNJrJO1wBSbwepNzdacKyLJVCNYSNhUlnGrliNNeIp6yg36gvwoLXRvt7WYHnj9ZoE2gQp/vvY=
X-Received: by 2002:a05:6122:3626:b0:4d4:3621:b245 with SMTP id
 du6-20020a056122362600b004d43621b245mr3439571vkb.16.1710549572831; Fri, 15
 Mar 2024 17:39:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Daniele Salvatore Albano <d.albano@gmail.com>
Date: Sat, 16 Mar 2024 01:39:07 +0100
Message-ID: <CAKq9yRgO3akVUoz=H_vKgMjoDowq=owq5snPhmKLi4c=taLTnA@mail.gmail.com>
Subject: [mlx5_core] kernel NULL pointer dereference when sending packets with
 AF_XDP using the hw checksum
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hey there,

Hope this is the right ml, if not sorry in advance.

I have been facing a reproducible kernel panic with 6.8.0 and 6.8.1
when sending packets and enabling the HW checksum calculation with
AF_XDP on my mellanox connect 5.

Running xskgen ( https://github.com/fomichev/xskgen ), which I saw
mentioned in some patches related to AF_XDP and the hw checksum
support. In addition to the minimum parameters to make it work, adding
the -m option is enough to trigger the kernel panic.

This is a mainline kernel from ubuntu.

Below the output from dmesg
[  157.108211] BUG: kernel NULL pointer dereference, address: 0000000000000000
[  157.108264] #PF: supervisor write access in kernel mode
[  157.108284] #PF: error_code(0x0002) - not-present page
[  157.108304] PGD 302a724067 P4D 302a724067 PUD 3027e99067 PMD 0
[  157.108332] Oops: 0002 [#1] PREEMPT SMP NOPTI
[  157.108352] CPU: 19 PID: 132 Comm: ksoftirqd/19 Not tainted
6.8.0-060800-generic #202403131158
[  157.108379] Hardware name: Supermicro Super Server/H11SSL-i, BIOS
2.1 02/21/2020
[  157.108402] RIP: 0010:mlx5e_free_xdpsq_desc+0x266/0x320 [mlx5_core]
[  157.108576] Code: 94 24 58 02 00 00 49 8b 8c 24 50 02 00 00 48 8d
7d c0 8b 02 8d 70 01 89 32 41 23 84 24 68 02 00 00 4c 8b 2c c1 e8 ca
fc ff ff <49> 89 45 00 e9 ce fe ff ff 41 8b 47 20 41 0f b7 57 0a 48 2d
68 01
[  157.108626] RSP: 0018:ffffa8668cd13b90 EFLAGS: 00010246
[  157.108647] RAX: 17bd161cd26e8f20 RBX: 0000000000000000 RCX: 0000000000000000
[  157.108670] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[  157.108693] RBP: ffffa8668cd13c08 R08: 0000000000000000 R09: 0000000000000000
[  157.108715] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8d5e420d3340
[  157.108737] R13: 0000000000000000 R14: ffffffffffffffff R15: 0000000000000000
[  157.108759] FS:  0000000000000000(0000) GS:ffff8d6ddf780000(0000)
knlGS:0000000000000000
[  157.108784] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  157.108804] CR2: 0000000000000000 CR3: 0000003028e5c000 CR4: 00000000003506f0
[  157.108827] Call Trace:
[  157.108841]  <TASK>
[  157.108855]  ? show_regs+0x6d/0x80
[  157.108876]  ? __die+0x24/0x80
[  157.108893]  ? page_fault_oops+0x99/0x1b0
[  157.108916]  ? do_user_addr_fault+0x2ee/0x6b0
[  157.108937]  ? exc_page_fault+0x83/0x1b0
[  157.108958]  ? asm_exc_page_fault+0x27/0x30
[  157.108986]  ? mlx5e_free_xdpsq_desc+0x266/0x320 [mlx5_core]
[  157.109154]  mlx5e_poll_xdpsq_cq+0x17c/0x4f0 [mlx5_core]
[  157.109324]  mlx5e_napi_poll+0x45e/0x7b0 [mlx5_core]
[  157.109470]  __napi_poll+0x33/0x200
[  157.109488]  net_rx_action+0x181/0x2e0
[  157.109502]  ? sched_clock_cpu+0x12/0x1e0
[  157.109524]  __do_softirq+0xe1/0x363
[  157.109544]  ? __pfx_smpboot_thread_fn+0x10/0x10
[  157.109565]  run_ksoftirqd+0x37/0x60
[  157.109582]  smpboot_thread_fn+0xe3/0x1e0
[  157.109600]  kthread+0xf2/0x120
[  157.109616]  ? __pfx_kthread+0x10/0x10
[  157.109632]  ret_from_fork+0x47/0x70
[  157.109648]  ? __pfx_kthread+0x10/0x10
[  157.109663]  ret_from_fork_asm+0x1b/0x30
[  157.109686]  </TASK>
[  157.109696] Modules linked in: xt_CHECKSUM xt_MASQUERADE
xt_conntrack xt_comment ipt_REJECT nf_reject_ipv4 xt_tcpudp nft_compat
nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
nf_tables nfnetlink cfg80211 binfmt_misc nls_iso8859_1 intel_rapl_msr
intel_rapl_common amd64_edac edac_mce_amd kvm_amd ipmi_ssif kvm
irqbypass rapl acpi_ipmi ccp k10temp ipmi_si ipmi_devintf joydev
input_leds ipmi_msghandler mac_hid br_netfilter dm_multipath bridge
scsi_dh_rdac scsi_dh_emc stp llc scsi_dh_alua overlay msr efi_pstore
dmi_sysfs ip_tables x_tables autofs4 btrfs blake2b_generic raid10
raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor
raid6_pq libcrc32c raid1 raid0 mlx5_ib ib_uverbs macsec ib_core
hid_generic usbhid hid mlx5_core crct10dif_pclmul crc32_pclmul
polyval_clmulni polyval_generic ghash_clmulni_intel mlxfw sha256_ssse3
psample nvme sha1_ssse3 igb tls ahci nvme_core ast pci_hyperv_intf
libahci dca i2c_piix4 xhci_pci nvme_auth i2c_algo_bit xhci_pci_renesas
aesni_intel crypto_simd cryptd
[  157.113195] CR2: 0000000000000000
[  157.113607] ---[ end trace 0000000000000000 ]---
[  157.877621] clocksource: Long readout interval, skipping watchdog
check: cs_nsec: 1263523800 wd_nsec: 1263521131


Thanks,
Daniele

