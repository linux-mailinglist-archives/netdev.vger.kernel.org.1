Return-Path: <netdev+bounces-208484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F34B0BB51
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 05:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF2D93AB084
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 03:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0FC2153CB;
	Mon, 21 Jul 2025 03:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zt26zYwc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049112036FA
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 03:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753067801; cv=none; b=JjfsHcWUazqMeNVar8Noam9ujbS5SnhOX0pbjHf4nW8xnFhK9TBljFYt9zbpAUelresx9tiqUHW8l3JIQzOkS802x2lHbwOKgH0yU4esyw6yMorAPdQHdmKbrkRg1GAY0SDiaipylcUDwDdjwM3XrIKfPsqX7zlNXQOG/wsVZ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753067801; c=relaxed/simple;
	bh=97VB3OjDpXO0JMAbFwdVRurX7PkvjQJ+Zv735XttjBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QE9OrhxLOnlwb/IGyeBBwLsWSTvX8lbE1XHEb+me5WFUsr34ZcTP6LOxn8ejWbjzZcCOCjMA7BWpwuQUmPFqLH/eSP4yBYbREdxc7w8mxKdBy+LeBXq3nA0llr+QMTx2jwJ0aa/HBs5uSt0gWlx1+ot8A7MOv6P37nPnDBRWK2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zt26zYwc; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-23508d30142so45451065ad.0
        for <netdev@vger.kernel.org>; Sun, 20 Jul 2025 20:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753067799; x=1753672599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfE6MsJgtVtfkAJ/WnU6M8XLPmI+xFrmUZN7Ldb8Btg=;
        b=Zt26zYwcbv7KI/iHnAGKwMEd2JhQdQGhY3WqK7/eKK6XrHeN9ApIsbLclejJUYN/Bx
         y9pzDi7LqhgJdz5tMZdA6ri0qr71HeH4cttX3InJIkEeDC5JoGYhnPg1Vbq/FpcVgoS+
         vdBKVKLaa0CJYd86m5ROPP4qdNDjMvF8Cu1VvFdShMVIRPHUrTbxcqzIfZRuWntfVNqL
         aNxDXk8BDy0iJPaVgu01NJ6a5oui2UDZ7CwWwuFG8FudXpVdY6ABdWPYFMM7EP1nWoXH
         fArG7qeVb8azVZjf0w0V4n2codMbH9ZVUHsq/WXJ1abRkV1XF+9fVvsdF2xpRrsJ/tcF
         l8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753067799; x=1753672599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WfE6MsJgtVtfkAJ/WnU6M8XLPmI+xFrmUZN7Ldb8Btg=;
        b=OIk3KwP94y7Me6RTtjG8yKDi4Lih4B9WnqcZqA0RF2hgnS0o9CsUfEG2N82Gz0OqDj
         pUvB3LxoxsBFQyQh0k35cU2e1zcUh2gN9DGO/zJWu/11chuqxMPLUWCZcgCJdNp5sWaE
         UzqPygvqmY68ShVJNTuGnPTWyf591+BZnWeqdlpztTjdzEjUNt5zZfA18XH20QSGR0Sz
         uyQtII8GAB63NuTd7z60t6fFGvSX2caCsCxARhypje5hedBPTIg48vL56SGPIARC9ahN
         4DQcCQmENX6HzJIkv2P1P9GTl7tdZBLWMhKcMLwA5ohu7ObFpW1fV+EMUA38NXhUBsa7
         39HQ==
X-Gm-Message-State: AOJu0YxI/fl09vTJ27cXXZmZxo1VR5CefuK6HtlIBzlqnZmbWx/BNzMr
	ha4XaUpnXoWNA7kQlLagKPaA6t11R18aUOTAnVHbP9KQWuqMRKfVZ16dIZEOD7a9gkc=
X-Gm-Gg: ASbGncui3HJtA85xXc33ncMJhDPUvDviKHBkeUpxy0BbuIiQa9n+YNk0de4F/oYXQ1E
	Vr1RT21Cml6mTKqvM3y3CBTWjyYZqgpPKK3NQjg614hU9IGJyVaPaJr7n24Fytj3ximuVUthZOK
	qHHLJU+RfW/dYrSQftBaolohFG35MyOR8eaNXRayTrxonDjy6+kSeEcufFZ7gCB9HejBiiLIejQ
	hzManFVxxic4iEJ6KGyTVEh3a+pfxmOUtFA6s1tj0R4qK9xTB00BingSN5ZGArFbqpzskOOpdYS
	lliLOMeEVgB3YwvkX8IuSd/ZKUpbqr8Apeod6G84MEaKaWIGBcFg5jrDZKSx2CwN5qyG0n7wxRS
	0/y/fj1EQn9aNkfCAanxlT0UlRD+hM4tmxGV32tdtYic=
X-Google-Smtp-Source: AGHT+IHbRLtlj4a9haVxwIQoXV1nmy6IqSVi+z2ScyI3SYHkT3QIYFkATfuTRI52l4nx/e0n9kco5g==
X-Received: by 2002:a17:903:2a84:b0:235:f18f:2911 with SMTP id d9443c01a7336-23e2566a99amr299084605ad.2.1753067799008;
        Sun, 20 Jul 2025 20:16:39 -0700 (PDT)
Received: from krishna-laptop.localdomain.com ([115.110.204.61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6eef80sm47899725ad.181.2025.07.20.20.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 20:16:38 -0700 (PDT)
From: Krishna Kumar <krikku@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	tom@herbertland.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sdf@fomichev.me,
	kuniyu@google.com,
	ahmed.zaki@intel.com,
	aleksander.lobakin@intel.com,
	atenart@kernel.org,
	jdamato@fastly.com,
	krishna.ku@flipkart.com,
	krikku@gmail.com
Subject: [PATCH v5 net-next 2/2] net: Cache hash and flow_id to avoid recalculation
Date: Mon, 21 Jul 2025 08:46:09 +0530
Message-ID: <20250721031609.132217-3-krikku@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721031609.132217-1-krikku@gmail.com>
References: <20250721031609.132217-1-krikku@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_rps_cpu() can cache flow_id and hash as both are required by
set_rps_cpu() instead of recalculating them twice.

Signed-off-by: Krishna Kumar <krikku@gmail.com>
---
 net/core/dev.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 979dcdfdee1f..2c3981b823c7 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4861,7 +4861,8 @@ static bool rps_flow_is_active(struct rps_dev_flow *rflow,
 
 static struct rps_dev_flow *
 set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
-	    struct rps_dev_flow *rflow, u16 next_cpu)
+	    struct rps_dev_flow *rflow, u16 next_cpu, u32 hash,
+	    u32 flow_id)
 {
 	if (next_cpu < nr_cpu_ids) {
 		u32 head;
@@ -4872,8 +4873,6 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		struct rps_dev_flow *tmp_rflow;
 		unsigned int tmp_cpu;
 		u16 rxq_index;
-		u32 flow_id;
-		u32 hash;
 		int rc;
 
 		/* Should we steer this flow to a different hardware queue? */
@@ -4889,9 +4888,6 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		if (!flow_table)
 			goto out;
 
-		hash = skb_get_hash(skb);
-		flow_id = rfs_slot(hash, flow_table);
-
 		tmp_rflow = &flow_table->flows[flow_id];
 		tmp_cpu = READ_ONCE(tmp_rflow->cpu);
 
@@ -4965,6 +4961,7 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 	struct rps_dev_flow_table *flow_table;
 	struct rps_map *map;
 	int cpu = -1;
+	u32 flow_id;
 	u32 tcpu;
 	u32 hash;
 
@@ -5011,7 +5008,8 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		/* OK, now we know there is a match,
 		 * we can look at the local (per receive queue) flow table
 		 */
-		rflow = &flow_table->flows[rfs_slot(hash, flow_table)];
+		flow_id = rfs_slot(hash, flow_table);
+		rflow = &flow_table->flows[flow_id];
 		tcpu = rflow->cpu;
 
 		/*
@@ -5030,7 +5028,8 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		     ((int)(READ_ONCE(per_cpu(softnet_data, tcpu).input_queue_head) -
 		      rflow->last_qtail)) >= 0)) {
 			tcpu = next_cpu;
-			rflow = set_rps_cpu(dev, skb, rflow, next_cpu);
+			rflow = set_rps_cpu(dev, skb, rflow, next_cpu, hash,
+					    flow_id);
 		}
 
 		if (tcpu < nr_cpu_ids && cpu_online(tcpu)) {
-- 
2.43.0


