Return-Path: <netdev+bounces-129576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C82F4984950
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 18:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA5581C22A2A
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 16:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FCC1AB6D5;
	Tue, 24 Sep 2024 16:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chrfttLq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5276C1B960
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 16:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727194388; cv=none; b=BO5IyUYMS9Er7q+HiQU4qcC/d8kXkz1M/H3Uvj27pKRkZADbXpIX0mUDjSFunS093d6+6JHhU5yAsU7C+cEzdqgqc4A8h31FhXMk2iU4cBV62yFyAvmJXUWOrLboibxb/+6GGmbjAqBvlAEmY+fckSOwBKRSDK8ZDfQpj0p+3pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727194388; c=relaxed/simple;
	bh=uA1UzxF4FK1EpME19A+kLOpFYPdCIp1cEEXRl2O7zxo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=s3gssEuJuJG69O0xCji4qNnEu7dRcWWsmo4EztXtji7b6CtWgVfstb5fnEwbrH1Oz4cf/3IXfypJwTIafrERbkvq2UzM4YF4QRT1NJE6iUWBctEUsXaMWHOuPVGDWroQ10i4/01Sd4mNIxl9B+I2h2flV5ngFaA+3/ix5LTi6lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chrfttLq; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f759688444so48165941fa.1
        for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 09:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727194384; x=1727799184; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OgauavqCA16lUVlBFiSeR76SwRx14LMrHfxUhoIWJ3Y=;
        b=chrfttLqlNOeDRT9smPFNqcIEo3Wq91vcJtmB0GT2JgkfKeCszCHscPJ+MOLWteTo/
         AH1e81gj45aQOT3zFZ0Ns4IvYsP4xqP3gcQiEBf/Z6/oE9rbkXz+AtjECW5eUU/4JvRL
         e/FK1sry1pgAke8gfIagDgJsR0B4M0xpffWzuoC3Yxd8Px/JNHWyT/7rRLbnoDiPFXzG
         tF5v5AI9bUonsgVhN6AwsQxnAzN1qCPdLrEU3nwoB+RoQky8IM1Izk5SkWsW7NdX1PkY
         2AW/Lje3pFnpxCDcXpglQMSwT5bnPAaLD4PQJY5nLT8eMCe5kcu/PD7rv0mrgOmVPw4A
         EQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727194384; x=1727799184;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OgauavqCA16lUVlBFiSeR76SwRx14LMrHfxUhoIWJ3Y=;
        b=R3vzbatEDt/8fbEOJJhI+qgXcGjhVWtSvOdxM+yaBEs+9xmlxSSzYRCzL81zLDw8fu
         DhJjE2Hfdfgbj5qag4VzNYmlVL0V1PnRccsY7nS05MYfNUezgUU2P/bJmevXUPW2d0TE
         YR98CDzr9sKLgSVkPIBIw/M13MqG0kwtRwQa1ZpIYZ9RZlo2nasNamVoja0X4aPDIuI9
         Z8HKtlc4QdZHNovohEntAwic6xQlpwc+OmQnEQLijtpmrXLjNRSTl6LQxNCC6n4+hbD9
         gFE28gkrL6y7R47TrvOeEi784HLkrgVdz+Ts8XCuHdupbCrrQIaVjILxS+Ca11uWXY9g
         icAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmUu++X/xAm5MdD0m4w0EnN3n/LrX2fAAQLiEs4VBYafX2FjWFNlKsvTDhgvKN+uVbgJ9l0CU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOi4TRQzZb+WEB4fQH8mbSmoV1Dz6EuUQyfG3BOujWl45V8Gs9
	gSu1K3qK4coLtZK2t2Y8jhUEHx2Ji2aXbTgQPE346oGRO1vZ5eHUss879UT/DLL8YqJoysLDvOW
	xU29yOIDYSi4kqmW2SXUcUIcsIl8=
X-Google-Smtp-Source: AGHT+IFFFrcmaaxFIwdp71KQhdtVVkaDC1vDnP5bp3dNfsehZa7Pu+ejqeyZtgAnR9bjwiwZ1GdK4mmMEV+z3dwhtpU=
X-Received: by 2002:a05:6512:15a2:b0:52f:cc06:c483 with SMTP id
 2adb3069b0e04-536ac2e778amr8681852e87.24.1727194383830; Tue, 24 Sep 2024
 09:13:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: reveliofuzzing <reveliofuzzing@gmail.com>
Date: Tue, 24 Sep 2024 12:12:53 -0400
Message-ID: <CA+-ZZ_hgYZJTJiVV1xONi0t2suBEKa_Tp2qhnj5Man0qV=siaA@mail.gmail.com>
Subject: Report "BUG: unable to handle kernel NULL pointer dereference in e1000_clean_rx_irq"
To: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

We found the following crash when fuzzing^1 the Linux kernel 6.10 and
we are able
to reproduce it. To our knowledge, this crash has not been observed by SyzBot so
we would like to report it for your reference.

- Crash
BUG: kernel NULL pointer dereference, address: 000000000000006a
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 800000000859a067 P4D 800000000859a067 PUD 9526067 PMD 0
Oops: Oops: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.10.0 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:memcpy_orig+0x64/0x140 linux-6.10/arch/x86/lib/memcpy_64.S:94
Code: 57 10 4c 89 5f 18 48 8d 7f 20 73 d4 83 c2 20 eb 4c 48 01 d6 48
01 d7 48 83 ea 20 66 66 2e 0f 1f 84 00 00 00 00 00 48 83 ea 20 <4c> 8b
46 f8 4c 8b 4e f0 4c 8b 56 e8 4c 8b 5e e0 48 8d 76 e0 4c 89
RSP: 0018:ffff88806d209bb8 EFLAGS: 00010202
RAX: ffff888024a13c40 RBX: ffff888007898000 RCX: 1ffff11000f5ad7f
RDX: 0000000000000032 RSI: 0000000000000072 RDI: ffff888024a13cb2
RBP: ffff888007ad6b40 R08: 0000000000000001 R09: ffffed10049427dd
R10: ffffed10049427dc R11: ffff888024a13ee3 R12: 0000000000000072
R13: 0000000000000072 R14: ffff8880098d4920 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff88806d200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000000006a CR3: 000000000cf9a004 CR4: 0000000000170ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 skb_put_data linux-6.10/include/linux/skbuff.h:2689 [inline]
 e1000_copybreak
linux-6.10/drivers/net/ethernet/intel/e1000/e1000_main.c:4333 [inline]
 e1000_clean_rx_irq+0x715/0x1020
linux-6.10/drivers/net/ethernet/intel/e1000/e1000_main.c:4378
 e1000_clean+0x831/0x22c0
linux-6.10/drivers/net/ethernet/intel/e1000/e1000_main.c:3801
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
RSP: 0018:ffffffff84e07e18 EFLAGS: 00000242
RAX: ffff88806d200000 RBX: 0000000000000000 RCX: ffffffff83e26864
RDX: 0000000000000001 RSI: 0000000000000004 RDI: 00000000000446e4
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
CR2: 000000000000006a
---[ end trace 0000000000000000 ]---
RIP: 0010:memcpy_orig+0x64/0x140 linux-6.10/arch/x86/lib/memcpy_64.S:94
Code: 57 10 4c 89 5f 18 48 8d 7f 20 73 d4 83 c2 20 eb 4c 48 01 d6 48
01 d7 48 83 ea 20 66 66 2e 0f 1f 84 00 00 00 00 00 48 83 ea 20 <4c> 8b
46 f8 4c 8b 4e f0 4c 8b 56 e8 4c 8b 5e e0 48 8d 76 e0 4c 89
RSP: 0018:ffff88806d209bb8 EFLAGS: 00010202
RAX: ffff888024a13c40 RBX: ffff888007898000 RCX: 1ffff11000f5ad7f
RDX: 0000000000000032 RSI: 0000000000000072 RDI: ffff888024a13cb2
RBP: ffff888007ad6b40 R08: 0000000000000001 R09: ffffed10049427dd
R10: ffffed10049427dc R11: ffff888024a13ee3 R12: 0000000000000072
R13: 0000000000000072 R14: ffff8880098d4920 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff88806d200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000000006a CR3: 000000000cf9a004 CR4: 0000000000170ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0: 57                    push   %rdi
   1: 10 4c 89 5f          adc    %cl,0x5f(%rcx,%rcx,4)
   5: 18 48 8d              sbb    %cl,-0x73(%rax)
   8: 7f 20                jg     0x2a
   a: 73 d4                jae    0xffffffe0
   c: 83 c2 20              add    $0x20,%edx
   f: eb 4c                jmp    0x5d
  11: 48 01 d6              add    %rdx,%rsi
  14: 48 01 d7              add    %rdx,%rdi
  17: 48 83 ea 20          sub    $0x20,%rdx
  1b: 66 66 2e 0f 1f 84 00 data16 nopw %cs:0x0(%rax,%rax,1)
  22: 00 00 00 00
  26: 48 83 ea 20          sub    $0x20,%rdx
* 2a: 4c 8b 46 f8          mov    -0x8(%rsi),%r8 <-- trapping instruction
  2e: 4c 8b 4e f0          mov    -0x10(%rsi),%r9
  32: 4c 8b 56 e8          mov    -0x18(%rsi),%r10
  36: 4c 8b 5e e0          mov    -0x20(%rsi),%r11
  3a: 48 8d 76 e0          lea    -0x20(%rsi),%rsi
  3e: 4c                    rex.WR
  3f: 89                    .byte 0x89


- reproducer
syz_genetlink_get_family_id$mptcp(0x0, 0xffffffffffffffff)
r0 = syz_open_dev$usbmon(&(0x7f00000004c0), 0x0, 0x0)
mmap(&(0x7f0000fff000/0x1000)=nil, 0x1000, 0x0, 0x12, r0, 0x0)
socket$nl_generic(0x10, 0x3, 0x10)
r1 = openat$null(0xffffffffffffff9c, &(0x7f0000001180), 0x0, 0x0)
r2 = openat$urandom(0xffffffffffffff9c, &(0x7f0000000040), 0x0, 0x0)
read(r2, &(0x7f0000000000), 0x2000)
shutdown(0xffffffffffffffff, 0x0)
mknodat$null(r1, &(0x7f0000000080)='./file0\x00', 0x0, 0x103)
r3 = syz_open_dev$sg(&(0x7f0000000040), 0x0, 0x0)
ioctl$SCSI_IOCTL_SEND_COMMAND(r3, 0x1,
&(0x7f0000000000)=ANY=[@ANYBLOB="000000001d00000085", @ANYRES8=r3])


- kernel config
https://drive.google.com/file/d/1LMJgfJPhTu78Cd2DfmDaRitF6cdxxcey/view?usp=sharing


[^1] We used a customized Syzkaller but did not change the guest kernel or the
hypervisor.

