Return-Path: <netdev+bounces-241189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46171C81297
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 15:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 373E54E67B4
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 14:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553FC287276;
	Mon, 24 Nov 2025 14:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="RA/GGN4j"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA156284689;
	Mon, 24 Nov 2025 14:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763995856; cv=none; b=KYZ/FNoL7+/Yc8/9SsHQLzNIju2C+NxjHqpu94DBZowGlZBsBBkUFt7XmUS6E/tABD8jx2YZXjgGAJr6zIyH+w/BDUyqTtdjkcUsGAVnAH6kN3tC2op0+WImVjX5NdbPAHtD1ai9EAZ7Ui+0xQMN9h2Vz5HoKQ4tgikvrnwCyGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763995856; c=relaxed/simple;
	bh=dulGugGRb7Lg5kUg+0MCEjiuvfM8BRySjJ2/AiTBjQU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qx3e7NjTf5vH9wGybt8SAt1+PpLEPoCA+M21VjIxwhvbN2i7lW2TdICz6SLKODvAxlPgH8IykVZ8bHMybvGrQYrX8gveOZMefANR7Pg73w9zbSszr+zolrxawS8E9GHoJSv6lBAhJnOZMByIsD4IyBriBiex08gTa0Hu7mXxujk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=RA/GGN4j; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 0728AA0522;
	Mon, 24 Nov 2025 15:50:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=F+B+xoVZY0ALU3op0vdncy2AomMGM19smOzs++ayb6A=; b=
	RA/GGN4jRTseqgpWx5ydFTeu3deZE9OQiC3WJ63ksZ/i+xETfFeJDeC/1n8jyx6H
	zKq3Coitvkt1aR4DiJdx7Y+vlKTSOA3yqq1C4R7qiADlKT2bDzU3Hp6q3En/g+C1
	53ls5nlphkTxTxk9v/Gi0YsGCaQBGdUHyH1BvBd6Z0/y9CahtCTTbqfW1xMvBEzT
	FLk+B8sXrFlDSF6QiNrcZ1W5OUzKm+YYAaJUMikCB0+XQz7s5tdBR0UivLRkBE4/
	kllB7Ma0yy1oJV4gEPU1QhqOApo8JfrHyiBJTQsqgZnCt3HHz5aNqLWEJklrbjSh
	ECQITL8/xPJAlu3QoZ7PQnK7bf/a+iUmbKME3qIZCkqTT0o3bN721TuqC4z/tbtB
	Q2lTUAtnagwRWPvXYN/GgRjwmRlbiIcbtBxd8wjWeWd0PLLjALzfCGsnIOUmU4zq
	MtLxppDzmBlAViO/X2sdFJ2Xp8Ble2HIqjU8fW/eBTVZClYnrXJfNMhuXlwxl8Wj
	SjxMO5I5Oclg6lix2/q6Yev93w895eoA2TpQ8eeAp//JOIBkq7EpOnT0OrpQiqg5
	ANJVu0iDLrfWB/2V8TIsq2NIHVCAL2sEPNEyKmop0OOEW+s5bWw7luWiA0grSKoT
	IiYVixwOeME2oPwVinRMH7+elUJq6cKrP+AXGtY+i6w=
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>
Subject: [PATCH net-next 1/1] net: mdio: remove redundant fwnode cleanup
Date: Mon, 24 Nov 2025 15:50:44 +0100
Message-ID: <00847693daa8f7c8ff5dfa19dd35fc712fa4e2b5.1763995734.git.buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1763995847;VERSION=8002;MC=1654837564;ID=127834;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155F607162

Remove redundant fwnode cleanup in of_mdiobus_register_device()
and xpcs_plat_init_dev().

mdio_device_free() eventually calls mdio_device_release(),
which already performs fwnode_handle_put(), making the manual
cleanup unnecessary.

Combine fwnode_handle_get() with device_set_node() in
of_mdiobus_register_device() for clarity.

Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
---
Previously discussed here:
https://lore.kernel.org/all/c01fc3d0-050e-4ea7-970f-393268430824@lunn.ch/
---
 drivers/net/mdio/of_mdio.c      | 5 +----
 drivers/net/pcs/pcs-xpcs-plat.c | 3 ---
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/mdio/of_mdio.c b/drivers/net/mdio/of_mdio.c
index 1357348e0..b8d298c04 100644
--- a/drivers/net/mdio/of_mdio.c
+++ b/drivers/net/mdio/of_mdio.c
@@ -63,14 +63,11 @@ static int of_mdiobus_register_device(struct mii_bus *mdio,
 	/* Associate the OF node with the device structure so it
 	 * can be looked up later.
 	 */
-	fwnode_handle_get(fwnode);
-	device_set_node(&mdiodev->dev, fwnode);
+	device_set_node(&mdiodev->dev, fwnode_handle_get(fwnode));
 
 	/* All data is now stored in the mdiodev struct; register it. */
 	rc = mdio_device_register(mdiodev);
 	if (rc) {
-		device_set_node(&mdiodev->dev, NULL);
-		fwnode_handle_put(fwnode);
 		mdio_device_free(mdiodev);
 		return rc;
 	}
diff --git a/drivers/net/pcs/pcs-xpcs-plat.c b/drivers/net/pcs/pcs-xpcs-plat.c
index c422e8d8b..b8c48f9ef 100644
--- a/drivers/net/pcs/pcs-xpcs-plat.c
+++ b/drivers/net/pcs/pcs-xpcs-plat.c
@@ -365,9 +365,6 @@ static int xpcs_plat_init_dev(struct dw_xpcs_plat *pxpcs)
 err_clean_data:
 	mdiodev->dev.platform_data = NULL;
 
-	fwnode_handle_put(dev_fwnode(&mdiodev->dev));
-	device_set_node(&mdiodev->dev, NULL);
-
 	mdio_device_free(mdiodev);
 
 	return ret;

base-commit: e2c20036a8879476c88002730d8a27f4e3c32d4b
-- 
2.39.5



