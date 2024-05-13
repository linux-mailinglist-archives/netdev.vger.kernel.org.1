Return-Path: <netdev+bounces-96176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 216928C495B
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 00:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C149A284FF0
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 22:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3725784A30;
	Mon, 13 May 2024 22:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0GvG+v6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132EB39FD8
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 22:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715637631; cv=none; b=o8YTmIEW9dfOetRZL3wu9801bnEZXMoqMKTpS19yqP0hetdBIKlCbAKl6/OYeFEzd079SmQkhV6SrvXSbYD6NboNPCmRwRLjg90QySKkAWK+xPLn+d8047FXnxbqV7SIctr8izUlKf4fvAyUZ7qzAlkXNGAgeaJLTaYDHA4SPNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715637631; c=relaxed/simple;
	bh=Kz1qsD2SYM2dwaZSzsVFY6VVYDjAg23PbOCYpG4p2u8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Wpnw0F1mQ+AYmpTIPuouc4SZxVWa7HIReQy4TNpj0eW3tFNRG931yuRzMXEz4rcuQs5WXDeHoYFo8sQyQu52RE0hw2Rxp823kyMguuCJVeoNfFynlvi8ygFryJcvdad2UqWp6lfFD7RlEYOnSNewLRVoYLUG/9fMKrtkfB2iW4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0GvG+v6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A513C32781;
	Mon, 13 May 2024 22:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715637630;
	bh=Kz1qsD2SYM2dwaZSzsVFY6VVYDjAg23PbOCYpG4p2u8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W0GvG+v6s1YX0dotGjDkALgYchO3YjdSxnzYUZ28ravJV1PoIoqGo4Eq8Ni8fvrcL
	 k2fcp7BqUxLc7/RFtkvfU9P1sjgYzPrOJ5KVolTtNeQ73hXOvXyXxxGjVpG03ieBFj
	 w7il2Pdax4FOUn+tAuLnJm2aAdqNOB6j1ZWtpKInn2nD+ZcdkHypfUXKak34VI6aWK
	 K5LgW5H7/RNxi/ikSZXmWXR4skpu41aiuirH/ymIvpynJhH4hc1DEuerww0RfTW+N3
	 MrKfdPlizuvSzTE6Lml7MeKK17Q1pSc9ApDqcw07Fg+bOaCOZS07D4B4QXejG1iU8W
	 xOs342amt5fbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8235FC433E9;
	Mon, 13 May 2024 22:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] inet: fix inet_fill_ifaddr() flags truncation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171563763052.31066.17219166518506619161.git-patchwork-notify@kernel.org>
Date: Mon, 13 May 2024 22:00:30 +0000
References: <20240510072932.2678952-1-edumazet@google.com>
In-Reply-To: <20240510072932.2678952-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 watanabe.yu@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 10 May 2024 07:29:32 +0000 you wrote:
> I missed that (struct ifaddrmsg)->ifa_flags was only 8bits,
> while (struct in_ifaddr)->ifa_flags is 32bits.
> 
> Use a temporary 32bit variable as I did in set_ifa_lifetime()
> and check_lifetime().
> 
> Fixes: 3ddc2231c810 ("inet: annotate data-races around ifa->ifa_flags")
> Reported-by: Yu Watanabe <watanabe.yu@gmail.com>
> Dianosed-by: Yu Watanabe <watanabe.yu@gmail.com>
> Closes: https://github.com/systemd/systemd/pull/32666#issuecomment-2103977928
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net] inet: fix inet_fill_ifaddr() flags truncation
    https://git.kernel.org/netdev/net/c/1af7f88af269

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



