Return-Path: <netdev+bounces-203517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C23AF6406
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 23:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 356904E32D9
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 21:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2E72D46C4;
	Wed,  2 Jul 2025 21:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfS18JJA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88F82BE656;
	Wed,  2 Jul 2025 21:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751491786; cv=none; b=o6AroeKAoMT3QjBQlWdrmOnpmjpwPikqodq24CyTkr1EZk7Ju7xTc5GR+omfh4mbuMcMofG5bnr440APl5g8ScejOIgOsh1Jh3uixG04kkHrypVH01suiiIMjMgZ7V6kPxouf61ohdxgLLtB0m+L3Erj+hrORmXUbo00QamKOX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751491786; c=relaxed/simple;
	bh=0WNEst3sBeqmgcUmIKzjp8s/Qwi8FrrcsJxDKg7Ym1w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GfXdxSJDjj859tdGLKAVNFrA+rG/LVcjkHn20KArPzYbHMjgfw7rWxBRBdC3q/EpLS2kGu+k9VxgF9rqO6PtZpe1I9k9sky0wM56EATetHfbXx2g8zON+nIAqXzbhr50QYB7DjJDK9wH4FclFAkat89BN7tE3XJZUVMUf7oSqvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfS18JJA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81169C4CEF2;
	Wed,  2 Jul 2025 21:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751491785;
	bh=0WNEst3sBeqmgcUmIKzjp8s/Qwi8FrrcsJxDKg7Ym1w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NfS18JJANYUxJH9ISefFms7MtV7+AXIV0SzQUkrIm0wBiqDKXAQ9lJmvODN+ZDtoJ
	 edX4Fod5+FSR1dZqv0Dgo3pjOc3SyjyupnkGWVDu43LE3zm3DPH/E1NCji36YwqBE9
	 zKZ3rZ6da3Krvj0bSG2niC9/+ydgexba3TwxuROLFGa7VGUZ1mkmZwhThrp5jMKMJ+
	 Oicoj4MsXhXOx4phQONxtDlsDpKdGEr1rzLbv2YgjgTdoewqVazQgsFyK76SRBeN4O
	 h6yAiedu5e5LYwmVtSLTcwMu+G15EmIh00lOyjHI+AXGkPSzWiz1q1jaziuryGVfTm
	 heDcexoDeuE2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D68383B273;
	Wed,  2 Jul 2025 21:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: thunderbolt: Enable end-to-end flow control also
 in
 transmit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175149180975.869841.11361314397733527763.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 21:30:09 +0000
References: <20250628093813.647005-1-zhangjianrong5@huawei.com>
In-Reply-To: <20250628093813.647005-1-zhangjianrong5@huawei.com>
To: zhangjianrong <zhangjianrong5@huawei.com>
Cc: michael.jamet@intel.com, mika.westerberg@linux.intel.com,
 YehezkelShB@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 guhengsheng@hisilicon.com, caiyadong@huawei.com, xuetao09@huawei.com,
 lixinghang1@huawei.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 28 Jun 2025 17:38:13 +0800 you wrote:
> According to USB4 specification, if E2E flow control is disabled for
> the Transmit Descriptor Ring, the Host Interface Adapter Layer shall
> not require any credits to be available before transmitting a Tunneled
> Packet from this Transmit Descriptor Ring, so e2e flow control should
> be enabled in both directions.
> 
> Signed-off-by: zhangjianrong <zhangjianrong5@huawei.com>
> 
> [...]

Here is the summary with links:
  - [v2] net: thunderbolt: Enable end-to-end flow control also in transmit
    https://git.kernel.org/netdev/net-next/c/a8065af3346e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



