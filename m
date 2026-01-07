Return-Path: <netdev+bounces-247751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 357BACFE124
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 14:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23D6E30086F9
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 13:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C52B33AD92;
	Wed,  7 Jan 2026 13:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Ktfs4Rq9"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586AC33A9E0;
	Wed,  7 Jan 2026 13:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767792298; cv=none; b=hslTyTF/BCY5f1dnmc5YXPtUSPDXQ1gbmw0DYwfpia7PAvl5qipkKwtrSp40nj80927e43oYzPjT4wOKpoVdNt0QcvN+YnRYDQh5DJdu/G9oA32sZtlpCP4loRwZ3DdOrNmq79LFYDlv4Pwysta7/qhwBamIkw4w+SZskCRUEMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767792298; c=relaxed/simple;
	bh=8jRebJfO1bv1tgyS50GUJHKyQY7q5WGqF/vGWMvpF8k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B4wDrfDsbs5IQWUNlPjJ0LZLI2tDRMo99S519YVfD7yTLduFs9HhknPWGS0Q+d+8Kf5uBmIL9ibHBfvU7SJs0B5K7n6lUiIMlqdnfwPtpvUMXma+4fvFwnoJ8vNBNotKno45V6uyxaCy/WaFRHwGYoOsA9I79gmClZm6BCyDGsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Ktfs4Rq9; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606NqTQu3768646;
	Wed, 7 Jan 2026 05:24:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=j
	m+Sj42M7/oRMy3MtiXwJyPjTGSroi/W2EgqeJwQRIs=; b=Ktfs4Rq9d2DXtKeg8
	77rS/bBwCis9NAHg3f+IAGNekAlMomDROMKzH7wA8aEBz+XFcPF5XR8pI4Mju7Az
	+/kY9A2TUrgpbtHn76aUU/PEtTPRjTRv6FypsIn+MeZsKLB6tFjCDYwlKXPU6yi0
	mMIjoyb0p6tzh6TFpc1vcKfgJJWoBgxxKU024p7KWaNkPhNrFfwG3YbmkeQn3B4V
	xl3sLLWmUV10CPLyauryDAB2WDFyAM1oZzOoJlAdJQnTY7H6rmHVYU4AzJfQHeih
	f6uXi9L1bc16FSvrVO1IQqhLivFcbUJhMI5LFJwLLM9qDmdXfyj86JAov5wLIt0v
	3pySg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bhces9cja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 05:24:48 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 7 Jan 2026 05:25:03 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 7 Jan 2026 05:25:03 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 72D393F704A;
	Wed,  7 Jan 2026 05:24:45 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andrew+netdev@lunn.ch>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH net-next v2 10/10] octeontx2: switch: trace support
Date: Wed, 7 Jan 2026 18:54:08 +0530
Message-ID: <20260107132408.3904352-11-rkannoth@marvell.com>
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
X-Authority-Analysis: v=2.4 cv=FokIPmrq c=1 sm=1 tr=0 ts=695e5ea1 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=gFDZAJeugxnc_ztJiqIA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: Eti1XaBQfdryFjW3ZvYq-YxYQvaSGGZh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDEwMiBTYWx0ZWRfX84DTdNEdDqwU
 UFTcwlKelimkrYNzxvFrsqCqmbTEgvHx2d2AJ2fB5ZWuI09Ue81NculQy6iwaLKDV7H2m8L2VG7
 9NDUpKKCc64PCsesljcAM0etDlSaDQQvlhBdZPkGeHzK+vp5Bxo37MOn6bFSYAnn5sKpPeFaUNH
 6fpas9VQh1yZG8c9ueICiWXvTPowp/v28+eoJj7oWqeCz9eLSemRObLgTXo0AZ2MCSAcqSjvJFw
 sEPJdUxNzFkJCzoeMoEJKYuW8mfMunZ4kyGU0kqcGi3EJigecTdIztDKMVIvdiRNIKW1bvfwxpq
 tKD2w8ABL0urTNeYQwfhbjiF7LoEBkPUMLnP2L2Ni5i1JuBFYqog0uaR9RbTf0Yxk4llnBTK27l
 YypEwSMQaTmpMEJHBrA1vPKIPzGiRWiBi8UO5ip1C9FjPo3erXLnWWRERiDZqkU/BO/+PNHdoQU
 TBkMjuNspXOgFZHowdw==
X-Proofpoint-ORIG-GUID: Eti1XaBQfdryFjW3ZvYq-YxYQvaSGGZh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_01,2026-01-06_01,2025-10-01_01

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
index fbb56f9bede9..a28b1d386a5f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c
@@ -18,6 +18,7 @@
 #include "../otx2_struct.h"
 #include "../cn10k.h"
 #include "sw_nb.h"
+#include "sw_trace.h"
 #include "sw_fl.h"
 
 #if !IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
@@ -137,6 +138,7 @@ static int sw_fl_parse_actions(struct otx2_nic *nic,
 
 		switch (act->id) {
 		case FLOW_ACTION_REDIRECT:
+			trace_sw_act_dump(__func__, __LINE__, act->id);
 			tuple->in_pf = nic->pcifunc;
 			out_nic = netdev_priv(act->dev);
 			tuple->xmit_pf = out_nic->pcifunc;
@@ -144,6 +146,7 @@ static int sw_fl_parse_actions(struct otx2_nic *nic,
 			break;
 
 		case FLOW_ACTION_CT:
+			trace_sw_act_dump(__func__, __LINE__, act->id);
 			err = nf_flow_table_offload_add_cb(act->ct.flow_table,
 							   sw_fl_setup_ft_block_ingress_cb,
 							   nic);
@@ -157,6 +160,7 @@ static int sw_fl_parse_actions(struct otx2_nic *nic,
 			break;
 
 		case FLOW_ACTION_MANGLE:
+			trace_sw_act_dump(__func__, __LINE__, act->id);
 			tuple->mangle[used].type = act->mangle.htype;
 			tuple->mangle[used].val = act->mangle.val;
 			tuple->mangle[used].mask = act->mangle.mask;
@@ -166,6 +170,7 @@ static int sw_fl_parse_actions(struct otx2_nic *nic,
 			break;
 
 		default:
+			trace_sw_act_dump(__func__, __LINE__, act->id);
 			break;
 		}
 	}
@@ -427,19 +432,26 @@ static int sw_fl_add(struct otx2_nic *nic, struct flow_cls_offload *f)
 		return 0;
 
 	rc  = sw_fl_parse_flow(nic, f, &tuple, &features);
-	if (rc)
+	if (rc) {
+		trace_sw_fl_dump(__func__, __LINE__, &tuple);
 		return -EFAULT;
+	}
 
 	if (!netif_is_ovs_port(nic->netdev)) {
 		rc = sw_fl_get_pcifunc(tuple.ip4src, &tuple.in_pf, &tuple, true);
-		if (rc)
+		if (rc) {
+			trace_sw_fl_dump(__func__, __LINE__, &tuple);
 			return rc;
+		}
 
 		rc = sw_fl_get_pcifunc(tuple.ip4dst, &tuple.xmit_pf, &tuple, false);
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
index 000000000000..4353c440a4c6
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
+			   __entry->sip = ftuple->ip4src;
+			   __entry->dip = ftuple->ip4dst;
+			   __entry->eth_type = ftuple->eth_type;
+			   __entry->ip_proto = ftuple->proto;
+			   __entry->sport = ftuple->sport;
+			   __entry->dport = ftuple->dport;
+			   __entry->uni_di = ftuple->uni_di;
+			   __entry->in_pf = ftuple->in_pf;
+			   __entry->out_pf = ftuple->xmit_pf;
+	    ),
+	    TP_printk("[%s:%d] %pM %pI4:%u to %pM %pI4:%u eth_type=%#x proto=%u uni=%u in=%#x out=%#x",
+		      __get_str(f), __entry->l, __entry->smac, &__entry->sip, __entry->sport,
+		      __entry->dmac, &__entry->dip, __entry->dport,
+		      ntohs(__entry->eth_type), __entry->ip_proto, __entry->uni_di,
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


