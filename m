Return-Path: <netdev+bounces-205526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FAEAFF135
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 20:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76F897A3F73
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 18:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EA523BCF2;
	Wed,  9 Jul 2025 18:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7WD/KIU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C08D239E9F
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 18:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752087293; cv=none; b=B98KHqkZJtOx4ZNljUwCs1r1FLBBpBC0kK8Q7ij6/IQZPP0kw+QF18aVDF76q73TnkmUsVfTUKdBT07IiuF5SfEVZqQ2tqPjpOh+pNuKlmHm3H1jX4lcEhz9QjlyawP81qJRKzImPzNt0WXoFLeIZOJzpjQzxl0VI68r/RTFNUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752087293; c=relaxed/simple;
	bh=ViYMYdEcc24X4JlWYdOgEi8kCXuSOAG7QlPZfxlOKJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtMBN/nasTHZlHarv4lM12nuBj2nRxxLs06h+FiDbZQ0/rDefm68phIyJ2xOCIRDoytobyJI+NLkfsaB2DoSgbf6r8ze+7cQTy/RnjTPA+iqEwqfovpFpx/QtFX3EElzaxMxmb44ReZhwROIn3z9Zcp5fY0O0GgP1fR5n7Ghkz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7WD/KIU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CDBC4CEEF;
	Wed,  9 Jul 2025 18:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752087293;
	bh=ViYMYdEcc24X4JlWYdOgEi8kCXuSOAG7QlPZfxlOKJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s7WD/KIUaJP6d4MGCs7XYzyQC3/mUOz8T7PLMP/M/vill0HPSYa80d61R39TTIRFh
	 DykUWOvcUH06bMtaV0MrY1MTkd6tbTJrTJVInxmJr1j1CZ1IlC3FMDe/M8RUcxEWCS
	 zRD/a203gdEkQ7NxHr7762a7PDh9Ud6RwiVgmKygBLOfHDEbU/r4xHVZTT28d6K2C9
	 Hc/JA3QOXKO85u5ifOdwkgxzOdgyzvmUyTSCp6qhkmKF+CIl9Wu2aPhb0csNN0kjr7
	 8eMtpWYxTOaTG+frNemUQYcOI/OdmLb+cz8L3gaiqgy396wOqYHjo1dWLfYrZQxPAD
	 fFSulf+16PI4g==
Date: Wed, 9 Jul 2025 19:54:49 +0100
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	syzbot+0c77cccd6b7cd917b35a@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 net 3/3] atm: clip: Fix infinite recursive call of
 clip_push().
Message-ID: <20250709185449.GM721198@horms.kernel.org>
References: <20250704062416.1613927-1-kuniyu@google.com>
 <20250704062416.1613927-4-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704062416.1613927-4-kuniyu@google.com>

On Fri, Jul 04, 2025 at 06:23:53AM +0000, Kuniyuki Iwashima wrote:
> syzbot reported the splat below. [0]
> 
> This happens if we call ioctl(ATMARP_MKIP) more than once.
> 
> During the first call, clip_mkip() sets clip_push() to vcc->push(),
> and the second call copies it to clip_vcc->old_push().
> 
> Later, when the socket is close()d, vcc_destroy_socket() passes
> NULL skb to clip_push(), which calls clip_vcc->old_push(),
> triggering the infinite recursion.
> 
> Let's prevent the second ioctl(ATMARP_MKIP) by checking
> vcc->user_back, which is allocated by the first call as clip_vcc.
> 
> Note also that we use lock_sock() to prevent racy calls.
> 
> [0]:
> BUG: TASK stack guard page was hit at ffffc9000d66fff8 (stack is ffffc9000d670000..ffffc9000d678000)
> Oops: stack guard page: 0000 [#1] SMP KASAN NOPTI
> CPU: 0 UID: 0 PID: 5322 Comm: syz.0.0 Not tainted 6.16.0-rc4-syzkaller #0 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:clip_push+0x5/0x720 net/atm/clip.c:191
> Code: e0 8f aa 8c e8 1c ad 5b fa eb ae 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 <41> 57 41 56 41 55 41 54 53 48 83 ec 20 48 89 f3 49 89 fd 48 bd 00
> RSP: 0018:ffffc9000d670000 EFLAGS: 00010246
> RAX: 1ffff1100235a4a5 RBX: ffff888011ad2508 RCX: ffff8880003c0000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888037f01000
> RBP: dffffc0000000000 R08: ffffffff8fa104f7 R09: 1ffffffff1f4209e
> R10: dffffc0000000000 R11: ffffffff8a99b300 R12: ffffffff8a99b300
> R13: ffff888037f01000 R14: ffff888011ad2500 R15: ffff888037f01578
> FS:  000055557ab6d500(0000) GS:ffff88808d250000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffc9000d66fff8 CR3: 0000000043172000 CR4: 0000000000352ef0
> Call Trace:
>  <TASK>
>  clip_push+0x6dc/0x720 net/atm/clip.c:200
>  clip_push+0x6dc/0x720 net/atm/clip.c:200
>  clip_push+0x6dc/0x720 net/atm/clip.c:200
> ...
>  clip_push+0x6dc/0x720 net/atm/clip.c:200
>  clip_push+0x6dc/0x720 net/atm/clip.c:200
>  clip_push+0x6dc/0x720 net/atm/clip.c:200
>  vcc_destroy_socket net/atm/common.c:183 [inline]
>  vcc_release+0x157/0x460 net/atm/common.c:205
>  __sock_release net/socket.c:647 [inline]
>  sock_close+0xc0/0x240 net/socket.c:1391
>  __fput+0x449/0xa70 fs/file_table.c:465
>  task_work_run+0x1d1/0x260 kernel/task_work.c:227
>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>  exit_to_user_mode_loop+0xec/0x110 kernel/entry/common.c:114
>  exit_to_user_mode_prepare include/linux/entry-common.h:330 [inline]
>  syscall_exit_to_user_mode_work include/linux/entry-common.h:414 [inline]
>  syscall_exit_to_user_mode include/linux/entry-common.h:449 [inline]
>  do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7ff31c98e929
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fffb5aa1f78 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
> RAX: 0000000000000000 RBX: 0000000000012747 RCX: 00007ff31c98e929
> RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
> RBP: 00007ff31cbb7ba0 R08: 0000000000000001 R09: 0000000db5aa226f
> R10: 00007ff31c7ff030 R11: 0000000000000246 R12: 00007ff31cbb608c
> R13: 00007ff31cbb6080 R14: ffffffffffffffff R15: 00007fffb5aa2090
>  </TASK>
> Modules linked in:
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+0c77cccd6b7cd917b35a@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=2371d94d248d126c1eb1
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


