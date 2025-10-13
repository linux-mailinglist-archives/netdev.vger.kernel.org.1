Return-Path: <netdev+bounces-228731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1A2BD3572
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 16:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B3524F257C
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 14:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CA423E32B;
	Mon, 13 Oct 2025 14:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Wywg27j8"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D24239E80;
	Mon, 13 Oct 2025 14:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760364330; cv=none; b=hDIlmmk6N069t976Z77NfJB9mzjgGNlQZPIfWSj+E4To0x8ZwKwiHcf5MfplzGOAslj2uOeBhWQ21MYo3SBKO1OE/rr2mEP/D+MyUtdCB2a1gUODvVSIABvqCoEhxWrZ0Y5ZzKRHxDAofLcub4Mmzpaxs7r3Vb7fhajHjzP3RXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760364330; c=relaxed/simple;
	bh=LKO7a3VvOSd15rGtH6ndJ1/WZUxOlKZK2B+xpDrMDgs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sd5PAXGDYY75KuZJm6+FQ5ZdJM4u99Q/nPmNmVcF2Ko7sG7SjwkfhVEnEJFYN1irYW+D9gBXRUg/RCw1vAf2rrhUkD0iMyNw7IgKdOKpLp2yUPn0ESdPsVdxCq6+ghZz6ka3flgZzaodWz4YZq1M7QHf5hFVVJaTYxQuHb5j8Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Wywg27j8; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 883CAA0D54;
	Mon, 13 Oct 2025 15:56:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=pTPd709va3Cfoo6hjA9X
	2hQaGOUHyvlvphTYLWDhepk=; b=Wywg27j8A9AmVpVK8ld0hm/NChZL6zJ48/FH
	GdJDxG4mmb7NQsmPzLTdVLdYAGn2Aqa1GiGd3l7aN4+08FORzL047gQxrJs4ibGs
	u0Trk8h2zlPZNdchD8IIImV0MBviHufciaXkICvos5uMDPuQSydePe2aFvShLLcr
	Jv+4x8sBUzcJjp0Zl6sN08/A0U1czxQPZshJz8DXzHu34lCXM+1fPsQFX/QYNTLB
	pkp8vpf2jnW6w9D3eB8gRbUTEVREI1n1BcX0LcSSbcpT+7H3k6olqsY1mcAIq5bQ
	QCsi7GAcAECrj50CU0z0y5k/wSM8HgR4ueT99Ni2XIdYXhpGo664z3+eZTfSxWF/
	xcIqwyPxSvIt+sApn1zXz6I8yfzX+4LE3KNGMT+5RPUotu3gUKCTG+tyoEHeiwgD
	S/bokkyRpld940Xnf+k20atFSODS4T8KW3JkkAzLVItvMGKHy31HqZ2w5T7ScYj4
	2LwOS6Qc814j/qbb/vlaDO2J3Q0/vnDXSwAf1otWtlEr1hzr8tzcvwW0B3gnmx2g
	N9lWfWhiypFrBWPFHSngzLrQML4cgct0m4mmwYo/0zfkmkeYJFpgIGiyxXjkdfRE
	8TcJO+JJu+u0Yq/WupxLthjQy2EEd4xzIart+4gmn0TE+1QuR0sniZFzgvy/mWE1
	SZgw2Fs=
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>
Subject: [PATCH 2/2] net: mdio: reset PHY before attempting to access registers in fwnode_mdiobus_register_phy
Date: Mon, 13 Oct 2025 15:55:57 +0200
Message-ID: <20251013135557.62949-2-buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251013135557.62949-1-buday.csaba@prolan.hu>
References: <20251013135557.62949-1-buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1760363764;VERSION=8000;MC=2490145309;ID=514330;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155F657D66

When the ID of an ethernet PHY is not provided by the 'compatible'
string in the device tree, its actual ID is read via the MDIO bus.
For some PHYs this could be unsafe, since a hard reset may be
necessary to safely access the MDIO registers.
This patch makes it possible to hard-reset an ethernet PHY before
attempting to read the ID, via a new device tree property, called:
`reset-phy-before-probe`.

There were previous attempts to implement such functionality, I
tried to collect a few of these (see links).

Link: https://lore.kernel.org/lkml/1499346330-12166-2-git-send-email-richard.leitner@skidata.com/
Link: https://lore.kernel.org/all/20230405-net-next-topic-net-phy-reset-v1-0-7e5329f08002@pengutronix.de/
Link: https://lore.kernel.org/netdev/20250709133222.48802-4-buday.csaba@prolan.hu/
Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
---
 drivers/net/mdio/fwnode_mdio.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
index ba7091518..6f405df98 100644
--- a/drivers/net/mdio/fwnode_mdio.c
+++ b/drivers/net/mdio/fwnode_mdio.c
@@ -114,6 +114,31 @@ int fwnode_mdiobus_phy_device_register(struct mii_bus *mdio,
 }
 EXPORT_SYMBOL(fwnode_mdiobus_phy_device_register);
 
+static int fwnode_reset_phy_before_probe(struct mii_bus *bus, u32 addr,
+					 struct fwnode_handle *phy_node)
+{
+	struct mdio_device *tmpdev;
+	int err;
+
+	tmpdev = mdio_device_create(bus, addr);
+
+	fwnode_handle_get(phy_node);
+	device_set_node(&tmpdev->dev, phy_node);
+	err = mdio_device_register_reset(tmpdev);
+	if (err)
+		return err;
+
+	mdio_device_reset(tmpdev, 1);
+	mdio_device_reset(tmpdev, 0);
+
+	mdio_device_unregister_reset(tmpdev);
+
+	mdio_device_free(tmpdev);
+	fwnode_handle_put(phy_node);
+
+	return 0;
+}
+
 int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 				struct fwnode_handle *child, u32 addr)
 {
@@ -129,8 +154,11 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 		return PTR_ERR(mii_ts);
 
 	is_c45 = fwnode_device_is_compatible(child, "ethernet-phy-ieee802.3-c45");
-	if (is_c45 || fwnode_get_phy_id(child, &phy_id))
+	if (is_c45 || fwnode_get_phy_id(child, &phy_id)) {
+		if (fwnode_property_present(child, "reset-phy-before-probe"))
+			fwnode_reset_phy_before_probe(bus, addr, child);
 		phy = get_phy_device(bus, addr, is_c45);
+	}
 	else
 		phy = phy_device_create(bus, addr, phy_id, 0, NULL);
 	if (IS_ERR(phy)) {
-- 
2.39.5



