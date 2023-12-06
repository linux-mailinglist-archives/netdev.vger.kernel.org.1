Return-Path: <netdev+bounces-54683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F27A807CA8
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 01:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAF972814CE
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 00:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDA0341AD;
	Thu,  7 Dec 2023 00:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBFiFxZv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A869ED62;
	Wed,  6 Dec 2023 16:00:28 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40b2ad4953cso8433275e9.0;
        Wed, 06 Dec 2023 16:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701907227; x=1702512027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYf/4x1S6Xi4qxCbsW/ZhILQxOYsjDvuEIJRKEsMK/k=;
        b=RBFiFxZvRRQzYOeDmuZrldz20PDWn4DKI+awAiIwtSUPIn+npVFpkMfV6EJTA64Be8
         lWCqjQ0JcxrnFn8k+VkgYeYrJuKPuH6GCh+0o3gSSrWzSPaNPIraOiag/+0JZm6gFGsn
         YmK5QhTgCR12YFdKI8joW6Unxk02n7Ji7jXoCO/1hQrrz3TjkG71rg0Nfn2RXGCfr4Ih
         GgrMRaJHPMNRsaPEi/HFMRc0nON9bC41GAJ5PC4R5QZUi0TM7M87W+MLJebPKgvo5aSQ
         mXjhneK2mcP6QsY/GbzUemVBhow/lKmmAmqU6xXt8XJUWWYpNzLAL53ugTdhqzAqsjrM
         XErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701907227; x=1702512027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rYf/4x1S6Xi4qxCbsW/ZhILQxOYsjDvuEIJRKEsMK/k=;
        b=DZT4henzxJ6aIPI+LqOyx1qaue9OF6sC7eSh2DED7ejjZE2X7DN5TAkG8TBt2DPlnd
         gP+njGBzyKThOEnY9aq5hmhGKO+cOoxtFBjWfcrNEsMMiLxdBpNQ0lQSubR4g6r6cfvl
         m965c2+nrpAsSrjGkXhns3F9RrBWTkJKIynjpgBh8dNu98S4hcTcG0/q+SCQQHpAKlb4
         O5SvcOL3VCxTR+TTLyvGAYCm8z2beqZiOOq7eq2vjtrZsjwyVB8SD7snT552qcNcx2pS
         T49qWzi10TjohX2SS2bA9UbYIiFOEf65kIAxu5yiXlH1Dt6VUSCbuVWfMCfLx6PNl6gp
         gS3w==
X-Gm-Message-State: AOJu0YwGhzZtjEz0c0pPDlU2mbpRXlXLKqZ5G15rSXtBMoeuZAg+Ip+Z
	8izACVpKVnSRlh/ubVd6hYo=
X-Google-Smtp-Source: AGHT+IElsDJmDetQs/EdK0OPQeUrb6dsfr3O805FFpJ7oprp00YCThosfXR+HgRJpzu3BY5wA2GFWg==
X-Received: by 2002:a7b:ce08:0:b0:40b:5e56:7b67 with SMTP id m8-20020a7bce08000000b0040b5e567b67mr2141779wmc.176.1701907227032;
        Wed, 06 Dec 2023 16:00:27 -0800 (PST)
Received: from localhost.localdomain (host-79-26-252-6.retail.telecomitalia.it. [79.26.252.6])
        by smtp.googlemail.com with ESMTPSA id je16-20020a05600c1f9000b00405442edc69sm50280wmb.14.2023.12.06.16.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 16:00:26 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v3 09/13] net: phy: at803x: move specific at8031 config_intr to dedicated function
Date: Thu,  7 Dec 2023 00:57:24 +0100
Message-Id: <20231206235728.6985-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231206235728.6985-1-ansuelsmth@gmail.com>
References: <20231206235728.6985-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move specific at8031 config_intr bits to dedicated function to make
at803x_config_initr more generic.

This is needed in preparation for PHY driver split as qca8081 share the
same function to setup interrupts.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/at803x.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 2de7a59c0faa..1897030667d9 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -990,7 +990,6 @@ static int at803x_ack_interrupt(struct phy_device *phydev)
 
 static int at803x_config_intr(struct phy_device *phydev)
 {
-	struct at803x_priv *priv = phydev->priv;
 	int err;
 	int value;
 
@@ -1007,10 +1006,6 @@ static int at803x_config_intr(struct phy_device *phydev)
 		value |= AT803X_INTR_ENABLE_DUPLEX_CHANGED;
 		value |= AT803X_INTR_ENABLE_LINK_FAIL;
 		value |= AT803X_INTR_ENABLE_LINK_SUCCESS;
-		if (priv->is_fiber) {
-			value |= AT803X_INTR_ENABLE_LINK_FAIL_BX;
-			value |= AT803X_INTR_ENABLE_LINK_SUCCESS_BX;
-		}
 
 		err = phy_write(phydev, AT803X_INTR_ENABLE, value);
 	} else {
@@ -1619,6 +1614,29 @@ static int at8031_set_wol(struct phy_device *phydev,
 	return ret;
 }
 
+static int at8031_config_intr(struct phy_device *phydev)
+{
+	struct at803x_priv *priv = phydev->priv;
+	int err, value = 0;
+
+	if (phydev->interrupts == PHY_INTERRUPT_ENABLED &&
+	    priv->is_fiber) {
+		/* Clear any pending interrupts */
+		err = at803x_ack_interrupt(phydev);
+		if (err)
+			return err;
+
+		value |= AT803X_INTR_ENABLE_LINK_FAIL_BX;
+		value |= AT803X_INTR_ENABLE_LINK_SUCCESS_BX;
+
+		err = phy_set_bits(phydev, AT803X_INTR_ENABLE, value);
+		if (err)
+			return err;
+	}
+
+	return at803x_config_intr(phydev);
+}
+
 static int qca83xx_config_init(struct phy_device *phydev)
 {
 	u8 switch_revision;
@@ -2139,7 +2157,7 @@ static struct phy_driver at803x_driver[] = {
 	.write_page		= at803x_write_page,
 	.get_features		= at803x_get_features,
 	.read_status		= at803x_read_status,
-	.config_intr		= at803x_config_intr,
+	.config_intr		= at8031_config_intr,
 	.handle_interrupt	= at803x_handle_interrupt,
 	.get_tunable		= at803x_get_tunable,
 	.set_tunable		= at803x_set_tunable,
-- 
2.40.1


