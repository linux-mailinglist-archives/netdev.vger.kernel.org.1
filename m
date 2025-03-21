Return-Path: <netdev+bounces-176767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72703A6C10A
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 18:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88BB8167A40
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 17:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438F222D794;
	Fri, 21 Mar 2025 17:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TbOb2a8w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC1C215078
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 17:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577201; cv=none; b=llTFB9cpKIywSmcyfA8OZL0R4E7IzHsy6HWCUcUQasKxuqPk0Md1BRhvd2xgOilSZ/3GRy5Jb6tFhSJ35+7AprRstHwaGQtsiedoUpljgONVxCtiYNgEcKS5+zTQU148wfCcIEtpIsW2DFwUcgB5f1nWmHqK+PTbm2Ngs2qo5vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577201; c=relaxed/simple;
	bh=9w1Wcg/Y+jXKgLVgBW0j+qtQ6kn93xBzxlBOeYti46s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=izqma4A/6UBGZ1O72U7VfSJB8ELAw0WOx9lz8Gu7rfwhEGKNQIYqUhoVxnuLaP+s/Y6QtUDkiZ2xDVwoLdsCAGCm/MppmpK1UapNpZ0IRR0xKdht3YisoL6kXDN+94ciQkQBBBWlXZ9oRz0akWxahbIRw+SUURZ/IAaBPfJxB6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TbOb2a8w; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-47686947566so35797581cf.3
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 10:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742577197; x=1743181997; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CCrJeNhhi7UAGqv+LvV2s6ihc0YFWVS0m8E1vq4eP3w=;
        b=TbOb2a8w2+b87XJ0I+u6oAfiXffM1SdQJEsZWHh277LdXUA0SVaAxzUir88DplR0Ym
         8QSTbPWekR1UudcpeDOcxnueBnItnhCWpUGFvIT5oN33YJ4Inkoh5vHwDhRf+4/CEB4E
         WHSkdT+r0S2JrMHY6wiMBHEkPz6LG1lBlVf510gAfw83ooFvL52m8AWDrvexevgCXDec
         gUWU2sHfshcuY4utWTkG2geryhXcKXTt0yys0casPVpQn4EAGT4oqsXdOjI1a0VSQSbe
         +XJ76GKQy2B4W/3ojcUkn2zXo2LRfhWyvHbKgtAO+RfBlrdmAvDHeC8HDMkghMlft38n
         So4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742577197; x=1743181997;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CCrJeNhhi7UAGqv+LvV2s6ihc0YFWVS0m8E1vq4eP3w=;
        b=xDnaE92aazIdzIm3Vm21hmT8fe/Z2IpVVkRA4LS2OEXfq4B7kW7FDYrKy2nEigaGFi
         UDumMuLs+3GgA6t8K+LCGVwuSAHwA11meVkIVUuUQ7J1KWguUY2vjRXBmvCxR7xDO5t8
         dK3KCniuT9iDoI52ApBPcuH21ptg4Q9RsoEer4PRr4ZmGGdIN1+hrBZe6/TS8K4hM+yT
         P147R7iNL20GXCK+pUohhK0fZ0AG1H8zq00vc41IpLjJy9L38vRahV/jpDJbITN7RuV7
         9jKE24PzdpuOuw4qmh9Ia/gmEZR+KSww4CRbm3JfYNqHMUSNL5k4AEaat4584MxCSgS1
         I0wQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCGaCX6J2TgCrYk/8UN2pNk8RhZ84T4hhWCCPu9JKWE7ZRGHtk1Zb4ULv5o7Phmggq7F6zHwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuKhDWgFw6aesXvXG+HpJhk3Xl6lOSdFzWU5Wi7UGwSpg28XXt
	zUfVlxmLKaoxC5ridQLfmSLLCliGERYAy6aEenTvVG7DamIs+ttf3hY1ZB2y34slQ5G6m2L/3vQ
	JPvKnCxfsPQ==
X-Google-Smtp-Source: AGHT+IHLjAUt29Igj5N8EPq93qK19Nv297sRIuJ3dYbpMdwe4M7RpG1UqortsosXp94pXXFJb7xrUltgqwavsg==
X-Received: from qtbeo7.prod.google.com ([2002:a05:622a:5447:b0:476:7f6b:7312])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:5e17:b0:477:d97:74b3 with SMTP id d75a77b69052e-4771dd5cefbmr62953551cf.5.1742577197088;
 Fri, 21 Mar 2025 10:13:17 -0700 (PDT)
Date: Fri, 21 Mar 2025 17:13:09 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250321171309.634100-1-edumazet@google.com>
Subject: [PATCH net-next] net: rfs: hash function change
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Neal Cardwell <ncardwell@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Tom Herbert <tom@herbertland.com>
Content-Type: text/plain; charset="UTF-8"

RFS is using two kinds of hash tables.

First one is controled by /proc/sys/net/core/rps_sock_flow_entries = 2^N
and using the N low order bits of the l4 hash is good enough.

Then each RX queue has its own hash table, controled by
/sys/class/net/eth1/queues/rx-$q/rps_flow_cnt = 2^X

Current hash function, using the X low order bits is suboptimal,
because RSS is usually using Func(hash) = (hash % power_of_two);

For example, with 32 RX queues, 6 low order bits have no entropy
for a given queue.

Switch this hash function to hash_32(hash, log) to increase
chances to use all possible slots and reduce collisions.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Tom Herbert <tom@herbertland.com>
---
 include/net/rps.h    |  2 +-
 net/core/dev.c       | 13 +++++++++----
 net/core/net-sysfs.c |  4 ++--
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/net/rps.h b/include/net/rps.h
index a93401d23d66e45210acc73f0326087813b69d59..e358e9711f27523534fdf4cbf57729cbdf629b8a 100644
--- a/include/net/rps.h
+++ b/include/net/rps.h
@@ -39,7 +39,7 @@ struct rps_dev_flow {
  * The rps_dev_flow_table structure contains a table of flow mappings.
  */
 struct rps_dev_flow_table {
-	unsigned int		mask;
+	u8			log;
 	struct rcu_head		rcu;
 	struct rps_dev_flow	flows[];
 };
diff --git a/net/core/dev.c b/net/core/dev.c
index 2355603417650fe10d075c8e85416a488e00626d..c5bf3b1684fe6dc7141b1c341b14423111fe8894 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4731,6 +4731,11 @@ EXPORT_SYMBOL(rps_needed);
 struct static_key_false rfs_needed __read_mostly;
 EXPORT_SYMBOL(rfs_needed);
 
+static u32 rfs_slot(u32 hash, const struct rps_dev_flow_table *flow_table)
+{
+	return hash_32(hash, flow_table->log);
+}
+
 static struct rps_dev_flow *
 set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 	    struct rps_dev_flow *rflow, u16 next_cpu)
@@ -4757,7 +4762,7 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		flow_table = rcu_dereference(rxqueue->rps_flow_table);
 		if (!flow_table)
 			goto out;
-		flow_id = skb_get_hash(skb) & flow_table->mask;
+		flow_id = rfs_slot(skb_get_hash(skb), flow_table);
 		rc = dev->netdev_ops->ndo_rx_flow_steer(dev, skb,
 							rxq_index, flow_id);
 		if (rc < 0)
@@ -4836,7 +4841,7 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		/* OK, now we know there is a match,
 		 * we can look at the local (per receive queue) flow table
 		 */
-		rflow = &flow_table->flows[hash & flow_table->mask];
+		rflow = &flow_table->flows[rfs_slot(hash, flow_table)];
 		tcpu = rflow->cpu;
 
 		/*
@@ -4903,13 +4908,13 @@ bool rps_may_expire_flow(struct net_device *dev, u16 rxq_index,
 
 	rcu_read_lock();
 	flow_table = rcu_dereference(rxqueue->rps_flow_table);
-	if (flow_table && flow_id <= flow_table->mask) {
+	if (flow_table && flow_id < (1UL << flow_table->log)) {
 		rflow = &flow_table->flows[flow_id];
 		cpu = READ_ONCE(rflow->cpu);
 		if (READ_ONCE(rflow->filter) == filter_id && cpu < nr_cpu_ids &&
 		    ((int)(READ_ONCE(per_cpu(softnet_data, cpu).input_queue_head) -
 			   READ_ONCE(rflow->last_qtail)) <
-		     (int)(10 * flow_table->mask)))
+		     (int)(10 << flow_table->log)))
 			expire = false;
 	}
 	rcu_read_unlock();
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index abaa1c919b984cb3340e99bf1af26864a0cc3405..b6fbe629ccee1ea874a796c6146e4a6e8296c5dc 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1056,7 +1056,7 @@ static ssize_t show_rps_dev_flow_table_cnt(struct netdev_rx_queue *queue,
 	rcu_read_lock();
 	flow_table = rcu_dereference(queue->rps_flow_table);
 	if (flow_table)
-		val = (unsigned long)flow_table->mask + 1;
+		val = 1UL << flow_table->log;
 	rcu_read_unlock();
 
 	return sysfs_emit(buf, "%lu\n", val);
@@ -1109,7 +1109,7 @@ static ssize_t store_rps_dev_flow_table_cnt(struct netdev_rx_queue *queue,
 		if (!table)
 			return -ENOMEM;
 
-		table->mask = mask;
+		table->log = ilog2(mask) + 1;
 		for (count = 0; count <= mask; count++)
 			table->flows[count].cpu = RPS_NO_CPU;
 	} else {
-- 
2.49.0.395.g12beb8f557-goog


