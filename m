Return-Path: <netdev+bounces-129577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 621AC984972
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 18:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5D461F23C82
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 16:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A63E1AAE24;
	Tue, 24 Sep 2024 16:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IExcaS8z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28820D531
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727194811; cv=none; b=ohVshE2RQDPFTI3i2oVtkY7utS0QvafoqwvJBRCCnt/L7ES9b7TziVDRggziomvmTtHVYZ76Pofl65eUg5VD0aLJSA7yX3lVs/VXe0viCkVEVm96zzXvYyBQASlKaFzySFxjromRUO7tVDNb7ueBfZGZAj17zDkigJzZU+QAxPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727194811; c=relaxed/simple;
	bh=cgB30COn9M0dpL4592SovCPiymlKb1y+pJV+Py7036o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=TnHm4zBK4VBb49eJ1zAg3O5sHHXTpt9PBXtOdk+yOpbmKLOowr/PBLMPLv3ms+1DdY6DTCg0v9YBQjiMh0j4BPxY7YfO9I89ruf7dCDsJbPEdLrb2VlzoDtTZDdYrfa6XDz3qw3rizUEyQY2IoVv3EwdwETtow4upEcKz1m6314=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IExcaS8z; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5366fd6fdf1so2047222e87.0
        for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 09:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727194808; x=1727799608; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WrF75twNwKK+vb8CF+UvK37E1Knvzk4NjudAF12Blmg=;
        b=IExcaS8z2JsjRnXWrNFWxO0V+dGAdudbIQ9q/6xNNkww6vy90yWT8n7WDsGbs2Dn65
         l0kQnLB0T5ba2RoPgnAgDPY32OVngfkFlNHfb3Kh/EUz1wyJF2DJ++sgrnYkksifjF8m
         o9B4V08buunC0rhwHpvNKS6H+wSU9ibfvuP/dfn+pWGmxJIAo9S58czhl+rKs/odIdER
         mwqaGw9f9sm17WQo/4C/zpPlhPgcU/5V/fWVC3NS8ZjsNAyZ5zbboK/BHUf7UTC7IqQ/
         7oPkYYEGBa8EYXR6UvvBi5tjUPp95moJiK3b+doKbUxQbZSc3tSbjXwCp1QDJRobOWT0
         7ihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727194808; x=1727799608;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WrF75twNwKK+vb8CF+UvK37E1Knvzk4NjudAF12Blmg=;
        b=M/1bqRd395DVmPb12QVRA3JKXPisiwpoqQotWf5MF++4afo2qCENpvCNshyIzWVYhX
         ubkL/IwYFnU3o8uEJbDD8KkOhQLqrnFr+84c/WEugxkc7tZeZBowAUKt7W0hniv7jEhj
         MBamggIhuNwutTFevjmqgnTFMUN9p3KgofL+HHPWWISzP/yP8S+/Ego9gWdIyHsVLH9U
         9PoOQ2iBrv1aYQH4u3Y8lkU0dMv/7WdgGZsbTjhGvsU6wgX9PtduPA0ad05ntE7hqMz9
         Z8WnyMPkRCI+F/Es34bN5QSClUsIYEvr/VQJ0tTZGBwKaN++NDyfFAiUZNWqWEEtmJpF
         p9FQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnYYFeH/XWLMQKYfX0zwqZiCWsyNbRuR1tMgERIlzyYFOWGSuYdKZmcMc2wG2qHHc/oOKObCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL9vMLeF0EtTZfFEryKOx6qZcJzZPknoX/f80kmB4G52tIPNp9
	ma6p9AQY6Mp8/Y6HE4XNtCYwUjhElZn0EoBksLvFQoUw5JmePUGIh2kcqW5al5JIsAgHvi/Sx7A
	H+xz2TvvlsMpIeNqgTB2JrCkvggIf6fn0ccHY7A==
X-Google-Smtp-Source: AGHT+IGgibFaugJV46yT2cw5kp5D6IEjZ3UVXAlmeOoV90p+8AT9WABWGaYKMIwBH4AwvEdQjX6EaZDNa1WpIfjORDg=
X-Received: by 2002:a05:6512:3c8c:b0:52e:fa6b:e54a with SMTP id
 2adb3069b0e04-536ad18183emr7963986e87.30.1727194807892; Tue, 24 Sep 2024
 09:20:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: reveliofuzzing <reveliofuzzing@gmail.com>
Date: Tue, 24 Sep 2024 12:19:57 -0400
Message-ID: <CA+-ZZ_g+VqQn6-SQoRgh8u4TBw1uNTy46wjOcAuyniBM6JUYzg@mail.gmail.com>
Subject: Report "BUG: unable to handle kernel NULL pointer dereference in ip6_sublist_rcv_finish"
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

We found the following crash when fuzzing^1 the Linux kernel 6.10 and
we are able
to reproduce it. To our knowledge, this crash has not been observed by SyzBot so
we would like to report it for your reference.

- Crash
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 800000000ff97067 P4D 800000000ff97067 PUD 8944067 PMD 0
Oops: Oops: 0010 [#1] PREEMPT SMP KASAN PTI
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.10.0 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffff88806d209728 EFLAGS: 00010246
RAX: ffffffff84e14440 RBX: ffff88806d2097e8 RCX: 1ffff11001879283
RDX: 0000000000000000 RSI: ffffffff837b2033 RDI: ffff88800c3c93c0
RBP: ffff88800c3c93c0 R08: 0000000000000001 R09: ffff88800c3c93c0
R10: ffff88800c3c93e8 R11: ffff88800c3c949f R12: dffffc0000000000
R13: 0000000000000000 R14: ffff88806d2097e8 R15: ffff88806d2097e8
FS:  0000000000000000(0000) GS:ffff88806d200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000000fea4006 CR4: 0000000000170ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 dst_input linux-6.10/include/net/dst.h:460 [inline]
 ip6_sublist_rcv_finish+0x179/0x1f0 linux-6.10/net/ipv6/ip6_input.c:88
 ip6_list_rcv_finish linux-6.10/net/ipv6/ip6_input.c:146 [inline]
 ip6_sublist_rcv+0x55e/0x830 linux-6.10/net/ipv6/ip6_input.c:320
 ipv6_list_rcv+0x2cd/0x3c0 linux-6.10/net/ipv6/ip6_input.c:355
 __netif_receive_skb_list_ptype linux-6.10/net/core/dev.c:5668 [inline]
 __netif_receive_skb_list_core+0x576/0x910 linux-6.10/net/core/dev.c:5716
 __netif_receive_skb_list linux-6.10/net/core/dev.c:5768 [inline]
 netif_receive_skb_list_internal+0x64b/0xb60 linux-6.10/net/core/dev.c:5860
 gro_normal_list linux-6.10/include/net/gro.h:515 [inline]
 gro_normal_list linux-6.10/include/net/gro.h:511 [inline]
 napi_complete_done+0x20a/0x760 linux-6.10/net/core/dev.c:6203
 e1000_clean+0x863/0x22c0
linux-6.10/drivers/net/ethernet/intel/e1000/e1000_main.c:3809
 __napi_poll+0xa7/0x590 linux-6.10/net/core/dev.c:6722
 napi_poll linux-6.10/net/core/dev.c:6791 [inline]
 net_rx_action+0x877/0xc30 linux-6.10/net/core/dev.c:6907
 handle_softirqs+0x162/0x520 linux-6.10/kernel/softirq.c:554
 __do_softirq linux-6.10/kernel/softirq.c:588 [inline]
 invoke_softirq linux-6.10/kernel/softirq.c:428 [inline]
 __irq_exit_rcu linux-6.10/kernel/softirq.c:637 [inline]
 irq_exit_rcu+0x7f/0xb0 linux-6.10/kernel/softirq.c:649
 common_interrupt+0x98/0xb0 linux-6.10/arch/x86/kernel/irq.c:278
 </IRQ>
 <TASK>
 asm_common_interrupt+0x26/0x40 linux-6.10/arch/x86/include/asm/idtentry.h:693
RIP: 0010:native_irq_disable
linux-6.10/arch/x86/include/asm/irqflags.h:37 [inline]
RIP: 0010:arch_local_irq_disable
linux-6.10/arch/x86/include/asm/irqflags.h:72 [inline]
RIP: 0010:default_idle+0x1e/0x30 linux-6.10/arch/x86/kernel/process.c:743
Code: 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00
66 90 0f 1f 44 00 00 0f 00 2d 79 d9 3f 00 0f 1f 44 00 00 fb f4 <fa> c3
cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
RSP: 0018:ffffffff84e07e18 EFLAGS: 00000246
RAX: ffff88806d200000 RBX: 0000000000000000 RCX: ffffffff83e26864
RDX: 0000000000000001 RSI: 0000000000000004 RDI: 0000000000061af4
RBP: dffffc0000000000 R08: 0000000000000001 R09: ffffed100da46a99
R10: ffffed100da46a98 R11: ffff88806d2354c3 R12: ffffffff856175d0
R13: 1ffffffff09c0fc8 R14: 0000000000000000 R15: 0000000000000000
 default_idle_call+0x38/0x60 linux-6.10/kernel/sched/idle.c:117
 cpuidle_idle_call linux-6.10/kernel/sched/idle.c:191 [inline]
 do_idle+0x2e8/0x3a0 linux-6.10/kernel/sched/idle.c:332
 cpu_startup_entry+0x4f/0x60 linux-6.10/kernel/sched/idle.c:430
 rest_init+0x116/0x140 linux-6.10/init/main.c:747
 start_kernel+0x355/0x450 linux-6.10/init/main.c:1103
 x86_64_start_reservations+0x18/0x30 linux-6.10/arch/x86/kernel/head64.c:507
 x86_64_start_kernel+0x92/0xa0 linux-6.10/arch/x86/kernel/head64.c:488
 common_startup_64+0x12c/0x138
 </TASK>
Modules linked in:
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffff88806d209728 EFLAGS: 00010246
RAX: ffffffff84e14440 RBX: ffff88806d2097e8 RCX: 1ffff11001879283
RDX: 0000000000000000 RSI: ffffffff837b2033 RDI: ffff88800c3c93c0
RBP: ffff88800c3c93c0 R08: 0000000000000001 R09: ffff88800c3c93c0
R10: ffff88800c3c93e8 R11: ffff88800c3c949f R12: dffffc0000000000
R13: 0000000000000000 R14: ffff88806d2097e8 R15: ffff88806d2097e8
FS:  0000000000000000(0000) GS:ffff88806d200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000000fea4006 CR4: 0000000000170ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0: 90                    nop
   1: 90                    nop
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
   c: f3 0f 1e fa          endbr64
  10: 0f 1f 44 00 00        nopl   0x0(%rax,%rax,1)
  15: 66 90                xchg   %ax,%ax
  17: 0f 1f 44 00 00        nopl   0x0(%rax,%rax,1)
  1c: 0f 00 2d 79 d9 3f 00 verw   0x3fd979(%rip)        # 0x3fd99c
  23: 0f 1f 44 00 00        nopl   0x0(%rax,%rax,1)
  28: fb                    sti
  29: f4                    hlt
* 2a: fa                    cli <-- trapping instruction
  2b: c3                    retq
  2c: cc                    int3
  2d: cc                    int3
  2e: cc                    int3
  2f: cc                    int3
  30: 66 66 2e 0f 1f 84 00 data16 nopw %cs:0x0(%rax,%rax,1)
  37: 00 00 00 00
  3b: 90                    nop
  3c: 90                    nop
  3d: 90                    nop
  3e: 90                    nop
  3f: 90                    nop


- reproducer
syz_genetlink_get_family_id$mptcp(0x0, 0xffffffffffffffff)
socket$inet(0x2, 0xa, 0x0)
socket$nl_generic(0x10, 0x3, 0x10)
openat$null(0xffffffffffffff9c, &(0x7f0000001180), 0x0, 0x0)
r0 = openat$urandom(0xffffffffffffff9c, &(0x7f0000000040), 0x0, 0x0)
read(r0, &(0x7f0000000000), 0x2000)
r1 = syz_open_dev$sg(&(0x7f0000000040), 0x0, 0x0)
ioctl$SCSI_IOCTL_SEND_COMMAND(r1, 0x1,
&(0x7f0000000000)=ANY=[@ANYBLOB="000000001d00000085", @ANYRES8=r1])


- kernel config
https://drive.google.com/file/d/1LMJgfJPhTu78Cd2DfmDaRitF6cdxxcey/view?usp=sharing


[^1] We used a customized Syzkaller but did not change the guest kernel or the
hypervisor.

