Return-Path: <netdev+bounces-213529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BDCB25857
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 02:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EEBE1C0533F
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 00:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806AC13635C;
	Thu, 14 Aug 2025 00:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iG1KkskZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF4A54F81;
	Thu, 14 Aug 2025 00:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755131148; cv=none; b=dlDxNxjXlwWQ5+1rKtAK3dFnIQMf2scq75rq6r/RT1ZiUXMlxLxiJwnuCE1Pyy/YwKeinRqXwjMAci/oGtPTEjEcmUGHpJHsy/mKVMMRHx5tm/IOCtV5zmlB3Uk/UagqwNgDA2wFAEf7G1UPshhpxZfYfUnggJjCdVIRsy+Qnsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755131148; c=relaxed/simple;
	bh=KbSVrPenJpV8f+sieb2H4aHo9s1fKl4oe0WQMgIjNFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GnL9wyRqTowPJkiK8LGULPXKycdWIFLYdiMFsF6AXdNiJZU55Zn7T7uUZHSeJGMzqjBCE8ra3jHt0ntMNXbSqnvBxqyRcEr5nSsERKvGFQe5L76kKsAtbOBFXb6f5Sjkh4lalhL/gQsf0+6ib6tIXSLbLLo1lrZn0YVBwwLt9hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iG1KkskZ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e2ea94c7dso757956b3a.2;
        Wed, 13 Aug 2025 17:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755131146; x=1755735946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dhg1jHByTfCplcY3YaCgrXANJZh/YTQcGYKlkTwY9s=;
        b=iG1KkskZGqk58t0PoXzE+RivFRWHok7U0DvMesTWkCpyHgEuRGjWQ1+t/PqSLZDqjb
         bk5rFwihgI25rbt/3/ltrwNDl8CL5zsbmjOGkUl11yocdFCkeLzTrkl12hw3+Pw8HyGo
         XHaVQoRShC9O3NmxB1oabcAOd5VrGC7/kohSsv7oDAu5Rywbssusrym1Ta/FkbVeioRm
         7uRHFAOQJshjPIWWEY8FNzE/AkGLo4LPOPW+ETD6HJaJxM818IJq8V7sDxRE8nrYyrN3
         r2VNc1Tdlc/Nwtep/V8JqoSUejt+r33t5yobs0wNAX/zGmT3mNyFIDZ9Uj+rPYuVjKM4
         scVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755131146; x=1755735946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dhg1jHByTfCplcY3YaCgrXANJZh/YTQcGYKlkTwY9s=;
        b=XuBAlM3L5hSKH8adjaWx7SwJGFw1k55evhQGDsKOK6YkQ6HwWCPQsg2k61UXLO4dFn
         ty7Y56xL6yY/OlTyImtQiIEjd3CGQFoY1HK8IZ3+3xCD51hF2AxzvZgCGAWtionmd1MN
         zqPYCu+faczgJwKfKYP9NEEr3c4fMX3OGr+2vCXvMGeahqaGldTaWcGvCSwmG4pGV0v3
         eYOLzksN+TtzB7KN/WQhfkh8gg02pynLnyXDnrbeN44oFBdxxKAkeiI200Ji3K9zm9PM
         ArgI+C8g8/Bw4pkK6sM6QT2nP4RJ0lKfrwsOkp2sELl3mIK2Dqe7bkpEDGSv09vucv7F
         y3rw==
X-Forwarded-Encrypted: i=1; AJvYcCWSHf+1klTW4yEuw6HNg9Ras2JKJ725/nZCmIacJui/xx4/If7RI/OhSXmGtf45wDHZkjCOsFzsXBBkghw=@vger.kernel.org, AJvYcCWgv3P1H2/rTguBF+pl8VRWVc/WFZgH1BNI4rFcT91O1AeVn+26YnCQQZYw2CTvv+Xsv23FrTKC@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9HqdYVdvr4P/Wxjvp9HvdRuIWB95fPXr56j9j7YENHMcPHqsA
	G2ZBFK+IpoL35TN4PPG6LRJuNEkTAhUuDEV2GYgPNz2x4ykyl901ZMX8
X-Gm-Gg: ASbGncvDxW0K3tbh0n5YYxjsTdsFekTp28LJhir746Nx4HnODQ7Kc/l8D8n461DpL+b
	8Z/xdH3qG3bA6FvteysPnmP81Az5zbq6IE8U32N/xgQ8iWMUIZfoK9OTeSSMh0g3p6BF28EjU+p
	Fd2XbPqU62LKP7Rr4+cdd/cXoMojf0SXHu70fH6R+/IpAQKUu4Gka7zZVy6Mrz4Y0VanCG4VcmV
	HeTY3IjaboucHqS++VX7CUrNHaaVBcdZEtS7p9rITqfGoEsmUDr+ggl6vorpiYgUAO2mczbbK/m
	Ps4oBPzaINW2LBE+Uo0MbBPGVfqyY/TWULNjtJ+Ag74EcIfD/5w1ztotv3jYLXfZzja5d0ZVt5C
	1GUVqPksfnlfMPrJgNWrX5eTyzgf5DunfN63j8U0=
X-Google-Smtp-Source: AGHT+IGSWbrwU7ACOmX2Z0LcwVxq+cvuqy+tlOM9s2oN5RQxudoLYQc5vq82e5He/7qypmwP/KG1MA==
X-Received: by 2002:a05:6a20:1592:b0:23d:55d0:f46d with SMTP id adf61e73a8af0-240bd24150fmr1164777637.21.1755131146296;
        Wed, 13 Aug 2025 17:25:46 -0700 (PDT)
Received: from localhost.localdomain ([207.34.150.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbce84sm33224424b3a.71.2025.08.13.17.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 17:25:45 -0700 (PDT)
From: Kyle Hendry <kylehendrydev@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: noltari@gmail.com,
	jonas.gorski@gmail.com,
	Kyle Hendry <kylehendrydev@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND net-next 2/2] net: dsa: b53: mmap: Implement bcm63268 gphy power control
Date: Wed, 13 Aug 2025 17:25:28 -0700
Message-ID: <20250814002530.5866-3-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814002530.5866-1-kylehendrydev@gmail.com>
References: <20250814002530.5866-1-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add check for gphy in enable/disable phy calls and set power bits
in gphy control register.

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_mmap.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_mmap.c b/drivers/net/dsa/b53/b53_mmap.c
index 87e1338765c2..f4a59d8fbdd6 100644
--- a/drivers/net/dsa/b53/b53_mmap.c
+++ b/drivers/net/dsa/b53/b53_mmap.c
@@ -29,6 +29,10 @@
 #include "b53_priv.h"
 
 #define BCM63XX_EPHY_REG 0x3C
+#define BCM63268_GPHY_REG 0x54
+
+#define GPHY_CTRL_LOW_PWR	BIT(3)
+#define GPHY_CTRL_IDDQ_BIAS	BIT(0)
 
 struct b53_phy_info {
 	u32 gphy_port_mask;
@@ -292,13 +296,30 @@ static int bcm63xx_ephy_set(struct b53_device *dev, int port, bool enable)
 	return regmap_update_bits(gpio_ctrl, BCM63XX_EPHY_REG, mask, val);
 }
 
+static int bcm63268_gphy_set(struct b53_device *dev, bool enable)
+{
+	struct b53_mmap_priv *priv = dev->priv;
+	struct regmap *gpio_ctrl = priv->gpio_ctrl;
+	u32 mask = GPHY_CTRL_IDDQ_BIAS | GPHY_CTRL_LOW_PWR;
+	u32 val = 0;
+
+	if (!enable)
+		val = mask;
+
+	return regmap_update_bits(gpio_ctrl, BCM63268_GPHY_REG, mask, val);
+}
+
 static void b53_mmap_phy_enable(struct b53_device *dev, int port)
 {
 	struct b53_mmap_priv *priv = dev->priv;
 	int ret = 0;
 
-	if (priv->phy_info && (BIT(port) & priv->phy_info->ephy_port_mask))
-		ret = bcm63xx_ephy_set(dev, port, true);
+	if (priv->phy_info) {
+		if (BIT(port) & priv->phy_info->ephy_port_mask)
+			ret = bcm63xx_ephy_set(dev, port, true);
+		else if (BIT(port) & priv->phy_info->gphy_port_mask)
+			ret = bcm63268_gphy_set(dev, true);
+	}
 
 	if (!ret)
 		priv->phys_enabled |= BIT(port);
@@ -309,8 +330,12 @@ static void b53_mmap_phy_disable(struct b53_device *dev, int port)
 	struct b53_mmap_priv *priv = dev->priv;
 	int ret = 0;
 
-	if (priv->phy_info && (BIT(port) & priv->phy_info->ephy_port_mask))
-		ret = bcm63xx_ephy_set(dev, port, false);
+	if (priv->phy_info) {
+		if (BIT(port) & priv->phy_info->ephy_port_mask)
+			ret = bcm63xx_ephy_set(dev, port, false);
+		else if (BIT(port) & priv->phy_info->gphy_port_mask)
+			ret = bcm63268_gphy_set(dev, false);
+	}
 
 	if (!ret)
 		priv->phys_enabled &= ~BIT(port);
-- 
2.43.0


