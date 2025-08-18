Return-Path: <netdev+bounces-214728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89718B2B15D
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 21:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F82A1B20B60
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 19:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294B7272815;
	Mon, 18 Aug 2025 19:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSQq1w5J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0AF3451B2;
	Mon, 18 Aug 2025 19:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755544269; cv=none; b=dfaL0tx51eY1ojSxHh5U/M62jKCtsqh1MfIF4f3xLL5OM0SUulNGHFm2E0uGUYCL8fQUhxyqetZQem5rYdY9ZPN3r4AjoctDlKSf79nzGBa3vrTOkuhMpHqA4MvSf+NcQ8NYR94dDLOboSDwlW9RqkX+0srWf3ig+D72tb3Cwtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755544269; c=relaxed/simple;
	bh=OZK5CyXw1PInn/yqI4pDY8A9Y5pwSG9xCax8VqYzUdI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ndTrS6uxs7het8I6oBcaGxQ+3iS8ABbK01/bNHG6Fp5JKolMsSHeENPROVEAyoJuYDSQJV2lnWF0EVB/XjEQf/RjeJKhhcEZfxfNVLiXbVZwYE8Z9K0Tm34yTH7q4hFcoWA8KwxrxaIzt7Tw2yrmqceZKYtmYj3FB2nMfc83emg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSQq1w5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5769AC4CEEB;
	Mon, 18 Aug 2025 19:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755544269;
	bh=OZK5CyXw1PInn/yqI4pDY8A9Y5pwSG9xCax8VqYzUdI=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=BSQq1w5JizmpSZUf4s5+tSO15Q/XuPUlIXNgf1lPgC6Pnth2YBndwPcZNe43Yz22l
	 aiAO/8djv6cgRjptjNlsO74pfWV92BT333yfBGhdxxO98IDtl22SSCsx3zVYv4NqzB
	 +BYzAH6+UQvq8qtZXQQ3H0ovg0z8at8SU1kKuzNcG+QMQnJGJclFDJwzkORw/cyvpw
	 XzRJ6qLivhVK38NONmfhs3MqKXQMUPujPlT2Tk37jMqef1ss8NnQOXHk83xn7Ll5mD
	 nyG/zTRJhjyz+DA7kC0kkMqTnXtCU4WEEjdG0E10KmP7TTsNiGgMRdmHrMmelN8F1f
	 tOfVwQIQBekwg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 07D41CE0CC4; Mon, 18 Aug 2025 12:11:09 -0700 (PDT)
Date: Mon, 18 Aug 2025 12:11:09 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Russell King <rmk+kernel@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH RFC] net: stmmac: Make DWMAC_ROCKCHIP and DWMAC_STM32 depend
 on PM_SLEEP
Message-ID: <7ee6a142-1ed9-4874-83b7-128031e41874@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

This might be more of a bug report than a patch, but here goes...

Running rcuscale or refscale performance tests on datacenter ARM systems
gives the following build errors with CONFIG_HIBERNATION=n:

ERROR: modpost: "stmmac_simple_pm_ops" [drivers/net/ethernet/stmicro/stmmac/dwmac-rk.ko] undefined!
ERROR: modpost: "stmmac_simple_pm_ops" [drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.ko] undefined!

The problem is that these two drivers unconditionally reference
stmmac_simple_pm_ops, which is not exported to modules in kernels built
without CONFIG_PM_SLEEP, which depends on CONFIG_HIBERNATION.

Therefore, update drivers/net/ethernet/stmicro/stmmac/Kconfig so that
CONFIG_DWMAC_ROCKCHIP and CONFIG_DWMAC_STM32 depend on CONFIG_PM_SLEEP,
thus preventing the dependence on a symbol when it is not exported.
With this change, rcuscale and refscale build and run happily on the
ARM system that I have access to.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: <netdev@vger.kernel.org>
Cc: <linux-stm32@st-md-mailman.stormreply.com>
Cc: <linux-arm-kernel@lists.infradead.org>

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 67fa879b1e521e..150f662953a24b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -146,7 +146,7 @@ config DWMAC_RENESAS_GBETH
 config DWMAC_ROCKCHIP
 	tristate "Rockchip dwmac support"
 	default ARCH_ROCKCHIP
-	depends on OF && (ARCH_ROCKCHIP || COMPILE_TEST)
+	depends on OF && (ARCH_ROCKCHIP || COMPILE_TEST) && PM_SLEEP
 	select MFD_SYSCON
 	help
 	  Support for Ethernet controller on Rockchip RK3288 SoC.
@@ -231,7 +231,7 @@ config DWMAC_STI
 config DWMAC_STM32
 	tristate "STM32 DWMAC support"
 	default ARCH_STM32
-	depends on OF && HAS_IOMEM && (ARCH_STM32 || COMPILE_TEST)
+	depends on OF && HAS_IOMEM && (ARCH_STM32 || COMPILE_TEST) && PM_SLEEP
 	select MFD_SYSCON
 	help
 	  Support for ethernet controller on STM32 SOCs.

