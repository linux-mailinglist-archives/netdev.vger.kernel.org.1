Return-Path: <netdev+bounces-275566-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOXrFE+N02nFiwcAu9opvQ
	(envelope-from <netdev+bounces-275566-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 12:39:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4CD3A2E00
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 12:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40BA530474E2
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 10:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1E732D0D8;
	Mon,  6 Apr 2026 10:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2q9s9cz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB98F32C923;
	Mon,  6 Apr 2026 10:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775471720; cv=none; b=lk4KsQM444IISWYQZU0mlMk0TtKIb8AMMIuyXbxveOTQll62WWzdVTBKRK2u0PweVV6jQzuxf3/U7VD5VBtIYhVl8ijHmxJ+c4X/k8364r5fJN57VPKqRQoLV3GeES/0594YSSUziY4aoXljntvoWh7bjNR5A5P0vRnf/YSH0yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775471720; c=relaxed/simple;
	bh=ql5s5IPOxHwoCRZKRGso/EiW5KK05u2mNhk9r4W+5Ao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qDz3XiwZesN9PgNYRsyBsq/3KupvCo5F4vNG7UoJ6y7ginBEqCeCjOo2eTjCOfo1pg+T2S7IAeHHcGtIMGy7lctr8oCJ4/KX2X6rgVeEzD/2QafAJkvgNSi1UrRIWE0k0muZ2cNPE8Duu758A2ipOvqN/vfi17jYYlOwWVahDCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2q9s9cz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49639C4CEF7;
	Mon,  6 Apr 2026 10:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775471719;
	bh=ql5s5IPOxHwoCRZKRGso/EiW5KK05u2mNhk9r4W+5Ao=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=u2q9s9czwFku/NWK86TGvX5WD3fq76hqNjs02Bz9vcSMDg3KTO4eIaUsQrt1qXYsA
	 6LypANxi8U19Q1uLb09nGnzIA5vMu0SsBCebqQa5510OuiIu7IW7co9Mpb1o5weroo
	 DGiqmsJ0G2itWqTlw6QODHNWMxNp3NXvDjDxH/h0ZEY0AdPDHJCA9OtSLCLm24eDZ+
	 UJio6tyEoCqGVtlXKLdk7NiIuodte6Tio/yG9kUDJZF6qUb1p5h2g3zH7qREGoJaRu
	 WMp+PjrzdlvGPgEh08G/DkJNrj1GPp4EYZArSSeBnRnDbcuRZ17dygzV67ykhzkhd4
	 53V5XtWOZGDHg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 06 Apr 2026 12:34:16 +0200
Subject: [PATCH net-next v3 11/12] net: airoha: Introduce WAN device flag
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260406-airoha-eth-multi-serdes-v3-11-ab6ea49d59ff@kernel.org>
References: <20260406-airoha-eth-multi-serdes-v3-0-ab6ea49d59ff@kernel.org>
In-Reply-To: <20260406-airoha-eth-multi-serdes-v3-0-ab6ea49d59ff@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 Benjamin Larsson <benjamin.larsson@genexis.eu>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Xuegang Lu <xuegang.lu@airoha.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275566-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org,airoha.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[airoha.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF4CD3A2E00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce WAN flag to specify if a given device is used to transmit/receive
WAN or LAN traffic. Current codebase supports specifying LAN/WAN device
configuration in ndo_init() callback during device bootstrap.
Please note it is possible to specify multiple LAN devices but just a
single WAN one.

Tested-by: Xuegang Lu <xuegang.lu@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 69 +++++++++++++++++++++++++-------
 drivers/net/ethernet/airoha/airoha_eth.h | 13 +++---
 drivers/net/ethernet/airoha/airoha_ppe.c |  2 +-
 3 files changed, 62 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 5b0cd37b155e..9988011dca53 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1796,36 +1796,77 @@ static int airoha_set_gdm2_loopback(struct airoha_gdm_dev *dev)
 	return 0;
 }
 
-static int airoha_dev_init(struct net_device *netdev)
+static struct airoha_gdm_dev *
+airoha_get_wan_gdm_dev(struct airoha_eth *eth)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
+		struct airoha_gdm_port *port = eth->ports[i];
+		int j;
+
+		if (!port)
+			continue;
+
+		for (j = 0; j < ARRAY_SIZE(port->devs); j++) {
+			struct airoha_gdm_dev *dev = port->devs[j];
+
+			if (dev && !airoha_is_lan_gdm_dev(dev))
+				return dev;
+		}
+	}
+
+	return NULL;
+}
+
+static void airoha_dev_set_qdma(struct airoha_gdm_dev *dev)
 {
-	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_gdm_port *port = dev->port;
 	struct airoha_eth *eth = dev->eth;
 	int i;
 
 	/* QDMA0 is used for lan ports while QDMA1 is used for WAN ports */
 	dev->qdma = &eth->qdma[!airoha_is_lan_gdm_dev(dev)];
 	dev->dev->irq = dev->qdma->irq_banks[0].irq;
-	airoha_set_macaddr(dev, netdev->dev_addr);
+
+	for (i = 0; i < eth->soc->num_ppe; i++)
+		airoha_ppe_set_cpu_port(dev, i, airoha_get_fe_port(dev));
+}
+
+static int airoha_dev_init(struct net_device *netdev)
+{
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_gdm_port *port = dev->port;
 
 	switch (port->id) {
 	case AIROHA_GDM3_IDX:
-	case AIROHA_GDM4_IDX:
-		/* If GDM2 is active we can't enable loopback */
-		if (!eth->ports[1]) {
-			int err;
+	case AIROHA_GDM4_IDX: {
+		struct airoha_eth *eth = dev->eth;
 
-			err = airoha_set_gdm2_loopback(dev);
-			if (err)
-				return err;
-		}
+		if (eth->ports[1] || airoha_get_wan_gdm_dev(eth))
+			break;
+		fallthrough;
+	}
+	case AIROHA_GDM2_IDX:
+		/* GDM2 is always used as wan */
+		dev->flags |= PRIV_FLAG_WAN;
 		break;
 	default:
 		break;
 	}
 
-	for (i = 0; i < eth->soc->num_ppe; i++)
-		airoha_ppe_set_cpu_port(dev, i, airoha_get_fe_port(dev));
+	airoha_dev_set_qdma(dev);
+	airoha_set_macaddr(dev, netdev->dev_addr);
+
+	if (!airoha_is_lan_gdm_dev(dev) &&
+	    (port->id == AIROHA_GDM3_IDX || port->id == AIROHA_GDM4_IDX)) {
+		int err;
+
+		err = airoha_set_gdm2_loopback(dev);
+		if (err) {
+			dev->flags &= ~PRIV_FLAG_WAN;
+			return err;
+		}
+	}
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 3e77bbae630a..8dec25fa0478 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -533,12 +533,17 @@ struct airoha_qdma {
 	struct airoha_queue q_rx[AIROHA_NUM_RX_RING];
 };
 
+enum airoha_priv_flags {
+	PRIV_FLAG_WAN = BIT(0),
+};
+
 struct airoha_gdm_dev {
 	struct airoha_gdm_port *port;
 	struct airoha_qdma *qdma;
 	struct airoha_eth *eth;
 	struct net_device *dev;
 
+	u32 flags;
 	int nbq;
 };
 
@@ -642,13 +647,7 @@ u32 airoha_rmw(void __iomem *base, u32 offset, u32 mask, u32 val);
 
 static inline bool airoha_is_lan_gdm_dev(struct airoha_gdm_dev *dev)
 {
-	struct airoha_gdm_port *port = dev->port;
-
-	/* GDM1 port on EN7581 SoC is connected to the lan dsa switch.
-	 * GDM{2,3,4} can be used as wan port connected to an external
-	 * phy module.
-	 */
-	return port->id == 1;
+	return !(dev->flags & PRIV_FLAG_WAN);
 }
 
 static inline bool airoha_is_7581(struct airoha_eth *eth)
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index a6b188fab053..87bb20b6ee49 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -343,7 +343,7 @@ static int airoha_ppe_foe_entry_prepare(struct airoha_eth *eth,
 				return -EINVAL;
 
 			port = dev->port;
-			if (dsa_port >= 0 || eth->ports[1])
+			if (dsa_port >= 0 || airoha_is_lan_gdm_dev(dev))
 				pse_port = port->id == 4 ? FE_PSE_PORT_GDM4
 							 : port->id;
 			else

-- 
2.53.0


