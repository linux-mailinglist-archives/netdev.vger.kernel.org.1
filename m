Return-Path: <netdev+bounces-208731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F3AB0CE9C
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 02:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 508261AA0360
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 00:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D36BEC5;
	Tue, 22 Jul 2025 00:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdKkbVnO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138EBA32;
	Tue, 22 Jul 2025 00:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753142988; cv=none; b=sZomCSsdmBWPVRFx44+oZGs9ywH6aY9/ZwQ1zOOiQsOXyVvqSPZ9cCc9IB36bu3X4wMtcaaDP1WXh/ZuUqPEoHIw5QZLqUY/PxxMgXcmbgITDQP5A++MAzeAMwvkRNujdrm9k3QqmcQ5Ql+TTyrHp3z1DTlLDEiDWcWmEHTfMuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753142988; c=relaxed/simple;
	bh=xElt16jMokiTAI4pjYxxd+MfCABOTQfiea9gnreY4rQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BZ4UJLgTt1b3Yyib3lWF2V7HI0rSMC4YJzBkfzFHyz3iMLeQ1KmMxo6zYhJvDb2dZbMnyn3kFpSKhMbaCxk+SzBwalVajzjc/AAYq3EjFJ61lZE55W2rF8oh6V6ARoQhZB1Ua71T7BYbXnpoV6tPBltDfKiaZF+ONmAnWcAnbf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdKkbVnO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B1CC4CEED;
	Tue, 22 Jul 2025 00:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753142987;
	bh=xElt16jMokiTAI4pjYxxd+MfCABOTQfiea9gnreY4rQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TdKkbVnO5k8mQ3T95tpqRJOJnH/U5+/6TPCe85wRr8ykhYyahriykx6TgIOQITbmJ
	 y7oATVd2m4mqQ5OC0If0Wa19NT/pGnGszK8AQxA2nITbhs9BOIpfcx8+pnVw5y1hkR
	 uEM7Vk/roNeKYCiWieZMJebD6+2JHyio0utWuvp6PW7gKACWByykuu7FPmbhD30uYt
	 7wEIebJGT9K4Ep7B1n4F0VBytGipBV5CE5BUbbahnAQMUsrM5PgNTPKoZ0yS+mY2+5
	 60DQK4chPtK3WnsqosXv08A5zz0B4GdNMSNjiA79p7ONSb1+Z1BvzWwOoRWS5I+6TJ
	 ipI5NFCaAjcog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E21383B267;
	Tue, 22 Jul 2025 00:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: appletalk: Fix use-after-free in AARP proxy probe
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175314300625.238860.12795177023377657376.git-patchwork-notify@kernel.org>
Date: Tue, 22 Jul 2025 00:10:06 +0000
References: <20250717012843.880423-1-hxzene@gmail.com>
In-Reply-To: <20250717012843.880423-1-hxzene@gmail.com>
To: Kito Xu (veritas501) <hxzene@gmail.com>
Cc: kuba@kernel.org, Yeking@Red54.com, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org,
 mingo@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 tglx@linutronix.de

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Jul 2025 01:28:43 +0000 you wrote:
> The AARP proxy‐probe routine (aarp_proxy_probe_network) sends a probe,
> releases the aarp_lock, sleeps, then re-acquires the lock.  During that
> window an expire timer thread (__aarp_expire_timer) can remove and
> kfree() the same entry, leading to a use-after-free.
> 
> race condition:
> 
> [...]

Here is the summary with links:
  - [v2] net: appletalk: Fix use-after-free in AARP proxy probe
    https://git.kernel.org/netdev/net/c/6c4a92d07b08

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



