Return-Path: <netdev+bounces-162969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBABA28A8C
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 13:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89FE418885CD
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 12:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05C322A7FA;
	Wed,  5 Feb 2025 12:43:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C93151987
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 12:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738759394; cv=none; b=gUhBHAjKliJo8JQRBoX3INnPOQzgiUT2IWHq+RazvUr5l+yGiBjoUVD0M7z1JQLJjrQBNeMgu0jw0wLRkKrZQYMTZk3DSc9pmg6Ug+zTtcszIuj+fexHqtAbibks29fTC/hKXcUf5hP/lTVERYuQ8aLopU6W3MCVE/6Y6ZHAapw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738759394; c=relaxed/simple;
	bh=UMKsj3kOJyvqQuwohwlW+wXDdaliWn1oR5I20QwRHfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K1dZxMbOmXiGiBUjDQ3FIgMp81oCuLG5Is+G3SP+2qYoTKKb4csHizJwhNqIkzepYwgmE5P7G+eCF+uJrBZHapUyPtdA/a6H8WNNOQN1AuTiNzZT3eRWGCyuQ6p6NIqHIn1GUqwouOESxlGF/oo56qpM6g5ZcRMmKeXLFd5szJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: ceBcTh8kQCW+CZ/WKhC9Yg==
X-CSE-MsgGUID: TpZdVZhQTc2TjjwYpYPbgw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 05 Feb 2025 21:43:11 +0900
Received: from localhost.localdomain (unknown [10.226.92.225])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id DF36D41F86AF;
	Wed,  5 Feb 2025 21:43:07 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-actions@lists.infradead.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH net-next v2 6/7] net: ethernet: actions: Use of_get_available_child_by_name()
Date: Wed,  5 Feb 2025 12:42:26 +0000
Message-ID: <20250205124235.53285-7-biju.das.jz@bp.renesas.com>
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
owl_emac_mdio_init().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
previous v2->v2:
 * Dropped using _free().
v1-> previous v2:
 * Dropped duplicate mdio_node declaration.
---
 drivers/net/ethernet/actions/owl-emac.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/actions/owl-emac.c b/drivers/net/ethernet/actions/owl-emac.c
index 115f48b3342c..0a08da799255 100644
--- a/drivers/net/ethernet/actions/owl-emac.c
+++ b/drivers/net/ethernet/actions/owl-emac.c
@@ -1325,15 +1325,10 @@ static int owl_emac_mdio_init(struct net_device *netdev)
 	struct device_node *mdio_node;
 	int ret;
 
-	mdio_node = of_get_child_by_name(dev->of_node, "mdio");
+	mdio_node = of_get_available_child_by_name(dev->of_node, "mdio");
 	if (!mdio_node)
 		return -ENODEV;
 
-	if (!of_device_is_available(mdio_node)) {
-		ret = -ENODEV;
-		goto err_put_node;
-	}
-
 	priv->mii = devm_mdiobus_alloc(dev);
 	if (!priv->mii) {
 		ret = -ENOMEM;
-- 
2.43.0


