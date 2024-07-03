Return-Path: <netdev+bounces-109001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A109267E0
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 20:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A8A11F26366
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 18:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B83718A952;
	Wed,  3 Jul 2024 18:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="znLU8L+e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC7618754A
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 18:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720030312; cv=none; b=NsSrAzI6gKDmpy3L/LtkycFER1YzhWaPyh2y+VlF6eQkEOHnRAcmA4Sg6DnDevUC09C61i5Cgd7ZOqM6ia9Arjw8YuxKsAnIwhK5sM89TENoomM+svHBGZzqTDiLZpqVD92vHlQzPvKQC0mUneBN6RKpldw01nDkDvcJ9kX6B2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720030312; c=relaxed/simple;
	bh=I8ZVS0D82/R3RtH++gdSA2BpSL5i3uiqUGmj0KpPRmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bptajZjxQfu6LSVodROAAfDX4g2ZIThBVQWyDhq5XyRoV+6u6+msp+WACgNSW8fZZolyLn6yiYMdLuPu8oG9jmdui2rGBb61kr+ahcyNq9UJNQZJD90r2/mvZG7zEnuRg+R3qLZqHJDqPLynR2njwAUsQf9AYw0jnjjnYA9e5K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=znLU8L+e; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so6396745e9.1
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 11:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720030309; x=1720635109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DH3kXkonM31DpQhN/1Hxs8pfB1Bit5q7zwIm1RL/Mck=;
        b=znLU8L+edVKJWwnxAsk63EoWyCH1+zDzoWWdOI20ORV7YQXwIy4nwxCzfUS6xD3KKw
         UojKMFhvtmd4Ah6zmWUI45bFOa5FGDpPhZYjzrjwjDu5WZ0aciqsiOo1YF/Q1ZrDYUqc
         07FrTZ7TwNpafvIF2qYm3EweDvwm3p9ozH676WYsyI4E6IYFzMWFgGqCSCsOWcdI51RQ
         Py/96wS+9pxunVICdZMUz2dlwwfQ2+nB4wSiPOKHFp30/9qo3z41n/QgGAId7U6AEzby
         OC303McYXny4Ie2KQNxHZpdW9W0qUXMOdsCwVrAdDUcaCVUTEStSrthznPvec+Lh81a7
         DSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720030309; x=1720635109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DH3kXkonM31DpQhN/1Hxs8pfB1Bit5q7zwIm1RL/Mck=;
        b=XwE6vs8Hi+r0xwC7WaBsOyWZHg64hwFfVhzQBHZRZk5UNLeB3YZqD1Gk+i/DWEdt/P
         GO8bVN0Kca4ZfldKETzrAMCD50u3ojyCj/y3Kv/gasxx7v9WgCXWP5HbuiiHSf5ChhJT
         6HX5cv2lp1ddSJKafNUEkn9tWWW/PNGLe9XXSHX35etJ4PyjDLxI0bj6lUv3jtnZI8Zz
         66yPIGZ9P2PvwI9wKJs8qZ2CfbMi8zqzNDyffKtYFpx1uegxoW0bcNNsfFneQLGP9C82
         5TTaK2wcNN9ZVFR/W45UEItAiqQ2GsGbV5M03tHlgjf1H4n44j5qEUmSqN18FFS/EHm3
         JRpg==
X-Gm-Message-State: AOJu0Yx0rfFM3Gp69sZrrDV0HbgY/ayeim84LECKlJXyxKUh3bSqQb5A
	ER+gbdpGoYMHu0RmYOEH6uqhv8GHBBP18T/rAHgbRJiohfGX0BNMnUMirZyTxlQ=
X-Google-Smtp-Source: AGHT+IHVwe8/4ij6H+78c3AbrhZOwIE2BfvOBOZPCNI35hR3tc0er9IaJ+qw7bNgU/kFrct/G4o16w==
X-Received: by 2002:a05:600c:4da4:b0:424:a401:f012 with SMTP id 5b1f17b1804b1-426408e51d2mr21890405e9.3.1720030309465;
        Wed, 03 Jul 2024 11:11:49 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:c37f:195e:538f:bf06])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af37828sm255295965e9.9.2024.07.03.11.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 11:11:49 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH net-next v3 3/4] net: phy: aquantia: wait for the GLOBAL_CFG to start returning real values
Date: Wed,  3 Jul 2024 20:11:30 +0200
Message-ID: <20240703181132.28374-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240703181132.28374-1-brgl@bgdev.pl>
References: <20240703181132.28374-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

When the PHY is first coming up (or resuming from suspend), it's
possible that although the FW status shows as running, we still see
zeroes in the GLOBAL_CFG set of registers and cannot determine available
modes. Since all models support 10M, add a poll and wait the config to
become available.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/phy/aquantia/aquantia_main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 974795bd0860..2c8ba2725a91 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -652,7 +652,13 @@ static int aqr107_fill_interface_modes(struct phy_device *phydev)
 	unsigned long *possible = phydev->possible_interfaces;
 	unsigned int serdes_mode, rate_adapt;
 	phy_interface_t interface;
-	int i, val;
+	int i, val, ret;
+
+	ret = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
+					VEND1_GLOBAL_CFG_10M, val, val != 0,
+					1000, 100000, false);
+	if (ret)
+		return ret;
 
 	/* Walk the media-speed configuration registers to determine which
 	 * host-side serdes modes may be used by the PHY depending on the
-- 
2.43.0


