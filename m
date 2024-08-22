Return-Path: <netdev+bounces-120926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2490595B380
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 13:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C81721F227EA
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 11:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C638F183063;
	Thu, 22 Aug 2024 11:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/bqPNuE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935A817B505;
	Thu, 22 Aug 2024 11:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724325026; cv=none; b=XPMzqx/DhTYsoqMs6aMMHJlowAm5PUylGFg2+LIP5X+I0Q4mFjsrCZiKvfyBfBBMZndIgLGY2irx/ZMD0ui2T4OqF0JkNu2n/vMXW1Qbc43jKe0CtDNST5l9GdsKgbDBdYXsf3m3dppTsC5hvE7vwSVazrxTaIQYqgSV/ZLokt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724325026; c=relaxed/simple;
	bh=JGjCvrzTNpYXYbWrH8AMK6WJfMGBOhy8bGcxvlipAFk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Yn16u7a0/MZvqkdoX/aphsM+9LSGLSuyuYFSyo6snICLdai0YaTphmLOyZq3hyh26RA+NktpLfAC2F1wB6nUBasXap3cPyY1zzgW97TSsCJue2lY0+n/1ORAGxtTjfPonaN9d/QvR2DR9BWYFx/2j7BhPiJGSXvekcOq479tzWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/bqPNuE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16251C32782;
	Thu, 22 Aug 2024 11:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724325026;
	bh=JGjCvrzTNpYXYbWrH8AMK6WJfMGBOhy8bGcxvlipAFk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J/bqPNuE99xWsmVHH9R8sf3CBUxrVMCAiBQDAXvtAHCa/ZJF/pe2Vv8n8k8M6lMH6
	 zw7ycni10afAWT326gBiOVMZl9RTUx34UF6oBM8grcI02VGFP4DV0ZIJ9zI0TO+ocQ
	 P2TucD+uUCACeYTFE0KvXDu0m0vbQEMF2OtIGGwJsuIgJfU1i0Zl+0r8Hn/edfdH+q
	 9Pepdl6ovvondMZEuKjaoK8XE41bAhdN4fS9I1l57zEuEMY5PYvxdweluYKRg5gkSu
	 fTbdvGdVQf4TsJ9LUjsguMJ+XeTDZNJzVQf5avY1jTs0STa6mgZCnsK8VS6+PdwgVb
	 qNlsN7H+slUDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE5A3809A80;
	Thu, 22 Aug 2024 11:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: phy: realtek: Fix setting of PHY LEDs Mode B bit on
 RTL8211F
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172432502550.2289496.6882132928249081221.git-patchwork-notify@kernel.org>
Date: Thu, 22 Aug 2024 11:10:25 +0000
References: <PAWP192MB21287372F30C4E55B6DF6158C38E2@PAWP192MB2128.EURP192.PROD.OUTLOOK.COM>
In-Reply-To: <PAWP192MB21287372F30C4E55B6DF6158C38E2@PAWP192MB2128.EURP192.PROD.OUTLOOK.COM>
To: Sava Jakovljev <sjakovljev@outlook.com>
Cc: savaj@meyersound.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, marex@denx.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 21 Aug 2024 04:16:57 +0200 you wrote:
> From: Sava Jakovljev <savaj@meyersound.com>
> 
> The current implementation incorrectly sets the mode bit of the PHY chip.
> Bit 15 (RTL8211F_LEDCR_MODE) should not be shifted together with the
> configuration nibble of a LED- it should be set independently of the
> index of the LED being configured.
> As a consequence, the RTL8211F LED control is actually operating in Mode A.
> Fix the error by or-ing final register value to write with a const-value of
> RTL8211F_LEDCR_MODE, thus setting Mode bit explicitly.
> 
> [...]

Here is the summary with links:
  - net: phy: realtek: Fix setting of PHY LEDs Mode B bit on RTL8211F
    https://git.kernel.org/netdev/net/c/a2f5c505b437

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



