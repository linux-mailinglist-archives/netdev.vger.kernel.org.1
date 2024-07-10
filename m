Return-Path: <netdev+bounces-110469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB20192C846
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 04:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57893282E73
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 02:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119FFAD5B;
	Wed, 10 Jul 2024 02:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwbkXmlq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7938C1E;
	Wed, 10 Jul 2024 02:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720577433; cv=none; b=IVs8Uk0cONwwBEEM5FuN7/hr5HKEiSxd/7bHfuy6jSNskpdS9bWbCa5zK4ZOlMRlMnl5vyG6x5GkPz6o0XJHjE5rpT7UeH1HhisECGGL0TaneA2+Wo+msrP26xnXfRoU4mymGoU6lMhrXjWgl3WqEraM9SyUa7LTh838CaIjO+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720577433; c=relaxed/simple;
	bh=m+5VXtYPcORUmfhv3b7HNMH2rq1aWbV56Jpp9Q43i0o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lzo5H8o4J1MO3uwU6gIBFfPx1bDugxp+bXY8SKvNfmCtp1E56GHfXGFaO+RnvTulywlV1RmaS/OKJ4nGj9wqyetl2YRHu71yhQL5mwH0U/W4MQYiRi/NzYrsPDFizsw49SK/xg5vSa9SZcViASvy/WMOfbsjMZm+zy9JK7PVPkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwbkXmlq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DE98C4AF10;
	Wed, 10 Jul 2024 02:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720577431;
	bh=m+5VXtYPcORUmfhv3b7HNMH2rq1aWbV56Jpp9Q43i0o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AwbkXmlq4h2GHT2JhUM2yoaUT2rTasjRDzS0XtVghw/Act9kv1da/0PD2LqxvEO2B
	 2+v+znIWT1H1zMGRK2ga+uIsW6jgmIRIZdWaEs8J2EZNiYm8NTCw40GSngG3KuYJDx
	 N98bWrecXDSpULM1WZoT882kQ10lWk9W6370BPYvRBQDeQerCZJ0/FaXV7mRmYeicL
	 eM9XvVMZtroJOIoTP8tG5mKhGvpVhAbV6mTqtrPRATXr1URrydX409bd6GtT4wYKvc
	 GVc4acazQwMXM27M1bJwuCOYiyfaK3flYzbtqGK2HeOIqRJDxmqk379weQHE46OrOo
	 dJIthmNQKzWLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4EEF9C4332D;
	Wed, 10 Jul 2024 02:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: ethernet: lantiq_etop: fix double free in detach
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172057743132.1917.14294482519163349153.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jul 2024 02:10:31 +0000
References: <20240708205826.5176-1-olek2@wp.pl>
In-Reply-To: <20240708205826.5176-1-olek2@wp.pl>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jacob.e.keller@intel.com, shannon.nelson@amd.com,
 horms@kernel.org, sd@queasysnail.net, u.kleine-koenig@pengutronix.de,
 ralf@linux-mips.org, ralph.hempel@lantiq.com, john@phrozen.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, joe@perches.com,
 andrew@lunn.ch

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Jul 2024 22:58:26 +0200 you wrote:
> The number of the currently released descriptor is never incremented
> which results in the same skb being released multiple times.
> 
> Fixes: 504d4721ee8e ("MIPS: Lantiq: Add ethernet driver")
> Reported-by: Joe Perches <joe@perches.com>
> Closes: https://lore.kernel.org/all/fc1bf93d92bb5b2f99c6c62745507cc22f3a7b2d.camel@perches.com/
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> [...]

Here is the summary with links:
  - [net,v3] net: ethernet: lantiq_etop: fix double free in detach
    https://git.kernel.org/netdev/net/c/e1533b6319ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



