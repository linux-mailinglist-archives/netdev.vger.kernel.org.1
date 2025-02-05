Return-Path: <netdev+bounces-162948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF37FA2899F
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 12:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ADE93A1F83
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 11:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D6321ADC3;
	Wed,  5 Feb 2025 11:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCYzFxz4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836D5151988
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 11:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738755846; cv=none; b=nIUbFdmyaVUxnJVEGeSpP1IvXhNOaJdc2oXVoMb+QeW0XlcoyG8jdJuE+Q0uB7+l9LFFGQWmcMz4isFSBhtE/Srupf5AyuLTCLLNibexu594ZnGRvg1IkL3Mq4AoV+RL0smEXbUY37gIly/dk9ou8NFXFu86JcGu+vxPBOmPyJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738755846; c=relaxed/simple;
	bh=gisfmmMbfzkMzuj02GGONnByJW94+hEYhnSJ7RIJoRo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ZR+UMBxG91giXWpqSuONNrd0MXqxsvGQcer0f6rOGh5sAoGq6b5S6yE3bX8G6JSQ6M9LynwYueImFt4sUf4hMIGbLRwJE2FIRpJ49NZQxZzT8OAcH3WdXq20ZBz3c+yij+WzXLuRJrzKot+GzhILy5FL4pmnn2kTq/Nv1ne9QTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCYzFxz4; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4b68cb2abacso1626085137.3
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 03:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738755843; x=1739360643; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=30s/cMWiiPQhu+giYkHsZesonBUjyhrhAHCe0xu5mfM=;
        b=dCYzFxz4P9qymAaNHdY8pruiPtm4GwhP9+l8Wb661Dc5VJJRXAfsQ5OGZjzrOyxfu9
         d1L39G1OEsOFHcI0r1h3uIjDWtEw9/hfPii7NcAgJ2mc3HR8pfQCGfbqcEmzFE3OzGyz
         k6W8N6FBs6n2IThOSyci2f6G8yecXKyZcjY93Q2+/86+ndhKbkpHvWtEdraj/bWW5GUZ
         UL0EM9HksjYaFBCb8/bAJwWXGgXKJFC7i+XhfJSKKyiItVmtM30O39bDfKFZR93kPkPJ
         DeoOQgqAjtTc35ZZEctr6wHCzZFlNVbK3IZiZ2I0o5Q/j5p66BWs2aDZEwJKvEla4Gpt
         Hnkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738755843; x=1739360643;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=30s/cMWiiPQhu+giYkHsZesonBUjyhrhAHCe0xu5mfM=;
        b=WYz8dwSdg/FKFistpq+YH82rm0nxgpf+nndzO7qMN6kkrzrFpC47irOFyazxXZvyZv
         dPzR+J9inZoMSuFebqCnYOl7Wm1VyIq/QzXm/t67PnHagbFZYRG1B0mgjDgBWiZ0U2ex
         +IdFxEDwj6yX2ls47Bf3NModIoGRLucvye5BsK1eRlPb7oMTFEGU9iZyPlLQx7fmssuP
         2VuRd3vgm1CaaJBRcwstgtgrxBDXErlrgEVFRuFeVdWCik1B11kt4lF2xEBy6t3A6ruq
         7K2sraeRH7ffkfRI+GY82oAnb+4Flt447lKtKOrST6UxNMZB3lXdKkA+qw4BOFAOsGew
         revw==
X-Gm-Message-State: AOJu0YzOEO5PsHG+Zg1PaodeCvqghbGEn/FIW+1BI0WyTg43LW838WvI
	FjKIAK0LLATxt+jH6DtSWbxQTUTIQzs6pAltJrlwm/sxLgX7YMBNIneZ8erz2tvPSObmO6QWzXo
	16JOxh+eHmVhY4N7gyuwqN2tTLP6GSPuUCqM=
X-Gm-Gg: ASbGncuWzYFM+FqYFvRzCPmZRaLIEkKTlwiovhVtoAknopfdIVFJwwzhn9tcce0wq3b
	vfGxqy9NgzIgaCfAWIhRi5J24OnMdOAABtpYEwIpoA0gY4IJ29GXPwmeTYaYRHBCSMN+Oohw=
X-Google-Smtp-Source: AGHT+IHO9pPOBI1kcolTZ/Oeu6bGEJjEK+YjNEXkvGUC4DT6RAigKrO3BhE0mo+8lCitUUlne8gYWXT2UaRqiAQ4JnI=
X-Received: by 2002:a05:6102:2ac2:b0:4af:ea3b:7b31 with SMTP id
 ada2fe7eead31-4ba478e7ae1mr1154572137.14.1738755842769; Wed, 05 Feb 2025
 03:44:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ian Kumlien <ian.kumlien@gmail.com>
Date: Wed, 5 Feb 2025 12:43:50 +0100
X-Gm-Features: AWEUYZlgPCRSFHct9129zAMk1clO5pnZpvsJOnNFUZBJqF54cUGLj_ZOGrzROtA
Message-ID: <CAA85sZvZ4Nuz6yk2ditVGoS0c2wcKU=MwUzOUoC2QT3_hjQ6FQ@mail.gmail.com>
Subject: Bug when trying to use a old mellanox connextx-3 pro
To: Linux Kernel Network Developers <netdev@vger.kernel.org>
Cc: tariqt@nvidia.com, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

Was thinking of switching my firewall from gigabit networking to
10gbit, and connectx-3 pro seemed like a ok fit
(very cheap and works with a pcie x4 slot)

Anyway, booting using that interface results in a kernel oops after
just a few seconds...

I assume it could be related to this being enabled by default:
ethtool -k enp2s0 |grep rx-gro-list
rx-gro-list: on

I have had similar issues with gro-lists when playing with tun/tap
devices (haven't had the time to debug it yet though)
(Which is why I included you Paolo, it could however be completely unrelated)

Anyway, here is the kernel oops

<4>[   34.088397] ------------[ cut here ]------------
<2>[   34.088406] kernel BUG at ./include/linux/skbuff.h:2773!
<4>[   34.088422] Oops: invalid opcode: 0000 [#1] PREEMPT_RT SMP NOPTI
<4>[   34.088433] CPU: 11 UID: 0 PID: 2404 Comm: irq/108-mlx4-8@ Not
tainted 6.13.1 #441
<4>[   34.088442] Hardware name: Supermicro Super
Server/A2SDi-12C-HLN4F, BIOS 1.9a 12/25/2023


<4>[ 34.088446] RIP: 0010:skb_pull (./include/linux/skbuff.h:2773
./include/linux/skbuff.h:2780 net/core/skbuff.c:2653)
<4>[ 34.088461] Code: 39 f0 72 1f 29 f0 89 47 70 3b 47 74 72 1c 89 f0
48 03 87 d0 00 00 00 48 89 87 d0 00 00 00 c3 cc cc cc cc 31 c0 c3 cc
cc cc cc <0f> 0b 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 41
57 41
All code
========
   0: 39 f0                cmp    %esi,%eax
   2: 72 1f                jb     0x23
   4: 29 f0                sub    %esi,%eax
   6: 89 47 70              mov    %eax,0x70(%rdi)
   9: 3b 47 74              cmp    0x74(%rdi),%eax
   c: 72 1c                jb     0x2a
   e: 89 f0                mov    %esi,%eax
  10: 48 03 87 d0 00 00 00 add    0xd0(%rdi),%rax
  17: 48 89 87 d0 00 00 00 mov    %rax,0xd0(%rdi)
  1e: c3                    ret
  1f: cc                    int3
  20: cc                    int3
  21: cc                    int3
  22: cc                    int3
  23: 31 c0                xor    %eax,%eax
  25: c3                    ret
  26: cc                    int3
  27: cc                    int3
  28: cc                    int3
  29: cc                    int3
  2a:* 0f 0b                ud2 <-- trapping instruction
  2c: 90                    nop
  2d: 90                    nop
  2e: 90                    nop
  2f: 90                    nop
  30: 90                    nop
  31: 90                    nop
  32: 90                    nop
  33: 90                    nop
  34: 90                    nop
  35: 90                    nop
  36: 90                    nop
  37: 90                    nop
  38: 90                    nop
  39: 90                    nop
  3a: 90                    nop
  3b: 90                    nop
  3c: 90                    nop
  3d: 41 57                push   %r15
  3f: 41                    rex.B

Code starting with the faulting instruction
===========================================
   0: 0f 0b                ud2
   2: 90                    nop
   3: 90                    nop
   4: 90                    nop
   5: 90                    nop
   6: 90                    nop
   7: 90                    nop
   8: 90                    nop
   9: 90                    nop
   a: 90                    nop
   b: 90                    nop
   c: 90                    nop
   d: 90                    nop
   e: 90                    nop
   f: 90                    nop
  10: 90                    nop
  11: 90                    nop
  12: 90                    nop
  13: 41 57                push   %r15
  15: 41                    rex.B
<4>[   34.088468] RSP: 0018:ffffa047c1c67a78 EFLAGS: 00010297
<4>[   34.088476] RAX: 0000000000000578 RBX: ffff94c1070d7400 RCX:
0000000000000000
<4>[   34.088481] RDX: ffff94c105152400 RSI: 0000000000000034 RDI:
ffff94c1039f6f00
<4>[   34.088485] RBP: ffff94c1039f6f00 R08: 0000000000000000 R09:
0000000000000000
<4>[   34.088489] R10: 0000000000000000 R11: 0000000000000001 R12:
ffff94c1039f6f00
<4>[   34.088493] R13: 000000000e041080 R14: 0000000000000578 R15:
0000000000000578
<4>[   34.088498] FS:  0000000000000000(0000)
GS:ffff94c46fcc0000(0000) knlGS:0000000000000000
<4>[   34.088504] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[   34.088509] CR2: 0000562f4233b000 CR3: 000000010596e000 CR4:
00000000003526f0
<4>[   34.088514] Call Trace:
<4>[   34.088519]  <TASK>
<4>[ 34.088523] ? __die (arch/x86/kernel/dumpstack.c:421
arch/x86/kernel/dumpstack.c:434)
<4>[ 34.088534] ? die (arch/x86/kernel/dumpstack.c:449)
<4>[ 34.088541] ? do_trap (arch/x86/kernel/traps.c:156
arch/x86/kernel/traps.c:197)
<4>[ 34.088553] ? do_error_trap (./arch/x86/include/asm/traps.h:58
arch/x86/kernel/traps.c:218)
<4>[ 34.088562] ? skb_pull (./include/linux/skbuff.h:2773
./include/linux/skbuff.h:2780 net/core/skbuff.c:2653)
<4>[ 34.088570] ? exc_invalid_op (arch/x86/kernel/traps.c:316)
<4>[ 34.088578] ? skb_pull (./include/linux/skbuff.h:2773
./include/linux/skbuff.h:2780 net/core/skbuff.c:2653)
<4>[ 34.088585] ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:621)
<4>[ 34.088597] ? skb_pull (./include/linux/skbuff.h:2773
./include/linux/skbuff.h:2780 net/core/skbuff.c:2653)
<4>[ 34.088605] skb_gro_receive_list (net/core/gro.c:242)
<4>[ 34.088614] tcp_gro_receive (./include/linux/skbuff.h:1670
./include/linux/skbuff.h:5049 net/ipv4/tcp_offload.c:371)
<4>[ 34.088626] inet_gro_receive (./include/net/gro.h:367
(discriminator 1) net/ipv4/af_inet.c:1545 (discriminator 1))
<4>[ 34.088637] dev_gro_receive (net/core/gro.c:516 (discriminator 4))
<4>[ 34.088645] ? __napi_build_skb (net/core/skbuff.c:545)
<4>[ 34.088655] napi_gro_frags (net/core/gro.c:765)
<4>[ 34.088661] mlx4_en_process_rx_cq
(drivers/net/ethernet/mellanox/mlx4/en_rx.c:955)
<4>[ 34.088671] ? mlx4_en_free_tx_desc
(drivers/net/ethernet/mellanox/mlx4/en_tx.c:339 (discriminator 1))
<4>[ 34.088682] mlx4_en_poll_rx_cq
(drivers/net/ethernet/mellanox/mlx4/en_rx.c:1021)
<4>[ 34.088690] __napi_poll.constprop.0 (net/core/dev.c:6902)
<4>[ 34.088700] net_rx_action (net/core/dev.c:6973 net/core/dev.c:7093)
<4>[ 34.088709] ? asm_common_interrupt (./arch/x86/include/asm/idtentry.h:693)
<4>[ 34.088718] ? mlx4_cq_completion
(drivers/net/ethernet/mellanox/mlx4/cq.c:113)
<4>[ 34.088729] ? __napi_schedule (net/core/dev.c:4577
net/core/dev.c:4545 net/core/dev.c:6198)
<4>[ 34.088737] ? mlx4_eq_int (drivers/net/ethernet/mellanox/mlx4/eq.c:523)
<4>[ 34.088743] ? update_curr_rt (kernel/sched/rt.c:997)
<4>[ 34.088751] handle_softirqs.isra.0
(./arch/x86/include/asm/jump_label.h:36
./include/trace/events/irq.h:142 kernel/softirq.c:562)
<4>[ 34.088764] __local_bh_enable_ip (kernel/softirq.c:246)
<4>[ 34.088770] irq_forced_thread_fn (kernel/irq/manage.c:1207)
<4>[ 34.088782] irq_thread (kernel/irq/manage.c:1325)
<4>[ 34.088791] ? __pfx_irq_forced_thread_fn (kernel/irq/manage.c:1192)
<4>[ 34.088802] ? __pfx_irq_thread_dtor (kernel/irq/manage.c:1234)
<4>[ 34.088812] ? __pfx_irq_thread (kernel/irq/manage.c:1301)
<4>[ 34.088821] kthread (kernel/kthread.c:389)
<4>[ 34.088830] ? __pfx_kthread (kernel/kthread.c:342)
<4>[ 34.088838] ret_from_fork (arch/x86/kernel/process.c:153)
<4>[ 34.088849] ? __pfx_kthread (kernel/kthread.c:342)
<4>[ 34.088857] ret_from_fork_asm (arch/x86/entry/entry_64.S:254)
<4>[   34.088870]  </TASK>
<4>[   34.088873] Modules linked in: chaoskey
<4>[   34.088885] ---[ end trace 0000000000000000 ]---

