Return-Path: <netdev+bounces-108626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 529A9924C4A
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 01:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D55601F233B2
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 23:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCEA17A5BD;
	Tue,  2 Jul 2024 23:44:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E913158853;
	Tue,  2 Jul 2024 23:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719963898; cv=none; b=AK6P8DT2ViA4V70OoGN+wUFH35UNxBCgQ9wHNi4Wv7Ss6xeRB/FTLvYjH573fDo7RKq0hxAB09/MZxbBvNAacTfPfnQoYwAeyk999V+b/RgTjE5Jd8Pkf/HZY1Srb9fwBuyhS0G3s68Yon23hK8y4tTLf3hGuKqy7FT3ALtqx3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719963898; c=relaxed/simple;
	bh=QIGQ12SfRMKhY4RdG2H7gQvUao7tIDkEk7Yy9wG41gc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ab1/dFvT8kvs1K8GDbJcP1rUTfITGLM3oCqSkrPBR1BuaETxmw6G7QZSLVM5U4pMmfklsFhdxgt1aPrZ3ELzMxxksxVNd3Sr3UhIcMyjNoRcv1CcXtlUMO+buAZmUQ1di0jkM/42Qf3B3ibBlVjzpLhFgxZL9uRnwlM552Pj7+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1sOnAq-000000006lM-23eU;
	Tue, 02 Jul 2024 23:44:36 +0000
Date: Wed, 3 Jul 2024 00:44:28 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, regressions@lists.linux.dev
Subject: [PATCH net v3] net: dsa: mt7530: fix impossible MDIO address and
 issue warning
Message-ID: <7e3fed489c0bbca84a386b1077c61589030ff4ab.1719963228.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The MDIO address of the MT7530 and MT7531 switch ICs can be configured
using bootstrap pins. However, there are only 4 possible options for the
switch itself: 7, 15, 23 and 31. As in MediaTek's SDK the address of the
switch is wrongly stated in the device tree as 0 (while in reality it is
31), warn the user about such broken device tree and make a good guess
what was actually intended.

This is imporant also to not break compatibility with older Device Trees
as with commit 868ff5f4944a ("net: dsa: mt7530-mdio: read PHY address of
switch from device tree") the address in device tree will be taken into
account, while before it was hard-coded to 0x1f.

Fixes: b8f126a8d543 ("net-next: dsa: add dsa support for Mediatek MT7530 switch")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
Only tested on BPi-R3 (with various deliberately broken DT) for now!

Changes since v2 [2]:
 - use macros instead of magic numbers
 - introduce helper functions
 - register new device on MDIO bus instead of messing with the address
   and schedule delayed_work to unregister the "wrong" device.
   This is a slightly different approach than suggested by Russell, but
   imho makes things much easier than keeping the "wrong" device and
   having to deal with keeping the removal of both devices linked.
 - improve comments

Changes since v1 [1]:
 - use FW_WARN as suggested.
 - fix build on net tree which doesn't have 'mdiodev' as member of the
   priv struct. Imho including this patch as fix makes sense to warn
   users about broken firmware, even if the change introducing the
   actual breakage is only present in net-next for now.

[1]: https://patchwork.kernel.org/project/netdevbpf/patch/e615351aefba25e990215845e4812e6cb8153b28.1714433716.git.daniel@makrotopia.org/
[2]: https://patchwork.kernel.org/project/netdevbpf/patch/11f5f127d0350e72569c36f9060b6e642dfaddbb.1714514208.git.daniel@makrotopia.org/

 drivers/net/dsa/mt7530-mdio.c | 92 +++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/drivers/net/dsa/mt7530-mdio.c b/drivers/net/dsa/mt7530-mdio.c
index 51df42ccdbe6..b5049ec2d84d 100644
--- a/drivers/net/dsa/mt7530-mdio.c
+++ b/drivers/net/dsa/mt7530-mdio.c
@@ -11,6 +11,7 @@
 #include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/regulator/consumer.h>
+#include <linux/workqueue.h>
 #include <net/dsa.h>
 
 #include "mt7530.h"
@@ -136,6 +137,93 @@ static const struct of_device_id mt7530_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, mt7530_of_match);
 
+static int
+mt7530_correct_addr(int phy_addr)
+{
+	/* The corrected address is calculated as stated below:
+	 * 0~6   -> 31
+	 * 8~14  -> 7
+	 * 16~22 -> 15
+	 * 24~30 -> 23
+	 */
+return ((((phy_addr - MT7530_NUM_PORTS) & ~MT7530_NUM_PORTS) % PHY_MAX_ADDR) +
+	MT7530_NUM_PORTS) & (PHY_MAX_ADDR - 1);
+}
+
+static bool
+mt7530_is_invalid_addr(int phy_addr)
+{
+	/* Only MDIO bus addresses 7, 15, 23, and 31 are valid options,
+	 * which all have the least significant three bits set. Check
+	 * for this.
+	 */
+	return (phy_addr & MT7530_NUM_PORTS) != MT7530_NUM_PORTS;
+}
+
+struct remove_impossible_priv {
+	struct delayed_work remove_impossible_work;
+	struct mdio_device *mdiodev;
+};
+
+static void
+mt7530_remove_impossible(struct work_struct *work)
+{
+	struct remove_impossible_priv *priv = container_of(work, struct remove_impossible_priv,
+							   remove_impossible_work.work);
+	struct mdio_device *mdiodev = priv->mdiodev;
+
+	mdio_device_remove(mdiodev);
+	mdio_device_free(mdiodev);
+	kfree(priv);
+}
+
+static int
+mt7530_reregister(struct mdio_device *mdiodev)
+{
+	/* If the address in DT must be wrong, make a good guess about
+	 * the most likely intention, issue a warning, register a new
+	 * MDIO device at the correct address and schedule the removal
+	 * of the device having an impossible address.
+	 */
+	struct fwnode_handle *fwnode = dev_fwnode(&mdiodev->dev);
+	int corrected_addr = mt7530_correct_addr(mdiodev->addr);
+	struct remove_impossible_priv *rem_priv;
+	struct mdio_device *new_mdiodev;
+	int ret;
+
+	rem_priv = kmalloc(sizeof(*rem_priv), GFP_KERNEL);
+	if (!rem_priv)
+		return -ENOMEM;
+
+	new_mdiodev = mdio_device_create(mdiodev->bus, corrected_addr);
+	if (IS_ERR(new_mdiodev)) {
+		ret = PTR_ERR(new_mdiodev);
+		goto out_free_work;
+	}
+	device_set_node(&new_mdiodev->dev, fwnode);
+
+	ret = mdio_device_register(new_mdiodev);
+	if (WARN_ON(ret))
+		goto out_free_dev;
+
+	dev_warn(&mdiodev->dev, FW_WARN
+		 "impossible switch MDIO address in device tree, assuming %d\n",
+		 corrected_addr);
+
+	/* schedule impossible device for removal from mdio bus */
+	rem_priv->mdiodev = mdiodev;
+	INIT_DELAYED_WORK(&rem_priv->remove_impossible_work, mt7530_remove_impossible);
+	schedule_delayed_work(&rem_priv->remove_impossible_work, 0);
+
+	return -EFAULT;
+
+out_free_dev:
+	mdio_device_free(new_mdiodev);
+out_free_work:
+	kfree(rem_priv);
+	return ret;
+}
+
 static int
 mt7530_probe(struct mdio_device *mdiodev)
 {
@@ -144,6 +232,10 @@ mt7530_probe(struct mdio_device *mdiodev)
 	struct device_node *dn;
 	int ret;
 
+	/* Check and if needed correct the MDIO address of the switch */
+	if (mt7530_is_invalid_addr(mdiodev->addr))
+		return mt7530_reregister(mdiodev);
+
 	dn = mdiodev->dev.of_node;
 
 	priv = devm_kzalloc(&mdiodev->dev, sizeof(*priv), GFP_KERNEL);
-- 
2.45.2


