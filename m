Return-Path: <netdev+bounces-151292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C1E9EDE81
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 05:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C8D2167F6D
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 04:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C442C1632DA;
	Thu, 12 Dec 2024 04:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4xDlaSm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A2713BADF
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 04:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733977828; cv=none; b=g/n19APGtCtI4jYiSz/cP//ulqXxfwEmOAEyf+hHoZrFBAH8RJB7eW5ZQ8ab8ixSTOTJ7ywmGsyFDW9K4Nc7BQgQ99SGFF/FldOu21fpv5tP2l1U77g7x6qB39kO0/cf959f9p/3ZznAa08ttQOHUhk5G7kaiENOE19f3iIz8Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733977828; c=relaxed/simple;
	bh=k3y12f4LcE98WlNHgoQa/ffgDunEM9Any1OcPm+DOzE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QTRQ66DVf7qozsdQFSjJJSAWcCgEj0cttf+LC+f8xyfxoC5Y+zMVGLnU9qsCilgop2Lw1D75S5zzEq578dJEmXCRB2U/iFattHLPOUeLpnLIQtNhBxsybMcIJxmDbhtaA7t+2b1GjMMwpL+Ny69Oob2ZcsZswehTvpHZ/LeZvlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4xDlaSm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C60C4CECE;
	Thu, 12 Dec 2024 04:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733977826;
	bh=k3y12f4LcE98WlNHgoQa/ffgDunEM9Any1OcPm+DOzE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H4xDlaSmF1RMz+aF0iT6dN2i46VoLCV4Mc5KDkQQGNqcWK0xWvzjSno+ploLuVn+f
	 CBHQiLDxaVBHvbhRjsq0yjDxqBX3SDCmpg/4oMGtoOXdgzIrRmZ7TcvoD719MjbMgG
	 POt+r7Jn/l0Tud3vAe6hMZMi0fnE5MJk9QCRXpEahCpPOwocnbJgM+ecidrum0K5gi
	 pJQ0K17Ad37XOW29bUgP9g2fzrDRdJSIn0OaI451Ts2/4Ocp6WMNg4PVmaKrIlczH1
	 0RRHkCY6HpsQWy+gm43dtUmZStUY4htZN1vwZJIhTuMbn//KEKKk9h/XtKAy/OIz5G
	 EiKPa/RECpQng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71FA5380A959;
	Thu, 12 Dec 2024 04:30:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] Make TIME-WAIT reuse delay deterministic
 and configurable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173397784199.1847197.6727486330355181144.git-patchwork-notify@kernel.org>
Date: Thu, 12 Dec 2024 04:30:41 +0000
References: <20241209-jakub-krn-909-poc-msec-tw-tstamp-v2-0-66aca0eed03e@cloudflare.com>
In-Reply-To: <20241209-jakub-krn-909-poc-msec-tw-tstamp-v2-0-66aca0eed03e@cloudflare.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kerneljasonxing@gmail.com,
 avasseur@cloudflare.com, lvalentine@cloudflare.com,
 kernel-team@cloudflare.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 09 Dec 2024 20:38:02 +0100 you wrote:
> This patch set is an effort to enable faster reuse of TIME-WAIT sockets.
> We have recently talked about the motivation and the idea at Plumbers [1].
> 
> Experiment in production
> ------------------------
> 
> We are restarting our experiment on a small set of production nodes as the
> code has slightly changed since v1 [2], and there are still a few weeks of
> development window to soak the changes. We will report back if we observe
> any regressions.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] tcp: Measure TIME-WAIT reuse delay with millisecond precision
    https://git.kernel.org/netdev/net-next/c/19ce8cd30465
  - [net-next,v2,2/2] tcp: Add sysctl to configure TIME-WAIT reuse delay
    https://git.kernel.org/netdev/net-next/c/ca6a6f93867a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



