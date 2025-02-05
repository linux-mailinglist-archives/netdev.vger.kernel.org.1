Return-Path: <netdev+bounces-162971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE01BA28A93
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 13:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B6EC7A2223
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 12:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568A3151987;
	Wed,  5 Feb 2025 12:43:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD75322DF81
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 12:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738759409; cv=none; b=KMVWx1SplRHT6ujGeS50XAPZH5IWp3Ng2PbK3hHW3A5kYwvoKZ11Th2r4NnrSSCLCTCBarhIJZkFljWuDm8v2I11fEaQnmMuXxUfmVcHypohAPUoiBf4RGo/reNwFAc/qPQtRERqJTYQcms/JzARu3tjX+K9U/qQwrynMoXDbnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738759409; c=relaxed/simple;
	bh=TJrOO80xGmN2b0CDRuYtCrX2qz0g5fveMRkZM0ot4fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J0NqDg6dDevYYYGudKf9RL3UOrEMMvUOLHucTpTmr/or3DE11g1HZj8GehQc4x6dBtU6INpfYJUwqb7SRTSUUiDxvyNM8iROI9KU7e1GjuDUWYGmdz5P4sQUZsoY7m/uJouBQ06TgHwsF5yFn6DEd+bW6mnxjMULD3AnNlBNYQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: Fii3sQLtT9qTh/UL0YK85w==
X-CSE-MsgGUID: myESdrXdT/+YWeio5jb/TA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 05 Feb 2025 21:43:26 +0900
Received: from localhost.localdomain (unknown [10.226.92.225])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4B07541F8497;
	Wed,  5 Feb 2025 21:43:12 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Rosen Penev <rosenp@gmail.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH net-next v2 7/7] net: ibm: emac: Use of_get_available_child_by_name()
Date: Wed,  5 Feb 2025 12:42:27 +0000
Message-ID: <20250205124235.53285-8-biju.das.jz@bp.renesas.com>
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
emac_dt_mdio_probe().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Dropped using _free()
---
 drivers/net/ethernet/ibm/emac/core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 25b8a3556004..417dfa18daae 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -2554,17 +2554,12 @@ static int emac_dt_mdio_probe(struct emac_instance *dev)
 	struct mii_bus *bus;
 	int res;
 
-	mii_np = of_get_child_by_name(dev->ofdev->dev.of_node, "mdio");
+	mii_np = of_get_available_child_by_name(dev->ofdev->dev.of_node, "mdio");
 	if (!mii_np) {
 		dev_err(&dev->ofdev->dev, "no mdio definition found.");
 		return -ENODEV;
 	}
 
-	if (!of_device_is_available(mii_np)) {
-		res = -ENODEV;
-		goto put_node;
-	}
-
 	bus = devm_mdiobus_alloc(&dev->ofdev->dev);
 	if (!bus) {
 		res = -ENOMEM;
-- 
2.43.0


