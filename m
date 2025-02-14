Return-Path: <netdev+bounces-166507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E80A3632E
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 17:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 935E83B40C8
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 16:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913EB267B9F;
	Fri, 14 Feb 2025 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dcc/1Si+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6179267AE7;
	Fri, 14 Feb 2025 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739550750; cv=none; b=ZCIN6w2akJaMYEG+VU02NCUUZEJmfNirAITko4fVfXO8MwkSdfXqnh+7U6b/mPGk+0tTfMQnYYY4wcaAL9FdAU39T+8JMVp2e6a3UCrmtgWept69lHaJ/Vy/8QLvqDrsOitI9caUXvYXdP6A3IM1Xr6kLU4HPkKWpFgI1eZcyHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739550750; c=relaxed/simple;
	bh=7lwrx4RRpVzZCgE/TYuke3KaJPHx8rSawCREvStJyvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mr3ZCoKBBraHR9qaeqT77TXiRhHksOrvd49B8fVya605pLwNYliVMGNA4XPj+0ICAV6iOzEm0Zwq+BU35CA8ffmFShq17bWtuHZyDllumpoFCjmAmnjTHoaWWEPcdvWBHiLrnYkqOjLqg42Zeh4yeiy42/CBhoklJjYnXc07yOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dcc/1Si+; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5dec996069aso3941786a12.2;
        Fri, 14 Feb 2025 08:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739550747; x=1740155547; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HmxvbSXC9J0vj/lTBJKkcQrKbAZ26uQTzWdP7WGpRMw=;
        b=Dcc/1Si+Wu1fZ++JX3d5xxbATtfoYGYLprFixJ1B6SoSeJte71JHh8iP8ODfvN6SAa
         BN/SjffAUXrDF4It+J6ZeWdQu52iV6eRpc+giIqd6drlVpyBGiDAvGM33tPcQfhFrBU5
         LlqBttyI7R4DBt3OV4jQwLHqp83FpjuQ42edOHnOqaAvr49YhTi2OY5lUSdFL/LYdvXC
         O+W79A4v9us0jX4G+forFzdl4oUM8X7lFwmfd+ef+izAUc4g+zEqtSRYfuHIYI+L4ZkO
         Ne+QIubkcIOuRrFZd7HYOPbVnSDnrGKGBLbnb6lJPd/1WgMSQT28lhfosn4zS0xekRH+
         m1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739550747; x=1740155547;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HmxvbSXC9J0vj/lTBJKkcQrKbAZ26uQTzWdP7WGpRMw=;
        b=BQT1cc8cRYOR4Fe6XqHKi/Fq+rRoc4NrL1Jb5GWDQSFbQYmmbiJKxPiwTnz8uCFGPD
         R5JQGRles6EdsmwyNq/tWUqaGvcKLClWYBu8iYpQyuUplH48s6L+UQSDJ2D6Obamj3dH
         dKidRsfo/9UjAM2hhUqDyZlcDyJZeR6XEsnx9jeEJfDZuDvUXuvbhBEPXC2RnZmYALef
         yNsZcEH0ZZEYRmfsVL0nFDN671WsCRzqyu/uqx1GN7Mc6MFxsPLUQFyb2jWdh/xtHNQM
         k0j3bOsasHnbx1TVIPvp8qU43jJunOe54ZMXLFr5cwAr+Mfow8lIm/ykb63JUbliBUgy
         BvGg==
X-Forwarded-Encrypted: i=1; AJvYcCW3XwCFOULNdB9XK9gOYuc3CZvw3/GwwjIFAAaBQCxfHhthHJXIjSsoXc2BfmDHdnoNhKCr5L5eltxoVBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKJ63UdhbYyp5rv6Az3H+bC+QTN2cIftu7h7WAK3yNgdsMXkoB
	qpEbQlwbeUntW9FEEH8isRqnxuhmOmy6E7TV0BmXINYfMWQEYrA5
X-Gm-Gg: ASbGncvJ0lB0tPYDmV6tik5DomgII/O+saYHGyVtPDpGE9f/P8/+YedU3eesazY0AXL
	zc8Xsf0buOOrGgn5an3izePcBxxXlonouxdD/MurhHNX9Jj2ENiWMniFzeJxMsAJrP406728zic
	WKMXXARfY+aSE93pjyJJbSOzSl12HBslx2wyHIJ0EbEKGD3ct2dRxV6wZj4AD8WS0Ft9+whvyk0
	Ndxb0ePEFdrr0q/3Jt8Q86xcORdLPPeOKdTHHvSU6O20n3soOI7ZSq1odd9E+F8AtbGWKK3Q4t2
	+/H5rCa5pvOvAllmDEk=
X-Google-Smtp-Source: AGHT+IHGRLuSZfJeXCb3dQQu1A6Yi5wnlJM4ZCRXl0irJ/FsQ5EvZnKFGPGDceSwJx2Yohsqs0noog==
X-Received: by 2002:a17:907:da5:b0:ab7:e73a:f2cc with SMTP id a640c23a62f3a-ab7f33c7622mr1381130266b.27.1739550746544;
        Fri, 14 Feb 2025 08:32:26 -0800 (PST)
Received: from [127.0.1.1] ([2a00:79c0:653:f300:45fb:7d1a:5e4d:9727])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5323202dsm370716266b.6.2025.02.14.08.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 08:32:26 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
Date: Fri, 14 Feb 2025 17:32:05 +0100
Subject: [PATCH net-next 3/3] net: phy: marvell-88q2xxx: enable temperature
 sensor in mv88q2xxx_config_init
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-marvell-88q2xxx-cleanup-v1-3-71d67c20f308@gmail.com>
References: <20250214-marvell-88q2xxx-cleanup-v1-0-71d67c20f308@gmail.com>
In-Reply-To: <20250214-marvell-88q2xxx-cleanup-v1-0-71d67c20f308@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
 Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
 Stefan Eichenberger <eichest@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2

Temperature sensor gets enabled for 88Q222X devices in
mv88q222x_config_init. Move enabling to mv88q2xxx_config_init because
all 88Q2XXX devices support the temperature sensor.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/net/phy/marvell-88q2xxx.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 7b0913968bb404df1d271b040e698a4c8c391705..1859db10b3914f54486c7e6132b10b0353fa49e6 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -513,6 +513,15 @@ static int mv88q2xxx_config_init(struct phy_device *phydev)
 			return ret;
 	}
 
+	/* Enable temperature sense */
+	if (priv->enable_temp) {
+		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
+				     MDIO_MMD_PCS_MV_TEMP_SENSOR2,
+				     MDIO_MMD_PCS_MV_TEMP_SENSOR2_DIS_MASK, 0);
+		if (ret < 0)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -903,18 +912,6 @@ static int mv88q222x_revb1_revb2_config_init(struct phy_device *phydev)
 
 static int mv88q222x_config_init(struct phy_device *phydev)
 {
-	struct mv88q2xxx_priv *priv = phydev->priv;
-	int ret;
-
-	/* Enable temperature sense */
-	if (priv->enable_temp) {
-		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
-				     MDIO_MMD_PCS_MV_TEMP_SENSOR2,
-				     MDIO_MMD_PCS_MV_TEMP_SENSOR2_DIS_MASK, 0);
-		if (ret < 0)
-			return ret;
-	}
-
 	if (phydev->c45_ids.device_ids[MDIO_MMD_PMAPMD] == PHY_ID_88Q2220_REVB0)
 		return mv88q222x_revb0_config_init(phydev);
 	else

-- 
2.39.5


