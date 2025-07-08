Return-Path: <netdev+bounces-204862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D2EAFC52F
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 10:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B968716A804
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 08:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32131C84BC;
	Tue,  8 Jul 2025 08:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCtsp7ul"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC142184540
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 08:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751962527; cv=none; b=has6Um5AdGfOTbxbYtoBdSNmXTTs1lv3UeMCQysT0/RK+T1mnUruYUK9VEwquWIf9pOOYlO42ZoEapvt1fkbijeohw0SN0VWFi88mxXx4h/GQ/0BzRKnuzL8MTmte16JkjKl+b9S97FHiGY6FFFC4PGah9E5X5/LwaaOtpZl0QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751962527; c=relaxed/simple;
	bh=35rssdZZcSheQIp6nd6KL4XuxjdNwTQxgmFcYRomCrg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mBkcM0XpdszlUBUeO3n7BEUu9ipW+I05jDi5XCrdiYdCILxXRcbxQdDZ/vyIwc4Sv9MqDkoQhxePGc7bSd6EEy3ladMBhztYe2kW+yDI5h4J9CT2v5mtXPzcLcP4bZOLMNXhlWHxo3NF7KdbGQzzCK6Kutmrx4MaSD+TPInIkT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCtsp7ul; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-313a001d781so3323205a91.3
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 01:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751962525; x=1752567325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fOFU3rvOBuvuWe9oD+h6cxy/pt9NBC6iZoU0NSvjxQw=;
        b=HCtsp7uleKgZrA/C6dWi5pOdbC8YD94ZgbO79lUlx2kuVyrD3pa3wDygilnSFYNFNf
         rlXVQADUhlw/5gfhj/Sc+eRYTSjaQsXE7XJrJ6laEvOV7ZV9YG/4oMXy7Bee3DrRWNrV
         Cz2C/5tDNOi8/nhySNp7f5mWrp2m3I/XE8cPrDvA2FVNXZeVQbCbRX9lqKAPhRu+B7iB
         iXBz4ojQYQ1Eh/4RWAu1CddQRlGwyxtUmY2q7pkvyAmFkGe/IKskTXYf93vgVB8RD6IT
         iARcRQKOBvkCIbPelmCbNWjqJJHEYYWjaV/3kwz7AoAgA3wTmNd4ua6BuMejk30Oq9oB
         2Inw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751962525; x=1752567325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fOFU3rvOBuvuWe9oD+h6cxy/pt9NBC6iZoU0NSvjxQw=;
        b=ZOfISXsZJv2fCEqVUSqre842CMgtkXfbPALG2jSFmMtnTzb0NslEFUpENm6dp/TWA5
         7gkkP6YCH7XPX4IFdxoNfJZrbmMSD3g3Qt6eNuXAkskMtG1TFA9ACizIl54QWaSGfZzW
         07NEG2xj28LYR/kE6pid1aMBJQtmOX0M4DcUtAN89ICfb9IZ6FQhSF/sjMGFaIoJdfwc
         rC042IXdWeIbwnn7cN3iUZD1paaaGYAOoJXKyyabf8wYCtHBXLMdH11LW5cKq4uj34xO
         Acp1ryJSUrplM1XNjv6o1o8UruQ7Q6mXeWz73pUGd3mL/HLKrPyslpUKBsTiK9SId5VO
         DQCw==
X-Gm-Message-State: AOJu0Yxm3f+K/Kwp2Na13YkdWG7LtMTwb10QwTDFab0h7P3daK7x/sgL
	viEZjrIXQLPqfmNwfL868cbb2XA9k69G1Uw3HoiSzBAaGvRUAw0e6G0CL4rl9WRo
X-Gm-Gg: ASbGncvNMVrBn7T0BxK6o198uDKOVzLkXOHRfapjlouvEtfkaltMHg9b3kp7KKyZmmh
	rzZZEQ7fOlKas0dyPnmeprhfdGKUgKzHIjQ2nFcawF09HgG8YPGjE+B1KecwQSXOphj3J3kj3/P
	utshYYafx9XaanjVPX5KAk5lK7fe/zRYEfXTbwRI3AsBXNSSb8+DrnJEXOG8cgHEu7cmQ25JHRk
	5DOYJm3Uko2wIjSqIOuvQhMY5GJkvlPbufLOffnv1+OlSoihWxDYUbHCY39BdZGI+ozr6HbBkY9
	SNV5wJexPPxOPfGxiEdRuWN9NUOPGI0P7A3aWV1HoV6wmmu4P04CYVEpwttfv1C81Ih0XsWqSI0
	=
X-Google-Smtp-Source: AGHT+IGAMiyInaqswPq1r55Y+wrPf1tJEmKKT3kyY/O2WwdZdxcHlehMFhs0JZYhQMevFb4I9yCjog==
X-Received: by 2002:a17:90b:3ec2:b0:311:fde5:c4be with SMTP id 98e67ed59e1d1-31aac544158mr18538860a91.35.1751962524769;
        Tue, 08 Jul 2025 01:15:24 -0700 (PDT)
Received: from krishna-laptop.localdomain ([134.238.240.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c21e9c89bsm1528401a91.36.2025.07.08.01.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 01:15:24 -0700 (PDT)
From: Krishna Kumar <krikku@gmail.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com
Cc: tom@herbertland.com,
	bhutchings@solarflare.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sdf@fomichev.me,
	kuniyu@google.com,
	ahmed.zaki@intel.com,
	aleksander.lobakin@intel.com,
	atenart@kernel.org,
	jdamato@fastly.com,
	krishna.ku@flipkart.com
Subject: [PATCH] net: Fix RPS table slot collision overwriting flow
Date: Tue,  8 Jul 2025 13:45:16 +0530
Message-ID: <20250708081516.53048-1-krikku@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes an issue where two different flows on the same RX queue
produce the same hash.

Flow #1: A packet for Flow #1 comes in, kernel calls the steering
   function. The driver gives back a filter id. The kernel saves this
   filter id in the selected slot. Later, the driver's service task
   checks if any filters have expired and then installs the rule for
   Flow #1.
Flow #2: A packet for Flow #2 comes in. It goes through the same steps.
   But this time, the chosen slot is being used by Flow #1. The driver
   gives a new filter id and the kernel saves it in the same slot. When
   the driver's task runs, it runs through all the flows, checks if
   Flow #1 should be expired, the kernel returns True as the slot has a
   different filter id, and then the driver installs the rule for
   Flow #2.
Flow #1 again: Another packet for Flow #1 comes in. The same thing
   repeats. The slot is overwritten with a new filter id for Flow #1.

This causes a repeated cycle of flow programming for missed packets,
wasting CPU cycles while not improving performance. This problem happens
at higher rates when the RPS table is small, but tests show it can still
happen even with 12,000 connections and an RPS size of 16K per queue
(global table size = 144x16K).

This patch prevents overwriting an rps_dev_flow entry if it is active.
The intention is that it is better to do aRFS for the first flow instead
of hurting all flows on the same hash. Without this, 2 (or more) flows
on one RX queue with the same hash can keep overwriting each other. This
causes the driver to reprogram the flow repeatedly wasting CPU cycles
(as well as add/delete operations involve DMA/PCIe write to the NIC's
hardware tables, etc).

Changes:
-----------
1. Add a new 'hash' field to struct rps_dev_flow.
2. Add rps_flow_is_active(): a helper function to check if a flow is
   active or not, extracted from rps_may_expire_flow().
3. In set_rps_cpu(): avoid overwriting by programming a new filter if:
      - The slot is not in use, or
      - The slot is in use but the flow is not active, or
      - The slot has an active flow with the same hash, but target CPU
        differs.
   Also, save the hash in the rps_dev_flow entry.
4. In get_rps_cpu(): Minor optimization of variables needed by
   set_rps_cpu() too.
5. rps_may_expire_flow(): Use earlier extracted rps_flow_is_active().

Testing & results:
-------------------
- Driver: ice (E810 NIC).
- #CPUs = #RXq = 144.
- Number of flows: 12K.
- Eight RPS settings from 256 to 32768. Though RPS=256 is not ideal, it
  is still sufficient to cover 12K flows (256*144 rx-queues = 32K global
  table slots).
- Each RPS test duration = 10 mins.

Legend for following tables:
----------------------------
Steer-C: #times ndo_rx_flow_steer() was called by set_rps_cpu()
Steer-L: #times ice_arfs_flow_steer() looped over aRFS entries
Add:     #times driver actually programmed aRFS (ice_arfs_build_entry())
Del:     #times driver deleted the flow (ice_arfs_del_flow_rules())
Units:   K = 1,000 times, M = 1 million times

Two types of tests were run:
1. Single run: 12K connections ran for 10 mins per RPS with original
   code, 10 mins with the new code.
-------------------- One iteration, Original code ---------------
|  RPS  | Latency |   Add    |   Del    |  Steer-C  | Steer-L   |
-----------------------------------------------------------------
| 256   | 229.05  | 3.5 M    | 3.5 M    | 114.4 M   | 274.8 M   |
| 512   | 225.01  | 12.0 M   | 12.0 M   | 58.2 M    | 194.2 M   |
| 1024  | 228.86  | 16.9 M   | 16.9 M   | 26.9 M    | 191.5 M   |
| 2048  | 218.46  | 10.1 M   | 10.1 M   | 12.3 M    | 113.9 M   |
| 4096  | 224.93  | 5.5 M    | 5.5 M    | 6.3 M     | 63.6 M    |
| 8192  | 218.22  | 3.0 M    | 3.0 M    | 3.5 M     | 36.3 M    |
| 16384 | 219.62  | 1.3 M    | 1.3 M    | 1.5 M     | 15.9 M    |
| 32768 | 225.29  | 644.4 K  | 632.5 K  | 752.1 K   | 7.1 M     |
------------------- One iteration, New code ---------------------
|  RPS  | Latency |   Add    |   Del    |  Steer-C  | Steer-L   |
-----------------------------------------------------------------
| 256   | 202.32  | 12.1 K   | 4119     | 12.4 K    | 66.9 K    |
| 512   | 201.22  | 11.0 K   | 304      | 11.0 K    | 57.0 K    |
| 1024  | 200.63  | 11.5 K   | 68       | 11.5 K    | 62.0 K    |
| 2048  | 201.60  | 11.7 K   | 47       | 11.7 K    | 64.3 K    |
| 4096  | 207.21  | 11.8 K   | 47       | 11.8 K    | 65.5 K    |
| 8192  | 201.91  | 11.9 K   | 45       | 12.0 K    | 66.4 K    |
| 16384 | 201.80  | 11.9 K   | 6        | 12.0 K    | 66.2 K    |
| 32768 | 202.27  | 11.9 K   | 1        | 12.0 K    | 66.3 K    |
-----------------------------------------------------------------

2. Five runs: To check that flows expire and new flows are programmed
   correctly. Total flows created: 60,000. Each test ran for 2 mins x
   5 runs = 10 mins (same time as the single run). E.g., for RPS = 512,
   it ran for 20 mins in total (10 mins for the old code + 10 minutes
   for the new code, each of the 5 individual test running for 2 mins
   each), and similarly for other RPS values.
-------------------- Five iterations, Original code -------------
|  RPS  | Latency |   Add    |   Del    |  Steer-C  | Steer-L   |
-----------------------------------------------------------------
| 256   | 241.39  | 1.8 M    | 1.8 M    | 126.8 M   | 308.2 M   |
| 512   | 239.41  | 9.9 M    | 9.9 M    | 80.4 M    | 264.2 M   |
| 1024  | 252.52  | 13.8 M   | 13.7 M   | 97.7 M    | 507.5 M   |
| 2048  | 277.41  | 7.9 M    | 7.9 M    | 137.8 M   | 630.2 M   |
| 4096  | 278.36  | 3.9 M    | 3.9 M    | 127.4 M   | 604.5 M   |
| 8192  | 287.86  | 2.1 M    | 2.1 M    | 122.8 M   | 586.1 M   |
| 16384 | 285.90  | 1.0 M    | 989.8 K  | 124.0 M   | 593.4 M   |
| 32768 | 283.82  | 510.8 K  | 498.9 K  | 124.8 M   | 600.9 M   |
-------------------- Five iterations, New code ------------------
|  RPS  | Latency |   Add    |   Del    |  Steer-C  | Steer-L   |
-----------------------------------------------------------------
| 256   | 218.30  | 54.1 K   | 47.4 K   | 231.4 K   | 1.1 M     |
| 512   | 220.20  | 54.7 K   | 47.1 K   | 125.7 K   | 786.4 K   |
| 1024  | 221.11  | 56.2 K   | 46.5 K   | 116.0 K   | 749.0 K   |
| 2048  | 215.96  | 57.7 K   | 46.3 K   | 96.6 K    | 715.2 K   |
| 4096  | 212.95  | 58.5 K   | 46.8 K   | 85.2 K    | 699.9 K   |
| 8192  | 213.57  | 59.1 K   | 47.2 K   | 79.2 K    | 695.8 K   |
| 16384 | 217.85  | 59.2 K   | 47.4 K   | 84.6 K    | 705.5 K   |
| 32768 | 212.84  | 59.3 K   | 47.4 K   | 73.5 K    | 690.0 K   |
-----------------------------------------------------------------

Flow Management (add/delete) remained almost constant at 11K (or 11K*5)
compared to values in millions (and going down to ~500K for larger RPS).

Cc: Eric Dumazet <edumazet@google.com>
Cc: Tom Herbert <tom@herbertland.com>
Cc: Ben Hutchings <bhutchings@solarflare.com>
Signed-off-by: Krishna Kumar <krikku@gmail.com>
---
 include/net/rps.h    |  5 ++-
 net/core/dev.c       | 88 ++++++++++++++++++++++++++++++++++++++------
 net/core/net-sysfs.c |  4 +-
 3 files changed, 83 insertions(+), 14 deletions(-)

diff --git a/include/net/rps.h b/include/net/rps.h
index d8ab3a08bcc4..8e33dbea9327 100644
--- a/include/net/rps.h
+++ b/include/net/rps.h
@@ -25,13 +25,14 @@ struct rps_map {
 
 /*
  * The rps_dev_flow structure contains the mapping of a flow to a CPU, the
- * tail pointer for that CPU's input queue at the time of last enqueue, and
- * a hardware filter index.
+ * tail pointer for that CPU's input queue at the time of last enqueue, a
+ * hardware filter index, and the hash of the flow.
  */
 struct rps_dev_flow {
 	u16		cpu;
 	u16		filter;
 	unsigned int	last_qtail;
+	u32		hash;
 };
 #define RPS_NO_FILTER 0xffff
 
diff --git a/net/core/dev.c b/net/core/dev.c
index be97c440ecd5..68ccd54ae158 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4837,9 +4837,32 @@ static u32 rfs_slot(u32 hash, const struct rps_dev_flow_table *flow_table)
 	return hash_32(hash, flow_table->log);
 }
 
+/**
+ * rps_flow_is_active - check whether the flow is recently active.
+ * @rflow: Specific flow to check activity.
+ * @flow_table: Check activity against the flow_table's size.
+ * @cpu: CPU saved in @rflow.
+ *
+ * If the CPU has processed many packets since the flow's last activity
+ * (beyond 10 times the table size), the flow is considered stale.
+ *
+ * Return values:
+ *	True:  Flow has recent activity.
+ *	False: Flow does not have recent activity.
+ */
+static inline bool rps_flow_is_active(struct rps_dev_flow *rflow,
+				      struct rps_dev_flow_table *flow_table,
+				      unsigned int cpu)
+{
+	return cpu < nr_cpu_ids &&
+	       ((int)(READ_ONCE(per_cpu(softnet_data, cpu).input_queue_head) -
+		READ_ONCE(rflow->last_qtail)) < (int)(10 << flow_table->log));
+}
+
 static struct rps_dev_flow *
 set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
-	    struct rps_dev_flow *rflow, u16 next_cpu)
+	    struct rps_dev_flow *rflow, u16 next_cpu, u32 hash,
+	    u32 flow_id)
 {
 	if (next_cpu < nr_cpu_ids) {
 		u32 head;
@@ -4847,8 +4870,9 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		struct netdev_rx_queue *rxqueue;
 		struct rps_dev_flow_table *flow_table;
 		struct rps_dev_flow *old_rflow;
+		struct rps_dev_flow *tmp_rflow;
+		unsigned int tmp_cpu;
 		u16 rxq_index;
-		u32 flow_id;
 		int rc;
 
 		/* Should we steer this flow to a different hardware queue? */
@@ -4863,14 +4887,54 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		flow_table = rcu_dereference(rxqueue->rps_flow_table);
 		if (!flow_table)
 			goto out;
-		flow_id = rfs_slot(skb_get_hash(skb), flow_table);
+
+		tmp_rflow = &flow_table->flows[flow_id];
+		tmp_cpu = READ_ONCE(tmp_rflow->cpu);
+
+		/* Make sure this slot is usable before enabling steer */
+		if (READ_ONCE(tmp_rflow->filter) != RPS_NO_FILTER) {
+			/* This slot has an entry */
+			if (rps_flow_is_active(tmp_rflow, flow_table,
+					       tmp_cpu)) {
+				/*
+				 * This slot has an active "programmed" flow.
+				 * Break out if the cached value stored is for
+				 * a different flow, or (for our flow) the
+				 * rx-queue# did not change.
+				 */
+				if (hash != READ_ONCE(tmp_rflow->hash) ||
+				    next_cpu == tmp_cpu) {
+					/*
+					 * Don't unnecessarily reprogram if:
+					 * 1. This slot has an active different
+					 *    flow.
+					 * 2. This slot has the same flow (very
+					 *    likely but not guaranteed) and
+					 *    the rx-queue# did not change.
+					 */
+					goto out;
+				}
+			}
+			/*
+			 * When we overwrite the flow, the driver still has
+			 * the cached entry. But drivers will check if the
+			 * flow is active and rps_may_expire_entry() will
+			 * return False and driver will delete it soon. Hence
+			 * inconsistency is resolved quickly between the kernel
+			 * and drivers.
+			 */
+		}
+
 		rc = dev->netdev_ops->ndo_rx_flow_steer(dev, skb,
 							rxq_index, flow_id);
 		if (rc < 0)
 			goto out;
+
 		old_rflow = rflow;
-		rflow = &flow_table->flows[flow_id];
+		rflow = tmp_rflow;
 		WRITE_ONCE(rflow->filter, rc);
+		WRITE_ONCE(rflow->hash, hash);
+
 		if (old_rflow->filter == rc)
 			WRITE_ONCE(old_rflow->filter, RPS_NO_FILTER);
 	out:
@@ -4896,6 +4960,7 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 	struct rps_dev_flow_table *flow_table;
 	struct rps_map *map;
 	int cpu = -1;
+	u32 flow_id;
 	u32 tcpu;
 	u32 hash;
 
@@ -4942,7 +5007,8 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		/* OK, now we know there is a match,
 		 * we can look at the local (per receive queue) flow table
 		 */
-		rflow = &flow_table->flows[rfs_slot(hash, flow_table)];
+		flow_id = rfs_slot(hash, flow_table);
+		rflow = &flow_table->flows[flow_id];
 		tcpu = rflow->cpu;
 
 		/*
@@ -4961,7 +5027,8 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		     ((int)(READ_ONCE(per_cpu(softnet_data, tcpu).input_queue_head) -
 		      rflow->last_qtail)) >= 0)) {
 			tcpu = next_cpu;
-			rflow = set_rps_cpu(dev, skb, rflow, next_cpu);
+			rflow = set_rps_cpu(dev, skb, rflow, next_cpu,
+					    hash, flow_id);
 		}
 
 		if (tcpu < nr_cpu_ids && cpu_online(tcpu)) {
@@ -5005,17 +5072,16 @@ bool rps_may_expire_flow(struct net_device *dev, u16 rxq_index,
 	struct rps_dev_flow_table *flow_table;
 	struct rps_dev_flow *rflow;
 	bool expire = true;
-	unsigned int cpu;
 
 	rcu_read_lock();
 	flow_table = rcu_dereference(rxqueue->rps_flow_table);
 	if (flow_table && flow_id < (1UL << flow_table->log)) {
+		unsigned int cpu;
+
 		rflow = &flow_table->flows[flow_id];
 		cpu = READ_ONCE(rflow->cpu);
-		if (READ_ONCE(rflow->filter) == filter_id && cpu < nr_cpu_ids &&
-		    ((int)(READ_ONCE(per_cpu(softnet_data, cpu).input_queue_head) -
-			   READ_ONCE(rflow->last_qtail)) <
-		     (int)(10 << flow_table->log)))
+		if (READ_ONCE(rflow->filter) == filter_id &&
+		    rps_flow_is_active(rflow, flow_table, cpu))
 			expire = false;
 	}
 	rcu_read_unlock();
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 1ace0cd01adc..2aec8625347d 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1110,8 +1110,10 @@ static ssize_t store_rps_dev_flow_table_cnt(struct netdev_rx_queue *queue,
 			return -ENOMEM;
 
 		table->log = ilog2(mask) + 1;
-		for (count = 0; count <= mask; count++)
+		for (count = 0; count <= mask; count++) {
 			table->flows[count].cpu = RPS_NO_CPU;
+			table->flows[count].filter = RPS_NO_FILTER;
+		}
 	} else {
 		table = NULL;
 	}
-- 
2.43.0


