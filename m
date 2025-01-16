Return-Path: <netdev+bounces-158872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B10CA139D4
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 13:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D81407A5004
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 12:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EA61DE884;
	Thu, 16 Jan 2025 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zgl57AQF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A12B1DE881
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737030011; cv=none; b=qrUvTbvCkhsE8WYq2NXJPhVm4TuLzJFQa84EzQ/TE6ywKcjxx7V5L/wtQIU/+GnkSFtFRHdEiCa3LS++EKoxifDIea2MP4eHSnigi/nMqYkFb8OX/GwjQ+P3Hlgsrlre/9Wc7qX5kJFSSwAHyn+1Jr0t+6zgTVmBBnRRJ8Zr6rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737030011; c=relaxed/simple;
	bh=j44ddHhb5lqOi8+uP/S4bL392bZ7sw/3T1yDaT7lnDA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gZ84OQIaYv9sBNj48UH1ehF9pBQWSEA/jZEEKPDk5nkKbmVsOcBNfOUBj2iNGnD6LvJry9D1P8uIEFKwr3/aCrbMg4UIzc8bCETrfQbm9+X6O6WWtXp9krbiEQBxNaY8pSRs3xSONWPPX5t1lzrodvDTgYaDkuC/qg/uUqVrVbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zgl57AQF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB01BC4CEE4;
	Thu, 16 Jan 2025 12:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737030010;
	bh=j44ddHhb5lqOi8+uP/S4bL392bZ7sw/3T1yDaT7lnDA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Zgl57AQFH31O98ZPcRlKRtH+BLX4aCzkNLI8IF99c8cZry+HY2Lxk31Q+0SJ4caEL
	 HiJBBWe9ICwm4f2g2+Wvj1Y2sgGR3y4IhYJKTQHZEHLpRsDSAfhcII9DBKxmq9vCli
	 n4+RcOArqD8CvX0TOLEmsSNhW+I6mS6pqDHZEAXqsfNGpMpxnnBNgtgexcL3wcTmMt
	 NPSDDfFvNQYXBtWqOicHChY9xp3+JCA4GpCiLBu2UalBBDqulaTT4A/DBjOyiBNGFI
	 2n1UCfuJII4xowBi2M3qTYogzcEyHLhjB+hJSGRXj8LKiMsH9RlDnK7K8m/WsmO9F3
	 2Ccz+4EY5Y4bQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C35380AA62;
	Thu, 16 Jan 2025 12:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netdev: avoid CFI problems with sock priv helpers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173703003374.1435910.6006607918623329312.git-patchwork-notify@kernel.org>
Date: Thu, 16 Jan 2025 12:20:33 +0000
References: <20250115161436.648646-1-kuba@kernel.org>
In-Reply-To: <20250115161436.648646-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 dualli@chromium.org, donald.hunter@gmail.com, sdf@fomichev.me,
 almasrymina@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 15 Jan 2025 08:14:36 -0800 you wrote:
> Li Li reports that casting away callback type may cause issues
> for CFI. Let's generate a small wrapper for each callback,
> to make sure compiler sees the anticipated types.
> 
> Reported-by: Li Li <dualli@chromium.org>
> Link: https://lore.kernel.org/CANBPYPjQVqmzZ4J=rVQX87a9iuwmaetULwbK_5_3YWk2eGzkaA@mail.gmail.com
> Fixes: 170aafe35cb9 ("netdev: support binding dma-buf to netdevice")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] netdev: avoid CFI problems with sock priv helpers
    https://git.kernel.org/netdev/net/c/a50da36562cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



