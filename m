Return-Path: <netdev+bounces-155170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA55A01590
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 16:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E30913A31F1
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 15:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19E91C3BE3;
	Sat,  4 Jan 2025 15:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKMHuOrZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAAD335C0
	for <netdev@vger.kernel.org>; Sat,  4 Jan 2025 15:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736005061; cv=none; b=WgV8dZ1d+49Wr9Onfk7pTw/ZuaWiBOG86EhiGBkinGZUEKSIr6/8RSSn5tcYp+4RmOqCJGOe6hYuPEy8Bqdyle3NidfcfloQTiuEyabs4d8vznyv8XnxWEoPJtmwYV91Kr0wltyv1g+HyRD7VXZfplhOo9gRyAqujVgJCwxAhsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736005061; c=relaxed/simple;
	bh=BB8yfBtSvPK7gqyv61bNu0LDCUbnS1qOYKVwEHBPBj0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EjU/5HsZqIsXnSXshrWHuxL0jTv+Q3G0drosIxJpQq72XhuAoIzEJewp/Xlt1LzxARtcUS2LJ8QY89wQXo7FEve96DzgVavTiTHD5umqKG1hBOnb2BfjaVViMwILmjKC1muvj/UTKADFCewQGlJQR2UY5VossNqkbrSqe7eAQJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKMHuOrZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4F6C4CED2;
	Sat,  4 Jan 2025 15:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736005061;
	bh=BB8yfBtSvPK7gqyv61bNu0LDCUbnS1qOYKVwEHBPBj0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OKMHuOrZbiBKvjxCrDzV+0yA8y/QvR+0Z1+n6e5JJo9VznH0Jfvdm47HBvUcinYuW
	 Kc8WAJPThTPrgzwdG0VIrcABCyCFHqHyl3EsYTzj5/pQV2Q9S2DC42LdUrqN1scSlj
	 h474XoZTFVRBAe3FzvnNIEijc0W0k0E6H8ylUVOF/mHwlTHCFyP+KMbEpLXpX4REbt
	 huRYqSJ3/rNrPdpTslaZe01zhik1b+NHQX0cOIzSmBMaSMYg/KN9p1MnoOKGB/OKKA
	 GYUWOhzHlPEy7qhQazGnqMqzSnHK6zh0dYaj2LVVaFtYYefGbErnVE1+dI7zs/leYP
	 UoED9LL5qqWAQ==
Date: Sat, 4 Jan 2025 07:37:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH v1 net-next 0/4] net: Hold per-netns RTNL during netdev
 notifier registration.
Message-ID: <20250104073740.597af5c0@kernel.org>
In-Reply-To: <20250104063735.36945-1-kuniyu@amazon.com>
References: <20250104063735.36945-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 4 Jan 2025 15:37:31 +0900 Kuniyuki Iwashima wrote:
> Patch 1 converts the global netdev notifier to blocking_notifier,
> which will be called under per-netns RTNL without RTNL, then we
> need to protect the ongoing netdev_chain users from unregistration.
> 
> Patch 2 ~ 4 adds per-netns RTNL for registration of the global
> and per-netns netdev notifiers.

Lockdep is not happy:

[  249.261403][   T11] ============================================ 
[  249.261592][   T11] WARNING: possible recursive locking detected
[  249.261769][   T11] 6.13.0-rc5-virtme #1 Not tainted
[  249.261920][   T11] --------------------------------------------
[  249.262094][   T11] kworker/u16:0/11 is trying to acquire lock:
[  249.262293][   T11] ffffffff8a7f6a70 ((netdev_chain).rwsem){++++}-{4:4}, at: blocking_notifier_call_chain+0x50/0x90
[  249.262591][   T11] 
[  249.262591][   T11] but task is already holding lock:
[  249.262810][   T11] ffffffff8a7f6a70 ((netdev_chain).rwsem){++++}-{4:4}, at: blocking_notifier_call_chain+0x50/0x90
[  249.263100][   T11] 
[  249.263100][   T11] other info that might help us debug this:
[  249.263310][   T11]  Possible unsafe locking scenario:
[  249.263310][   T11] 
[  249.263522][   T11]        CPU0
[  249.263624][   T11]        ----
[  249.263728][   T11]   lock((netdev_chain).rwsem);
[  249.263875][   T11]   lock((netdev_chain).rwsem);
[  249.264020][   T11] 
[  249.264020][   T11]  *** DEADLOCK ***
[  249.264020][   T11] 
[  249.264223][   T11]  May be due to missing lock nesting notation
[  249.264223][   T11] 
[  249.264440][   T11] 5 locks held by kworker/u16:0/11:
[  249.264582][   T11]  #0: ffff8880010b5948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0x7ec/0x16d0
[  249.264867][   T11]  #1: ffffc900000b7da0 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0xe0b/0x16d0
[  249.265118][   T11]  #2: ffffffff8a7ec4d0 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0xbc/0xba0
[  249.265381][   T11]  #3: ffffffff8a807e88 (rtnl_mutex){+.+.}-{4:4}, at: default_device_exit_batch+0x81/0x2e0
[  249.265668][   T11]  #4: ffffffff8a7f6a70 ((netdev_chain).rwsem){++++}-{4:4}, at: blocking_notifier_call_chain+0x50/0x90
[  249.265954][   T11] 
[  249.265954][   T11] stack backtrace:
[  249.266126][   T11] CPU: 2 UID: 0 PID: 11 Comm: kworker/u16:0 Not tainted 6.13.0-rc5-virtme #1
[  249.266389][   T11] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[  249.266572][   T11] Workqueue: netns cleanup_net
[  249.266722][   T11] Call Trace:
[  249.266826][   T11]  <TASK>
[  249.266907][   T11]  dump_stack_lvl+0x82/0xd0
[  249.267056][   T11]  print_deadlock_bug+0x40a/0x650
[  249.267206][   T11]  validate_chain+0x5bf/0xae0
[  249.267352][   T11]  ? __pfx_validate_chain+0x10/0x10
[  249.267503][   T11]  ? hlock_class+0x4e/0x130
[  249.267642][   T11]  ? mark_lock+0x38/0x3e0
[  249.267751][   T11]  __lock_acquire+0xb9a/0x1680
[  249.267897][   T11]  ? spin_bug+0x191/0x1d0
[  249.268007][   T11]  ? debug_object_assert_init+0x2a9/0x370
[  249.268164][   T11]  lock_acquire.part.0+0xeb/0x330
[  249.268313][   T11]  ? blocking_notifier_call_chain+0x50/0x90
[  249.268497][   T11]  ? __pfx_lock_acquire.part.0+0x10/0x10
[  249.268651][   T11]  ? trace_lock_acquire+0x14c/0x1f0
[  249.268803][   T11]  ? lock_acquire+0x32/0xc0
[  249.268944][   T11]  ? blocking_notifier_call_chain+0x50/0x90
[  249.269132][   T11]  down_read+0x9f/0x340
[  249.269247][   T11]  ? blocking_notifier_call_chain+0x50/0x90
[  249.269436][   T11]  ? __pfx_down_read+0x10/0x10
[  249.269586][   T11]  blocking_notifier_call_chain+0x50/0x90
[  249.269739][   T11]  __dev_close_many+0xdf/0x2d0
[  249.269881][   T11]  ? __pfx___dev_close_many+0x10/0x10
[  249.270031][   T11]  dev_close_many+0x202/0x650
-- 
pw-bot: cr

