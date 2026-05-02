Return-Path: <netdev+bounces-283494-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCyLGBuI9mkUWAIAu9opvQ
	(envelope-from <netdev+bounces-283494-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 01:26:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C9B4B3A0B
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 01:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9B983015C94
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 23:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A908430B51A;
	Sat,  2 May 2026 23:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlUO0Em0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7917629BDBF;
	Sat,  2 May 2026 23:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777764337; cv=none; b=SHcljhnqJXLVkZi+fisSdVrWoqwNIAxuXLz17bUGvGb+Ogh+pYhKxRpdLd6bxLDye4+8aBwykhgM/lFpiOyeixj/6dirdD9h2nuThkfxXuOyRRWjXNPWh8AfB1zrt2puf/JkwAafR2/HioNoSNponfY+zTwU5j0tqOz/uLm9EYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777764337; c=relaxed/simple;
	bh=lSp5RtkRrkLS3UnLdEXDQPx8rCZF2JtRoDbFylwnoyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dtn59fi8h71GbkayWM4sgQzAqe4OkeoDyeLoUHIynXCPl4+Qs/cSaf02ePzBbHKjkpjoAYio5Q8Vp1U4Ndh4ReX/M2EqEbc5Fa+fJpKQG0K7eXN5XXk7RhcKcl7I4k/cWTMMvXb43He0sqw2aRZm/NG0sXQlKIdneE0VrKyqDa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BlUO0Em0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35802C4AF0B;
	Sat,  2 May 2026 23:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777764337;
	bh=lSp5RtkRrkLS3UnLdEXDQPx8rCZF2JtRoDbFylwnoyc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BlUO0Em0KNw1bzJAzm/c/teQ9tbDVv1kLunkwvmOOs2dlt0+IMHNLtLG1GovxL4G8
	 ArnSLueJNVE7DLY++hj8qcJQQiWUQAYSpaWa00JADq8kWJb0Iz+PRrmENIHiYJaVlg
	 aUADQfABvbu2OGv/Fn86vkg16r8ajTqvIEoggVczlDQngMu0mBqxpNU0vwitJbrSjV
	 7ZpMyXCrNqjpGcoJ+zxB4yF13c/nzXPcgOwH3/lz/doIWdPOTR5wtqaMrNZ2jC9icT
	 dVjfTbgdxqt35EYVojTmdpsPzqa8FkKC8BgjlfJgsU5mm41XpkhJ9+5+az/P7yvRtU
	 AF1Fbi3CuRk8A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F97CD13DA;
	Sat,  2 May 2026 23:25:37 +0000 (UTC)
From: Ciprian Regus via B4 Relay <devnull+ciprian.regus.analog.com@kernel.org>
Date: Sun, 03 May 2026 02:24:51 +0300
Subject: [PATCH net-next 2/5] net: ethernet: oa_tc6: Allow custom mii_bus
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260503-adin1140-driver-v1-2-dd043cdd88f0@analog.com>
References: <20260503-adin1140-driver-v1-0-dd043cdd88f0@analog.com>
In-Reply-To: <20260503-adin1140-driver-v1-0-dd043cdd88f0@analog.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
 Ciprian Regus <ciprian.regus@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777764335; l=8828;
 i=ciprian.regus@analog.com; s=20260330; h=from:subject:message-id;
 bh=i2IZDXFhSiWWDn9rUet0TbTRwmDcB1jlwrQRqyKLBfM=;
 b=j2nbNGaipLRK/u1xIXBvUubr0GD80MDP1a9NnSREu10kT692oHrykvzN3rnYq+pJuYBraZkAI
 y2b55NeHWy8BxW7NSgrk2Xo51GJRNFWBg3BmmR0Fr/5sNxwD62u6Czu
X-Developer-Key: i=ciprian.regus@analog.com; a=ed25519;
 pk=8WoNhI0kQcQUl8YqJO5ZevROYk9HP8lOIeIgIYgjfbc=
X-Endpoint-Received: by B4 Relay for ciprian.regus@analog.com/20260330 with
 auth_id=703
X-Original-From: Ciprian Regus <ciprian.regus@analog.com>
Reply-To: ciprian.regus@analog.com
X-Rspamd-Queue-Id: 09C9B4B3A0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283494-lists,netdev=lfdr.de,ciprian.regus.analog.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	HAS_REPLYTO(0.00)[ciprian.regus@analog.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,analog.com:email,analog.com:replyto,analog.com:mid]

From: Ciprian Regus <ciprian.regus@analog.com>

Some drivers that use oa_tc6 have to use their own mdio bus access
functions as a workaround for hardware issues. Support these cases by
adding a new parameter for the mii_bus in the oa_tc6_init(). In this
case, drivers are responsible for allocating the mii_bus struct, assign
the bus access methods and free the memory after it's no longer used
by oa_tc6. The mii_bus is registered/unregistered by oa_tc6. The phy
connection process does not change and it's still done by oa_tc6.

Drivers can still choose to use the default mii_bus access functions
implemented by oa_tc6 by passing a NULL reference in the mii_bus param.
To avoid extending the function signature every time a new configuration
option is needed, convert oa_tc6_init() to take a config struct.
Also, update the affected drivers and the oa_tc6 framework documentation.

Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
---
 Documentation/networking/oa-tc6-framework.rst    |  3 +-
 drivers/net/ethernet/microchip/lan865x/lan865x.c |  6 +-
 drivers/net/ethernet/oa_tc6.c                    | 89 +++++++++++++++---------
 include/linux/oa_tc6.h                           |  9 ++-
 4 files changed, 70 insertions(+), 37 deletions(-)

diff --git a/Documentation/networking/oa-tc6-framework.rst b/Documentation/networking/oa-tc6-framework.rst
index fe2aabde923a..eaa5b4b85b34 100644
--- a/Documentation/networking/oa-tc6-framework.rst
+++ b/Documentation/networking/oa-tc6-framework.rst
@@ -453,8 +453,7 @@ Device drivers API
 
 The include/linux/oa_tc6.h defines the following functions:
 
-.. c:function:: struct oa_tc6 *oa_tc6_init(struct spi_device *spi, \
-                                           struct net_device *netdev)
+.. c:function:: struct oa_tc6 *oa_tc6_init(struct oa_tc6_config *config);
 
 Initialize OA TC6 lib.
 
diff --git a/drivers/net/ethernet/microchip/lan865x/lan865x.c b/drivers/net/ethernet/microchip/lan865x/lan865x.c
index 0277d9737369..c509c8a3e321 100644
--- a/drivers/net/ethernet/microchip/lan865x/lan865x.c
+++ b/drivers/net/ethernet/microchip/lan865x/lan865x.c
@@ -332,6 +332,7 @@ static const struct net_device_ops lan865x_netdev_ops = {
 
 static int lan865x_probe(struct spi_device *spi)
 {
+	struct oa_tc6_config tc6_config = {};
 	struct net_device *netdev;
 	struct lan865x_priv *priv;
 	int ret;
@@ -346,7 +347,10 @@ static int lan865x_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, priv);
 	INIT_WORK(&priv->multicast_work, lan865x_multicast_work_handler);
 
-	priv->tc6 = oa_tc6_init(spi, netdev);
+	tc6_config.spi = spi;
+	tc6_config.netdev = netdev;
+
+	priv->tc6 = oa_tc6_init(&tc6_config);
 	if (!priv->tc6) {
 		ret = -ENODEV;
 		goto free_netdev;
diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 546ca652d974..fa89b820133f 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -139,6 +139,7 @@ struct oa_tc6 {
 	bool rx_buf_overflow;
 	bool int_flag;
 	bool prot_ctrl;
+	bool own_mdiobus;
 };
 
 enum oa_tc6_header_type {
@@ -538,32 +539,37 @@ static int oa_tc6_mdiobus_register(struct oa_tc6 *tc6)
 {
 	int ret;
 
-	tc6->mdiobus = mdiobus_alloc();
 	if (!tc6->mdiobus) {
-		netdev_err(tc6->netdev, "MDIO bus alloc failed\n");
-		return -ENOMEM;
+		tc6->mdiobus = mdiobus_alloc();
+		if (!tc6->mdiobus) {
+			netdev_err(tc6->netdev, "MDIO bus alloc failed\n");
+			return -ENOMEM;
+		}
+
+		tc6->mdiobus->read = oa_tc6_mdiobus_read;
+		tc6->mdiobus->write = oa_tc6_mdiobus_write;
+		/* OPEN Alliance 10BASE-T1x compliance MAC-PHYs will have both C22 and
+		 * C45 registers space. If the PHY is discovered via C22 bus protocol it
+		 * assumes it uses C22 protocol and always uses C22 registers indirect
+		 * access to access C45 registers. This is because, we don't have a
+		 * clean separation between C22/C45 register space and C22/C45 MDIO bus
+		 * protocols. Resulting, PHY C45 registers direct access can't be used
+		 * which can save multiple SPI bus access. To support this feature, PHY
+		 * drivers can set .read_mmd/.write_mmd in the PHY driver to call
+		 * .read_c45/.write_c45. Ex: drivers/net/phy/microchip_t1s.c
+		 */
+		tc6->mdiobus->read_c45 = oa_tc6_mdiobus_read_c45;
+		tc6->mdiobus->write_c45 = oa_tc6_mdiobus_write_c45;
+
+		tc6->own_mdiobus = true;
 	}
 
 	tc6->mdiobus->priv = tc6;
-	tc6->mdiobus->read = oa_tc6_mdiobus_read;
-	tc6->mdiobus->write = oa_tc6_mdiobus_write;
-	/* OPEN Alliance 10BASE-T1x compliance MAC-PHYs will have both C22 and
-	 * C45 registers space. If the PHY is discovered via C22 bus protocol it
-	 * assumes it uses C22 protocol and always uses C22 registers indirect
-	 * access to access C45 registers. This is because, we don't have a
-	 * clean separation between C22/C45 register space and C22/C45 MDIO bus
-	 * protocols. Resulting, PHY C45 registers direct access can't be used
-	 * which can save multiple SPI bus access. To support this feature, PHY
-	 * drivers can set .read_mmd/.write_mmd in the PHY driver to call
-	 * .read_c45/.write_c45. Ex: drivers/net/phy/microchip_t1s.c
-	 */
-	tc6->mdiobus->read_c45 = oa_tc6_mdiobus_read_c45;
-	tc6->mdiobus->write_c45 = oa_tc6_mdiobus_write_c45;
-	tc6->mdiobus->name = "oa-tc6-mdiobus";
 	tc6->mdiobus->parent = tc6->dev;
+	tc6->mdiobus->name = "oa-tc6-mdiobus";
 
 	snprintf(tc6->mdiobus->id, ARRAY_SIZE(tc6->mdiobus->id), "%s",
-		 dev_name(&tc6->spi->dev));
+			 dev_name(&tc6->spi->dev));
 
 	ret = mdiobus_register(tc6->mdiobus);
 	if (ret) {
@@ -577,19 +583,30 @@ static int oa_tc6_mdiobus_register(struct oa_tc6 *tc6)
 
 static void oa_tc6_mdiobus_unregister(struct oa_tc6 *tc6)
 {
+	if (!tc6->mdiobus)
+		return;
+
 	mdiobus_unregister(tc6->mdiobus);
-	mdiobus_free(tc6->mdiobus);
+
+	if (tc6->own_mdiobus)
+		mdiobus_free(tc6->mdiobus);
 }
 
 static int oa_tc6_phy_init(struct oa_tc6 *tc6)
 {
 	int ret;
 
-	ret = oa_tc6_check_phy_reg_direct_access_capability(tc6);
-	if (ret) {
-		netdev_err(tc6->netdev,
-			   "Direct PHY register access is not supported by the MAC-PHY\n");
-		return ret;
+	/* If the driver provided a mii_bus, it is also responsible for
+	 * implementing the bus access methods, so we don't have to worry
+	 * about checking the PHY access mode.
+	 */
+	if (!tc6->mdiobus) {
+		ret = oa_tc6_check_phy_reg_direct_access_capability(tc6);
+		if (ret) {
+			netdev_err(tc6->netdev,
+				"Direct PHY register access is not supported by the MAC-PHY\n");
+			return ret;
+		}
 	}
 
 	ret = oa_tc6_mdiobus_register(tc6);
@@ -621,7 +638,9 @@ static int oa_tc6_phy_init(struct oa_tc6 *tc6)
 
 static void oa_tc6_phy_exit(struct oa_tc6 *tc6)
 {
-	phy_disconnect(tc6->phydev);
+	if (tc6->phydev)
+		phy_disconnect(tc6->phydev);
+
 	oa_tc6_mdiobus_unregister(tc6);
 }
 
@@ -1282,24 +1301,28 @@ static int oa_tc6_check_ctrl_protection(struct oa_tc6 *tc6)
 
 /**
  * oa_tc6_init - allocates and initializes oa_tc6 structure.
- * @spi: device with which data will be exchanged.
- * @netdev: network device interface structure.
+ * @config: pointer to a caller-filled structure describing the MACPHY
+ *          (SPI device, net_device, and config flags).
  *
  * Return: pointer reference to the oa_tc6 structure if the MAC-PHY
  * initialization is successful otherwise NULL.
  */
-struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev)
+struct oa_tc6 *oa_tc6_init(struct oa_tc6_config *config)
 {
 	struct oa_tc6 *tc6;
 	int ret;
 
-	tc6 = devm_kzalloc(&spi->dev, sizeof(*tc6), GFP_KERNEL);
+	if (!config)
+		return NULL;
+
+	tc6 = devm_kzalloc(&config->spi->dev, sizeof(*tc6), GFP_KERNEL);
 	if (!tc6)
 		return NULL;
 
-	tc6->spi = spi;
-	tc6->netdev = netdev;
-	SET_NETDEV_DEV(netdev, &spi->dev);
+	tc6->spi = config->spi;
+	tc6->netdev = config->netdev;
+	tc6->mdiobus = config->mii_bus;
+	SET_NETDEV_DEV(tc6->netdev, &tc6->spi->dev);
 	mutex_init(&tc6->spi_ctrl_lock);
 	spin_lock_init(&tc6->tx_skb_lock);
 
diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
index 15f58e3c56c7..7ed7769bac88 100644
--- a/include/linux/oa_tc6.h
+++ b/include/linux/oa_tc6.h
@@ -8,11 +8,18 @@
  */
 
 #include <linux/etherdevice.h>
+#include <linux/mdio.h>
 #include <linux/spi/spi.h>
 
 struct oa_tc6;
 
-struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev);
+struct oa_tc6_config {
+	struct spi_device *spi;
+	struct net_device *netdev;
+	struct mii_bus *mii_bus;
+};
+
+struct oa_tc6 *oa_tc6_init(struct oa_tc6_config *config);
 void oa_tc6_exit(struct oa_tc6 *tc6);
 int oa_tc6_write_register(struct oa_tc6 *tc6, u32 address, u32 value);
 int oa_tc6_write_registers(struct oa_tc6 *tc6, u32 address, u32 value[],

-- 
2.43.0



