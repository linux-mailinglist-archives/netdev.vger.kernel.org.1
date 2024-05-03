Return-Path: <netdev+bounces-93160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE9F8BA533
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 04:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D20B1C21BB7
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 02:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE56E15EA6;
	Fri,  3 May 2024 02:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mC9mHDmH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3F714F62
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 02:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714702229; cv=none; b=BhmHN4LVgRg7+7Sha3WC+6c8GlztOOjvZRGXyEwk0vITJajOSz/o89NtcmfRAO0RCRI7DsrqjpsaJ6HCUt8CN22+DWthL8Dt/VX1+q/Swh/iWimI8CvP1t4aqUBB3rNeqDYXF9nushXr0WUT2wYTzEX2H2i+AF5n21rM6D8hV+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714702229; c=relaxed/simple;
	bh=N+jYHFer5aBDnXwI4G6JdJFZCHD0k2V4kGsbrRCiMFY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l1N/XgKnPbqlPwfWqADdEhPbmJBio1wNItR5LT2Jp1VvVVgo868uziivs4+nh0c7GJnZJUxNr8iah0rOuGrumYdra5vNl6GI0YvbtvU/L3BghH0D/imrR3MFCdTnQ4Njmvm9z5aFrQ5eA18ErguF8emP/DSwnmNmzDHoVVJyq7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mC9mHDmH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41B0AC4AF19;
	Fri,  3 May 2024 02:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714702229;
	bh=N+jYHFer5aBDnXwI4G6JdJFZCHD0k2V4kGsbrRCiMFY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mC9mHDmHhAmyRQju6rfhBdrzMiyM19scmHSoX9Yh0gj0wS4RSPjFImrgHCTAUf86P
	 xI/69HY2y5odLUInEoEADcphKpL0e8gwURqy4V7ZP2XaBUkglioL/OfUTLOGB5L789
	 hdu19yfcEZWkmHIrQ5OKFWCigzLBqkcGBcpTfkGx9NCzmzCPFA59Wgjp3YYS1PVPSb
	 gdCEVr+lEDfH5zpzqLKd5xf+/MZ/hC1ieU0ZzueJt4h0YyCfZHbwV1ubfS1rDuYo+R
	 b1VxmLJrEWm25gQ+h8gjchyDinDbw7GkxPpiMsRy1k+fqxZntSNC4MC+VZWn7whzw3
	 sJIpADe8q4oFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A5C8C4333B;
	Fri,  3 May 2024 02:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: defer shutdown(SEND_SHUTDOWN) for TCP_SYN_RECV
 sockets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171470222917.28714.1735864391101159950.git-patchwork-notify@kernel.org>
Date: Fri, 03 May 2024 02:10:29 +0000
References: <20240501125448.896529-1-edumazet@google.com>
In-Reply-To: <20240501125448.896529-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, ycheng@google.com, kuniyu@amazon.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  1 May 2024 12:54:48 +0000 you wrote:
> TCP_SYN_RECV state is really special, it is only used by
> cross-syn connections, mostly used by fuzzers.
> 
> In the following crash [1], syzbot managed to trigger a divide
> by zero in tcp_rcv_space_adjust()
> 
> A socket makes the following state transitions,
> without ever calling tcp_init_transfer(),
> meaning tcp_init_buffer_space() is also not called.
> 
> [...]

Here is the summary with links:
  - [net] tcp: defer shutdown(SEND_SHUTDOWN) for TCP_SYN_RECV sockets
    https://git.kernel.org/netdev/net/c/94062790aedb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



