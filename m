Return-Path: <netdev+bounces-242273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4C6C8E3C4
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 13:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 169B934CC9B
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 12:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC9232F768;
	Thu, 27 Nov 2025 12:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UROH+dL1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E8A32E156
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 12:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764246046; cv=none; b=KD4Mk0cgJi6wv9BCqVjY5CwLYfq3JtIHWqwPwCoLCgxIR86sywT6KMgJowmTtTnuSY5UIDScmZ2KRAbOyu3o3mOAX88aXEj0JiQNoVY9cz8RkZnko62j/PiK7K4eQkTWfws5smht7+VLu2hOw1iJCZeAde2Xf5hPbQTGkjzUhek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764246046; c=relaxed/simple;
	bh=3ERbXbzNJtuwcEyji1irl/PUVl+PwRw7QXzK6uwGFo0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tz77WuzI0FEO1pc3ypyHH524An49M7Etczhk06gk4h+WWy8xYtc88w6O7Pv0zTMctKkWSuWslA5AwKAMU/onK7R3IdHv98nLuq9RLPGHnNOnRn9HOaqJ1h07KY6jav9Ldkcbw5AWGUaR3Edx6v70rDF+9FHSnDiFySrCcZDSjPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UROH+dL1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0048C4CEF8;
	Thu, 27 Nov 2025 12:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764246045;
	bh=3ERbXbzNJtuwcEyji1irl/PUVl+PwRw7QXzK6uwGFo0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UROH+dL1BT98VjAR40MCm23j6PODqjZ5JQ4KW8sKHwkhGPxeC2UjF94/ujC7CVjz3
	 YqnOoxWUU7JcLbcWNyZu6+R4UQ6DzYH5ERyntC9Iu1bUOD7R/HysBIP+h29wC2/4uU
	 fo2DzACTvAwp6rfhYmH/zeAWaV/ibQV68KZrmECP21bQ7m/MtjOdHZ59PuH106OcIx
	 mu/0e9HOHXPyXlkTwp614n8EQchIAarud8LGPIGw3+yS35WtuctbHw/YoUGoIWm/t3
	 IDPjJbJM5ZVt/VL9ZtpQbe1MJaLZZJMaNEeqlAaHl4S5RoxlqP43FecGwoYLE9/rNA
	 dxctHziIp2bXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E0D380CFEF;
	Thu, 27 Nov 2025 12:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] mptcp: Initialise rcv_mss before calling
 tcp_send_active_reset() in mptcp_do_fastclose().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176424600726.2553841.2265045087455449510.git-patchwork-notify@kernel.org>
Date: Thu, 27 Nov 2025 12:20:07 +0000
References: <20251125195331.309558-1-kuniyu@google.com>
In-Reply-To: <20251125195331.309558-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: matttbe@kernel.org, martineau@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, geliang@kernel.org,
 horms@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
 syzbot+3a92d359bc2ec6255a33@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 25 Nov 2025 19:53:29 +0000 you wrote:
> syzbot reported divide-by-zero in __tcp_select_window() by
> MPTCP socket. [0]
> 
> We had a similar issue for the bare TCP and fixed in commit
> 499350a5a6e7 ("tcp: initialize rcv_mss to TCP_MIN_MSS instead
> of 0").
> 
> [...]

Here is the summary with links:
  - [v1,net-next] mptcp: Initialise rcv_mss before calling tcp_send_active_reset() in mptcp_do_fastclose().
    https://git.kernel.org/netdev/net/c/f07f4ea53e22

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



