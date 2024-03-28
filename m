Return-Path: <netdev+bounces-83018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 839D38906C8
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 18:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7BE81C262B0
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 17:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439CE131E3C;
	Thu, 28 Mar 2024 17:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tHmPJZUC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF1939FCF
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 17:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645407; cv=none; b=X4UhTapvpYW30GUegs28EG5H1jnzoYahu092IxXsH7a5Z0WcXtA4Wfk2s2Kmmgw9P4KKG0bE6LYxTEttl4N5F8Ux2bRRl2kqMgYshhrqLffCRURkoIexPRkE4sInHq/APj3AOKhXMNDfOn8o7J/yr8cBH54vVCaQnTP68u267h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645407; c=relaxed/simple;
	bh=VWLua73p7ZUAjdHrayoP/lX15Em4rPKgzz1/a9x1KxQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SVRyS7VzszEWRzROMIYHzpEu0v4KRdMeP5k5iMyGO5jalHdPqhh5eQTLscAfSibDGU2aC7OZsrH3I8PQAVBVejLm6s0BQvYBdwMpZykEUXm7f1dEgMJlrpqKRxQp1fBm7Pr/vmfD+FLIV2jN/pZyyaaRW877tFrDkdXqDDs5E0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tHmPJZUC; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcbee93a3e1so1734847276.3
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 10:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711645404; x=1712250204; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DyO3NL4DZ5+zyEmGrUmGhqOJCsHXA1HlVzHyeVmkchI=;
        b=tHmPJZUCToedZH0Khr2fAir1EVZdmg1TKq27+KLpk5ZLSTaQfmvRPaiRyMGES4y1rh
         YB9Tsnyz/W+i8cyNJTVrhL4VRJnoETtIUzTTx/Ge1wMKjIzii2YvGkH3a0DCRA2DBWPg
         i91BrwR2zxNpSYdik/d8MR2nzfGQOEWOaHMYgjuzpF/fPciQzsrBJCOdepOH2m0PCye6
         NuH2Yw863EwNpW4nbuoEqSGRWESiZQVuqU74N02/DZJ/73WnQPww8InKq1yZfYGwXO/n
         nTXNcekTdlnSaX6fxILl3qQJjQcRcOoCLrMalGriKdciDPn+6fJbQrVIjnJfDHTQURUn
         XTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711645404; x=1712250204;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DyO3NL4DZ5+zyEmGrUmGhqOJCsHXA1HlVzHyeVmkchI=;
        b=eBDqcVK3A7pNtkUSquIJkMQ6hSWHAuT6vTwwSopFyYkcFD8/ZBJWraK0BhgOqS4Zpd
         sCpOjv8tGfrGD3hnEsqCXOWHF1yTGVIOwjfaV9U4WUb7I099tYBqXtIeZmj2G9+hcD1C
         XhwdCeg8dmHFq9r5zF28B4PhbWRkJzFftmecnZjChvHfSTWL5W2qH+8JAyTndRzoFzkD
         AbMn8/d2piMfl43lX+SIGXv0095URlMxFaSkVox2AQuL0jJtGaur5Ch862WF0m9eOwhN
         +I0GrPUMRa+UOsHIhf0tG5aWa+ZwT2yFZ31KY6puyYyqWuVG+VB/K2j9zHt+dEoK/52v
         J8Kw==
X-Gm-Message-State: AOJu0YzeQ56qysJsC9OWI3rlwkHYK74A5e4uItpSJYuwHySg1nXCTZHb
	FbmLN0OeF/zpp0lDkBZ0S/MzGGA6fwzkb2TRCS5n+MXCRIrNarxsmV9NRG2S4NuV1nq99MKv8vn
	hZVhLN9bjTA==
X-Google-Smtp-Source: AGHT+IEcAU6On1FebhvDzRMHxKgc0gG9W0lAfWMgqvnygBHzEBD0mgjfLuzwj379NGUbm10JUxpCruxTKGqE3g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2292:b0:ddd:7581:1234 with SMTP
 id dn18-20020a056902229200b00ddd75811234mr207996ybb.11.1711645404695; Thu, 28
 Mar 2024 10:03:24 -0700 (PDT)
Date: Thu, 28 Mar 2024 17:03:08 +0000
In-Reply-To: <20240328170309.2172584-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240328170309.2172584-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240328170309.2172584-8-edumazet@google.com>
Subject: [PATCH net-next 7/8] net: rps: add rps_input_queue_head_add() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

process_backlog() can batch increments of sd->input_queue_head,
saving some memory bandwidth.

Also add READ_ONCE()/WRITE_ONCE() annotations around sd->input_queue_head
accesses.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/rps.h |  9 +++++++--
 net/core/dev.c    | 13 ++++++++-----
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/net/rps.h b/include/net/rps.h
index c13f829b8556fda63e76544c332f2c089f0d6ea4..135427bc6fcd29b9dad92a671c9a9f4efc975dec 100644
--- a/include/net/rps.h
+++ b/include/net/rps.h
@@ -51,13 +51,18 @@ static inline void rps_input_queue_tail_save(u32 *dest, u32 tail)
 #endif
 }
 
-static inline void rps_input_queue_head_incr(struct softnet_data *sd)
+static inline void rps_input_queue_head_add(struct softnet_data *sd, int val)
 {
 #ifdef CONFIG_RPS
-	sd->input_queue_head++;
+	WRITE_ONCE(sd->input_queue_head, sd->input_queue_head + val);
 #endif
 }
 
+static inline void rps_input_queue_head_incr(struct softnet_data *sd)
+{
+	rps_input_queue_head_add(sd, 1);
+}
+
 /*
  * The rps_dev_flow_table structure contains a table of flow mappings.
  */
diff --git a/net/core/dev.c b/net/core/dev.c
index 1fe7c6b10793d45a03461ee581d240d2442f9e17..59e7fc30e8f03880340bfbeda0fa9e9ac757a168 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4518,7 +4518,7 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 	out:
 #endif
 		rflow->last_qtail =
-			per_cpu(softnet_data, next_cpu).input_queue_head;
+			READ_ONCE(per_cpu(softnet_data, next_cpu).input_queue_head);
 	}
 
 	rflow->cpu = next_cpu;
@@ -4600,7 +4600,7 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		 */
 		if (unlikely(tcpu != next_cpu) &&
 		    (tcpu >= nr_cpu_ids || !cpu_online(tcpu) ||
-		     ((int)(per_cpu(softnet_data, tcpu).input_queue_head -
+		     ((int)(READ_ONCE(per_cpu(softnet_data, tcpu).input_queue_head) -
 		      READ_ONCE(rflow->last_qtail))) >= 0)) {
 			tcpu = next_cpu;
 			rflow = set_rps_cpu(dev, skb, rflow, next_cpu);
@@ -4655,7 +4655,7 @@ bool rps_may_expire_flow(struct net_device *dev, u16 rxq_index,
 		rflow = &flow_table->flows[flow_id];
 		cpu = READ_ONCE(rflow->cpu);
 		if (rflow->filter == filter_id && cpu < nr_cpu_ids &&
-		    ((int)(per_cpu(softnet_data, cpu).input_queue_head -
+		    ((int)(READ_ONCE(per_cpu(softnet_data, cpu).input_queue_head) -
 			   READ_ONCE(rflow->last_qtail)) <
 		     (int)(10 * flow_table->mask)))
 			expire = false;
@@ -6035,9 +6035,10 @@ static int process_backlog(struct napi_struct *napi, int quota)
 			rcu_read_lock();
 			__netif_receive_skb(skb);
 			rcu_read_unlock();
-			rps_input_queue_head_incr(sd);
-			if (++work >= quota)
+			if (++work >= quota) {
+				rps_input_queue_head_add(sd, work);
 				return work;
+			}
 
 		}
 
@@ -6060,6 +6061,8 @@ static int process_backlog(struct napi_struct *napi, int quota)
 		backlog_unlock_irq_enable(sd);
 	}
 
+	if (work)
+		rps_input_queue_head_add(sd, work);
 	return work;
 }
 
-- 
2.44.0.478.gd926399ef9-goog


