Return-Path: <netdev+bounces-68954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A257848F25
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 17:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47C4528328B
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 16:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F193422626;
	Sun,  4 Feb 2024 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlBFcq4x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE07B22EE3
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707063026; cv=none; b=OH4zgi4KePaGKT01u3iRsPfir9ArmEIGtnnT+sEZMv+fMZI56gn3Bu9AQjzpj/xLAvA5XzAlPgHLtYcxW4ABn6SI58a9mQOj/2QgcJHA1s1GCl30vattaR372dVGnc4ODKXmNw+YyWCMV5Mhg2oomICatYegAdtpL8m6thlozTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707063026; c=relaxed/simple;
	bh=7E/0hQfZ/s/cur+sKQ0CmdZ82oK7jTp8S72oO+v5btM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nDTJax/KYseh8magBkPdon1zRsKBknb19lsXXBzYoH5z+L5E54HHqJYynv1Nm02JAuBSaktT9xtxm8lgHTN6axxvgUnZc3ubW9CRlsJoY5RGHNrNvXl8rhdJu16cfAc25SErf6A8RYNMyLm1m4GRKHeJodh+2IDl6W/xTONMf3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlBFcq4x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 333E0C43394;
	Sun,  4 Feb 2024 16:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707063026;
	bh=7E/0hQfZ/s/cur+sKQ0CmdZ82oK7jTp8S72oO+v5btM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qlBFcq4xty/E5u69eMmohFhyg/BnxUlrb2n8mzhelUagA5Dr4Hn6gaOQqvwgS0AiX
	 XJp3f8ia2A9I+BYTPJyi8hLpx8HSB0fqXd5U5oMMCZGFpRKL/NrtW/6NOXDCsE1pQR
	 EKBCBW7ZR674AAH2O/LN6DC6tUFPJHZ2ULGXbvAxvmxtBS7U5ZwiiwNHhzztcMZJIS
	 hDz9vSElDNyDWs7uYbY3ntSJJp7n+ZVno6MHUm/U0AjA5UNeYVsskIwgbEgxY7qoGX
	 18y6WhR4BcoTQ1qQkSfHQG10LVyTAiiyhw6Ktiw65L3/XqGger8awDe9jgtIXQDjqb
	 etzDl+dy8n0NA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 138C1E2F2F2;
	Sun,  4 Feb 2024 16:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] inet: read sk->sk_family once in inet_recv_error()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170706302607.24202.14702397263062920964.git-patchwork-notify@kernel.org>
Date: Sun, 04 Feb 2024 16:10:26 +0000
References: <20240202095404.183274-1-edumazet@google.com>
In-Reply-To: <20240202095404.183274-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, willemb@google.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  2 Feb 2024 09:54:04 +0000 you wrote:
> inet_recv_error() is called without holding the socket lock.
> 
> IPv6 socket could mutate to IPv4 with IPV6_ADDRFORM
> socket option and trigger a KCSAN warning.
> 
> Fixes: f4713a3dfad0 ("net-timestamp: make tcp_recvmsg call ipv6_recv_error for AF_INET6 socks")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Willem de Bruijn <willemb@google.com>
> 
> [...]

Here is the summary with links:
  - [net] inet: read sk->sk_family once in inet_recv_error()
    https://git.kernel.org/netdev/net/c/eef00a82c568

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



