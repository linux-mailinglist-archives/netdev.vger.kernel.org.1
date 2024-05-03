Return-Path: <netdev+bounces-93380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FAD8BB712
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 00:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3792B1C22A71
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 22:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3C6824AC;
	Fri,  3 May 2024 22:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUQDGUrp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D8282492
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 22:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714775429; cv=none; b=aWDZZXK4mDKaTiH0oi+7oEhZR+jpwwQ2VcbpjuvdfeAiYHDFEjao8sFi33F0huH+jiGLxggfXF3dcPWpg8aIG8QTZZC+SyFb2h9MlE+7smMwiAPRKXvKzb6ZAY2/frM7ZS6fLMZXlOZM7dbFCdrjrflhnIJE4RKUy26XFARNaIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714775429; c=relaxed/simple;
	bh=61DCARPmnDZoCM/eTUnKz0etgpvl8MO5yvPqNhXqyvc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qy8Nf7DPxO5PqMMr3hYJ8uE+a8KFikzPH6BasYLcUZ6wDOCghM7g82rjsWi5ftfooMhcygrBSqBAMUnBSCx4PlVNJU1deNcQTtlSZnfwwELGDHpohazxcOBMcLBZSA7U7um/tBJNn0l2NpNsojNSJYhOO9lLtu7vw7w88Q6TdJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUQDGUrp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12AC1C4AF14;
	Fri,  3 May 2024 22:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714775429;
	bh=61DCARPmnDZoCM/eTUnKz0etgpvl8MO5yvPqNhXqyvc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CUQDGUrpL6riCQz0iAKroGuFOtwuWtCVoQdLvY4LqO3tryblF188ofoIftefr4h5S
	 THfVTRG/fbDRTJ9pmq/pVgJzBnT+8+2+yEbUbGCu6Jjzd2AqdeDOKDZvtRFJG3g8Y9
	 Q6YnPwDwnWLecv0qSA3Uc6uCpUv/W/TnCv+DGFjjzjevn4FAmxkAg/qWa+AyZtgLyt
	 id/XY+NvgneJuNyXB/mf9GT6Rs4QUr3pekf8b6Q4HsKoqur5K0yQLLtBguq26KSiY7
	 V+b9x3jOWuOkuDZrAZGVHsFxBKIyT+tI6f12yVCq9rDauICKfJVdYY4BPWwj/VnwSx
	 cAhDmIvxYHg+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 001D4C43444;
	Fri,  3 May 2024 22:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net,PATCH v3] net: ks8851: Queue RX packets in IRQ handler instead
 of disabling BHs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171477542899.22073.9972190380699224946.git-patchwork-notify@kernel.org>
Date: Fri, 03 May 2024 22:30:28 +0000
References: <20240502183436.117117-1-marex@denx.de>
In-Reply-To: <20240502183436.117117-1-marex@denx.de>
To: Marek Vasut <marex@denx.de>
Cc: netdev@vger.kernel.org, ronald.wahl@raritan.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 May 2024 20:32:59 +0200 you wrote:
> Currently the driver uses local_bh_disable()/local_bh_enable() in its
> IRQ handler to avoid triggering net_rx_action() softirq on exit from
> netif_rx(). The net_rx_action() could trigger this driver .start_xmit
> callback, which is protected by the same lock as the IRQ handler, so
> calling the .start_xmit from netif_rx() from the IRQ handler critical
> section protected by the lock could lead to an attempt to claim the
> already claimed lock, and a hang.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: ks8851: Queue RX packets in IRQ handler instead of disabling BHs
    https://git.kernel.org/netdev/net/c/e0863634bf9f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



