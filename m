Return-Path: <netdev+bounces-199781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB1EAE1C69
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 15:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16EAA1BC8160
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 13:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF6A295DB8;
	Fri, 20 Jun 2025 13:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFhKygTf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73125295523;
	Fri, 20 Jun 2025 13:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750426930; cv=none; b=QkdOSkOQrcF3fxhYE386FfWDamP2gvdeojdvBvuKQiH1hp49EmE2+uYhVGP5csySMP5+onT3NgmkDo2iBZ5N48cS6ETcPju+jusQXB2ymSVLvBLNPHlu7Gaj3R8YTRXxmxoV+dqT72MKuE+4lvPTjRkckKQRZLskKCP5jSYhwUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750426930; c=relaxed/simple;
	bh=O7NSU7w6z0Hcjgc0tS9pN9tgseLHRIsdORtIpN1QxPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IF8ML6fRRg9eTv3sysFcn9W+qtN16Q0Dh9GAW6P3yF1HNU2l1ipDcOwM6pYVf+9IUyeH9XW9GPlHZcx8X/0uL1rMIvyFhWMdLqE/WefFRVL+gwhtWfZ8qYF+HlaTkoqqrfdgmLNy7rjDE65TOtip5b6OznUrcGRhk5xSAH0AWrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFhKygTf; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-234d3261631so12967485ad.1;
        Fri, 20 Jun 2025 06:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750426929; x=1751031729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4PrwJRNlMfwkB4OAPUaXOmp2IqH98k7aBvjhcWB4Fo=;
        b=mFhKygTf905PD4h9PeL0W1JYPgBRlObqY+aGpnZkT7fItOzmXroUfEVeFxeFk9cKe/
         xSi9HaGc+yBfh0rvrxbO5uw6rPYOF3my64j8fTCTAyjZnK9Xw9eIHw+8y0/7+vwj1dVS
         ZvBJGUtupfGsE0RGIE4nJdlwHZ2MSwbOVfjVGvYNZSbO088lr+aWtiDnLaAidiIINbnV
         HrS16TVt1YtTn5YSfOYGpc2Z+s6IHIRWFaWPdAeDaiVKzzJpFFzM5pd1rpxlIfW8MzyY
         pILr5BwFjf2e/vgwo52Wz++kO70fAL3gum2JGvPRrKSo3dbBpls2Fn8rXrjzH8zT7sdj
         zhJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750426929; x=1751031729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4PrwJRNlMfwkB4OAPUaXOmp2IqH98k7aBvjhcWB4Fo=;
        b=VRF6WZgIFrAT/f6IeLrh9Ot10ZFzx9hWoPuG0YYICkk7Gz/J3/QVBrHgJf5EIUrBNH
         vP1UAF/vKVUKJuvvZJqq885DdS35H6cXxsEJ5wG6X8fAHHI4TzERo/QYmF+VszGotDLY
         9oTE6ms35egsqi+ov6NZ5ztfBkquIRBgKJxix1xgkdrY+XVdXaEpRIOi1SIIAQBR4AXc
         376CblQjb3VAlMHDy8UC7nqd6J5D4sHfxXPqEBU5W6pDGJTBcUMJYWJI2OzO2XkplcjG
         aBvxgoP9dpCYb2wKZ9Y1RXW19PVTe+HE31ir2hdZwNXU1sgDti5WB8k3ulfU4vD15ad5
         XAug==
X-Forwarded-Encrypted: i=1; AJvYcCUeRGKCS098UTCEsmfzY9bP5HD/l7h9OsXSHfPOrLyVYTy4L5kodhfRJ4g7zfl/hu/rSZFiNYiygmK+2pYM@vger.kernel.org, AJvYcCVmn0pi7DAQdgcS31WBjVM/wfw6iNRGrybsT2CmQ9HLFYT6w7+Iid3vDCSMBYZsiYbDHWwZjUL0@vger.kernel.org, AJvYcCWYHsJnDeXIw6hNBN0xxMqtdG5fzv+B+4RAo5PjzPMT0WAzdit7we9XPv52woBRQ5tibl2qY4/yV5eo@vger.kernel.org
X-Gm-Message-State: AOJu0YwgTo5ri3DTAbohZX13PS1Ta8gA2/Gdqo0fOlIiF/rrpElY6pdf
	hRU/AbuMrA8Q71BaMU9LlVnacF6eCctpnZ1irgFX3j9N2uda5SOqCrUc
X-Gm-Gg: ASbGncsMNJhkzpzcXmc836pewRiOSfvBtGoqxlMQ/5G8dBLQf1u7LtHWwrGaSGtYyZL
	OkHYi/3stLCGSDxR751ieZBso/IdgIcZs37yYYNQOKiiIMU3OKmgeVhETv2dKB6xmsbUYGiu5D+
	0AQnmvpv3tbQp2EAqHwXF+hEIE69hsfPEJ9l65ks92fQ0X3i83sjHpn8s/axpBPVHEfyGuzh6+/
	tJHnjYD3u/JTYrk4a/jlg4YK5DFT95JtXXr9Hk+t8JTdmEuBomM8pW/QCUHRxqTNgXQqtckR9e6
	MUgj2+Owpwp8GvP2IQEZC/A27seZyjxN7Iel7w4uiMDmLlcpr0ObdUiYXotXOEGtsz6lhQk6YZ7
	wE9gn
X-Google-Smtp-Source: AGHT+IED2Sma74TmFQCXHWQz6h6HmzHgOGQKtnSIJXQFnE9KD0MU7E4a3Gq0g7Ql/v2IZ4UAr6hlwg==
X-Received: by 2002:a17:902:e88f:b0:235:f3df:bbff with SMTP id d9443c01a7336-237d97674eemr44936455ad.4.1750426928720;
        Fri, 20 Jun 2025 06:42:08 -0700 (PDT)
Received: from localhost.localdomain ([207.34.150.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d861047fsm18885505ad.134.2025.06.20.06.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 06:42:08 -0700 (PDT)
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
Subject: [RFC PATCH net-next 4/6] net: dsa: b53: mmap: Add register layout for bcm63268
Date: Fri, 20 Jun 2025 06:41:19 -0700
Message-ID: <20250620134132.5195-5-kylehendrydev@gmail.com>
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

Add a structure to describe the ephy control register.
Add table with single entry for bcm63268. When probing,
try to match table entry with the chip_id.

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
---
 drivers/net/dsa/b53/b53_mmap.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/b53/b53_mmap.c b/drivers/net/dsa/b53/b53_mmap.c
index a0c06d703861..1bebf5b9826b 100644
--- a/drivers/net/dsa/b53/b53_mmap.c
+++ b/drivers/net/dsa/b53/b53_mmap.c
@@ -27,9 +27,31 @@
 
 #include "b53_priv.h"
 
+struct b53_phy_info {
+	u32 chip_id;
+	u32 mask;
+	u32 num_ephy;
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
+static const struct b53_phy_info bcm63xx_ephy_info[] = {
+	{
+		/* 6318 has different reg layout,
+		 * need to distinguish it somehow
+		 */
+		.chip_id = BCM63268_DEVICE_ID,
+		.mask = GENMASK(4, 0),
+		.num_ephy = ARRAY_SIZE(bcm63268_ephy_offsets),
+		.ephy_offset = bcm63268_ephy_offsets,
+	}
 };
 
 static int b53_mmap_read8(struct b53_device *dev, u8 page, u8 reg, u8 *val)
@@ -296,7 +318,7 @@ static int b53_mmap_probe(struct platform_device *pdev)
 	struct b53_platform_data *pdata = pdev->dev.platform_data;
 	struct b53_mmap_priv *priv;
 	struct b53_device *dev;
-	int ret;
+	int i, ret;
 
 	if (!pdata && np) {
 		ret = b53_mmap_probe_of(pdev, &pdata);
@@ -316,6 +338,14 @@ static int b53_mmap_probe(struct platform_device *pdev)
 	priv->regs = pdata->regs;
 
 	priv->gpio_ctrl = syscon_regmap_lookup_by_phandle(np, "brcm,gpio-ctrl");
+	if (!IS_ERR(priv->gpio_ctrl)) {
+		for (i = 0; i < ARRAY_SIZE(bcm63xx_ephy_info); i++) {
+			if (bcm63xx_ephy_info[i].chip_id == pdata->chip_id) {
+				priv->phy_info = &bcm63xx_ephy_info[i];
+				break;
+			}
+		}
+	}
 
 	dev = b53_switch_alloc(&pdev->dev, &b53_mmap_ops, priv);
 	if (!dev)
-- 
2.43.0


