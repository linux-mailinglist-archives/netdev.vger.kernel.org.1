Return-Path: <netdev+bounces-209712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CACB3B1081C
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 12:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0779416ACD5
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 10:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC846266B59;
	Thu, 24 Jul 2025 10:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IO+DgEoQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E95257AC1
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 10:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753354203; cv=none; b=ivY5N2hEDD+jRHtg6alG0NbeFBPn8LaRBtkPGzQnjdz3ZumT0vEurTlo1xwktLwsAXbAPDIArI1ZD7gUWlRh47/LmHnXhb9sDFYcTmOiqIqMLiaBYl+My3Yy1Egvuh5P+BF8Xf8Dm+qnBp/p2rNWtXK3GlbLaZs1bJgYIPnEvrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753354203; c=relaxed/simple;
	bh=s9eMKrCYYs28pAA08oTpyw2I+8fSUO3E3Pd3Y61yE9A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YHedcEFDeRIFU6U8KsbjqdYYbAlGXC8S4bSUH2cOgk6FQi59+Xw+to/NQZ6Ic+YfY6bYBionrfqaTNOq0eRuOUQwsYbZeA4KZYhzjA6TjIv0Bt3wnjcLxA5jvxWOHgFIUv5IgdyedK8NPG4nWLf6i1EL7iQGJZDMOAkJO5MuTjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IO+DgEoQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430B2C4CEED;
	Thu, 24 Jul 2025 10:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753354203;
	bh=s9eMKrCYYs28pAA08oTpyw2I+8fSUO3E3Pd3Y61yE9A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IO+DgEoQCxz6MNsckIY2+hAAGqMoncNw54uh+oCgnAaoN9zo+qGcF26H7pGBI/ZTF
	 eYvUoNRS5REiI8kRnRiWh5OmML7AhwONYpp71c+Cyt834TWMnHgxqM1O4JnGWW2hGj
	 leLMa9Y+HD9/8InHF4jTX4uK5AmBpucPZZXNFYq3/qPgufkoxYqdKChM6f3f67AzPV
	 8npjrFUATIuY0BOYWMmjeMG2AyEU1hRZk+tifQzwagdcEIzUiBEwBr6yaD52wMDcK4
	 vurYHXnNmItDx6Um8W8/5tWs3SaoKcsKcOSS/lFBwjtj365UtXfWIMBu3W24l5d1DQ
	 T/esEBcJgJtPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7105A383BF4E;
	Thu, 24 Jul 2025 10:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/8] xfrm: state: initialize state_ptrs earlier in
 xfrm_state_find
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175335422092.2346656.3527153380129416427.git-patchwork-notify@kernel.org>
Date: Thu, 24 Jul 2025 10:50:20 +0000
References: <20250723075417.3432644-2-steffen.klassert@secunet.com>
In-Reply-To: <20250723075417.3432644-2-steffen.klassert@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Steffen Klassert <steffen.klassert@secunet.com>:

On Wed, 23 Jul 2025 09:53:53 +0200 you wrote:
> From: Sabrina Dubroca <sd@queasysnail.net>
> 
> In case of preemption, xfrm_state_look_at will find a different
> pcpu_id and look up states for that other CPU. If we matched a state
> for CPU2 in the state_cache while the lookup started on CPU1, we will
> jump to "found", but the "best" state that we got will be ignored and
> we will enter the "acquire" block. This block uses state_ptrs, which
> isn't initialized at this point.
> 
> [...]

Here is the summary with links:
  - [1/8] xfrm: state: initialize state_ptrs earlier in xfrm_state_find
    https://git.kernel.org/netdev/net/c/94d077c33173
  - [2/8] xfrm: state: use a consistent pcpu_id in xfrm_state_find
    https://git.kernel.org/netdev/net/c/7eb11c0ab707
  - [3/8] xfrm: always initialize offload path
    https://git.kernel.org/netdev/net/c/c0f21029f123
  - [4/8] xfrm: Set transport header to fix UDP GRO handling
    https://git.kernel.org/netdev/net/c/3ac9e29211fa
  - [5/8] xfrm: ipcomp: adjust transport header after decompressing
    https://git.kernel.org/netdev/net/c/2ca58d87ebae
  - [6/8] xfrm: interface: fix use-after-free after changing collect_md xfrm interface
    https://git.kernel.org/netdev/net/c/a90b2a1aaacb
  - [7/8] xfrm: delete x->tunnel as we delete x
    https://git.kernel.org/netdev/net/c/b441cf3f8c4b
  - [8/8] Revert "xfrm: destroy xfrm_state synchronously on net exit path"
    https://git.kernel.org/netdev/net/c/2a198bbec691

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



