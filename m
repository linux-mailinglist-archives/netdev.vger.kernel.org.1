Return-Path: <netdev+bounces-180128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F99A7FA8A
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4A4C19E1AEC
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA64267F63;
	Tue,  8 Apr 2025 09:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RS7Aovxw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EABD267B7B;
	Tue,  8 Apr 2025 09:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744105947; cv=none; b=fcqIL+3TmfQgmRAYrZsYLAEhck6m9Z2W73FApwGXOOpmGnVG/SsBY3t05Wp+BH3LqCTXnwfrrv8hLIFveq6V6YcGr3bIfDSq3Way8t0vSQwQQwx+HzIFiAmVPAuiRYoxnA4Ox9xm9E0tOWcKnGrbRfwZPbdl9P/YCAD1hkgAa40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744105947; c=relaxed/simple;
	bh=JM+0wuRT7FMakNxdB2r0VDHnMDdWzvnL7Cz4mTVE2dc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=abUUm+V9zAGePxgfiDAbRmG1As1Zp+XNoCbab/jx3G6CBJDf9moZamMtO8uEGY/ANbigHho48GXPxQ83Oeyyq01ASrzS0O5AGdWEqvHRwRB4cyfICQ7AkmnDLNxoVPdfNtlUh/Hw7UmNnz4yRssyrStc8b4qirW4NgFrRx4ZH2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RS7Aovxw; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso52713535e9.1;
        Tue, 08 Apr 2025 02:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744105943; x=1744710743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i9cj1rDP/cubKfbE6LHAYD/iOcx4KqaxRMhogz7zaTE=;
        b=RS7AovxwevAVEFrIOR5B/kLl7OPk9wPkeko/4YKyFX3TXIj31pQU/W2FTSzNylpd6G
         zpx4fMmvLdCVHV5A5axkanr61PbiQVkRXpZrPQsCvWds7Lgt85DjLXZsy+4xJGHsuMMM
         lsRqRo0qA9+vvUkSpJMmf1jcHbxSN3Rf8kngATs66A5pOWiIkPnlE5BNjebLxJrAI9A5
         8M6NjN3WUBp8t5ZPQ9mkDJ3JRRvjs0qKj/pSYfIdfG+fl2QkLkJK+aeXkjFi6GwDvc93
         cQC+SnvsI+xcShRTq9gLnPccZ0gx+BsPzopuKpsz+pW58LVH1clAlPC+pEMTWQS+acBu
         8XKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744105943; x=1744710743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9cj1rDP/cubKfbE6LHAYD/iOcx4KqaxRMhogz7zaTE=;
        b=O4jR/V01IY+2QWV2WJsqZcqDar45fSfGaHZh2s8uxB+dZ6nCmh9VIQduOYvkwo90Ar
         M2v6N67W1RiJ5ZcEYD7OId9uNEmcIjkVPzp8rPiS+w9Aw9aYIEQPONOSYWkqkxPTYS87
         Xg/6BMBfSiTWod9elm0gWTyxPNRyU2X2OsZxDRt9dH8jFyMKhTtycftVLGBLLEyWHFRH
         OVO5HM2P97KU6OzlNVaqqOvgE+3a6kl3v+/30fVk1FVX8am+tq1k52V4Gjs8vsKu3LNX
         ZKqkU/FiK4M0Q/GwRheqqdf5kugHOfXaVCHPadB8NLWFteAXjuxZHPkes6R2dzSq/9Ow
         qbTA==
X-Forwarded-Encrypted: i=1; AJvYcCV8LW9iyeP0rx5Ee8iTluOV3us58+mNFOwyHpx6vrb1FPg8Z+PBGRFNmL3dhcaPuD4buc4zCr0LyQef@vger.kernel.org, AJvYcCWcDW2jmyjvgU5n2ec2fNC+nEbxrDPrmW3yly3d4Yjs5zFpZWWbmKI2oI9YSXNLFfTu9FXnugiiVNPEcQ1W@vger.kernel.org, AJvYcCXvqCVPd+++MR9cF2IR6czXQaOztpwAbNHSUGC4dmq9YbRjnyq+SjnvhD8MDPS4P17O+pPbfJ3P@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4RruKC8uPr8imqbVSRMMkaT8M2XX3bGawDwvKVSf8BLpItaWa
	HLk4XU7KeFKnIn99sgO2DNBTtCm00LmhmRxBpfrNPsCULOHEwU6g
X-Gm-Gg: ASbGncu7Au+UCJIqFba8tlk56/oDJ+zyW6RZ/ba5kV4zdQs/MSLDFtY6Hthwm4eQMQc
	M+Sbpeg41JCOSch+wBWFW4iBf1ql7OR/8EtaMsR0aBCfShYeJrSeT12Hk48GI71XRCgjBtP7I6B
	+YP2f3TYax60Kf18pWABpxt8LgTkJ2vE6w+td2sOCo8YNUeMwehudrfBnSzKHzqo480tSF9eROZ
	wRSDGTH5K7bfooVzYPBdMDZJ6hJ7UJQX1Z+pr4Ep+tnIDbNEgHhBMKqlBpMvZ5vzoRkep1i/rPa
	ZlLlkuFlH66kNZEOcg2zuAG0nKCxWQrgaFL+CgbxmnHkm2LA1nnea7xSCDdCqNakN300ZjnRiub
	ibjKiNAExB7wjCWLZWw+zFUtM
X-Google-Smtp-Source: AGHT+IEY/oDiPIa/nOlTAjnwslt218cYgrDecYU+5L1GpQyJtEecEknywGQ7urVCh3StZq6R+wNITA==
X-Received: by 2002:a05:600c:3d98:b0:43c:f81d:f with SMTP id 5b1f17b1804b1-43ed0bf62eemr150638415e9.8.1744105943506;
        Tue, 08 Apr 2025 02:52:23 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39c3020dacfsm14493310f8f.72.2025.04.08.02.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 02:52:23 -0700 (PDT)
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
Subject: [net-next PATCH v14 08/16] net: mdio: regmap: add support for multiple valid addr
Date: Tue,  8 Apr 2025 11:51:15 +0200
Message-ID: <20250408095139.51659-9-ansuelsmth@gmail.com>
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


