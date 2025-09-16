Return-Path: <netdev+bounces-223331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 658E0B58BC9
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 04:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 261B7168779
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 02:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6072821579F;
	Tue, 16 Sep 2025 02:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pH194gir"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C381991B6;
	Tue, 16 Sep 2025 02:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757989205; cv=none; b=UCFjJxenHrY3CNB3589tQSu1hWpAsorEC/QywPJFSNiW6qT9nuec8/XDHawFah8cWlJtCfQtSe5UWnnnGaNaegeQChsVfRVy+3bnhcAkIDf9ABRHibcExVWUW5+bLJbuRdyi3sjoA/lTDETydXAkiwQs7gk5+4eacCqATwgOGI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757989205; c=relaxed/simple;
	bh=2gX2j8ditCU1viWiisvTMn+6yohguFv2MHQEjMqRJCQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b+rifcj3hBTU8Y3dcVDX4k6g0QDz0fyZyR+KsBHBdsUyRFP5azZp3RVThNEkYoDgyOabo/cIfmmUw0f/GLHjzgucY+l/C2HVw4QnJRVm1zY+Aldv43VNpZc7b2W673zVAjAAGlHwGWi1nA+F/bpUOhOua4ehaUtsE7pwpFKw37g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pH194gir; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B67C4CEF1;
	Tue, 16 Sep 2025 02:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757989204;
	bh=2gX2j8ditCU1viWiisvTMn+6yohguFv2MHQEjMqRJCQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pH194gir3VJO5+1ZDJoLCmU8stXzdQVLqVmtDM7C+OC8DQaN6uyKzUADnVnHAEd52
	 Fp3A0ss8MuaQ+OHYtHi14bqhWIohmNL/gCQu+YKduFuU4311PX5JGfEIZgsBnHSLyh
	 ALH+amTWlaxIEIN2kGgD3DDQE1bTQL/20g/FH6n7P3RQXJlj1EiRR0zvkBCBoOZOdb
	 eyGoWxE86ib/rbXE5weez1P5y6spl9fFcxVxsFlcitJjQ2lAfPA4+Sv9ljQWHRszbM
	 J9KhSpSqxw0hphML5UXwwzeucWVxICs+UDSN/lVdlBV+OOeh/djJJUDL/9vgGnQFb0
	 4vrsyzKeZh2Lw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D8739D0C17;
	Tue, 16 Sep 2025 02:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: natsemi: fix `rx_dropped` double accounting
 on
 `netif_rx()` failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175798920625.572140.10879472998951369666.git-patchwork-notify@kernel.org>
Date: Tue, 16 Sep 2025 02:20:06 +0000
References: <20250913060135.35282-3-yyyynoom@gmail.com>
In-Reply-To: <20250913060135.35282-3-yyyynoom@gmail.com>
To: Yeounsu Moon <yyyynoom@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, eric.dumazet@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 13 Sep 2025 15:01:36 +0900 you wrote:
> `netif_rx()` already increments `rx_dropped` core stat when it fails.
> The driver was also updating `ndev->stats.rx_dropped` in the same path.
> Since both are reported together via `ip -s -s` command, this resulted
> in drops being counted twice in user-visible stats.
> 
> Keep the driver update on `if (unlikely(!skb))`, but skip it after
> `netif_rx()` errors.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: natsemi: fix `rx_dropped` double accounting on `netif_rx()` failure
    https://git.kernel.org/netdev/net/c/93ab4881a4e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



