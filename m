Return-Path: <netdev+bounces-186093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA825A9D160
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 21:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D78B01C00F27
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 19:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386E8217F24;
	Fri, 25 Apr 2025 19:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libre.computer header.i=@libre.computer header.b="AsIHlZ1j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A777E1AA795
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 19:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745608813; cv=none; b=ltTTPQNGQZUyppbz9L59sfLxbotdUOp8DORGecmpIGzk9jTsNgVqNJVc5N0Z5JPX+PDfBGBGsgpxiKWbTFcRpqd2jpxOxwDJuuveZDR54PxXwZRNtiCQ8m4+ElYe40GBUpXgpqWV7zz49NfK2P9yuVLWpGhOEFV18UEge5GIHjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745608813; c=relaxed/simple;
	bh=UizIfOXDw7K3bISuywDn5DUtvUYwR+8wO0LDq5X4GLo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rzWafynvHiL8YcBfjulRui74EeMbzTkDc8Hxhw+jXFa6tVHaDfcDSn/EWbL7Z902A4StFxTf+gpqOsHh4EzChWKrk6B1qQgroV2BkLYMpirenMY/OM7nYS6NR5xwnV1AYJBbuPiEkBR6tbYDqKja+U6bvqBQrLUxkl5k4TaJxzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libre.computer; spf=none smtp.mailfrom=libretech.co; dkim=pass (2048-bit key) header.d=libre.computer header.i=@libre.computer header.b=AsIHlZ1j; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libre.computer
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=libretech.co
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4768f90bf36so31125161cf.0
        for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 12:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=libre.computer; s=google; t=1745608810; x=1746213610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tSiF7FhF0tHfOGpGfJXsH5sp5D81/QkR5l4lerbklaI=;
        b=AsIHlZ1jE5XQ8lJtsA313Q074M4NzIfxw6H6ZZ8/PkiY0qA1wrf4Wu63nT67La4+IS
         DI/452ay1qr6ra4NJBMe9TwWgrQ44uvzFdH2uOBqmmXFN3xuFmX4NFXnSGCqYslfTrkq
         M0n4v6bXEjgsqpcGn/JvAL8zSAjwxRd4t1cU0kviDwuKiQpKokpGYqLZ0QGFhR4kPPJ3
         pZqVt3sHDgVINVQ097OrkMNuiE3M0WxtxIFKKtk0gPwKDLEV3vPT3Iqjiq38iQOr0ajX
         paxSqEaSxPZ8iLOTA1OyJ4EJRkjLyNu8UnC/7lHctpugoHQEb5NYFT2Fw7vI4Hroh8o4
         jJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745608810; x=1746213610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tSiF7FhF0tHfOGpGfJXsH5sp5D81/QkR5l4lerbklaI=;
        b=S2UBeVmcJgt2pYdjnqOkA6QEHT6KJbFHOi2edaFcE2HEr2dlSABTdB1suvMpnINTf8
         LSZGPrjCGuFXdjPpVO189oP5SExBoQIn5rdY/3Ykf0g4yAOw3+fIsm7ksn8hvd/tGMGi
         dDTyeam9s7PqWjh+Lft2diljAlW6svkAQntA7mJEQGEVBn8rsq48+ZVHXJyV1vFJqZRi
         CTJS6ThaAPBthjkUlRMedyXkogw839jGtIBxZrD4mGmVVB8ZzIuCFPT1v40HMkOwTt+Z
         +becYZuN/2Cm/vbuGBpcvdYekc5TQ8nXJQuQr2hKRzfot3eAFTu9OLW1ZTkr1HlN+2e5
         SVrw==
X-Gm-Message-State: AOJu0YxTWIGV77vAmpZblnGg/beeAL8ooIdN7aOi2ug4bIg88e0ejRhR
	+TkeXq2IUs8D99lg1XMg/fSPho4jNLXFZy5kbGpJmchJ000aBKYCtYdShqNlnA==
X-Gm-Gg: ASbGnculbaPcOHeHYsy2YhkymHFMxZ5r3ItWkF83vZ6hrMBosSDzsV0d7OLB9QulZWj
	Cf+H56sIAn/ce36T69bwgs79Rdub4uFK6P0n6ZwXMPCickR82iEvg9mv74c+ACQuAhziwHU/CSd
	OzQd3lpvxHt+kGnmWatuHaOJyWr3Bf7L9aMV6OsJLS7NppCX/sIPczYhX0jl4ogjCEiIIECaJZb
	EVwssMtUYuN999PSog7NsGxou9snWqVZIxORcxZ4fs7kr2vk3H1/LQon8kIiuJw3t978MzzY1y7
	jx8ABIxUCSfzr6W6+1mcxOkRlVhUjmWhx3aJ
X-Google-Smtp-Source: AGHT+IGY/FeexPuDpgYb8JxPjPFvAGcEWUmeISWIErTY/veMEqRNOKkQikr2E7yj9IXljqqh0c90qg==
X-Received: by 2002:ac8:7d4c:0:b0:476:a895:7e87 with SMTP id d75a77b69052e-481335610c0mr7228001cf.48.1745608810494;
        Fri, 25 Apr 2025 12:20:10 -0700 (PDT)
Received: from localhost ([2607:fb91:bdd9:47ad:b39:2164:cbe2:1695])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9f1cc02esm29045181cf.30.2025.04.25.12.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 12:20:10 -0700 (PDT)
From: Da Xue <da@libre.computer>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Christian Hewitt <christianshewitt@gmail.com>,
	stable@vger.kernel.org,
	Da Xue <da@libre.computer>
Subject: [PATCH v3] net: mdio: mux-meson-gxl: set reversed bit when using internal phy
Date: Fri, 25 Apr 2025 15:20:09 -0400
Message-Id: <20250425192009.1439508-1-da@libre.computer>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This bit is necessary to receive packets from the internal PHY.
Without this bit set, no activity occurs on the interface.

Normally u-boot sets this bit, but if u-boot is compiled without
net support, the interface will be up but without any activity.

The vendor SDK sets this bit along with the PHY_ID bits.

Fixes: 9a24e1ff4326 ("net: mdio: add amlogic gxl mdio mux support");
Signed-off-by: Da Xue <da@libre.computer>
---
Changes since v2:
* Rename REG2_RESERVED_28 to REG2_REVERSED

Link to v2:
https://patchwork.kernel.org/project/linux-amlogic/patch/20250331074420.3443748-1-christianshewitt@gmail.com/
---
 drivers/net/mdio/mdio-mux-meson-gxl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-mux-meson-gxl.c b/drivers/net/mdio/mdio-mux-meson-gxl.c
index 00c66240136b..3dd12a8c8b03 100644
--- a/drivers/net/mdio/mdio-mux-meson-gxl.c
+++ b/drivers/net/mdio/mdio-mux-meson-gxl.c
@@ -17,6 +17,7 @@
 #define  REG2_LEDACT		GENMASK(23, 22)
 #define  REG2_LEDLINK		GENMASK(25, 24)
 #define  REG2_DIV4SEL		BIT(27)
+#define  REG2_REVERSED		BIT(28)
 #define  REG2_ADCBYPASS		BIT(30)
 #define  REG2_CLKINSEL		BIT(31)
 #define ETH_REG3		0x4
@@ -65,7 +66,7 @@ static void gxl_enable_internal_mdio(struct gxl_mdio_mux *priv)
 	 * The only constraint is that it must match the one in
 	 * drivers/net/phy/meson-gxl.c to properly match the PHY.
 	 */
-	writel(FIELD_PREP(REG2_PHYID, EPHY_GXL_ID),
+	writel(REG2_REVERSED | FIELD_PREP(REG2_PHYID, EPHY_GXL_ID),
 	       priv->regs + ETH_REG2);
 
 	/* Enable the internal phy */
-- 
2.39.5


