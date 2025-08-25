Return-Path: <netdev+bounces-216356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD0BB3346F
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 05:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8C2D189B6DA
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 03:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DAB233145;
	Mon, 25 Aug 2025 03:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEA0iYbj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE22323ABA7
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 03:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756091423; cv=none; b=hklKFz7iB3+tuTapAy9iLx3wUn159ePMSoWceyBjIa3o9434fzva1KlPtTN9PtMeXAW073lyT1iJrIIQPtoqmZzTfc3AwdVnHj8QcuDMKrsSmvqBSW79aZmmShRAEeAG5/Y5bYXNBk77d9buGE18wSYKxCbEFrSIrfsfDnkUDj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756091423; c=relaxed/simple;
	bh=7e0g8YU9Wce03Oz2uO96yIC2gbkS5Tb2u3NEkTlCAbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MyAakjtXYWnikPzNMw8Xgf2mxtMeah0RAfIHy0GDBFdeK9WHq2VC9+jGT1yqOfmMX3L+jI7QQxBR3Vexla1Ob6PfIlElX4uov/Fk6jCovmSfEIhkOVHm6tAdQzozhwSf3GfsIh9MhquwVcrB0jKo+1gOFXOY+wUec41gqvtPbGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEA0iYbj; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-32567465cddso880185a91.0
        for <netdev@vger.kernel.org>; Sun, 24 Aug 2025 20:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756091421; x=1756696221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=paOp3zjyWVdaewg5la84H7Vu67a54XPOepoIjH32KT4=;
        b=LEA0iYbjwqe49vHdXyMQXUBrifs1i65oSI2PXtR195FwHOpoe6A8vS3RmZMgg2/8xu
         cc1jyHnyLY0PtSr/NFOP6ukfrnmLGzR8XGteOCuIQFnJkTx9wLn9rS4G6eDNiyABw95p
         9q9En17H6X593anQnO5rDQ+waSsyajRLiQJegkG9wplvxLFIqHO/8gfXOLhZSrBfEDbJ
         mk3Vy7YMKy145+OpfMVl93ojokrH2XJieQvEYJw6dHvy85QBbETckXjBeosh18YE1tYU
         d68ZOK4Nk+56I/YvEBKUp3OnFwciJpSgYHOs53+p1vRhvQ7Nybem0Px0U2IHK/iJQPe4
         kVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756091421; x=1756696221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=paOp3zjyWVdaewg5la84H7Vu67a54XPOepoIjH32KT4=;
        b=Xr+w8FHuFdIuoGuircXEAyAehsaE/LcNGphrEgG0cdqy0IdatWIZbV8Zq8WhtoERbt
         JHEeeFikTvUyftEmvQVJz4uec5Ei2wXUV/aHVoG8eCfq1Eb/2lxKmSrj4MPfctuun9lt
         4g0UEaghX5DHRp8SEX8f7w+CLv+NqMt/hnDZ0M6mp9nYE8wrDrkvaO9Q3l8rm9OPgOTf
         3IGjNoXztk74OehZQPGRLHXYCWtU9CXGsV8cNPXe4hqAj/oHQeDRb5hirw8aKCPjEwo3
         CIEVhsm6poGkPDvIwFFUElmYWSUkl9FVX2RlH309s9OzKkgZxFg6B6WeLxvaioodpNGg
         6cYA==
X-Gm-Message-State: AOJu0YxLJobH1gQbIjon8ZMAcdJA2w9d5D9Vf96BNRK11UK2DE7UxXnq
	69YX6ZBLctVt760nzbvxKRoH2icYKthlmo0oUCnlcsxC2Y10y2GUoixKRLYmtMQa
X-Gm-Gg: ASbGncsKTqEw/UpFUWyluKMwNysjG3x+D12x2roeK1F6X0bwvNwAa0oj/2UMACk9gRb
	R2XJqsQQjQM/l2E3q0ijjRwG08xE6Ic/yxKo0SRiRTirrpWOHO4Nt8URpp1RWy8eOfeFyVslZnZ
	3ibRojulE1XjpVjlP8ssxe7zKhzUAq5p45oc2gQ7UASST4Dj4D/fBGs9QL6YEnlCXXZuC+HS2F4
	9MP0+2Hoka2wt+2hAQoyleNe2TasWNTYoJQqpcNPUaNuP+ofi/CfuU0CfgGVc4Lll2tFY5sR5E+
	x8x23d1hFgDOGCZ9fUROvSDstIG+8/+Jt+BrxkAadcZpLM27eFC+AoyFIhp+NX6FnaIF1l5o5be
	AdmCuA8ySXHg1hKhw1CIqzwrmjtxUdiNvZgsiKkaNHA==
X-Google-Smtp-Source: AGHT+IHOX7aEu3OuUDrLZxCcVf5YE/k45oVGhsBymLZzod2BPUdXfzIwEZIgmN1BZjkXGHHDREWjfQ==
X-Received: by 2002:a17:90b:2f87:b0:31f:8723:d128 with SMTP id 98e67ed59e1d1-32517b2db8fmr14242625a91.34.1756091420676;
        Sun, 24 Aug 2025 20:10:20 -0700 (PDT)
Received: from krishna-laptop.localdomain ([2401:4900:62f4:d6c0:d353:4049:5750:d5ac])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771ebabeeffsm29162b3a.30.2025.08.24.20.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 20:10:20 -0700 (PDT)
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
	krishna.ku@flipkart.com,
	krikku@gmail.com
Subject: [RESEND PATCH v7 net-next 1/2] net: Prevent RPS table overwrite of active flows
Date: Mon, 25 Aug 2025 08:40:04 +0530
Message-ID: <20250825031005.3674864-2-krikku@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250825031005.3674864-1-krikku@gmail.com>
References: <20250825031005.3674864-1-krikku@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes an issue where two different flows on the same RXq
produce the same hash resulting in continuous flow overwrites.

Flow #1: A packet for Flow #1 comes in, kernel calls the steering
         function. The driver gives back a filter id. The kernel saves
	 this filter id in the selected slot. Later, the driver's
	 service task checks if any filters have expired and then
	 installs the rule for Flow #1.
Flow #2: A packet for Flow #2 comes in. It goes through the same steps.
         But this time, the chosen slot is being used by Flow #1. The
	 driver gives a new filter id and the kernel saves it in the
	 same slot. When the driver's service task runs, it runs through
	 all the flows, checks if Flow #1 should be expired, the kernel
	 returns True as the slot has a different filter id, and then
	 the driver installs the rule for Flow #2.
Flow #1: Another packet for Flow #1 comes in. The same thing repeats.
         The slot is overwritten with a new filter id for Flow #1.

This causes a repeated cycle of flow programming for missed packets,
wasting CPU cycles while not improving performance. This problem happens
at higher rates when the RPS table is small, but tests show it still
happens even with 12,000 connections and an RPS size of 16K per queue
(global table size = 144x16K = 64K).

This patch prevents overwriting an rps_dev_flow entry if it is active.
The intention is that it is better to do aRFS for the first flow instead
of hurting all flows on the same hash. Without this, two (or more) flows
on one RX queue with the same hash can keep overwriting each other. This
causes the driver to reprogram the flow repeatedly.

Changes:
  1. Add a new 'hash' field to struct rps_dev_flow.
  2. Add rps_flow_is_active(): a helper function to check if a flow is
     active or not, extracted from rps_may_expire_flow(). It is further
     simplified as per reviewer feedback.
  3. In set_rps_cpu():
     - Avoid overwriting by programming a new filter if:
        - The slot is not in use, or
        - The slot is in use but the flow is not active, or
        - The slot has an active flow with the same hash, but target CPU
          differs.
     - Save the hash in the rps_dev_flow entry.
  4. rps_may_expire_flow(): Use earlier extracted rps_flow_is_active().

Testing & results:
  - Driver: ice (E810 NIC), Kernel: net-next
  - #CPUs = #RXq = 144 (1:1)
  - Number of flows: 12K
  - Eight RPS settings from 256 to 32768. Though RPS=256 is not ideal,
    it is still sufficient to cover 12K flows (256*144 rx-queues = 64K
    global table slots)
  - Global Table Size = 144 * RPS (effectively equal to 256 * RPS)
  - Each RPS test duration = 8 mins (org code) + 8 mins (new code).
  - Metrics captured on client

Legend for following tables:
Steer-C: #times ndo_rx_flow_steer() was Called by set_rps_cpu()
Steer-L: #times ice_arfs_flow_steer() Looped over aRFS entries
Add:     #times driver actually programmed aRFS (ice_arfs_build_entry())
Del:     #times driver deleted the flow (ice_arfs_del_flow_rules())
Units:   K = 1,000 times, M = 1 million times

  |-------|---------|------|     Org Code    |---------|---------|
  | RPS   | Latency | CPU  | Add    |  Del   | Steer-C | Steer-L |
  |-------|---------|------|--------|--------|---------|---------|
  | 256   | 227.0   | 93.2 | 1.6M   | 1.6M   | 121.7M  | 267.6M  |
  | 512   | 225.9   | 94.1 | 11.5M  | 11.2M  | 65.7M   | 199.6M  |
  | 1024  | 223.5   | 95.6 | 16.5M  | 16.5M  | 27.1M   | 187.3M  |
  | 2048  | 222.2   | 96.3 | 10.5M  | 10.5M  | 12.5M   | 115.2M  |
  | 4096  | 223.9   | 94.1 | 5.5M   | 5.5M   | 7.2M    | 65.9M   |
  | 8192  | 224.7   | 92.5 | 2.7M   | 2.7M   | 3.0M    | 29.9M   |
  | 16384 | 223.5   | 92.5 | 1.3M   | 1.3M   | 1.4M    | 13.9M   |
  | 32768 | 219.6   | 93.2 | 838.1K | 838.1K | 965.1K  | 8.9M    |
  |-------|---------|------|   New Code      |---------|---------|
  | 256   | 201.5   | 99.1 | 13.4K  | 5.0K   | 13.7K   | 75.2K   |
  | 512   | 202.5   | 98.2 | 11.2K  | 5.9K   | 11.2K   | 55.5K   |
  | 1024  | 207.3   | 93.9 | 11.5K  | 9.7K   | 11.5K   | 59.6K   |
  | 2048  | 207.5   | 96.7 | 11.8K  | 11.1K  | 15.5K   | 79.3K   |
  | 4096  | 206.9   | 96.6 | 11.8K  | 11.7K  | 11.8K   | 63.2K   |
  | 8192  | 205.8   | 96.7 | 11.9K  | 11.8K  | 11.9K   | 63.9K   |
  | 16384 | 200.9   | 98.2 | 11.9K  | 11.9K  | 11.9K   | 64.2K   |
  | 32768 | 202.5   | 98.0 | 11.9K  | 11.9K  | 11.9K   | 64.2K   |
  |-------|---------|------|--------|--------|---------|---------|

Some observations:
  1. Overall Latency improved: (1790.19-1634.94)/1790.19*100 = 8.67%
  2. Overall CPU increased:    (777.32-751.49)/751.45*100    = 3.44%
  3. Flow Management (add/delete) remained almost constant at ~11K
     compared to values in millions.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507161125.rUCoz9ov-lkp@intel.com/
Signed-off-by: Krishna Kumar <krikku@gmail.com>
---
 include/net/rps.h    |  7 +++--
 net/core/dev.c       | 64 +++++++++++++++++++++++++++++++++++++++-----
 net/core/net-sysfs.c |  4 ++-
 3 files changed, 65 insertions(+), 10 deletions(-)

diff --git a/include/net/rps.h b/include/net/rps.h
index d8ab3a08bcc4..73ce56534715 100644
--- a/include/net/rps.h
+++ b/include/net/rps.h
@@ -25,13 +25,16 @@ struct rps_map {
 
 /*
  * The rps_dev_flow structure contains the mapping of a flow to a CPU, the
- * tail pointer for that CPU's input queue at the time of last enqueue, and
- * a hardware filter index.
+ * tail pointer for that CPU's input queue at the time of last enqueue, a
+ * hardware filter index, and the hash of the flow if aRFS is enabled.
  */
 struct rps_dev_flow {
 	u16		cpu;
 	u16		filter;
 	unsigned int	last_qtail;
+#ifdef CONFIG_RFS_ACCEL
+	u32		hash;
+#endif
 };
 #define RPS_NO_FILTER 0xffff
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 1c6e755841ce..656eceb18e67 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4837,6 +4837,36 @@ static u32 rfs_slot(u32 hash, const struct rps_dev_flow_table *flow_table)
 	return hash_32(hash, flow_table->log);
 }
 
+#ifdef CONFIG_RFS_ACCEL
+/**
+ * rps_flow_is_active - check whether the flow is recently active.
+ * @rflow: Specific flow to check activity.
+ * @flow_table: per-queue flowtable that @rflow belongs to.
+ * @cpu: CPU saved in @rflow.
+ *
+ * If the CPU has processed many packets since the flow's last activity
+ * (beyond 10 times the table size), the flow is considered stale.
+ *
+ * Return: true if flow was recently active.
+ */
+static bool rps_flow_is_active(struct rps_dev_flow *rflow,
+			       struct rps_dev_flow_table *flow_table,
+			       unsigned int cpu)
+{
+	unsigned int flow_last_active;
+	unsigned int sd_input_head;
+
+	if (cpu >= nr_cpu_ids)
+		return false;
+
+	sd_input_head = READ_ONCE(per_cpu(softnet_data, cpu).input_queue_head);
+	flow_last_active = READ_ONCE(rflow->last_qtail);
+
+	return (int)(sd_input_head - flow_last_active) <
+		(int)(10 << flow_table->log);
+}
+#endif
+
 static struct rps_dev_flow *
 set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 	    struct rps_dev_flow *rflow, u16 next_cpu)
@@ -4847,8 +4877,11 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		struct netdev_rx_queue *rxqueue;
 		struct rps_dev_flow_table *flow_table;
 		struct rps_dev_flow *old_rflow;
+		struct rps_dev_flow *tmp_rflow;
+		unsigned int tmp_cpu;
 		u16 rxq_index;
 		u32 flow_id;
+		u32 hash;
 		int rc;
 
 		/* Should we steer this flow to a different hardware queue? */
@@ -4863,14 +4896,32 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		flow_table = rcu_dereference(rxqueue->rps_flow_table);
 		if (!flow_table)
 			goto out;
-		flow_id = rfs_slot(skb_get_hash(skb), flow_table);
+
+		hash = skb_get_hash(skb);
+		flow_id = rfs_slot(hash, flow_table);
+
+		tmp_rflow = &flow_table->flows[flow_id];
+		tmp_cpu = READ_ONCE(tmp_rflow->cpu);
+
+		if (READ_ONCE(tmp_rflow->filter) != RPS_NO_FILTER) {
+			if (rps_flow_is_active(tmp_rflow, flow_table,
+					       tmp_cpu)) {
+				if (hash != READ_ONCE(tmp_rflow->hash) ||
+				    next_cpu == tmp_cpu)
+					goto out;
+			}
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
@@ -5005,17 +5056,16 @@ bool rps_may_expire_flow(struct net_device *dev, u16 rxq_index,
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
index c28cd6665444..5ea9f64adce3 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1120,8 +1120,10 @@ static ssize_t store_rps_dev_flow_table_cnt(struct netdev_rx_queue *queue,
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
2.39.5


