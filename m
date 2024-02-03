Return-Path: <netdev+bounces-68811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6990848656
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 13:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58F31B23A5A
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 12:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F354F5EB;
	Sat,  3 Feb 2024 12:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRkiCNjM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D64439860
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 12:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706964626; cv=none; b=Vj2VDGl+CcY7uEpB5drTjVlDUb0dZAh9x0Gf/UKOhBEGcVyK02wiVs9tjP3+Zl5Wy8BWxFczfwUKZSuIS0oeWaVlhAb9HwixPQkJTxpL85QQmsV1WwioH9+Wh8J16n7lfph3AvVxwvBKq9s9SQUu/FRv5Z3NFkiRdg8ZHYQRJSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706964626; c=relaxed/simple;
	bh=QiXInQWpGnlMJu/k5INEF+uprg272aX5Z/65zCbkGyM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qV3NwPAqg7Y+XqboPK7wvNGmvsHjr712gn72XCpsx+VpOlHp5j3MBcjmOpzAtxFVOSVLayS1RJNyPxJ6kk2Gw3Ixjz2MwnUVxXEdAGCSzXOxxF46DQ/4hCZeSwBfe6qSDMo+2mwjLPbD+3JNqT4xr8/x+az1/ikPHavvqI/Xmdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRkiCNjM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F33CC433B1;
	Sat,  3 Feb 2024 12:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706964626;
	bh=QiXInQWpGnlMJu/k5INEF+uprg272aX5Z/65zCbkGyM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fRkiCNjM99uzfwF0O4TguelTFYE1FmSSuVAx6mhR62rfhTdggmZKPhXQ03vCovHx9
	 e0PYCJn6FT61l3JoJ4R8i33giFb3Hm6WdRTsSS+GjCeLjslqGILsg6A++cEK+IwL4g
	 nQN1/XSmZn63dbksm8lT8A6dJbO4xXY5aN7gbBBC9vqfn87rhKwMefCGMZET5YJ6m5
	 l8ScTolVobHa7decHlQqCMLxo/6wbVux9hUYVa5ii6qPkhK++Gl8kpuKKPgSnOXUMm
	 b8F83YqxcIUm33L4z/Wf7herHcxPN7cDbLDE271G/3azQccQL9BG9AAhrnDmztR0eQ
	 LPM4P6Vbj3UMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1543CDC99E7;
	Sat,  3 Feb 2024 12:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tunnels: fix out of bounds access when building IPv6 PMTU
 error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170696462608.20224.15153343992903506175.git-patchwork-notify@kernel.org>
Date: Sat, 03 Feb 2024 12:50:26 +0000
References: <20240201083817.12774-1-atenart@kernel.org>
In-Reply-To: <20240201083817.12774-1-atenart@kernel.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  1 Feb 2024 09:38:15 +0100 you wrote:
> If the ICMPv6 error is built from a non-linear skb we get the following
> splat,
> 
>   BUG: KASAN: slab-out-of-bounds in do_csum+0x220/0x240
>   Read of size 4 at addr ffff88811d402c80 by task netperf/820
>   CPU: 0 PID: 820 Comm: netperf Not tainted 6.8.0-rc1+ #543
>   ...
>    kasan_report+0xd8/0x110
>    do_csum+0x220/0x240
>    csum_partial+0xc/0x20
>    skb_tunnel_check_pmtu+0xeb9/0x3280
>    vxlan_xmit_one+0x14c2/0x4080
>    vxlan_xmit+0xf61/0x5c00
>    dev_hard_start_xmit+0xfb/0x510
>    __dev_queue_xmit+0x7cd/0x32a0
>    br_dev_queue_push_xmit+0x39d/0x6a0
> 
> [...]

Here is the summary with links:
  - [net] tunnels: fix out of bounds access when building IPv6 PMTU error
    https://git.kernel.org/netdev/net/c/d75abeec401f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



