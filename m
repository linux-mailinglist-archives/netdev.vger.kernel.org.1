Return-Path: <netdev+bounces-42360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 619007CE73A
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 20:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F9E3B20C6E
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 18:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C6B3FB20;
	Wed, 18 Oct 2023 18:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E230A3B2AE
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 18:53:39 +0000 (UTC)
Received: from mx.ewheeler.net (mx.ewheeler.net [173.205.220.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907B5114
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 11:53:37 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 4E19A81;
	Wed, 18 Oct 2023 11:53:37 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id CC2_oPsr9TJf; Wed, 18 Oct 2023 11:53:32 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id BFF2340;
	Wed, 18 Oct 2023 11:53:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net BFF2340
Date: Wed, 18 Oct 2023 11:53:32 -0700 (PDT)
From: Eric Wheeler <netdev@lists.ewheeler.net>
To: Jakub Kicinski <kuba@kernel.org>
cc: netdev@vger.kernel.org
Subject: Re: BUG: looking up invalid subclass: 8
In-Reply-To: <44d7fba4-3887-50ff-3dd1-3ca39164e6a@ewheeler.net>
Message-ID: <6dc9ecc-1aff-d33d-991d-a44baae2f8dc@ewheeler.net>
References: <cea84b66-2ad5-76af-3feb-418b78cdd87@ewheeler.net> <20231017170900.62f951cd@kernel.org> <44d7fba4-3887-50ff-3dd1-3ca39164e6a@ewheeler.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 18 Oct 2023, Eric Wheeler wrote:
> On Tue, 17 Oct 2023, Jakub Kicinski wrote:
> > On Tue, 17 Oct 2023 16:41:41 -0700 (PDT) Eric Wheeler wrote:
> > > I found a similar backtrace that was fixed in
> > > 3510c7aa069aa83a2de6dab2b41401a198317bdc .  It was for ALSA, but had the
> > > same BUG of "looking up invalid subclass: 8" and the fix was trivial,
> > > noting that MAX_HOPS shouldn't be bigger than MAX_LOCKDEP_SUBCLASSES.
> > > 
> > > Is there a simple fix for this in netlink, too?
> > > 
> > > ]# ./scripts/decode_stacktrace.sh vmlinux `pwd` < stackdump.txt 
> > > [  113.347055] BUG: looking up invalid subclass: 8
> > > [  113.357387] turning off the locking correctness validator.
> > > [  113.364842] Hardware name: Supermicro Super Server/H11SSL-i, BIOS 2.4 12/27/2021
> > > [  113.373614] Call Trace:
> > > [  113.381874]  <TASK>
> > > [  113.382556] dump_stack_lvl (lib/dump_stack.c:108) 
> > > [  113.388816] look_up_lock_class (kernel/locking/lockdep.c:941) 
> > > [  113.399562] register_lock_class (kernel/locking/lockdep.c:1284 (discriminator 13)) 
> > > [  113.400238] ? srso_return_thunk (arch/x86/lib/retpoline.S:308) 
> > > [  113.403627] __lock_acquire (kernel/locking/lockdep.c:5014) 
> > > [  113.414652] lock_acquire.part.0 (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5755) 
> > > [  113.428619] ? srso_return_thunk (arch/x86/lib/retpoline.S:308) 
> > > [  113.435463] ? lock_acquire (./include/trace/events/lock.h:24 kernel/locking/lockdep.c:5724) 
> > > [  113.440620] _raw_spin_lock_nested (kernel/locking/spinlock.c:379) 
> > > [  113.462749] ? __nla_validate_parse (lib/nlattr.c:606) 
> > > [  113.471052] genl_family_rcv_msg_doit.isra.0 (net/netlink/genetlink.c:970) 
> > > [  113.471651] genl_family_rcv_msg (net/netlink/genetlink.c:1050) 
> > 
> > Thanks for sharing the decoded stack trace, can you share the full
> > non-decoded one? Is there the name of the command that's calling
> > this somewhere?
> > 
> > There's no lock where this is pointing at, just an indirect call.
> > So I wonder where the lock is. Perhaps retpoline is confusing 
> > the stack trace :(

Hmm, I just noticed the original decoded trace is different and does not 
include drbd.  I don't know that I have the output that specifies the 
command, just this much starting at "BUG".  I only copy-pasted enough to 
get the decode. This is the dump from the first email to netdev (scroll 
down, more commentary below the dump):

]# cat stackdump.txt
[  113.347055] BUG: looking up invalid subclass: 8
[  113.357387] turning off the locking correctness validator.
[  113.364842] Hardware name: Supermicro Super Server/H11SSL-i, BIOS 2.4 12/27/2021
[  113.373614] Call Trace:
[  113.381874]  <TASK>
[  113.382556]  dump_stack_lvl+0x60/0xa0
[  113.388816]  look_up_lock_class+0x10b/0x150
[  113.399562]  register_lock_class+0x48/0x500
[  113.400238]  ? srso_return_thunk+0x5/0x10
[  113.403627]  __lock_acquire+0x5f/0xb80
[  113.414652]  lock_acquire.part.0+0x90/0x210
[  113.428619]  ? srso_return_thunk+0x5/0x10
[  113.435463]  ? lock_acquire+0x10b/0x120
[  113.440620]  _raw_spin_lock_nested+0x33/0x80
[  113.462749]  ? __nla_validate_parse+0x13f/0x1f0
[  113.471052]  genl_family_rcv_msg_doit.isra.0+0xe4/0x150
[  113.471651]  genl_family_rcv_msg+0x187/0x260
[  113.483623]  genl_rcv_msg+0x4b/0xb0
[  113.489055]  ? __pfx_genl_rcv_msg+0x10/0x10
[  113.489623]  netlink_rcv_skb+0x66/0x120
[  113.492711]  genl_rcv+0x28/0x40
[  113.502610]  netlink_unicast+0x1b8/0x280
[  113.506927]  netlink_sendmsg+0x273/0x520
[  113.507486]  sock_write_iter+0x188/0x190
[  113.510657]  vfs_write+0x3e5/0x520
[  113.519624]  ksys_write+0xc8/0x100
[  113.524713]  do_syscall_64+0x3f/0xa0
[  113.525233]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[  113.526621] RIP: 0033:0x7f41c473e987
[  113.535618] Code: 0b 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 
c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[  113.543013] RSP: 002b:00007ffe80a28648 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  113.543627] RAX: ffffffffffffffda RBX: 00000000000000c8 RCX: 00007f41c473e987
[  113.552607] RDX: 00000000000000c8 RSI: 000055be8e4f7320 RDI: 0000000000000004
[  113.560243] RBP: 000055be8e4f7320 R08: 0000000000000000 R09: 0000000000000000
[  113.560803] R10: 0000000000001000 R11: 0000000000000246 R12: 00000000000000c8
[  113.561353] R13: 0000000000000004 R14: 00007ffe80a28970 R15: 000055be8d383848
[  113.569626]  </TASK>


> Here it is from two different hosts.
> 
> This is vanilla v6.5.7:
> 
> Oct 16 09:48:47 hv1.ewheeler.net kernel: BUG: looking up invalid subclass: 8
> Oct 16 09:48:47 hv1.ewheeler.net kernel: turning off the locking correctness validator.
> Oct 16 09:48:47 hv1.ewheeler.net kernel: CPU: 8 PID: 13275 Comm: drbdsetup-84 Tainted: G            E      6.5.7 #23
> Oct 16 09:48:47 hv1.ewheeler.net kernel: Hardware name: Supermicro Super Server/H11SSL-i, BIOS 2.4 12/27/2021
> Oct 16 09:48:47 hv1.ewheeler.net kernel: Call Trace:
> Oct 16 09:48:47 hv1.ewheeler.net kernel: <TASK>
> Oct 16 09:48:47 hv1.ewheeler.net kernel: dump_stack_lvl+0x60/0xa0
> Oct 16 09:48:47 hv1.ewheeler.net kernel: look_up_lock_class+0x10b/0x150
> Oct 16 09:48:47 hv1.ewheeler.net kernel: register_lock_class+0x48/0x500
> Oct 16 09:48:47 hv1.ewheeler.net kernel: ? srso_return_thunk+0x5/0x10
> Oct 16 09:48:47 hv1.ewheeler.net kernel: __lock_acquire+0x5f/0xb80
> Oct 16 09:48:47 hv1.ewheeler.net kernel: lock_acquire.part.0+0x90/0x210
> Oct 16 09:48:47 hv1.ewheeler.net kernel: ? lock_all_resources+0x5a/0x90 [drbd]
> Oct 16 09:48:47 hv1.ewheeler.net kernel: ? lock_all_resources+0x5a/0x90 [drbd]
> Oct 16 09:48:47 hv1.ewheeler.net kernel: ? srso_return_thunk+0x5/0x10
> Oct 16 09:48:47 hv1.ewheeler.net kernel: ? lock_acquire+0x10b/0x120
> Oct 16 09:48:47 hv1.ewheeler.net kernel: ? lock_all_resources+0x5a/0x90 [drbd]
> Oct 16 09:48:47 hv1.ewheeler.net kernel: _raw_spin_lock_nested+0x33/0x80
> Oct 16 09:48:47 hv1.ewheeler.net kernel: ? lock_all_resources+0x5a/0x90 [drbd]
> Oct 16 09:48:47 hv1.ewheeler.net kernel: lock_all_resources+0x5a/0x90 [drbd]
> Oct 16 09:48:47 hv1.ewheeler.net kernel: drbd_adm_attach+0x748/0x1340 [drbd]
> Oct 16 09:48:47 hv1.ewheeler.net kernel: ? __nla_validate_parse+0x13f/0x1f0
> Oct 16 09:48:47 hv1.ewheeler.net kernel: genl_family_rcv_msg_doit.isra.0+0xe4/0x150
> Oct 16 09:48:47 hv1.ewheeler.net kernel: genl_family_rcv_msg+0x187/0x260
> Oct 16 09:48:47 hv1.ewheeler.net kernel: ? __pfx_drbd_adm_attach+0x10/0x10 [drbd]
> Oct 16 09:48:47 hv1.ewheeler.net kernel: genl_rcv_msg+0x4b/0xb0
> Oct 16 09:48:47 hv1.ewheeler.net kernel: ? __pfx_genl_rcv_msg+0x10/0x10
> Oct 16 09:48:47 hv1.ewheeler.net kernel: netlink_rcv_skb+0x66/0x120
> Oct 16 09:48:47 hv1.ewheeler.net kernel: genl_rcv+0x28/0x40
> Oct 16 09:48:47 hv1.ewheeler.net kernel: netlink_unicast+0x1b8/0x280
> Oct 16 09:48:47 hv1.ewheeler.net kernel: netlink_sendmsg+0x273/0x520
> Oct 16 09:48:47 hv1.ewheeler.net kernel: sock_write_iter+0x188/0x190
> Oct 16 09:48:47 hv1.ewheeler.net kernel: vfs_write+0x3e5/0x520
> Oct 16 09:48:47 hv1.ewheeler.net kernel: ksys_write+0xc8/0x100
> Oct 16 09:48:47 hv1.ewheeler.net kernel: do_syscall_64+0x3f/0xa0
> Oct 16 09:48:47 hv1.ewheeler.net kernel: entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> Oct 16 09:48:47 hv1.ewheeler.net kernel: RIP: 0033:0x7f41c473e987
> Oct 16 09:48:47 hv1.ewheeler.net kernel: Code: 0b 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
> Oct 16 09:48:47 hv1.ewheeler.net kernel: RSP: 002b:00007ffe80a28648 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> Oct 16 09:48:47 hv1.ewheeler.net kernel: RAX: ffffffffffffffda RBX: 00000000000000c8 RCX: 00007f41c473e987
> Oct 16 09:48:47 hv1.ewheeler.net kernel: RDX: 00000000000000c8 RSI: 000055be8e4f7320 RDI: 0000000000000004
> Oct 16 09:48:47 hv1.ewheeler.net kernel: RBP: 000055be8e4f7320 R08: 0000000000000000 R09: 0000000000000000
> Oct 16 09:48:47 hv1.ewheeler.net kernel: R10: 0000000000001000 R11: 0000000000000246 R12: 00000000000000c8
> Oct 16 09:48:47 hv1.ewheeler.net kernel: R13: 0000000000000004 R14: 00007ffe80a28970 R15: 000055be8d383848
> Oct 16 09:48:47 hv1.ewheeler.net kernel: </TASK>

It is interesting that the original trace did _not_ have drbd in the
trace: Here is the decode for the one above that _does_ have DRBD:

Oct 16 09:48:47 hv1.ewheeler.net kernel: dump_stack_lvl (lib/dump_stack.c:108) 
Oct 16 09:48:47 hv1.ewheeler.net kernel: look_up_lock_class (kernel/locking/lockdep.c:941) 
Oct 16 09:48:47 hv1.ewheeler.net kernel: register_lock_class (kernel/locking/lockdep.c:1284 (discriminator 13)) 
Oct 16 09:48:47 hv1.ewheeler.net kernel: ? srso_return_thunk (arch/x86/lib/retpoline.S:308) 
Oct 16 09:48:47 hv1.ewheeler.net kernel: __lock_acquire (kernel/locking/lockdep.c:5014) 
Oct 16 09:48:47 hv1.ewheeler.net kernel: lock_acquire.part.0 (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5755) 
Oct 16 09:48:47 hv1.ewheeler.net kernel: ? lock_all_resources (drivers/block/drbd/drbd_main.c:3715 (discriminator 3)) drbd
Oct 16 09:48:47 hv1.ewheeler.net kernel: ? lock_all_resources (drivers/block/drbd/drbd_main.c:3715 (discriminator 3)) drbd
Oct 16 09:48:47 hv1.ewheeler.net kernel: ? srso_return_thunk (arch/x86/lib/retpoline.S:308) 
Oct 16 09:48:47 hv1.ewheeler.net kernel: ? lock_acquire (./include/trace/events/lock.h:24 kernel/locking/lockdep.c:5724) 
Oct 16 09:48:47 hv1.ewheeler.net kernel: ? lock_all_resources (drivers/block/drbd/drbd_main.c:3715 (discriminator 3)) drbd
Oct 16 09:48:47 hv1.ewheeler.net kernel: _raw_spin_lock_nested (kernel/locking/spinlock.c:379) 
Oct 16 09:48:47 hv1.ewheeler.net kernel: ? lock_all_resources (drivers/block/drbd/drbd_main.c:3715 (discriminator 3)) drbd
Oct 16 09:48:47 hv1.ewheeler.net kernel: lock_all_resources (drivers/block/drbd/drbd_main.c:3715 (discriminator 3)) drbd
Oct 16 09:48:47 hv1.ewheeler.net kernel: drbd_adm_attach (drivers/block/drbd/drbd_nl.c:1954) drbd
Oct 16 09:48:47 hv1.ewheeler.net kernel: ? __nla_validate_parse (lib/nlattr.c:606) 
Oct 16 09:48:47 hv1.ewheeler.net kernel: genl_family_rcv_msg_doit.isra.0 (net/netlink/genetlink.c:970) 
Oct 16 09:48:47 hv1.ewheeler.net kernel: genl_family_rcv_msg (net/netlink/genetlink.c:1050) 
Oct 16 09:48:47 hv1.ewheeler.net kernel: ? __pfx_drbd_adm_attach (drivers/block/drbd/drbd_nl.c:1723) drbd
Oct 16 09:48:47 hv1.ewheeler.net kernel: genl_rcv_msg (net/netlink/genetlink.c:1069) 
Oct 16 09:48:47 hv1.ewheeler.net kernel: ? __pfx_genl_rcv_msg (net/netlink/genetlink.c:1056) 
Oct 16 09:48:47 hv1.ewheeler.net kernel: netlink_rcv_skb (net/netlink/af_netlink.c:2519) 
Oct 16 09:48:47 hv1.ewheeler.net kernel: genl_rcv (net/netlink/genetlink.c:1079) 
Oct 16 09:48:47 hv1.ewheeler.net kernel: netlink_unicast (net/netlink/af_netlink.c:1338 net/netlink/af_netlink.c:1363) 
Oct 16 09:48:47 hv1.ewheeler.net kernel: netlink_sendmsg (net/netlink/af_netlink.c:1885) 
Oct 16 09:48:47 hv1.ewheeler.net kernel: sock_write_iter (net/socket.c:725 net/socket.c:740 net/socket.c:1147) 
Oct 16 09:48:47 hv1.ewheeler.net kernel: vfs_write (./include/linux/fs.h:1877 fs/read_write.c:491 fs/read_write.c:584) 
Oct 16 09:48:47 hv1.ewheeler.net kernel: ksys_write (fs/read_write.c:637) 
Oct 16 09:48:47 hv1.ewheeler.net kernel: do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
Oct 16 09:48:47 hv1.ewheeler.net kernel: entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
Oct 16 09:48:47 hv1.ewheeler.net kernel: RIP: 0033:0x7f41c473e987
Oct 16 09:48:47 hv1.ewheeler.net kernel: Code: 0b 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e

Code starting with the faulting instruction
===========================================
   0:	0b 00                	or     (%rax),%eax
   2:	f7 d8                	neg    %eax
   4:	64 89 02             	mov    %eax,%fs:(%rdx)
   7:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
   e:	eb b7                	jmp    0xffffffffffffffc7
  10:	0f 1f 00             	nopl   (%rax)
  13:	f3                   	repz
  14:	0f                   	.byte 0xf
  15:	1e                   	(bad)  
fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24
18 48 89 74 24
Oct 16 09:48:47 hv1.ewheeler.net kernel: RSP: 002b:00007ffe80a28648 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
Oct 16 09:48:47 hv1.ewheeler.net kernel: RAX: ffffffffffffffda RBX: 00000000000000c8 RCX: 00007f41c473e987
Oct 16 09:48:47 hv1.ewheeler.net kernel: RDX: 00000000000000c8 RSI: 000055be8e4f7320 RDI: 0000000000000004
Oct 16 09:48:47 hv1.ewheeler.net kernel: RBP: 000055be8e4f7320 R08: 0000000000000000 R09: 0000000000000000
Oct 16 09:48:47 hv1.ewheeler.net kernel: R10: 0000000000001000 R11: 0000000000000246 R12: 00000000000000c8
Oct 16 09:48:47 hv1.ewheeler.net kernel: R13: 0000000000000004 R14: 00007ffe80a28970 R15: 000055be8d383848
Oct 16 09:48:47 hv1.ewheeler.net kernel: </TASK>


--
Eric


> And this is a hacked up Oracle UEK 5.15.0-X build with a similar trace:
> 
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.342188] CPU: 29 PID: 35965 Comm: drbdsetup-84 Kdump: loaded Not tainted 5.15.0-7.86.6.1.el9uek.x86_64-TEST+ #7
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.358188] Hardware name: Supermicro Super Server/H11SSL-i, BIOS 2.4 12/27/2021
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.374188] Call Trace:
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.390189]  <TASK>
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.406190]  dump_stack_lvl+0x57/0x7e
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.422187]  look_up_lock_class+0xe7/0xfb
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.438187]  register_lock_class+0x3d/0x4db
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.454191]  __lock_acquire+0x56/0xaa3
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.469193]  lock_acquire+0xc8/0x32d
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.484192]  ? lock_all_resources+0x54/0x80 [drbd]
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.500053]  ? find_held_lock+0x32/0x8d
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.515189]  ? lock_all_resources+0x54/0x80 [drbd]
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.530198]  ? lock_all_resources+0x54/0x80 [drbd]
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.545186]  ? __lock_acquired+0x58/0x278
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.559270]  _raw_spin_lock_nested+0x2f/0x71
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.573191]  ? lock_all_resources+0x54/0x80 [drbd]
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.588187]  lock_all_resources+0x54/0x80 [drbd]
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.603187]  drbd_adm_attach+0x90c/0x1074 [drbd]
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.618191]  ? __nla_validate_parse+0x15c/0x1c8
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.632189]  genl_family_rcv_msg_doit+0xfd/0x169
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.646192]  genl_family_rcv_msg+0xbe/0x179
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.658194]  ? drbd_adm_disk_opts.cold+0x77/0x77 [drbd]
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.672195]  genl_rcv_msg+0x47/0xa6
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.685194]  ? find_held_lock+0x32/0x8d
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.698199]  ? genl_family_rcv_msg+0x180/0x179
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.711192]  netlink_rcv_skb+0x5c/0x106
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.724191]  genl_rcv+0x24/0x31
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.736197]  netlink_unicast+0x1a5/0x261
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.749188]  netlink_sendmsg+0x24f/0x4d5
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.761612]  sock_sendmsg+0x68/0x6a
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.773189]  sock_write_iter+0x9e/0x10a
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.785193]  new_sync_write+0x1da/0x1e9
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.797193]  vfs_write+0x276/0x381
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.809188]  ksys_write+0xc7/0xf4
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.820190]  do_syscall_64+0x3b/0x8d
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.831196]  entry_SYSCALL_64_after_hwframe+0x63/0x0
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.843192] RIP: 0033:0x7fdc29a1d987
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.853533] Code: 0b 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.877188] RSP: 002b:00007fff4acbe2a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.889186] RAX: ffffffffffffffda RBX: 00000000000000c8 RCX: 00007fdc29a1d987
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.900198] RDX: 00000000000000c8 RSI: 00005583cafa6320 RDI: 0000000000000004
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.911508] RBP: 00005583cafa6320 R08: 0000000000000000 R09: 0000000000000000
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.922188] R10: 0000000000001000 R11: 0000000000000246 R12: 00000000000000c8
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.934189] R13: 0000000000000004 R14: 00007fff4acbe5d0 R15: 00005583ca41d848
> Oct 16 10:56:58 hv2.ewheeler.net  [  406.945189]  </TASK>
> 
> 

