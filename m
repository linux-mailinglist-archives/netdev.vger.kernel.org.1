Return-Path: <netdev+bounces-288589-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Of3HXEHCGqVVgMAu9opvQ
	(envelope-from <netdev+bounces-288589-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 07:58:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB7155A632
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 07:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C612B3008D01
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 05:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4E435A395;
	Sat, 16 May 2026 05:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5dRy+mt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2928C175A7B;
	Sat, 16 May 2026 05:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778911075; cv=none; b=U4ti+p4ltTpvZ+F/mRSjIkRTV0hjXmhrBr0aFxdM8kRuQ+I9xi5tAw9zcQeySj2wn4RROpii52fz6GXpCqEB3zIfJtktP4rci/SE/2FpX02Y4Tm7d5XKmykUkD17JZvueaOLuK2ASd5jLwuNBdk5l6pYPhO/Ct/CnfCTEqsRIqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778911075; c=relaxed/simple;
	bh=TXblOyw4xqTUZlj938ntGPUamqR6+B49eQEtuY69Iu8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EnWOgGg6wvllCFe7LbcojhXV8EsUtqGK+dvsc0I7AL9aunBxFrqghQv3a4SPHuAn/0YnVsIQkab0UctgbBoKphGRuYGoi3ssr+8zLKctOLJOjkv0u5Eph2v59ONvNUayIedrCeUQ4WMN17c8sAQICM0kcMK4ir08YXlvKyyHfSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5dRy+mt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C15C2BCB7;
	Sat, 16 May 2026 05:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778911074;
	bh=TXblOyw4xqTUZlj938ntGPUamqR6+B49eQEtuY69Iu8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=D5dRy+mt+MrpEqdrOPhMZFtPAs/klM6nmCFzj7PqTmBLirOel76jS/jKDKyUzFhpa
	 PRKK+lcbIY/Sp95YMIah7ietSYEK2XUx3h7trZqL2hH/N/dFY/3M3hZUTQl7EsNDis
	 euQnD7wTuUr8rjaRIFged+Sps2bbpJCh9E2aHH3GDhbBGFdcHuIBjHJuYNJU40plFz
	 aiXRZhZcwufNS2c/stNee71g3lDc+KeZBIbwr0ytODJDWiPZCijGFhEw1WCzsV2k52
	 9dj37T3JpQDr/MTDZLoujtlvdvjMZ933/kmK8e0910Q+9zrUOUN6G8k2FbW5qsAOYK
	 8PNTOpsGFjw4w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 16 May 2026 07:57:12 +0200
Subject: [PATCH net-next v7 10/10] net: airoha: Support multiple LAN/WAN
 interfaces for hw MAC address configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-airoha-eth-multi-serdes-v7-10-99e0093303e2@kernel.org>
References: <20260516-airoha-eth-multi-serdes-v7-0-99e0093303e2@kernel.org>
In-Reply-To: <20260516-airoha-eth-multi-serdes-v7-0-99e0093303e2@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 Benjamin Larsson <benjamin.larsson@genexis.eu>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Madhur Agrawal <madhur.agrawal@airoha.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 9BB7155A632
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288589-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org,airoha.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,airoha.com:email]
X-Rspamd-Action: no action

The EN7581 and AN7583 SoCs provide registers to configure hardware LAN/WAN
MAC addresses, used to determine whether received traffic is destined for
this host or should be forwarded to another device.
The SoC hardware design assumes all interfaces configured as LAN (or WAN)
share a common upper MAC address, which is programmed into the
REG_FE_{LAN,WAN}_MAC_H register. The lower bytes of 'local' addresses can
be expressed as a range via the REG_FE_MAC_LMIN and REG_FE_MAC_LMAX
registers.
Previously, only a single interface was considered when programming these
registers. Extend the logic to derive the correct minimum and maximum
values for REG_FE_MAC_LMIN/REG_FE_MAC_LMAX when two or more interfaces are
configured as LAN or WAN.

Tested-by: Madhur Agrawal <madhur.agrawal@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 77 +++++++++++++++++++++++++++-----
 drivers/net/ethernet/airoha/airoha_eth.h |  2 +-
 drivers/net/ethernet/airoha/airoha_ppe.c |  4 +-
 3 files changed, 68 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 0540a73b2997..4e9843acc714 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -71,20 +71,69 @@ static void airoha_qdma_irq_disable(struct airoha_irq_bank *irq_bank,
 	airoha_qdma_set_irqmask(irq_bank, index, mask, 0);
 }
 
-static void airoha_set_macaddr(struct airoha_gdm_dev *dev, const u8 *addr)
+static int airoha_set_macaddr(struct airoha_gdm_dev *dev, const u8 *addr)
 {
+	u8 ref_addr[ETH_ALEN] __aligned(2);
 	struct airoha_eth *eth = dev->eth;
-	u32 val, reg;
+	u32 reg, val, lmin, lmax;
+	int i;
+
+	eth_zero_addr(ref_addr);
+	lmin = (addr[3] << 16) | (addr[4] << 8) | addr[5];
+	lmax = lmin;
+
+	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
+		struct airoha_gdm_port *port = eth->ports[i];
+		int j;
+
+		if (!port)
+			continue;
+
+		for (j = 0; j < ARRAY_SIZE(port->devs); j++) {
+			struct airoha_gdm_dev *iter_dev;
+			struct net_device *netdev;
+
+			iter_dev = port->devs[j];
+			if (!iter_dev || iter_dev == dev)
+				continue;
+
+			if (airoha_is_lan_gdm_dev(iter_dev) !=
+			    airoha_is_lan_gdm_dev(dev))
+				continue;
+
+			netdev = iter_dev->dev;
+			if (netdev->reg_state != NETREG_REGISTERED)
+				continue;
+
+			ether_addr_copy(ref_addr, netdev->dev_addr);
+			val = (netdev->dev_addr[3] << 16) |
+			      (netdev->dev_addr[4] << 8) | netdev->dev_addr[5];
+			if (val < lmin)
+				lmin = val;
+			if (val > lmax)
+				lmax = val;
+		}
+	}
+
+	if (!is_zero_ether_addr(ref_addr) && memcmp(ref_addr, addr, 3)) {
+		/* According to the HW design, hw mac address MS bits
+		 * must be the same for each net_device with the same
+		 * LAN/WAN configuration.
+		 */
+		netdev_err(dev->dev, "wrong mac addr for shared GDM port\n");
+		return -EINVAL;
+	}
 
 	reg = airoha_is_lan_gdm_dev(dev) ? REG_FE_LAN_MAC_H : REG_FE_WAN_MAC_H;
 	val = (addr[0] << 16) | (addr[1] << 8) | addr[2];
 	airoha_fe_wr(eth, reg, val);
 
-	val = (addr[3] << 16) | (addr[4] << 8) | addr[5];
-	airoha_fe_wr(eth, REG_FE_MAC_LMIN(reg), val);
-	airoha_fe_wr(eth, REG_FE_MAC_LMAX(reg), val);
+	airoha_fe_wr(eth, REG_FE_MAC_LMIN(reg), lmin);
+	airoha_fe_wr(eth, REG_FE_MAC_LMAX(reg), lmax);
 
-	airoha_ppe_init_upd_mem(dev);
+	airoha_ppe_init_upd_mem(dev, addr);
+
+	return 0;
 }
 
 static void airoha_set_gdm_port_fwd_cfg(struct airoha_eth *eth, u32 addr,
@@ -1814,13 +1863,18 @@ static int airoha_dev_stop(struct net_device *netdev)
 static int airoha_dev_set_macaddr(struct net_device *netdev, void *p)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct sockaddr *addr = p;
 	int err;
 
-	err = eth_mac_addr(netdev, p);
+	err = eth_prepare_mac_addr_change(netdev, p);
 	if (err)
 		return err;
 
-	airoha_set_macaddr(dev, netdev->dev_addr);
+	err = airoha_set_macaddr(dev, addr->sa_data);
+	if (err)
+		return err;
+
+	eth_commit_mac_addr_change(netdev, p);
 
 	return 0;
 }
@@ -1925,6 +1979,7 @@ static int airoha_dev_init(struct net_device *netdev)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
 	struct airoha_gdm_port *port = dev->port;
+	int err;
 
 	switch (port->id) {
 	case AIROHA_GDM3_IDX:
@@ -1949,12 +2004,12 @@ static int airoha_dev_init(struct net_device *netdev)
 	}
 
 	airoha_dev_set_qdma(dev);
-	airoha_set_macaddr(dev, netdev->dev_addr);
+	err = airoha_set_macaddr(dev, netdev->dev_addr);
+	if (err)
+		return err;
 
 	if (!airoha_is_lan_gdm_dev(dev) &&
 	    (port->id == AIROHA_GDM3_IDX || port->id == AIROHA_GDM4_IDX)) {
-		int err;
-
 		err = airoha_set_gdm2_loopback(dev);
 		if (err)
 			return err;
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index a2241520f2e2..364ca76eb3a6 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -684,7 +684,7 @@ void airoha_ppe_check_skb(struct airoha_ppe_dev *dev, struct sk_buff *skb,
 int airoha_ppe_setup_tc_block_cb(struct airoha_ppe_dev *dev, void *type_data);
 int airoha_ppe_init(struct airoha_eth *eth);
 void airoha_ppe_deinit(struct airoha_eth *eth);
-void airoha_ppe_init_upd_mem(struct airoha_gdm_dev *dev);
+void airoha_ppe_init_upd_mem(struct airoha_gdm_dev *dev, const u8 *addr);
 u32 airoha_ppe_get_total_num_entries(struct airoha_ppe *ppe);
 struct airoha_foe_entry *airoha_ppe_foe_get_entry(struct airoha_ppe *ppe,
 						  u32 hash);
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 194cd50b2c74..531ce33528b9 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -1482,12 +1482,10 @@ void airoha_ppe_check_skb(struct airoha_ppe_dev *dev, struct sk_buff *skb,
 	airoha_ppe_foe_insert_entry(ppe, skb, hash, rx_wlan);
 }
 
-void airoha_ppe_init_upd_mem(struct airoha_gdm_dev *dev)
+void airoha_ppe_init_upd_mem(struct airoha_gdm_dev *dev, const u8 *addr)
 {
 	struct airoha_gdm_port *port = dev->port;
-	struct net_device *netdev = dev->dev;
 	struct airoha_eth *eth = dev->eth;
-	const u8 *addr = netdev->dev_addr;
 	u32 val;
 
 	val = (addr[2] << 24) | (addr[3] << 16) | (addr[4] << 8) | addr[5];

-- 
2.54.0


