Return-Path: <netdev+bounces-98523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 306DF8D1A9C
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5ACE1F238B8
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 12:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DD116D4C5;
	Tue, 28 May 2024 12:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWj8ZvqO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88B916B743;
	Tue, 28 May 2024 12:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716897872; cv=none; b=pCX5dolmBWQdARLWazFI1pIf6sKbiT4z0Yyf/7X5A3RVZTEIGNVR+qSuanqEsC+9JnpiTVVe60uFq/WTCPw8532RLcKvZa0dIE2vCS5g1dWEiqMYhKgSPo61HVyl8O3duoxHfSNBPwoEUBudZCYto7vVLoPRKeO+AY8IpErzCoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716897872; c=relaxed/simple;
	bh=geFzxgDm7W4HA50i8vXt3CLQRJwI4FU8uG+93ofHFxY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EFuU6234aGJNUbhvm+8mJcS/C0Amb74pHbyCO8FUNTMTqdoBZ4ILNsQ4Im+Pjg9rOLyoukqO7oruJAb/I1WMpunZUJE446+mVGAvgdlseUwnX7ihNrNSNuM4NJi6lvOAK6Ts8Dz6qDIjww9eOVPVO2cliue88MbJN2ihP6mH0sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWj8ZvqO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83895C32782;
	Tue, 28 May 2024 12:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716897871;
	bh=geFzxgDm7W4HA50i8vXt3CLQRJwI4FU8uG+93ofHFxY=;
	h=From:To:Cc:Subject:Date:From;
	b=nWj8ZvqO4QYiburakoYAcexvxmbveCbUU//HDUl7nERTKp6g9s8UoYzLPvtik1c9r
	 E5dkiPoJgdwlZc342vma5XxmBxFTDLj05IzI1+cP/U6Ie6kKKJkq+Jc20mISDYZ+/F
	 NiEG85XE+an8l0XRshU6+Yl0Ox0nOjpi5TKuBgNMGOXABd24d6MMfC9J4geeb5BaUM
	 nChOeg0guxtb9N0GmRqjF2G2xqdJkoo2v3/8tyqtEppXWWmtKCeWv65l28h8pt8Zjl
	 N43yo6BdlcQ8etlQ24KYJz5KJQ20Q3v7sSTUFXtKY8bnYrKwOGvxtU6GPXzuK9l8zi
	 O4hDR15XJkplg==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: dsa: realtek: add LEDS_CLASS dependency
Date: Tue, 28 May 2024 14:03:46 +0200
Message-Id: <20240528120424.3353880-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

This driver fails to link when LED support is disabled:

ERROR: modpost: "led_init_default_state_get" [drivers/net/dsa/realtek/rtl8366.ko] undefined!
ERROR: modpost: "devm_led_classdev_register_ext" [drivers/net/dsa/realtek/rtl8366.ko] undefined!

Add a dependency that prevents this configuration.

Fixes: 32d617005475 ("net: dsa: realtek: add LED drivers for rtl8366rb")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/dsa/realtek/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/realtek/Kconfig b/drivers/net/dsa/realtek/Kconfig
index 6989972eebc3..6c90a83c71da 100644
--- a/drivers/net/dsa/realtek/Kconfig
+++ b/drivers/net/dsa/realtek/Kconfig
@@ -39,6 +39,7 @@ config NET_DSA_REALTEK_RTL8365MB
 config NET_DSA_REALTEK_RTL8366RB
 	tristate "Realtek RTL8366RB switch driver"
 	depends on NET_DSA_REALTEK_SMI || NET_DSA_REALTEK_MDIO
+	depends on LEDS_CLASS
 	select NET_DSA_TAG_RTL4_A
 	help
 	  Select to enable support for Realtek RTL8366RB.
-- 
2.39.2


