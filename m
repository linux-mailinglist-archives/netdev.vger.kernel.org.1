Return-Path: <netdev+bounces-79813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AC987B9CB
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 09:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1691C2235F
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 08:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2948C6CDA1;
	Thu, 14 Mar 2024 08:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cYHtDJrz"
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67F96BFB6;
	Thu, 14 Mar 2024 08:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710406514; cv=none; b=tzdK1wyYKayMK06DAd/W2QPiXczkv0P7HPC/rByLPBbnT7+QRW/uO7EaPE52WrJZyD4gikhYI1AdAEZQcJvT8A60HEUXV0ph1fJYpcZ/KlxCOgQKMMLpfq4wtwVRUkkkDuDawNCdA3i6Zwpj60uEEah1HX0YGU7ngo1TREIBMDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710406514; c=relaxed/simple;
	bh=n177dp2ajuDUj2qvSsEBqedkKm9thu1SvJDItbvqOkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JCQ+AZP3qEd9v4FNLMn8xVuqNR0OZrhmiZHzUMlOW1Vp7G4Y9qSsV+OktYGcK+QZG8WaT7mE5LLk4JDBcuAGT2JNkhQIsQWlVuW8inM7YlHofm7Mhc8CN1QVX8m5jM4rYdNNuyYH4uqJhZF1ZHA5z3DK/o16CAzYQiy4kEBFzEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cYHtDJrz; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710406510; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=PzVt1FCHXuF6yFno3W2t1cNpaHTrc2n2nJPJR8ipBz8=;
	b=cYHtDJrz3bdyO1dCIYSa+x1nYrmu/ma7DHOGfTXUZbHCSu5pZ/Qy+/bpj5IyjzWKNeE2W7uBghBQUEeoT9uj4Zj0ML3yfjh7Z6NPmUfOTfcRHFXd0GAs4H6H7HcO1SsqfAEA/R9TAI5lk1jBMm6lvNT5cF2ccuwXtUxT7voflGo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W2S0Im7_1710406508;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W2S0Im7_1710406508)
          by smtp.aliyun-inc.com;
          Thu, 14 Mar 2024 16:55:09 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next v4 7/8] netdev: add queue stats
Date: Thu, 14 Mar 2024 16:54:58 +0800
Message-Id: <20240314085459.115933-8-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240314085459.115933-1-xuanzhuo@linux.alibaba.com>
References: <20240314085459.115933-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 76259b0090f3
Content-Transfer-Encoding: 8bit

These stats are commonly. Support reporting those via netdev-genl queue
stats.

name: rx-hw-drops
name: rx-hw-drop-overruns
name: rx-csum-unnecessary
name: rx-csum-none
name: rx-csum-bad
name: rx-hw-gro-packets
name: rx-hw-gro-bytes
name: rx-hw-gro-wire-packets
name: rx-hw-gro-wire-bytes
name: rx-hw-drop-ratelimits
name: tx-hw-drops
name: tx-hw-drop-errors
name: tx-csum-none
name: tx-needs-csum
name: tx-hw-gso-packets
name: tx-hw-gso-bytes
name: tx-hw-gso-wire-packets
name: tx-hw-gso-wire-bytes
name: tx-hw-drop-ratelimits

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 Documentation/netlink/specs/netdev.yaml | 105 ++++++++++++++++++++++++
 include/net/netdev_queues.h             |  27 ++++++
 include/uapi/linux/netdev.h             |  20 +++++
 net/core/netdev-genl.c                  |  23 +++++-
 tools/include/uapi/linux/netdev.h       |  19 +++++
 5 files changed, 192 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 76352dbd2be4..41ba22cf1123 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -335,6 +335,111 @@ attribute-sets:
           Allocation failure may, or may not result in a packet drop, depending
           on driver implementation and whether system recovers quickly.
         type: uint
+      -
+        name: rx-hw-drops
+        doc: |
+          Number of packets that arrived at the device but never left it,
+          encompassing packets dropped for reasons such as insufficient buffer
+          space, processing errors, as well as those affected by explicitly
+          defined policies and packet filtering criteria.
+        type: uint
+      -
+        name: rx-hw-drop-overruns
+        doc: |
+          Number of packets that arrived at the device but never left it due to
+          no descriptors.
+        type: uint
+      -
+        name: rx-csum-unnecessary
+        doc: Number of packets that are marked as CHECKSUM_UNNECESSARY.
+        type: uint
+      -
+        name: rx-csum-none
+        doc: Number of packets that are not checksummed by device.
+        type: uint
+      -
+        name: rx-csum-bad
+        doc: |
+          Number of packets that are dropped by device due to invalid checksum.
+        type: uint
+      -
+        name: rx-hw-gro-packets
+        doc: |
+          Number of packets that area coalesced from smaller packets by the device,
+          that do not cover LRO packets.
+        type: uint
+      -
+        name: rx-hw-gro-bytes
+        doc: see `rx-hw-gro-packets`.
+        type: uint
+      -
+        name: rx-hw-gro-wire-packets
+        doc: |
+          Number of packets that area coalesced to bigger packets(no LRO packets)
+          by the device.
+        type: uint
+      -
+        name: rx-hw-gro-wire-bytes
+        doc: see `rx-hw-gro-wire-packets`.
+        type: uint
+      -
+        name: rx-hw-drop-ratelimits
+        doc: |
+          Number of the packets dropped by the device due to the received
+          packets bitrate exceeding the device speed limit.
+        type: uint
+      -
+        name: tx-hw-drops
+        doc: |
+          Number of packets that arrived at the device but never left it,
+          encompassing packets dropped for reasons such as processing errors, as
+          well as those affected by explicitly defined policies and packet
+          filtering criteria.
+        type: uint
+      -
+        name: tx-hw-drop-errors
+        doc: Number of packets dropped because they were invalid or malformed.
+        type: uint
+      -
+        name: tx-csum-none
+        doc: |
+          Number of packets that do not require the device to calculate the
+          checksum.
+        type: uint
+      -
+        name: tx-needs-csum
+        doc: |
+          Number of packets that require the device to calculate the
+          checksum.
+        type: uint
+      -
+        name: tx-hw-gso-packets
+        doc: |
+          Number of packets that necessitated segmentation into smaller packets
+          by the device.
+        type: uint
+      -
+        name: tx-hw-gso-bytes
+        doc: |
+          Successfully segmented into smaller packets by the device, see
+          `tx-hw-gso-packets`.
+        type: uint
+      -
+        name: tx-hw-gso-wire-packets
+        doc: |
+          Number of the small packets that segmented from bigger packets by the
+          device.
+        type: uint
+      -
+        name: tx-hw-gso-wire-bytes
+        doc: See `tx-hw-gso-wire-packets`.
+        type: uint
+      -
+        name: tx-hw-drop-ratelimits
+        doc: |
+          Number of the packets dropped by the device due to the transmit
+          packets bitrate exceeding the device speed limit.
+        type: uint
 
 operations:
   list:
diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index 1ec408585373..c7ac4539eafc 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -9,11 +9,38 @@ struct netdev_queue_stats_rx {
 	u64 bytes;
 	u64 packets;
 	u64 alloc_fail;
+
+	u64 hw_drops;
+	u64 hw_drop_overruns;
+
+	u64 csum_unnecessary;
+	u64 csum_none;
+	u64 csum_bad;
+
+	u64 hw_gro_packets;
+	u64 hw_gro_bytes;
+	u64 hw_gro_wire_packets;
+	u64 hw_gro_wire_bytes;
+
+	u64 hw_drop_ratelimits;
 };
 
 struct netdev_queue_stats_tx {
 	u64 bytes;
 	u64 packets;
+
+	u64 hw_drops;
+	u64 hw_drop_errors;
+
+	u64 csum_none;
+	u64 needs_csum;
+
+	u64 hw_gso_packets;
+	u64 hw_gso_bytes;
+	u64 hw_gso_wire_packets;
+	u64 hw_gso_wire_bytes;
+
+	u64 hw_drop_ratelimits;
 };
 
 /**
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index bb65ee840cda..702d69b09f14 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -147,6 +147,26 @@ enum {
 	NETDEV_A_QSTATS_TX_BYTES,
 	NETDEV_A_QSTATS_RX_ALLOC_FAIL,
 
+	NETDEV_A_QSTATS_RX_HW_DROPS,
+	NETDEV_A_QSTATS_RX_HW_DROP_OVERRUNS,
+	NETDEV_A_QSTATS_RX_CSUM_UNNECESSARY,
+	NETDEV_A_QSTATS_RX_CSUM_NONE,
+	NETDEV_A_QSTATS_RX_CSUM_BAD,
+	NETDEV_A_QSTATS_RX_HW_GRO_PACKETS,
+	NETDEV_A_QSTATS_RX_HW_GRO_BYTES,
+	NETDEV_A_QSTATS_RX_HW_GRO_WIRE_PACKETS,
+	NETDEV_A_QSTATS_RX_HW_GRO_WIRE_BYTES,
+	NETDEV_A_QSTATS_RX_HW_DROP_RATELIMITS,
+	NETDEV_A_QSTATS_TX_HW_DROPS,
+	NETDEV_A_QSTATS_TX_HW_DROP_ERRORS,
+	NETDEV_A_QSTATS_TX_CSUM_NONE,
+	NETDEV_A_QSTATS_TX_NEEDS_CSUM,
+	NETDEV_A_QSTATS_TX_HW_GSO_PACKETS,
+	NETDEV_A_QSTATS_TX_HW_GSO_BYTES,
+	NETDEV_A_QSTATS_TX_HW_GSO_WIRE_PACKETS,
+	NETDEV_A_QSTATS_TX_HW_GSO_WIRE_BYTES,
+	NETDEV_A_QSTATS_TX_HW_DROP_RATELIMITS,
+
 	__NETDEV_A_QSTATS_MAX,
 	NETDEV_A_QSTATS_MAX = (__NETDEV_A_QSTATS_MAX - 1)
 };
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 7004b3399c2b..a2bf9af2dcf6 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -489,7 +489,17 @@ netdev_nl_stats_write_rx(struct sk_buff *rsp, struct netdev_queue_stats_rx *rx)
 {
 	if (netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_PACKETS, rx->packets) ||
 	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_BYTES, rx->bytes) ||
-	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_ALLOC_FAIL, rx->alloc_fail))
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_ALLOC_FAIL, rx->alloc_fail) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_HW_DROPS, rx->hw_drops) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_HW_DROP_OVERRUNS, rx->hw_drop_overruns) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_CSUM_UNNECESSARY, rx->csum_unnecessary) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_CSUM_NONE, rx->csum_none) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_CSUM_BAD, rx->csum_bad) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_HW_GRO_PACKETS, rx->hw_gro_packets) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_HW_GRO_BYTES, rx->hw_gro_bytes) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_HW_GRO_WIRE_PACKETS, rx->hw_gro_wire_packets) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_HW_GRO_WIRE_BYTES, rx->hw_gro_wire_bytes) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_HW_DROP_RATELIMITS, rx->hw_drop_ratelimits))
 		return -EMSGSIZE;
 	return 0;
 }
@@ -498,7 +508,16 @@ static int
 netdev_nl_stats_write_tx(struct sk_buff *rsp, struct netdev_queue_stats_tx *tx)
 {
 	if (netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_PACKETS, tx->packets) ||
-	    netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_BYTES, tx->bytes))
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_BYTES, tx->bytes) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_HW_DROPS, tx->hw_drops) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_HW_DROP_ERRORS, tx->hw_drop_errors) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_CSUM_NONE, tx->csum_none) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_NEEDS_CSUM, tx->needs_csum) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_HW_GSO_PACKETS, tx->hw_gso_packets) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_HW_GSO_BYTES, tx->hw_gso_bytes) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_HW_GSO_WIRE_PACKETS, tx->hw_gso_wire_packets) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_HW_GSO_WIRE_BYTES, tx->hw_gso_wire_bytes) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_HW_DROP_RATELIMITS, tx->hw_drop_ratelimits))
 		return -EMSGSIZE;
 	return 0;
 }
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index bb65ee840cda..cf24f1d9adf8 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -146,6 +146,25 @@ enum {
 	NETDEV_A_QSTATS_TX_PACKETS,
 	NETDEV_A_QSTATS_TX_BYTES,
 	NETDEV_A_QSTATS_RX_ALLOC_FAIL,
+	NETDEV_A_QSTATS_RX_HW_DROPS,
+	NETDEV_A_QSTATS_RX_HW_DROP_OVERRUNS,
+	NETDEV_A_QSTATS_RX_CSUM_UNNECESSARY,
+	NETDEV_A_QSTATS_RX_CSUM_NONE,
+	NETDEV_A_QSTATS_RX_CSUM_BAD,
+	NETDEV_A_QSTATS_RX_HW_GRO_PACKETS,
+	NETDEV_A_QSTATS_RX_HW_GRO_BYTES,
+	NETDEV_A_QSTATS_RX_HW_GRO_WIRE_PACKETS,
+	NETDEV_A_QSTATS_RX_HW_GRO_WIRE_BYTES,
+	NETDEV_A_QSTATS_RX_HW_DROP_RATELIMITS,
+	NETDEV_A_QSTATS_TX_HW_DROPS,
+	NETDEV_A_QSTATS_TX_HW_DROP_ERRORS,
+	NETDEV_A_QSTATS_TX_CSUM_NONE,
+	NETDEV_A_QSTATS_TX_NEEDS_CSUM,
+	NETDEV_A_QSTATS_TX_HW_GSO_PACKETS,
+	NETDEV_A_QSTATS_TX_HW_GSO_BYTES,
+	NETDEV_A_QSTATS_TX_HW_GSO_WIRE_PACKETS,
+	NETDEV_A_QSTATS_TX_HW_GSO_WIRE_BYTES,
+	NETDEV_A_QSTATS_TX_HW_DROP_RATELIMITS,
 
 	__NETDEV_A_QSTATS_MAX,
 	NETDEV_A_QSTATS_MAX = (__NETDEV_A_QSTATS_MAX - 1)
-- 
2.32.0.3.g01195cf9f


