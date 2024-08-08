Return-Path: <netdev+bounces-116947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 501BF94C28A
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 18:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 086941F223F6
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 16:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FB919148D;
	Thu,  8 Aug 2024 16:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJ5LQ4gS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8ED18E02D;
	Thu,  8 Aug 2024 16:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723134043; cv=none; b=FXnXgGbdrm12ClAaSZiSd4RfgD4oiOuE+Vq6nyWQFVgJ5Nh/DYCp/0PjW+x0dr90rikf4KbBVTwTZF2PZbX9lWLmFWX/XpYpQo0Mnmw/eM79vovc4C9y84FlIOWm5JdskPyW71d2SxpW/PE2baoZNkHKvRBDpR961Be/bWAm+Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723134043; c=relaxed/simple;
	bh=/ZsZ+Z7HYAE5RdzRe9M2LUYLZzaBzS3/nxnK6+ZBj6o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=joXDquuDQ3sBZsZKK3cakA/NkrA3dutVViGyTHMPPRn5AeL88DjMdwIMeJzJPTNDixNesYBsEKLbKQqm63PsKQ9sm6kssfSWHJKTBPNhPYWexi2SRAF5lNc8yqZuS3hZhGlOy/pRDvCDi5qR0lXTSvuxu6+eFv0geeXKDV9ND8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJ5LQ4gS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94387C32782;
	Thu,  8 Aug 2024 16:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723134041;
	bh=/ZsZ+Z7HYAE5RdzRe9M2LUYLZzaBzS3/nxnK6+ZBj6o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rJ5LQ4gSxcZNVwl+VjmtYd9OsNvyCamK6wyCpWlQFhP9qArphzXEh7WjquJ2VkGW9
	 XRTDnCjwtj8sMgFgLEk8F/gykhpPAm5dvb5YhSp4BKcBAC5QX9Wp+i8hnhgHRPRt3Y
	 tUioyo7V2BgZD8rOmtR0QN3twEkKXO+nri4II8WaaKYUpkTO5xD2hOcogI0UdtXUIj
	 wUuDdpYll7Ms0ImNblOts8p2QgyDbmdrX+m5nt9b9n10Wzr3XGzUKvomYp6/KOIxTM
	 fSHiQgx4TR9Qt3CxKy+LcjQYg8dVn2u3QM9bZkD2OnDJ0ZSGInv1xiuVqrgyInwX4p
	 tCoCLPcoYXjgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE26382336A;
	Thu,  8 Aug 2024 16:20:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH resubmit net] net: fec: Stop PPS on driver remove
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172313404024.3227143.9358152908749582476.git-patchwork-notify@kernel.org>
Date: Thu, 08 Aug 2024 16:20:40 +0000
References: <20240807080956.2556602-1-csokas.bence@prolan.hu>
In-Reply-To: <20240807080956.2556602-1-csokas.bence@prolan.hu>
To: =?utf-8?b?Q3PDs2vDoXMgQmVuY2UgPGNzb2thcy5iZW5jZUBwcm9sYW4uaHU+?=@codeaurora.org
Cc: B38611@freescale.com, davem@davemloft.net, l.stach@pengutronix.de,
 imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 festevam@gmail.com, wei.fang@nxp.com, shenwei.wang@nxp.com,
 xiaoning.wang@nxp.com, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 7 Aug 2024 10:09:56 +0200 you wrote:
> PPS was not stopped in `fec_ptp_stop()`, called when
> the adapter was removed. Consequentially, you couldn't
> safely reload the driver with the PPS signal on.
> 
> Fixes: 32cba57ba74b ("net: fec: introduce fec_ptp_stop and use in probe fail path")
> 
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> Link: https://lore.kernel.org/netdev/CAOMZO5BzcZR8PwKKwBssQq_wAGzVgf1ffwe_nhpQJjviTdxy-w@mail.gmail.com/T/#m01dcb810bfc451a492140f6797ca77443d0cb79f
> Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
> 
> [...]

Here is the summary with links:
  - [resubmit,net] net: fec: Stop PPS on driver remove
    https://git.kernel.org/netdev/net/c/8fee6d5ad5fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



