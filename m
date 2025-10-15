Return-Path: <netdev+bounces-229660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E39BDF827
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 18:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EABBB19C6D4A
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 16:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AAD2BCF4C;
	Wed, 15 Oct 2025 16:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYDcBUhn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D493349659
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 16:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544023; cv=none; b=fng7X7fWzNHWVmOCqXj42OIQWIhpm9U64B0H/HC3VUq22aJst64UDDd2ubRAabffX1OyMLLrUHAZDNB0nqEJZfLKDoIM5MWWdcQPQmrsxokp1tMQy2b66E8hPE9ZOkLSzud2bqOqKl1d6Llf50+AW7iLyIpiJ2gwCHgrb2if918=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544023; c=relaxed/simple;
	bh=IP/nIODl1dm2/cBo46IninpWQtGbLOpifqhVPqgPHhQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=llE757QSv0rDUysJui+hT1Cb4SHcKXd9Ah1EIBkY44xeXZmZt4B1QO8lDaevSOPFngmrJuMbDHkluxDC0yAZrKHSZdXS0B+XDESiyav2aDdaEaAVx2kcINC5tkm6rdjPhgr+gULOrPjzOPPFQO6upZNn2sAez76+facB11u1U68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYDcBUhn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD40C4CEFB;
	Wed, 15 Oct 2025 16:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760544023;
	bh=IP/nIODl1dm2/cBo46IninpWQtGbLOpifqhVPqgPHhQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EYDcBUhn1wT9tCXs9UlnzJuJeYxNEHcNtwwLx7y3NqPl26aOhPZMbpgoAdYxzPVCx
	 X2IFyhc5Hb1PBL1E3cE9SoFNssJnJQc5BBzjdKZ3OZMKVHXxA0L6OD89vsF+vNafjv
	 NTt43Ltb3Vebpbv1E/ML/OFbdHutjclJ1vgKSeBiHEUtso5rebcJDeTpPAAO9upaD6
	 bTjeQkN1UVU38cL8EuXSK3RWBgUvbX3s1GHBWLk7XUywiri+NIDM36JyBihWK5TWJb
	 7ZCiwXuyY5WoWR8zrPzb/6oclTVeKudPMoUg4Y/PILo1CwYhmtrOYUUmalmYp+3xnS
	 tWxHhHZf20wiQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE183380CFFF;
	Wed, 15 Oct 2025 16:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: better handle TCP_TX_DELAY on established
 flows
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176054400824.936044.998951692022220635.git-patchwork-notify@kernel.org>
Date: Wed, 15 Oct 2025 16:00:08 +0000
References: <20251013145926.833198-1-edumazet@google.com>
In-Reply-To: <20251013145926.833198-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, willemb@google.com, kuniyu@google.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Oct 2025 14:59:26 +0000 you wrote:
> Some applications uses TCP_TX_DELAY socket option after TCP flow
> is established.
> 
> Some metrics need to be updated, otherwise TCP might take time to
> adapt to the new (emulated) RTT.
> 
> This patch adjusts tp->srtt_us, tp->rtt_min, icsk_rto
> and sk->sk_pacing_rate.
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: better handle TCP_TX_DELAY on established flows
    https://git.kernel.org/netdev/net-next/c/1c51450f1aff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



