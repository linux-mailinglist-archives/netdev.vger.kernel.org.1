Return-Path: <netdev+bounces-207326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8D0B06A75
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 02:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 388C41891BE9
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 00:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55ADF14A0BC;
	Wed, 16 Jul 2025 00:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmz4VCQE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FCA145348;
	Wed, 16 Jul 2025 00:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752625779; cv=none; b=g1d9X386hvn3qVr0eUjvnzMgY/WInL/DjdwC5EIyJNpcvxHCM8j2q9fRm0xWktEcBFg+IA07I3ivZJcu7gifT5cR6NrSYh2Q3C629sqXLyk0qCu5NCB7fPTkaA0bGBlYgjo2biIz1uAMeJZT2U0viZG/L0Z6HV8jtVmsd22sqVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752625779; c=relaxed/simple;
	bh=cKeD8MJ11uQjEVwv2q6OaS91Wmxgb2CLaPxh4I+NOBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ujjyELaj9lmtAsaK1QkSDdTRT0amisXNi9Ym3trYe1S/CI2FqrjEF881PBYgT9foeTFPpfHsgUWNi7YtrXDwmGdFYOqM/c4GjbCXCKUMYGxfiH0eZRWP+l13OP1E0EQnNSoEVgWv4EYuDUpDXwJMyROx8jj3zsI6t9j1x21KzQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmz4VCQE; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-748feca4a61so3450091b3a.3;
        Tue, 15 Jul 2025 17:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752625774; x=1753230574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LE9bQHddXM1L6vafWPqB8LgPsA3C5qgIW5OXgUaknnM=;
        b=cmz4VCQEgvCqmlTdPJnXL56Q33uZJaiVa/yv+HElxGdbxOzu0rEXk3GJQkFdAQTnH1
         lMEXN/riZiS1iQm88URmfw174lmKRskZIepQ7jO0x+THXPBQx6KF/Z2xezfmTohDpe//
         qiONzF57L9e5Z5bfFGE/MNhTGN6JETdKDW79Q67+SzLdS8HS/zeKrMEJjBw1MKkTZ9l1
         b2eggFiCuvAVddiiV/WMyeM6T6OnKUP+mf8dR9A7GV71mS7EKB8wZH7013oKBRNZ7LD9
         dLKb0aNnoZ3+XIM+6eB6hmifgxrVe6jOt8FVia1MlnIEaisocNKmW6cuyyrOnnFHcT9S
         l+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752625774; x=1753230574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LE9bQHddXM1L6vafWPqB8LgPsA3C5qgIW5OXgUaknnM=;
        b=GYf25gYmQzApVc/XGLZqAM/MJwMMaiebaZsJOFPJD7NBbAX7AY1GwUVOelOxf4JZk8
         GnIDr5Fo1BSaM4Wq1fm3xUWR2n6462Ov/l0wY8ZPeLScQ9HAskyNSDSSCIoyNyLsCPbg
         R1A+uS10EMRXq/MnIEq2YR6qZGT0XLmzNWb6sJ3rZJRZG/P8e/xYgi8gtfHDSt8ME433
         OgPz/S6QMxEt8eoa/uuNh8OAxXU4Mhm6mPwy8wk3OnaD9EW2Ot9BFTbr2LErNj1RI05U
         mQ9EaMvUSxkXpADhhCe6oFwawlPmQtjwnPLe0ADl/VLureenIn5zChpDxcEX2et9+U0b
         mYqA==
X-Forwarded-Encrypted: i=1; AJvYcCUSlVCc4eLFvLXEDqAyTOG3jKR6RxW1h87Bk/HMNk/trb20ecyD+mC57plZl+vU8HQdqoDQXw5hLdhq@vger.kernel.org, AJvYcCVSnR13QRuIBNBNJqgPRcWeqxAmmUgGmvR+NC+8yJgsYCyvFjo+6cUvyXnLSfyZV1XiTHDtsHjAfkQobDEc@vger.kernel.org, AJvYcCVm7XGOUredGmfrBMPHBw4vfuo7fWUiMlAeHvE/syVf6REiODb52RD29MeZU2ORPRT05k7tTYia@vger.kernel.org
X-Gm-Message-State: AOJu0YwxtICl6fA4CvDRyHT6elchNONAhTynwX4eEWdCG2t+GmWRcB7t
	BZ6MaApbTSnx+dzsh1mtzZf9/fL+d0rsvFXz6aUkZWCkaJtkaJ2OjSZU
X-Gm-Gg: ASbGnctlyceU4SfvaYX/GAQK4TkXcLQrpJnyzCOXGJ8k/yd+ykUNS6O3Qg3+muY1BM5
	uAIbB43wxweGxq8QRcuJXzGHWv8TDPHZBYl0KrtDSyPwzxf4BnXJB4fHvlBdWDVHqhmgQr0+DbD
	unocPihypPKBSqVYkYgWk8Y4UxNPYv3GFhT4YCfwyh6aEBSfNOVWwazWBA0gBT3SU4IroCBSwUC
	ToM6Kify79yPgEIWz40GExmlC4sqMwrjCKU8GE0mXah+AeTWBigZW79qmW45qTWn2dmhlXhD2c/
	GZ04v/kVZKF+PI/1MVzK9De3pfmlv2T2T7mJA1kBOLJxwIrfQ4nyFGeqfN0r3IeoQANVL7bU90Q
	WjLUml7cPJH/MTJlZ3DTnNdE0g2ZN97X3GsonCdmV
X-Google-Smtp-Source: AGHT+IFcZVSR+ABxtLT+WpjtxVvTGXmc+FRNWy+RbbiPKXkB7yC/im8s5x4HX1WjaH18l2am++Qmqg==
X-Received: by 2002:a05:6a00:1945:b0:736:5f75:4a3b with SMTP id d2e1a72fcca58-75722869626mr740076b3a.7.1752625773820;
        Tue, 15 Jul 2025 17:29:33 -0700 (PDT)
Received: from localhost.localdomain ([207.34.150.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ebfd2d26asm11145720b3a.76.2025.07.15.17.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 17:29:33 -0700 (PDT)
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
Subject: [PATCH net-next 1/8] net: dsa: b53: Add phy_enable(), phy_disable() methods
Date: Tue, 15 Jul 2025 17:29:00 -0700
Message-ID: <20250716002922.230807-2-kylehendrydev@gmail.com>
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

Add phy enable/disable to b53 ops to be called when
enabling/disabling ports.

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 6 ++++++
 drivers/net/dsa/b53/b53_priv.h   | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 46978757c972..77acc7b8abfb 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -689,6 +689,9 @@ int b53_enable_port(struct dsa_switch *ds, int port, struct phy_device *phy)
 
 	cpu_port = dsa_to_port(ds, port)->cpu_dp->index;
 
+	if (dev->ops->phy_enable)
+		dev->ops->phy_enable(dev, port);
+
 	if (dev->ops->irq_enable)
 		ret = dev->ops->irq_enable(dev, port);
 	if (ret)
@@ -727,6 +730,9 @@ void b53_disable_port(struct dsa_switch *ds, int port)
 	reg |= PORT_CTRL_RX_DISABLE | PORT_CTRL_TX_DISABLE;
 	b53_write8(dev, B53_CTRL_PAGE, B53_PORT_CTRL(port), reg);
 
+	if (dev->ops->phy_disable)
+		dev->ops->phy_disable(dev, port);
+
 	if (dev->ops->irq_disable)
 		dev->ops->irq_disable(dev, port);
 }
diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index b1b9e8882ba4..f1124f5e50da 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -45,6 +45,8 @@ struct b53_io_ops {
 	int (*phy_write16)(struct b53_device *dev, int addr, int reg, u16 value);
 	int (*irq_enable)(struct b53_device *dev, int port);
 	void (*irq_disable)(struct b53_device *dev, int port);
+	void (*phy_enable)(struct b53_device *dev, int port);
+	void (*phy_disable)(struct b53_device *dev, int port);
 	void (*phylink_get_caps)(struct b53_device *dev, int port,
 				 struct phylink_config *config);
 	struct phylink_pcs *(*phylink_mac_select_pcs)(struct b53_device *dev,
-- 
2.43.0


