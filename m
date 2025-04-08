Return-Path: <netdev+bounces-180129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91880A7FA79
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B6CB175ACC
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DEA268696;
	Tue,  8 Apr 2025 09:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmfTiy8q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C8B26658E;
	Tue,  8 Apr 2025 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744105948; cv=none; b=DIMWzmbw1GRlWy6Xuvo8CJpbH1HKoCuV9dre+JRPw1TyZc2Hoehf8JlWnvigwaBiLjnJZGsgnOcSgrmqJ3at809F0e8N3QrcjpGiAsL/v9GMTIdo2P1BJfvbylsJ5jumg6Cjv2bZNx4AIruMfSms3iP/QMjCTMwf/WYxdQq4YoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744105948; c=relaxed/simple;
	bh=ySqujHFR96IIBQhdaLRLxccLZuHkD84IWUQvUJGbBjM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXNFgPtSBprYsYlBlGGmLQWtAc/OfdHY5BLuaC/wc6Rt881nFLun2r4oRV8eHrAPjksf9ADN4dsvDSFyB4DXk9eNO7UYJIH52icxUa6I+3dPXisbJ6KK8iTY1iaVotJV6Y2zD0LBzkEOmCtzoYoe9O5Ezfg125Z/sWUSuEeCX6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmfTiy8q; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso49554695e9.2;
        Tue, 08 Apr 2025 02:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744105945; x=1744710745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xHfS9Ayq+62ZEPKyiIIGlUUpg7PHKrYF5eIEp4kJv8I=;
        b=lmfTiy8qlrwwRH0H3egqtwvrfhT6SEJI6elO8GgPv54I/T+7+VBNyMB7N4XeQHwuW0
         iq1+f48zIZoIxnGcoKRIREz2NOaDJK669tI4h4xKjvn4vHhPl6HCRgK93FhmdJCUhJIH
         7xz9hBZvcvdAlZXLdWMME+riFBX01F2j9vScfNsOkjpycnBid54E3WLHAfo0u9/MFjZ5
         qfk3AfMaoYb1gfmn/Iy0Q5PnqZmhX+we+kUPeAQFdB/TWFegwBdHY5UowIDqbGKrtf6j
         0MDlwovCFQiFlbHNyNrnctJ6ftB5qPwBqQu7b37+Pn/K5LRUkeaUj5aAcdrdEVQOzq16
         iGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744105945; x=1744710745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHfS9Ayq+62ZEPKyiIIGlUUpg7PHKrYF5eIEp4kJv8I=;
        b=KfAs3HaCsfEkFnFs7I0WXFSomnGZQaXeKa2KsHuksb5Sn3ykY0PTNlodxgrDrhPLmo
         hfzfAYl/p+7YC1dwxWNwOqnG+PIzUaVYeg3HGAHOBpX95oD1mSJPOUz9BlxPd/jdrGuE
         IG3IPhUfGwKcTipPal621v1PZFqFmI2Z/2r+wxAIG9q+Fe4tFSuwMHlTufnY1HRDFk9P
         gi5t7NHRxc18/Qc/M3ubHEPIdJHzIOF8SixbynWnMFXwtvI1YQ8KiV7Dk27WuP0gTnTl
         V/LjmVhlK/588nM9FpIboV0EQiFMaXraGcVQTFDnwtMWoR34Z5ZmhNt9Mhf44Khq5l2R
         wY/g==
X-Forwarded-Encrypted: i=1; AJvYcCU8osxONR1UptNSEgmgP+yNNdnrsngeXBf8RFsj5gGgLsTXpVoyfX7F9/JgTWWSrmgYUzcJaDYf0r7LSXg5@vger.kernel.org, AJvYcCUMTKFh7SQMhZbeLu/tDgWyZa2DtX6wDBWcDJ29SWSoFmXBBbovYzVqs38cbGmLoxO260+6ktpk@vger.kernel.org, AJvYcCXNR1HI7jQDpB8GrFZ6WLiauH05ulEYVDkJ3JYc0NbIJikPDlTwujzPTse8cEbPydcDTmUE3caCkW0Q@vger.kernel.org
X-Gm-Message-State: AOJu0YzjLR2gE9t8nmPZyo6pn/av08Lq3+GJ1PrCHTud3PQoGIuwQns5
	fkXyMWjA3+hhfbcrB5YuZckWzOXF4Ac81DMjCGr8W54ltE0vV26Y
X-Gm-Gg: ASbGnctS6jE7weqlSJyCBxv1NpITWaTlpGxgYE7tD4zdkdJFPpMAo8Yy2/IVDfTEtI7
	4kK8yR6S/c3FqWcSgItRNFb9pUowpfayoCdeT5gt+Nar/IKvHnThyySfJaP9yObv1jlDxTjN0JO
	uhmUHYiEi17EnYw++cpYtg6/vKnGoRH3E2NDCHM+go7hjoBtxPtI8bjomrvxW0XeY585d25BTgO
	KiNQHhJsXRerI0AxYefLl3v6oBfhtzmSeyD0qi/Bg/WagDYhHwbgN54mQhOPXu4hBjZTkymDS/G
	pYyfeLqBB9iNEwgy+dLyUORc++QyvdOWZYknAmJGqlQ7ol3VW2vj3ewsarRYgPfr+KI12n/s5wt
	ZsSGBjjLWXeyGTr5mdjAHcwyf
X-Google-Smtp-Source: AGHT+IHs+RYORl9SDyQYvbJFkJWKqxzv51lL0XqnDQTULLmNslDEtLs39z+pWyUEwouddd/Lq6+k1Q==
X-Received: by 2002:a05:600c:848d:b0:43c:f969:13c0 with SMTP id 5b1f17b1804b1-43ecfa1874emr139943075e9.29.1744105945053;
        Tue, 08 Apr 2025 02:52:25 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39c3020dacfsm14493310f8f.72.2025.04.08.02.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 02:52:24 -0700 (PDT)
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
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Simon Horman <horms@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: [net-next PATCH v14 09/16] net: mdio: regmap: add OF support
Date: Tue,  8 Apr 2025 11:51:16 +0200
Message-ID: <20250408095139.51659-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250408095139.51659-1-ansuelsmth@gmail.com>
References: <20250408095139.51659-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Permit to pass a device tree node to mdio regmap config and use
the OF variant of mdiobus_register.

This is done to autoprobe PHY defined in device tree as the current
mdiobus_register only permits probing PHY using the MDIO mask value.

Previous implementation is not changed as of_mdiobus_register fallback
to mdiobus_register if the passed device tree pointer is NULL.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/mdio/mdio-regmap.c   | 2 +-
 include/linux/mdio/mdio-regmap.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-regmap.c b/drivers/net/mdio/mdio-regmap.c
index ed0443eb039f..8e89068c844d 100644
--- a/drivers/net/mdio/mdio-regmap.c
+++ b/drivers/net/mdio/mdio-regmap.c
@@ -143,7 +143,7 @@ struct mii_bus *devm_mdio_regmap_register(struct device *dev,
 	else
 		mii->phy_mask = ~0;
 
-	rc = devm_mdiobus_register(dev, mii);
+	rc = devm_of_mdiobus_register(dev, mii, config->np);
 	if (rc) {
 		dev_err(config->parent, "Cannot register MDIO bus![%s] (%d)\n", mii->id, rc);
 		return ERR_PTR(rc);
diff --git a/include/linux/mdio/mdio-regmap.h b/include/linux/mdio/mdio-regmap.h
index bb0e7dc9c0dc..228f12e90750 100644
--- a/include/linux/mdio/mdio-regmap.h
+++ b/include/linux/mdio/mdio-regmap.h
@@ -14,6 +14,7 @@ struct regmap;
 
 struct mdio_regmap_config {
 	struct device *parent;
+	struct device_node *np;
 	struct regmap *regmap;
 	char name[MII_BUS_ID_SIZE];
 	u8 valid_addr;
-- 
2.48.1


