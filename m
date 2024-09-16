Return-Path: <netdev+bounces-128474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FA0979B02
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 08:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68C87B231B8
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 06:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43604D8CC;
	Mon, 16 Sep 2024 06:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="WsTtGOZP"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456954174C;
	Mon, 16 Sep 2024 06:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726467184; cv=none; b=fui3ZkOFJqS+udXFr34FPQ9NCnOBKo8W8Xud2+YP9Dc3IHHVxpur2evJsoSi6am3Wnf+/7h6MpxHOKze3xlsZ78JvFEpKgjC28YrtLyoVxocXyW1NFGv29f1WPjR0QhrAV1L651+5dtoIgajD+sL1To+rpRTNa7OWgbvTO7/5Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726467184; c=relaxed/simple;
	bh=qH47oae7xV799PY1O9ArLGWv47UZIj6mX/xyhBn5P0A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WkkavmbwbVYcw4GJshwEEj3+dX+qJ8Ax6yzq+o2bLUMtdNcr5H8yG9jru3exB810mggxGL/mV7XkTi0uIbW6BLe0SZO6/vQwyc5dh/8+IzvV9l1EC9yrpQtLjxTq6g1vSi2aSLiP1v/2p08JASmyb5dkcUWS9WqneVWMy04cubQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=WsTtGOZP; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 049D1100002;
	Mon, 16 Sep 2024 09:04:26 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1726466666; bh=aMvX9QVU5OXaxXIFkw06V1Szly2/pKcrmasnSySGh9w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=WsTtGOZPPTQd8/R9/KLizfBPugXGboCX3TloqoTmTI8ZaWTCn5CkJK6TXX/ngLgZQ
	 KkfdhF4TxZmHozcAlXYkN855wqmVNy4+Sk2Iph5HtzFt1v8km2myZj2XurWXWawlM7
	 +ismKjxvsZT3rXiZre8Dn98WRx6PoIA2OCHcB2Ug70q7bt78SOYGTEHAgix8qvZbic
	 oluJAYHyrimN5E6woP8Kv84am+mzS2HAAanOmJuOmZ6j7u8wRywX33ur8AoSw6TqF6
	 zHwtM6jiiHhlyQ/Qzeo7MMzDEEjzDL7tPPRjpRW8mGB9DwQIGp1qW1/HZ2FaGrtA5B
	 dJIWDW3Hb029g==
Received: from mx1.t-argos.ru.ru (mail.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Mon, 16 Sep 2024 09:03:13 +0300 (MSK)
Received: from Comp.ta.t-argos.ru (172.17.44.124) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 16 Sep
 2024 09:02:53 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Veerasenareddy Burru <vburru@marvell.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Sathesh Edara <sedara@marvell.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Abhijit
 Ayarekar <aayarekar@marvell.com>, Satananda Burla <sburla@marvell.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH net v2] octeon_ep: Add SKB allocation failures handling in __octep_oq_process_rx()
Date: Mon, 16 Sep 2024 09:02:12 +0300
Message-ID: <20240916060212.12393-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
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
X-KSMG-AntiSpam-Lua-Profiles: 187753 [Sep 15 2024]
X-KSMG-AntiSpam-Version: 6.1.1.5
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 34 0.3.34 8a1fac695d5606478feba790382a59668a4f0039, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;t-argos.ru:7.1.1;mx1.t-argos.ru.ru:7.1.1;127.0.0.199:7.1.2;lore.kernel.org:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/09/16 05:23:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/09/16 00:21:00 #26593326
X-KSMG-AntiVirus-Status: Clean, skipped

build_skb() returns NULL in case of a memory allocation failure so handle
it inside __octep_oq_process_rx() to avoid NULL pointer dereference.

__octep_oq_process_rx() is called during NAPI polling by the driver. If
skb allocation fails, keep on pulling packets out of the Rx DMA queue: we
shouldn't break the polling immediately and thus falsely indicate to the
octep_napi_poll() that the Rx pressure is going down. As there is no
associated skb in this case, don't process the packets and don't push them
up the network stack - they are skipped.

The common code with skb and some index manipulations is extracted to make
the fix more readable and avoid code duplication. Also helper function is
implemented to unmmap/flush all the fragment buffers used by the dropped
packet. 'alloc_failures' counter is incremented to mark the skb allocation
error in driver statistics.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 37d79d059606 ("octeon_ep: add Tx/Rx processing and interrupt support")
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
A similar situation is present in the __octep_vf_oq_process_rx() of the
Octeon VF driver. First we want to try the fix on __octep_oq_process_rx().

There are some doubts about increasing the 'rx_bytes'. On the one hand,
the data has not been processed, therefore, the counter does not need to
be increased. On the other hand, this counter is used to estimate the
bandwidth at the card's input.
In octeon_droq_fast_process_packet() from the Liquidio driver in
'droq->stats.bytes_received += total_len' everything that was received
from the device is considered.
/* Output Queue statistics. Each output queue has four stats fields. */
struct octep_oq_stats {
	/* Number of packets received from the Device. */
	u64 packets;
	/* Number of bytes received from the Device. */
	u64 bytes;
	/* Number of times failed to allocate buffers. */
	u64 alloc_failures;
};

Compile tested only.

v2: 
  - Implement helper instead of adding multiple checks for '!skb' and
    remove 'rx_bytes' increasing in case of packet dropping as suggested
    by Paolo
    (https://lore.kernel.org/all/ba514498-3706-413b-a09f-f577861eef28@redhat.com/)
v1: https://lore.kernel.org/all/20240906063907.9591-1-amishin@t-argos.ru/

 .../net/ethernet/marvell/octeon_ep/octep_rx.c | 80 +++++++++++++++----
 1 file changed, 64 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
index 4746a6b258f0..6b665263b9be 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
@@ -336,6 +336,51 @@ static int octep_oq_check_hw_for_pkts(struct octep_device *oct,
 	return new_pkts;
 }
 
+/**
+ * octep_oq_drop_rx() - Free the resources associated with a packet.
+ *
+ * @oq: Octeon Rx queue data structure.
+ * @buff_info: Current packet buffer info.
+ * @read_idx: Current packet index in the ring.
+ * @desc_used: Current packet descriptor number.
+ *
+ */
+static void octep_oq_drop_rx(struct octep_oq *oq,
+			     struct octep_rx_buffer *buff_info,
+			     u32 *read_idx, u32 *desc_used)
+{
+	dma_unmap_page(oq->dev, oq->desc_ring[*read_idx].buffer_ptr,
+		       PAGE_SIZE, DMA_FROM_DEVICE);
+	buff_info->page = NULL;
+	(*read_idx)++;
+	(*desc_used)++;
+	if (*read_idx == oq->max_count)
+		*read_idx = 0;
+
+	if (buff_info->len > oq->max_single_buffer_size) {
+		u16 data_len;
+		/* Head fragment includes response header(s);
+		 * subsequent fragments contains only data.
+		 */
+		data_len = buff_info->len - oq->max_single_buffer_size;
+		while (data_len) {
+			dma_unmap_page(oq->dev, oq->desc_ring[*read_idx].buffer_ptr,
+				       PAGE_SIZE, DMA_FROM_DEVICE);
+			buff_info = (struct octep_rx_buffer *)
+				     &oq->buff_info[*read_idx];
+			if (data_len < oq->buffer_size)
+				data_len = 0;
+			else
+				data_len -= oq->buffer_size;
+			buff_info->page = NULL;
+			(*read_idx)++;
+			(*desc_used)++;
+			if (*read_idx == oq->max_count)
+				*read_idx = 0;
+		}
+	}
+}
+
 /**
  * __octep_oq_process_rx() - Process hardware Rx queue and push to stack.
  *
@@ -367,10 +412,7 @@ static int __octep_oq_process_rx(struct octep_device *oct,
 	desc_used = 0;
 	for (pkt = 0; pkt < pkts_to_process; pkt++) {
 		buff_info = (struct octep_rx_buffer *)&oq->buff_info[read_idx];
-		dma_unmap_page(oq->dev, oq->desc_ring[read_idx].buffer_ptr,
-			       PAGE_SIZE, DMA_FROM_DEVICE);
 		resp_hw = page_address(buff_info->page);
-		buff_info->page = NULL;
 
 		/* Swap the length field that is in Big-Endian to CPU */
 		buff_info->len = be64_to_cpu(resp_hw->length);
@@ -394,31 +436,37 @@ static int __octep_oq_process_rx(struct octep_device *oct,
 			data_offset = OCTEP_OQ_RESP_HW_SIZE;
 			rx_ol_flags = 0;
 		}
+
+		skb = build_skb((void *)resp_hw, PAGE_SIZE);
+		if (!skb) {
+			octep_oq_drop_rx(oq, buff_info,
+					 &read_idx, &desc_used);
+			oq->stats.alloc_failures++;
+			continue;
+		}
+		skb_reserve(skb, data_offset);
+
+		dma_unmap_page(oq->dev, oq->desc_ring[read_idx].buffer_ptr,
+			       PAGE_SIZE, DMA_FROM_DEVICE);
+		buff_info->page = NULL;
+
+		read_idx++;
+		desc_used++;
+		if (read_idx == oq->max_count)
+			read_idx = 0;
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
-- 
2.30.2


