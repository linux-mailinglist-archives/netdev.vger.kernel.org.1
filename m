Return-Path: <netdev+bounces-286127-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMJBGWP5/mng0gAAu9opvQ
	(envelope-from <netdev+bounces-286127-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 11:07:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4794FEE83
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 11:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90592301BCEC
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 09:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1990F392829;
	Sat,  9 May 2026 09:06:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5BB39281E;
	Sat,  9 May 2026 09:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778317612; cv=none; b=ifWv9qa1ONF7ubgoz0mOw8UcVrm6rc7V1lZRs5+O6wHFyNGi3oQ4sowSBfhm7SLopbXAdZGhvcsH7IkJHjJSMciAwqL1Zdpm3iwIWtjzRLAAmzFbJC1Z9P9VQwn9wAP+/aLQ9U+4sEdm/j8P9aE0UkluaOYzJU+xEwwJL0vLZ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778317612; c=relaxed/simple;
	bh=Fz4ADg+K4qmCWYFW7qc3UchBZSZ2z45B62tKJrsbPBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cdiYeFxLSSN5/Rk8fHNU1M1CUBzBmbiRyYLV2e643ZnQTNbaD5lahV3M1FFWm/avlH2/xhKJUC7sMNH/sxd2ppwrd8M7M5o6Cu7z4BZc3KMOcE8gT1tcCnqdOLaEtt30pE0iicI5DujEOm9gagXK1ci6cVwMKu7DYbd9BhjQ+cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 67752203A25;
	Sat,  9 May 2026 11:06:49 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 07FCE203A24;
	Sat,  9 May 2026 11:06:49 +0200 (CEST)
Received: from lsvm11u0000621.swis.ap-northeast-2.aws.nxp.com (lsvm11u0000621.swis.ap-northeast-2.aws.nxp.com [10.52.8.159])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 22BE818002DC;
	Sat,  9 May 2026 17:06:47 +0800 (+08)
From: Minghuan Lian <minghuan.lian@nxp.com>
To: netdev@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	andrew+netdev@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Minghuan Lian <minghuan.lian@nxp.com>
Subject: [PATCH net-next 4/4] net: dsa: hms: Add ethtool statistics support
Date: Sat,  9 May 2026 18:06:32 +0900
Message-ID: <20260509090632.2959553-5-minghuan.lian@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260509090632.2959553-1-minghuan.lian@nxp.com>
References: <20260509090632.2959553-1-minghuan.lian@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Rspamd-Queue-Id: AA4794FEE83
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286127-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,nxp.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.605];
	FROM_NEQ_ENVFROM(0.00)[minghuan.lian@nxp.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add ethtool statistics support for the HMS switch. This provides
per-port statistics including:
  - RX/TX byte and frame counters
  - Frame size distribution counters
  - Error and discard counters
  - Per-queue statistics for all 8 traffic classes

Statistics are retrieved from the RT1180 MCU via the SPI command
interface using HMS_CMD_PORT_ETHTOOL_STATS_GET.

Signed-off-by: Minghuan Lian <minghuan.lian@nxp.com>
---
 drivers/net/dsa/hms/Makefile      |   1 +
 drivers/net/dsa/hms/hms_ethtool.c | 346 ++++++++++++++++++++++++++++++
 drivers/net/dsa/hms/hms_main.c    |   4 +
 drivers/net/dsa/hms/hms_switch.h  |   6 +
 4 files changed, 357 insertions(+)
 create mode 100644 drivers/net/dsa/hms/hms_ethtool.c

diff --git a/drivers/net/dsa/hms/Makefile b/drivers/net/dsa/hms/Makefile
index acf6a8f2d953b..11bb215b270c6 100644
--- a/drivers/net/dsa/hms/Makefile
+++ b/drivers/net/dsa/hms/Makefile
@@ -5,4 +5,5 @@ obj-$(CONFIG_NET_DSA_HMS_SWITCH) += hms.o
 hms-objs := \
 	hms_spi.o \
 	hms_config.o \
+	hms_ethtool.o \
 	hms_main.o
diff --git a/drivers/net/dsa/hms/hms_ethtool.c b/drivers/net/dsa/hms/hms_ethtool.c
new file mode 100644
index 0000000000000..00c8406b12862
--- /dev/null
+++ b/drivers/net/dsa/hms/hms_ethtool.c
@@ -0,0 +1,346 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NXP HMS (Heterogeneous Multi-SoC) DSA Switch ethtool Statistics
+ *
+ * Copyright 2025-2026 NXP
+ */
+
+#include "hms_switch.h"
+
+enum hms_stat_index {
+	/* RX stats */
+	HMS_STAT_RX_BYTES,
+	HMS_STAT_RX_VALID_BYTES,
+	HMS_STAT_RX_PAUSE_FRAMES,
+	HMS_STAT_RX_VALID_FRAMES,
+	HMS_STAT_RX_VLAN_FRAMES,
+	HMS_STAT_RX_UC_FRAMES,
+	HMS_STAT_RX_MC_FRAMES,
+	HMS_STAT_RX_BC_FRAMES,
+	HMS_STAT_RX_FRAMES,
+	HMS_STAT_RX_MIN_FRAMES,
+	HMS_STAT_RX_64_FRAMES,
+	HMS_STAT_RX_65_127_FRAMES,
+	HMS_STAT_RX_128_255_FRAMES,
+	HMS_STAT_RX_256_511_FRAMES,
+	HMS_STAT_RX_512_1023_FRAMES,
+	HMS_STAT_RX_1024_1522_FRAMES,
+	HMS_STAT_RX_1523_MAX_FRAMES,
+	HMS_STAT_RX_CONTROL_FRAMES,
+
+	/* TX stats */
+	HMS_STAT_TX_BYTES,
+	HMS_STAT_TX_VALID_BYTES,
+	HMS_STAT_TX_PAUSE_FRAMES,
+	HMS_STAT_TX_VALID_FRAMES,
+	HMS_STAT_TX_VLAN_FRAMES,
+	HMS_STAT_TX_UC_FRAMES,
+	HMS_STAT_TX_MC_FRAMES,
+	HMS_STAT_TX_BC_FRAMES,
+	HMS_STAT_TX_FRAMES,
+	HMS_STAT_TX_MIN_FRAMES,
+	HMS_STAT_TX_64_FRAMES,
+	HMS_STAT_TX_65_127_FRAMES,
+	HMS_STAT_TX_128_255_FRAMES,
+	HMS_STAT_TX_256_511_FRAMES,
+	HMS_STAT_TX_512_1023_FRAMES,
+	HMS_STAT_TX_1024_1522_FRAMES,
+	HMS_STAT_TX_1523_MAX_FRAMES,
+	HMS_STAT_TX_CONTROL_FRAMES,
+
+	HMS_STAT_RX_VALID_REASSEMBLED_FRAMES,
+	HMS_STAT_RX_ADDITIONAL_MPACKETS,
+	HMS_STAT_RX_ERROR_FRAME_REASSEMBLY,
+	HMS_STAT_RX_ERROR_FRAME_SMD,
+	HMS_STAT_TX_ADDITIONAL_MPACKETS,
+	HMS_STAT_TX_HOLD_TRANSITIONS,
+
+	/* Error stats */
+	HMS_STAT_RX_ERROR,
+	HMS_STAT_RX_ERROR_UNDERSIZE,
+	HMS_STAT_RX_ERROR_OVERSIZE,
+	HMS_STAT_RX_ERROR_FCS,
+	HMS_STAT_RX_ERROR_FRAGMENT,
+	HMS_STAT_RX_ERROR_JABBER,
+	HMS_STAT_RX_ERROR_DISCARD,
+	HMS_STAT_RX_ERROR_NO_TRUNCATED,
+	HMS_STAT_TX_ERROR_FCS,
+	HMS_STAT_TX_ERROR_UNDERSIZE,
+
+	/* Discard stats */
+	HMS_STAT_RX_DISCARD_COUNT,
+	HMS_STAT_RX_DISCARD_REASON0,
+	HMS_STAT_RX_DISCARD_TABLE_ID,
+	HMS_STAT_RX_DISCARD_ENTRY_ID,
+	HMS_STAT_TX_DISCARD_COUNT,
+	HMS_STAT_TX_DISCARD_REASON0,
+	HMS_STAT_TX_DISCARD_TABLE_ID,
+	HMS_STAT_TX_DISCARD_ENTRY_ID,
+	HMS_STAT_BRIDGE_DISCARD_COUNT,
+	HMS_STAT_BRIDGE_DISCARD_REASON0,
+	HMS_STAT_BRIDGE_DISCARD_TABLE_ID,
+	HMS_STAT_BRIDGE_DISCARD_ENTRY_ID,
+
+	/* Q0 stats */
+	HMS_STAT_Q0_REJECTED_BYTES,
+	HMS_STAT_Q0_REJECTED_FRAMES,
+	HMS_STAT_Q0_DEQUEUE_BYTES,
+	HMS_STAT_Q0_DEQUEUE_FRAMES,
+	HMS_STAT_Q0_DROPPED_BYTES,
+	HMS_STAT_Q0_DROPPED_FRAMES,
+	HMS_STAT_Q0_FRAMES,
+
+	/* Q1 stats */
+	HMS_STAT_Q1_REJECTED_BYTES,
+	HMS_STAT_Q1_REJECTED_FRAMES,
+	HMS_STAT_Q1_DEQUEUE_BYTES,
+	HMS_STAT_Q1_DEQUEUE_FRAMES,
+	HMS_STAT_Q1_DROPPED_BYTES,
+	HMS_STAT_Q1_DROPPED_FRAMES,
+	HMS_STAT_Q1_FRAMES,
+
+	/* Q2 stats */
+	HMS_STAT_Q2_REJECTED_BYTES,
+	HMS_STAT_Q2_REJECTED_FRAMES,
+	HMS_STAT_Q2_DEQUEUE_BYTES,
+	HMS_STAT_Q2_DEQUEUE_FRAMES,
+	HMS_STAT_Q2_DROPPED_BYTES,
+	HMS_STAT_Q2_DROPPED_FRAMES,
+	HMS_STAT_Q2_FRAMES,
+
+	/* Q3 stats */
+	HMS_STAT_Q3_REJECTED_BYTES,
+	HMS_STAT_Q3_REJECTED_FRAMES,
+	HMS_STAT_Q3_DEQUEUE_BYTES,
+	HMS_STAT_Q3_DEQUEUE_FRAMES,
+	HMS_STAT_Q3_DROPPED_BYTES,
+	HMS_STAT_Q3_DROPPED_FRAMES,
+	HMS_STAT_Q3_FRAMES,
+
+	/* Q4 stats */
+	HMS_STAT_Q4_REJECTED_BYTES,
+	HMS_STAT_Q4_REJECTED_FRAMES,
+	HMS_STAT_Q4_DEQUEUE_BYTES,
+	HMS_STAT_Q4_DEQUEUE_FRAMES,
+	HMS_STAT_Q4_DROPPED_BYTES,
+	HMS_STAT_Q4_DROPPED_FRAMES,
+	HMS_STAT_Q4_FRAMES,
+
+	/* Q5 stats */
+	HMS_STAT_Q5_REJECTED_BYTES,
+	HMS_STAT_Q5_REJECTED_FRAMES,
+	HMS_STAT_Q5_DEQUEUE_BYTES,
+	HMS_STAT_Q5_DEQUEUE_FRAMES,
+	HMS_STAT_Q5_DROPPED_BYTES,
+	HMS_STAT_Q5_DROPPED_FRAMES,
+	HMS_STAT_Q5_FRAMES,
+
+	/* Q6 stats */
+	HMS_STAT_Q6_REJECTED_BYTES,
+	HMS_STAT_Q6_REJECTED_FRAMES,
+	HMS_STAT_Q6_DEQUEUE_BYTES,
+	HMS_STAT_Q6_DEQUEUE_FRAMES,
+	HMS_STAT_Q6_DROPPED_BYTES,
+	HMS_STAT_Q6_DROPPED_FRAMES,
+	HMS_STAT_Q6_FRAMES,
+
+	/* Q7 stats */
+	HMS_STAT_Q7_REJECTED_BYTES,
+	HMS_STAT_Q7_REJECTED_FRAMES,
+	HMS_STAT_Q7_DEQUEUE_BYTES,
+	HMS_STAT_Q7_DEQUEUE_FRAMES,
+	HMS_STAT_Q7_DROPPED_BYTES,
+	HMS_STAT_Q7_DROPPED_FRAMES,
+	HMS_STAT_Q7_FRAMES,
+	HMS_STAT_NUM,
+};
+
+static const char hms_stat_name[][ETH_GSTRING_LEN] = {
+	/* RX stats */
+	[HMS_STAT_RX_BYTES] = "in-bytes",
+	[HMS_STAT_RX_VALID_BYTES] = "in-valid-bytes",
+	[HMS_STAT_RX_PAUSE_FRAMES] = "in-pause-frames",
+	[HMS_STAT_RX_VALID_FRAMES] = "in-valid-frames",
+	[HMS_STAT_RX_VLAN_FRAMES] = "in-vlan-frames",
+	[HMS_STAT_RX_UC_FRAMES] = "in-uc-frames",
+	[HMS_STAT_RX_MC_FRAMES] = "in-mc-frames",
+	[HMS_STAT_RX_BC_FRAMES] = "in-bc-frames",
+	[HMS_STAT_RX_FRAMES] = "in-frames",
+	[HMS_STAT_RX_MIN_FRAMES] = "in-min-frames",
+	[HMS_STAT_RX_64_FRAMES] = "in-64-frames",
+	[HMS_STAT_RX_65_127_FRAMES] = "in-65-127-frames",
+	[HMS_STAT_RX_128_255_FRAMES] = "in-128-255-frames",
+	[HMS_STAT_RX_256_511_FRAMES] = "in-256-511-frames",
+	[HMS_STAT_RX_512_1023_FRAMES] = "in-512-1023-frames",
+	[HMS_STAT_RX_1024_1522_FRAMES] = "in-1024-1522-frames",
+	[HMS_STAT_RX_1523_MAX_FRAMES] = "in-1523-max-frames",
+	[HMS_STAT_RX_CONTROL_FRAMES] = "in-control-frames",
+
+	/* TX stats */
+	[HMS_STAT_TX_BYTES] = "out-bytes",
+	[HMS_STAT_TX_VALID_BYTES] = "out-valid-bytes",
+	[HMS_STAT_TX_PAUSE_FRAMES] = "out-pause-frames",
+	[HMS_STAT_TX_VALID_FRAMES] = "out-valid-frames",
+	[HMS_STAT_TX_VLAN_FRAMES] = "out-vlan-frames",
+	[HMS_STAT_TX_UC_FRAMES] = "out-uc-frames",
+	[HMS_STAT_TX_MC_FRAMES] = "out-mc-frames",
+	[HMS_STAT_TX_BC_FRAMES] = "out-bc-frames",
+	[HMS_STAT_TX_FRAMES] = "out-frames",
+	[HMS_STAT_TX_MIN_FRAMES] = "out-min-frames",
+	[HMS_STAT_TX_64_FRAMES] = "out-64-frames",
+	[HMS_STAT_TX_65_127_FRAMES] = "out-65-127-frames",
+	[HMS_STAT_TX_128_255_FRAMES] = "out-128-255-frames",
+	[HMS_STAT_TX_256_511_FRAMES] = "out-256-511-frames",
+	[HMS_STAT_TX_512_1023_FRAMES] = "out-512-1023-frames",
+	[HMS_STAT_TX_1024_1522_FRAMES] = "out-1024-1522-frames",
+	[HMS_STAT_TX_1523_MAX_FRAMES] = "out-1523-max-frames",
+	[HMS_STAT_TX_CONTROL_FRAMES] = "out-control-frames",
+
+	[HMS_STAT_RX_VALID_REASSEMBLED_FRAMES] = "in-valid-reassembled-frames",
+	[HMS_STAT_RX_ADDITIONAL_MPACKETS] = "in-additional-mPackets",
+	[HMS_STAT_RX_ERROR_FRAME_REASSEMBLY] = "in-error-frame-reassembly",
+	[HMS_STAT_RX_ERROR_FRAME_SMD] = "in-error-frame-smd",
+	[HMS_STAT_TX_ADDITIONAL_MPACKETS] = "out-additional-mPackets",
+	[HMS_STAT_TX_HOLD_TRANSITIONS] = "out-hold-transitions",
+
+	/* Error stats */
+	[HMS_STAT_RX_ERROR] = "in-error",
+	[HMS_STAT_RX_ERROR_UNDERSIZE] = "in-error-undersize",
+	[HMS_STAT_RX_ERROR_OVERSIZE] = "in-error-oversize",
+	[HMS_STAT_RX_ERROR_FCS] = "in-error-fcs",
+	[HMS_STAT_RX_ERROR_FRAGMENT] = "in-error-fragment",
+	[HMS_STAT_RX_ERROR_JABBER] = "in-error-jabber",
+	[HMS_STAT_RX_ERROR_DISCARD] = "in-error-discard",
+	[HMS_STAT_RX_ERROR_NO_TRUNCATED] = "in-error-dicard-no-truncated",
+	[HMS_STAT_TX_ERROR_FCS] = "out-error-fcs",
+	[HMS_STAT_TX_ERROR_UNDERSIZE] = "out-error-undersize",
+
+	/* Discard stats */
+	[HMS_STAT_RX_DISCARD_COUNT] = "in-discard-count",
+	[HMS_STAT_RX_DISCARD_REASON0] = "in-discard-reason0",
+	[HMS_STAT_RX_DISCARD_TABLE_ID] = "in-discard-table-id",
+	[HMS_STAT_RX_DISCARD_ENTRY_ID] = "in-discard-entry-id",
+	[HMS_STAT_TX_DISCARD_COUNT] = "out-discard-count",
+	[HMS_STAT_TX_DISCARD_REASON0] = "out-discard-reason0",
+	[HMS_STAT_TX_DISCARD_TABLE_ID] = "out-discard-table-id",
+	[HMS_STAT_TX_DISCARD_ENTRY_ID] = "out-discard-entry-id",
+	[HMS_STAT_BRIDGE_DISCARD_COUNT] = "bridge-discard-count",
+	[HMS_STAT_BRIDGE_DISCARD_REASON0] = "bridge-discard-reason0",
+	[HMS_STAT_BRIDGE_DISCARD_TABLE_ID] = "bridge-discard-table-id",
+	[HMS_STAT_BRIDGE_DISCARD_ENTRY_ID] = "bridge-discard-entry-id",
+
+	/* Q0 stats */
+	[HMS_STAT_Q0_REJECTED_BYTES] = "q0-rejected-bytes",
+	[HMS_STAT_Q0_REJECTED_FRAMES] = "q0-rejected-frames",
+	[HMS_STAT_Q0_DEQUEUE_BYTES] = "q0-dequeue-bytes",
+	[HMS_STAT_Q0_DEQUEUE_FRAMES] = "q0-dequeue-frames",
+	[HMS_STAT_Q0_DROPPED_BYTES] = "q0-dropped-bytes",
+	[HMS_STAT_Q0_DROPPED_FRAMES] = "q0-dropped-frames",
+	[HMS_STAT_Q0_FRAMES] = "q0-frames",
+
+	/* Q1 stats */
+	[HMS_STAT_Q1_REJECTED_BYTES] = "q1-rejected-bytes",
+	[HMS_STAT_Q1_REJECTED_FRAMES] = "q1-rejected-frames",
+	[HMS_STAT_Q1_DEQUEUE_BYTES] = "q1-dequeue-bytes",
+	[HMS_STAT_Q1_DEQUEUE_FRAMES] = "q1-dequeue-frames",
+	[HMS_STAT_Q1_DROPPED_BYTES] = "q1-dropped-bytes",
+	[HMS_STAT_Q1_DROPPED_FRAMES] = "q1-dropped-frames",
+	[HMS_STAT_Q1_FRAMES] = "q1-frames",
+
+	/* Q2 stats */
+	[HMS_STAT_Q2_REJECTED_BYTES] = "q2-rejected-bytes",
+	[HMS_STAT_Q2_REJECTED_FRAMES] = "q2-rejected-frames",
+	[HMS_STAT_Q2_DEQUEUE_BYTES] = "q2-dequeue-bytes",
+	[HMS_STAT_Q2_DEQUEUE_FRAMES] = "q2-dequeue-frames",
+	[HMS_STAT_Q2_DROPPED_BYTES] = "q2-dropped-bytes",
+	[HMS_STAT_Q2_DROPPED_FRAMES] = "q2-dropped-frames",
+	[HMS_STAT_Q2_FRAMES] = "q2-frames",
+
+	/* Q3 stats */
+	[HMS_STAT_Q3_REJECTED_BYTES] = "q3-rejected-bytes",
+	[HMS_STAT_Q3_REJECTED_FRAMES] = "q3-rejected-frames",
+	[HMS_STAT_Q3_DEQUEUE_BYTES] = "q3-dequeue-bytes",
+	[HMS_STAT_Q3_DEQUEUE_FRAMES] = "q3-dequeue-frames",
+	[HMS_STAT_Q3_DROPPED_BYTES] = "q3-dropped-bytes",
+	[HMS_STAT_Q3_DROPPED_FRAMES] = "q3-dropped-frames",
+	[HMS_STAT_Q3_FRAMES] = "q3-frames",
+
+	/* Q4 stats */
+	[HMS_STAT_Q4_REJECTED_BYTES] = "q4-rejected-bytes",
+	[HMS_STAT_Q4_REJECTED_FRAMES] = "q4-rejected-frames",
+	[HMS_STAT_Q4_DEQUEUE_BYTES] = "q4-dequeue-bytes",
+	[HMS_STAT_Q4_DEQUEUE_FRAMES] = "q4-dequeue-frames",
+	[HMS_STAT_Q4_DROPPED_BYTES] = "q4-dropped-bytes",
+	[HMS_STAT_Q4_DROPPED_FRAMES] = "q4-dropped-frames",
+	[HMS_STAT_Q4_FRAMES] = "q4-frames",
+
+	/* Q5 stats */
+	[HMS_STAT_Q5_REJECTED_BYTES] = "q5-rejected-bytes",
+	[HMS_STAT_Q5_REJECTED_FRAMES] = "q5-rejected-frames",
+	[HMS_STAT_Q5_DEQUEUE_BYTES] = "q5-dequeue-bytes",
+	[HMS_STAT_Q5_DEQUEUE_FRAMES] = "q5-dequeue-frames",
+	[HMS_STAT_Q5_DROPPED_BYTES] = "q5-dropped-bytes",
+	[HMS_STAT_Q5_DROPPED_FRAMES] = "q5-dropped-frames",
+	[HMS_STAT_Q5_FRAMES] = "q5-frames",
+
+	/* Q6 stats */
+	[HMS_STAT_Q6_REJECTED_BYTES] = "q6-rejected-bytes",
+	[HMS_STAT_Q6_REJECTED_FRAMES] = "q6-rejected-frames",
+	[HMS_STAT_Q6_DEQUEUE_BYTES] = "q6-dequeue-bytes",
+	[HMS_STAT_Q6_DEQUEUE_FRAMES] = "q6-dequeue-frames",
+	[HMS_STAT_Q6_DROPPED_BYTES] = "q6-dropped-bytes",
+	[HMS_STAT_Q6_DROPPED_FRAMES] = "q6-dropped-frames",
+	[HMS_STAT_Q6_FRAMES] = "q6-frames",
+
+	/* Q7 stats */
+	[HMS_STAT_Q7_REJECTED_BYTES] = "q7-rejected-bytes",
+	[HMS_STAT_Q7_REJECTED_FRAMES] = "q7-rejected-frames",
+	[HMS_STAT_Q7_DEQUEUE_BYTES] = "q7-dequeue-bytes",
+	[HMS_STAT_Q7_DEQUEUE_FRAMES] = "q7-dequeue-frames",
+	[HMS_STAT_Q7_DROPPED_BYTES] = "q7-dropped-bytes",
+	[HMS_STAT_Q7_DROPPED_FRAMES] = "q7-dropped-frames",
+	[HMS_STAT_Q7_FRAMES] = "q7-frames",
+};
+
+void hms_get_ethtool_stats(struct dsa_switch *ds, int port, u64 *data)
+{
+	struct hms_private *priv = ds->priv;
+	struct hms_cmd_port_ethtool_stats stats;
+	int rc;
+	enum hms_stat_index i;
+
+	rc = hms_xfer_get_cmd(priv, HMS_CMD_PORT_ETHTOOL_STATS_GET,
+			      port, &stats, sizeof(stats));
+
+	if (rc) {
+		memset(data, 0, sizeof(u64) * HMS_STAT_NUM);
+		dev_err(ds->dev, "Failed to get port %d stats\n", port);
+		return;
+	}
+
+	for (i = 0; i < HMS_STAT_NUM; i++)
+		data[i] = stats.values[i];
+}
+
+void hms_get_strings(struct dsa_switch *ds, int port,
+		     u32 stringset, u8 *data)
+{
+	enum hms_stat_index i;
+	char *p = (char *)data;
+
+	if (stringset != ETH_SS_STATS)
+		return;
+
+	for (i = 0; i < HMS_STAT_NUM; i++) {
+		strscpy(p, hms_stat_name[i], ETH_GSTRING_LEN);
+		p += ETH_GSTRING_LEN;
+	}
+}
+
+int hms_get_sset_count(struct dsa_switch *ds, int port, int sset)
+{
+	if (sset != ETH_SS_STATS)
+		return -EOPNOTSUPP;
+
+	return HMS_STAT_NUM;
+}
diff --git a/drivers/net/dsa/hms/hms_main.c b/drivers/net/dsa/hms/hms_main.c
index b7f7c3a7d3667..cfe0095fcdb32 100644
--- a/drivers/net/dsa/hms/hms_main.c
+++ b/drivers/net/dsa/hms/hms_main.c
@@ -761,6 +761,10 @@ static const struct dsa_switch_ops hms_switch_ops = {
 	.port_vlan_add		= hms_bridge_vlan_add,
 	.port_vlan_del		= hms_bridge_vlan_del,
 
+	.get_strings		= hms_get_strings,
+	.get_ethtool_stats	= hms_get_ethtool_stats,
+	.get_sset_count		= hms_get_sset_count,
+
 	.tag_8021q_vlan_add	= hms_8021q_vlan_add,
 	.tag_8021q_vlan_del	= hms_8021q_vlan_del,
 	.port_prechangeupper	= hms_prechangeupper,
diff --git a/drivers/net/dsa/hms/hms_switch.h b/drivers/net/dsa/hms/hms_switch.h
index 8f9e3035374b1..eee0b822f769d 100644
--- a/drivers/net/dsa/hms/hms_switch.h
+++ b/drivers/net/dsa/hms/hms_switch.h
@@ -64,4 +64,10 @@ int hms_xfer_get_cmd(struct hms_private *priv,
 		     enum hms_cmd cmd, u32 id,
 		     void *resp, size_t resp_len);
 
+/* From hms_ethtool.c */
+void hms_get_ethtool_stats(struct dsa_switch *ds, int port, u64 *data);
+void hms_get_strings(struct dsa_switch *ds, int port,
+		     u32 stringset, u8 *data);
+int hms_get_sset_count(struct dsa_switch *ds, int port, int sset);
+
 #endif /* _HMS_SWITCH_H */
-- 
2.43.0


