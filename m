Return-Path: <netdev+bounces-142181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E92F9BDB52
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 02:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F6E21C22D78
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 01:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E3D18A93A;
	Wed,  6 Nov 2024 01:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOhjAYou"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF0B188CC6
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 01:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730857239; cv=none; b=jQp4AOJ90Dkm8QALp3uyyd/GzYAUpPXpu8gLwxNyM6T5Gi7wywE7xIv50kYyTdfYdBQR4tFNtOpgKMpFJxqgZ0Wu6624WwYx6AifnlEpjETuIhmZXUCMdfneI+mhxdczVAaAQmwl821/h7JVlTS9yRDfRc4X0UnMSFHo9sriQTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730857239; c=relaxed/simple;
	bh=+8yIKFNxFh6YclIVOQfw2dlPbRI1IuC8/c83jc0Ix9Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cPxpX0ruIzy/HZoJXeh5VRN8+SkQcw3oZ4BYNAkWGV2uxlFQScfTgvED41aWZfeh0c39u/EShRauPCak/ttJyvzV2ptNGkl/fHSDG2T+oyUYZMMD7T9LYfh8eOD8EuEqzSYKPK9r617R0Mor8am/kXfz+I3Wo5FwcIdbOVtfd9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOhjAYou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9886C4AF09;
	Wed,  6 Nov 2024 01:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730857237;
	bh=+8yIKFNxFh6YclIVOQfw2dlPbRI1IuC8/c83jc0Ix9Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OOhjAYouUUZjDtTSDBrRt2m4bq2L3NgTM8jWq1sxrRCvd+Uid+iq9Vkl2nkO7OBGS
	 lGFtt7Q5fL/u2+sejzWpRRe80wAl5nSOWgabo9B0Ly2+2djHOKJc/WZT3+rB5rxxPW
	 9C55odhF/w0SZntH6Ajp6IoSPhv6L5ARKnNO1wvjRjfculz6AGwk1x69otqkqS9C2q
	 904IG050ccovYlmV/3c4rsl3YI5G9+Awjj/nFbu66MSxctMi83y7jwUZVTiHgIpTfK
	 L3uOAQT9iHL0doh0wzAUBNzNt0K+rp90NnNjwg+K62yanGTR0v7V+6Rm46wo2zJ/na
	 EeClSNwRCad4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD453809A80;
	Wed,  6 Nov 2024 01:40:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: improve initialization of RSS registers on
 RTL8125/RTL8126
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173085724649.759302.11455173324217886714.git-patchwork-notify@kernel.org>
Date: Wed, 06 Nov 2024 01:40:46 +0000
References: <3bf2f340-b369-4174-97bf-fd38d4217492@gmail.com>
In-Reply-To: <3bf2f340-b369-4174-97bf-fd38d4217492@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 2 Nov 2024 14:49:01 +0100 you wrote:
> Replace the register addresses with the names used in r8125/r8126
> vendor driver, and consider that RSS_CTRL_8125 is a 32 bit register.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net-next] r8169: improve initialization of RSS registers on RTL8125/RTL8126
    https://git.kernel.org/netdev/net-next/c/2cd02f2fdd8a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



