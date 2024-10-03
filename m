Return-Path: <netdev+bounces-131824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC2498FA7A
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 01:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D358A1C2209D
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 23:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB78B1CFED8;
	Thu,  3 Oct 2024 23:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iED0x/0P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F4B1CFEC2
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 23:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727998226; cv=none; b=KbO/8OonPlmALMR8STzquH/16n6iXvve95Ymnor0JNncnxd+aNNqEyprWgjdk0TKzsr4uuvUq4yA1wOvEuigt7Xmg6LYzPOFe4Z5pOcna4jJ99UTr3l7EwikkIutKm1oPc+tp4sVEwulWqda0limWpbB9G0PFxParekPCT+Thv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727998226; c=relaxed/simple;
	bh=lER9vlbGPiVHRuD5h9WqqQGND+Lw0rPtBRuqEsn6BaU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Siw6QJ1GXZ7EKqcCA/tvLROAYg1cecj8Wvx2AKyUUYpU5A6jUsC7z79cEg/DJg/GLTvuoQlwImrHQ11jATX3NZS4G06q+cCFlcpYuhxuPMMVbG55M5Pc8NxwaZw6VCNvpjFn13BGi7a/fjjefSaFhQapS+/d4SGwEAHUg7cpwIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iED0x/0P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF0AC4CEC5;
	Thu,  3 Oct 2024 23:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727998226;
	bh=lER9vlbGPiVHRuD5h9WqqQGND+Lw0rPtBRuqEsn6BaU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iED0x/0PIkmgo6JNBVFPlr1plBqbXXRir6Ohyct59triueDysHkaUc2BlucEkxChA
	 /zlqJWkZcSPNSz4KG2VxTPOXiCbVfAlSFVm7XhuE9glbtWJgJvZ8Vma2ZOHfUID2Lc
	 FcUZIOIvT6CEHBqonasdsr8/3C+7Ou5NfiaU4ZLf+TDKv7wGrHm0BWYgorFgPFJQNg
	 i0dPLfbnpYi7QT2+GWyfxmYBde21Of7Zq8IddhY9Q5xf1PDopX3/ErC8f/iV9bZVsB
	 qewUBozAAEhOQvb1rEL0ncQwUsPifwHqxPKvlpa3aREdCj+QjKJq6aVBDzLCQ0CwyN
	 e5pnJhekOfakQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE09B3803263;
	Thu,  3 Oct 2024 23:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] tcp: 3 fixes for retrans_stamp and undo logic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172799822951.2026907.10544992195133480284.git-patchwork-notify@kernel.org>
Date: Thu, 03 Oct 2024 23:30:29 +0000
References: <20241001200517.2756803-1-ncardwell.sw@gmail.com>
In-Reply-To: <20241001200517.2756803-1-ncardwell.sw@gmail.com>
To: Neal Cardwell <ncardwell.sw@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 netdev@vger.kernel.org, ncardwell@google.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  1 Oct 2024 20:05:14 +0000 you wrote:
> From: Neal Cardwell <ncardwell@google.com>
> 
> Geumhwan Yu <geumhwan.yu@samsung.com> recently reported and diagnosed a
> regression in TCP loss recovery undo logic in the case where a TCP
> connection enters fast recovery, is unable to retransmit anything due to
> TSQ, and then receives an ACK allowing forward progress. The sender should
> be able to undo the spurious loss recovery in this case, but was not doing
> so. The first patch fixes this regression.
> 
> [...]

Here is the summary with links:
  - [net,1/3] tcp: fix to allow timestamp undo if no retransmits were sent
    https://git.kernel.org/netdev/net/c/e37ab7373696
  - [net,2/3] tcp: fix tcp_enter_recovery() to zero retrans_stamp when it's safe
    https://git.kernel.org/netdev/net/c/b41b4cbd9655
  - [net,3/3] tcp: fix TFO SYN_RECV to not zero retrans_stamp with retransmits out
    https://git.kernel.org/netdev/net/c/27c80efcc204

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



