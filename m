Return-Path: <netdev+bounces-136514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E85309A1F79
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 12:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ABEA1F28BF0
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 10:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2DF1D9A41;
	Thu, 17 Oct 2024 10:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="S2bnxns9"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750F91D9677;
	Thu, 17 Oct 2024 10:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729159768; cv=none; b=NbujYgQRUcr7J+Nw7MvS5PUgHmX3nSREb4m2rHwbxKzyNRmmbeXZF9xGkYCAF6NBwZwDrUAEDz+iiiS8kGO5wuJFUSpSqapbzSn2hzEOFbefIBEZs8KPF4/aQXqkQuJNk924KuNfVx0WOgKwOVdtw0pqEV/WpoNnTHZRFwbCFLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729159768; c=relaxed/simple;
	bh=iBDHNPmA0rZe8zhFkOEkuSp9OXesrimhWdyxHD9fRnw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S18K3t77AbYFqPHhdQzGg4EeWETiDJKE68VqiEQhh1CADlH1ltXVhrESNojEdDLTgRbzaaduIfTnZV1tXCo2lDFhkyW6SwXi1/jLoevpPr65JBJt7t/EOvqPVepWqCgfB/iPYPOeM98rQM6d5oM092b6UdKB3RFIBOKpoBo4+TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=S2bnxns9; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 8191D10000A;
	Thu, 17 Oct 2024 13:09:07 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1729159747; bh=uRYLmJ8aJYKdwU/1v18RZIA4g8rsNWlg2Md1dnpX5jA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=S2bnxns9ZQT+mBADwS4p21uOEw0oGU02K6vdQBut/Iv2inWH7Z6LbocxYORB+oOpQ
	 6scIL5Y+8CwXJrXfmdWimXGg8FExMmCn1pqHykFsJVZJAdjW/R6PVMP1+ZX0yE7Maj
	 RsjowLPh9Z7siMuMs2DzxwxAB6SMQZfxI3gE/V+6TGW+29AERlODQOujcTKRVtsY8M
	 k9R04+/CzFGxH2czis+YQOFmxZMSLJucQte7d8gFM98G4t4SyanaXJVnuj3sLBNWl/
	 ZQxjHmT9u9At/XpO3nshhHii3xOwpJeNtjx9/Z/73PsxRx5Wj0QOsWVo9r1YPM7KYr
	 lPkB3VBAoAKQA==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Thu, 17 Oct 2024 13:08:00 +0300 (MSK)
Received: from Comp.ta.t-argos.ru (172.17.44.124) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 17 Oct
 2024 13:07:05 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Veerasenareddy Burru <vburru@marvell.com>, Abhijit Ayarekar
	<aayarekar@marvell.com>, Satananda Burla <sburla@marvell.com>, Sathesh Edara
	<sedara@marvell.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, Simon Horman
	<horms@kernel.org>
Subject: [PATCH net v5 1/2] octeon_ep: Implement helper for iterating packets in Rx queue
Date: Thu, 17 Oct 2024 13:06:50 +0300
Message-ID: <20241017100651.15863-2-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241017100651.15863-1-amishin@t-argos.ru>
References: <20241017100651.15863-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 188506 [Oct 17 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 39 0.3.39 e168d0b3ce73b485ab2648dd465313add1404cce, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, mx1.t-argos.ru.ru:7.1.1;t-argos.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;lore.kernel.org:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/10/17 09:58:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/10/17 05:21:00 #26765332
X-KSMG-AntiVirus-Status: Clean, skipped

The common code with some packet and index manipulations is extracted and
moved to newly implemented helper to make the code more readable and avoid
duplication. This is a preparation for skb allocation failure handling.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Suggested-by: Simon Horman <horms@kernel.org>
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
Compile tested only.

v5:
  - Unmap paged buffer before the skb creation as suggested by Paolo
    (https://lore.kernel.org/all/cf656975-69b4-427e-8769-d16575774bba@redhat.com/)
v4: https://lore.kernel.org/all/20241012094950.9438-1-amishin@t-argos.ru/
  - Split patch up as suggested by Jakub
    (https://lore.kernel.org/all/20241004073311.223efca4@kernel.org/)
v3: https://lore.kernel.org/all/20240930053328.9618-1-amishin@t-argos.ru/
  - Implement helper which frees current packet resources and increase
    index and descriptor as suggested by Simon
    (https://lore.kernel.org/all/20240919134812.GB1571683@kernel.org/)
  - v3 has been reviewed-by Simon Horman
    (https://lore.kernel.org/all/20240930162622.GF1310185@kernel.org/)
v1: https://lore.kernel.org/all/20240906063907.9591-1-amishin@t-argos.ru/

 .../net/ethernet/marvell/octeon_ep/octep_rx.c | 55 +++++++++++--------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
index 4746a6b258f0..a889c1510518 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
@@ -336,6 +336,30 @@ static int octep_oq_check_hw_for_pkts(struct octep_device *oct,
 	return new_pkts;
 }
 
+/**
+ * octep_oq_next_pkt() - Move to the next packet in Rx queue.
+ *
+ * @oq: Octeon Rx queue data structure.
+ * @buff_info: Current packet buffer info.
+ * @read_idx: Current packet index in the ring.
+ * @desc_used: Current packet descriptor number.
+ *
+ * Free the resources associated with a packet.
+ * Increment packet index in the ring and packet descriptor number.
+ */
+static void octep_oq_next_pkt(struct octep_oq *oq,
+			      struct octep_rx_buffer *buff_info,
+			      u32 *read_idx, u32 *desc_used)
+{
+	dma_unmap_page(oq->dev, oq->desc_ring[*read_idx].buffer_ptr,
+		       PAGE_SIZE, DMA_FROM_DEVICE);
+	buff_info->page = NULL;
+	(*read_idx)++;
+	(*desc_used)++;
+	if (*read_idx == oq->max_count)
+		*read_idx = 0;
+}
+
 /**
  * __octep_oq_process_rx() - Process hardware Rx queue and push to stack.
  *
@@ -367,10 +391,7 @@ static int __octep_oq_process_rx(struct octep_device *oct,
 	desc_used = 0;
 	for (pkt = 0; pkt < pkts_to_process; pkt++) {
 		buff_info = (struct octep_rx_buffer *)&oq->buff_info[read_idx];
-		dma_unmap_page(oq->dev, oq->desc_ring[read_idx].buffer_ptr,
-			       PAGE_SIZE, DMA_FROM_DEVICE);
 		resp_hw = page_address(buff_info->page);
-		buff_info->page = NULL;
 
 		/* Swap the length field that is in Big-Endian to CPU */
 		buff_info->len = be64_to_cpu(resp_hw->length);
@@ -394,36 +415,27 @@ static int __octep_oq_process_rx(struct octep_device *oct,
 			data_offset = OCTEP_OQ_RESP_HW_SIZE;
 			rx_ol_flags = 0;
 		}
+
+		octep_oq_next_pkt(oq, buff_info, &read_idx, &desc_used);
+
+		skb = build_skb((void *)resp_hw, PAGE_SIZE);
+		skb_reserve(skb, data_offset);
+
 		rx_bytes += buff_info->len;
 
 		if (buff_info->len <= oq->max_single_buffer_size) {
-			skb = build_skb((void *)resp_hw, PAGE_SIZE);
-			skb_reserve(skb, data_offset);
 			skb_put(skb, buff_info->len);
-			read_idx++;
-			desc_used++;
-			if (read_idx == oq->max_count)
-				read_idx = 0;
 		} else {
 			struct skb_shared_info *shinfo;
 			u16 data_len;
 
-			skb = build_skb((void *)resp_hw, PAGE_SIZE);
-			skb_reserve(skb, data_offset);
 			/* Head fragment includes response header(s);
 			 * subsequent fragments contains only data.
 			 */
 			skb_put(skb, oq->max_single_buffer_size);
-			read_idx++;
-			desc_used++;
-			if (read_idx == oq->max_count)
-				read_idx = 0;
-
 			shinfo = skb_shinfo(skb);
 			data_len = buff_info->len - oq->max_single_buffer_size;
 			while (data_len) {
-				dma_unmap_page(oq->dev, oq->desc_ring[read_idx].buffer_ptr,
-					       PAGE_SIZE, DMA_FROM_DEVICE);
 				buff_info = (struct octep_rx_buffer *)
 					    &oq->buff_info[read_idx];
 				if (data_len < oq->buffer_size) {
@@ -438,11 +450,8 @@ static int __octep_oq_process_rx(struct octep_device *oct,
 						buff_info->page, 0,
 						buff_info->len,
 						buff_info->len);
-				buff_info->page = NULL;
-				read_idx++;
-				desc_used++;
-				if (read_idx == oq->max_count)
-					read_idx = 0;
+
+				octep_oq_next_pkt(oq, buff_info, &read_idx, &desc_used);
 			}
 		}
 
-- 
2.30.2


