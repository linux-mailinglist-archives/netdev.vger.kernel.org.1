Return-Path: <netdev+bounces-193493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C8CAC43BB
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 20:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77C56179B56
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 18:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B21B19E971;
	Mon, 26 May 2025 18:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFaMK49o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBC92405F6;
	Mon, 26 May 2025 18:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748284217; cv=none; b=sdcDEdRi5eIF2ZgHQuX8JG/8MSLxzIZnqtQ7lC2eeAea9x4RmqhLEkLS+abCtlwK85L39JWgITU+kdR1UE/TpZDs7WbzqTUkAZGf+fmtBz07qmg2NvKItKMKfrPxgbx+/csfufRyUUoZe4jSk/y8nGPofaBUqftwMHey/rSzCno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748284217; c=relaxed/simple;
	bh=n9lLa9aOW+o9DIrjLgE71KlJZvLdzhrLz9GSBZNuZrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p7m+3vWztxstQYbFK9oZm+glzYfFxNpihyYLG6byNlD3sZ88sugKhScXOZ7hgwUQKcq+C5q4CkF977tR6wOUOyWsbGuhzd4OhSZnv3ZYPHIIdfoPATUZvXKOFbX+EH3mNyZU5fJAT1gWMeV4RuzdSgMlWIb4N+FNOSz4nQ0qH/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFaMK49o; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-85b3f92c8dfso68975039f.2;
        Mon, 26 May 2025 11:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748284214; x=1748889014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95DMf2o/6QqJigi08+dNX9nTEaleJKhH1r+O8T2YuA4=;
        b=DFaMK49o6EiSE+4WE/twXIGPt/FqYGuca0kACQ6zvZBZSufz4wCUntoYvS4SNOp9t5
         IZlHQz+yYGARLl8Vvw7kG3ps2lJ8F8UkEJui88Yi+Oyb/Xy+hYEAq6r62b+4uqwGltLr
         QJASzl75jUWlmXixkO67Gf5TUVA59MtmUZLS5txeCPN211NjsxfawS29xowSGMDptlMi
         inS6wn7AcC5Zy89sgBeFbdt/SsJoTvZfaygsQ2PGlz+I00PeneyHBfRi2mKp8sOuCwkd
         wWYjBfBL0lM3eCGhnIIINZIu1QfhXMLooDlGXpEGt7hsilyPPy2H6V2e7RX35GUg90E3
         6s+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748284214; x=1748889014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95DMf2o/6QqJigi08+dNX9nTEaleJKhH1r+O8T2YuA4=;
        b=n3iUCOyDzWDDOFvOzP1ZJT0pIX5ZfnPcKvvcqUfxFVs9cmWSKmPodEou/MTfRQNmod
         Y8kV+Fm36qWmk6KiaS7tN7c7YxUQdxrcCcCtuHjrEZ/jWLLAo5mCE6i+aXp17hBBLrv4
         +1hGCXJ0xRH2LDr7hnpXAKB6oF5EtmXTuJcookuS54wmXet+HMEv+AtNzKV7JnDbxvyo
         2c5ZlY9A2bv4N1J7ug8+rjO4Q1hn5QEchVvgc3OXrZ3whZXyKao/3JAHHU79qCvHo5TC
         dtTDlzdAMvoXY/S+er50tcxlzVkJXyTz8pWBE2tNTeH8RVPDMGWkjvxhqqvArN6a/Ypq
         qWjw==
X-Forwarded-Encrypted: i=1; AJvYcCWwIzCW/79mLPiOzI7BNzbNmBiGVF4/TfY8FD+3Qt6aPjKvGcOf2oqHBuFc/BW/dp4bpUBKG4Ewz+Azv2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyCxOJiAWKsL0b9CYcdWvNclWaAX8BBvPfvqAIupm6dQ4SNOs2
	8CzSqX/4ejKqu4WcrApts/pS+dcnuhLP8pc8b2kS9DGivQmDiQqZdx0j6hzlidhxzIU=
X-Gm-Gg: ASbGnctRCDz0tHD8p8Lgh3GQ3X4Ls2wJd0VFSvUun4pUQgr7xU1bejpZ9ThFilUAm8R
	NlrR7m+ElqMJXtx+wGiQoh3+vbl2tE8SsfwdDEQDq30W/Sn8csSi5MbsEjduNFsdPSQFcHoj1AS
	tcKZm+pTLQlFyYznRCBUQHJ+jBaUn/IIwCppNyKrIuZp8vczKY4Ux3uUMZ0RTzqmJyehC6t4Him
	k+xeHam4dD/SSIqEEdiQV7dgdbmeEUULjBOXxZU7XV8pyI+V3qZBiEXzWoHo6CCu22EchNJFgKG
	3fQ8JWAW/Q4jpkiITpyQv9gMSWX2AzhLxsx6Szqo+zswukQcLXOc2OiJohBH4YiLi0yJsD8WrGD
	8cVroXZKtDKt1UiikU76P3bKiwUWVaQ==
X-Google-Smtp-Source: AGHT+IFDdvdL5g5ovSs/1gRBNnLk8GUjN90DAUSZdCdx+omEcVNlJWEAmQHeKYZ7rWqPkDPPkFePrg==
X-Received: by 2002:a05:6602:750c:b0:867:6680:cfd with SMTP id ca18e2360f4ac-86cbb7b82a4mr997010839f.1.1748284214365;
        Mon, 26 May 2025 11:30:14 -0700 (PDT)
Received: from james-x399.localdomain (97-118-146-220.hlrn.qwest.net. [97.118.146.220])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-86a235bff69sm477028639f.8.2025.05.26.11.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 11:30:13 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-sunxi@lists.linux.dev,
	James Hilliard <james.hilliard1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Feiyang Chen <chenfeiyang@loongson.cn>,
	Yanteng Si <si.yanteng@linux.dev>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Paul Kocialkowski <paulk@sys-base.io>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] net: stmmac: dwmac-sun8i: Allow runtime AC200/AC300 phy selection
Date: Mon, 26 May 2025 12:29:35 -0600
Message-Id: <20250526182939.2593553-2-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250526182939.2593553-1-james.hilliard1@gmail.com>
References: <20250526182939.2593553-1-james.hilliard1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Allwinner H616 ships with two different on-die phy variants, in
order to determine the phy being used we need to read an efuse and
then select the appropriate PHY based on the AC300 bit.

By defining an emac node without a phy-handle we can override the
default PHY selection logic in stmmac by passing a specific phy_node
selected based on the ac200 and ac300 names in a phys list.

This allows us to have a device tree that defines both PHY variants
even though only one will actually end up being used at runtime
based on the ac300 nvmem efuse bit.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 6c7e8655a7eb..50d37876fabf 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -11,6 +11,7 @@
 #include <linux/mdio-mux.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/of.h>
 #include <linux/of_mdio.h>
 #include <linux/of_net.h>
@@ -280,6 +281,8 @@ static const struct emac_variant emac_variant_h6 = {
 #define SYSCON_ETCS_EXT_GMII	0x1
 #define SYSCON_ETCS_INT_GMII	0x2
 
+#define AC300_KEY		BIT(8) /* 1: AC300 PHY, 0: AC200 PHY */
+
 /* sun8i_dwmac_dma_reset() - reset the EMAC
  * Called from stmmac via stmmac_dma_ops->reset
  */
@@ -1149,6 +1152,35 @@ static struct regmap *sun8i_dwmac_get_syscon_from_dev(struct device_node *node)
 	return regmap;
 }
 
+/* H616 SoCs can contain either an AC200 PHY (needs i2c init) or an AC300
+ * PHY (no i2c). The silicon variant is flagged by the AC300_KEY efuse.
+ */
+static int sun8i_dwmac_get_ac300_phy(struct device *dev,
+				     struct plat_stmmacenet_data *plat_dat)
+{
+	u16 val;
+
+	/* If the nvmem cell is absent, use normal phy selection. */
+	if (nvmem_cell_read_u16(dev, "ac300", &val))
+		return 0;
+
+	const char *phy_name = (val & AC300_KEY) ? "ac300" : "ac200";
+	int index = of_property_match_string(dev->of_node, "phy-names",
+					     phy_name);
+	if (index < 0) {
+		dev_err(dev, "PHY name not found in device tree\n");
+		return -EINVAL;
+	}
+
+	plat_dat->phy_node = of_parse_phandle(dev->of_node, "phys", index);
+	if (!plat_dat->phy_node) {
+		dev_err(dev, "Failed to get PHY node from phys property\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int sun8i_dwmac_probe(struct platform_device *pdev)
 {
 	struct plat_stmmacenet_data *plat_dat;
@@ -1222,6 +1254,10 @@ static int sun8i_dwmac_probe(struct platform_device *pdev)
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
+	ret = sun8i_dwmac_get_ac300_phy(dev, plat_dat);
+	if (ret)
+		return ret;
+
 	/* platform data specifying hardware features and callbacks.
 	 * hardware features were copied from Allwinner drivers.
 	 */
-- 
2.34.1


