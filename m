Return-Path: <netdev+bounces-168887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EFFA4149F
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 06:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83DFB168D2B
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 05:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC4A1A3153;
	Mon, 24 Feb 2025 05:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUMOKBNh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1467EEA8
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 05:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740374030; cv=none; b=awepKVwLIS2Z7GtmGmiQrb/SYWrl4bYGljdveAE33mvMgsgO8bx9AlV3DJtDdyftwkk7Y+4/EPu1HsTXUve78YCXbPwc6Jnhh8FFy3KF+KjcjBmGjhf0kS7EKYkKZ1r3Cgz2p3wwaL1Bb+vl7IEYwmiEP9Lo35Fhc9QfVV3nqu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740374030; c=relaxed/simple;
	bh=kd7KEwyQnN6bU6nkDXwq3SdQyw6+nY53Po1zTBfnxHM=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=bIvu9QjallCksFT1TRPMdv7YIMtKJ3CLwgw7aiiFrG9QOao8qZZUjgJwXvSFR8hiYHwhezEexOtxvGx8GQBokB1mHsBXI9NpuFnU7P6OaTRi88LiRFgiM5m6Wb2GBxcJtc6dCWWFDKTO4Ay7WJGjWAgTNi3V/8WM3s2+YhO5EzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YUMOKBNh; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-439a2780b44so23699475e9.1
        for <netdev@vger.kernel.org>; Sun, 23 Feb 2025 21:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740374027; x=1740978827; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jvFDx+SW2cZA0hghVHNrGT2g6jYmHmOGsv7UrkQCZD4=;
        b=YUMOKBNhlb5UpUmxNyc6CooAkLtZcrsl3ZJaTsaU9QViHHYZVIh0ifyew2RPC+w81G
         AsVxZYVQqWTf+S4FaZbveIvPSg7avh9g6IA/InL0ugtxXCjj6bWaTH1IdMxRMcnktL7k
         SmDMYa0GccXRmCj5Phn/2sqgmQOTIPotWYdGE5noGU/K8mK2BxiB2wliNS58wEoqDi11
         yRlFlLNnZ2YvMfE9O/yozaLvCujs9NBJbvkcTkFnnbnXOQ69FMScSa6ncVMl0nO5qygG
         nmxs8YBgWUkPXCaktxWZoE+lS3a3mdFkTQMXXCRTi+k7UspyGLTJ6P2p/i7e8DD+ptLB
         3wAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740374027; x=1740978827;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvFDx+SW2cZA0hghVHNrGT2g6jYmHmOGsv7UrkQCZD4=;
        b=mtnzjttTywOTQdalG7v8DBmEc0XKzGSi3xw1NuKRHm1zpRmLFf0DGKXMfHrjiQn16L
         q9g6QQbg4SwrqfemFESPzVpuMkdh7erH8IpNwj+mP8ruierpXRfNE/4eGKOUnBNXeMMg
         /U/vY21LXp65cXY3YBSGxX9v4dTmXcdloG8WWrlgMb2Dgu9M2N8lyl94Wcddo+ayD8t/
         yvP9BylmciEiqD5wBs6HSEvddJROu9Jy9E7WEk1J09bJC0vA3ayaZXXZdR6hx3zM04Sk
         /p+lxv2diP7sdQOP77v+1XweJSoWhoZpqK0V10Nptl+qti027snNAdaTHvztoisuviGZ
         KpGw==
X-Gm-Message-State: AOJu0YwtJB8tqjNa5LnpFvEH0ni9vUKMhL2+h84FA6EgRfzXuG5qZlqz
	PyqO2mZ8yVtwP8cZO6xwZoE1Mbu9//3KZ7140r0LvST3OhayBFgfwHxMHfuR
X-Gm-Gg: ASbGncuUSwUVtue1ry85xD3NKOqxaSizJn4uk8D3YR/uqAp0qrA8iXcJOwRTBUkbLR6
	Q+adki+VLnO0DZImjEGnnTrGgtp28CkEelwdtOhZ8nqWZB/xCuLKxGkLZt2QmNQAi6mdvU/1bmv
	qGMV4fu+Y2SMyhQDPi5m114s/fcJbzuQIlhEusspaeY+/JTnKaXfcSdwYZzXtOCZL6Ew3xJmn3U
	iwQBKt8wp/Z79ULySctHN64RFv7ipJrHu7BeiB3atiWoDTqlSwbSCJdtsB28HuIw2n1CJMX5oz3
	dpRt1Q73XEFxr1HvnTopCPVlahH7IInqpi2T2AgMaA==
X-Google-Smtp-Source: AGHT+IHevS3cTEfn033nafZzuEJzWQ9tvQfL9a/Y5aYT3oIRKb/C8Vfr1admzeJ6O2RcyYfXoz0q7g==
X-Received: by 2002:adf:e8cd:0:b0:38f:2b54:874e with SMTP id ffacd0b85a97d-38f6e95f67amr8271562f8f.16.1740374026430;
        Sun, 23 Feb 2025 21:13:46 -0800 (PST)
Received: from smtpclient.apple ([178.254.237.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b4491sm29994467f8f.7.2025.02.23.21.13.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Feb 2025 21:13:45 -0800 (PST)
From: Martin Zaharinov <micron10@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Bug Report in Virtio_net driver and skb_try_coalesce
Message-Id: <4115C55D-7699-41BF-8412-89C80A6C1A7B@gmail.com>
Date: Mon, 24 Feb 2025 07:13:33 +0200
Cc: edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 willemb@google.com,
 lulie@linux.alibaba.com,
 aleksander.lobakin@intel.com,
 dust.li@linux.alibaba.com,
 hustcat@gmail.com,
 jasowang@redhat.com,
 jdamato@fastly.com
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3826.400.131.1.6)

Hello all,

i have this issue fro kernel 6.12 and still is here with kernel 6.13.4

when run vm with virtio_net as ethernet card=20
start traffic like try to scp file to this vm and machine crash with =
second debug.=20
First is when system boot .

any help to fix this .

Best regards,
Martin

[   19.070538][    C7] ------------[ cut here ]------------
[   19.071165][    C7] WARNING: CPU: 7 PID: 0 at net/core/skbuff.c:6075 =
skb_try_coalesce+0x495/0x520
[   19.072094][    C7] Modules linked in: nf_conntrack_sip(-) =
nf_conntrack_ftp nf_conntrack_pptp nft_ct nft_nat nft_chain_nat nf_nat =
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables netconsole vmxnet3 =
virtio_net net_failover failover virtio_pci virtio_pci_legacy_dev =
virtio_pci_modern_dev virtio virtio_ring e1000 e1000e tap tun =
aesni_intel gf128mul crypto_simd cryptd
[   19.075316][    C7] CPU: 7 UID: 0 PID: 0 Comm: swapper/7 Tainted: G   =
        O       6.13.4 #2
[   19.076047][    C7] Tainted: [O]=3DOOT_MODULE
[   19.076456][    C7] Hardware name: QEMU Standard PC (Q35 + ICH9, =
2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   19.077608][    C7] RIP: 0010:skb_try_coalesce+0x495/0x520
[   19.078049][    C7] Code: 00 00 0f 85 ef fd ff ff 49 8b 11 80 e2 40 =
0f 84 e3 fd ff ff 49 8b 51 48 f6 c2 01 0f 84 d6 fd ff ff 4c 8d 4a ff e9 =
cd fd ff ff <0f> 0b e9 fc fd ff ff 0f 0b 31 c0 e9 cd fe ff ff 4c 8d 4e =
ff e9 b4
[   19.079500][    C7] RSP: 0018:ffff9aaf002a4c90 EFLAGS: 00010297
[   19.079969][    C7] RAX: ffff9aaf002a4d03 RBX: ffff917408a6b900 RCX: =
00000000000000c0
[   19.080582][    C7] RDX: 00000000fffffdc0 RSI: ffff9174059e3800 RDI: =
0000000000000598
[   19.081178][    C7] RBP: ffff917408a6b100 R08: 0000000000000001 R09: =
0000000000000000
[   19.081781][    C7] R10: 0000000000000000 R11: 00000000000000c0 R12: =
ffff9aaf002a4d04
[   19.082600][    C7] R13: 0000000000000598 R14: ffff9175059e35c0 R15: =
ffff9175059e2dc0
[   19.083465][    C7] FS:  0000000000000000(0000) =
GS:ffff917577dc0000(0000) knlGS:0000000000000000
[   19.084492][    C7] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   19.085203][    C7] CR2: 00007f56364bdd78 CR3: 0000000104866000 CR4: =
00000000003506f0
[   19.086077][    C7] Call Trace:
[   19.086436][    C7]  <IRQ>
[   19.086751][    C7]  ? show_trace_log_lvl+0x1a2/0x260
[   19.087312][    C7]  ? inet_frag_reasm_finish+0xef/0x380
[   19.087903][    C7]  ? skb_try_coalesce+0x495/0x520
[   19.088442][    C7]  ? __warn.cold+0x90/0x9e
[   19.088917][    C7]  ? skb_try_coalesce+0x495/0x520
[   19.089460][    C7]  ? report_bug+0xf2/0x1f0
[   19.089934][    C7]  ? handle_bug+0x4f/0x90
[   19.090397][    C7]  ? exc_invalid_op+0x17/0x160
[   19.090907][    C7]  ? asm_exc_invalid_op+0x16/0x20
[   19.091447][    C7]  ? skb_try_coalesce+0x495/0x520
[   19.091993][    C7]  inet_frag_reasm_finish+0xef/0x380
[   19.092560][    C7]  ip_frag_queue+0x507/0x670
[   19.093059][    C7]  ip_defrag+0x93/0x130
[   19.093493][    C7]  ip_local_deliver+0x38/0xc0
[   19.094013][    C7]  process_backlog+0xcb/0x1f0
[   19.094516][    C7]  __napi_poll+0x20/0x130
[   19.094992][    C7]  net_rx_action+0x306/0x3e0
[   19.095486][    C7]  ? enqueue_dl_entity+0x42f/0xa80
[   19.096047][    C7]  ? enqueue_task_fair+0x21a/0xb00
[   19.096595][    C7]  ? __napi_schedule+0x97/0xa0
[   19.097101][    C7]  handle_softirqs+0xde/0x1d0
[   19.097605][    C7]  irq_exit_rcu+0xac/0xd0
[   19.097964][    C7]  common_interrupt+0x79/0xa0
[   19.098414][    C7]  </IRQ>
[   19.098737][    C7]  <TASK>
[   19.099055][    C7]  asm_common_interrupt+0x22/0x40
[   19.099599][    C7] RIP: 0010:default_idle+0xb/0x10
[   19.100144][    C7] Code: 07 76 e7 48 89 07 49 c7 c0 08 00 00 00 4d =
29 c8 4c 01 c7 4c 29 c2 e9 72 ff ff ff cc cc cc cc eb 07 0f 00 2d 37 f9 =
33 00 fb f4 <fa> c3 0f 1f 00 65 48 8b 35 98 ff 55 7c f0 80 4e 02 20 48 =
8b 06 a8
[   19.102223][    C7] RSP: 0018:ffff9aaf000efef0 EFLAGS: 00000202
[   19.102825][    C7] RAX: ffff917577dc0000 RBX: ffff91740083bdc0 RCX: =
00000000ffffffff
[   19.103447][    C7] RDX: 0000000000000000 RSI: 000000046bc5c460 RDI: =
00000000000234d4
[   19.104075][    C7] RBP: 0000000000000007 R08: 0000000000000001 R09: =
00000000fff8da2a
[   19.104703][    C7] R10: 0000000000000001 R11: 0000000000001800 R12: =
0000000000000000
[   19.105326][    C7] R13: 0000000000000000 R14: 0000000000000000 R15: =
0000000000000000
[   19.105953][    C7]  default_idle_call+0x20/0x40
[   19.106334][    C7]  do_idle+0x1a4/0x1d0
[   19.106658][    C7]  cpu_startup_entry+0x20/0x30
[   19.107042][    C7]  start_secondary+0xe1/0xf0
[   19.107405][    C7]  common_startup_64+0x13e/0x148
[   19.107802][    C7]  </TASK>
[   19.108041][    C7] ---[ end trace 0000000000000000 ]=E2=80=94



[  101.473110][    C5] BUG: unable to handle page fault for address: =
ffff91742f6ed1ec
[  101.473731][    C5] #PF: supervisor write access in kernel mode
[  101.474181][    C5] #PF: error_code(0x0003) - permissions violation
[  101.474661][    C5] PGD 233c01067 P4D 233c01067 PUD 101bbf063 PMD =
13f3cf063 PTE 800000012f6ed121
[  101.475326][    C5] Oops: Oops: 0003 [#1] SMP
[  101.475662][    C5] CPU: 5 UID: 0 PID: 0 Comm: swapper/5 Tainted: G   =
     W  O       6.13.4 #2
[  101.476318][    C5] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
[  101.476706][    C5] Hardware name: QEMU Standard PC (Q35 + ICH9, =
2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[  101.477616][    C5] RIP: 0010:memcpy_orig+0x68/0x110
[  101.477997][    C5] Code: 83 c2 20 eb 44 48 01 d6 48 01 d7 48 83 ea =
20 0f 1f 00 48 83 ea 20 4c 8b 46 f8 4c 8b 4e f0 4c 8b 56 e8 4c 8b 5e e0 =
48 8d 76 e0 <4c> 89 47 f8 4c 89 4f f0 4c 89 57 e8 4c 89 5f e0 48 8d 7f =
e0 73 d2
[  101.479467][    C5] RSP: 0018:ffff9aaf0022cc58 EFLAGS: 00010206
[  101.479918][    C5] RAX: ffff91742f6ec840 RBX: ffff91740ac63100 RCX: =
0000000000000000
[  101.480519][    C5] RDX: 0000000000000974 RSI: ffff917400396630 RDI: =
ffff91742f6ed1f4
[  101.481110][    C5] RBP: 00000000000009b4 R08: bd71b2c82ec828b5 R09: =
516abfaa22e30e4c
[  101.481705][    C5] R10: 70129ddb96fbe60f R11: 877be8f28680b588 R12: =
ffff917400395c90
[  101.482294][    C5] R13: 000000000000000c R14: 0000000000005c9c R15: =
fffff4a18400e400
[  101.482889][    C5] FS:  0000000000000000(0000) =
GS:ffff917577d40000(0000) knlGS:0000000000000000
[  101.483554][    C5] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  101.484041][    C5] CR2: ffff91742f6ed1ec CR3: 0000000109555000 CR4: =
00000000003506f0
[  101.484635][    C5] Call Trace:
[  101.484878][    C5]  <IRQ>
[  101.485088][    C5]  ? show_trace_log_lvl+0x1a2/0x260
[  101.485478][    C5]  ? page_to_skb+0x378/0x5e0 [virtio_net]
[  101.485903][    C5]  ? __die+0x4d/0x8a
[  101.486190][    C5]  ? page_fault_oops+0x83/0x190
[  101.486553][    C5]  ? =
kernelmode_fixup_or_oops.constprop.0+0x33/0x1d0
[  101.487049][    C5]  ? exc_page_fault+0x91/0xa0
[  101.487395][    C5]  ? asm_exc_page_fault+0x22/0x30
[  101.487771][    C5]  ? memcpy_orig+0x68/0x110
[  101.488103][    C5]  page_to_skb+0x378/0x5e0 [virtio_net]
[  101.488518][    C5]  receive_buf+0x2ba/0xb70 [virtio_net]
[  101.488930][    C5]  ? kmem_cache_free+0x287/0x2d0
[  101.489295][    C5]  virtnet_poll+0x4f6/0x6c0 [virtio_net]
[  101.489717][    C5]  __napi_poll+0x20/0x130
[  101.490037][    C5]  net_rx_action+0x1c7/0x3e0
[  101.490376][    C5]  ? __napi_schedule+0x97/0xa0
[  101.490732][    C5]  handle_softirqs+0xde/0x1d0
[  101.491078][    C5]  irq_exit_rcu+0xac/0xd0
[  101.491398][    C5]  common_interrupt+0x79/0xa0
[  101.491755][    C5]  </IRQ>
[  101.491972][    C5]  <TASK>
[  101.492188][    C5]  asm_common_interrupt+0x22/0x40
[  101.492564][    C5] RIP: 0010:default_idle+0xb/0x10
[  101.492939][    C5] Code: 07 76 e7 48 89 07 49 c7 c0 08 00 00 00 4d =
29 c8 4c 01 c7 4c 29 c2 e9 72 ff ff ff cc cc cc cc eb 07 0f 00 2d 37 f9 =
33 00 fb f4 <fa> c3 0f 1f 00 65 48 8b 35 98 ff 55 7c f0 80 4e 02 20 48 =
8b 06 a8
[  101.494404][    C5] RSP: 0018:ffff9aaf000dfef0 EFLAGS: 00000212
[  101.494860][    C5] RAX: ffff917577d40000 RBX: ffff917400839b40 RCX: =
00000000ffffffff
[  101.495455][    C5] RDX: 0000000000000000 RSI: 000000179b776480 RDI: =
00000000000510ec
[  101.496048][    C5] RBP: 0000000000000005 R08: 0000000000000001 R09: =
00000000fffaf2b0
[  101.496643][    C5] R10: 0000000000000001 R11: 0000000000016c00 R12: =
0000000000000000
[  101.497234][    C5] R13: 0000000000000000 R14: 0000000000000000 R15: =
0000000000000000
[  101.497829][    C5]  default_idle_call+0x20/0x40
[  101.498183][    C5]  do_idle+0x1a4/0x1d0
[  101.498488][    C5]  cpu_startup_entry+0x20/0x30
[  101.498842][    C5]  start_secondary+0xe1/0xf0
[  101.499183][    C5]  common_startup_64+0x13e/0x148
[  101.499553][    C5]  </TASK>
[  101.499777][    C5] Modules linked in: xsk_diag unix_diag pppoe pppox =
ppp_generic slhc nf_conntrack_sip nf_conntrack_ftp nf_conntrack_pptp =
nft_ct nft_nat nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 =
nf_defrag_ipv4 nf_tables netconsole vmxnet3 virtio_net net_failover =
failover virtio_pci virtio_pci_legacy_dev virtio_pci_modern_dev virtio =
virtio_ring e1000 e1000e tap tun aesni_intel gf128mul crypto_simd cryptd
[  101.502860][    C5] CR2: ffff91742f6ed1ec
[  101.503168][    C5] ---[ end trace 0000000000000000 ]---
[  101.503578][    C5] RIP: 0010:memcpy_orig+0x68/0x110
[  101.503959][    C5] Code: 83 c2 20 eb 44 48 01 d6 48 01 d7 48 83 ea =
20 0f 1f 00 48 83 ea 20 4c 8b 46 f8 4c 8b 4e f0 4c 8b 56 e8 4c 8b 5e e0 =
48 8d 76 e0 <4c> 89 47 f8 4c 89 4f f0 4c 89 57 e8 4c 89 5f e0 48 8d 7f =
e0 73 d2
[  101.505439][    C5] RSP: 0018:ffff9aaf0022cc58 EFLAGS: 00010206
[  101.505897][    C5] RAX: ffff91742f6ec840 RBX: ffff91740ac63100 RCX: =
0000000000000000
[  101.506492][    C5] RDX: 0000000000000974 RSI: ffff917400396630 RDI: =
ffff91742f6ed1f4
[  101.507084][    C5] RBP: 00000000000009b4 R08: bd71b2c82ec828b5 R09: =
516abfaa22e30e4c
[  101.507679][    C5] R10: 70129ddb96fbe60f R11: 877be8f28680b588 R12: =
ffff917400395c90
[  101.508269][    C5] R13: 000000000000000c R14: 0000000000005c9c R15: =
fffff4a18400e400
[  101.508864][    C5] FS:  0000000000000000(0000) =
GS:ffff917577d40000(0000) knlGS:0000000000000000
[  101.509533][    C5] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  101.510024][    C5] CR2: ffff91742f6ed1ec CR3: 0000000109555000 CR4: =
00000000003506f0
[  101.510631][    C5] Kernel panic - not syncing: Fatal exception in =
interrupt
[  101.511284][    C5] Kernel Offset: 0x2000000 from 0xffffffff81000000 =
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[  101.512159][    C5] Rebooting in 10 seconds..=

