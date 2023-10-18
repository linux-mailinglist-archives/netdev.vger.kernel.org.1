Return-Path: <netdev+bounces-42070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DD37CD122
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 02:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 848FD1C208D0
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 00:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1510063B;
	Wed, 18 Oct 2023 00:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lm3w4oxI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7B2631
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 00:09:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E4EC433C7;
	Wed, 18 Oct 2023 00:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697587741;
	bh=nGekJ0v9QqlsVIf8Z6gELw/jojrBub3oAAHx8xtFVxQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lm3w4oxInAOM2h8CTlPha0X76RAxnv+Gg/YtnDfD/gr+bBzlXmgZJ5g6vF+iLCvJN
	 +SSrfu8JDNLtekN3qXU7pG5EDRjHYLOi5yFDOkqrP+pIsjFEVGpVekolfRWKkDqQMk
	 RjzfQijFSvxkIXWxDcReKUTYt86dgQhYqSnKptNq336xYJS7QYxkFQz1qeVK2dt6jD
	 9oft77TON4I66J5eoqy8PB1meXtChg3zUnbA2Cb5BkLGrQJNgLoJqrpK6qCLm87btc
	 siPHmSk9lonpH5/CtfyvqZLTWKaoQ5AKhDrRAIktEPl5j/99vuxstFbLqkv+7XiiAY
	 vuJeRP6VnIQ1w==
Date: Tue, 17 Oct 2023 17:09:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Wheeler <netdev@lists.ewheeler.net>
Cc: netdev@vger.kernel.org
Subject: Re: BUG: looking up invalid subclass: 8
Message-ID: <20231017170900.62f951cd@kernel.org>
In-Reply-To: <cea84b66-2ad5-76af-3feb-418b78cdd87@ewheeler.net>
References: <cea84b66-2ad5-76af-3feb-418b78cdd87@ewheeler.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Oct 2023 16:41:41 -0700 (PDT) Eric Wheeler wrote:
> I found a similar backtrace that was fixed in
> 3510c7aa069aa83a2de6dab2b41401a198317bdc .  It was for ALSA, but had the
> same BUG of "looking up invalid subclass: 8" and the fix was trivial,
> noting that MAX_HOPS shouldn't be bigger than MAX_LOCKDEP_SUBCLASSES.
> 
> Is there a simple fix for this in netlink, too?
> 
> ]# ./scripts/decode_stacktrace.sh vmlinux `pwd` < stackdump.txt 
> [  113.347055] BUG: looking up invalid subclass: 8
> [  113.357387] turning off the locking correctness validator.
> [  113.364842] Hardware name: Supermicro Super Server/H11SSL-i, BIOS 2.4 12/27/2021
> [  113.373614] Call Trace:
> [  113.381874]  <TASK>
> [  113.382556] dump_stack_lvl (lib/dump_stack.c:108) 
> [  113.388816] look_up_lock_class (kernel/locking/lockdep.c:941) 
> [  113.399562] register_lock_class (kernel/locking/lockdep.c:1284 (discriminator 13)) 
> [  113.400238] ? srso_return_thunk (arch/x86/lib/retpoline.S:308) 
> [  113.403627] __lock_acquire (kernel/locking/lockdep.c:5014) 
> [  113.414652] lock_acquire.part.0 (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5755) 
> [  113.428619] ? srso_return_thunk (arch/x86/lib/retpoline.S:308) 
> [  113.435463] ? lock_acquire (./include/trace/events/lock.h:24 kernel/locking/lockdep.c:5724) 
> [  113.440620] _raw_spin_lock_nested (kernel/locking/spinlock.c:379) 
> [  113.462749] ? __nla_validate_parse (lib/nlattr.c:606) 
> [  113.471052] genl_family_rcv_msg_doit.isra.0 (net/netlink/genetlink.c:970) 
> [  113.471651] genl_family_rcv_msg (net/netlink/genetlink.c:1050) 

Thanks for sharing the decoded stack trace, can you share the full
non-decoded one? Is there the name of the command that's calling
this somewhere?

There's no lock where this is pointing at, just an indirect call.
So I wonder where the lock is. Perhaps retpoline is confusing 
the stack trace :(

