Return-Path: <netdev+bounces-130266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 027B7989A44
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 07:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A08FC1C211BE
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 05:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB15013D890;
	Mon, 30 Sep 2024 05:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="W+THLIow"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214551AACA;
	Mon, 30 Sep 2024 05:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727675238; cv=none; b=HxsEo2PYEdlOyq4YjFmgkhxeEF6UOvO+fpG7deqqDz45+x7adv9bojsYz1SbV2ikjUW8Y9LC35cUfSEymc7vIy4zoud2QACnSHL2Em3xMBNlnrP46abK7AM5111lAhMEF7Zk7VFFl2pyLEBHvHQ5u33ZyFEkbPKsYmmqCXyIQ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727675238; c=relaxed/simple;
	bh=1kZcWTw+uh9sYtCHqw6KUFDKIKE3BwedqrEdQsJrVyk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PZ70JA/JzxaMZ48qXENjgVIBnoqxmboIv0UixDbSsHmCSSGF85r+2sSW4Kd0VoX2d9VEMSkd3cQ/EEUlYNWJWQguzGUoWxu4kz9j0puWTs7cRZIRchT1TxsBhfWvmtmdUXZtddMOvFJlfrG42Z9qWNu5VUUw9e4OUDJvFj7F1C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=W+THLIow; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id AB550100003;
	Mon, 30 Sep 2024 08:35:23 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1727674523; bh=NYurvg8rUACXqby6TG/6lbGfV/8P2PMPQAjubImhlyQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=W+THLIowx8GF2buA8HSH0mdRv05UvJnEqZLhoiCX5+dNh0ph13Hno/Ym+ersNKnUH
	 bm5Y2FkrVpgziQqtbutw63n/WuFs/twxGDAqGRDehry73FlQCii24wBnLs6djLvNXV
	 YQ3Egw4Gcr5mEY4OUl81w/8f90lv6tOPmmLPGjd1NzRUJlJ6Vsa+8XAp1QEHV0xScW
	 OIMmpLLiymojj+DcYPwzqbpvFua2Fj6Z5dDj6e9Kr/i9Y4PRwmT47A2QdUpb00ue+j
	 TZgk1ld/8TXeZdm3ZLhiXnQIQVxl9VGHFf9hEwZA/G06MVvB3CergKBY2c5LmyaE5N
	 EzJ35oIRrG08A==
Received: from mx1.t-argos.ru.ru (mail.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Mon, 30 Sep 2024 08:34:09 +0300 (MSK)
Received: from Comp.ta.t-argos.ru (172.17.44.124) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 30 Sep
 2024 08:33:49 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Veerasenareddy Burru <vburru@marvell.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Sathesh Edara <sedara@marvell.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Abhijit
 Ayarekar <aayarekar@marvell.com>, Satananda Burla <sburla@marvell.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, Simon Horman <horms@kernel.org>
Subject: [PATCH net v3] octeon_ep: Add SKB allocation failures handling in __octep_oq_process_rx()
Date: Mon, 30 Sep 2024 08:33:28 +0300
Message-ID: <20240930053328.9618-1-amishin@t-argos.ru>
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
X-KSMG-AntiSpam-Lua-Profiles: 188073 [Sep 30 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 34 0.3.34 8a1fac695d5606478feba790382a59668a4f0039, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;t-argos.ru:7.1.1;lore.kernel.org:7.1.1;mx1.t-argos.ru.ru:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/09/30 05:30:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/09/30 05:07:00 #26684507
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
Suggested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
A similar situation is present in the __octep_vf_oq_process_rx() of the
Octeon VF driver. First we want to try the fix on __octep_oq_process_rx().

Compile tested only.

v3:
  - Implement helper which frees current packet resources and increase
    index and descriptor as suggested by Simon
    (https://lore.kernel.org/all/20240919134812.GB1571683@kernel.org/)
  - Optimize helper as suggested by Paolo
    (https://lore.kernel.org/all/b9ae8575-f903-425f-aa42-0c2a7605aa94@redhat.com/)	
v2: https://lore.kernel.org/all/20240916060212.12393-1-amishin@t-argos.ru/
  - Implement helper instead of adding multiple checks for '!skb' and
    remove 'rx_bytes' increasing in case of packet dropping as suggested
    by Paolo
    (https://lore.kernel.org/all/ba514498-3706-413b-a09f-f577861eef28@redhat.com/)
v1: https://lore.kernel.org/all/20240906063907.9591-1-amishin@t-argos.ru/

 .../net/ethernet/marvell/octeon_ep/octep_rx.c | 82 +++++++++++++------
 1 file changed, 59 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
index 4746a6b258f0..2d9d95071786 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
@@ -336,6 +336,51 @@ static int octep_oq_check_hw_for_pkts(struct octep_device *oct,
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
+	int data_len = buff_info->len - oq->max_single_buffer_size;
+
+	do {
+		octep_oq_next_pkt(oq, buff_info, read_idx, desc_used);
+		data_len -= oq->buffer_size;
+	} while (data_len > 0);
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
@@ -394,36 +436,33 @@ static int __octep_oq_process_rx(struct octep_device *oct,
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
+		octep_oq_next_pkt(oq, buff_info, &read_idx, &desc_used);
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
@@ -438,11 +477,8 @@ static int __octep_oq_process_rx(struct octep_device *oct,
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


