Return-Path: <netdev+bounces-147942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B64789DF381
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 23:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F04E281464
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 22:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C9C1A9B31;
	Sat, 30 Nov 2024 22:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0I1i+eP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C81517BD3
	for <netdev@vger.kernel.org>; Sat, 30 Nov 2024 22:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733005216; cv=none; b=nG5UrVbniM5o5QBFTgtRoRRyH2AebEUV1luPFCLNLHnpAsv/nN6rv4WYssVeGlLiX5Dg8Rdtl70IFyXMXUj1HQwFMtsUuxsiOSeHnjeDm0tRJZYihpuAMD/vm1GpXHiTe4WzHf6rc3DywOWQyVUA3aNMxVvNVFvPg/sQCfF2380=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733005216; c=relaxed/simple;
	bh=Pna4B1EP8VxoDmjqbb18vam1FBaeZTOvfrev2mEgsw8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=URRRXQmy2FbHbQILpKIE9+SNQEuK4CQFlVgyoHKlr50GY8G6QJUe5OD373rCV8LZT6OcUfJBb60ezsWAJluQME00dbRqvJiLZhow6jQ+S74qVDqjEer7la50Lj9As5K6YC1yLXLp68CnrP2OKu2hBuoNoIMj0xchlyRE33XxC5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0I1i+eP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08461C4CECC;
	Sat, 30 Nov 2024 22:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733005216;
	bh=Pna4B1EP8VxoDmjqbb18vam1FBaeZTOvfrev2mEgsw8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O0I1i+ePqArHsYmNpfIGSTfvr6ZbUTomgwa8hYVfJ+RVtc2qMQ9Btb1n02mX6vIMN
	 bPcrQIg/mniXkHhkdCiJ3I8azZGUUF9YsBJZ6AYs4aw42bc5BMKfrYtibGKApckDFw
	 5AxzGLLKBCFcaxv1QL8B53F1mXngH2v2OjgU7BtGaA4tGEfEZuMvvUKeJQOh1qdjp5
	 8U7e2ByW31kjnY8f4BQvneLFrZKl40+L0H4eqXRmCGqacoRrdoRM574+/q2vbN9n8Y
	 OkxTLTnJ3Q/iLTA4sZSZMtJzwA7gz75Jl9OmXEM8DNiXFuNf8lSlBin7q343HTJ19z
	 LTjhd31w1FeeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB28B380A944;
	Sat, 30 Nov 2024 22:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: hsr: avoid potential out-of-bound access in
 fill_frame_info()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173300522975.2492979.17101494144631097796.git-patchwork-notify@kernel.org>
Date: Sat, 30 Nov 2024 22:20:29 +0000
References: <20241126144344.4177332-1-edumazet@google.com>
In-Reply-To: <20241126144344.4177332-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+671e2853f9851d039551@syzkaller.appspotmail.com, w-kwok2@ti.com,
 m-karicheri2@ti.com, danishanwar@ti.com, jiri@nvidia.com,
 george.mccollister@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 Nov 2024 14:43:44 +0000 you wrote:
> syzbot is able to feed a packet with 14 bytes, pretending
> it is a vlan one.
> 
> Since fill_frame_info() is relying on skb->mac_len already,
> extend the check to cover this case.
> 
> BUG: KMSAN: uninit-value in fill_frame_info net/hsr/hsr_forward.c:709 [inline]
>  BUG: KMSAN: uninit-value in hsr_forward_skb+0x9ee/0x3b10 net/hsr/hsr_forward.c:724
>   fill_frame_info net/hsr/hsr_forward.c:709 [inline]
>   hsr_forward_skb+0x9ee/0x3b10 net/hsr/hsr_forward.c:724
>   hsr_dev_xmit+0x2f0/0x350 net/hsr/hsr_device.c:235
>   __netdev_start_xmit include/linux/netdevice.h:5002 [inline]
>   netdev_start_xmit include/linux/netdevice.h:5011 [inline]
>   xmit_one net/core/dev.c:3590 [inline]
>   dev_hard_start_xmit+0x247/0xa20 net/core/dev.c:3606
>   __dev_queue_xmit+0x366a/0x57d0 net/core/dev.c:4434
>   dev_queue_xmit include/linux/netdevice.h:3168 [inline]
>   packet_xmit+0x9c/0x6c0 net/packet/af_packet.c:276
>   packet_snd net/packet/af_packet.c:3146 [inline]
>   packet_sendmsg+0x91ae/0xa6f0 net/packet/af_packet.c:3178
>   sock_sendmsg_nosec net/socket.c:711 [inline]
>   __sock_sendmsg+0x30f/0x380 net/socket.c:726
>   __sys_sendto+0x594/0x750 net/socket.c:2197
>   __do_sys_sendto net/socket.c:2204 [inline]
>   __se_sys_sendto net/socket.c:2200 [inline]
>   __x64_sys_sendto+0x125/0x1d0 net/socket.c:2200
>   x64_sys_call+0x346a/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:45
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Here is the summary with links:
  - [net] net: hsr: avoid potential out-of-bound access in fill_frame_info()
    https://git.kernel.org/netdev/net/c/b9653d19e556

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



