Return-Path: <netdev+bounces-180126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 576ACA7FA73
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C54C7ABF49
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A6F267B1A;
	Tue,  8 Apr 2025 09:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hj0y2fkP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA2226771F;
	Tue,  8 Apr 2025 09:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744105944; cv=none; b=cr0OUyg0h6qgQoFTb23kOwmDbZlNF42RvUPdZkA0NiSVOKotBtSVNdIHiR51/W0cgvQqCpnptjbPMFdDHEorLGwWN0B+WByduINGE/GUuMOE0iFH4EmIrk+d5gVzhd0LoUT2Xa4SzhSgrISOgfWTq6Sc5FJp7+eOyhE1c/Hasb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744105944; c=relaxed/simple;
	bh=e/J9AFAnHogYRe/iJlrSPwXbA3k0hVtFkeaCTXItC3g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcOPff2GCzAqm2nR4EzMNGy2ymPogFa9rj8Ky40jqax/fRR+IMTyNt/kL3TwyQ+yayWO5v9uoSVjTrTXKEH/fzWZpBj2UZT/oKPffXVbnVlBhSMePNRz9hJy5NGrhXgAnQzxntbg/Os9O7fy2Tn99QrGbic6sQdlGTAQPIFg624=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hj0y2fkP; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3912fdddf8fso4080878f8f.1;
        Tue, 08 Apr 2025 02:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744105940; x=1744710740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NEeHqPbidnUgfl04t+LLdBVbgy41Di7XU1dGgXeGDSo=;
        b=Hj0y2fkPX9DrHgcGdog7LMFfy1tc/4+21xFnMx47CgWAkZUFgehGLpCPl6ZM8tBx1r
         580qislwTdEpSI/Us/qi1RS+XnN6yDk7fWVFroqXjXTkSRLmex23SFU/1DPMHmnouYAC
         bXLv0lkGnugLQ0bDxrfIQKDj2MlzIh/RDtrENni6jyeFTsdme1I62CKr3fZtSxW6iB07
         cDwZwbCJDw9Ak2xI63eZQki77ZKDY3LQTh6A6Q4u+E2OB8ab1iLgyKfDFDQT1sBpPoU9
         xV40MKnSqIYT4Soc0tKTk0Fcnl+iuxTFB3qePZFxz4vayHeIJFeT/zMvTjSdRX3PDm0s
         6hhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744105940; x=1744710740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NEeHqPbidnUgfl04t+LLdBVbgy41Di7XU1dGgXeGDSo=;
        b=oLNUih7bmVToa5oSHPuFNGDUlH9//5yXQUdN03cNRjjCxvEQO9X5ml82LXeJlW4whG
         qg9oYt0IcFg2zxFgW0CXtX4ELw1rNqdCPjuQNPYgk4komg7UmAfeMhUqaqN4Bb5wh+2Z
         VgTSm94qOKKkLMtOI6uTUjuJ8BOVWToADwjshyV0ZPFooqoi6mc638nhDpPVEP1mcAyQ
         Fz72cRvxAJHo8JuBq+9zJJYRuI5VwR602oMatgpkgovHpscr7kXIK77rlvYLPkQFZrbq
         kwmW2nB5ZSRa0VlY5swTrfbY/Hmx2TLF9fsbqgTU/R5aKn/Lshnt+A0XvyaVPWM2/H1Q
         bgUA==
X-Forwarded-Encrypted: i=1; AJvYcCUYcbWRZ9TseRIJEGHWgiaowVO5n+XTM4dO9Qa8Hp4DgXzIhcqyB90ky1FDSbKq8NvnqzYQhshKWiyP@vger.kernel.org, AJvYcCVuxh6KZVkOdUqX9hT6aMocrP2My4BpMheVf4waVVtu0ac/ZWuG3sJ7XAItnam+NZKR9fD+jzbS@vger.kernel.org, AJvYcCWOYYi38NqPTtHPvFkqSAZBIaz03oqhnpaf3RHmwJDxAhmcf0jH9+DahxbarP0EZnukXFmsmf5mGjCP3zNJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+g8ECBSatScktHxIEAAmGiOfEzfXsm+tN7CeSlTt2pQpfJ0oR
	Fd/Tot7QbQyFP7fW6t7XxJ2kGMEGTN83dsFootVtz8j6dEofdiS1
X-Gm-Gg: ASbGncv+5z4epFCmCFrAGNpBQfot7LxYxNqYx5RwK1pf/ag8MPQLrIGv6Eouf6Vy6+5
	yZZnZAM3nncE88dEWBAQxsVFUaYEkJuGqFxoGp+igDahRgmVaQkHTMzhZqjzE+/nesgsnosE3TO
	G+zriJPPAI9ZWyixxF8yWl+WYHalIHn4BvJrxS4O/D26tIy2KyiiP7mnpnZCYkZic6fHERTR1Tr
	cgITJuwR33I8YuPQ6fxf4MZZ532/cEug2BejosSN7SXn0ZnwkAZGthNXXf2FR2CfO36UHMYV6F2
	NhW9BieNOEW8l15cuDoyegZ2+TWwJVIV/HJsHn5dPG6N2FapEOTddetw56FIlBJQYZIFZEXoThm
	BgYG2fHf3kbxenw==
X-Google-Smtp-Source: AGHT+IGrqwVCjgn7rIaO84RS/dOygNudZl4m5bHzjJ/0QnrWbjeDDkJm2owzPEvR2qtLmTK4q+Z6+g==
X-Received: by 2002:a05:6000:2ab:b0:38d:df15:2770 with SMTP id ffacd0b85a97d-39d81f60b1dmr2398842f8f.0.1744105940434;
        Tue, 08 Apr 2025 02:52:20 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39c3020dacfsm14493310f8f.72.2025.04.08.02.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 02:52:20 -0700 (PDT)
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
Subject: [net-next PATCH v14 06/16] net: mdio: regmap: prepare support for multiple valid addr
Date: Tue,  8 Apr 2025 11:51:13 +0200
Message-ID: <20250408095139.51659-7-ansuelsmth@gmail.com>
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

Rework the valid_addr and convert it to a mask in preparation for mdio
regmap to support multiple valid addr in the case the regmap can support
it.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/mdio/mdio-regmap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/mdio/mdio-regmap.c b/drivers/net/mdio/mdio-regmap.c
index 8a742a8d6387..810ba0a736f0 100644
--- a/drivers/net/mdio/mdio-regmap.c
+++ b/drivers/net/mdio/mdio-regmap.c
@@ -19,7 +19,7 @@
 
 struct mdio_regmap_priv {
 	struct regmap *regmap;
-	u8 valid_addr;
+	u32 valid_addr_mask;
 };
 
 static int mdio_regmap_read_c22(struct mii_bus *bus, int addr, int regnum)
@@ -28,7 +28,7 @@ static int mdio_regmap_read_c22(struct mii_bus *bus, int addr, int regnum)
 	unsigned int val;
 	int ret;
 
-	if (ctx->valid_addr != addr)
+	if (!(ctx->valid_addr_mask & BIT(addr)))
 		return -ENODEV;
 
 	ret = regmap_read(ctx->regmap, regnum, &val);
@@ -43,7 +43,7 @@ static int mdio_regmap_write_c22(struct mii_bus *bus, int addr, int regnum,
 {
 	struct mdio_regmap_priv *ctx = bus->priv;
 
-	if (ctx->valid_addr != addr)
+	if (!(ctx->valid_addr_mask & BIT(addr)))
 		return -ENODEV;
 
 	return regmap_write(ctx->regmap, regnum, val);
@@ -65,7 +65,7 @@ struct mii_bus *devm_mdio_regmap_register(struct device *dev,
 
 	mr = mii->priv;
 	mr->regmap = config->regmap;
-	mr->valid_addr = config->valid_addr;
+	mr->valid_addr_mask = BIT(config->valid_addr);
 
 	mii->name = DRV_NAME;
 	strscpy(mii->id, config->name, MII_BUS_ID_SIZE);
@@ -74,7 +74,7 @@ struct mii_bus *devm_mdio_regmap_register(struct device *dev,
 	mii->write = mdio_regmap_write_c22;
 
 	if (config->autoscan)
-		mii->phy_mask = ~BIT(config->valid_addr);
+		mii->phy_mask = ~mr->valid_addr_mask;
 	else
 		mii->phy_mask = ~0;
 
-- 
2.48.1


