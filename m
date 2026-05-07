Return-Path: <netdev+bounces-285509-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKceDr8C/WmIWgAAu9opvQ
	(envelope-from <netdev+bounces-285509-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 23:23:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 588F54EF370
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 23:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E4D75300516C
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 21:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB49A344030;
	Thu,  7 May 2026 21:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fm2Gguc/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A870030E837;
	Thu,  7 May 2026 21:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778188971; cv=none; b=hvXk2qUBArCM0gRSXxKlktwC5qHAHSWgvIE1jvO+h2OK+pU5AWrNnD9puvLIiYtYofM/CJyisGgIFAhOJoe1pA7bG69y9Cenj/9DDtumaYrvJI/E97plPlLY0IuhecgXxlBCMyIwtJVoQUNMVQb7BEj08uNvYNFHS9/XnehTc5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778188971; c=relaxed/simple;
	bh=fcQuV8WMZWguNDOAHbXa5lYO/Ui/98EqaE3hlGtG44Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X6VQ1Zsq3EH2F/zJHgVfIpl/bC7i1Jx+UKBHOBFst7+ZAawgFyv52wgWVbFH6orS+IA9U8VepNUf3U5+nNEKnf9FbtsXZlTr0RnNf1G2SUvvG3rxT8/qd7NKyQDckeQdRVt8QokpEwaCvzBvEMAUA9wQXZ7ktmTL6wNOjX5xioc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fm2Gguc/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31FFBC2BCF5;
	Thu,  7 May 2026 21:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778188971;
	bh=fcQuV8WMZWguNDOAHbXa5lYO/Ui/98EqaE3hlGtG44Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Fm2Gguc/CP29SWELe5aR27miAGHD2sKbHJxjOSO75cX+a9JZ/ttCWEpYK8h4ypTfS
	 PqNOfQzmZBWWehIHrNRWLl7WhpOCe1wxeVUJl/gDQniKdzneE5NLsuCmTWexZFBiIw
	 rlDI7o2OS8U+2proT2vNEKDp18oYeooiS28VhN45y8c+BdIXXlpoOf204Ey3AATXAq
	 7ohK0B8dtjAuSREsFH7RQfNocorPPPjG7Y1iMzU2GWiPOD509deh+KJmtmuRDLmVa2
	 QGKGq0Q9kd9EjLqyMqSy21uG8NKSy8ku9IDRc0MYMAUAyNzTIRcABxW01Yo6jjA7H9
	 F37sIzNB1SG0Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 07 May 2026 23:21:53 +0200
Subject: [PATCH net-next v4 10/10] net: airoha: Support multiple LAN/WAN
 interfaces for hw MAC address configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-airoha-eth-multi-serdes-v4-10-af613b61ae02@kernel.org>
References: <20260507-airoha-eth-multi-serdes-v4-0-af613b61ae02@kernel.org>
In-Reply-To: <20260507-airoha-eth-multi-serdes-v4-0-af613b61ae02@kernel.org>
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
X-Rspamd-Queue-Id: 588F54EF370
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285509-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org,airoha.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[airoha.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
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
 drivers/net/ethernet/airoha/airoha_eth.c | 73 +++++++++++++++++++++++++++-----
 1 file changed, 63 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 8617dd4f7932..fbfefd0ec355 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -71,20 +71,67 @@ static void airoha_qdma_irq_disable(struct airoha_irq_bank *irq_bank,
 	airoha_qdma_set_irqmask(irq_bank, index, mask, 0);
 }
 
-static void airoha_set_macaddr(struct airoha_gdm_dev *dev, const u8 *addr)
+static int airoha_set_macaddr(struct airoha_gdm_dev *dev, const u8 *addr)
 {
 	struct airoha_eth *eth = dev->eth;
-	u32 val, reg;
+	u8 ref_addr[ETH_ALEN] = {};
+	u32 reg, val, lmin, lmax;
+	int i;
+
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
 
 	airoha_ppe_init_upd_mem(dev);
+
+	return 0;
 }
 
 static void airoha_set_gdm_port_fwd_cfg(struct airoha_eth *eth, u32 addr,
@@ -1792,13 +1839,18 @@ static int airoha_dev_stop(struct net_device *netdev)
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
@@ -1903,6 +1955,7 @@ static int airoha_dev_init(struct net_device *netdev)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
 	struct airoha_gdm_port *port = dev->port;
+	int err;
 
 	switch (port->id) {
 	case AIROHA_GDM3_IDX:
@@ -1922,12 +1975,12 @@ static int airoha_dev_init(struct net_device *netdev)
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
 		if (err) {
 			dev->flags &= ~PRIV_FLAG_WAN;

-- 
2.54.0


