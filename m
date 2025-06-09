Return-Path: <netdev+bounces-195655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E8BAD1A63
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 11:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618B61884567
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 09:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E762E1F1905;
	Mon,  9 Jun 2025 09:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjLlsrBt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D781E833F;
	Mon,  9 Jun 2025 09:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749460722; cv=none; b=BVlOCVjlT3UOMqLhSP6ZJwqcC0yppjm3Pg/lN6t3FYdWqpZJiHuqSuTwPzPbRqViTksHgwdLe5Z6b08KE+oISnTyN0C7rbXZ2JYBMOn30g5I310WYQyORTYSkR/teWopHSt6G5fRsIA3GFU1Xp0ukAMjnrpEl6OeHa3TFtURHUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749460722; c=relaxed/simple;
	bh=0t3bd5mS/k+TzXuv1s2z9LinsUXFTN0zTKLZN+YTrfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U/xJLq5UBSDwWcuJ494QElZd5YEXvQ87wpvLAiWsxyhgDbC5wpFGRT0hqkvEKp/zA50BtzyTOz1eummGgtqGCpDNv/CUvKIvDkMOtGiyAyrWHwI0S5xLeROT+8zE4QFG+w14Yz5trLOQZGUuChGUnBOVA2YbY4E8Uw4ZgIpWzKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjLlsrBt; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so6571782a12.2;
        Mon, 09 Jun 2025 02:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749460719; x=1750065519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gHNBXLnJYpqI/PeJ6YF0lV8TzDjl/rwRReLeL5eQ6So=;
        b=EjLlsrBt+Z7YR9W3zjLL16lyEQmMfopOdsW4LHhKPJMppnJJIXoAsrMd1/KgsRSd+v
         AcZsXTs0FKPIv5k/K2xtypcc3x2mXNhozrB8UYKR2RnJ6smP+4xrJBipjcHcLpTmohc7
         +F8RSGzrKYGvlU9kK8VP77KQ4EzXBIrsuEh9wKMHz+Gq8KFkZR++5yPLsCYmmDtAHWzU
         6I28/PH9ru52eukX4BV6tufDXJboKyIgugPHMo0GGrYi5a66GwUljwHGimgEE0jbjfFM
         9dxQKtt3XMWS57uKqqc8anTCD8tEeTfoouglmG0sb+a/ILgPi15hDnRA92/dwor3ZTfi
         8YRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749460719; x=1750065519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gHNBXLnJYpqI/PeJ6YF0lV8TzDjl/rwRReLeL5eQ6So=;
        b=bbYqysRAou2Zo5GoSL+DFNujS0/3zIs9W5j3J733tjy9q36pbuJxJqBFZsjjtIDB32
         S0DUFZ5tiK1vh0e6DHY4Yst5Cg1Zq+TGAYlZ13YjTErWjSbCMKnMRGZcz8+XBjl4h+Yr
         V8I3+cR9yK2z5XwXoqPHCfieaJ/pjP2DgzjM28GZVjhEWB4HtUrRnKFcyZKjinCt0MpF
         DHWopSzJsgg7eD6ijUOFZakoth0yt+tWd6q7Kb8YXrJpJylU7Z4zlrpscA6ZHRF0ZyMi
         DUl54yPS59oDnggJdsd4Uvr2OFnJHyjD0elijGrQczJ91spr94aipFsxKy8cpOJVFMUR
         0nXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIlEQWUO2uPS/xZw2g9BS0vvISzRzMzH5CHdt392tSECDxkANJE2AlR/nSjz2ldyW6MZEkD3ZqmHbcGhk=@vger.kernel.org, AJvYcCXbgG9b1/7HyCoyzrWZRUtJ8K09xUqmxyeCgxPbGiiXuBDbGNKW0ahbas5hnuMycPhhYNgja0SZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyOuO6mm6q8spFJR1GR5foHpngmmFlTX0yiEG49DS8EeYCddH8y
	Ur1so9uCjofE9Pg9YeWBsPyiLUHkStmeVSVhKgFXFTdzxrYFlrWkBppe
X-Gm-Gg: ASbGncvpe8I23ktVcjf4o3hkjPZhJtBx5ciosQE+tv+uLGWYeOC/XCynL3o1gQGuydY
	dOWgZAnX+n/dkB388VgLkW68dOpvhr11bCtYP8Sl8+X/ZWSuhndJjDUFmeKClDWZtRhgaJO/qgQ
	jldWcL45ytN76YXKDK00UgoGRUfMEJe/ka1t5hq301/e6yZEmiJGr9Vpp96DudH//g6pKCISQ2K
	J6DYbJeRzYbjHIOm2H9MgPmFEFHntIDiyDGF+gOogmGoiZlrbba/muINgpCENkTFwt3B5fPlvNp
	FZVa5ujkbMUwBv7FoIIvUbroD5ZvleplKXzD/6ThOZpw3FCv2KhL9b8Bv1EbZuw+hIPbMkIJJsV
	q5frwMg7EGA7YTipe10pxbxaLFmdd66ST0y3MrdxHgw==
X-Google-Smtp-Source: AGHT+IEIsKXjZIJknesKs71lvadeUufp4Iv5xZ+xr/7CJj078fSSgYQyWLeZXIaXAJj5iU/E5/rmew==
X-Received: by 2002:a05:6402:4307:b0:606:4d43:e647 with SMTP id 4fb4d7f45d1cf-6077479d45bmr11625009a12.24.1749460718944;
        Mon, 09 Jun 2025 02:18:38 -0700 (PDT)
Received: from localhost (dslb-002-205-016-252.002.205.pools.vodafone-ip.de. [2.205.16.252])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-607ee69d2f6sm1224004a12.9.2025.06.09.02.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 02:18:38 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [PATCH RFC net] net: dsa: b53: bcm531x5: fix cpu rgmii mode interpretation
Date: Mon,  9 Jun 2025 11:18:24 +0200
Message-ID: <20250609091824.35897-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

b53_adjust_531x5_rgmii() incorrectly enable delays in rgmii mode, but
disables them in rgmii-id mode. Only rgmii-txid is correctly handled.

Fix this by correctly enabling rx delay in rgmii-rxid and rgmii-id
modes, and tx delay in rgmii-txid and rgmii-id modes.

Since b53_adjust_531x5_rgmii() is only called for fixed-link ports,
these are usually used as the CPU port, connected to a MAC. This means
the chip is assuming the role of the PHY and enabling delays is
expected.

Since this has the potential to break existing setups, add a config
options to treat rgmii as rgmii-id, and enable it by default.

I only made the quirk fixup rgmii to rgmii-id, but not rgmii-id to
rgmii, or no delays for rgmii-rxid. My reasoning is that

a) Boards not requiring internal delays are probably rather seldom, so I
   considered the likelyhood requiring/wrongly specifying rgmii-id when
   they need rgmii as very unlikely.
   And if they understand the difference enough to know to use the
   "wrong" mode, they would have hopefully noticed the discrepancy and
   reported the issue by now.
b) I don't want to require new users to wrongly use rgmii to get
   rgmii-id behavior with the quirk enabled.

Fixes: 967dd82ffc52 ("net: dsa: b53: Add support for Broadcom RoboSwitch")
Reported-by: Álvaro Fernández Rojas <noltari@gmail.com>
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
There is no bug report to link to, we discovered this while switching
our bcm63xx device tree files from rgmii* to rgmii-id and testing the
changes (I would have found this myself if my tested bcm6368 with
bcm53115 didn't actually work with no delays as well).

I only found one in-tree user of "rgmii-txid" [1], which was already
implemented correctly, and one user of "rgmii" [2], but that one doesn't
have the appropriate b53 node defined.

Since it is apparently possible and expected(?) to specify different
rgmii modes for both sides of the link, I didn't see a reason to touch
the latter for now.

[1] arch/arm/boot/dts/allwinner/sun7i-a20-lamobo-r1.dts
[2] arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts

 drivers/net/dsa/b53/Kconfig      | 10 ++++++++++
 drivers/net/dsa/b53/b53_common.c | 33 +++++++++++++++++++++++---------
 2 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dsa/b53/Kconfig b/drivers/net/dsa/b53/Kconfig
index ebaa4a80d544..176c5f7e2bd7 100644
--- a/drivers/net/dsa/b53/Kconfig
+++ b/drivers/net/dsa/b53/Kconfig
@@ -46,3 +46,13 @@ config B53_SERDES
 	default ARCH_BCM_NSP
 	help
 	  Select to enable support for SerDes on e.g: Northstar Plus SoCs.
+
+config B53_QUIRK_IMP_RGMII_IMPLIES_DELAYS
+	bool "Treat RGMII as RGMII-ID for CPU port"
+	depends on B53
+	default y
+	help
+	  Select to enable RGMII delays also in RGMII (no ID) mode for the CPU
+	  port to mirror old driver behavior.
+	  Enable this if your board wrongly uses RGMII instead of RGMII-ID as
+	  the phy interface, but actually requires internal delays enabled.
diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index dc2f4adac9bc..6992d8ceb36a 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1350,6 +1350,16 @@ static void b53_adjust_531x5_rgmii(struct dsa_switch *ds, int port,
 	else
 		off = B53_RGMII_CTRL_P(port);
 
+	if (IS_ENABLED(CONFIG_B53_QUIRK_IMP_RGMII_IMPLIES_DELAYS) &&
+	    interface == PHY_INTERFACE_MODE_RGMII) {
+		/* Older driver versions incorrectly applied delays in
+		 * PHY_INTERFACE_MODE_RGMII mode.
+		 *
+		 * So fixup the interface to match the old behavior.
+		 */
+		interface = PHY_INTERFACE_MODE_RGMII_ID;
+	}
+
 	/* Configure the port RGMII clock delay by DLL disabled and
 	 * tx_clk aligned timing (restoring to reset defaults)
 	 */
@@ -1361,19 +1371,24 @@ static void b53_adjust_531x5_rgmii(struct dsa_switch *ds, int port,
 	 * account for this internal delay that is inserted, otherwise
 	 * the switch won't be able to receive correctly.
 	 *
+	 * PHY_INTERFACE_MODE_RGMII_RXID means RX internal delay, make
+	 * sure that we enable the port RX clock internal sampling delay
+	 * to account for this internal delay that is inserted, otherwise
+	 * the switch won't be able to send correctly.
+	 *
+	 * PHY_INTERFACE_MODE_RGMII_ID means both RX and TX internal delay,
+	 * make sure that we enable delays for both.
+	 *
 	 * PHY_INTERFACE_MODE_RGMII means that we are not introducing
 	 * any delay neither on transmission nor reception, so the
-	 * BCM53125 must also be configured accordingly to account for
-	 * the lack of delay and introduce
-	 *
-	 * The BCM53125 switch has its RX clock and TX clock control
-	 * swapped, hence the reason why we modify the TX clock path in
-	 * the "RGMII" case
+	 * BCM53125 must also be configured accordingly.
 	 */
-	if (interface == PHY_INTERFACE_MODE_RGMII_TXID)
+	if (interface == PHY_INTERFACE_MODE_RGMII_TXID ||
+	    interface == PHY_INTERFACE_MODE_RGMII_ID)
 		rgmii_ctrl |= RGMII_CTRL_DLL_TXC;
-	if (interface == PHY_INTERFACE_MODE_RGMII)
-		rgmii_ctrl |= RGMII_CTRL_DLL_TXC | RGMII_CTRL_DLL_RXC;
+	if (interface == PHY_INTERFACE_MODE_RGMII_RXID ||
+	    interface == PHY_INTERFACE_MODE_RGMII_ID)
+		rgmii_ctrl |= RGMII_CTRL_DLL_RXC;
 
 	if (dev->chip_id != BCM53115_DEVICE_ID)
 		rgmii_ctrl |= RGMII_CTRL_TIMING_SEL;
-- 
2.43.0


