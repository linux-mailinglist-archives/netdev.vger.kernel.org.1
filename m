Return-Path: <netdev+bounces-113810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B11E94000E
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 23:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F6B0B20B03
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 21:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5857818E75C;
	Mon, 29 Jul 2024 21:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJmBA4+e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D1518D4B9;
	Mon, 29 Jul 2024 21:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722287191; cv=none; b=j2pYhCoBjVHNT9czP4eWZ1LHVJWoCpxvgZh/pwyqB23z5JfH8TaH8K1q06/8iesSGDLPOYFhHDlx7lcgQugEnDeXUFgEtS7+hqwMW4r5mDck2vnbXqY1wGMCjdL2KkQ4HNVoqS0E80oeRMmGvkUISkTFuj4g8Zlwoegt+a0vhP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722287191; c=relaxed/simple;
	bh=Cpt+i9qTuiQOTiMo6sAVRnHUWZnH0LKQw62enj6HraM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pbZnKqjv0bzvO/bsuu2hOPdJ2563Bq90gAwOAHHkd4GcxdoXOPwDwqvRFyRWcJcnmKDJL4HGEGH+GZauclm2LjcSb7Y9n7A25L2mY4XF4Iw6OU1WlbNPU8hIFD0w6sm/2Hvr0I6jlo+1jE1udqPz/1visjyke1rdDv2XXANNo0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJmBA4+e; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52ea2b6a9f5so4265189e87.0;
        Mon, 29 Jul 2024 14:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722287187; x=1722891987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXigS76hXyXNzttcHDC5pgJv8gL66Sfge/cx5CeuvVY=;
        b=bJmBA4+eByuRtjwA3DQHrUKo5VODSqzlNuIW5cZUdHakYrEcLQWXi2AjeK20+mPZCR
         YX0uF/Rt507SQ2LsIieaUHOCoGB4nZpyjBFcAeGasy7mhSwd26Tg1/Gvw8txi78pB7SZ
         /CZG1UjaFxJtkDY0ap15BO9haphjQYv2VtY91wnulRqs0GVPJA04DD8xeFxUDx4y5xHN
         eEQzeXjy5AFIiyC/o8fohvqMMVUQlU1nIS5rZvqslnEVTbzgg1VZgPdysvOHS1IOhfO7
         9DkuQlv/ssMhVkPEU3Xfd1+nmwNeBkr60kQ6jOMGgAn7in6kxOdvba+S7FEajM9d5jUF
         925w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722287187; x=1722891987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXigS76hXyXNzttcHDC5pgJv8gL66Sfge/cx5CeuvVY=;
        b=rFiiZpV+inXUnzjG3rkOMnYKgcXFSeglbBvaYeOYlD8yLujQxx0wpv9K2IamN/BGX5
         vde2e8Bh2Q46+TaMt5wydYGRlq0PGYPuyxRURUkBehqs30okkegA5eKJ4QpH0lgAodZd
         owVyt/5zN8ufmxxV9ek3aBdbIWtmMMVhh/d6E45uhy4F7zq0cPobqPxwqYzyQfag1kME
         e1Pa7cH8OKV+PjLTZ+8PIwPlRK0FVsMbAAwPRhuDQh7Yj+9Mx1zIs5Jfp8S4sOlAzyOM
         1HU6/AN8+flBaZUt4AXAF6FAU28Bf5ieU3RHLjQHyRTdEkThznBHPtMnc68KxttSiWm/
         +DYg==
X-Forwarded-Encrypted: i=1; AJvYcCXhlqElmLYIqCNiAjhaO5xzMMoG0E+jetR1eVKco+Vr4SS9/wIXYE33vsm7yJI8Tahm0zoRKCpn/vQ+8aR/si3QY309FpNx/NAR4Rog
X-Gm-Message-State: AOJu0YwIzqFsPLxI5PR6PFShXVmCgEUNP1cnKy77IWRSUohxHqJ0tt9h
	mdXlbj3/WqkAthqQ3wN8/OuzdmKtW/jpJD7WInGcCxiaNJu5Ipbpvwy9K9NF
X-Google-Smtp-Source: AGHT+IFqvxfm9YQxm7hR+RfoWvFIdHXc4u7EK6d1asKudHaSntNMyhKn3KrIJhVxExpG4CbmzkgW7g==
X-Received: by 2002:ac2:4f04:0:b0:52b:8c88:2d6b with SMTP id 2adb3069b0e04-5309b259c10mr8309724e87.11.1722287186976;
        Mon, 29 Jul 2024 14:06:26 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c2becesm1624210e87.258.2024.07.29.14.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 14:06:26 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/9] net: dsa: vsc73xx: fix port MAC configuration in full duplex mode
Date: Mon, 29 Jul 2024 23:06:08 +0200
Message-Id: <20240729210615.279952-3-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729210615.279952-1-paweldembicki@gmail.com>
References: <20240729210615.279952-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the datasheet description ("Port Mode Procedure" in 5.6.2),
the VSC73XX_MAC_CFG_WEXC_DIS bit is configured only for half duplex mode.

The WEXC_DIS bit is responsible for MAC behavior after an excessive
collision. Let's set it as described in the datasheet.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 43aeb578d608..9bd186af8941 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -1019,6 +1019,11 @@ static void vsc73xx_mac_link_up(struct phylink_config *config,
 
 	if (duplex == DUPLEX_FULL)
 		val |= VSC73XX_MAC_CFG_FDX;
+	else
+		/* In datasheet description ("Port Mode Procedure" in 5.6.2)
+		 * this bit is configured only for half duplex.
+		 */
+		val |= VSC73XX_MAC_CFG_WEXC_DIS;
 
 	/* This routine is described in the datasheet (below ARBDISC register
 	 * description)
@@ -1029,7 +1034,6 @@ static void vsc73xx_mac_link_up(struct phylink_config *config,
 	get_random_bytes(&seed, 1);
 	val |= seed << VSC73XX_MAC_CFG_SEED_OFFSET;
 	val |= VSC73XX_MAC_CFG_SEED_LOAD;
-	val |= VSC73XX_MAC_CFG_WEXC_DIS;
 
 	/* Those bits are responsible for MTU only. Kernel takes care about MTU,
 	 * let's enable +8 bytes frame length unconditionally.
-- 
2.34.1


