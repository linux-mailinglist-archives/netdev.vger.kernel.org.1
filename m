Return-Path: <netdev+bounces-89623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E838AAECB
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 14:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0759282CDB
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 12:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5B782D62;
	Fri, 19 Apr 2024 12:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="OSaCuar2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039831DFC7
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 12:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713530798; cv=none; b=OiLp+XZ3M9kfLQqiG0eFe8Uf0nKnkiZE8fxj6fzENThC+bv2iK6zjAPuMxg7TcxmPpv7P8/2tAxXKkXoamRGEBqZf8PcH9+gbh0oUjgs2a2tGPPh73ucWVdFsdnFVYk2RM1NTB1YR8f1VfdgMBCg2hV9J9nLpXPjvSiNXh0/gPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713530798; c=relaxed/simple;
	bh=Wo8wgR1yK4qQfw7ntsvLb1nlPH6dOgVHILflgqeVR9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ARYufLN7ZW7+XS1myvZRy3KgQySx0kGuwbkgZ9F8mbUYkowW/RIo9e9wa1IFRt8pIwDdHYiqIjp+oHYu7Yw5nkVZN3J2fEri6likLkgpu4hoITuOHJNGxD8RcpCu6LtClg0bL8eK8tJygRsiFz7TQg/YI9FAKlDKnmP1N8spH1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=OSaCuar2; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3465921600dso1732301f8f.3
        for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 05:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1713530794; x=1714135594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C41hY+yqZW09uHBLxVycCPRF188Vs1i1C51zjaGGICU=;
        b=OSaCuar2hfq4wJZ4qtuZesNRg/IdR5Sqz4BO6PQQ/WKvoBUp7Xjb7fXAEP32JPkX/l
         0PMuOUiW4pscUKuR3N8cDSmLA6DhzTSBfIpjeCq+eFImdjOpnww6IxnfrNDabBu0Mr01
         OFD+kVqNTuLWohKx+WKyZfKshlNWiIrWkj5CLq93aLGRc4d6Q/JRq+mNcImIII7hFKQr
         RwmFZlHEnEexOfo4NUyEKD2GqnCJcsKmBC3oKOgT3qCb9jwGXwemWVm2fLZtt9x7y7Z1
         vnq02YK3Xp9Yyb9a4Xjo2Nyue103Fe9GRwLuLkJxde3JbNO5o7CTxVgKwQvvzH4sW4xw
         ULsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713530794; x=1714135594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C41hY+yqZW09uHBLxVycCPRF188Vs1i1C51zjaGGICU=;
        b=Q4mDPeLNW8cD1Uxb79jzkWOSyS7D1zZIbQ9OAtSGeCmg+NBe9yntqP2+08RE7BeKYf
         iOWOXI0HcsSfffo53vnYBImXEE2ilxpwBK1OanUT1jXcfLIFb9VqsqC6sZ8cp+ZUd0j8
         XQyXzw9H2hwtae/0/OU94sYC640s/Py+sGh8FPCNU/B5msO6BUSELN3IyeEXWkrFxN9t
         KKOwwNYhERRugQGFq2UqrH+DcimPlljRTV1wiaTHqonDePkrmFRgXKP2WuV6VNHwqNci
         M/ooXnjgNKIzMOCU2H0Bfi+5h6aEZgYsFv0lAIsItgJDg8q+dmIl3SwMwuyg795XEcjI
         3t2w==
X-Gm-Message-State: AOJu0YxDquHWQ5Tj4ce9Ht/0Tmt2ECS4xjxAYw769bW9M1dZ1iePBdWv
	xgjhUiKMbW1wqj719NTIL4lDcS0at4lTw/efwGu3qeertctXUsC79Iy7k1Q1oKgQQ6hPMfvdYlf
	GB75YrQ==
X-Google-Smtp-Source: AGHT+IFIcIpguaDJSzY/Nr74kkMk+17axtpuUsPSiSfsQbG34sbFaiMKSs7FV6Ox7vLlRbxRbqvc1A==
X-Received: by 2002:a5d:59ab:0:b0:34a:73a9:50fd with SMTP id p11-20020a5d59ab000000b0034a73a950fdmr794564wrr.31.1713530793998;
        Fri, 19 Apr 2024 05:46:33 -0700 (PDT)
Received: from C02Y543BJGH6.home ([2a09:bac5:37e4:ebe::178:121])
        by smtp.gmail.com with ESMTPSA id w20-20020adfe054000000b0034a366f26b0sm2733767wrh.87.2024.04.19.05.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 05:46:33 -0700 (PDT)
From: Oxana Kharitonova <oxana@cloudflare.com>
To: netdev@vger.kernel.org
Cc: saeedm@nvidia.com,
	leon@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	rrameshbabu@nvidia.com,
	oxana@cloudflare.com,
	kernel-team@cloudflare.com
Subject: mlx5 driver fails to detect NIC in 6.6.28
Date: Fri, 19 Apr 2024 13:45:47 +0100
Message-ID: <20240419124632.60294-1-oxana@cloudflare.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

NIC stopped being detected in Linux 6.6.28. The problem was observed on 
two servers, after reverting kernel to 6.6.25 (our current stable version) 
everything returned to normal.

We suspect commit "net/mlx5e: Do not produce metadata freelist entries in 
Tx port ts WQE xmit", but we haven't done bisect yet. 

The kernel log is below.

root@localhost:~# ifconfig
lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
       inet 127.0.0.1  netmask 255.0.0.0
       inet6 ::1  prefixlen 128  scopeid 0x10<host>
       loop  txqueuelen 1000  (Local Loopback)
       RX packets 80  bytes 6480 (6.3 KiB)
       RX errors 0  dropped 0  overruns 0  frame 0
       TX packets 80  bytes 6480 (6.3 KiB)
       TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

root@localhost:~# lspci | grep Eth
c1:00.0 Ethernet controller: Mellanox Technologies MT27710 Family [ConnectX-4 Lx]
c1:00.1 Ethernet controller: Mellanox Technologies MT27710 Family [ConnectX-4 Lx]

[   23.519113] RIP: 0010:esw_port_metadata_get (drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c:4095 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c:2442) mlx5_core
[   23.524293] usb 2-1: new SuperSpeed USB device number 2 using xhci_hcd
[ 23.528602] Code: eb 8e 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 53 48 89 d3 e8 f2 5d ea c9 48 8b 80 b0 09 00 00 <8b> 80 18 11 00 00 88 03 31 c0 80 23 01 5b e9 38 1f f3 c9 0f 1f 84
All code
========
   0:	eb 8e                	jmp    0xffffffffffffff90
   2:	0f 1f 00             	nopl   (%rax)
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  1a:	53                   	push   %rbx
  1b:	48 89 d3             	mov    %rdx,%rbx
  1e:	e8 f2 5d ea c9       	call   0xffffffffc9ea5e15
  23:	48 8b 80 b0 09 00 00 	mov    0x9b0(%rax),%rax
  2a:*	8b 80 18 11 00 00    	mov    0x1118(%rax),%eax		<-- trapping instruction
  30:	88 03                	mov    %al,(%rbx)
  32:	31 c0                	xor    %eax,%eax
  34:	80 23 01             	andb   $0x1,(%rbx)
  37:	5b                   	pop    %rbx
  38:	e9 38 1f f3 c9       	jmp    0xffffffffc9f31f75
  3d:	0f                   	.byte 0xf
  3e:	1f                   	(bad)
  3f:	84                   	.byte 0x84

Code starting with the faulting instruction
===========================================
   0:	8b 80 18 11 00 00    	mov    0x1118(%rax),%eax
   6:	88 03                	mov    %al,(%rbx)
   8:	31 c0                	xor    %eax,%eax
   a:	80 23 01             	andb   $0x1,(%rbx)
   d:	5b                   	pop    %rbx
   e:	e9 38 1f f3 c9       	jmp    0xffffffffc9f31f4b
  13:	0f                   	.byte 0xf
  14:	1f                   	(bad)
  15:	84                   	.byte 0x84
[   23.528604] RSP: 0018:ffffc9000dbbfba8 EFLAGS: 00010282
[   23.530802] hub 1-1:1.0: 4 ports detected
[   23.537574] RAX: 0000000000000000 RBX: ffffc9000dbbfbfc RCX: 0000000000000028
[   23.537576] RDX: ffffc9000dbbfbfc RSI: 0000000000000013 RDI: ffff88811ec38000
[   23.537578] RBP: ffffffffc23fa560 R08: 0000000000000000 R09: 0000000000000000
[   23.537580] R10: 0000000000036ea0 R11: 0000000000000dc0 R12: ffff889850104f00
[   23.547568] usb 2-1: New USB device found, idVendor=05e3, idProduct=0620, bcdDevice=93.03
[   23.564222] R13: ffff8881075ca840 R14: ffff88811ec38000 R15: 0000000000000000
[   23.564224] FS:  0000000000000000(0000) GS:ffff88843fa00000(0000) knlGS:0000000000000000
[   23.564226] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   23.570143] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[   23.574839] CR2: 0000000000001118 CR3: 0000000c7af5c000 CR4: 0000000000350ef0
[   23.574841] Call Trace:
[   23.574844]  <TASK>
[   23.574846] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434) 
[   23.590485] ? page_fault_oops (arch/x86/mm/fault.c:707) 
[   23.590490] ? get_page_from_freelist (mm/page_alloc.c:1553 mm/page_alloc.c:3177) 
[   23.606129] ? exc_page_fault (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:72 arch/x86/mm/fault.c:1504 arch/x86/mm/fault.c:1552) 
[   23.655856] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:570) 
[   23.671501] ? esw_port_metadata_get (drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c:4095 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c:2442) mlx5_core
[   23.790812] ? esw_port_metadata_get (drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c:4095 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c:2442) mlx5_core
[   23.955180] devlink_nl_param_fill.constprop.0 (net/devlink/param.c:268) 
[   23.961276] ? __alloc_skb (net/core/skbuff.c:651 (discriminator 1)) 
[   23.974490] ? srso_return_thunk (arch/x86/lib/retpoline.S:217) 
[   23.987013] ? __kmalloc_node_track_caller (mm/slab_common.c:1025 mm/slab_common.c:1046) 
[   23.987018] ? srso_return_thunk (arch/x86/lib/retpoline.S:217) 
[   23.997812] ? kmalloc_reserve (net/core/skbuff.c:584) 
[   23.997816] ? srso_return_thunk (arch/x86/lib/retpoline.S:217) 
[   24.007217] ? __alloc_skb (net/core/skbuff.c:666) 
[   24.007222] devlink_param_notify.constprop.0 (net/devlink/param.c:354 net/devlink/param.c:330) 
[   24.055512] devl_params_register (net/devlink/param.c:686 (discriminator 1)) 
[   24.055516] esw_offloads_init (drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c:2482) mlx5_core
[   24.065009] mlx5_eswitch_init (drivers/net/ethernet/mellanox/mlx5/core/eswitch.c:1872) mlx5_core
[   24.165229] mlx5_init_one_devl_locked (drivers/net/ethernet/mellanox/mlx5/core/main.c:1022 drivers/net/ethernet/mellanox/mlx5/core/main.c:1447) mlx5_core
[   24.177007] probe_one (drivers/net/ethernet/mellanox/mlx5/core/main.c:1507 drivers/net/ethernet/mellanox/mlx5/core/main.c:1947) mlx5_core
[   24.187296] local_pci_probe (drivers/pci/pci-driver.c:325) 
[   24.196698] work_for_cpu_fn (kernel/workqueue.c:5618 (discriminator 1)) 
[   24.205988] process_one_work (kernel/workqueue.c:2632) 
[   24.215612] worker_thread (kernel/workqueue.c:2694 (discriminator 2) kernel/workqueue.c:2781 (discriminator 2)) 
[   24.224999] ? __pfx_worker_thread (kernel/workqueue.c:2727) 
[   24.234912] kthread (kernel/kthread.c:388) 
[   24.243647] ? __pfx_kthread (kernel/kthread.c:341) 
[   24.252988] ret_from_fork (arch/x86/kernel/process.c:153) 
[   24.262103] ? __pfx_kthread (kernel/kthread.c:341) 
[   24.271347] ret_from_fork_asm (arch/x86/entry/entry_64.S:314) 
[   24.280754]  </TASK>


