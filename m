Return-Path: <netdev+bounces-119952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 945D9957AA5
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 03:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21FFEB22492
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 01:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208E68F70;
	Tue, 20 Aug 2024 01:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyERijNf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04CE79E5
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 01:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724115632; cv=none; b=lf8Gn95RagQbqAjXLzMmBLSevFkxa4ex4VC0R2zARKlog9YtRd9ez2WJxCUlmu/2RyE1Il1jmOkRskaU/PRrlId/m08Qq74YH8eQ3GL2tgJsXHL+Cuv9vIkQ4XjJFDHni/seiUxMiq5wnC2MnmDEwhxLGZRAxy+KHLz6uzHit9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724115632; c=relaxed/simple;
	bh=dJF/cEsrS6TAJenJLQqKehRHoAwCd3dZy7/YxJ1Buo0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tVPKa3D3HTMQinQ2VSkX6n++rCjJd5yf1jFlk8BUE1OY5IZhmRvQat2oJbiXreSE69tz920OcJ526aI3kBF+rhLJglfTkR65K9Uf/Sek3BOA5tZfFTrTmfM9FllqP2szA4gslQmZxOB99yHRrDglwfXL36tvZnFd2y9PvpDtskA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyERijNf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 854DAC32782;
	Tue, 20 Aug 2024 01:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724115630;
	bh=dJF/cEsrS6TAJenJLQqKehRHoAwCd3dZy7/YxJ1Buo0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hyERijNfNWqj7libO042O1YVMD1k8ZxcZzgYhG16LHbQgDutbo30JOhBoeQh/6nj4
	 mtGPrFm5Hfq6ThvM3XyO+uzfLlOcKSkiodqfur/W9ApyKydEEHfti2aIHE4y4Mqgoi
	 wQlWCtMI6nhVBkzzvaWl83twqvM7KfkCjlHCX+5TMj9EhrpqPTeY/O0DBQjDbZVYbe
	 M1Y+WPOTnhLvpKtFlSburRbCR0BBT++sA0BeySz7ERV2IZ5u7lYPU2SbayT4YPyMJI
	 rxkGQGhTzVTdtboW21gF7/mpdS/fVKo3FNhqCweSrgEESK4S4bDUOmjJkiEpqlNHSV
	 l0NXMIVwkySOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340073823271;
	Tue, 20 Aug 2024 01:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mctp: test: Use correct skb for route input
 check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172411563004.698489.9848294032783743613.git-patchwork-notify@kernel.org>
Date: Tue, 20 Aug 2024 01:00:30 +0000
References: <20240816-mctp-kunit-skb-fix-v1-1-3c367ac89c27@codeconstruct.com.au>
In-Reply-To: <20240816-mctp-kunit-skb-fix-v1-1-3c367ac89c27@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: matt@codeconstruct.com.au, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dan.carpenter@linaro.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 Aug 2024 18:29:17 +0800 you wrote:
> In the MCTP route input test, we're routing one skb, then (when delivery
> is expected) checking the resulting routed skb.
> 
> However, we're currently checking the original skb length, rather than
> the routed skb. Check the routed skb instead; the original will have
> been freed at this point.
> 
> [...]

Here is the summary with links:
  - [net-next] net: mctp: test: Use correct skb for route input check
    https://git.kernel.org/netdev/net/c/ce335db06216

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



