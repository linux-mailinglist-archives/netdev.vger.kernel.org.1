Return-Path: <netdev+bounces-204518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A834AFAFA0
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 11:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 093DD7AFD02
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 09:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5397828D8EA;
	Mon,  7 Jul 2025 09:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRp95toe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60075286412;
	Mon,  7 Jul 2025 09:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751880341; cv=none; b=ENJRSlE2Et4vGaU9qfo2JVqFzi0zIyvr3dIHc6rV7ErMP9z0InHFzVk/dRL8K2NdxMn7wM4BhcmNpHmpJuTIDC71g7IrdQzC3hIF8op0reEyU0T8H8AD3JvUbSz1PEdzmXQ7YYqeUPBB9sV2p8X83Q24t5NCoOPyjMyxW2xOqrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751880341; c=relaxed/simple;
	bh=kiu74TbM0Cl3ZxjxQf5ILMyGowXJ4logIX6ks4uEFoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B9VLv4pExNkHuqxXOwWCY+Szc0otC+CN2iKmbNduvxvRvH6jptDnXu4+aXUnhJFatjgr++sAqPzhQLuBsDh77kMa+EW2eEzkrKPNAR2tEwJcVgMrVz6Uw8QJcTEA+QFO8dv5o4nzME9ZDoGCZAqxy6sTbYW4E3ErRZHhB9/HTE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRp95toe; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4538a2fc7ffso27356545e9.0;
        Mon, 07 Jul 2025 02:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751880338; x=1752485138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uBfXlQ5Rh46iJk1Ot161EwZF/wssDqxpNViVgwXBrGk=;
        b=bRp95toeDbgrwusQafmBZUEdXNv4ROiYYXc2+FAM8iyo9b0ezluL+H6FDANqa5bWBx
         LR7fzL5MuVjKTUCkMkA9gWcJGwY/5DiSLTWjzGo8HWNNOwhN0Cr25nsfICj9uJbMTTLA
         Z3EKfbHhm/LogfvdQMoFKfYv6d/l7yJXgVED2/rHxXjCGjSkAbELL2MzA+Sb7oTH22pI
         uvGDU+XlRyiCKo4+VidVhZc1YqjtlBBR1DmWarCft8gHsHU+sNv4iXZ/wbYy6PTCyuN2
         4fHZNq8fVfVCO3uUjyK2Xd5BSP7Us2yySOpHhvRomyG9N/jBVVqXDWSA8fGeWA7JkHtx
         FlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751880338; x=1752485138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uBfXlQ5Rh46iJk1Ot161EwZF/wssDqxpNViVgwXBrGk=;
        b=UpBfamRd3iB1QdUjfeyMdLm259ESIZlkrGixZW00Kv+JQgMC+WkVWyxyZBBIjMJPSN
         jwKvKTFu1DuWnxEJXFMIXLEN64YVPYo0URF6LsvJ9+Y5eTdo94dxJ/EJb5HCn2vpD4tS
         dTSZzEAtRRxrcOxP/84xDAy2mFv5r+bL0NMTzagwblK97pvva47kZysIebPQqndj1eXu
         8EhT9DbCNkwzrXdeRtuP+c3WBE+5qEWdVb5dWx0k1xdxlOZzCzG39hRVSA/od5Bnt7Ir
         a4zGr8e+AUuMPnS3fnxAyzNRvtMcY5v4AXlcVF+jQ8qqLfELXHLN2x90OznNzkkrbDvM
         3u7g==
X-Forwarded-Encrypted: i=1; AJvYcCXDLbqNDBSJ9qWZODTTBWbxwqqpMOgnY+inm0UPV3/aT9/UfyJS41cTie9uNow5rAAaIEGwgikdabA63u0=@vger.kernel.org, AJvYcCXL3J9fkWlyE524AjvywkE9kyz3/J335oUG7vFbQ2SWeBhje5HFvYP7mI8pXVD1kcv3i2w9aPXg@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz0j1sySIhgfYUSWnDZ/5kQDS7gCgWy6dUedbapZuaLsEWIQEG
	lnI7rvDBHUuHHRoeakgCHuLTRsEvyjZK1VQzgg1Ww1IQVhsB4uSSTBk=
X-Gm-Gg: ASbGncvkjOCZqjhRE04u6p6IXGMg1P710TjUaakZhLDtai6xOwjWE6Tenw73wPxQST6
	e5Vufa1oYj7cD9RnZGkIGfAGCZ1dW2VjH/zDFfZ8kZTND8ROToSRQA1Tyr4hevJSa5g5QBqHzjb
	m/kqQFBPs4DVr98WaeK/tTTatM5t/UbrLW386Se52Y2IU/yoyhGrBQhyZEp/YY7ygD3XTK6KrU8
	LwNOjThHG6Kszm7bMnYwKkJNQcR6C2glv11srKvxPZFXCqjEvCpqocY3c4wsyHUhLQwiYK+jmG2
	76GiSMoexkGjbYYVuDmkeMmQu61xoQIaCKR7c3LTXyl8Y7GYjdcCEnFgCo/ZrLx9NvaygB6Ws3v
	hZ8aXUCZa
X-Google-Smtp-Source: AGHT+IGmJIakfH6RwdWQXAB2RSk4UIYPuqWeGj9ECYYOi5nFOPPfRxhO4I42se2wJJpaehcK/1mujA==
X-Received: by 2002:a05:600c:1da0:b0:453:835a:db with SMTP id 5b1f17b1804b1-454b1f471fdmr96857885e9.4.1751880337364;
        Mon, 07 Jul 2025 02:25:37 -0700 (PDT)
Received: from phoenix.rocket.internal ([2a12:26c0:2205:8802:9bf5:fd10:aa7f:bd06])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454b1890626sm108671325e9.40.2025.07.07.02.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 02:25:36 -0700 (PDT)
From: Rui Salvaterra <rsalvaterra@gmail.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: edumazet@google.com,
	kuba@kernel.org,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rui Salvaterra <rsalvaterra@gmail.com>
Subject: [PATCH iwl-next] igc: demote register and ring dumps to debug
Date: Mon,  7 Jul 2025 10:17:10 +0100
Message-ID: <20250707092531.365663-1-rsalvaterra@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is debug information, upon which the user is not expected to act. Output as
such. This avoids polluting the dmesg with full register dumps at every link
down.

Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
---

This file hasn't been touched in over four years, it's probably from a time when
the driver was under heavy development (started in 2018). Nevertheless, the
status quo is positively annoying. :)

 drivers/net/ethernet/intel/igc/igc_dump.c | 54 +++++++++++------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_dump.c b/drivers/net/ethernet/intel/igc/igc_dump.c
index c09c95cc5f70..e84d09ca8e67 100644
--- a/drivers/net/ethernet/intel/igc/igc_dump.c
+++ b/drivers/net/ethernet/intel/igc/igc_dump.c
@@ -98,13 +98,13 @@ static void igc_regdump(struct igc_hw *hw, struct igc_reg_info *reginfo)
 			regs[n] = rd32(IGC_TXDCTL(n));
 		break;
 	default:
-		netdev_info(dev, "%-15s %08x\n", reginfo->name,
+		netdev_dbg(dev, "%-15s %08x\n", reginfo->name,
 			    rd32(reginfo->ofs));
 		return;
 	}
 
 	snprintf(rname, 16, "%s%s", reginfo->name, "[0-3]");
-	netdev_info(dev, "%-15s %08x %08x %08x %08x\n", rname, regs[0], regs[1],
+	netdev_dbg(dev, "%-15s %08x %08x %08x %08x\n", rname, regs[0], regs[1],
 		    regs[2], regs[3]);
 }
 
@@ -123,22 +123,22 @@ void igc_rings_dump(struct igc_adapter *adapter)
 	if (!netif_msg_hw(adapter))
 		return;
 
-	netdev_info(netdev, "Device info: state %016lX trans_start %016lX\n",
+	netdev_dbg(netdev, "Device info: state %016lX trans_start %016lX\n",
 		    netdev->state, dev_trans_start(netdev));
 
 	/* Print TX Ring Summary */
 	if (!netif_running(netdev))
 		goto exit;
 
-	netdev_info(netdev, "TX Rings Summary\n");
-	netdev_info(netdev, "Queue [NTU] [NTC] [bi(ntc)->dma  ] leng ntw timestamp\n");
+	netdev_dbg(netdev, "TX Rings Summary\n");
+	netdev_dbg(netdev, "Queue [NTU] [NTC] [bi(ntc)->dma  ] leng ntw timestamp\n");
 	for (n = 0; n < adapter->num_tx_queues; n++) {
 		struct igc_tx_buffer *buffer_info;
 
 		tx_ring = adapter->tx_ring[n];
 		buffer_info = &tx_ring->tx_buffer_info[tx_ring->next_to_clean];
 
-		netdev_info(netdev, "%5d %5X %5X %016llX %04X %p %016llX\n",
+		netdev_dbg(netdev, "%5d %5X %5X %016llX %04X %p %016llX\n",
 			    n, tx_ring->next_to_use, tx_ring->next_to_clean,
 			    (u64)dma_unmap_addr(buffer_info, dma),
 			    dma_unmap_len(buffer_info, len),
@@ -150,7 +150,7 @@ void igc_rings_dump(struct igc_adapter *adapter)
 	if (!netif_msg_tx_done(adapter))
 		goto rx_ring_summary;
 
-	netdev_info(netdev, "TX Rings Dump\n");
+	netdev_dbg(netdev, "TX Rings Dump\n");
 
 	/* Transmit Descriptor Formats
 	 *
@@ -165,11 +165,11 @@ void igc_rings_dump(struct igc_adapter *adapter)
 
 	for (n = 0; n < adapter->num_tx_queues; n++) {
 		tx_ring = adapter->tx_ring[n];
-		netdev_info(netdev, "------------------------------------\n");
-		netdev_info(netdev, "TX QUEUE INDEX = %d\n",
+		netdev_dbg(netdev, "------------------------------------\n");
+		netdev_dbg(netdev, "TX QUEUE INDEX = %d\n",
 			    tx_ring->queue_index);
-		netdev_info(netdev, "------------------------------------\n");
-		netdev_info(netdev, "T [desc]     [address 63:0  ] [PlPOCIStDDM Ln] [bi->dma       ] leng  ntw timestamp        bi->skb\n");
+		netdev_dbg(netdev, "------------------------------------\n");
+		netdev_dbg(netdev, "T [desc]     [address 63:0  ] [PlPOCIStDDM Ln] [bi->dma       ] leng  ntw timestamp        bi->skb\n");
 
 		for (i = 0; tx_ring->desc && (i < tx_ring->count); i++) {
 			const char *next_desc;
@@ -188,7 +188,7 @@ void igc_rings_dump(struct igc_adapter *adapter)
 			else
 				next_desc = "";
 
-			netdev_info(netdev, "T [0x%03X]    %016llX %016llX %016llX %04X  %p %016llX %p%s\n",
+			netdev_dbg(netdev, "T [0x%03X]    %016llX %016llX %016llX %04X  %p %016llX %p%s\n",
 				    i, le64_to_cpu(u0->a),
 				    le64_to_cpu(u0->b),
 				    (u64)dma_unmap_addr(buffer_info, dma),
@@ -198,7 +198,7 @@ void igc_rings_dump(struct igc_adapter *adapter)
 				    buffer_info->skb, next_desc);
 
 			if (netif_msg_pktdata(adapter) && buffer_info->skb)
-				print_hex_dump(KERN_INFO, "",
+				print_hex_dump(KERN_DEBUG, "",
 					       DUMP_PREFIX_ADDRESS,
 					       16, 1, buffer_info->skb->data,
 					       dma_unmap_len(buffer_info, len),
@@ -208,11 +208,11 @@ void igc_rings_dump(struct igc_adapter *adapter)
 
 	/* Print RX Rings Summary */
 rx_ring_summary:
-	netdev_info(netdev, "RX Rings Summary\n");
-	netdev_info(netdev, "Queue [NTU] [NTC]\n");
+	netdev_dbg(netdev, "RX Rings Summary\n");
+	netdev_dbg(netdev, "Queue [NTU] [NTC]\n");
 	for (n = 0; n < adapter->num_rx_queues; n++) {
 		rx_ring = adapter->rx_ring[n];
-		netdev_info(netdev, "%5d %5X %5X\n", n, rx_ring->next_to_use,
+		netdev_dbg(netdev, "%5d %5X %5X\n", n, rx_ring->next_to_use,
 			    rx_ring->next_to_clean);
 	}
 
@@ -220,7 +220,7 @@ void igc_rings_dump(struct igc_adapter *adapter)
 	if (!netif_msg_rx_status(adapter))
 		goto exit;
 
-	netdev_info(netdev, "RX Rings Dump\n");
+	netdev_dbg(netdev, "RX Rings Dump\n");
 
 	/* Advanced Receive Descriptor (Read) Format
 	 *    63                                           1        0
@@ -245,12 +245,12 @@ void igc_rings_dump(struct igc_adapter *adapter)
 
 	for (n = 0; n < adapter->num_rx_queues; n++) {
 		rx_ring = adapter->rx_ring[n];
-		netdev_info(netdev, "------------------------------------\n");
-		netdev_info(netdev, "RX QUEUE INDEX = %d\n",
+		netdev_dbg(netdev, "------------------------------------\n");
+		netdev_dbg(netdev, "RX QUEUE INDEX = %d\n",
 			    rx_ring->queue_index);
-		netdev_info(netdev, "------------------------------------\n");
-		netdev_info(netdev, "R  [desc]      [ PktBuf     A0] [  HeadBuf   DD] [bi->dma       ] [bi->skb] <-- Adv Rx Read format\n");
-		netdev_info(netdev, "RWB[desc]      [PcsmIpSHl PtRs] [vl er S cks ln] ---------------- [bi->skb] <-- Adv Rx Write-Back format\n");
+		netdev_dbg(netdev, "------------------------------------\n");
+		netdev_dbg(netdev, "R  [desc]      [ PktBuf     A0] [  HeadBuf   DD] [bi->dma       ] [bi->skb] <-- Adv Rx Read format\n");
+		netdev_dbg(netdev, "RWB[desc]      [PcsmIpSHl PtRs] [vl er S cks ln] ---------------- [bi->skb] <-- Adv Rx Write-Back format\n");
 
 		for (i = 0; i < rx_ring->count; i++) {
 			const char *next_desc;
@@ -270,13 +270,13 @@ void igc_rings_dump(struct igc_adapter *adapter)
 
 			if (staterr & IGC_RXD_STAT_DD) {
 				/* Descriptor Done */
-				netdev_info(netdev, "%s[0x%03X]     %016llX %016llX ---------------- %s\n",
+				netdev_dbg(netdev, "%s[0x%03X]     %016llX %016llX ---------------- %s\n",
 					    "RWB", i,
 					    le64_to_cpu(u0->a),
 					    le64_to_cpu(u0->b),
 					    next_desc);
 			} else {
-				netdev_info(netdev, "%s[0x%03X]     %016llX %016llX %016llX %s\n",
+				netdev_dbg(netdev, "%s[0x%03X]     %016llX %016llX %016llX %s\n",
 					    "R  ", i,
 					    le64_to_cpu(u0->a),
 					    le64_to_cpu(u0->b),
@@ -285,7 +285,7 @@ void igc_rings_dump(struct igc_adapter *adapter)
 
 				if (netif_msg_pktdata(adapter) &&
 				    buffer_info->dma && buffer_info->page) {
-					print_hex_dump(KERN_INFO, "",
+					print_hex_dump(KERN_DEBUG, "",
 						       DUMP_PREFIX_ADDRESS,
 						       16, 1,
 						       page_address
@@ -309,8 +309,8 @@ void igc_regs_dump(struct igc_adapter *adapter)
 	struct igc_reg_info *reginfo;
 
 	/* Print Registers */
-	netdev_info(adapter->netdev, "Register Dump\n");
-	netdev_info(adapter->netdev, "Register Name   Value\n");
+	netdev_dbg(adapter->netdev, "Register Dump\n");
+	netdev_dbg(adapter->netdev, "Register Name   Value\n");
 	for (reginfo = (struct igc_reg_info *)igc_reg_info_tbl;
 	     reginfo->name; reginfo++) {
 		igc_regdump(hw, reginfo);
-- 
2.49.0


