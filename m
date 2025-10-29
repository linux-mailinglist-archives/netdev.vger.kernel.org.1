Return-Path: <netdev+bounces-233873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC28BC19BD2
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 11:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 588333B404E
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 10:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111F3339B3C;
	Wed, 29 Oct 2025 10:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="CnnkWMw9"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1472336EE6;
	Wed, 29 Oct 2025 10:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733438; cv=none; b=HIHNbqOlcKfoPaQoGkCBdEe+JR3j2StN9bkNLmOZV6iH70vC/AfPKyJ0Bf87kBeMV+ot8793BrAtWsypsuWakrvkTZTgEqkU8fnTafmijAnt+FD5Xo7ZfH0ec07GFatEMn10XcX1s3sCnPFc5j6tQBJr2eQ+pGvOzZ4Hvfu8a90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733438; c=relaxed/simple;
	bh=gdDyCJFwXhEzN5BdFc3KdmJ+d9teKB6ElyWgJOpoEnI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BPXxnZWtK/ReY5T0F70/ACJABlP45mgklg1tu7YTDk5GBZpny1AqTjfDXm0m3Oedagk2UkJm2YWu7/4Ff7iMldxkVUH4m3Xpb2MM8br1/LlDj8ek/Iqgr+DW+KwbqvGZpmYlUFQxqrQdP4Ia/pP6QXvRlNGww1ZNxgQJv84p4XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=CnnkWMw9; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 05AACA103D;
	Wed, 29 Oct 2025 11:23:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=WZc19MxEdOgnJCHscmbM
	xcyD19MjLAKNwWL8Njb/7d8=; b=CnnkWMw990cF1ir2vyXC4pHUz3iPpgpXyfbL
	UZMthiHCl0JoX/ahk3X3BWls6Gi0gQzIAme4nz1qBCO1NE00wQhWqa9GKesLvxfh
	RiOfH6lnyvF2ywM2kNTR779+o97kIUwbnqlPQnTI3r6IPpafkMtOSiy3KhamocMP
	wwk8qo9ddab+k3rpxls61+hrEqt8Gk8d95C/H7HDrMCngasguKbpEX6RPCfk4c20
	KM8pntKL/vT01ypy4Jp+qSfwETO8+Xqv7j1hei5TAix/nZi5pUPw5bEmbjWvBd2L
	JwBg5/yM+N54/zK4yBde1y37irNLFklvfGgxAo+G8K5hhPTNfBANpVt8dAg1YyEW
	/dqJ6dGhOT26aKtkB5WXTVAchku8C+nwZqPqlxEISECRIGP4qaG5pu5A/Ji7CkVu
	h2oOb0QISEtsRXym2OlS5PSDfSbPHwrMTn70Ma7IrVrTBJwkPn4MfkjAhTlcGevO
	meLvMH9HY/oUhpIHo4Dkb6bxaDmHIIvIoxDg0jIwYxpNvQPb6yARtxXn9ovVuDL/
	ruINkIo0WNHecZtzdGrmo7qKQq3flXOUBC7aeEfVyxMhr4WtQ2cx0nvwPUWu91VU
	v85TEQyzbtPpYcLQTRPXPjhB7K4eJkZ//f20eBfapYQ6FU/wPh5u0DkaOQ19SzNW
	zgW4jbo=
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>
Subject: [PATCH net-next v5 3/4] net: mdio: reset PHY before attempting to access registers in fwnode_mdiobus_register_phy
Date: Wed, 29 Oct 2025 11:23:43 +0100
Message-ID: <5f8d93021a7aa6eeb4fb67ab27ddc7de9101c59f.1761732347.git.buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1761732347.git.buday.csaba@prolan.hu>
References: <cover.1761732347.git.buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1761733432;VERSION=8000;MC=2688889924;ID=148164;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155F677066

When the ID of an Ethernet PHY is not provided by the 'compatible'
string in the device tree, its actual ID is read via the MDIO bus.
For some PHYs this could be unsafe, since a hard reset may be
necessary to safely access the MDIO registers.

Add a fallback mechanism for these devices: when reading the
ID fails, the reset will be asserted, and the ID read is retried.

Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
---
V4 -> V5:
 - when fwnode_reset_phy() returns with -EPROBE_DEFER, that error
   is now propagated upstream instead of being discarded.
 - info message removed (it will be a separate commit)
 - 'err' variable changed to 'rc' in fwnode_reset_phy()
 - removed last fwnode_handle_put() in fwnode_reset_phy()
   The cleanup is performed by mdio_device_free().
V3 -> V4: dropped DT property `phy-id-read-needs-reset` to control
	  the reset behaviour, asserting reset as a fallback
	  mechanism instead. Added info level message for resetting.
V2 -> V3: kernel-doc replaced with a comment (fixed warning)
V1 -> V2:
 - renamed fwnode_reset_phy_before_probe() to
   fwnode_reset_phy()
 - added kernel-doc for fwnode_reset_phy()
 - improved error handling in fwnode_reset_phy()
---
 drivers/net/mdio/fwnode_mdio.c | 38 +++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
index ba7091518..9669da2b7 100644
--- a/drivers/net/mdio/fwnode_mdio.c
+++ b/drivers/net/mdio/fwnode_mdio.c
@@ -114,6 +114,34 @@ int fwnode_mdiobus_phy_device_register(struct mii_bus *mdio,
 }
 EXPORT_SYMBOL(fwnode_mdiobus_phy_device_register);
 
+/* Hard-reset a PHY before registration */
+static int fwnode_reset_phy(struct mii_bus *bus, u32 addr,
+			    struct fwnode_handle *phy_node)
+{
+	struct mdio_device *tmpdev;
+	int rc;
+
+	tmpdev = mdio_device_create(bus, addr);
+	if (IS_ERR(tmpdev))
+		return PTR_ERR(tmpdev);
+
+	fwnode_handle_get(phy_node);
+	device_set_node(&tmpdev->dev, phy_node);
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
@@ -129,8 +157,16 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 		return PTR_ERR(mii_ts);
 
 	is_c45 = fwnode_device_is_compatible(child, "ethernet-phy-ieee802.3-c45");
-	if (is_c45 || fwnode_get_phy_id(child, &phy_id))
+	if (is_c45 || fwnode_get_phy_id(child, &phy_id)) {
 		phy = get_phy_device(bus, addr, is_c45);
+		if (IS_ERR(phy)) {
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
-- 
2.39.5



