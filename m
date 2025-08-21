Return-Path: <netdev+bounces-215462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A355FB2EB57
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 04:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E9685E4F4F
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 02:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2683429BD81;
	Thu, 21 Aug 2025 02:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SaGlS2+o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E6C27990A
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 02:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755744008; cv=none; b=Qbd7KRTl1pOmRPdXkZHSPcAEEKrlQAo8/AG/Dp5z1kB/DrjQrpKP9zlyPAz/xqAPDX0qjAZ3KXVJBpFLaTKg8UNPs1YuSyFXfn8h7jhYeJIgUVO9fB1wDN886a8QUpgg5bCSgSw84q9Yb65jx48l3KbKT/I1NRVeissLXFPIZx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755744008; c=relaxed/simple;
	bh=sht5IwXPXe9lLDUdVFEK7rEs8VmcLuMc6CFKQZuYHkQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SHnx14dOTLIz6kt5QT0VZmeITltGqR+wuKGnyCRVRC0fkALotOdgLEu+Vk9B1qmCp608hjunwVKoihcj2Kz5usXw0h6Ry48ovzFPhssvrvDmijGNoUQDu1Uq2EjRD+m1t5qFJtJgcxJ1lyY1EUcihS3G9xniGm/TaNVI+j7mIGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SaGlS2+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8D5C4CEE7;
	Thu, 21 Aug 2025 02:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755744007;
	bh=sht5IwXPXe9lLDUdVFEK7rEs8VmcLuMc6CFKQZuYHkQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SaGlS2+of02Z8hKeOIfaEjzwts4hzP1HQ2zQZavtan7zXuabrd3oTlTzfU4hBFzdk
	 6yZHfNwMdcEzhbOThbn1KABW+IxCmR6XCggqzjlulg5ZoDdm/H+8XpHeu5e6zqHL+q
	 h1ERrL2DddfCp6OQiHJ239+NGVa32hxZq77TCHuDcTapveMN1/1T+dyB53d7xCyAMp
	 7DFqkwMnmFjib7YizD/4tAJZs8R7olZOrbiAj0YgAtR8o+AHtmwMOdG7j4bViLsTJr
	 tne+M+MnpBPHtkOwjOIfy4yI7eNp8tV9VRVOHx0M+fFqF47pSCw6hIo4XjdIOnqgKi
	 Q9sv1xDqvUA9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C86383BF4E;
	Thu, 21 Aug 2025 02:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/2] net/sched: Make cake_enqueue return
 NET_XMIT_CN
 when past buffer_limit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175574401699.482952.13902122380397656800.git-patchwork-notify@kernel.org>
Date: Thu, 21 Aug 2025 02:40:16 +0000
References: <20250819033601.579821-1-will@willsroot.io>
In-Reply-To: <20250819033601.579821-1-will@willsroot.io>
To: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, toke@toke.dk, dave.taht@gmail.com,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, pabeni@redhat.com,
 kuba@kernel.org, savy@syst3mfailure.io, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 cake@lists.bufferbloat.net

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 Aug 2025 03:36:28 +0000 you wrote:
> The following setup can trigger a WARNING in htb_activate due to
> the condition: !cl->leaf.q->q.qlen
> 
> tc qdisc del dev lo root
> tc qdisc add dev lo root handle 1: htb default 1
> tc class add dev lo parent 1: classid 1:1 \
>        htb rate 64bit
> tc qdisc add dev lo parent 1:1 handle f: \
>        cake memlimit 1b
> ping -I lo -f -c1 -s64 -W0.001 127.0.0.1
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net/sched: Make cake_enqueue return NET_XMIT_CN when past buffer_limit
    https://git.kernel.org/netdev/net/c/15de71d06a40
  - [net,v2,2/2] net/sched: Remove unnecessary WARNING condition for empty child qdisc in htb_activate
    https://git.kernel.org/netdev/net/c/2c2192e5f9c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



