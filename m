Return-Path: <netdev+bounces-159765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0689CA16C5F
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 13:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40CAB164167
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 12:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2401E0B99;
	Mon, 20 Jan 2025 12:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/bGNuJs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ED71E0B66
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 12:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737376208; cv=none; b=kCSoYIPfngBz8yHwIxMINLcwiAPWNNJzE75UkYPmsoryAlLyxaPhUtjwQPJlFhbjEXHpT+KaSnYJq1DHWIgDHy1lo1OIbmX4X63X1fluQ7Ehd1kOC+zBGoA4SHHS/hYRYSFe1ZbntgWDpeVszfGC8gPOna4AyUbpgO8mTXtXGb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737376208; c=relaxed/simple;
	bh=M/RKs4UvLQZhtlrl1aaCPvsFio4ap7X8nShuql5o3ig=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hMrsJmUJ1UgotjGpT+Ltc0BFtq/4gwnATA9U330KPBsw8UM/sCR4LMCTfij8geLmhA0g150K4kUYEBqsG6q7WCUEqcrfBD5w3EaM5KvOOm++QtI5zSZHdRcj0/hLuZBQAmdzrVHTFZpyjhNYmvx5E0R9QSdr/K+S0ZjcLh3YK14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/bGNuJs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA3EC4CEDD;
	Mon, 20 Jan 2025 12:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737376208;
	bh=M/RKs4UvLQZhtlrl1aaCPvsFio4ap7X8nShuql5o3ig=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S/bGNuJsdXbPQgS4KRGSqANHQAo+sggipqgta/QM7cNgIUAj28qaWJVG01AgnmfeJ
	 2bibOhHB7fGrKZSHxzDZ739+BWjq3oVk7hy9rPslEZcaQplmdwyGNWfcDz0Fr1WYQC
	 6RAzIW/WVmsLcx2fQ8biAnRqXYTWd9TC+YSPQe4tPN00xk4/IrPhbtOHPQLs8m9l+m
	 Ed+GYUn34z1Nec7K0QYt2/I+Tq/SAL829ULXKT3GRH+hO2X0GM21VIlUlBuAQKXOXG
	 o+SIPyrJU+qbsLVdwjiewjM0VPgIn9CQVqDXG+r0N0bqTClXBxR6yv1EfjTQ31NULI
	 ZU3zcmXkta0lg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E54380AA62;
	Mon, 20 Jan 2025 12:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] tcp_cubic: fix incorrect HyStart round start detection
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173737623226.3511965.17438541188298408042.git-patchwork-notify@kernel.org>
Date: Mon, 20 Jan 2025 12:30:32 +0000
References: <20250117213751.2404-1-ma.arghavani@yahoo.com>
In-Reply-To: <20250117213751.2404-1-ma.arghavani@yahoo.com>
To: Mahdi Arghavani <ma.arghavani@yahoo.com>
Cc: netdev@vger.kernel.org, ncardwell@google.com, edumazet@google.com,
 haibo.zhang@otago.ac.nz, david.eyers@otago.ac.nz, abbas.arghavani@mdu.se,
 kerneljasonxing@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 17 Jan 2025 21:37:51 +0000 you wrote:
> I noticed that HyStart incorrectly marks the start of rounds,
> leading to inaccurate measurements of ACK train lengths and
> resetting the `ca->sample_cnt` variable. This inaccuracy can impact
> HyStart's functionality in terminating exponential cwnd growth during
> Slow-Start, potentially degrading TCP performance.
> 
> The issue arises because the changes introduced in commit 4e1fddc98d25
> ("tcp_cubic: fix spurious Hystart ACK train detections for not-cwnd-limited flows")
> moved the caller of the `bictcp_hystart_reset` function inside the `hystart_update` function.
> This modification added an additional condition for triggering the caller,
> requiring that (tcp_snd_cwnd(tp) >= hystart_low_window) must also
> be satisfied before invoking `bictcp_hystart_reset`.
> 
> [...]

Here is the summary with links:
  - [net,v3] tcp_cubic: fix incorrect HyStart round start detection
    https://git.kernel.org/netdev/net/c/25c1a9ca53db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



