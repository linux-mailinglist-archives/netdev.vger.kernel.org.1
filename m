Return-Path: <netdev+bounces-193785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C371AC5E89
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 02:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0360C18874EE
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 00:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062D31F874C;
	Wed, 28 May 2025 00:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBmGrA0v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62601F5833
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 00:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748393404; cv=none; b=PmB46tW24OA52MoFBUIdQOK1mgiRA/fcab1u/gvgx8TuQBXePubrBRevpNWE0lOS755WWCYTPohPyMzyAs8/wFvEoKIu2fVLjCuue7tpDk4X/G59DVewqPZRCfOubqcXnMNkPR+wkIdidrEW9ekuVElBWB9VlFD3q5hh3RYHajs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748393404; c=relaxed/simple;
	bh=pq3qZTSWC3S+D4ehlP6t/LNSP/jBlyNWrw++sa4C3d0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YBwozKYOC94msR6fdBSGVtHJqqF3v2m/xRrH+XGMlcIRwa+V2VMTmd8HMgONmXfLZJ0Ho3hHNWYcv6sNAEyNgeYKLikO8/ge7QS819plXd9hR9tjEkrhBFjbriyluret6sgHydwkIxtYKGn7PWKmbzVeUC+gcia8qHh6hGBt7SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBmGrA0v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3C3C4CEE9;
	Wed, 28 May 2025 00:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748393404;
	bh=pq3qZTSWC3S+D4ehlP6t/LNSP/jBlyNWrw++sa4C3d0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tBmGrA0vfFydc/Rk1/eU7eu3G9BzqJ2evaezlmL0cQm18X1HJZ4kWHSKYiV00fHTL
	 QakQ8uewPQ1uYfSCEM/YUDjKwsEtfvXRSnKxtt2TEz2Rl6o7xbXsGYIJKMsANT+v4q
	 E1dWt0t/femwFSADAxoh25FMIdBYaR5xbwxyUzQRqSIhqXytDjCsJOEjoW8iDyU6pQ
	 0GO/aPxD838A1B/PNjlFBgf/BV0s7oNuL76JO61j0n3qOx8ApzZXyltxAtrJSTXPuy
	 0fVi2nhXD9LfN4gf+o1ADVpL3i4RaH2ujPmc8p0Xqi16JQ34CRwHxca/JiQTizw3uv
	 uCYrUbAoiDPNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE65380AAE2;
	Wed, 28 May 2025 00:50:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mctp: start tx queue on netdev open
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174839343849.1843884.5252612531483158148.git-patchwork-notify@kernel.org>
Date: Wed, 28 May 2025 00:50:38 +0000
References: <20250526-dev-mctp-usb-v1-1-c7bd6cb75aa0@codeconstruct.com.au>
In-Reply-To: <20250526-dev-mctp-usb-v1-1-c7bd6cb75aa0@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: matt@codeconstruct.com.au, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, nitsingh@nvidia.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 May 2025 10:44:33 +0800 you wrote:
> We stop queues in ndo_stop, so they need to be restarted in ndo_open.
> This allows us to resume tx after a link down/up cycle.
> 
> Suggested-by: Nitin Singh <nitsingh@nvidia.com>
> Fixes: 0791c0327a6e ("net: mctp: Add MCTP USB transport driver")
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> 
> [...]

Here is the summary with links:
  - [net] net: mctp: start tx queue on netdev open
    https://git.kernel.org/netdev/net/c/126cd7852a62

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



