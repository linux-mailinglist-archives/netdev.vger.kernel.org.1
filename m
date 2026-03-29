Return-Path: <netdev+bounces-272899-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FgTKoglyWm/vAUAu9opvQ
	(envelope-from <netdev+bounces-272899-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 15:13:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 169CF3521D5
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 15:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3626730470EC
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 13:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC76F36F410;
	Sun, 29 Mar 2026 13:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTMFss9P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92E4433AD;
	Sun, 29 Mar 2026 13:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774789713; cv=none; b=KhkpRMMwM2eU3vEfX/SNt5oCga5FR+iVYrO6n/ngRGpGMqn5J8v7YAPmfCfkQi1ZwPbNZqwHWH2rIvdGnouDPIF3761RBgvtmA8Us2Ayv1VxeVNUnJKr7a86uUPnBY9LsajVzjJIdEejiLq6mWrJOdm0+Cv832HEIWkyRxZhRPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774789713; c=relaxed/simple;
	bh=KHtEcUjy+l7BW8+NRPiOYtZvKISRU14p4pZxqiPtYZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a0t9YFXhCOYRWpzq3JEz4W6xtQa87hE+lihB0BFdkY1xiTuiMsZPO9/Arxg40dMQbzpt9El+CotlvUrfEPSu9RmLJ345FIdBAx6Pfw33E2uatNWm1BAYUd6dr1tTFnxZMN+VmYkqYKT9Nuuz+fAzwqepVvra/v3BMkYJDPzli2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTMFss9P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DC4C19423;
	Sun, 29 Mar 2026 13:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774789713;
	bh=KHtEcUjy+l7BW8+NRPiOYtZvKISRU14p4pZxqiPtYZk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XTMFss9POuk3xb27HG0cd6LwdeZRdeEtfBGSFECWkhEHgg7bYjP36KMMMj5FX8T40
	 UqBcD0rFq8UdM9YCZCK/KwdPxzeopess8gPhBtL/FuVgMT0NKFeHCJl/DXjd1XXEt8
	 cDdx23OpnjJ7dariJvwbYiHkKu/tQnRQyPhjQR/aGz7T4tPVUxaZyp1wALslQlz+n6
	 ySzwyLopMwri5LAqC27Se25lxrJ2VsIraEd0EGc5sko+/+GAP7hjIutjf/Zh7K0DsN
	 RhLWtmb8d+l3oSQYcklO6TyYGhVtwB5FPeG7sFKAKTE7ycrDquFFL1VEjpyfaRTLGT
	 dzmDIrIHIF0jg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 29 Mar 2026 15:07:57 +0200
Subject: [PATCH net-next 07/10] net: airoha: Rely on airoha_gdm_dev pointer
 in airhoa_is_lan_gdm_port()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260329-airoha-eth-multi-serdes-v1-7-00f52dc360ca@kernel.org>
References: <20260329-airoha-eth-multi-serdes-v1-0-00f52dc360ca@kernel.org>
In-Reply-To: <20260329-airoha-eth-multi-serdes-v1-0-00f52dc360ca@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Xuegang Lu <xuegang.lu@airoha.com>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272899-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.infradead.org,vger.kernel.org,airoha.com];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,airoha.com:email]
X-Rspamd-Queue-Id: 169CF3521D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Rename airhoa_is_lan_gdm_port in airhoa_is_lan_gdm_dev. Moreover, rely
on airoha_gdm_dev pointer in airhoa_is_lan_gdm_dev() instead of
airoha_gdm_port one.
This is a preliminary patch to support multiple net_devices connected to
the same GDM{3,4} port via an external hw multiplexer.

Tested-by: Xuegang Lu <xuegang.lu@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 6 ++----
 drivers/net/ethernet/airoha/airoha_eth.h | 4 +++-
 drivers/net/ethernet/airoha/airoha_ppe.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index b56a3a1668cd36deb808e53a5e90204b1e9c1d98..65046010ebabd336109a9f2afd4e6ce1d21e8593 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -73,12 +73,10 @@ static void airoha_qdma_irq_disable(struct airoha_irq_bank *irq_bank,
 
 static void airoha_set_macaddr(struct airoha_gdm_dev *dev, const u8 *addr)
 {
-	struct airoha_gdm_port *port = dev->port;
 	struct airoha_eth *eth = dev->eth;
 	u32 val, reg;
 
-	reg = airoha_is_lan_gdm_port(port) ? REG_FE_LAN_MAC_H
-					   : REG_FE_WAN_MAC_H;
+	reg = airoha_is_lan_gdm_dev(dev) ? REG_FE_LAN_MAC_H : REG_FE_WAN_MAC_H;
 	val = (addr[0] << 16) | (addr[1] << 8) | addr[2];
 	airoha_fe_wr(eth, reg, val);
 
@@ -1782,7 +1780,7 @@ static int airoha_dev_init(struct net_device *netdev)
 	int i;
 
 	/* QDMA0 is used for lan ports while QDMA1 is used for WAN ports */
-	dev->qdma = &eth->qdma[!airoha_is_lan_gdm_port(port)];
+	dev->qdma = &eth->qdma[!airoha_is_lan_gdm_dev(dev)];
 	dev->dev->irq = dev->qdma->irq_banks[0].irq;
 	airoha_set_macaddr(dev, netdev->dev_addr);
 
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 222ae993435e8cf080278958e92d98c58d5f5f92..e41e99738217b6aa61c5643b4b3894f6ca2aa1c8 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -633,8 +633,10 @@ u32 airoha_rmw(void __iomem *base, u32 offset, u32 mask, u32 val);
 #define airoha_qdma_clear(qdma, offset, val)			\
 	airoha_rmw((qdma)->regs, (offset), (val), 0)
 
-static inline bool airoha_is_lan_gdm_port(struct airoha_gdm_port *port)
+static inline bool airoha_is_lan_gdm_dev(struct airoha_gdm_dev *dev)
 {
+	struct airoha_gdm_port *port = dev->port;
+
 	/* GDM1 port on EN7581 SoC is connected to the lan dsa switch.
 	 * GDM{2,3,4} can be used as wan port connected to an external
 	 * phy module.
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index eb8b7ed76fed5f36ad77886f5537a73eba0f0624..85ad27c8d71a1af6431195a457f53817b647e644 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -347,7 +347,7 @@ static int airoha_ppe_foe_entry_prepare(struct airoha_eth *eth,
 			/* For downlink traffic consume SRAM memory for hw
 			 * forwarding descriptors queue.
 			 */
-			if (airoha_is_lan_gdm_port(port))
+			if (airoha_is_lan_gdm_dev(dev))
 				val |= AIROHA_FOE_IB2_FAST_PATH;
 			if (dsa_port >= 0)
 				val |= FIELD_PREP(AIROHA_FOE_IB2_NBQ,

-- 
2.53.0


