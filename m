Return-Path: <netdev+bounces-51950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DA27FCCA7
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 03:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 258E2B2171D
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 02:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C429442E;
	Wed, 29 Nov 2023 02:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myTKw3P9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E10519AE;
	Tue, 28 Nov 2023 18:12:32 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40b397793aaso2298335e9.0;
        Tue, 28 Nov 2023 18:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701223951; x=1701828751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dt4PyFm7vz4PSs/CMN+Td9iZ3kGYAxZdlYsWr/1duKY=;
        b=myTKw3P9yLweJySHRcUsNdISUyaqcUFm1Wws7m20QUkiQ67XLXjysYKARUkRACMtpj
         WcUO+2FM/2e2IHfZQIM9WnHz2IJKBXX9Oh1CDTIg2cFJH77Y1pqV+oDl3ArdAeJjEilp
         4tTsoQ7mQtWUqJXK99lQNdjDWbgwmzLjKlTpmEHxU7x9SkXwotkFixkJN4Bo6ushriAt
         DLTI1X79kut7M4L6qbBBjbjbHrSHAkq13BPK15VnxxZykIwz/XdkMawiLgdZTA/Kzrq3
         DqRDyfGuNdbzaZY+TrWEvSbVxxPt1dNBq97g8yGWJjg9egsBR5szThkbn4hJq2Vpww0i
         1+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701223951; x=1701828751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dt4PyFm7vz4PSs/CMN+Td9iZ3kGYAxZdlYsWr/1duKY=;
        b=lA+QNNWri/QblZ8Cb7nwcEjjJCgL0Tte9AyTsawWSgAPp3dUvt50X/yV5oTC4CxK2D
         2s7wMZQcnlYSxIvb82Z6S96rxaFYJuFqRTO9OYcqhj9toCq09KkkjUSfKtjStonQPyvs
         tXiLJX7/1/Rs5bVBNuy7DcaxCRidHE3m6in3Mxb0uWjZtFKqNODF5jCywRSmV6hj8jVD
         RnkV1Rmr8zQ7n2RNQc5D4fEQbKWfLwhKDT2+PijTijfvgKH2bwu4ZEcb3Eaiwtl+UwID
         REZHPTlmFhZis20V197ccpVbY9yMaHjhgwQ0MXDh30qO8PGrmhuot7iPl0G3ReS6ETNa
         d0dQ==
X-Gm-Message-State: AOJu0Ywg7cmopcYjE++CqJfIQixOeyMBJQfG1qkVpPEkeLZdZSqSTQ11
	oT/tDw3AGYkU57oSYxQ/M0sY4/uSOUI=
X-Google-Smtp-Source: AGHT+IEB+EE62ZxZ6YnKc/wRURf8O/aC2YQ2mvgKi7hDtLh/cSIMB8bMSwMZeV+Goocx5Ff3aZOQzw==
X-Received: by 2002:a05:600c:1d08:b0:40b:2a62:a2b6 with SMTP id l8-20020a05600c1d0800b0040b2a62a2b6mr14429504wms.1.1701223950657;
        Tue, 28 Nov 2023 18:12:30 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id b19-20020a05600c4e1300b0040648217f4fsm321406wmq.39.2023.11.28.18.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 18:12:30 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH 02/14] net: phy: at803x: move disable WOL for 8031 from probe to config
Date: Wed, 29 Nov 2023 03:12:07 +0100
Message-Id: <20231129021219.20914-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231129021219.20914-1-ansuelsmth@gmail.com>
References: <20231129021219.20914-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Probe should be used only for DT parsing and allocate required priv, it
shouldn't touch regs, there is config_init for that.

Move the WOL disable call from probe to config_init to follow this rule
and keep code tidy.

No behaviour is done as the mode was disabled only if phy_read succeeded
in probe and this is translated as the first action done in config_init
(called only if probe returns 0)

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/at803x.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index ef203b0807e5..b32ff82240dc 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -886,15 +886,6 @@ static int at803x_probe(struct phy_device *phydev)
 			priv->is_fiber = true;
 			break;
 		}
-
-		/* Disable WoL in 1588 register which is enabled
-		 * by default
-		 */
-		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
-				     AT803X_PHY_MMD3_WOL_CTRL,
-				     AT803X_WOL_EN, 0);
-		if (ret)
-			return ret;
 	}
 
 	return 0;
@@ -1008,6 +999,15 @@ static int at803x_config_init(struct phy_device *phydev)
 	int ret;
 
 	if (phydev->drv->phy_id == ATH8031_PHY_ID) {
+		/* Disable WoL in 1588 register which is enabled
+		 * by default
+		 */
+		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
+				     AT803X_PHY_MMD3_WOL_CTRL,
+				     AT803X_WOL_EN, 0);
+		if (ret)
+			return ret;
+
 		/* Some bootloaders leave the fiber page selected.
 		 * Switch to the appropriate page (fiber or copper), as otherwise we
 		 * read the PHY capabilities from the wrong page.
-- 
2.40.1


