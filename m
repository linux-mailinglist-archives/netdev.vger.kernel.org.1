Return-Path: <netdev+bounces-151603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 879929F02DE
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 04:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43983285074
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 03:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E75141AAC;
	Fri, 13 Dec 2024 03:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvlnJ/zH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7992AD14;
	Fri, 13 Dec 2024 03:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734058848; cv=none; b=CO1GWhd6Drd1My3gL6Rb+W6/8ffS1hVAn2iEXdXXaFBKwtdycs7hZw5C3kfZ1tqLa1zl0aug4zis8vCuCcecT10qncK0WRw3SqTcWblzdKsjH/lGiuPLHVQlYr68w1HHxFm8XZ+hsj0iCA/2nGpeCm8IPYCiVMIxbc6G9Cf+/6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734058848; c=relaxed/simple;
	bh=O8qJbyVUKNdgkHDzurgu6WVclwncE7fPDQ6O10gtf20=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O2FykyV3eQBki3sW4J6YaQbjzrZ8I+xZiXUxo7Ip7cFjBNijpfP8wvD0yGz1TmXOsHGPqsLEv2VL2W9CYh5NP1+IAkQ+eYdgyZlK3O3dfDCgknOzSOK7Yoc/o5lqPMuu8FRcUNJ8YQRmqguSay7qEQpeGb1d5gcQS0esg7HLGIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvlnJ/zH; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-728ea1573c0so1119737b3a.0;
        Thu, 12 Dec 2024 19:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734058845; x=1734663645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KPBXi5N5CCwTHICg2FM5R+V0qUviqQKoqSquGXTiuRs=;
        b=BvlnJ/zHWEtEVs+dRtiSnlbuswBEkRh2RmSDUL87lKiMyEm4NDubIfkaa5HdsNoaCd
         VcnHuYNe7Ix2WYZXzR6+IfmDZiHiJwccTXPVBoHx1aYY/36+NNaTjIKk+REURr9spjVD
         ChtjupR5RPtW4Q3oI0aMwUHTKGR8wjv7+s9TdIJV7VLkYS1Xdf85Ysok8YbsDeVo+Rz3
         08T0l4eWUuaJNa680NiF6fqGNucAb5VISx4eK43lpUvomRTIulwC9CWs93ESS9aFXOMC
         +smZ7Dwfu38JCJD3k2gKYTFc5uAmY1Z1D2Z64zI51hB0NfInc1LrkYGj0ORF6VCrM0VU
         DVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734058845; x=1734663645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KPBXi5N5CCwTHICg2FM5R+V0qUviqQKoqSquGXTiuRs=;
        b=TLh6a3z5diu8JgkBkv4Iz2n0lBJkRZMrVeHx594qcwK4X1SCn9pFYQBqXP3WnjmIAv
         BxdtXhdCiYsufDQ+B3LHaV4tOFRspEFMslNUfiaP31dxmEgw/BgOR4aU6U0ApWR144q/
         TStKF/0cKOgd+pSosfwQ9lyWB7oRt5nZhGR1J054WakT7V23Ct0TmfeK8eN3fqK+asRb
         E1AE3WLCYtjwYU08niBVVqv2XMHF/MvudUxoZvP5QXMIcUQ1KChHZfwG2FspZPYammXV
         96HodcfaGEo8YMSRSiKUt7DLskgmdi/n2SdKzqhNqFqYLQgX8VyYJOfbXUWh+oYf+PtD
         gXyA==
X-Forwarded-Encrypted: i=1; AJvYcCVRGLmZ+sJV3Lg0sttr5Um0SHnDdHAxscIytWmEEQgN0DUT0MXjJ9YvOy6tdmfTwWZhFzLVm+DJ3ge7KBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvkcYf+rJcocph7WIS9rmDgHJl2WMlOV7wmXKcY3iUCXjqeFyj
	zUIOXiNso8/NXFZwOmFR62VPq/PGI3Dhb8r5LlxYaFHj8BFUNtQoref8NQ==
X-Gm-Gg: ASbGncuURhAxaso5rtzj/yMiX94au9zpomXvnFUmUt8zUM3HvOUaDy5n0e0Tu1riUQ/
	SswVpS+XGgjwdBy0qZE7yDVEgMbeI+SVIjMLM6F8s33LATmk71yC6MpaNg1/cn2nytILMp6WwQ4
	UqFuLIhP11709pmZ1fuw4NxLzrpHwNxIY8uBbjwmfCj022nSgWRM6ZVtiNfk1caavPvTlh8GsRa
	V5grP/AmZBi1Wuyf8egNMkMp2dzO3KXGUc4PTrBVV5BJCCBWNlOzSkdYcn8VniBd5mkSQ==
X-Google-Smtp-Source: AGHT+IHZz0EP8rBsHt73REos2pRhq2kj90v6bkCqeRkKUwXgaZ0ElTwKurf6FJc0UkKYBVOnQvmB0Q==
X-Received: by 2002:a05:6a00:c82:b0:728:eb62:a132 with SMTP id d2e1a72fcca58-7290c1b1c49mr1368212b3a.15.1734058844679;
        Thu, 12 Dec 2024 19:00:44 -0800 (PST)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-728957aaf22sm5977712b3a.128.2024.12.12.19.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 19:00:44 -0800 (PST)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v1] net: stmmac: TSO: Simplify the code flow of DMA descriptor allocations
Date: Fri, 13 Dec 2024 11:00:06 +0800
Message-Id: <20241213030006.337695-1-0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DMA AXI address width of DWMAC cores can be configured to
32-bit/40-bit/48-bit, then the format of DMA transmit descriptors
get a little different between 32-bit and 40-bit/48-bit.
Current driver code checks priv->dma_cap.addr64 to use certain format
with certain configuration.

This patch converts the format of DMA transmit descriptors on platforms
that the DMA AXI address width is configured to 32-bit (as described by
function comments of stmmac_tso_xmit() in current code) to a more generic
format (see the updated function comments after this patch) which is
actually already used on 40-bit/48-bit platforms to provide better
compatibility and make code flow cleaner.

Tested and verified on:
DWMAC CORE 5.10a with 32-bit DMA AXI address width
DWXGMAC CORE 3.20a with 40-bit DMA AXI address width

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 60 ++++++++-----------
 1 file changed, 24 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 16b8bcfa8b11..a48b7cf74a29 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4121,11 +4121,7 @@ static void stmmac_tso_allocator(struct stmmac_priv *priv, dma_addr_t des,
 			desc = &tx_q->dma_tx[tx_q->cur_tx];
 
 		curr_addr = des + (total_len - tmp_len);
-		if (priv->dma_cap.addr64 <= 32)
-			desc->des0 = cpu_to_le32(curr_addr);
-		else
-			stmmac_set_desc_addr(priv, desc, curr_addr);
-
+		stmmac_set_desc_addr(priv, desc, curr_addr);
 		buff_size = tmp_len >= TSO_MAX_BUFF_SIZE ?
 			    TSO_MAX_BUFF_SIZE : tmp_len;
 
@@ -4171,17 +4167,27 @@ static void stmmac_flush_tx_descriptors(struct stmmac_priv *priv, int queue)
  *  First Descriptor
  *   --------
  *   | DES0 |---> buffer1 = L2/L3/L4 header
- *   | DES1 |---> TCP Payload (can continue on next descr...)
- *   | DES2 |---> buffer 1 and 2 len
+ *   | DES1 |---> can be used as buffer2 for TCP Payload if the DMA AXI address
+ *   |      |     width is 32-bit, but we never use it.
+ *   |      |     Also can be used as the most-significant 8-bits or 16-bits of
+ *   |      |     buffer1 address pointer if the DMA AXI address width is 40-bit
+ *   |      |     or 48-bit, and we always use it.
+ *   | DES2 |---> buffer1 len
  *   | DES3 |---> must set TSE, TCP hdr len-> [22:19]. TCP payload len [17:0]
  *   --------
+ *   --------
+ *   | DES0 |---> buffer1 = TCP Payload (can continue on next descr...)
+ *   | DES1 |---> same as the First Descriptor
+ *   | DES2 |---> buffer1 len
+ *   | DES3 |
+ *   --------
  *	|
  *     ...
  *	|
  *   --------
- *   | DES0 | --| Split TCP Payload on Buffers 1 and 2
- *   | DES1 | --|
- *   | DES2 | --> buffer 1 and 2 len
+ *   | DES0 |---> buffer1 = Split TCP Payload
+ *   | DES1 |---> same as the First Descriptor
+ *   | DES2 |---> buffer1 len
  *   | DES3 |
  *   --------
  *
@@ -4191,15 +4197,14 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct dma_desc *desc, *first, *mss_desc = NULL;
 	struct stmmac_priv *priv = netdev_priv(dev);
-	int tmp_pay_len = 0, first_tx, nfrags;
 	unsigned int first_entry, tx_packets;
 	struct stmmac_txq_stats *txq_stats;
 	struct stmmac_tx_queue *tx_q;
 	u32 pay_len, mss, queue;
-	dma_addr_t tso_des, des;
+	int i, first_tx, nfrags;
 	u8 proto_hdr_len, hdr;
+	dma_addr_t des;
 	bool set_ic;
-	int i;
 
 	/* Always insert VLAN tag to SKB payload for TSO frames.
 	 *
@@ -4284,24 +4289,9 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (dma_mapping_error(priv->device, des))
 		goto dma_map_err;
 
-	if (priv->dma_cap.addr64 <= 32) {
-		first->des0 = cpu_to_le32(des);
-
-		/* Fill start of payload in buff2 of first descriptor */
-		if (pay_len)
-			first->des1 = cpu_to_le32(des + proto_hdr_len);
-
-		/* If needed take extra descriptors to fill the remaining payload */
-		tmp_pay_len = pay_len - TSO_MAX_BUFF_SIZE;
-		tso_des = des;
-	} else {
-		stmmac_set_desc_addr(priv, first, des);
-		tmp_pay_len = pay_len;
-		tso_des = des + proto_hdr_len;
-		pay_len = 0;
-	}
-
-	stmmac_tso_allocator(priv, tso_des, tmp_pay_len, (nfrags == 0), queue);
+	stmmac_set_desc_addr(priv, first, des);
+	stmmac_tso_allocator(priv, des + proto_hdr_len, pay_len,
+			     (nfrags == 0), queue);
 
 	/* In case two or more DMA transmit descriptors are allocated for this
 	 * non-paged SKB data, the DMA buffer address should be saved to
@@ -4405,11 +4395,9 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	/* Complete the first descriptor before granting the DMA */
-	stmmac_prepare_tso_tx_desc(priv, first, 1,
-			proto_hdr_len,
-			pay_len,
-			1, tx_q->tx_skbuff_dma[first_entry].last_segment,
-			hdr / 4, (skb->len - proto_hdr_len));
+	stmmac_prepare_tso_tx_desc(priv, first, 1, proto_hdr_len, 0, 1,
+				   tx_q->tx_skbuff_dma[first_entry].last_segment,
+				   hdr / 4, (skb->len - proto_hdr_len));
 
 	/* If context desc is used to change MSS */
 	if (mss_desc) {
-- 
2.34.1


