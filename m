Return-Path: <netdev+bounces-239566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FB1C69C89
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 15:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 68ECF2BD4B
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 14:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE2735A94F;
	Tue, 18 Nov 2025 13:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="XeIM/Umv"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32EB35503F;
	Tue, 18 Nov 2025 13:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763474352; cv=none; b=JvflSLNVDdKbBGLzbRJldgLdbxHLf7hNHe3lutPJqw72xCEHcwf8M/Cw2xfsl8JvSFiAWBOCs8vRiFDQSLDjb4ymEsmpsH8eK3srtiwi7rcnak3DW+d2JCEG2j723DYsH+x4DOQxJb0raMeZqoJh18Ycm89cZ2+Mud5xArOkUwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763474352; c=relaxed/simple;
	bh=Ma7HQDyMOsSkortRll35FHiQPSK80dtQ4ppaAjNf5Rk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LU4Q3js6BK+aP/Hq8irj1TkfZ2Ud9gBMQ3JoNpFE3PfMendonasAv9dM2rF57hbAqPnZDa3YG9yIuB+/5GsoNf4Q8a9x7HKCUi3jsU5YnNIPTnnhkVaIynFk1S+vK4cSPD4IQOk4PIfLWMC5y7xtfRnkRuu5Pl48q0j/FJKdwYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=XeIM/Umv; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 1A029A13FD;
	Tue, 18 Nov 2025 14:58:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=lVWbjU6OZMZKSfpBWgnJ
	aHrHugrOdzvPNNE0axpkUrU=; b=XeIM/UmvDcHivrZTyWMvlynxn99Kk3q1Xmin
	2tnNhfpQXBsZ/i5ApJLkJPGnb9IKemwX0sKCqBm+ONPB7aj0o/yv6w7ngbOHnuM0
	A/AkhK4ohOoXdFdn5tpx72iXnWEfoBI8BfUOQGRNL7TYVMJGanfr6Bo3oZ6g0pj4
	6JTuPJFO4dgefcTOBnjiU9JvB3pqsxSF9QW3dNj3byeXr7y+pz303lP+afv3tcGc
	DOUKefuHsawL7+QGa3cIDS78wBABPmvecg4kWvwMFeKX19yCVB3ANbrYxgnDZLyj
	ARP1bn3EH0fNgBVcSFha0AALQsxR7hnBLeWUkP03pSGZyi1wn6YoEh4R8n49tMiQ
	41Mp3TB3tXs0jQfHppoHGiQHgq78JbtEjc2rVwNGGSDKIQgkvbN94OLdKV5t35t8
	p0GuNfPvDC2I4X1HiBYyF/NT8zMJPhesbJQ/G27hS4CMO98CePsWiJBOai2f27cx
	1bug+Wy4sAxLznG8fYwXerLYz5wfuSwUqYLFx2JEEGXTBc1CKbYv3C0R6Zqf1Z3C
	VPpYqm8RcGfC4Cmx+fe1TAwCAnSYNfC9P2h8/YNeZON2Y8gVST8Jv7XByD0+rdOM
	8rZgvrrH7b94327swcJuOIdxTWBgGCgwayNBGsUmOCROacCZhyBNle7i3E4ctxZW
	EovMa1g=
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>
Subject: [PATCH net-next v3 1/3] net: mdio: move device reset functions to mdio_device.c
Date: Tue, 18 Nov 2025 14:58:52 +0100
Message-ID: <5f684838ee897130f21b21beb07695eea4af8988.1763473655.git.buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1763473655.git.buday.csaba@prolan.hu>
References: <cover.1763473655.git.buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1763474337;VERSION=8002;MC=2836567782;ID=69549;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2998FD515F617266

The functions mdiobus_register_gpiod() and mdiobus_register_reset()
handle the mdio device reset initialization, which belong to
mdio_device.c.
Move them from mdio_bus.c to mdio_device.c, and rename them to match
the corresponding source file: mdio_device_register_gpio() and
mdio_device_register_reset().
Remove 'static' qualifiers and declare them in
drivers/net/phy/mdio-private.h (new header file).

Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
---
V2 -> V3: removed declarations from include/linux/mdio.h to
	  drivers/net/phy/mdio-private.h on maintainer request.
V1 -> V2: rebase, no changes
---
 drivers/net/phy/mdio-private.h | 11 +++++++++++
 drivers/net/phy/mdio_bus.c     | 32 +++-----------------------------
 drivers/net/phy/mdio_device.c  | 28 ++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 29 deletions(-)
 create mode 100644 drivers/net/phy/mdio-private.h

diff --git a/drivers/net/phy/mdio-private.h b/drivers/net/phy/mdio-private.h
new file mode 100644
index 000000000..44e2e0907
--- /dev/null
+++ b/drivers/net/phy/mdio-private.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef __MDIO_PRIVATE_H
+#define __MDIO_PRIVATE_H
+
+/* MDIO internal helpers
+ */
+
+int mdio_device_register_reset(struct mdio_device *mdiodev);
+int mdio_device_register_gpiod(struct mdio_device *mdiodev);
+
+#endif /* __MDIO_PRIVATE_H */
diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 435424113..575b8bb5b 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -29,37 +29,11 @@
 #include <linux/string.h>
 #include <linux/uaccess.h>
 #include <linux/unistd.h>
+#include "mdio-private.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/mdio.h>
 
-static int mdiobus_register_gpiod(struct mdio_device *mdiodev)
-{
-	/* Deassert the optional reset signal */
-	mdiodev->reset_gpio = gpiod_get_optional(&mdiodev->dev,
-						 "reset", GPIOD_OUT_LOW);
-	if (IS_ERR(mdiodev->reset_gpio))
-		return PTR_ERR(mdiodev->reset_gpio);
-
-	if (mdiodev->reset_gpio)
-		gpiod_set_consumer_name(mdiodev->reset_gpio, "PHY reset");
-
-	return 0;
-}
-
-static int mdiobus_register_reset(struct mdio_device *mdiodev)
-{
-	struct reset_control *reset;
-
-	reset = reset_control_get_optional_exclusive(&mdiodev->dev, "phy");
-	if (IS_ERR(reset))
-		return PTR_ERR(reset);
-
-	mdiodev->reset_ctrl = reset;
-
-	return 0;
-}
-
 int mdiobus_register_device(struct mdio_device *mdiodev)
 {
 	int err;
@@ -68,11 +42,11 @@ int mdiobus_register_device(struct mdio_device *mdiodev)
 		return -EBUSY;
 
 	if (mdiodev->flags & MDIO_DEVICE_FLAG_PHY) {
-		err = mdiobus_register_gpiod(mdiodev);
+		err = mdio_device_register_gpiod(mdiodev);
 		if (err)
 			return err;
 
-		err = mdiobus_register_reset(mdiodev);
+		err = mdio_device_register_reset(mdiodev);
 		if (err) {
 			gpiod_put(mdiodev->reset_gpio);
 			mdiodev->reset_gpio = NULL;
diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device.c
index f64176e0e..0e04bddd3 100644
--- a/drivers/net/phy/mdio_device.c
+++ b/drivers/net/phy/mdio_device.c
@@ -22,6 +22,7 @@
 #include <linux/string.h>
 #include <linux/unistd.h>
 #include <linux/property.h>
+#include "mdio-private.h"
 
 void mdio_device_free(struct mdio_device *mdiodev)
 {
@@ -118,6 +119,33 @@ void mdio_device_remove(struct mdio_device *mdiodev)
 }
 EXPORT_SYMBOL(mdio_device_remove);
 
+int mdio_device_register_gpiod(struct mdio_device *mdiodev)
+{
+	/* Deassert the optional reset signal */
+	mdiodev->reset_gpio = gpiod_get_optional(&mdiodev->dev,
+						 "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(mdiodev->reset_gpio))
+		return PTR_ERR(mdiodev->reset_gpio);
+
+	if (mdiodev->reset_gpio)
+		gpiod_set_consumer_name(mdiodev->reset_gpio, "PHY reset");
+
+	return 0;
+}
+
+int mdio_device_register_reset(struct mdio_device *mdiodev)
+{
+	struct reset_control *reset;
+
+	reset = reset_control_get_optional_exclusive(&mdiodev->dev, "phy");
+	if (IS_ERR(reset))
+		return PTR_ERR(reset);
+
+	mdiodev->reset_ctrl = reset;
+
+	return 0;
+}
+
 void mdio_device_reset(struct mdio_device *mdiodev, int value)
 {
 	unsigned int d;
-- 
2.39.5



