Return-Path: <netdev+bounces-173134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA25A577F3
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 04:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A423177408
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 03:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9B917A2FF;
	Sat,  8 Mar 2025 03:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ff5cML+1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A14117A2F6
	for <netdev@vger.kernel.org>; Sat,  8 Mar 2025 03:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741405211; cv=none; b=aM/vJQfUeUXg75XzJGIyL+1laZ+FvPm00GMKlS99Huvej/YSzwEuhoYGmpeYIlYWdi/OIRcbeuB4fusdEjuhgTo1eWEMz7BzYSAT6nwspU2rI/hqTC7w2HOSygG5YkuMD70SKtthFqT0rrqrKYsGWPq80r5/MFPdP5LEcb7yVBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741405211; c=relaxed/simple;
	bh=KSpWT0KM8jdIfWYEAZRSVrkFSrV9cdCaq1IjXD46mYo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rGdlwIYyNN7IPuyQH0igRMi0kOw7E4eicnZE2+gWnRzPgc4Ud0mfVnL8KG9meoWto1CW9Aq7uuEK3mq6EhPWbo4V1NxCl8/tGjzPLqnXrryBQoHG/KoP/lUBtfkX+WpgCZTfSYxHDqoEtxEutBaxZGZ/KDk9mN9+eWXDeoKEqII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ff5cML+1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63841C4CEE2;
	Sat,  8 Mar 2025 03:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741405211;
	bh=KSpWT0KM8jdIfWYEAZRSVrkFSrV9cdCaq1IjXD46mYo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ff5cML+1O+rAHzuZOv6uP8VZ81E9KI0AA1kJomakiVX+D2bw1ICWDEJwQ7pcIOY0E
	 CY6muqkoIQfvjiYQGdB7r7pGUxGQbTBG3GZOaiJzDuyB24hkep8JWdNtT58yhvhCoh
	 wJHYBk9jiZlTTiw77UbVJkh6u+xbU05mkWu5TR/WjLlYdsdvMY5mGIm5JdHL+/1dzf
	 PR7CqP+uP4sbU/4l2qU2M6ihyr9O97CWxrs4ws/kqNzeEcL8bSTg+UUp3AfVIb73vT
	 NsvnaZvCoqyS3/Te1iyv3zSdeeKF24b0YcjIFGnzeSln/42fSdyNupRLa7L4+5Wm16
	 xJUkchNa3FCbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DB3380CFFB;
	Sat,  8 Mar 2025 03:40:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] bpf: fix a possible NULL deref in
 bpf_map_offload_map_alloc()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174140524498.2565853.1890386523722103613.git-patchwork-notify@kernel.org>
Date: Sat, 08 Mar 2025 03:40:44 +0000
References: <20250307074303.1497911-1-edumazet@google.com>
In-Reply-To: <20250307074303.1497911-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, sdf@fomichev.me,
 horms@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+0c7bfd8cf3aecec92708@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  7 Mar 2025 07:43:02 +0000 you wrote:
> Call bpf_dev_offload_check() before netdev_lock_ops().
> 
> This is needed if attr->map_ifindex is not valid.
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000197: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000cb8-0x0000000000000cbf]
>  RIP: 0010:netdev_need_ops_lock include/linux/netdevice.h:2792 [inline]
>  RIP: 0010:netdev_lock_ops include/linux/netdevice.h:2803 [inline]
>  RIP: 0010:bpf_map_offload_map_alloc+0x19a/0x910 kernel/bpf/offload.c:533
> Call Trace:
>  <TASK>
>   map_create+0x946/0x11c0 kernel/bpf/syscall.c:1455
>   __sys_bpf+0x6d3/0x820 kernel/bpf/syscall.c:5777
>   __do_sys_bpf kernel/bpf/syscall.c:5902 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5900 [inline]
>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5900
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> 
> [...]

Here is the summary with links:
  - [net-next] bpf: fix a possible NULL deref in bpf_map_offload_map_alloc()
    https://git.kernel.org/netdev/net-next/c/0a5c8b2c8ccb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



