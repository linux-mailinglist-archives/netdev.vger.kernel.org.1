Return-Path: <netdev+bounces-175064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F8BA62F7B
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 16:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF7717AC5F
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 15:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2682066FB;
	Sat, 15 Mar 2025 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xu0eAL9h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9B8204697;
	Sat, 15 Mar 2025 15:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742053493; cv=none; b=gURsa+HHl77SFmrVrmo8UY/JPdDbcDKXIKvgA+jQoOXGYuKUTWeTKM9tvEKKyFCf6zq8y12zutftxvgucqKHujakGvzy0l4Qe6s0e8lmsl5u0gvIr76UjhMCdwANIQhT0VRlReArj98D5a285vutV43t+vLrkRngO1hv7hX/4dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742053493; c=relaxed/simple;
	bh=yggMNrGklrFWiO5PfnLZDkSdJxP7dDHeBQvYAC+NpIM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sidvqOAl8pi6MO1JKbkV443a9X5SzZ3feMo4jloaObMDh2Eid2o8QswB+Vh8RSViXpxPIv0Lu1SWYpmVXqlDvVFZMSJeVcAaRz4xOVQIaUQpBjvAgBPnvWkVEefbIVVx3kLsqFyM3jlqsAxS9xRDNy2PPlJosiuw9MSeMZjzcs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xu0eAL9h; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-394780e98easo1951482f8f.1;
        Sat, 15 Mar 2025 08:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742053489; x=1742658289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B/n2TjI2M2VtBMHZFJp0/mcf13FR0dQEfPH18lq5S60=;
        b=Xu0eAL9h+W6h9EwQ5fVbHFe5rqwPZBStMm2VQfz0QxpnpU8oBQRanTaUa5+f/JhBzX
         Hbu6+mcU/LIOpDkBVfDjy7DupnjLkdTXRoIPZJkInssi4lx1+4V2JyEk8eFCtGhwF0MZ
         zGO65PjvYeUFwL/WMKiB9Zczdnr3IfZSYED6XCNgmNjDPM3TvsTiGkUR/iB9UG3BtAXT
         YTZc9TXoo8S4XpADXB9C65DLnLhByREMIXpAlbz5RnGvYIKJor15eUpvONWNR7KrUyxi
         SskGEfJ0VIOu9eCCWwF7D/kOO6aLYRU0XR9AY4rypHXkPHiFSdksON8U+3T/AHIQqGQR
         Povw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742053489; x=1742658289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/n2TjI2M2VtBMHZFJp0/mcf13FR0dQEfPH18lq5S60=;
        b=mIkZaHBOLX38WpNTcA8IRKB3jdCqE4n80XnZXWtOYsddakRvSlD5zjza/0iRk5PSF5
         xcO1jD9FbDlm8+7CIZqVQV/h6eyUQUad72t1UzMAvtqd3yEvEXmSDKJz8HbOdWCh8Yte
         uUyNWI8CU0rt6/tWOtLnS5hJqKkPbvBBU4IjilxCTrYIOfNCB1abEIOpg4memTVSIszB
         o+8gXq/mD10l8h+LiJrc3OFZs19jDE3aOuv3YXAjsdJoq8juaWHM9CqbmIzxMahT5CY2
         4RHg355zbRxBDgSeATzNP9yLU62ihmC2Oc+2n3NSvOsBXXhrMM+eVbr3hJGJ/98veXAo
         1sEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMoT0RSt/C8xa93kgxr181r5PDM6dOjKSQOzk5bJyCkFjpogq63uYK1zKxQZAwwhcMCPl6AbyJ@vger.kernel.org, AJvYcCWEPmYnaMwJyInvI3/0R+zag3UtC1g9amFTVxWKXAhkSTu468qQTdTb7fuNAHzHpLrIkV18neJIN5487Ks8@vger.kernel.org, AJvYcCXc2Z6Sg7hLb0zuxU45LbwdwNZPGsiqQ6A6+JlaMhkbOL4dK4VUGWaFsTXIoTVqaHJIGPLan/KZu4SL@vger.kernel.org
X-Gm-Message-State: AOJu0YxuE5vP0eID6tRGHhlyuIoZ0BVhLE2kpOcEBC7l3GM3duvwmn6T
	4+I5vXLrPN2erjo1Njc9YPmOIoKLVly8bIvTWK32zom3IaQP0VsK
X-Gm-Gg: ASbGncuiHdPXKw0tJApLbxjscgaHOHMtnOqWOFrUBWm2up8/HPQBIySIb+l/ngfjrRO
	JWVJiACqxSd9NZgGbaxg+ByzRgVKxQb8NbFkfu9p6kkzXNN5lcgXEskiMEqYq5GrPLOoaaHTJs6
	oJZ+CxVyRdOWyRCMvuc0d5DHx9Jm2Jkp2FzsTBCI0GupnB0BDFFrXhRomIX+BqwEn6Z/IYQ0ZhY
	cIfd1nwMOYkeqUKImb5/OgdKcCLTRelt81GEtAGCVpj6xqpdrt89NyIXjr1vk1hIs6nPZfOilst
	3KJNaO/xMzVP9DtgdcKdq67acR6pYppHTVLAqhi53WTB76f5vDwcnQjElMd6PnwMj5pNDK06Xc/
	RLG0dZCi7o7NEsQ==
X-Google-Smtp-Source: AGHT+IFfi4s8YK/7ZOy1tENtskKAFtjhxc2HmKBHt4o16W7ijUbFjzkhItG3iYRAjb22D/PG7p8FBg==
X-Received: by 2002:a05:6000:1564:b0:38f:28a1:501e with SMTP id ffacd0b85a97d-3971d03df3dmr8216932f8f.8.1742053489365;
        Sat, 15 Mar 2025 08:44:49 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d1fe0636dsm53464195e9.11.2025.03.15.08.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 08:44:49 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: [net-next PATCH v13 07/14] net: mdio: regmap: add support for C45 read/write
Date: Sat, 15 Mar 2025 16:43:47 +0100
Message-ID: <20250315154407.26304-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250315154407.26304-1-ansuelsmth@gmail.com>
References: <20250315154407.26304-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for C45 read/write for mdio regmap. This can be done
by enabling the support_encoded_addr bool in mdio regmap config and by
using the new API devm_mdio_regmap_init to init a regmap.

To support C45, additional info needs to be appended to the regmap
address passed to regmap OPs.

The logic applied to the regmap address value:
- First the regnum value (20, 16)
- Second the devnum value (25, 21)
- A bit to signal if it's C45 (26)

devm_mdio_regmap_init MUST be used to register a regmap for this to
correctly handle internally the encode/decode of the address.

Drivers needs to define a mdio_regmap_init_config where an optional regmap
name can be defined and MUST define C22 OPs (mdio_read/write).
To support C45 operation also C45 OPs (mdio_read/write_c45).

The regmap from devm_mdio_regmap_init will internally decode the encoded
regmap address and extract the various info (addr, devnum if C45 and
regnum). It will then call the related OP and pass the extracted values to
the function.

Example for a C45 read operation:
- With an encoded address with C45 bit enabled, it will call the
  .mdio_read_c45 and addr, devnum and regnum will be passed.
  .mdio_read_c45 will then return the val and val will be stored in the
  regmap_read pointer and will return 0. If .mdio_read_c45 returns
  any error, then the regmap_read will return such error.

With support_encoded_addr enabled, also C22 will encode the address in
the regmap address and .mdio_read/write will called accordingly similar
to C45 operation.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/mdio/mdio-regmap.c   | 170 +++++++++++++++++++++++++++++--
 include/linux/mdio/mdio-regmap.h |  14 +++
 2 files changed, 176 insertions(+), 8 deletions(-)

diff --git a/drivers/net/mdio/mdio-regmap.c b/drivers/net/mdio/mdio-regmap.c
index 810ba0a736f0..f263e4ae2477 100644
--- a/drivers/net/mdio/mdio-regmap.c
+++ b/drivers/net/mdio/mdio-regmap.c
@@ -15,22 +15,72 @@
 #include <linux/regmap.h>
 #include <linux/mdio/mdio-regmap.h>
 
+#define MDIO_REGMAP_C45			BIT(26)
+#define MDIO_REGMAP_ADDR		GENMASK(25, 21)
+#define MDIO_REGMAP_DEVNUM		GENMASK(20, 16)
+#define MDIO_REGMAP_REGNUM		GENMASK(15, 0)
+
 #define DRV_NAME "mdio-regmap"
 
 struct mdio_regmap_priv {
+	void *ctx;
+
+	const struct mdio_regmap_init_config *config;
+};
+
+struct mdio_regmap_mii_priv {
 	struct regmap *regmap;
 	u32 valid_addr_mask;
+	bool encode_addr;
 };
 
-static int mdio_regmap_read_c22(struct mii_bus *bus, int addr, int regnum)
+static int mdio_regmap_mii_read_c22(struct mii_bus *bus, int addr, int regnum)
+{
+	struct mdio_regmap_mii_priv *ctx = bus->priv;
+	unsigned int val;
+	int ret;
+
+	if (!(ctx->valid_addr_mask & BIT(addr)))
+		return -ENODEV;
+
+	if (ctx->encode_addr)
+		regnum |= FIELD_PREP(MDIO_REGMAP_ADDR, addr);
+
+	ret = regmap_read(ctx->regmap, regnum, &val);
+	if (ret < 0)
+		return ret;
+
+	return val;
+}
+
+static int mdio_regmap_mii_write_c22(struct mii_bus *bus, int addr, int regnum,
+				     u16 val)
 {
-	struct mdio_regmap_priv *ctx = bus->priv;
+	struct mdio_regmap_mii_priv *ctx = bus->priv;
+
+	if (!(ctx->valid_addr_mask & BIT(addr)))
+		return -ENODEV;
+
+	if (ctx->encode_addr)
+		regnum |= FIELD_PREP(MDIO_REGMAP_ADDR, addr);
+
+	return regmap_write(ctx->regmap, regnum, val);
+}
+
+static int mdio_regmap_mii_read_c45(struct mii_bus *bus, int addr, int devnum,
+				    int regnum)
+{
+	struct mdio_regmap_mii_priv *ctx = bus->priv;
 	unsigned int val;
 	int ret;
 
 	if (!(ctx->valid_addr_mask & BIT(addr)))
 		return -ENODEV;
 
+	regnum |= MDIO_REGMAP_C45;
+	regnum |= FIELD_PREP(MDIO_REGMAP_ADDR, addr);
+	regnum |= FIELD_PREP(MDIO_REGMAP_DEVNUM, devnum);
+
 	ret = regmap_read(ctx->regmap, regnum, &val);
 	if (ret < 0)
 		return ret;
@@ -38,21 +88,25 @@ static int mdio_regmap_read_c22(struct mii_bus *bus, int addr, int regnum)
 	return val;
 }
 
-static int mdio_regmap_write_c22(struct mii_bus *bus, int addr, int regnum,
-				 u16 val)
+static int mdio_regmap_mii_write_c45(struct mii_bus *bus, int addr, int devnum,
+				     int regnum, u16 val)
 {
-	struct mdio_regmap_priv *ctx = bus->priv;
+	struct mdio_regmap_mii_priv *ctx = bus->priv;
 
 	if (!(ctx->valid_addr_mask & BIT(addr)))
 		return -ENODEV;
 
+	regnum |= MDIO_REGMAP_C45;
+	regnum |= FIELD_PREP(MDIO_REGMAP_ADDR, addr);
+	regnum |= FIELD_PREP(MDIO_REGMAP_DEVNUM, devnum);
+
 	return regmap_write(ctx->regmap, regnum, val);
 }
 
 struct mii_bus *devm_mdio_regmap_register(struct device *dev,
 					  const struct mdio_regmap_config *config)
 {
-	struct mdio_regmap_priv *mr;
+	struct mdio_regmap_mii_priv *mr;
 	struct mii_bus *mii;
 	int rc;
 
@@ -66,12 +120,17 @@ struct mii_bus *devm_mdio_regmap_register(struct device *dev,
 	mr = mii->priv;
 	mr->regmap = config->regmap;
 	mr->valid_addr_mask = BIT(config->valid_addr);
+	mr->encode_addr = config->support_encoded_addr;
 
 	mii->name = DRV_NAME;
 	strscpy(mii->id, config->name, MII_BUS_ID_SIZE);
 	mii->parent = config->parent;
-	mii->read = mdio_regmap_read_c22;
-	mii->write = mdio_regmap_write_c22;
+	mii->read = mdio_regmap_mii_read_c22;
+	mii->write = mdio_regmap_mii_write_c22;
+	if (config->support_encoded_addr) {
+		mii->read_c45 = mdio_regmap_mii_read_c45;
+		mii->write_c45 = mdio_regmap_mii_write_c45;
+	}
 
 	if (config->autoscan)
 		mii->phy_mask = ~mr->valid_addr_mask;
@@ -88,6 +147,101 @@ struct mii_bus *devm_mdio_regmap_register(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_mdio_regmap_register);
 
+static int mdio_regmap_reg_read(void *context, unsigned int reg, unsigned int *val)
+{
+	const struct mdio_regmap_init_config *config;
+	struct mdio_regmap_priv *priv = context;
+	int addr, regnum;
+	int ret;
+
+	config = priv->config;
+
+	addr = FIELD_GET(MDIO_REGMAP_ADDR, reg);
+	regnum = FIELD_GET(MDIO_REGMAP_REGNUM, reg);
+
+	if (reg & MDIO_REGMAP_C45) {
+		int devnum;
+
+		if (!config->mdio_write_c45)
+			return -EOPNOTSUPP;
+
+		devnum = FIELD_GET(MDIO_REGMAP_DEVNUM, reg);
+		ret = config->mdio_read_c45(priv->ctx, addr, devnum, regnum);
+	} else {
+		ret = config->mdio_read(priv->ctx, addr, regnum);
+	}
+
+	if (ret < 0)
+		return ret;
+
+	*val = ret;
+	return 0;
+}
+
+static int mdio_regmap_reg_write(void *context, unsigned int reg, unsigned int val)
+{
+	const struct mdio_regmap_init_config *config;
+	struct mdio_regmap_priv *priv = context;
+	int addr, regnum;
+
+	config = priv->config;
+
+	addr = FIELD_GET(MDIO_REGMAP_ADDR, reg);
+	regnum = FIELD_GET(MDIO_REGMAP_REGNUM, reg);
+
+	if (reg & MDIO_REGMAP_C45) {
+		int devnum;
+
+		if (!config->mdio_write_c45)
+			return -EOPNOTSUPP;
+
+		devnum = FIELD_GET(MDIO_REGMAP_DEVNUM, reg);
+		return config->mdio_write_c45(priv->ctx, addr, devnum, regnum, val);
+	}
+
+	return config->mdio_write(priv->ctx, addr, regnum, val);
+}
+
+static const struct regmap_config mdio_regmap_default_config = {
+	.reg_bits = 26,
+	.val_bits = 16,
+	.reg_stride = 1,
+	.max_register = MDIO_REGMAP_C45 | MDIO_REGMAP_ADDR |
+			MDIO_REGMAP_DEVNUM | MDIO_REGMAP_REGNUM,
+	.reg_read = mdio_regmap_reg_read,
+	.reg_write = mdio_regmap_reg_write,
+	/* Locking MUST be handled in mdio_write/read(_c45) */
+	.disable_locking = true,
+};
+
+struct regmap *devm_mdio_regmap_init(struct device *dev, void *priv,
+				     const struct mdio_regmap_init_config *config)
+{
+	struct mdio_regmap_priv *mdio_regmap_priv;
+	struct regmap_config regmap_config;
+
+	/* Validate config */
+	if (!config->mdio_read || !config->mdio_write) {
+		dev_err(dev, ".mdio_read and .mdio_write MUST be defined in config\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	mdio_regmap_priv = devm_kzalloc(dev, sizeof(*mdio_regmap_priv),
+					GFP_KERNEL);
+	if (!mdio_regmap_priv)
+		return ERR_PTR(-ENOMEM);
+
+	memcpy(&regmap_config, &mdio_regmap_default_config, sizeof(regmap_config));
+	regmap_config.name = config->name;
+
+	mdio_regmap_priv->ctx = priv;
+	mdio_regmap_priv->config = config;
+
+	return devm_regmap_init(dev, NULL, mdio_regmap_priv,
+				&regmap_config);
+}
+EXPORT_SYMBOL_GPL(devm_mdio_regmap_init);
+
 MODULE_DESCRIPTION("MDIO API over regmap");
 MODULE_AUTHOR("Maxime Chevallier <maxime.chevallier@bootlin.com>");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/mdio/mdio-regmap.h b/include/linux/mdio/mdio-regmap.h
index 679d9069846b..504fa2046043 100644
--- a/include/linux/mdio/mdio-regmap.h
+++ b/include/linux/mdio/mdio-regmap.h
@@ -17,10 +17,24 @@ struct mdio_regmap_config {
 	struct regmap *regmap;
 	char name[MII_BUS_ID_SIZE];
 	u8 valid_addr;
+	/* devm_mdio_regmap_init is required with this enabled */
+	bool support_encoded_addr;
 	bool autoscan;
 };
 
 struct mii_bus *devm_mdio_regmap_register(struct device *dev,
 					  const struct mdio_regmap_config *config);
 
+struct mdio_regmap_init_config {
+	const char *name;
+
+	int (*mdio_read)(void *ctx, int addr, int regnum);
+	int (*mdio_write)(void *ctx, int addr, int regnum, u16 val);
+	int (*mdio_read_c45)(void *ctx, int addr, int devnum, int regnum);
+	int (*mdio_write_c45)(void *ctx, int addr, int devnum, int regnum, u16 val);
+};
+
+struct regmap *devm_mdio_regmap_init(struct device *dev, void *priv,
+				     const struct mdio_regmap_init_config *config);
+
 #endif
-- 
2.48.1


