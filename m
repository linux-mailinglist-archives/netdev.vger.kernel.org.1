Return-Path: <netdev+bounces-162970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0240A28A91
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 13:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038303A4E77
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 12:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A323522D4C4;
	Wed,  5 Feb 2025 12:43:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038DF22CBFC
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 12:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738759396; cv=none; b=VPtfGQTJDG1e3ctjJusmEKM0b72yH0vVg5IO6EiVaUF62he96fChmbmzp8xeB51fjQ0l5uDKeSwO19aWIIxR3L7C2D1jQhJtoyWafzSky25ZB9aY2p162h/nSuj0hpwXFwRynnBc1rNLdTmwoVF8Xo1mCBzyAFu91s9GDaURM/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738759396; c=relaxed/simple;
	bh=0a76rMX4A5KkCWxXKAhyeftlYEa53MDXoI+fCqhufo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RcsY6GbXZHSqP5okh8MOO9y9VrE+nWiv2upwmJFU1Flh92AZ/+Opp/XDKFO2Yd3T2us7K1Y+W20kaLD4Yxu0VGHZd5Kj+Uv0bnUASUVu+M5W9xmCT45Feb6S4B62uO7mNUyFtjw6msrow0hgIexagydMZXOV17PaLjYXWtHF9w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: kZEjbmkXQmKuWVWpCE4ldQ==
X-CSE-MsgGUID: heLXhqTjSwWnRtR0B4PM8w==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 05 Feb 2025 21:43:13 +0900
Received: from localhost.localdomain (unknown [10.226.92.225])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id AC44F41F86B5;
	Wed,  5 Feb 2025 21:43:02 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH net-next v2 5/7] net: ethernet: mtk_eth_soc: Use of_get_available_child_by_name()
Date: Wed,  5 Feb 2025 12:42:25 +0000
Message-ID: <20250205124235.53285-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205124235.53285-1-biju.das.jz@bp.renesas.com>
References: <20250205124235.53285-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the helper of_get_available_child_by_name() to simplify
mtk_mdio_init().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Dropped using _free().
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 53485142938c..0ad965ced5ef 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -830,17 +830,12 @@ static int mtk_mdio_init(struct mtk_eth *eth)
 	int ret;
 	u32 val;
 
-	mii_np = of_get_child_by_name(eth->dev->of_node, "mdio-bus");
+	mii_np = of_get_available_child_by_name(eth->dev->of_node, "mdio-bus");
 	if (!mii_np) {
 		dev_err(eth->dev, "no %s child node found", "mdio-bus");
 		return -ENODEV;
 	}
 
-	if (!of_device_is_available(mii_np)) {
-		ret = -ENODEV;
-		goto err_put_node;
-	}
-
 	eth->mii_bus = devm_mdiobus_alloc(eth->dev);
 	if (!eth->mii_bus) {
 		ret = -ENOMEM;
-- 
2.43.0


