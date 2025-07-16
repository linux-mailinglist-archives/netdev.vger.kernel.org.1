Return-Path: <netdev+bounces-207325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CA5B06A70
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 02:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFBB85677F8
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 00:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4C31411EB;
	Wed, 16 Jul 2025 00:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRzkX1eI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967911448D5;
	Wed, 16 Jul 2025 00:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752625779; cv=none; b=WlvKY1izqqu7JKwyjF6NrwtMj/0eF6n7vTf4KAn3aYhs3Z23e9CapXX9sfHAOHH9qCq217Q0pjibn4iwMCmEVSxy1tgFrtUXYqQD1rk9hNj3VlD86MyhALBCS4eAWrmqFPeSrFemV35bY71Q+fhQ0/VCudagsl0qPYpN9d/NiO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752625779; c=relaxed/simple;
	bh=2Z+6ava4xwu7u6Yc1S3o+CtXLhSW5qVEEE9nA1nMS5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mMexfKP8ekS709xoj11UB3NBemfrooYBhkkP3NsygChIx/hr8Z/0i2/nhbm+zpyf03GOtbD7/kJyaPzRsZ3B/J8EydahIQS8KEzpIjTDmVSnrbBcSHeMgSTEf51I1Ua6XXksshmohkWHimvtfpl85K0LtEW7vp/5jl3piUeN81Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRzkX1eI; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7481600130eso6836564b3a.3;
        Tue, 15 Jul 2025 17:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752625777; x=1753230577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X25TgPjcZ3fkjftiPDPm5horCo+r7wLhcQXafmRaqwU=;
        b=GRzkX1eIJoEFaaWpHFOsYGZS/TFj6UJhKGOw9A7Puiu2jCjKCBOO3fpdpgsGGYQc8k
         29GDS8WyYdw41Y8UBNlJzoY7LZq4O8MrDjYP7ZAA+qMVp8s4uDvJjRV0+F3YFHmQqE5D
         EnGVCG657BhXw9JJtE40pQ/LuRxLBn+3hKWmyLEaTv6EFhTzrhoM46kA6JRAYCsO48hx
         SefLR7QaQzz+3dzmdjRoTP88WLHpVZFC1PsC9NPqjgX44oB94PVjW/dxfQaTkOsOuqSX
         uk4dKzBUNwW+xhq+LPXl0FMP2TSC0vWDhK3s59AuJoPNtXGlAMya3KIwPHrAoJiVgDKw
         jRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752625777; x=1753230577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X25TgPjcZ3fkjftiPDPm5horCo+r7wLhcQXafmRaqwU=;
        b=gc4kJOPpYYKSK7FpJiry4BiiN/D71aP6uoxvyAX/4itdFpc1/QpllNN70GQcTM6R/R
         1favUu7EE2sbtJTMnr+Bv1WENPiOhazhadVPwCz7LGh8TRp25c7LGVMnuZFV3lM4dkUK
         iqYzOW3eitA5RABmqBHZdnlX0MO7NBXrVeBFG6fKoJ5ZtHNFxn64lm/3/gesb8quXcee
         +ES6L6E+hsuO6EXpFQ3oiuJ6V0y+WOxGDcuzSgVRkHCDo/XWAVo3aW/4ryFVcs7pVPj5
         mRIP3CSH7qDAq5JI5LonVUGQEYXvHooGguX7bgF9f6I7Aa47wBcw4ka9miV6yCZfL9kY
         HWgw==
X-Forwarded-Encrypted: i=1; AJvYcCVKJm981rRjVWVX/Fvq1eETv6xGdRudjAnDe3JAmEeQhfoaOa4Oq5QCJ+jajZmIFSNLJRs+JEI5mxKo2vaS@vger.kernel.org, AJvYcCVhJk4Audc8keFbFgUW1G8q+I5mjotXklTLieEGsfdXOUUAm8UfNKXHcVkaFOs2if49Vfgp7z0q@vger.kernel.org, AJvYcCWMcfTDAynp2w3OPLh7tw4LZNbmS0H4TxVcww3xMU3plx+2yHZ/60qFBcDQeq19o/Vhk7xX5uhvKIjG@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk7MKxd1z9DjOVx4Krh6+viioEHwA3Zd1WeIJw+aFXqZ0G2vSq
	1atdd+PLTwEuGylFswRMUNnVF+20jz7KJjydyJMjxDbT8K0qv03nZKrC
X-Gm-Gg: ASbGncvK1OUecvFbBy7we0TdWm3JPqcZr7EjIwv19mJ5VXlFSEODoIGgOElyW742Qq0
	oK22LLXT3wioLUmhq4+JIxMeXgP6LgT2AqwyLo3xSZ+V9uC7j/zlcUq//s8X5iW6LGMIj/R2hjx
	buns1eSbKzYflmz45rZfeYKoO+7R2aNml98Gib64F3ye4O+lpdiDUzUfcbwwxRMoXr/WxHAcpw/
	BrtZ/mRQHt7Jzv2/RSGP1rFYV2ovVcf03u3ct9+yJ37UjRywIwA0PB8NGxtNfPqOVRRTkL5zNdE
	XsI0mFJQsvYiUayXZ0LnV3sqHsZjb7KMv0hl5k5c+Yp6OlH+dVFM1xd9wIpYYOdNRfwY1s0Hvy/
	7JhGJk/rPhVqmxZpvb/nhtctp0xSkTD+Dno4n5faD
X-Google-Smtp-Source: AGHT+IFE9vyelHDv/p73IS1h2jFDZ/yGTkiztrsUWLi5qARJHMYYf94EZUy1KUk+a78S2mim3wbJYg==
X-Received: by 2002:a05:6a20:548d:b0:236:355d:5f27 with SMTP id adf61e73a8af0-23813664463mr760682637.42.1752625776893;
        Tue, 15 Jul 2025 17:29:36 -0700 (PDT)
Received: from localhost.localdomain ([207.34.150.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ebfd2d26asm11145720b3a.76.2025.07.15.17.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 17:29:36 -0700 (PDT)
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
Subject: [PATCH net-next 2/8] net: dsa: b53: mmap: Add reference to bcm63xx gpio controller
Date: Tue, 15 Jul 2025 17:29:01 -0700
Message-ID: <20250716002922.230807-3-kylehendrydev@gmail.com>
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

On bcm63xx SoCs there are registers that control the PHYs in
the GPIO controller. Allow the b53 driver to access them
by passing in the syscon through the device tree.

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
---
 drivers/net/dsa/b53/b53_mmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_mmap.c b/drivers/net/dsa/b53/b53_mmap.c
index c687360a5b7f..a0c06d703861 100644
--- a/drivers/net/dsa/b53/b53_mmap.c
+++ b/drivers/net/dsa/b53/b53_mmap.c
@@ -21,6 +21,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/io.h>
+#include <linux/mfd/syscon.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/b53.h>
 
@@ -28,6 +29,7 @@
 
 struct b53_mmap_priv {
 	void __iomem *regs;
+	struct regmap *gpio_ctrl;
 };
 
 static int b53_mmap_read8(struct b53_device *dev, u8 page, u8 reg, u8 *val)
@@ -313,6 +315,8 @@ static int b53_mmap_probe(struct platform_device *pdev)
 
 	priv->regs = pdata->regs;
 
+	priv->gpio_ctrl = syscon_regmap_lookup_by_phandle(np, "brcm,gpio-ctrl");
+
 	dev = b53_switch_alloc(&pdev->dev, &b53_mmap_ops, priv);
 	if (!dev)
 		return -ENOMEM;
-- 
2.43.0


