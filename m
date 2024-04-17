Return-Path: <netdev+bounces-88670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 587918A82AE
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 14:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 892A91C218C6
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 12:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC1A13D245;
	Wed, 17 Apr 2024 12:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+BSqGKt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB8213CFBD
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 12:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713355228; cv=none; b=s45K7t6rkCjlggCqPLMPOJorbQET0g9aKWnsltE3onTtQFhFIFA8TYQDtLlcieD+c8SO/250tEMIrauqpWQXKlMEzU2PXx201LZtpunB0biukpUlp4gcCiEipTOTAk2MAOMRWP+aAybv40Tti5PvEoPdxxtXRSGnk2JU24bHdkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713355228; c=relaxed/simple;
	bh=HzGMgnDrZvUIv1uGxXoX3B+eBoUnhMaKa3oceiR5HQE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tDtEVBLDtYfZbRa99aLft8N+7R0cWAS8gxYFFhCYIGSBlaBDo5WqvT1fEa1P4rakiCH7/GgS8qgqGAg2kCoLQ+fyqQbLjUsiX9twF0D+M+3QrU9kbZ4QiGKM0WbfkMfwFImGw8+i2Xs9X80P0SwRCDoMtX0iUTjGwqjjHfkC2TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+BSqGKt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 701BEC4AF08;
	Wed, 17 Apr 2024 12:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713355228;
	bh=HzGMgnDrZvUIv1uGxXoX3B+eBoUnhMaKa3oceiR5HQE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K+BSqGKtp5BuQMD3coF/l/t2MYkSvFI/bGA5T3tr0ezNZOrhTHH/XIxIRQQTvCHlW
	 8lqy1GOEaOeNCbIGba0jbGhi7BDD+Unc6OV+YFsHIhnkyZ8vYOrogDLek3BYtAnQT1
	 hFxhOVCqPrcKwPqNoDH5RalNG0vVa24y239faMVVqvV3L4WVg1KoTQmcZkoH93Cgd9
	 24ArNZ6KTiR1QcAqyqDLLChcRwA5PLO7eD5npK1CAViTxAWVTxmnhltnMpbLaSUZIo
	 6Q9scowyCYZCD7mrCraTwOVK4x6GF7/RTd7glSWgtvxlVK60koESWH2GKeNN6yx5DK
	 EPMb3pi1Mxikw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 647B2C54BB3;
	Wed, 17 Apr 2024 12:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: accept bare FIN packets under memory pressure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171335522840.25671.6144928889217490556.git-patchwork-notify@kernel.org>
Date: Wed, 17 Apr 2024 12:00:28 +0000
References: <20240416095054.703956-1-edumazet@google.com>
In-Reply-To: <20240416095054.703956-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, aoates@google.com,
 ncardwell@google.com, cpaasch@apple.com, vidhi_goel@apple.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 16 Apr 2024 09:50:54 +0000 you wrote:
> Andrew Oates reported that some macOS hosts could repeatedly
> send FIN packets even if the remote peer drops them and
> send back DUP ACK RWIN 0 packets.
> 
> <quoting Andrew>
> 
>  20:27:16.968254 gif0  In  IP macos > victim: Flags [SEW], seq 1950399762, win 65535, options [mss 1460,nop,wscale 6,nop,nop,TS val 501897188 ecr 0,sackOK,eol], length 0
>  20:27:16.968339 gif0  Out IP victim > macos: Flags [S.E], seq 2995489058, ack 1950399763, win 1448, options [mss 1460,sackOK,TS val 3829877593 ecr 501897188,nop,wscale 0], length 0
>  20:27:16.968833 gif0  In  IP macos > victim: Flags [.], ack 1, win 2058, options [nop,nop,TS val 501897188 ecr 3829877593], length 0
>  20:27:16.968885 gif0  In  IP macos > victim: Flags [P.], seq 1:1449, ack 1, win 2058, options [nop,nop,TS val 501897188 ecr 3829877593], length 1448
>  20:27:16.968896 gif0  Out IP victim > macos: Flags [.], ack 1449, win 0, options [nop,nop,TS val 3829877593 ecr 501897188], length 0
>  20:27:19.454593 gif0  In  IP macos > victim: Flags [F.], seq 1449, ack 1, win 2058, options [nop,nop,TS val 501899674 ecr 3829877593], length 0
>  20:27:19.454675 gif0  Out IP victim > macos: Flags [.], ack 1449, win 0, options [nop,nop,TS val 3829880079 ecr 501899674], length 0
>  20:27:19.455116 gif0  In  IP macos > victim: Flags [F.], seq 1449, ack 1, win 2058, options [nop,nop,TS val 501899674 ecr 3829880079], length 0
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: accept bare FIN packets under memory pressure
    https://git.kernel.org/netdev/net-next/c/2bd99aef1b19

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



