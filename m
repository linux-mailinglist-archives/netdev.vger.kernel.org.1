Return-Path: <netdev+bounces-191985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B001ABE18A
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 19:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02CF17C495
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 17:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A2F27A927;
	Tue, 20 May 2025 17:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OT5Mguw2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B98027E7E3
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 17:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747760828; cv=none; b=u+/KqIiw9T8lE5zQrjh6QsXTQPtQp3PAJCkzfw8j1M4v30S++s57kJ19rej3kIULg003A9UEPHSGjYhi3DNopsu/SRQRHimQl3mT/oPe+Yh8G10yX2oodUQayNe3WKEcrAIMdizDNHdM274lO4uHrtHnneLKkla+CB1+AmR18jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747760828; c=relaxed/simple;
	bh=S+axlp2OLqhwGbiEwXJ/XwuN3faR2Nu22xeuil1eMNc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E9+UYFE3N7gqNH/+b4rMa6JRe2LvaiiTGgXWFTIvScHcU+9ccMjcc9GP1i/O+Q4QVigMyahEHzgnYInff4a0nHbuvaaq1WazsydROEjk88Z+Ep0fimxlTNPibQrFEhNb6rRSR+eeSdoVvED+C5q8VBiiHPYirp1SU90RLax05aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OT5Mguw2; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7399838db7fso5560645b3a.0
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 10:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747760825; x=1748365625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lFe5CRPmw2G3mler/gdvGoz6GknCu8ATHweIAPxKe4c=;
        b=OT5Mguw2Tf8jNKJIz0me3Wc2HgarjgebwFCtUAqzIZCzFcmTwJiJzSN9KTkjRO7tvl
         4udEyAK4wP2MpXEV1RCFeGXfliK95p6yASpdwsDdjCvH4g098HXVkkRx3PIhJYFTSTLo
         TKpNUDsXDaHIXhmamZnav9i12XeZvhj3I9HkgATUacferMYzKaUgpRb7UNDpHqJlzLmd
         3DAMaobj1i5iramnQR6qYKpSsIKYKoUVvGyvI2fVoXft9kgVEyity3JBO24BqDndYI3m
         MLU9bTzNDEz5M8ZW/Dq0oxBL4LKTJHQI1yggzwuW+HlnWmftR3KbfMjHFmItYcspz70V
         nxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747760825; x=1748365625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lFe5CRPmw2G3mler/gdvGoz6GknCu8ATHweIAPxKe4c=;
        b=IR/mfBwafMW1t8DiCncPFFu6J3b9BMu7B7Fuj/8VBBt/7kLlEKl3JE3tBFvirFP2iw
         AuY3bJgTSyrjcG3KXtnk0RqIEKRixlLvAIE7VhifqvYBDRjP+shNIgkpLVIe1jJbu2Fk
         PnT8rrKSGVOecPhF+3ymelxl0cpe6c5Rdjs5ZgEVWoL2cd7pVBXQ2YFQdbFPKU2awRWz
         HmUqqfWRPmQt5WZ0bhJNfu7hP6CoknxfGIYKpffr5WJyPGeJQgox9u+rfZXLBLpmGdkh
         cvu/Q5CGsnxnEmPwqndj77vc16nDSk1Z2B9RYF846fwnZgbjmDj+t2FftgqvB87KKJHk
         n8Ag==
X-Gm-Message-State: AOJu0YzVgtAQBwEK4iZIXDucFeQFoxZo1RU6Z9y0cf+bS4q7j+mSP5yr
	4ZGgr4dZfBlm+A2+GQJMh8v7vhQf6A8tRceYZNnth60WcWymhjxS3Y5H0pow9iYg
X-Gm-Gg: ASbGncuYgcU8MxuvA0aD+0CBG198hiDbT5rwYYNvOTIuzNQlIhZA9QzBkl1tPnbdulG
	etCtbKM4DD2PYUWnic/qL4zVSTD+uZcn36cqtCF9kLD/w3pmu1dt13gB206sbCB+iGHxmnyECEm
	VfydHhCr/6Vz+oQGdhi3c1AVYUXGrZvTNHljeVjBtX8la86Mg/VM8vyMznaqBIQNZDe/Mk2htI0
	Zlap8oP4TIwViPI9gwLQhUa/T2aY/z6uPJET99TZKrEDPiT0gXTrb4tFnNyiMFwVKxKskwKGOTz
	yD1zkk1e3v/mdBwWCwLhT6p1QGa5vRw4W0ZA+7IrTBmhUaaZMIPE4CN6CvyXSDH4
X-Google-Smtp-Source: AGHT+IHgjcVaeBnCZoqq3puUxQXrL2nPm8ZKUDvBc5s5+4N3RXxIKz0JYFs6mRVTwuSqrbT42S4Ziw==
X-Received: by 2002:a05:6a00:4d9a:b0:742:aed4:3e1 with SMTP id d2e1a72fcca58-742aed4044fmr16451127b3a.2.1747760825066;
        Tue, 20 May 2025 10:07:05 -0700 (PDT)
Received: from krishna-laptop.localdomain ([134.238.240.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a96e2765sm8466906b3a.19.2025.05.20.10.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 10:07:04 -0700 (PDT)
From: Krishna Kumar <krikku@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	horms@kernel.org,
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
Subject: [PATCH v2 net] net: ice: Perform accurate aRFS flow match
Date: Tue, 20 May 2025 22:36:56 +0530
Message-ID: <20250520170656.2875753-1-krikku@gmail.com>
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
and noisy neighbor effects when many connections collide on the same
hash (some of our production servers have 20-30K connections).

set_rps_cpu() calls ndo_rx_flow_steer() with flow_id that is calculated by
hashing the skb sized by the per rx-queue table size. This results in
multiple connections (even across different rx-queues) getting the same
hash value. The driver steer function modifies the wrong flow to use this
rx-queue, e.g.: Flow#1 is first added:
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

Runtime comparison: original code vs with the patch for different
rps_flow_cnt values.

+-------------------------------+--------------+--------------+
| rps_flow_cnt                  |      512     |    2048      |
+-------------------------------+--------------+--------------+
| Ratio of Pkts on Good:Bad q's | 214 vs 822K  | 1.1M vs 980K |
| Avoid wrong aRFS programming  | 0 vs 310K    | 0 vs 30K     |
| CPU User                      | 216 vs 183   | 216 vs 206   |
| CPU System                    | 1441 vs 1171 | 1447 vs 1320 |
| CPU Softirq                   | 1245 vs 920  | 1238 vs 961  |
| CPU Total                     | 29 vs 22.7   | 29 vs 24.9   |
| aRFS Update                   | 533K vs 59   | 521K vs 32   |
| aRFS Skip                     | 82M vs 77M   | 7.2M vs 4.5M |
+-------------------------------+--------------+--------------+

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

Changes since v1:
  - Added "Fixes:" tag and documented return values.
  - Added @ for function parameters.
  - Updated subject line to denote target tree (net)

Fixes: 28bf26724fdb0 ("ice: Implement aRFS")
Signed-off-by: Krishna Kumar <krikku@gmail.com>
---
 drivers/net/ethernet/intel/ice/ice_arfs.c | 49 +++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_arfs.c b/drivers/net/ethernet/intel/ice/ice_arfs.c
index 2bc5c7f59844..c957d0a62d25 100644
--- a/drivers/net/ethernet/intel/ice/ice_arfs.c
+++ b/drivers/net/ethernet/intel/ice/ice_arfs.c
@@ -377,6 +377,51 @@ ice_arfs_is_perfect_flow_set(struct ice_hw *hw, __be16 l3_proto, u8 l4_proto)
 	return false;
 }
 
+/**
+ * ice_arfs_cmp - Check if aRFS filter matches this flow.
+ * @fltr_info: filter info of the saved ARFS entry.
+ * @fk: flow dissector keys.
+ * @n_proto:  One of htons(ETH_P_IP) or htons(ETH_P_IPV6).
+ * @ip_proto: One of IPPROTO_TCP or IPPROTO_UDP.
+ *
+ * Since this function assumes limited values for n_proto and ip_proto, it
+ * is meant to be called only from ice_rx_flow_steer().
+ *
+ * Return:
+ * * true	- fltr_info refers to the same flow as fk.
+ * * false	- fltr_info and fk refer to different flows.
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
@@ -448,6 +493,10 @@ ice_rx_flow_steer(struct net_device *netdev, const struct sk_buff *skb,
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


