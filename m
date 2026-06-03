Return-Path: <netdev+bounces-294562-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5FVyAXPDH2pspgAAu9opvQ
	(envelope-from <netdev+bounces-294562-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:02:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3216347BF
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:02:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="enSpK/Fq";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294562-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294562-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2DA84305261A
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 06:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A3E3F9F52;
	Wed,  3 Jun 2026 06:01:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7563FADE0;
	Wed,  3 Jun 2026 06:01:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780466479; cv=none; b=QbJk26exeOKqISI0t2lMTn0MAy2wpBO3Bp5dmUNfwRV2gjltovtvw6SxpAaclsl+B26yTlHH/XXkBuiIdK9jMXzKvZ5xRKsQS0rGfsFBTzxn6Q7Y4EL3kPRLnbLsPNHVlgdLVcte27gaNXCbI2w3y7E1SjIyWNDqb3wPo8xcxLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780466479; c=relaxed/simple;
	bh=/0KgoMZ7Y/Y66N6PUC1bOPKa43xzWpVKcVg749kMwdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GbIce4O8MIbob9AUKCjFRQAW9LL1zpNmx0XJddY9RPfYNJZeq++eyDA9TbhZ4grFFx80locR08yPAHLjtyy4bRcmBjjXir6GAA9Me3I+l/0d8SjeLOuvXBtaI50AXG9qFOSxNLKF3SC46ghiwsbBIj5KDuy+1Y8NZQK9Q0xfjlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enSpK/Fq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88421F0089B;
	Wed,  3 Jun 2026 06:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780466476;
	bh=kwIhmiUhjwa16fmPX2KCAn+2U6erjZhTvA6Oh/JF3Ek=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=enSpK/FqKXcv6CnTcskuOQrBmQWdqGUhBqQnFU6/NwkpB4Pud96BO4KgfO/LlFgrd
	 NvJH9+sMnfoFKaS0GzI5iijhQ0IoSqEHt2pOl4t21LGRL4mgPJyNQiPsGsBhEhHYSr
	 YsU50pJgrKlEAUxtGDzgK1kjI+KFKQoUHl6fKXfAjzoyXEbDvUkHAicP1QJW9SFTUv
	 FNMYkxrRdr8lAaFQbOkPLU3EOrHy/KsGKIKImUdSbGQQzn4XZxWI0dj8geVZcxNxLh
	 Gj1S+4mLYDlBk+g4rFVkc1c+1eTwhUAPjxogPZh4F7imYZFqKm8ka9vAzD3Qtq+Moe
	 0FQ5IAaUveY+Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 03 Jun 2026 08:00:20 +0200
Subject: [PATCH net-next v9 6/6] net: airoha: Support multiple LAN/WAN
 interfaces for hw MAC address configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-airoha-eth-multi-serdes-v9-6-5d476bc2f426@kernel.org>
References: <20260603-airoha-eth-multi-serdes-v9-0-5d476bc2f426@kernel.org>
In-Reply-To: <20260603-airoha-eth-multi-serdes-v9-0-5d476bc2f426@kernel.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294562-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:lorenzo@kernel.org,m:ansuelsmth@gmail.com,m:benjamin.larsson@genexis.eu,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:madhur.agrawal@airoha.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org,airoha.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[airoha.com:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B3216347BF

The EN7581 and AN7583 SoCs provide registers to configure hardware LAN/WAN
MAC addresses. These registers are used during FE hw acceleration to
determine whether received traffic is destined to this host (L3 traffic)
or should be switched to another device (L2 traffic).
The SoC hardware design assumes all interfaces configured as LAN (or WAN)
share the MAC address MSBs, which are programmed into the
REG_FE_{LAN,WAN}_MAC_H register. The LSBs of 'local' mac addresses can be
expressed as a range via the REG_FE_MAC_LMIN and REG_FE_MAC_LMAX
registers. In order to properly accelerate the traffic, FE module requires
the user to configure the REG_FE_{LAN,WAN}_MAC_H register respecting this
limitation. Please note a misconfiguration in REG_FE_{LAN,WAN}_MAC_H
will still allow the user to log into the device for debugging.
Previously, only a single interface was considered when programming these
registers. Extend the logic to derive the correct minimum and maximum
values for REG_FE_MAC_LMIN/REG_FE_MAC_LMAX when two or more interfaces are
configured as LAN or WAN. Since this functionality was not available
before this series, no regression is introduced.

Tested-by: Madhur Agrawal <madhur.agrawal@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 77 ++++++++++++++++++++++++++++----
 drivers/net/ethernet/airoha/airoha_eth.h |  2 +-
 drivers/net/ethernet/airoha/airoha_ppe.c |  4 +-
 3 files changed, 71 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 64ee526da241..8f2608293bb7 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -71,20 +71,76 @@ static void airoha_qdma_irq_disable(struct airoha_irq_bank *irq_bank,
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
+			netdev = netdev_from_priv(iter_dev);
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
+		/* According to the HW design, hw mac address MSBs must be
+		 * the same for each net_device with the same LAN/WAN
+		 * configuration.
+		 */
+		struct net_device *netdev = netdev_from_priv(dev);
+
+		dev_warn(eth->dev,
+			 "%s: wrong mac addr, MSBs must be %02x:%02x:%02x\n",
+			 netdev->name, ref_addr[0], ref_addr[1],
+			 ref_addr[2]);
+		dev_warn(eth->dev, "FE hw forwarding won't work properly\n");
+
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
@@ -1826,13 +1882,18 @@ static int airoha_dev_stop(struct net_device *netdev)
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
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 3e8262f583a7..8f42973f9cf5 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -683,7 +683,7 @@ void airoha_ppe_check_skb(struct airoha_ppe_dev *dev, struct sk_buff *skb,
 int airoha_ppe_setup_tc_block_cb(struct airoha_ppe_dev *dev, void *type_data);
 int airoha_ppe_init(struct airoha_eth *eth);
 void airoha_ppe_deinit(struct airoha_eth *eth);
-void airoha_ppe_init_upd_mem(struct airoha_gdm_dev *dev);
+void airoha_ppe_init_upd_mem(struct airoha_gdm_dev *dev, const u8 *addr);
 u32 airoha_ppe_get_total_num_entries(struct airoha_ppe *ppe);
 struct airoha_foe_entry *airoha_ppe_foe_get_entry(struct airoha_ppe *ppe,
 						  u32 hash);
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index f54622904733..91bcc55a6ac6 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -1487,12 +1487,10 @@ void airoha_ppe_check_skb(struct airoha_ppe_dev *dev, struct sk_buff *skb,
 	airoha_ppe_foe_insert_entry(ppe, skb, hash, rx_wlan);
 }
 
-void airoha_ppe_init_upd_mem(struct airoha_gdm_dev *dev)
+void airoha_ppe_init_upd_mem(struct airoha_gdm_dev *dev, const u8 *addr)
 {
-	struct net_device *netdev = netdev_from_priv(dev);
 	struct airoha_gdm_port *port = dev->port;
 	struct airoha_eth *eth = dev->eth;
-	const u8 *addr = netdev->dev_addr;
 	u32 val;
 
 	val = (addr[2] << 24) | (addr[3] << 16) | (addr[4] << 8) | addr[5];

-- 
2.54.0


