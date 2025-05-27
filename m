Return-Path: <netdev+bounces-193731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF59AC5990
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 19:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F2B79E2312
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 17:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87180288C97;
	Tue, 27 May 2025 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+xJ/HEV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7332280337;
	Tue, 27 May 2025 17:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748368597; cv=none; b=cMwwhAkJGAEg+FrVkm4IA4uIg2K7uZejOZCGZRxxLqDYgLnUySscAj9oNagVVgbcSqXTgYjhU6K9Po01g31+e3u0Pg3kR9AxpBvEEzOPUz7Wj9nWNRUA3PdhPkKDNZI8vlxPZ2BJ86POdNGA57w5tH1JxsrH/wHIOWGHfW5dR9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748368597; c=relaxed/simple;
	bh=tex/uD0w2dWBw2SvdbOmRsdYC71bPLdJZ97hYpxcaSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CJJSa5OSBHskfHgEEXPrGaQVSMjZGEtn3Ld9fjZYW+HBxkVu40FQ/sTFMamkBW5qDlw3sLUpGUwyCRi2ehDLEFNUFx5bff5QtEm7q8PjxjsQgA9po5MePCSRaosUPgJlllv5K+8y/caSmMHZi7iEoHdZMq6tXnDBV70e979YY8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+xJ/HEV; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7cadd46eb07so349094285a.3;
        Tue, 27 May 2025 10:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748368593; x=1748973393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPM8Cvieqz5nNvWINKg7DvU/92uvEyS4n24d/iV9dr0=;
        b=U+xJ/HEVwIGqEhyoeFcDuxVyBPWROTVjUkLD2vLzo6+Rax5yJVAoc7vXAOfxp+H+3V
         pFkAwWMVnrefAUc7Odw7kiYgE5HGXFH9QDopAkGJaTcbiY/y+ukNQihIrYr9P6CmLO25
         cvVKdyeJDbwd1vylvNod9ouE0I/N/Njp6PKXZ+XANRiYdgKNLao9uYZzFfVnzoXNK134
         SNikNrYCWr0+q2ipU9fdGyXp/LUNAzGxvbflOCKpKrRnrGsGMng2bDlnIlfCHr3AGg33
         x48TQh8DkC6RTZjGG9foEC+3afqEglTzHcYATPHmgXaYPehxgKjfUNwZKxMqd1TzmOEB
         PweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748368593; x=1748973393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CPM8Cvieqz5nNvWINKg7DvU/92uvEyS4n24d/iV9dr0=;
        b=bp2i1PMLHNyPGqfiKb6TQXVWSy47SdhtEbnNGe8WH7HCQ1ovzueodXktfHHOWFRn8v
         9jebxof7jz/9EXEiwG9ue7nd1TAeoMvtltdn3ebN5a7f2LzfrgnsUyPeLgITwrWjDBSQ
         jZn6QMjobLEwJgy5ASPV4jTaen1zPftGd2t6dM8V9zNFV6WW+apmU7CWvTHxF3NRLI2P
         N9M3LqlllSDZZJ3VHQVrn0sIkcNTCOdnLucrl8jCjLm9k7its/3xnMxm3S/kxtsUUjPV
         x07Uj9UvJj6xW18e/zJLulCHfPAxV7MXxC9b28fiOm0XIWDIKEAOLuh6iqqiRKrpHTYG
         ytMg==
X-Forwarded-Encrypted: i=1; AJvYcCXDhX7GUyCNGmI/HgyJs0Z2zwcwLy8BV7PcI3/HKcyCA1ZMVOZxb/2CayzKFdgkBcvEVChJxv5XzvGpmKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YziJd79fQroYHG9M46w+fuacnp0crJ4GUcAW8YKUomfv4V58D2L
	q/RfVk83f7m9JfiZLld9EP9F/h9GWUkIrqW/tVA0RI33dIqNhVndMPJLcB9IL70/1J8=
X-Gm-Gg: ASbGnct/4/WDAiDCswOQMORj430uEGkpYoLGV0DVBm28e4QMjS7lw6w+VPn5jqQr+sD
	qyAX+H3eqdR1sQg0v7sAwrvlh+UvYc0g1Aqkvrc2cRTaaulTP0BBhM+kzEOpNelVHSK2v+KaxBl
	b3qpMNW/+QxF/jawoeiE1b59xhExhEzOYJvjXAbyTGrfO06R0SHHNWdLN7swceEWobzGz+FV+/V
	PaBGXQ0kQ6rGoawJClovwC4fDi1zW4SVCjpD/BaCttuN+9KanL1eYHK6NgtjnUYjB7OUIg7n9+i
	CvyIO3N86zESFY2qbbpGXt0yVGX0vN70+otXvjx1Fxml2gV0M4VpBl5uCHK5p9XbYmNCRqkhDrT
	Ub+C9zFU52uEgyFssgmoh5Jl7VQiUDjqR71ko7Y9Z
X-Google-Smtp-Source: AGHT+IGb7ZAkz0DXl6pr3hb3Rtl1mnfnjPXpzgihCk3W+jtxghNllqAVA4MuKf6P/Nz/db42HhLmew==
X-Received: by 2002:a05:6e02:1b05:b0:3dc:7563:c3d7 with SMTP id e9e14a558f8ab-3dc9b6a1250mr157952185ab.12.1748368582436;
        Tue, 27 May 2025 10:56:22 -0700 (PDT)
Received: from james-x399.localdomain (97-118-146-220.hlrn.qwest.net. [97.118.146.220])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dc82e014f4sm38082275ab.40.2025.05.27.10.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 10:56:22 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-sunxi@lists.linux.dev,
	James Hilliard <james.hilliard1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Yinggang Gu <guyinggang@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Paul Kocialkowski <paulk@sys-base.io>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] net: stmmac: dwmac-sun8i: Allow runtime AC200/AC300 phy selection
Date: Tue, 27 May 2025 11:55:55 -0600
Message-Id: <20250527175558.2738342-2-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250527175558.2738342-1-james.hilliard1@gmail.com>
References: <20250527175558.2738342-1-james.hilliard1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Allwinner H616 ships with two different copackaged phy variants,
in order to determine the phy being used we need to read an efuse and
then select the appropriate PHY based on the AC300 bit.

By defining an emac node without a phy-handle we can override the
default PHY selection logic in stmmac by passing a specific phy_node
selected based on the ac200 and ac300 names in a phys list.

This allows us to have a device tree that defines both PHY variants
even though only one will actually end up being used at runtime
based on the ac300 nvmem efuse bit.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 6c7e8655a7eb..50d37876fabf 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -11,6 +11,7 @@
 #include <linux/mdio-mux.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/of.h>
 #include <linux/of_mdio.h>
 #include <linux/of_net.h>
@@ -280,6 +281,8 @@ static const struct emac_variant emac_variant_h6 = {
 #define SYSCON_ETCS_EXT_GMII	0x1
 #define SYSCON_ETCS_INT_GMII	0x2
 
+#define AC300_KEY		BIT(8) /* 1: AC300 PHY, 0: AC200 PHY */
+
 /* sun8i_dwmac_dma_reset() - reset the EMAC
  * Called from stmmac via stmmac_dma_ops->reset
  */
@@ -1149,6 +1152,35 @@ static struct regmap *sun8i_dwmac_get_syscon_from_dev(struct device_node *node)
 	return regmap;
 }
 
+/* H616 SoCs can contain either an AC200 PHY (needs i2c init) or an AC300
+ * PHY (no i2c). The silicon variant is flagged by the AC300_KEY efuse.
+ */
+static int sun8i_dwmac_get_ac300_phy(struct device *dev,
+				     struct plat_stmmacenet_data *plat_dat)
+{
+	u16 val;
+
+	/* If the nvmem cell is absent, use normal phy selection. */
+	if (nvmem_cell_read_u16(dev, "ac300", &val))
+		return 0;
+
+	const char *phy_name = (val & AC300_KEY) ? "ac300" : "ac200";
+	int index = of_property_match_string(dev->of_node, "phy-names",
+					     phy_name);
+	if (index < 0) {
+		dev_err(dev, "PHY name not found in device tree\n");
+		return -EINVAL;
+	}
+
+	plat_dat->phy_node = of_parse_phandle(dev->of_node, "phys", index);
+	if (!plat_dat->phy_node) {
+		dev_err(dev, "Failed to get PHY node from phys property\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int sun8i_dwmac_probe(struct platform_device *pdev)
 {
 	struct plat_stmmacenet_data *plat_dat;
@@ -1222,6 +1254,10 @@ static int sun8i_dwmac_probe(struct platform_device *pdev)
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
+	ret = sun8i_dwmac_get_ac300_phy(dev, plat_dat);
+	if (ret)
+		return ret;
+
 	/* platform data specifying hardware features and callbacks.
 	 * hardware features were copied from Allwinner drivers.
 	 */
-- 
2.34.1


