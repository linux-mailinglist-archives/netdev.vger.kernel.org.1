Return-Path: <netdev+bounces-228064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E52BC064A
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 08:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 94F5E4F3517
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 06:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B43B235354;
	Tue,  7 Oct 2025 06:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IGYhEZS0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990133FC7
	for <netdev@vger.kernel.org>; Tue,  7 Oct 2025 06:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759819912; cv=none; b=tVaD0oGGAu776DjZTfzxmq7J84sLsd5IdS8gwzja3kfRcdz7pSQish6AN/Iq0ws1KHhv7njD2W5khPmniW9pEG5yICqzwICBNwai0bMnsA2OwY51zvugowwEFv514RThqEYIjRjYmH8uKdAHIEwswUoOhHZbce0pUI95iGT6+l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759819912; c=relaxed/simple;
	bh=taPypstpgDTDUjBmUfJvNW2OwwrAp5+Rl01nAXbvMpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l4OC0+04E4Jt6EwscOdx+ERDYip2zWJWZacf61YBI+Uj32PQwlS4YSuv7/GBL5swGSASsz/cJfizrfVnr9JL74KcezBibEa3K35so6Mdf8fNmvb9UeluKGq0//SD5aeY5HosLGNTvdt58l9kelxMLgDbMDoMrPUI+mz+tu54VNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IGYhEZS0; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4e2d2d764a3so44495951cf.1
        for <netdev@vger.kernel.org>; Mon, 06 Oct 2025 23:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759819909; x=1760424709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+JidXosakX2VeiW3D08a668j/IcphI3xJ+XGffiOSQ=;
        b=IGYhEZS0aj9z5ynUa3bDbv0wA776Nc1Xr1O6gByMoQFuiWykZ9Wd6t4JZmucE8NZRF
         zPM/A0NJSehOh3C5XZKkQ5Qsu2iNcU7h8BEtRGoYfRKvTfRk8brA/tKuuj7PY26h1L4Y
         lTEIJQGfDHgLS43PAKzZHGxFww+A2YltaTKMmuA1l7F9XgPBMM6SYdVCPodbjAouhOdS
         OCUCYSL4zJCXHJnYijDtUYiiC83dwvoecF4qdLw93zjk+LI1BTdJD9yKE+g2wqEPlOYj
         UKdhtx0xnuoSriLubExmzjDeVC/qH4ealFFxsaZanXHJXp243b3zC8FmDIhucpuP+piG
         /dVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759819909; x=1760424709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+JidXosakX2VeiW3D08a668j/IcphI3xJ+XGffiOSQ=;
        b=w4v0kGrt3yvWx3v9hMAUDpQR97urdxoHRU+GVEMWhL1E5WJXxiL8stYRzyywWsdk3m
         xiXEPbLJd7d4Z7PLCZh68pLaSFhMTGXZ21jsR1rQovvTbdLRUW26iIzCiD4217uydBl0
         bjFDMBweyNVJZix/6Q0yO0KTO7rSIfmHpI9rkA0Po4DJWz33Xb/zFFLn8Tj4eCiXDeRB
         L2pyAurdE+eGafjNeEDaHGKaDypEgOiT3/nCmmrdJSjKHo/jA8XRcBSXCgcznjw43U3X
         jlMDXcqUTxgJmh43rIwNiZiiE+0dEpKnX03GaoABZYEGlGOxsZGiMGcr97N0y7PaIjH2
         pSVg==
X-Forwarded-Encrypted: i=1; AJvYcCVmBGyHxSgETTJcMouKHZ/pgVm5FuOfZ0DBZqwdhw9bILjoS16w5EedmCHgnzV5a73fIDr9VII=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyiy6+yP846K++dO9jCG/S0kWAWzi89FODuPq74BDpVKVb5TtAI
	x1ev2yMY1o3ARUPSQx39VYI6ySc6FVhCpGD9QFTeSGc2CoMVee3evyPs5mTcO8CxqXuJ7fFKdyJ
	0xkeKXSF6gaNB82OLpCUfuO3gzf/CGM2pcz/isjF3
X-Gm-Gg: ASbGnctWpyIyTwAOBP4C6UMIavU2kXhJchtd6vCsI4vpOhSoHHVr7lEs6IuzekzS2f3
	aeZ6WAE2AA5R9syC1axypfaT3za//SzjZ+xKtyv7pb3YQ4P/9a82QNJGrya6JwZsPgtPxVb1XOF
	L90+OM3ETeSgebgaLStpqRE/yC+AybbFgR0xDAb6LpUxK56zMCSp7SfS/Y477/U+3ppGakKgLpN
	glm8gC+9LomgfjrfrvMFeWDp3b7XJJjy+XhPAxAZZT736SHkSdzIcK/kmnM78FtiGpLK4HK90Yu
	R34=
X-Google-Smtp-Source: AGHT+IFeofBP/c+wJwsHC20YK3rHFH3MJrj2b4okMyxd0qNeu44w+ajjQ6HoWelQQFWldIezOCpuA/DZ5AI17I1LleI=
X-Received: by 2002:ac8:5885:0:b0:4d3:1b4f:dda1 with SMTP id
 d75a77b69052e-4e576b15512mr188508481cf.61.1759819909054; Mon, 06 Oct 2025
 23:51:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925223656.1894710-1-nogikh@google.com>
In-Reply-To: <20250925223656.1894710-1-nogikh@google.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 7 Oct 2025 08:51:12 +0200
X-Gm-Features: AS18NWCyXCXj_i81r8vLTXVuUBRBEcFIsjxfqzy_6Tl-otD9cIoqcrjJwpSjR4U
Message-ID: <CAG_fn=U3Rjd_0zfCJE-vuU3Htbf2fRP_GYczdYjJJ1W5o30+UQ@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in eth_type_trans
To: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@infradead.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Leon Romanovsky <leonro@nvidia.com>, mhklinux@outlook.com
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, Aleksandr Nogikh <nogikh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 12:36=E2=80=AFAM Aleksandr Nogikh <nogikh@google.co=
m> wrote:
>
> Hello net developers,

CCing DMA developers, as this seems to be a generic problem.
See the question below, after the KMSAN report.

> I hit the following kernel crash when I try to boot a CONFIG_KMSAN=3Dy ke=
rnel on qemu:
>
> KMSAN: uninit-value in eth_type_trans
>
> Could you please have a look?
>
> Kernel: torvalds
> Commit: cec1e6e5d1ab33403b809f79cd20d6aff124ccfe
> Config: https://raw.githubusercontent.com/google/syzkaller/refs/heads/mas=
ter/dashboard/config/linux/upstream-kmsan.config
>
> Qemu command to reproduce:
>
> qemu-system-x86_64 -m 8G -smp 2,sockets=3D2,cores=3D1 -machine pc-q35-10.=
0 \
> -enable-kvm -display none -serial stdio -snapshot \
> -device virtio-blk-pci,drive=3Dmyhd -drive file=3D~/buildroot_amd64_2024.=
09,format=3Draw,if=3Dnone,id=3Dmyhd \
> -kernel ~/linux/arch/x86/boot/bzImage -append "root=3D/dev/vda1" -cpu max=
 \
> -net nic,model=3De1000 -net user,host=3D10.0.2.10,hostfwd=3Dtcp:127.0.0.1=
:10021-:22
>
> The command used the buildroot image below:
> $ wget 'https://storage.googleapis.com/syzkaller/images/buildroot_amd64_2=
024.09.gz'
> $ gunzip buildroot_amd64_2024.09.gz
>
> Full symbolized report:
>
> BUG: KMSAN: uninit-value in eth_skb_pkt_type include/linux/etherdevice.h:=
627 [inline]
> BUG: KMSAN: uninit-value in eth_type_trans+0x4ee/0x980 net/ethernet/eth.c=
:165
>  eth_skb_pkt_type include/linux/etherdevice.h:627 [inline]
>  eth_type_trans+0x4ee/0x980 net/ethernet/eth.c:165
>  e1000_receive_skb drivers/net/ethernet/intel/e1000/e1000_main.c:4005 [in=
line]
>  e1000_clean_rx_irq+0x1256/0x1cf0 drivers/net/ethernet/intel/e1000/e1000_=
main.c:4465
>  e1000_clean+0x1e4b/0x5f10 drivers/net/ethernet/intel/e1000/e1000_main.c:=
3807
>  __napi_poll+0xda/0x850 net/core/dev.c:7506
>  napi_poll net/core/dev.c:7569 [inline]
>  net_rx_action+0xa56/0x1b00 net/core/dev.c:7696
>  handle_softirqs+0x166/0x6e0 kernel/softirq.c:579
>  __do_softirq kernel/softirq.c:613 [inline]
>  invoke_softirq kernel/softirq.c:453 [inline]
>  __irq_exit_rcu+0x66/0x180 kernel/softirq.c:680
>  irq_exit_rcu+0x12/0x20 kernel/softirq.c:696
>  common_interrupt+0x99/0xb0 arch/x86/kernel/irq.c:318
>  asm_common_interrupt+0x2b/0x40 arch/x86/include/asm/idtentry.h:693
>  native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
>  pv_native_safe_halt+0x17/0x20 arch/x86/kernel/paravirt.c:81
>  arch_safe_halt arch/x86/kernel/process.c:756 [inline]
>  default_idle+0xd/0x20 arch/x86/kernel/process.c:757
>  arch_cpu_idle+0xd/0x20 arch/x86/kernel/process.c:794
>  default_idle_call+0x41/0x70 kernel/sched/idle.c:122
>  cpuidle_idle_call kernel/sched/idle.c:190 [inline]
>  do_idle+0x1dc/0x790 kernel/sched/idle.c:330
>  cpu_startup_entry+0x60/0x80 kernel/sched/idle.c:428
>  rest_init+0x1df/0x260 init/main.c:744
>  start_kernel+0x76e/0x960 init/main.c:1097
>  x86_64_start_reservations+0x28/0x30 arch/x86/kernel/head64.c:307
>  x86_64_start_kernel+0x139/0x140 arch/x86/kernel/head64.c:288
>  common_startup_64+0x13e/0x147
>
> Uninit was stored to memory at:
>  skb_put_data include/linux/skbuff.h:2753 [inline]
>  e1000_copybreak drivers/net/ethernet/intel/e1000/e1000_main.c:4339 [inli=
ne]
>  e1000_clean_rx_irq+0x870/0x1cf0 drivers/net/ethernet/intel/e1000/e1000_m=
ain.c:4384
>  e1000_clean+0x1e4b/0x5f10 drivers/net/ethernet/intel/e1000/e1000_main.c:=
3807
>  __napi_poll+0xda/0x850 net/core/dev.c:7506
>  napi_poll net/core/dev.c:7569 [inline]
>  net_rx_action+0xa56/0x1b00 net/core/dev.c:7696
>  handle_softirqs+0x166/0x6e0 kernel/softirq.c:579
>  __do_softirq kernel/softirq.c:613 [inline]
>  invoke_softirq kernel/softirq.c:453 [inline]
>  __irq_exit_rcu+0x66/0x180 kernel/softirq.c:680
>  irq_exit_rcu+0x12/0x20 kernel/softirq.c:696
>  common_interrupt+0x99/0xb0 arch/x86/kernel/irq.c:318
>  asm_common_interrupt+0x2b/0x40 arch/x86/include/asm/idtentry.h:693
>
> Uninit was stored to memory at:
>  swiotlb_bounce+0x470/0x640 kernel/dma/swiotlb.c:-1
>  __swiotlb_sync_single_for_cpu+0x9e/0xc0 kernel/dma/swiotlb.c:1567
>  swiotlb_sync_single_for_cpu include/linux/swiotlb.h:279 [inline]
>  dma_direct_sync_single_for_cpu kernel/dma/direct.h:77 [inline]
>  __dma_sync_single_for_cpu+0x50d/0x710 kernel/dma/mapping.c:370
>  dma_sync_single_for_cpu include/linux/dma-mapping.h:381 [inline]
>  e1000_copybreak drivers/net/ethernet/intel/e1000/e1000_main.c:4336 [inli=
ne]
>  e1000_clean_rx_irq+0x7dc/0x1cf0 drivers/net/ethernet/intel/e1000/e1000_m=
ain.c:4384
>  e1000_clean+0x1e4b/0x5f10 drivers/net/ethernet/intel/e1000/e1000_main.c:=
3807
>  __napi_poll+0xda/0x850 net/core/dev.c:7506
>  napi_poll net/core/dev.c:7569 [inline]
>  net_rx_action+0xa56/0x1b00 net/core/dev.c:7696
>  handle_softirqs+0x166/0x6e0 kernel/softirq.c:579
>  __do_softirq kernel/softirq.c:613 [inline]
>  invoke_softirq kernel/softirq.c:453 [inline]
>  __irq_exit_rcu+0x66/0x180 kernel/softirq.c:680
>  irq_exit_rcu+0x12/0x20 kernel/softirq.c:696
>  common_interrupt+0x99/0xb0 arch/x86/kernel/irq.c:318
>  asm_common_interrupt+0x2b/0x40 arch/x86/include/asm/idtentry.h:693
>
> Uninit was stored to memory at:
>  swiotlb_bounce+0x470/0x640 kernel/dma/swiotlb.c:-1
>  swiotlb_tbl_map_single+0x2956/0x2b20 kernel/dma/swiotlb.c:1439
>  swiotlb_map+0x349/0x1050 kernel/dma/swiotlb.c:1584
>  dma_direct_map_page kernel/dma/direct.h:-1 [inline]
>  dma_map_page_attrs+0x614/0xef0 kernel/dma/mapping.c:169
>  dma_map_single_attrs include/linux/dma-mapping.h:469 [inline]
>  e1000_alloc_rx_buffers+0x96d/0x1600 drivers/net/ethernet/intel/e1000/e10=
00_main.c:4616
>  e1000_configure+0x16fe/0x1930 drivers/net/ethernet/intel/e1000/e1000_mai=
n.c:377
>  e1000_open+0x985/0x14d0 drivers/net/ethernet/intel/e1000/e1000_main.c:13=
88
>  __dev_open+0x7c2/0xc40 net/core/dev.c:1682
>  __dev_change_flags+0x3ae/0x9b0 net/core/dev.c:9549
>  netif_change_flags+0x8d/0x1e0 net/core/dev.c:9612
>  dev_change_flags+0x18c/0x320 net/core/dev_api.c:68
>  devinet_ioctl+0x162d/0x2570 net/ipv4/devinet.c:1199
>  inet_ioctl+0x4c0/0x6f0 net/ipv4/af_inet.c:1001
>  sock_do_ioctl+0x9f/0x480 net/socket.c:1238
>  sock_ioctl+0x70b/0xd60 net/socket.c:1359
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:598 [inline]
>  __se_sys_ioctl+0x23c/0x400 fs/ioctl.c:584
>  __x64_sys_ioctl+0x97/0xe0 fs/ioctl.c:584
>  x64_sys_call+0x1cbc/0x3e20 arch/x86/include/generated/asm/syscalls_64.h:=
17
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Uninit was created at:
>  __alloc_frozen_pages_noprof+0x648/0xe80 mm/page_alloc.c:5171
>  __alloc_pages_noprof+0x41/0xd0 mm/page_alloc.c:5182
>  __page_frag_cache_refill+0x57/0x2a0 mm/page_frag_cache.c:59
>  __page_frag_alloc_align+0xd0/0x690 mm/page_frag_cache.c:103
>  __napi_alloc_frag_align net/core/skbuff.c:248 [inline]
>  __netdev_alloc_frag_align+0x1b7/0x1f0 net/core/skbuff.c:269
>  netdev_alloc_frag include/linux/skbuff.h:3408 [inline]
>  e1000_alloc_frag drivers/net/ethernet/intel/e1000/e1000_main.c:2074 [inl=
ine]
>  e1000_alloc_rx_buffers+0x276/0x1600 drivers/net/ethernet/intel/e1000/e10=
00_main.c:4584
>  e1000_configure+0x16fe/0x1930 drivers/net/ethernet/intel/e1000/e1000_mai=
n.c:377
>  e1000_open+0x985/0x14d0 drivers/net/ethernet/intel/e1000/e1000_main.c:13=
88
>  __dev_open+0x7c2/0xc40 net/core/dev.c:1682
>  __dev_change_flags+0x3ae/0x9b0 net/core/dev.c:9549
>  netif_change_flags+0x8d/0x1e0 net/core/dev.c:9612
>  dev_change_flags+0x18c/0x320 net/core/dev_api.c:68
>  devinet_ioctl+0x162d/0x2570 net/ipv4/devinet.c:1199
>  inet_ioctl+0x4c0/0x6f0 net/ipv4/af_inet.c:1001
>  sock_do_ioctl+0x9f/0x480 net/socket.c:1238
>  sock_ioctl+0x70b/0xd60 net/socket.c:1359
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:598 [inline]
>  __se_sys_ioctl+0x23c/0x400 fs/ioctl.c:584
>  __x64_sys_ioctl+0x97/0xe0 fs/ioctl.c:584
>  x64_sys_call+0x1cbc/0x3e20 arch/x86/include/generated/asm/syscalls_64.h:=
17
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f

Folks, as far as I understand, dma_direct_sync_single_for_cpu() and
dma_direct_sync_single_for_device() are the places where we send data
to or from the device.
Should we add KMSAN annotations to those functions to catch infoleaks
and mark data from devices as initialized?

