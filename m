Return-Path: <netdev+bounces-27109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EB677A632
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 13:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAE511C208F2
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 11:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DF0522C;
	Sun, 13 Aug 2023 11:30:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07473FE0
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 11:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46563C433C7;
	Sun, 13 Aug 2023 11:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691926220;
	bh=tv0AJaJfM1H7xAQNmykztN3H5FVSHFg0uLsHKr48Ejg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bVQkejMU84wHVEID3w+1CUnD+hPtVzmefQflM+YJVVn4ekOr5w68vMXZsfkaVf+qP
	 5bW56RLTgXZiY4/8+3YPxtX2/SYBs3IxGWSbW7iMqmgbaOdBsYwDS3TJBJIH5H5jkb
	 NGErhhQf+XTb8+EN4CWtga2+kz84ENz58zvCogGMiB9uR65B409AHi1uBn8w19gM3W
	 mIYLTH8NMiAP7eVlPsX24wDCayP+3XbgEEXWpdOGDbQVkBq6iT6vcSmC007R1hn1iB
	 UF41wqWyeNDpd+8rVit5BbGt6n04KBogk+J2UXJAEQ9hsKS9M14AUhIT3vfFehi/Bb
	 k/9QiMi0lYgkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 293B0C595D0;
	Sun, 13 Aug 2023 11:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: fix IRQ-based wake-on-lan over hibernate /
 power off
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169192622016.28684.14964917014181303735.git-patchwork-notify@kernel.org>
Date: Sun, 13 Aug 2023 11:30:20 +0000
References: <E1qUPLi-003XN6-Dr@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1qUPLi-003XN6-Dr@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandru.ardelean@analog.com,
 andre.edich@microchip.com, atenart@kernel.org, baruch@tkos.co.il,
 christophe.leroy@c-s.fr, davem@davemloft.net, Divya.Koppera@microchip.com,
 edumazet@google.com, f.fainelli@gmail.com, hauke@hauke-m.de,
 ioana.ciornei@nxp.com, kuba@kernel.org, jbrunet@baylibre.com,
 kavyasree.kotagiri@microchip.com, linus.walleij@linaro.org,
 m.felsch@pengutronix.de, marex@denx.de, martin.blumenstingl@googlemail.com,
 dev@kresin.me, fido_max@inbox.ru, michael@walle.cc, narmstrong@baylibre.com,
 Nisar.Sayed@microchip.com, o.rempel@pengutronix.de, pabeni@redhat.com,
 philippe.schenker@toradex.com, willy.liu@realtek.com,
 yuiko.oshino@microchip.com, u.kleine-koenig@pengutronix.de,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 11 Aug 2023 11:26:30 +0100 you wrote:
> Uwe reports:
> "Most PHYs signal WoL using an interrupt. So disabling interrupts [at
> shutdown] breaks WoL at least on PHYs covered by the marvell driver."
> 
> Discussing with Ioana, the problem which was trying to be solved was:
> "The board in question is a LS1021ATSN which has two AR8031 PHYs that
> share an interrupt line. In case only one of the PHYs is probed and
> there are pending interrupts on the PHY#2 an IRQ storm will happen
> since there is no entity to clear the interrupt from PHY#2's registers.
> PHY#1's driver will get stuck in .handle_interrupt() indefinitely."
> 
> [...]

Here is the summary with links:
  - [net] net: phy: fix IRQ-based wake-on-lan over hibernate / power off
    https://git.kernel.org/netdev/net/c/cc941e548bff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



