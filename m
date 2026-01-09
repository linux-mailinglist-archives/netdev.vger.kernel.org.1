Return-Path: <netdev+bounces-248454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA2ED089A5
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 11:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DC44309B899
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 10:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7307B33BBAF;
	Fri,  9 Jan 2026 10:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Mv5PWSAA"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832D233A6E0;
	Fri,  9 Jan 2026 10:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767954721; cv=none; b=pClDhMI4twpg4kOambgzN0AdYi/liPzbzbCRvavWRNsw119I5qx4RmrqFi2B3+AkIVdMpRffJgSEe/D7hIf61CogF97libMwPp7XPQPbvOHbFyHTVzvjUwfdia9YHuGqx6kbG8YOQY2k3A6JQAnH7fmjzVIHavhAQZRPj++HcmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767954721; c=relaxed/simple;
	bh=7LdXTT/4uMU1KEnQ2Nm+9GOgr+S0ppAn+sVry4w4/mY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EfB4QT5NTiSnOU8orRNP6eOY1pYliQmNNT+MyR4AE2qc838rlWTZbltL25rhQT7ymmE2IfxEQS8Ob/gEaWF+dNQGbyoymDAusysegqCiHQha6tMgV7ik1eDvvpnkMLM3Q47JjztVEB2P9RfPAFcYgvm6PRXAPFVV0KileJZOGps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Mv5PWSAA; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60934aZ0027531;
	Fri, 9 Jan 2026 02:31:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=e
	Na560f65DxhyZfQm4oATo3PUgV4in3z9qiFk2KCJNo=; b=Mv5PWSAAOOr+fzAsw
	cNZ9Tj3fD1W/aHdC59mnkpsMM0MnrPzQTMu/5PvmtxSh8ESKK02l4LCDBv88E61a
	boY7eViwsEWojOu8cYzw72Urr3ojsHHoWSiY9hgKydGKgYls7l3o50rQEnA9qMwd
	2vuq1kFy+2ItjsKiYhCgDvW4ZxQKMIEjXid5hS5DDIzoMFqs/M8Rnk775iRKcMeQ
	/QlKADRUUjTn9wHGkQjvCAtOzj5diTk92XWWDJfWNGVbm1BbUCgqOI+fDGdsIuwe
	GdWgF3DFowwEj5E1yewkC9M2JrSzuzBIKZLjdpZV4UMKwoDdZJ0cy58Ls2OpfBeP
	YC+BQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bjset0x36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Jan 2026 02:31:51 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 9 Jan 2026 02:31:51 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 9 Jan 2026 02:31:51 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 68A3F3F708A;
	Fri,  9 Jan 2026 02:31:48 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net-next v3 10/10] octeontx2: switch: trace support
Date: Fri, 9 Jan 2026 16:00:35 +0530
Message-ID: <20260109103035.2972893-11-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109103035.2972893-1-rkannoth@marvell.com>
References: <20260109103035.2972893-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=W581lBWk c=1 sm=1 tr=0 ts=6960d917 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=gFDZAJeugxnc_ztJiqIA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: Ox0XJNy9nPamQWsCAD5XqAKjMPA9er4l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA3NiBTYWx0ZWRfX8OVLlCo92mbJ
 FOi0Men1gHZMCxgOFXCzuzNB2ZSdtrZSAcJH81LY7u3/WgLI0f4Cyk0QptmVsqXKKUps0plqYsi
 tm8KeXAcw378fT1RRVtbb+DwBMvqiI1aj3JnjH9l6ejQcPvgve39mhEhFAV1Z2ECwO4xVS3zutc
 ck/GCgLmTYvyEg85kyiSq9Rm2V0mo8VPt9zRTCR4Yze7z7RnTkyQ8Am6LyXBDQFdSyBeJAgu+cf
 JQfQbDR2paduCytIZwn7E/DYbV5sC2A24Y7zczGQN6Hj7jYjmGTeju4iZkXDA8taSD0PFzsW+Si
 Rj7EEqbJOcAEOZfFbe1J9Pu3WOBc4YDN5ZdXsF1FPKZnij6NUeLnts4XQ+zghlofV9qajluF1RD
 tWIENPiUjlrxOgPfsF94y7wg/H/ax2sq66+vAUquc2uLPIXu8VwDXP28oZFw3g5qjtxd0kV1/R2
 4xzFnaKqOHUYNxAa2EA==
X-Proofpoint-ORIG-GUID: Ox0XJNy9nPamQWsCAD5XqAKjMPA9er4l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_03,2026-01-08_02,2025-10-01_01

Traces are added to flow parsing to ease debugging.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/nic/Makefile   |  2 +-
 .../marvell/octeontx2/nic/switch/sw_fl.c      | 18 +++-
 .../marvell/octeontx2/nic/switch/sw_trace.c   | 11 +++
 .../marvell/octeontx2/nic/switch/sw_trace.h   | 82 +++++++++++++++++++
 4 files changed, 109 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_trace.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_trace.h

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
index da87e952c187..5f722d0cfac2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
@@ -13,7 +13,7 @@ rvu_nicpf-y := otx2_pf.o otx2_common.o otx2_txrx.o otx2_ethtool.o \
 	       switch/sw_fdb.o switch/sw_fl.o
 
 ifdef CONFIG_OCTEONTX_SWITCH
-rvu_nicpf-y += switch/sw_nb.o switch/sw_fib.o
+rvu_nicpf-y += switch/sw_nb.o switch/sw_fib.o switch/sw_trace.o
 endif
 
 rvu_nicvf-y := otx2_vf.o
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c
index c9aa0043cc4c..3ddae5d08578 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c
@@ -18,6 +18,7 @@
 #include "../otx2_struct.h"
 #include "../cn10k.h"
 #include "sw_nb.h"
+#include "sw_trace.h"
 #include "sw_fl.h"
 
 #if !IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
@@ -140,6 +141,7 @@ static int sw_fl_parse_actions(struct otx2_nic *nic,
 
 		switch (act->id) {
 		case FLOW_ACTION_REDIRECT:
+			trace_sw_act_dump(__func__, __LINE__, act->id);
 			tuple->in_pf = nic->pcifunc;
 			out_nic = netdev_priv(act->dev);
 			tuple->xmit_pf = out_nic->pcifunc;
@@ -147,6 +149,7 @@ static int sw_fl_parse_actions(struct otx2_nic *nic,
 			break;
 
 		case FLOW_ACTION_CT:
+			trace_sw_act_dump(__func__, __LINE__, act->id);
 			err = nf_flow_table_offload_add_cb(act->ct.flow_table,
 							   sw_fl_setup_ft_block_ingress_cb,
 							   nic);
@@ -161,6 +164,7 @@ static int sw_fl_parse_actions(struct otx2_nic *nic,
 			break;
 
 		case FLOW_ACTION_MANGLE:
+			trace_sw_act_dump(__func__, __LINE__, act->id);
 			tuple->mangle[used].type = act->mangle.htype;
 			tuple->mangle[used].val = act->mangle.val;
 			tuple->mangle[used].mask = act->mangle.mask;
@@ -170,6 +174,7 @@ static int sw_fl_parse_actions(struct otx2_nic *nic,
 			break;
 
 		default:
+			trace_sw_act_dump(__func__, __LINE__, act->id);
 			break;
 		}
 	}
@@ -445,21 +450,28 @@ static int sw_fl_add(struct otx2_nic *nic, struct flow_cls_offload *f)
 		return 0;
 
 	rc  = sw_fl_parse_flow(nic, f, &tuple, &features);
-	if (rc)
+	if (rc) {
+		trace_sw_fl_dump(__func__, __LINE__, &tuple);
 		return -EFAULT;
+	}
 
 	if (!netif_is_ovs_port(nic->netdev)) {
 		rc = sw_fl_get_pcifunc(nic, tuple.ip4src, &tuple.in_pf,
 				       &tuple, true);
-		if (rc)
+		if (rc) {
+			trace_sw_fl_dump(__func__, __LINE__, &tuple);
 			return rc;
+		}
 
 		rc = sw_fl_get_pcifunc(nic, tuple.ip4dst, &tuple.xmit_pf,
 				       &tuple, false);
-		if (rc)
+		if (rc) {
+			trace_sw_fl_dump(__func__, __LINE__, &tuple);
 			return rc;
+		}
 	}
 
+	trace_sw_fl_dump(__func__, __LINE__, &tuple);
 	sw_fl_add_to_list(nic, &tuple, f->cookie, true);
 	return 0;
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_trace.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_trace.c
new file mode 100644
index 000000000000..260fd2bb3606
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_trace.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell RVU Admin Function driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+
+#define CREATE_TRACE_POINTS
+#include "sw_trace.h"
+EXPORT_TRACEPOINT_SYMBOL(sw_fl_dump);
+EXPORT_TRACEPOINT_SYMBOL(sw_act_dump);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_trace.h b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_trace.h
new file mode 100644
index 000000000000..e23deca0309a
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_trace.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell RVU Admin Function driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM rvu
+
+#if !defined(SW_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define SW_TRACE_H
+
+#include <linux/types.h>
+#include <linux/tracepoint.h>
+
+#include "mbox.h"
+
+TRACE_EVENT(sw_fl_dump,
+	    TP_PROTO(const char *fname, int line, struct fl_tuple *ftuple),
+	    TP_ARGS(fname, line, ftuple),
+	    TP_STRUCT__entry(__string(f, fname)
+			     __field(int, l)
+			     __array(u8, smac, ETH_ALEN)
+			     __array(u8, dmac, ETH_ALEN)
+			     __field(u16, eth_type)
+			     __field(u32, sip)
+			     __field(u32, dip)
+			     __field(u8, ip_proto)
+			     __field(u16, sport)
+			     __field(u16, dport)
+			     __field(u8, uni_di)
+			     __field(u16, in_pf)
+			     __field(u16, out_pf)
+	    ),
+	    TP_fast_assign(__assign_str(f);
+			   __entry->l = line;
+			   memcpy(__entry->smac, ftuple->smac, ETH_ALEN);
+			   memcpy(__entry->dmac, ftuple->dmac, ETH_ALEN);
+			   __entry->sip = (__force u32)(ftuple->ip4src);
+			   __entry->dip = (__force u32)(ftuple->ip4dst);
+			   __entry->eth_type = (__force u16)ftuple->eth_type;
+			   __entry->ip_proto = ftuple->proto;
+			   __entry->sport = (__force u16)(ftuple->sport);
+			   __entry->dport = (__force u16)(ftuple->dport);
+			   __entry->uni_di = ftuple->uni_di;
+			   __entry->in_pf = ftuple->in_pf;
+			   __entry->out_pf = ftuple->xmit_pf;
+	    ),
+	    TP_printk("[%s:%d] %pM %pI4:%u to %pM %pI4:%u eth_type=%#x proto=%u uni=%u in=%#x out=%#x",
+		      __get_str(f), __entry->l, __entry->smac, &__entry->sip, __entry->sport,
+		      __entry->dmac, &__entry->dip, __entry->dport,
+		      ntohs((__force __be16)__entry->eth_type), __entry->ip_proto, __entry->uni_di,
+		      __entry->in_pf, __entry->out_pf)
+);
+
+TRACE_EVENT(sw_act_dump,
+	    TP_PROTO(const char *fname, int line, u32 act),
+	    TP_ARGS(fname, line, act),
+	    TP_STRUCT__entry(__string(fname, fname)
+			     __field(int, line)
+			     __field(u32, act)
+	    ),
+
+	    TP_fast_assign(__assign_str(fname);
+			   __entry->line = line;
+			   __entry->act = act;
+	    ),
+
+	    TP_printk("[%s:%d] %u",
+		       __get_str(fname), __entry->line, __entry->act)
+);
+
+#endif
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH ../../drivers/net/ethernet/marvell/octeontx2/nic/switch/
+
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE sw_trace
+
+#include <trace/define_trace.h>
-- 
2.43.0


