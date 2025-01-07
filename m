Return-Path: <netdev+bounces-155647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B4CA0341C
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 01:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4DE47A22B5
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 00:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E4C6F073;
	Tue,  7 Jan 2025 00:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6WMz7dc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0434C5674D
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 00:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736210417; cv=none; b=HOUA+0hw8AGdCfPjH4aVXlrV+SfSxvMTfg4EH7D/HvXXFD7pTThRkvaW+NJedGqGGt3gcgyWnb19YmlonIPICdG/rLjjRa99QCkzM9CbjAD0dMV63AhT3mrEh+zlLie3ekS6XPtS1PrB1l1rc+Dm0er1IYefEfKG0b8hDz99mSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736210417; c=relaxed/simple;
	bh=usHerIzfxMut+i0ycSY3XYucco2T+7loswuUwZ/M4Kk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rnuKNIpranZyuG1VaRrd51UBWEfj2x84v3DHTkdbbKJ1QxCEsxU6Y15g3C+kikS1iV0gBpGgo3xcTE3EL2a/MMr+Q2XfQnzmgpbD10i3Kl56kctyc4YQZ05C6MQ/42FWFK3OhqHWkZF6EAPwUsUVMf2iODFLyE6sAHZhufg1tu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6WMz7dc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853D9C4CED2;
	Tue,  7 Jan 2025 00:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736210416;
	bh=usHerIzfxMut+i0ycSY3XYucco2T+7loswuUwZ/M4Kk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k6WMz7dcVvakjbCk8wV8+VyXccf6V12x64shjrxAf/uD5VIm+keUYOH7h/CLlbT3p
	 VsURchn5OmX8D6Mexh8yYJSTsLIyOnVKY5X7f4HvaUkwBxy7o1BpVjFK74VBMo68QT
	 YStNqjUrEJ0MiiXY5sytOwhyF2WKJq9Lf+M79/a+lwi8ZbU5Tue5Vk/Q3wzHMrjiFU
	 SqyOaGZb/dJSb60yAMlF85O2CTFDHwiVXhXsl6upeTEQlGNbY2X36N5bJhL9HKEDhe
	 lvyHqdRWZoe9qPNrKglkmDKaQImu70PsZJlFHeFMusD+UBD3Q9VXvTmhz3taYHhmDT
	 c/rSFiegXv57A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD8A380A97E;
	Tue,  7 Jan 2025 00:40:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: hsr: remove one synchronize_rcu() from
 hsr_del_port()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173621043775.3661002.11789058676616894426.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jan 2025 00:40:37 +0000
References: <20250103101148.3594545-1-edumazet@google.com>
In-Reply-To: <20250103101148.3594545-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, horms@kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  3 Jan 2025 10:11:48 +0000 you wrote:
> Use kfree_rcu() instead of synchronize_rcu()+kfree().
> 
> This might allow syzbot to fuzz HSR a bit faster...
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/hsr/hsr_main.h  | 1 +
>  net/hsr/hsr_slave.c | 4 +---
>  2 files changed, 2 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [net-next] net: hsr: remove one synchronize_rcu() from hsr_del_port()
    https://git.kernel.org/netdev/net-next/c/4475d56145f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



