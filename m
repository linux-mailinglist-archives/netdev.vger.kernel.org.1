Return-Path: <netdev+bounces-216117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D959B3219F
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 19:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DA64B24221
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 17:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890D12877FE;
	Fri, 22 Aug 2025 17:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMREzobe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1751FAC4B
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 17:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755884399; cv=none; b=AinHA7hyuyH+EkwFMCH/Ku8kJv86qoLXSbFEn5BP5VTUpK7G07leq4oA2lpQHyLixmxcmktmR9PtWKPYl8ib5S1/sYzXvlKDvLiRoGMDVbNZTFH9DPzPtnVgyaDtxT3LhDvo9R/wpEbmRFjr6vtui1WSI++NvAF8iD5x2DdvQ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755884399; c=relaxed/simple;
	bh=TWlaZsRXuvdtWRlIB2ZUnFNfxFjeC72nBRgP12SBZ84=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZpqCjG3lM8ITRtl4E1laABZXmIH3WS8E158+9U9A8AB0BhL6mhxVaXZhwMDm23DNBr1zCeOtodLRbdIXejQlJQStUoxUwUaiIAh0/5lLgPW+WDkan8sPuNKrPO908vqaT6v8q2P7q1XBOKae1x1Fphwicl+l7azzze7leXUDFN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMREzobe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F62C4CEED;
	Fri, 22 Aug 2025 17:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755884397;
	bh=TWlaZsRXuvdtWRlIB2ZUnFNfxFjeC72nBRgP12SBZ84=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lMREzobeHf5XzRYdtfPmN2nJ5B+8TG1e6hItHFCQivpWFA/DdBIV0atXy58v+73tF
	 /BjXNX+Kpb6IB5tOsX46JFfPlLHSQBpTuIN/tpRBgclxscKzAO1c3q7pvdiUBgts3z
	 +UTH7wJBJCMjmA+ox/WoA0WeDg/jRgvdmm1OLJgTiZWdp/D3H6T4e915wvCGeXXX7i
	 unVbZppG9Xn3tTRX0IRQWheg46u0M36qfSqIRZp4TT98Pmc/f+6v92rteM7pqvHNHK
	 k67xzbyjRCvRpGyy6juweGgzKV+DVUC+FNoUJv4gmM5OE8tfYs35RNLW50G97qiL9P
	 sk0GIDzVu5vlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFD6383BF69;
	Fri, 22 Aug 2025 17:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] idpf: do not linearize big TSO packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175588440676.1915556.260278295179768223.git-patchwork-notify@kernel.org>
Date: Fri, 22 Aug 2025 17:40:06 +0000
References: <20250818195934.757936-1-edumazet@google.com>
In-Reply-To: <20250818195934.757936-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com,
 madhu.chittim@intel.com, pavan.kumar.linga@intel.com, joshua.a.hay@intel.com,
 brianvv@google.com, willemb@google.com, andrew+netdev@lunn.ch

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 18 Aug 2025 19:59:34 +0000 you wrote:
> idpf has a limit on number of scatter-gather frags
> that can be used per segment.
> 
> Currently, idpf_tx_start() checks if the limit is hit
> and forces a linearization of the whole packet.
> 
> This requires high order allocations that can fail
> under memory pressure. A full size BIG-TCP packet
> would require order-7 alocation on x86_64 :/
> 
> [...]

Here is the summary with links:
  - [net-next] idpf: do not linearize big TSO packets
    https://git.kernel.org/netdev/net-next/c/02614eee26fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



