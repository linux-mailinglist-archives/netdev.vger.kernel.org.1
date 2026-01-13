Return-Path: <netdev+bounces-249298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAC5D16833
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 04:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3DB6C3014EAD
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 03:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBD134BA40;
	Tue, 13 Jan 2026 03:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIyCsmJm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B667348867;
	Tue, 13 Jan 2026 03:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768275229; cv=none; b=Iogvv0HSrqf9tNFfHMAvmnzeFG7KOORgBkROuk7Hy9Lyp/WqQBw2t+T4nSIwni5ea54MZLkbkPXAQT/t9exjq/bpMN8zd19+tHCPtLabi5So0IngP/7K3vz/v7cEkHPJS3V7ED3BGufb9LPyN9gu76jg2x6DVODYpDew2H7xEl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768275229; c=relaxed/simple;
	bh=ld+qFM8NumkkJhVgGWM2NGa658xtCNZfXHqL66y0wiI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A20seCeA3NEaKfF2djWfNHffvvnkm+07K1O+ySaCGmXGmXg6iInWVsfeNJYLHHjUzWufbJdr/Gon1hTRoK5oiwFwWnK8YqFZuYVQekBgeZqtzqmj75kUcIj97UnCCPsfkdXR+hWziQZB4q0gnNr3n8CrBOzMPGbgj7Op/fw/ieI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIyCsmJm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4058CC19421;
	Tue, 13 Jan 2026 03:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768275229;
	bh=ld+qFM8NumkkJhVgGWM2NGa658xtCNZfXHqL66y0wiI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RIyCsmJmYZMh4yemF20efGeUZiVDqQc4UEyAoJzXHpCjYrbrYwJLVtjdIUab0DRTM
	 dviL8rDqbDWu2UyLbofRkPIJh7eXEB7v+owzT4QJddw6g64Cfh79zeieEb5mCDIf5/
	 lo7nFSz4VZNprAYcUGNW1ZTgQ5wjl2h+fwwqffB2Yh+Y1xmfqKp55YdkduDNydLwid
	 jw1ilCqpLx2XyermicAvcwEhgAubXIYcjQDIO2hFCwSd67xRywy1s73CWO5Zg+en++
	 /roatzWW7g6Q6eguHhbc3v9RBEYoyyZCk0P5i9tQbSwrPOjgDwanFJjOHHM88omizv
	 r9LlqiyWHjryA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 37583380CFE1;
	Tue, 13 Jan 2026 03:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: mctp-i2c: fix duplicate reception of old data
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176827502277.1659151.11890329379549397516.git-patchwork-notify@kernel.org>
Date: Tue, 13 Jan 2026 03:30:22 +0000
References: <20260108101829.1140448-1-zhangjian.3032@bytedance.com>
In-Reply-To: <20260108101829.1140448-1-zhangjian.3032@bytedance.com>
To: Jian Zhang <zhangjian.3032@bytedance.com>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  8 Jan 2026 18:18:29 +0800 you wrote:
> The MCTP I2C slave callback did not handle I2C_SLAVE_READ_REQUESTED
> events. As a result, i2c read event will trigger repeated reception of
> old data, reset rx_pos when a read request is received.
> 
> Signed-off-by: Jian Zhang <zhangjian.3032@bytedance.com>
> ---
>  drivers/net/mctp/mctp-i2c.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Here is the summary with links:
  - net: mctp-i2c: fix duplicate reception of old data
    https://git.kernel.org/netdev/net-next/c/ae4744e173fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



