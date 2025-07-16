Return-Path: <netdev+bounces-207329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B31CB06A81
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 02:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8CD31893359
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 00:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644D51B87EB;
	Wed, 16 Jul 2025 00:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTiV+zPh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EA01B042E;
	Wed, 16 Jul 2025 00:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752625789; cv=none; b=r0KSWckI8J2M7wGqT1PccPf0Si/bkskDgQQPJhE7B/K6DTt+Ka09L+BPH5WP+UEv5ZxzUpMYkIrvvxB5gkMFBo9ARmxbgrAzVjWdR/ASELXLPGN90HClJfeZjhEVQ/tZ0Pg6we4oBR0DX7iH9jsQGioNvXe383Ep90ZU9JwR7Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752625789; c=relaxed/simple;
	bh=1s/rRLQpP0/Ad7YRWn62YzcT+E57zo+pJ3fqF0nUOCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGahxxAKdId9yM6nFDfOEjMIsQgplgo9TfSwoFZvqRR7N8jiLiSazMquO80blSJY6Fj6AUckO0Y8H1c9MDwscSoTxJP6plnNsP7wuFrEWwNOdIyvBI8HFU8EeFChJXT3ZAflsR0fp9021h9lc2gupYpf7eIXKMuWl0/mUBXsD9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTiV+zPh; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-74ce477af25so3814913b3a.3;
        Tue, 15 Jul 2025 17:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752625787; x=1753230587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zli/9zoXo9DwZBg0lzqpi6NVz9XLC4bnUS91cZLJcYw=;
        b=mTiV+zPhsXRcQoyrWNrxenJFNcppQp99nTT0TQpYUhuOVjTwSTeWj1/dim7i71qpDo
         P6ZlaCxi/iggqbQxlwhsuXnrS1dD0PBSo55TQh07NtzJe8OusyC8oR6l59lwr1Wrl6H9
         aBXCgM3vBUMxk9kPrSyAgDfjy5P99BHqj4Ph1kxTojwYRGj28TSohE7sAKqPChgH3ZrU
         zmqXxWtKiceBYdBxGvA/F+tOqkrcuoOSziEPGQbYpQTIk9M3n0mvxA7SEJQttaZ+gyhG
         GezFriEaDyTFIQmInywy+HFi9Su7gd3ISV7TMmvaXMjY97utdMaHwAIvT7h4nrKapGHA
         xe0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752625787; x=1753230587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zli/9zoXo9DwZBg0lzqpi6NVz9XLC4bnUS91cZLJcYw=;
        b=KJShVJLoI0Gr+y+qcdQ9nRWQSzirDXS9D+aLHZclK9Jx0ryTmi99NVBcvGBJAUepG7
         WHLVROrw/AeIa3xXuDAAxDYMZiSF13xgaxJlY+LaORaMZ5yIfu3moJnBoX+2pF65t9os
         8fE6vu8InYo4F5ylipTx6wpyaSctXnyMq9TdgYtdqhQeO4RBtqZPLZ3iV5KA5ZM3aMZ+
         WC6+MJp3V9S2heNH/IA1PhxP/SsFA9e3zLypUdgf+xXeID/fF0kO3x9qJ3mBh+lu6l9W
         eMopw03qrDqRCjZTI0LB2Lz2sfwYYbT7i+/YbVhYx87apUt0bZSFlZeEaM3/W0E3e9BT
         xxOA==
X-Forwarded-Encrypted: i=1; AJvYcCU3doZAIQKlrLguxo8+oEWRB/Jl1zEBY+eOdCyNmRTmBTeaZRpkSLvcL0O9A7MJHZ0NQ7L8wyvF@vger.kernel.org, AJvYcCVhDSTwAcRWyybQY/GFTcsplhdJ8i053+ieEGI0OfXh/7/aE23KjJ73y01f/pBtJ/EDvvLbZKYxp3iVwNj3@vger.kernel.org, AJvYcCW1weoOo3FlOduaDKyeD3vBzAQPINBJHZLU4BYi/7Zm8uhy8hzsMHoRWV7CmEKHHi49QdA763Kh293V@vger.kernel.org
X-Gm-Message-State: AOJu0YxgabdLwefM++s5tuQdnagQdPMiGyG09K6nC8p+RGsyiuyGkP41
	FF/SFY+gnODEPZ3LB8gRwmzlMXRPA9ZEDGhtw3/HyYQVZqdTtvgPeX1K
X-Gm-Gg: ASbGncvIIPCAmj6iBtqaCP5W3HfmpA5T9HqPnHGeNkog7zNvHJJoyxHtUqcWp0u5/Yh
	POCXgwWLQwor26P9gfnlKuD8etYQTDoz0m8IsP9atntWEVH4LlRBgoBsac0N229Luq6m+mP5mFj
	VPgYTmQI44JPD8cTWt71bUDvwSEYlf/i1z0Gza7+sLot3mixL8rw5NLafy8AZ2NjIFn75oeUBEe
	KD/JhTbBwQYXZXdtyBMVUDn+M6reA6ASW+Z7sXDV4w2bn+e++0C+7RIiz93ZQUEnNNcQANtWOsU
	77/XmvQeuFvmk5bhCNIyrwU0+ATOjmKDGFwYID5y+b0h8cmQ3cPRtZQO5UsFwmLm0YwvYRlX9CR
	Pis5DGyXlZnV2Sfffx2vVsTMT9Yy6ofUHoEdlNwdg
X-Google-Smtp-Source: AGHT+IHMx3Sonw4T9ukMyi/fvH1auBUfh+cF+ZPQeQBL7+coHf8Zy1wGoo/Qe/S1ZpWqqJ6jP0+fcQ==
X-Received: by 2002:a05:6a20:12c2:b0:220:9e54:d5cc with SMTP id adf61e73a8af0-2381295e6d3mr1096335637.31.1752625787142;
        Tue, 15 Jul 2025 17:29:47 -0700 (PDT)
Received: from localhost.localdomain ([207.34.150.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ebfd2d26asm11145720b3a.76.2025.07.15.17.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 17:29:46 -0700 (PDT)
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
Subject: [PATCH net-next 5/8] net: dsa: b53: mmap: Add register layout for bcm63268
Date: Tue, 15 Jul 2025 17:29:04 -0700
Message-ID: <20250716002922.230807-6-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250716002922.230807-1-kylehendrydev@gmail.com>
References: <20250716002922.230807-1-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a structure to describe the ephy control register
and add register info for bcm63268.

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
---
 drivers/net/dsa/b53/b53_mmap.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_mmap.c b/drivers/net/dsa/b53/b53_mmap.c
index 09631792049c..35bf39ab2771 100644
--- a/drivers/net/dsa/b53/b53_mmap.c
+++ b/drivers/net/dsa/b53/b53_mmap.c
@@ -27,9 +27,26 @@
 
 #include "b53_priv.h"
 
+struct b53_phy_info {
+	u32 ephy_enable_mask;
+	u32 ephy_port_mask;
+	u32 ephy_bias_bit;
+	const u32 *ephy_offset;
+};
+
 struct b53_mmap_priv {
 	void __iomem *regs;
 	struct regmap *gpio_ctrl;
+	const struct b53_phy_info *phy_info;
+};
+
+static const u32 bcm63268_ephy_offsets[] = {4, 9, 14};
+
+static const struct b53_phy_info bcm63268_ephy_info = {
+	.ephy_enable_mask = GENMASK(4, 0),
+	.ephy_port_mask = GENMASK((ARRAY_SIZE(bcm63268_ephy_offsets) - 1), 0),
+	.ephy_bias_bit = 24,
+	.ephy_offset = bcm63268_ephy_offsets,
 };
 
 static int b53_mmap_read8(struct b53_device *dev, u8 page, u8 reg, u8 *val)
@@ -316,6 +333,10 @@ static int b53_mmap_probe(struct platform_device *pdev)
 	priv->regs = pdata->regs;
 
 	priv->gpio_ctrl = syscon_regmap_lookup_by_phandle(np, "brcm,gpio-ctrl");
+	if (!IS_ERR(priv->gpio_ctrl)) {
+		if (pdata->chip_id == BCM63268_DEVICE_ID)
+			priv->phy_info = &bcm63268_ephy_info;
+	}
 
 	dev = b53_switch_alloc(&pdev->dev, &b53_mmap_ops, priv);
 	if (!dev)
-- 
2.43.0


