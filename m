Return-Path: <netdev+bounces-31922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6099B7916FA
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 14:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FCD31C204AB
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 12:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EED67471;
	Mon,  4 Sep 2023 12:17:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CF51FBD
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 12:17:39 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 429CFCD0;
	Mon,  4 Sep 2023 05:17:35 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 384CGoTbA007845, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 384CGoTbA007845
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 4 Sep 2023 20:16:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 4 Sep 2023 20:17:18 +0800
Received: from fc38.localdomain (172.22.228.98) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 4 Sep 2023
 20:17:14 +0800
From: Hayes Wang <hayeswang@realtek.com>
To: <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Hayes Wang
	<hayeswang@realtek.com>
Subject: [PATCH net] r8152: avoid the driver drops a lot of packets
Date: Mon, 4 Sep 2023 20:17:06 +0800
Message-ID: <20230904121706.7132-420-nic_swsd@realtek.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Stop submitting rx, if the driver queue more than 256 packets.

If the hardware is more fast than the software, the driver would start
queuing the packets. And, the driver starts dropping the packets, if it
queues more than 1000 packets.

Increase the weight of NAPI could improve the situation. However, the
weight has been changed to 64, so we have to stop submitting rx when the
driver queues too many packets. Then,the device may send the pause frame
to slow down the receiving, when the FIFO of the device is full.

Fixes: cf74eb5a5bc8 ("eth: r8152: try to use a normal budget")
Signed-off-by: Hayes Wang <hayeswang@realtek.com>
---
 drivers/net/usb/r8152.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 332c853ca99b..b5ed55938b1c 100644
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
@@ -2556,7 +2552,7 @@ static int rx_bottom(struct r8152 *tp, int budget)
 		}
 
 submit:
-		if (!ret) {
+		if (!ret && likely(skb_queue_len(&tp->rx_queue) < 256)) {
 			ret = r8152_submit_rx(tp, agg, GFP_ATOMIC);
 		} else {
 			urb->actual_length = 0;
-- 
2.41.0


