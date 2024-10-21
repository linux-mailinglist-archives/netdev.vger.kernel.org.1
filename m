Return-Path: <netdev+bounces-137442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 538599A6614
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 13:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD23BB20D69
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 11:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE0C1E4113;
	Mon, 21 Oct 2024 11:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOPuzjMe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8522D194C6B
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 11:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729509023; cv=none; b=EhXRI7pDhTWZRU1ylIOKkaDDDcGvPQoU2IkcBxqVJZXVFu8CSNvQDJOu+1GA2FTT6w2kCiZQOUTmaGhTzJSSDUoZOropFiUse/3Isfn4lRyyCcGLLmad3cab+MsBR5S8WaLJ9MC3RfXX5JEP81B3kYMn3lsfaJBVk8X8Q9pNT0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729509023; c=relaxed/simple;
	bh=7k3WMZLopZpptnzqDj9MmdysCMRgfWGYpA6mAVdEnUM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fpx0rghb+OBuDqxUHei1okkE2fn8nKOSWXIPFq7EhCHlGIgrwKyAYKE2pFJgCi48cUf/rcO8rTKDsWyDFXIRTQd7hUiLuaejxemc2SXlVmHpJ3G8TqA2WqwEsoaggrES6a6b+bmW07UxVXrwJJCP/wL+YXkIN+3MOlPvGXnzRzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOPuzjMe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B9DC4CEC3;
	Mon, 21 Oct 2024 11:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729509023;
	bh=7k3WMZLopZpptnzqDj9MmdysCMRgfWGYpA6mAVdEnUM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EOPuzjMeVsFZrDRBhvBnsG7unn4yJGyDnAnRDwYWunIrG5tMDNCOhbwhtuyzjCD5J
	 897nMeAJZKPHYZqRpM8zMUNwmNDn/X+JGvxHMFxbovRB5ikxClXcbKKlPJqoiQfioB
	 10nNppzSFy1vXB3Vhdcc5U7qzBpyxN45R0iI4J8fe3qkLzQEwdax8QB6mhetPlo7I6
	 wl/d5M283gzsY1m3pyM+X4F2EpFv1Wsp6VNt3Ub9upGW/WKFzgqc6FUxpG4XVu6G3M
	 6f99MRuCFxUrWwAccz9wi1fWaR7PHuIvWP4cKo8O9gZ8pfAApAhnjR9M+oVGIW8bkB
	 UIk3h6XkSRBDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CA43809A8A;
	Mon, 21 Oct 2024 11:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: fix races in netdev_tx_sent_queue()/dev_watchdog()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172950902900.217933.2929178610738073203.git-patchwork-notify@kernel.org>
Date: Mon, 21 Oct 2024 11:10:29 +0000
References: <20241015194118.3951657-1-edumazet@google.com>
In-Reply-To: <20241015194118.3951657-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 15 Oct 2024 19:41:18 +0000 you wrote:
> Some workloads hit the infamous dev_watchdog() message:
> 
> "NETDEV WATCHDOG: eth0 (xxxx): transmit queue XX timed out"
> 
> It seems possible to hit this even for perfectly normal
> BQL enabled drivers:
> 
> [...]

Here is the summary with links:
  - [net] net: fix races in netdev_tx_sent_queue()/dev_watchdog()
    https://git.kernel.org/netdev/net/c/95ecba62e2fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



