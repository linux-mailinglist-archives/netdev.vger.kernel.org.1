Return-Path: <netdev+bounces-42067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5C77CD0F8
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 01:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75864B21016
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 23:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E75F2F53E;
	Tue, 17 Oct 2023 23:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CC82E3ED
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 23:41:50 +0000 (UTC)
Received: from mx.ewheeler.net (mx.ewheeler.net [173.205.220.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE13610B
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 16:41:47 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 5DC7385
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 16:41:46 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ouw2Sn3sE6pS for <netdev@vger.kernel.org>;
	Tue, 17 Oct 2023 16:41:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id E574C45
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 16:41:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net E574C45
Date: Tue, 17 Oct 2023 16:41:41 -0700 (PDT)
From: Eric Wheeler <netdev@lists.ewheeler.net>
To: netdev@vger.kernel.org
Subject: BUG: looking up invalid subclass: 8
Message-ID: <cea84b66-2ad5-76af-3feb-418b78cdd87@ewheeler.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello all:

We are running Linux 6.5.7 and are getting the following trace in dmesg.

I found a similar backtrace that was fixed in
3510c7aa069aa83a2de6dab2b41401a198317bdc .  It was for ALSA, but had the
same BUG of "looking up invalid subclass: 8" and the fix was trivial,
noting that MAX_HOPS shouldn't be bigger than MAX_LOCKDEP_SUBCLASSES.

Is there a simple fix for this in netlink, too?

]# ./scripts/decode_stacktrace.sh vmlinux `pwd` < stackdump.txt 
[  113.347055] BUG: looking up invalid subclass: 8
[  113.357387] turning off the locking correctness validator.
[  113.364842] Hardware name: Supermicro Super Server/H11SSL-i, BIOS 2.4 12/27/2021
[  113.373614] Call Trace:
[  113.381874]  <TASK>
[  113.382556] dump_stack_lvl (lib/dump_stack.c:108) 
[  113.388816] look_up_lock_class (kernel/locking/lockdep.c:941) 
[  113.399562] register_lock_class (kernel/locking/lockdep.c:1284 (discriminator 13)) 
[  113.400238] ? srso_return_thunk (arch/x86/lib/retpoline.S:308) 
[  113.403627] __lock_acquire (kernel/locking/lockdep.c:5014) 
[  113.414652] lock_acquire.part.0 (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5755) 
[  113.428619] ? srso_return_thunk (arch/x86/lib/retpoline.S:308) 
[  113.435463] ? lock_acquire (./include/trace/events/lock.h:24 kernel/locking/lockdep.c:5724) 
[  113.440620] _raw_spin_lock_nested (kernel/locking/spinlock.c:379) 
[  113.462749] ? __nla_validate_parse (lib/nlattr.c:606) 
[  113.471052] genl_family_rcv_msg_doit.isra.0 (net/netlink/genetlink.c:970) 
[  113.471651] genl_family_rcv_msg (net/netlink/genetlink.c:1050) 
[  113.483623] genl_rcv_msg (net/netlink/genetlink.c:1069) 
[  113.489055] ? __pfx_genl_rcv_msg (net/netlink/genetlink.c:1056) 
[  113.489623] netlink_rcv_skb (net/netlink/af_netlink.c:2519) 
[  113.492711] genl_rcv (net/netlink/genetlink.c:1079) 
[  113.502610] netlink_unicast (net/netlink/af_netlink.c:1338 net/netlink/af_netlink.c:1363) 
[  113.506927] netlink_sendmsg (net/netlink/af_netlink.c:1885) 
[  113.507486] sock_write_iter (net/socket.c:725 net/socket.c:740 net/socket.c:1147) 
[  113.510657] vfs_write (./include/linux/fs.h:1877 fs/read_write.c:491 fs/read_write.c:584) 
[  113.519624] ksys_write (fs/read_write.c:637) 
[  113.524713] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[  113.525233] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  113.526621] RIP: 0033:0x7f41c473e987
[ 113.535618] Code: 0b 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85

Code starting with the faulting instruction
===========================================
   0:	0b 00                	or     (%rax),%eax
   2:	f7 d8                	neg    %eax
   4:	64 89 02             	mov    %eax,%fs:(%rdx)
   7:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
   e:	eb b7                	jmp    0xffffffffffffffc7
  10:	0f 1f 00             	nopl   (%rax)
  13:	f3 0f 1e fa          	endbr64 
  17:	64 8b 04 25 18 00 00 	mov    %fs:0x18,%eax
  1e:	00 
  1f:	85                   	.byte 0x85
c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[  113.543013] RSP: 002b:00007ffe80a28648 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  113.543627] RAX: ffffffffffffffda RBX: 00000000000000c8 RCX: 00007f41c473e987
[  113.552607] RDX: 00000000000000c8 RSI: 000055be8e4f7320 RDI: 0000000000000004
[  113.560243] RBP: 000055be8e4f7320 R08: 0000000000000000 R09: 0000000000000000
[  113.560803] R10: 0000000000001000 R11: 0000000000000246 R12: 00000000000000c8
[  113.561353] R13: 0000000000000004 R14: 00007ffe80a28970 R15: 000055be8d383848
[  113.569626]  </TASK>






--
Eric Wheeler

