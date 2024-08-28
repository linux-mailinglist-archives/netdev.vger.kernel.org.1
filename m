Return-Path: <netdev+bounces-122988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4570F963648
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 01:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDA30281790
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 23:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E0D1B1516;
	Wed, 28 Aug 2024 23:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="qvAOAJT9";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="vhBBhJxX"
X-Original-To: netdev@vger.kernel.org
Received: from mx2.ucr.edu (mx.ucr.edu [138.23.62.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9472B1B1507
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 23:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724888353; cv=none; b=qjozcjYsVQXJO1YT/Ayhww0oWOj9RWiIKxndpO0T82oXkn7JCx9JUvWRqKsu0gzgDJEnH78vjeUvvOYQoo312OdMU/F5lPEmeQLXUZheHZHwvAtO8wuI5rrMXi80w5fHG4R4ONZ8Y2HXoq26AmvPEx1GYGDfOFledQgHZQ8xHkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724888353; c=relaxed/simple;
	bh=ure7jQOxTtBQdZR6CneH3rC55w6S4PteO1J4K7AKm2E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=sWsODuxhbbfO0uSbiC3hJH4vXTZD5XQ9H0dfhYIuLYe2tORy1aVDdi8xw96fAXmgTiQPLPbzzmUyD+5TvNILKxCk5A4eT/r2F/LDuxGc8UhYA83ExV5pI2COWkwEPLm+THzAAA0ggxsVf7Lmm4WKFkxwDNG9XMbyib1x5Whsw2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=qvAOAJT9; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=vhBBhJxX; arc=none smtp.client-ip=138.23.62.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724888350; x=1756424350;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:cc:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=ure7jQOxTtBQdZR6CneH3rC55w6S4PteO1J4K7AKm2E=;
  b=qvAOAJT9FuaT+X8g0vzOZcGbPUGSr6Oyb4Ik0Gkqplh8KPtpUfg19MuI
   wvptU4e16J7ULMfuzifiOyfbG3FMUhIpkpwh8bH978LdH1OFCkBuQnwhl
   zHR2ph/zTIedJnpDzMlhJ9xwsC1AdPFojPktrYNnQ3qW2FVptPyfrLSbe
   kU0uOQFNfXotO6tyVe7faqqIISXLqH58lou66SXY01jmkDARU5jiY9XB9
   Wa6y7Ys2YXsA7fFtlmgtnONLqHABJHlV1eqWA3vP+8cyfeglc8TD2L+Pw
   pNMySlPp4MoQqrmW7/HHcrN48JkxZqzNgRam1AHXXlOGDgkWgivMz/MaE
   g==;
X-CSE-ConnectionGUID: zI6cRyosS02S1FT0CqhG5g==
X-CSE-MsgGUID: 3U5D+qXhTWq3dBHmjYsEmA==
Received: from mail-il1-f199.google.com ([209.85.166.199])
  by smtp2.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 16:39:09 -0700
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d2dee9722so186805ab.0
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 16:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724888350; x=1725493150; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jREoq/9wIhH0GEi0zCX+sEzYBPR2LET91TBlkmE5cYk=;
        b=vhBBhJxX5irVUvAoRgQ8UAfeVN0X1ezzOShA/PkI5oe/VIHOONm84cM8L60HFkzrfx
         xHONbbVLLiW/Yeesuw+jSjPvJLoL1EY/3ZgfbHjLo498iLwY3V5Xoyec4gMcihVh5JYf
         MMJx9X3dDA9ITshkiyaVcft+qpwU+6fM1uJlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724888350; x=1725493150;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jREoq/9wIhH0GEi0zCX+sEzYBPR2LET91TBlkmE5cYk=;
        b=DQR+1ZASNg8j2Vu1Ry5v3x2iFnFFPXXNxU5qTFLul6lif1Ghdmi2GfehOKmMMNzeUh
         lNzRx0lRUrke8a37gu1+Tg053Z6XH2GbI/LBbzYUDXBxb3wK2myxaql6vJghBlvbquqs
         p7/de15u7b/jVpzMScDMB6MFBdWPRIYbaFL0lDOHj3EDLqPhLe+4J5WHhLOsGsakYhKu
         74mq8is7pIJ0mViNI50Q+EhNr5HWBJahPaJSFVm864Pk5f8eX7jiUktrFgwDh9PW5m4L
         Tw5NU18/3Kh40zRduJCb7e1k/+/yVevwvQYy2tn2gw9LjE77ZNgaVQfaTgDnj1JJcZmK
         tfNA==
X-Forwarded-Encrypted: i=1; AJvYcCWzX8Wu2LHoZFewT6wwUIkA2LkSjyPIYzoqPZ6BXfXz7BU3mjx4B9EuthBSfEQQWWKZqmauPMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNyasirmiCbbkA7UlsPQ/19ITIwn6H4pRetxc5dWxx6Da8lUxo
	kNzx+2OvjLs7YDwx9ZN37hizkJcA3G6NyDYdNsPOpDYraiwoSAt+zLOb6u0Me1LBAPeoh2WIHxf
	bQ14CF7BBiTLV+Lalpo5doXWzJeuGMaAK9EpL26KI3KDo8nyNciVBkKwE3fmFg9jN5NL62OMQnS
	aEv2+ziLKyo4rxuwt7vL1StD4Rs79ANU1yOy75ObHyAFM=
X-Received: by 2002:a92:c565:0:b0:39a:e984:1caa with SMTP id e9e14a558f8ab-39f3784f79dmr16058885ab.21.1724888349765;
        Wed, 28 Aug 2024 16:39:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtqJDTCrQ0tvJc4HXl0HIj4UIR/CMwsG9r7cZO0/xZrZ46wrKe9DbU7OIE8dSPcARoGUFC70wZdQgjBwfLYDU=
X-Received: by 2002:a92:c565:0:b0:39a:e984:1caa with SMTP id
 e9e14a558f8ab-39f3784f79dmr16058715ab.21.1724888349452; Wed, 28 Aug 2024
 16:39:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 16:38:59 -0700
Message-ID: <CALAgD-41QZdm=Sj2N4QyYyeNY1EMq6DKY+q7647-53ysZEs8ZQ@mail.gmail.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in sock_def_readable
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, willemb@google.com, kuniyu@amazon.com, 
	wuyun.abel@bytedance.com, quic_abchauha@quicinc.com, gouhao@uniontech.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"

Hi,

We found a bug in Linux 6.10 using syzkaller. It is possibly a null
pointer dereference  bug.
The bug report is as follows, but unfortunately there is no generated
syzkaller reproducer.

Bug report:

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 0 P4D 0
Oops: Oops: 0010 [#1] PREEMPT SMP KASAN PTI
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc90000006af8 EFLAGS: 00010046
RAX: 1ffff92001572f0a RBX: 0000000000000000 RCX: 00000000000000c3
RDX: 0000000000000010 RSI: 0000000000000001 RDI: ffffc9000ab97840
RBP: 0000000000000001 R08: 0000000000000003 R09: fffff52000000d3c
R10: dffffc0000000000 R11: 0000000000000000 R12: ffffc9000ab97850
R13: 0000000000000000 R14: ffffc9000ab97840 R15: ffff88802dfb3680
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000000d932000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 __wake_up_common kernel/sched/wait.c:89 [inline]
 __wake_up_common_lock+0x134/0x1e0 kernel/sched/wait.c:106
 sock_def_readable+0x167/0x380 net/core/sock.c:3353
 tcp_data_queue+0x215c/0x7790 net/ipv4/tcp_input.c:5267
 tcp_rcv_established+0xe3e/0x1ba0 net/ipv4/tcp_input.c:6210
 tcp_v4_do_rcv+0x94a/0xc40 net/ipv4/tcp_ipv4.c:1909
 tcp_v4_rcv+0x2d45/0x3750 net/ipv4/tcp_ipv4.c:2345
 ip_protocol_deliver_rcu+0x221/0x430 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x321/0x5e0 net/ipv4/ip_input.c:233
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ip_local_deliver net/ipv4/ip_input.c:254 [inline]
 dst_input include/net/dst.h:460 [inline]
 ip_sublist_rcv_finish+0x3ef/0x520 net/ipv4/ip_input.c:580
 ip_list_rcv_finish net/ipv4/ip_input.c:631 [inline]
 ip_sublist_rcv+0x703/0x750 net/ipv4/ip_input.c:639
 ip_list_rcv+0x42a/0x470 net/ipv4/ip_input.c:674
 __netif_receive_skb_list_ptype net/core/dev.c:5668 [inline]
 __netif_receive_skb_list_core+0x988/0x9c0 net/core/dev.c:5716
 __netif_receive_skb_list+0x436/0x4d0 net/core/dev.c:5768
 netif_receive_skb_list_internal+0x5dd/0x950 net/core/dev.c:5860
 gro_normal_list include/net/gro.h:515 [inline]
 napi_complete_done+0x2f9/0x8b0 net/core/dev.c:6203
 e1000_clean+0xf5e/0x3bf0 drivers/net/ethernet/intel/e1000/e1000_main.c:3809
 __napi_poll+0xcc/0x480 net/core/dev.c:6722
 napi_poll net/core/dev.c:6791 [inline]
 net_rx_action+0x7ed/0x1040 net/core/dev.c:6907
 handle_softirqs+0x272/0x750 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf0/0x1b0 kernel/softirq.c:637
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
 common_interrupt+0xa4/0xc0 arch/x86/kernel/irq.c:278
 </IRQ>
 <TASK>
 asm_common_interrupt+0x22/0x40 arch/x86/include/asm/idtentry.h:693
RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:72 [inline]
RIP: 0010:default_idle+0xb/0x10 arch/x86/kernel/process.c:743
Code: 07 76 e7 48 89 07 49 c7 c0 08 00 00 00 4d 29 c8 4c 01 c7 4c 29
c2 e9 72 ff ff ff cc cc cc cc 66 90 0f 00 2d c7 a4 4e 00 fb f4 <fa> c3
0f 1f 00 e9 eb ff ff ff 66 2e 0f 1f 84 00 00 00 00 00 90 65
RSP: 0018:ffffffff8d807d68 EFLAGS: 000002c2
RAX: fc297babf4643600 RBX: ffffffff816928eb RCX: 000000000000d851
RDX: 0000000000000001 RSI: ffffffff8b4c89c0 RDI: ffffffff8ba956e0
RBP: ffffffff8d807eb8 R08: ffff888063a37d0b R09: 1ffff1100c746fa1
R10: dffffc0000000000 R11: ffffed100c746fa2 R12: 1ffffffff1b00fc6
R13: 1ffffffff1b12778 R14: 0000000000000000 R15: dffffc0000000000
 default_idle_call+0x6e/0xa0 kernel/sched/idle.c:117
 cpuidle_idle_call kernel/sched/idle.c:191 [inline]
 do_idle+0x22b/0x5c0 kernel/sched/idle.c:332
 cpu_startup_entry+0x3d/0x60 kernel/sched/idle.c:430
 rest_init+0x2db/0x300 init/main.c:747
 start_kernel+0x486/0x500 init/main.c:1103
 x86_64_start_reservations+0x26/0x30 arch/x86/kernel/head64.c:507
 x86_64_start_kernel+0x5c/0x60 arch/x86/kernel/head64.c:488
 common_startup_64+0x13e/0x147
 </TASK>
Modules linked in:
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc90000006af8 EFLAGS: 00010046
RAX: 1ffff92001572f0a RBX: 0000000000000000 RCX: 00000000000000c3
RDX: 0000000000000010 RSI: 0000000000000001 RDI: ffffc9000ab97840
RBP: 0000000000000001 R08: 0000000000000003 R09: fffff52000000d3c
R10: dffffc0000000000 R11: 0000000000000000 R12: ffffc9000ab97850
R13: 0000000000000000 R14: ffffc9000ab97840 R15: ffff88802dfb3680
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000000d932000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0: 76 e7                 jbe    0xffffffe9
   2: 48 89 07             mov    %rax,(%rdi)
   5: 49 c7 c0 08 00 00 00 mov    $0x8,%r8
   c: 4d 29 c8             sub    %r9,%r8
   f: 4c 01 c7             add    %r8,%rdi
  12: 4c 29 c2             sub    %r8,%rdx
  15: e9 72 ff ff ff       jmp    0xffffff8c
  1a: cc                   int3
  1b: cc                   int3
  1c: cc                   int3
  1d: cc                   int3
  1e: 66 90                 xchg   %ax,%ax
  20: 0f 00 2d c7 a4 4e 00 verw   0x4ea4c7(%rip)        # 0x4ea4ee
  27: fb                   sti
  28: f4                   hlt
* 29: fa                   cli <-- trapping instruction
  2a: c3                   ret
  2b: 0f 1f 00             nopl   (%rax)
  2e: e9 eb ff ff ff       jmp    0x1e
  33: 66 2e 0f 1f 84 00 00 cs nopw 0x0(%rax,%rax,1)
  3a: 00 00 00
  3d: 90                   nop
  3e: 65                   gs

-- 
Yours sincerely,
Xingyu

