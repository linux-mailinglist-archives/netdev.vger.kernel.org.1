Return-Path: <netdev+bounces-212288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FF2B1EF47
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 22:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D68BC5A2158
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 20:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43B92253AE;
	Fri,  8 Aug 2025 20:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="peMMkYsK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE2D2222D0
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 20:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754683796; cv=none; b=cTGV3BNAKBYrIctgNg0ckFhkB3CTXy6PVhJnAqJJGJ3FhhO3dM2HE5tP7H7sxJoEPi8Mc/atK9C0yRTvr2Ui/jBxRyy4Uvm2B2375+4LKjVAIOjS5kHegRQF4c8vXitmhTTGEy6K/HNNfE8ESUGLexl6Z5zWhL6wJwCMZJc4CZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754683796; c=relaxed/simple;
	bh=aS2FtTVZ6uYRzfbEBWDX8DSsN87gpLEa7R5Li57VhVo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e+pTL9aKE9APQaHl295X6QDJxPb9qCT2+XsktAdudHPyO6+rCXM2etAEU5Vr/AM2SaKNMyKVhW0WEJIc/it9OR93fZJEkR/WBaFwQBNIXaV6M/E3H1U6NvF1mn75m5qFYU9maMkuyoMN0d7HZvplxZdlxYEFCHCon0ElUmLxTGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=peMMkYsK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A477C4CEF1;
	Fri,  8 Aug 2025 20:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754683796;
	bh=aS2FtTVZ6uYRzfbEBWDX8DSsN87gpLEa7R5Li57VhVo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=peMMkYsKFC0XBuroE0phcz9VX/NQp2SrXOtlNBoWK50aNqwdwMc3r2IG4op5yhtIT
	 5ABhxOpSozD7uzh3kKZtydrO8jsxOmlvnJk5vaNHzvPJIPMsXTAJKkIX0uWtv8n1CR
	 SweCx8841Obnoyj5iXn0Xre6h5sxBE9UnyX6m1U/wrc5jNetZnfU05PIdp9NV0IajE
	 hFtECeRTsBUSPKHeQK8fhWLFK1E53YoSz+6ukIrWOag6DggMG0OORC3/yefmJHCW7C
	 r6ynvR/c71FyxOy4gErNq+mFVQLV2J5rRlkwx9n4kU9ACpZCtyd0z7pKMo+RUtuEsW
	 Owtrxmb0DtNGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD40383BF5A;
	Fri,  8 Aug 2025 20:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: page_pool: allow enabling recycling late,
 fix false positive warning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175468380949.252401.12324052781173842236.git-patchwork-notify@kernel.org>
Date: Fri, 08 Aug 2025 20:10:09 +0000
References: <20250805003654.2944974-1-kuba@kernel.org>
In-Reply-To: <20250805003654.2944974-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, dw@davidwei.uk,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com, hawk@kernel.org,
 ilias.apalodimas@linaro.org, almasrymina@google.com, sdf@fomichev.me

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  4 Aug 2025 17:36:54 -0700 you wrote:
> Page pool can have pages "directly" (locklessly) recycled to it,
> if the NAPI that owns the page pool is scheduled to run on the same CPU.
> To make this safe we check that the NAPI is disabled while we destroy
> the page pool. In most cases NAPI and page pool lifetimes are tied
> together so this happens naturally.
> 
> The queue API expects the following order of calls:
>  -> mem_alloc
>     alloc new pp
>  -> stop
>     napi_disable
>  -> start
>     napi_enable
>  -> mem_free
>     free old pp
> 
> [...]

Here is the summary with links:
  - [net,v2] net: page_pool: allow enabling recycling late, fix false positive warning
    https://git.kernel.org/netdev/net/c/64fdaa94bfe0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



