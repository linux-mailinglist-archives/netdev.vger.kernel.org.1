Return-Path: <netdev+bounces-189482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BF6AB24E3
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 19:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D79BC3BFCA9
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 17:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B54D22F392;
	Sat, 10 May 2025 17:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="N6baxT28"
X-Original-To: netdev@vger.kernel.org
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209B822B8D9;
	Sat, 10 May 2025 17:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746899886; cv=none; b=fLqgzw+gUCKDyyMh1VAVVHAB2o8X2kvrNll6L1nhKKkHE7x1EvRqWLcUB1mwIa4wRB9UxpHPfDgVEj8SC/bCkoihh0y7FaPOpqGR5r5FaD61djCs3SzjWtgs+DnfigKkpd2pXR8EkaCo2wH/0ifLiwIjHvQVVXixoeAcl5dgFuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746899886; c=relaxed/simple;
	bh=QQf//rEMyNITbaywNt9GDXiXMR5B3IjJlWxUEQrvqOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XJYvxiP8gcyrNE+yKxip02wLRKf0scPn30+OevHkgRjMlHhuZf2qnD5i5UT5yEl5sKr3B/porApczrpmJMhQcrVYRMNCKuB37/oWgoreoydX6WZnpKJXOmA5Vyfje6lIcZT7IQ/0VE0Kf/274GZzkGTnH5MOYHKpqUQZhlYjNdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=N6baxT28; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox4.masterlogin.de (unknown [192.168.10.79])
	by mxout4.routing.net (Postfix) with ESMTP id 0FB381003BB;
	Sat, 10 May 2025 17:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1746899400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZJk9iIuV2ZtYqSNu6/IHDZogtwF6sWyClO8J6khSNsA=;
	b=N6baxT28joV5PobXemFEQf3aHy//NBRJu5h1FppZg7CUlO5K2vaKkykWWLWuFN3Z5Qi+m/
	4aUx9ZMqr3ub0pMZqD8QDhU6T6lONQ+lChXAVa/DTw7j+e/isAzXlf5pL4el4CuZJcjGcw
	fu+v8GDpfkTETMeyTdQWmeuRmmtKR5k=
Received: from frank-u24.. (fttx-pool-157.180.226.129.bambit.de [157.180.226.129])
	by mxbox4.masterlogin.de (Postfix) with ESMTPSA id C0A5980236;
	Sat, 10 May 2025 17:49:58 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [net-next, PATCH v2] net: phy: mediatek: do not require syscon compatible for pio property
Date: Sat, 10 May 2025 19:49:32 +0200
Message-ID: <20250510174933.154589-1-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: c1fe3543-f69b-41e4-8960-f64da6740af7

From: Frank Wunderlich <frank-w@public-files.de>

Current implementation requires syscon compatible for pio property
which is used for driving the switch leds on mt7988.

Replace syscon_regmap_lookup_by_phandle with of_parse_phandle and
device_node_to_regmap to get the regmap already assigned by pinctrl
driver.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---

v2:
- out of RFC

---
 drivers/net/phy/mediatek/mtk-ge-soc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/mediatek/mtk-ge-soc.c b/drivers/net/phy/mediatek/mtk-ge-soc.c
index 175cf5239bba..21975ef946d5 100644
--- a/drivers/net/phy/mediatek/mtk-ge-soc.c
+++ b/drivers/net/phy/mediatek/mtk-ge-soc.c
@@ -7,6 +7,7 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/phy.h>
 #include <linux/regmap.h>
+#include <linux/of.h>
 
 #include "../phylib.h"
 #include "mtk.h"
@@ -1319,6 +1320,7 @@ static int mt7988_phy_probe_shared(struct phy_device *phydev)
 {
 	struct device_node *np = dev_of_node(&phydev->mdio.bus->dev);
 	struct mtk_socphy_shared *shared = phy_package_get_priv(phydev);
+	struct device_node *pio_np;
 	struct regmap *regmap;
 	u32 reg;
 	int ret;
@@ -1336,7 +1338,13 @@ static int mt7988_phy_probe_shared(struct phy_device *phydev)
 	 * The 4 bits in TPBANK0 are kept as package shared data and are used to
 	 * set LED polarity for each of the LED0.
 	 */
-	regmap = syscon_regmap_lookup_by_phandle(np, "mediatek,pio");
+	pio_np = of_parse_phandle(np, "mediatek,pio", 0);
+	if (!pio_np)
+		return -ENODEV;
+
+	regmap = device_node_to_regmap(pio_np);
+	of_node_put(pio_np);
+
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-- 
2.43.0


