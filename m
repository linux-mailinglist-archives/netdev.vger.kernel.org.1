Return-Path: <netdev+bounces-104991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDDF90F662
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 20:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 313821C2423A
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 18:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C7515ADB8;
	Wed, 19 Jun 2024 18:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="WOErlLnr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC15158DDC
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 18:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718822770; cv=none; b=QoAHiCotOzvUTXhdvMZibYHtSLDCJ+AL0KjCEHQeMMlco31Rz9jr4PJNqr5o4z0spRvMlzWmL5Hib8/4AXMYC/+kVF6U0JtseirIkZKLJVMs1b7Lx85mgdTCp0SFNiSujASkO0Xr+0Pj7pinIPvFOMoFOHmNxlIwfgQ3a3dwDLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718822770; c=relaxed/simple;
	bh=hMKuphYxcRk1Xq3wJs+eZtl8W7VRQW6ODJK+7oB9dN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ewTxwiwwe8I4pXABsLVzhOt5O5oIT+ytPezxfyofGG9BfivE6dxjGt7rbnRIwQPCUm/MIrla+DGqxnwiA7Vpuxo5ZUQg6iDJkKjmebT/IpgJwuOXX5iIxN05MDVU79MWLD2N+e+cjco6L8LGyptocmyTkOCx0GmCb73rZJlB8rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=WOErlLnr; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-363bbd51050so75210f8f.0
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 11:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718822766; x=1719427566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DXl1d4Y8Fq/VGE/ZlCIrTHLlhnzc/4anlmd+PrIAuk=;
        b=WOErlLnrZIlqTlGuSbB0U4WRLUB9rW6/bSiH4LGVNKHmLNy0gvPTqlZpibvwh0tT9U
         1yONNwt9j4PqHP13/JEiPdWdMezovCwwGqTUWy5TzLYNEFH1DuixMZusKVBfvoOv6qmC
         os247MyvRhAd9IZpkZRr86sTMIoKdI/fetO/oZyVsObBzM96zeB8tPFLbu2b1Q/oKkNH
         crplNMBrSeXMXEt2Vp1Ju5tmNtMneS1z6XwsrrKbSggdWf56+2CskUtHk+/QoQjCKzfj
         z30856nBbZZx1qARqyOxfrkmvVtO+B/HkEL23TCuXOHn6843p9SVd9oZicUqSp9D9pfH
         eYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718822766; x=1719427566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DXl1d4Y8Fq/VGE/ZlCIrTHLlhnzc/4anlmd+PrIAuk=;
        b=mguRirYp+ULFhv8xw/ZduqDv6jKJl+E55XzyS1h/6ytYIDQ4vGv8o2gnLC83kEH1G/
         bEOD6ijC4Bfnzgj4bexffI9E3h5V50aqJ5GtU0U2ZTHFOk4UT0aAUqylMAzpWLrW5s7G
         X4KlVDlLXNO4VmKZzcYf9F0CE4ldohHWLztWLrWlJLPDVCTb2LTySpk+dn8qZPgpDFVE
         6MjRa+iPBYk69/IUYPBdcfxO7X2STb9/XhmZtKl3dukJgNKXLvL/vDdZ517x5ox+6/aH
         UMcYl0K9xuhy2yze4o95jZ+0InDW9VCCNYJd1x+yJsrry/TsdGe4oHxH4dIqE964OmuI
         ORKw==
X-Gm-Message-State: AOJu0YzsPrnTk5WFkaUg8M1wrwi6CXTJPb3tje+0O3s+frmDRaPFamrV
	SazcpF6dbwcXw/dX4zQHTjAXztnfYMIlYMPyNY7wjpwKD9CPu1So4D+OsVWxpag=
X-Google-Smtp-Source: AGHT+IFnMG2uKDWMS0ODk8knrpOgQWkYuhtlFvM28oyZAff20pv5uomTc+TbnoChW8iQa/KMF1tSDw==
X-Received: by 2002:a5d:5269:0:b0:362:4b65:1cd2 with SMTP id ffacd0b85a97d-36317d7311fmr2276902f8f.38.1718822766449;
        Wed, 19 Jun 2024 11:46:06 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:991f:deb8:4c5d:d73d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36098c8c596sm7594156f8f.14.2024.06.19.11.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 11:46:06 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Vinod Koul <vkoul@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH net-next 4/8] net: phy: aquantia: add support for aqr115c
Date: Wed, 19 Jun 2024 20:45:45 +0200
Message-ID: <20240619184550.34524-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240619184550.34524-1-brgl@bgdev.pl>
References: <20240619184550.34524-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add support for a new model to the Aquantia driver. This PHY supports
Overlocked SGMII mode with 2.5G speeds.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/phy/aquantia/aquantia_main.c | 41 ++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 6c14355744b7..11da460698b0 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -29,6 +29,7 @@
 #define PHY_ID_AQR113	0x31c31c40
 #define PHY_ID_AQR113C	0x31c31c12
 #define PHY_ID_AQR114C	0x31c31c22
+#define PHY_ID_AQR115C	0x31c31c33
 #define PHY_ID_AQR813	0x31c31cb2
 
 #define MDIO_PHYXS_VEND_IF_STATUS		0xe812
@@ -111,7 +112,6 @@ static u64 aqr107_get_stat(struct phy_device *phydev, int index)
 	int len_h = stat->size - len_l;
 	u64 ret;
 	int val;
-
 	val = phy_read_mmd(phydev, MDIO_MMD_C22EXT, stat->reg);
 	if (val < 0)
 		return U64_MAX;
@@ -368,7 +368,7 @@ static int aqr107_read_status(struct phy_device *phydev)
 		phydev->interface = PHY_INTERFACE_MODE_RXAUI;
 		break;
 	case MDIO_PHYXS_VEND_IF_STATUS_TYPE_OCSGMII:
-		phydev->interface = PHY_INTERFACE_MODE_2500BASEX;
+		phydev->interface = PHY_INTERFACE_MODE_OCSGMII;
 		break;
 	default:
 		phydev->interface = PHY_INTERFACE_MODE_NA;
@@ -721,6 +721,18 @@ static int aqr113c_config_init(struct phy_device *phydev)
 	return aqr107_fill_interface_modes(phydev);
 }
 
+static int aqr115c_config_init(struct phy_device *phydev)
+{
+	/* Check that the PHY interface type is compatible */
+	if (phydev->interface != PHY_INTERFACE_MODE_SGMII &&
+	    phydev->interface != PHY_INTERFACE_MODE_OCSGMII)
+		return -ENODEV;
+
+	phy_set_max_speed(phydev, SPEED_2500);
+
+	return 0;
+}
+
 static int aqr107_probe(struct phy_device *phydev)
 {
 	int ret;
@@ -999,6 +1011,30 @@ static struct phy_driver aqr_driver[] = {
 	.led_hw_control_get = aqr_phy_led_hw_control_get,
 	.led_polarity_set = aqr_phy_led_polarity_set,
 },
+{
+	PHY_ID_MATCH_MODEL(PHY_ID_AQR115C),
+	.name           = "Aquantia AQR115C",
+	.probe          = aqr107_probe,
+	.get_rate_matching = aqr107_get_rate_matching,
+	.config_init    = aqr115c_config_init,
+	.config_aneg    = aqr_config_aneg,
+	.config_intr    = aqr_config_intr,
+	.handle_interrupt = aqr_handle_interrupt,
+	.read_status    = aqr107_read_status,
+	.get_tunable    = aqr107_get_tunable,
+	.set_tunable    = aqr107_set_tunable,
+	.suspend        = aqr107_suspend,
+	.resume         = aqr107_resume,
+	.get_sset_count = aqr107_get_sset_count,
+	.get_strings    = aqr107_get_strings,
+	.get_stats      = aqr107_get_stats,
+	.link_change_notify = aqr107_link_change_notify,
+	.led_brightness_set = aqr_phy_led_brightness_set,
+	.led_hw_is_supported = aqr_phy_led_hw_is_supported,
+	.led_hw_control_set = aqr_phy_led_hw_control_set,
+	.led_hw_control_get = aqr_phy_led_hw_control_get,
+	.led_polarity_set = aqr_phy_led_polarity_set,
+},
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR813),
 	.name		= "Aquantia AQR813",
@@ -1042,6 +1078,7 @@ static struct mdio_device_id __maybe_unused aqr_tbl[] = {
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR113) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR113C) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR114C) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR115C) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR813) },
 	{ }
 };
-- 
2.43.0


