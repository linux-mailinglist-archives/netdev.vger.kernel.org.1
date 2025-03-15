Return-Path: <netdev+bounces-175065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3B9A62FB7
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 16:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FF4B1896579
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 15:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79614206F38;
	Sat, 15 Mar 2025 15:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTP881ZL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4432066C8;
	Sat, 15 Mar 2025 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742053494; cv=none; b=fxjlaAod3GVJJSJTUBkcLYxxFflc/dI6/hWDJ7QWfMMO1tgontqZFT5olipd3Q7lpJ/8LymBtPooafd2WaHwzln+yaQMXVhn7w72+bEjz5pGiKfnGyTdJKyZebLQQ/y6iDYiIcTm9gKYbq/aMQ2vnfsgt2hQjJtldrlB/lKIdbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742053494; c=relaxed/simple;
	bh=JM+0wuRT7FMakNxdB2r0VDHnMDdWzvnL7Cz4mTVE2dc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oDB9bApYqKJ2BFs3b/MPGTSw7f25zXMUIt+MWe0vq/DT2jZI/gnI9U/Vam1+1asgMGMNWmjIxhGc6JVLDT3tsjClbFRTmJXFEbhS0H9/mx0YzHwFV8BnpcAZFLYewKQuk47/ZyXzDna1IC2D98PO0VEfqdNVmGrIjK5D1KWk3HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTP881ZL; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso4586065e9.2;
        Sat, 15 Mar 2025 08:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742053491; x=1742658291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i9cj1rDP/cubKfbE6LHAYD/iOcx4KqaxRMhogz7zaTE=;
        b=cTP881ZLpGeFiQ/onKn7/fpcIp+K8n4TAZT8V1BAjFU8y7zC3cAyr6S7428TAS2nOI
         eCyXVdKzbydEF8OwIbMxeq0eT2PnHPfwbLsY25UB2CjYWQyDpv+j4we0SMv7XIP8uH6z
         Q73XTrLrc+3brEoHE/L6VOp7Gzckva2XPZPYAnHOYHC+MgQf4N9HZ7j9DY0/Fceq2P40
         bS7S6BRQuwBl0DeXaheG2WKvZ3iqfnOdQaagKGsbEORQoFEhQ/5xWU+Aj2jb4+nZa+t1
         8LO91KDHcGGy6FcVoWF/Nh+cCMthzZN+0a+rjhAeq3qDH9+SI1H4i1utyEE0GTMMl8RP
         Yrvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742053491; x=1742658291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9cj1rDP/cubKfbE6LHAYD/iOcx4KqaxRMhogz7zaTE=;
        b=ftOwZtaQ4wKKNRzaF2zX2MCUzTpXIrbOaNkLLMxS7e2dWpkIKNLt4nPQXwc9f1kjki
         SC5Z68QwFjvi6+raOFt2V2SQdDA9IwAe/5Yk8du7KXpzWaLhajydWmvWu0lDQR0lRylT
         8/6jYQAlWGwdDsa5M9kjKyAYLipUXEmHg7wPBaAX7u1vkoFSPmlBU2C2vfiTRDzx89Zw
         H0pvQQwLrM7IFWb18Rto4O4iFR7ZOY4g2iMoV42iSMelWEuIRAjirDEEcDQSjjomeEQ8
         OilU1ICp0KnKgfVqKmGgs6LUv6FBMat4m28uP5Uz6h6lAIQ8KofLy6rQOw0zb3R3u5cW
         GUog==
X-Forwarded-Encrypted: i=1; AJvYcCUtct99l5QG6VlZMVNGo9Gas3d4inRDb+DDgCgNsjL/gH80fTo3HC2TNhFCZzTmpgk3SkMKG8HH@vger.kernel.org, AJvYcCVBjMFX8JaJHFzmPhHWGcUaX3RGx3sht88qfHK7WTivBtLt/KIueJJuK7rY7hlCmeDWCxSu6lNftiPi@vger.kernel.org, AJvYcCVwkEICMNSWfvZyAUIUrTmclPcoralhhdDKLTVhacBI4DKFNm173RuPNaq5e/AoyXULeiDhTTYhUkf2Pf9P@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1dFAXOkfskBeiCZWgk24Nx3OvIBCSX8TCpR/IWCorEAbJyEmz
	qDT4hv7ZwxwC6OCH+WRtkRX0aTjzIxs+LEeuR/bOEL2HUwFsi6vc
X-Gm-Gg: ASbGnctGr2dlfkRn3q34qtjzPWyQAmUdE2AxLsCUamNqANKksekbkN81A9W9Ddw7el6
	PGv9U061b/RawOvMhfGgGxhFZWef/sonIJ6GZqF6PR2Huk6wVMNq1IJJVWQujIwtnmKfKUxla2+
	9lAF+4mlMvFExOGbA0+q68RESdBzEpjlrn4FIce4eu7ViVwJdVG596n73ihtKpr4YS2LlyN5ra/
	l7pZS6Mdv/Y5fawyIMI29nRMl28/bH6ogDO9rXokzcDzUD6VXRNbcyvSBRLeZQOZmxW2JZjd3jC
	1XK+utXofH8ndUzD9fq2CQR+exlakXALwWcS/s4FQsZHiDsPQkHUSBDosFt/4RrbMLOFWFGV+BI
	TSbfTHBwUBm6p+w==
X-Google-Smtp-Source: AGHT+IEOhKkyCgm/ebHsk4V7WwKT8R78FhVt6pOGjtm8mBgSx5vzbp0xB3tzUWDN02MyZuAGCjf4jw==
X-Received: by 2002:a05:600c:45cb:b0:43c:fcbc:9686 with SMTP id 5b1f17b1804b1-43d1ec66d39mr56598865e9.1.1742053490677;
        Sat, 15 Mar 2025 08:44:50 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d1fe0636dsm53464195e9.11.2025.03.15.08.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 08:44:50 -0700 (PDT)
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
Subject: [net-next PATCH v13 08/14] net: mdio: regmap: add support for multiple valid addr
Date: Sat, 15 Mar 2025 16:43:48 +0100
Message-ID: <20250315154407.26304-9-ansuelsmth@gmail.com>
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

Add support for multiple valid addr for mdio regmap. This can be done by
defining the new valid_addr_mask value in the mdio regmap config.

This makes use of the new implementation used by C45 to encode
additional info in the regmap address to support multiple MDIO address.

To actually use this, support_encoded_addr MUST be enabled and
(indirectly) devm_mdio_regmap_init must be used to create the regmap.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/mdio/mdio-regmap.c   | 8 +++++++-
 include/linux/mdio/mdio-regmap.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-regmap.c b/drivers/net/mdio/mdio-regmap.c
index f263e4ae2477..ed0443eb039f 100644
--- a/drivers/net/mdio/mdio-regmap.c
+++ b/drivers/net/mdio/mdio-regmap.c
@@ -113,13 +113,19 @@ struct mii_bus *devm_mdio_regmap_register(struct device *dev,
 	if (!config->parent)
 		return ERR_PTR(-EINVAL);
 
+	if (config->valid_addr_mask && !config->support_encoded_addr) {
+		dev_err(dev, "encoded address support is required to support multiple MDIO address\n");
+		return ERR_PTR(-EINVAL);
+	}
+
 	mii = devm_mdiobus_alloc_size(config->parent, sizeof(*mr));
 	if (!mii)
 		return ERR_PTR(-ENOMEM);
 
 	mr = mii->priv;
 	mr->regmap = config->regmap;
-	mr->valid_addr_mask = BIT(config->valid_addr);
+	mr->valid_addr_mask = config->valid_addr_mask ? config->valid_addr_mask :
+							BIT(config->valid_addr);
 	mr->encode_addr = config->support_encoded_addr;
 
 	mii->name = DRV_NAME;
diff --git a/include/linux/mdio/mdio-regmap.h b/include/linux/mdio/mdio-regmap.h
index 504fa2046043..bb0e7dc9c0dc 100644
--- a/include/linux/mdio/mdio-regmap.h
+++ b/include/linux/mdio/mdio-regmap.h
@@ -17,6 +17,7 @@ struct mdio_regmap_config {
 	struct regmap *regmap;
 	char name[MII_BUS_ID_SIZE];
 	u8 valid_addr;
+	u32 valid_addr_mask;
 	/* devm_mdio_regmap_init is required with this enabled */
 	bool support_encoded_addr;
 	bool autoscan;
-- 
2.48.1


