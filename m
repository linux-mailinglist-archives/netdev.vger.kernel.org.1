Return-Path: <netdev+bounces-194656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E962AACBBDA
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 21:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B482A3A45F0
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 19:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4973022AE65;
	Mon,  2 Jun 2025 19:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dG/c9lAS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B06229B21;
	Mon,  2 Jun 2025 19:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748893206; cv=none; b=dVTa1Z6flCZ1dgf5S+6jEZ9xOvuF9T2EiWEzfSxkBBIdBhhH9w+iMO6hPZT1Fajpr/84o2qQcp+qCZcikQuMJA/CkI5RRm147Yy0Fbq+lbAJSYZdv4FsfA9HHLTml/I8kz6TLijeqYP3soPK8aI1s5O3k7MEs6BbkKLfEnuFLus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748893206; c=relaxed/simple;
	bh=FM1OIF5jyi3GYdMHYCF0YylKd/eZT9LkGNpp/L0y6EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FhVJLEIcghh58lYG1wj7fjeUBxGOI9655jmqyXpBjlcGQRJu4/5B1hBz84EgxtQDLD4OENM6hsgtndDORdGrhSeUBUhS+3ItmxONIkOMqQWsRln94+fFqU+SNoFwqrfBxSmNz7F8Zh0io1fdKX+Q0Jy+jqGogNrz1PMx5G6iU3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dG/c9lAS; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6020ff8d51dso8185791a12.2;
        Mon, 02 Jun 2025 12:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748893203; x=1749498003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrFcz0jrIGdyNJHISHvZtvCzGrxOG0pxjV0WsjejwPk=;
        b=dG/c9lASoJgWmimiUkxmuCRcDXZNRBzTr+XdD+HSp8yR/9MOupG0g6q2GDZJI7ULS3
         vt1V4fyafWIyHC9lIimO0jm4KTU32QG2cHC2rIyaXut9Y1XjyRNKLrqrwJAiEeXwXl9a
         b0/wPq/7PwsP6wgjfkBBz5tQv41cKCALYsN6TEFOk0KAQY/hhai6UQsyS2BYNdmtsMy5
         g5XbXDWciLo0iULFBbYtGfnbQOXyK4WokGTHkW87VDU2YqhWo4ZmqLsEsqkqmCzFoiEL
         td+4riOoVc8mfXXfM3v3TAd6/Loz9Pfj5maEwtYPVtdV0+D83mMWDgy7o0Fie3OWHWMK
         9hrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748893203; x=1749498003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nrFcz0jrIGdyNJHISHvZtvCzGrxOG0pxjV0WsjejwPk=;
        b=dx/X6WEeWfFuX6eFQsMe+5R7RUdwwoXCeZO2TdwFV5Sap9c77TspBI/12VFQh7yI1c
         RRExmtqheV0cTk0DCDqnlyL+OZdvBRV8s0ZogqVTLL8Kxs3xJk+NqQD8p+QcAITgxfA7
         YpUqdIKRktuRmQIibLtitreAR37grDwfPcgrEbFN1BoKSUOKmHUbaOhgJnfgBXRwCA4J
         ZIHlBGhmX8xkA5nmo7K9fWVlUEsLc2n4SiWFSzwtB35tBxuRilbVnOJlGn4J1Vk82VJk
         g91Ep4IKogtS1Sdn6vacrIZv+cEvdAMVgqWwS6EDf77Q29Z/JXnFK1GYT48TnxOfvXqX
         CsVA==
X-Forwarded-Encrypted: i=1; AJvYcCU9SHvz1o0Kcl+cMvkwjQ9+PSCTXiits8gL4RCaTfK58gMs/mjoEGwIn1jMsTZ+ak1yTwTL3SIaaD8M3DY=@vger.kernel.org, AJvYcCVGiX7uJE3VkYssRJ8UnQtJ3YVQTBjjPKPTGp7/D2zIof+Wk2X0QCxwhHXRPvji5Bi/fqTId/gA@vger.kernel.org
X-Gm-Message-State: AOJu0YwRccbIVhbgphoCDNsAaagd5qSfIMdHc5g5ffOIxx+3LkO5+Wd+
	UeKOCEZHZvV+d4OfsuG3pjrjWsXXVgAaN/s09dYik7Yqwu3woVMXRKQQ
X-Gm-Gg: ASbGncv6SRASrXY8+ZwMaZjf+dunWknnEFAqX5ZJAXa1oFobdn6rkhBLFmVTTJcLnyh
	V0Mkyak4A8rN1tR+zrn/YtlN4FljJniiAVUD6nGp4y414w/EXEcp2ppsncKwSqcNgkwgH43i2f5
	jUOt6VP0PtzQTU94+1h+nxJq/m7miHEz956fWIpmLJ1hVvr6+PxkkDQDK0A+AAHma+ggYqEZotn
	XibYV+916zqyo5IL4NszQCbMbXLVQ3zbnY0xlQXCk6koTda1wIxp8N5mBo8e+YxAGeg/QJcffIQ
	i7qMGttpUuXZewEOEFOa3LY/YmBtto2JdQX2pVLIgYtf3kzE0LLogV92+6+2eK3Rmy5tEVIYbVt
	dOvlLl5gBQjFpYnst9ok8m3o0BhSWflE=
X-Google-Smtp-Source: AGHT+IGr47poasSImkj54X863XNyqV2MwrfPoTrDvP0NBAw+QQ34FKdUMNXBbfeEjeiuYOBtR8RJdg==
X-Received: by 2002:a05:6402:5189:b0:600:caf:51f1 with SMTP id 4fb4d7f45d1cf-6056ef01cb7mr13750942a12.28.1748893202626;
        Mon, 02 Jun 2025 12:40:02 -0700 (PDT)
Received: from localhost (dslb-002-205-016-252.002.205.pools.vodafone-ip.de. [2.205.16.252])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60699731f06sm554420a12.27.2025.06.02.12.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 12:40:02 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 3/5] net: dsa: b53: do not configure bcm63xx's IMP port interface
Date: Mon,  2 Jun 2025 21:39:51 +0200
Message-ID: <20250602193953.1010487-4-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250602193953.1010487-1-jonas.gorski@gmail.com>
References: <20250602193953.1010487-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IMP port is not a valid RGMII interface, but hard wired to internal,
so we shouldn't touch the undefined register B53_RGMII_CTRL_IMP.

While this does not seem to have any side effects, let's not touch it at
all, so limit RGMII configuration on bcm63xx to the actual RGMII ports.

Fixes: ce3bf94871f7 ("net: dsa: b53: add support for BCM63xx RGMIIs")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
v1 -> v2:
* new patch

 drivers/net/dsa/b53/b53_common.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index c186ee3fb28d..3f4934f974c8 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -22,6 +22,7 @@
 #include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/math.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/platform_data/b53.h>
 #include <linux/phy.h>
@@ -1322,24 +1323,17 @@ static void b53_adjust_63xx_rgmii(struct dsa_switch *ds, int port,
 				  phy_interface_t interface)
 {
 	struct b53_device *dev = ds->priv;
-	u8 rgmii_ctrl = 0, off;
+	u8 rgmii_ctrl = 0;
 
-	if (port == dev->imp_port)
-		off = B53_RGMII_CTRL_IMP;
-	else
-		off = B53_RGMII_CTRL_P(port);
-
-	b53_read8(dev, B53_CTRL_PAGE, off, &rgmii_ctrl);
+	b53_read8(dev, B53_CTRL_PAGE, B53_RGMII_CTRL_P(port), &rgmii_ctrl);
 	rgmii_ctrl &= ~(RGMII_CTRL_DLL_RXC | RGMII_CTRL_DLL_TXC);
 
-	if (port != dev->imp_port) {
-		if (is63268(dev))
-			rgmii_ctrl |= RGMII_CTRL_MII_OVERRIDE;
+	if (is63268(dev))
+		rgmii_ctrl |= RGMII_CTRL_MII_OVERRIDE;
 
-		rgmii_ctrl |= RGMII_CTRL_ENABLE_GMII;
-	}
+	rgmii_ctrl |= RGMII_CTRL_ENABLE_GMII;
 
-	b53_write8(dev, B53_CTRL_PAGE, off, rgmii_ctrl);
+	b53_write8(dev, B53_CTRL_PAGE, B53_RGMII_CTRL_P(port), rgmii_ctrl);
 
 	dev_dbg(ds->dev, "Configured port %d for %s\n", port,
 		phy_modes(interface));
@@ -1484,7 +1478,7 @@ static void b53_phylink_mac_config(struct phylink_config *config,
 	struct b53_device *dev = ds->priv;
 	int port = dp->index;
 
-	if (is63xx(dev) && port >= B53_63XX_RGMII0)
+	if (is63xx(dev) && in_range(port, B53_63XX_RGMII0, 4))
 		b53_adjust_63xx_rgmii(ds, port, interface);
 
 	if (mode == MLO_AN_FIXED) {
-- 
2.43.0


