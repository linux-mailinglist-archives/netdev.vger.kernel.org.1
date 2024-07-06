Return-Path: <netdev+bounces-109593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A59928FF3
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 03:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 366591C217C2
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 01:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4BE5C99;
	Sat,  6 Jul 2024 01:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrkEm0fE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA050EC0
	for <netdev@vger.kernel.org>; Sat,  6 Jul 2024 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720229430; cv=none; b=jqXTTH1g03GB+qV64gJY1l+NP+i4kjgSOsZOFyokv/lsU/V4yiRUTNTPAvzFvh53W5wrb04WfmYrOX2V4LaSeDphw+tldgy3kfDVmTWKF3OyI4zHgH2aXPgrbSVe+3Vxyrvxz+2RaR2Lc3b/H4sQ8iwYzuBh6elKVIpuwLLEdok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720229430; c=relaxed/simple;
	bh=FGzgXY7WQKji30GWN12qFJHBl8ZVPOLeEYiySBvdkGg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kvh9RznT5zNjfRNPbApfbFUM5xPWTcxQjlhm/bz+9V8uwfpyx95sCxEcv5ZvNzgSAZTlDF3RAYgp8Bd8mot4MpkEVhNtOFAE+2JMqo4J2iGFRCh2jCj0gG0LBz4WTQtWkD5KWFluPEliM4S6AFO1bJb6vXVS3wEBvTRM+VtQz+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrkEm0fE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5BB6FC4AF0A;
	Sat,  6 Jul 2024 01:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720229430;
	bh=FGzgXY7WQKji30GWN12qFJHBl8ZVPOLeEYiySBvdkGg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TrkEm0fEBjqs6zzbGAakbHS2GVvdys2e5iHVV7LVPgDyMnGT6Mg2UZVciEXg/FQT7
	 45pOcunv6YsWTbvBXgjp8p1dlTfN//ADvFV+Sjxq9a5zZwBy0CISlLs+gKbkmqTIut
	 NOvon2opTCc0WOCfA20uWfqdDIdtj3XJTAwQiMaZOwxR+9kwEoi8zuF+JarNA/UuBy
	 mgY27pLYRq5JWae+pv2Ch9ppyW3i8LjkoJaC3DmJIp/+E3ZPigKQgKb8e3QVjPidjV
	 WvGbQTLykM6k7Ug1bs2RpTB6kF8gdVdF5/3fgDtm3nK0+Q8hjypJm4jqI7Rr+hwuHg
	 wy7FIXb/tYKKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41F05C43332;
	Sat,  6 Jul 2024 01:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: fix incorrect undo caused by DSACK of TLP retransmit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172022943026.18706.18202616674867302507.git-patchwork-notify@kernel.org>
Date: Sat, 06 Jul 2024 01:30:30 +0000
References: <20240703171246.1739561-1-ncardwell.sw@gmail.com>
In-Reply-To: <20240703171246.1739561-1-ncardwell.sw@gmail.com>
To: Neal Cardwell <ncardwell.sw@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 netdev@vger.kernel.org, ncardwell@google.com, ycheng@google.com,
 yyd@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Jul 2024 13:12:46 -0400 you wrote:
> From: Neal Cardwell <ncardwell@google.com>
> 
> Loss recovery undo_retrans bookkeeping had a long-standing bug where a
> DSACK from a spurious TLP retransmit packet could cause an erroneous
> undo of a fast recovery or RTO recovery that repaired a single
> really-lost packet (in a sequence range outside that of the TLP
> retransmit). Basically, because the loss recovery state machine didn't
> account for the fact that it sent a TLP retransmit, the DSACK for the
> TLP retransmit could erroneously be implicitly be interpreted as
> corresponding to the normal fast recovery or RTO recovery retransmit
> that plugged a real hole, thus resulting in an improper undo.
> 
> [...]

Here is the summary with links:
  - [net] tcp: fix incorrect undo caused by DSACK of TLP retransmit
    https://git.kernel.org/netdev/net/c/0ec986ed7bab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



