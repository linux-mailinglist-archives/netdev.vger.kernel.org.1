Return-Path: <netdev+bounces-273918-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QABIIpfDzGkWWgYAu9opvQ
	(envelope-from <netdev+bounces-273918-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:04:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC783758A6
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53C0030A3A5B
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 07:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2A234752D;
	Wed,  1 Apr 2026 07:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yxqp49XI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF1C364E89;
	Wed,  1 Apr 2026 07:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775026823; cv=none; b=efFu083Sr4d5AfayTQeoejBwGhNEEYV1vQRqYZaPOxdfmbGTwnF45UG06Faq0BupkDb55cIzKFGOgYmUsnaa4OySRcb85L8T//KnjjxKsxL12gDEcABQakibkKuAKYi7q/lYxv046cOrqN634lyNiNCJ2y8DOjuMaNMarWPF/Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775026823; c=relaxed/simple;
	bh=d7jwV4NmIZslEsfJD4wLprgivI7Ue+FGu8WLJId/xuA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OxEwyjJ6NqNvTEiWUJblCN596UieryKwzJ5NVGu+g2k/kyj9e8OGyGmwNCBdvPEprM34MVZVyEl/Yba59vXGEafiLZs+KaR5jFuPnWVy9y6S6O51D8bxlUCu/4mcotgwsWJ+PVvsUmFjGDDMSKVwj1YowuveHfXsdNtVuVuNFkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yxqp49XI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F828C2BCB8;
	Wed,  1 Apr 2026 07:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775026822;
	bh=d7jwV4NmIZslEsfJD4wLprgivI7Ue+FGu8WLJId/xuA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Yxqp49XIIBlLWIlyM6vtMYIkqdZ5+Z7G+vBKWwqp16/Eo6fdCpXGI056CfvZa9FD0
	 rh6/YjPlsHy9wivAtJMj5LUtvgi72Ml74qYZZIwVTnADGCEajw/aV9AKCeRuHPZ8i7
	 HARDdcs4qPMerQtsx7eXcs+r6/byy0tFh/aXR4BWLoIgO5k9Ujf2vhWoGBtt63XOgr
	 DcuoKlM+RFE1mhVkGX8gsJbTRCCl3X1vCY0dhiR7ncUGiKrK0oaU8lTWC8+5+QfPa0
	 BLZkBCgl8H3tjti0+o7qnKOO6gQcoQ3JtgRPkXCx85SSqJcaBnfvMyRryZZwI1IOhg
	 Y7R3jjYDWNQYw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 01 Apr 2026 08:59:26 +0200
Subject: [PATCH net-next v2 08/11] net: airoha: Rely on airoha_gdm_dev
 pointer in airhoa_is_lan_gdm_port()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-airoha-eth-multi-serdes-v2-8-ac427ae4beeb@kernel.org>
References: <20260401-airoha-eth-multi-serdes-v2-0-ac427ae4beeb@kernel.org>
In-Reply-To: <20260401-airoha-eth-multi-serdes-v2-0-ac427ae4beeb@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-273918-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,airoha.com:email]
X-Rspamd-Queue-Id: DDC783758A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Rename airhoa_is_lan_gdm_port in airhoa_is_lan_gdm_dev. Moreover, rely
on airoha_gdm_dev pointer in airhoa_is_lan_gdm_dev() instead of
airoha_gdm_port one.
This is a preliminary patch to support multiple net_devices connected to
the same GDM{3,4} port via an external hw arbiter.

Tested-by: Xuegang Lu <xuegang.lu@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 6 ++----
 drivers/net/ethernet/airoha/airoha_eth.h | 4 +++-
 drivers/net/ethernet/airoha/airoha_ppe.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 8a9d79afe48d636e17168d43ed152620ed661435..5e489e8593ba6ad3d5d9f6a383c827919153652e 100644
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
 
@@ -1785,7 +1783,7 @@ static int airoha_dev_init(struct net_device *netdev)
 	int i;
 
 	/* QDMA0 is used for lan ports while QDMA1 is used for WAN ports */
-	dev->qdma = &eth->qdma[!airoha_is_lan_gdm_port(port)];
+	dev->qdma = &eth->qdma[!airoha_is_lan_gdm_dev(dev)];
 	dev->dev->irq = dev->qdma->irq_banks[0].irq;
 	airoha_set_macaddr(dev, netdev->dev_addr);
 
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index b1e05cb67ce93640b25355106947ca2ab31f7235..c444ba7832dec356286e5dd2166aba792fdd2c5f 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -632,8 +632,10 @@ u32 airoha_rmw(void __iomem *base, u32 offset, u32 mask, u32 val);
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
index 6c55ffa40edad63ec135cd0c987b3bcac0b0fbf6..c86cbbfacc1e6e049ccac60d703edc8ca53eff9b 100644
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


