Return-Path: <netdev+bounces-284557-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IGuLFY4+mnHKwMAu9opvQ
	(envelope-from <netdev+bounces-284557-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 20:35:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B32B64D2BE3
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 20:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 89F7230563F3
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 18:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9074BCACE;
	Tue,  5 May 2026 18:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sGqThrMv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD994C6EFE
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 18:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778005670; cv=none; b=A5ssS4DvVSvGYh+hTESwUnl+v4YjiX2ONC1WTGdALk4pFYF368uZOPT6gSMYT3tY4ckzwFIuet0RdX3rHZ7qyrf3p/j/YNLy4Zgm+tzvD+doKRgX6ltEnyBfnHPvi7Poh5ZATE/PKUNOX89GX7mvv/I1ARCYUoVHFjNLA0+aooA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778005670; c=relaxed/simple;
	bh=8TOcBAcHy4ERcrNCANl+/YGMOI+dYHXMFUUcTMQqtHg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aa+PoyLEYGGUHr0sHymAwTdshW8l+smm6JGid4RSVkE2nuNsrrnxoiTWKxXzAj/8sX7J0zIw70sh5fKb6arEmOitGLlv+sehq/tCuAL/Js2ae5spcsKD3rIDNljpQWk4KPqsqNRDO0F5QPuVSC0R0V4qxgcnFeaSNt7lE4cJj8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sGqThrMv; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso42987385e9.3
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 11:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778005666; x=1778610466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pbS3OG+YVDKJuembzs3rrFe7024t5JnNqmdQJp33Wns=;
        b=sGqThrMvZO8as1pf0CTxiTkA1fRHOa9a2Zhqbvt9rQ+JJwiiYTzCDqwEMCs96LRZFg
         UVrEelHz3YviNe/PAhH5grnqZX/R3gjfuHiwI/LFNtiS6f9r1VkOOUqGZl3G0VanN8Qo
         mILxCi2hwSZyc8sisvW/W21f/CPWv8crLMlZ3aeuxJYWlUKcXyFcC4d2e0gt3b1sl7y5
         EHbIt6LyHZBryjyqkwUSwrP7XW5df7amWRUeN74qyLQWMeVrXv+TOUTG3ssRYp+Iws+p
         3hn8g42KK+eT5VurSjzv8HILubbFf9WwljlLauaeNSsM+zS4LwxTFWW8PDu6U0ePlU8P
         8T3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778005666; x=1778610466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pbS3OG+YVDKJuembzs3rrFe7024t5JnNqmdQJp33Wns=;
        b=I3zfh0RvIj4oiYBi8Xcmcc/alP+zNLB0HbdLJeX5ZbnzLW3Od6AJ5y8ND1dmB/CSI6
         wmnwpiXFt36VttB9XDWmjA+qE4mHxo37EDrgY7lLrrE3u5/PdKPgWVGXbsrfNl1IcsON
         UAJui+TclMUr5syvwGG9rhTsYrdrk4GdUhWOKnbsKvxz6jhR12svw784klvBmIedAXdt
         AwsCEcT22+eISpmfjP9sb71wC75J0dh1A+cHSem/HuFm/xeNbmqYT/6F8um0E4r4M5uf
         a45e3pxNoRq++L1/zRrAe0j0fym170tMFIS2aciPs89AmLvx6+spOc9hiWZUEVKw01fb
         UfgA==
X-Forwarded-Encrypted: i=1; AFNElJ8/kB0HcFR92IJYLRFNSUIi2VhAOsWbi8tVKZXQ+6/l2iZsCPQNafQRhpW09py53VLzvtge3lg=@vger.kernel.org
X-Gm-Message-State: AOJu0YypIqJYDA8DJVBI4dYJUORYnMs5ibgx79qejjJba4kewb2F385k
	sV8JtnbK/bYfEZbpgX7LKKZSkRuIj3E8nWLvfsQjlh0QL3Abv5hCgOfJ
X-Gm-Gg: AeBDieuCf9MdcALQmxCgk105XWyMa56jOh5eDRdH7V0Nm9ovIAWPwrDeJf2yDu5kjwJ
	lc1M+ek+4rWZL4naRDc0hMIburYsLhrqv9q6Jq+5L2bWkkt+78m8QeCIHjKdHZ4so1MaV0MoKmJ
	UFrMsg+o3L4mwrISaqOBBOnTkCSrDQWKbaWr8qoSgpL1QeTJbjtaD3EwCuiqHTET6jFykoOaKvp
	zYF1AoU/LoatvDJnZEghWYZcISNbA0Sc3i5VgD116z2iAZ/kEM2Jfg0UPgt2Db3r7uj9utSF03/
	2TYkjFv6+55aMGchj/sOR7gC1AhqSfGT76cjvmqQ4YmZhtVUKnv+CjZMhxZdhLmadnHwRz4dmtj
	17WuDafsfVnEoSn5f5X8qSp04CYYSxDiDCT1zFUWA+njt95H+KxyqsvLq7OeW6AzeLr0yLRMHgp
	aoIhPgohx77iUt+FaABNHJCvRtf/7qYXhYMokb+A98RrMQAJiuOJEuLZ1CiUDKQDdtwFFkAIKCT
	qEhB2g=
X-Received: by 2002:a05:600c:34ca:b0:489:1f08:91b with SMTP id 5b1f17b1804b1-48e521e6085mr3516555e9.16.1778005665680;
        Tue, 05 May 2026 11:27:45 -0700 (PDT)
Received: from Ansuel-XPS24 (host-82-59-227-65.retail.telecomitalia.it. [82.59.227.65])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48a820c865esm408208245e9.5.2026.05.05.11.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 11:27:45 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [net-next RFC PATCH v5 10/10] net: airoha: add phylink support for GDM2/3/4
Date: Tue,  5 May 2026 20:27:11 +0200
Message-ID: <20260505182713.27644-11-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505182713.27644-1-ansuelsmth@gmail.com>
References: <20260505182713.27644-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B32B64D2BE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-284557-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,pengutronix.de,makrotopia.org,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt,lkml];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Add phylink support for GDM2/3/4 port that require configuration of the
PCS to make the external PHY or attached SFP cage work.

These needs to be defined in the GDM port node using the pcs-handle
property.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/ethernet/airoha/Kconfig       |   1 +
 drivers/net/ethernet/airoha/airoha_eth.c  | 144 +++++++++++++++++++++-
 drivers/net/ethernet/airoha/airoha_eth.h  |   3 +
 drivers/net/ethernet/airoha/airoha_regs.h |  12 ++
 4 files changed, 159 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/Kconfig b/drivers/net/ethernet/airoha/Kconfig
index ad3ce501e7a5..38dcc76e5998 100644
--- a/drivers/net/ethernet/airoha/Kconfig
+++ b/drivers/net/ethernet/airoha/Kconfig
@@ -20,6 +20,7 @@ config NET_AIROHA
 	depends on NET_DSA || !NET_DSA
 	select NET_AIROHA_NPU
 	select PAGE_POOL
+	select PHYLINK
 	help
 	  This driver supports the gigabit ethernet MACs in the
 	  Airoha SoC family.
diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 2bd79da70934..ad0328a25422 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -8,6 +8,7 @@
 #include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/tcp.h>
+#include <linux/pcs/pcs.h>
 #include <linux/u64_stats_sync.h>
 #include <net/dst_metadata.h>
 #include <net/page_pool/helpers.h>
@@ -71,6 +72,11 @@ static void airoha_qdma_irq_disable(struct airoha_irq_bank *irq_bank,
 	airoha_qdma_set_irqmask(irq_bank, index, mask, 0);
 }
 
+static bool airhoa_is_phy_external(struct airoha_gdm_port *port)
+{
+	return port->id != 1;
+}
+
 static void airoha_set_macaddr(struct airoha_gdm_port *port, const u8 *addr)
 {
 	struct airoha_eth *eth = port->qdma->eth;
@@ -1644,6 +1650,17 @@ static int airoha_dev_open(struct net_device *dev)
 	struct airoha_qdma *qdma = port->qdma;
 	u32 pse_port = FE_PSE_PORT_PPE1;
 
+	if (airhoa_is_phy_external(port)) {
+		err = phylink_of_phy_connect(port->phylink, dev->dev.of_node, 0);
+		if (err) {
+			netdev_err(dev, "%s: could not attach PHY: %d\n", __func__,
+				   err);
+			return err;
+		}
+
+		phylink_start(port->phylink);
+	}
+
 	netif_tx_start_all_queues(dev);
 	err = airoha_set_vip_for_gdm_port(port, true);
 	if (err)
@@ -1707,6 +1724,11 @@ static int airoha_dev_stop(struct net_device *dev)
 		}
 	}
 
+	if (airhoa_is_phy_external(port)) {
+		phylink_stop(port->phylink);
+		phylink_disconnect_phy(port->phylink);
+	}
+
 	return 0;
 }
 
@@ -2883,6 +2905,115 @@ bool airoha_is_valid_gdm_port(struct airoha_eth *eth,
 	return false;
 }
 
+static void airoha_mac_link_up(struct phylink_config *config, struct phy_device *phy,
+			       unsigned int mode, phy_interface_t interface,
+			       int speed, int duplex, bool tx_pause, bool rx_pause)
+{
+	struct airoha_gdm_port *port = container_of(config, struct airoha_gdm_port,
+						    phylink_config);
+	struct airoha_qdma *qdma = port->qdma;
+	struct airoha_eth *eth = qdma->eth;
+	u32 frag_size_tx, frag_size_rx;
+
+	if (port->id != 4)
+		return;
+
+	switch (speed) {
+	case SPEED_10000:
+	case SPEED_5000:
+		frag_size_tx = 8;
+		frag_size_rx = 8;
+		break;
+	case SPEED_2500:
+		frag_size_tx = 2;
+		frag_size_rx = 1;
+		break;
+	default:
+		frag_size_tx = 1;
+		frag_size_rx = 0;
+	}
+
+	/* Configure TX/RX frag based on speed */
+	airoha_fe_rmw(eth, REG_GDMA4_TMBI_FRAG,
+		      GDMA4_SGMII0_TX_FRAG_SIZE_MASK,
+		      FIELD_PREP(GDMA4_SGMII0_TX_FRAG_SIZE_MASK,
+				 frag_size_tx));
+
+	airoha_fe_rmw(eth, REG_GDMA4_RMBI_FRAG,
+		      GDMA4_SGMII0_RX_FRAG_SIZE_MASK,
+		      FIELD_PREP(GDMA4_SGMII0_RX_FRAG_SIZE_MASK,
+				 frag_size_rx));
+}
+
+static const struct phylink_mac_ops airoha_phylink_ops = {
+	.mac_link_up = airoha_mac_link_up,
+};
+
+static int airoha_setup_phylink(struct net_device *dev)
+{
+	struct airoha_gdm_port *port = netdev_priv(dev);
+	struct device_node *np = dev->dev.of_node;
+	struct phylink_pcs **available_pcs;
+	phy_interface_t phy_mode;
+	struct phylink *phylink;
+	unsigned int num_pcs;
+	int err;
+
+	err = of_get_phy_mode(np, &phy_mode);
+	if (err) {
+		dev_err(&dev->dev, "incorrect phy-mode\n");
+		return err;
+	}
+
+	port->phylink_config.dev = &dev->dev;
+	port->phylink_config.type = PHYLINK_NETDEV;
+	port->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+						MAC_10 | MAC_100 | MAC_1000 | MAC_2500FD |
+						MAC_5000FD | MAC_10000FD;
+
+	err = fwnode_phylink_pcs_parse(dev_fwnode(&dev->dev), NULL, &num_pcs);
+	if (err)
+		return err;
+
+	available_pcs = kcalloc(num_pcs, sizeof(*available_pcs), GFP_KERNEL);
+	if (!available_pcs)
+		return -ENOMEM;
+
+	err = fwnode_phylink_pcs_parse(dev_fwnode(&dev->dev), available_pcs,
+				       &num_pcs);
+	if (err)
+		goto out;
+
+	port->phylink_config.available_pcs = available_pcs;
+	port->phylink_config.num_available_pcs = num_pcs;
+
+	__set_bit(PHY_INTERFACE_MODE_SGMII,
+		  port->phylink_config.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_1000BASEX,
+		  port->phylink_config.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_2500BASEX,
+		  port->phylink_config.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_USXGMII,
+		  port->phylink_config.supported_interfaces);
+
+	phy_interface_copy(port->phylink_config.pcs_interfaces,
+			   port->phylink_config.supported_interfaces);
+
+	phylink = phylink_create(&port->phylink_config,
+				 of_fwnode_handle(np),
+				 phy_mode, &airoha_phylink_ops);
+	if (IS_ERR(phylink)) {
+		err = PTR_ERR(phylink);
+		goto out;
+	}
+
+	port->phylink = phylink;
+out:
+	kfree(available_pcs);
+
+	return err;
+}
+
 static int airoha_alloc_gdm_port(struct airoha_eth *eth,
 				 struct device_node *np)
 {
@@ -2954,6 +3085,12 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
 	port->id = id;
 	eth->ports[p] = port;
 
+	if (airhoa_is_phy_external(port)) {
+		err = airoha_setup_phylink(dev);
+		if (err)
+			return err;
+	}
+
 	return airoha_metadata_dst_alloc(port);
 }
 
@@ -3081,8 +3218,11 @@ static int airoha_probe(struct platform_device *pdev)
 		if (!port)
 			continue;
 
-		if (port->dev->reg_state == NETREG_REGISTERED)
+		if (port->dev->reg_state == NETREG_REGISTERED) {
+			if (airhoa_is_phy_external(port))
+				phylink_destroy(port->phylink);
 			unregister_netdev(port->dev);
+		}
 		airoha_metadata_dst_free(port);
 	}
 	airoha_hw_cleanup(eth);
@@ -3107,6 +3247,8 @@ static void airoha_remove(struct platform_device *pdev)
 		if (!port)
 			continue;
 
+		if (airhoa_is_phy_external(port))
+			phylink_destroy(port->phylink);
 		unregister_netdev(port->dev);
 		airoha_metadata_dst_free(port);
 	}
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index af29fc74165b..e5c70f1fa4f1 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -538,6 +538,9 @@ struct airoha_gdm_port {
 	struct net_device *dev;
 	int id;
 
+	struct phylink *phylink;
+	struct phylink_config phylink_config;
+
 	struct airoha_hw_stats stats;
 
 	DECLARE_BITMAP(qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS);
diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethernet/airoha/airoha_regs.h
index 436f3c8779c1..27f2583e143a 100644
--- a/drivers/net/ethernet/airoha/airoha_regs.h
+++ b/drivers/net/ethernet/airoha/airoha_regs.h
@@ -358,6 +358,18 @@
 #define IP_FRAGMENT_PORT_MASK		GENMASK(8, 5)
 #define IP_FRAGMENT_NBQ_MASK		GENMASK(4, 0)
 
+#define REG_GDMA4_TMBI_FRAG		0x2028
+#define GDMA4_SGMII1_TX_WEIGHT_MASK	GENMASK(31, 26)
+#define GDMA4_SGMII1_TX_FRAG_SIZE_MASK	GENMASK(25, 16)
+#define GDMA4_SGMII0_TX_WEIGHT_MASK	GENMASK(15, 10)
+#define GDMA4_SGMII0_TX_FRAG_SIZE_MASK	GENMASK(9, 0)
+
+#define REG_GDMA4_RMBI_FRAG		0x202c
+#define GDMA4_SGMII1_RX_WEIGHT_MASK	GENMASK(31, 26)
+#define GDMA4_SGMII1_RX_FRAG_SIZE_MASK	GENMASK(25, 16)
+#define GDMA4_SGMII0_RX_WEIGHT_MASK	GENMASK(15, 10)
+#define GDMA4_SGMII0_RX_FRAG_SIZE_MASK	GENMASK(9, 0)
+
 #define REG_MC_VLAN_EN			0x2100
 #define MC_VLAN_EN_MASK			BIT(0)
 
-- 
2.53.0


