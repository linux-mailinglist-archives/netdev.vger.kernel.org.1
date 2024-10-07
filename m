Return-Path: <netdev+bounces-132850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31030993825
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 22:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC7F21F2247D
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 20:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4CD1DE4F0;
	Mon,  7 Oct 2024 20:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XszoP9Nx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7423E1DE4E9;
	Mon,  7 Oct 2024 20:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728332567; cv=none; b=Y/+Tbo7YpC2s+mhfDyx6Ir41oRECpffXjGC7OwfzfTlUUUl9aASZlW609cQxniwDkRaUWOIfAZwc26MYTdjWtd4GiTjaq0vqHMp4yz4ONOTRGr14j7swIeTv1+kY6T1IMyaHlVwnQPO9WLt+iNIfOk9JKalbVlZwHVIDyubhSBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728332567; c=relaxed/simple;
	bh=/xuJ2PAry2LqpmBgD3b47oNY0CjTeicFO2L4LKiuWug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlD5HpIWp5nNMzBGmFcP94O+q+P14DJp+45Au5nGV73aC4TNpaKCpD2b7iR6aMFDl5Z+g89R04psxOFAwp1bWaNAGYvTue1cOdeb5dNO7vRhqFJYK7XN0+ebtVirZLz/AuVYMJKz4vuAVLm3Dh0oafxD8bEcbtbqC4fkHHFW2Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XszoP9Nx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70202C4CEC6;
	Mon,  7 Oct 2024 20:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728332567;
	bh=/xuJ2PAry2LqpmBgD3b47oNY0CjTeicFO2L4LKiuWug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XszoP9NxjdT9p9NyyFpQ/Rp02MBeEqeMp/FTEfDogXJYJ6vVfKKeaM/voZHeyzCPC
	 ahkdqgZD8k5QeCM9KKARaCd9AB/BdEI50+lNyySFeG2cWhWsEoj+4hOBS0/3A4AP+f
	 jHui8bvG+nkEUPzCQZWBF+aVKp/B76eN918vVDb5z5m7lIU9yo/qBlskGdxETuD/Sh
	 w1UOa2eL0UknUbdfdq8aZOuf+K4p1JjcJu0cL75HZ32XMgEYH8cexfVhxm/ybcKw+A
	 WO67MIKjyhVm72eKGP+F6oUTFAqIR7TkfdYXtpGVvA9Hcw+ujPLngP+/OmemaBiRGp
	 +CvOL4iP8CdJw==
Date: Mon, 7 Oct 2024 22:22:40 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Xingyu Li <xli399@ucr.edu>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, dsahern@kernel.org, linux@weissschuh.net,
	judyhsiao@chromium.org, James.Z.Li@dell.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yu Hao <yhao016@ucr.edu>
Subject: Re: BUG: corrupted list in neigh_destroy
Message-ID: <20241007202240.bsqczev75yzdgn3g@joelS2.panther.com>
References: <CALAgD-7-Z+xbXwtvA9n9X2YE-B9f2bHFtyQxkX1uL+Yqd5zRuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAgD-7-Z+xbXwtvA9n9X2YE-B9f2bHFtyQxkX1uL+Yqd5zRuQ@mail.gmail.com>

On Wed, Aug 28, 2024 at 04:34:39PM -0700, Xingyu Li wrote:
> Hi,
> 
> We found a bug in Linux 6.10 using syzkaller. It is possibly a
> corrupted list bug.
> The bug report is as follows, but unfortunately there is no generated
> syzkaller reproducer.

Please resend once you find a reproducer.

> 
> Bug report:
> 
> list_del corruption, ffff88802cfc0d80->next is NULL
> ------------[ cut here ]------------
> kernel BUG at lib/list_debug.c:53!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 0 PID: 4497 Comm: kworker/0:3 Not tainted 6.10.0 #13
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Workqueue: events_power_efficient neigh_periodic_work
> RIP: 0010:__list_del_entry_valid_or_report+0xc3/0x120 lib/list_debug.c:52
> Code: 08 48 89 df e8 4e 01 96 fd 48 8b 13 4c 39 fa 75 62 b0 01 5b 41
> 5c 41 5e 41 5f c3 48 c7 c7 60 5a a9 8b 4c 89 fe e8 dd ff 96 06 <0f> 0b
> 48 c7 c7 c0 5a a9 8b 4c 89 fe e8 cc ff 96 06 0f 0b 48 c7 c7
> RSP: 0018:ffffc90002ce7978 EFLAGS: 00010046
> RAX: 0000000000000033 RBX: 0000000000000000 RCX: 31a71fdaa0dd1600
> RDX: 0000000000000000 RSI: 0000000080000202 RDI: 0000000000000000
> RBP: ffffc90002ce7ac8 R08: ffffffff8172e30c R09: 1ffff9200059ced0
> R10: dffffc0000000000 R11: fffff5200059ced1 R12: dffffc0000000000
> R13: ffff88802cfc0d80 R14: 0000000000000000 R15: ffff88802cfc0d80
> FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055dc1a4cee78 CR3: 000000000d932000 CR4: 0000000000350ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __list_del_entry_valid include/linux/list.h:124 [inline]
>  __list_del_entry include/linux/list.h:215 [inline]
>  list_move_tail include/linux/list.h:310 [inline]
>  ref_tracker_free+0x191/0x7b0 lib/ref_tracker.c:262
>  netdev_tracker_free include/linux/netdevice.h:4058 [inline]
>  netdev_put include/linux/netdevice.h:4075 [inline]
>  neigh_destroy+0x317/0x570 net/core/neighbour.c:914
>  neigh_periodic_work+0x3c6/0xd40 net/core/neighbour.c:1007
>  process_one_work kernel/workqueue.c:3248 [inline]
>  process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
>  worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
>  kthread+0x2eb/0x380 kernel/kthread.c:389
>  ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:__list_del_entry_valid_or_report+0xc3/0x120 lib/list_debug.c:52
> Code: 08 48 89 df e8 4e 01 96 fd 48 8b 13 4c 39 fa 75 62 b0 01 5b 41
> 5c 41 5e 41 5f c3 48 c7 c7 60 5a a9 8b 4c 89 fe e8 dd ff 96 06 <0f> 0b
> 48 c7 c7 c0 5a a9 8b 4c 89 fe e8 cc ff 96 06 0f 0b 48 c7 c7
> RSP: 0018:ffffc90002ce7978 EFLAGS: 00010046
> RAX: 0000000000000033 RBX: 0000000000000000 RCX: 31a71fdaa0dd1600
> RDX: 0000000000000000 RSI: 0000000080000202 RDI: 0000000000000000
> RBP: ffffc90002ce7ac8 R08: ffffffff8172e30c R09: 1ffff9200059ced0
> R10: dffffc0000000000 R11: fffff5200059ced1 R12: dffffc0000000000
> R13: ffff88802cfc0d80 R14: 0000000000000000 R15: ffff88802cfc0d80
> FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055dc1a4cee78 CR3: 000000000d932000 CR4: 0000000000350ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> 
> -- 
> Yours sincerely,
> Xingyu

-- 

Joel Granados

