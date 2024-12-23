Return-Path: <netdev+bounces-154081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB0E9FB3CF
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 19:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3D8718849C4
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 18:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA471B87CE;
	Mon, 23 Dec 2024 18:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCScH02u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1E21B413F;
	Mon, 23 Dec 2024 18:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734977416; cv=none; b=TB1IoQWmwACw2lPzDkV32Eh2qxu5CzzgE/vYQY9VurHrGMRcdlASf6n3/yKdpgg1Q0ZIMYNQUBa6wM7NjXPUvjkiWuV4Z83foF8zkoZHpfVLzaytjAnYi/0BJrNV0vQgeFGFGAR4yZ4AWVTHv4onOFXafmTqQ29M2PJzBSho9m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734977416; c=relaxed/simple;
	bh=tXUXC+t6Y6cZ22CroxIM3T1waOshmRP4BslzF0u05Rg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fiwBZE3J8coYpg66rGlqG8RoZkG+d5jevfOrwS68X7E1DWtYveXjMFfqGXlwnKALDSGRMnAnc7zrdCpTnoNIFOtedGPFHhhwF8tlLPQHL2XhSZESj16v2f0J0OtnBfMxZZJZ8u3UcFSdG/ae+UySvRJUHAwAfZPIenJQGO77TgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCScH02u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D69C4CED3;
	Mon, 23 Dec 2024 18:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734977415;
	bh=tXUXC+t6Y6cZ22CroxIM3T1waOshmRP4BslzF0u05Rg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NCScH02uNyhLJVAR1Zh32v6zgGCnwb6n9qpcRCOpSutDvlzhtmjFOX+hcWOyZ3V3e
	 NLhDsQxLupwCGH4K9U93Sn8wfaTRF/S/myeJNUkEffvWH4kgJEI6FWnRlYiZlpmqML
	 onUWeq1DvWS/0OT15QOZyNVCryJRbahkKWkK9K0DeH3b61STmY01iwxklYYvTc86in
	 w9lpeYvO8BG+LbBO9LERLepljiaTJ1GrGGOu/AvDaXRXoUNUUFGtipBwR9JFCTPmhN
	 WJod3H+13Ul67ZfBLJsBAYe6e90kpmIHOJ8V8fcSxcOhudKVGA5keTwvkMSWny1y26
	 MjlZ52pfVzspw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF2D3805DB2;
	Mon, 23 Dec 2024 18:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: fix memory leak in tcp_conn_request()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173497743378.3921163.15697697298645904400.git-patchwork-notify@kernel.org>
Date: Mon, 23 Dec 2024 18:10:33 +0000
References: <20241219072859.3783576-1-wangliang74@huawei.com>
In-Reply-To: <20241219072859.3783576-1-wangliang74@huawei.com>
To: Wang Liang <wangliang74@huawei.com>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 luoxuanqiang@kylinos.cn, kuniyu@amazon.com, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Dec 2024 15:28:59 +0800 you wrote:
> If inet_csk_reqsk_queue_hash_add() return false, tcp_conn_request() will
> return without free the dst memory, which allocated in af_ops->route_req.
> 
> Here is the kmemleak stack:
> 
> unreferenced object 0xffff8881198631c0 (size 240):
>   comm "softirq", pid 0, jiffies 4299266571 (age 1802.392s)
>   hex dump (first 32 bytes):
>     00 10 9b 03 81 88 ff ff 80 98 da bc ff ff ff ff  ................
>     81 55 18 bb ff ff ff ff 00 00 00 00 00 00 00 00  .U..............
>   backtrace:
>     [<ffffffffb93e8d4c>] kmem_cache_alloc+0x60c/0xa80
>     [<ffffffffba11b4c5>] dst_alloc+0x55/0x250
>     [<ffffffffba227bf6>] rt_dst_alloc+0x46/0x1d0
>     [<ffffffffba23050a>] __mkroute_output+0x29a/0xa50
>     [<ffffffffba23456b>] ip_route_output_key_hash+0x10b/0x240
>     [<ffffffffba2346bd>] ip_route_output_flow+0x1d/0x90
>     [<ffffffffba254855>] inet_csk_route_req+0x2c5/0x500
>     [<ffffffffba26b331>] tcp_conn_request+0x691/0x12c0
>     [<ffffffffba27bd08>] tcp_rcv_state_process+0x3c8/0x11b0
>     [<ffffffffba2965c6>] tcp_v4_do_rcv+0x156/0x3b0
>     [<ffffffffba299c98>] tcp_v4_rcv+0x1cf8/0x1d80
>     [<ffffffffba239656>] ip_protocol_deliver_rcu+0xf6/0x360
>     [<ffffffffba2399a6>] ip_local_deliver_finish+0xe6/0x1e0
>     [<ffffffffba239b8e>] ip_local_deliver+0xee/0x360
>     [<ffffffffba239ead>] ip_rcv+0xad/0x2f0
>     [<ffffffffba110943>] __netif_receive_skb_one_core+0x123/0x140
> 
> [...]

Here is the summary with links:
  - [net] net: fix memory leak in tcp_conn_request()
    https://git.kernel.org/netdev/net/c/4f4aa4aa2814

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



