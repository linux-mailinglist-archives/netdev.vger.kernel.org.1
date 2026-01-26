Return-Path: <netdev+bounces-253421-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPmlESNEd2mMdQEAu9opvQ
	(envelope-from <netdev+bounces-253421-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 11:38:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 864FC871C3
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 11:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A0778301EC8B
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 10:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4C4330B3B;
	Mon, 26 Jan 2026 10:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xMv3kFhp";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XvSnlWh5"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F192D060B;
	Mon, 26 Jan 2026 10:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769423735; cv=none; b=GbSFZPU9cU2npyZ3fXLqoqmLVYBeFCIgvrFnX4ls9WCeqzZ3yoeU4iRxoqXyADLGyXypHBx6qkl9sQKUiIJDBJzlvvIRqWJJFWvqKArxEUw086ng4TD/QwjAB3cmCw3iIYpjJtxUYFnwLKTk7PuspUuJC/ope7TrBgp1IsH2J9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769423735; c=relaxed/simple;
	bh=haySyqfhwLP9+xnJypQTqKxLnVGwCb+HZsI0u/Rkp1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZRQo8bHMc+BuyM3Nag2szmlu2QDQwUKtQ9giNtPcW9b6X+WUSQ67P1mCX+/FxGkWNwIDaPFAKILtSOlyyfs/UsyPKAwW8KABWG2rAFxMG46olsvrnJ21jmqtNahWK+sY1f/v4DlvQvYka7/Sbs6Rsw0kP7VDwOWejJLi1erYrAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=xMv3kFhp; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=XvSnlWh5; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4f04gR6SZ0z9t6j;
	Mon, 26 Jan 2026 11:35:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1769423731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z06Kb6I1pYSThuzVPxgg5ahC+qLhEdq8OUCOAzJASys=;
	b=xMv3kFhpVuaTraoOKAv/tL5GzoiRbTpW9j89juzw1jrFqPN/M3R6ozTeZBJ6b+vz7raEUD
	HIutgYl8lTUtYkGOJe7cdVRiukbPy5R40XG27qrU3wM6tJkPZkxhUPr48/det7ZChAGmy1
	ozzHFXhhLpuwRfW2XhsuM6zcB/lRiC4rYlf/oY5quDDZfzdX5oUa5+qYfw2hgImeyWdu8/
	524hjOQMd9Ef2mazXot5lM6bEjgeV7nKB5b1kiqm27W04d8m/9Qt7Mwm3Aa89Gtc6UnUVx
	EfovdHT3i2/NBq8edA1CNXLseTwqq+tpdD5C8QRizKharIcKZxkZTy1h3gxfBA==
From: Lukasz Majewski <lukasz.majewski@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1769423730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z06Kb6I1pYSThuzVPxgg5ahC+qLhEdq8OUCOAzJASys=;
	b=XvSnlWh5PjHKymoSZ5H8WE4fqywsLKGi2zk1jUkjIa/A6WxYV6ffB2rPjooH+XlnhUjW/I
	nIe9ITk6+fBH4zmFRPmU8By6zaNOxRFN2jhI4ON99k5l8CNYu20rYEWonJPc9tgbHZ1H1m
	CqxRBTgLv3edF9K0BdM0QyU6J7Ap805znfzgyohwMObdpdgy4EIPTUgXEkelxK9AbEp7mC
	MKvTu6d2tQh9aKGJs1wX5LEFZ/A310NYClScI4O7KYE7/hNEuRpE7A1Z88MG4dw96DBPzZ
	mRJ6roccM7ydovZG6k/Kwu8I0GHIoqsllg79hYuLSOZAXYurZ1EQvC6Uph4YCA==
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Simon Horman <horms@kernel.org>,
	Lukasz Majewski <lukasz.majewski@mailbox.org>
Subject: [net-next v20 7/7] net: mtip: Extend the L2 switch driver for imx287 with bridge operations
Date: Mon, 26 Jan 2026 11:34:00 +0100
Message-Id: <20260126103400.1683125-8-lukasz.majewski@mailbox.org>
In-Reply-To: <20260126103400.1683125-1-lukasz.majewski@mailbox.org>
References: <20260126103400.1683125-1-lukasz.majewski@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ngnxusbiw6sj7wm6hk9qbk5wz3hswxrn
X-MBO-RS-ID: 74befb1b19604f122e0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,gmx.net,kernel.org,mailbox.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-253421-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukasz.majewski@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:email,mailbox.org:dkim,mailbox.org:mid,denx.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 864FC871C3
X-Rspamd-Action: no action

After this change the MTIP L2 switch can be configured as offloading
device for packet switching when bridge on its interfaces is created.

Signed-off-by: Lukasz Majewski <lukasz.majewski@mailbox.org>
---

Changes for v13:
- New patch - created by excluding some code from large (i.e. v12 and
  earlier) MTIP driver

Changes for v14 - v15:
- None

Changes for v16:
- Enable MTIP ports to support bridge offloading

Changes for v17 - v20:
- None
---
 .../net/ethernet/freescale/mtipsw/Makefile    |   2 +-
 .../net/ethernet/freescale/mtipsw/mtipl2sw.c  |   9 +-
 .../net/ethernet/freescale/mtipsw/mtipl2sw.h  |   2 +
 .../ethernet/freescale/mtipsw/mtipl2sw_br.c   | 132 ++++++++++++++++++
 4 files changed, 143 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c

diff --git a/drivers/net/ethernet/freescale/mtipsw/Makefile b/drivers/net/ethernet/freescale/mtipsw/Makefile
index a99aaf6ddfb2..81e2b0e03e6c 100644
--- a/drivers/net/ethernet/freescale/mtipsw/Makefile
+++ b/drivers/net/ethernet/freescale/mtipsw/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_FEC_MTIP_L2SW) += nxp-mtipl2sw.o
-nxp-mtipl2sw-objs := mtipl2sw.o mtipl2sw_mgnt.o
+nxp-mtipl2sw-objs := mtipl2sw.o mtipl2sw_mgnt.o mtipl2sw_br.o
diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
index 1a2722a4938b..32cdc3f0bf47 100644
--- a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
+++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
@@ -1922,11 +1922,15 @@ static int mtip_sw_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "Could not alloc IRQ\n");
 
+	ret = mtip_register_notifiers(fep);
+	if (ret)
+		return ret;
+
 	ret = mtip_switch_dma_init(fep);
 	if (ret) {
 		dev_err(&pdev->dev, "%s: ethernet switch init fail (%d)!\n",
 			__func__, ret);
-		return ret;
+		goto unregister_notifiers;
 	}
 
 	ret = mtip_mii_init(fep, pdev);
@@ -1957,6 +1961,8 @@ static int mtip_sw_probe(struct platform_device *pdev)
 			  fep->bd_dma);
 	fep->rx_bd_base = NULL;
 	fep->tx_bd_base = NULL;
+ unregister_notifiers:
+	mtip_unregister_notifiers(fep);
 
 	return ret;
 }
@@ -1965,6 +1971,7 @@ static void mtip_sw_remove(struct platform_device *pdev)
 {
 	struct switch_enet_private *fep = platform_get_drvdata(pdev);
 
+	mtip_unregister_notifiers(fep);
 	mtip_ndev_cleanup(fep);
 
 	mtip_mii_remove(fep);
diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.h b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.h
index 4054415d39f9..449eca41e6b6 100644
--- a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.h
+++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.h
@@ -640,6 +640,8 @@ int mtip_port_learning_config(struct switch_enet_private *fep, int port,
 int mtip_port_blocking_config(struct switch_enet_private *fep, int port,
 			      bool enable);
 bool mtip_is_switch_netdev_port(const struct net_device *ndev);
+int mtip_register_notifiers(struct switch_enet_private *fep);
+void mtip_unregister_notifiers(struct switch_enet_private *fep);
 int mtip_port_enable_config(struct switch_enet_private *fep, int port,
 			    bool tx_en, bool rx_en);
 void mtip_clear_atable(struct switch_enet_private *fep);
diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c
new file mode 100644
index 000000000000..f961b9cc4e6a
--- /dev/null
+++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  L2 switch Controller driver for MTIP block - bridge network interface
+ *
+ *  Copyright (C) 2025 DENX Software Engineering GmbH
+ *  Lukasz Majewski <lukma@denx.de>
+ */
+
+#include <linux/etherdevice.h>
+#include <linux/netdevice.h>
+#include <linux/platform_device.h>
+#include <net/switchdev.h>
+
+#include "mtipl2sw.h"
+
+static int mtip_ndev_port_link(struct net_device *ndev,
+			       struct net_device *br_ndev,
+			       struct netlink_ext_ack *extack)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(ndev), *other_priv;
+	struct switch_enet_private *fep = priv->fep;
+	struct net_device *other_ndev;
+	int err;
+
+	/* Check if one port of MTIP switch is already bridged */
+	if (fep->br_members && !fep->br_offload) {
+		/* Get the second bridge ndev */
+		other_ndev = fep->ndev[fep->br_members - 1];
+		other_priv = netdev_priv(other_ndev);
+		if (other_priv->master_dev != br_ndev) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "L2 offloading only possible for the same bridge!");
+			return notifier_from_errno(-EOPNOTSUPP);
+		}
+
+		fep->br_offload = 1;
+		mtip_switch_dis_port_separation(fep);
+		mtip_clear_atable(fep);
+	}
+
+	if (!priv->master_dev)
+		priv->master_dev = br_ndev;
+
+	fep->br_members |= BIT(priv->portnum - 1);
+
+	err = switchdev_bridge_port_offload(ndev, ndev, NULL, NULL, NULL,
+					    false, extack);
+	if (err) {
+		dev_err(&ndev->dev, "can't offload bridge port %s [err: %d]\n",
+			ndev->name, err);
+		return err;
+	}
+
+	dev_dbg(&ndev->dev,
+		"%s: ndev: %s br: %s fep: %p members: 0x%x offload: %d\n",
+		__func__, ndev->name,  br_ndev->name, fep, fep->br_members,
+		fep->br_offload);
+
+	return NOTIFY_DONE;
+}
+
+static void mtip_netdevice_port_unlink(struct net_device *ndev)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(ndev);
+	struct switch_enet_private *fep = priv->fep;
+
+	dev_dbg(&ndev->dev, "%s: ndev: %s members: 0x%x\n", __func__,
+		ndev->name, fep->br_members);
+
+	switchdev_bridge_port_unoffload(ndev, NULL, NULL, NULL);
+
+	fep->br_members &= ~BIT(priv->portnum - 1);
+	priv->master_dev = NULL;
+
+	if (fep->br_members && fep->br_offload) {
+		fep->br_offload = 0;
+		mtip_switch_en_port_separation(fep);
+		mtip_clear_atable(fep);
+	}
+}
+
+/* netdev notifier */
+static int mtip_netdevice_event(struct notifier_block *unused,
+				unsigned long event, void *ptr)
+{
+	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
+	struct netdev_notifier_changeupper_info *info = ptr;
+	struct netlink_ext_ack *extack;
+	int ret = NOTIFY_DONE;
+
+	if (!mtip_is_switch_netdev_port(ndev))
+		return NOTIFY_DONE;
+
+	extack = netdev_notifier_info_to_extack(&info->info);
+
+	switch (event) {
+	case NETDEV_CHANGEUPPER:
+		if (!netif_is_bridge_master(info->upper_dev))
+			break;
+
+		if (info->linking)
+			ret = mtip_ndev_port_link(ndev, info->upper_dev,
+						  extack);
+		else
+			mtip_netdevice_port_unlink(ndev);
+
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return notifier_from_errno(ret);
+}
+
+static struct notifier_block mtip_netdevice_nb __read_mostly = {
+	.notifier_call = mtip_netdevice_event,
+};
+
+int mtip_register_notifiers(struct switch_enet_private *fep)
+{
+	int ret = register_netdevice_notifier(&mtip_netdevice_nb);
+
+	if (ret)
+		dev_err(&fep->pdev->dev, "can't register netdevice notifier\n");
+
+	return ret;
+}
+
+void mtip_unregister_notifiers(struct switch_enet_private *fep)
+{
+	unregister_netdevice_notifier(&mtip_netdevice_nb);
+}
-- 
2.39.5


