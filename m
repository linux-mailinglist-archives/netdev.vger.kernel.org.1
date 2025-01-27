Return-Path: <netdev+bounces-161214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A43AA200B9
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 23:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA3023A6F72
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 22:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EC61DB548;
	Mon, 27 Jan 2025 22:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjOIrW8h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCF819885F
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 22:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738017607; cv=none; b=mrFHjpJM6c5L8P2cmcGHCMTf69sTBWemPUUiDyP/6/HdLWgJqDaO3T+mJ3u0mEbwlsMoVA1+jn95mAD/rP4x/5qL9NYvlFXNpg9I9XywRY6SP6vRjeyykLqAiCHWXVPbFHdBwjAU74OlA9o+lYPDX152l3KvMaFPXzkebNV9dlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738017607; c=relaxed/simple;
	bh=oNxgDrzCpkZejR8ZAUgtOuxzoD3nubkG4KjOgKcXU+0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BSn0wtzm5CfncQ1kExz4OKnMlsn48ftU2tmDllyEQW03ziUvHf1VxCjDKNGAAe3wEY/HH/HWDKT+sUFTF7eFECl78TF9x0sAjt03hy9EudyBiI8nUnO5eW9la2UfzqgYs+ZQssJVWiImhFB57rEwPd/GY+X0jLPwVUAgPnlBTKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjOIrW8h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587DCC4CED2;
	Mon, 27 Jan 2025 22:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738017607;
	bh=oNxgDrzCpkZejR8ZAUgtOuxzoD3nubkG4KjOgKcXU+0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BjOIrW8hk74SWV7ZMZouyC4dSlZhbbY4Y3sKQoKYd72hz4ZDAcUwGFq044h+np7kL
	 ZWEwx45draNSR4bW57bUh+5YdwSA1EkAocFLtNcCVU2a2JdRjRgHDXRUQhS9l4wiBm
	 1//TbFbsW4l2RahWrqJsPb+rn/UzzZ0pAOTrPqiFPPFg1s/UQgiDkY2NWIHF2NsPD2
	 Ega89Fqv021XPIoT12fV2DEQt6in+1VjKBKYzd+soDK3jysNVxN4+Y/QDR50uakOkm
	 cibOx+C/ZThURPT6cC8ZCBCaaVQnnkpsJ5kNLhkGMiIiulW3KekbsHdh0885M2DFIF
	 0+tn9bLKmH7Uw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D9D380AA63;
	Mon, 27 Jan 2025 22:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/7] eth: fix calling napi_enable() in atomic context
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173801763301.3245248.16328170214017560223.git-patchwork-notify@kernel.org>
Date: Mon, 27 Jan 2025 22:40:33 +0000
References: <20250124031841.1179756-1-kuba@kernel.org>
In-Reply-To: <20250124031841.1179756-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 dan.carpenter@linaro.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 Jan 2025 19:18:34 -0800 you wrote:
> Dan has reported that I missed a lot of drivers which call napi_enable()
> in atomic with the naive coccinelle search for spin locks:
> https://lore.kernel.org/dcfd56bc-de32-4b11-9e19-d8bd1543745d@stanley.mountain
> 
> Fix them. Most of the fixes involve taking the netdev_lock()
> before the spin lock. mt76 is special because we can just
> move napi_enable() from the BH section.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/7] eth: tg3: fix calling napi_enable() in atomic context
    https://git.kernel.org/netdev/net/c/8ed47e4e0b42
  - [net,v3,2/7] eth: forcedeth: remove local wrappers for napi enable/disable
    https://git.kernel.org/netdev/net/c/a878f3e4ace7
  - [net,v3,3/7] eth: forcedeth: fix calling napi_enable() in atomic context
    https://git.kernel.org/netdev/net/c/5c4470a1719c
  - [net,v3,4/7] eth: 8139too: fix calling napi_enable() in atomic context
    https://git.kernel.org/netdev/net/c/d19e612c47f4
  - [net,v3,5/7] eth: niu: fix calling napi_enable() in atomic context
    https://git.kernel.org/netdev/net/c/f1d12bc7a596
  - [net,v3,6/7] eth: via-rhine: fix calling napi_enable() in atomic context
    https://git.kernel.org/netdev/net/c/09a939487fc8
  - [net,v3,7/7] wifi: mt76: move napi_enable() from under BH
    https://git.kernel.org/netdev/net/c/a60558644e20

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



