Return-Path: <netdev+bounces-189943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B72AB48F2
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 03:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAFB01B417C7
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 01:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11A9192B8C;
	Tue, 13 May 2025 01:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmU4T94F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9726E18DB20;
	Tue, 13 May 2025 01:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747100998; cv=none; b=UJl8A/8+fDSuadoS9aYbnEEHcToSG3LNmf0HhpAAjyARwOqMKgJHI8c5nRz4wwfaC9/iSEXy82axYaMCtJT3YzrB3+bFLLOva6XjgKJW4BJuJAHDiPdN++6DegtTmOaZNbqvIwhgVp13KDTRkvNvjy6vviOKh9rq1yFP1ipu3dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747100998; c=relaxed/simple;
	bh=pMyNGweScu0asBGaNv3MN6SC4EsJhgTTOAoAOOs+zGE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VKWh4gF7KzjblBZ/MruCGdUyjfI+OiUX6zP7eQDMSk+upiS58UBNreoKAHpaYcjnN2BVooE3pBssUDyG79wtOI5sCdHLxSiHqoxaQzaEDmCV3sxNg7H2U9HQVnKfoo46fTUPp2BUla6nanR6rINoOH+g25cc42yILYpVntWzwp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmU4T94F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6B0C4CEE7;
	Tue, 13 May 2025 01:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747100998;
	bh=pMyNGweScu0asBGaNv3MN6SC4EsJhgTTOAoAOOs+zGE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MmU4T94F9ryTLRbQewt00Nbxj9OUZcoCPtYkCJcE2VBixyJ2DghGu8vOdflX9XnHt
	 xtwAHMGjmdQAVlxkVkVh/lpGTBeSdVS1kA2GatsPI3DNWfOd8KH9LesMQM4Oruwx0r
	 Y6Amdn1Fdzl/wuDZXXm1eD6OZu7LHmUIap6dprXa8xbY3ZtVjtL5dmbWtCmUDYFjvz
	 /15x7hjQyWWNKKU3kuTdE4NY7g5rltBQYZvvob+G7F9M6ugb2+eajTLkiCZCjTt3Wk
	 y4R2QJfVd0gEbYrJOW2uD4okd/FKOI/by/KbLtnX1xZn159wV/Q6iUqgfdiql3/Ghk
	 DOg9dqJOt2SVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACC939D60BB;
	Tue, 13 May 2025 01:50:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: cadence: macb: Fix a possible deadlock in
 macb_halt_tx.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174710103549.1140764.16369480038799369631.git-patchwork-notify@kernel.org>
Date: Tue, 13 May 2025 01:50:35 +0000
References: <20250509121935.16282-1-othacehe@gnu.org>
In-Reply-To: <20250509121935.16282-1-othacehe@gnu.org>
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, anton.reding@landisgyr.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  9 May 2025 14:19:35 +0200 you wrote:
> There is a situation where after THALT is set high, TGO stays high as
> well. Because jiffies are never updated, as we are in a context with
> interrupts disabled, we never exit that loop and have a deadlock.
> 
> That deadlock was noticed on a sama5d4 device that stayed locked for days.
> 
> Use retries instead of jiffies so that the timeout really works and we do
> not have a deadlock anymore.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: cadence: macb: Fix a possible deadlock in macb_halt_tx.
    https://git.kernel.org/netdev/net/c/c92d6089d8ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



