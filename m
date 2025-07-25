Return-Path: <netdev+bounces-210106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D86B3B121B6
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 18:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3704216F421
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 16:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298892F1FCF;
	Fri, 25 Jul 2025 16:13:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A585F2EF2AA
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460027; cv=none; b=NV5gUNX/ruBYXlybHSZJECG1q/Irz8sGO/nTyEnB6qzYMBewOlT7JuN5IGSVwVPYs+swYGIjhMtDMGcn9tWX9uHRAUPhHECSaocQewPGTTeFpsXu4/qBov8DurS9WKXe7iinzx8p3d1St9qE0W2ppcyd/ycRbBQJu36x109XapA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460027; c=relaxed/simple;
	bh=598beW9lhVgBtD3B6Ont7c64WEbFnsqoUW7hY5PGM6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lOQD/DRHmBnfPZMRh088m6O58iym/3wclAImPwQKFnLRZLSE9UpRWxqfaD9asJxm0KTfjkljX//RXkA5riFBFeob30eefLDrfKqsT0IyHMt2uYHyb5yYCweZH2JkZ9eIfHB1J+VXRe+Z7NG/Web/oyJHsgRokc/3K8b+bdUBmVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufL3F-0006kx-4M
	for netdev@vger.kernel.org; Fri, 25 Jul 2025 18:13:41 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufL3B-00AFd5-0c
	for netdev@vger.kernel.org;
	Fri, 25 Jul 2025 18:13:37 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 975B84498F1
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 16:13:35 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id DDF9944984A;
	Fri, 25 Jul 2025 16:13:31 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 36e1c2a4;
	Fri, 25 Jul 2025 16:13:30 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Jimmy Assarsson <extja@kvaser.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 26/27] can: kvaser_usb: Add devlink port support
Date: Fri, 25 Jul 2025 18:05:36 +0200
Message-ID: <20250725161327.4165174-27-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725161327.4165174-1-mkl@pengutronix.de>
References: <20250725161327.4165174-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

From: Jimmy Assarsson <extja@kvaser.com>

Register each CAN channel of the device as an devlink physical port.
This makes it easier to get device information for a given network
interface (i.e. can2).

Example output:
  $ devlink dev
  usb/1-1.3:1.0

  $ devlink port
  usb/1-1.3:1.0/0: type eth netdev can0 flavour physical port 0 splittable false
  usb/1-1.3:1.0/1: type eth netdev can1 flavour physical port 1 splittable false

  $ devlink port show can1
  usb/1-1.3:1.0/1: type eth netdev can1 flavour physical port 0 splittable false

  $ devlink dev info
  usb/1-1.3:1.0:
    driver kvaser_usb
    serial_number 1020
    versions:
        fixed:
          board.rev 1
          board.id 7330130009653
        running:
          fw 3.22.527

  $ ethtool -i can1
  driver: kvaser_usb
  version: 6.12.10-arch1-1
  firmware-version: 3.22.527
  expansion-rom-version:
  bus-info: 1-1.3:1.0
  supports-statistics: no
  supports-test: no
  supports-eeprom-access: no
  supports-register-dump: no
  supports-priv-flags: no

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Link: https://patch.msgid.link/20250725123452.41-11-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h   |  4 +++
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 15 ++++++++---
 .../can/usb/kvaser_usb/kvaser_usb_devlink.c   | 25 +++++++++++++++++++
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index d5f913ac9b44..46a1b6907a50 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -131,6 +131,7 @@ struct kvaser_usb {
 
 struct kvaser_usb_net_priv {
 	struct can_priv can;
+	struct devlink_port devlink_port;
 	struct can_berr_counter bec;
 
 	/* subdriver-specific data */
@@ -229,6 +230,9 @@ extern const struct kvaser_usb_dev_ops kvaser_usb_leaf_dev_ops;
 
 extern const struct devlink_ops kvaser_usb_devlink_ops;
 
+int kvaser_usb_devlink_port_register(struct kvaser_usb_net_priv *priv);
+void kvaser_usb_devlink_port_unregister(struct kvaser_usb_net_priv *priv);
+
 void kvaser_usb_unlink_tx_urbs(struct kvaser_usb_net_priv *priv);
 
 int kvaser_usb_recv_cmd(const struct kvaser_usb *dev, void *cmd, int len,
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index b9b2e120a5cd..90e77fa0ff4a 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -818,6 +818,7 @@ static void kvaser_usb_remove_interfaces(struct kvaser_usb *dev)
 		if (ops->dev_remove_channel)
 			ops->dev_remove_channel(priv);
 
+		kvaser_usb_devlink_port_unregister(priv);
 		free_candev(priv->netdev);
 	}
 }
@@ -891,20 +892,28 @@ static int kvaser_usb_init_one(struct kvaser_usb *dev, int channel)
 	if (ops->dev_init_channel) {
 		err = ops->dev_init_channel(priv);
 		if (err)
-			goto err;
+			goto candev_free;
+	}
+
+	err = kvaser_usb_devlink_port_register(priv);
+	if (err) {
+		dev_err(&dev->intf->dev, "Failed to register devlink port\n");
+		goto candev_free;
 	}
 
 	err = register_candev(netdev);
 	if (err) {
 		dev_err(&dev->intf->dev, "Failed to register CAN device\n");
-		goto err;
+		goto unregister_devlink_port;
 	}
 
 	netdev_dbg(netdev, "device registered\n");
 
 	return 0;
 
-err:
+unregister_devlink_port:
+	kvaser_usb_devlink_port_unregister(priv);
+candev_free:
 	free_candev(netdev);
 	dev->nets[channel] = NULL;
 	return err;
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c
index aa06bd1fa125..e838b82298ae 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c
@@ -5,6 +5,7 @@
  */
 #include "kvaser_usb.h"
 
+#include <linux/netdevice.h>
 #include <net/devlink.h>
 
 #define KVASER_USB_EAN_MSB 0x00073301
@@ -60,3 +61,27 @@ static int kvaser_usb_devlink_info_get(struct devlink *devlink,
 const struct devlink_ops kvaser_usb_devlink_ops = {
 	.info_get = kvaser_usb_devlink_info_get,
 };
+
+int kvaser_usb_devlink_port_register(struct kvaser_usb_net_priv *priv)
+{
+	int ret;
+	struct devlink_port_attrs attrs = {
+		.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL,
+		.phys.port_number = priv->channel,
+	};
+	devlink_port_attrs_set(&priv->devlink_port, &attrs);
+
+	ret = devlink_port_register(priv_to_devlink(priv->dev),
+				    &priv->devlink_port, priv->channel);
+	if (ret)
+		return ret;
+
+	SET_NETDEV_DEVLINK_PORT(priv->netdev, &priv->devlink_port);
+
+	return 0;
+}
+
+void kvaser_usb_devlink_port_unregister(struct kvaser_usb_net_priv *priv)
+{
+	devlink_port_unregister(&priv->devlink_port);
+}
-- 
2.47.2



