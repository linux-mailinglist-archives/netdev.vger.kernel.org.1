Return-Path: <netdev+bounces-116295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C83949DE1
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 04:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B845A2873E9
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 02:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B533190049;
	Wed,  7 Aug 2024 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWN5OGX/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C6A2119;
	Wed,  7 Aug 2024 02:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722998429; cv=none; b=EiFi0eo55M/FD6m2jqqemLYAHHAhPrXRQIsr3cQwcov4SN9azhny9ICjI/nfkoqfi1gDeHDhkNeKkayTRvylLgOspkw1N0FDqFDjCCFmoBFUk1XKpkWsvEKRyy+rXrBO0YoTwSSCk5RcGEmv1MQqU10ACHEkjZzv1xwdkn2+N68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722998429; c=relaxed/simple;
	bh=hviNgjEq/RUmB3PKIoaM88TL4OuqaAnF2k5zsmOpGNA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cHuFi2cPbax+O8o90C8NxPVc/yC0uR53JSK7oJefFJBMDJKvyR7v5PT5za9HncCG9KXNaC/arQD9o1Hmt09jVdNeoLMxlXelIQLi4I9+Fyg9bfHiYOfIZkoCdckKy0G4UKKjMqJX7K1D325JTsIXif1AfgbfsksA2O7rxh+rMdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWN5OGX/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7867CC32786;
	Wed,  7 Aug 2024 02:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722998428;
	bh=hviNgjEq/RUmB3PKIoaM88TL4OuqaAnF2k5zsmOpGNA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SWN5OGX/wmENQg+57kxHHQR6p0RfVcOjIIresBx3RCerbUE04m4KSam+rs4lI48WL
	 WplgSJNWMEy2XXqWnzifdIGCAvHvmy0d2jsFwye7lduT0uW4/n/tTlVoqtYelipb2K
	 ZWYZBo+7HXfSELdVQmUTC7wWAE3H613rkTjjtcXTCJuqQ7YO77pv+HgWAFhXJ/GFLD
	 jSo9RvGpDb6pzsdEZXl/2ru6s/C4pEC01Qqtq30/KDdVfwxVkUZdnUs0TkgCBg48dm
	 AnGhXQ/9HEdNC3pVQkhzKG/BTknf+OH3anppooPUAlQlj2JzjZBbka70ObeQWWgovj
	 y4bjE/jBKrF8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E8439EFA73;
	Wed,  7 Aug 2024 02:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: dsa: microchip: Fix Wake-on-LAN check to not
 return an error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172299842699.1823320.12985942431593338303.git-patchwork-notify@kernel.org>
Date: Wed, 07 Aug 2024 02:40:26 +0000
References: <20240805235200.24982-1-Tristram.Ha@microchip.com>
In-Reply-To: <20240805235200.24982-1-Tristram.Ha@microchip.com>
To:  <Tristram.Ha@microchip.com>
Cc: woojung.huh@microchip.com, andrew@lunn.ch, vivien.didelot@gmail.com,
 f.fainelli@gmail.com, olteanv@gmail.com, o.rempel@pengutronix.de,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, tristram.ha@microchip.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 5 Aug 2024 16:52:00 -0700 you wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> The wol variable in ksz_port_set_mac_address() is declared with random
> data, but the code in ksz_get_wol call may not be executed so the
> WAKE_MAGIC check may be invalid resulting in an error message when
> setting a MAC address after starting the DSA driver.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: dsa: microchip: Fix Wake-on-LAN check to not return an error
    https://git.kernel.org/netdev/net/c/c7a19018bd55

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



