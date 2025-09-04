Return-Path: <netdev+bounces-220001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA42B4429F
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 18:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3850A1C83CD0
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 16:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C8A224AF2;
	Thu,  4 Sep 2025 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8Jbotei"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BDD27713
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 16:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003074; cv=none; b=oT9MnaZSJq6oUeLr1bQYrrsaVHobtBkVUn9lm/mJUyHH63UJK447ksyu1IGcd5sZFi7geJQcNAjYAtls+JFXbXrQGH3+Xnqf4xUzX44tJqNWGmttupBWefKykNFtQqMqjw1sJl1k/5ZOk1xHE96Q4YvEZLd8/LzTypgYxA/MGRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003074; c=relaxed/simple;
	bh=5PW3qDcyoeLmaMP99RIFWN7LFhUGMZ0e+RAkv6b9G/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b09yc3p8mVPTZeSc3UCAXU8HzHxDklC/woHhI0PQo+6J/r1nfLk1tUDpgt8pdei0AVftrnFejD6R5QU1l1tcbUG4cgPr4AvScmBUG4ZA10h+/Jo6Osw52/1lUQRi/H+Zd5iP1fQk684yJEoSwFdHo559Qr63UmvlyQWp2ToCxXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8Jbotei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5655EC4CEF0;
	Thu,  4 Sep 2025 16:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757003073;
	bh=5PW3qDcyoeLmaMP99RIFWN7LFhUGMZ0e+RAkv6b9G/Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o8JboteihL4uEUdlSBBhcZHydWssk/DynYocoQgy4bXaj5eqx4Ir6X4dx8ybVQJP+
	 9T+aZ1zn/OxYdmAuvSC2v4JLOVaKbvJGFR/LL4Jfj65nrFJ2PGn1ex51fwBWua3z9n
	 lSwQ709h++IN8mMkXG+qFAICoePSK6s9xuxRx446TEWCiuWuEKSssIOb89PsEaal/3
	 YfU1XHwhQTv0ON5gwPxZiNHGMZk99IGxdI/wfrb3KG097MSyntZ159jlgRCf5eMGKp
	 zYrtCRibqPxS7/MDoeGeqUUIbSYCyOfqzeQrE2FRlkpfp7ZbUoY9vMvBJgjGEBpQmf
	 lclLk8xcLAD0g==
Date: Thu, 4 Sep 2025 09:24:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern
 <dsahern@kernel.org>, Jamie Bainbridge <jamie.bainbridge@gmail.com>,
 Abhishek Rawal <rawal.abhishek92@gmail.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 0/3] ipv6: snmp: avoid performance issue with
 RATELIMITHOST
Message-ID: <20250904092432.113c4940@kernel.org>
In-Reply-To: <20250904132554.2891227-1-edumazet@google.com>
References: <20250904132554.2891227-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Sep 2025 13:25:50 +0000 Eric Dumazet wrote:
> Addition of ICMP6_MIB_RATELIMITHOST in commit d0941130c9351
> ("icmp: Add counters for rate limits") introduced a performance
> drop in case of DOS (like receiving UDP packets
> to closed ports).
> 
> Per netns ICMP6_MIB_RATELIMITHOST tracking uses per-cpu
> storage and is enough, we do not need per-device and slow tracking
> for this metric.

CI says:

==================================================================
[ 156.608382][ T330] BUG: KASAN: global-out-of-bounds in snmp6_seq_show_item64.constprop.0 (net/ipv6/proc.c:211) 
[ 156.608699][ T330] Read of size 8 at addr ffffffffad4d4790 by task connect-deny_ip/330
[ 156.608965][ T330]
[ 156.609064][ T330] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[ 156.609066][ T330] Call Trace:
[ 156.609069][ T330]  <TASK>
[ 156.609071][ T330] dump_stack_lvl (lib/dump_stack.c:123) 
[ 156.609077][ T330] print_address_description.constprop.0 (mm/kasan/report.c:379) 
[ 156.609084][ T330] ? snmp6_seq_show_item64.constprop.0 (net/ipv6/proc.c:211) 
[ 156.609088][ T330] print_report (mm/kasan/report.c:483) 
[ 156.609091][ T330] ? snmp6_seq_show_item64.constprop.0 (net/ipv6/proc.c:211) 
[ 156.609094][ T330] ? kasan_addr_to_slab (./include/linux/mm.h:1180 mm/kasan/../slab.h:187 mm/kasan/common.c:38) 
[ 156.609098][ T330] ? snmp6_seq_show_item64.constprop.0 (net/ipv6/proc.c:211) 
[ 156.609101][ T330] kasan_report (mm/kasan/report.c:597) 
[ 156.609105][ T330] ? snmp6_seq_show_item64.constprop.0 (net/ipv6/proc.c:211) 
[ 156.609111][ T330] snmp6_seq_show_item64.constprop.0 (net/ipv6/proc.c:211) 
[ 156.609119][ T330] ? sockstat6_seq_show (net/ipv6/proc.c:202) 
[ 156.609137][ T330] ? rcu_is_watching (./include/linux/context_tracking.h:128 kernel/rcu/tree.c:751) 
[ 156.609142][ T330] ? trace_kmalloc (./include/trace/events/kmem.h:54 (discriminator 21)) 
[ 156.609146][ T330] ? __kvmalloc_node_noprof (mm/slub.c:5055) 
[ 156.609152][ T330] snmp6_seq_show (net/ipv6/proc.c:224) 
[ 156.609155][ T330] seq_read_iter (fs/seq_file.c:231) 
[ 156.609165][ T330] seq_read (fs/seq_file.c:163) 
[ 156.609169][ T330] ? seq_read_iter (fs/seq_file.c:152) 
[ 156.609173][ T330] ? __lock_acquire (kernel/locking/lockdep.c:5237) 
[ 156.609180][ T330] ? __mutex_trylock_common (./arch/x86/include/asm/atomic64_64.h:101 ./include/linux/atomic/atomic-arch-fallback.h:4296 ./include/linux/atomic/atomic-long.h:1482 ./include/linux/atomic/atomic-instrumented.h:4458 kernel/locking/mutex.c:113) 
[ 156.609184][ T330] ? rcu_is_watching (./include/linux/context_tracking.h:128 kernel/rcu/tree.c:751) 
[ 156.609189][ T330] proc_reg_read (fs/proc/inode.c:308 fs/proc/inode.c:320) 
[ 156.609196][ T330] vfs_read (fs/read_write.c:570) 
[ 156.609201][ T330] ? fdget_pos (fs/file.c:1235) 
[ 156.609206][ T330] ? ww_mutex_lock (kernel/locking/mutex.c:759) 
[ 156.609212][ T330] ? kernel_read (fs/read_write.c:553) 
[ 156.609215][ T330] ? __lock_release (kernel/locking/lockdep.c:5536) 
[ 156.609220][ T330] ? __fget_files (./include/linux/rcupdate.h:341 ./include/linux/rcupdate.h:871 fs/file.c:1072) 
[ 156.609223][ T330] ? __fget_files (fs/file.c:1075) 
[ 156.609230][ T330] ksys_read (fs/read_write.c:715) 
[ 156.609234][ T330] ? vfs_write (fs/read_write.c:705) 
[ 156.609240][ T330] do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94) 
[ 156.609244][ T330] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[ 156.609248][ T330] RIP: 0033:0x7f5190d4a2cc
[ 156.609252][ T330] Code: ec 28 48 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 29 8b f8 ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 34 44 89 c7 48 89 44 24 08 e8 7f 8b f8 ff 48
All code
========
   0:	ec                   	in     (%dx),%al
   1:	28 48 89             	sub    %cl,-0x77(%rax)
   4:	54                   	push   %rsp
   5:	24 18                	and    $0x18,%al
   7:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)
   c:	89 7c 24 08          	mov    %edi,0x8(%rsp)
  10:	e8 29 8b f8 ff       	call   0xfffffffffff88b3e
  15:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
  1a:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
  1f:	41 89 c0             	mov    %eax,%r8d
  22:	8b 7c 24 08          	mov    0x8(%rsp),%edi
  26:	31 c0                	xor    %eax,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 34                	ja     0x66
  32:	44 89 c7             	mov    %r8d,%edi
  35:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  3a:	e8 7f 8b f8 ff       	call   0xfffffffffff88bbe
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 34                	ja     0x3c
   8:	44 89 c7             	mov    %r8d,%edi
   b:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  10:	e8 7f 8b f8 ff       	call   0xfffffffffff88b94
  15:	48                   	rex.W
[  156.609255][  T330] RSP: 002b:00007f518bffe090 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[  156.609259][  T330] RAX: ffffffffffffffda RBX: 00007f5184000f30 RCX: 00007f5190d4a2cc
[  156.609261][  T330] RDX: 0000000000000400 RSI: 00007f5184001190 RDI: 000000000000000b
[  156.609263][  T330] RBP: 00007f5190e425c0 R08: 0000000000000000 R09: 0000000000000000
[  156.609265][  T330] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000


