Return-Path: <netdev+bounces-193289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F868AC3772
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 02:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A2407AA949
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 00:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFEF7260C;
	Mon, 26 May 2025 00:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjbKuxPv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C86487BE;
	Mon, 26 May 2025 00:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748219431; cv=none; b=QCjHrimnCJom6V6DGHc9mxrmaj3+/U3KfxEbWxMUGqSNFvUGAxGWzB0DK2UFaoDjkcCNTpZttbuovzw3T48ardKkp1U5R3DqZ1ZQBvk8xVrR8EyMWveXp3ch20qNUWiXNd6vfIiRAo+DGct5a9vmIUL/wTj4UbozKwHXwLtoFvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748219431; c=relaxed/simple;
	bh=j/AgqK6sTn7GZhod0s1Zdw40IxV6Jv0f8Ah9CoFUBmI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uwKPJyLmwuBRyXGPR8PSMk4F2/Cb6q887zWWnc4lZC8kkUL+TbOQGk7S/cPXT0Lxy41y6UG5SrkVsPP4+dVN13R9Tvmy8K7ehwCfE+CWlmm5AagjcpfE4MEpkVPT7Ey1y+kPleGxChrBYSFJObF61bH0zfXy4xwifkDlGXmAZo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjbKuxPv; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3dc6dbb3d58so14845435ab.3;
        Sun, 25 May 2025 17:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748219429; x=1748824229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hE9h/M7uKcWqMcsxjrPkg3JJriS4MccIRahSsbbNqE8=;
        b=WjbKuxPvJQO+sUjLBggyvtz6W5sF15lCrvK1IulmZF3lfvQ1/J1Zr2+6IpoaW+T3aC
         diEZgUU2jCWTUduVDbvr5/eCjWuqeDODkQ36QNsUOOkF/WI4O0phD4w9BW2GwBLuQ4yP
         n/WjmF7F5l2E8hMa6jP7co49Q8/hnDkPz9avh9KC/e1GtrapupBpukXIyC+F+N71m9Iv
         C7Z5H5URKb+FMlLCbY6Qn+ym9ugrd87mS/8qM5LZNyO0w7lSG3/K8g1/Qnj+BDkckFQC
         /Znbalv2KfvVRJmNnjD0gY6fvqlxCNHlYNX7F+FyrphqjUE0lKPv+7EHsQv6oUgeEPYU
         jyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748219429; x=1748824229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hE9h/M7uKcWqMcsxjrPkg3JJriS4MccIRahSsbbNqE8=;
        b=cScY9DZEID2Hhcjz35SqhDMfUL1w+NtDVXJsFjFn+lv7EzPviLVac0Rb3sr047VV94
         dxnYSPxAK5wvt2XRmhST4Qd6K0BFZ+lAR9vd0BvRhMVqtmzY18WOEU4+ur9i9c/ETf2q
         PGnceooaOqiBZOm6AgBrFT6r409eG9X/keF9N5YBHESAnOqLsqTm6yYOh5an1d26xW49
         R+ZUl5drJW1YyoeV0m4/EPthtGqHKZcBDFP9L8728h821pXOsF9bLtcepOTjvm3gmyug
         P3IHh3sPyiSX5Jdqq2S81mj1Suk9MWp+N1rUv7hOi7hS0rDtOzQQ5N5p4ooDKXOkyAJ7
         18Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVDFQYuHXsu8angtMEsH/Ey9JyT8viCYAY8+3hVM/vQurUljVrz0VNuP5DhDxF+jSxAJp9I2ZTyvAJvdh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw79/3wjEieE/gBlv+MKcJReY1kX5tHpMHP6P2Tt4tvwZD799Ie
	1ThStQxFnAGDqFOuieWUUnf+xvIGg1tbhg3FL7W3apZduWSewxBqROOifJmHawJ2VRg=
X-Gm-Gg: ASbGncsgW5u7LfMjHL34BDeC+ABrVmq+qd2nFd0woUMLBw0j+sf3IThQfcfqVqCQxqB
	UQSxYDH7WVv9ASo7sbPgVTU4bavm9zpp7KDuhWAs6YWIT0wYDEMcR6bDQ7qo4b4L2pzakNVdD2i
	07J99xGqwZeJAmY8mZxTHnMrTDkdF2N2TV4GPFOn2f8SsdkWa6vVO3LfWwMjBdniUNgqJXm0wHL
	bn8aX3AypE1JCcSD+2q3yo6hIBPA/+jAnfa6slYCcc5owfe6qw81sZIKlWNcROIHWQtOx4MaQ5I
	ss6xZaW968xSARQ6lDWv43MXI+ScPjEy+m9Hgo5gfJzVwdfBuCKymhAJBBWSEvQDTcr7Kpb+zpP
	pp6i/okPM0lGa9t4zv0K6UrcofnbFhA==
X-Google-Smtp-Source: AGHT+IHeprWN0OT6Xq1C608Ko9smpP11pwLwlFe3T1+FZlCl5LSrUPerfPVKNYI6owNKSrybdMvlyA==
X-Received: by 2002:a05:6e02:2193:b0:3dc:8b57:b759 with SMTP id e9e14a558f8ab-3dc9b7517a5mr74670715ab.21.1748219428699;
        Sun, 25 May 2025 17:30:28 -0700 (PDT)
Received: from james-x399.localdomain (97-118-146-220.hlrn.qwest.net. [97.118.146.220])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dc85ef07dcsm25532785ab.36.2025.05.25.17.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 17:30:28 -0700 (PDT)
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
	Yinggang Gu <guyinggang@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Feiyang Chen <chenfeiyang@loongson.cn>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Paul Kocialkowski <paulk@sys-base.io>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] net: stmmac: dwmac-sun8i: Allow runtime AC200/AC300 phy selection
Date: Sun, 25 May 2025 18:29:22 -0600
Message-Id: <20250526002924.2567843-2-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250526002924.2567843-1-james.hilliard1@gmail.com>
References: <20250526002924.2567843-1-james.hilliard1@gmail.com>
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
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 6c7e8655a7eb..e275f4caa684 100644
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
 
+#define AC300_KEY		BIT(8)
+
 /* sun8i_dwmac_dma_reset() - reset the EMAC
  * Called from stmmac via stmmac_dma_ops->reset
  */
@@ -1159,6 +1162,7 @@ static int sun8i_dwmac_probe(struct platform_device *pdev)
 	struct net_device *ndev;
 	struct regmap *regmap;
 	int ret;
+	u16 val;
 
 	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
 	if (ret)
@@ -1222,6 +1226,21 @@ static int sun8i_dwmac_probe(struct platform_device *pdev)
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
+	if (!nvmem_cell_read_u16(dev, "ac300", &val)) {
+		const char *phy_name = (val & AC300_KEY) ? "ac300" : "ac200";
+		int index = of_property_match_string(dev->of_node, "phy-names", phy_name);
+		if (index < 0) {
+			dev_err(dev, "PHY name not found in device tree\n");
+			return -EINVAL;
+		}
+
+		plat_dat->phy_node = of_parse_phandle(dev->of_node, "phys", index);
+		if (!plat_dat->phy_node) {
+			dev_err(dev, "Failed to get PHY node from phys property\n");
+			return -EINVAL;
+		}
+	}
+
 	/* platform data specifying hardware features and callbacks.
 	 * hardware features were copied from Allwinner drivers.
 	 */
-- 
2.34.1


