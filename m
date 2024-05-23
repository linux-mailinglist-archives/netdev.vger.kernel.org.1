Return-Path: <netdev+bounces-97731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EF58CCEC6
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 11:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2F272821F4
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 09:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F3313D240;
	Thu, 23 May 2024 09:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="28JvoKxa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2476A13CF93
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 09:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716455357; cv=none; b=HU/M10cZWg7y/xy64uFMQM+G3P231PGL5ryomw0NzMiPnfpRepRL+WE2h2Op9XPCmHK2B4ilPsN3JxXTfhpNGAqGrKSZQdyxMT0/4IKMd1it+h0oevd86lTxARpBUS0dz0YD7KUal/S0yNs8x6kb8vRuaFXex/7NPMP5jrHspJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716455357; c=relaxed/simple;
	bh=2JYubz4Ps7KPt7XXfcnmfocab4Yao251kcNtVlyrwQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t96cwkgTJ7HQNX/HyBUACWsHvgWCSUNwIRv2MfvQKQZehkvwbefKGBJJM8STouMfLgga+kz0NBA3QwBqFg9VAP0HpU4wC0Y9w5Rg9Yxbbmv1IW2NXludrfVELF8OoStcxWueiUaIBjxM74Wfc+ejF613OWaUzVoXUuR4WLaK8MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=28JvoKxa; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a5a5cce2ce6so988085766b.3
        for <netdev@vger.kernel.org>; Thu, 23 May 2024 02:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1716455353; x=1717060153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b5SD+2Q/n2VCUhgMsXmzgdogRkao4DuVxoUJaRKE3zs=;
        b=28JvoKxa7Z2+KJslT11ZqKmXKZ4gRhyo2zbV7CQLvaITVKEzsH+FYQ8u6aePylETVj
         0JQlfazPyNIHgM1zcA5i5cHqy63wLo1MO13wOsaUG4ogPE2kABn5st1R7f9rjqOgulb9
         94bIaqqeShdDckGjC6gcLk+s0pMp016YVRIZH8U3GKoWkYDSzEjvKHzistX69QXls+QT
         tZet7ORg6VpUPks7ErFQ1yXvr8zYLZDELaZIknRu21ICesgbe4sp7W3Dbjt5ZChvdjTn
         hFnQXTtYYfOQEP4dQqluQ3kvsuuvqvwFma3n36wcRZotLw5eFdo+taVR/ow/XVOvfOwK
         aUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716455353; x=1717060153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5SD+2Q/n2VCUhgMsXmzgdogRkao4DuVxoUJaRKE3zs=;
        b=DixfwS1q87mvT+J+PkycrlzbSxk7LgPch9W52u/QtqpxqcvsstsVjH+BREgtwrfipP
         elZaMwesdB2kzq3uF2E5nMJn/YiZq0oNKxrzxwPPOybQRa8/TbvfPlbre4XiErMoFPz4
         N7wTzLU0/lnZJqIHY7hibTjSCW62hruzaIejUNS4u6rKkNCykgKOkS9vFBRGFuuZkvtt
         rax5TdsjQ1z+tZ7nsJowqHdlDq9e0oKf0r5RWakS9zzShvGrPHCYHbY7xilmPfYkCsQG
         dFINSgAWuvewLFpxcN/tRrUMs5E9I1GdGZo+pqt3/6qbMrpE95IP0LyW2EEIKrJR6W32
         SUEg==
X-Gm-Message-State: AOJu0YxgMF6Nyt7dCdI4CZGK9qzuz8+CBV+9TV9j7db5aOu52Y5XXAEq
	HSt4M918rifu9EVZ+vyBHw20rSZmfFaYgFNn1al8CBmN786OrM62+Q7dz55uEog=
X-Google-Smtp-Source: AGHT+IGIKGAZV9XaKjWzU+vREJX1dK+rJPHwqt9SCZ2GLUEZ7Q56Oak3zmq8tVmP7jrz5tuX6zi6zA==
X-Received: by 2002:a17:906:ae41:b0:a59:f3f9:d24c with SMTP id a640c23a62f3a-a6228171dafmr272969466b.76.1716455353073;
        Thu, 23 May 2024 02:09:13 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a691870absm1444913866b.124.2024.05.23.02.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 02:09:12 -0700 (PDT)
Date: Thu, 23 May 2024 11:09:10 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v2 2/2] Revert "virtio_net: Add a lock for per queue
 RX coalesce"
Message-ID: <Zk8Hts3HrzFMV0p9@nanopsycho.orion>
References: <20240523074651.3717-1-hengqi@linux.alibaba.com>
 <20240523074651.3717-3-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523074651.3717-3-hengqi@linux.alibaba.com>

Thu, May 23, 2024 at 09:46:51AM CEST, hengqi@linux.alibaba.com wrote:
>This reverts commit 4d4ac2ececd3c42a08dd32a6e3a4aaf25f7efe44.
>
>When the following snippet is run, lockdep will report a deadlock[1].
>
>  /* Acquire all queues dim_locks */
>  for (i = 0; i < vi->max_queue_pairs; i++)
>          mutex_lock(&vi->rq[i].dim_lock);
>
>There's no deadlock here because the vq locks are always taken
>in the same order, but lockdep can not figure it out, and we
>can not make each lock a separate class because there can be more
>than MAX_LOCKDEP_SUBCLASSES of vqs.
>
>However, dropping the lock is harmless:
>  1. If dim is enabled, modifications made by dim worker to coalescing
>     params may cause the user's query results to be dirty data.
>  2. In scenarios (a) and (b), a spurious dim worker is scheduled,
>     but this can be handled correctly:
>     (a)
>       1. dim is on
>       2. net_dim call schedules a worker
>       3. dim is turning off
>       4. The worker checks that dim is off and then exits after
>          restoring dim's state.
>       5. The worker will not be scheduled until the next time dim is on.
>
>     (b)
>       1. dim is on
>       2. net_dim call schedules a worker
>       3. The worker checks that dim is on and keeps going
>       4. dim is turning off
>       5. The worker successfully configure this parameter to the device.
>       6. The worker will not be scheduled until the next time dim is on.
>
>[1]
>========================================================
>WARNING: possible recursive locking detected
>6.9.0-rc7+ #319 Not tainted
>--------------------------------------------
>ethtool/962 is trying to acquire lock:
>
>but task is already holding lock:
>
>other info that might help us debug this:
>Possible unsafe locking scenario:
>
>      CPU0
>      ----
> lock(&vi->rq[i].dim_lock);
> lock(&vi->rq[i].dim_lock);
>
>*** DEADLOCK ***
>
> May be due to missing lock nesting notation
>
>3 locks held by ethtool/962:
> #0: ffffffff82dbaab0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40
> #1: ffffffff82dad0a8 (rtnl_mutex){+.+.}-{3:3}, at:
>				ethnl_default_set_doit+0xbe/0x1e0
>
>stack backtrace:
>CPU: 6 PID: 962 Comm: ethtool Not tainted 6.9.0-rc7+ #319
>Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>	   rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
>Call Trace:
> <TASK>
> dump_stack_lvl+0x79/0xb0
> check_deadlock+0x130/0x220
> __lock_acquire+0x861/0x990
> lock_acquire.part.0+0x72/0x1d0
> ? lock_acquire+0xf8/0x130
> __mutex_lock+0x71/0xd50
> virtnet_set_coalesce+0x151/0x190
> __ethnl_set_coalesce.isra.0+0x3f8/0x4d0
> ethnl_set_coalesce+0x34/0x90
> ethnl_default_set_doit+0xdd/0x1e0
> genl_family_rcv_msg_doit+0xdc/0x130
> genl_family_rcv_msg+0x154/0x230
> ? __pfx_ethnl_default_set_doit+0x10/0x10
> genl_rcv_msg+0x4b/0xa0
> ? __pfx_genl_rcv_msg+0x10/0x10
> netlink_rcv_skb+0x5a/0x110
> genl_rcv+0x28/0x40
> netlink_unicast+0x1af/0x280
> netlink_sendmsg+0x20e/0x460
> __sys_sendto+0x1fe/0x210
> ? find_held_lock+0x2b/0x80
> ? do_user_addr_fault+0x3a2/0x8a0
> ? __lock_release+0x5e/0x160
> ? do_user_addr_fault+0x3a2/0x8a0
> ? lock_release+0x72/0x140
> ? do_user_addr_fault+0x3a7/0x8a0
> __x64_sys_sendto+0x29/0x30
> do_syscall_64+0x78/0x180
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
>Fixes: 4d4ac2ececd3 ("virtio_net: Add a lock for per queue RX coalesce")
>Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

