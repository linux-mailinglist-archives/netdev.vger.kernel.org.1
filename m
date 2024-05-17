Return-Path: <netdev+bounces-96834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2F58C7FFA
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 04:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A73D2B207C7
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 02:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411F68F45;
	Fri, 17 May 2024 02:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVAOrIXL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF8D63A5
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 02:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715913631; cv=none; b=hy+WvzmE0tkVZBOTGrFBaXYZk+TOyZXe8+eBrS21ewuxSeJB4fkV7+BJqFlqKyJ9CUmGobF4oms88jkXm8l5G6hYINs3FuC9MXAwDlZdS5EBTrdGUy7DB8BQy09b4Qwg8AySmBtcUep11K4qPMjuNOR90YRwk+o9YJqZ3hGCGS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715913631; c=relaxed/simple;
	bh=9Afnm6NLwvDHnP0kr9Q5cU+6wvBvT4RGvSlN4rIfGfU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rPpNws1l3JvP9EkzBZsRrCHiNOatbDs2cwswCjSBPH0EhWTg8pLUfKc09VG5RKxB4XkmxajWU0XX5LY6198PnECDLmEN4zRltu+ufNLRbxPFFFpHZ9vBWcpjWRKkU1kxYvAJ3eakPJ2AUs04xvu/gQJgrx4WswgJXUDSGuKO6mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVAOrIXL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C69FDC32789;
	Fri, 17 May 2024 02:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715913630;
	bh=9Afnm6NLwvDHnP0kr9Q5cU+6wvBvT4RGvSlN4rIfGfU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RVAOrIXL5YyDIjoXIj/6+EwY4RkJ19WPENGBRheW/ujY1aXbJv4ACFCsNMBFqotza
	 P1apLx0xSzSeC89U/jcH56OB7fb40MxsXtTDcP6ggkZEjXphLz8l6r4tTDYds+FZfk
	 jBZk/vKeEoEPFcOn33ujBaursd5sxXdRHkSIILwX1QRuB2iJZxvVRX4MdSsNVCMm8v
	 FeKrNsm9WLZF5H65RzOl3AOLBmRTUMZNbSUnukRoZiP6/LoDH1tFYUkwKQy7SCI/va
	 rD+wNbjXvFyy5J3RzeganUCmidG+XtAgXFtM5eNS8MZ/Lf69f4SyFQFO/yY/pNwsZr
	 EiPqobaHMkhEQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B6935C43339;
	Fri, 17 May 2024 02:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] af_packet: do not call packet_read_pending() from
 tpacket_destruct_skb()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171591363074.2697.13112927096928807724.git-patchwork-notify@kernel.org>
Date: Fri, 17 May 2024 02:40:30 +0000
References: <20240515163358.4105915-1-edumazet@google.com>
In-Reply-To: <20240515163358.4105915-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, nhorman@tuxdriver.com,
 daniel@iogearbox.net, willemdebruijn.kernel@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 May 2024 16:33:58 +0000 you wrote:
> trafgen performance considerably sank on hosts with many cores
> after the blamed commit.
> 
> packet_read_pending() is very expensive, and calling it
> in af_packet fast path defeats Daniel intent in commit
> b013840810c2 ("packet: use percpu mmap tx frame pending refcount")
> 
> [...]

Here is the summary with links:
  - [net] af_packet: do not call packet_read_pending() from tpacket_destruct_skb()
    https://git.kernel.org/netdev/net/c/581073f626e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



