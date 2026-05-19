Return-Path: <netdev+bounces-289345-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEayFQsrDGq0XwUAu9opvQ
	(envelope-from <netdev+bounces-289345-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:19:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FD857B183
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F09731625E6
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6593F871B;
	Tue, 19 May 2026 08:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMPQwQNA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8BF3F54C6;
	Tue, 19 May 2026 08:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779181123; cv=none; b=qSLI1WiRkpwV3sQZKeWu9f6LcSYq/2xXF8xstkxZwibDLsmOSgdaq4R0QKpjJNOt/ILN4kkZSa3I4lraWbGC0+wrlTuzpxt1pbDTWLNsw2EbKYgqH5PY2+c6z5clMT2cOdq7Bl8xv17mcEQPCyhD7O0LSRfSqeKiftpVSLIPm3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779181123; c=relaxed/simple;
	bh=rI/PHZv77t+h2odXKOV+gmTdfhoFgSSrgxe9ykEFQbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=byyFwOQFvJFGRsQbHt6ggqDy8nsl7cm2yCJx9u7+bMWL3eoJffW3LjuttaIkFMycZ6pf5b+vHgpYvSdF5u0CX3ErDM5sMveHn9B1jPD1DiKT3oGMHtn62jZck74jtPgdJyn5FdwswfJI2DK+8AR0GVRbd4ySDMpZLRLcL5dIjYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMPQwQNA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC8DC2BCFC;
	Tue, 19 May 2026 08:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779181123;
	bh=rI/PHZv77t+h2odXKOV+gmTdfhoFgSSrgxe9ykEFQbo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GMPQwQNACOJFNY/GzbxyLyEIiZMqyhYfPm6GLWZPbrrwG67X08Y3YOLqWQRV12wlT
	 HXk5N7D7so2p9bw70HnUiBZr5EkhK09a/lDd3whx4FNJhcHLJrLkQ36sta/fXqBYJ+
	 lEr8Cke2x6uaMKwO/DuUd9c/79wmvaCEoSAk7MtEK23DIpioC+DGRFj+SojoqPvp/8
	 tk3T1pn3Z6Pxd72EW7H0A/AWF3sm7I/MvUQDszGJ1BzebwJk3aF1gewjZf8yKOLjNG
	 fECA9Yuz39db/8kmWBe5qRSck2jrKutRSd0Y97ahZvRcNoCmculzBl1qrk4+K4Ia0w
	 HlG1U0tKIhxfg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 19 May 2026 10:57:52 +0200
Subject: [PATCH net-next v8 09/10] net: airoha: Introduce WAN device flag
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-airoha-eth-multi-serdes-v8-9-6bd70e329df6@kernel.org>
References: <20260519-airoha-eth-multi-serdes-v8-0-6bd70e329df6@kernel.org>
In-Reply-To: <20260519-airoha-eth-multi-serdes-v8-0-6bd70e329df6@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289345-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org,airoha.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[airoha.com:email]
X-Rspamd-Queue-Id: 05FD857B183
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce WAN flag to specify if a given device is used to transmit/receive
WAN or LAN traffic. Current codebase supports specifying LAN/WAN device
configuration in ndo_init() callback during device bootstrap.
In order to consider setups where LAN configuration is used even for
GDM3/GDM4 devices, check airoha_is_lan_gdm_dev() to select pse_port in
airoha_ppe_foe_entry_prepare().
Please note after this patch, it will be possible to specify multiple LAN
devices but just a single WAN one. Please note this change is not visible
to the user since airoha_eth driver currently supports just the internal
phy available via the MT7530 DSA switch and there are no WAN interfaces
officially supported since PCS/external phy is not merged mainline yet
(it will be posted with following patches).

Tested-by: Xuegang Lu <xuegang.lu@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 72 +++++++++++++++++++++++++-------
 drivers/net/ethernet/airoha/airoha_eth.h | 13 +++---
 drivers/net/ethernet/airoha/airoha_ppe.c |  2 +-
 3 files changed, 65 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 15ad5a7edd43..328f94fef2e2 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1895,36 +1895,80 @@ static int airoha_set_gdm2_loopback(struct airoha_gdm_dev *dev)
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
+		/* GDM2 supports a single net_device */
+		if (eth->ports[1] && eth->ports[1]->devs[0])
+			break;
+
+		if (airoha_get_wan_gdm_dev(eth))
+			break;
+
+		fallthrough;
+	}
+	case AIROHA_GDM2_IDX:
+		/* GDM2 is always used as wan */
+		dev->flags |= AIROHA_PRIV_F_WAN;
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
+		if (err)
+			return err;
+	}
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 32633d84f7d2..a2241520f2e2 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -538,6 +538,10 @@ struct airoha_qdma {
 	DECLARE_BITMAP(qos_channel_map, AIROHA_NUM_QOS_CHANNELS);
 };
 
+enum airoha_priv_flags {
+	AIROHA_PRIV_F_WAN = BIT(0),
+};
+
 struct airoha_gdm_dev {
 	struct airoha_gdm_port *port;
 	struct airoha_qdma *qdma;
@@ -549,6 +553,7 @@ struct airoha_gdm_dev {
 	u64 cpu_tx_packets;
 	u64 fwd_tx_packets;
 
+	u32 flags;
 	int nbq;
 };
 
@@ -655,13 +660,7 @@ static inline u16 airoha_qdma_get_txq(struct airoha_qdma *qdma, u16 qid)
 
 static inline bool airoha_is_lan_gdm_dev(struct airoha_gdm_dev *dev)
 {
-	struct airoha_gdm_port *port = dev->port;
-
-	/* GDM1 port on EN7581 SoC is connected to the lan dsa switch.
-	 * GDM{2,3,4} can be used as wan port connected to an external
-	 * phy module.
-	 */
-	return port->id == 1;
+	return !(dev->flags & AIROHA_PRIV_F_WAN);
 }
 
 static inline bool airoha_is_7581(struct airoha_eth *eth)
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index c4086d29d984..194cd50b2c74 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -350,7 +350,7 @@ static int airoha_ppe_foe_entry_prepare(struct airoha_eth *eth,
 				return -EINVAL;
 
 			port = dev->port;
-			if (dsa_port >= 0 || eth->ports[1])
+			if (dsa_port >= 0 || airoha_is_lan_gdm_dev(dev))
 				pse_port = port->id == 4 ? FE_PSE_PORT_GDM4
 							 : port->id;
 			else

-- 
2.54.0


