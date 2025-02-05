Return-Path: <netdev+bounces-163189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19421A298BD
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 19:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AD4D16833B
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 18:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151B01FDA66;
	Wed,  5 Feb 2025 18:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hd5iQwUK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A3F1FCCE1;
	Wed,  5 Feb 2025 18:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738779732; cv=none; b=MsSoPV6D1N9ajUAJjCw3/A8md+xcMzih32vertEwGuutcKC1b1coq8kydbsFXZd/vnFgpjV6JbNTVFVSBiJg+btfiXi7qzkt8zUu6DDPpcMlNVUoLU7LV4sqhfn21wsEkcWjI+abUB6zUTK0uv9QJNxm6tCMzejl/tTWeTzYyYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738779732; c=relaxed/simple;
	bh=obYgSC2EXfhhCIacH2bcpqqvIZQXINjXQ4LiWYYsW7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cwdYD7xQVXcbXz08ZyuI2H/6jMLbT2ZzeDX5RfmSmJZvBsd3aO6dTCRMVwuzDAhRFrtRJqyI2f1hYbE+EV1jh9cCqPVngGclLRZ/7G1iagEQPGIKlZDUBVFYKyyrgKH9EdwVpfsqfAxHbpRN2B8z4aEVif6oBWzRsOw2CRKG0jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hd5iQwUK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01272C4CED1;
	Wed,  5 Feb 2025 18:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738779731;
	bh=obYgSC2EXfhhCIacH2bcpqqvIZQXINjXQ4LiWYYsW7w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hd5iQwUKE6nvALoN5XA68zGbUt8uYAca5y/duLO1SgaU9SIWE14WIqSH5jrbPnnOa
	 buIJSaZtB5ciXrU4viaHUFSFki0YiJKQzDQeyYtbt55edayDAkUXL+MwDHm5IaDjFS
	 HgqqZvJ81vKvZ0BbP3wtYC6hR5H67X6m1+1OxOdOsTQdkg4pGOzwXMr7sGXVC9THi6
	 cgEIm/BnxwIJYKz38DTMQY74H/kvjpa6ZRQQsXW71Jqa4RjP9JbgO/SxXsNWWHUDe+
	 yJVTaDMHA7Kb+/UOFRjHPDlNiFe2UxR50jfIlew/54v7E3qSC2q1euwu88jgwHsqh8
	 i7clNchBINFjA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 05 Feb 2025 19:21:22 +0100
Subject: [PATCH net-next 03/13] net: airoha: Move reg/write utility
 routines in airoha_eth.h
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-airoha-en7581-flowtable-offload-v1-3-d362cfa97b01@kernel.org>
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

This is a preliminary patch to introduce flowtable hw offloading
support for airoha_eth driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 28 +++-------------------------
 drivers/net/ethernet/airoha/airoha_eth.h | 26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index a9074c6b55efc5c2fc1f09f8f8a6fdb34508d5cd..5916600555d6094a86c4bd3c17fa7bf8750059bd 100644
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


