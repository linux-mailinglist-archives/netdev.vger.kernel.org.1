Return-Path: <netdev+bounces-99326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF008D4829
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 11:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71C971F21A0C
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 09:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C81183979;
	Thu, 30 May 2024 09:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wZ5ROcnU"
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7C9183973
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 09:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717060385; cv=none; b=bMhvLeht+eBRE/leT0u+ZVHuumwsv/mT/IKyPIzGnYW5GQCnH5fl+HHO6lueSHiyJk+be1Cgytj1dmXr06gV4oyJNk1WC0j93uVDRwC3OhjLyKhWZhoimouBV1LSFaNXsUkRcZovva2+OBza5BNys2wXi4bh98tGhBJtzrhmpSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717060385; c=relaxed/simple;
	bh=xe5FIuhMy93kJX1XnWgqwVB3T4SMSXoOA+p7FeEX7x4=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=DziawNjKTOk+kgfM4g39Tj23mUXXCUKxBnBen873JWej4U/3C/VWzJ3K93l9S9rwS7O4LxruxiNGdqJU6h2wnUQ5NuhWaO0M37QdWRYW1+H1rudtMgOWbvT+47hWG4YNo91GdlQDshrT0kUHzA97BJsrL6y43o0vcSNtxYI0qwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wZ5ROcnU; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717060380; h=Message-ID:Subject:Date:From:To;
	bh=89kKgGLmjLMer9ydMYGhYwVeiGXJLhKdY8ZU1/xZSIQ=;
	b=wZ5ROcnUoceDu1eEZPSNX10m7/abe6SuozfzNRWg64cW6GEV+92HDreRqHVqvO+FrdaOjMOTZRcSjz95KTgADIsiNDRfRR91wtp5UjthCE+rBxt40ADLw6ieAxgs7WSRWOWn3657BcHSkdqHEYX4GpMkwQaZNNi70lvoo1qO5Xw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W7WSSnR_1717060379;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W7WSSnR_1717060379)
          by smtp.aliyun-inc.com;
          Thu, 30 May 2024 17:13:00 +0800
Message-ID: <1717058986.0899282-2-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net v3 2/2] virtio_net: fix a spurious deadlock issue
Date: Thu, 30 May 2024 16:49:46 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>,
 Daniel Jurgens <danielj@nvidia.com>,
 netdev@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20240528134116.117426-1-hengqi@linux.alibaba.com>
 <20240528134116.117426-3-hengqi@linux.alibaba.com>
 <e6411cb5ec7e5ecc211faded7af4843647c6143a.camel@redhat.com>
In-Reply-To: <e6411cb5ec7e5ecc211faded7af4843647c6143a.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 30 May 2024 10:34:07 +0200, Paolo Abeni <pabeni@redhat.com> wrote:
> On Tue, 2024-05-28 at 21:41 +0800, Heng Qi wrote:
> > When the following snippet is run, lockdep will report a deadlock[1].
> > 
> >   /* Acquire all queues dim_locks */
> >   for (i = 0; i < vi->max_queue_pairs; i++)
> >           mutex_lock(&vi->rq[i].dim_lock);
> > 
> > There's no deadlock here because the vq locks are always taken
> > in the same order, but lockdep can not figure it out. So refactoring
> > the code to alleviate the problem.
> > 
> > [1]
> > ========================================================
> > WARNING: possible recursive locking detected
> > 6.9.0-rc7+ #319 Not tainted
> > --------------------------------------------
> > ethtool/962 is trying to acquire lock:
> > 
> > but task is already holding lock:
> > 
> > other info that might help us debug this:
> > Possible unsafe locking scenario:
> > 
> >       CPU0
> >       ----
> >  lock(&vi->rq[i].dim_lock);
> >  lock(&vi->rq[i].dim_lock);
> > 
> > *** DEADLOCK ***
> > 
> >  May be due to missing lock nesting notation
> > 
> > 3 locks held by ethtool/962:
> >  #0: ffffffff82dbaab0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40
> >  #1: ffffffff82dad0a8 (rtnl_mutex){+.+.}-{3:3}, at:
> > 				ethnl_default_set_doit+0xbe/0x1e0
> > 
> > stack backtrace:
> > CPU: 6 PID: 962 Comm: ethtool Not tainted 6.9.0-rc7+ #319
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > 	   rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0x79/0xb0
> >  check_deadlock+0x130/0x220
> >  __lock_acquire+0x861/0x990
> >  lock_acquire.part.0+0x72/0x1d0
> >  ? lock_acquire+0xf8/0x130
> >  __mutex_lock+0x71/0xd50
> >  virtnet_set_coalesce+0x151/0x190
> >  __ethnl_set_coalesce.isra.0+0x3f8/0x4d0
> >  ethnl_set_coalesce+0x34/0x90
> >  ethnl_default_set_doit+0xdd/0x1e0
> >  genl_family_rcv_msg_doit+0xdc/0x130
> >  genl_family_rcv_msg+0x154/0x230
> >  ? __pfx_ethnl_default_set_doit+0x10/0x10
> >  genl_rcv_msg+0x4b/0xa0
> >  ? __pfx_genl_rcv_msg+0x10/0x10
> >  netlink_rcv_skb+0x5a/0x110
> >  genl_rcv+0x28/0x40
> >  netlink_unicast+0x1af/0x280
> >  netlink_sendmsg+0x20e/0x460
> >  __sys_sendto+0x1fe/0x210
> >  ? find_held_lock+0x2b/0x80
> >  ? do_user_addr_fault+0x3a2/0x8a0
> >  ? __lock_release+0x5e/0x160
> >  ? do_user_addr_fault+0x3a2/0x8a0
> >  ? lock_release+0x72/0x140
> >  ? do_user_addr_fault+0x3a7/0x8a0
> >  __x64_sys_sendto+0x29/0x30
> >  do_syscall_64+0x78/0x180
> >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > 
> > Fixes: 4d4ac2ececd3 ("virtio_net: Add a lock for per queue RX coalesce")
> > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> 
> This would have deserved a changelog after the commit message.

I declared the changelog in the cover-letter, but I can initiate a new
RESEND version with a changelog in this patch if you want :)

> 
> The patch LGTM (for obvious reasons ;), but it deserves an explicit ack
> from Jason and/or Michael

Thanks.

> 
> Cheers,
> 
> Paolo
> 

