Return-Path: <netdev+bounces-247742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BD7CFE083
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 14:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92DFA30DDB14
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 13:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC0B335553;
	Wed,  7 Jan 2026 13:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="AptQFLBT"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1CF335092;
	Wed,  7 Jan 2026 13:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767792270; cv=none; b=sOiJOrwRBYtljiEzoi80SEuFkm9VpLe9gePmXwfsdNtfWtOESgdiuS4G3epM3aT/qj690SQXK8X65bxdhIXcZwkmnpIhRyyueB1vmzPSfU2yZli/Ts2k6OamX2S3raJQ93b2hIt+MkoqNe61hpK6qDwuLKE+jJchR3cLn7po22s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767792270; c=relaxed/simple;
	bh=qviC/+xYHW+f3Bhrq3MBLgLXbYychxs8a+T2uBXQFhA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HbWJVw15i51b4E2lNunUXyNV8Px67nVcAr5ZANde/1TTOf5bjvTv1pgO89J0GcXp0JJx9g0aMQONeIxBZiBWmkaPphN3tsyYycNj/dG3iv41Ma8OXtrn8jTO+5K+fkb/pCeqWbg+kGaq9L+z/DW9baBwSnC74xhUVkVtYcg2si4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=AptQFLBT; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606NRjiX4099278;
	Wed, 7 Jan 2026 05:24:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=t
	wCP1llxCo6U+TX6NaiG5PE15Ej8Pg0umFs/iOIQF2M=; b=AptQFLBTMYEtzDqm2
	d6gKVcFvy3sxq2FzMD2IU7wluikts1ZgKXLLPoWyK21QHNIxhBSDOZdA1CZfUntQ
	v75MuonHNCAXZalLj7B2rR4Gb9ddIDb0hvlM4rsTQFatMumwg9uoIRfs1l/evm/L
	V6vUiX9DTu6iLGT1DIQX2J3fRJ0P9uHQd4Bnf34j1PRT/c+7jVBuaViVR8zm6oMz
	nz/GkAlTF19B03BEqkkpDaU3U9o0OTpxODXRUq4CNXetspT8F8SiAyq+7tEP6nQO
	O+pS8YquDxZKAPpfhGAI7j5OTUtmtNK47WpHeQtU+KKaXEYI/MEu53dE9H0cEq84
	gBQ2Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bhc34hc14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 05:24:20 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 7 Jan 2026 05:24:19 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 7 Jan 2026 05:24:19 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id D6BE23F704A;
	Wed,  7 Jan 2026 05:24:16 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andrew+netdev@lunn.ch>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH net-next v2 01/10] octeontx2-af: switch: Add AF to switch mbox and skeleton files
Date: Wed, 7 Jan 2026 18:53:59 +0530
Message-ID: <20260107132408.3904352-2-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107132408.3904352-1-rkannoth@marvell.com>
References: <20260107132408.3904352-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=PJICOPqC c=1 sm=1 tr=0 ts=695e5e84 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=77CTF0lh-Qqp0iihmhoA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: _P6nsB5-HyxuIY1f-K6OoHkB-PoK56lb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDEwMiBTYWx0ZWRfX5itetr/iez6f
 c2LtJEEGar49uPoe7fHQPLui3Q367JoAehEbmIFZVibxGYk2IkbwjB1ea/jAoEL9fpEMMz+LlxV
 bUGOTHlYUbwcNIons59aq7gWvg0Vdmy1v4UZzClKhDnSkYWcdQ6aQlu9/lWxPv54HkosirAX1uE
 r47E4k7Fe2VD5+Pa1LWkuh/yAnBqsXJjdvC8JwJ8fkVhjvzCRFUShS7qLm2trLW20hPxT1xCPYQ
 9/TOTfLH5mdUNCYe3IcnY3fqcY7Cmhdr4lfxp+ZJKvpz99J3O8Qp4RFsKk5kpFU4FVWkFJ12zq7
 /OGt6CJAElemIeB0Bqz5gExfqVpwGYBOAcCP0tOO0dXRCeQSrFJ1bovYoWxgdOmcRPgEv4OS8Ft
 Q7gkJaAXG7fT/BUdMKhb/wnK+m/TUTLwkB6OqAlPx3z4C8xN00ebItq/1TvB3TcRlVfYIsI+sD7
 ESKzVZ2WMmuZ0RjScPQ==
X-Proofpoint-ORIG-GUID: _P6nsB5-HyxuIY1f-K6OoHkB-PoK56lb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_01,2026-01-06_01,2025-10-01_01

The Marvell switch hardware runs on a Linux OS. This OS receives
various messages, which are parsed to create flow rules that can be
installed on HW. The switch is capable of accelerating both L2 and
L3 flows.

This commit adds various mailbox messages used by the Linux OS
(on arm64) to send events to the switch hardware.

fdb messages:     Linux bridge FDB messages
fib messages:     Linux routing table messages
status messages:  Packet status updates sent to Host
                  Linux to keep flows active
                  for connection-tracked flows.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/Makefile    |  2 +
 .../net/ethernet/marvell/octeontx2/af/mbox.h  | 95 +++++++++++++++++++
 .../marvell/octeontx2/af/switch/rvu_sw_fl.c   | 21 ++++
 .../marvell/octeontx2/af/switch/rvu_sw_fl.h   | 11 +++
 .../marvell/octeontx2/af/switch/rvu_sw_l2.c   | 14 +++
 .../marvell/octeontx2/af/switch/rvu_sw_l2.h   | 11 +++
 .../marvell/octeontx2/af/switch/rvu_sw_l3.c   | 14 +++
 .../marvell/octeontx2/af/switch/rvu_sw_l3.h   | 11 +++
 8 files changed, 179 insertions(+)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.h

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/Makefile b/drivers/net/ethernet/marvell/octeontx2/af/Makefile
index 244de500963e..e28b1fc6dbc6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/Makefile
+++ b/drivers/net/ethernet/marvell/octeontx2/af/Makefile
@@ -4,6 +4,7 @@
 #
 
 ccflags-y += -I$(src)
+ccflags-y += -I$(src) -I$(src)/switch/
 obj-$(CONFIG_OCTEONTX2_MBOX) += rvu_mbox.o
 obj-$(CONFIG_OCTEONTX2_AF) += rvu_af.o
 
@@ -12,5 +13,6 @@ rvu_af-y := cgx.o rvu.o rvu_cgx.o rvu_npa.o rvu_nix.o \
 		  rvu_reg.o rvu_npc.o rvu_debugfs.o ptp.o rvu_npc_fs.o \
 		  rvu_cpt.o rvu_devlink.o rpm.o rvu_cn10k.o rvu_switch.o \
 		  rvu_sdp.o rvu_npc_hash.o mcs.o mcs_rvu_if.o mcs_cnf10kb.o \
+		  switch/rvu_sw_l2.o switch/rvu_sw_l3.o switch/rvu_sw_fl.o\
 		  rvu_rep.o cn20k/mbox_init.o cn20k/nix.o cn20k/debugfs.o \
 		  cn20k/npa.o
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index a3e273126e4e..a439fe17580c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -156,6 +156,14 @@ M(PTP_GET_CAP,		0x00c, ptp_get_cap, msg_req, ptp_get_cap_rsp)	\
 M(GET_REP_CNT,		0x00d, get_rep_cnt, msg_req, get_rep_cnt_rsp)	\
 M(ESW_CFG,		0x00e, esw_cfg, esw_cfg_req, msg_rsp)	\
 M(REP_EVENT_NOTIFY,     0x00f, rep_event_notify, rep_event, msg_rsp) \
+M(FDB_NOTIFY,		0x010,  fdb_notify,				\
+				fdb_notify_req, msg_rsp)		\
+M(FIB_NOTIFY,		0x011,  fib_notify,				\
+				fib_notify_req, msg_rsp)		\
+M(FL_NOTIFY,		0x012,  fl_notify,				\
+				fl_notify_req, msg_rsp)		\
+M(FL_GET_STATS,		0x013,  fl_get_stats,				\
+				fl_get_stats_req, fl_get_stats_rsp)	\
 /* CGX mbox IDs (range 0x200 - 0x3FF) */				\
 M(CGX_START_RXTX,	0x200, cgx_start_rxtx, msg_req, msg_rsp)	\
 M(CGX_STOP_RXTX,	0x201, cgx_stop_rxtx, msg_req, msg_rsp)		\
@@ -1694,6 +1702,93 @@ struct rep_event {
 	struct rep_evt_data evt_data;
 };
 
+#define FDB_ADD  BIT_ULL(0)
+#define FDB_DEL	 BIT_ULL(1)
+#define FIB_CMD	 BIT_ULL(2)
+#define FL_ADD	 BIT_ULL(3)
+#define FL_DEL	 BIT_ULL(4)
+#define DP_ADD	 BIT_ULL(5)
+
+struct fdb_notify_req {
+	struct  mbox_msghdr hdr;
+	u64 flags;
+	u8  mac[ETH_ALEN];
+};
+
+struct fib_entry {
+	u64 cmd;
+	u64 gw_valid : 1;
+	u64 mac_valid : 1;
+	u64 vlan_valid: 1;
+	u64 host    : 1;
+	u64 bridge  : 1;
+	u16 vlan_tag;
+	u32 dst;
+	u32 dst_len;
+	u32 gw;
+	u16 port_id;
+	u8 nud_state;
+	u8 mac[ETH_ALEN];
+};
+
+struct fib_notify_req {
+	struct  mbox_msghdr hdr;
+	u16 cnt;
+	struct fib_entry entry[16];
+};
+
+struct fl_tuple {
+	__be32 ip4src;
+	__be32 m_ip4src;
+	__be32 ip4dst;
+	__be32 m_ip4dst;
+	__be16 sport;
+	__be16 m_sport;
+	__be16 dport;
+	__be16 m_dport;
+	__be16 eth_type;
+	__be16 m_eth_type;
+	u8 proto;
+	u8 smac[6];
+	u8 m_smac[6];
+	u8 dmac[6];
+	u8 m_dmac[6];
+	u64 is_xdev_br : 1;
+	u64 is_indev_br : 1;
+	u64 uni_di  : 1;
+	u16 in_pf;
+	u16 xmit_pf;
+	u64 features;
+	struct {				/* FLOW_ACTION_MANGLE */
+		u8		offset;
+		u8		type;
+		u32		mask;
+		u32		val;
+#define MANGLE_ARR_SZ 9
+	} mangle[MANGLE_ARR_SZ]; /* 2 for ETH, 1 for VLAN, 4 for IPv6, 2 for L4. */
+#define MANGLE_LAYER_CNT 4
+	u8 mangle_map[MANGLE_LAYER_CNT]; /* 1 for ETH,  1 for VLAN, 1 for L3, 1 for L4 */
+	u8 mangle_cnt;
+};
+
+struct fl_notify_req {
+	struct  mbox_msghdr hdr;
+	unsigned long cookie;
+	u64 flags;
+	u64 features;
+	struct fl_tuple tuple;
+};
+
+struct fl_get_stats_req {
+	struct  mbox_msghdr hdr;
+	unsigned long cookie;
+};
+
+struct fl_get_stats_rsp {
+	struct  mbox_msghdr hdr;
+	u64 pkts_diff;
+};
+
 struct flow_msg {
 	unsigned char dmac[6];
 	unsigned char smac[6];
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c
new file mode 100644
index 000000000000..1f8b82a84a5d
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell RVU Admin Function driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#include "rvu.h"
+
+int rvu_mbox_handler_fl_get_stats(struct rvu *rvu,
+				  struct fl_get_stats_req *req,
+				  struct fl_get_stats_rsp *rsp)
+{
+	return 0;
+}
+
+int rvu_mbox_handler_fl_notify(struct rvu *rvu,
+			       struct fl_notify_req *req,
+			       struct msg_rsp *rsp)
+{
+	return 0;
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.h b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.h
new file mode 100644
index 000000000000..cf3e5b884f77
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell RVU Admin Function driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+
+#ifndef RVU_SW_FL_H
+#define RVU_SW_FL_H
+
+#endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.c
new file mode 100644
index 000000000000..5f805bfa81ed
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell RVU Admin Function driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#include "rvu.h"
+
+int rvu_mbox_handler_fdb_notify(struct rvu *rvu,
+				struct fdb_notify_req *req,
+				struct msg_rsp *rsp)
+{
+	return 0;
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.h b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.h
new file mode 100644
index 000000000000..ff28612150c9
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell RVU Admin Function driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+
+#ifndef RVU_SW_L2_H
+#define RVU_SW_L2_H
+
+#endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c
new file mode 100644
index 000000000000..2b798d5f0644
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell RVU Admin Function driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+#include "rvu.h"
+
+int rvu_mbox_handler_fib_notify(struct rvu *rvu,
+				struct fib_notify_req *req,
+				struct msg_rsp *rsp)
+{
+	return 0;
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.h b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.h
new file mode 100644
index 000000000000..ac8c4f9ba5ac
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell RVU Admin Function driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+
+#ifndef RVU_SW_L3_H
+#define RVU_SW_L3_H
+
+#endif
-- 
2.43.0


