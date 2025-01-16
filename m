Return-Path: <netdev+bounces-158937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCF9A13DD6
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 16:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8EC83A1EC2
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 15:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C445F22B8C7;
	Thu, 16 Jan 2025 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GM7SiUdU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33F11DDC12;
	Thu, 16 Jan 2025 15:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737041880; cv=none; b=ih1uECQRSksJloVbHLY5nk+Gv23s8/zYZljLDs9+vp3HOi7dqbimgdOMc5bt8Gr1Bfj4tyZpfnQf+0BoeVWf8X4/oC+MXImsPowG61ryj5ENewYLMv7jOj6TDdrgJwH40qYa9zuRQqMPYl5UKfP6Fhz6ipFw9ci1Z8mhqKD7so0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737041880; c=relaxed/simple;
	bh=ZC0RYR1ltnLyKvLk6LeStwXGRFIa/CFwlUvkdoclUc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MjxFxYJitNTlugN3597cTD6OJWj+wixgrFHniZ0jttwcOibFaXUU16NZlGS7YRThnSjKNCYYXtAKKdAYAKoIOcUuMUe/rmG7otMPX9ZQVmE3l84ft47VObCl1EX8gIA/9fWR3RqPlBdQvVEXt6K/fG6rPLWtfPx4Ukb3jBAuRMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GM7SiUdU; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-436a03197b2so6883775e9.2;
        Thu, 16 Jan 2025 07:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737041877; x=1737646677; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IvKsGcuwHSSfTksCXd89NVhV3jyKpjpaSxG5iBRmpcM=;
        b=GM7SiUdUHOP30ksppVbso0QWFtfp8djVkswHDUJNN1M8x0LkI9D4kSYo/NbDQEQ0FQ
         gbwnWBu+a1H3CO/e2G6DS8yRFaIv9Taux9RRihI5MYkPddUNC9aejEd6QgCHvEk6nnss
         Sfd00akfgpydyhDMqaMKBxNHs3Nl1/dBB6RYBt4xbQqRB8aa5O7cXcaglClsSkHxDBif
         Ej44ZDwGuDd0GJJ8V9YHDq6yaGnh3IFn6kI4+yaT756Ll9ENw/OLATYYZPFs6n34zmQE
         xoNj2JIeRs9Q07EFazpZGfwfqxxszy/ZB5AGxSO3Osf/8AWt2BlFcg55Wuu+J7bW/efi
         EXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737041877; x=1737646677;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IvKsGcuwHSSfTksCXd89NVhV3jyKpjpaSxG5iBRmpcM=;
        b=b/qNKrCp6GoN/TeWd20xNCns3cN/Q3/NeMzoZZ3CiNt0mwIv6R+3/7FLMcTRfwTGgA
         drdeengEG3IiCD3RMDAhNof+NQw82Y93ffg16VO3D9T4tjtKmX1kX7aHyM+5jgn+J0dl
         P9uqsu3JA+cXm7AdUHVLCeFRvwkUXyopUg8B6Q6jcClfSO3QLbGNwW0XdqGOFB8ShL7u
         nUFZxRR2/XXf4LluWX64nLdRvpiT0Fcc27CYn0UPQX3AqewER6grxPsjWVdz6NczPP+S
         Tq6MZm3pDT+gnFr7DIvVpt5/5ftkXJPlw0vyPp5BRn25WJ3TICA1fuVsA2mp+hsLSHSy
         QUFg==
X-Forwarded-Encrypted: i=1; AJvYcCXol2PT9QED3vqEdOAeV65Enjgm0VtwqkT3lY4ln2ZlG6gPw4on5EAUYIgYsn6fZJ/5iZiVsQdcfQb/n+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz78ymmLbKjYzDLT1oGV5vJZtVAkrP8JOdnWt3DQ+QdwKenSZ7r
	pqssHB+FnO2tloo0X8MR766JiEwagTzOYdqd3uCinSa7l946GzYQ
X-Gm-Gg: ASbGncu3pmDvr7vPDH59e6SMG/Km+kuE/wquERMk+Adj8J5sju4Ac0HH9M9ttv7KrGJ
	GyJcZoRlwggTuDd9QIDffpznEKVIokomfjdbC469NrMl+4RIavoWmzUik9bcWwVXLP7LNgzkgke
	Z7VbERNgh4fx9R2CYQIZyskcGt/hx+C/KbDzlstZUAcIMITpMY/KvY/qlsQwyhRyPp+ILZJQaAu
	b6AnhMXG8ZOjqX0urnT3eFV9hr8nUPEfq/czJuA7VVT/DOsKmhkofMrCWE=
X-Google-Smtp-Source: AGHT+IGVC7O7Y8ZL3GoILZTnZsH/SaLMPsr2sypNzFotAMAMRRVYh+NuXcopuvWtoYJPK1cQ0aaKyA==
X-Received: by 2002:a05:600c:1384:b0:436:1c04:aa8e with SMTP id 5b1f17b1804b1-436e26bdac1mr364732675e9.16.1737041877163;
        Thu, 16 Jan 2025 07:37:57 -0800 (PST)
Received: from [127.0.1.1] ([2a00:79c0:650:2c00:303:6c5b:4b07:6715])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4389041f61bsm2834985e9.17.2025.01.16.07.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 07:37:56 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
Date: Thu, 16 Jan 2025 16:37:44 +0100
Subject: [PATCH] net: phy: marvell-88q2xxx: Fix temperature measurement
 with reset-gpios
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-marvell-88q2xxx-fix-hwmon-v1-1-ee5cfda4be87@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMcniWcC/x2MQQqAIBAAvxJ7bkEXyuor0UFqy4WyUigh+nvSc
 RhmHogchCN0xQOBL4my+wy6LGB01i+MMmUGUlQprWvcbLh4XbFpTkop4SwJ3b3tHqfaKGUtt0Q
 Gcn8EzvJ/98P7fph9GDprAAAA
X-Change-ID: 20250116-marvell-88q2xxx-fix-hwmon-d6700aae9227
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

When using temperature measurement on Marvell 88Q2XXX devices and the
reset-gpios property is set in DT, the device does a hardware reset when
interface is brought down and up again. That means that the content of
the register MDIO_MMD_PCS_MV_TEMP_SENSOR2 is reset to default and that
leads to permanent deactivation of the temperature measurement, because
activation is done in mv88q2xxx_probe. To fix this move activation of
temperature measurement to mv88q222x_config_init.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/net/phy/marvell-88q2xxx.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 4494b3e39ce2b672efe49d53d7021b765def6aa6..a3996471a1c9a5d4060d5d19ce44aa70e902a83f 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -95,6 +95,10 @@
 
 #define MDIO_MMD_PCS_MV_TDR_OFF_CUTOFF			65246
 
+struct mv88q2xxx_priv {
+	bool enable_temp;
+};
+
 struct mmd_val {
 	int devad;
 	u32 regnum;
@@ -710,17 +714,12 @@ static const struct hwmon_chip_info mv88q2xxx_hwmon_chip_info = {
 
 static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
 {
+	struct mv88q2xxx_priv *priv = phydev->priv;
 	struct device *dev = &phydev->mdio.dev;
 	struct device *hwmon;
 	char *hwmon_name;
-	int ret;
-
-	/* Enable temperature sense */
-	ret = phy_modify_mmd(phydev, MDIO_MMD_PCS, MDIO_MMD_PCS_MV_TEMP_SENSOR2,
-			     MDIO_MMD_PCS_MV_TEMP_SENSOR2_DIS_MASK, 0);
-	if (ret < 0)
-		return ret;
 
+	priv->enable_temp = true;
 	hwmon_name = devm_hwmon_sanitize_name(dev, dev_name(dev));
 	if (IS_ERR(hwmon_name))
 		return PTR_ERR(hwmon_name);
@@ -743,6 +742,14 @@ static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
 
 static int mv88q2xxx_probe(struct phy_device *phydev)
 {
+	struct mv88q2xxx_priv *priv;
+
+	priv = devm_kzalloc(&phydev->mdio.dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	phydev->priv = priv;
+
 	return mv88q2xxx_hwmon_probe(phydev);
 }
 
@@ -810,6 +817,18 @@ static int mv88q222x_revb1_revb2_config_init(struct phy_device *phydev)
 
 static int mv88q222x_config_init(struct phy_device *phydev)
 {
+	struct mv88q2xxx_priv *priv = phydev->priv;
+	int ret;
+
+	/* Enable temperature sense */
+	if (priv->enable_temp) {
+		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
+				     MDIO_MMD_PCS_MV_TEMP_SENSOR2,
+				     MDIO_MMD_PCS_MV_TEMP_SENSOR2_DIS_MASK, 0);
+		if (ret < 0)
+			return ret;
+	}
+
 	if (phydev->c45_ids.device_ids[MDIO_MMD_PMAPMD] == PHY_ID_88Q2220_REVB0)
 		return mv88q222x_revb0_config_init(phydev);
 	else

---
base-commit: b44e27b4df1a1cd3fd84cf26c82156ed0301575f
change-id: 20250116-marvell-88q2xxx-fix-hwmon-d6700aae9227

Best regards,
-- 
Dimitri Fedrau <dima.fedrau@gmail.com>


