Return-Path: <netdev+bounces-198858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0306ADE0C4
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 03:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B0F0189BF93
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 01:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955651D6194;
	Wed, 18 Jun 2025 01:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dru0PcH6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D7E1D5154;
	Wed, 18 Jun 2025 01:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750210848; cv=none; b=it1lPFYslZgOCdX/kHs7C5vbzWb02K8MwGeoOeMOctAb/0QCu5RRa8n8CuMhZo1b9cVF7+f1NHWnIvbht1LXVgYR/ZX1ugkWdyToL1ycmJFs3DtK83kY3J7Y46QHSWx1Ye6RCntBMR8TUCA3wB49lm1Apw2/X81J/Fm1qjabQcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750210848; c=relaxed/simple;
	bh=NPx5pq4IMTD/sxfK/tl1p7YJ4Ofiro4gEBB5gNKVvuE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mS7hI4m60pmYEsMSqD4mxxgUPE7cbKwRTg8Ylv4GBtOxFhEK3lvMjap50yGVczxW3OwfDZG74S1mOpkUvlVrC/M2d0Vn/kNwILAXHqORUAqA8A2z2l56zEO0+BdxDy/LukQnf6gmvIDhi4gcX0GFAHD0C2ch36emsFtLxDcOvLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dru0PcH6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9638C4CEE7;
	Wed, 18 Jun 2025 01:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750210847;
	bh=NPx5pq4IMTD/sxfK/tl1p7YJ4Ofiro4gEBB5gNKVvuE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Dru0PcH6HUso/po2qh++NNgNwK1rr1DrW/fwXsd+k/wPNxTwtcLiX1luCl3Ynjqqm
	 ig4+8ZTKibmebxtgEjrcYY4bv5KqW+qiD+dhe2nQE6tthjpsnwkVnSSJjgMp4muf3k
	 mgTyoiuH2TTrxSEPK1p/jfpbRAlx9wz5rI3SKBEiVlY57JIpFHJUsGySGNuaGHJohg
	 fED7v0YwhZuz6vkzBZAn540bupMSdU02OBvXfNNc6/ukes7LJ9K1B9Vy92d1HIlMyC
	 a3ESz/wwx/H6CY7+XMg2xUwGNoGabL+Wn2esdGe+HgerR/ABVSPxIe1NrFqSy3jpvI
	 ohQC/Kl2ffAAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 89E3C38111DD;
	Wed, 18 Jun 2025 01:41:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next] net: tcp: tsq: Convert from tasklet to BH
 workqueue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175021087649.3761578.7417279027374931577.git-patchwork-notify@kernel.org>
Date: Wed, 18 Jun 2025 01:41:16 +0000
References: <aFBeJ38AS1ZF3Dq5@slm.duckdns.org>
In-Reply-To: <aFBeJ38AS1ZF3Dq5@slm.duckdns.org>
To: Tejun Heo <tj@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 dsahern@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kerneljasonxing@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Jun 2025 08:10:47 -1000 you wrote:
> The only generic interface to execute asynchronously in the BH context is
> tasklet; however, it's marked deprecated and has some design flaws. To
> replace tasklets, BH workqueue support was recently added. A BH workqueue
> behaves similarly to regular workqueues except that the queued work items
> are executed in the BH context.
> 
> This patch converts TCP Small Queues implementation from tasklet to BH
> workqueue.
> 
> [...]

Here is the summary with links:
  - [v3,net-next] net: tcp: tsq: Convert from tasklet to BH workqueue
    https://git.kernel.org/netdev/net-next/c/fd0406e5ca53

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



