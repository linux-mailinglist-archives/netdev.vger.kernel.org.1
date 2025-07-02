Return-Path: <netdev+bounces-203077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3D1AF077A
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 02:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D148C7A85DD
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 00:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3ABE146A66;
	Wed,  2 Jul 2025 00:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="es7dEfCB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0339145B3E
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 00:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751417394; cv=none; b=IxZeshGy2bJXHyTi3SP+aWjfd+b72NQWcCxw6OcYMPnoYDbbWaDqix3MqxabP8um/QREDFPxfRmrf0MQhOIGDwoFNpeUZrAH7jR98dIRsc6j/IBMYgtUsaBXZ77P//ERtXVR/HR92Jv5eKOslUkoaFv2I/buRnkTBspfSb8QTG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751417394; c=relaxed/simple;
	bh=nsZsB4Bag43e7mCaDzK1MbMF31AbLzH8N2KlkOTWggc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S318NZDSTJX4NcdR6RV1NjBHGKNoVE923W+1EXPY8fhZyjV69akRU3KMF3LKgZ7Ck2y+mCMe2aMoEKFXf81gOPW7c/Ag/W4HqVer304q1eSJ/mbC/S0tkYq7C8nDAU3bgUV2VzLXV2DyWI1y1tE+gW8vy0moAtqduplc0AMbI6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=es7dEfCB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6A9C4CEEB;
	Wed,  2 Jul 2025 00:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751417394;
	bh=nsZsB4Bag43e7mCaDzK1MbMF31AbLzH8N2KlkOTWggc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=es7dEfCB32QDJur3P6xa4h1YbeYyKzd8ygQc6Q7k7ZzjlmH468DUsK5kWBgx/vxPW
	 IScUhrRk5sm6/SO4sM9IgYNSc9Ryc13yDB7U4uJ50am0WOqAPblPTpWcsnCV4OF9+K
	 Zyuqm/mRSJ3A1hwfILp50abyVuuOjYcCDFZVCu8izgGdwkWKIyZWj1T+UG2wdYJr4Y
	 +G9A8rDbNGimd+iG3nboAQBs4R9WsYi6g44ezLqaQtR0PdLQxowIQKiinGiJnI6h1F
	 rg6orGpfDlw1shFKud5q8HsKyL0b4+VDllqji3RVc+lJZrShtCknwhSGx9gi+S3e2o
	 TbScty6yMSMCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B00383BA06;
	Wed,  2 Jul 2025 00:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethtool: fix leaking netdev ref if
 ethnl_default_parse() failed
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175141741881.160580.14789268644696405027.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 00:50:18 +0000
References: <20250630154053.1074664-1-kuba@kernel.org>
In-Reply-To: <20250630154053.1074664-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, idosch@idosch.org, netdev@vger.kernel.org,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Jun 2025 08:40:53 -0700 you wrote:
> Ido spotted that I made a mistake in commit under Fixes,
> ethnl_default_parse() may acquire a dev reference even when it returns
> an error. This may have been driven by the code structure in dumps
> (which unconditionally release dev before handling errors), but it's
> too much of a trap. Functions should undo what they did before returning
> an error, rather than expecting caller to clean up.
> 
> [...]

Here is the summary with links:
  - [net-next] net: ethtool: fix leaking netdev ref if ethnl_default_parse() failed
    https://git.kernel.org/netdev/net-next/c/3249eae7e445

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



