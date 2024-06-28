Return-Path: <netdev+bounces-107621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDCC91BB7C
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 11:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95934283A22
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 09:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5522A15380D;
	Fri, 28 Jun 2024 09:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9UrDZoA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314DF1CD32
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 09:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719567037; cv=none; b=r72DjVCTYXYZ8fJwNmpFqvr5MdTWwyX0XGbz/8AjjxYdYk2Cxybh5SDkMMW8mwF7n5X8omtaySikDjQ9zNlFJUT/xQsQawy6oz8UmpNJIL3k7/KczFNwijtIBQebWy83kFyF0Gz0k21U+SbmH5ECNamcHpp8suxdGa5fuGMS1jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719567037; c=relaxed/simple;
	bh=vwYtMlRc8sDsRvEojIZJTFr8GeZYqVLnSXVvs2ncOrg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H5sPyNS/uxZHAxf0iImkgRDvOH27qTcjjO3o8i8N+/dlnPHvvVyotoOJ2JhAhaitShcjlowF1BRoo9MAsdfkvMerbBhoaywZd5+J6Wk4fmebr5Sgg36jltyRocLzuwONWRwO5mFqw3g2YR/FaFVNGmXXsHQ2zM84hLVCC4EK3wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9UrDZoA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8D57C2BD10;
	Fri, 28 Jun 2024 09:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719567036;
	bh=vwYtMlRc8sDsRvEojIZJTFr8GeZYqVLnSXVvs2ncOrg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p9UrDZoAquYoa2AVzqiMhQMjoeVDt5rZJf1VO+l1IqlDkpEgIyHhfmbVXwBJovTYO
	 fDQZfC4fiummIghCGZ0iYPnSrILwSSsCSptAeLZcDAJnO+1b0K4hCUX9UJHG46QXsB
	 ZNZm267bELUkRzO3mPjR5OPr0g8pz42Uow0aT3QXUb+KBiTaeYjJctjf/dFmaxedO9
	 MG3nLrF9Y33pzwl/KkPxWkUuvStmbjXsAb5EO+m+yEE0mtXtElQsKgzTbiAqa5HLej
	 QI+iz3MLTsxobKUxtFSVdMoPPE8FY4BwBKHy5e2rQyRFTWpB0QHo7H3QBnrz7+IYFf
	 MS3UoZWOg0UQg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 98E00C43336;
	Fri, 28 Jun 2024 09:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] UPSTREAM: tcp: fix DSACK undo in fast recovery to call
 tcp_try_to_open()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171956703662.17958.2669161609955229303.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jun 2024 09:30:36 +0000
References: <20240627024227.3040278-1-ncardwell.sw@gmail.com>
In-Reply-To: <20240627024227.3040278-1-ncardwell.sw@gmail.com>
To: Neal Cardwell <ncardwell.sw@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 netdev@vger.kernel.org, ncardwell@google.com, ycheng@google.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 26 Jun 2024 22:42:27 -0400 you wrote:
> From: Neal Cardwell <ncardwell@google.com>
> 
> In some production workloads we noticed that connections could
> sometimes close extremely prematurely with ETIMEDOUT after
> transmitting only 1 TLP and RTO retransmission (when we would normally
> expect roughly tcp_retries2 = TCP_RETR2 = 15 RTOs before a connection
> closes with ETIMEDOUT).
> 
> [...]

Here is the summary with links:
  - [net] UPSTREAM: tcp: fix DSACK undo in fast recovery to call tcp_try_to_open()
    https://git.kernel.org/netdev/net/c/a6458ab7fd4f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



