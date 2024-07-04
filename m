Return-Path: <netdev+bounces-109084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DB8926D70
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 04:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE9191F22D26
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 02:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F83DDC3;
	Thu,  4 Jul 2024 02:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aO02bzCj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98CF1DA334;
	Thu,  4 Jul 2024 02:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720060228; cv=none; b=UuKg1zisZbGxl1x/VDbdaGCNP4yhvyMyuN8Pf1HzJ3GEn8SFJgu8xkqZF3YNbCkUATbMPa26TbBYyJYweW5Dt03ySDtTv0VQ9X6ptAhmFzqt7jKYZDuBD14ugih5EKDP6Y1TW7oEvZ4fie+aMFGwaXQs+Gz3xlLA56YR1+I1YSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720060228; c=relaxed/simple;
	bh=eGoaTL7YIMj9E4dmJnynaJLUdEB90a5ASRmAa84CSyQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PYGLdwe3tocKc4fxaym5h3+ts+VIclaSddWS/oFAlk4OP4Fa7UjJKw3IEqEx0zM5LcLR/XqM+RelLUjCvSq8i9Atgfo/cZ5ABNrcz6u7MjHAEZSwH0eqYswaqLMAQiMYCUzMDs6qSevxdZOPgnerzP5IWDpW7wNHkYmsetZAq20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aO02bzCj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34799C3277B;
	Thu,  4 Jul 2024 02:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720060228;
	bh=eGoaTL7YIMj9E4dmJnynaJLUdEB90a5ASRmAa84CSyQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aO02bzCjZU+y+Ly/mH0674pqcJdQNIan8R7AWDP9mCewVMJoRi7UB2nnvp3UBE0e4
	 q/jhGBy+G46ZEagmimdALcZyXi95KseyNpLF+tRDQ3AjxMijOLIZxhczewxndrJwnQ
	 XiD7GKzzjdGg4fvm8ZoQtreNw0XAQv3rpLCLcRKXepNSWyuNZaHKZm06KMqguznTIR
	 wky7ZVSUMcZAl9ea5MRzu0nZMaP5fEx6kG/ukb0VF3dJajU9FV3XqbHp1aiobUoFqv
	 +o94ulJFgfzeIhLlEW7keNkoy6aS+4b32VGIkkaeXe0Fx5wXY7p5Ve1OLifcTMAKQ6
	 QKUwlTBZZumTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 24DECC43446;
	Thu,  4 Jul 2024 02:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: rswitch: Avoid use-after-free in rswitch_poll()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172006022814.6400.15151962053735623334.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jul 2024 02:30:28 +0000
References: <20240702210838.2703228-1-rrendec@redhat.com>
In-Reply-To: <20240702210838.2703228-1-rrendec@redhat.com>
To: Radu Rendec <rrendec@redhat.com>
Cc: yoshihiro.shimoda.uh@renesas.com, davem@davemloft.net, pabeni@redhat.com,
 niklas.soderlund+renesas@ragnatech.se, kuba@kernel.org, horms@kernel.org,
 netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Jul 2024 17:08:37 -0400 you wrote:
> The use-after-free is actually in rswitch_tx_free(), which is inlined in
> rswitch_poll(). Since `skb` and `gq->skbs[gq->dirty]` are in fact the
> same pointer, the skb is first freed using dev_kfree_skb_any(), then the
> value in skb->len is used to update the interface statistics.
> 
> Let's move around the instructions to use skb->len before the skb is
> freed.
> 
> [...]

Here is the summary with links:
  - net: rswitch: Avoid use-after-free in rswitch_poll()
    https://git.kernel.org/netdev/net/c/9a0c28efeec6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



