Return-Path: <netdev+bounces-106718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6A3917572
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 03:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E03F5B22545
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 01:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4BBBA47;
	Wed, 26 Jun 2024 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlpRFNEG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF60028FA
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 01:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719364229; cv=none; b=OwlJ6xH5VCtRveSdk5bGryp/Zn/XFGfIN4HyHzSEfVPR9PRzuHEcvxcjIoHbPIM0AQnmAuEPTAEikk+UhgzowbY6gp07sdt3sujhoknCaluZFxwlV6OYAThigoXQ+VHbtAHeuCw3/pH5D9mPTMQhrrFJttEoxfY4l9KLmV6e9tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719364229; c=relaxed/simple;
	bh=JtIB4IEJ1DgPC1v0K6bMMZTH898m6T9woqIMzroPbXI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O+Qo0HLvyFXqEPPvmL/lny7FhyK7ao5WdloKxu2g2b+VF54JKbPnVXSMFETELIA6yRxJ/CRTosRGP8eHHP5psJZr2bXx0hBoIj2NM6Dp8eKbhPUsiCnQkRqMTUvKmV+0sveAKjxTmxrwBO9AMJeegevJfFluZXX1mx/rw4HuSmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlpRFNEG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73F78C4AF07;
	Wed, 26 Jun 2024 01:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719364228;
	bh=JtIB4IEJ1DgPC1v0K6bMMZTH898m6T9woqIMzroPbXI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nlpRFNEGWZXudZnus+0iteDRL300M7ZZH0ym1Wp4gIABgKBH1OZlFod4uq0Kl+kFX
	 7h9hoiDOtIalw9zDG2UXvgD72hKdXOjFaPSnUggh/UpRtMMuuDNZzagoGC1pE7ZS9w
	 r9prE/FEMiNMh2wBICBH3bbgq0Z8D/AXRRJatlutC3nL+NuQOShc6SSnQMWlx+yspu
	 nbqV/Xjhn3Qal6Jf5EQ8wU+bTzUem2sFCodWsAbBCbo+Zo87CZcYVbzwTs7ndnsLMB
	 lAfrcNAPudG5LVg7A+2OW8iEHdK/6EN7+6IjiHjsF/Jm8m26sGX8rHicIzeA7b/SCQ
	 bqFCmbfDMoc1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 65220DE8DF3;
	Wed, 26 Jun 2024 01:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: fix tcp_rcv_fastopen_synack() to enter TCP_CA_Loss
 for failed TFO
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171936422841.4196.14500455106305455588.git-patchwork-notify@kernel.org>
Date: Wed, 26 Jun 2024 01:10:28 +0000
References: <20240624144323.2371403-1-ncardwell.sw@gmail.com>
In-Reply-To: <20240624144323.2371403-1-ncardwell.sw@gmail.com>
To: Neal Cardwell <ncardwell.sw@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 netdev@vger.kernel.org, ncardwell@google.com, ycheng@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Jun 2024 14:43:23 +0000 you wrote:
> From: Neal Cardwell <ncardwell@google.com>
> 
> Testing determined that the recent commit 9e046bb111f1 ("tcp: clear
> tp->retrans_stamp in tcp_rcv_fastopen_synack()") has a race, and does
> not always ensure retrans_stamp is 0 after a TFO payload retransmit.
> 
> If transmit completion for the SYN+data skb happens after the client
> TCP stack receives the SYNACK (which sometimes happens), then
> retrans_stamp can erroneously remain non-zero for the lifetime of the
> connection, causing a premature ETIMEDOUT later.
> 
> [...]

Here is the summary with links:
  - [net] tcp: fix tcp_rcv_fastopen_synack() to enter TCP_CA_Loss for failed TFO
    https://git.kernel.org/netdev/net/c/5dfe9d273932

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



