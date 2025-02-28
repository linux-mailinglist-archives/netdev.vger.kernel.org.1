Return-Path: <netdev+bounces-170662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC624A497E8
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 11:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B21E7A99E0
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 10:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E872620C2;
	Fri, 28 Feb 2025 10:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfcRGW7f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E611260375;
	Fri, 28 Feb 2025 10:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740740091; cv=none; b=jUICUKcTqkcxPIE0Y36tNRjHEgX2h/f1M7j3U0GCun0O0BH52TkV7qBj7PERkDSv+BlZo1aXrHAvXDhnRBMN1uHOyRb1cdO9AV0NnsOZDHx1BqdmiNutdHB4vl8xWkq2VhRMvSiaJJeTH/qnwazDQY8InyxkyzqMDfN7g1nmSc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740740091; c=relaxed/simple;
	bh=UpFZxvQCSOusKr0OSxkaX3mdCDG/dd+DHL1AgasxZF0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U/9Ag8HrhHTH2GerhHannO4dpkXQx+QiuKEAf31VX7BTsa1/aLSpfWQHCWqJSwGldy8epusG+EyyJ1fXIT245VqtCFSrNN3g7S8/v1DZcxEDoL0bNOS/UBlmmSNpnNf/BqkrtV0+p7Dvak48EaKLnOqiIDwIBQ4/dT6+mtEnEJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfcRGW7f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C72FC4CED6;
	Fri, 28 Feb 2025 10:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740740090;
	bh=UpFZxvQCSOusKr0OSxkaX3mdCDG/dd+DHL1AgasxZF0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bfcRGW7fwG7Jls/NxqO2gopz7+/kdMq/iTlqR79bLIxaFv6y6vJXA5SHTfMRfE3+T
	 QzPl9Wydnyd27FZoNLyq19NM36L6q1heFJF3DSpPd/PRi/09Qeye9NKsSD7hGDTPdY
	 UsKYqUqNyOWHTgpTFMNtIxldvbOrj2Ys+8mdTVfJ5/FHSzf6dHrzIgMWJxveBVkO5I
	 7vf7KO6U/+PKvK73GRqvWrsSi6hPRd156No/XL2IWZIEJOm9wxj7B6MZ2yiLI937Iz
	 k3HhGNBxQ6VhBM7HseGfXxu7yKU9XKT5TQmHpmyaevgNwOPaqxLusjL58a4wpU2QpJ
	 f2NQILBwb3+CQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 28 Feb 2025 11:54:16 +0100
Subject: [PATCH net-next v8 08/15] net: airoha: Move REG_GDM_FWD_CFG()
 initialization in airoha_dev_init()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-airoha-en7581-flowtable-offload-v8-8-01dc1653f46e@kernel.org>
References: <20250228-airoha-en7581-flowtable-offload-v8-0-01dc1653f46e@kernel.org>
In-Reply-To: <20250228-airoha-en7581-flowtable-offload-v8-0-01dc1653f46e@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 "Chester A. Unal" <chester.a.unal@arinc9.com>, 
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 upstream@airoha.com
X-Mailer: b4 0.14.2

Move REG_GDM_FWD_CFG() register initialization in airoha_dev_init
routine. Moreover, always send traffic PPE module in order to be
processed by hw accelerator.
This is a preliminary patch to enable netfilter flowtable hw offloading
on EN7581 SoC.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 69775dfbc1c34e25787d285931f89ce6e735658a..4e74fd1839919a666065a8a63926abe826b5fa65 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -107,25 +107,20 @@ static void airoha_set_gdm_port_fwd_cfg(struct airoha_eth *eth, u32 addr,
 
 static int airoha_set_gdm_port(struct airoha_eth *eth, int port, bool enable)
 {
-	u32 val = enable ? FE_PSE_PORT_PPE1 : FE_PSE_PORT_DROP;
-	u32 vip_port, cfg_addr;
+	u32 vip_port;
 
 	switch (port) {
 	case XSI_PCIE0_PORT:
 		vip_port = XSI_PCIE0_VIP_PORT_MASK;
-		cfg_addr = REG_GDM_FWD_CFG(3);
 		break;
 	case XSI_PCIE1_PORT:
 		vip_port = XSI_PCIE1_VIP_PORT_MASK;
-		cfg_addr = REG_GDM_FWD_CFG(3);
 		break;
 	case XSI_USB_PORT:
 		vip_port = XSI_USB_VIP_PORT_MASK;
-		cfg_addr = REG_GDM_FWD_CFG(4);
 		break;
 	case XSI_ETH_PORT:
 		vip_port = XSI_ETH_VIP_PORT_MASK;
-		cfg_addr = REG_GDM_FWD_CFG(4);
 		break;
 	default:
 		return -EINVAL;
@@ -139,8 +134,6 @@ static int airoha_set_gdm_port(struct airoha_eth *eth, int port, bool enable)
 		airoha_fe_clear(eth, REG_FE_IFC_PORT_EN, vip_port);
 	}
 
-	airoha_set_gdm_port_fwd_cfg(eth, cfg_addr, val);
-
 	return 0;
 }
 
@@ -177,8 +170,6 @@ static void airoha_fe_maccr_init(struct airoha_eth *eth)
 		airoha_fe_set(eth, REG_GDM_FWD_CFG(p),
 			      GDM_TCP_CKSUM | GDM_UDP_CKSUM | GDM_IP4_CKSUM |
 			      GDM_DROP_CRC_ERR);
-		airoha_set_gdm_port_fwd_cfg(eth, REG_GDM_FWD_CFG(p),
-					    FE_PSE_PORT_CDM1);
 		airoha_fe_rmw(eth, REG_GDM_LEN_CFG(p),
 			      GDM_SHORT_LEN_MASK | GDM_LONG_LEN_MASK,
 			      FIELD_PREP(GDM_SHORT_LEN_MASK, 60) |
@@ -1614,8 +1605,11 @@ static int airoha_dev_set_macaddr(struct net_device *dev, void *p)
 static int airoha_dev_init(struct net_device *dev)
 {
 	struct airoha_gdm_port *port = netdev_priv(dev);
+	struct airoha_eth *eth = port->qdma->eth;
 
 	airoha_set_macaddr(port, dev->dev_addr);
+	airoha_set_gdm_port_fwd_cfg(eth, REG_GDM_FWD_CFG(port->id),
+				    FE_PSE_PORT_PPE1);
 
 	return 0;
 }

-- 
2.48.1


