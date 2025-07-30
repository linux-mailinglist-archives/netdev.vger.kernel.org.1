Return-Path: <netdev+bounces-210920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0E0B15765
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 04:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 206825A1532
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 02:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB88A1E2848;
	Wed, 30 Jul 2025 02:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWXGw78A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436FE1D5ACE;
	Wed, 30 Jul 2025 02:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753841039; cv=none; b=YnGqrGx7XswT9JEpRV7qW4HPK4DnpKo8nboSmUdKgAGuGV2SVVQqDgA8gEPegzMkflTyVFAS9fsJuIGb855vurdGgy29N6YmZ5O/p2R2YnrrkgzfutBop6URv3b4/LYxOnsyu1zV/h/pMmybhfUo+wng20nBru+BcIPjmIHkMTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753841039; c=relaxed/simple;
	bh=C2Dh2y7uxmOEcVN2K5+H+xeT0w+sDUBqWX5xNBEpuqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aPToCXMEz3GP7skSW06YxdTdZvaoHDYLNd4o80YLj6l7yJEHVPjuuqNLnB56REY8rBecjw3bQ5aIjaXw7OGzLtRLOck9l3xAd5yMuwf/rxjl/IKx7dQ28nCgVQydiB4Y27rhYpzvlWvbG/PNJtsYIzT6Ggdk7/mhOvtLro4Qn+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWXGw78A; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23fd3fe0d81so32389685ad.3;
        Tue, 29 Jul 2025 19:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753841037; x=1754445837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXVHa3hSudv2gKzCVrdcUINEZJnfMmL9RlrwC77Sdpc=;
        b=eWXGw78AS4dSrFfneD67D4DuEMgWJRyjin13xpc6L5PEkAhI1t4te/+zsJHJ1w9Vew
         GjuMymCEtEtJ7J7r+qDigLb0eHp2ZYzI7xkqkfDBsFl4H+Z1O7YDjKsSDY6RrPpZLQgD
         tsgQvj1vm8W0cawZ6diSWHnSLt4e6/157V6K4KYJa2f7uOC0aLmigjrSinMNbQson0ua
         tj/3SCUXh0q2ZnSoQat+w5tFggYY2+GaoG69VwsD4z9nZsr57e5xD7+vK+iXAHeKkcmX
         LeLaC2919wgLbMoDKeFc+B/pMPndvG6ZRmKlsebHUGhBNzUro/qhXOml/gcQxkKJ4ajl
         CTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753841037; x=1754445837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NXVHa3hSudv2gKzCVrdcUINEZJnfMmL9RlrwC77Sdpc=;
        b=woYE2NVwhS7yI44QTUA7UHdUK5ZccQjJLOUHKsZT8unWWjTuuSsKv3vFprAHLGjYV/
         ES2JDNkUM0S5GOsJcqJixc3Lwn/CRnRFFkOE6/+O6Bio5a9XYh0G+JRPHVPvktwaofNj
         63QjKno47URqw67Q784VfZScCCwTS/KuNdBrCaEsuxzhzf+0dp6j8JLESSoN11+Sz/mE
         yasG2w0l3ECklaJPaUv4xAuxgBiyC4CphDzF7aDRengJWzJGEP2e1xIo6FehgDEr54Sn
         lWSnqVje9yMrIbG/hXBjavaZ5CcCCqoYq+jDpX5ggQwF87xyCRGmnEfYIskQp3UAkP75
         ZtcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlHsd5iAb4vHRWEDdUHROSjlOJTy35xQtupC7zRqqZpbn2z2KE6mwBmPjD5tqu5lCfblkZRi68jKDp8ew=@vger.kernel.org, AJvYcCXt1q1WZnWSgZmal3pfCxlMEp8oi0xH6OPW6nNhsL69XgiM3e9UjyfnO9LYaMxZ/z3LIP/YsiYk@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9z5HrS7zdWuHVNUHFGzitD+N/Vl5zGUp8exNmd9/8eABmvjAe
	tjDsuJqkSOauEkxPKmrAXKwas5fsq7PMyTMxTQv9RZhgv5I0NWi13xpG
X-Gm-Gg: ASbGncucdgNI/iyDkblsoUrTyS2Z1RBBbpFXzD7vyWEkxy4hXn3mH+Qf6XhmFN2DlCp
	kgDQllt0OZOwcrdNHBGMXaqYEQiXqcsEAFWAfvGeF/vI8HgEyNDPJp6PcNjV87KF4Hy+D1scygY
	ntcw67SIqfgvivU25wsDVmtYFs2mI6GQYyV0FqglDRTo83C0Ci7A+KZRngOdwn9A7VG9e2gyM9a
	k5CWLIkw9Ntqd84UGaaG8UM9/ubLyaAxa6Tx9q2HMFfbdteOzbwKhS4QcQjcpiORINu3FTmmd6s
	W7Al6GwuXV60LhpJt8Y8ge4dLk04BRrFqh9F+YJtow8HRHMOIHFG0VBY2ohKYFr6fIiBH1XKnaS
	CygzBKg8019fR/wcsnha/qstlKGB/NND/Q2Xeg3La
X-Google-Smtp-Source: AGHT+IHF6jK+tnopo4qbjwzbZz/buElWW/vs4XCYurio/x3lKbEc2pbKdzuG822V+ftQuDidwpYaFg==
X-Received: by 2002:a17:902:cf08:b0:240:6fda:582a with SMTP id d9443c01a7336-24096acc97amr18518555ad.23.1753841037487;
        Tue, 29 Jul 2025 19:03:57 -0700 (PDT)
Received: from localhost.localdomain ([207.34.150.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23ff71916f0sm70349845ad.147.2025.07.29.19.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 19:03:57 -0700 (PDT)
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
Subject: [PATCH net-next 2/2] net: dsa: b53: mmap: Implement bcm63268 gphy power control
Date: Tue, 29 Jul 2025 19:03:36 -0700
Message-ID: <20250730020338.15569-3-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730020338.15569-1-kylehendrydev@gmail.com>
References: <20250730020338.15569-1-kylehendrydev@gmail.com>
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


