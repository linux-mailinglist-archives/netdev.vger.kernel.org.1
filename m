Return-Path: <netdev+bounces-141554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EB69BB543
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 14:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3C6A1C21C7A
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 13:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8521B86CC;
	Mon,  4 Nov 2024 13:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QV3cviAv"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4458B1B85D7;
	Mon,  4 Nov 2024 13:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730725325; cv=none; b=tTxsAFIiq7BPgfxNivINsdMSWJGXjORUqm6UzNKOx21TgLUcs8Pl9l/prqRuSv531uM+jilNr6aNlwrbpn7/XBVOMhBQ6N0oAGXRsKKn5yLi0n7B3iExQlzwq0/F4QOTwzEAdBGLSoizz8lb61xdHkK+X7Rfxh2wPIyhI44i4Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730725325; c=relaxed/simple;
	bh=kmYoxaAaiXAIj7/EBZuGyiZPPJS/LqE7N5G+nG9H11M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGUNb9l6ywfw8Xg4E6DYEjG15xz96ZX5KIlEBHVWUD+1omi74585z0ghUumXPnnoy8dlPOhT2USoSHvGAl9E52cSakhURuTZOlki6KtkVv0IBSDWCd8FnKL/CHaXgP+SISaZwOIJNBkTDSaRULR2rB8crSZYmWctVlXeSRlEt5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QV3cviAv; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=Msi5U
	O0XeHyxPfT+8A8tLnfNN4KZV4Ysxbt0ioo0v5w=; b=QV3cviAvkozH2Z3U9/TOF
	ysVBmP+yt9POoVC45E+ZLfQbX7vpN0KFKIxj134wr1AXTzR7Vl8yLSuT0iUaen73
	PBIl3ejHEK0dvXn0MfZXsI9xAZsq7yk6PXdgJ/uB/X7EskrHt1NsRlt3yn68Cf8b
	p3jrFFGDnsh56UbcugkqKo=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3H6e8xShnPaEoFA--.33421S4;
	Mon, 04 Nov 2024 21:01:53 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david.wu@rock-chips.com,
	Johan Jonker <jbx6244@gmail.com>,
	Andy Yan <andyshrk@163.com>,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v2 2/2] net: arc: rockchip: fix emac mdio node support
Date: Mon,  4 Nov 2024 21:01:39 +0800
Message-ID: <20241104130147.440125-3-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104130147.440125-1-andyshrk@163.com>
References: <20241104130147.440125-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H6e8xShnPaEoFA--.33421S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFyxXr48XFyUGrWrAF15CFg_yoW8CFWUpa
	yDurZ8CrykXr4Sgw4vyrW0vryaqw48GrWj9F12kanYqFn8JryxJry2gFyUur1qkFWqka1a
	q3yDZFyruayDJr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UO0edUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0haNXmcow9UdaQAAs6

From: Johan Jonker <jbx6244@gmail.com>

The binding emac_rockchip.txt is converted to YAML.
Changed against the original binding is an added MDIO subnode.
This make the driver failed to find the PHY, and given the 'mdio
has invalid PHY address' it is probably looking in the wrong node.
Fix emac_mdio.c so that it can handle both old and new
device trees.

Fixes: 1dabb74971b3 ("ARM: dts: rockchip: restyle emac nodes")
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Tested-by: Andy Yan <andyshrk@163.com>
Link: https://lore.kernel.org/r/20220603163539.537-3-jbx6244@gmail.com
Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

Changes in v2:
- Add fix tag.
- Add more detail explaination.

 drivers/net/ethernet/arc/emac_mdio.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/arc/emac_mdio.c b/drivers/net/ethernet/arc/emac_mdio.c
index 87f40c2ba9040..078b1a72c1613 100644
--- a/drivers/net/ethernet/arc/emac_mdio.c
+++ b/drivers/net/ethernet/arc/emac_mdio.c
@@ -133,6 +133,7 @@ int arc_mdio_probe(struct arc_emac_priv *priv)
 	struct arc_emac_mdio_bus_data *data = &priv->bus_data;
 	struct device_node *np = priv->dev->of_node;
 	const char *name = "Synopsys MII Bus";
+	struct device_node *mdio_node;
 	struct mii_bus *bus;
 	int error;
 
@@ -164,7 +165,13 @@ int arc_mdio_probe(struct arc_emac_priv *priv)
 
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", bus->name);
 
-	error = of_mdiobus_register(bus, priv->dev->of_node);
+	/* Backwards compatibility for EMAC nodes without MDIO subnode. */
+	mdio_node = of_get_child_by_name(np, "mdio");
+	if (!mdio_node)
+		mdio_node = of_node_get(np);
+
+	error = of_mdiobus_register(bus, mdio_node);
+	of_node_put(mdio_node);
 	if (error) {
 		mdiobus_free(bus);
 		return dev_err_probe(priv->dev, error,
-- 
2.34.1


