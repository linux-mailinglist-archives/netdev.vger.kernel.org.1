Return-Path: <netdev+bounces-163193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB10A298C7
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 19:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20843188AB08
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 18:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CF61FE453;
	Wed,  5 Feb 2025 18:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvzI/B4/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5C01FCFE1;
	Wed,  5 Feb 2025 18:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738779742; cv=none; b=Izj44dKzyH31R8inHqLoQtw0y9FRS3qMwQuKqJ2Sk997wt7rVxZK8bkyeRcu1EDBhg4qjBnxsO5/l86/shggu7vxrUezNaJOwGcj3VmT9iMcJ9aPx8rfm3kujCyVhyGzQ2IxBAGlOfS3mgioaHf9X2rtjAr4MaKJG8i5rR/7VGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738779742; c=relaxed/simple;
	bh=WFtXkOHzpsVl/lSmvchFASlqyP6fybupy9T9sIM0y/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PUBYHjzzqGgJgmcGVExe48+UZreQFEVMSOWn2e8jNiN4gNTeUilLtlIknmY0EV79844x3CsadNrOjUM0Jlyz+MoEtPastOHSAw10WgjiKUeEPTzAOpxKpECmMsVPqIqGYpTHWqCQwK2uk8uFPLGfwYb/iQ34pOtoxbZKdf8RAbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvzI/B4/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04AFC4CED1;
	Wed,  5 Feb 2025 18:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738779742;
	bh=WFtXkOHzpsVl/lSmvchFASlqyP6fybupy9T9sIM0y/o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jvzI/B4/o3rR664OqP1QZ3awrF+0S2EZAl9U3ziymClJlMINKU/BpIblp4f5UlZoD
	 TTw7lgTd1aam/asxspB7ABtVABVko0WWFCNxOfwvjMBHaPSFy6sjBSUnkLNvUoOMG/
	 ATwq+tW9bOnfl6Lp2eoDCkg2iIMWSus6hEXmiaH0JlB+g8Ict2QvlU9jH1Dr0VSmn1
	 KTVJulY88M1OAmEfZKTHGwKGIiM1meV/g9ae+WFcevtDPfYOCD1yRF0ZQDfFrroW7x
	 lP3W4ZFDyM1zhGzHmP5lqlUofQBf4ujEh3czrQT/nLoLQ2APLaz11vrv8bFlIBqwn7
	 ryZ6tjUSpusIw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 05 Feb 2025 19:21:26 +0100
Subject: [PATCH net-next 07/13] net: airoha: Move REG_GDM_FWD_CFG()
 initialization in airoha_dev_init()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-airoha-en7581-flowtable-offload-v1-7-d362cfa97b01@kernel.org>
References: <20250205-airoha-en7581-flowtable-offload-v1-0-d362cfa97b01@kernel.org>
In-Reply-To: <20250205-airoha-en7581-flowtable-offload-v1-0-d362cfa97b01@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
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
index 42b5e0945fb8738f70d0b77bf597a7a04e5f0716..db75a9b1d5766bfaaa92312d625c395e19c88368 100644
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


