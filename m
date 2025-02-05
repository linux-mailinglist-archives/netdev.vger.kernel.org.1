Return-Path: <netdev+bounces-162950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7898A289AC
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 12:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44A041640BE
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 11:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4151721ADC3;
	Wed,  5 Feb 2025 11:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6vkRID6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2318621516B
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 11:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738756172; cv=none; b=lhVmg32mWXc6XJnzk56yEeOUfifWQkfxYgG5+ZekbpD5vcuPYdSRVXQBzSbWcrs4AyeJEyo48wqtenmpJmhP1d75g9VTH3oMERHBfdfIXbgMTnDAFAti0LGPrN07t48W9IGfawTgd8SQFGrp/whPf80y7Mb4Vsu3FTK5qrA6SWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738756172; c=relaxed/simple;
	bh=iP3zidMEi5CXP7Z1ZnMuNZn1CVwtpt2P3DKjjgEejgE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=QyNUIpgV+XWneXUrVVCct2iBIyQnEneNRw2o21UeJsn7a07DwLZuNDfNEq6QWsEfcmjfm/dlScZHvHIE8D75JvVO97FZlUlaP5QaL6PODX47kOEMtH+23rzdl2sDq1QfpRMUXAA8QuF+LW1GjFIRfcu/IiIh6YyclDPi+UzKlEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6vkRID6; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-866eb01bde9so318426241.0
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 03:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738756168; x=1739360968; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=72JglIftWiPOQvwCE0p3rByzC4fgqKLFM9zYVhJ3lw8=;
        b=H6vkRID6dNFJLjVzsXWy/xGwnhUOgdbLHNlxtPiSPEbgM4B3/LLYrPmd9nTjDyjbAF
         5Oc4yDPw+IrPJENx2i5tYvA8cA7ZNmGYwpi3I3pYBHMZbqipGsCdu2mLcgoKUl96yee8
         z10m4JsEjxCGCkO3CXVgZQN6CHJwolgWI7wpbVLNbf54RrkiG1AlZLzflzJtTND0dXs9
         5eaIDVOQq49QP0riritBy5b3CRXwdTMHR4pKWf1Fso2uD+ienviCSHCRKKpinRqWWO0l
         F1mrzIzKqMZzYicfIWtlMF4I6IhKcbTLoY6car0iTGF5m8/TRF+H73BNhoHIOqp0mZyi
         wvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738756168; x=1739360968;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=72JglIftWiPOQvwCE0p3rByzC4fgqKLFM9zYVhJ3lw8=;
        b=NyOvGxW/UfGKZKsX62NtMiEaG/kzrmcXtFxtZ6hSd9FH5XdU8N/3AD9W5cnw9MzQM+
         cEFdjGOdqQwO3NqJldu6XzaCn2K07peGgs1dTJUQM7GJ3awo75OS8fdaO4qAlBH4MgzY
         Iy2KmLnNXzgX1yWfoIGquOW/4VVKcNjMmCNwNTFquKdpyuuP6AMFeza80xe/EM7ROWZh
         8lAQq6Fe5riESKd7IKr11Xa4zJUywP0knu9uaRXcCWpWeo0HpJ0roa/6F/aGraeCUYW6
         e+0viB1i0qddfjgu+BbHK6fHAeKejMqqmEOjvoGrY6bx27B73FML39VB3gNrVgw+O3Mx
         Y4kg==
X-Gm-Message-State: AOJu0YwRF52ysQRVoSeomK2bi59PKCwix1vhsYMwvt4Yvj8oBN/CwJfl
	uJ5LvgDiopttI67fsLIOL7J2FMBwJS/Q6zImCZgpne+S8McFrWPLjSvyxznOF/uJPLRXZW7TsS9
	92xuLBFMFsFho1Unw2faJ1T0lYqwmcNJ+36I=
X-Gm-Gg: ASbGncvd42o4GCeamygvHdMDtTxyldoX8bOwLGX1sR0vLZEE5pKQssy1n0/Fotqm88W
	spK6330VdUfZSp70kFl13V21cO2xWw+h70KQeMSd1INDZtuOS73NHdqj87lEg6Jy/upv2ISs=
X-Google-Smtp-Source: AGHT+IFMw+d+/d8hv9Du+COD3Gi3DLcVWslt/gawg5KIqXdl/r0ulxPG7oOAK2r0jD/xc/mTcTgpTkbIhi5w6z6paZA=
X-Received: by 2002:a05:6102:1513:b0:4b2:5c1a:bb57 with SMTP id
 ada2fe7eead31-4ba47ab5d94mr1624926137.20.1738756168467; Wed, 05 Feb 2025
 03:49:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ian Kumlien <ian.kumlien@gmail.com>
Date: Wed, 5 Feb 2025 12:49:17 +0100
X-Gm-Features: AWEUYZmcQW_pPrsD6UNmRqP1cXdpu_cB5bLq1-LqKt6Vl5JTd1_dG39h0cjXut4
Message-ID: <CAA85sZtE+qmv94hQgpiWtBFvG7tOdngao6Lxkrw-3Ry-fKvvSA@mail.gmail.com>
Subject: mlx5 - kernel oops on link down and up?
To: Linux Kernel Network Developers <netdev@vger.kernel.org>
Cc: saeedm@nvidia.com
Content-Type: text/plain; charset="UTF-8"

Hi, again,

I have two machines at home connected with two mlx5 cards - 100 gbit,
for testing things like rdma for nfs etc

They are directly connected, so no switch is involved.

So, the machine on the other end had a bad harddrive - so it was
powered down and up...
To my surprise, my desktop broke in the process (network traffic
stopped working)

Anyway, here is the output:
/usr/src/linux/scripts/decode_stacktrace.sh /boot/vmlinuz-6.13.0 < mlxbug.txt
[111535.640532] mlx5_core 0000:03:00.1 eth3: Link down
[111740.928608] mlx5_core 0000:03:00.1 eth3: Link up
[111740.988004] GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP|__GFP_THISNODE
allocation from offline node 6
[111740.988010] CPU: 18 UID: 0 PID: 6566 Comm: NetworkManager Tainted:
G S                 6.13.0 #520
[111740.988013] Tainted: [S]=CPU_OUT_OF_SPEC
[111740.988014] Hardware name: ASUS System Product Name/Pro WS
X570-ACE, BIOS 4902 08/29/2024
[111740.988016] Call Trace:
[111740.988018]  <TASK>
[111740.988021] dump_stack_lvl+0x47/0x70
[111740.988027] allocate_slab.cold+0x1a/0x46
[111740.988031] ___slab_alloc+0xd7c/0xe20
WARNING! Cannot find .ko for module mlx5_core, please pass a valid module path
[111740.988036] ? mlx5e_open_channels+0x746/0x1070 mlx5_core
WARNING! Cannot find .ko for module mlx5_core, please pass a valid module path
[111740.988077] ? mlx5e_open_channels+0x746/0x1070 mlx5_core
[111740.988104] __kmalloc_node_noprof+0xdc/0x380
WARNING! Cannot find .ko for module mlx5_core, please pass a valid module path
[111740.988108] mlx5e_open_channels+0x746/0x1070 mlx5_core
WARNING! Cannot find .ko for module mlx5_core, please pass a valid module path
[111740.988138] ? __pfx_mlx5e_set_dev_port_mtu_ctx+0x10/0x10 mlx5_core
WARNING! Cannot find .ko for module mlx5_core, please pass a valid module path
[111740.988165] mlx5e_safe_switch_params+0x8a/0x120 mlx5_core
WARNING! Cannot find .ko for module mlx5_core, please pass a valid module path
[111740.988192] mlx5e_change_mtu+0x101/0x300 mlx5_core
WARNING! Cannot find .ko for module mlx5_core, please pass a valid module path
[111740.988219] ? __pfx_mlx5e_set_dev_port_mtu_ctx+0x10/0x10 mlx5_core
[111740.988251] dev_set_mtu_ext+0x101/0x210
[111740.988257] do_setlink.isra.0+0x210/0x11d0
[111740.988263] ? ___slab_alloc+0x26d/0xe20
[111740.988266] ? rtnl_newlink+0x46/0xc10
[111740.988268] ? srso_return_thunk+0x5/0x5f
[111740.988271] ? __nla_validate_parse+0x83/0xe00
[111740.988275] ? srso_return_thunk+0x5/0x5f
[111740.988277] ? security_capable+0x68/0xa0
[111740.988281] rtnl_newlink+0x6ce/0xc10
[111740.988284] ? srso_return_thunk+0x5/0x5f
[111740.988286] ? rt_spin_unlock+0x13/0x40
[111740.988288] ? srso_return_thunk+0x5/0x5f
[111740.988290] ? lockref_get_not_dead+0x30/0x50
[111740.988293] ? srso_return_thunk+0x5/0x5f
[111740.988294] ? try_to_unlazy+0x68/0xe0
[111740.988297] ? srso_return_thunk+0x5/0x5f
[111740.988299] ? terminate_walk+0x61/0x100
[111740.988300] ? srso_return_thunk+0x5/0x5f
[111740.988302] ? path_lookupat+0x96/0x1a0
[111740.988305] ? srso_return_thunk+0x5/0x5f
[111740.988306] ? __pfx_rtnl_newlink+0x10/0x10
[111740.988309] rtnetlink_rcv_msg+0x385/0x430
[111740.988311] ? srso_return_thunk+0x5/0x5f
[111740.988313] ? ___slab_alloc+0x26d/0xe20
[111740.988315] ? srso_return_thunk+0x5/0x5f
[111740.988317] ? kmalloc_reserve+0xc1/0x130
[111740.988320] ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[111740.988322] netlink_rcv_skb+0x4f/0x100
[111740.988328] netlink_unicast+0x24b/0x3a0
[111740.988331] netlink_sendmsg+0x1f1/0x450
[111740.988334] ____sys_sendmsg+0x2fc/0x330
[111740.988338] ? copy_msghdr_from_user+0xeb/0x180
[111740.988341] ___sys_sendmsg+0x8f/0xe0
[111740.988344] ? srso_return_thunk+0x5/0x5f
[111740.988346] ? srso_return_thunk+0x5/0x5f
[111740.988348] ? kfree+0x15f/0x3a0
[111740.988350] ? srso_return_thunk+0x5/0x5f
[111740.988352] ? srso_return_thunk+0x5/0x5f
[111740.988353] ? rt_spin_unlock+0x13/0x40
[111740.988355] ? srso_return_thunk+0x5/0x5f
[111740.988357] ? proc_sys_call_handler+0xf6/0x2d0
[111740.988360] ? srso_return_thunk+0x5/0x5f
[111740.988362] ? srso_return_thunk+0x5/0x5f
[111740.988365] __sys_sendmsg+0x88/0x100
[111740.988369] do_syscall_64+0x47/0x110
[111740.988373] entry_SYSCALL_64_after_hwframe+0x76/0x7e
[111740.988376] RIP: 0033:0x7f1b02f6aace
[111740.988379] Code: 20 89 54 24 1c 48 89 74 24 10 89 7c 24 08 e8 59
64 f7 ff 41 89 c0 b8 2e 00 00 00 8b 54 24 1c 48 8b 74 24 10 8b 7c 24
08 0f 05 <48> 3d 00 f0 ff ff 77 3a 44 89 c7 48 89 44 24 08 e8 ad 64 f7
ff 48
All code
========
   0: 20 89 54 24 1c 48    and    %cl,0x481c2454(%rcx)
   6: 89 74 24 10          mov    %esi,0x10(%rsp)
   a: 89 7c 24 08          mov    %edi,0x8(%rsp)
   e: e8 59 64 f7 ff        call   0xfffffffffff7646c
  13: 41 89 c0              mov    %eax,%r8d
  16: b8 2e 00 00 00        mov    $0x2e,%eax
  1b: 8b 54 24 1c          mov    0x1c(%rsp),%edx
  1f: 48 8b 74 24 10        mov    0x10(%rsp),%rsi
  24: 8b 7c 24 08          mov    0x8(%rsp),%edi
  28: 0f 05                syscall
  2a:* 48 3d 00 f0 ff ff    cmp    $0xfffffffffffff000,%rax <--
trapping instruction
  30: 77 3a                ja     0x6c
  32: 44 89 c7              mov    %r8d,%edi
  35: 48 89 44 24 08        mov    %rax,0x8(%rsp)
  3a: e8 ad 64 f7 ff        call   0xfffffffffff764ec
  3f: 48                    rex.W

Code starting with the faulting instruction
===========================================
   0: 48 3d 00 f0 ff ff    cmp    $0xfffffffffffff000,%rax
   6: 77 3a                ja     0x42
   8: 44 89 c7              mov    %r8d,%edi
   b: 48 89 44 24 08        mov    %rax,0x8(%rsp)
  10: e8 ad 64 f7 ff        call   0xfffffffffff764c2
  15: 48                    rex.W
[111740.988381] RSP: 002b:00007ffdc6aba270 EFLAGS: 00000293 ORIG_RAX:
000000000000002e
[111740.988383] RAX: ffffffffffffffda RBX: 000055bd7e6c9ea0 RCX:
00007f1b02f6aace
[111740.988385] RDX: 0000000000000000 RSI: 00007ffdc6aba2c0 RDI:
000000000000000d
[111740.988386] RBP: 00007ffdc6aba2c0 R08: 0000000000000000 R09:
0000000000000000
[111740.988387] R10: 0000000000000000 R11: 0000000000000293 R12:
000055bd7e6c9ea0
[111740.988388] R13: 0000000000000000 R14: 00007ffdc6aba4b8 R15:
0000000000000000
[111740.988391]  </TASK>
[111749.376570] mlx5_core 0000:03:00.1 eth3: Link down
[111872.072811] mlx5_core 0000:03:00.1 eth3: Link up
[111872.261415] BUG: unable to handle page fault for address: ffffffff8a2c29f8
[111872.261418] #PF: supervisor write access in kernel mode
[111872.261420] #PF: error_code(0x0003) - permissions violation
[111872.261421] PGD 785446067 P4D 785446067 PUD 785447063 PMD
108b47063 PTE 80000007852c2121
[111872.261425] Oops: Oops: 0003 [#1] PREEMPT_RT SMP NOPTI
[111872.261428] CPU: 8 UID: 0 PID: 6566 Comm: NetworkManager Tainted:
G S                 6.13.0 #520
[111872.261431] Tainted: [S]=CPU_OUT_OF_SPEC
[111872.261432] Hardware name: ASUS System Product Name/Pro WS
X570-ACE, BIOS 4902 08/29/2024
[111872.261433] RIP: queued_spin_lock_slowpath+0x22b/0x265
[111872.261438] Code: ff f3 90 48 8b 0a 48 85 c9 74 f6 eb d6 c1 e9 12
83 e0 03 ff c9 48 c1 e0 04 48 63 c9 48 05 c0 06 03 00 48 03 04 cd e0
cb 27 8a <48> 89 10 8b 42 08 85 c0 75 09 f3 90 8b 42 08 85 c0 74 f7 48
8b 0a
All code
========
   0: ff f3                push   %rbx
   2: 90                    nop
   3: 48 8b 0a              mov    (%rdx),%rcx
   6: 48 85 c9              test   %rcx,%rcx
   9: 74 f6                je     0x1
   b: eb d6                jmp    0xffffffffffffffe3
   d: c1 e9 12              shr    $0x12,%ecx
  10: 83 e0 03              and    $0x3,%eax
  13: ff c9                dec    %ecx
  15: 48 c1 e0 04          shl    $0x4,%rax
  19: 48 63 c9              movslq %ecx,%rcx
  1c: 48 05 c0 06 03 00    add    $0x306c0,%rax
  22: 48 03 04 cd e0 cb 27 add    -0x75d83420(,%rcx,8),%rax
  29: 8a
  2a:* 48 89 10              mov    %rdx,(%rax) <-- trapping instruction
  2d: 8b 42 08              mov    0x8(%rdx),%eax
  30: 85 c0                test   %eax,%eax
  32: 75 09                jne    0x3d
  34: f3 90                pause
  36: 8b 42 08              mov    0x8(%rdx),%eax
  39: 85 c0                test   %eax,%eax
  3b: 74 f7                je     0x34
  3d: 48 8b 0a              mov    (%rdx),%rcx

Code starting with the faulting instruction
===========================================
   0: 48 89 10              mov    %rdx,(%rax)
   3: 8b 42 08              mov    0x8(%rdx),%eax
   6: 85 c0                test   %eax,%eax
   8: 75 09                jne    0x13
   a: f3 90                pause
   c: 8b 42 08              mov    0x8(%rdx),%eax
   f: 85 c0                test   %eax,%eax
  11: 74 f7                je     0xa
  13: 48 8b 0a              mov    (%rdx),%rcx
[111872.261440] RSP: 0018:ffff8bd905cdb2f0 EFLAGS: 00010082
[111872.261442] RAX: ffffffff8a2c29f8 RBX: ffff89b1c0042b68 RCX:
0000000000003000
[111872.261443] RDX: ffff89b8cee306c0 RSI: 00000000c0042a68 RDI:
ffff89b1c0042b68
[111872.261444] RBP: ffff89b8cee306c0 R08: ffff89b8cee33470 R09:
0000000000000300
[111872.261445] R10: ffff89b1c0042b00 R11: ffff89b8cee33470 R12:
0000000000240000
[111872.261446] R13: 0000000000240000 R14: 0000000000000000 R15:
ffff89b8cee33470
[111872.261447] FS:  00007f1b020712c0(0000) GS:ffff89b8cee00000(0000)
knlGS:0000000000000000
[111872.261449] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[111872.261450] CR2: ffffffff8a2c29f8 CR3: 000000010338a000 CR4:
0000000000350ef0
[111872.261451] Call Trace:
[111872.261453]  <TASK>
[111872.261455] ? __die+0x52/0x93
[111872.261459] ? page_fault_oops+0xb2/0x230
[111872.261461] ? srso_return_thunk+0x5/0x5f
[111872.261463] ? search_bpf_extables+0x5b/0x80
[111872.261467] ? srso_return_thunk+0x5/0x5f
[111872.261470] ? exc_page_fault+0x313/0x7d0
[111872.261473] ? kfree+0x15f/0x3a0
[111872.261476] ? asm_exc_page_fault+0x22/0x30
[111872.261481] ? queued_spin_lock_slowpath+0x22b/0x265
[111872.261484] _raw_spin_lock_irqsave+0x2d/0x40
[111872.261486] rt_spin_lock+0x7d/0xd0
[111872.261488] ___slab_alloc+0x4a6/0xe20
WARNING! Cannot find .ko for module mlx5_core, please pass a valid module path
[111872.261492] ? mlx5e_open_channels+0x746/0x1070 mlx5_core
WARNING! Cannot find .ko for module mlx5_core, please pass a valid module path
[111872.261533] ? mlx5e_open_channels+0x746/0x1070 mlx5_core
[111872.261560] __kmalloc_node_noprof+0xdc/0x380
WARNING! Cannot find .ko for module mlx5_core, please pass a valid module path
[111872.261564] mlx5e_open_channels+0x746/0x1070 mlx5_core
WARNING! Cannot find .ko for module mlx5_core, please pass a valid module path
[111872.261594] ? __pfx_mlx5e_set_dev_port_mtu_ctx+0x10/0x10 mlx5_core
WARNING! Cannot find .ko for module mlx5_core, please pass a valid module path
[111872.261622] mlx5e_safe_switch_params+0x8a/0x120 mlx5_core
WARNING! Cannot find .ko for module mlx5_core, please pass a valid module path
[111872.261648] mlx5e_change_mtu+0x101/0x300 mlx5_core
WARNING! Cannot find .ko for module mlx5_core, please pass a valid module path
[111872.261675] ? __pfx_mlx5e_set_dev_port_mtu_ctx+0x10/0x10 mlx5_core
[111872.261708] dev_set_mtu_ext+0x101/0x210
[111872.261713] do_setlink.isra.0+0x210/0x11d0
[111872.261717] ? ___slab_alloc+0x26d/0xe20
[111872.261720] ? rtnl_newlink+0x46/0xc10
[111872.261722] ? srso_return_thunk+0x5/0x5f
[111872.261724] ? __nla_validate_parse+0x83/0xe00
[111872.261729] ? srso_return_thunk+0x5/0x5f
[111872.261730] ? security_capable+0x68/0xa0
[111872.261734] rtnl_newlink+0x6ce/0xc10
[111872.261738] ? srso_return_thunk+0x5/0x5f
[111872.261740] ? enqueue_dl_entity+0x373/0x5f0
[111872.261743] ? srso_return_thunk+0x5/0x5f
[111872.261745] ? enqueue_task_fair+0x240/0x400
[111872.261748] ? srso_return_thunk+0x5/0x5f
[111872.261749] ? __pfx_rtnl_newlink+0x10/0x10
[111872.261752] rtnetlink_rcv_msg+0x385/0x430
[111872.261754] ? srso_return_thunk+0x5/0x5f
[111872.261756] ? ___slab_alloc+0x26d/0xe20
[111872.261758] ? srso_return_thunk+0x5/0x5f
[111872.261759] ? kmalloc_reserve+0xc1/0x130
[111872.261762] ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[111872.261765] netlink_rcv_skb+0x4f/0x100
[111872.261770] netlink_unicast+0x24b/0x3a0
[111872.261773] netlink_sendmsg+0x1f1/0x450
[111872.261777] ____sys_sendmsg+0x2fc/0x330
[111872.261780] ? copy_msghdr_from_user+0xeb/0x180
[111872.261783] ___sys_sendmsg+0x8f/0xe0
[111872.261786] ? srso_return_thunk+0x5/0x5f
[111872.261788] ? srso_return_thunk+0x5/0x5f
[111872.261790] ? kfree+0x15f/0x3a0
[111872.261792] ? srso_return_thunk+0x5/0x5f
[111872.261794] ? srso_return_thunk+0x5/0x5f
[111872.261795] ? rt_spin_unlock+0x13/0x40
[111872.261798] ? srso_return_thunk+0x5/0x5f
[111872.261799] ? proc_sys_call_handler+0xf6/0x2d0
[111872.261802] ? srso_return_thunk+0x5/0x5f
[111872.261805] ? srso_return_thunk+0x5/0x5f
[111872.261807] __sys_sendmsg+0x88/0x100
[111872.261811] do_syscall_64+0x47/0x110
[111872.261815] entry_SYSCALL_64_after_hwframe+0x76/0x7e
[111872.261817] RIP: 0033:0x7f1b02f6aace
[111872.261819] Code: 20 89 54 24 1c 48 89 74 24 10 89 7c 24 08 e8 59
64 f7 ff 41 89 c0 b8 2e 00 00 00 8b 54 24 1c 48 8b 74 24 10 8b 7c 24
08 0f 05 <48> 3d 00 f0 ff ff 77 3a 44 89 c7 48 89 44 24 08 e8 ad 64 f7
ff 48
All code
========
   0: 20 89 54 24 1c 48    and    %cl,0x481c2454(%rcx)
   6: 89 74 24 10          mov    %esi,0x10(%rsp)
   a: 89 7c 24 08          mov    %edi,0x8(%rsp)
   e: e8 59 64 f7 ff        call   0xfffffffffff7646c
  13: 41 89 c0              mov    %eax,%r8d
  16: b8 2e 00 00 00        mov    $0x2e,%eax
  1b: 8b 54 24 1c          mov    0x1c(%rsp),%edx
  1f: 48 8b 74 24 10        mov    0x10(%rsp),%rsi
  24: 8b 7c 24 08          mov    0x8(%rsp),%edi
  28: 0f 05                syscall
  2a:* 48 3d 00 f0 ff ff    cmp    $0xfffffffffffff000,%rax <--
trapping instruction
  30: 77 3a                ja     0x6c
  32: 44 89 c7              mov    %r8d,%edi
  35: 48 89 44 24 08        mov    %rax,0x8(%rsp)
  3a: e8 ad 64 f7 ff        call   0xfffffffffff764ec
  3f: 48                    rex.W

Code starting with the faulting instruction
===========================================
   0: 48 3d 00 f0 ff ff    cmp    $0xfffffffffffff000,%rax
   6: 77 3a                ja     0x42
   8: 44 89 c7              mov    %r8d,%edi
   b: 48 89 44 24 08        mov    %rax,0x8(%rsp)
  10: e8 ad 64 f7 ff        call   0xfffffffffff764c2
  15: 48                    rex.W
[111872.261821] RSP: 002b:00007ffdc6aba270 EFLAGS: 00000293 ORIG_RAX:
000000000000002e
[111872.261823] RAX: ffffffffffffffda RBX: 000055bd7e6c9ea0 RCX:
00007f1b02f6aace
[111872.261824] RDX: 0000000000000000 RSI: 00007ffdc6aba2c0 RDI:
000000000000000d
[111872.261825] RBP: 00007ffdc6aba2c0 R08: 0000000000000000 R09:
0000000000000000
[111872.261826] R10: 0000000000000000 R11: 0000000000000293 R12:
000055bd7e6c9ea0
[111872.261827] R13: 0000000000000000 R14: 00007ffdc6aba4b8 R15:
0000000000000000
[111872.261830]  </TASK>
[111872.261831] Modules linked in: cifs cifs_arc4 nls_ucs2_utils
cifs_md4 netfs mlx5_ib chaoskey amdgpu amdxcp mfd_core drm_ttm_helper
ttm drm_exec gpu_sched drm_suballoc_helper drm_buddy
drm_display_helper mlx5_core sp5100_tco ccp i2c_dev rpcrdma ib_ipoib
[111872.261847] CR2: ffffffff8a2c29f8
[111872.261850] ---[ end trace 0000000000000000 ]---
[111872.261851] RIP: queued_spin_lock_slowpath+0x22b/0x265
[111872.261853] Code: ff f3 90 48 8b 0a 48 85 c9 74 f6 eb d6 c1 e9 12
83 e0 03 ff c9 48 c1 e0 04 48 63 c9 48 05 c0 06 03 00 48 03 04 cd e0
cb 27 8a <48> 89 10 8b 42 08 85 c0 75 09 f3 90 8b 42 08 85 c0 74 f7 48
8b 0a
All code
========
   0: ff f3                push   %rbx
   2: 90                    nop
   3: 48 8b 0a              mov    (%rdx),%rcx
   6: 48 85 c9              test   %rcx,%rcx
   9: 74 f6                je     0x1
   b: eb d6                jmp    0xffffffffffffffe3
   d: c1 e9 12              shr    $0x12,%ecx
  10: 83 e0 03              and    $0x3,%eax
  13: ff c9                dec    %ecx
  15: 48 c1 e0 04          shl    $0x4,%rax
  19: 48 63 c9              movslq %ecx,%rcx
  1c: 48 05 c0 06 03 00    add    $0x306c0,%rax
  22: 48 03 04 cd e0 cb 27 add    -0x75d83420(,%rcx,8),%rax
  29: 8a
  2a:* 48 89 10              mov    %rdx,(%rax) <-- trapping instruction
  2d: 8b 42 08              mov    0x8(%rdx),%eax
  30: 85 c0                test   %eax,%eax
  32: 75 09                jne    0x3d
  34: f3 90                pause
  36: 8b 42 08              mov    0x8(%rdx),%eax
  39: 85 c0                test   %eax,%eax
  3b: 74 f7                je     0x34
  3d: 48 8b 0a              mov    (%rdx),%rcx

Code starting with the faulting instruction
===========================================
   0: 48 89 10              mov    %rdx,(%rax)
   3: 8b 42 08              mov    0x8(%rdx),%eax
   6: 85 c0                test   %eax,%eax
   8: 75 09                jne    0x13
   a: f3 90                pause
   c: 8b 42 08              mov    0x8(%rdx),%eax
   f: 85 c0                test   %eax,%eax
  11: 74 f7                je     0xa
  13: 48 8b 0a              mov    (%rdx),%rcx
[111872.261854] RSP: 0018:ffff8bd905cdb2f0 EFLAGS: 00010082
[111872.261856] RAX: ffffffff8a2c29f8 RBX: ffff89b1c0042b68 RCX:
0000000000003000
[111872.261857] RDX: ffff89b8cee306c0 RSI: 00000000c0042a68 RDI:
ffff89b1c0042b68
[111872.261858] RBP: ffff89b8cee306c0 R08: ffff89b8cee33470 R09:
0000000000000300
[111872.261859] R10: ffff89b1c0042b00 R11: ffff89b8cee33470 R12:
0000000000240000
[111872.261860] R13: 0000000000240000 R14: 0000000000000000 R15:
ffff89b8cee33470
[111872.261861] FS:  00007f1b020712c0(0000) GS:ffff89b8cee00000(0000)
knlGS:0000000000000000
[111872.261862] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[111872.261863] CR2: ffffffff8a2c29f8 CR3: 000000010338a000 CR4:
0000000000350ef0
[111872.261865] note: NetworkManager[6566] exited with irqs disabled
[111872.261871] note: NetworkManager[6566] exited with preempt_count 1

