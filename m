Return-Path: <netdev+bounces-207760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C77B08760
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 09:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E00D3B1236
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 07:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7163826738B;
	Thu, 17 Jul 2025 07:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ke0axdv3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A522676C2
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 07:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752739038; cv=none; b=TSdelPHT+mqNIHjXVyvg4OkP9Wnn4587EOYuDpzqacKtiofaH937bm6f4YGby4WdPFHZEEd8vdm8vZvtwAZdNdMPML5n8T/USADxKmjmEOoqkzrMszypOtn6rx0lY41zdc19wQ/2YhSIKoZ+EHRZ5lpXEyFuy0WTihFD8EsWah0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752739038; c=relaxed/simple;
	bh=SxtLZ3WqDscFG4GuZQEXeuZ/n1qGW3jYGEIivDb5JFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kqVKCL+2MwTIrqbckFz1GN+654fbLyYmYbxR4T33d/n+mrPqsmvSF1EL2ZAXZaCQBQF17XYBBoxZ68WNrjHy3zGRLoCId9p3y5im4JiNcF8U82W/V+FDoP1eGDV1Zy1QmEj4O/jFIg1Od4DPEvrrzVRlzcG5OYCHtcDB8pY3fpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ke0axdv3; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-235ea292956so5713225ad.1
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 00:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752739035; x=1753343835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfbkFqTTFTKVNTyXHgO6IQ/PVxsqzZJulyD6ZuBMp1I=;
        b=Ke0axdv3UQURIAjgX6rPNHhv9tjOqxMvXtTghaj03avJSNZQiXiojqH6DmgSYodhU1
         /9HCTvdJpBQELIvaWZXTt4FwtJicjhp/4hzzGIy45dre69P3hEhRNqLBaoSAQ5BnENyn
         9fPTQpih8LdkSyEiRZ1459o31YJZtIydJthduyAWj6RO3GHpQ+QBUhekGAtj40RIF7BV
         9HrVo13Lg4vrMJ2ILyjrI338o09xO8yvH5WnEoL0FuHDUBaRgTIyheWU62NTkWQDhUAh
         en+rcQ3k9cimoEkgNqy0tU84jwGOnYjQr+wQSecYiQJbwm4KH3JH7KGLIyKpUcMXHEQB
         mTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752739035; x=1753343835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfbkFqTTFTKVNTyXHgO6IQ/PVxsqzZJulyD6ZuBMp1I=;
        b=Aauc+OEyU6LCqLM47hbJ/p4uguTiptUVDeKdPNWIG3ffyhCccZl1frmFEpi/5LkwN2
         SaVW+7cHGG69/JELmOYawFMLG0s4aYRyTSvEBWevEMhGAcyCa2T9Xav0VBBOBY1Aa3eN
         6C6ia7y4BUogtTMhOazFp7r2a1gI6zRlONuMXb2Q+cQSA4FG01MWIvZwamo33vKdmasz
         CrtTqQdn7IquyTmqwAs2DlEPqnorFjLgKDsssZ9idF+7CpvJtfcPtugL1Lmt1YqErmgv
         1YPrQqIZ+QAEs61X0dLsPD1Bx2Uh9f7VolB13WcN6DDmZFLhSk5B3oLSRrOZb9pL3qEh
         Fciw==
X-Gm-Message-State: AOJu0YxTXeEJDwL1Oerdgh2fg9ip9qZtJ4AQzwSfKaIlcfW0deNU1S9S
	DO9bwSK8HnuGUOum/CRZRhgWaXzm9wpxZozcsHL76pKCYCGQg7Rz0kcxDHLqxkIT
X-Gm-Gg: ASbGncv/DF58rGLTsO/M96Gy3YGSfXoL5lV+NNWRbZavPIcOl5cFY3X3NtI8k4lktJb
	AZleeUMssxzWK2Ld/lqqSBHboL+Q2wx+JoarFymL0fg+1Zf7r+B3kX3lfQ97O3mtIUeAyHz2nVf
	Ciz+EUsak+G4XhZyByVFUsvcryR402IVe1E/fuo5s4vcJYOQxllSZKLt+QUyUMe5EZtHUuzEicu
	ULG2fVLdfWee4BmGC98LZuJYYXmXDUpGlTiy96b3g86nuxeAAogcadZSntj9l36fmwm05yTH8Ix
	kBDJCzixy6H1Iof57Dk+AoAqYPUVwsOyYeM2mlcqAO7J3YHoxwIfYqdlMdVdv8KHJi7pPUAJPTL
	e1/3qacDdXPGW987JVAboL+SmpDze7947CUm8n96y0YgIjg==
X-Google-Smtp-Source: AGHT+IFMch99H/bN0J8rReYiWEVm1m2iLhHqSIyRWcgB9t6JZkJEsx3f6GbnX5Zp1H2z3c8UXP4jbg==
X-Received: by 2002:a17:902:ccce:b0:235:f143:9b07 with SMTP id d9443c01a7336-23e25684c62mr93638775ad.5.1752739034513;
        Thu, 17 Jul 2025 00:57:14 -0700 (PDT)
Received: from krishna-laptop.localdomain ([134.238.240.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4322e92sm143118425ad.128.2025.07.17.00.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 00:57:13 -0700 (PDT)
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
Subject: [PATCH v3 net-next 1/2] net: Prevent RPS table overwrite for active flows
Date: Thu, 17 Jul 2025 13:26:57 +0530
Message-ID: <20250717075659.2725245-2-krikku@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250717075659.2725245-1-krikku@gmail.com>
References: <20250715112431.2178100-1-krikku@gmail.com>
 <20250717075659.2725245-1-krikku@gmail.com>
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
     active or not, extracted from rps_may_expire_flow().
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
 include/net/rps.h    |  5 +--
 net/core/dev.c       | 84 ++++++++++++++++++++++++++++++++++++++++----
 net/core/net-sysfs.c |  4 ++-
 3 files changed, 83 insertions(+), 10 deletions(-)

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
index 621a639aeba1..614fa64de84e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4837,6 +4837,30 @@ static u32 rfs_slot(u32 hash, const struct rps_dev_flow_table *flow_table)
 	return hash_32(hash, flow_table->log);
 }
 
+#ifdef CONFIG_RFS_ACCEL
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
+static bool rps_flow_is_active(struct rps_dev_flow *rflow,
+			       struct rps_dev_flow_table *flow_table,
+			       unsigned int cpu)
+{
+	return cpu < nr_cpu_ids &&
+	       ((int)(READ_ONCE(per_cpu(softnet_data, cpu).input_queue_head) -
+		READ_ONCE(rflow->last_qtail)) < (int)(10 << flow_table->log));
+}
+#endif
+
 static struct rps_dev_flow *
 set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 	    struct rps_dev_flow *rflow, u16 next_cpu)
@@ -4847,8 +4871,11 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
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
@@ -4863,14 +4890,58 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
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
+
+			/*
+			 * When we overwrite the flow, the driver still has
+			 * the cached entry. But drivers will check if the
+			 * flow is active and rps_may_expire_entry() will
+			 * return False and driver will delete it soon. Hence
+			 * inconsistency between kernel & driver is quickly
+			 * resolved.
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
@@ -5005,17 +5076,16 @@ bool rps_may_expire_flow(struct net_device *dev, u16 rxq_index,
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
index 8f897e2c8b4f..bc2618d288a8 100644
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
2.43.0


