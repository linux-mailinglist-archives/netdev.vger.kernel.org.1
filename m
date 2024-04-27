Return-Path: <netdev+bounces-91899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B498B4668
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 15:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23024B229E2
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 13:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4704D5AC;
	Sat, 27 Apr 2024 13:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSodTo8n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8801443172
	for <netdev@vger.kernel.org>; Sat, 27 Apr 2024 13:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714223790; cv=none; b=sMU10Hw7ILFr+ngGfygpsgybKb35BqrnyXP5aFazEIkTY4W/rfuebqNJgRV95xWOyCDQ5VFKvkDm7CqjOQxjwaStyE99kJYxWXznhifffvNAn2AxK+o857Hu8t1Kt1uEeLSVzLwt3u2rC7PeT8U/A0Vk7H4gNuEDKk+r0EJFAQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714223790; c=relaxed/simple;
	bh=fUUuB8Olt4La3VO4Sni1xzc+AGR154Gg5keMY31XNhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9MMgpnRflLQFxc7VJhxvsdnA0BN+C0l3mVCm9RYST8P6G8irQrUIdRZnMxgABMskVbQTgUF+/Tqtt6Y8oSH3dMlVodz0BfUma22WLKh/HOK9dN4NKhId2tJak1HWyKqCEU/1fqr4oDv8kS1Bg9gQ1qM4lxMd+ath5Tb0vtTW90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSodTo8n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B41AC113CE;
	Sat, 27 Apr 2024 13:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714223790;
	bh=fUUuB8Olt4La3VO4Sni1xzc+AGR154Gg5keMY31XNhc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eSodTo8n0h8b/xKSnOD2kNyYL92d6QQxlSk9o/jaSaXse2AdHe8p5OYZ1+/lQz+IE
	 JLKWRPJm1ieP/R8UHaX5CB6CICpggldyooeUfI1PQ4oJsYmMTWk3BOt0lKMcWrre04
	 VybOxB1YS70creH2z6yJ5VjLaty96/wLQ4QBrmuUFCyJwwf8UAfKvMr565EQbqFwI2
	 ogyd3dgfPizK8qFS1cDh9bglqtc8O3nbcUj4JxS8phU4Jqhd/S0WI9ijiHAHEpT6cX
	 BtN/VzVVGrKK4zGif5J8ox6a8ExHedbD3J6juMzjhDAtA8rsfyBcBFKJTjPxh7cMoq
	 pvcy3avvZ1+4w==
Date: Sat, 27 Apr 2024 14:16:25 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot <syzkaller@googlegroups.com>,
	Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH net-next] net: hsr: init prune_proxy_timer sooner
Message-ID: <20240427131625.GH516117@kernel.org>
References: <20240426163355.2613767-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426163355.2613767-1-edumazet@google.com>

On Fri, Apr 26, 2024 at 04:33:55PM +0000, Eric Dumazet wrote:
> We must initialize prune_proxy_timer before we attempt
> a del_timer_sync() on it.
> 
> syzbot reported the following splat:
> 
> INFO: trying to register non-static key.
> The code is fine but needs lockdep annotation, or maybe
> you didn't initialize this object before use?
> turning off the locking correctness validator.
> CPU: 1 PID: 11 Comm: kworker/u8:1 Not tainted 6.9.0-rc5-syzkaller-01199-gfc48de77d69d #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> Workqueue: netns cleanup_net
> Call Trace:
>  <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>   assign_lock_key+0x238/0x270 kernel/locking/lockdep.c:976
>   register_lock_class+0x1cf/0x980 kernel/locking/lockdep.c:1289
>   __lock_acquire+0xda/0x1fd0 kernel/locking/lockdep.c:5014
>   lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
>   __timer_delete_sync+0x148/0x310 kernel/time/timer.c:1648
>   del_timer_sync include/linux/timer.h:185 [inline]
>   hsr_dellink+0x33/0x80 net/hsr/hsr_netlink.c:132
>   default_device_exit_batch+0x956/0xa90 net/core/dev.c:11737
>   ops_exit_list net/core/net_namespace.c:175 [inline]
>   cleanup_net+0x89d/0xcc0 net/core/net_namespace.c:637
>   process_one_work kernel/workqueue.c:3254 [inline]
>   process_scheduled_works+0xa10/0x17c0 kernel/workqueue.c:3335
>   worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
>   kthread+0x2f0/0x390 kernel/kthread.c:388
>   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> ODEBUG: assert_init not available (active state 0) object: ffff88806d3fcd88 object type: timer_list hint: 0x0
>  WARNING: CPU: 1 PID: 11 at lib/debugobjects.c:517 debug_print_object+0x17a/0x1f0 lib/debugobjects.c:514
> 
> Fixes: 5055cccfc2d1 ("net: hsr: Provide RedBox support (HSR-SAN)")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Lukasz Majewski <lukma@denx.de>

Reviewed-by: Simon Horman <horms@kernel.org>


