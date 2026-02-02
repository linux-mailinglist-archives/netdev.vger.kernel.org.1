Return-Path: <netdev+bounces-256008-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGkzH4cOgWnmDwMAu9opvQ
	(envelope-from <netdev+bounces-256008-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 21:52:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F55AD150D
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 21:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 761993006444
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 20:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC732F28FC;
	Mon,  2 Feb 2026 20:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OGa1L6YV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCB929ACD7
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 20:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770065541; cv=none; b=k9YCPPpIthk3ahQHVILFAD+Fqeg+1JfB0eCx1w52XdHTeHFIICHfo9ACQ38UQVp0I636I8jPd5j/WxH8d1oY0tyXtlIq5HOcpTEs90HBEEOIoazPf+C8dVHGJAtK3nMpDOEqWE6tCRzVTVSEWS5v3eKPlzwabU6ry5n8Q1geK1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770065541; c=relaxed/simple;
	bh=hwI4iv6phdnQ2kvwOXpDIIaTlaHRSx6B8PDuktcvq24=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Lqlg17i/80VQ6TPXMybprqPrVe1WwCPxbDHb/uqcSrUwrZk3fE2YP10pDXfdKwMoAfDH0VpDTmKWLTfHcdwZVaoTRTt7ZL/MQJfLqb0gBZglifP4G6wQkKLAYTRQeHLsm/+mVdYcS1QJEXaHgGBcaoW0Sa/s1epsLga1S+YS5co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OGa1L6YV; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-503342386c7so160274031cf.0
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 12:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770065538; x=1770670338; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8etqEAMVPqWxdzGkeAFlTOSoaybw7qQHBNqWSXfGI+c=;
        b=OGa1L6YV+Hnv07/PUj5TQlxUVYxSHF4v7OWZSoS5Nht95p7jOAOjy4YFOFnwqL5S6p
         GZL8Nnmr2F76Avds6n/aUe3qYWNpQcZSVweonZp66YupyMaOVExi0j9kXmRNGgoQYFyP
         QLnF6XQ0icF0BhbuD4pVjDefHEFma/kR1YB9tLHlHui8yyHbWP+cL77lAcdf4X7fhrWi
         VX2r63cGg33CoFE7GSiGS3rAEXIczMzRRtNXG9aDDED6pEBbskG7j8KRqIHtiCvZ3iqj
         iJpwjS3wJBxAU+g8ZPagKFS3RPkvMbtEH9WmUvsqcAyTO1IHu//vZowJ+u/fuzE9Nqx2
         6ZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770065538; x=1770670338;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8etqEAMVPqWxdzGkeAFlTOSoaybw7qQHBNqWSXfGI+c=;
        b=VSjN0xgYKw69sbBdbUvux4zlQ4/0FaIT9Nf5HCRPYMKd8JAGKMtC21DpYxFAk+/sO5
         tO8OoDCsBWp53JN3j2C5EEG81rctRVQsl35+CSJSK+tEshLU3XorB4mHv1EM1Cv+C09b
         z7Bnruyh9fF3PiS9y2Uhj+VOwQ0jiXQN3pO0VGXx8ybAqsfBqNbwIj5y3AQkKdYMYDFU
         FRaHmpoRnJ28iXvcIPRI6Gd0gFMJb6hCzGQjAd98aaq9IdgzieKAbxUhuY0/3Z5JYg8O
         DSzqbabybaLaSGkiWy7a5EP8mWaYzcpyRqbSWKB4d06RoSrBqaPlty1c9mjLHVKinfyn
         qdHw==
X-Forwarded-Encrypted: i=1; AJvYcCUJAJqyNjo2Fodk35a+eEQ0R3MwLwFsynCFXPY7wDHt13IJNjbSAcUR8xwZGsGrUS8iXNwcv1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzXGIKLhRA3SqplWBxGPumoctB5Chq2kBJ77Q/CsuzeAKLOg8s
	xQkJ6d5U6S9gfZLNQUA/mvU2RrVKEXiM3ACExoXzyoiwEXvk678Yee/ouX6D0MxTAnOumLipCEH
	DIhgy3GkKkdklrA==
X-Received: from qtwx7.prod.google.com ([2002:a05:622a:7:b0:4f1:ab10:b9bf])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1791:b0:4ed:ba76:a008 with SMTP id d75a77b69052e-505d22acf2dmr186238411cf.73.1770065538446;
 Mon, 02 Feb 2026 12:52:18 -0800 (PST)
Date: Mon,  2 Feb 2026 20:52:17 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260202205217.2881198-1-edumazet@google.com>
Subject: [PATCH v3 net] net: add proper RCU protection to /proc/net/ptype
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Yin Fengwei <fengwei_yin@linux.alibaba.com>, Dong Chenchen <dongchenchen2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com,linux.alibaba.com,huawei.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256008-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,alibaba.com:email,list.next:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1F55AD150D
X-Rspamd-Action: no action

Yin Fengwei reported an RCU stall in ptype_seq_show() and provided
a patch.

Real issue is that ptype_seq_next() and ptype_seq_show() violate
RCU rules.

ptype_seq_show() runs under rcu_read_lock(), and reads pt->dev
to get device name without any barrier.

At the same time, concurrent writers can remove a packet_type structure
(which is correctly freed after an RCU grace period) and clear pt->dev
without an RCU grace period.

Define ptype_iter_state to carry a dev pointer along seq_net_private:

struct ptype_iter_state {
	struct seq_net_private	p;
	struct net_device	*dev; // added in this patch
};

We need to record the device pointer in ptype_get_idx() and
ptype_seq_next() so that ptype_seq_show() is safe against
concurrent pt->dev changes.

We also need to add full RCU protection in ptype_seq_next().
(Missing READ_ONCE() when reading list.next values)

Many thanks to Dong Chenchen for providing a repro.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: 1d10f8a1f40b ("net-procfs: show net devices bound packet types")
Fixes: c353e8983e0d ("net: introduce per netns packet chains")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Yin Fengwei <fengwei_yin@linux.alibaba.com>
Reported-by: Dong Chenchen <dongchenchen2@huawei.com>
Closes: https://lore.kernel.org/netdev/CANn89iKRRKPnWjJmb-_3a=sq+9h6DvTQM4DBZHT5ZRGPMzQaiA@mail.gmail.com/T/#m7b80b9fc9b9267f90e0b7aad557595f686f9c50d

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/net-procfs.c | 50 +++++++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/net/core/net-procfs.c b/net/core/net-procfs.c
index 70e0e9a3b650..7dbfa6109f0b 100644
--- a/net/core/net-procfs.c
+++ b/net/core/net-procfs.c
@@ -170,8 +170,14 @@ static const struct seq_operations softnet_seq_ops = {
 	.show  = softnet_seq_show,
 };
 
+struct ptype_iter_state {
+	struct seq_net_private	p;
+	struct net_device	*dev;
+};
+
 static void *ptype_get_idx(struct seq_file *seq, loff_t pos)
 {
+	struct ptype_iter_state *iter = seq->private;
 	struct list_head *ptype_list = NULL;
 	struct packet_type *pt = NULL;
 	struct net_device *dev;
@@ -181,12 +187,16 @@ static void *ptype_get_idx(struct seq_file *seq, loff_t pos)
 	for_each_netdev_rcu(seq_file_net(seq), dev) {
 		ptype_list = &dev->ptype_all;
 		list_for_each_entry_rcu(pt, ptype_list, list) {
-			if (i == pos)
+			if (i == pos) {
+				iter->dev = dev;
 				return pt;
+			}
 			++i;
 		}
 	}
 
+	iter->dev = NULL;
+
 	list_for_each_entry_rcu(pt, &seq_file_net(seq)->ptype_all, list) {
 		if (i == pos)
 			return pt;
@@ -218,6 +228,7 @@ static void *ptype_seq_start(struct seq_file *seq, loff_t *pos)
 
 static void *ptype_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
+	struct ptype_iter_state *iter = seq->private;
 	struct net *net = seq_file_net(seq);
 	struct net_device *dev;
 	struct packet_type *pt;
@@ -229,19 +240,21 @@ static void *ptype_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 		return ptype_get_idx(seq, 0);
 
 	pt = v;
-	nxt = pt->list.next;
-	if (pt->dev) {
-		if (nxt != &pt->dev->ptype_all)
+	nxt = READ_ONCE(pt->list.next);
+	dev = iter->dev;
+	if (dev) {
+		if (nxt != &dev->ptype_all)
 			goto found;
 
-		dev = pt->dev;
 		for_each_netdev_continue_rcu(seq_file_net(seq), dev) {
-			if (!list_empty(&dev->ptype_all)) {
-				nxt = dev->ptype_all.next;
+			nxt = READ_ONCE(dev->ptype_all.next);
+			if (nxt != &dev->ptype_all) {
+				iter->dev = dev;
 				goto found;
 			}
 		}
-		nxt = net->ptype_all.next;
+		iter->dev = NULL;
+		nxt = READ_ONCE(net->ptype_all.next);
 		goto net_ptype_all;
 	}
 
@@ -252,20 +265,20 @@ static void *ptype_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 
 		if (nxt == &net->ptype_all) {
 			/* continue with ->ptype_specific if it's not empty */
-			nxt = net->ptype_specific.next;
+			nxt = READ_ONCE(net->ptype_specific.next);
 			if (nxt != &net->ptype_specific)
 				goto found;
 		}
 
 		hash = 0;
-		nxt = ptype_base[0].next;
+		nxt = READ_ONCE(ptype_base[0].next);
 	} else
 		hash = ntohs(pt->type) & PTYPE_HASH_MASK;
 
 	while (nxt == &ptype_base[hash]) {
 		if (++hash >= PTYPE_HASH_SIZE)
 			return NULL;
-		nxt = ptype_base[hash].next;
+		nxt = READ_ONCE(ptype_base[hash].next);
 	}
 found:
 	return list_entry(nxt, struct packet_type, list);
@@ -279,19 +292,24 @@ static void ptype_seq_stop(struct seq_file *seq, void *v)
 
 static int ptype_seq_show(struct seq_file *seq, void *v)
 {
+	struct ptype_iter_state *iter = seq->private;
 	struct packet_type *pt = v;
+	struct net_device *dev;
 
-	if (v == SEQ_START_TOKEN)
+	if (v == SEQ_START_TOKEN) {
 		seq_puts(seq, "Type Device      Function\n");
-	else if ((!pt->af_packet_net || net_eq(pt->af_packet_net, seq_file_net(seq))) &&
-		 (!pt->dev || net_eq(dev_net(pt->dev), seq_file_net(seq)))) {
+		return 0;
+	}
+	dev = iter->dev;
+	if ((!pt->af_packet_net || net_eq(pt->af_packet_net, seq_file_net(seq))) &&
+		 (!dev || net_eq(dev_net(dev), seq_file_net(seq)))) {
 		if (pt->type == htons(ETH_P_ALL))
 			seq_puts(seq, "ALL ");
 		else
 			seq_printf(seq, "%04x", ntohs(pt->type));
 
 		seq_printf(seq, " %-8s %ps\n",
-			   pt->dev ? pt->dev->name : "", pt->func);
+			   dev ? dev->name : "", pt->func);
 	}
 
 	return 0;
@@ -315,7 +333,7 @@ static int __net_init dev_proc_net_init(struct net *net)
 			 &softnet_seq_ops))
 		goto out_dev;
 	if (!proc_create_net("ptype", 0444, net->proc_net, &ptype_seq_ops,
-			sizeof(struct seq_net_private)))
+			sizeof(struct ptype_iter_state)))
 		goto out_softnet;
 
 	if (wext_proc_init(net))
-- 
2.53.0.rc1.225.gd81095ad13-goog


