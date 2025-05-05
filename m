Return-Path: <netdev+bounces-188187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0740AAB7FB
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 08:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95D8A4E49CE
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 06:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E752FCA8F;
	Tue,  6 May 2025 01:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2pJeK2s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33907312809;
	Mon,  5 May 2025 23:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746489044; cv=none; b=d0e5n0odes1b11salZLvtnGV36G/zsGxAtGPu5jGR37W5Jd9QeiUbHp3WEO8thd8NcvQ45+LtGIDSjiRpK7FTROWC8e+jmdF2E2rmZR0AbVNUXXfWRQ0H78l+EGfo/hPtt+dUlV/DAgq1siUCgappVpK/FPUCsKfMQaHJPdFXN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746489044; c=relaxed/simple;
	bh=2ovfTBu8BtfROUp5TFoIE/nZlSdnbc4INB3TudhG3Ks=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BIilSrUiNg+jh0+6xgdWs3i7IQcFePNG9kHFF5XdcBw5fcHZFAcWi4AqB5mf1c1glBYg/VYEcvJPTLzn3TCXPr+N6faE8f/6LZoWatShHkUjIm0TCNUCPWvkoUeLkzCfJVx1zLGVuYKia+pgDzQcGJJJiv0KZ2Y7MPk/BhA4StE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2pJeK2s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA854C4CEED;
	Mon,  5 May 2025 23:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746489043;
	bh=2ovfTBu8BtfROUp5TFoIE/nZlSdnbc4INB3TudhG3Ks=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U2pJeK2sRpk3FVIBIKNEXlZHl2GldeBdH++mB8y1buY0toOUWHfm5mLYhJMW0B9nc
	 z2fGiiRPwGKkEnoE/7Av8BEdLrcpCet+2ViW94o74Da8z7IMxwxN9rCOhXDRsgRlqU
	 NgLhwn6MT1JeqVC/+9V2k7EcpDhqfsTGRYB8SLGHfJYb/vACmIylGfuVae/QolPfvz
	 GirPMPLTt8hl1RCEpGTqUb5cxMQimOIuH5igYFnvRzqSxyDueXtzicNRk4MBVyvIQW
	 eiOC6fz/vH/rmY5+3iTvQ+9WZIWVC3AfwAVXZuCYW3YMnjqXW2WOb6NtcHZI7ipKMF
	 amQmb9iRw1i0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 339F2380CFD9;
	Mon,  5 May 2025 23:51:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] virtio-net: free xsk_buffs on error in
 virtnet_xsk_pool_enable()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174648908298.967302.6128357304548070079.git-patchwork-notify@kernel.org>
Date: Mon, 05 May 2025 23:51:22 +0000
References: <20250430163836.3029761-1-kuba@kernel.org>
In-Reply-To: <20250430163836.3029761-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 jasowang@redhat.com, mst@redhat.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, hawk@kernel.org, john.fastabend@gmail.com,
 virtualization@lists.linux.dev, minhquangbui99@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Apr 2025 09:38:36 -0700 you wrote:
> The selftests added to our CI by Bui Quang Minh recently reveals
> that there is a mem leak on the error path of virtnet_xsk_pool_enable():
> 
> unreferenced object 0xffff88800a68a000 (size 2048):
>   comm "xdp_helper", pid 318, jiffies 4294692778
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc 0):
>     __kvmalloc_node_noprof+0x402/0x570
>     virtnet_xsk_pool_enable+0x293/0x6a0 (drivers/net/virtio_net.c:5882)
>     xp_assign_dev+0x369/0x670 (net/xdp/xsk_buff_pool.c:226)
>     xsk_bind+0x6a5/0x1ae0
>     __sys_bind+0x15e/0x230
>     __x64_sys_bind+0x72/0xb0
>     do_syscall_64+0xc1/0x1d0
>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Here is the summary with links:
  - [net,v2] virtio-net: free xsk_buffs on error in virtnet_xsk_pool_enable()
    https://git.kernel.org/netdev/net/c/4397684a292a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



