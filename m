Return-Path: <netdev+bounces-125859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3FE96F03C
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 11:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 555962838F7
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 09:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215CC1C8715;
	Fri,  6 Sep 2024 09:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M36rJfB1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192BE188A31
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 09:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725616344; cv=none; b=OvA5j2WQNlk/YN7NnBqxQjDWtty/lJVATb8fs2Uo3CmgEelRlkgpwkc7RUTIiA7atYe1HvMT/5pcoa7Iy9LQ8M4+75MFhpxft+i55gaB092vLFTjoG95XSi8nDRFChb/Z8t0LPRLkR81jh8nzHYB8OAsoZd0W1SV+7lGi7paOTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725616344; c=relaxed/simple;
	bh=+WdmdLJ++ntQszSER6H97BLGPbEr4RkygG4KQMAXQ1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Aiarg7Y6NYbHoatz+YFzUacmkKkNuJSFDlSu4tMXV1cdwQjRCxp4sC8+5nWEk4mlNirLnQ+HjSyhjSJYqHBECrV+LKC/aWEW8PSvEaIQC2aHTJIJT5U1C1nagJLtkloUGH+T38efLxiW32WHgDqryk7eoiyQpetSS8I0wYilvr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M36rJfB1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725616340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RAhjvdU69DweMTukvqKoSI0bouOhm5I8VZurmeZkx/4=;
	b=M36rJfB1DvwOfpVjAJXtEUOgbwNsiq1WuMcjPyZAQ/GJYQJqmYz6pDg2ODBT6ohzSGGEqt
	wt8f7JNvLGIAvyGkUMSdEx9tAUANCN4IbIRQFvlD55Z8x5LwZDOepgos2swzVvHJYnzskf
	lyKAfK93SK+l9Oink6ZvrJk38O0f7AM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-WdE5yAxxMD2gqXYWVd7GUA-1; Fri, 06 Sep 2024 05:52:18 -0400
X-MC-Unique: WdE5yAxxMD2gqXYWVd7GUA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42bbadffbbdso14921735e9.0
        for <netdev@vger.kernel.org>; Fri, 06 Sep 2024 02:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725616337; x=1726221137;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAhjvdU69DweMTukvqKoSI0bouOhm5I8VZurmeZkx/4=;
        b=R0MInX8lFUUN2OCrhOYW5khebVjbg3rFIK/sPyp+pQ6VXHsBZTV2B7Bodx6RGF2VNc
         RZfb+88REzxIHtZPsUp/Jm8hZ+5Xf9d2L6Qsq7KVCMGg6qiSXb+ND+KnF2uObrl/6+2R
         +uM8lKuroPJc9YvoMmrGRsAkzEq9TQ4AVlJwIBdvYhsC0NPey1fB56x3jA8QSV4g/lxD
         Y4gw2NefjxIq9KiTRtG9qVnWAK5U3pxGYtqUB5L0kalx2Vv2PgNcTAZBzZdUZr/HLRIs
         cbWZHsEWMoQh8kfe7oYbSgNon7i9MueuwoKD+3A6c7VIiLhkhR27s95zlR2xfl9+Vsg0
         CnAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXt3tt1QEa/J4QjznvYP2XElqCBmq++9o5tFzh9sakDTpis6gJbM/lajpiH6bkPE6deAPEbNlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZdXa1bq3BYlnIOBy94PH7gVf/W09MNONocwwZnX1S1v1AaMcS
	RuCO1hOcL7jJnJ97rTcEit1Fn+JEpb+SeTO6ouX9h+lVyRPCKFQDcoS0jHx+5v6jxGaHorLtk5E
	gx79+yg0mQHmKneXZcJ7122zRliYnrP7o/jgsbywnowfU+MUl49+uig==
X-Received: by 2002:a7b:cbd7:0:b0:42c:a036:576b with SMTP id 5b1f17b1804b1-42ca036586amr11549495e9.10.1725616336864;
        Fri, 06 Sep 2024 02:52:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPfNW5ZNIYZ6ySGbDxAjGN5cljZH32PkDUkAXC+kNVw9arDO3UpGRYu+jTSJTgwTIdviRLJw==
X-Received: by 2002:a7b:cbd7:0:b0:42c:a036:576b with SMTP id 5b1f17b1804b1-42ca036586amr11549105e9.10.1725616336099;
        Fri, 06 Sep 2024 02:52:16 -0700 (PDT)
Received: from redhat.com ([155.133.17.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374cd905b7csm11808511f8f.74.2024.09.06.02.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 02:52:15 -0700 (PDT)
Date: Fri, 6 Sep 2024 05:52:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, Si-Wei Liu <si-wei.liu@oracle.com>,
	Darren Kenny <darren.kenny@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [RFC PATCH v2 0/7] Revert "virtio_net: rx enable premapped mode by
 default"
Message-ID: <cover.1725616135.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

Note: Xuan Zhuo, if you figure out all the issues, pls post an alternative
patch.

Note2: untested, Darren, pls test and confirm.

Turns out unconditionally enabling premapped 
virtio-net leads to a regression on VM with no ACCESS_PLATFORM, and with
sysctl net.core.high_order_alloc_disable=1

where crashes and scp failures were reported (scp a file 100M in size to VM):

[  332.079333] __vm_enough_memory: pid: 18440, comm: sshd, bytes: 5285790347661783040 not enough memory for the allocation
[  332.079651] ------------[ cut here ]------------
[  332.079655] kernel BUG at mm/mmap.c:3514!
[  332.080095] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[  332.080826] CPU: 18 PID: 18440 Comm: sshd Kdump: loaded Not tainted 6.10.0-2.x86_64 #2
[  332.081514] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-4.module+el8.9.0+90173+a3f3e83a 04/01/2014
[  332.082451] RIP: 0010:exit_mmap+0x3a1/0x3b0
[  332.082871] Code: be 01 00 00 00 48 89 df e8 0c 94 fe ff eb d7 be 01 00 00 00 48 89 df e8 5d 98 fe ff eb be 31 f6 48 89 df e8 31 99 fe ff eb a8 <0f> 0b e8 68 bc ae 00 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
[  332.084230] RSP: 0018:ffff9988b1c8f948 EFLAGS: 00010293
[  332.084635] RAX: 0000000000000406 RBX: ffff8d47583e7380 RCX: 0000000000000000
[  332.085171] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[  332.085699] RBP: 000000000000008f R08: 0000000000000000 R09: 0000000000000000
[  332.086233] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8d47583e7430
[  332.086761] R13: ffff8d47583e73c0 R14: 0000000000000406 R15: 000495ae650dda58
[  332.087300] FS:  00007ff443899980(0000) GS:ffff8df1c5700000(0000) knlGS:0000000000000000
[  332.087888] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  332.088334] CR2: 000055a42d30b730 CR3: 00000102e956a004 CR4: 0000000000770ef0
[  332.088867] PKRU: 55555554
[  332.089114] Call Trace:
[  332.089349] <TASK>
[  332.089556]  ? die+0x36/0x90
[  332.089818]  ? do_trap+0xed/0x110
[  332.090110]  ? exit_mmap+0x3a1/0x3b0
[  332.090411]  ? do_error_trap+0x6a/0xa0
[  332.090722]  ? exit_mmap+0x3a1/0x3b0
[  332.091029]  ? exc_invalid_op+0x50/0x80
[  332.091348]  ? exit_mmap+0x3a1/0x3b0
[  332.091648]  ? asm_exc_invalid_op+0x1a/0x20
[  332.091998]  ? exit_mmap+0x3a1/0x3b0
[  332.092299]  ? exit_mmap+0x1d6/0x3b0
[  332.092604] __mmput+0x3e/0x130
[  332.092882] dup_mm.constprop.0+0x10c/0x110
[  332.093226] copy_process+0xbd0/0x1570
[  332.093539] kernel_clone+0xbf/0x430
[  332.093838]  ? syscall_exit_work+0x103/0x130
[  332.094197] __do_sys_clone+0x66/0xa0
[  332.094506]  do_syscall_64+0x8c/0x1d0
[  332.094814]  ? srso_alias_return_thunk+0x5/0xfbef5
[  332.095198]  ? audit_reset_context+0x232/0x310
[  332.095558]  ? srso_alias_return_thunk+0x5/0xfbef5
[  332.095936]  ? syscall_exit_work+0x103/0x130
[  332.096288]  ? srso_alias_return_thunk+0x5/0xfbef5
[  332.096668]  ? syscall_exit_to_user_mode+0x7d/0x220
[  332.097059]  ? srso_alias_return_thunk+0x5/0xfbef5
[  332.097436]  ? do_syscall_64+0xba/0x1d0
[  332.097752]  ? srso_alias_return_thunk+0x5/0xfbef5
[  332.098137]  ? syscall_exit_to_user_mode+0x7d/0x220
[  332.098525]  ? srso_alias_return_thunk+0x5/0xfbef5
[  332.098903]  ? do_syscall_64+0xba/0x1d0
[  332.099227]  ? srso_alias_return_thunk+0x5/0xfbef5
[  332.099606]  ? __audit_filter_op+0xbe/0x140
[  332.099943]  ? srso_alias_return_thunk+0x5/0xfbef5
[  332.100328]  ? srso_alias_return_thunk+0x5/0xfbef5
[  332.100706]  ? srso_alias_return_thunk+0x5/0xfbef5
[  332.101089]  ? srso_alias_return_thunk+0x5/0xfbef5
[  332.101468]  ? wp_page_reuse+0x8e/0xb0
[  332.101779]  ? srso_alias_return_thunk+0x5/0xfbef5
[  332.102163]  ? do_wp_page+0xe6/0x470
[  332.102465]  ? srso_alias_return_thunk+0x5/0xfbef5
[  332.102843]  ? __handle_mm_fault+0x5ff/0x720
[  332.103197]  ? srso_alias_return_thunk+0x5/0xfbef5
[  332.103574]  ? __count_memcg_events+0x4d/0xd0
[  332.103938]  ? srso_alias_return_thunk+0x5/0xfbef5
[  332.104323]  ? count_memcg_events.constprop.0+0x26/0x50
[  332.104729]  ? srso_alias_return_thunk+0x5/0xfbef5
[  332.105114]  ? handle_mm_fault+0xae/0x320
[  332.105442]  ? srso_alias_return_thunk+0x5/0xfbef5
[  332.105820]  ? do_user_addr_fault+0x31f/0x6c0
[  332.106181]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  332.106576] RIP: 0033:0x7ff43f8f9a73
[  332.106876] Code: db 0f 85 28 01 00 00 64 4c 8b 0c 25 10 00 00 00 45 31 c0 4d 8d 91 d0 02 00 00 31 d2 31 f6 bf 11 00 20 01 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 b9 00 00 00 41 89 c5 85 c0 0f 85 c6 00 00
[  332.108163] RSP: 002b:00007ffc690909b0 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
[  332.108719] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff43f8f9a73
[  332.109253] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
[  332.109782] RBP: 0000000000000000 R08: 0000000000000000 R09: 00007ff443899980
[  332.110313] R10: 00007ff443899c50 R11: 0000000000000246 R12: 0000000000000002
[  332.110842] R13: 0000562e56cd4780 R14: 0000000000000006 R15: 0000562e800346b0
[  332.111381]  </TASK>
[  332.111590] Modules linked in: rdmaip_notify scsi_transport_iscsi target_core_mod rfkill mstflint_access cuse rds_rdma rds rdma_ucm rdma_cm iw_cm dm_multipath ib_umad ib_ipoib ib_cm mlx5_ib iTCO_wdt iTCO_vendor_support intel_rapl_msr ib_uverbs intel_rapl_common ib_core crc32_pclmul i2c_i801 joydev virtio_balloon i2c_smbus lpc_ich binfmt_misc xfs sd_mod t10_pi crc64_rocksoft sg crct10dif_pclmul mlx5_core virtio_net ahci net_failover mlxfw ghash_clmulni_intel virtio_scsi failover libahci sha512_ssse3 tls sha256_ssse3 pci_hyperv_intf virtio_pci libata psample sha1_ssse3 virtio_pci_legacy_dev serio_raw dimlib virtio_pci_modern_dev qemu_fw_cfg dm_mirror dm_region_hash dm_log dm_mod fuse aesni_intel crypto_simd cryptd
[  332.115851] ---[ end trace 0000000000000000 ]---

and another instance splats:

BUG: Bad page map in process PsWatcher.sh  pte:9402e1e2b18c8ae9 pmd:10fe4f067
[  193.046098] addr:00007ff912a00000 vm_flags:08000070 anon_vma:0000000000000000 mapping:ffff8ec28047eeb0 index:200
[  193.046863] file:libtinfo.so.6.1 fault:xfs_filemap_fault [xfs] mmap:xfs_file_mmap [xfs] read_folio:xfs_vm_read_folio [xfs]
[  193.049564] get_swap_device: Bad swap file entry 3803ad7a32eab547
[  193.050902] BUG: Bad rss-counter state mm:00000000ff28307a type:MM_SWAPENTS val:-1
[  193.758147] Kernel panic - not syncing: corrupted stack end detected inside scheduler
[  193.759151] CPU: 5 PID: 22932 Comm: LogFlusher Tainted: G B              6.10.0-rc2+ #1
[  193.759764] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-4.module+el8.9.0+90173+a3f3e83a 04/01/2014
[  193.760435] Call Trace:
[  193.760624]  <TASK>
[  193.760799]  panic+0x31d/0x340
[  193.761033]  __schedule+0xb30/0xb30
[  193.761283]  ? srso_alias_return_thunk+0x5/0xfbef5
[  193.761605]  ? enqueue_hrtimer+0x35/0x90
[  193.761883]  ? srso_alias_return_thunk+0x5/0xfbef5
[  193.762207]  ? srso_alias_return_thunk+0x5/0xfbef5
[  193.762532]  ? hrtimer_start_range_ns+0x121/0x300
[  193.762856]  schedule+0x27/0xb0
[  193.763083]  futex_wait_queue+0x63/0x90
[  193.763354]  __futex_wait+0x13d/0x1b0
[  193.763610]  ? __pfx_futex_wake_mark+0x10/0x10
[  193.763918]  futex_wait+0x69/0xd0
[  193.764153]  ? pick_next_task+0x9fb/0xa30
[  193.764430]  ? __pfx_hrtimer_wakeup+0x10/0x10
[  193.764734]  do_futex+0x11a/0x1d0
[  193.764976]  __x64_sys_futex+0x68/0x1c0
[  193.765243]  do_syscall_64+0x80/0x160
[  193.765504]  ? srso_alias_return_thunk+0x5/0xfbef5
[  193.765834]  ? __audit_filter_op+0xaa/0xf0
[  193.766117]  ? srso_alias_return_thunk+0x5/0xfbef5
[  193.766437]  ? audit_reset_context.part.16+0x270/0x2d0
[  193.766895]  ? srso_alias_return_thunk+0x5/0xfbef5
[  193.767237]  ? syscall_exit_to_user_mode_prepare+0x17b/0x1a0
[  193.767624]  ? srso_alias_return_thunk+0x5/0xfbef5
[  193.767972]  ? syscall_exit_to_user_mode+0x80/0x1e0
[  193.768309]  ? srso_alias_return_thunk+0x5/0xfbef5
[  193.768628]  ? do_syscall_64+0x8c/0x160
[  193.768901]  ? srso_alias_return_thunk+0x5/0xfbef5
[  193.769225]  ? audit_reset_context.part.16+0x270/0x2d0
[  193.769573]  ? srso_alias_return_thunk+0x5/0xfbef5
[  193.769901]  ? restore_fpregs_from_fpstate+0x3c/0xa0
[  193.770241]  ? srso_alias_return_thunk+0x5/0xfbef5
[  193.770561]  ? switch_fpu_return+0x4f/0xd0
[  193.770848]  ? srso_alias_return_thunk+0x5/0xfbef5
[  193.771171]  ? syscall_exit_to_user_mode+0x80/0x1e0
[  193.771505]  ? srso_alias_return_thunk+0x5/0xfbef5
[  193.771830]  ? do_syscall_64+0x8c/0x160
[  193.772098]  ? srso_alias_return_thunk+0x5/0xfbef5
[  193.772426]  ? syscall_exit_to_user_mode_prepare+0x17b/0x1a0
[  193.772805]  ? srso_alias_return_thunk+0x5/0xfbef5
[  193.773124]  ? syscall_exit_to_user_mode+0x80/0x1e0
[  193.773458]  ? srso_alias_return_thunk+0x5/0xfbef5
[  193.773781]  ? do_syscall_64+0x8c/0x160
[  193.774047]  ? srso_alias_return_thunk+0x5/0xfbef5
[  193.774376]  ? task_mm_cid_work+0x1c1/0x210
[  193.774669]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  193.775010] RIP: 0033:0x7f4da640e898
[  193.775270] Code: 24 58 48 85 c0 0f 88 8f 00 00 00 e8 f2 2e 00 00 89 ee 4c 8b 54 24 38 31 d2 41 89 c0 40 80 f6 80 4c 89 ef b8 ca 00 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 ff 00 00 00 44 89 c7 e8 24 2f 00 00 48 8b
[  193.776404] RSP: 002b:00007f4d797f2750 EFLAGS: 00000282 ORIG_RAX: 00000000000000ca
[  193.776893] RAX: ffffffffffffffda RBX: 00007f4d402c1b50 RCX: 00007f4da640e898
[  193.777355] RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f4d402c1b7c
[  193.777813] RBP: 0000000000000000 R08: 0000000000000000 R09: 00007f4da6ece000
[  193.778276] R10: 00007f4d797f27a0 R11: 0000000000000282 R12: 00007f4d402c1b28
[  193.778732] R13: 00007f4d402c1b7c R14: 00007f4d797f2840 R15: 0000000000000002
[  193.779189]  </TASK>
[  193.780419] Kernel Offset: 0x13c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[  193.781097] Rebooting in 60 seconds..

Even in premapped mode with use_dma_api, in virtnet_rq_alloc(), 
skb_page_frag_refill() can return order-0 page if
high order page allocation is disabled. But in current code

       alloc_frag->offset += size;

gets accounted irrespective of the actual page size returned (dma->len). 
And virtnet_rq_unmap() seems to only work with high order pages.

Suggest reverting for now, unfortunately this implies reverting
the xsk enhancements. Try again next merge window.


Michael S. Tsirkin (7):
  Revert "virtio_net: xsk: rx: support recv merge mode"
  Revert "virtio_net: xsk: rx: support recv small mode"
  Revert "virtio_net: xsk: rx: support fill with xsk buffer"
  Revert "virtio_net: xsk: bind/unbind xsk for rx"
  Revert "virtio_net: rx remove premapped failover code"
  Revert "virtio_net: big mode skip the unmap check"
  Revert "virtio_ring: enable premapped mode whatever use_dma_api"

 drivers/net/virtio_net.c     | 633 ++++-------------------------------
 drivers/virtio/virtio_ring.c |   7 +-
 2 files changed, 80 insertions(+), 560 deletions(-)

-- 
MST


