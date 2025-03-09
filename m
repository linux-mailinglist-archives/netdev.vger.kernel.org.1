Return-Path: <netdev+bounces-173339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 304DBA5862F
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 18:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60E913AD44F
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 17:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D32821323D;
	Sun,  9 Mar 2025 17:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddR93WiE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A72F20D506;
	Sun,  9 Mar 2025 17:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741541289; cv=none; b=q1eOeYbJsvxDlpSalcQYVeN0TXsmlLNDldo5w+0O5qE+LvrInn10UNTwv3lfdEn7qr1M7nQGiTqzAhW3+M481KvuRo4M7jNPxtRoG/F+ygX9J88h3hmC1zyNnwxVxUKOiuui7sCbaG+VKxnAEA/g5M+9JK/ej3nI7j4t8jq0nnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741541289; c=relaxed/simple;
	bh=eT7PmgfJqa1MeWScvscGy+EY/rAOHc/fI1c6grFwoe0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q+ULpcoUZsmZCFXbS0C2zA5+k6ZfAsYC55HvJhyj+WrrPHjMmsvCdQlP+GBjANM7b9GSOYiDNn3sIncC5Yz7fExca78rVaW45eSRDsHz4tK5btCk4T/fTvwhQ/j+3DZG/PnYwb4Ni0BgqgOlv/y44rwg3YNsamflvJcBmzaEqnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddR93WiE; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso11097735e9.0;
        Sun, 09 Mar 2025 10:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741541282; x=1742146082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dOVSGlk9MbIOj4qQTH/OndQ/66dvbhCb7zwun+5/sJk=;
        b=ddR93WiEZ8m8ut2tCi7drnSs3cuPpFhkaG29CA8q5cN0FWakPsk83pPiDB8IR2H+7V
         AXPqBUdUvKSwFY+YtTvqIAsp2FBlpWNG5c0Iy5be2e+wglQ2WjInCZgvESmTu6ymc+Gn
         ubXJa6hjt7VngRc/lnOF/hEdAiCH4/gG1ql9pyKAPUZSCDwDXguk06aRmLCaZO5adKNf
         P/NLHiG7/kiK48y42ny6WQ1goWueW1l008Ue7yE5Nf9MFpbaDxIk/7ySbdJ6LtqeYNpG
         6Ze0j+wrFVKUbgYaBverTWUm419XJJ0Wv1iRh8kVWbTmLQvTIg+T9DF3bzvdqq5WUnwi
         H1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741541282; x=1742146082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dOVSGlk9MbIOj4qQTH/OndQ/66dvbhCb7zwun+5/sJk=;
        b=UcBFVBmmPaDsgfXJaA4/KRSRunKih9DyN88d2AY2nmveP3YEa3W/xuZIghHmr+mPq9
         RiHFv9tLPgi67Ii35GFWz7YBenkIbeATrsgwPVOy63wwOgrLzfUMOGWlSUJMEL2Wmvd+
         N20GhcVtCk6zDqqbPj5v291TiImLFQShjTfrQzKxN5Z3mXlBoegEXFrnXojX/9TkU111
         InMc9zZkYaG4kvq6FJYmglt6tqd14zdSXAQa/4EO2YxWr50Hs1AVK/SVhrclQqluntnG
         dCkdFIRCPdwpEihgR2vYv9tubVhmjbXhMxEa22IZZhw/VYDBK4bgoTOXmkbpQkLAIzaj
         /EDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG2T9gishgxs51oCxJHU/pe5fXJQjJlRUe7rcNy6E6iHsuZK1W0NFefhrEDvbHIsvR5wloNUW6@vger.kernel.org, AJvYcCWSqM8En2WBYIhB6NCxB0AYl6pCan03zGsx1OkRB0zlUyj+0GjFP7czgQn2VcGTeU9y/2B2DG+dL7EmpLY2@vger.kernel.org, AJvYcCXJq4N/c1zORBzZatDzx4jpxV5MJDDqILfilbOj5/XZWbZ1sBJGrhdGf3sSDWh3XWSfOp0xXMKEDa9J@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1HYrlEImRahN3QNTl328VMS37xbPk+AV4ArQeXJ4EaJMOIgeb
	qTznRux2jVN3MhttcvhcZWX/yVNMm06H4tiMKLlGOhBOfcO3aDyu
X-Gm-Gg: ASbGncthHjPqGZkr+ERZ6YKfF6cDyRMsuuB5fwCuNo28tOnJiHW9o2oYV05XjBzgNrD
	8dbB5yah7sIxnpvMoca+VO4h5Tgme1hrfrfLpkryYy3XnCLy95CwrwKMa+gmypsK/jithFTqXSi
	vRrqf4R03LUM7tqpSLIpfdYi3R3dXYV1ZjG3PuKadt3elPCjvXmVQ7FO4GEYU+tuPUnt7ZPYouO
	FR8OeLJ4sYyIAUhoRKU7dCU73R63KkGR8pD+R154ANLD0C6BYC77AbLOWmCOJwpVDYEN8tH+J0L
	E/q2cDBw2AuT1oyXl66K3Z0H+EhxFufx25rgXEetD8jKdq88ddatvkdfMA9AWa9wsVwiiv7T9Ro
	hk7SLhQ7twsz3Ydgfat9WWefH
X-Google-Smtp-Source: AGHT+IFQNqoLJM1g7t2UpEImBkVLLifEkcARk21L/1UDJINg+bdHLPSO9tjE2bg8XfIXEsBW4bqbxA==
X-Received: by 2002:a5d:6d8a:0:b0:390:eae5:5196 with SMTP id ffacd0b85a97d-39132dbb3b3mr8164112f8f.38.1741541282456;
        Sun, 09 Mar 2025 10:28:02 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3912bfdfddcsm12564875f8f.35.2025.03.09.10.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 10:28:02 -0700 (PDT)
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
Subject: [net-next PATCH v12 08/13] net: mdio: regmap: add OF support
Date: Sun,  9 Mar 2025 18:26:53 +0100
Message-ID: <20250309172717.9067-9-ansuelsmth@gmail.com>
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

Permit to pass the device node pointer to mdio regmap config and permit
mdio registration with an OF node to support DT PHY probe.

With the device node pointer NULL, the normal mdio registration is used.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/mdio/mdio-regmap.c   | 2 +-
 include/linux/mdio/mdio-regmap.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-regmap.c b/drivers/net/mdio/mdio-regmap.c
index 8bfcd9e415c8..329839ab68e6 100644
--- a/drivers/net/mdio/mdio-regmap.c
+++ b/drivers/net/mdio/mdio-regmap.c
@@ -90,7 +90,7 @@ struct mii_bus *devm_mdio_regmap_register(struct device *dev,
 	else
 		mii->phy_mask = ~0;
 
-	rc = devm_mdiobus_register(dev, mii);
+	rc = devm_of_mdiobus_register(dev, mii, config->np);
 	if (rc) {
 		dev_err(config->parent, "Cannot register MDIO bus![%s] (%d)\n", mii->id, rc);
 		return ERR_PTR(rc);
diff --git a/include/linux/mdio/mdio-regmap.h b/include/linux/mdio/mdio-regmap.h
index 8c7061e39ccb..23fc2dd9d752 100644
--- a/include/linux/mdio/mdio-regmap.h
+++ b/include/linux/mdio/mdio-regmap.h
@@ -22,6 +22,7 @@ struct regmap;
 
 struct mdio_regmap_config {
 	struct device *parent;
+	struct device_node *np;
 	struct regmap *regmap;
 	char name[MII_BUS_ID_SIZE];
 	u8 valid_addr;
-- 
2.48.1


