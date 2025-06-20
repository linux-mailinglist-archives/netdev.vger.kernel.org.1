Return-Path: <netdev+bounces-199783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B311CAE1C74
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 15:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A34B46A0A23
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 13:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB1729A326;
	Fri, 20 Jun 2025 13:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWhbQ3ZV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ACF299AA4;
	Fri, 20 Jun 2025 13:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750426937; cv=none; b=tRXCN0IFMApnyBweXDbUbja2fpJ4Ef6nShadT6xpYiHX+Wuk0WUm8AtQSc5qLiTQeAHjV4Xi9rRgaE7U934r7Q4uVe4VszORYPkSrkrQnMW10oVuTqpkw+oHHc2H+SfkE57VE2Dz9sWS8AfKAwho0MWogJg0dYdaU9hCiPiRL5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750426937; c=relaxed/simple;
	bh=frII0sqlDiSbWDSlPxgeD6vfP+S0Yy8Kxk0CZ2aQw6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TvnDARjaI6WUzxHxJQcXiIV1P/1HLO8bh6KaBk+r0gyCNI3nBwUGA9wFzl4astEzGHXM7/GnzczvpJRHWpOrq6XKBhivTCa+TFyXI/HMKaYfMg6Ihfco9bAQgXADHWDXb5wDaOdEhFgFqr1TOSXlVE1aVtNibi4DXkj098A345g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWhbQ3ZV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2366e5e4dbaso15180215ad.1;
        Fri, 20 Jun 2025 06:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750426935; x=1751031735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNBwt43MHIWMmmpsxqwqFsalJ3qguFb5ELzUaUDEscI=;
        b=mWhbQ3ZVVl+XHyg6FVw0TnYpT393xVic+wDp0QyC/0MgEA8qLRb/vh3+F5NDahQgRw
         oxDPTAGLhqXG54pIBjR7C7JKZHAM+PPwrXAtFnMlX+G9T/0syzvwPoRdu8E1TVF9FTt2
         DPAITh66IOOiZFkmiLYsECHF9S+qLmsdGmKqkHuUZIolcwZEWcoHIOBPMedPjMjY441f
         d0CZsw0I7u2hmqMEeR/sD6PCpgJGO4WyPQ2Z5f24wXR8CAhDA5AH1FMNwtfd282Ibgrx
         dKMxzz7g6uu+JqIi3wC8gpJBpcrNzYGcxsB94Oxb94Q8CSJ70GLrofCI2q542iBR8yfb
         B/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750426935; x=1751031735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNBwt43MHIWMmmpsxqwqFsalJ3qguFb5ELzUaUDEscI=;
        b=VfensFfG0sqVGm72Lfl8cZTFM/v3aLhslcO1OsPqQ7f4aQ3RIh9Mdki8oaLpS9iuBR
         NHv1NlgaAThVxk55qyyEPJpCpiBMOvqU2Gc8j81bSGVALj66iXj49NXQVNb8HGdnZw9B
         v++/hxYAyDY2Z7Nkeh9il7T00jIiF48G1bfI1CGiHFSvrkqtd/ebprnceQkrB2YZMx//
         dGy58/s9G5pSFaIPvAWqdPvUjVxYwc2yoH4eO/pDxoVvcqHhCbbtnAWhAncAk0qBL0qn
         NfUxdeNXbEBkuoFcSFJgrNnm3EvEAW08WJrcDh51bUTn6ARovKH8BUvFp4WEueNPp0Qn
         X1vg==
X-Forwarded-Encrypted: i=1; AJvYcCVWELuJrelnblK9mlDW24Zcz0kCUKapSvoT9GeLQGchK44aEUZ/irrbo3yg6inPYcGlVDvEX3HGTeynQfzM@vger.kernel.org, AJvYcCWYcimRkUFryAClIkaKfk9I2+D1tFHnXdDBTRM4Ny+h/UBxteUN1IPSbIsoLfTW2cOOqOGvtXGK@vger.kernel.org, AJvYcCXKmhF1lAgyWHBmMMKKmcLqjSXejV9ZctnCpTnYroqD3eaXQOFJ/UMY1nzB2fz36U4/1SiQkoFkFa1R@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfdynu0H7bRqp8vBaLgc8OVnqJs9PP3ZpEnNEgJgO8Bjj6hIL4
	4vji+Fi/nUtEck0edHzZbda+rXFAPBY+/HaAzvwFb1HgKQpYB9+GkYlv
X-Gm-Gg: ASbGncstoCXBNSwQUQD+V8QwFWTcfcarZCnsp1rYqxLXJAOVe0hFdHvk3z455Tr/p+q
	NGodGH6eXb38KJKkBt+BFDDZasz0ov+Dh0Lhgp+dXaD05im7AXPzEdnokwo9+PjAf7MopVp6poH
	+cPBmSMViAtb6WXxFsSo6uWP0K1Kdwyo0drBJdmFTaE3oxN53p0WIcw5HFMv6J/1Aq9JmtCRqSA
	g6Slg4nlwfZZ5ZwlQfWLKM8sU4LkL1Zod0pOjkkhcZO8jAh45LYiXNQigfJPyc0y3fFlI35MVVo
	VvaboNYkcK+Pb0OyoDa4VDHMY4rj2jgvzGXlZfaaDqdDe26+WfRAjvM2Za5rgavARU+Ayd4Gc8e
	GQRzg
X-Google-Smtp-Source: AGHT+IG7wam8fQo1fx9LX6RAyzqtMQVwrj4OaPZzWacH85+bQVS4c210WpX0nCi0F8AReA91nXk5kw==
X-Received: by 2002:a17:903:1665:b0:231:d0da:5e1f with SMTP id d9443c01a7336-237db0d8ea3mr39974165ad.21.1750426935169;
        Fri, 20 Jun 2025 06:42:15 -0700 (PDT)
Received: from localhost.localdomain ([207.34.150.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d861047fsm18885505ad.134.2025.06.20.06.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 06:42:14 -0700 (PDT)
From: Kyle Hendry <kylehendrydev@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>
Cc: noltari@gmail.com,
	jonas.gorski@gmail.com,
	Kyle Hendry <kylehendrydev@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 6/6] net: dsa: b53: mmap: Implement bcm63xx ephy power control
Date: Fri, 20 Jun 2025 06:41:21 -0700
Message-ID: <20250620134132.5195-7-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250620134132.5195-1-kylehendrydev@gmail.com>
References: <20250620134132.5195-1-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the phy enable/disable calls for b53 mmap, and
set the power down registers in the ephy control register
appropriately.

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
---
 drivers/net/dsa/b53/b53_mmap.c | 50 ++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_mmap.c b/drivers/net/dsa/b53/b53_mmap.c
index a4a2f2965bcc..cf34a7d1048f 100644
--- a/drivers/net/dsa/b53/b53_mmap.c
+++ b/drivers/net/dsa/b53/b53_mmap.c
@@ -29,6 +29,7 @@
 #include "b53_priv.h"
 
 #define BCM63XX_EPHY_REG 0x3C
+#define BCM63XX_EPHY_POWER_DOWN_BIAS BIT(24)
 
 struct b53_phy_info {
 	u32 chip_id;
@@ -264,6 +265,53 @@ static void bcm63xx_ephy_reset(struct regmap *regmap, int num_ephy)
 	regmap_update_bits(regmap, BCM63XX_EPHY_REG, mask, mask);
 }
 
+static void bcm63xx_ephy_set(struct b53_device *dev, int port, bool enable)
+{
+	struct b53_mmap_priv *priv = dev->priv;
+	const struct b53_phy_info *info = priv->phy_info;
+	u32 val, mask;
+	int i;
+
+	if (enable) {
+		val = 0;
+		mask = (info->mask << info->ephy_offset[port])
+				| BCM63XX_EPHY_POWER_DOWN_BIAS;
+		regmap_update_bits(priv->gpio_ctrl, BCM63XX_EPHY_REG, mask, val);
+	} else {
+		if (!regmap_read(priv->gpio_ctrl, BCM63XX_EPHY_REG, &val)) {
+			val |= info->mask << info->ephy_offset[port];
+			/*Check if all phys are full off and set bias bit*/
+			for (i = 0; i < info->num_ephy; i++) {
+				mask = info->mask << info->ephy_offset[i];
+				if ((val & mask) != mask)
+					break;
+			}
+
+			if (i == info->num_ephy)
+				val |= BCM63XX_EPHY_POWER_DOWN_BIAS;
+
+			/*Might need a lock around the read/write*/
+			regmap_write(priv->gpio_ctrl, BCM63XX_EPHY_REG, val);
+		}
+	}
+}
+
+static void b53_mmap_phy_enable(struct b53_device *dev, int port)
+{
+	struct b53_mmap_priv *priv = dev->priv;
+
+	if (priv->phy_info && port < priv->phy_info->num_ephy)
+		bcm63xx_ephy_set(dev, port, true);
+}
+
+static void b53_mmap_phy_disable(struct b53_device *dev, int port)
+{
+	struct b53_mmap_priv *priv = dev->priv;
+
+	if (priv->phy_info && port < priv->phy_info->num_ephy)
+		bcm63xx_ephy_set(dev, port, false);
+}
+
 static const struct b53_io_ops b53_mmap_ops = {
 	.read8 = b53_mmap_read8,
 	.read16 = b53_mmap_read16,
@@ -277,6 +325,8 @@ static const struct b53_io_ops b53_mmap_ops = {
 	.write64 = b53_mmap_write64,
 	.phy_read16 = b53_mmap_phy_read16,
 	.phy_write16 = b53_mmap_phy_write16,
+	.phy_enable = b53_mmap_phy_enable,
+	.phy_disable = b53_mmap_phy_disable,
 };
 
 static int b53_mmap_probe_of(struct platform_device *pdev,
-- 
2.43.0


