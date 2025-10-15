Return-Path: <netdev+bounces-229496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B44BDCE0C
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 09:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768C33B0877
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 07:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678D8314D06;
	Wed, 15 Oct 2025 07:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfpM+RYt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F7F314A9B;
	Wed, 15 Oct 2025 07:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512557; cv=none; b=fW04nKkv4HdVdDrfdtUKVHCMJo6b2nAmKhZpTQ2rPCSVsJuySX9sjpczTjibg4PtA3cKdoMa39ltU2j+dCG4Eh4rQQtPjusJeez/HUGIrWwWbF1vVOMrT8fx3Yqbsyx+AcdsXbfxKmXSgoWPjVeV8XRPiTPPs6C9u2D4bOdJF5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512557; c=relaxed/simple;
	bh=ztyA9W1K/1nlwkdJRr2NmB5/GYOpfXsTuWsxzmHDkkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d628ZpuOJmsULIJ8R+4XTtfv5Hkud81RDfLgarWeP2oojSvqrSF0Zt9KXeqFXv9bDzyduXPJMLSca7p5yU+1PRFSnRBnMzmEnfY8fmwspLI2dDJGix2RAUCHWBpadmfOrHX3Bs0j2WZ/LHloIZtEs7gKnHZCnCO2t+6umVXImp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfpM+RYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726DBC4CEF9;
	Wed, 15 Oct 2025 07:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760512556;
	bh=ztyA9W1K/1nlwkdJRr2NmB5/GYOpfXsTuWsxzmHDkkI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CfpM+RYt+NpoQ/CaIqAqAiPQOshqrOR9EbcpGMWx5+KSHiOe0BFHGmX/vhCEk6VTc
	 7okS5Fodz1DebVDPIIiXQw0YAX6NtCqgWacob2SDwdpyLiZ4Pbi0j8GZjlHFguRQuc
	 C8/Eoq4RI2+aLrC29HNmORpweDb7NpBQeI2D0HPTZhaJHS6CMh6mUMs8u0Op1sEDmf
	 3UM/R3yHBaJP3AvQiIs6MBCBD9KcLFJDs+D3c4rlfBeiNMm+yggCB30zAlITfwUOUU
	 JJRb+JxOWcsXLS03k7UK5ZnXVOLAfO74/KZjtz3WnQY272U7FNFAj95bkxY+IqZWbp
	 x6MIIiOvaq2lw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 15 Oct 2025 09:15:10 +0200
Subject: [PATCH net-next 10/12] net: airoha: Select default ppe cpu port in
 airoha_dev_init()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-an7583-eth-support-v1-10-064855f05923@kernel.org>
References: <20251015-an7583-eth-support-v1-0-064855f05923@kernel.org>
In-Reply-To: <20251015-an7583-eth-support-v1-0-064855f05923@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

Select PPE default cpu port in airoha_dev_init routine.
For PPE2 always use secondary cpu port. For PPE1 select cpu port
according to the running QDMA.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 38 ++++++++++++++------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 99e7fea52c6db9c4686fcef368f21e25f21ced58..5f6b5ab52e0265f7bb56b008ca653d64e04ff2d2 100644
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


