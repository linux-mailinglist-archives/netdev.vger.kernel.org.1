Return-Path: <netdev+bounces-282370-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAuzD3H28WmElwEAu9opvQ
	(envelope-from <netdev+bounces-282370-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 14:15:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFB6493F34
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 14:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 575913006446
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 12:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4734B34EF0F;
	Wed, 29 Apr 2026 12:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="BIm/AEQG"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C7C1F3B87;
	Wed, 29 Apr 2026 12:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777464937; cv=none; b=BYacb5wNTqzCZuGv8PGSXKOevUQrKUG6fYMhKNvHuWgondiQINW6IE410LOumGEkRFS2tNFcRrEmrzYa6aNA2KImIfmfNfoP4m/KNqdjexXAuJZ9VPdzW+ZUW8we9NBTBw3UrVTxpR2es5gDnI54vZa84SdJX0TNVqoG/QPcDwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777464937; c=relaxed/simple;
	bh=uL9vk2jg29WT0te2XlTlXMqJhBp1I5Nix+Oz3cLzEIg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tP5OcICc/x4IfkMAz/EpcN1arq71akO2kxL6Yd8GMkjycc9w+aYNdLTmgGNmdU8Vs/lkc95YVIbf42/r/GCBz+q2JYNjVLOuf5k5SHyBwk8fhpb2wATyoQfvnKuhbUaz19eKjbQypAlGsdIEAyEODG6xt7tRmyPKYh6mnU6JvtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=BIm/AEQG; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Lieja21KR9tcF55zn9yePRbeLB0kUzBTO/1vd4meHnw=;
	b=BIm/AEQGHaQk05xxqMh4RewZLiGKXCGDIbGE2RxNTM6UCBRK5diBsCfGX02LsFDkaKLR0Pc/P
	Qs3inIB2OUQ1zHn3lyHMFW0+2uWvkHJLotUJbykbVXtwo1a6E71UD4eomhqA4Wp7xRlM9hExNFc
	OG7w0vRNi6HBQrSuzKDJEeQ=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4g5GLZ4bMtz1T4G8;
	Wed, 29 Apr 2026 20:09:10 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 36DAF40561;
	Wed, 29 Apr 2026 20:15:31 +0800 (CST)
Received: from huawei.com (10.50.85.128) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 29 Apr
 2026 20:15:30 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH net-next] net: core: Call netif_get_rxqueue() in get_rps_cpu()
Date: Wed, 29 Apr 2026 20:37:41 +0800
Message-ID: <20260429123741.3777677-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500002.china.huawei.com (7.185.36.57)
X-Rspamd-Queue-Id: 1CFB6493F34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[yuehaibing@huawei.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-282370-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	DMARC_DNSFAIL(0.00)[huawei.com : query timed out];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huawei.com:dkim,huawei.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Refactor netif_get_rxqueue() return NULL when rxq index checking failed
instead of falling back to first queue, then use it to avoid code
duplication.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/core/dev.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index e7bc95cbd1fa..72aef872d03c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5104,6 +5104,8 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 	return rflow;
 }
 
+static struct netdev_rx_queue *netif_get_rxqueue(struct sk_buff *skb);
+
 /*
  * get_rps_cpu is called from netif_receive_skb and returns the target
  * CPU from the RPS map of the receiving queue for a given skb.
@@ -5112,25 +5114,16 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		       struct rps_dev_flow **rflowp)
 {
-	struct netdev_rx_queue *rxqueue = dev->_rx;
+	struct netdev_rx_queue *rxqueue;
 	rps_tag_ptr global_tag_ptr, q_tag_ptr;
 	struct rps_map *map;
 	int cpu = -1;
 	u32 tcpu;
 	u32 hash;
 
-	if (skb_rx_queue_recorded(skb)) {
-		u16 index = skb_get_rx_queue(skb);
-
-		if (unlikely(index >= dev->real_num_rx_queues)) {
-			WARN_ONCE(dev->real_num_rx_queues > 1,
-				  "%s received packet on queue %u, but number "
-				  "of RX queues is %u\n",
-				  dev->name, index, dev->real_num_rx_queues);
-			goto done;
-		}
-		rxqueue += index;
-	}
+	rxqueue = netif_get_rxqueue(skb);
+	if (!rxqueue)
+		goto done;
 
 	/* Avoid computing hash if RFS/RPS is not active for this rxqueue */
 
@@ -5442,8 +5435,7 @@ static struct netdev_rx_queue *netif_get_rxqueue(struct sk_buff *skb)
 				  "%s received packet on queue %u, but number "
 				  "of RX queues is %u\n",
 				  dev->name, index, dev->real_num_rx_queues);
-
-			return rxqueue; /* Return first rxqueue */
+			return NULL;
 		}
 		rxqueue += index;
 	}
@@ -5473,6 +5465,8 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 	frame_sz += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
 	rxqueue = netif_get_rxqueue(skb);
+	if (!rxqueue)
+		rxqueue = skb->dev->_rx;
 	xdp_init_buff(xdp, frame_sz, &rxqueue->xdp_rxq);
 	xdp_prepare_buff(xdp, hard_start, skb_headroom(skb) - mac_len,
 			 skb_headlen(skb) + mac_len, true);
-- 
2.34.1


