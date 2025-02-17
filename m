Return-Path: <netdev+bounces-166978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C088EA383FA
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 14:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8CAA3B70AB
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 13:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D821A21CC7D;
	Mon, 17 Feb 2025 13:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgDjF4wb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD8021CC49;
	Mon, 17 Feb 2025 13:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739797311; cv=none; b=YhaETRP1pCZYru1obP+1CYs0bOclQWathCWXDsFB0wI1CMeW8Ox0J8dKGX67u3Em9ZWzyXyVxr5+SzujSn/uxvtlCbbrQlwcWHsiXDkwsfC/aRsWsxxzhHTm8Ojpj8INOVeWw5QVGDMxmpRfvCOkRenbGHRTiJXBP4ZBibQAAsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739797311; c=relaxed/simple;
	bh=LYtv9hkmflZk9C5liopfd0s1ChdnvNXvY0QApzYcDPA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ser4CPGxtElZO7qGmgr80IvK8sZu9XfAdVjJZ9HzT0HlziQtokTUd33c18vbRZNLrj820i/0mFFqd7ouSNjOeITRac3w2rGdtgVwW6tbhQ45elTnwYzb3N2Ye9pqSYgsFdGeAwVcpCk7kZ+LPgSuK3mH6yv59AAYBu/PuyE4rhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgDjF4wb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6650C4CEE4;
	Mon, 17 Feb 2025 13:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739797311;
	bh=LYtv9hkmflZk9C5liopfd0s1ChdnvNXvY0QApzYcDPA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GgDjF4wbherwy4R4WrwZlitcSVLiqi+eOQlh9Td/ii1/r6+x+jVGxXdwX00Iwl/In
	 JGLj42XVrfcT8sMngIhSBya8WW4rKvZZ2KXoj16gHdNruzgm15TydHJiRhuznkJujw
	 zb5HJWCnNGLjt8VocalLhvC9HIp8hc+NDoTgwO9/DgiNBqQZeZJpMUppJPZB5EUTK5
	 nlhAOgXiViwtHC6AQMnOZ1vVALX57BXQR9yfkaVt7sRPKlTIlyVbILdPWtlyCic3/G
	 bZ7kCBrunQtTMQtgTfXeg07YUEFMQIDxpJnwJQgzUcSqXLFOae0dO/DWIzxOvQG68q
	 vnHYihLCm8MYA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 17 Feb 2025 14:01:07 +0100
Subject: [PATCH net-next v5 03/15] net: airoha: Move reg/write utility
 routines in airoha_eth.h
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-airoha-en7581-flowtable-offload-v5-3-28be901cb735@kernel.org>
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

This is a preliminary patch to introduce flowtable hw offloading
support for airoha_eth driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 28 +++-------------------------
 drivers/net/ethernet/airoha/airoha_eth.h | 26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 0048a5665576afaf532778f0bd96be8b07d29703..1c6fb7b9ccbbaec846643343e0347a1e948a575f 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -673,17 +673,17 @@ struct airoha_qdma_fwd_desc {
 	__le32 rsv1;
 };
 
-static u32 airoha_rr(void __iomem *base, u32 offset)
+u32 airoha_rr(void __iomem *base, u32 offset)
 {
 	return readl(base + offset);
 }
 
-static void airoha_wr(void __iomem *base, u32 offset, u32 val)
+void airoha_wr(void __iomem *base, u32 offset, u32 val)
 {
 	writel(val, base + offset);
 }
 
-static u32 airoha_rmw(void __iomem *base, u32 offset, u32 mask, u32 val)
+u32 airoha_rmw(void __iomem *base, u32 offset, u32 mask, u32 val)
 {
 	val |= (airoha_rr(base, offset) & ~mask);
 	airoha_wr(base, offset, val);
@@ -691,28 +691,6 @@ static u32 airoha_rmw(void __iomem *base, u32 offset, u32 mask, u32 val)
 	return val;
 }
 
-#define airoha_fe_rr(eth, offset)				\
-	airoha_rr((eth)->fe_regs, (offset))
-#define airoha_fe_wr(eth, offset, val)				\
-	airoha_wr((eth)->fe_regs, (offset), (val))
-#define airoha_fe_rmw(eth, offset, mask, val)			\
-	airoha_rmw((eth)->fe_regs, (offset), (mask), (val))
-#define airoha_fe_set(eth, offset, val)				\
-	airoha_rmw((eth)->fe_regs, (offset), 0, (val))
-#define airoha_fe_clear(eth, offset, val)			\
-	airoha_rmw((eth)->fe_regs, (offset), (val), 0)
-
-#define airoha_qdma_rr(qdma, offset)				\
-	airoha_rr((qdma)->regs, (offset))
-#define airoha_qdma_wr(qdma, offset, val)			\
-	airoha_wr((qdma)->regs, (offset), (val))
-#define airoha_qdma_rmw(qdma, offset, mask, val)		\
-	airoha_rmw((qdma)->regs, (offset), (mask), (val))
-#define airoha_qdma_set(qdma, offset, val)			\
-	airoha_rmw((qdma)->regs, (offset), 0, (val))
-#define airoha_qdma_clear(qdma, offset, val)			\
-	airoha_rmw((qdma)->regs, (offset), (val), 0)
-
 static void airoha_qdma_set_irqmask(struct airoha_qdma *qdma, int index,
 				    u32 clear, u32 set)
 {
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 3310e0cf85f1d240e95404a0c15703e5f6be26bc..743aaf10235fe09fb2a91b491f4b25064ed8319b 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -248,4 +248,30 @@ struct airoha_eth {
 	struct airoha_gdm_port *ports[AIROHA_MAX_NUM_GDM_PORTS];
 };
 
+u32 airoha_rr(void __iomem *base, u32 offset);
+void airoha_wr(void __iomem *base, u32 offset, u32 val);
+u32 airoha_rmw(void __iomem *base, u32 offset, u32 mask, u32 val);
+
+#define airoha_fe_rr(eth, offset)				\
+	airoha_rr((eth)->fe_regs, (offset))
+#define airoha_fe_wr(eth, offset, val)				\
+	airoha_wr((eth)->fe_regs, (offset), (val))
+#define airoha_fe_rmw(eth, offset, mask, val)			\
+	airoha_rmw((eth)->fe_regs, (offset), (mask), (val))
+#define airoha_fe_set(eth, offset, val)				\
+	airoha_rmw((eth)->fe_regs, (offset), 0, (val))
+#define airoha_fe_clear(eth, offset, val)			\
+	airoha_rmw((eth)->fe_regs, (offset), (val), 0)
+
+#define airoha_qdma_rr(qdma, offset)				\
+	airoha_rr((qdma)->regs, (offset))
+#define airoha_qdma_wr(qdma, offset, val)			\
+	airoha_wr((qdma)->regs, (offset), (val))
+#define airoha_qdma_rmw(qdma, offset, mask, val)		\
+	airoha_rmw((qdma)->regs, (offset), (mask), (val))
+#define airoha_qdma_set(qdma, offset, val)			\
+	airoha_rmw((qdma)->regs, (offset), 0, (val))
+#define airoha_qdma_clear(qdma, offset, val)			\
+	airoha_rmw((qdma)->regs, (offset), (val), 0)
+
 #endif /* AIROHA_ETH_H */

-- 
2.48.1


