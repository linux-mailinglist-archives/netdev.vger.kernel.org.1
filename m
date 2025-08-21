Return-Path: <netdev+bounces-215537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F13B2F1A1
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 10:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 866EB1CE1DB1
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 08:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A332737E8;
	Thu, 21 Aug 2025 08:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoiKTnF6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED771F4C8E;
	Thu, 21 Aug 2025 08:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764398; cv=none; b=kySndcd1kRxoWCxOpWF2GB9GuWM5GWNHUmNswsSRy45WzFSqb9O4L7VBsBQ0lQF2GpGflqrVIRfZI1Skj5eBrzDwl4FZdeVUtDJ2Yk12pB5oLBQnQ2nHFU8HAIpOGkTsNez95ulHGa3376yOicIkdFNS/0+Vo1xqa3yiZlPparg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764398; c=relaxed/simple;
	bh=NyFmdauxMhgbA7Oonju31Ha2eCezb5EXSKerkVHtnR0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cPXq3vA3dARtkq3oFFJw5ggyFfdpYGl/emNAfENIPPny0OO6WvJNjCrZim6cQkeoGSU2Kp4CGAiWoe1VsHuwcZDM+B+1lyzcUvu9zZMy0hOmk/eYezFjboMtm8EQbAM8++ab9yJrTzCC+dLuo+pYhdnL4H8bv1ujDPFQByQsLtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoiKTnF6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D8CC4CEEB;
	Thu, 21 Aug 2025 08:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755764396;
	bh=NyFmdauxMhgbA7Oonju31Ha2eCezb5EXSKerkVHtnR0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OoiKTnF6OTYamZ1tRIZ9V6FX1CjLJplI+QYtVGA+/eWfkPZDO0Spt6gy9oTqIxbtH
	 scTXwJCkYAu4Dws7trGmsfCP3Z/nBp5FGPdbIbK0mqY3fp+TRenANxz39X84C1/knj
	 ljckTpa4U8dI/Pbdu5geYsDRZ9VNdA+ztRki08Zf/GZQre0LHazMnz/HWUt1+ZS5Ab
	 Cn9UDKpnV6/17ADpHuWdY3V7dB6v88h/up/7I0QdYQ8eqIHfyiLZ4TaN/1vFYI+jtv
	 Z0cYdvs61d0jgryZXNHJqvq8f/P8l6o9XU5fp8/Fz7Y7e4hnUIUaoES+TpFG9CxTh1
	 6XFDCy4JlBj3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E85383BF5B;
	Thu, 21 Aug 2025 08:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: pktgen: Use min()/min_t() to improve
 pktgen_finalize_skb()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175576440602.934305.17939332102559736776.git-patchwork-notify@kernel.org>
Date: Thu, 21 Aug 2025 08:20:06 +0000
References: <20250815153334.295431-3-thorsten.blum@linux.dev>
In-Reply-To: <20250815153334.295431-3-thorsten.blum@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, ps.report@gmx.net, toke@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 15 Aug 2025 17:33:33 +0200 you wrote:
> Use min() and min_t() to improve pktgen_finalize_skb() and avoid
> calculating 'datalen / frags' twice.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Changes in v2:
> - Use min_t(int,,) to prevent a signedness error
> - Link to v1: https://lore.kernel.org/lkml/20250814172242.231633-2-thorsten.blum@linux.dev/
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: pktgen: Use min()/min_t() to improve pktgen_finalize_skb()
    https://git.kernel.org/netdev/net-next/c/833e43171b00

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



