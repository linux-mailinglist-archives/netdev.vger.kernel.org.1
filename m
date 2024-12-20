Return-Path: <netdev+bounces-153615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF229F8DB8
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 09:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CA52165121
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 08:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48EE19FA9D;
	Fri, 20 Dec 2024 08:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6uv1u3w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487CD13AA35;
	Fri, 20 Dec 2024 08:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734682078; cv=none; b=EKDfyxULCPRMfU5/27CusmbxTUQRS1hqHm8fWYiKVKu1xzmvBmnejmpqgaZy+kNb7uDhNSXNVtlwusp0i+MarGu3CSEsC8jd4MzmRwtdW70qOmUsKMqHGym9MoS+UiWpKhwJZHqMJPRv96DeiywJ2JnTLfw+xDe+3pajv++UGk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734682078; c=relaxed/simple;
	bh=Os0/4BExeAWdiLqJzkfOpTkP1tVgSEnrkHQYdiCVAqA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qFKFL1cXGaenyQJZU/n8XQWLSLg3+SwIjzytmAvqGYA6SHdFdVO13NCaqPNHYCiP6p9vJmKv2muHyv4lol0RR6ybPpIwh/tlw+MVxJMXhS0hOwCPoPBIv6vSvJVEqEbWjaF0cxfdA14uT24VwKKNyDJz2Ff8ACG6IPzO9gTy1fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6uv1u3w; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7fd51285746so1008966a12.3;
        Fri, 20 Dec 2024 00:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734682076; x=1735286876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sIHIgWFpQUvX2jXNx2azeaWpatd549ZsSnWm31PKQmM=;
        b=c6uv1u3w3B0+Qde0EAg3gxB6oagPkUl0+uIr9YOlab47tH7T3bG7liui3fqzXXj1bI
         ue05yDj5mAhAvC7RqNzZeArnj8X9SSWDphs0YEhDdYNlsSIGL1/T/tjbwtBkattDXNab
         6QUpB+ZxF/yGU8B9Q3Sje0CgjE2lJjih4ukE0JiQ8g7AXAXROq7sqo5BimwkiGeA7nUW
         G9s9uwaLcDH8maw3GN/vCN8FCMltQLxDAoqP/F/XgZJWzzkqmRaXRLPEhBhsP61GeaW2
         Ya2f3VjWOUvYoBksoIyI21NOv6H/ZJZ9gxtWP2VpsZVSUYY43LlMY8/TKeWJyDCXgu4r
         Gzrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734682076; x=1735286876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sIHIgWFpQUvX2jXNx2azeaWpatd549ZsSnWm31PKQmM=;
        b=nKfo44QIgkcF0VKWfyiG1XF0U/XZGUDMAvVx1i5GrejqAAb/3Cv2FxhTVaLPSWFLmv
         +bx47OgQN714hhkSVIPLmZGcPJ3P4JbwTYU+SnvsLzO3043MFfPlNNFKkG5ZTBotLuU9
         NHpPWFWyxf784UrgxPIsnkX4L/RPFkFH4mysS+Vu+AmWqgqsUF3vzaN4RwPhD+kE/H/M
         lPgMgBwfzacmWDxTSMaoNpQRks0GKbnZDU5h2ba5Blntx1KePEZ9fc1X9ipWDtAwsSLa
         anschQlADQAJ7y/UxGyQVTdbxs4u04QHbEtIPSE8WwKR6tv2wudc1fFXk1bAy6xtzXNg
         FfZw==
X-Forwarded-Encrypted: i=1; AJvYcCWWI45QgRl8fSmp/GMlejkjt0Hao0zEm9rejlrbwG06yjYizls4C5jTJ5S7NEHG9pX5kM+wmK7DzLXhrwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaC1AFkQw5MJHA8NGfYgU72JfgxmFzVcxFJa97ycYnBOJgTwFa
	Z9WMbG2Chxz9CV1kMEM4MR3DgO61p72UC6+mxb/qzU96qzx9Ijut0o4YJQ==
X-Gm-Gg: ASbGnctpleMTaSoR1rvsd6DhiWRyKfoLCB8IHSjHFYOi8ng9azr4I8MAfFwd8J/ZBkx
	bO2eYZn0k2kcCpAi5bZ2KjSph2ZirDucb31ZGK0z8FoerlLn+jHqiih3K2L1l9bElA78ZLYI4SZ
	NDAZWEqRgVC9rtZXXomFZFljz7wHdGALnntqnXEPbqruO9nFjg+CXUch68AwX7ZnbBvkk5e1Or8
	8IgMBu7TtE+/+XynB7r2aOJU/KfkZIm8iT8i4fDj38w6yOO0sUjojD0/1x69vtzvRXgDw==
X-Google-Smtp-Source: AGHT+IG/D9plEVilAERZI3fidpIBW8JkrUOdC70JJmLdSIf9OIsnZlzX/HnlT4jua2CEoZFs6bN1Fw==
X-Received: by 2002:a17:90b:5487:b0:2ee:d9f5:cfb4 with SMTP id 98e67ed59e1d1-2f452eeb66dmr2697667a91.36.1734682075918;
        Fri, 20 Dec 2024 00:07:55 -0800 (PST)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2f447883b0csm2971735a91.42.2024.12.20.00.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 00:07:55 -0800 (PST)
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
Subject: [PATCH net-next v2] net: stmmac: TSO: Simplify the code flow of DMA descriptor allocations
Date: Fri, 20 Dec 2024 16:07:26 +0800
Message-Id: <20241220080726.1733837-1-0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TCP Segmentation Offload (TSO) engine is an optional function in
DWMAC cores, it is implemented for dwmac4 and dwxgmac2 only, ancient
dwmac100 and dwmac1000 are not supported by hardware. Current driver
code checks priv->dma_cap.tsoen which is read from MAC_HW_Feature1
register to determine if TSO is enabled in hardware configurations,
if (!priv->dma_cap.tsoen) driver never sets NETIF_F_TSO for net_device.

This patch never affects dwmac100/dwmac1000 and their stmmac_desc_ops:
ndesc_ops/enh_desc_ops, since TSO is never supported by them two.

The DMA AXI address width of DWMAC cores can be configured to
32-bit/40-bit/48-bit, then the format of DMA transmit descriptors
get a little different between 32-bit and 40-bit/48-bit.
Current driver code checks priv->dma_cap.addr64 to use certain format
with certain configuration.

This patch converts the format of DMA transmit descriptors on dwmac4
and dwxgmac2 that the DMA AXI address width is configured to 32-bit (as
described by function comments of stmmac_tso_xmit() in current code) to
a more generic format (see updated function comments after this patch)
which is actually already used on 40-bit/48-bit platforms to provide
better compatibility and make code flow cleaner in TSO TX routine.

Another interesting finding, struct stmmac_desc_ops is a common abstract
interface to maintain descriptors, we should avoid the direct assignment
of descriptor members (e.g. desc->des0), stmmac_set_desc_addr() is the
proper method yet. This patch tries to improve this by the way.

Tested and verified on:
DWMAC CORE 5.00a with 32-bit DMA AXI address width
DWMAC CORE 5.10a with 32-bit DMA AXI address width
DWXGMAC CORE 3.20a with 40-bit DMA AXI address width

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
V1 -> V2: Update commit message
V1: https://lore.kernel.org/r/20241213030006.337695-1-0x1207@gmail.com
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 60 ++++++++-----------
 1 file changed, 24 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 6bc10ffe7a2b..99eaec8bac4a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4116,11 +4116,7 @@ static void stmmac_tso_allocator(struct stmmac_priv *priv, dma_addr_t des,
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
 
@@ -4166,17 +4162,27 @@ static void stmmac_flush_tx_descriptors(struct stmmac_priv *priv, int queue)
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
@@ -4186,15 +4192,14 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
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
@@ -4279,24 +4284,9 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
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
@@ -4400,11 +4390,9 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
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


