Return-Path: <netdev+bounces-241503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F36C84B19
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 12:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 86A62350E3D
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 11:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8447A311592;
	Tue, 25 Nov 2025 11:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="MlrsdxcD"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5922B279334;
	Tue, 25 Nov 2025 11:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764069367; cv=none; b=CVVr2N5armJKKIpMZB30U+Pt16soAimOeW4e+5YdVoUIyW8xEChzbTw9qLuv9DYmuTBgghe7s4VzybYxMxh1iVRGJ6k+R7M5cpZToD2WlXUYP0Y8PrdLuLEATyc1J3bz//W8bLvQhGvPxVcdUueCbI0q/iJwRWTpw2rK0UjR+uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764069367; c=relaxed/simple;
	bh=Ip64xUfPHkgew7xpzZ7PNaFPgDrh7O5mRfg0xTeQwTk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tyRnPuLxbwEaGjLzc327+mVpwspdT4bpvPCKuLSfrFgeXTQaao9rrE4J6Zp/QiKV4tjC6bSOqYwD3rvA7pghy0WPFvqzBVF4pPZZU7xY92f0U85WZu0wUGof0HJ/PBemAt6rMCxPZT8e/gbf1wa9aJguj0Kb9jO4K2eR1amxPno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=MlrsdxcD; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id EB686A079F;
	Tue, 25 Nov 2025 12:15:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=Nl3hW5Z6IaAKy/ThA3ZCAbDyqXFPOZPXjA3rXI/HNTg=; b=
	MlrsdxcDLoNPyz5CnjwSwlTF3x/G/d+VZ/tOeNyQ1j5uVYJdUWmJVtDMUm6ICvGI
	Ek/PZ4Suo6tBf5QDTkicm4UkP7R9Lifnuc9/+Ki6VOCts3OpWrogS6Q9fwmGjiG9
	7PblEkpEo1j3LNIsyKUJi/gYQcGL8O7wZ/nBRjtzR3jNgDlpjWyFlB0S7ity6Oao
	HWEHG/VY6erNqT49vS+WlHc1KLVMYhJON06/SdAvcViCbM629RSikB1hJ9x+kktR
	fA6gbCJlzbU+/vXsHVMyanbUN0whPCRSvdPndgcAIBt5OOFT9+h+vxtMLW43+J7H
	YSjA9aaE82owe5f/HRsfS8Lu18XFXDrwkOVBWX4SairtW5U9WGdgvrTj1qLRv1hW
	pkInGGd1amk5L4JU6Y0l4Bo0J8nSq1+kzfqzENbE13iEzx7HXa5CmeDlqWrYaH/N
	yAxprmFq8n+YfEv0vQc+KRoENLv1xaItTOP1KNTs233qIwcK2SD2uG6kC9vDtEjC
	VNtLL8FK0DpIQ/5VcqSGsKmGoc12p7/YnKecRime2K4jePPzufa9EoKmaon+8kLJ
	8LOe3BvWw7OnvIpdFav7D6Z2UoNfW4D3Zpo8Ohux1Fj6TZQ07a8fq32O19nykoEu
	Q+tiQA8fpGFVa/YAwxNgh7hSKG/M34fOGACheZzKCNI=
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>
Subject: [PATCH net-next 1/1] net: mdio: reset PHY before attempting to access ID register
Date: Tue, 25 Nov 2025 12:15:51 +0100
Message-ID: <6cb97b7bfd92d8dc1c1c00662114ece03b6d2913.1764069248.git.buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1764069352;VERSION=8002;MC=174721073;ID=136232;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155F607062

When the ID of an Ethernet PHY is not provided by the 'compatible'
string in the device tree, its actual ID is read via the MDIO bus.
For some PHYs this could be unsafe, since a hard reset may be
necessary to safely access the MDIO registers.

Add a fallback mechanism for such devices: when reading the ID
fails, the reset will be asserted, and the ID read is retried.

This allows such devices to be used with an autodetected ID.

The fallback mechanism is activated in the error handling path, and
the return code of fwnode_mdiobus_register_phy() is unaltered, except
when the reset fails with -EPROBE_DEFER, which is propagated to the
caller.

Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
---
Patch split from a larger series:
https://lore.kernel.org/all/cover.1761732347.git.buday.csaba@prolan.hu/

The refactoring parts of the previous patchset were already merged,
leaving this one. Functionally identical to:
https://lore.kernel.org/all/5f8d93021a7aa6eeb4fb67ab27ddc7de9101c59f.1761732347.git.buday.csaba@prolan.hu/

Comments were added for clarity.
---
 drivers/net/mdio/fwnode_mdio.c | 40 +++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
index ba7091518..c1988cc37 100644
--- a/drivers/net/mdio/fwnode_mdio.c
+++ b/drivers/net/mdio/fwnode_mdio.c
@@ -12,6 +12,7 @@
 #include <linux/of.h>
 #include <linux/phy.h>
 #include <linux/pse-pd/pse.h>
+#include "../phy/mdio-private.h"
 
 MODULE_AUTHOR("Calvin Johnson <calvin.johnson@oss.nxp.com>");
 MODULE_LICENSE("GPL");
@@ -114,6 +115,34 @@ int fwnode_mdiobus_phy_device_register(struct mii_bus *mdio,
 }
 EXPORT_SYMBOL(fwnode_mdiobus_phy_device_register);
 
+/* Hard-reset a PHY before registration */
+static int fwnode_reset_phy(struct mii_bus *bus, u32 addr,
+			    struct fwnode_handle *phy_node)
+{
+	struct mdio_device *tmpdev;
+	int rc;
+
+	/* Create a temporary MDIO device to allocate reset resources */
+	tmpdev = mdio_device_create(bus, addr);
+	if (IS_ERR(tmpdev))
+		return PTR_ERR(tmpdev);
+
+	device_set_node(&tmpdev->dev, fwnode_handle_get(phy_node));
+	rc = mdio_device_register_reset(tmpdev);
+	if (rc) {
+		mdio_device_free(tmpdev);
+		return rc;
+	}
+
+	mdio_device_reset(tmpdev, 1);
+	mdio_device_reset(tmpdev, 0);
+
+	mdio_device_unregister_reset(tmpdev);
+	mdio_device_free(tmpdev);
+
+	return 0;
+}
+
 int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 				struct fwnode_handle *child, u32 addr)
 {
@@ -129,8 +158,17 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 		return PTR_ERR(mii_ts);
 
 	is_c45 = fwnode_device_is_compatible(child, "ethernet-phy-ieee802.3-c45");
-	if (is_c45 || fwnode_get_phy_id(child, &phy_id))
+	if (is_c45 || fwnode_get_phy_id(child, &phy_id)) {
 		phy = get_phy_device(bus, addr, is_c45);
+		if (IS_ERR(phy)) {
+			/* get_phy_device() failed, retry after a reset */
+			rc = fwnode_reset_phy(bus, addr, child);
+			if (rc == -EPROBE_DEFER)
+				goto clean_mii_ts;
+			else if (!rc)
+				phy = get_phy_device(bus, addr, is_c45);
+		}
+	}
 	else
 		phy = phy_device_create(bus, addr, phy_id, 0, NULL);
 	if (IS_ERR(phy)) {

base-commit: e2c20036a8879476c88002730d8a27f4e3c32d4b
-- 
2.39.5



