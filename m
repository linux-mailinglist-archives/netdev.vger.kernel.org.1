Return-Path: <netdev+bounces-230395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFF3BE774A
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 11:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 797EA562A99
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 09:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3915B31283F;
	Fri, 17 Oct 2025 09:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhWDvd+I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DAA2D5416;
	Fri, 17 Oct 2025 09:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760692018; cv=none; b=C/7+4bhkc5FRiyH7Zk/loKyVmcPV5U5KtF9Z3ZvB825ZxGVimxgTtvuqhOHSLun+tvNJCnTlQEG+YQFQmV0qBTt2in2/0/rY98XYjdIcsch9A9a82qr0SZderno9m3ll6tVBDqIKjk4RKJjtZSAGhCdcMrWbRvgHVxELnQgYBTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760692018; c=relaxed/simple;
	bh=ptWrRTulQ7ja6IlTLgATLScM0utDLOR3ac/K/ROGBcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FhHpJduR/NU9lrzlHkPYtloW+ou+tmUO6SzUNbKvQGxEgOQwqwkBATEQ9EwjEelDSFmtqpRQ7okMf4nFBpZBjXIm8b7rkNh+tN3bS2nsPCTilZTp7pKaDtPLaU1QycKOGVGrj40nmfNRlAlmnGt38ZXJcJATfZtSH07FtvJHNr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhWDvd+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D13C4CEF9;
	Fri, 17 Oct 2025 09:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760692017;
	bh=ptWrRTulQ7ja6IlTLgATLScM0utDLOR3ac/K/ROGBcY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EhWDvd+IcNjQ0EpcsKd1baxcIeX8OsVl9Ajif4J0Y+YZHUD41LrqxMyizcajZGDSx
	 +M029aoHL093q3HKgfO5qu++/XsFPEnpBMmKn/NJH7Rg6lexJMWjY6HEveyjm2JK83
	 ZOguQAg9HAWpQaFl24rQTz9d/5qICMLAa97ZIsDW5x2RPw32IvC+d8P1r86suQNbqj
	 Ap6CW1PDHUjZXQzyf9MEtzjUqpzWYg/BKRdK1Pm67Zyocu0ihKJGDzwIK77/PyRWzH
	 cZYqMJaqMGWEMiRIBH7Z2x0syO5K00XjHheIguItvvHS7gSvxHpYchqsKw9/xPY0ZW
	 ydpQbczxLuQNQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 17 Oct 2025 11:06:19 +0200
Subject: [PATCH net-next v3 10/13] net: airoha: Select default ppe cpu port
 in airoha_dev_init()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-an7583-eth-support-v3-10-f28319666667@kernel.org>
References: <20251017-an7583-eth-support-v3-0-f28319666667@kernel.org>
In-Reply-To: <20251017-an7583-eth-support-v3-0-f28319666667@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.2

Select the PPE default cpu port in airoha_dev_init routine.
This patch allows to distribute the load between the two available cpu
ports (FE_PSE_PORT_CDM1 and FE_PSE_PORT_CDM2) if the device is running a
single PPE module (e.g. 7583) selecting the cpu port based on the use
QDMA device. For multi-PPE device (e.g. 7581) assign FE_PSE_PORT_CDM1 to
PPE1 and FE_PSE_PORT_CDM2 to PPE2.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 38 ++++++++++++++------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index dea856ddf242d2c4ec3ca44796fc6deb2d784904..4e338c126dd3fa16f040960ff7f26d8214a9d6f7 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -531,25 +531,6 @@ static int airoha_fe_init(struct airoha_eth *eth)
 	/* disable IFC by default */
 	airoha_fe_clear(eth, REG_FE_CSR_IFC_CFG, FE_IFC_EN_MASK);
 
-	airoha_fe_wr(eth, REG_PPE_DFT_CPORT0(0),
-		     FIELD_PREP(DFT_CPORT_MASK(7), FE_PSE_PORT_CDM1) |
-		     FIELD_PREP(DFT_CPORT_MASK(6), FE_PSE_PORT_CDM1) |
-		     FIELD_PREP(DFT_CPORT_MASK(5), FE_PSE_PORT_CDM1) |
-		     FIELD_PREP(DFT_CPORT_MASK(4), FE_PSE_PORT_CDM1) |
-		     FIELD_PREP(DFT_CPORT_MASK(3), FE_PSE_PORT_CDM1) |
-		     FIELD_PREP(DFT_CPORT_MASK(2), FE_PSE_PORT_CDM1) |
-		     FIELD_PREP(DFT_CPORT_MASK(1), FE_PSE_PORT_CDM1) |
-		     FIELD_PREP(DFT_CPORT_MASK(0), FE_PSE_PORT_CDM1));
-	airoha_fe_wr(eth, REG_PPE_DFT_CPORT0(1),
-		     FIELD_PREP(DFT_CPORT_MASK(7), FE_PSE_PORT_CDM2) |
-		     FIELD_PREP(DFT_CPORT_MASK(6), FE_PSE_PORT_CDM2) |
-		     FIELD_PREP(DFT_CPORT_MASK(5), FE_PSE_PORT_CDM2) |
-		     FIELD_PREP(DFT_CPORT_MASK(4), FE_PSE_PORT_CDM2) |
-		     FIELD_PREP(DFT_CPORT_MASK(3), FE_PSE_PORT_CDM2) |
-		     FIELD_PREP(DFT_CPORT_MASK(2), FE_PSE_PORT_CDM2) |
-		     FIELD_PREP(DFT_CPORT_MASK(1), FE_PSE_PORT_CDM2) |
-		     FIELD_PREP(DFT_CPORT_MASK(0), FE_PSE_PORT_CDM2));
-
 	/* enable 1:N vlan action, init vlan table */
 	airoha_fe_set(eth, REG_MC_VLAN_EN, MC_VLAN_EN_MASK);
 
@@ -1756,8 +1737,10 @@ static void airhoha_set_gdm2_loopback(struct airoha_gdm_port *port)
 static int airoha_dev_init(struct net_device *dev)
 {
 	struct airoha_gdm_port *port = netdev_priv(dev);
-	struct airoha_eth *eth = port->qdma->eth;
-	u32 pse_port;
+	struct airoha_qdma *qdma = port->qdma;
+	struct airoha_eth *eth = qdma->eth;
+	u32 pse_port, fe_cpu_port;
+	u8 ppe_id;
 
 	airoha_set_macaddr(port, dev->dev_addr);
 
@@ -1770,16 +1753,27 @@ static int airoha_dev_init(struct net_device *dev)
 		fallthrough;
 	case 2:
 		if (airoha_ppe_is_enabled(eth, 1)) {
+			/* For PPE2 always use secondary cpu port. */
+			fe_cpu_port = FE_PSE_PORT_CDM2;
 			pse_port = FE_PSE_PORT_PPE2;
 			break;
 		}
 		fallthrough;
-	default:
+	default: {
+		u8 qdma_id = qdma - &eth->qdma[0];
+
+		/* For PPE1 select cpu port according to the running QDMA. */
+		fe_cpu_port = qdma_id ? FE_PSE_PORT_CDM2 : FE_PSE_PORT_CDM1;
 		pse_port = FE_PSE_PORT_PPE1;
 		break;
 	}
+	}
 
 	airoha_set_gdm_port_fwd_cfg(eth, REG_GDM_FWD_CFG(port->id), pse_port);
+	ppe_id = pse_port == FE_PSE_PORT_PPE2 ? 1 : 0;
+	airoha_fe_rmw(eth, REG_PPE_DFT_CPORT0(ppe_id),
+		      DFT_CPORT_MASK(port->id),
+		      fe_cpu_port << __ffs(DFT_CPORT_MASK(port->id)));
 
 	return 0;
 }

-- 
2.51.0


