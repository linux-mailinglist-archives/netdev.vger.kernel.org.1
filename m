Return-Path: <netdev+bounces-191726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C95E7ABCE62
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 07:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EB888A3C39
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 05:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160831E9B2A;
	Tue, 20 May 2025 05:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhZdsDNj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69290BE5E
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 05:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747717336; cv=none; b=IoqhC51weEQK8Z8wzqtBWtu3hFa3tYcwtZFYGbstRV9gNo5+DBeIGvEnxefJBQbhX3dBVcl+OKzEMdwgUNgDB8qL3V5xkdNaD192rSL03uBHbFv8gzPIv6dT+bi+vIeroBk7wHJGuxLT0jVy5mDmj2cBCHlPecInXD9A+qxXo9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747717336; c=relaxed/simple;
	bh=01Pa1MRduJoGzPYd+5E/wcxCwR7JiqrUPuL0+GizBQk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a8xUXEG1fjA67rBsUEXqT1n+YkSCDTuVCkBX0YbdE9nZJKFNtZKs7CUl391uj07KaedPgRUENUd5RMBrNHxghzapk5VPMRcpV4uqAt+chLQc78e54KqK842AjbtGx7N/JIwKh/4Q6UjYZTiKcctI9u3XSmKeffznEyfrObOydx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhZdsDNj; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22fcf9cf3c2so42512735ad.0
        for <netdev@vger.kernel.org>; Mon, 19 May 2025 22:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747717333; x=1748322133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Zo89Uh65y1W7p51jiseNB1QHRLEnuIdeBuM916/T1I=;
        b=bhZdsDNjfloo3IYsuvCC6RWHobywBiF0iAAZUsh9JRPFQJnEDedN2HAV+xyUH63aG6
         Xh5zGDtneafQXNpukfzmfBtpuerM/uZn05aWNPD8xMviU1AwT7SQG1fYCLuyPOMSWDvt
         r1PwJ3cTPv6BgpTiKZOA+1b4sBmFVvWl8FjbLYY2u0NRMv7F7EgTKwqVCHb3tzjKb1Nx
         DO0dYiAdlMjXm6KRM+n4s8bMOqvn2Oly4inQXiBtERCQGArprn6sOWMjLgwk8XZl6/6q
         GYAhPY94OEIMiqU5YgC7IkHGD8MnFfAZJbLP6qJJeAYx8cfhEw7BkcNETaZ72jnfCMbn
         o2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747717333; x=1748322133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Zo89Uh65y1W7p51jiseNB1QHRLEnuIdeBuM916/T1I=;
        b=pb7BHwVd3X+yPVThESYnpA9TT+4Ifepzls85Ylc/P4G2O2F4z4oheW3AMbjUa7SLQb
         ncTQ7NDOQO5Iq+JclWZObsABoakPMv7UDrfZk65s/h6yozXFJjCe3KIqJgmO+YoAAbsC
         4AL6QdhKjaFE0kgy4gYa7SVk9uEpWpTJSPXm22GHVM3elUECqAGBtOMYbgHHfkx4KoyJ
         ettGWRmeZ7gPQZah3eRAV9B/q/0uX0lbPGegE/wbpbxsrQowGoM8Rt7KQ68oKnk6VGph
         5cbJPvIzwJbUeu79egis+uhzu+QHfZwl9Lt7hG7DbZ2AJHIE9cTv692UqmF9BcE3hqL7
         Nrxw==
X-Gm-Message-State: AOJu0Yy+6rILwWJsCt1rP1XGkjKW6WD0XeQZ3CVlWvrnGr4rGjBUO41a
	Nd3z3H45ocFxYbqCsMtTla1hnscELxEN8LhQVnXjaMqkud+TB3MAMEdMZVX9WzXq
X-Gm-Gg: ASbGncsSy9+lQQZ56z1NMdapVkdjWlX5hcHkkDSmqFfuwxrDnhvLd6JVq2Ph5f6kWMa
	33HgG2Z7qv0nPnVVFwVvS/A5n5niL2UGp1bshHWvOHrmHJcTVDKyQBNS5KlkKtyehPvS6+Ka1mZ
	e4wIhGtI8u4/ROdczHE64/55Ze3tDhZYtwePlGu43hlOdZHDrNvU9U84gbiEofmY0w/xDF48dXi
	c6KZnDaXR0+IiMAXiu5jfcJyPCnNDSUOegkp7VMkBGmETVtieEFSAOAf+XGMV41upjAJTDQrlat
	OSlOjx6CHTqrn6txpjcx3TJnsCiUllKJR+jd8haT7/WFXwSyxx21n3FMkfdITYRW
X-Google-Smtp-Source: AGHT+IESXd/dVWiym3PzXMePeQxsJl9U8pCh2WdoEQGkNtnGe2NW3PES8sb+ekfXIVADGkNjqgfurQ==
X-Received: by 2002:a17:902:ea0e:b0:227:ac2a:2472 with SMTP id d9443c01a7336-231d43c3e5emr249654225ad.28.1747717333166;
        Mon, 19 May 2025 22:02:13 -0700 (PDT)
Received: from krishna-laptop.localdomain ([134.238.240.39])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ebb084sm68322245ad.201.2025.05.19.22.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 22:02:12 -0700 (PDT)
From: Krishna Kumar <krikku@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	edumazet@google.com,
	intel-wired-lan@lists.osuosl.org,
	andrew+netdev@lunn.ch,
	kuba@kernel.org,
	pabeni@redhat.com,
	sridhar.samudrala@intel.com,
	ahmed.zaki@intel.com,
	krishna.ku@flipkart.com
Subject: [PATCH] net: ice: Perform accurate aRFS flow match
Date: Tue, 20 May 2025 10:32:05 +0530
Message-ID: <20250520050205.2778391-1-krikku@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes an issue seen in a large-scale deployment under heavy
incoming pkts where the aRFS flow wrongly matches a flow and reprograms the
NIC with wrong settings. That mis-steering causes RX-path latency spikes
and noisy neighbor effects when many connections collide on the same has
(some of our production servers have 20-30K connections).

set_rps_cpu() calls ndo_rx_flow_steer() with flow_id that is calculated by
hashing the skb sized by the per rx-queue table size. This results in
multiple connections (even across different rx-queues) getting the same
hash value. The driver steer function modifies the wrong flow to use this
rx-queue, e.g.:
    Flow#1 is first added:
	    Flow#1:  <ip1, port1, ip2, port2>, Hash 'h', q#10
    Later when a new flow needs to be added:
	    Flow#2:  <ip3, port3, ip4, port4>, Hash 'h', q#20
The driver finds the hash 'h' from Flow#1 and updates it to use q#20. This
results in both flows getting un-optimized - packets for Flow#1 goes to
q#20, and then reprogrammed back to q#10 later and so on; and Flow #2
programming is never done as Flow#1 is matched first for all misses. Many
flows may wrongly share the same hash and reprogram rules of the original
flow each with their own q#.

Tested on two 144-core servers with 16K netperf sessions for 180s. Netperf
clients are pinned to cores 0-71 sequentially (so that wrong packets on q#s
72-143 can be measured). IRQs are set 1:1 for queues -> CPUs, enable XPS,
enable aRFS (global value is 144 * rps_flow_cnt).

Test notes about results from ice_rx_flow_steer():
---------------------------------------------------
1. "Skip:" counter increments here:
    if (fltr_info->q_index == rxq_idx ||
	arfs_entry->fltr_state != ICE_ARFS_ACTIVE)
	    goto out;
2. "Add:" counter increments here:
    ret = arfs_entry->fltr_info.fltr_id;
    INIT_HLIST_NODE(&arfs_entry->list_entry);
3. "Update:" counter increments here:
    /* update the queue to forward to on an already existing flow */

- **rps_flow_cnt=512**
  - Ratio of packets on good vs bad queues: 214 vs 822,392
  - Avoid updating wrong aRFS filter: 0 vs 310,826
  - CPU: User: 216 vs 183, System: 1441 vs 1171, Softirq: 1245 vs 920
         Total: 29.02 22.74
  - aRFS Add: 6,078,551 vs 6,126,286 Update: 533,973 vs 59
         Skip: 82,219,629 vs 77,088,191, Del: 6,078,409 vs 6,126,139

- **rps_flow_cnt=1024**
  - Ratio of packets on good vs bad queues: 854 vs 1,003,176
  - Avoid updating wrong aRFS filter: 0 vs 50,363
  - CPU: User: 220 vs 206, System: 1460 vs 1322 Softirq: 1216 vs 1027
         Total: 28.96 vs 25.55
  - aRFS Add: 7,000,757 vs 7,499,586 Update: 504,371 vs 33
         Skip: 27,455,269 vs 21,752,043, Del: 7,000,610 vs 7,499,438

- **rps_flow_cnt=2048**
  - Ratio of packets on good vs bad queues: 1,173,756 vs 981,892
  - Avoid updating wrong aRFS filter: 0 vs 30,145
  - CPU: User: 216 vs 206, System: 1447 vs 1320, Softirq: 1238 vs 961
         Total: 29.01 vs 24.87
  - aRFS Add: 7,226,598 vs 6,960,991, Update: 521,264 vs 32
         Skip: 7,236,716 vs 4,584,043, Del: 722,6430 vs 696,0798

A separate TCP_STREAM and TCP_RR with 1,4,8,16,64,128,256,512 connections
showed no performance degradation.

Some points on the patch/aRFS behavior:
1. Enabling full tuple matching ensures flows are always correctly matched,
   even with smaller hash sizes.
2. 5-6% drop in CPU utilization as the packets arrive at the correct CPUs
   and fewer calls to driver for programming on misses.
3. Larger hash tables reduces mis-steering due to more unique flow hashes,
   but still has clashes. However, with larger per-device rps_flow_cnt, old
   flows take more time to expire and new aRFS flows cannot be added if h/w
   limits are reached (rps_may_expire_flow() succeeds when 10*rps_flow_cnt
   pkts have been processed by this cpu that are not part of the flow).

Signed-off-by: Krishna Kumar <krikku@gmail.com>
---
 drivers/net/ethernet/intel/ice/ice_arfs.c | 45 +++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_arfs.c b/drivers/net/ethernet/intel/ice/ice_arfs.c
index 2bc5c7f59844..b36bd189bd64 100644
--- a/drivers/net/ethernet/intel/ice/ice_arfs.c
+++ b/drivers/net/ethernet/intel/ice/ice_arfs.c
@@ -377,6 +377,47 @@ ice_arfs_is_perfect_flow_set(struct ice_hw *hw, __be16 l3_proto, u8 l4_proto)
 	return false;
 }
 
+/**
+ * ice_arfs_cmp - Check if aRFS filter matches this flow.
+ * @fltr_info: filter info of the saved ARFS entry.
+ * @fk: flow dissector keys.
+ * n_proto:  One of htons(IPv4) or htons(IPv6).
+ * ip_proto: One of IPPROTO_TCP or IPPROTO_UDP.
+ *
+ * Since this function assumes limited values for n_proto and ip_proto, it
+ * is meant to be called only from ice_rx_flow_steer().
+ */
+static bool
+ice_arfs_cmp(const struct ice_fdir_fltr *fltr_info, const struct flow_keys *fk,
+	     __be16 n_proto, u8 ip_proto)
+{
+	/*
+	 * Determine if the filter is for IPv4 or IPv6 based on flow_type,
+	 * which is one of ICE_FLTR_PTYPE_NONF_IPV{4,6}_{TCP,UDP}.
+	 */
+	bool is_v4 = fltr_info->flow_type == ICE_FLTR_PTYPE_NONF_IPV4_TCP ||
+		     fltr_info->flow_type == ICE_FLTR_PTYPE_NONF_IPV4_UDP;
+
+	/* Following checks are arranged in the quickest and most discriminative
+	 * fields first for early failure.
+	 */
+	if (is_v4)
+		return n_proto == htons(ETH_P_IP) &&
+			fltr_info->ip.v4.src_port == fk->ports.src &&
+			fltr_info->ip.v4.dst_port == fk->ports.dst &&
+			fltr_info->ip.v4.src_ip == fk->addrs.v4addrs.src &&
+			fltr_info->ip.v4.dst_ip == fk->addrs.v4addrs.dst &&
+			fltr_info->ip.v4.proto == ip_proto;
+
+	return fltr_info->ip.v6.src_port == fk->ports.src &&
+		fltr_info->ip.v6.dst_port == fk->ports.dst &&
+		fltr_info->ip.v6.proto == ip_proto &&
+		!memcmp(&fltr_info->ip.v6.src_ip, &fk->addrs.v6addrs.src,
+			sizeof(struct in6_addr)) &&
+		!memcmp(&fltr_info->ip.v6.dst_ip, &fk->addrs.v6addrs.dst,
+			sizeof(struct in6_addr));
+}
+
 /**
  * ice_rx_flow_steer - steer the Rx flow to where application is being run
  * @netdev: ptr to the netdev being adjusted
@@ -448,6 +489,10 @@ ice_rx_flow_steer(struct net_device *netdev, const struct sk_buff *skb,
 			continue;
 
 		fltr_info = &arfs_entry->fltr_info;
+
+		if (!ice_arfs_cmp(fltr_info, &fk, n_proto, ip_proto))
+			continue;
+
 		ret = fltr_info->fltr_id;
 
 		if (fltr_info->q_index == rxq_idx ||
-- 
2.39.5


