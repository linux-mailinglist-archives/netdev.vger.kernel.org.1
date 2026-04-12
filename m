Return-Path: <netdev+bounces-277750-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MsRDDINQ22krAAkAu9opvQ
	(envelope-from <netdev+bounces-277750-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 09:57:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA913E30F8
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 09:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DB9C30131EE
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 07:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87DB3033EA;
	Sun, 12 Apr 2026 07:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beWUfbwZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F3E28CF5F
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 07:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775980670; cv=none; b=NbMBe2f+li0wy18x6bqP49/yonj3wGOApXpmP5WVx0RYIk+C9/T2bzYj4R0nggykfsL7Mf8m4nEwC7BjmJbq7Szr2z+d2Y1H0CXpSRu74Ro09Igi4oPnhGrZAk5U/9i+xeASLa7VeMsG6JN9FuKVol3052C/AbYAH/KbPMlTy0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775980670; c=relaxed/simple;
	bh=hEB/WlU+PuCaCCF9GLECeF0sJYz4vRrr9X6SysrwYrs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OBBtg8cic5l5eRCwMwy0Cb4vZUEz0ujKKhSLwcu8n1/guPvo8IbhFJ4/Xz97Fv4cLpFcNc6Vg/hVg/iMc9uXF6OIGxKoLsGB4yZGFnfzuL8R/Sa7emOtbji9REWNnKb+94R6oS6LX1fsmXMHJQbhas+1nhqtxLnNeSaCPfUcVTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beWUfbwZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2214C19424;
	Sun, 12 Apr 2026 07:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775980670;
	bh=hEB/WlU+PuCaCCF9GLECeF0sJYz4vRrr9X6SysrwYrs=;
	h=From:Date:Subject:To:Cc:From;
	b=beWUfbwZJ/aZnitlU+tGPf3EwUUaWXXHhsD/6HTlEdiVAwMquibjyqFWH8ncjwEVx
	 tYreXdA6/ewOATjJKNItuVp+o/Yujw5uPPhjeY3LUsUBspEc2GLTS4Y49YYhegOcUp
	 ypp1aSdOLFxBD4PtSgDzK6IAHDQDLbR8Rq6W+Ch+pMcA/VrBipeeFOiLmakXa3r/KA
	 /9cNsQX4Y02vKQ+MnoomVLri3CJtmcmLfJUaUNOYecAG9qSSDQl1hkkJT2dt/yS7qL
	 sdFNpjQvf+se7slrz+R7NGL82tgpPEIfwlRE8Ae8FWs4y+0Eu6AcSSiFYZKtRQmVuC
	 JXazpXgmiRD3w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 12 Apr 2026 09:57:29 +0200
Subject: [PATCH net] net: airoha: Fix VIP configuration for AN7583 SoC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260412-airoha-7583-vip-fix-v1-1-c35e02b054bb@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MywqAIBAAfyX23IJZ2uNXooPZVntR0Ygg/Pek4
 wzMvJAoMiWYqhci3ZzYuwJNXYE9jTsIeSsMUkgtukai4ehPg70aWrw54M4PKqH0Olrd78JAKUO
 kov/rDI4uWHL+ALnhc0VqAAAA
X-Change-ID: 20260412-airoha-7583-vip-fix-5056b9c67f0a
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277750-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6EA913E30F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

EN7581 and AN7583 SoCs have different VIP definitions. Introduce
get_vip_port callback in airoha_eth_soc_data struct in order to take
into account EN7581 and AN7583 VIP register layout and definition
differences.
Introduce nbq parameter in airoha_gdm_port struct. At the moment nbq
is set statically to value previously used in airhoha_set_gdm2_loopback
routine and it will be read from device tree in subsequent patches.

Fixes: e4e5ce823bdd ("net: airoha: Add AN7583 SoC support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 66 ++++++++++++++++++++++++--------
 drivers/net/ethernet/airoha/airoha_eth.h |  2 +
 2 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index c14cdce588a7..b64667722d7f 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -107,19 +107,7 @@ static int airoha_set_vip_for_gdm_port(struct airoha_gdm_port *port,
 	struct airoha_eth *eth = port->qdma->eth;
 	u32 vip_port;
 
-	switch (port->id) {
-	case AIROHA_GDM3_IDX:
-		/* FIXME: handle XSI_PCIE1_PORT */
-		vip_port = XSI_PCIE0_VIP_PORT_MASK;
-		break;
-	case AIROHA_GDM4_IDX:
-		/* FIXME: handle XSI_USB_PORT */
-		vip_port = XSI_ETH_VIP_PORT_MASK;
-		break;
-	default:
-		return 0;
-	}
-
+	vip_port = eth->soc->ops.get_vip_port(port, port->nbq);
 	if (enable) {
 		airoha_fe_set(eth, REG_FE_VIP_PORT_EN, vip_port);
 		airoha_fe_set(eth, REG_FE_IFC_PORT_EN, vip_port);
@@ -1705,7 +1693,7 @@ static int airoha_dev_set_macaddr(struct net_device *dev, void *p)
 static int airhoha_set_gdm2_loopback(struct airoha_gdm_port *port)
 {
 	struct airoha_eth *eth = port->qdma->eth;
-	u32 val, pse_port, chan, nbq;
+	u32 val, pse_port, chan;
 	int src_port;
 
 	/* Forward the traffic to the proper GDM port */
@@ -1735,9 +1723,7 @@ static int airhoha_set_gdm2_loopback(struct airoha_gdm_port *port)
 	airoha_fe_clear(eth, REG_FE_VIP_PORT_EN, BIT(AIROHA_GDM2_IDX));
 	airoha_fe_clear(eth, REG_FE_IFC_PORT_EN, BIT(AIROHA_GDM2_IDX));
 
-	/* XXX: handle XSI_USB_PORT and XSI_PCE1_PORT */
-	nbq = port->id == AIROHA_GDM3_IDX && airoha_is_7581(eth) ? 4 : 0;
-	src_port = eth->soc->ops.get_src_port_id(port, nbq);
+	src_port = eth->soc->ops.get_src_port_id(port, port->nbq);
 	if (src_port < 0)
 		return src_port;
 
@@ -2946,6 +2932,8 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
 	port->qdma = qdma;
 	port->dev = dev;
 	port->id = id;
+	/* XXX: Read nbq from DTS */
+	port->nbq = id == AIROHA_GDM3_IDX && airoha_is_7581(eth) ? 4 : 0;
 	eth->ports[p] = port;
 
 	return airoha_metadata_dst_alloc(port);
@@ -3147,6 +3135,28 @@ static int airoha_en7581_get_src_port_id(struct airoha_gdm_port *port, int nbq)
 	return -EINVAL;
 }
 
+static u32 airoha_en7581_get_vip_port(struct airoha_gdm_port *port, int nbq)
+{
+	switch (port->id) {
+	case AIROHA_GDM3_IDX:
+		if (nbq == 4)
+			return XSI_PCIE0_VIP_PORT_MASK;
+		if (nbq == 5)
+			return XSI_PCIE1_VIP_PORT_MASK;
+		break;
+	case AIROHA_GDM4_IDX:
+		if (!nbq)
+			return XSI_ETH_VIP_PORT_MASK;
+		if (nbq == 1)
+			return XSI_USB_VIP_PORT_MASK;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static const char * const an7583_xsi_rsts_names[] = {
 	"xsi-mac",
 	"hsi0-mac",
@@ -3176,6 +3186,26 @@ static int airoha_an7583_get_src_port_id(struct airoha_gdm_port *port, int nbq)
 	return -EINVAL;
 }
 
+static u32 airoha_an7583_get_vip_port(struct airoha_gdm_port *port, int nbq)
+{
+	switch (port->id) {
+	case AIROHA_GDM3_IDX:
+		if (!nbq)
+			return XSI_ETH_VIP_PORT_MASK;
+		break;
+	case AIROHA_GDM4_IDX:
+		if (!nbq)
+			return XSI_PCIE0_VIP_PORT_MASK;
+		if (nbq == 1)
+			return XSI_USB_VIP_PORT_MASK;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static const struct airoha_eth_soc_data en7581_soc_data = {
 	.version = 0x7581,
 	.xsi_rsts_names = en7581_xsi_rsts_names,
@@ -3183,6 +3213,7 @@ static const struct airoha_eth_soc_data en7581_soc_data = {
 	.num_ppe = 2,
 	.ops = {
 		.get_src_port_id = airoha_en7581_get_src_port_id,
+		.get_vip_port = airoha_en7581_get_vip_port,
 	},
 };
 
@@ -3193,6 +3224,7 @@ static const struct airoha_eth_soc_data an7583_soc_data = {
 	.num_ppe = 1,
 	.ops = {
 		.get_src_port_id = airoha_an7583_get_src_port_id,
+		.get_vip_port = airoha_an7583_get_vip_port,
 	},
 };
 
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index a97903569335..8bcd809e6f53 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -536,6 +536,7 @@ struct airoha_gdm_port {
 	struct airoha_qdma *qdma;
 	struct net_device *dev;
 	int id;
+	int nbq;
 
 	struct airoha_hw_stats stats;
 
@@ -576,6 +577,7 @@ struct airoha_eth_soc_data {
 	int num_ppe;
 	struct {
 		int (*get_src_port_id)(struct airoha_gdm_port *port, int nbq);
+		u32 (*get_vip_port)(struct airoha_gdm_port *port, int nbq);
 	} ops;
 };
 

---
base-commit: 02f72964395911e7a09bb2ea2fe6f79eda4ea2c2
change-id: 20260412-airoha-7583-vip-fix-5056b9c67f0a

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


