Return-Path: <netdev+bounces-24328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E72C376FCB1
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 10:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1BA71C217D9
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 08:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B89B9474;
	Fri,  4 Aug 2023 08:58:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710EB63DB
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 08:58:02 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1534EFC;
	Fri,  4 Aug 2023 01:58:00 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4RHKP346sGz4xVnh;
	Fri,  4 Aug 2023 16:57:59 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
	by mse-fl2.zte.com.cn with SMTP id 3748vi7f025316;
	Fri, 4 Aug 2023 16:57:44 +0800 (+08)
	(envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
	by mapi (Zmail) with MAPI id mid14;
	Fri, 4 Aug 2023 16:57:46 +0800 (CST)
Date: Fri, 4 Aug 2023 16:57:46 +0800 (CST)
X-Zmail-TransId: 2b0364ccbd8affffffff972-96c06
X-Mailer: Zmail v1.0
Message-ID: <202308041657467504029@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <yang.yang29@zte.com.cn>
To: <davem@davemloft.net>
Cc: <dsahern@kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBuZXQ6IGFkZCBuZXQgZGV2aWNlIHJlZmNvdW50IHRyYWNrZXIgdG8gcG5laWdoX3F1ZXVl?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 3748vi7f025316
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 64CCBD97.002/4RHKP346sGz4xVnh
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: xu xin <xu.xin16@zte.com.cn>

Add a static net device refcount tracker to neighbour.c to track
dev's refcnt when pneigh enqueuing and dequeuing.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Reviewed-by: Yang Yang <yang.yang.29@zte.com.cn>
Cc: Kuang Mingfu <kuang.mingfu@zte.com.cn>
---
 net/core/neighbour.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index ddd0f32de20e..56e87130fa95 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -61,6 +61,7 @@ static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
 static const struct seq_operations neigh_stat_seq_ops;
 #endif

+static netdevice_tracker pneigh_queue_dev_tracker;
 /*
    Neighbour hash table buckets are protected with rwlock tbl->lock.

@@ -364,7 +365,7 @@ static void pneigh_queue_purge(struct sk_buff_head *list, struct net *net,
 	spin_unlock_irqrestore(&list->lock, flags);

 	while ((skb = __skb_dequeue(&tmp))) {
-		dev_put(skb->dev);
+		netdev_put(skb->dev, &pneigh_queue_dev_tracker);
 		kfree_skb(skb);
 	}
 }
@@ -1633,7 +1634,7 @@ static void neigh_proxy_process(struct timer_list *t)
 				kfree_skb(skb);
 			}

-			dev_put(dev);
+			netdev_put(skb->dev, &pneigh_queue_dev_tracker);
 		} else if (!sched_next || tdif < sched_next)
 			sched_next = tdif;
 	}
@@ -1673,7 +1674,7 @@ void pneigh_enqueue(struct neigh_table *tbl, struct neigh_parms *p,
 			sched_next = tbl->proxy_timer.expires;
 	}
 	skb_dst_drop(skb);
-	dev_hold(skb->dev);
+	netdev_hold(skb->dev, &pneigh_queue_dev_tracker, GFP_KERNEL);
 	__skb_queue_tail(&tbl->proxy_queue, skb);
 	p->qlen++;
 	mod_timer(&tbl->proxy_timer, sched_next);
-- 
2.15.2

