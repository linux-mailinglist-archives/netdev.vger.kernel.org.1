Return-Path: <netdev+bounces-205031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36666AFCE99
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 17:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D67A1425D84
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 15:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7DE2E0B4B;
	Tue,  8 Jul 2025 15:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PK3WpzAw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B042B2E093E;
	Tue,  8 Jul 2025 15:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751987388; cv=none; b=SSExWuM9bTALuPfuOvuBwn5kYSy6eFdVzxo9SygQtCq1hPMFjOjZWqKdQ1Yw1GN0EprXvEcxT6nX36fteCgLrp9o4diIIjIwHKcjmJDeRsrdq1x5iESn2xwE/8uYdeW4GdZMLXg03Tv3uGoJEheE4OQPLtpUDpkPrDhoCjOTLog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751987388; c=relaxed/simple;
	bh=m8j9BgC+C683QcWhHpBX4bU5kkyY9xFVDvRjCOR5Lc8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NC63e2LtO41db+rnJRZ34aTI6FJhzZcbu9CdY2vib20IaiGEV/R0oRLMWbNEuEmDjBW24w01VbiN/wiDx4G3MN5yGYIuFMLYGTTWVVwM3WYo0PEBfc/48SLLp6IB2usqZ8TBTi83A+MIQmjDDgGKub9QX+yv6Gx6MB4UEOGCYus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PK3WpzAw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54213C4CEEF;
	Tue,  8 Jul 2025 15:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751987388;
	bh=m8j9BgC+C683QcWhHpBX4bU5kkyY9xFVDvRjCOR5Lc8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PK3WpzAwrnRqcEQcygXjS8tZX6H/H132xlWnZ7NlMhYbci+4L8MXtkFo8Ny3nzbZ4
	 8P5khn3ztmh6lzDBa4bBygBwvhHvhFF/IjPUdm0SK5ZHeWiETNzcis5hBD8uapz9ec
	 a+fZjJnaifXs8AOyqNxDU174JvTZYCB91pHdaZHGmVw7xB8VgaRo6WFxCTMyqK3G+T
	 Tm+TZr7G42OBFxUemRixpDO4qgrSpbVmNTJ1DDctKR6vDIaqNAYVLogOfHblZwxz3i
	 le5ylARfhMK7jCt8jJdcdcDH0cue/yhSHtfc9POOdkvEWYYPT8TMdu/Nn9vtB20Id4
	 veWieW7tZ5zSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D83380DBEE;
	Tue,  8 Jul 2025 15:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] tcp: Correct signedness in skb remaining
 space
 calculation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175198741125.4099273.6939974180776177373.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 15:10:11 +0000
References: <20250707054112.101081-1-jiayuan.chen@linux.dev>
In-Reply-To: <20250707054112.101081-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, mrpre@163.com,
 syzbot+de6565462ab540f50e47@syzkaller.appspotmail.com, edumazet@google.com,
 ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
 dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dhowells@redhat.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Jul 2025 13:41:11 +0800 you wrote:
> Syzkaller reported a bug [1] where sk->sk_forward_alloc can overflow.
> 
> When we send data, if an skb exists at the tail of the write queue, the
> kernel will attempt to append the new data to that skb. However, the code
> that checks for available space in the skb is flawed:
> '''
> copy = size_goal - skb->len
> '''
> 
> [...]

Here is the summary with links:
  - [net-next,v4] tcp: Correct signedness in skb remaining space calculation
    https://git.kernel.org/netdev/net/c/d3a5f2871adc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



