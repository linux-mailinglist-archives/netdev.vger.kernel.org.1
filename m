Return-Path: <netdev+bounces-109048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B81C926AC0
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 23:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45E971F23A5D
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 21:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206AE194C69;
	Wed,  3 Jul 2024 21:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2i2oGC5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D98E194A60;
	Wed,  3 Jul 2024 21:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043215; cv=none; b=Aams68ur//FJ31RlP7V1C47XfvHpfwZMZDK0xPJUn5CBbEqoEoFHsSEyqOn4JBl/8tTtWLOwKg4vtN0lZUe3utELhAiN9jGkBbANzNaIVgSdiobYbznAwXyphoJ5X8SF0fgVtXsNrC+PoF1sCbk8x349uMFx7saMbak4w1HPK60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043215; c=relaxed/simple;
	bh=6q2DdO7S16bdyZgq1GbnvgpchKg/KexCeYaw8kP7yyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S4ophOhEBM00aiOvVfVae30lP79aOmcDndesSwln3F6jQ0F+3KFsOC9Qw2B8x+SbQ42DC/nnGjY7RDDjgD4Cr3FiHBy2aG6XXw+bLTXHDAxckMBgVWJYdjlpkeKt7MT1R7OAffP9iQT17KG32XTpaI2mhTQZ3q2MzZV4Y/A4STE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2i2oGC5; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-367975543a8so4126f8f.3;
        Wed, 03 Jul 2024 14:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720043212; x=1720648012; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BRnEsbWpiC4auC0zP97cCNMZQHKbNM/aAU/PO3sRgTg=;
        b=S2i2oGC5WAs0kGosEb+Py97cYjXpUuWiJAHynQwqiKJFvO4FXUINZ2y/NIGBkzooQQ
         AwxzQL7tTDhqlopCogGqBSAe/lISejvHf/eIFLuq5ZOvB4Ge40SYlLF2tnQE1qIwKwRS
         ENKrX7odPsSYuaN3c5sp4o2tqKwYQz0WWw7e1av2nhwUPK6cN5SdcRxD1frwMFniRCZG
         StCSle8AhTopAa2rbL2u9B+ig3oHu86DD3EcItSxIOiW4E4pkteyi9HGNJkwc5t0MDHt
         x7WstwIWKGV6X8SI2O8RUSNng2IpvIHWCfwhs6EQW0ZejlgPJgm6mENZ26nG9cdJTrgy
         DKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720043212; x=1720648012;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRnEsbWpiC4auC0zP97cCNMZQHKbNM/aAU/PO3sRgTg=;
        b=elV7WadcMMOCwTxe4LqniYrj9E/bPw53mQcLRBs4VkcVDXpJm2IGFyEgZwTkHyWqL0
         Ij+vABahyib3dsTDq3hqtUaL+Bh7F5LyEJpTXywGQygA1zXcgAW84WWK+Zq6nVF4ecQ4
         l1qRJeXM2LRkoGXwfH9z6ZibIMACCKqk/UGvstdDCWq6tYc09d2uCSg6l0azGVhLsON7
         tXvq4IE0LLF32UllETnrmifybYnw6xfazszFiVEsMNWQy2gZyWylgW65RYYbdNjAz8ld
         t8SmotphnLUNyfcmBak7DWJ/T4Wvj+Phu0+UlDLs3w2mXteb4GcUJGVX2fu1B/FAaXTV
         Iwkg==
X-Forwarded-Encrypted: i=1; AJvYcCWzWh7AptdWRMdW4c6kNJ/0GYVcdlH2/qylYtzX8tZSMwzOY4QSArLD1u5QDzoukMNMuTFoarGi/pGKruNw8exmpC55Bi4xCW91IsNk
X-Gm-Message-State: AOJu0YxPxJTijZK2n4u265vVOZDGihXTb/fgKwaso6lCI1kUw/KKz/O9
	HYsMYjH9tTdRflEKsdMh92Pg+eF1ItK2zCwI+4zS68LvFYulC1+c
X-Google-Smtp-Source: AGHT+IEjIk9IP242fY3YMgi2r7mtGX/Qr9/68nkAe/52Tlw1KiNc9kjTMLnVnjbTEjfbPVXEXhIYmw==
X-Received: by 2002:a05:6000:1543:b0:360:9c4f:1f8 with SMTP id ffacd0b85a97d-367756bb76cmr9705790f8f.34.1720043211744;
        Wed, 03 Jul 2024 14:46:51 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3678fbe89cdsm3628068f8f.61.2024.07.03.14.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:46:51 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 03 Jul 2024 23:46:35 +0200
Subject: [PATCH 3/4] net: encx24j600: constify struct
 regmap_bus/regmap_config
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-net-const-regmap-v1-3-ff4aeceda02c@gmail.com>
References: <20240703-net-const-regmap-v1-0-ff4aeceda02c@gmail.com>
In-Reply-To: <20240703-net-const-regmap-v1-0-ff4aeceda02c@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720043205; l=1431;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=6q2DdO7S16bdyZgq1GbnvgpchKg/KexCeYaw8kP7yyY=;
 b=Oo469PHgcSkwQZn4uzhnc6b2A1jagh2BGeWP7cVvHDBXEGIgsoGBR4eCQyieNkCkj+UdYxFMe
 3SFVNVE/AOsCZ3612i1TEytAQo96wcUljFNbpvc053/w8KlKFz5QQDQ
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

`regmap_encx24j600`, `phycfg` and `phymap_encx24j600` are not modified
and can be declared as const to move their data to a read-only section.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/net/ethernet/microchip/encx24j600-regmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microchip/encx24j600-regmap.c b/drivers/net/ethernet/microchip/encx24j600-regmap.c
index 3885d6fbace1..26b00e66d912 100644
--- a/drivers/net/ethernet/microchip/encx24j600-regmap.c
+++ b/drivers/net/ethernet/microchip/encx24j600-regmap.c
@@ -474,13 +474,13 @@ static struct regmap_config regcfg = {
 	.unlock = regmap_unlock_mutex,
 };
 
-static struct regmap_bus regmap_encx24j600 = {
+static const struct regmap_bus regmap_encx24j600 = {
 	.write = regmap_encx24j600_write,
 	.read = regmap_encx24j600_read,
 	.reg_update_bits = regmap_encx24j600_reg_update_bits,
 };
 
-static struct regmap_config phycfg = {
+static const struct regmap_config phycfg = {
 	.name = "phy",
 	.reg_bits = 8,
 	.val_bits = 16,
@@ -492,7 +492,7 @@ static struct regmap_config phycfg = {
 	.volatile_reg = encx24j600_phymap_volatile,
 };
 
-static struct regmap_bus phymap_encx24j600 = {
+static const struct regmap_bus phymap_encx24j600 = {
 	.reg_write = regmap_encx24j600_phy_reg_write,
 	.reg_read = regmap_encx24j600_phy_reg_read,
 };

-- 
2.40.1


