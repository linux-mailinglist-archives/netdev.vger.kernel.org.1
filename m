Return-Path: <netdev+bounces-178066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DACE0A74505
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 09:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29AC4177E4A
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 08:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F687212B18;
	Fri, 28 Mar 2025 08:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjFl6xlJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF32212D6A
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 08:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743149267; cv=none; b=rUML5obrwRfj7x3chb4a/ZcPPBXs8xcKM9wM0aC/YFsveUw26c8EJJBrR0Hp6a8JuYC0ge1Q09uQm03l0OD0RRXTt251qAl1w0bQaiUR42/VhzO+aG8MTt0Sz/8ewd2L5NPMeUl8/Up1dIteOgwgLVmysgwnQhhlUTLIbd+GpW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743149267; c=relaxed/simple;
	bh=8MT4Clkb8zLapIaAY2yXE0XBJVbREZ8pQcXY43FA4iI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LvkjS1aTIssvA5nuScXuw1aCxks3/58S+d7VfylnjShNEDSMUVYFlM25XXeUIi98c41vkhBtVCPS+0MygwThyrzE31fXgFm5KcTVGsWZ6gph45p/2USHDffzoEhMC/fmcoksYsjEdR347fVMBN6aMD1AWErdpQBZxY/lYKpWWDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjFl6xlJ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e61375c108so2343365a12.1
        for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 01:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743149258; x=1743754058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P89vxdhCmtIIlwldHf2OMvDGBOp8Vm+zOlDzw6xZAZ4=;
        b=FjFl6xlJCqEpOqxqiC4wd2+pRY3BhCFw1ITGXa0Sa/xdWiXC5wWru4iu1+ExfArTiO
         TTPwoEfrywMvJGsXqHYjVx3Ktsa85Igh/x2pqSbis1L1GTvMQS2WN7k6la6+cQOpTR98
         ghHui5TDuhcARliYEeunZWyLqU95spoNxVfIfPxCbm8lPEpumT6PxbaC+rI2Cj0UUdlE
         5dkIsXgiK3mwCixNjP9/bZDCo8qt3bfpfNDJzzyjKnPGDBekoRgfYtibG2bQMlpPLS4w
         8oOBLBABDjGvzBmcdEuAr1FF89PZMcKpCE04A4bXja7OT76LWcNJ6jfahR+RA1HzXC+W
         Kv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743149258; x=1743754058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P89vxdhCmtIIlwldHf2OMvDGBOp8Vm+zOlDzw6xZAZ4=;
        b=Nh/rmZgBUCT1jECweX4LXw2rfcafaxpIFUXy+Ro/MEb6sqcpWnWpnCWC1/X50bhkf2
         rUtOX9Couh87RN8gVEtJvAOw5WgR6QPuF6D5gH7fnMecIsFroMFk2/SxUEOKeKUtvhXe
         gG/jcPBWtLgq8N97CrpACT2XC3kb522acYu2n3U9Ba3BfrO6GWTnHiMYN6m1rgzXB9iq
         LsjfFHlE9K8LRtMRMjMzxTvSbowGxpKcIKPD0f8IWScMXFXLUC/XnrpfexnS8pty0O3O
         IQe7aOb318nxQFEUG1zAuOiFSYwLf7l8X63clqEUOn6qAOtO8V9ewAq25pm1RnVZyvoA
         6HUA==
X-Gm-Message-State: AOJu0Yyp5XimsKGHVnKMEny/A/ScFIaOP6sca3gYNZwxk1d3q4hpJ7Op
	olEzeno6ZDpVe6SGkpGplKOuZExA5tqYxjtWQ0zwTEDrM6U7Q6ZZCMMF/qzBaxt/IH57VR1pdgE
	6ctKAJlhzCHnxjDhAJhU4LfQHuoI=
X-Gm-Gg: ASbGnctxwT4Ovn97vy4TV6xtW9hyxhto75GT39IqxmSBMW4Uw4B4QcU+0B4dtysRuws
	R0hYgOqjMUG9zVhoW0XnnnO2U3Q27ZYopbz3APX+YWWgltvR3KhOAv9Fbfi3+mPEdG9ZPs7Ezz/
	g2zDV9Wc47guLjEKaydC1aPzh1p0EU
X-Google-Smtp-Source: AGHT+IEe0OAJt837Lu0jHmctOnWSjX01piUWHNMegM46+Tnh6T2H9jQw1YDOV3W2XZ4AjRa3ENZ5qf/+oP1CdKQ6qJA=
X-Received: by 2002:a05:6402:1e94:b0:5e6:6407:3b23 with SMTP id
 4fb4d7f45d1cf-5ed8eb16aecmr5953000a12.21.1743149257070; Fri, 28 Mar 2025
 01:07:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327135659.2057487-1-sdf@fomichev.me>
In-Reply-To: <20250327135659.2057487-1-sdf@fomichev.me>
From: Taehee Yoo <ap420073@gmail.com>
Date: Fri, 28 Mar 2025 17:07:24 +0900
X-Gm-Features: AQ5f1JpbD1XtTWfAKDGJASxXsh9_vozebbI7SietiUV6PjCowZoyQFQIa1YMNSw
Message-ID: <CAMArcTV4P8PFsc6O2tSgzRno050DzafgqkLA2b7t=Fv_SY=brw@mail.gmail.com>
Subject: Re: [PATCH net v2 00/11] net: hold instance lock during NETDEV_UP/REGISTER/UNREGISTER
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 10:57=E2=80=AFPM Stanislav Fomichev <sdf@fomichev.m=
e> wrote:
>

Hi Stanislav,
Thanks a lot for the patch!

> Solving the issue reported by Cosmin in [0] requires consistent
> lock during NETDEV_UP/REGISTER/UNREGISTER notifiers. This series
> addresses that (along with some other fixes in net/ipv4/devinet.c
> and net/ipv6/addrconf.c) and appends the patches from Jakub
> that were conditional on locked NETDEV_UNREGISTER.
>
> 0: https://lore.kernel.org/netdev/700fa36b94cbd57cfea2622029b087643c80cbc=
9.camel@nvidia.com/
>

I tested it using netdevsim/veth and my Broadcom NIC.
It appears that netdevsim/veth has no issues, but I encountered many
RTNL assertions in the bnxt driver.

Reproducer:
   interface=3D<bnxt interface>
   ip a a 10.0.0.1/24 dev $interface
   ip a a 2001:db8::1/64 dev $interface
   ip link set $interface up
   reboot

Splats:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: suspicious RCU usage
6.14.0+ #2 Tainted: G        W
-----------------------------
./include/linux/inetdevice.h:256 suspicious rcu_dereference_protected() usa=
ge!

other info that might help us debug this:


rcu_scheduler_active =3D 2, debug_locks =3D 1
4 locks held by shutdown/1:
#0: ffffffffa4d58750 (system_transition_mutex){+.+.}-{4:4}, at:
__do_sys_reboot (kernel/reboot.c:760)
#1: ffff888114d0c1b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/device.h:922 drivers/base/core.c:4802)
#2: ffff8881152211b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/pm_runtime.h:121 drivers/base/core.c:4805)
#3: ffff888178e24d90 (&dev->lock){+.+.}-{4:4}, at: bnxt_shutdown
(drivers/net/ethernet/broadcom/bnxt/bnxt.c:16703) bnxt_en

stack backtrace:
CPU: 0 UID: 0 PID: 1 Comm: shutdown Tainted: G        W
6.14.0+ #2 PREEMPT(undef)  271a3d276f79e3bb26d6065917556e94aae0d88d
Tainted: [W]=3DWARN
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/20=
21
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:123)
lockdep_rcu_suspicious (kernel/locking/lockdep.c:6863)
inetdev_event (./include/linux/inetdevice.h:256 net/ipv4/devinet.c:1585)
? __pfx_inetdev_event (net/ipv4/devinet.c:1583)
? fib_rules_event (net/core/fib_rules.c:1367 (discriminator 3))
? fib_rules_event (net/core/fib_rules.c:1367 (discriminator 3))
? notifier_call_chain (kernel/notifier.c:85)
notifier_call_chain (kernel/notifier.c:85)
__dev_close_many (net/core/dev.c:1732 (discriminator 3))
? __pfx___dev_close_many (net/core/dev.c:1720)
? __mutex_lock (./arch/x86/include/asm/preempt.h:104
kernel/locking/mutex.c:713 kernel/locking/mutex.c:732)
dev_close_many (net/core/dev.c:1786)
? __pfx_dev_close_many (net/core/dev.c:1776)
netif_close (./include/linux/list.h:124 ./include/linux/list.h:215
./include/linux/list.h:229 net/core/dev.c:1802 net/core/dev.c:1795)
? __pfx_netif_close (net/core/dev.c:1796)
? mark_held_locks (kernel/locking/lockdep.c:4326)
bnxt_shutdown (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16707) bnxt_en
pci_device_shutdown (drivers/pci/pci-driver.c:511)
device_shutdown (drivers/base/core.c:4820)
kernel_restart (kernel/reboot.c:271 kernel/reboot.c:285)
__do_sys_reboot (kernel/reboot.c:763)
? __pfx___do_sys_reboot (kernel/reboot.c:725)
? rseq_get_rseq_cs (kernel/rseq.c:310)
? rseq_syscall (kernel/rseq.c:465)
? __pfx_rseq_syscall (kernel/rseq.c:458)
? do_writev (fs/read_write.c:1101)
? __pfx_do_writev (fs/read_write.c:1091)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f7f28830a07
Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f
1e fa 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d
008
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   c7 c0 ff ff ff ff       mov    $0xffffffff,%eax
   6:   eb be                   jmp    0xffffffffffffffc6
   8:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
   f:   00 00 00
  12:   90                      nop
  13:   f3 0f 1e fa             endbr64
  17:   89 fa                   mov    %edi,%edx
  19:   be 69 19 12 28          mov    $0x28121969,%esi
  1e:   bf ad de e1 fe          mov    $0xfee1dead,%edi
  23:   b8 a9 00 00 00          mov    $0xa9,%eax
  28:   0f 05                   syscall
  2a:*  48                      rex.W           <-- trapping instruction
  2b:   3d                      .byte 0x3d
  2c:   08                      .byte 0x8

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   48                      rex.W
   1:   3d                      .byte 0x3d
   2:   08                      .byte 0x8
RSP: 002b:00007ffc65d6b1a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a9
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7f28830a07
RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
RBP: 00007ffc65d6b3e0 R08: 0000000000000069 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000001234567
</TASK>
------------[ cut here ]------------
RTNL: assertion failed at net/ipv4/devinet.c (1587)
WARNING: CPU: 0 PID: 1 at net/ipv4/devinet.c:1587 inetdev_event
(net/ipv4/devinet.c:1587 (discriminator 3))
Modules linked in: xt_nat xt_tcpudp veth xt_conntrack nft_chain_nat
xt_MASQUERADE nf_conntrack_netlink xfrm_user xt_addrtype nft_compat
nf_tabs
CPU: 0 UID: 0 PID: 1 Comm: shutdown Tainted: G        W
6.14.0+ #2 PREEMPT(undef)  271a3d276f79e3bb26d6065917556e94aae0d88d
Tainted: [W]=3DWARN
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/20=
21
RIP: 0010:inetdev_event (net/ipv4/devinet.c:1587 (discriminator 3))
Code: 76 3a 0b 09 00 0f 85 51 f7 ff ff ba 33 06 00 00 48 c7 c6 80 57
02 a4 48 c7 c7 c0 57 02 a4 c6 05 56 3a 0b 09 01 e8 7e 90 f8 fd <0f> 0b
e90
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   76 3a                   jbe    0x3c
   2:   0b 09                   or     (%rcx),%ecx
   4:   00 0f                   add    %cl,(%rdi)
   6:   85 51 f7                test   %edx,-0x9(%rcx)
   9:   ff                      (bad)
   a:   ff                      (bad)
   b:   ba 33 06 00 00          mov    $0x633,%edx
  10:   48 c7 c6 80 57 02 a4    mov    $0xffffffffa4025780,%rsi
  17:   48 c7 c7 c0 57 02 a4    mov    $0xffffffffa40257c0,%rdi
  1e:   c6 05 56 3a 0b 09 01    movb   $0x1,0x90b3a56(%rip)        # 0x90b3=
a7b
  25:   e8 7e 90 f8 fd          call   0xfffffffffdf890a8
  2a:*  0f 0b                   ud2             <-- trapping instruction
  2c:   90                      nop

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   0f 0b                   ud2
   2:   90                      nop
RSP: 0018:ffff888104e2f980 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 1ffff110209c5f38 RCX: 0000000000000000
RDX: 0000000000000002 RSI: 0000000000000004 RDI: 0000000000000001
RBP: ffff888104e2fa50 R08: 0000000000000000 R09: fffffbfff49a4af4
R10: 0000000000000003 R11: 0000000000000001 R12: ffff888178e24000
R13: ffff8881a3141000 R14: 000000000000000a R15: ffff888178e24420
FS:  00007f7f27cb4440(0000) GS:ffff88886dc22000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc65d6b0cc CR3: 00000001d73de000 CR4: 00000000007506f0
PKRU: 55555554
Call Trace:
<TASK>
? __warn (kernel/panic.c:748)
? __pfx_vprintk_emit.part.0 (kernel/printk/printk.c:2378)
? inetdev_event (net/ipv4/devinet.c:1587 (discriminator 3))
? report_bug (lib/bug.c:201 lib/bug.c:219)
? inetdev_event (net/ipv4/devinet.c:1587 (discriminator 3))
? handle_bug (arch/x86/kernel/traps.c:337)
? exc_invalid_op (arch/x86/kernel/traps.c:391 (discriminator 1))
? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:578)
? inetdev_event (net/ipv4/devinet.c:1587 (discriminator 3))
? __pfx_inetdev_event (net/ipv4/devinet.c:1583)
? fib_rules_event (net/core/fib_rules.c:1367 (discriminator 3))
? fib_rules_event (net/core/fib_rules.c:1367 (discriminator 3))
? notifier_call_chain (kernel/notifier.c:85)
notifier_call_chain (kernel/notifier.c:85)
__dev_close_many (net/core/dev.c:1732 (discriminator 3))
? __pfx___dev_close_many (net/core/dev.c:1720)
? __mutex_lock (./arch/x86/include/asm/preempt.h:104
kernel/locking/mutex.c:713 kernel/locking/mutex.c:732)
dev_close_many (net/core/dev.c:1786)
? __pfx_dev_close_many (net/core/dev.c:1776)
netif_close (./include/linux/list.h:124 ./include/linux/list.h:215
./include/linux/list.h:229 net/core/dev.c:1802 net/core/dev.c:1795)
? __pfx_netif_close (net/core/dev.c:1796)
? mark_held_locks (kernel/locking/lockdep.c:4326)
bnxt_shutdown (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16707) bnxt_en
pci_device_shutdown (drivers/pci/pci-driver.c:511)
device_shutdown (drivers/base/core.c:4820)
kernel_restart (kernel/reboot.c:271 kernel/reboot.c:285)
__do_sys_reboot (kernel/reboot.c:763)
? __pfx___do_sys_reboot (kernel/reboot.c:725)
? rseq_get_rseq_cs (kernel/rseq.c:310)
? rseq_syscall (kernel/rseq.c:465)
? __pfx_rseq_syscall (kernel/rseq.c:458)
? do_writev (fs/read_write.c:1101)
? __pfx_do_writev (fs/read_write.c:1091)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f7f28830a07
Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f
1e fa 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d
008
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   c7 c0 ff ff ff ff       mov    $0xffffffff,%eax
   6:   eb be                   jmp    0xffffffffffffffc6
   8:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
   f:   00 00 00
  12:   90                      nop
  13:   f3 0f 1e fa             endbr64
  17:   89 fa                   mov    %edi,%edx
  19:   be 69 19 12 28          mov    $0x28121969,%esi
  1e:   bf ad de e1 fe          mov    $0xfee1dead,%edi
  23:   b8 a9 00 00 00          mov    $0xa9,%eax
  28:   0f 05                   syscall
  2a:*  48                      rex.W           <-- trapping instruction
  2b:   3d                      .byte 0x3d
  2c:   08                      .byte 0x8

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   48                      rex.W
   1:   3d                      .byte 0x3d
   2:   08                      .byte 0x8
RSP: 002b:00007ffc65d6b1a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a9
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7f28830a07
RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
RBP: 00007ffc65d6b3e0 R08: 0000000000000069 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000001234567
</TASK>
irq event stamp: 12714113
hardirqs last enabled at (12714125): __up_console_sem
(kernel/printk/printk.c:344 (discriminator 1))
hardirqs last disabled at (12714142): __up_console_sem
(kernel/printk/printk.c:342 (discriminator 1))
softirqs last enabled at (12714138): __irq_exit_rcu
(kernel/softirq.c:596 kernel/softirq.c:435 kernel/softirq.c:662)
softirqs last disabled at (12714133): __irq_exit_rcu
(kernel/softirq.c:596 kernel/softirq.c:435 kernel/softirq.c:662)
---[ end trace 0000000000000000 ]---

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: suspicious RCU usage
6.14.0+ #2 Tainted: G        W
-----------------------------
./include/linux/inetdevice.h:256 suspicious rcu_dereference_protected() usa=
ge!

other info that might help us debug this:


rcu_scheduler_active =3D 2, debug_locks =3D 1
4 locks held by shutdown/1:
#0: ffffffffa4d58750 (system_transition_mutex){+.+.}-{4:4}, at:
__do_sys_reboot (kernel/reboot.c:760)
#1: ffff888114d0c1b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/device.h:922 drivers/base/core.c:4802)
#2: ffff8881152211b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/pm_runtime.h:121 drivers/base/core.c:4805)
#3: ffff888178e24d90 (&dev->lock){+.+.}-{4:4}, at: bnxt_shutdown
(drivers/net/ethernet/broadcom/bnxt/bnxt.c:16703) bnxt_en

stack backtrace:
CPU: 0 UID: 0 PID: 1 Comm: shutdown Tainted: G        W
6.14.0+ #2 PREEMPT(undef)  271a3d276f79e3bb26d6065917556e94aae0d88d
Tainted: [W]=3DWARN
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/20=
21
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:123)
lockdep_rcu_suspicious (kernel/locking/lockdep.c:6863)
fib_netdev_event (./include/linux/inetdevice.h:256 net/ipv4/fib_frontend.c:=
1508)
notifier_call_chain (kernel/notifier.c:85)
__dev_close_many (net/core/dev.c:1732 (discriminator 3))
? __pfx___dev_close_many (net/core/dev.c:1720)
? __mutex_lock (./arch/x86/include/asm/preempt.h:104
kernel/locking/mutex.c:713 kernel/locking/mutex.c:732)
dev_close_many (net/core/dev.c:1786)
? __pfx_dev_close_many (net/core/dev.c:1776)
netif_close (./include/linux/list.h:124 ./include/linux/list.h:215
./include/linux/list.h:229 net/core/dev.c:1802 net/core/dev.c:1795)
? __pfx_netif_close (net/core/dev.c:1796)
? mark_held_locks (kernel/locking/lockdep.c:4326)
bnxt_shutdown (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16707) bnxt_en
pci_device_shutdown (drivers/pci/pci-driver.c:511)
device_shutdown (drivers/base/core.c:4820)
kernel_restart (kernel/reboot.c:271 kernel/reboot.c:285)
__do_sys_reboot (kernel/reboot.c:763)
? __pfx___do_sys_reboot (kernel/reboot.c:725)
? rseq_get_rseq_cs (kernel/rseq.c:310)
? rseq_syscall (kernel/rseq.c:465)
? __pfx_rseq_syscall (kernel/rseq.c:458)
? do_writev (fs/read_write.c:1101)
? __pfx_do_writev (fs/read_write.c:1091)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f7f28830a07
Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f
1e fa 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d
008
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   c7 c0 ff ff ff ff       mov    $0xffffffff,%eax
   6:   eb be                   jmp    0xffffffffffffffc6
   8:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
   f:   00 00 00
  12:   90                      nop
  13:   f3 0f 1e fa             endbr64
  17:   89 fa                   mov    %edi,%edx
  19:   be 69 19 12 28          mov    $0x28121969,%esi
  1e:   bf ad de e1 fe          mov    $0xfee1dead,%edi
  23:   b8 a9 00 00 00          mov    $0xa9,%eax
  28:   0f 05                   syscall
  2a:*  48                      rex.W           <-- trapping instruction
  2b:   3d                      .byte 0x3d
  2c:   08                      .byte 0x8

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   48                      rex.W
   1:   3d                      .byte 0x3d
   2:   08                      .byte 0x8
RSP: 002b:00007ffc65d6b1a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a9
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7f28830a07
RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
RBP: 00007ffc65d6b3e0 R08: 0000000000000069 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000001234567
</TASK>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: suspicious RCU usage
6.14.0+ #2 Tainted: G        W
-----------------------------
./include/net/addrconf.h:347 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active =3D 2, debug_locks =3D 1
4 locks held by shutdown/1:
#0: ffffffffa4d58750 (system_transition_mutex){+.+.}-{4:4}, at:
__do_sys_reboot (kernel/reboot.c:760)
#1: ffff888114d0c1b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/device.h:922 drivers/base/core.c:4802)
#2: ffff8881152211b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/pm_runtime.h:121 drivers/base/core.c:4805)
#3: ffff888178e24d90 (&dev->lock){+.+.}-{4:4}, at: bnxt_shutdown
(drivers/net/ethernet/broadcom/bnxt/bnxt.c:16703) bnxt_en

stack backtrace:
CPU: 0 UID: 0 PID: 1 Comm: shutdown Tainted: G        W
6.14.0+ #2 PREEMPT(undef)  271a3d276f79e3bb26d6065917556e94aae0d88d
Tainted: [W]=3DWARN
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/20=
21
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:123)
lockdep_rcu_suspicious (kernel/locking/lockdep.c:6863)
addrconf_notify (./include/net/addrconf.h:347
./include/net/addrconf.h:345 net/ipv6/addrconf.c:3641)
? ip6mr_device_event (net/ipv6/ip6mr.c:1277)
? fib_netdev_event (./include/linux/inetdevice.h:256
net/ipv4/fib_frontend.c:1508)
notifier_call_chain (kernel/notifier.c:85)
__dev_close_many (net/core/dev.c:1732 (discriminator 3))
? __pfx___dev_close_many (net/core/dev.c:1720)
? __mutex_lock (./arch/x86/include/asm/preempt.h:104
kernel/locking/mutex.c:713 kernel/locking/mutex.c:732)
dev_close_many (net/core/dev.c:1786)
? __pfx_dev_close_many (net/core/dev.c:1776)
netif_close (./include/linux/list.h:124 ./include/linux/list.h:215
./include/linux/list.h:229 net/core/dev.c:1802 net/core/dev.c:1795)
? __pfx_netif_close (net/core/dev.c:1796)
? mark_held_locks (kernel/locking/lockdep.c:4326)
bnxt_shutdown (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16707) bnxt_en
pci_device_shutdown (drivers/pci/pci-driver.c:511)
device_shutdown (drivers/base/core.c:4820)
kernel_restart (kernel/reboot.c:271 kernel/reboot.c:285)
__do_sys_reboot (kernel/reboot.c:763)
? __pfx___do_sys_reboot (kernel/reboot.c:725)
? rseq_get_rseq_cs (kernel/rseq.c:310)
? rseq_syscall (kernel/rseq.c:465)
? __pfx_rseq_syscall (kernel/rseq.c:458)
? do_writev (fs/read_write.c:1101)
? __pfx_do_writev (fs/read_write.c:1091)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f7f28830a07
Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f
1e fa 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d
008
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   c7 c0 ff ff ff ff       mov    $0xffffffff,%eax
   6:   eb be                   jmp    0xffffffffffffffc6
   8:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
   f:   00 00 00
  12:   90                      nop
  13:   f3 0f 1e fa             endbr64
  17:   89 fa                   mov    %edi,%edx
  19:   be 69 19 12 28          mov    $0x28121969,%esi
  1e:   bf ad de e1 fe          mov    $0xfee1dead,%edi
  23:   b8 a9 00 00 00          mov    $0xa9,%eax
  28:   0f 05                   syscall
  2a:*  48                      rex.W           <-- trapping instruction
  2b:   3d                      .byte 0x3d
  2c:   08                      .byte 0x8

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   48                      rex.W
   1:   3d                      .byte 0x3d
   2:   08                      .byte 0x8
RSP: 002b:00007ffc65d6b1a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a9
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7f28830a07
RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
RBP: 00007ffc65d6b3e0 R08: 0000000000000069 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000001234567
</TASK>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: suspicious RCU usage
6.14.0+ #2 Tainted: G        W
-----------------------------
./include/net/addrconf.h:347 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active =3D 2, debug_locks =3D 1
4 locks held by shutdown/1:
#0: ffffffffa4d58750 (system_transition_mutex){+.+.}-{4:4}, at:
__do_sys_reboot (kernel/reboot.c:760)
#1: ffff888114d0c1b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/device.h:922 drivers/base/core.c:4802)
#2: ffff8881152211b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/pm_runtime.h:121 drivers/base/core.c:4805)
#3: ffff888178e24d90 (&dev->lock){+.+.}-{4:4}, at: bnxt_shutdown
(drivers/net/ethernet/broadcom/bnxt/bnxt.c:16703) bnxt_en

stack backtrace:
CPU: 0 UID: 0 PID: 1 Comm: shutdown Tainted: G        W
6.14.0+ #2 PREEMPT(undef)  271a3d276f79e3bb26d6065917556e94aae0d88d
Tainted: [W]=3DWARN
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/20=
21
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:123)
lockdep_rcu_suspicious (kernel/locking/lockdep.c:6863)
ipv6_mc_netdev_event (./include/net/addrconf.h:347
./include/net/addrconf.h:345 net/ipv6/mcast.c:2888)
notifier_call_chain (kernel/notifier.c:85)
__dev_close_many (net/core/dev.c:1732 (discriminator 3))
? __pfx___dev_close_many (net/core/dev.c:1720)
? __mutex_lock (./arch/x86/include/asm/preempt.h:104
kernel/locking/mutex.c:713 kernel/locking/mutex.c:732)
dev_close_many (net/core/dev.c:1786)
? __pfx_dev_close_many (net/core/dev.c:1776)
netif_close (./include/linux/list.h:124 ./include/linux/list.h:215
./include/linux/list.h:229 net/core/dev.c:1802 net/core/dev.c:1795)
? __pfx_netif_close (net/core/dev.c:1796)
? mark_held_locks (kernel/locking/lockdep.c:4326)
bnxt_shutdown (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16707) bnxt_en
pci_device_shutdown (drivers/pci/pci-driver.c:511)
device_shutdown (drivers/base/core.c:4820)
kernel_restart (kernel/reboot.c:271 kernel/reboot.c:285)
__do_sys_reboot (kernel/reboot.c:763)
? __pfx___do_sys_reboot (kernel/reboot.c:725)
? rseq_get_rseq_cs (kernel/rseq.c:310)
? rseq_syscall (kernel/rseq.c:465)
? __pfx_rseq_syscall (kernel/rseq.c:458)
? do_writev (fs/read_write.c:1101)
? __pfx_do_writev (fs/read_write.c:1091)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f7f28830a07
Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f
1e fa 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d
008
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   c7 c0 ff ff ff ff       mov    $0xffffffff,%eax
   6:   eb be                   jmp    0xffffffffffffffc6
   8:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
   f:   00 00 00
  12:   90                      nop
  13:   f3 0f 1e fa             endbr64
  17:   89 fa                   mov    %edi,%edx
  19:   be 69 19 12 28          mov    $0x28121969,%esi
  1e:   bf ad de e1 fe          mov    $0xfee1dead,%edi
  23:   b8 a9 00 00 00          mov    $0xa9,%eax
  28:   0f 05                   syscall
  2a:*  48                      rex.W           <-- trapping instruction
  2b:   3d                      .byte 0x3d
  2c:   08                      .byte 0x8

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   48                      rex.W
   1:   3d                      .byte 0x3d
   2:   08                      .byte 0x8
RSP: 002b:00007ffc65d6b1a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a9
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7f28830a07
RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
RBP: 00007ffc65d6b3e0 R08: 0000000000000069 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000001234567
</TASK>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: suspicious RCU usage
6.14.0+ #2 Tainted: G        W
-----------------------------
net/sched/sch_generic.c:1285 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active =3D 2, debug_locks =3D 1
4 locks held by shutdown/1:
#0: ffffffffa4d58750 (system_transition_mutex){+.+.}-{4:4}, at:
__do_sys_reboot (kernel/reboot.c:760)
#1: ffff888114d0c1b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/device.h:922 drivers/base/core.c:4802)
#2: ffff8881152211b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/pm_runtime.h:121 drivers/base/core.c:4805)
#3: ffff888178e24d90 (&dev->lock){+.+.}-{4:4}, at: bnxt_shutdown
(drivers/net/ethernet/broadcom/bnxt/bnxt.c:16703) bnxt_en

stack backtrace:
CPU: 0 UID: 0 PID: 1 Comm: shutdown Tainted: G        W
6.14.0+ #2 PREEMPT(undef)  271a3d276f79e3bb26d6065917556e94aae0d88d
Tainted: [W]=3DWARN
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/20=
21
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:123)
lockdep_rcu_suspicious (kernel/locking/lockdep.c:6863)
dev_deactivate_queue (net/sched/sch_generic.c:1285 (discriminator 7))
dev_deactivate_many (./include/linux/netdevice.h:2650
net/sched/sch_generic.c:1361)
? preempt_count_add (./include/linux/ftrace.h:1089
kernel/sched/core.c:5822 kernel/sched/core.c:5819
kernel/sched/core.c:5847)
? __pfx_dev_deactivate_many (net/sched/sch_generic.c:1356)
? notifier_call_chain (kernel/notifier.c:85)
__dev_close_many (net/core/dev.c:1745)
? __pfx___dev_close_many (net/core/dev.c:1720)
? __mutex_lock (./arch/x86/include/asm/preempt.h:104
kernel/locking/mutex.c:713 kernel/locking/mutex.c:732)
dev_close_many (net/core/dev.c:1786)
? __pfx_dev_close_many (net/core/dev.c:1776)
netif_close (./include/linux/list.h:124 ./include/linux/list.h:215
./include/linux/list.h:229 net/core/dev.c:1802 net/core/dev.c:1795)
? __pfx_netif_close (net/core/dev.c:1796)
? mark_held_locks (kernel/locking/lockdep.c:4326)
bnxt_shutdown (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16707) bnxt_en
pci_device_shutdown (drivers/pci/pci-driver.c:511)
device_shutdown (drivers/base/core.c:4820)
kernel_restart (kernel/reboot.c:271 kernel/reboot.c:285)
__do_sys_reboot (kernel/reboot.c:763)
? __pfx___do_sys_reboot (kernel/reboot.c:725)
? rseq_get_rseq_cs (kernel/rseq.c:310)
? rseq_syscall (kernel/rseq.c:465)
? __pfx_rseq_syscall (kernel/rseq.c:458)
? do_writev (fs/read_write.c:1101)
? __pfx_do_writev (fs/read_write.c:1091)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f7f28830a07
Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f
1e fa 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d
008
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   c7 c0 ff ff ff ff       mov    $0xffffffff,%eax
   6:   eb be                   jmp    0xffffffffffffffc6
   8:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
   f:   00 00 00
  12:   90                      nop
  13:   f3 0f 1e fa             endbr64
  17:   89 fa                   mov    %edi,%edx
  19:   be 69 19 12 28          mov    $0x28121969,%esi
  1e:   bf ad de e1 fe          mov    $0xfee1dead,%edi
  23:   b8 a9 00 00 00          mov    $0xa9,%eax
  28:   0f 05                   syscall
  2a:*  48                      rex.W           <-- trapping instruction
  2b:   3d                      .byte 0x3d
  2c:   08                      .byte 0x8

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   48                      rex.W
   1:   3d                      .byte 0x3d
   2:   08                      .byte 0x8
RSP: 002b:00007ffc65d6b1a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a9
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7f28830a07
RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
RBP: 00007ffc65d6b3e0 R08: 0000000000000069 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000001234567
</TASK>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: suspicious RCU usage
6.14.0+ #2 Tainted: G        W
-----------------------------
./include/linux/rtnetlink.h:163 suspicious rcu_dereference_protected() usag=
e!

other info that might help us debug this:


rcu_scheduler_active =3D 2, debug_locks =3D 1
4 locks held by shutdown/1:
#0: ffffffffa4d58750 (system_transition_mutex){+.+.}-{4:4}, at:
__do_sys_reboot (kernel/reboot.c:760)
#1: ffff888114d0c1b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/device.h:922 drivers/base/core.c:4802)
#2: ffff8881152211b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/pm_runtime.h:121 drivers/base/core.c:4805)
#3: ffff888178e24d90 (&dev->lock){+.+.}-{4:4}, at: bnxt_shutdown
(drivers/net/ethernet/broadcom/bnxt/bnxt.c:16703) bnxt_en

stack backtrace:
CPU: 0 UID: 0 PID: 1 Comm: shutdown Tainted: G        W
6.14.0+ #2 PREEMPT(undef)  271a3d276f79e3bb26d6065917556e94aae0d88d
Tainted: [W]=3DWARN
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/20=
21
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:123)
lockdep_rcu_suspicious (kernel/locking/lockdep.c:6863)
dev_deactivate_many (./include/linux/rtnetlink.h:163
net/sched/sch_generic.c:1363)
? preempt_count_add (./include/linux/ftrace.h:1089
kernel/sched/core.c:5822 kernel/sched/core.c:5819
kernel/sched/core.c:5847)
? __pfx_dev_deactivate_many (net/sched/sch_generic.c:1356)
? notifier_call_chain (kernel/notifier.c:85)
__dev_close_many (net/core/dev.c:1745)
? __pfx___dev_close_many (net/core/dev.c:1720)
? __mutex_lock (./arch/x86/include/asm/preempt.h:104
kernel/locking/mutex.c:713 kernel/locking/mutex.c:732)
dev_close_many (net/core/dev.c:1786)
? __pfx_dev_close_many (net/core/dev.c:1776)
netif_close (./include/linux/list.h:124 ./include/linux/list.h:215
./include/linux/list.h:229 net/core/dev.c:1802 net/core/dev.c:1795)
? __pfx_netif_close (net/core/dev.c:1796)
? mark_held_locks (kernel/locking/lockdep.c:4326)
bnxt_shutdown (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16707) bnxt_en
pci_device_shutdown (drivers/pci/pci-driver.c:511)
device_shutdown (drivers/base/core.c:4820)
kernel_restart (kernel/reboot.c:271 kernel/reboot.c:285)
__do_sys_reboot (kernel/reboot.c:763)
? __pfx___do_sys_reboot (kernel/reboot.c:725)
? rseq_get_rseq_cs (kernel/rseq.c:310)
? rseq_syscall (kernel/rseq.c:465)
? __pfx_rseq_syscall (kernel/rseq.c:458)
? do_writev (fs/read_write.c:1101)
? __pfx_do_writev (fs/read_write.c:1091)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f7f28830a07
Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f
1e fa 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d
008
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   c7 c0 ff ff ff ff       mov    $0xffffffff,%eax
   6:   eb be                   jmp    0xffffffffffffffc6
   8:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
   f:   00 00 00
  12:   90                      nop
  13:   f3 0f 1e fa             endbr64
  17:   89 fa                   mov    %edi,%edx
  19:   be 69 19 12 28          mov    $0x28121969,%esi
  1e:   bf ad de e1 fe          mov    $0xfee1dead,%edi
  23:   b8 a9 00 00 00          mov    $0xa9,%eax
  28:   0f 05                   syscall
  2a:*  48                      rex.W           <-- trapping instruction
  2b:   3d                      .byte 0x3d
  2c:   08                      .byte 0x8

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   48                      rex.W
   1:   3d                      .byte 0x3d
   2:   08                      .byte 0x8
RSP: 002b:00007ffc65d6b1a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a9
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7f28830a07
RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
RBP: 00007ffc65d6b3e0 R08: 0000000000000069 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000001234567
</TASK>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: suspicious RCU usage
6.14.0+ #2 Tainted: G        W
-----------------------------
net/sched/sch_generic.c:1301 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active =3D 2, debug_locks =3D 1
4 locks held by shutdown/1:
#0: ffffffffa4d58750 (system_transition_mutex){+.+.}-{4:4}, at:
__do_sys_reboot (kernel/reboot.c:760)
#1: ffff888114d0c1b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/device.h:922 drivers/base/core.c:4802)
#2: ffff8881152211b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/pm_runtime.h:121 drivers/base/core.c:4805)
#3: ffff888178e24d90 (&dev->lock){+.+.}-{4:4}, at: bnxt_shutdown
(drivers/net/ethernet/broadcom/bnxt/bnxt.c:16703) bnxt_en

stack backtrace:
CPU: 0 UID: 0 PID: 1 Comm: shutdown Tainted: G        W
6.14.0+ #2 PREEMPT(undef)  271a3d276f79e3bb26d6065917556e94aae0d88d
Tainted: [W]=3DWARN
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/20=
21
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:123)
lockdep_rcu_suspicious (kernel/locking/lockdep.c:6863)
dev_reset_queue (net/sched/sch_generic.c:1301 (discriminator 7))
dev_deactivate_many (./include/linux/netdevice.h:2650
net/sched/sch_generic.c:1375)
? preempt_count_add (./include/linux/ftrace.h:1089
kernel/sched/core.c:5822 kernel/sched/core.c:5819
kernel/sched/core.c:5847)
? __pfx_dev_deactivate_many (net/sched/sch_generic.c:1356)
? notifier_call_chain (kernel/notifier.c:85)
__dev_close_many (net/core/dev.c:1745)
? __pfx___dev_close_many (net/core/dev.c:1720)
? __mutex_lock (./arch/x86/include/asm/preempt.h:104
kernel/locking/mutex.c:713 kernel/locking/mutex.c:732)
dev_close_many (net/core/dev.c:1786)
? __pfx_dev_close_many (net/core/dev.c:1776)
netif_close (./include/linux/list.h:124 ./include/linux/list.h:215
./include/linux/list.h:229 net/core/dev.c:1802 net/core/dev.c:1795)
? __pfx_netif_close (net/core/dev.c:1796)
? mark_held_locks (kernel/locking/lockdep.c:4326)
bnxt_shutdown (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16707) bnxt_en
pci_device_shutdown (drivers/pci/pci-driver.c:511)
device_shutdown (drivers/base/core.c:4820)
kernel_restart (kernel/reboot.c:271 kernel/reboot.c:285)
__do_sys_reboot (kernel/reboot.c:763)
? __pfx___do_sys_reboot (kernel/reboot.c:725)
? rseq_get_rseq_cs (kernel/rseq.c:310)
? rseq_syscall (kernel/rseq.c:465)
? __pfx_rseq_syscall (kernel/rseq.c:458)
? do_writev (fs/read_write.c:1101)
? __pfx_do_writev (fs/read_write.c:1091)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f7f28830a07
Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f
1e fa 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d
008
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   c7 c0 ff ff ff ff       mov    $0xffffffff,%eax
   6:   eb be                   jmp    0xffffffffffffffc6
   8:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
   f:   00 00 00
  12:   90                      nop
  13:   f3 0f 1e fa             endbr64
  17:   89 fa                   mov    %edi,%edx
  19:   be 69 19 12 28          mov    $0x28121969,%esi
  1e:   bf ad de e1 fe          mov    $0xfee1dead,%edi
  23:   b8 a9 00 00 00          mov    $0xa9,%eax
  28:   0f 05                   syscall
  2a:*  48                      rex.W           <-- trapping instruction
  2b:   3d                      .byte 0x3d
  2c:   08                      .byte 0x8

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   48                      rex.W
   1:   3d                      .byte 0x3d
   2:   08                      .byte 0x8
RSP: 002b:00007ffc65d6b1a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a9
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7f28830a07
RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
RBP: 00007ffc65d6b3e0 R08: 0000000000000069 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000001234567
</TASK>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: suspicious RCU usage
6.14.0+ #2 Tainted: G        W
-----------------------------
net/sched/sch_generic.c:1332 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active =3D 2, debug_locks =3D 1
4 locks held by shutdown/1:
#0: ffffffffa4d58750 (system_transition_mutex){+.+.}-{4:4}, at:
__do_sys_reboot (kernel/reboot.c:760)
#1: ffff888114d0c1b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/device.h:922 drivers/base/core.c:4802)
#2: ffff8881152211b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/pm_runtime.h:121 drivers/base/core.c:4805)
#3: ffff888178e24d90 (&dev->lock){+.+.}-{4:4}, at: bnxt_shutdown
(drivers/net/ethernet/broadcom/bnxt/bnxt.c:16703) bnxt_en

stack backtrace:
CPU: 0 UID: 0 PID: 1 Comm: shutdown Tainted: G        W
6.14.0+ #2 PREEMPT(undef)  271a3d276f79e3bb26d6065917556e94aae0d88d
Tainted: [W]=3DWARN
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/20=
21
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:123)
lockdep_rcu_suspicious (kernel/locking/lockdep.c:6863)
dev_deactivate_many (net/sched/sch_generic.c:1332 net/sched/sch_generic.c:1=
383)
? __pfx_dev_deactivate_many (net/sched/sch_generic.c:1356)
? notifier_call_chain (kernel/notifier.c:85)
__dev_close_many (net/core/dev.c:1745)
? __pfx___dev_close_many (net/core/dev.c:1720)
? __mutex_lock (./arch/x86/include/asm/preempt.h:104
kernel/locking/mutex.c:713 kernel/locking/mutex.c:732)
dev_close_many (net/core/dev.c:1786)
? __pfx_dev_close_many (net/core/dev.c:1776)
netif_close (./include/linux/list.h:124 ./include/linux/list.h:215
./include/linux/list.h:229 net/core/dev.c:1802 net/core/dev.c:1795)
? __pfx_netif_close (net/core/dev.c:1796)
? mark_held_locks (kernel/locking/lockdep.c:4326)
bnxt_shutdown (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16707) bnxt_en
pci_device_shutdown (drivers/pci/pci-driver.c:511)
device_shutdown (drivers/base/core.c:4820)
kernel_restart (kernel/reboot.c:271 kernel/reboot.c:285)
__do_sys_reboot (kernel/reboot.c:763)
? __pfx___do_sys_reboot (kernel/reboot.c:725)
? rseq_get_rseq_cs (kernel/rseq.c:310)
? rseq_syscall (kernel/rseq.c:465)
? __pfx_rseq_syscall (kernel/rseq.c:458)
? do_writev (fs/read_write.c:1101)
? __pfx_do_writev (fs/read_write.c:1091)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f7f28830a07
Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f
1e fa 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d
008
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   c7 c0 ff ff ff ff       mov    $0xffffffff,%eax
   6:   eb be                   jmp    0xffffffffffffffc6
   8:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
   f:   00 00 00
  12:   90                      nop
  13:   f3 0f 1e fa             endbr64
  17:   89 fa                   mov    %edi,%edx
  19:   be 69 19 12 28          mov    $0x28121969,%esi
  1e:   bf ad de e1 fe          mov    $0xfee1dead,%edi
  23:   b8 a9 00 00 00          mov    $0xa9,%eax
  28:   0f 05                   syscall
  2a:*  48                      rex.W           <-- trapping instruction
  2b:   3d                      .byte 0x3d
  2c:   08                      .byte 0x8

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   48                      rex.W
   1:   3d                      .byte 0x3d
   2:   08                      .byte 0x8
RSP: 002b:00007ffc65d6b1a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a9
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7f28830a07
RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
RBP: 00007ffc65d6b3e0 R08: 0000000000000069 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000001234567
</TASK>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: suspicious RCU usage
6.14.0+ #2 Tainted: G        W
-----------------------------
net/core/netpoll.c:229 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active =3D 2, debug_locks =3D 1
4 locks held by shutdown/1:
#0: ffffffffa4d58750 (system_transition_mutex){+.+.}-{4:4}, at:
__do_sys_reboot (kernel/reboot.c:760)
#1: ffff888114d0c1b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/device.h:922 drivers/base/core.c:4802)
#2: ffff8881152211b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/pm_runtime.h:121 drivers/base/core.c:4805)
#3: ffff888178e24d90 (&dev->lock){+.+.}-{4:4}, at: bnxt_shutdown
(drivers/net/ethernet/broadcom/bnxt/bnxt.c:16703) bnxt_en

stack backtrace:
CPU: 0 UID: 0 PID: 1 Comm: shutdown Tainted: G        W
6.14.0+ #2 PREEMPT(undef)  271a3d276f79e3bb26d6065917556e94aae0d88d
Tainted: [W]=3DWARN
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/20=
21
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:123)
lockdep_rcu_suspicious (kernel/locking/lockdep.c:6863)
netpoll_poll_enable (net/core/netpoll.c:229 (discriminator 7))
__dev_close_many (net/core/dev.c:1745)
? __pfx___dev_close_many (net/core/dev.c:1720)
? __mutex_lock (./arch/x86/include/asm/preempt.h:104
kernel/locking/mutex.c:713 kernel/locking/mutex.c:732)
dev_close_many (net/core/dev.c:1786)
? __pfx_dev_close_many (net/core/dev.c:1776)
netif_close (./include/linux/list.h:124 ./include/linux/list.h:215
./include/linux/list.h:229 net/core/dev.c:1802 net/core/dev.c:1795)
? __pfx_netif_close (net/core/dev.c:1796)
? mark_held_locks (kernel/locking/lockdep.c:4326)
bnxt_shutdown (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16707) bnxt_en
pci_device_shutdown (drivers/pci/pci-driver.c:511)
device_shutdown (drivers/base/core.c:4820)
kernel_restart (kernel/reboot.c:271 kernel/reboot.c:285)
__do_sys_reboot (kernel/reboot.c:763)
? __pfx___do_sys_reboot (kernel/reboot.c:725)
? rseq_get_rseq_cs (kernel/rseq.c:310)
? rseq_syscall (kernel/rseq.c:465)
? __pfx_rseq_syscall (kernel/rseq.c:458)
? do_writev (fs/read_write.c:1101)
? __pfx_do_writev (fs/read_write.c:1091)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f7f28830a07
Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f
1e fa 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d
008
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   c7 c0 ff ff ff ff       mov    $0xffffffff,%eax
   6:   eb be                   jmp    0xffffffffffffffc6
   8:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
   f:   00 00 00
  12:   90                      nop
  13:   f3 0f 1e fa             endbr64
  17:   89 fa                   mov    %edi,%edx
  19:   be 69 19 12 28          mov    $0x28121969,%esi
  1e:   bf ad de e1 fe          mov    $0xfee1dead,%edi
  23:   b8 a9 00 00 00          mov    $0xa9,%eax
  28:   0f 05                   syscall
  2a:*  48                      rex.W           <-- trapping instruction
  2b:   3d                      .byte 0x3d
  2c:   08                      .byte 0x8

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   48                      rex.W
   1:   3d                      .byte 0x3d
   2:   08                      .byte 0x8
RSP: 002b:00007ffc65d6b1a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a9
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7f28830a07
RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
RBP: 00007ffc65d6b3e0 R08: 0000000000000069 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000001234567
</TASK>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: suspicious RCU usage
6.14.0+ #2 Tainted: G        W
-----------------------------
drivers/dpll/dpll_netlink.c:71 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active =3D 2, debug_locks =3D 1
4 locks held by shutdown/1:
#0: ffffffffa4d58750 (system_transition_mutex){+.+.}-{4:4}, at:
__do_sys_reboot (kernel/reboot.c:760)
#1: ffff888114d0c1b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/device.h:922 drivers/base/core.c:4802)
#2: ffff8881152211b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/pm_runtime.h:121 drivers/base/core.c:4805)
#3: ffff888178e24d90 (&dev->lock){+.+.}-{4:4}, at: bnxt_shutdown
(drivers/net/ethernet/broadcom/bnxt/bnxt.c:16703) bnxt_en

stack backtrace:
CPU: 0 UID: 0 PID: 1 Comm: shutdown Tainted: G        W
6.14.0+ #2 PREEMPT(undef)  271a3d276f79e3bb26d6065917556e94aae0d88d
Tainted: [W]=3DWARN
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/20=
21
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:123)
lockdep_rcu_suspicious (kernel/locking/lockdep.c:6863)
dpll_netdev_pin_handle_size (drivers/dpll/dpll_netlink.c:71
drivers/dpll/dpll_netlink.c:69 drivers/dpll/dpll_netlink.c:82)
if_nlmsg_size (net/core/rtnetlink.c:1263 net/core/rtnetlink.c:1325)
rtmsg_ifinfo_build_skb (./include/linux/skbuff.h:1340
./include/net/netlink.h:1019 net/core/rtnetlink.c:4400)
rtmsg_ifinfo (net/core/rtnetlink.c:4442 net/core/rtnetlink.c:4432
net/core/rtnetlink.c:4451)
dev_close_many (net/core/dev.c:2285 net/core/dev.c:2299 net/core/dev.c:1788=
)
? __pfx_dev_close_many (net/core/dev.c:1776)
netif_close (./include/linux/list.h:124 ./include/linux/list.h:215
./include/linux/list.h:229 net/core/dev.c:1802 net/core/dev.c:1795)
? __pfx_netif_close (net/core/dev.c:1796)
? mark_held_locks (kernel/locking/lockdep.c:4326)
bnxt_shutdown (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16707) bnxt_en
pci_device_shutdown (drivers/pci/pci-driver.c:511)
device_shutdown (drivers/base/core.c:4820)
kernel_restart (kernel/reboot.c:271 kernel/reboot.c:285)
__do_sys_reboot (kernel/reboot.c:763)
? __pfx___do_sys_reboot (kernel/reboot.c:725)
? rseq_get_rseq_cs (kernel/rseq.c:310)
? rseq_syscall (kernel/rseq.c:465)
? __pfx_rseq_syscall (kernel/rseq.c:458)
? do_writev (fs/read_write.c:1101)
? __pfx_do_writev (fs/read_write.c:1091)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f7f28830a07
Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f
1e fa 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d
008
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   c7 c0 ff ff ff ff       mov    $0xffffffff,%eax
   6:   eb be                   jmp    0xffffffffffffffc6
   8:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
   f:   00 00 00
  12:   90                      nop
  13:   f3 0f 1e fa             endbr64
  17:   89 fa                   mov    %edi,%edx
  19:   be 69 19 12 28          mov    $0x28121969,%esi
  1e:   bf ad de e1 fe          mov    $0xfee1dead,%edi
  23:   b8 a9 00 00 00          mov    $0xa9,%eax
  28:   0f 05                   syscall
  2a:*  48                      rex.W           <-- trapping instruction
  2b:   3d                      .byte 0x3d
  2c:   08                      .byte 0x8

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   48                      rex.W
   1:   3d                      .byte 0x3d
   2:   08                      .byte 0x8
RSP: 002b:00007ffc65d6b1a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a9
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7f28830a07
RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
RBP: 00007ffc65d6b3e0 R08: 0000000000000069 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000001234567
</TASK>
------------[ cut here ]------------
RTNL: assertion failed at net/core/rtnetlink.c (2029)
WARNING: CPU: 0 PID: 1 at net/core/rtnetlink.c:2029
rtnl_fill_ifinfo.constprop.0 (net/core/rtnetlink.c:2029)
Modules linked in: xt_nat xt_tcpudp veth xt_conntrack nft_chain_nat
xt_MASQUERADE nf_conntrack_netlink xfrm_user xt_addrtype nft_compat
nf_tabs
CPU: 0 UID: 0 PID: 1 Comm: shutdown Tainted: G        W
6.14.0+ #2 PREEMPT(undef)  271a3d276f79e3bb26d6065917556e94aae0d88d
Tainted: [W]=3DWARN
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/20=
21
RIP: 0010:rtnl_fill_ifinfo.constprop.0 (net/core/rtnetlink.c:2029)
Code: 6c c3 42 09 00 0f 85 14 e4 ff ff ba ed 07 00 00 48 c7 c6 20 1d
fe a3 48 c7 c7 60 1d fe a3 c6 05 4c c3 42 09 01 e8 f5 19 30 fe <0f> 0b
e99
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   6c                      insb   (%dx),%es:(%rdi)
   1:   c3                      ret
   2:   42 09 00                rex.X or %eax,(%rax)
   5:   0f 85 14 e4 ff ff       jne    0xffffffffffffe41f
   b:   ba ed 07 00 00          mov    $0x7ed,%edx
  10:   48 c7 c6 20 1d fe a3    mov    $0xffffffffa3fe1d20,%rsi
  17:   48 c7 c7 60 1d fe a3    mov    $0xffffffffa3fe1d60,%rdi
  1e:   c6 05 4c c3 42 09 01    movb   $0x1,0x942c34c(%rip)        # 0x942c=
371
  25:   e8 f5 19 30 fe          call   0xfffffffffe301a1f
  2a:*  0f 0b                   ud2             <-- trapping instruction
  2c:   99                      cltd

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   0f 0b                   ud2
   2:   99                      cltd
RSP: 0018:ffff888104e2f890 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000010 RCX: 0000000000000000
RDX: 0000000000000002 RSI: 0000000000000004 RDI: 0000000000000001
RBP: ffff88881be2ef00 R08: 0000000000000000 R09: fffffbfff49a4af4
R10: 0000000000000003 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: ffff888178e24000 R15: ffff888178e24108
FS:  00007f7f27cb4440(0000) GS:ffff88886dc22000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc65d6b0cc CR3: 00000001d73de000 CR4: 00000000007506f0
PKRU: 55555554
Call Trace:
<TASK>
? __warn (kernel/panic.c:748)
? __pfx_vprintk_emit.part.0 (kernel/printk/printk.c:2378)
? rtnl_fill_ifinfo.constprop.0 (net/core/rtnetlink.c:2029)
? report_bug (lib/bug.c:201 lib/bug.c:219)
? rtnl_fill_ifinfo.constprop.0 (net/core/rtnetlink.c:2029)
? handle_bug (arch/x86/kernel/traps.c:337)
? exc_invalid_op (arch/x86/kernel/traps.c:391 (discriminator 1))
? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:578)
? rtnl_fill_ifinfo.constprop.0 (net/core/rtnetlink.c:2029)
? mark_held_locks (kernel/locking/lockdep.c:4326)
? _raw_spin_unlock_irqrestore (./include/linux/spinlock_api_smp.h:151
kernel/locking/spinlock.c:194)
? lockdep_hardirqs_on (kernel/locking/lockdep.c:4476 (discriminator 3))
? __pfx_rtnl_fill_ifinfo.constprop.0 (net/core/rtnetlink.c:2017)
? rcu_is_watching (./include/linux/context_tracking.h:128 kernel/rcu/tree.c=
:736)
? __kmalloc_node_track_caller_noprof (./include/trace/events/kmem.h:54
mm/slub.c:4319 mm/slub.c:4337)
? __alloc_skb (net/core/skbuff.c:668)
? rcu_is_watching (./include/linux/context_tracking.h:128 kernel/rcu/tree.c=
:736)
? kmalloc_reserve (net/core/skbuff.c:602)
? __build_skb_around (./arch/x86/include/asm/atomic.h:28
./include/linux/atomic/atomic-arch-fallback.h:503
./include/linux/atomic/atomic-instrumented.h:68 net/core/skbuff.c:380
net/core/skbuff.c:438)
? __alloc_skb (net/core/skbuff.c:684)
? __pfx___alloc_skb (net/core/skbuff.c:641)
? lockdep_rcu_suspicious (./include/linux/context_tracking.h:159
kernel/locking/lockdep.c:6864)
rtmsg_ifinfo_build_skb (net/core/rtnetlink.c:4409)
rtmsg_ifinfo (net/core/rtnetlink.c:4442 net/core/rtnetlink.c:4432
net/core/rtnetlink.c:4451)
dev_close_many (net/core/dev.c:2285 net/core/dev.c:2299 net/core/dev.c:1788=
)
? __pfx_dev_close_many (net/core/dev.c:1776)
netif_close (./include/linux/list.h:124 ./include/linux/list.h:215
./include/linux/list.h:229 net/core/dev.c:1802 net/core/dev.c:1795)
? __pfx_netif_close (net/core/dev.c:1796)
? mark_held_locks (kernel/locking/lockdep.c:4326)
bnxt_shutdown (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16707) bnxt_en
pci_device_shutdown (drivers/pci/pci-driver.c:511)
device_shutdown (drivers/base/core.c:4820)
kernel_restart (kernel/reboot.c:271 kernel/reboot.c:285)
__do_sys_reboot (kernel/reboot.c:763)
? __pfx___do_sys_reboot (kernel/reboot.c:725)
? rseq_get_rseq_cs (kernel/rseq.c:310)
? rseq_syscall (kernel/rseq.c:465)
? __pfx_rseq_syscall (kernel/rseq.c:458)
? do_writev (fs/read_write.c:1101)
? __pfx_do_writev (fs/read_write.c:1091)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f7f28830a07
Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f
1e fa 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d
008
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   c7 c0 ff ff ff ff       mov    $0xffffffff,%eax
   6:   eb be                   jmp    0xffffffffffffffc6
   8:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
   f:   00 00 00
  12:   90                      nop
  13:   f3 0f 1e fa             endbr64
  17:   89 fa                   mov    %edi,%edx
  19:   be 69 19 12 28          mov    $0x28121969,%esi
  1e:   bf ad de e1 fe          mov    $0xfee1dead,%edi
  23:   b8 a9 00 00 00          mov    $0xa9,%eax
  28:   0f 05                   syscall
  2a:*  48                      rex.W           <-- trapping instruction
  2b:   3d                      .byte 0x3d
  2c:   08                      .byte 0x8

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   48                      rex.W
   1:   3d                      .byte 0x3d
   2:   08                      .byte 0x8
RSP: 002b:00007ffc65d6b1a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a9
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7f28830a07
RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
RBP: 00007ffc65d6b3e0 R08: 0000000000000069 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000001234567
</TASK>
irq event stamp: 12752209
hardirqs last enabled at (12752221): __up_console_sem
(kernel/printk/printk.c:344 (discriminator 1))
hardirqs last disabled at (12752254): __up_console_sem
(kernel/printk/printk.c:342 (discriminator 1))
softirqs last enabled at (12752286): __irq_exit_rcu
(kernel/softirq.c:596 kernel/softirq.c:435 kernel/softirq.c:662)
softirqs last disabled at (12752299): __irq_exit_rcu
(kernel/softirq.c:596 kernel/softirq.c:435 kernel/softirq.c:662)
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
RTNL: assertion failed at net/devlink/port.c (1596)
WARNING: CPU: 0 PID: 1 at net/devlink/port.c:1596
devlink_compat_phys_port_name_get (net/devlink/port.c:1596
(discriminator 3))
Modules linked in: xt_nat xt_tcpudp veth xt_conntrack nft_chain_nat
xt_MASQUERADE nf_conntrack_netlink xfrm_user xt_addrtype nft_compat
nf_tabs
CPU: 0 UID: 0 PID: 1 Comm: shutdown Tainted: G        W
6.14.0+ #2 PREEMPT(undef)  271a3d276f79e3bb26d6065917556e94aae0d88d
Tainted: [W]=3DWARN
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/20=
21
RIP: 0010:devlink_compat_phys_port_name_get (net/devlink/port.c:1596
(discriminator 3))
Code: 57 6a d0 08 00 0f 85 48 fb ff ff ba 3c 06 00 00 48 c7 c6 80 f1
07 a4 48 c7 c7 a0 f2 07 a4 c6 05 37 6a d0 08 01 e8 f2 bf bd fd <0f> 0b
e9c
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   57                      push   %rdi
   1:   6a d0                   push   $0xffffffffffffffd0
   3:   08 00                   or     %al,(%rax)
   5:   0f 85 48 fb ff ff       jne    0xfffffffffffffb53
   b:   ba 3c 06 00 00          mov    $0x63c,%edx
  10:   48 c7 c6 80 f1 07 a4    mov    $0xffffffffa407f180,%rsi
  17:   48 c7 c7 a0 f2 07 a4    mov    $0xffffffffa407f2a0,%rdi
  1e:   c6 05 37 6a d0 08 01    movb   $0x1,0x8d06a37(%rip)        # 0x8d06=
a5c
  25:   e8 f2 bf bd fd          call   0xfffffffffdbdc01c
  2a:*  0f 0b                   ud2             <-- trapping instruction
  2c:   9c                      pushf

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   0f 0b                   ud2
   2:   9c                      pushf
RSP: 0018:ffff888104e2f858 EFLAGS: 00010292
RAX: 0000000000000000 RBX: ffff888178e24000 RCX: 0000000000000000
RDX: 0000000000000002 RSI: 0000000000000004 RDI: 0000000000000001
RBP: 0000000000000010 R08: 0000000000000000 R09: fffffbfff49a4af4
R10: 0000000000000003 R11: 0000000000000001 R12: ffff888104e2fa28
R13: ffff888104e2f9b8 R14: ffff888178e24000 R15: ffff888104e2f938
FS:  00007f7f27cb4440(0000) GS:ffff88886dc22000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc65d6b0cc CR3: 00000001d73de000 CR4: 00000000007506f0
PKRU: 55555554
Call Trace:
<TASK>
? __warn (kernel/panic.c:748)
? devlink_compat_phys_port_name_get (net/devlink/port.c:1596 (discriminator=
 3))
? report_bug (lib/bug.c:201 lib/bug.c:219)
? devlink_compat_phys_port_name_get (net/devlink/port.c:1596 (discriminator=
 3))
? handle_bug (arch/x86/kernel/traps.c:337)
? exc_invalid_op (arch/x86/kernel/traps.c:391 (discriminator 1))
? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:578)
? devlink_compat_phys_port_name_get (net/devlink/port.c:1596 (discriminator=
 3))
? devlink_compat_phys_port_name_get (net/devlink/port.c:1596 (discriminator=
 3))
rtnl_fill_ifinfo.constprop.0 (net/core/rtnetlink.c:1432
net/core/rtnetlink.c:2112)
? _raw_spin_unlock_irqrestore (./include/linux/spinlock_api_smp.h:151
kernel/locking/spinlock.c:194)
? lockdep_hardirqs_on (kernel/locking/lockdep.c:4476 (discriminator 3))
? __pfx_rtnl_fill_ifinfo.constprop.0 (net/core/rtnetlink.c:2017)
? rcu_is_watching (./include/linux/context_tracking.h:128 kernel/rcu/tree.c=
:736)
? __alloc_skb (net/core/skbuff.c:668)
? rcu_is_watching (./include/linux/context_tracking.h:128 kernel/rcu/tree.c=
:736)
? kmalloc_reserve (net/core/skbuff.c:602)
? __build_skb_around (./arch/x86/include/asm/atomic.h:28
./include/linux/atomic/atomic-arch-fallback.h:503
./include/linux/atomic/atomic-instrumented.h:68 net/core/skbuff.c:380
net/core/skbuff.c:438)
? __alloc_skb (net/core/skbuff.c:684)
? __pfx___alloc_skb (net/core/skbuff.c:641)
? lockdep_rcu_suspicious (./include/linux/context_tracking.h:159
kernel/locking/lockdep.c:6864)
rtmsg_ifinfo_build_skb (net/core/rtnetlink.c:4409)
rtmsg_ifinfo (net/core/rtnetlink.c:4442 net/core/rtnetlink.c:4432
net/core/rtnetlink.c:4451)
dev_close_many (net/core/dev.c:2285 net/core/dev.c:2299 net/core/dev.c:1788=
)
? __pfx_dev_close_many (net/core/dev.c:1776)
netif_close (./include/linux/list.h:124 ./include/linux/list.h:215
./include/linux/list.h:229 net/core/dev.c:1802 net/core/dev.c:1795)
? __pfx_netif_close (net/core/dev.c:1796)
? mark_held_locks (kernel/locking/lockdep.c:4326)
bnxt_shutdown (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16707) bnxt_en
pci_device_shutdown (drivers/pci/pci-driver.c:511)
device_shutdown (drivers/base/core.c:4820)
kernel_restart (kernel/reboot.c:271 kernel/reboot.c:285)
__do_sys_reboot (kernel/reboot.c:763)
? __pfx___do_sys_reboot (kernel/reboot.c:725)
? rseq_get_rseq_cs (kernel/rseq.c:310)
? rseq_syscall (kernel/rseq.c:465)
? __pfx_rseq_syscall (kernel/rseq.c:458)
? do_writev (fs/read_write.c:1101)
? __pfx_do_writev (fs/read_write.c:1091)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f7f28830a07
Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f
1e fa 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d
008
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   c7 c0 ff ff ff ff       mov    $0xffffffff,%eax
   6:   eb be                   jmp    0xffffffffffffffc6
   8:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
   f:   00 00 00
  12:   90                      nop
  13:   f3 0f 1e fa             endbr64
  17:   89 fa                   mov    %edi,%edx
  19:   be 69 19 12 28          mov    $0x28121969,%esi
  1e:   bf ad de e1 fe          mov    $0xfee1dead,%edi
  23:   b8 a9 00 00 00          mov    $0xa9,%eax
  28:   0f 05                   syscall
  2a:*  48                      rex.W           <-- trapping instruction
  2b:   3d                      .byte 0x3d
  2c:   08                      .byte 0x8

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   48                      rex.W
   1:   3d                      .byte 0x3d
   2:   08                      .byte 0x8
RSP: 002b:00007ffc65d6b1a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a9
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7f28830a07
RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
RBP: 00007ffc65d6b3e0 R08: 0000000000000069 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000001234567
</TASK>
irq event stamp: 12755161
hardirqs last enabled at (12755173): __up_console_sem
(kernel/printk/printk.c:344 (discriminator 1))
hardirqs last disabled at (12755206): __up_console_sem
(kernel/printk/printk.c:342 (discriminator 1))
softirqs last enabled at (12755236): __irq_exit_rcu
(kernel/softirq.c:596 kernel/softirq.c:435 kernel/softirq.c:662)
softirqs last disabled at (12755249): __irq_exit_rcu
(kernel/softirq.c:596 kernel/softirq.c:435 kernel/softirq.c:662)
---[ end trace 0000000000000000 ]---

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: suspicious RCU usage
6.14.0+ #2 Tainted: G        W
-----------------------------
net/mctp/device.c:48 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active =3D 2, debug_locks =3D 1
5 locks held by shutdown/1:
#0: ffffffffa4d58750 (system_transition_mutex){+.+.}-{4:4}, at:
__do_sys_reboot (kernel/reboot.c:760)
#1: ffff888114d0c1b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/device.h:922 drivers/base/core.c:4802)
#2: ffff8881152211b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/pm_runtime.h:121 drivers/base/core.c:4805)
#3: ffff888178e24d90 (&dev->lock){+.+.}-{4:4}, at: bnxt_shutdown
(drivers/net/ethernet/broadcom/bnxt/bnxt.c:16703) bnxt_en
#4: ffffffffabda0e60 (rcu_read_lock){....}-{1:3}, at:
rtnl_fill_ifinfo.constprop.0 (./include/linux/rcupdate.h:331
./include/linux/rcupdate.h:841 net/core/rtnetlink.c:2146)

stack backtrace:
CPU: 0 UID: 0 PID: 1 Comm: shutdown Tainted: G        W
6.14.0+ #2 PREEMPT(undef)  271a3d276f79e3bb26d6065917556e94aae0d88d
Tainted: [W]=3DWARN
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/20=
21
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:123)
lockdep_rcu_suspicious (kernel/locking/lockdep.c:6863)
mctp_dev_get_rtnl (net/mctp/device.c:48 (discriminator 7))
mctp_fill_link_af (net/mctp/device.c:355)
? __pfx_mctp_fill_link_af (net/mctp/device.c:351)
? nla_put (lib/nlattr.c:1100)
rtnl_fill_ifinfo.constprop.0 (net/core/rtnetlink.c:1886
net/core/rtnetlink.c:2152)
? lockdep_hardirqs_on (kernel/locking/lockdep.c:4476 (discriminator 3))
? __pfx_rtnl_fill_ifinfo.constprop.0 (net/core/rtnetlink.c:2017)
? rcu_is_watching (./include/linux/context_tracking.h:128 kernel/rcu/tree.c=
:736)
? __alloc_skb (net/core/skbuff.c:668)
? rcu_is_watching (./include/linux/context_tracking.h:128 kernel/rcu/tree.c=
:736)
? __build_skb_around (./arch/x86/include/asm/atomic.h:28
./include/linux/atomic/atomic-arch-fallback.h:503
./include/linux/atomic/atomic-instrumented.h:68 net/core/skbuff.c:380
net/core/skbuff.c:438)
? __alloc_skb (net/core/skbuff.c:684)
? __pfx___alloc_skb (net/core/skbuff.c:641)
? lockdep_rcu_suspicious (./include/linux/context_tracking.h:159
kernel/locking/lockdep.c:6864)
rtmsg_ifinfo_build_skb (net/core/rtnetlink.c:4409)
rtmsg_ifinfo (net/core/rtnetlink.c:4442 net/core/rtnetlink.c:4432
net/core/rtnetlink.c:4451)
dev_close_many (net/core/dev.c:2285 net/core/dev.c:2299 net/core/dev.c:1788=
)
? __pfx_dev_close_many (net/core/dev.c:1776)
netif_close (./include/linux/list.h:124 ./include/linux/list.h:215
./include/linux/list.h:229 net/core/dev.c:1802 net/core/dev.c:1795)
? __pfx_netif_close (net/core/dev.c:1796)
? mark_held_locks (kernel/locking/lockdep.c:4326)
bnxt_shutdown (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16707) bnxt_en
pci_device_shutdown (drivers/pci/pci-driver.c:511)
device_shutdown (drivers/base/core.c:4820)
kernel_restart (kernel/reboot.c:271 kernel/reboot.c:285)
__do_sys_reboot (kernel/reboot.c:763)
? __pfx___do_sys_reboot (kernel/reboot.c:725)
? rseq_get_rseq_cs (kernel/rseq.c:310)
? rseq_syscall (kernel/rseq.c:465)
? __pfx_rseq_syscall (kernel/rseq.c:458)
? do_writev (fs/read_write.c:1101)
? __pfx_do_writev (fs/read_write.c:1091)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f7f28830a07
Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f
1e fa 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d
008
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   c7 c0 ff ff ff ff       mov    $0xffffffff,%eax
   6:   eb be                   jmp    0xffffffffffffffc6
   8:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
   f:   00 00 00
  12:   90                      nop
  13:   f3 0f 1e fa             endbr64
  17:   89 fa                   mov    %edi,%edx
  19:   be 69 19 12 28          mov    $0x28121969,%esi
  1e:   bf ad de e1 fe          mov    $0xfee1dead,%edi
  23:   b8 a9 00 00 00          mov    $0xa9,%eax
  28:   0f 05                   syscall
  2a:*  48                      rex.W           <-- trapping instruction
  2b:   3d                      .byte 0x3d
  2c:   08                      .byte 0x8

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   48                      rex.W
   1:   3d                      .byte 0x3d
   2:   08                      .byte 0x8
RSP: 002b:00007ffc65d6b1a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a9
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7f28830a07
RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
RBP: 00007ffc65d6b3e0 R08: 0000000000000069 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000001234567
</TASK>
------------[ cut here ]------------
RTNL: assertion failed at net/ipv4/igmp.c (1826)
WARNING: CPU: 0 PID: 1 at net/ipv4/igmp.c:1826 ip_mc_down
(net/ipv4/igmp.c:1826 (discriminator 3))
Modules linked in: xt_nat xt_tcpudp veth xt_conntrack nft_chain_nat
xt_MASQUERADE nf_conntrack_netlink xfrm_user xt_addrtype nft_compat
nf_tabs
CPU: 0 UID: 0 PID: 1 Comm: shutdown Tainted: G        W
6.14.0+ #2 PREEMPT(undef)  271a3d276f79e3bb26d6065917556e94aae0d88d
Tainted: [W]=3DWARN
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/20=
21
RIP: 0010:ip_mc_down (net/ipv4/igmp.c:1826 (discriminator 3))
Code: 5b 39 09 09 00 0f 85 e7 fd ff ff ba 22 07 00 00 48 c7 c6 00 8e
02 a4 48 c7 c7 80 8f 02 a4 c6 05 3b 39 09 09 01 e8 4f 8f f6 fd <0f> 0b
e9e
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   5b                      pop    %rbx
   1:   39 09                   cmp    %ecx,(%rcx)
   3:   09 00                   or     %eax,(%rax)
   5:   0f 85 e7 fd ff ff       jne    0xfffffffffffffdf2
   b:   ba 22 07 00 00          mov    $0x722,%edx
  10:   48 c7 c6 00 8e 02 a4    mov    $0xffffffffa4028e00,%rsi
  17:   48 c7 c7 80 8f 02 a4    mov    $0xffffffffa4028f80,%rdi
  1e:   c6 05 3b 39 09 09 01    movb   $0x1,0x909393b(%rip)        # 0x9093=
960
  25:   e8 4f 8f f6 fd          call   0xfffffffffdf68f79
  2a:*  0f 0b                   ud2             <-- trapping instruction
  2c:   9e                      sahf

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   0f 0b                   ud2
   2:   9e                      sahf
RSP: 0018:ffff888104e2fa10 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 1ffff110209c5f4e RCX: 0000000000000000
RDX: 0000000000000002 RSI: 0000000000000004 RDI: 0000000000000001
RBP: ffff8881a3141000 R08: 0000000000000000 R09: fffffbfff49a4af4
R10: 0000000000000003 R11: 0000000000000001 R12: ffff888178e24000
R13: ffff8881a3141000 R14: 0000000000000002 R15: ffff888178e24420
FS:  00007f7f27cb4440(0000) GS:ffff88886dc22000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc65d6b0cc CR3: 00000001d73de000 CR4: 00000000007506f0
PKRU: 55555554
Call Trace:
<TASK>
? __warn (kernel/panic.c:748)
? __pfx_vprintk_emit.part.0 (kernel/printk/printk.c:2378)
? ip_mc_down (net/ipv4/igmp.c:1826 (discriminator 3))
? report_bug (lib/bug.c:201 lib/bug.c:219)
? ip_mc_down (net/ipv4/igmp.c:1826 (discriminator 3))
? handle_bug (arch/x86/kernel/traps.c:337)
? exc_invalid_op (arch/x86/kernel/traps.c:391 (discriminator 1))
? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:578)
? ip_mc_down (net/ipv4/igmp.c:1826 (discriminator 3))
inetdev_event (net/ipv4/devinet.c:1669)
? _raw_spin_unlock_irqrestore (./arch/x86/include/asm/preempt.h:104
./include/linux/spinlock_api_smp.h:152 kernel/locking/spinlock.c:194)
? __wake_up (kernel/sched/wait.c:110 kernel/sched/wait.c:127)
? __pfx_inetdev_event (net/ipv4/devinet.c:1583)
? nexthop_flush_dev (./include/net/net_namespace.h:409
./include/linux/netdevice.h:2709 net/ipv4/nexthop.c:2653)
? nh_netdev_event (net/ipv4/nexthop.c:3878)
? notifier_call_chain (kernel/notifier.c:85)
notifier_call_chain (kernel/notifier.c:85)
dev_close_many (net/core/dev.c:1789)
? __pfx_dev_close_many (net/core/dev.c:1776)
netif_close (./include/linux/list.h:124 ./include/linux/list.h:215
./include/linux/list.h:229 net/core/dev.c:1802 net/core/dev.c:1795)
? __pfx_netif_close (net/core/dev.c:1796)
? mark_held_locks (kernel/locking/lockdep.c:4326)
bnxt_shutdown (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16707) bnxt_en
pci_device_shutdown (drivers/pci/pci-driver.c:511)
device_shutdown (drivers/base/core.c:4820)
kernel_restart (kernel/reboot.c:271 kernel/reboot.c:285)
__do_sys_reboot (kernel/reboot.c:763)
? __pfx___do_sys_reboot (kernel/reboot.c:725)
? rseq_get_rseq_cs (kernel/rseq.c:310)
? rseq_syscall (kernel/rseq.c:465)
? __pfx_rseq_syscall (kernel/rseq.c:458)
? do_writev (fs/read_write.c:1101)
? __pfx_do_writev (fs/read_write.c:1091)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f7f28830a07
Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f
1e fa 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d
008
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   c7 c0 ff ff ff ff       mov    $0xffffffff,%eax
   6:   eb be                   jmp    0xffffffffffffffc6
   8:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
   f:   00 00 00
  12:   90                      nop
  13:   f3 0f 1e fa             endbr64
  17:   89 fa                   mov    %edi,%edx
  19:   be 69 19 12 28          mov    $0x28121969,%esi
  1e:   bf ad de e1 fe          mov    $0xfee1dead,%edi
  23:   b8 a9 00 00 00          mov    $0xa9,%eax
  28:   0f 05                   syscall
  2a:*  48                      rex.W           <-- trapping instruction
  2b:   3d                      .byte 0x3d
  2c:   08                      .byte 0x8

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   48                      rex.W
   1:   3d                      .byte 0x3d
   2:   08                      .byte 0x8
RSP: 002b:00007ffc65d6b1a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a9
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7f28830a07
RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
RBP: 00007ffc65d6b3e0 R08: 0000000000000069 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000001234567
</TASK>
irq event stamp: 12757803
hardirqs last enabled at (12757815): __up_console_sem
(kernel/printk/printk.c:344 (discriminator 1))
hardirqs last disabled at (12757826): __up_console_sem
(kernel/printk/printk.c:342 (discriminator 1))
softirqs last enabled at (12757708): __irq_exit_rcu
(kernel/softirq.c:596 kernel/softirq.c:435 kernel/softirq.c:662)
softirqs last disabled at (12757703): __irq_exit_rcu
(kernel/softirq.c:596 kernel/softirq.c:435 kernel/softirq.c:662)
---[ end trace 0000000000000000 ]---

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: suspicious RCU usage
6.14.0+ #2 Tainted: G        W
-----------------------------
net/ipv4/igmp.c:1828 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active =3D 2, debug_locks =3D 1
4 locks held by shutdown/1:
#0: ffffffffa4d58750 (system_transition_mutex){+.+.}-{4:4}, at:
__do_sys_reboot (kernel/reboot.c:760)
#1: ffff888114d0c1b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/device.h:922 drivers/base/core.c:4802)
#2: ffff8881152211b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/pm_runtime.h:121 drivers/base/core.c:4805)
#3: ffff888178e24d90 (&dev->lock){+.+.}-{4:4}, at: bnxt_shutdown
(drivers/net/ethernet/broadcom/bnxt/bnxt.c:16703) bnxt_en

stack backtrace:
CPU: 0 UID: 0 PID: 1 Comm: shutdown Tainted: G        W
6.14.0+ #2 PREEMPT(undef)  271a3d276f79e3bb26d6065917556e94aae0d88d
Tainted: [W]=3DWARN
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/20=
21
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:123)
lockdep_rcu_suspicious (kernel/locking/lockdep.c:6863)
ip_mc_down (net/ipv4/igmp.c:1828 (discriminator 7))
inetdev_event (net/ipv4/devinet.c:1669)
? _raw_spin_unlock_irqrestore (./arch/x86/include/asm/preempt.h:104
./include/linux/spinlock_api_smp.h:152 kernel/locking/spinlock.c:194)
? __wake_up (kernel/sched/wait.c:110 kernel/sched/wait.c:127)
? __pfx_inetdev_event (net/ipv4/devinet.c:1583)
? nexthop_flush_dev (./include/net/net_namespace.h:409
./include/linux/netdevice.h:2709 net/ipv4/nexthop.c:2653)
? nh_netdev_event (net/ipv4/nexthop.c:3878)
? notifier_call_chain (kernel/notifier.c:85)
notifier_call_chain (kernel/notifier.c:85)
dev_close_many (net/core/dev.c:1789)
? __pfx_dev_close_many (net/core/dev.c:1776)
netif_close (./include/linux/list.h:124 ./include/linux/list.h:215
./include/linux/list.h:229 net/core/dev.c:1802 net/core/dev.c:1795)
? __pfx_netif_close (net/core/dev.c:1796)
? mark_held_locks (kernel/locking/lockdep.c:4326)
bnxt_shutdown (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16707) bnxt_en
pci_device_shutdown (drivers/pci/pci-driver.c:511)
device_shutdown (drivers/base/core.c:4820)
kernel_restart (kernel/reboot.c:271 kernel/reboot.c:285)
__do_sys_reboot (kernel/reboot.c:763)
? __pfx___do_sys_reboot (kernel/reboot.c:725)
? rseq_get_rseq_cs (kernel/rseq.c:310)
? rseq_syscall (kernel/rseq.c:465)
? __pfx_rseq_syscall (kernel/rseq.c:458)
? do_writev (fs/read_write.c:1101)
? __pfx_do_writev (fs/read_write.c:1091)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f7f28830a07
Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f
1e fa 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d
008
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   c7 c0 ff ff ff ff       mov    $0xffffffff,%eax
   6:   eb be                   jmp    0xffffffffffffffc6
   8:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
   f:   00 00 00
  12:   90                      nop
  13:   f3 0f 1e fa             endbr64
  17:   89 fa                   mov    %edi,%edx
  19:   be 69 19 12 28          mov    $0x28121969,%esi
  1e:   bf ad de e1 fe          mov    $0xfee1dead,%edi
  23:   b8 a9 00 00 00          mov    $0xa9,%eax
  28:   0f 05                   syscall
  2a:*  48                      rex.W           <-- trapping instruction
  2b:   3d                      .byte 0x3d
  2c:   08                      .byte 0x8

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   48                      rex.W
   1:   3d                      .byte 0x3d
   2:   08                      .byte 0x8
RSP: 002b:00007ffc65d6b1a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a9
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7f28830a07
RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
RBP: 00007ffc65d6b3e0 R08: 0000000000000069 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000001234567
</TASK>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: suspicious RCU usage
6.14.0+ #2 Tainted: G        W
-----------------------------
net/ipv4/igmp.c:1828 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active =3D 2, debug_locks =3D 1
4 locks held by shutdown/1:
#0: ffffffffa4d58750 (system_transition_mutex){+.+.}-{4:4}, at:
__do_sys_reboot (kernel/reboot.c:760)
#1: ffff888114d0c1b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/device.h:922 drivers/base/core.c:4802)
#2: ffff8881152211b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/pm_runtime.h:121 drivers/base/core.c:4805)
#3: ffff888178e24d90 (&dev->lock){+.+.}-{4:4}, at: bnxt_shutdown
(drivers/net/ethernet/broadcom/bnxt/bnxt.c:16703) bnxt_en

stack backtrace:
CPU: 0 UID: 0 PID: 1 Comm: shutdown Tainted: G        W
6.14.0+ #2 PREEMPT(undef)  271a3d276f79e3bb26d6065917556e94aae0d88d
Tainted: [W]=3DWARN
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/20=
21
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:123)
lockdep_rcu_suspicious (kernel/locking/lockdep.c:6863)
ip_mc_down (net/ipv4/igmp.c:1828 (discriminator 17))
inetdev_event (net/ipv4/devinet.c:1669)
? _raw_spin_unlock_irqrestore (./arch/x86/include/asm/preempt.h:104
./include/linux/spinlock_api_smp.h:152 kernel/locking/spinlock.c:194)
? __wake_up (kernel/sched/wait.c:110 kernel/sched/wait.c:127)
? __pfx_inetdev_event (net/ipv4/devinet.c:1583)
? nexthop_flush_dev (./include/net/net_namespace.h:409
./include/linux/netdevice.h:2709 net/ipv4/nexthop.c:2653)
? nh_netdev_event (net/ipv4/nexthop.c:3878)
? notifier_call_chain (kernel/notifier.c:85)
notifier_call_chain (kernel/notifier.c:85)
dev_close_many (net/core/dev.c:1789)
? __pfx_dev_close_many (net/core/dev.c:1776)
netif_close (./include/linux/list.h:124 ./include/linux/list.h:215
./include/linux/list.h:229 net/core/dev.c:1802 net/core/dev.c:1795)
? __pfx_netif_close (net/core/dev.c:1796)
? mark_held_locks (kernel/locking/lockdep.c:4326)
bnxt_shutdown (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16707) bnxt_en
pci_device_shutdown (drivers/pci/pci-driver.c:511)
device_shutdown (drivers/base/core.c:4820)
kernel_restart (kernel/reboot.c:271 kernel/reboot.c:285)
__do_sys_reboot (kernel/reboot.c:763)
? __pfx___do_sys_reboot (kernel/reboot.c:725)
? rseq_get_rseq_cs (kernel/rseq.c:310)
? rseq_syscall (kernel/rseq.c:465)
? __pfx_rseq_syscall (kernel/rseq.c:458)
? do_writev (fs/read_write.c:1101)
? __pfx_do_writev (fs/read_write.c:1091)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f7f28830a07
Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f
1e fa 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d
008
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   c7 c0 ff ff ff ff       mov    $0xffffffff,%eax
   6:   eb be                   jmp    0xffffffffffffffc6
   8:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
   f:   00 00 00
  12:   90                      nop
  13:   f3 0f 1e fa             endbr64
  17:   89 fa                   mov    %edi,%edx
  19:   be 69 19 12 28          mov    $0x28121969,%esi
  1e:   bf ad de e1 fe          mov    $0xfee1dead,%edi
  23:   b8 a9 00 00 00          mov    $0xa9,%eax
  28:   0f 05                   syscall
  2a:*  48                      rex.W           <-- trapping instruction
  2b:   3d                      .byte 0x3d
  2c:   08                      .byte 0x8

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   48                      rex.W
   1:   3d                      .byte 0x3d
   2:   08                      .byte 0x8
RSP: 002b:00007ffc65d6b1a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a9
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7f28830a07
RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
RBP: 00007ffc65d6b3e0 R08: 0000000000000069 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000001234567
</TASK>
------------[ cut here ]------------
RTNL: assertion failed at net/ipv4/igmp.c (1767)
WARNING: CPU: 0 PID: 1 at net/ipv4/igmp.c:1767 __ip_mc_dec_group
(net/ipv4/igmp.c:1767 (discriminator 3))
Modules linked in: xt_nat xt_tcpudp veth xt_conntrack nft_chain_nat
xt_MASQUERADE nf_conntrack_netlink xfrm_user xt_addrtype nft_compat
nf_tabs
CPU: 0 UID: 0 PID: 1 Comm: shutdown Tainted: G        W
6.14.0+ #2 PREEMPT(undef)  271a3d276f79e3bb26d6065917556e94aae0d88d
Tainted: [W]=3DWARN
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/20=
21
RIP: 0010:__ip_mc_dec_group (net/ipv4/igmp.c:1767 (discriminator 3))
Code: b6 44 09 09 00 0f 85 2f fe ff ff ba e7 06 00 00 48 c7 c6 00 8e
02 a4 48 c7 c7 80 8f 02 a4 c6 05 96 44 09 09 01 e8 a7 9a f6 fd <0f> 0b
e98
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   b6 44                   mov    $0x44,%dh
   2:   09 09                   or     %ecx,(%rcx)
   4:   00 0f                   add    %cl,(%rdi)
   6:   85 2f                   test   %ebp,(%rdi)
   8:   fe                      (bad)
   9:   ff                      (bad)
   a:   ff                      (bad)
   b:   ba e7 06 00 00          mov    $0x6e7,%edx
  10:   48 c7 c6 00 8e 02 a4    mov    $0xffffffffa4028e00,%rsi
  17:   48 c7 c7 80 8f 02 a4    mov    $0xffffffffa4028f80,%rdi
  1e:   c6 05 96 44 09 09 01    movb   $0x1,0x9094496(%rip)        # 0x9094=
4bb
  25:   e8 a7 9a f6 fd          call   0xfffffffffdf69ad1
  2a:*  0f 0b                   ud2             <-- trapping instruction
  2c:   98                      cwtl

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   0f 0b                   ud2
   2:   98                      cwtl
RSP: 0018:ffff888104e2f9f0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 1ffff110209c5f4e RCX: 0000000000000000
RDX: 0000000000000002 RSI: 0000000000000004 RDI: 0000000000000001
RBP: ffff888104e2fb00 R08: 0000000000000000 R09: fffffbfff49a4af4
R10: 0000000000000003 R11: 0000000000000001 R12: ffff888178e24000
R13: 00000000010000e0 R14: ffff8881a3141000 R15: 0000000000000cc0
FS:  00007f7f27cb4440(0000) GS:ffff88886dc22000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc65d6b0cc CR3: 00000001d73de000 CR4: 00000000007506f0
PKRU: 55555554
Call Trace:
<TASK>
? __warn (kernel/panic.c:748)
? __pfx_vprintk_emit.part.0 (kernel/printk/printk.c:2378)
? __ip_mc_dec_group (net/ipv4/igmp.c:1767 (discriminator 3))
? report_bug (lib/bug.c:201 lib/bug.c:219)
? __ip_mc_dec_group (net/ipv4/igmp.c:1767 (discriminator 3))
? handle_bug (arch/x86/kernel/traps.c:337)
? exc_invalid_op (arch/x86/kernel/traps.c:391 (discriminator 1))
? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:578)
? __ip_mc_dec_group (net/ipv4/igmp.c:1767 (discriminator 3))
inetdev_event (net/ipv4/devinet.c:1669)
? _raw_spin_unlock_irqrestore (./arch/x86/include/asm/preempt.h:104
./include/linux/spinlock_api_smp.h:152 kernel/locking/spinlock.c:194)
? __wake_up (kernel/sched/wait.c:110 kernel/sched/wait.c:127)
? __pfx_inetdev_event (net/ipv4/devinet.c:1583)
? nexthop_flush_dev (./include/net/net_namespace.h:409
./include/linux/netdevice.h:2709 net/ipv4/nexthop.c:2653)
? nh_netdev_event (net/ipv4/nexthop.c:3878)
? notifier_call_chain (kernel/notifier.c:85)
notifier_call_chain (kernel/notifier.c:85)
dev_close_many (net/core/dev.c:1789)
? __pfx_dev_close_many (net/core/dev.c:1776)
netif_close (./include/linux/list.h:124 ./include/linux/list.h:215
./include/linux/list.h:229 net/core/dev.c:1802 net/core/dev.c:1795)
? __pfx_netif_close (net/core/dev.c:1796)
? mark_held_locks (kernel/locking/lockdep.c:4326)
bnxt_shutdown (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16707) bnxt_en
pci_device_shutdown (drivers/pci/pci-driver.c:511)
device_shutdown (drivers/base/core.c:4820)
kernel_restart (kernel/reboot.c:271 kernel/reboot.c:285)
__do_sys_reboot (kernel/reboot.c:763)
? __pfx___do_sys_reboot (kernel/reboot.c:725)
? rseq_get_rseq_cs (kernel/rseq.c:310)
? rseq_syscall (kernel/rseq.c:465)
? __pfx_rseq_syscall (kernel/rseq.c:458)
? do_writev (fs/read_write.c:1101)
? __pfx_do_writev (fs/read_write.c:1091)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f7f28830a07
Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f
1e fa 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d
008
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   c7 c0 ff ff ff ff       mov    $0xffffffff,%eax
   6:   eb be                   jmp    0xffffffffffffffc6
   8:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
   f:   00 00 00
  12:   90                      nop
  13:   f3 0f 1e fa             endbr64
  17:   89 fa                   mov    %edi,%edx
  19:   be 69 19 12 28          mov    $0x28121969,%esi
  1e:   bf ad de e1 fe          mov    $0xfee1dead,%edi
  23:   b8 a9 00 00 00          mov    $0xa9,%eax
  28:   0f 05                   syscall
  2a:*  48                      rex.W           <-- trapping instruction
  2b:   3d                      .byte 0x3d
  2c:   08                      .byte 0x8

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   48                      rex.W
   1:   3d                      .byte 0x3d
   2:   08                      .byte 0x8
RSP: 002b:00007ffc65d6b1a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a9
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7f28830a07
RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
RBP: 00007ffc65d6b3e0 R08: 0000000000000069 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000001234567
</TASK>
irq event stamp: 12760245
hardirqs last enabled at (12760257): __up_console_sem
(kernel/printk/printk.c:344 (discriminator 1))
hardirqs last disabled at (12760268): __up_console_sem
(kernel/printk/printk.c:342 (discriminator 1))
softirqs last enabled at (12760150): __irq_exit_rcu
(kernel/softirq.c:596 kernel/softirq.c:435 kernel/softirq.c:662)
softirqs last disabled at (12760145): __irq_exit_rcu
(kernel/softirq.c:596 kernel/softirq.c:435 kernel/softirq.c:662)
---[ end trace 0000000000000000 ]---

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: suspicious RCU usage
6.14.0+ #2 Tainted: G        W
-----------------------------
net/ipv4/igmp.c:1770 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active =3D 2, debug_locks =3D 1
4 locks held by shutdown/1:
#0: ffffffffa4d58750 (system_transition_mutex){+.+.}-{4:4}, at:
__do_sys_reboot (kernel/reboot.c:760)
#1: ffff888114d0c1b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/device.h:922 drivers/base/core.c:4802)
#2: ffff8881152211b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/pm_runtime.h:121 drivers/base/core.c:4805)
#3: ffff888178e24d90 (&dev->lock){+.+.}-{4:4}, at: bnxt_shutdown
(drivers/net/ethernet/broadcom/bnxt/bnxt.c:16703) bnxt_en

stack backtrace:
CPU: 0 UID: 0 PID: 1 Comm: shutdown Tainted: G        W
6.14.0+ #2 PREEMPT(undef)  271a3d276f79e3bb26d6065917556e94aae0d88d
Tainted: [W]=3DWARN
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/20=
21
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:123)
lockdep_rcu_suspicious (kernel/locking/lockdep.c:6863)
__ip_mc_dec_group (net/ipv4/igmp.c:1770 (discriminator 7))
inetdev_event (net/ipv4/devinet.c:1669)
? _raw_spin_unlock_irqrestore (./arch/x86/include/asm/preempt.h:104
./include/linux/spinlock_api_smp.h:152 kernel/locking/spinlock.c:194)
? __wake_up (kernel/sched/wait.c:110 kernel/sched/wait.c:127)
? __pfx_inetdev_event (net/ipv4/devinet.c:1583)
? nexthop_flush_dev (./include/net/net_namespace.h:409
./include/linux/netdevice.h:2709 net/ipv4/nexthop.c:2653)
? nh_netdev_event (net/ipv4/nexthop.c:3878)
? notifier_call_chain (kernel/notifier.c:85)
notifier_call_chain (kernel/notifier.c:85)
dev_close_many (net/core/dev.c:1789)
? __pfx_dev_close_many (net/core/dev.c:1776)
netif_close (./include/linux/list.h:124 ./include/linux/list.h:215
./include/linux/list.h:229 net/core/dev.c:1802 net/core/dev.c:1795)
? __pfx_netif_close (net/core/dev.c:1796)
? mark_held_locks (kernel/locking/lockdep.c:4326)
bnxt_shutdown (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16707) bnxt_en
pci_device_shutdown (drivers/pci/pci-driver.c:511)
device_shutdown (drivers/base/core.c:4820)
kernel_restart (kernel/reboot.c:271 kernel/reboot.c:285)
__do_sys_reboot (kernel/reboot.c:763)
? __pfx___do_sys_reboot (kernel/reboot.c:725)
? rseq_get_rseq_cs (kernel/rseq.c:310)
? rseq_syscall (kernel/rseq.c:465)
? __pfx_rseq_syscall (kernel/rseq.c:458)
? do_writev (fs/read_write.c:1101)
? __pfx_do_writev (fs/read_write.c:1091)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f7f28830a07
Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f
1e fa 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d
008
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   c7 c0 ff ff ff ff       mov    $0xffffffff,%eax
   6:   eb be                   jmp    0xffffffffffffffc6
   8:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
   f:   00 00 00
  12:   90                      nop
  13:   f3 0f 1e fa             endbr64
  17:   89 fa                   mov    %edi,%edx
  19:   be 69 19 12 28          mov    $0x28121969,%esi
  1e:   bf ad de e1 fe          mov    $0xfee1dead,%edi
  23:   b8 a9 00 00 00          mov    $0xa9,%eax
  28:   0f 05                   syscall
  2a:*  48                      rex.W           <-- trapping instruction
  2b:   3d                      .byte 0x3d
  2c:   08                      .byte 0x8

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   48                      rex.W
   1:   3d                      .byte 0x3d
   2:   08                      .byte 0x8
RSP: 002b:00007ffc65d6b1a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a9
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7f28830a07
RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
RBP: 00007ffc65d6b3e0 R08: 0000000000000069 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000001234567
</TASK>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: suspicious RCU usage
6.14.0+ #2 Tainted: G        W
-----------------------------
net/ipv4/igmp.c:1425 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active =3D 2, debug_locks =3D 1
4 locks held by shutdown/1:
#0: ffffffffa4d58750 (system_transition_mutex){+.+.}-{4:4}, at:
__do_sys_reboot (kernel/reboot.c:760)
#1: ffff888114d0c1b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/device.h:922 drivers/base/core.c:4802)
#2: ffff8881152211b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/pm_runtime.h:121 drivers/base/core.c:4805)
#3: ffff888178e24d90 (&dev->lock){+.+.}-{4:4}, at: bnxt_shutdown
(drivers/net/ethernet/broadcom/bnxt/bnxt.c:16703) bnxt_en

stack backtrace:
CPU: 0 UID: 0 PID: 1 Comm: shutdown Tainted: G        W
6.14.0+ #2 PREEMPT(undef)  271a3d276f79e3bb26d6065917556e94aae0d88d
Tainted: [W]=3DWARN
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/20=
21
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:123)
lockdep_rcu_suspicious (kernel/locking/lockdep.c:6863)
__ip_mc_dec_group (net/ipv4/igmp.c:1425 net/ipv4/igmp.c:1774)
inetdev_event (net/ipv4/devinet.c:1669)
? _raw_spin_unlock_irqrestore (./arch/x86/include/asm/preempt.h:104
./include/linux/spinlock_api_smp.h:152 kernel/locking/spinlock.c:194)
? __wake_up (kernel/sched/wait.c:110 kernel/sched/wait.c:127)
? __pfx_inetdev_event (net/ipv4/devinet.c:1583)
? nexthop_flush_dev (./include/net/net_namespace.h:409
./include/linux/netdevice.h:2709 net/ipv4/nexthop.c:2653)
? nh_netdev_event (net/ipv4/nexthop.c:3878)
? notifier_call_chain (kernel/notifier.c:85)
notifier_call_chain (kernel/notifier.c:85)
dev_close_many (net/core/dev.c:1789)
? __pfx_dev_close_many (net/core/dev.c:1776)
netif_close (./include/linux/list.h:124 ./include/linux/list.h:215
./include/linux/list.h:229 net/core/dev.c:1802 net/core/dev.c:1795)
? __pfx_netif_close (net/core/dev.c:1796)
? mark_held_locks (kernel/locking/lockdep.c:4326)
bnxt_shutdown (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16707) bnxt_en
pci_device_shutdown (drivers/pci/pci-driver.c:511)
device_shutdown (drivers/base/core.c:4820)
kernel_restart (kernel/reboot.c:271 kernel/reboot.c:285)
__do_sys_reboot (kernel/reboot.c:763)
? __pfx___do_sys_reboot (kernel/reboot.c:725)
? rseq_get_rseq_cs (kernel/rseq.c:310)
? rseq_syscall (kernel/rseq.c:465)
? __pfx_rseq_syscall (kernel/rseq.c:458)
? do_writev (fs/read_write.c:1101)
? __pfx_do_writev (fs/read_write.c:1091)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f7f28830a07
Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f
1e fa 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d
008
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   c7 c0 ff ff ff ff       mov    $0xffffffff,%eax
   6:   eb be                   jmp    0xffffffffffffffc6
   8:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
   f:   00 00 00
  12:   90                      nop
  13:   f3 0f 1e fa             endbr64
  17:   89 fa                   mov    %edi,%edx
  19:   be 69 19 12 28          mov    $0x28121969,%esi
  1e:   bf ad de e1 fe          mov    $0xfee1dead,%edi
  23:   b8 a9 00 00 00          mov    $0xa9,%eax
  28:   0f 05                   syscall
  2a:*  48                      rex.W           <-- trapping instruction
  2b:   3d                      .byte 0x3d
  2c:   08                      .byte 0x8

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   48                      rex.W
   1:   3d                      .byte 0x3d
   2:   08                      .byte 0x8
RSP: 002b:00007ffc65d6b1a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a9
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7f28830a07
RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
RBP: 00007ffc65d6b3e0 R08: 0000000000000069 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000001234567
</TASK>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: suspicious RCU usage
6.14.0+ #2 Tainted: G        W
-----------------------------
./include/linux/inetdevice.h:270 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active =3D 2, debug_locks =3D 1
4 locks held by shutdown/1:
#0: ffffffffa4d58750 (system_transition_mutex){+.+.}-{4:4}, at:
__do_sys_reboot (kernel/reboot.c:760)
#1: ffff888114d0c1b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/device.h:922 drivers/base/core.c:4802)
#2: ffff8881152211b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/pm_runtime.h:121 drivers/base/core.c:4805)
#3: ffff888178e24d90 (&dev->lock){+.+.}-{4:4}, at: bnxt_shutdown
(drivers/net/ethernet/broadcom/bnxt/bnxt.c:16703) bnxt_en

stack backtrace:
CPU: 0 UID: 0 PID: 1 Comm: shutdown Tainted: G        W
6.14.0+ #2 PREEMPT(undef)  271a3d276f79e3bb26d6065917556e94aae0d88d
Tainted: [W]=3DWARN
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/20=
21
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:123)
lockdep_rcu_suspicious (kernel/locking/lockdep.c:6863)
fib_sync_down_dev (./include/linux/inetdevice.h:270
net/ipv4/fib_semantics.c:1853 net/ipv4/fib_semantics.c:1971)
? __pfx_fib_sync_down_dev (net/ipv4/fib_semantics.c:1937)
? _raw_spin_unlock_irqrestore (./arch/x86/include/asm/preempt.h:104
./include/linux/spinlock_api_smp.h:152 kernel/locking/spinlock.c:194)
? __wake_up (kernel/sched/wait.c:110 kernel/sched/wait.c:127)
fib_netdev_event (net/ipv4/fib_frontend.c:1454 net/ipv4/fib_frontend.c:1524=
)
notifier_call_chain (kernel/notifier.c:85)
dev_close_many (net/core/dev.c:1789)
? __pfx_dev_close_many (net/core/dev.c:1776)
netif_close (./include/linux/list.h:124 ./include/linux/list.h:215
./include/linux/list.h:229 net/core/dev.c:1802 net/core/dev.c:1795)
? __pfx_netif_close (net/core/dev.c:1796)
? mark_held_locks (kernel/locking/lockdep.c:4326)
bnxt_shutdown (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16707) bnxt_en
pci_device_shutdown (drivers/pci/pci-driver.c:511)
device_shutdown (drivers/base/core.c:4820)
kernel_restart (kernel/reboot.c:271 kernel/reboot.c:285)
__do_sys_reboot (kernel/reboot.c:763)
? __pfx___do_sys_reboot (kernel/reboot.c:725)
? rseq_get_rseq_cs (kernel/rseq.c:310)
? rseq_syscall (kernel/rseq.c:465)
? __pfx_rseq_syscall (kernel/rseq.c:458)
? do_writev (fs/read_write.c:1101)
? __pfx_do_writev (fs/read_write.c:1091)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f7f28830a07
Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f
1e fa 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d
008
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   c7 c0 ff ff ff ff       mov    $0xffffffff,%eax
   6:   eb be                   jmp    0xffffffffffffffc6
   8:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
   f:   00 00 00
  12:   90                      nop
  13:   f3 0f 1e fa             endbr64
  17:   89 fa                   mov    %edi,%edx
  19:   be 69 19 12 28          mov    $0x28121969,%esi
  1e:   bf ad de e1 fe          mov    $0xfee1dead,%edi
  23:   b8 a9 00 00 00          mov    $0xa9,%eax
  28:   0f 05                   syscall
  2a:*  48                      rex.W           <-- trapping instruction
  2b:   3d                      .byte 0x3d
  2c:   08                      .byte 0x8

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   48                      rex.W
   1:   3d                      .byte 0x3d
   2:   08                      .byte 0x8
RSP: 002b:00007ffc65d6b1a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a9
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7f28830a07
RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
RBP: 00007ffc65d6b3e0 R08: 0000000000000069 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000001234567
</TASK>
------------[ cut here ]------------
RTNL: assertion failed at net/ipv4/fib_notifier.c (22)
WARNING: CPU: 0 PID: 1 at net/ipv4/fib_notifier.c:22
call_fib4_notifiers (net/ipv4/fib_notifier.c:22 (discriminator 3))
Modules linked in: xt_nat xt_tcpudp veth xt_conntrack nft_chain_nat
xt_MASQUERADE nf_conntrack_netlink xfrm_user xt_addrtype nft_compat
nf_tabs
CPU: 0 UID: 0 PID: 1 Comm: shutdown Tainted: G        W
6.14.0+ #2 PREEMPT(undef)  271a3d276f79e3bb26d6065917556e94aae0d88d
Tainted: [W]=3DWARN
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/20=
21
RIP: 0010:call_fib4_notifiers (net/ipv4/fib_notifier.c:22 (discriminator 3)=
)
Code: ca ff 80 3d 20 f8 05 09 00 75 88 ba 16 00 00 00 48 c7 c6 a0 c6
02 a4 48 c7 c7 e0 c6 02 a4 c6 05 04 f8 05 09 01 e8 0d 4e f3 fd <0f> 0b
e9e
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   ca ff 80                lret   $0x80ff
   3:   3d 20 f8 05 09          cmp    $0x905f820,%eax
   8:   00 75 88                add    %dh,-0x78(%rbp)
   b:   ba 16 00 00 00          mov    $0x16,%edx
  10:   48 c7 c6 a0 c6 02 a4    mov    $0xffffffffa402c6a0,%rsi
  17:   48 c7 c7 e0 c6 02 a4    mov    $0xffffffffa402c6e0,%rdi
  1e:   c6 05 04 f8 05 09 01    movb   $0x1,0x905f804(%rip)        # 0x905f=
829
  25:   e8 0d 4e f3 fd          call   0xfffffffffdf34e37
  2a:*  0f 0b                   ud2             <-- trapping instruction
  2c:   9e                      sahf

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   0f 0b                   ud2
   2:   9e                      sahf
RSP: 0018:ffff888104e2f990 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88813a8cdc97 RCX: 0000000000000000
RDX: 0000000000000002 RSI: 0000000000000004 RDI: 0000000000000001
RBP: ffffffffb0a15f40 R08: 0000000000000000 R09: fffffbfff49a4af4
R10: 0000000000000003 R11: 0000000000000001 R12: ffff888104e2fa40
R13: 0000000000000007 R14: ffff888178e24000 R15: dffffc0000000000
FS:  00007f7f27cb4440(0000) GS:ffff88886dc22000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc65d6b0cc CR3: 00000001d73de000 CR4: 00000000007506f0
PKRU: 55555554
Call Trace:
<TASK>
? __warn (kernel/panic.c:748)
? __pfx_vprintk_emit.part.0 (kernel/printk/printk.c:2378)
? call_fib4_notifiers (net/ipv4/fib_notifier.c:22 (discriminator 3))
? report_bug (lib/bug.c:201 lib/bug.c:219)
? call_fib4_notifiers (net/ipv4/fib_notifier.c:22 (discriminator 3))
? handle_bug (arch/x86/kernel/traps.c:337)
? exc_invalid_op (arch/x86/kernel/traps.c:391 (discriminator 1))
? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:578)
? call_fib4_notifiers (net/ipv4/fib_notifier.c:22 (discriminator 3))
fib_sync_down_dev (net/ipv4/fib_semantics.c:1869 net/ipv4/fib_semantics.c:1=
971)
? __pfx_fib_sync_down_dev (net/ipv4/fib_semantics.c:1937)
? __wake_up (kernel/sched/wait.c:110 kernel/sched/wait.c:127)
fib_netdev_event (net/ipv4/fib_frontend.c:1454 net/ipv4/fib_frontend.c:1524=
)
notifier_call_chain (kernel/notifier.c:85)
dev_close_many (net/core/dev.c:1789)
? __pfx_dev_close_many (net/core/dev.c:1776)
netif_close (./include/linux/list.h:124 ./include/linux/list.h:215
./include/linux/list.h:229 net/core/dev.c:1802 net/core/dev.c:1795)
? __pfx_netif_close (net/core/dev.c:1796)
? mark_held_locks (kernel/locking/lockdep.c:4326)
bnxt_shutdown (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16707) bnxt_en
pci_device_shutdown (drivers/pci/pci-driver.c:511)
device_shutdown (drivers/base/core.c:4820)
kernel_restart (kernel/reboot.c:271 kernel/reboot.c:285)
__do_sys_reboot (kernel/reboot.c:763)
? __pfx___do_sys_reboot (kernel/reboot.c:725)
? rseq_get_rseq_cs (kernel/rseq.c:310)
? rseq_syscall (kernel/rseq.c:465)
? __pfx_rseq_syscall (kernel/rseq.c:458)
? do_writev (fs/read_write.c:1101)
? __pfx_do_writev (fs/read_write.c:1091)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f7f28830a07
Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f
1e fa 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d
008
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   c7 c0 ff ff ff ff       mov    $0xffffffff,%eax
   6:   eb be                   jmp    0xffffffffffffffc6
   8:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
   f:   00 00 00
  12:   90                      nop
  13:   f3 0f 1e fa             endbr64
  17:   89 fa                   mov    %edi,%edx
  19:   be 69 19 12 28          mov    $0x28121969,%esi
  1e:   bf ad de e1 fe          mov    $0xfee1dead,%edi
  23:   b8 a9 00 00 00          mov    $0xa9,%eax
  28:   0f 05                   syscall
  2a:*  48                      rex.W           <-- trapping instruction
  2b:   3d                      .byte 0x3d
  2c:   08                      .byte 0x8

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   48                      rex.W
   1:   3d                      .byte 0x3d
   2:   08                      .byte 0x8
RSP: 002b:00007ffc65d6b1a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a9
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7f28830a07
RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
RBP: 00007ffc65d6b3e0 R08: 0000000000000069 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000001234567
</TASK>
irq event stamp: 12763011
hardirqs last enabled at (12763023): __up_console_sem
(kernel/printk/printk.c:344 (discriminator 1))
hardirqs last disabled at (12763034): __up_console_sem
(kernel/printk/printk.c:342 (discriminator 1))
softirqs last enabled at (12762816): __irq_exit_rcu
(kernel/softirq.c:596 kernel/softirq.c:435 kernel/softirq.c:662)
softirqs last disabled at (12763055): __irq_exit_rcu
(kernel/softirq.c:596 kernel/softirq.c:435 kernel/softirq.c:662)
---[ end trace 0000000000000000 ]---

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: suspicious RCU usage
6.14.0+ #2 Tainted: G        W
-----------------------------
net/ipv4/fib_trie.c:2034 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active =3D 2, debug_locks =3D 1
4 locks held by shutdown/1:
#0: ffffffffa4d58750 (system_transition_mutex){+.+.}-{4:4}, at:
__do_sys_reboot (kernel/reboot.c:760)
#1: ffff888114d0c1b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/device.h:922 drivers/base/core.c:4802)
#2: ffff8881152211b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/pm_runtime.h:121 drivers/base/core.c:4805)
#3: ffff888178e24d90 (&dev->lock){+.+.}-{4:4}, at: bnxt_shutdown
(drivers/net/ethernet/broadcom/bnxt/bnxt.c:16703) bnxt_en

stack backtrace:
CPU: 0 UID: 0 PID: 1 Comm: shutdown Tainted: G        W
6.14.0+ #2 PREEMPT(undef)  271a3d276f79e3bb26d6065917556e94aae0d88d
Tainted: [W]=3DWARN
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/20=
21
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:123)
lockdep_rcu_suspicious (kernel/locking/lockdep.c:6863)
fib_table_flush (net/ipv4/fib_trie.c:2034 (discriminator 7))
? fib_sync_down_dev (net/ipv4/fib_semantics.c:1996)
? __pfx_fib_table_flush (net/ipv4/fib_trie.c:2001)
? __pfx_fib_sync_down_dev (net/ipv4/fib_semantics.c:1937)
fib_flush (net/ipv4/fib_frontend.c:195 (discriminator 11))
fib_netdev_event (net/ipv4/fib_frontend.c:1458 net/ipv4/fib_frontend.c:1545=
)
notifier_call_chain (kernel/notifier.c:85)
dev_close_many (net/core/dev.c:1789)
? __pfx_dev_close_many (net/core/dev.c:1776)
netif_close (./include/linux/list.h:124 ./include/linux/list.h:215
./include/linux/list.h:229 net/core/dev.c:1802 net/core/dev.c:1795)
? __pfx_netif_close (net/core/dev.c:1796)
? mark_held_locks (kernel/locking/lockdep.c:4326)
bnxt_shutdown (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16707) bnxt_en
pci_device_shutdown (drivers/pci/pci-driver.c:511)
device_shutdown (drivers/base/core.c:4820)
kernel_restart (kernel/reboot.c:271 kernel/reboot.c:285)
__do_sys_reboot (kernel/reboot.c:763)
? __pfx___do_sys_reboot (kernel/reboot.c:725)
? rseq_get_rseq_cs (kernel/rseq.c:310)
? rseq_syscall (kernel/rseq.c:465)
? __pfx_rseq_syscall (kernel/rseq.c:458)
? do_writev (fs/read_write.c:1101)
? __pfx_do_writev (fs/read_write.c:1091)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f7f28830a07
Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f
1e fa 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d
008
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   c7 c0 ff ff ff ff       mov    $0xffffffff,%eax
   6:   eb be                   jmp    0xffffffffffffffc6
   8:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
   f:   00 00 00
  12:   90                      nop
  13:   f3 0f 1e fa             endbr64
  17:   89 fa                   mov    %edi,%edx
  19:   be 69 19 12 28          mov    $0x28121969,%esi
  1e:   bf ad de e1 fe          mov    $0xfee1dead,%edi
  23:   b8 a9 00 00 00          mov    $0xa9,%eax
  28:   0f 05                   syscall
  2a:*  48                      rex.W           <-- trapping instruction
  2b:   3d                      .byte 0x3d
  2c:   08                      .byte 0x8

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   48                      rex.W
   1:   3d                      .byte 0x3d
   2:   08                      .byte 0x8
RSP: 002b:00007ffc65d6b1a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a9
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7f28830a07
RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
RBP: 00007ffc65d6b3e0 R08: 0000000000000069 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000001234567
</TASK>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: suspicious RCU usage
6.14.0+ #2 Tainted: G        W
-----------------------------
net/ipv4/fib_trie.c:721 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active =3D 2, debug_locks =3D 1
4 locks held by shutdown/1:
#0: ffffffffa4d58750 (system_transition_mutex){+.+.}-{4:4}, at:
__do_sys_reboot (kernel/reboot.c:760)
#1: ffff888114d0c1b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/device.h:922 drivers/base/core.c:4802)
#2: ffff8881152211b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/pm_runtime.h:121 drivers/base/core.c:4805)
#3: ffff888178e24d90 (&dev->lock){+.+.}-{4:4}, at: bnxt_shutdown
(drivers/net/ethernet/broadcom/bnxt/bnxt.c:16703) bnxt_en

stack backtrace:
CPU: 0 UID: 0 PID: 1 Comm: shutdown Tainted: G        W
6.14.0+ #2 PREEMPT(undef)  271a3d276f79e3bb26d6065917556e94aae0d88d
Tainted: [W]=3DWARN
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/20=
21
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:123)
lockdep_rcu_suspicious (kernel/locking/lockdep.c:6863)
update_suffix (net/ipv4/fib_trie.c:721 (discriminator 7))
fib_table_flush (net/ipv4/fib_trie.c:2024)
? fib_sync_down_dev (net/ipv4/fib_semantics.c:1996)
? __pfx_fib_table_flush (net/ipv4/fib_trie.c:2001)
? __pfx_fib_sync_down_dev (net/ipv4/fib_semantics.c:1937)
fib_flush (net/ipv4/fib_frontend.c:195 (discriminator 11))
fib_netdev_event (net/ipv4/fib_frontend.c:1458 net/ipv4/fib_frontend.c:1545=
)
notifier_call_chain (kernel/notifier.c:85)
dev_close_many (net/core/dev.c:1789)
? __pfx_dev_close_many (net/core/dev.c:1776)
netif_close (./include/linux/list.h:124 ./include/linux/list.h:215
./include/linux/list.h:229 net/core/dev.c:1802 net/core/dev.c:1795)
? __pfx_netif_close (net/core/dev.c:1796)
? mark_held_locks (kernel/locking/lockdep.c:4326)
bnxt_shutdown (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16707) bnxt_en
pci_device_shutdown (drivers/pci/pci-driver.c:511)
device_shutdown (drivers/base/core.c:4820)
kernel_restart (kernel/reboot.c:271 kernel/reboot.c:285)
__do_sys_reboot (kernel/reboot.c:763)
? __pfx___do_sys_reboot (kernel/reboot.c:725)
? rseq_get_rseq_cs (kernel/rseq.c:310)
? rseq_syscall (kernel/rseq.c:465)
? __pfx_rseq_syscall (kernel/rseq.c:458)
? do_writev (fs/read_write.c:1101)
? __pfx_do_writev (fs/read_write.c:1091)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f7f28830a07
Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f
1e fa 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d
008
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   c7 c0 ff ff ff ff       mov    $0xffffffff,%eax
   6:   eb be                   jmp    0xffffffffffffffc6
   8:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
   f:   00 00 00
  12:   90                      nop
  13:   f3 0f 1e fa             endbr64
  17:   89 fa                   mov    %edi,%edx
  19:   be 69 19 12 28          mov    $0x28121969,%esi
  1e:   bf ad de e1 fe          mov    $0xfee1dead,%edi
  23:   b8 a9 00 00 00          mov    $0xa9,%eax
  28:   0f 05                   syscall
  2a:*  48                      rex.W           <-- trapping instruction
  2b:   3d                      .byte 0x3d
  2c:   08                      .byte 0x8

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   48                      rex.W
   1:   3d                      .byte 0x3d
   2:   08                      .byte 0x8
RSP: 002b:00007ffc65d6b1a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a9
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7f28830a07
RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
RBP: 00007ffc65d6b3e0 R08: 0000000000000069 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000001234567
</TASK>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: suspicious RCU usage
6.14.0+ #2 Tainted: G        W
-----------------------------
net/ipv4/fib_trie.c:847 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active =3D 2, debug_locks =3D 1
4 locks held by shutdown/1:
#0: ffffffffa4d58750 (system_transition_mutex){+.+.}-{4:4}, at:
__do_sys_reboot (kernel/reboot.c:760)
#1: ffff888114d0c1b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/device.h:922 drivers/base/core.c:4802)
#2: ffff8881152211b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/pm_runtime.h:121 drivers/base/core.c:4805)
#3: ffff888178e24d90 (&dev->lock){+.+.}-{4:4}, at: bnxt_shutdown
(drivers/net/ethernet/broadcom/bnxt/bnxt.c:16703) bnxt_en

stack backtrace:
CPU: 0 UID: 0 PID: 1 Comm: shutdown Tainted: G        W
6.14.0+ #2 PREEMPT(undef)  271a3d276f79e3bb26d6065917556e94aae0d88d
Tainted: [W]=3DWARN
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/20=
21
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:123)
lockdep_rcu_suspicious (kernel/locking/lockdep.c:6863)
resize (net/ipv4/fib_trie.c:847 (discriminator 7))
? nbcon_cpu_emergency_exit (./arch/x86/include/asm/preempt.h:104
kernel/printk/nbcon.c:1657)
? lockdep_rcu_suspicious (./include/linux/context_tracking.h:159
kernel/locking/lockdep.c:6864)
? update_suffix (net/ipv4/fib_trie.c:721 (discriminator 7))
fib_table_flush (net/ipv4/fib_trie.c:2027)
? fib_sync_down_dev (net/ipv4/fib_semantics.c:1996)
? __pfx_fib_table_flush (net/ipv4/fib_trie.c:2001)
? __pfx_fib_sync_down_dev (net/ipv4/fib_semantics.c:1937)
fib_flush (net/ipv4/fib_frontend.c:195 (discriminator 11))
fib_netdev_event (net/ipv4/fib_frontend.c:1458 net/ipv4/fib_frontend.c:1545=
)
notifier_call_chain (kernel/notifier.c:85)
dev_close_many (net/core/dev.c:1789)
? __pfx_dev_close_many (net/core/dev.c:1776)
netif_close (./include/linux/list.h:124 ./include/linux/list.h:215
./include/linux/list.h:229 net/core/dev.c:1802 net/core/dev.c:1795)
? __pfx_netif_close (net/core/dev.c:1796)
? mark_held_locks (kernel/locking/lockdep.c:4326)
bnxt_shutdown (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16707) bnxt_en
pci_device_shutdown (drivers/pci/pci-driver.c:511)
device_shutdown (drivers/base/core.c:4820)
kernel_restart (kernel/reboot.c:271 kernel/reboot.c:285)
__do_sys_reboot (kernel/reboot.c:763)
? __pfx___do_sys_reboot (kernel/reboot.c:725)
? rseq_get_rseq_cs (kernel/rseq.c:310)
? rseq_syscall (kernel/rseq.c:465)
? __pfx_rseq_syscall (kernel/rseq.c:458)
? do_writev (fs/read_write.c:1101)
? __pfx_do_writev (fs/read_write.c:1091)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f7f28830a07
Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f
1e fa 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d
008
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   c7 c0 ff ff ff ff       mov    $0xffffffff,%eax
   6:   eb be                   jmp    0xffffffffffffffc6
   8:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
   f:   00 00 00
  12:   90                      nop
  13:   f3 0f 1e fa             endbr64
  17:   89 fa                   mov    %edi,%edx
  19:   be 69 19 12 28          mov    $0x28121969,%esi
  1e:   bf ad de e1 fe          mov    $0xfee1dead,%edi
  23:   b8 a9 00 00 00          mov    $0xa9,%eax
  28:   0f 05                   syscall
  2a:*  48                      rex.W           <-- trapping instruction
  2b:   3d                      .byte 0x3d
  2c:   08                      .byte 0x8

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   48                      rex.W
   1:   3d                      .byte 0x3d
   2:   08                      .byte 0x8
RSP: 002b:00007ffc65d6b1a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a9
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7f28830a07
RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
RBP: 00007ffc65d6b3e0 R08: 0000000000000069 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000001234567
</TASK>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: suspicious RCU usage
6.14.0+ #2 Tainted: G        W
-----------------------------
net/ipv4/fib_trie.c:858 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active =3D 2, debug_locks =3D 1
4 locks held by shutdown/1:
#0: ffffffffa4d58750 (system_transition_mutex){+.+.}-{4:4}, at:
__do_sys_reboot (kernel/reboot.c:760)
#1: ffff888114d0c1b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/device.h:922 drivers/base/core.c:4802)
#2: ffff8881152211b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/pm_runtime.h:121 drivers/base/core.c:4805)
#3: ffff888178e24d90 (&dev->lock){+.+.}-{4:4}, at: bnxt_shutdown
(drivers/net/ethernet/broadcom/bnxt/bnxt.c:16703) bnxt_en

stack backtrace:
CPU: 0 UID: 0 PID: 1 Comm: shutdown Tainted: G        W
6.14.0+ #2 PREEMPT(undef)  271a3d276f79e3bb26d6065917556e94aae0d88d
Tainted: [W]=3DWARN
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/20=
21
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:123)
lockdep_rcu_suspicious (kernel/locking/lockdep.c:6863)
resize (net/ipv4/fib_trie.c:858 (discriminator 7))
? nbcon_cpu_emergency_exit (./arch/x86/include/asm/preempt.h:104
kernel/printk/nbcon.c:1657)
? lockdep_rcu_suspicious (./include/linux/context_tracking.h:159
kernel/locking/lockdep.c:6864)
? update_suffix (net/ipv4/fib_trie.c:721 (discriminator 7))
fib_table_flush (net/ipv4/fib_trie.c:2027)
? fib_sync_down_dev (net/ipv4/fib_semantics.c:1996)
? __pfx_fib_table_flush (net/ipv4/fib_trie.c:2001)
? __pfx_fib_sync_down_dev (net/ipv4/fib_semantics.c:1937)
fib_flush (net/ipv4/fib_frontend.c:195 (discriminator 11))
fib_netdev_event (net/ipv4/fib_frontend.c:1458 net/ipv4/fib_frontend.c:1545=
)
notifier_call_chain (kernel/notifier.c:85)
dev_close_many (net/core/dev.c:1789)
? __pfx_dev_close_many (net/core/dev.c:1776)
netif_close (./include/linux/list.h:124 ./include/linux/list.h:215
./include/linux/list.h:229 net/core/dev.c:1802 net/core/dev.c:1795)
? __pfx_netif_close (net/core/dev.c:1796)
? mark_held_locks (kernel/locking/lockdep.c:4326)
bnxt_shutdown (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16707) bnxt_en
pci_device_shutdown (drivers/pci/pci-driver.c:511)
device_shutdown (drivers/base/core.c:4820)
kernel_restart (kernel/reboot.c:271 kernel/reboot.c:285)
__do_sys_reboot (kernel/reboot.c:763)
? __pfx___do_sys_reboot (kernel/reboot.c:725)
? rseq_get_rseq_cs (kernel/rseq.c:310)
? rseq_syscall (kernel/rseq.c:465)
? __pfx_rseq_syscall (kernel/rseq.c:458)
? do_writev (fs/read_write.c:1101)
? __pfx_do_writev (fs/read_write.c:1091)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f7f28830a07
Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f
1e fa 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d
008
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   c7 c0 ff ff ff ff       mov    $0xffffffff,%eax
   6:   eb be                   jmp    0xffffffffffffffc6
   8:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
   f:   00 00 00
  12:   90                      nop
  13:   f3 0f 1e fa             endbr64
  17:   89 fa                   mov    %edi,%edx
  19:   be 69 19 12 28          mov    $0x28121969,%esi
  1e:   bf ad de e1 fe          mov    $0xfee1dead,%edi
  23:   b8 a9 00 00 00          mov    $0xa9,%eax
  28:   0f 05                   syscall
  2a:*  48                      rex.W           <-- trapping instruction
  2b:   3d                      .byte 0x3d
  2c:   08                      .byte 0x8

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   48                      rex.W
   1:   3d                      .byte 0x3d
   2:   08                      .byte 0x8
RSP: 002b:00007ffc65d6b1a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a9
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7f28830a07
RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
RBP: 00007ffc65d6b3e0 R08: 0000000000000069 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000001234567
</TASK>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: suspicious RCU usage
6.14.0+ #2 Tainted: G        W
-----------------------------
net/ipv4/fib_trie.c:877 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active =3D 2, debug_locks =3D 1
4 locks held by shutdown/1:
#0: ffffffffa4d58750 (system_transition_mutex){+.+.}-{4:4}, at:
__do_sys_reboot (kernel/reboot.c:760)
#1: ffff888114d0c1b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/device.h:922 drivers/base/core.c:4802)
#2: ffff8881152211b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/pm_runtime.h:121 drivers/base/core.c:4805)
#3: ffff888178e24d90 (&dev->lock){+.+.}-{4:4}, at: bnxt_shutdown
(drivers/net/ethernet/broadcom/bnxt/bnxt.c:16703) bnxt_en

stack backtrace:
CPU: 0 UID: 0 PID: 1 Comm: shutdown Tainted: G        W
6.14.0+ #2 PREEMPT(undef)  271a3d276f79e3bb26d6065917556e94aae0d88d
Tainted: [W]=3DWARN
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/20=
21
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:123)
lockdep_rcu_suspicious (kernel/locking/lockdep.c:6863)
resize (net/ipv4/fib_trie.c:877 (discriminator 7))
? nbcon_cpu_emergency_exit (./arch/x86/include/asm/preempt.h:104
kernel/printk/nbcon.c:1657)
? lockdep_rcu_suspicious (./include/linux/context_tracking.h:159
kernel/locking/lockdep.c:6864)
? update_suffix (net/ipv4/fib_trie.c:721 (discriminator 7))
fib_table_flush (net/ipv4/fib_trie.c:2027)
? fib_sync_down_dev (net/ipv4/fib_semantics.c:1996)
? __pfx_fib_table_flush (net/ipv4/fib_trie.c:2001)
? __pfx_fib_sync_down_dev (net/ipv4/fib_semantics.c:1937)
fib_flush (net/ipv4/fib_frontend.c:195 (discriminator 11))
fib_netdev_event (net/ipv4/fib_frontend.c:1458 net/ipv4/fib_frontend.c:1545=
)
notifier_call_chain (kernel/notifier.c:85)
dev_close_many (net/core/dev.c:1789)
? __pfx_dev_close_many (net/core/dev.c:1776)
netif_close (./include/linux/list.h:124 ./include/linux/list.h:215
./include/linux/list.h:229 net/core/dev.c:1802 net/core/dev.c:1795)
? __pfx_netif_close (net/core/dev.c:1796)
? mark_held_locks (kernel/locking/lockdep.c:4326)
bnxt_shutdown (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16707) bnxt_en
pci_device_shutdown (drivers/pci/pci-driver.c:511)
device_shutdown (drivers/base/core.c:4820)
kernel_restart (kernel/reboot.c:271 kernel/reboot.c:285)
__do_sys_reboot (kernel/reboot.c:763)
? __pfx___do_sys_reboot (kernel/reboot.c:725)
? rseq_get_rseq_cs (kernel/rseq.c:310)
? rseq_syscall (kernel/rseq.c:465)
? __pfx_rseq_syscall (kernel/rseq.c:458)
? do_writev (fs/read_write.c:1101)
? __pfx_do_writev (fs/read_write.c:1091)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f7f28830a07
Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f
1e fa 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d
008
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   c7 c0 ff ff ff ff       mov    $0xffffffff,%eax
   6:   eb be                   jmp    0xffffffffffffffc6
   8:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
   f:   00 00 00
  12:   90                      nop
  13:   f3 0f 1e fa             endbr64
  17:   89 fa                   mov    %edi,%edx
  19:   be 69 19 12 28          mov    $0x28121969,%esi
  1e:   bf ad de e1 fe          mov    $0xfee1dead,%edi
  23:   b8 a9 00 00 00          mov    $0xa9,%eax
  28:   0f 05                   syscall
  2a:*  48                      rex.W           <-- trapping instruction
  2b:   3d                      .byte 0x3d
  2c:   08                      .byte 0x8

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   48                      rex.W
   1:   3d                      .byte 0x3d
   2:   08                      .byte 0x8
RSP: 002b:00007ffc65d6b1a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a9
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7f28830a07
RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
RBP: 00007ffc65d6b3e0 R08: 0000000000000069 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000001234567
</TASK>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: suspicious RCU usage
6.14.0+ #2 Tainted: G        W
-----------------------------
net/ipv4/fib_trie.c:904 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active =3D 2, debug_locks =3D 1
4 locks held by shutdown/1:
#0: ffffffffa4d58750 (system_transition_mutex){+.+.}-{4:4}, at:
__do_sys_reboot (kernel/reboot.c:760)
#1: ffff888114d0c1b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/device.h:922 drivers/base/core.c:4802)
#2: ffff8881152211b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/pm_runtime.h:121 drivers/base/core.c:4805)
#3: ffff888178e24d90 (&dev->lock){+.+.}-{4:4}, at: bnxt_shutdown
(drivers/net/ethernet/broadcom/bnxt/bnxt.c:16703) bnxt_en

stack backtrace:
CPU: 0 UID: 0 PID: 1 Comm: shutdown Tainted: G        W
6.14.0+ #2 PREEMPT(undef)  271a3d276f79e3bb26d6065917556e94aae0d88d
Tainted: [W]=3DWARN
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/20=
21
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:123)
lockdep_rcu_suspicious (kernel/locking/lockdep.c:6863)
resize (net/ipv4/fib_trie.c:904 (discriminator 7))
? nbcon_cpu_emergency_exit (./arch/x86/include/asm/preempt.h:104
kernel/printk/nbcon.c:1657)
? lockdep_rcu_suspicious (./include/linux/context_tracking.h:159
kernel/locking/lockdep.c:6864)
? update_suffix (net/ipv4/fib_trie.c:721 (discriminator 7))
fib_table_flush (net/ipv4/fib_trie.c:2027)
? fib_sync_down_dev (net/ipv4/fib_semantics.c:1996)
? __pfx_fib_table_flush (net/ipv4/fib_trie.c:2001)
? __pfx_fib_sync_down_dev (net/ipv4/fib_semantics.c:1937)
fib_flush (net/ipv4/fib_frontend.c:195 (discriminator 11))
fib_netdev_event (net/ipv4/fib_frontend.c:1458 net/ipv4/fib_frontend.c:1545=
)
notifier_call_chain (kernel/notifier.c:85)
dev_close_many (net/core/dev.c:1789)
? __pfx_dev_close_many (net/core/dev.c:1776)
netif_close (./include/linux/list.h:124 ./include/linux/list.h:215
./include/linux/list.h:229 net/core/dev.c:1802 net/core/dev.c:1795)
? __pfx_netif_close (net/core/dev.c:1796)
? mark_held_locks (kernel/locking/lockdep.c:4326)
bnxt_shutdown (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16707) bnxt_en
pci_device_shutdown (drivers/pci/pci-driver.c:511)
device_shutdown (drivers/base/core.c:4820)
kernel_restart (kernel/reboot.c:271 kernel/reboot.c:285)
__do_sys_reboot (kernel/reboot.c:763)
? __pfx___do_sys_reboot (kernel/reboot.c:725)
? rseq_get_rseq_cs (kernel/rseq.c:310)
? rseq_syscall (kernel/rseq.c:465)
? __pfx_rseq_syscall (kernel/rseq.c:458)
? do_writev (fs/read_write.c:1101)
? __pfx_do_writev (fs/read_write.c:1091)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f7f28830a07
Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f
1e fa 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d
008
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   c7 c0 ff ff ff ff       mov    $0xffffffff,%eax
   6:   eb be                   jmp    0xffffffffffffffc6
   8:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
   f:   00 00 00
  12:   90                      nop
  13:   f3 0f 1e fa             endbr64
  17:   89 fa                   mov    %edi,%edx
  19:   be 69 19 12 28          mov    $0x28121969,%esi
  1e:   bf ad de e1 fe          mov    $0xfee1dead,%edi
  23:   b8 a9 00 00 00          mov    $0xa9,%eax
  28:   0f 05                   syscall
  2a:*  48                      rex.W           <-- trapping instruction
  2b:   3d                      .byte 0x3d
  2c:   08                      .byte 0x8

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   48                      rex.W
   1:   3d                      .byte 0x3d
   2:   08                      .byte 0x8
RSP: 002b:00007ffc65d6b1a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a9
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7f28830a07
RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
RBP: 00007ffc65d6b3e0 R08: 0000000000000069 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000001234567
</TASK>
------------[ cut here ]------------
RTNL: assertion failed at net/ipv4/fib_semantics.c (252)
WARNING: CPU: 0 PID: 1 at net/ipv4/fib_semantics.c:252
fib_release_info (net/ipv4/fib_semantics.c:252 (discriminator 3))
Modules linked in: xt_nat xt_tcpudp veth xt_conntrack nft_chain_nat
xt_MASQUERADE nf_conntrack_netlink xfrm_user xt_addrtype nft_compat
nf_tabs
CPU: 0 UID: 0 PID: 1 Comm: shutdown Tainted: G        W
6.14.0+ #2 PREEMPT(undef)  271a3d276f79e3bb26d6065917556e94aae0d88d
Tainted: [W]=3DWARN
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/20=
21
RIP: 0010:fib_release_info (net/ipv4/fib_semantics.c:252 (discriminator 3))
Code: c3 08 08 09 00 0f 85 20 fb ff ff ba fc 00 00 00 48 c7 c6 20 a3
02 a4 48 c7 c7 60 a3 02 a4 c6 05 a3 08 08 09 01 e8 ae 5e f5 fd <0f> 0b
e91
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   c3                      ret
   1:   08 08                   or     %cl,(%rax)
   3:   09 00                   or     %eax,(%rax)
   5:   0f 85 20 fb ff ff       jne    0xfffffffffffffb2b
   b:   ba fc 00 00 00          mov    $0xfc,%edx
  10:   48 c7 c6 20 a3 02 a4    mov    $0xffffffffa402a320,%rsi
  17:   48 c7 c7 60 a3 02 a4    mov    $0xffffffffa402a360,%rdi
  1e:   c6 05 a3 08 08 09 01    movb   $0x1,0x90808a3(%rip)        # 0x9080=
8c8
  25:   e8 ae 5e f5 fd          call   0xfffffffffdf55ed8
  2a:*  0f 0b                   ud2             <-- trapping instruction
  2c:   91                      xchg   %eax,%ecx

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   0f 0b                   ud2
   2:   91                      xchg   %eax,%ecx
RSP: 0018:ffff888104e2f930 EFLAGS: 00010282
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: 0000000000000002 RSI: 0000000000000004 RDI: 0000000000000001
RBP: ffff88813a8ccd00 R08: 0000000000000000 R09: fffffbfff49a4af4
R10: 0000000000000003 R11: 0000000000000001 R12: ffff888108aeb200
R13: 0000000000000000 R14: ffff888137455168 R15: ffff888118b3fd20
FS:  00007f7f27cb4440(0000) GS:ffff88886dc22000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc65d6b0cc CR3: 00000001d73de000 CR4: 00000000007506f0
PKRU: 55555554
Call Trace:
<TASK>
? __warn (kernel/panic.c:748)
? __pfx_vprintk_emit.part.0 (kernel/printk/printk.c:2378)
? fib_release_info (net/ipv4/fib_semantics.c:252 (discriminator 3))
? report_bug (lib/bug.c:201 lib/bug.c:219)
? fib_release_info (net/ipv4/fib_semantics.c:252 (discriminator 3))
? handle_bug (arch/x86/kernel/traps.c:337)
? exc_invalid_op (arch/x86/kernel/traps.c:391 (discriminator 1))
? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:578)
? fib_release_info (net/ipv4/fib_semantics.c:252 (discriminator 3))
fib_table_flush (net/ipv4/fib_trie.c:297 net/ipv4/fib_trie.c:2071)
? __pfx_fib_table_flush (net/ipv4/fib_trie.c:2001)
? __pfx_fib_sync_down_dev (net/ipv4/fib_semantics.c:1937)
fib_flush (net/ipv4/fib_frontend.c:195 (discriminator 11))
fib_netdev_event (net/ipv4/fib_frontend.c:1458 net/ipv4/fib_frontend.c:1545=
)
notifier_call_chain (kernel/notifier.c:85)
dev_close_many (net/core/dev.c:1789)
? __pfx_dev_close_many (net/core/dev.c:1776)
netif_close (./include/linux/list.h:124 ./include/linux/list.h:215
./include/linux/list.h:229 net/core/dev.c:1802 net/core/dev.c:1795)
? __pfx_netif_close (net/core/dev.c:1796)
? mark_held_locks (kernel/locking/lockdep.c:4326)
bnxt_shutdown (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16707) bnxt_en
pci_device_shutdown (drivers/pci/pci-driver.c:511)
device_shutdown (drivers/base/core.c:4820)
kernel_restart (kernel/reboot.c:271 kernel/reboot.c:285)
__do_sys_reboot (kernel/reboot.c:763)
? __pfx___do_sys_reboot (kernel/reboot.c:725)
? rseq_get_rseq_cs (kernel/rseq.c:310)
? rseq_syscall (kernel/rseq.c:465)
? __pfx_rseq_syscall (kernel/rseq.c:458)
? do_writev (fs/read_write.c:1101)
? __pfx_do_writev (fs/read_write.c:1091)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f7f28830a07
Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f
1e fa 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d
008
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   c7 c0 ff ff ff ff       mov    $0xffffffff,%eax
   6:   eb be                   jmp    0xffffffffffffffc6
   8:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
   f:   00 00 00
  12:   90                      nop
  13:   f3 0f 1e fa             endbr64
  17:   89 fa                   mov    %edi,%edx
  19:   be 69 19 12 28          mov    $0x28121969,%esi
  1e:   bf ad de e1 fe          mov    $0xfee1dead,%edi
  23:   b8 a9 00 00 00          mov    $0xa9,%eax
  28:   0f 05                   syscall
  2a:*  48                      rex.W           <-- trapping instruction
  2b:   3d                      .byte 0x3d
  2c:   08                      .byte 0x8

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   48                      rex.W
   1:   3d                      .byte 0x3d
   2:   08                      .byte 0x8
RSP: 002b:00007ffc65d6b1a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a9
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7f28830a07
RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
RBP: 00007ffc65d6b3e0 R08: 0000000000000069 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000001234567
</TASK>
irq event stamp: 12767447
hardirqs last enabled at (12767459): __up_console_sem
(kernel/printk/printk.c:344 (discriminator 1))
hardirqs last disabled at (12767470): __up_console_sem
(kernel/printk/printk.c:342 (discriminator 1))
softirqs last enabled at (12767280): __irq_exit_rcu
(kernel/softirq.c:596 kernel/softirq.c:435 kernel/softirq.c:662)
softirqs last disabled at (12767275): __irq_exit_rcu
(kernel/softirq.c:596 kernel/softirq.c:435 kernel/softirq.c:662)
---[ end trace 0000000000000000 ]---

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: suspicious RCU usage
6.14.0+ #2 Tainted: G        W
-----------------------------
net/ipv4/fib_trie.c:415 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active =3D 2, debug_locks =3D 1
4 locks held by shutdown/1:
#0: ffffffffa4d58750 (system_transition_mutex){+.+.}-{4:4}, at:
__do_sys_reboot (kernel/reboot.c:760)
#1: ffff888114d0c1b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/device.h:922 drivers/base/core.c:4802)
#2: ffff8881152211b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/pm_runtime.h:121 drivers/base/core.c:4805)
#3: ffff888178e24d90 (&dev->lock){+.+.}-{4:4}, at: bnxt_shutdown
(drivers/net/ethernet/broadcom/bnxt/bnxt.c:16703) bnxt_en

stack backtrace:
CPU: 0 UID: 0 PID: 1 Comm: shutdown Tainted: G        W
6.14.0+ #2 PREEMPT(undef)  271a3d276f79e3bb26d6065917556e94aae0d88d
Tainted: [W]=3DWARN
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/20=
21
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:123)
lockdep_rcu_suspicious (kernel/locking/lockdep.c:6863)
put_child (net/ipv4/fib_trie.c:415 (discriminator 7))
fib_table_flush (net/ipv4/fib_trie.c:469 net/ipv4/fib_trie.c:2079)
? __pfx_fib_table_flush (net/ipv4/fib_trie.c:2001)
? __pfx_fib_sync_down_dev (net/ipv4/fib_semantics.c:1937)
fib_flush (net/ipv4/fib_frontend.c:195 (discriminator 11))
fib_netdev_event (net/ipv4/fib_frontend.c:1458 net/ipv4/fib_frontend.c:1545=
)
notifier_call_chain (kernel/notifier.c:85)
dev_close_many (net/core/dev.c:1789)
? __pfx_dev_close_many (net/core/dev.c:1776)
netif_close (./include/linux/list.h:124 ./include/linux/list.h:215
./include/linux/list.h:229 net/core/dev.c:1802 net/core/dev.c:1795)
? __pfx_netif_close (net/core/dev.c:1796)
? mark_held_locks (kernel/locking/lockdep.c:4326)
bnxt_shutdown (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16707) bnxt_en
pci_device_shutdown (drivers/pci/pci-driver.c:511)
device_shutdown (drivers/base/core.c:4820)
kernel_restart (kernel/reboot.c:271 kernel/reboot.c:285)
__do_sys_reboot (kernel/reboot.c:763)
? __pfx___do_sys_reboot (kernel/reboot.c:725)
? rseq_get_rseq_cs (kernel/rseq.c:310)
? rseq_syscall (kernel/rseq.c:465)
? __pfx_rseq_syscall (kernel/rseq.c:458)
? do_writev (fs/read_write.c:1101)
? __pfx_do_writev (fs/read_write.c:1091)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f7f28830a07
Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f
1e fa 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d
008
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   c7 c0 ff ff ff ff       mov    $0xffffffff,%eax
   6:   eb be                   jmp    0xffffffffffffffc6
   8:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
   f:   00 00 00
  12:   90                      nop
  13:   f3 0f 1e fa             endbr64
  17:   89 fa                   mov    %edi,%edx
  19:   be 69 19 12 28          mov    $0x28121969,%esi
  1e:   bf ad de e1 fe          mov    $0xfee1dead,%edi
  23:   b8 a9 00 00 00          mov    $0xa9,%eax
  28:   0f 05                   syscall
  2a:*  48                      rex.W           <-- trapping instruction
  2b:   3d                      .byte 0x3d
  2c:   08                      .byte 0x8

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   48                      rex.W
   1:   3d                      .byte 0x3d
   2:   08                      .byte 0x8
RSP: 002b:00007ffc65d6b1a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a9
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7f28830a07
RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
RBP: 00007ffc65d6b3e0 R08: 0000000000000069 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000001234567
</TASK>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: suspicious RCU usage
6.14.0+ #2 Tainted: G        W
-----------------------------
net/ipv4/fib_trie.c:690 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active =3D 2, debug_locks =3D 1
4 locks held by shutdown/1:
#0: ffffffffa4d58750 (system_transition_mutex){+.+.}-{4:4}, at:
__do_sys_reboot (kernel/reboot.c:760)
#1: ffff888114d0c1b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/device.h:922 drivers/base/core.c:4802)
#2: ffff8881152211b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/pm_runtime.h:121 drivers/base/core.c:4805)
#3: ffff888178e24d90 (&dev->lock){+.+.}-{4:4}, at: bnxt_shutdown
(drivers/net/ethernet/broadcom/bnxt/bnxt.c:16703) bnxt_en

stack backtrace:
CPU: 0 UID: 0 PID: 1 Comm: shutdown Tainted: G        W
6.14.0+ #2 PREEMPT(undef)  271a3d276f79e3bb26d6065917556e94aae0d88d
Tainted: [W]=3DWARN
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/20=
21
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:123)
lockdep_rcu_suspicious (kernel/locking/lockdep.c:6863)
resize (net/ipv4/fib_trie.c:690 net/ipv4/fib_trie.c:901)
? update_suffix (net/ipv4/fib_trie.c:721 (discriminator 3))
fib_table_flush (net/ipv4/fib_trie.c:2027)
? __pfx_fib_table_flush (net/ipv4/fib_trie.c:2001)
? __pfx_fib_sync_down_dev (net/ipv4/fib_semantics.c:1937)
fib_flush (net/ipv4/fib_frontend.c:195 (discriminator 11))
fib_netdev_event (net/ipv4/fib_frontend.c:1458 net/ipv4/fib_frontend.c:1545=
)
notifier_call_chain (kernel/notifier.c:85)
dev_close_many (net/core/dev.c:1789)
? __pfx_dev_close_many (net/core/dev.c:1776)
netif_close (./include/linux/list.h:124 ./include/linux/list.h:215
./include/linux/list.h:229 net/core/dev.c:1802 net/core/dev.c:1795)
? __pfx_netif_close (net/core/dev.c:1796)
? mark_held_locks (kernel/locking/lockdep.c:4326)
bnxt_shutdown (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16707) bnxt_en
pci_device_shutdown (drivers/pci/pci-driver.c:511)
device_shutdown (drivers/base/core.c:4820)
kernel_restart (kernel/reboot.c:271 kernel/reboot.c:285)
__do_sys_reboot (kernel/reboot.c:763)
? __pfx___do_sys_reboot (kernel/reboot.c:725)
? rseq_get_rseq_cs (kernel/rseq.c:310)
? rseq_syscall (kernel/rseq.c:465)
? __pfx_rseq_syscall (kernel/rseq.c:458)
? do_writev (fs/read_write.c:1101)
? __pfx_do_writev (fs/read_write.c:1091)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f7f28830a07
Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f
1e fa 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d
008
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   c7 c0 ff ff ff ff       mov    $0xffffffff,%eax
   6:   eb be                   jmp    0xffffffffffffffc6
   8:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
   f:   00 00 00
  12:   90                      nop
  13:   f3 0f 1e fa             endbr64
  17:   89 fa                   mov    %edi,%edx
  19:   be 69 19 12 28          mov    $0x28121969,%esi
  1e:   bf ad de e1 fe          mov    $0xfee1dead,%edi
  23:   b8 a9 00 00 00          mov    $0xa9,%eax
  28:   0f 05                   syscall
  2a:*  48                      rex.W           <-- trapping instruction
  2b:   3d                      .byte 0x3d
  2c:   08                      .byte 0x8

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   48                      rex.W
   1:   3d                      .byte 0x3d
   2:   08                      .byte 0x8
RSP: 002b:00007ffc65d6b1a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a9
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7f28830a07
RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
RBP: 00007ffc65d6b3e0 R08: 0000000000000069 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000001234567
</TASK>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: suspicious RCU usage
6.14.0+ #2 Tainted: G        W
-----------------------------
net/ipv4/fib_trie.c:693 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active =3D 2, debug_locks =3D 1
4 locks held by shutdown/1:
#0: ffffffffa4d58750 (system_transition_mutex){+.+.}-{4:4}, at:
__do_sys_reboot (kernel/reboot.c:760)
#1: ffff888114d0c1b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/device.h:922 drivers/base/core.c:4802)
#2: ffff8881152211b8 (&dev->mutex){....}-{4:4}, at: device_shutdown
(./include/linux/pm_runtime.h:121 drivers/base/core.c:4805)
#3: ffff888178e24d90 (&dev->lock){+.+.}-{4:4}, at: bnxt_shutdown
(drivers/net/ethernet/broadcom/bnxt/bnxt.c:16703) bnxt_en

stack backtrace:
CPU: 0 UID: 0 PID: 1 Comm: shutdown Tainted: G        W
6.14.0+ #2 PREEMPT(undef)  271a3d276f79e3bb26d6065917556e94aae0d88d
Tainted: [W]=3DWARN
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/20=
21
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:123)
lockdep_rcu_suspicious (kernel/locking/lockdep.c:6863)
resize (net/ipv4/fib_trie.c:693 net/ipv4/fib_trie.c:901)
? update_suffix (net/ipv4/fib_trie.c:721 (discriminator 3))
fib_table_flush (net/ipv4/fib_trie.c:2027)
? __pfx_fib_table_flush (net/ipv4/fib_trie.c:2001)
? __pfx_fib_sync_down_dev (net/ipv4/fib_semantics.c:1937)
fib_flush (net/ipv4/fib_frontend.c:195 (discriminator 11))
fib_netdev_event (net/ipv4/fib_frontend.c:1458 net/ipv4/fib_frontend.c:1545=
)
notifier_call_chain (kernel/notifier.c:85)
dev_close_many (net/core/dev.c:1789)
? __pfx_dev_close_many (net/core/dev.c:1776)
netif_close (./include/linux/list.h:124 ./include/linux/list.h:215
./include/linux/list.h:229 net/core/dev.c:1802 net/core/dev.c:1795)
? __pfx_netif_close (net/core/dev.c:1796)
? mark_held_locks (kernel/locking/lockdep.c:4326)
bnxt_shutdown (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16707) bnxt_en
pci_device_shutdown (drivers/pci/pci-driver.c:511)
device_shutdown (drivers/base/core.c:4820)
kernel_restart (kernel/reboot.c:271 kernel/reboot.c:285)
__do_sys_reboot (kernel/reboot.c:763)
? __pfx___do_sys_reboot (kernel/reboot.c:725)
? rseq_get_rseq_cs (kernel/rseq.c:310)
? rseq_syscall (kernel/rseq.c:465)
? __pfx_rseq_syscall (kernel/rseq.c:458)
? do_writev (fs/read_write.c:1101)
? __pfx_do_writev (fs/read_write.c:1091)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f7f28830a07
Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f
1e fa 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d
008
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   c7 c0 ff ff ff ff       mov    $0xffffffff,%eax
   6:   eb be                   jmp    0xffffffffffffffc6
   8:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
   f:   00 00 00
  12:   90                      nop
  13:   f3 0f 1e fa             endbr64
  17:   89 fa                   mov    %edi,%edx
  19:   be 69 19 12 28          mov    $0x28121969,%esi
  1e:   bf ad de e1 fe          mov    $0xfee1dead,%edi
  23:   b8 a9 00 00 00          mov    $0xa9,%eax
  28:   0f 05                   syscall
  2a:*  48                      rex.W           <-- trapping instruction
  2b:   3d                      .byte 0x3d
  2c:   08                      .byte 0x8

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   48                      rex.W
   1:   3d                      .byte 0x3d
   2:   08                      .byte 0x8
RSP: 002b:00007ffc65d6b1a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a9
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7f28830a07
RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
RBP: 00007ffc65d6b3e0 R08: 0000000000000069 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000001234567
</TASK>
------------[ cut here ]------------
RTNL: assertion failed at net/ipv6/addrconf.c (3850)
WARNING: CPU: 0 PID: 1 at net/ipv6/addrconf.c:3850
addrconf_ifdown.isra.0 (net/ipv6/addrconf.c:3850)
Modules linked in: xt_nat xt_tcpudp veth xt_conntrack nft_chain_nat
xt_MASQUERADE nf_conntrack_netlink xfrm_user xt_addrtype nft_compat
nf_tabs
CPU: 0 UID: 0 PID: 1 Comm: shutdown Tainted: G        W
6.14.0+ #2 PREEMPT(undef)  271a3d276f79e3bb26d6065917556e94aae0d88d
Tainted: [W]=3DWARN
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/20=
21
RIP: 0010:addrconf_ifdown.isra.0 (net/ipv6/addrconf.c:3850)
Code: e3 25 ef 08 00 0f 85 49 f0 ff ff ba 0a 0f 00 00 48 c7 c6 80 77
04 a4 48 c7 c7 c0 77 04 a4 c6 05 c3 25 ef 08 01 e8 ab 7b dc fd <0f> 0b
e9f
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   e3 25                   jrcxz  0x27
   2:   ef                      out    %eax,(%dx)
   3:   08 00                   or     %al,(%rax)
   5:   0f 85 49 f0 ff ff       jne    0xfffffffffffff054
   b:   ba 0a 0f 00 00          mov    $0xf0a,%edx
  10:   48 c7 c6 80 77 04 a4    mov    $0xffffffffa4047780,%rsi
  17:   48 c7 c7 c0 77 04 a4    mov    $0xffffffffa40477c0,%rdi
  1e:   c6 05 c3 25 ef 08 01    movb   $0x1,0x8ef25c3(%rip)        # 0x8ef2=
5e8
  25:   e8 ab 7b dc fd          call   0xfffffffffddc7bd5
  2a:*  0f 0b                   ud2             <-- trapping instruction
  2c:   9f                      lahf

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   0f 0b                   ud2
   2:   9f                      lahf
RSP: 0018:ffff888104e2f970 EFLAGS: 00010282
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: 0000000000000002 RSI: 0000000000000004 RDI: 0000000000000001
RBP: ffff888104e2fa90 R08: 0000000000000000 R09: fffffbfff49a4af4
R10: 0000000000000003 R11: 0000000000000001 R12: 0000000000000002
R13: 0000000000000002 R14: ffff888104e2fbc8 R15: ffff888178e24000
FS:  00007f7f27cb4440(0000) GS:ffff88886dc22000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc65d6b0cc CR3: 00000001d73de000 CR4: 00000000007506f0
PKRU: 55555554
Call Trace:
<TASK>
? __warn (kernel/panic.c:748)
? __pfx_vprintk_emit.part.0 (kernel/printk/printk.c:2378)
? addrconf_ifdown.isra.0 (net/ipv6/addrconf.c:3850)
? report_bug (lib/bug.c:201 lib/bug.c:219)
? addrconf_ifdown.isra.0 (net/ipv6/addrconf.c:3850)
? handle_bug (arch/x86/kernel/traps.c:337)
? exc_invalid_op (arch/x86/kernel/traps.c:391 (discriminator 1))
? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:578)
? addrconf_ifdown.isra.0 (net/ipv6/addrconf.c:3850)
? find_held_lock (kernel/locking/lockdep.c:5348)
? mark_held_locks (kernel/locking/lockdep.c:4326)
? _raw_spin_unlock_irqrestore (./include/linux/spinlock_api_smp.h:151
kernel/locking/spinlock.c:194)
? __pfx_addrconf_ifdown.isra.0 (net/ipv6/addrconf.c:3839)
? __timer_delete_sync (kernel/time/timer.c:1664)
addrconf_notify (net/ipv6/addrconf.c:3809)
? ip6mr_device_event (net/ipv6/ip6mr.c:1277)
? neigh_ifdown (net/core/neighbour.c:445)
? fib_netdev_event (net/ipv4/fib_frontend.c:1549)
notifier_call_chain (kernel/notifier.c:85)
dev_close_many (net/core/dev.c:1789)
? __pfx_dev_close_many (net/core/dev.c:1776)
netif_close (./include/linux/list.h:124 ./include/linux/list.h:215
./include/linux/list.h:229 net/core/dev.c:1802 net/core/dev.c:1795)
? __pfx_netif_close (net/core/dev.c:1796)
? mark_held_locks (kernel/locking/lockdep.c:4326)
bnxt_shutdown (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16707) bnxt_en
pci_device_shutdown (drivers/pci/pci-driver.c:511)
device_shutdown (drivers/base/core.c:4820)
kernel_restart (kernel/reboot.c:271 kernel/reboot.c:285)
__do_sys_reboot (kernel/reboot.c:763)
? __pfx___do_sys_reboot (kernel/reboot.c:725)
? rseq_get_rseq_cs (kernel/rseq.c:310)
? rseq_syscall (kernel/rseq.c:465)
? __pfx_rseq_syscall (kernel/rseq.c:458)
? do_writev (fs/read_write.c:1101)
? __pfx_do_writev (fs/read_write.c:1091)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f7f28830a07
Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f
1e fa 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d
008
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   c7 c0 ff ff ff ff       mov    $0xffffffff,%eax
   6:   eb be                   jmp    0xffffffffffffffc6
   8:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
   f:   00 00 00
  12:   90                      nop
  13:   f3 0f 1e fa             endbr64
  17:   89 fa                   mov    %edi,%edx
  19:   be 69 19 12 28          mov    $0x28121969,%esi
  1e:   bf ad de e1 fe          mov    $0xfee1dead,%edi
  23:   b8 a9 00 00 00          mov    $0xa9,%eax
  28:   0f 05                   syscall
  2a:*  48                      rex.W           <-- trapping instruction
  2b:   3d                      .byte 0x3d
  2c:   08                      .byte 0x8

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   48                      rex.W
   1:   3d                      .byte 0x3d
   2:   08                      .byte 0x8
RSP: 002b:00007ffc65d6b1a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a9
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7f28830a07
RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
RBP: 00007ffc65d6b3e0 R08: 0000000000000069 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000001234567
</TASK>
irq event stamp: 12770237
hardirqs last enabled at (12770249): __up_console_sem
(kernel/printk/printk.c:344 (discriminator 1))
hardirqs last disabled at (12770260): __up_console_sem
(kernel/printk/printk.c:342 (discriminator 1))
softirqs last enabled at (12770118): __irq_exit_rcu
(kernel/softirq.c:596 kernel/softirq.c:435 kernel/softirq.c:662)
softirqs last disabled at (12770113): __irq_exit_rcu
(kernel/softirq.c:596 kernel/softirq.c:435 kernel/softirq.c:662)
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
RTNL: assertion failed at net/ipv6/addrconf.c (6252)
WARNING: CPU: 0 PID: 1 at net/ipv6/addrconf.c:6252 __ipv6_ifa_notify
(net/ipv6/addrconf.c:6252 (discriminator 3))
Modules linked in: xt_nat xt_tcpudp veth xt_conntrack nft_chain_nat
xt_MASQUERADE nf_conntrack_netlink xfrm_user xt_addrtype nft_compat
nf_tabs
CPU: 0 UID: 0 PID: 1 Comm: shutdown Tainted: G        W
6.14.0+ #2 PREEMPT(undef)  271a3d276f79e3bb26d6065917556e94aae0d88d
Tainted: [W]=3DWARN
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/20=
21
RIP: 0010:__ipv6_ifa_notify (net/ipv6/addrconf.c:6252 (discriminator 3))
Code: b5 fa ff ff ba 6c 18 00 00 48 c7 c6 80 77 04 a4 48 c7 c7 c0 77
04 a4 44 89 a5 28 ff ff ff c6 05 6f e2 ef 08 01 e8 5b 38 dd fd <0f> 0b
8bf
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   b5 fa                   mov    $0xfa,%ch
   2:   ff                      (bad)
   3:   ff                      (bad)
   4:   ba 6c 18 00 00          mov    $0x186c,%edx
   9:   48 c7 c6 80 77 04 a4    mov    $0xffffffffa4047780,%rsi
  10:   48 c7 c7 c0 77 04 a4    mov    $0xffffffffa40477c0,%rdi
  17:   44 89 a5 28 ff ff ff    mov    %r12d,-0xd8(%rbp)
  1e:   c6 05 6f e2 ef 08 01    movb   $0x1,0x8efe26f(%rip)        # 0x8efe=
294
  25:   e8 5b 38 dd fd          call   0xfffffffffddd3885
  2a:*  0f 0b                   ud2             <-- trapping instruction
  2c:   bf                      .byte 0xbf

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   0f 0b                   ud2
   2:   bf                      .byte 0xbf
RSP: 0018:ffff888104e2f870 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88815680e800 RCX: 0000000000000000
RDX: 0000000000000002 RSI: 0000000000000004 RDI: 0000000000000001
RBP: ffff888104e2f950 R08: 0000000000000000 R09: fffffbfff49a4af4
R10: 0000000000000003 R11: 0000000000000001 R12: 0000000000000015
R13: 1ffff110209c5f10 R14: ffffffffb0a15f40 R15: ffff88815680e950
FS:  00007f7f27cb4440(0000) GS:ffff88886dc22000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc65d6b0cc CR3: 00000001d73de000 CR4: 00000000007506f0
PKRU: 55555554
Call Trace:
<TASK>
? __warn (kernel/panic.c:748)
? __pfx_vprintk_emit.part.0 (kernel/printk/printk.c:2378)
? __ipv6_ifa_notify (net/ipv6/addrconf.c:6252 (discriminator 3))
? report_bug (lib/bug.c:201 lib/bug.c:219)
? __ipv6_ifa_notify (net/ipv6/addrconf.c:6252 (discriminator 3))
? handle_bug (arch/x86/kernel/traps.c:337)
? exc_invalid_op (arch/x86/kernel/traps.c:391 (discriminator 1))
? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:578)
? __ipv6_ifa_notify (net/ipv6/addrconf.c:6252 (discriminator 3))
? __pfx___ipv6_ifa_notify (net/ipv6/addrconf.c:6248)
? lock_acquire (kernel/locking/lockdep.c:472
kernel/locking/lockdep.c:5868 kernel/locking/lockdep.c:5823)
? do_raw_spin_trylock (./arch/x86/include/asm/atomic.h:107
./include/linux/atomic/atomic-arch-fallback.h:2170
./include/linux/atomic/atomic-instrumented.h:1302
./include/asm-generic/qspinlock.h:97
kernel/locking/spinlock_debug.c:123)
? addrconf_ifdown.isra.0 (net/ipv6/addrconf.c:3977)
addrconf_ifdown.isra.0 (net/ipv6/addrconf.c:3977)
? find_held_lock (kernel/locking/lockdep.c:5348)
? __pfx_addrconf_ifdown.isra.0 (net/ipv6/addrconf.c:3839)
? __timer_delete_sync (kernel/time/timer.c:1664)
addrconf_notify (net/ipv6/addrconf.c:3809)
? ip6mr_device_event (net/ipv6/ip6mr.c:1277)
? neigh_ifdown (net/core/neighbour.c:445)
? fib_netdev_event (net/ipv4/fib_frontend.c:1549)
notifier_call_chain (kernel/notifier.c:85)
dev_close_many (net/core/dev.c:1789)
? __pfx_dev_close_many (net/core/dev.c:1776)
netif_close (./include/linux/list.h:124 ./include/linux/list.h:215
./include/linux/list.h:229 net/core/dev.c:1802 net/core/dev.c:1795)
? __pfx_netif_close (net/core/dev.c:1796)
? mark_held_locks (kernel/locking/lockdep.c:4326)
bnxt_shutdown (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16707) bnxt_en
pci_device_shutdown (drivers/pci/pci-driver.c:511)
device_shutdown (drivers/base/core.c:4820)
kernel_restart (kernel/reboot.c:271 kernel/reboot.c:285)
__do_sys_reboot (kernel/reboot.c:763)
? __pfx___do_sys_reboot (kernel/reboot.c:725)
? rseq_get_rseq_cs (kernel/rseq.c:310)
? rseq_syscall (kernel/rseq.c:465)
? __pfx_rseq_syscall (kernel/rseq.c:458)
? do_writev (fs/read_write.c:1101)
? __pfx_do_writev (fs/read_write.c:1091)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f7f28830a07
Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f
1e fa 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d
008
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   c7 c0 ff ff ff ff       mov    $0xffffffff,%eax
   6:   eb be                   jmp    0xffffffffffffffc6
   8:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
   f:   00 00 00
  12:   90                      nop
  13:   f3 0f 1e fa             endbr64
  17:   89 fa                   mov    %edi,%edx
  19:   be 69 19 12 28          mov    $0x28121969,%esi
  1e:   bf ad de e1 fe          mov    $0xfee1dead,%edi
  23:   b8 a9 00 00 00          mov    $0xa9,%eax
  28:   0f 05                   syscall
  2a:*  48                      rex.W           <-- trapping instruction
  2b:   3d                      .byte 0x3d
  2c:   08                      .byte 0x8

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   48                      rex.W
   1:   3d                      .byte 0x3d
   2:   08                      .byte 0x8
RSP: 002b:00007ffc65d6b1a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a9
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7f28830a07
RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
RBP: 00007ffc65d6b3e0 R08: 0000000000000069 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000001234567
</TASK>
irq event stamp: 12773159
hardirqs last enabled at (12773171): __up_console_sem
(kernel/printk/printk.c:344 (discriminator 1))
hardirqs last disabled at (12773182): __up_console_sem
(kernel/printk/printk.c:342 (discriminator 1))
softirqs last enabled at (12773004): __irq_exit_rcu
(kernel/softirq.c:596 kernel/softirq.c:435 kernel/softirq.c:662)
softirqs last disabled at (12772999): __irq_exit_rcu
(kernel/softirq.c:596 kernel/softirq.c:435 kernel/softirq.c:662)
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
RTNL: assertion failed at net/ipv6/mcast.c (1008)
WARNING: CPU: 0 PID: 1 at net/ipv6/mcast.c:1008 __ipv6_dev_mc_dec
(net/ipv6/mcast.c:1008 (discriminator 3))
Modules linked in: xt_nat xt_tcpudp veth xt_conntrack nft_chain_nat
xt_MASQUERADE nf_conntrack_netlink xfrm_user xt_addrtype nft_compat
nf_tabs
CPU: 0 UID: 0 PID: 1 Comm: shutdown Tainted: G        W
6.14.0+ #2 PREEMPT(undef)  271a3d276f79e3bb26d6065917556e94aae0d88d
Tainted: [W]=3DWARN
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/20=
21
RIP: 0010:__ipv6_dev_mc_dec (net/ipv6/mcast.c:1008 (discriminator 3))
Code: 40 b2 e4 08 00 0f 85 d7 fd ff ff ba f0 03 00 00 48 c7 c6 00 58
05 a4 48 c7 c7 60 5d 05 a4 c6 05 20 b2 e4 08 01 e8 f2 07 d2 fd <0f> 0b
e9b
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   40 b2 e4                rex mov $0xe4,%dl
   3:   08 00                   or     %al,(%rax)
   5:   0f 85 d7 fd ff ff       jne    0xfffffffffffffde2
   b:   ba f0 03 00 00          mov    $0x3f0,%edx
  10:   48 c7 c6 00 58 05 a4    mov    $0xffffffffa4055800,%rsi
  17:   48 c7 c7 60 5d 05 a4    mov    $0xffffffffa4055d60,%rdi
  1e:   c6 05 20 b2 e4 08 01    movb   $0x1,0x8e4b220(%rip)        # 0x8e4b=
245
  25:   e8 f2 07 d2 fd          call   0xfffffffffdd2081c
  2a:*  0f 0b                   ud2             <-- trapping instruction
  2c:   9b                      fwait

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   0f 0b                   ud2
   2:   9b                      fwait
RSP: 0018:ffff888104e2f818 EFLAGS: 00010292
RAX: 0000000000000000 RBX: ffff888104e2f8e0 RCX: 0000000000000000
RDX: 0000000000000002 RSI: 0000000000000004 RDI: 0000000000000001
RBP: ffff888104e2f950 R08: 0000000000000000 R09: fffffbfff49a4af4
R10: 0000000000000003 R11: 0000000000000001 R12: ffff888144111000
R13: ffff888144111000 R14: ffffffffb0a15f40 R15: ffff88815680e950
FS:  00007f7f27cb4440(0000) GS:ffff88886dc22000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc65d6b0cc CR3: 00000001d73de000 CR4: 00000000007506f0
PKRU: 55555554
Call Trace:
<TASK>
? __warn (kernel/panic.c:748)
? __ipv6_dev_mc_dec (net/ipv6/mcast.c:1008 (discriminator 3))
? report_bug (lib/bug.c:201 lib/bug.c:219)
? __ipv6_dev_mc_dec (net/ipv6/mcast.c:1008 (discriminator 3))
? handle_bug (arch/x86/kernel/traps.c:337)
? exc_invalid_op (arch/x86/kernel/traps.c:391 (discriminator 1))
? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:578)
? __ipv6_dev_mc_dec (net/ipv6/mcast.c:1008 (discriminator 3))
? __ipv6_dev_mc_dec (net/ipv6/mcast.c:1008 (discriminator 3))
? nlmsg_notify (net/netlink/af_netlink.c:2578)
__ipv6_ifa_notify (net/ipv6/addrconf.c:2254 net/ipv6/addrconf.c:2246
net/ipv6/addrconf.c:6283)
? __pfx___ipv6_ifa_notify (net/ipv6/addrconf.c:6248)
? do_raw_spin_trylock (./arch/x86/include/asm/atomic.h:107
./include/linux/atomic/atomic-arch-fallback.h:2170
./include/linux/atomic/atomic-instrumented.h:1302
./include/asm-generic/qspinlock.h:97
kernel/locking/spinlock_debug.c:123)
? addrconf_ifdown.isra.0 (net/ipv6/addrconf.c:3977)
addrconf_ifdown.isra.0 (net/ipv6/addrconf.c:3977)
? find_held_lock (kernel/locking/lockdep.c:5348)
? __pfx_addrconf_ifdown.isra.0 (net/ipv6/addrconf.c:3839)
? __timer_delete_sync (kernel/time/timer.c:1664)
addrconf_notify (net/ipv6/addrconf.c:3809)
? ip6mr_device_event (net/ipv6/ip6mr.c:1277)
? neigh_ifdown (net/core/neighbour.c:445)
? fib_netdev_event (net/ipv4/fib_frontend.c:1549)
notifier_call_chain (kernel/notifier.c:85)
dev_close_many (net/core/dev.c:1789)
? __pfx_dev_close_many (net/core/dev.c:1776)
netif_close (./include/linux/list.h:124 ./include/linux/list.h:215
./include/linux/list.h:229 net/core/dev.c:1802 net/core/dev.c:1795)
? __pfx_netif_close (net/core/dev.c:1796)
? mark_held_locks (kernel/locking/lockdep.c:4326)
bnxt_shutdown (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16707) bnxt_en
pci_device_shutdown (drivers/pci/pci-driver.c:511)
device_shutdown (drivers/base/core.c:4820)
kernel_restart (kernel/reboot.c:271 kernel/reboot.c:285)
__do_sys_reboot (kernel/reboot.c:763)
? __pfx___do_sys_reboot (kernel/reboot.c:725)
? rseq_get_rseq_cs (kernel/rseq.c:310)
? rseq_syscall (kernel/rseq.c:465)
? __pfx_rseq_syscall (kernel/rseq.c:458)
? do_writev (fs/read_write.c:1101)
? __pfx_do_writev (fs/read_write.c:1091)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:9=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f7f28830a07
Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f
1e fa 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d
008
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   c7 c0 ff ff ff ff       mov    $0xffffffff,%eax
   6:   eb be                   jmp    0xffffffffffffffc6
   8:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
   f:   00 00 00
  12:   90                      nop
  13:   f3 0f 1e fa             endbr64
  17:   89 fa                   mov    %edi,%edx
  19:   be 69 19 12 28          mov    $0x28121969,%esi
  1e:   bf ad de e1 fe          mov    $0xfee1dead,%edi
  23:   b8 a9 00 00 00          mov    $0xa9,%eax
  28:   0f 05                   syscall
  2a:*  48                      rex.W           <-- trapping instruction
  2b:   3d                      .byte 0x3d
  2c:   08                      .byte 0x8

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   48                      rex.W
   1:   3d                      .byte 0x3d
   2:   08                      .byte 0x8
RSP: 002b:00007ffc65d6b1a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a9
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7f28830a07
RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
RBP: 00007ffc65d6b3e0 R08: 0000000000000069 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000001234567
</TASK>
irq event stamp: 12774589
hardirqs last enabled at (12774601): __up_console_sem
(kernel/printk/printk.c:344 (discriminator 1))
hardirqs last disabled at (12774612): __up_console_sem
(kernel/printk/printk.c:342 (discriminator 1))
softirqs last enabled at (12774418): __irq_exit_rcu
(kernel/softirq.c:596 kernel/softirq.c:435 kernel/softirq.c:662)
softirqs last disabled at (12774633): __irq_exit_rcu
(kernel/softirq.c:596 kernel/softirq.c:435 kernel/softirq.c:662)
---[ end trace 0000000000000000 ]---

Sorry for the too-long splats.

I didn't see all splats, but I think the cause is only one,
netdev_lock()+netif_close() path. please look at bnxt_shutdown().

The commits 110eff172dfe ("eth: bnxt: switch to netif_close") and
004b5008016a ("eth: bnxt: remove most dependencies on RTNL")
replace rtnl_lock() + dev_close() to netdev_lock() + netif_close().
However, internal functions of netif_close() are still using
rtnl_dereference(). So, there are many RTNL assertions on the
netif_close() path.
Only the bnxt driver uses netif_close(), so other drivers don't have
this problem.
Could you please look into this?

Thanks a lot!
Taehee Yoo

> v2:
> - export netdev_get_by_index_lock
> - new patch: add netdev_lockdep_set_classes to mlx5
> - new patch: exercise notifiers in netdevsim
> - ignore specific locked netdev in call_netdevice_register_notifiers,
>   not all
>
> Jakub Kicinski (3):
>   net: designate XSK pool pointers in queues as "ops protected"
>   netdev: add "ops compat locking" helpers
>   netdev: don't hold rtnl_lock over nl queue info get when possible
>
> Stanislav Fomichev (8):
>   net: switch to netif_disable_lro in inetdev_init
>   net: hold instance lock during NETDEV_REGISTER/UP/UNREGISTER
>   net: use netif_disable_lro in ipv6_add_dev
>   net: release instance lock during NETDEV_UNREGISTER for bond/team
>   net/mlx5e: use netdev_lockdep_set_classes
>   netdevsim: add dummy device notifiers
>   net: dummy: request ops lock
>   docs: net: document netdev notifier expectations
>
>  Documentation/networking/netdevices.rst       |  18 +++
>  drivers/net/bonding/bond_main.c               |   2 +
>  drivers/net/dummy.c                           |   1 +
>  .../net/ethernet/mellanox/mlx5/core/en_main.c |   2 +
>  drivers/net/netdevsim/netdev.c                |  58 +++++++++
>  drivers/net/netdevsim/netdevsim.h             |   3 +
>  drivers/net/team/team_core.c                  |   2 +
>  include/linux/netdevice.h                     |   2 +
>  include/net/netdev_lock.h                     |  16 +++
>  include/net/netdev_rx_queue.h                 |   6 +-
>  net/core/dev.c                                | 117 ++++++++++++++----
>  net/core/dev.h                                |  16 ++-
>  net/core/netdev-genl.c                        |  18 ++-
>  net/ipv4/devinet.c                            |   2 +-
>  net/ipv6/addrconf.c                           |  17 ++-
>  net/xdp/xsk_buff_pool.c                       |   7 +-
>  16 files changed, 245 insertions(+), 42 deletions(-)
>
> --
> 2.48.1
>
>

