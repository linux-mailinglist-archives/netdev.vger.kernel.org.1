Return-Path: <netdev+bounces-259786-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hGQQN4XfmGlkNwMAu9opvQ
	(envelope-from <netdev+bounces-259786-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 23:26:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFBB16B2A5
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 23:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2708830117B6
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 22:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47F72F3C30;
	Fri, 20 Feb 2026 22:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nTuUD1kt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f74.google.com (mail-yx1-f74.google.com [74.125.224.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D161E7660
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 22:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771626369; cv=none; b=MzFrxZxMzOeIxpQYr60ImaDleK79DsW6/mopXwFC66B89eU2dp4QUZCahGQxNB+ilCxdL0I9Cikus/gu105OS/ZjO0L//7ll34wPWzSgoQ1kBxagF/2yiR6sEt9WV3iF3vmlnMXccl4B0aLj99OjpEsms7npDxnT964sEUdJ+Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771626369; c=relaxed/simple;
	bh=+P9l4qZEJlIvnk24H/wvcRUZMPwgNMWHkq945oK3xdE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=spuJRW3Fy711xSDFHIH7L7pm7aMcbM5hXim9uWr9OcdXybpFbQVzismcNavsdI5tNmonFvfcsotHgUUStLVz7/jEakA6ilrVRk1ryFObxls1XTpgrEN6kkjtxhyc3hIje0XcDTvufWEtfZbmzdBFXThFsvVOJ4wcJmj3sb5N/MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nTuUD1kt; arc=none smtp.client-ip=74.125.224.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yx1-f74.google.com with SMTP id 956f58d0204a3-649f0d26e5eso4280915d50.0
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 14:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771626367; x=1772231167; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fO4WNsIVwI0BR9PdXIfKdGUeTP0BQm+sQVlZuEG3GGI=;
        b=nTuUD1ktocICE6xmQ91qwizPmqxPECWzbz6ZZjGa5cKyYG60BzRceWcKRGnSXVb9g3
         qUIDo2RTLspZe1mfgGlJ01AJS6RUfE6VKfNIqM9s2rst7Hgrp24D2/0fnxOyhP40mjWj
         gAMckQC3GC5e9TRpS4wwWDbI5uWPmoxGcu3zDShRSA99ZUiv9MEYteWcK/o7ZBxCgygt
         AqwNtrK13LvqjIzRVVrvHozl29EA4xszm6mshyUGbivwLI5h1gLPsdmtsiLJR+ciAbTA
         AOC826y526F4I//Q9+W1BL1dQiXJLbcywhRXz4HeP1j3V46o7+NrR9tXx80PeZebBNk3
         ajpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771626367; x=1772231167;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fO4WNsIVwI0BR9PdXIfKdGUeTP0BQm+sQVlZuEG3GGI=;
        b=s5sa5/tqDONe8h9VngDpKGeecsElVjNwUGKg/XBLYC/xoAC9kno5zgA4PIeiRHXhIk
         +KGiJALeTLWhs1pLtc3VkfpFLTMqcVONLtNadvVcwZudbnzHUuZlKOnWOswIrtxtTCT3
         CABQzk2fqkrIMrvZOGUM+73pgwUHaqqifhOeGmLTYjZs23/Xt9t1cE1fVxVP2QyI+Sj0
         UBvIISx9Du0w8whOC9Go+YKwWS6jAGi/5iXt0vlXJn3kkOgl3d5rUOGQ3IL7kLAUswb6
         UjD8Ish3MIwTV6n0MV9UhPmLm3eRuudPoNx3Xl+bOz9Qn7YPHV9u/+LtAIOEmIZZTCdF
         GwZA==
X-Forwarded-Encrypted: i=1; AJvYcCU/Xbw7SwVcH8teWZSkKM8DEDYLqhdk9/QtKr8uVy0CtGT/wFz+/Sg/hY72cs2weqJ2yegfNcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCXpRrosllqiZv9zyE8WffBWCI552RQUAqfl782PGhG8mc1G3y
	oQ9dSIJvIjhik0so4F2e5Zd7g7p4D8qb7mTPFqpsOhGkbIFbSmzA2eYjdr7+S6uehS7bI0fSC6i
	us1z5BCRYKXDp1g==
X-Received: from yxqa13.prod.google.com ([2002:a53:e94d:0:b0:640:d681:9c16])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:c4e:b0:649:b915:a050 with SMTP id 956f58d0204a3-64c787d4f91mr1379476d50.9.1771626367156;
 Fri, 20 Feb 2026 14:26:07 -0800 (PST)
Date: Fri, 20 Feb 2026 22:26:05 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Message-ID: <20260220222605.3468081-1-edumazet@google.com>
Subject: [PATCH net] net: do not pass flow_id to set_rps_cpu()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Krishna Kumar <krikku@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259786-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4CFBB16B2A5
X-Rspamd-Action: no action

Blamed commit made the assumption that the RPS table for each receive
queue would have the same size, and that it would not change.

Compute flow_id in set_rps_cpu(), do not assume we can use the value
computed by get_rps_cpu(). Otherwise we risk out-of-bound access
and/or crashes.

Fixes: 48aa30443e52 ("net: Cache hash and flow_id to avoid recalculation")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Krishna Kumar <krikku@gmail.com>
---
 net/core/dev.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 096b3ff13f6b9bf685cb74d0e762a2b00e97d9de..f3426385f1ba83d98ba237c5f23440b5f119b799 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4992,8 +4992,7 @@ static bool rps_flow_is_active(struct rps_dev_flow *rflow,
 
 static struct rps_dev_flow *
 set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
-	    struct rps_dev_flow *rflow, u16 next_cpu, u32 hash,
-	    u32 flow_id)
+	    struct rps_dev_flow *rflow, u16 next_cpu, u32 hash)
 {
 	if (next_cpu < nr_cpu_ids) {
 		u32 head;
@@ -5004,6 +5003,7 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		struct rps_dev_flow *tmp_rflow;
 		unsigned int tmp_cpu;
 		u16 rxq_index;
+		u32 flow_id;
 		int rc;
 
 		/* Should we steer this flow to a different hardware queue? */
@@ -5019,6 +5019,7 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		if (!flow_table)
 			goto out;
 
+		flow_id = rfs_slot(hash, flow_table);
 		tmp_rflow = &flow_table->flows[flow_id];
 		tmp_cpu = READ_ONCE(tmp_rflow->cpu);
 
@@ -5066,7 +5067,6 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 	struct rps_dev_flow_table *flow_table;
 	struct rps_map *map;
 	int cpu = -1;
-	u32 flow_id;
 	u32 tcpu;
 	u32 hash;
 
@@ -5113,8 +5113,7 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		/* OK, now we know there is a match,
 		 * we can look at the local (per receive queue) flow table
 		 */
-		flow_id = rfs_slot(hash, flow_table);
-		rflow = &flow_table->flows[flow_id];
+		rflow = &flow_table->flows[rfs_slot(hash, flow_table)];
 		tcpu = rflow->cpu;
 
 		/*
@@ -5133,8 +5132,7 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		     ((int)(READ_ONCE(per_cpu(softnet_data, tcpu).input_queue_head) -
 		      rflow->last_qtail)) >= 0)) {
 			tcpu = next_cpu;
-			rflow = set_rps_cpu(dev, skb, rflow, next_cpu, hash,
-					    flow_id);
+			rflow = set_rps_cpu(dev, skb, rflow, next_cpu, hash);
 		}
 
 		if (tcpu < nr_cpu_ids && cpu_online(tcpu)) {
-- 
2.53.0.345.g96ddfc5eaa-goog


