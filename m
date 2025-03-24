Return-Path: <netdev+bounces-177152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4E9A6E1A1
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 18:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AEA63BCBC4
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 17:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5A0266F17;
	Mon, 24 Mar 2025 17:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRup2H21"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760D2266F13
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 17:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742838002; cv=none; b=u7iLC6fLbdk7KduPP+Ep5gypvy/aNn0ko5tyVkHZg4YDroTLeVCZDzbfTF8FUJf89N7GOo3hn1Zk4yyQ4tBlMeGcLrqMMzVMEHKFB22GmDmLYrKeKe1nKzTIJTpTwXNB60ddbmZeKc6Sx9xUrlWcR5hFdw7TRH3CzG8U3TFEn94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742838002; c=relaxed/simple;
	bh=L7zHiXorn6aA9p5vOwjnNHiZUQTutSOkrnfclwWeuc8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BGnyauX+gabFeWpwhD/Gh6r5pZewLnLZo79TemrPa7ZQTJdhcNi3helbp3uLdPtzxKHwbYyWCg0KZsZVR0Ym/UkmX1jzXR7NaVOpcNRddyrkXkTuzx8IL134mwxwgNaR9YriDICObxCBmHuZGzf8P2BkGe9aQj89y7SsT7y6ISg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRup2H21; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A87C4CEDD;
	Mon, 24 Mar 2025 17:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742838002;
	bh=L7zHiXorn6aA9p5vOwjnNHiZUQTutSOkrnfclwWeuc8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pRup2H212+dxikKxv+NVRIG2/CQvHfHwV79x0xB4g9AJJ6L5B7Y+xThUguiK1lCAq
	 eMTZDwEvT6bWJzqop+ceFFOJG3PIFSybgc9ayYf8eKHAu+gzeT1JJzJK0st3TCVGqm
	 SyPaoO9Ud6xl5LhhFknLt/DBJ4AAlnRenuYzNjLbZ/nd5VCKSHpMNBNRJjOEdQFgmc
	 cJlWUNSW53wzTEkBURGV4EMM0vVVBcRlBSV9OUrj9OpslcXlgrHBOIQOCwlIsnUlsP
	 RVdMcyam/f4BShvOJtH8wLTYbZrUzmRYY/rY50Mk4cX4FrK224UmZ/591bRUPib/2a
	 +4hJG6VIV6J3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE108380664D;
	Mon, 24 Mar 2025 17:40:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: move icsk_clean_acked to a better location
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174283803826.4111679.7163094076104773870.git-patchwork-notify@kernel.org>
Date: Mon, 24 Mar 2025 17:40:38 +0000
References: <20250317085313.2023214-1-edumazet@google.com>
In-Reply-To: <20250317085313.2023214-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, kuniyu@amazon.com, borisp@nvidia.com,
 john.fastabend@gmail.com, horms@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Mar 2025 08:53:13 +0000 you wrote:
> As a followup of my presentation in Zagreb for netdev 0x19:
> 
> icsk_clean_acked is only used by TCP when/if CONFIG_TLS_DEVICE
> is enabled from tcp_ack().
> 
> Rename it to tcp_clean_acked, move it to tcp_sock structure
> in the tcp_sock_read_rx for better cache locality in TCP
> fast path.
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: move icsk_clean_acked to a better location
    https://git.kernel.org/netdev/net-next/c/1937a0be28c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



