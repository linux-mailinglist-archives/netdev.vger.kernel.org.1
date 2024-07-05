Return-Path: <netdev+bounces-109431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D62D92870D
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 12:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6A2DB22AD2
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 10:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07974146A74;
	Fri,  5 Jul 2024 10:49:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFAF14658C;
	Fri,  5 Jul 2024 10:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720176547; cv=none; b=HWoXvclBqYASHNx+29aVCXFLnj3mAT74Vs/GLqJxnWnXPC9syBWH82GYq/4qv/rA8pCa3SrIKTXxydEKc6Nwmv/Ag4WFSnWRsCb9aJ1s57Bv9uo24lrm9jOdWqO46pVHFZNacOt2ykEc+ygBCzP7FwZfFPV3bCqw3LSXPAyggKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720176547; c=relaxed/simple;
	bh=esPDpEApx4zj4Yo7wj9fcSyQ8vyUkNYVODN1kPFC3wU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CaAbvsjJWokrXH9nlJn8w59xKN0BywpKcyKeYtdACKGl5DxfXgPkykCJl0tzEx1i8oFFJ45c4fD84o8T/GzUGtpQCQuniXa1N5bb6alkr8i9AAInqNYURUoEGs6x71W+AbFLhTo1rdS360YcI/AvouqZgeCAe9ATKPwTO3679xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1sPgUe-000000004uj-3adT;
	Fri, 05 Jul 2024 10:48:44 +0000
Date: Fri, 5 Jul 2024 11:48:40 +0100
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
	Landen Chao <Landen.Chao@mediatek.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v5] net: dsa: mt7530: fix impossible MDIO address and issue
 warning
Message-ID: <f485d1d4f7b34cc2ebf3d60030d1c67b4016af3c.1720107535.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The MDIO address of the MT7530 and MT7531 switch ICs can be configured
using bootstrap pins. However, there are only 4 possible options for the
switch itself: 7, 15, 23 and 31. As in MediaTek's SDK the address of the
switch is wrongly stated in the device tree as 0 (while in reality it is
31), warn the user about such broken device tree and make a good guess
what was actually intended.

This is necessary to not break compatibility with existing Device Trees
wrongly declaring the switch to be present at address 0 or 1, as with
commit 868ff5f4944a ("net: dsa: mt7530-mdio: read PHY address of switch
from device tree") the address in device tree will be taken into
account, while before it was hard-coded in the driver to 0x1f
independently of the value in Device Tree.

Fixes: b8f126a8d543 ("net-next: dsa: add dsa support for Mediatek MT7530 switch")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
Changes since v4 [4]:
 - fix indentation
 - bring back parentheses to satisfy GCC
 - print warning before registering new device to avoid confusing
   order of messages in kernel log
 - improve commit message

Changes since v3 [3]:
 - simplify calculation of correct address

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
[3]: https://patchwork.kernel.org/project/netdevbpf/patch/7e3fed489c0bbca84a386b1077c61589030ff4ab.1719963228.git.daniel@makrotopia.org/
[4]: https://patchwork.kernel.org/project/netdevbpf/patch/1c378be54d0fb76117f6d72dadd4a43a9950f0dc.1720105125.git.daniel@makrotopia.org/

 drivers/net/dsa/mt7530-mdio.c | 92 +++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/drivers/net/dsa/mt7530-mdio.c b/drivers/net/dsa/mt7530-mdio.c
index 51df42ccdbe6..c666edec6b9e 100644
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
+	 *  0 ~  6, 31 -> 31
+	 *  7 ~ 14     -> 7
+	 * 15 ~ 22     -> 15
+	 * 23 ~ 30     -> 23
+	 */
+	return (((phy_addr - MT7530_NUM_PORTS) & ~MT7530_NUM_PORTS) +
+		MT7530_NUM_PORTS) & (PHY_MAX_ADDR - 1);
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
+	dev_warn(&mdiodev->dev, FW_WARN
+		 "impossible switch MDIO address in device tree, assuming %d\n",
+		 corrected_addr);
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

