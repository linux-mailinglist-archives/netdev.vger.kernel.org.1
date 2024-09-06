Return-Path: <netdev+bounces-125800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C631696EAD2
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 08:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06611C2156E
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 06:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B648175F;
	Fri,  6 Sep 2024 06:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="C3kLgRiu"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8275A48;
	Fri,  6 Sep 2024 06:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725604888; cv=none; b=lyE8lOtZkf8h0rtHWtsyMcZiPnoObJMLaLR7eEbudBjlpsYKW6SNa+vmw+r+NHmAR4xzeqz6GaADxCBeJG6CMvAiyTd+M5HFUQWcZsuq2gRBIUwOdQshHsYzE6+5omRRO7Ig6zsyPs+DUbSClezbLzxbOoIouIbm0sg4NFyzbyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725604888; c=relaxed/simple;
	bh=lISy1XVK95E6juyFTlrJi6eGquNRUHVuITs9r4o9CKM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u9axdGlnsX6bIYqFoCuZqSFFNsBGUHrFIs09C0WHVwCK1fWVtT/G3dIGcir9nFRxOMKUEGrELqB9OX8C/dDzvQRz+a69R61K0eXTx7RNgByTVY9LXDyK3P2H1D+f7OLVTwAsl2v5G1vPF7BSqDVQTKz+8L4HLz2uGmRNGxt/7Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=C3kLgRiu; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 880A1100003;
	Fri,  6 Sep 2024 09:40:58 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1725604858; bh=G001kMIRwgSJpFj2NWZLKtCybZzFdTXkEYckfYsihfw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=C3kLgRiuehVH3lRCVJ0gr3WNg4Sqt/yU8Ttvc3OIv+Z5jx+u/AvtzkzH+lUtwscsB
	 2Ih2YC5TbzTbTlA8UHeGmHQu4YLGHEIYNBmlxIAYgrep2MqG5HNyaZQLj9PblxIJEL
	 bbI8HX8zWQPojG/r0K5nI/uHvVGy195hrUv0kQ4AHOqTmr5rL9HujYGmgo1oZitE3b
	 +zhdan2mVjECC/7fl7dckgfF1ljcxERZTFXFlb+dmyswd8vMMeIPRCjmZ0IM2i2TZp
	 eKDZJt7bMT5koPlmcthc1k5bwdnjfpDGHuaBjXmCgbXlHnW5oQCMLAEiR9sAV+mogd
	 8tVPiuHm4/F6g==
Received: from mx1.t-argos.ru.ru (mail.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Fri,  6 Sep 2024 09:39:50 +0300 (MSK)
Received: from localhost.localdomain (172.17.210.9) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Sep
 2024 09:39:27 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Veerasenareddy Burru <vburru@marvell.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Sathesh Edara <sedara@marvell.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Abhijit
 Ayarekar <aayarekar@marvell.com>, Satananda Burla <sburla@marvell.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH net] octeon_ep: Add SKB allocation failures handling in __octep_oq_process_rx()
Date: Fri, 6 Sep 2024 09:39:07 +0300
Message-ID: <20240906063907.9591-1-amishin@t-argos.ru>
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
X-KSMG-AntiSpam-Lua-Profiles: 187583 [Sep 06 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 32 0.3.32 766319f57b3d5e49f2c79a76e7d7087b621090df, {Tracking_from_domain_doesnt_match_to}, t-argos.ru:7.1.1;mx1.t-argos.ru.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/09/06 06:08:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/09/06 05:10:00 #26531716
X-KSMG-AntiVirus-Status: Clean, skipped

build_skb() returns NULL in case of a memory allocation failure so handle
it inside __octep_oq_process_rx() to avoid NULL pointer dereference.

__octep_oq_process_rx() is called during NAPI polling by the driver. If
skb allocation fails, keep on pulling packets out of the Rx DMA queue: we
shouldn't break the polling immediately and thus falsely indicate to the
octep_napi_poll() that the Rx pressure is going down. As there is no
associated skb in this case, don't process the packets and don't push them
up the network stack - they are skipped.

The common code with skb and index manipulations is extracted to make the
fix more readable and avoid code duplication. Also 'alloc_failures' counter
is incremented to mark the skb allocation error in driver statistics.

The suggested approach for handling buffer allocation failures in the NAPI
polling functions is also implemented in the Cavium Liquidio driver. It
has the same structure, namely in octeon_droq_fast_process_packets().

A similar situation is present in the __octep_vf_oq_process_rx() of the
Octeon VF driver. First we want to try the fix on __octep_oq_process_rx().

Compile tested only. Marvell folks, could you review and test this, please?

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 37d79d059606 ("octeon_ep: add Tx/Rx processing and interrupt support")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 .../net/ethernet/marvell/octeon_ep/octep_rx.c | 44 ++++++++++---------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
index 4746a6b258f0..e92afd1a372a 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
@@ -394,32 +394,32 @@ static int __octep_oq_process_rx(struct octep_device *oct,
 			data_offset = OCTEP_OQ_RESP_HW_SIZE;
 			rx_ol_flags = 0;
 		}
+
+		skb = build_skb((void *)resp_hw, PAGE_SIZE);
+		if (skb)
+			skb_reserve(skb, data_offset);
+		else
+			oq->stats.alloc_failures++;
 		rx_bytes += buff_info->len;
+		read_idx++;
+		desc_used++;
+		if (read_idx == oq->max_count)
+			read_idx = 0;
 
 		if (buff_info->len <= oq->max_single_buffer_size) {
-			skb = build_skb((void *)resp_hw, PAGE_SIZE);
-			skb_reserve(skb, data_offset);
-			skb_put(skb, buff_info->len);
-			read_idx++;
-			desc_used++;
-			if (read_idx == oq->max_count)
-				read_idx = 0;
+			if (skb)
+				skb_put(skb, buff_info->len);
 		} else {
 			struct skb_shared_info *shinfo;
 			u16 data_len;
 
-			skb = build_skb((void *)resp_hw, PAGE_SIZE);
-			skb_reserve(skb, data_offset);
 			/* Head fragment includes response header(s);
 			 * subsequent fragments contains only data.
 			 */
-			skb_put(skb, oq->max_single_buffer_size);
-			read_idx++;
-			desc_used++;
-			if (read_idx == oq->max_count)
-				read_idx = 0;
-
-			shinfo = skb_shinfo(skb);
+			if (skb) {
+				skb_put(skb, oq->max_single_buffer_size);
+				shinfo = skb_shinfo(skb);
+			}
 			data_len = buff_info->len - oq->max_single_buffer_size;
 			while (data_len) {
 				dma_unmap_page(oq->dev, oq->desc_ring[read_idx].buffer_ptr,
@@ -434,10 +434,11 @@ static int __octep_oq_process_rx(struct octep_device *oct,
 					data_len -= oq->buffer_size;
 				}
 
-				skb_add_rx_frag(skb, shinfo->nr_frags,
-						buff_info->page, 0,
-						buff_info->len,
-						buff_info->len);
+				if (skb)
+					skb_add_rx_frag(skb, shinfo->nr_frags,
+							buff_info->page, 0,
+							buff_info->len,
+							buff_info->len);
 				buff_info->page = NULL;
 				read_idx++;
 				desc_used++;
@@ -446,6 +447,9 @@ static int __octep_oq_process_rx(struct octep_device *oct,
 			}
 		}
 
+		if (!skb)
+			continue;
+
 		skb->dev = oq->netdev;
 		skb->protocol =  eth_type_trans(skb, skb->dev);
 		if (feat & NETIF_F_RXCSUM &&
-- 
2.30.2


