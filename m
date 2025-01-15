Return-Path: <netdev+bounces-158669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D6CA12E9F
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 23:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5882F164F1D
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 22:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A2A1DDC11;
	Wed, 15 Jan 2025 22:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKAJByFK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215811DDC0B
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 22:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736981414; cv=none; b=IRTMD6saMPwrL0zW1MBuxZYRVA+aBvLkyHlbmhOP4uwCeKY9woQx60FZZTIWcToqboBfgVWzDNDfB4I/ZCl79UkyYnObgUejs0iOCExIymXORTt2KXr4lauSDcqvkWyi6MS0dvD7/XSvkWE3zAXYOL5rCih6q0Q2u4dwxH6CCWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736981414; c=relaxed/simple;
	bh=BfmysXEs77QYVDhJJ4igQqo6rMGdlixn1ERSXRTckLQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uRzYBI1m1Ts66Kn961D4/yyfJe5259+5AoDHLveFFIXWGpq18LI78tXnCjIPHqwPwXTM5LvPmQWHaORNMY4A8nCH+m5izTZaRF3nhSIZOTUsLz3zOSSISWc0X8v8R3YCy7RCSJsDsto1xLwEUMH9FP7uY80Q8kEl0OhU8DIu/I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKAJByFK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA55C4CEE3;
	Wed, 15 Jan 2025 22:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736981413;
	bh=BfmysXEs77QYVDhJJ4igQqo6rMGdlixn1ERSXRTckLQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nKAJByFKLELZY7R+sq/uLHSCd+nuDlYR9S2nTNTmqeih72hXiRqus3lVnQCyBY3Wb
	 SnSOOo5Ahsksb1cGJ/CdyMHKhjEkP3U+YiJeG+SSVv47EkiJG5dtD2gzksZ+fPIvy1
	 3Ugs0JX9BUup1aB5ykCJneKvcx3IIEUaIcertVdIP+ER6KXbB3g2LpgG7AYKZksjgy
	 IwOjc8oOIY3l+roS0isc5ViYo9eqRPbFRQED+/B/vaXw8MEdJo6E4xD9IYnQqZTJSF
	 KQczVVKeRSvLjfBOaCjHxzc7FWpkY6vMaCEVvf1hmNuY6UIpdz5dlDOEQRFWRaLrgi
	 +kiVobX/2IRqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC2A4380AA5F;
	Wed, 15 Jan 2025 22:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] net: loopback: Hold rtnl_net_lock() in
 blackhole_netdev_init().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173698143650.903583.8155783530492632250.git-patchwork-notify@kernel.org>
Date: Wed, 15 Jan 2025 22:50:36 +0000
References: <20250114081352.47404-1-kuniyu@amazon.com>
In-Reply-To: <20250114081352.47404-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Jan 2025 17:13:52 +0900 you wrote:
> blackhole_netdev is the global device in init_net.
> 
> Let's hold rtnl_net_lock(&init_net) in blackhole_netdev_init().
> 
> While at it, the unnecessary dev_net_set() call is removed, which
> is done in alloc_netdev_mqs().
> 
> [...]

Here is the summary with links:
  - [v1,net-next] net: loopback: Hold rtnl_net_lock() in blackhole_netdev_init().
    https://git.kernel.org/netdev/net-next/c/2248c05340a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



