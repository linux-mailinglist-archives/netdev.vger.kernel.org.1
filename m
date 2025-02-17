Return-Path: <netdev+bounces-166983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29877A38402
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 14:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9A153B7B87
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 13:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9A5223302;
	Mon, 17 Feb 2025 13:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WB8BIp03"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A9A21C9E4;
	Mon, 17 Feb 2025 13:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739797325; cv=none; b=OS8CYtwFRH/bXjrzcU2ARhAgBgnlJ/n7fuS6bwOzLdJ5+Hy1CaZOOImVqVjqXmlY91OQfpoz0A8nufX6LrFq55rqwFHCBLkFsXmXzI1j00ftyTBsCm4q8ig9Q5yvjq2ECU+lew+NnvWWhNgofOQgjisP+4kgmv+s2pyoQmwP0ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739797325; c=relaxed/simple;
	bh=UyYEPlddIkFUvoM3xOhih3hnmMO/4Vng4ybbFMkkQHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l8T2bMiIUI8b76qUdgRtflqZurijFRdowxgC5VkC+mNNcvyUbTWT7bl6xl0rNFm3kpUO+Lb+yrbUR2ht97lRpx+FxAQozmftn+ELbdybo8TlIvSyoxJfFWcbB0DqLu/9H8ZUO+PpoJV/UG1tDFBA79o0ORw4i2fTXWS9jAil3G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WB8BIp03; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1A4C4CEE2;
	Mon, 17 Feb 2025 13:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739797325;
	bh=UyYEPlddIkFUvoM3xOhih3hnmMO/4Vng4ybbFMkkQHs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WB8BIp034pI3WD3NWSmrB1w4f9cRxaa2RLeyEOcZGlljRGKXNqtcmTu+t8SAfKu/I
	 /LQqV44o9BVAkGdrM2pjMbcUWsHZEIHq4qPyfukZzl6+nAX4obeVjbVKl7T5ozJ0q7
	 Z6I0niscs8TwZsY9q9dZjFI3oYkAtzb6g+gTRTi0eqm7tf11D8st5J4qEaB0Yf5W0z
	 SZUWe+K5wYmRrCCP1b/6bWAPFchbGNlnbyWofuqxNBAlePH/w0SD5CNhFLBexKCyXt
	 6PUSELxPu+fhQcl+uLnkSn0rSWhs5lyK1H7xsE+I4/fH1IFAFFiisMgRzTW+oA3MLa
	 G3YnR2TEvuHcQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 17 Feb 2025 14:01:12 +0100
Subject: [PATCH net-next v5 08/15] net: airoha: Move REG_GDM_FWD_CFG()
 initialization in airoha_dev_init()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-airoha-en7581-flowtable-offload-v5-8-28be901cb735@kernel.org>
References: <20250217-airoha-en7581-flowtable-offload-v5-0-28be901cb735@kernel.org>
In-Reply-To: <20250217-airoha-en7581-flowtable-offload-v5-0-28be901cb735@kernel.org>
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
index 513914da8503c1162b0f1b4fcca57434385fa4d1..6c899358c086e6eb1de3ed25f625e48db129888f 100644
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


