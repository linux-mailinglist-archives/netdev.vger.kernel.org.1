Return-Path: <netdev+bounces-173338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C73F6A5862A
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 18:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D96A03AD40A
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 17:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DA420C468;
	Sun,  9 Mar 2025 17:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjL8qG5i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4CA20297C;
	Sun,  9 Mar 2025 17:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741541284; cv=none; b=HTtJsFoEHfwrefxP4BccSoJeo38oD+sfKR9P/DNwIW7NP7WSq+bNDdHc0KDZ3J9AMaQEbviXqmQ0ej7SESrBvFqVrBBfOL88rHiAoYrFaYx2Awu10fO7tS1s41BfL1xGztyMarscOtb2wzMtk7Xbi7Zd6YV2oDq6aRyl49aPeAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741541284; c=relaxed/simple;
	bh=Vl+O3cIl/Vk9GhQ49pnC5+Pv8TMbT5WKCt7npky/LjU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XbEw9+Da8l9OAC1r23OxcAlDP6RpoYzStnJfAojrepwpJMfqTVzuij8UE6ddhWOHK4/z9U4Y7Dx3ytMlYDiAxLDtIkie3DItFxdR1JXop+k5ViaX0c7snQf5Ytyoy3nhFYcSaaH55Ia4y34g8wma4dp8kbjkppBtaz+ZlBHa96c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjL8qG5i; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cf680d351so1470755e9.0;
        Sun, 09 Mar 2025 10:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741541280; x=1742146080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QM0UO5m9vnNon96+OZmUjWH0wQG7viZoaqOeY0dYk4k=;
        b=AjL8qG5isxUqxex7xwWgDdaD+h7XJWF8I1yhdacmOyHoQ3FVPn4twvIHMgtNa3IjQx
         BpBKAzjduwYuxlwxBxnV+0ThmA+3OlsQilidjEkFanR2MO/Q1hQ1xD6ayG76tXCa/zaK
         dojz5iQpVN9Q+1GBNnQi4QjEpj5B/DxkTjEtP9LSxpQ1nxIRRgKTIIBPGPFS4dsFo2W+
         k7QWDPGUeBleZM8gWUZwDv66zaKfRFm5O+ZzuWvHLz6C5VYldk3uF3L+YYDE06VJbz4p
         WnLYT2iISFmyqGwk434gjzjSZHUQQtzEyzeyZrjgfjvV8gPs3vkW1Bp51K7eXMHl9VVW
         +miQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741541280; x=1742146080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QM0UO5m9vnNon96+OZmUjWH0wQG7viZoaqOeY0dYk4k=;
        b=TO8iLzRDpKqrHxcrq+yWZmx82jjw83qAbbT6TE+2KenZr270fiB6BgjDOAJ6bafkCT
         YAONCUODsoxi/tyKdkfaefBSA0o2Zk421xZ+rr6nghtlBXzgBtf4aA8jHthavVzR3Aol
         Up6spkk155AYvzQtkYwYZ0eFhtTOLnNPTNpiAsKMiBzTQxElDaQwX1pNZEirdbZUkqrW
         bugvh3XRb9DX9K5bLtQU8tMiN3XrhGZb5eiw5XSKc8x11CWMo+h3MnEmd1ovLwRyuIiU
         FoQM7ldUJUrloEL8JSvACH3GCipc5Vi8SoXk4q6CcLioTZC4WF4lrQrl6yMdgxVwnzzX
         exVw==
X-Forwarded-Encrypted: i=1; AJvYcCUDrafG8XUCC0eT+i+sXSrLZrj7a2dAkVZr7IjcJd9aJzdnJ3w6Imz+54SH8R6qH/8i4biB/Wvp0XZ2GIch@vger.kernel.org, AJvYcCVCvp0+vJmM48EtJQZGbN/4MPoLsUHbPOwZ4ueYfWn2176JNu/OitHLujE3tB+kQG58f5Ms+3da@vger.kernel.org, AJvYcCXYYiCrWgUlEo0y0iY/mesoBI+alacJos5QaT/Ppi6vKAKYB79J/HO5X9I+L8ts0mF3/98xaKYubu6M@vger.kernel.org
X-Gm-Message-State: AOJu0YzuSS9f+le2Y9l2zlVudJc0t4vYWxLFFrbVMS9vy0dZPm36WuIY
	LBYnbul8Nf35u2DgbWtfOf/byshK0u6cPEak6lDNRVvfA1QKs5Mg
X-Gm-Gg: ASbGncvppgo6+JtkKDI/fabGDkMizlsr9sj9hDkpHAOxyJpnOIoF5t2MC3OdlTHRxu7
	/azIPYpoeE5CZCoueqTGjH5CgX4gmvU/1IU+C+Spx9gYrkhD8w2Rl0K+0vaBQKBRpKxt2b1sjbc
	B/xQfBCb3uu+UV8kqk79oBnNJoEeJiAVfA0FkBVvp/YRPsBKV24J6Y1WRZrlm4ZS/vDblSvnR5k
	PZ6z6WVnzxV/ao+xh2xDNVcODYMeZmz+X3bwmtE84rQFsJRTgA6OJSY9FEh23q6JCN0msTEvk0/
	6yV+OFxjt4eHbeKuLrpxx+ncyXWEJLE+mNsfEqQdJE5oI6JhAlOZ5rt8S8/E6hCqtYsXsuGVaFM
	xRg4SFT8LuNBJaw==
X-Google-Smtp-Source: AGHT+IFJc324nOp0xL0joexmATC9oINifYFsm58q392dt0UDBoQukBL2fNzDysktpqNgakVylLKNhw==
X-Received: by 2002:a5d:5f88:0:b0:391:32d5:157b with SMTP id ffacd0b85a97d-3913aeff340mr3650013f8f.12.1741541280518;
        Sun, 09 Mar 2025 10:28:00 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3912bfdfddcsm12564875f8f.35.2025.03.09.10.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 10:27:59 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
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
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	upstream@airoha.com
Subject: [net-next PATCH v12 07/13] net: mdio: regmap: add support for multiple valid addr
Date: Sun,  9 Mar 2025 18:26:52 +0100
Message-ID: <20250309172717.9067-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309172717.9067-1-ansuelsmth@gmail.com>
References: <20250309172717.9067-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for multiple valid addr for mdio regmap. This can be done by
defining the new valid_addr_mask value in the mdio regmap config.

In such case, the PHY address is appended to the regmap regnum right
after the first 16 bit of the PHY register used for the read/write
operation.

The passed regmap will then extract the address from the passed regnum
and execute the needed operations accordingly.

Notice that if valid_addr_mask, the unique valid_addr in config is
ignored.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/mdio/mdio-regmap.c   | 14 +++++++++++++-
 include/linux/mdio/mdio-regmap.h |  9 +++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-regmap.c b/drivers/net/mdio/mdio-regmap.c
index 810ba0a736f0..8bfcd9e415c8 100644
--- a/drivers/net/mdio/mdio-regmap.c
+++ b/drivers/net/mdio/mdio-regmap.c
@@ -20,6 +20,7 @@
 struct mdio_regmap_priv {
 	struct regmap *regmap;
 	u32 valid_addr_mask;
+	bool append_addr;
 };
 
 static int mdio_regmap_read_c22(struct mii_bus *bus, int addr, int regnum)
@@ -31,6 +32,9 @@ static int mdio_regmap_read_c22(struct mii_bus *bus, int addr, int regnum)
 	if (!(ctx->valid_addr_mask & BIT(addr)))
 		return -ENODEV;
 
+	if (ctx->append_addr)
+		regnum |= FIELD_PREP(MDIO_REGMAP_PHY_ADDR, addr);
+
 	ret = regmap_read(ctx->regmap, regnum, &val);
 	if (ret < 0)
 		return ret;
@@ -46,6 +50,9 @@ static int mdio_regmap_write_c22(struct mii_bus *bus, int addr, int regnum,
 	if (!(ctx->valid_addr_mask & BIT(addr)))
 		return -ENODEV;
 
+	if (ctx->append_addr)
+		regnum |= FIELD_PREP(MDIO_REGMAP_PHY_ADDR, addr);
+
 	return regmap_write(ctx->regmap, regnum, val);
 }
 
@@ -65,7 +72,12 @@ struct mii_bus *devm_mdio_regmap_register(struct device *dev,
 
 	mr = mii->priv;
 	mr->regmap = config->regmap;
-	mr->valid_addr_mask = BIT(config->valid_addr);
+	if (config->valid_addr_mask) {
+		mr->valid_addr_mask = config->valid_addr_mask;
+		mr->append_addr = true;
+	} else {
+		mr->valid_addr_mask = BIT(config->valid_addr);
+	}
 
 	mii->name = DRV_NAME;
 	strscpy(mii->id, config->name, MII_BUS_ID_SIZE);
diff --git a/include/linux/mdio/mdio-regmap.h b/include/linux/mdio/mdio-regmap.h
index 679d9069846b..8c7061e39ccb 100644
--- a/include/linux/mdio/mdio-regmap.h
+++ b/include/linux/mdio/mdio-regmap.h
@@ -12,11 +12,20 @@
 struct device;
 struct regmap;
 
+/* If a non empty valid_addr_mask is passed, PHY address and
+ * read/write register are encoded in the regmap register
+ * by placing the register in the first 16 bits and the PHY address
+ * right after.
+ */
+#define MDIO_REGMAP_PHY_ADDR		GENMASK(20, 16)
+#define MDIO_REGMAP_PHY_REG		GENMASK(15, 0)
+
 struct mdio_regmap_config {
 	struct device *parent;
 	struct regmap *regmap;
 	char name[MII_BUS_ID_SIZE];
 	u8 valid_addr;
+	u32 valid_addr_mask;
 	bool autoscan;
 };
 
-- 
2.48.1


