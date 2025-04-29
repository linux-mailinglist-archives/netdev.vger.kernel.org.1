Return-Path: <netdev+bounces-186662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B89AA03CD
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 08:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA36A3ADBD4
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 06:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A58D270EC3;
	Tue, 29 Apr 2025 06:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtzRv5H8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522551E515;
	Tue, 29 Apr 2025 06:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745909682; cv=none; b=K+YrmtB6enjd/HlMr2X9KkcY88Je+xd+Yje2IoFde5BAjlDKJmPu8XnhsMIk0Ss81I6Wx4KpW3YCFkPs8n3ytWmGyudFfv1yEfJsUUpBoAyKx2Owj8XDDg+Ckk/2yYxI7CVIEfUrVPox0/C/pW7I7mzXcBhZsbgyyJnCfW9QpfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745909682; c=relaxed/simple;
	bh=QS4g/DJskkmyG3WGjE3wU7hR1aISCZAwwI1Gc+GN2xo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MUhFA3HeMn4KfaV8nZ0okDqPbFT0kdWCivN0mZJDtyEm+YQtkmycFvytI2ut00PWBpT5lpDs+qnFWPmhYNSp3cJZTT0f7cPhcuRaulX1WrUGC+aZtnDS3O6wTO2ToN3VG0DO+o7lPeWwPS3Vyt5gr4b10jqUg2cnN4vdqQtzNLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtzRv5H8; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43ed8d32a95so49632455e9.3;
        Mon, 28 Apr 2025 23:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745909678; x=1746514478; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D7E1N/UpacKCrkBNmeE1dayNBzrDWeX6gVQV+4Chjqo=;
        b=ZtzRv5H8CTgbH4MHXghHHtdvvisT0ycppAmiVxfuY5585bGP5ZKCi6kzpZZgyLmZAc
         Vsbug3NT9l4zZc7Gi91mcE790p7yEt+l28jn1c3Fn0aapdovyEcy3Vvy3gz5dq4kRLQk
         FOItIuvqFZcKxC+irkhtvAhw92t3AITxBYpKvzWyyRWWVvMldSQSFtKTr3vajOYPR0m2
         RDTUcz2nl9z4MHv83PqwuRHKAe637lX+CTew5yk3kSQio4diWJOGeM5spKVy7EbRYXJN
         9bS718JpK/GHc9rGsFfkUg9Zl4vJMyl7F/UDmJMq5k58ta/Z7bowZ1qLNJbK6LVrxmEN
         FUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745909678; x=1746514478;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D7E1N/UpacKCrkBNmeE1dayNBzrDWeX6gVQV+4Chjqo=;
        b=hNNQlAsk5xUj/bJOjBsbaJxcT7K5SttrrmA+6g2UagjuldJ5zN8wZ9XPmhHyO8tb/C
         /qUAXWq3NmcQeKnkQltFQxtF7fHRu4hTr2hkLGqH+XVF1pHpxtEGhxfd5OdwwI+dPhvu
         nbAG6FbPOzz0D68qivWl68HPhE0/z5P7Yg9MWQlF5TfErb1CklaOsWnP1C0+cEdpjeIL
         K12s2nny9XgscBxcSVmJhzhC7nulIaYEXktWVCws6vLZAHR4CoYjlAHxPW0xL1bvmkxt
         eHOBFk0wWipVQXJqc5TNtxBA/LfCLqAh8DGsEz72IpArfw945JTHY8dfdqwFWD/9N3oH
         CN+w==
X-Forwarded-Encrypted: i=1; AJvYcCXMp89moQIEmYK2YxfKUOaAFR5tnzQWPg7Ylv6jA+E/cgYLzkQNRz5L7gRe7TJxqXOTbXYVVPc4mJZ3PtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzolsgJAFEFagJEHn8GuGPNc8ar+89q77xqiMUMi+UOn6/c/Ea7
	xPQAJCySY+GwIVr31A6fsB7rT96NVoPpKI3d1FId9uspsk0EqV8a
X-Gm-Gg: ASbGnctog9FwneGteFmYvP1e0FVDlx2WlfHLuHI1gfVBEKaqZH7aXLLZ537Ya/3Kcxl
	HOIfZY8KARi8APszM22Vyb8gwfsW8MVPLe+CyIKMYhHm6OK1mQddFqmFLVTyb3rWxb+kYcWGisG
	P/V84VN9k15XeWGZ7iaBY4UW9TQaHvyEjbNwNCbDK5ZJp6yR9051APOKLNPwwr/+LiBwW0HkOSv
	MTE5neOh1P5eMInU0kAJz3lxTkc/IoZ0PLMLm4M2PgLA5G3sDUq7daLmFtIXSYcJ+3ngjuD8iJ9
	zHNzdPCiniPX81Rv5hPuYh/dyyMM37uighi8o1ctNz0R
X-Google-Smtp-Source: AGHT+IF5zzw0joQplVD8O1YMC5LrZL5G9q2qTXG2tg8+eefUxxDDQmSd91NNGB5VH8VMeSq82sorvA==
X-Received: by 2002:a05:600c:1988:b0:43d:fa58:81d3 with SMTP id 5b1f17b1804b1-441ac91d3f9mr11143495e9.32.1745909678170;
        Mon, 28 Apr 2025 23:54:38 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:79c0:614:df00:45fb:7d1a:5e4d:9727])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a536a021sm145374365e9.29.2025.04.28.23.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 23:54:37 -0700 (PDT)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
Date: Tue, 29 Apr 2025 08:54:25 +0200
Subject: [PATCH net-next v3] net: phy: marvell-88q2xxx: Enable temperature
 measurement in probe again
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-marvell-88q2xxx-hwmon-enable-at-probe-v3-1-0351ccd9127e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKB3EGgC/42OQQ6CMBBFr2K6dkw7CBZX3sO4GGCUJtBiIbWGc
 Hcb4oIly5efvPdnMbI3PIrrYRaegxmNswmy40HULdkXg2kSC5SYS1QX6MkH7jrQ+o0xRmg/vbP
 AlqqOgSYYvKsYkLAoigzzUuciuQbPTxPXzl1YnsBynMQjLa0ZJ+e/64Gg1v3f0jtbQYGEsiwpk
 +dak1K3V0+mO9WuXwsBN1aUe62YrBddoc40FdjQ1rosyw9ZM+rIOgEAAA==
X-Change-ID: 20250217-marvell-88q2xxx-hwmon-enable-at-probe-2a2666325985
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
 Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
 Stefan Eichenberger <eichest@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2

Enabling of the temperature sensor was moved from mv88q2xxx_hwmon_probe to
mv88q222x_config_init with the consequence that the sensor is only
usable when the PHY is configured. Enable the sensor in
mv88q2xxx_hwmon_probe as well to fix this.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
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
 drivers/net/phy/marvell-88q2xxx.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 5c687164b8e068f3f09e91cd4dd198f24782682e..5d2fbbf332933ffe06f4506058e380fbc7c52921 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -513,7 +513,10 @@ static int mv88q2xxx_config_init(struct phy_device *phydev)
 			return ret;
 	}
 
-	/* Enable temperature sense */
+	/* Enable temperature sense again. There might have been a hard reset
+	 * of the PHY and in this case the register content is restored to
+	 * defaults and we need to enable it again.
+	 */
 	if (priv->enable_temp) {
 		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
 				     MDIO_MMD_PCS_MV_TEMP_SENSOR2,
@@ -765,6 +768,13 @@ static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
 	struct mv88q2xxx_priv *priv = phydev->priv;
 	struct device *dev = &phydev->mdio.dev;
 	struct device *hwmon;
+	int ret;
+
+	/* Enable temperature sense */
+	ret = phy_modify_mmd(phydev, MDIO_MMD_PCS, MDIO_MMD_PCS_MV_TEMP_SENSOR2,
+			     MDIO_MMD_PCS_MV_TEMP_SENSOR2_DIS_MASK, 0);
+	if (ret < 0)
+		return ret;
 
 	priv->enable_temp = true;
 

---
base-commit: 0d15a26b247d25cd012134bf8825128fedb15cc9
change-id: 20250217-marvell-88q2xxx-hwmon-enable-at-probe-2a2666325985

Best regards,
-- 
Dimitri Fedrau <dima.fedrau@gmail.com>


