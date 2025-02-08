Return-Path: <netdev+bounces-164289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 912A9A2D3BF
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 05:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D537E3ACBB3
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 04:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A4B18E04D;
	Sat,  8 Feb 2025 04:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgiRkfH/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C80F18CBFC
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 04:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738988414; cv=none; b=KLRx8SkZdevXT4DgMzV7dXBoE4dps1sBOzNOEneixKQ5gS2uHy92t4XFKQYF0eRJFc9j+3Ajg48K/t36ILdAyooZO590BQSyighLc7RyYFwUmJO78Y9JTJZaY4TS5IzzadS6BgU0Esa7ZTBM/wXpFK3qDxOZiQSg6EalTyoz6uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738988414; c=relaxed/simple;
	bh=D6F3jPN80SzRMxKWnd+YfopDfveRR9g7embkLkIDKk4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YuKoxFOXYycaVR4oTBeIvl1gpmED21xuf662ArhH1OhfNxobuPslxIO/viJ4QUL/zsHRQAIPJ93kVCJehS5CGr+1muWI1iY88syXTN6T7VbCxLG7qpl5U8wACTMLop+s15YWVKYyXJF87WwpFjony6MhQebZOawvOEwdz2zN3g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pgiRkfH/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0419BC4CED6;
	Sat,  8 Feb 2025 04:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738988414;
	bh=D6F3jPN80SzRMxKWnd+YfopDfveRR9g7embkLkIDKk4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pgiRkfH/VSDsosjX7oC/HW56VdVAeDo66o9aAoBxmeBoIUeyFnGbcgI4sli3C/izd
	 TW03Monj4kLyucj382XTaDJsCnlnJNpMrpbvfWzxuU56QTxEjNoYkIANE098SYlX18
	 4xp4iy0/msRlh5K6CVoumrhQ+bSysGvEVgfALR8Z6FXWqqNtnNqOhQGmX248+/dbtz
	 WpV9Xb/dKNGRoPs/8WAL77RxxAKnOGtehxzdEzL6YPD8wAAZbUUwiWkmFKNX5vff2r
	 IcezNe0uzKwgE6RlLf2Mkk8Szm10KC4OndYlQqRTf2bu2+2QNTeyZRW6dbrCGkLB7y
	 dM/m9FAM/jQHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E07380AAF5;
	Sat,  8 Feb 2025 04:20:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4] net: improve core queue API handling while
 device is down
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173898844200.2488639.8958711526898409810.git-patchwork-notify@kernel.org>
Date: Sat, 08 Feb 2025 04:20:42 +0000
References: <20250206225638.1387810-1-kuba@kernel.org>
In-Reply-To: <20250206225638.1387810-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 almasrymina@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Feb 2025 14:56:34 -0800 you wrote:
> The core netdev_rx_queue_restart() doesn't currently take into account
> that the device may be down. The current and proposed queue API
> implementations deal with this by rejecting queue API calls while
> the device is down. We can do better, in theory we can still allow
> devmem binding when the device is down - we shouldn't stop and start
> the queues just try to allocate the memory. The reason we allocate
> the memory is that memory provider binding checks if any compatible
> page pool has been created (page_pool_check_memory_provider()).
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] net: refactor netdev_rx_queue_restart() to use local qops
    https://git.kernel.org/netdev/net-next/c/1eb824d69f8d
  - [net-next,v2,2/4] net: devmem: don't call queue stop / start when the interface is down
    https://git.kernel.org/netdev/net-next/c/3e7efc3f4f03
  - [net-next,v2,3/4] net: page_pool: avoid false positive warning if NAPI was never added
    https://git.kernel.org/netdev/net-next/c/c1e00bc4be06
  - [net-next,v2,4/4] netdevsim: allow normal queue reset while down
    https://git.kernel.org/netdev/net-next/c/285b3f78eabd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



