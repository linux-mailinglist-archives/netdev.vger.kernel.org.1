Return-Path: <netdev+bounces-189736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C035BAB3685
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 14:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 491CC164D57
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 12:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1363829188E;
	Mon, 12 May 2025 12:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ja+wQ9Q9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189082798F6;
	Mon, 12 May 2025 12:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747051448; cv=none; b=Ehyp2T6nhtBLBxG3oYqCSvTPkQBuYPkMxfxTu+EvoFQnOPaLb/rtvGq3b6J4ZhCxMyQk44UmWsX+CDpjITMSgLozDjBOEqZ36WLk7f9UDhgxBVXw3e1LhSiHrUSbIllnjf1HtwvPsanFlTGlafDyqEzF1HNlxq8NCcoIzYcIiyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747051448; c=relaxed/simple;
	bh=ii4KRCHs29y4O5XCyMXOMjgkEhpDtt5Y2IviGT33gTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qy3yJqYa8xlUXV47Vc8f2Le2P3K8FED3uMrMQhnTelcznbhgcUzyNKLz9Fo1O2le1t0OekETvE+iUfvsMf2AOjwQd+Xt+uJANzZOeodGlJe2YC4OyIU/tbXImfbe0XXQGzO4nBMEctozUFeDqEbDr7xRqnjR6O/tH9QNwENCIB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ja+wQ9Q9; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so36710485e9.1;
        Mon, 12 May 2025 05:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747051444; x=1747656244; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZO8pZbDsRoynnhm7Y1CwjkgoOKbYUaTd40m+78ifVE=;
        b=ja+wQ9Q9Mlhf4KENK1cGLl58CLDUKrjb9e5ma11vgIgyL6N0Xv95bGUxmVzxmDBeHU
         6Y4nUoYhqFFxWe6CZ0bswtwdoG09SJEfRlUqzuiRLDzbr8bum98zxTFalzKz6LbYJFRL
         GfiDbgHsomr60JsOiK8Fbb1kkdxyEm4fz/Lf1opI24ucq/YO3qWdMCHQLmuaD8ej4cn1
         YTyFYqVal4StU1lwO33ZRiJk2ASomuzUzG65ZWTT/gHgcCsX5/xMVvr9lXYJftuLWhRa
         MLGvlLG1GqZyu5f7jLkT+GUrSE1VJETF1rL5Lm6iXg5/Iwm/EI0EBOPGHTcn38c3quPY
         hWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747051444; x=1747656244;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ZO8pZbDsRoynnhm7Y1CwjkgoOKbYUaTd40m+78ifVE=;
        b=oKyYU7FfgnSjYYPhYpwdg6pV3YZtVDS7vFWDUNfhn/Qjc6ahsUjSWRFwndFEFnaZmm
         Y3C+xFfvruBjLtBqfj+qqIvxyMH6vXPcJejcB2G+fMd8UFqt9GUlx6xrtwt0m+DFWB6u
         FoCOpwDsBm570vbHZfbEDJMjWELpvwBrpHCvR7CphFvcX1Tf4AUaOPfuxAGrYbwhPTix
         7Twaw61sxHEBvdEj0BSAXaDnMP/PUbSdlaiu4mZmNRAMMP3FBk5O6jB1wuY4POJfCXEE
         JZYUlAb0dI+cR4dyHXybC+OlN+JTRUxnaTdI0/Kr9GThS3gcTlnIPrm1XxYzOs7pFZ9t
         1k3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVuw8A/wh9ODgsSDrf/EAaGbSGORnEwlJUr68oWZ0JxTwPqU2zf1OqQOW0q/Xnla7zu08wX42ugyMNRLZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp4np6xchbbUqqCUG2+VgS7d/b8UO2TDJG9xxOqBMydCFVuSIY
	/T3vmqy1cBkCsgR2HZ1zgxODOgYDjAWSvNDN1DGzO4VwjVNZJymH
X-Gm-Gg: ASbGnct+sDyeMdvibz+KYDyy5D4L7PP38P6yXnsvn39zoK+jq5YNznlCaWUTp70Wy3S
	UTc90f0mCc38In2CH+PUhvE2YSxxhDDUbXsEOeWm29XsEPOMW29vTR8T20Snb2znyRkpQv0dZqx
	I/QvR1z7BVw7cDeB4QNHk01ytfjXz5XY4iFkoh3fyyQkYedjcI4cFdWPshvt2VgVCmqOaRIVi6n
	gDhZ7AAymKFidRD69249WHH/XpqG9azSVggeLyApk90YS0sa70J0objCpqYgbGPGzlU/SbUC7kA
	im3RGGiRGbfgZPWyze7Fv/maAQUzigKFd38IzpM8JYu0iJE8bDGRBRs=
X-Google-Smtp-Source: AGHT+IEEGMeINSgVe6WSQZ6v690B951EWDFendDNt85VGvu6pqNiLUdzKldTgg1Omn39IsVG9eP+Bw==
X-Received: by 2002:a05:6000:402a:b0:3a0:b56a:c256 with SMTP id ffacd0b85a97d-3a1f6ccfb5amr10789066f8f.28.1747051444022;
        Mon, 12 May 2025 05:04:04 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:79c0:632:2600:45fb:7d1a:5e4d:9727])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f579aa5bsm12183798f8f.0.2025.05.12.05.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 05:04:03 -0700 (PDT)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
Date: Mon, 12 May 2025 14:03:42 +0200
Subject: [PATCH net-next v4] net: phy: marvell-88q2xxx: Enable temperature
 measurement in probe again
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250512-marvell-88q2xxx-hwmon-enable-at-probe-v4-1-9256a5c8f603@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJ3jIWgC/43OzWrEIBQF4FcZXPcWveZHu+p7lC5uzO1ESHRqg
 rUMefdKKHToKsvDge+cu1g5eV7Fy+UuEme/+hhqaJ4uwk0Urgx+rFmgxFai6mGhlHmewZhPLKX
 A9LXEABxomBlog1uKAwMSdl2nsbWmFdW6Jf7w5dh5E4E3CFw28V6bya9bTN/HgayO/nfLnNzKC
 iRYa0nLxhlS6vW6kJ+fXVyOhYwPKsqzKla1NwMabajDkf6r+k9t0J5VNdS3ulXOjVZhz4/qvu8
 /WWlWqZABAAA=
X-Change-ID: 20250217-marvell-88q2xxx-hwmon-enable-at-probe-2a2666325985
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
 Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
 Stefan Eichenberger <eichest@gmail.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2

Enabling of the temperature sensor was moved from mv88q2xxx_hwmon_probe to
mv88q222x_config_init with the consequence that the sensor is only
usable when the PHY is configured. Enable the sensor in
mv88q2xxx_hwmon_probe as well to fix this.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
Changes in v4:
- Create helper mv88q2xxx_enable_temp_sense
- Link to v3: https://lore.kernel.org/r/20250429-marvell-88q2xxx-hwmon-enable-at-probe-v3-1-0351ccd9127e@gmail.com

Changes in v3:
- Remove patch "net: phy: marvell-88q2xxx: Prevent hwmon access with asserted reset"
  from series. There will be a separate patch handling this and I'm not
  sure if it is going to be accepted. Separating this is necessary
  because the temperature reading is somehow odd at the moment, because
  the interface has to be brought up for it to work. See:
  https://lore.kernel.org/netdev/20250418145800.2420751-1-niklas.soderlund+renesas@ragnatech.se/
- Link to v2: https://lore.kernel.org/r/20250220-marvell-88q2xxx-hwmon-enable-at-probe-v2-0-78b2838a62da@gmail.com

Changes in v2:
- Add comment in mv88q2xxx_config_init why the temperature sensor is
  enabled again (Stefan)
- Fix commit message by adding the information why the PHY reset might
  be asserted. (Andrew)
- Remove fixes tags (Andrew)
- Switch to net-next (Andrew)
- Return ENETDOWN instead of EIO when PHYs reset is asserted in
  mv88q2xxx_hwmon_read (Andrew)
- Add check if PHYs reset is asserted in mv88q2xxx_hwmon_write as it was
  done in mv88q2xxx_hwmon_read
- Link to v1: https://lore.kernel.org/r/20250218-marvell-88q2xxx-hwmon-enable-at-probe-v1-0-999a304c8a11@gmail.com
---
 drivers/net/phy/marvell-88q2xxx.c | 103 +++++++++++++++++++++-----------------
 1 file changed, 57 insertions(+), 46 deletions(-)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 5c687164b8e068f3f09e91cd4dd198f24782682e..f3d83b04c9535c78091a2491d3d551d4d340d130 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -119,7 +119,6 @@
 #define MV88Q2XXX_LED_INDEX_GPIO			1
 
 struct mv88q2xxx_priv {
-	bool enable_temp;
 	bool enable_led0;
 };
 
@@ -482,49 +481,6 @@ static int mv88q2xxx_config_aneg(struct phy_device *phydev)
 	return phydev->drv->soft_reset(phydev);
 }
 
-static int mv88q2xxx_config_init(struct phy_device *phydev)
-{
-	struct mv88q2xxx_priv *priv = phydev->priv;
-	int ret;
-
-	/* The 88Q2XXX PHYs do have the extended ability register available, but
-	 * register MDIO_PMA_EXTABLE where they should signalize it does not
-	 * work according to specification. Therefore, we force it here.
-	 */
-	phydev->pma_extable = MDIO_PMA_EXTABLE_BT1;
-
-	/* Configure interrupt with default settings, output is driven low for
-	 * active interrupt and high for inactive.
-	 */
-	if (phy_interrupt_is_valid(phydev)) {
-		ret = phy_set_bits_mmd(phydev, MDIO_MMD_PCS,
-				       MDIO_MMD_PCS_MV_GPIO_INT_CTRL,
-				       MDIO_MMD_PCS_MV_GPIO_INT_CTRL_TRI_DIS);
-		if (ret < 0)
-			return ret;
-	}
-
-	/* Enable LED function and disable TX disable feature on LED/TX_ENABLE */
-	if (priv->enable_led0) {
-		ret = phy_clear_bits_mmd(phydev, MDIO_MMD_PCS,
-					 MDIO_MMD_PCS_MV_RESET_CTRL,
-					 MDIO_MMD_PCS_MV_RESET_CTRL_TX_DISABLE);
-		if (ret < 0)
-			return ret;
-	}
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
-	return 0;
-}
-
 static int mv88q2xxx_get_sqi(struct phy_device *phydev)
 {
 	int ret;
@@ -667,6 +623,12 @@ static int mv88q2xxx_resume(struct phy_device *phydev)
 }
 
 #if IS_ENABLED(CONFIG_HWMON)
+static int mv88q2xxx_enable_temp_sense(struct phy_device *phydev)
+{
+	return phy_modify_mmd(phydev, MDIO_MMD_PCS, MDIO_MMD_PCS_MV_TEMP_SENSOR2,
+			      MDIO_MMD_PCS_MV_TEMP_SENSOR2_DIS_MASK, 0);
+}
+
 static const struct hwmon_channel_info * const mv88q2xxx_hwmon_info[] = {
 	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_ALARM),
 	NULL
@@ -762,11 +724,13 @@ static const struct hwmon_chip_info mv88q2xxx_hwmon_chip_info = {
 
 static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
 {
-	struct mv88q2xxx_priv *priv = phydev->priv;
 	struct device *dev = &phydev->mdio.dev;
 	struct device *hwmon;
+	int ret;
 
-	priv->enable_temp = true;
+	ret = mv88q2xxx_enable_temp_sense(phydev);
+	if (ret < 0)
+		return ret;
 
 	hwmon = devm_hwmon_device_register_with_info(dev, NULL, phydev,
 						     &mv88q2xxx_hwmon_chip_info,
@@ -776,6 +740,11 @@ static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
 }
 
 #else
+static int mv88q2xxx_enable_temp_sense(struct phy_device *phydev)
+{
+	return 0;
+}
+
 static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
 {
 	return 0;
@@ -843,6 +812,48 @@ static int mv88q2xxx_probe(struct phy_device *phydev)
 	return mv88q2xxx_hwmon_probe(phydev);
 }
 
+static int mv88q2xxx_config_init(struct phy_device *phydev)
+{
+	struct mv88q2xxx_priv *priv = phydev->priv;
+	int ret;
+
+	/* The 88Q2XXX PHYs do have the extended ability register available, but
+	 * register MDIO_PMA_EXTABLE where they should signalize it does not
+	 * work according to specification. Therefore, we force it here.
+	 */
+	phydev->pma_extable = MDIO_PMA_EXTABLE_BT1;
+
+	/* Configure interrupt with default settings, output is driven low for
+	 * active interrupt and high for inactive.
+	 */
+	if (phy_interrupt_is_valid(phydev)) {
+		ret = phy_set_bits_mmd(phydev, MDIO_MMD_PCS,
+				       MDIO_MMD_PCS_MV_GPIO_INT_CTRL,
+				       MDIO_MMD_PCS_MV_GPIO_INT_CTRL_TRI_DIS);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Enable LED function and disable TX disable feature on LED/TX_ENABLE */
+	if (priv->enable_led0) {
+		ret = phy_clear_bits_mmd(phydev, MDIO_MMD_PCS,
+					 MDIO_MMD_PCS_MV_RESET_CTRL,
+					 MDIO_MMD_PCS_MV_RESET_CTRL_TX_DISABLE);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Enable temperature sense again. There might have been a hard reset
+	 * of the PHY and in this case the register content is restored to
+	 * defaults and we need to enable it again.
+	 */
+	ret = mv88q2xxx_enable_temp_sense(phydev);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int mv88q2110_config_init(struct phy_device *phydev)
 {
 	int ret;

---
base-commit: 0d15a26b247d25cd012134bf8825128fedb15cc9
change-id: 20250217-marvell-88q2xxx-hwmon-enable-at-probe-2a2666325985

Best regards,
-- 
Dimitri Fedrau <dima.fedrau@gmail.com>


