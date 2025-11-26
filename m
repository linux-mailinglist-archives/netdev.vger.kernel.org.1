Return-Path: <netdev+bounces-241760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8079AC8800E
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 05:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 725E14E18DF
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 04:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FFA307AD3;
	Wed, 26 Nov 2025 04:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHg0+Nft"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322FA20CCDC
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 04:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764129662; cv=none; b=suO7oUKugNhcHY8IWHlc5s+uUlcK086uKHGzxjUyPa9yCqM1F0fCzmq+JkX9pQklEyWS8CqopQuP894rECDc/vJBpJwW1kkr7bYOz7kmTug/rSzrHvLIF6lLLzqxeWNWEQAPcHeuymbZ6ZLGBlhGxipUIY8yg/3j0HuB9DYOP+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764129662; c=relaxed/simple;
	bh=O8zqvhEL1LDVp4SC4WIEIJGz4toQkgI28PYyf6Rw5ww=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ub3LyRLcYiiOVrcSqpTWy8QRh1pjjiMuZTrV0xVfTk01TXUHqx/RSPjED/bi/7vnhiYHtVQqpYyVxbggAAqCZYIdH6O06+DByVowpu0H/VUcKwx+NblUYFtivTXWHRrEF6YtlBUrEiGCO+b8W6irlm6p/KaqX20l2FVjvvQiOME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHg0+Nft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BAF9C113D0;
	Wed, 26 Nov 2025 04:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764129660;
	bh=O8zqvhEL1LDVp4SC4WIEIJGz4toQkgI28PYyf6Rw5ww=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CHg0+Nftres3uuuhpnsunAAnbuQdVu6tpWRY4Q7n/HImiD1elAQ6I0Ho/8RHL0spQ
	 XLdw8/2Iqy3BlpV+5oCpaU1/4naQIF6mNrs/bK1WPx1UMO9qgvrkayCG1F4nKY5hUw
	 KR66JwKlJfi2KmxIlOptdtFelnJ3Pm4hgBFoyUY8HOmoj6UhrLrFtPJGUyvhpmEmu5
	 nJzcdk5pMmtxAWKxCReBzT4OuUklsc6aN6VoCrGsdeXGVmAbpItoUXw5KDeCcqVbqm
	 OGn/DlTN2q6ek6LYvv6ktBAIifEPANqamqDw1NOmbW9Q34p9dmiiUFPWNHbj+A6fXO
	 0lKptlDiDlEYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADBF380AA73;
	Wed, 26 Nov 2025 04:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] tcp: provide better locality for retransmit
 timer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176412962248.1513924.7172777480710377145.git-patchwork-notify@kernel.org>
Date: Wed, 26 Nov 2025 04:00:22 +0000
References: <20251124175013.1473655-1-edumazet@google.com>
In-Reply-To: <20251124175013.1473655-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, matttbe@kernel.org,
 martineau@kernel.org, geliang@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Nov 2025 17:50:09 +0000 you wrote:
> TCP stack uses three timers per flow, currently spread this way:
> 
> - sk->sk_timer : keepalive timer
> - icsk->icsk_retransmit_timer : retransmit timer
> - icsk->icsk_delack_timer : delayed ack timer
> 
> This series moves the retransmit timer to sk->sk_timer location,
> to increase data locality in TX paths.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] tcp: rename icsk_timeout() to tcp_timeout_expires()
    https://git.kernel.org/netdev/net-next/c/3a6e8fd0bf40
  - [net-next,2/4] net: move sk_dst_pending_confirm and sk_pacing_status to sock_read_tx group
    https://git.kernel.org/netdev/net-next/c/27e8257a8651
  - [net-next,3/4] tcp: introduce icsk->icsk_keepalive_timer
    https://git.kernel.org/netdev/net-next/c/08dfe370239e
  - [net-next,4/4] tcp: remove icsk->icsk_retransmit_timer
    https://git.kernel.org/netdev/net-next/c/9a5e5334adc0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



