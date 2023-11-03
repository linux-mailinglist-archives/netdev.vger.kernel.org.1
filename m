Return-Path: <netdev+bounces-45873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9F07DFFF6
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 10:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10694B2129C
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 09:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C42C8C6;
	Fri,  3 Nov 2023 09:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2Zrz/9i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0484D79D1
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 09:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99C06C433C7;
	Fri,  3 Nov 2023 09:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699003223;
	bh=THMrlEH/AgE0HuxCkw5yaitecucnxgYxx5Wpr6R41uM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e2Zrz/9iiMCFX8sIkXu53NulliBGiIOMOe93ulJFtJeypWyUKWSIpytL6I4ybVRBS
	 jNWZSvPFo7zb+ckmbOVjXpFd64UUYpjrR02NEKvTfmTZNsdUgRcg97AotY58eWFTXd
	 cY0XRtf3rP7T+CeoFIpASIeyPn8Ifn3Vm1mfnoKkCDVxEQqGil5kCYyQKEN2AGDp8+
	 l0tFusaI4R+mpH+5l+YT/Lbc37JYQ+Sr7TayRua9GyjQaHStlfGxSsIyWmAWRpDfvo
	 C1HOZJl7PBE3VMS4zzgdoRDVoaXwfdcYJCcZIcPKDmzJLdTapymLwc4aE3jQm/1Lwl
	 b4+YWKOGf2Spg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8269FC04DD9;
	Fri,  3 Nov 2023 09:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: fix fastopen code vs usec TS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169900322353.11636.7052991589260368750.git-patchwork-notify@kernel.org>
Date: Fri, 03 Nov 2023 09:20:23 +0000
References: <20231031061945.2801972-1-edumazet@google.com>
In-Reply-To: <20231031061945.2801972-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, oliver.sang@intel.com,
 ncardwell@google.com, morleyd@google.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 31 Oct 2023 06:19:45 +0000 you wrote:
> After blamed commit, TFO client-ack-dropped-then-recovery-ms-timestamps
> packetdrill test failed.
> 
> David Morley and Neal Cardwell started investigating and Neal pointed
> that we had :
> 
> tcp_conn_request()
>   tcp_try_fastopen()
>    -> tcp_fastopen_create_child
>      -> child = inet_csk(sk)->icsk_af_ops->syn_recv_sock()
>        -> tcp_create_openreq_child()
>           -> copy req_usec_ts from req:
>           newtp->tcp_usec_ts = treq->req_usec_ts;
>           // now the new TFO server socket always does usec TS, no matter
>           // what the route options are...
>   send_synack()
>     -> tcp_make_synack()
>         // disable tcp_rsk(req)->req_usec_ts if route option is not present:
>         if (tcp_rsk(req)->req_usec_ts < 0)
>                 tcp_rsk(req)->req_usec_ts = dst_tcp_usec_ts(dst);
> 
> [...]

Here is the summary with links:
  - [net] tcp: fix fastopen code vs usec TS
    https://git.kernel.org/netdev/net/c/cdbab6236605

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



