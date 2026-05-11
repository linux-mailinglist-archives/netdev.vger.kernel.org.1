Return-Path: <netdev+bounces-286614-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGj0HqK0AWr2igEAu9opvQ
	(envelope-from <netdev+bounces-286614-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:51:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B39D50C3E2
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 73E6C301AA5F
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186183DB64D;
	Mon, 11 May 2026 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ajz9Wkqx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89D83BB9F8;
	Mon, 11 May 2026 10:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778496618; cv=none; b=qU1x3j/cLBQH4Ryst6KGOyq1zWr6UNUQmzz7cSLWOSg+0t8BqlNjD+xFId+x6jYSdKI9xQUf0Cit5TEPgLotXr9XUPQDKccjGp2sq+MkFySu7YkQKzoFkuifahSihj6Bb8uwp6C3IXceEyogISspVbLVRRG3L4MuA6eZw3UY9Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778496618; c=relaxed/simple;
	bh=ZZP7nGJimNWfzZFTltJLxulnLS7JtS0cVx0FFLyhLcA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BaCFBaQGZcDoCoH49aJVQyTiI60rrVCWMGwcZSg/HYqd/G6snEcfnQntFoyydEd2WqfsU3/mHkO6EFpT++s91LYI1YaFnbvjha0ZtUQ3QyjGifeo42+mwRgAaNQsv2PCKEzgMaxAx4/WzMhMdX252CAdAbWkY4ALMEYSw3J1zhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ajz9Wkqx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F5ACC2BCF7;
	Mon, 11 May 2026 10:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778496617;
	bh=ZZP7nGJimNWfzZFTltJLxulnLS7JtS0cVx0FFLyhLcA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ajz9Wkqx/VQKfvMYSMpjvb4Aug9YN8g7qQBGTtCG+5ZSpEZkllv0irIkk0nqm0kD+
	 Y73tVVz8dXdsj/QK94bITRVz0W8kh4N/PC+XsG3ail5zHMvvV1VkJ3PqlmPBQp9x+t
	 9f1JuSkJ5WTZ4wMMZdmXRqiRCSsSO3vZbGJdC8VPJ9IVz1eW/8omTODUatvhwfDBXf
	 a/qhyzhx6q9om6MIyeF+Xz2LDkbuT9rnYI+ek+dXLtBb2Nx0wLsv35vY39KIa9cfas
	 R03aenNjMsJUtBDKKUhpKCGm716FUBt9Rp9FFqVttzSv5GyCIxBaW8DnCRxdMKsPUV
	 Fo/TImkA1UUdg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 11 May 2026 12:49:36 +0200
Subject: [PATCH net-next v6 10/12] net: airoha: Introduce WAN device flag
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-airoha-eth-multi-serdes-v6-10-c899462c4f75@kernel.org>
References: <20260511-airoha-eth-multi-serdes-v6-0-c899462c4f75@kernel.org>
In-Reply-To: <20260511-airoha-eth-multi-serdes-v6-0-c899462c4f75@kernel.org>
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
X-Rspamd-Queue-Id: 5B39D50C3E2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286614-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[airoha.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Introduce WAN flag to specify if a given device is used to transmit/receive
WAN or LAN traffic. Current codebase supports specifying LAN/WAN device
configuration in ndo_init() callback during device bootstrap.
Please note after this patch, it will be possible to specify multiple LAN
devices but just a single WAN one. Please note this change is not visible
to the user since airoha_eth driver currently supports just the internal
phy available via the MT7530 DSA switch and there are no WAN interfaces
officially supported since PCS/external phy is not merged mainline yet
(it will be posted with following patches).

Tested-by: Xuegang Lu <xuegang.lu@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 74 ++++++++++++++++++++++++++------
 drivers/net/ethernet/airoha/airoha_eth.h | 13 +++---
 drivers/net/ethernet/airoha/airoha_ppe.c |  2 +-
 3 files changed, 67 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index aed182c7a5e1..16c0ff9999da 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1885,36 +1885,82 @@ static int airoha_set_gdm2_loopback(struct airoha_gdm_dev *dev)
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
+		if (err) {
+			dev->flags &= ~AIROHA_PRIV_F_WAN;
+			return err;
+		}
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


