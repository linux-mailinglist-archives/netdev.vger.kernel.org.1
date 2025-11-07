Return-Path: <netdev+bounces-236889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 15877C418E1
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 21:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AEB7B4F0B92
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 20:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C842230DD19;
	Fri,  7 Nov 2025 20:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THw0g3s9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F93930DD02
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 20:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762546378; cv=none; b=M5MPTOClPpR6EA9WHFQ4nP8xSC5EOXzumR+pNhn9jGKhg8SzDjVZXe73HlGIMLoRvA6juimBaGfzhBjJ7EhHcT4lOaMW8ia//sU+Lse6qEW3MYM6UQQqVZLz8uWPyLpGoU7Rgn1/rQFJagvV8UyKDHoCSReMxEYPf5VqH7yWb+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762546378; c=relaxed/simple;
	bh=v8yHUl2VCCuFa3tLr/Bqru4Xwe8KeevfdbbJgX94SXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cN7XLUla2mVXo1o2A9/mbyF4Tuxihe5IeAhD8aW0uiWAm9+v9vHjyB2mx/vRRITNgrlwW9KiDpcU2D6TKjC/e7Wr+2erIYleXjk/QDAeArJDubgdEDTQ2yxUIRUBWZQRnIvB0+NQJbvvOT6p82vchvHanBfxqncm7qpOi4Ar48g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THw0g3s9; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so972187b3a.1
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 12:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762546375; x=1763151175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2jIm/CZCkZaBbDnD9nBZsgOURxlF1+5kGMORETVnug=;
        b=THw0g3s9UQva+8taWcK6ba8UJMs1DBvHYodryLlafUTTYVlRjvXFotDRAYOFQqqrMN
         o07BobtetTsBgomyv0rTGFj10qRzehQhgjx4WuidbnpnuHpVs5DgLILTAJN1yaUME6Qz
         3odAEfZt0QaZlfDMsBffUw1VaxFWUhSfI8gQYXIct8w90k77lVKfpyjL3ARFZoVI8hVO
         5P+FgtDt5eVg6fxGZPpAJA/OX3UKPLA1X9ATCPixKjLa3TfiLue2yopk23DwUdBlLMlW
         5sZN+X6NfD6p9Xdb21GdPcnDNZJhRH5XxrFkVLvpEQjfbmevtWdxcv4TI3uzfLXojGnk
         IfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762546375; x=1763151175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+2jIm/CZCkZaBbDnD9nBZsgOURxlF1+5kGMORETVnug=;
        b=JP+5JwgCaOG+Z1QvA/pvLRGGcU7ruuR/oHtTswK6j4XaNd4Lj3jd17sps72oUHKEug
         l7tph3cElk/pHgde3aizClYqt8YyjFbLbLwbwB+HH/118l0dgfWbqIJ2ReTkkRDnm3qZ
         SR8L/YTieUNeg8B3cVaNfVk5DF7B1uuuKO/PNAz07jcF/CHBC/Fo3OQYYoiKSFv1wrk5
         dVd69QNqeqmPGu4mblZ20ZyQWQ9SqjbJAT/CeeIwezLB7aapubKOL5syZocLUVwZ8M7l
         C7bnqQwVC7b3YigxdneoTJeFm1XDVyRzajCd0XMX4WuZ86mOsyk/hxvOSV7OrUhLHNq0
         CAZQ==
X-Gm-Message-State: AOJu0Yw5gZtJyKfU7XouEk5jL+vYde3cxJadYegen3sB58y0jqUgvZeW
	xD+ojs+sxfWudIOI3CQ0TDI40c5gS4TGdkt8q5V29J3qlEHkUGkjxTBQ
X-Gm-Gg: ASbGncvbJ2A0RNLJT1hqRqDwbJwEzgiRxAMtvR748BIg7aX2Z4IsVXj3owZmxJFtqxk
	SlQw64s0JZnvi2C0qtZSRiX9gaNbjpoJfekbRrwI+91qbpIsOFX4tFwc/nAixflH/QnwcR5MHG4
	AknUzPTWLoOaAShsWHktBJHD4JRm7LiwHYnao7OaeDFXSEXg56GazACgMdJKe0DF8Z3BBRjztku
	gcQzrQmqjdwainX8c1Q+3T7buftB53Ghwof8eyZCou4BvVpn7X4zcSCCGbxGmnfIVFH0HY/GEdr
	PhhuCsP9B0oxMxCZZvuRMjOev1EIFGODJa6EZTP0/dGkUYiL7vhH4p/siBrPUhLxQpiIBLKkfTz
	BXETtRo2+aUbemMtI8Kpf5aRc0XqLGQOgDVuNpcwwnX8sVCaZZAXq3d4Hj1ai5ERnCjSyN9Riov
	jjGVEeivykDZJ/IURKNG7mVA==
X-Google-Smtp-Source: AGHT+IH8khfZJBhTJpXLTO5Gb4RSM+k9uIEQChjCn5mDLXBQUnyR83c66GjH4StNfJo9F5kUwk9slw==
X-Received: by 2002:a05:6a00:1892:b0:7ac:6c3e:e918 with SMTP id d2e1a72fcca58-7b225b50453mr562311b3a.11.1762546374902;
        Fri, 07 Nov 2025 12:12:54 -0800 (PST)
Received: from iku.. ([2401:4900:1c07:5fe8:9724:b1da:3d06:ab48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc17784bsm3828553b3a.47.2025.11.07.12.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 12:12:54 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next v2 1/3] net: phy: mscc: Simplify LED mode update using phy_modify()
Date: Fri,  7 Nov 2025 20:12:30 +0000
Message-ID: <20251107201232.282152-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251107201232.282152-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251107201232.282152-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The vsc85xx_led_cntl_set() function currently performs a manual
read-modify-write sequence protected by the PHY lock to update the
LED mode register (MSCC_PHY_LED_MODE_SEL).

Replace this sequence with a call to phy_modify(), which already
handles read-modify-write operations with proper locking inside
the PHY core.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2:
- New patch
---
 drivers/net/phy/mscc/mscc_main.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index 8678ebf89cca..032050ec0bc9 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -177,17 +177,10 @@ static int vsc85xx_led_cntl_set(struct phy_device *phydev,
 				u8 led_num,
 				u8 mode)
 {
-	int rc;
-	u16 reg_val;
-
-	mutex_lock(&phydev->lock);
-	reg_val = phy_read(phydev, MSCC_PHY_LED_MODE_SEL);
-	reg_val &= ~LED_MODE_SEL_MASK(led_num);
-	reg_val |= LED_MODE_SEL(led_num, (u16)mode);
-	rc = phy_write(phydev, MSCC_PHY_LED_MODE_SEL, reg_val);
-	mutex_unlock(&phydev->lock);
+	u16 mask = LED_MODE_SEL_MASK(led_num);
+	u16 val = LED_MODE_SEL(led_num, mode);
 
-	return rc;
+	return phy_modify(phydev, MSCC_PHY_LED_MODE_SEL, mask, val);
 }
 
 static int vsc85xx_mdix_get(struct phy_device *phydev, u8 *mdix)
-- 
2.43.0


