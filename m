Return-Path: <netdev+bounces-24327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC21C76FCAB
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 10:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A784A2821C6
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 08:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976A6946C;
	Fri,  4 Aug 2023 08:55:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D11C9449
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 08:55:00 +0000 (UTC)
X-Greylist: delayed 259 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Aug 2023 01:54:39 PDT
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8800618E;
	Fri,  4 Aug 2023 01:54:39 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4RHKJV4Lvwz5R9jt;
	Fri,  4 Aug 2023 16:54:02 +0800 (CST)
Received: from szxlzmapp06.zte.com.cn ([10.5.230.252])
	by mse-fl2.zte.com.cn with SMTP id 3748rdjo016893;
	Fri, 4 Aug 2023 16:53:39 +0800 (+08)
	(envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp07[null])
	by mapi (Zmail) with MAPI id mid14;
	Fri, 4 Aug 2023 16:53:41 +0800 (CST)
Date: Fri, 4 Aug 2023 16:53:41 +0800 (CST)
X-Zmail-TransId: 2b0964ccbc95ffffffffefa-19509
X-Mailer: Zmail v1.0
Message-ID: <202308041653414100323@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <yang.yang29@zte.com.cn>
To: <jmaloy@redhat.com>, <davem@davemloft.net>
Cc: <ying.xue@windriver.com>, <edumazet@google.com>, <kuba@kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBuZXQ6IHRpcGM6IGFkZCBuZXQgZGV2aWNlIHJlZmNvdW50IHRyYWNrZXIgZm9yIGJlYXJlcg==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 3748rdjo016893
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 64CCBCAA.003/4RHKJV4Lvwz5R9jt
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: xu xin <xu.xin16@zte.com.cn>

Add net device refcount tracker to the struct tipc_bearer.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Reviewed-by: Yang Yang <yang.yang.29@zte.com.cn>
Cc: Kuang Mingfu <kuang.mingfu@zte.com.cn>
---
 net/tipc/bearer.c | 10 +++++-----
 net/tipc/bearer.h |  1 +
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 2cde375477e3..01ffd1f2337a 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -426,15 +426,15 @@ int tipc_enable_l2_media(struct net *net, struct tipc_bearer *b,
 	struct net_device *dev;

 	/* Find device with specified name */
-	dev = dev_get_by_name(net, dev_name);
+	dev = netdev_get_by_name(net, dev_name, &b->devtracker, GFP_KERNEL);
 	if (!dev)
 		return -ENODEV;
 	if (tipc_mtu_bad(dev)) {
-		dev_put(dev);
+		netdev_put(dev, &b->devtracker);
 		return -EINVAL;
 	}
 	if (dev == net->loopback_dev) {
-		dev_put(dev);
+		netdev_put(dev, &b->devtracker);
 		pr_info("Enabling <%s> not permitted\n", b->name);
 		return -EINVAL;
 	}
@@ -445,7 +445,7 @@ int tipc_enable_l2_media(struct net *net, struct tipc_bearer *b,
 		tipc_net_init(net, node_id, 0);
 	}
 	if (!tipc_own_id(net)) {
-		dev_put(dev);
+		netdev_put(dev, &b->devtracker);
 		pr_warn("Failed to obtain node identity\n");
 		return -EINVAL;
 	}
@@ -479,7 +479,7 @@ void tipc_disable_l2_media(struct tipc_bearer *b)
 	dev_remove_pack(&b->pt);
 	RCU_INIT_POINTER(dev->tipc_ptr, NULL);
 	synchronize_net();
-	dev_put(dev);
+	netdev_put(dev, &b->devtracker);
 }

 /**
diff --git a/net/tipc/bearer.h b/net/tipc/bearer.h
index 41eac1ee0c09..1adeaf94aa62 100644
--- a/net/tipc/bearer.h
+++ b/net/tipc/bearer.h
@@ -174,6 +174,7 @@ struct tipc_bearer {
 	u16 encap_hlen;
 	unsigned long up;
 	refcount_t refcnt;
+	netdevice_tracker	devtracker;
 };

 struct tipc_bearer_names {
-- 
2.15.2

