Return-Path: <netdev+bounces-296124-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BMFpIXNnJGoS6AEAu9opvQ
	(envelope-from <netdev+bounces-296124-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 20:31:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C7D64E070
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 20:31:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296124-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296124-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=chelsio.com (policy=reject);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4889E302883A
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 18:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EE03B47DD;
	Sat,  6 Jun 2026 18:21:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stargate.chelsio.com (unknown [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF0ACA4E
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 18:20:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780770062; cv=none; b=byOtsd+NFDxeEuceaTckOhgO87/EIMo//vFZ7oYgSUOPdmYmtN22WtfDTsS/8Ow7ewUvIP/uzPokGm8c/KlMnQljOmhEh4M+pWSgDL/fWdNIb0Wze1kWd+MlfqcXBg/85XfthDC22utEsDnaDP66h7bvSDueoguYFh+p4NEuJB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780770062; c=relaxed/simple;
	bh=OfoxDMKE6KeF13RqELfNGvUuUeUoeybJP5VikqdR4Go=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NJYbt7eWxey7m7AD6NYb6/1Ke9NJEY9PaRHgmdVxiklavQZo0rieIeo7xuH14AY8UrB0Rt7YM83ZBGzt1+9FOEDhEVXgB79ohmVCD3zKULdqDu70DC33eJzNN2tCblPiI43Xs6Ng2pKry477SQ+tbXWdwCEGXJABfI9GL6VAEHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Received: from mehrangarh-blr-asicdesigners-com.asicdesigners.com (mehrangarh.blr.asicdesigners.com [10.193.185.169])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 656IKSGE029679;
	Sat, 6 Jun 2026 11:20:48 -0700
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, bharat@chelsio.com
Subject: [PATCH net-next v1 04/10] cxgb4: Add versioned structures and scratch buffs
Date: Sat,  6 Jun 2026 23:52:14 -0400
Message-Id: <20260607035220.528439-5-bharat@chelsio.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260607035220.528439-1-bharat@chelsio.com>
References: <20260607035220.528439-1-bharat@chelsio.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: add header
X-Spamd-Result: default: False [7.54 / 15.00];
	DATE_IN_FUTURE(4.00)[9];
	DMARC_POLICY_REJECT(2.00)[chelsio.com : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:bharat@chelsio.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296124-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,body];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[bharat@chelsio.com,netdev@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[bharat@chelsio.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chelsio.com:mid,chelsio.com:from_mime,chelsio.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D5C7D64E070
X-Spam: Yes

Upgrade the cudbg framework to support the expanded address space and
multi-core tracking requirements of T7 adapters.

Refactor the debug layout by replacing flat representations with
versioned structures like cim_ibq_rev1 and sge_ctxt_rev1 embedded with
compatibility headers for user-space parsing tools. Widen memory
description bounds from u32 to u64 to accommodate T7's 64-bit physical
memory footprint, and register 16 new T7-specific debug entity IDs.
A new parameter-passing array is also added to route microprocessor
core IDs and mailbox logging context straight to the capture routines.

Finally, introduce get_scratch_buff and release_scratch_buff management
helpers. These functions carve out transient working space directly from
the tail of the pre-allocated output payload, eliminating the overhead
and memory fragmentation of repetitive kmalloc calls during diagnostic
dump captures.

Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
 .../net/ethernet/chelsio/cxgb4/cudbg_common.c |  30 ++++
 .../net/ethernet/chelsio/cxgb4/cudbg_entity.h | 147 +++++++++++++++---
 drivers/net/ethernet/chelsio/cxgb4/cudbg_if.h |  54 ++++++-
 .../ethernet/chelsio/cxgb4/cudbg_lib_common.h |   4 +
 4 files changed, 216 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cudbg_common.c b/drivers/net/ethernet/chelsio/cxgb4/cudbg_common.c
index 175e1a675de5..ccbf402a0a89 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cudbg_common.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cudbg_common.c
@@ -7,6 +7,36 @@
 #include "cudbg_if.h"
 #include "cudbg_lib_common.h"
 
+void release_scratch_buff(struct cudbg_buffer *pscratch_buff,
+			  struct cudbg_buffer *pdbg_buff)
+{
+	pdbg_buff->size += pscratch_buff->size;
+	memset(pscratch_buff->data, 0, pscratch_buff->size);
+	pscratch_buff->data = NULL;
+	pscratch_buff->offset = 0;
+	pscratch_buff->size = 0;
+}
+
+int get_scratch_buff(struct cudbg_buffer *pdbg_buff, u32 size,
+		     struct cudbg_buffer *pscratch_buff)
+{
+	u32 scratch_offset;
+	int rc = 0;
+
+	scratch_offset = pdbg_buff->size - size;
+	if (pdbg_buff->offset > (int)scratch_offset || pdbg_buff->size < size) {
+		rc = CUDBG_STATUS_NO_MEM;
+		goto err;
+	} else {
+		pscratch_buff->data = (char *)pdbg_buff->data + scratch_offset;
+		pscratch_buff->offset = 0;
+		pscratch_buff->size = size;
+		pdbg_buff->size -= size;
+	}
+err:
+	return rc;
+}
+
 int cudbg_get_buff(struct cudbg_init *pdbg_init,
 		   struct cudbg_buffer *pdbg_buff, u32 size,
 		   struct cudbg_buffer *pin_buff)
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cudbg_entity.h b/drivers/net/ethernet/chelsio/cxgb4/cudbg_entity.h
index d5218e74284c..bad27fedac63 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cudbg_entity.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cudbg_entity.h
@@ -21,13 +21,58 @@ struct cudbg_mbox_log {
 	u32 lo[MBOX_LEN / 8];
 };
 
-struct cudbg_cim_qcfg {
-	u8 chip;
-	u16 base[CIM_NUM_IBQ + CIM_NUM_OBQ_T5];
-	u16 size[CIM_NUM_IBQ + CIM_NUM_OBQ_T5];
-	u16 thres[CIM_NUM_IBQ];
-	u32 obq_wr[2 * CIM_NUM_OBQ_T5];
-	u32 stat[4 * (CIM_NUM_IBQ + CIM_NUM_OBQ_T5)];
+#define CUDBG_CIM_IBQ_REV 1
+
+struct cim_ibq_rev1 {
+	struct cudbg_ver_hdr ver_hdr;
+	u8 qid;
+	u8 coreid;
+	u32 data[]; /* Must be last */
+};
+
+#define CUDBG_CIM_OBQ_REV 1
+
+struct cim_obq_rev1 {
+	struct cudbg_ver_hdr ver_hdr;
+	u8 qid;
+	u8 coreid;
+	u32 data[]; /* Must be last */
+};
+
+#define CUDBG_CIM_QCFG_REV 1
+
+enum cudbg_entity_cim_qcfg_qtype {
+	CUDBG_ENTITY_CIM_QCFG_QTYPE_IBQ = 0,
+	CUDBG_ENTITY_CIM_QCFG_QTYPE_OBQ,
+};
+
+struct cim_qcfg_rev1_data {
+	u8 qtype;
+	u8 qid;
+	u16 base;
+	u16 size;
+	u16 thres;
+	u32 obq_wr[2];
+	u32 stat[4];
+};
+
+struct cim_qcfg_rev1 {
+	struct cudbg_ver_hdr ver_hdr;
+	u8 num_cim_ibq;
+	u8 num_cim_obq;
+	u8 coreid;
+	struct cim_qcfg_rev1_data data[]; /* Must be last */
+};
+
+#define CUDBG_CIM_LA_REV 1
+
+struct struct_cim_la_rev1 {
+	struct cudbg_ver_hdr ver_hdr;
+	u8 coreid;
+	u8 ncol;
+	u16 nrow;
+	u32 config;
+	u32 data[]; /* Must be last */
 };
 
 struct cudbg_rss_vf_conf {
@@ -50,6 +95,25 @@ struct cudbg_hw_sched {
 	u32 map;
 };
 
+#define CUDBG_TP_INDIR_REG_REV 1
+#define CUDBG_PM_INDIR_REG_REV 1
+#define CUDBG_MA_INDIR_REG_REV 1
+#define CUDBG_UP_CIM_INDIR_REG_REV 1
+#define CUDBG_HMA_INDIR_REG_REV 1
+
+struct cudbg_indir_reg_data {
+	u32 offset;
+	u32 data;
+};
+
+struct cudbg_indir_reg_entity {
+	struct cudbg_ver_hdr ver_hdr;
+	u32 indir_reg;
+	u32 indir_data;
+	u32 nentries;
+	struct cudbg_indir_reg_data data[];
+};
+
 #define SGE_QBASE_DATA_REG_NUM 4
 
 struct sge_qbase_reg_field {
@@ -91,20 +155,20 @@ static const char * const cudbg_region[] = {
 	"Tx payload:", "Rx payload:", "LE hash:", "iSCSI region:",
 	"TDDP region:", "TPT region:", "STAG region:", "RQ region:",
 	"RQUDP region:", "PBL region:", "TXPBL region:",
-	"DBVFIFO region:", "ULPRX state:", "ULPTX state:",
-	"On-chip queues:"
+	"RRQ region:", "DBVFIFO region:", "ULPRX state:",
+	"ULPTX state:", "On-chip queues:"
 };
 
 /* Memory region info relative to current memory (i.e. wrt 0). */
 struct cudbg_region_info {
 	bool exist; /* Does region exists in current memory? */
-	u32 start;  /* Start wrt 0 */
-	u32 end;    /* End wrt 0 */
+	u64 start;  /* Start wrt 0 */
+	u64 end;    /* End wrt 0 */
 };
 
 struct cudbg_mem_desc {
-	u32 base;
-	u32 limit;
+	u64 base;
+	u64 limit;
 	u32 idx;
 };
 
@@ -187,20 +251,42 @@ struct cudbg_tid_info_region_rev1 {
 	struct cudbg_ver_hdr ver_hdr;
 	struct cudbg_tid_info_region tid;
 	u32 tid_start;
-	u32 reserved[16];
+	u32 nhash;
+	u32 clip_base;
+	u32 nclip;
+	u32 route_base;
+	u32 nroute;
+	u32 reserved[11];
 };
 
 #define CUDBG_LOWMEM_MAX_CTXT_QIDS 256
 #define CUDBG_MAX_FL_QIDS 1024
 
-struct cudbg_ch_cntxt {
-	u32 cntxt_type;
-	u32 cntxt_id;
-	u32 data[SGE_CTXT_SIZE / 4];
+#define CUDBG_SGE_CTXT_REV 1
+
+struct struct_sge_ctxt_rev1_data {
+	u8 ctxt_type;
+	u8 size;
+	u32 ctxt_id;
+	u32 data[];
+};
+
+struct struct_sge_ctxt_rev1 {
+	struct cudbg_ver_hdr ver_hdr;
+	u32 nentries;
+	struct struct_sge_ctxt_rev1_data data[]; /* Must be last */
 };
 
 #define CUDBG_MAX_RPLC_SIZE 128
 
+struct cudbg_cntxt_field {
+	char *name;
+	u32 start_bit;
+	u32 end_bit;
+	u32 shift;
+	u32 islog2;
+};
+
 struct cudbg_mps_tcam {
 	u64 mask;
 	u32 rplc[8];
@@ -250,6 +336,8 @@ enum cudbg_le_entry_types {
 	LE_ET_TCAM_ROUTING = 5,
 	LE_ET_HASH_CON = 6,
 	LE_ET_INVALID_TID = 8,
+	/* Reserve for future regions */
+	LE_ET_TCAM_MAX = 16,
 };
 
 struct cudbg_tcam {
@@ -349,4 +437,27 @@ struct cudbg_qdesc_info {
 
 #define CUDBG_NUM_PCIE_CONFIG_REGS 0x61
 
+struct cudbg_letcam_region {
+	u8 type;
+	u32 start;
+	u32 nentries;
+
+	u8 reserved[64];
+};
+
+struct cudbg_letcam {
+	struct cudbg_ver_hdr ver_hdr;
+
+	u8 nregions;
+	u32 region_hdr_size;
+
+	u32 max_tid;
+	u32 tid_data_hdr_size;
+
+	u8 reserved[64];
+};
+
+int cudbg_view_sge_ctxt(u8 ctxt_type, u32 qid, u32 *ctxt_data,
+			struct cudbg_cntxt_field *field,
+			struct cudbg_buffer *cudbg_poutbuf);
 #endif /* __CUDBG_ENTITY_H__ */
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cudbg_if.h b/drivers/net/ethernet/chelsio/cxgb4/cudbg_if.h
index c84719e3ca08..dbb0611b6d26 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cudbg_if.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cudbg_if.h
@@ -17,6 +17,12 @@
 #define CUDBG_MAJOR_VERSION 1
 #define CUDBG_MINOR_VERSION 14
 
+#define CUDBG_MAX_PARAMS 16
+
+enum {
+	CUDBG_UP_COREID_PARAM = 13,
+};
+
 enum cudbg_dbg_entity_type {
 	CUDBG_REG_DUMP = 1,
 	CUDBG_DEV_LOG = 2,
@@ -71,11 +77,57 @@ enum cudbg_dbg_entity_type {
 	CUDBG_HMA = 68,
 	CUDBG_QDESC = 70,
 	CUDBG_FLASH = 71,
-	CUDBG_MAX_ENTITY = 72,
+	CUDBG_CIM_IBQ_TP2  = 73,
+	CUDBG_CIM_IBQ_TP3  = 74,
+	CUDBG_CIM_IBQ_IPC1 = 75,
+	CUDBG_CIM_IBQ_IPC2 = 76,
+	CUDBG_CIM_IBQ_IPC3 = 77,
+	CUDBG_CIM_IBQ_IPC4 = 78,
+	CUDBG_CIM_IBQ_IPC5 = 79,
+	CUDBG_CIM_IBQ_IPC6 = 80,
+	CUDBG_CIM_IBQ_IPC7 = 81,
+	CUDBG_CIM_OBQ_IPC1 = 82,
+	CUDBG_CIM_OBQ_IPC2 = 83,
+	CUDBG_CIM_OBQ_IPC3 = 84,
+	CUDBG_CIM_OBQ_IPC4 = 85,
+	CUDBG_CIM_OBQ_IPC5 = 86,
+	CUDBG_CIM_OBQ_IPC6 = 87,
+	CUDBG_CIM_OBQ_IPC7 = 88,
+	CUDBG_MAX_ENTITY,
+};
+
+struct cudbg_param {
+	u16 param_type;
+	u16 reserved;
+	union {
+		struct {
+			u32 memtype; /* which memory (EDC0, EDC1, MC) */
+			u32 start; /* start of log in firmware memory */
+			u32 size; /* size of log */
+		} devlog_param;
+		struct {
+			struct mbox_cmd_log *log;
+			u16 mbox_cmds;
+		} mboxlog_param;
+		struct {
+			const char *caller_string;
+			u8 os_type;
+		} sw_state_param;
+		struct {
+			u32 itr;
+		} yield_param;
+		u64 time;
+		u8 tcb_bit_param;
+		void *adap;
+		u8 coreid;
+	} u;
 };
 
 struct cudbg_init {
 	struct adapter *adap; /* Pointer to adapter structure */
+	u16                dbg_params_cnt;
+	u16                dbg_reserved;
+	struct cudbg_param dbg_params[CUDBG_MAX_PARAMS];
 	void *outbuf; /* Output buffer */
 	u32 outbuf_size;  /* Output buffer size */
 	u8 compress_type; /* Type of compression to use */
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib_common.h b/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib_common.h
index 9fac777b0b24..45551f464ac4 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib_common.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib_common.h
@@ -67,6 +67,10 @@ struct cudbg_error {
 #define CDUMP_MAX_COMP_BUF_SIZE ((64 * 1024) - 1)
 #define CUDBG_CHUNK_SIZE ((CDUMP_MAX_COMP_BUF_SIZE / 1024) * 1024)
 
+void release_scratch_buff(struct cudbg_buffer *pscratch_buff,
+			  struct cudbg_buffer *pdbg_buff);
+int get_scratch_buff(struct cudbg_buffer *pdbg_buff, u32 size,
+		     struct cudbg_buffer *pscratch_buff);
 int cudbg_get_buff(struct cudbg_init *pdbg_init,
 		   struct cudbg_buffer *pdbg_buff, u32 size,
 		   struct cudbg_buffer *pin_buff);
-- 
2.39.1


