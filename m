Return-Path: <netdev+bounces-187262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A83ADAA5FC9
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 16:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72D954C47A6
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 14:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EEF1F7098;
	Thu,  1 May 2025 14:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Op57GEv9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484D41F12FC;
	Thu,  1 May 2025 14:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746109194; cv=none; b=NoUOl9OvcbdkiFTaVAglZnkhuUFoPd/oqCmvMVbBGmYQuHqF8/4kdihv3Ij7BBsMmwMiTK6NQVjIkGaMu0nZhOQZCdSLVH//zGJ5jv95orywlRIJIk+JFDFodqmdtXbwcqPOZCqXkUFPO5eSBDBvPj6VH6E+UiGczblb+fEAZVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746109194; c=relaxed/simple;
	bh=KUY2E04W8FOqQvyGwUg/Efg4gZOMQe3f2YoxI8LRvN8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pW1cDGokgZJ4JT+zm/7IkY3V4Ls7TyfxlKyTem8saHdVcNrWmf1kuKARamCHZ8QwWiathjgBNpn4pU+0+tTcGBWprNsh/xzISxk+8t0Htr0yWfJu1Bm5MWOci7guxODZGc2XWA5f/Ha3F8HdoFxy7bEL3TknNQjrUb0iJ4al+us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Op57GEv9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222F9C4CEF2;
	Thu,  1 May 2025 14:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746109194;
	bh=KUY2E04W8FOqQvyGwUg/Efg4gZOMQe3f2YoxI8LRvN8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Op57GEv9WQJxOJlV57U3+UDWylzA1Cxv5QYYctFbppsPQwM9eKlWvfMCWcS18pXd4
	 GD82i13oK2jmSnZr8sFLIMfIQ211qj0vZplRxzOrm7LTgAsJP6GgHrYj3GR9KQfCuG
	 Udu5vTcv7IRLo1DujlHb2D2ADPIlo8AEnbcgNFCuM1vm00xQr0ZtszOnFGe5sousBh
	 3obtK47p6gmmCufzpgDa8K9jO/eKF0JF3nj2Jq5ghSA0tD6O/B9x39Jl4KPKNm0OC+
	 NmllqtCF9HJXbAaTOqjmGcy/ziINWmx4AE6NTMkkYdtUL/owISyDFV4fNZFukWRkTy
	 aOGGwiLLct1pw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70ED53822D59;
	Thu,  1 May 2025 14:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeon_ep: Fix host hang issue during device reboot
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174610923324.2992896.6627147475991348639.git-patchwork-notify@kernel.org>
Date: Thu, 01 May 2025 14:20:33 +0000
References: <20250429114624.19104-1-sedara@marvell.com>
In-Reply-To: <20250429114624.19104-1-sedara@marvell.com>
To: Sathesh B Edara <sedara@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hgani@marvell.com,
 vimleshk@marvell.com, vburru@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 aayarekar@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 29 Apr 2025 04:46:24 -0700 you wrote:
> When the host loses heartbeat messages from the device,
> the driver calls the device-specific ndo_stop function,
> which frees the resources. If the driver is unloaded in
> this scenario, it calls ndo_stop again, attempting to free
> resources that have already been freed, leading to a host
> hang issue. To resolve this, dev_close should be called
> instead of the device-specific stop function.dev_close
> internally calls ndo_stop to stop the network interface
> and performs additional cleanup tasks. During the driver
> unload process, if the device is already down, ndo_stop
> is not called.
> 
> [...]

Here is the summary with links:
  - [net] octeon_ep: Fix host hang issue during device reboot
    https://git.kernel.org/netdev/net/c/34f42736b325

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



