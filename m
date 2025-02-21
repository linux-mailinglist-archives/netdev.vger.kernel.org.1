Return-Path: <netdev+bounces-168482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA93DA3F212
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 11:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D1653BECEB
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 10:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A7D205AAB;
	Fri, 21 Feb 2025 10:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOrY6vic"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6F2204F90;
	Fri, 21 Feb 2025 10:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740133716; cv=none; b=sGdfGbBaZQ7aI7aZNV5HMkUVnWsdT0QIeYN963/4NZticUO8acuHfzGk+2KXbU26C2wstoqgmoETyrrInQUTjpElCoQOp4uHJHYwQOqRSjH+MMQyrwf5R+BwQ66kvXkc4ANnhC1OeOGflTuCmUiIbuXlPj5CyvESPsukBxnOX3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740133716; c=relaxed/simple;
	bh=LYtv9hkmflZk9C5liopfd0s1ChdnvNXvY0QApzYcDPA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b6gD6luc1B9rtF5LK0jdM65KMyOrHgrpSiJ99JTirRV7YtBz7BQeW6BFgqvxHOjpoMAOWX9fiP85YORFNV0tch3NmMkzwKck/KohN8ARBI/gAsAO0ep66jytjJsFGIDk2o34+RcZWmREhRV8yQzEDHQSSUoF0Ty5Ap5DdD34grE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOrY6vic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1420DC4CED6;
	Fri, 21 Feb 2025 10:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740133714;
	bh=LYtv9hkmflZk9C5liopfd0s1ChdnvNXvY0QApzYcDPA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VOrY6vict6nJ+9oGsiOzNtB7bF4sD7srsLas7V6VrioEZwG1zSkPQlES/rQUDXf73
	 7F8ErigZDu1ff9fj4X23hQ2SdckwfF/1Ys/XqzE5fYA7x0EncqPOtcp4nG1M5cMjAF
	 igzAkVa4baCSpr6Efq+du/oxZi10e9d7W1qWinfEYeToKOv5m6pOkVNt5d/xpOqo1p
	 GB24P4ZHHQdG+sfTH3AdnwdFupBRQnIuelym/hrHKcz7rJDq20a8zPcvAU5g3hnIzC
	 jsVCYYQzQFFEeEK1qPGuZkrMIt1HiKH78cFq8gMZzzcbdkngOYtLMkZqYx9Ht6TMKB
	 Zh1CKirpzcb5w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 21 Feb 2025 11:28:04 +0100
Subject: [PATCH net-next v6 03/15] net: airoha: Move reg/write utility
 routines in airoha_eth.h
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-airoha-en7581-flowtable-offload-v6-3-d593af0e9487@kernel.org>
References: <20250221-airoha-en7581-flowtable-offload-v6-0-d593af0e9487@kernel.org>
In-Reply-To: <20250221-airoha-en7581-flowtable-offload-v6-0-d593af0e9487@kernel.org>
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


