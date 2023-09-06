Return-Path: <netdev+bounces-32173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2017933F8
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 05:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFACE1C2096D
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 03:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6570658;
	Wed,  6 Sep 2023 03:12:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948877E
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 03:12:40 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0DBB199;
	Tue,  5 Sep 2023 20:12:34 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3863Bp3R2030400, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3863Bp3R2030400
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 6 Sep 2023 11:11:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 6 Sep 2023 11:12:13 +0800
Received: from fc38.localdomain (172.22.228.98) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 6 Sep 2023
 11:12:12 +0800
From: Hayes Wang <hayeswang@realtek.com>
To: <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Hayes Wang
	<hayeswang@realtek.com>
Subject: [PATCH net v2] r8152: avoid the driver drops a lot of packets
Date: Wed, 6 Sep 2023 11:11:48 +0800
Message-ID: <20230906031148.16774-421-nic_swsd@realtek.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.22.228.98]
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Stop submitting rx, if the driver queue more than 256 packets.

If the hardware is more fast than the software, the driver would start
queuing the packets. And, the driver starts dropping the packets, if it
queues more than 1000 packets.

Increase the weight of NAPI could improve the situation. However, the
weight has been changed to 64, so we have to stop submitting rx when the
driver queues too many packets. Then, the device may send the pause frame
to slow down the receiving, when the FIFO of the device is full.

Fixes: cf74eb5a5bc8 ("eth: r8152: try to use a normal budget")
Signed-off-by: Hayes Wang <hayeswang@realtek.com>
---
v2:
Add WARN_ON_ONCE() and debug message for the skb_queue_len(&tp->rx_queue).

 drivers/net/usb/r8152.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 332c853ca99b..4a62e420a7be 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -2484,10 +2484,6 @@ static int rx_bottom(struct r8152 *tp, int budget)
 			unsigned int pkt_len, rx_frag_head_sz;
 			struct sk_buff *skb;
 
-			/* limit the skb numbers for rx_queue */
-			if (unlikely(skb_queue_len(&tp->rx_queue) >= 1000))
-				break;
-
 			pkt_len = le32_to_cpu(rx_desc->opts1) & RX_LEN_MASK;
 			if (pkt_len < ETH_ZLEN)
 				break;
@@ -2556,9 +2552,14 @@ static int rx_bottom(struct r8152 *tp, int budget)
 		}
 
 submit:
-		if (!ret) {
+		if (!ret && likely(skb_queue_len(&tp->rx_queue) < 256)) {
 			ret = r8152_submit_rx(tp, agg, GFP_ATOMIC);
 		} else {
+			WARN_ON_ONCE(skb_queue_len(&tp->rx_queue) >= 1000);
+			if (net_ratelimit())
+				netif_dbg(tp, rx_err, tp->netdev,
+					  "submit_rx=%d, rx_queue=%u\n",
+					  ret, skb_queue_len(&tp->rx_queue));
 			urb->actual_length = 0;
 			list_add_tail(&agg->list, next);
 		}
-- 
2.41.0


