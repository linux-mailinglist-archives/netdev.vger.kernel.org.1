Return-Path: <netdev+bounces-36263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC69F7AEB4A
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 13:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 6DEF1281E68
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 11:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67F1266DC;
	Tue, 26 Sep 2023 11:18:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C004266C0;
	Tue, 26 Sep 2023 11:18:34 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41E9120;
	Tue, 26 Sep 2023 04:18:31 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38QBHi1eA857842, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38QBHi1eA857842
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Sep 2023 19:17:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 26 Sep 2023 19:17:44 +0800
Received: from fc38.localdomain (172.22.228.98) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 26 Sep
 2023 19:17:43 +0800
From: Hayes Wang <hayeswang@realtek.com>
To: <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <edumazet@google.com>, <bjorn@mork.no>, <pabeni@redhat.com>,
        Hayes Wang
	<hayeswang@realtek.com>
Subject: [PATCH net-next v3 1/2] r8152: break the loop when the budget is exhausted
Date: Tue, 26 Sep 2023 19:17:13 +0800
Message-ID: <20230926111714.9448-433-nic_swsd@realtek.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230926111714.9448-432-nic_swsd@realtek.com>
References: <20230926111714.9448-432-nic_swsd@realtek.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

A bulk transfer of the USB may contain many packets. And, the total
number of the packets in the bulk transfer may be more than budget.

Originally, only budget packets would be handled by napi_gro_receive(),
and the other packets would be queued in the driver for next schedule.

This patch would break the loop about getting next bulk transfer, when
the budget is exhausted. That is, only the current bulk transfer would
be handled, and the other bulk transfers would be queued for next
schedule. Besides, the packets which are more than the budget in the
current bulk trasnfer would be still queued in the driver, as the
original method.

In addition, a bulk transfer wouldn't contain more than 400 packets, so
the check of queue length is unnecessary. Therefore, I replace it with
WARN_ON_ONCE().

Fixes: cf74eb5a5bc8 ("eth: r8152: try to use a normal budget")
Signed-off-by: Hayes Wang <hayeswang@realtek.com>
---
 drivers/net/usb/r8152.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 0c13d9950cd8..c4038def193f 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -2449,7 +2449,7 @@ static int rx_bottom(struct r8152 *tp, int budget)
 		}
 	}
 
-	if (list_empty(&tp->rx_done))
+	if (list_empty(&tp->rx_done) || work_done >= budget)
 		goto out1;
 
 	clear_bit(RX_EPROTO, &tp->flags);
@@ -2465,6 +2465,15 @@ static int rx_bottom(struct r8152 *tp, int budget)
 		struct urb *urb;
 		u8 *rx_data;
 
+		/* A bulk transfer of USB may contain may packets, so the
+		 * total packets may more than the budget. Deal with all
+		 * packets in current bulk transfer, and stop to handle the
+		 * next bulk transfer until next schedule, if budget is
+		 * exhausted.
+		 */
+		if (work_done >= budget)
+			break;
+
 		list_del_init(cursor);
 
 		agg = list_entry(cursor, struct rx_agg, list);
@@ -2484,9 +2493,7 @@ static int rx_bottom(struct r8152 *tp, int budget)
 			unsigned int pkt_len, rx_frag_head_sz;
 			struct sk_buff *skb;
 
-			/* limit the skb numbers for rx_queue */
-			if (unlikely(skb_queue_len(&tp->rx_queue) >= 1000))
-				break;
+			WARN_ON_ONCE(skb_queue_len(&tp->rx_queue) >= 1000);
 
 			pkt_len = le32_to_cpu(rx_desc->opts1) & RX_LEN_MASK;
 			if (pkt_len < ETH_ZLEN)
@@ -2564,9 +2571,10 @@ static int rx_bottom(struct r8152 *tp, int budget)
 		}
 	}
 
+	/* Splice the remained list back to rx_done for next schedule */
 	if (!list_empty(&rx_queue)) {
 		spin_lock_irqsave(&tp->rx_lock, flags);
-		list_splice_tail(&rx_queue, &tp->rx_done);
+		list_splice(&rx_queue, &tp->rx_done);
 		spin_unlock_irqrestore(&tp->rx_lock, flags);
 	}
 
-- 
2.41.0


