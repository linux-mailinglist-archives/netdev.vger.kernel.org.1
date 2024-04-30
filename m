Return-Path: <netdev+bounces-92305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FA98B67E9
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 04:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43CF72823CA
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 02:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C66BE65;
	Tue, 30 Apr 2024 02:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srKcgFAS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954FD1C33
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 02:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714443632; cv=none; b=QvYs5SUcx+RAyqCB0WGqIb/cjsu6gS7vO2VI6gj773RGEqfljG9JSQrV4xYKZ1IZsM5t6zJ5kKnU9PTv3k5jEnBX3oJYHfYK5rj3HQFflWYlgWtVR4am94gA+eQFEDB6Lh/uQvRV8WG8mVJytGyhErQCZaRg7iZ8jwPKUEskvZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714443632; c=relaxed/simple;
	bh=w8cyZXotk5rZ5lIQxEoR2ZMYU6wDRTxJVuHRkdUagDw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DKP47xBpR0SbRMosKV3rUmwEQgrJ/fLsQv5QYnNEI7bXNn7wcD5fdiZKxN/3GzHYNfwL3n56ob+ZVbXzilK3Q0KrmwM5g/nKjvpooumqQOFMR4pNUXC4GGdIeb1lpVv/uZHMox++XmfB8ZvlssrFy8Lv9uDdiHvbOAVzd3Tl1d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srKcgFAS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E61AC4AF18;
	Tue, 30 Apr 2024 02:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714443632;
	bh=w8cyZXotk5rZ5lIQxEoR2ZMYU6wDRTxJVuHRkdUagDw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=srKcgFAS5qjy+DIkspNY+C6pvckBPRwZ6jvm+Vk+hZkuHayqV5ZOAh/MInT+IrZgj
	 XbZPi3bxAUEc4VswUnV4sYLfB6oaWIo7fd9C89KCE42gZnjPnghMqSZuF2hFSnUNUw
	 T807EFtNYXVPUHkLl72uZhkN/acmnRDjMiZwaso5IteMshwrRp1Ttm9ncs0ERonYVK
	 VpU6przhn0kbSVQWlSjY3vWQOG/U+Gs5ED7Ntrr/EeFOrWAGaeMzWzuTDWQlXG+Zhb
	 lnRTDURcbHd8NgMwQaFP/+OdFOA1bV6KVCNKyk21jsQsIcAPEwH6C7pufMneOshftW
	 v9wOPfLZVE0Pg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2BB20E2D48A;
	Tue, 30 Apr 2024 02:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: txgbe: use phylink_pcs_change() to report PCS
 link change events
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171444363217.30384.6690772865686731757.git-patchwork-notify@kernel.org>
Date: Tue, 30 Apr 2024 02:20:32 +0000
References: <E1s0OH2-009hgx-Qw@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1s0OH2-009hgx-Qw@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: jiawenwu@trustnetic.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 26 Apr 2024 17:18:08 +0100 you wrote:
> Use phylink_pcs_change() when reporting changes in PCS link state to
> phylink as the interrupts are informing us about changes to the PCS
> state.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net: txgbe: use phylink_pcs_change() to report PCS link change events
    https://git.kernel.org/netdev/net-next/c/dd1941f801bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



