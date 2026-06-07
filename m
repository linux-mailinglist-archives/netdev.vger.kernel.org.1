Return-Path: <netdev+bounces-296132-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ugHLHFZpJGpd6AEAu9opvQ
	(envelope-from <netdev+bounces-296132-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 20:39:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA5264E09B
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 20:39:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296132-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296132-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=chelsio.com (policy=reject);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95CD730134B9
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 18:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E782E2F5328;
	Sat,  6 Jun 2026 18:39:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stargate.chelsio.com (unknown [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B6C2FF672
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 18:39:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780771145; cv=none; b=uNuKCZGbrVCo4Ojr82oj/a/7BL/DtEaOiKJ9mKfMwW0dpdmBQ6L/hHKNcoUgMn0+JE2XXCXe8rzB3S0wVL5YmU/XGIbhGQy+VfOi9GG4jG7BH+1z+ZFJ36ZtovX92oNuk+ymI21ZZtoWCwt49f7g/8qvUkigu+UNMgOHUVuXIFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780771145; c=relaxed/simple;
	bh=Y+Dr6d20/eg+cDgLlhRiTrysfzyB/I1mF7sOkqIF2XE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FL0SiYCwHsSusMiW9tSScMRate/GIciD4is4i98HIK0d8B3wONuZIZTP6D1W2ag+F5368ZscMspsYSk1JEofIsPvJIqxqgD1ZIZ1F7zaZRQLr6b7JdXW4nUl0xffDICjx1COdp/gdP6xtD4hHpP6Gg1zVw9OfboLj/ZUsFhrG9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Received: from mehrangarh-blr-asicdesigners-com.asicdesigners.com (mehrangarh.blr.asicdesigners.com [10.193.185.169])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 656IKSGC029679;
	Sat, 6 Jun 2026 11:20:40 -0700
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, bharat@chelsio.com
Subject: [PATCH net-next v1 02/10] cxgb4: Add T7 chip type identification and HW constants
Date: Sat,  6 Jun 2026 23:52:12 -0400
Message-Id: <20260607035220.528439-3-bharat@chelsio.com>
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
	TAGGED_FROM(0.00)[bounces-296132-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,meta];
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
X-Rspamd-Queue-Id: BBA5264E09B
X-Spam: Yes

Introduce the core chip identification infrastructure, hardware limits,
and register layout definitions required to support Chelsio T7 adapters.

Add the CHELSIO_T7 version constant, T7_A0/T7_B0 silicon revision
codes, revision range sentinels, and the is_t7 inline validation helper
to t4_chip_type.h to establish the foundational detection logic.

Extend the hardware specifications within t4_hw.h for the T7 design.
This includes increasing the maximum microprocessor cores to 8, expanding
internal buffer queue allocations to 16, sizing SGE context tracking
structures to 28 bytes, and updating CIM logic analyzer constraints.
Replace legacy flat FLASH constants with a flexible enum t4_flash_loc
table mechanism to allow per-adapter dynamic flash maps, while keeping
existing firmware load path constants for backward compatibility.

Refactor value parameters and field mappings in t4_values.h and t4_tcb.h
to match the T7 architecture. This standardizes mailbox ownership suffix
conventions, implements the narrower 4-bit T7 PCIe memory offset shift,
and inserts explicit tuple boundary markers and width definitions for
expanded hardware filter configurations. Finally, integrate new TCP
Control Block field macros to support advanced T7 TOE states.

Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
 .../net/ethernet/chelsio/cxgb4/t4_chip_type.h |  10 ++
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.h    | 136 ++++++++++++------
 drivers/net/ethernet/chelsio/cxgb4/t4_tcb.h   |  16 +++
 .../net/ethernet/chelsio/cxgb4/t4_values.h    |  15 +-
 4 files changed, 129 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_chip_type.h b/drivers/net/ethernet/chelsio/cxgb4/t4_chip_type.h
index 721c77577ec5..444675436b01 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_chip_type.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_chip_type.h
@@ -39,6 +39,7 @@
 #define CHELSIO_T4		0x4
 #define CHELSIO_T5		0x5
 #define CHELSIO_T6		0x6
+#define CHELSIO_T7		0x7
 
 /* We code the Chelsio T4 Family "Chip Code" as a tuple:
  *
@@ -67,6 +68,11 @@ enum chip_type {
 	T6_A0 = CHELSIO_CHIP_CODE(CHELSIO_T6, 0),
 	T6_FIRST_REV	= T6_A0,
 	T6_LAST_REV	= T6_A0,
+
+	T7_A0 = CHELSIO_CHIP_CODE(CHELSIO_T7, 0),
+	T7_B0 = CHELSIO_CHIP_CODE(CHELSIO_T7, 1),
+	T7_FIRST_REV    = T7_A0,
+	T7_LAST_REV     = T7_B0,
 };
 
 static inline int is_t4(enum chip_type chip)
@@ -84,4 +90,8 @@ static inline int is_t6(enum chip_type chip)
 	return (CHELSIO_CHIP_VERSION(chip) == CHELSIO_T6);
 }
 
+static inline int is_t7(enum chip_type chip)
+{
+	return (CHELSIO_CHIP_VERSION(chip) == CHELSIO_T7);
+}
 #endif /* __T4_CHIP_TYPE_H__ */
diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.h b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.h
index 63bc956d2037..6c7761b88ca6 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.h
@@ -54,13 +54,18 @@ enum {
 	MBOX_LEN        = 64,   /* mailbox size in bytes */
 	TRACE_LEN       = 112,  /* length of trace data and mask */
 	FILTER_OPT_LEN  = 36,   /* filter tuple width for optional components */
+	T7_PM_RX_CACHE_NSTATS = 27, /* # of PM Rx Cache stats in T7 */
+	MAX_UP_CORES    = 8,    /* Max # of uP cores that can be enabled */
 };
 
 enum {
 	CIM_NUM_IBQ    = 6,     /* # of CIM IBQs */
+	CIM_NUM_IBQ_T7 = 16,    /* # of CIM IBQs for T7 */
 	CIM_NUM_OBQ    = 6,     /* # of CIM OBQs */
 	CIM_NUM_OBQ_T5 = 8,     /* # of CIM OBQs for T5 adapter */
-	CIMLA_SIZE     = 2048,  /* # of 32-bit words in CIM LA */
+	CIM_NUM_OBQ_T7 = 16,    /* # of CIM OBQs for T7 adapter */
+	CIMLA_SIZE     = (256 * 8),  /* 256 rows * ceil(235/32) 32-bit words */
+	CIMLA_SIZE_T6  = (256 * 10), /* 256 rows * ceil(311/32) 32-bit words */
 	CIM_PIFLA_SIZE = 64,    /* # of 192-bit words in CIM PIF LA */
 	CIM_MALA_SIZE  = 64,    /* # of 160-bit words in CIM MA LA */
 	CIM_IBQ_SIZE   = 128,   /* # of 128-bit words in a CIM IBQ */
@@ -89,6 +94,7 @@ enum { MBOX_OWNER_NONE, MBOX_OWNER_FW, MBOX_OWNER_DRV };    /* mailbox owners */
 enum {
 	SGE_MAX_WR_LEN = 512,     /* max WR size in bytes */
 	SGE_CTXT_SIZE = 24,       /* size of SGE context */
+	SGE_CTXT_SIZE_T7 = 28,    /* size of SGE context for T7 */
 	SGE_NTIMERS = 6,          /* # of interrupt holdoff timer values */
 	SGE_NCOUNTERS = 4,        /* # of interrupt packet counter values */
 	SGE_NDBQTIMERS = 8,       /* # of Doorbell Queue Timer values */
@@ -199,89 +205,127 @@ struct rsp_ctrl {
 #define FLASH_MAX_SIZE(nsecs)	((nsecs) * SF_SEC_SIZE)
 
 enum {
+	FLASH_FW_START_SEC = 8,
+	FLASH_FW_NSECS = 16,
+	FLASH_FW_START = FLASH_START(FLASH_FW_START_SEC),
+	FLASH_FW_MAX_SIZE = FLASH_MAX_SIZE(FLASH_FW_NSECS),
+
+	FLASH_CFG_START_SEC = 31,
+	FLASH_CFG_NSECS = 1,
+	FLASH_CFG_START = FLASH_START(FLASH_CFG_START_SEC),
+	FLASH_CFG_MAX_SIZE = FLASH_MAX_SIZE(FLASH_CFG_NSECS),
+
+	FLASH_MIN_SIZE = FLASH_CFG_START + FLASH_CFG_MAX_SIZE,
+};
+
+enum t4_flash_loc {
 	/*
 	 * Various Expansion-ROM boot images, etc.
 	 */
-	FLASH_EXP_ROM_START_SEC = 0,
-	FLASH_EXP_ROM_NSECS = 6,
-	FLASH_EXP_ROM_START = FLASH_START(FLASH_EXP_ROM_START_SEC),
-	FLASH_EXP_ROM_MAX_SIZE = FLASH_MAX_SIZE(FLASH_EXP_ROM_NSECS),
+	FLASH_LOC_EXP_ROM = 0,
 
 	/*
 	 * iSCSI Boot Firmware Table (iBFT) and other driver-related
 	 * parameters ...
 	 */
-	FLASH_IBFT_START_SEC = 6,
-	FLASH_IBFT_NSECS = 1,
-	FLASH_IBFT_START = FLASH_START(FLASH_IBFT_START_SEC),
-	FLASH_IBFT_MAX_SIZE = FLASH_MAX_SIZE(FLASH_IBFT_NSECS),
+	FLASH_LOC_IBFT,
 
 	/*
 	 * Boot configuration data.
 	 */
-	FLASH_BOOTCFG_START_SEC = 7,
-	FLASH_BOOTCFG_NSECS = 1,
-	FLASH_BOOTCFG_START = FLASH_START(FLASH_BOOTCFG_START_SEC),
-	FLASH_BOOTCFG_MAX_SIZE = FLASH_MAX_SIZE(FLASH_BOOTCFG_NSECS),
+	FLASH_LOC_BOOTCFG,
 
 	/*
 	 * Location of firmware image in FLASH.
 	 */
-	FLASH_FW_START_SEC = 8,
-	FLASH_FW_NSECS = 16,
-	FLASH_FW_START = FLASH_START(FLASH_FW_START_SEC),
-	FLASH_FW_MAX_SIZE = FLASH_MAX_SIZE(FLASH_FW_NSECS),
+	FLASH_LOC_FW,
 
 	/* Location of bootstrap firmware image in FLASH.
 	 */
-	FLASH_FWBOOTSTRAP_START_SEC = 27,
-	FLASH_FWBOOTSTRAP_NSECS = 1,
-	FLASH_FWBOOTSTRAP_START = FLASH_START(FLASH_FWBOOTSTRAP_START_SEC),
-	FLASH_FWBOOTSTRAP_MAX_SIZE = FLASH_MAX_SIZE(FLASH_FWBOOTSTRAP_NSECS),
+	FLASH_LOC_FWBOOTSTRAP,
 
 	/*
 	 * iSCSI persistent/crash information.
 	 */
-	FLASH_ISCSI_CRASH_START_SEC = 29,
-	FLASH_ISCSI_CRASH_NSECS = 1,
-	FLASH_ISCSI_CRASH_START = FLASH_START(FLASH_ISCSI_CRASH_START_SEC),
-	FLASH_ISCSI_CRASH_MAX_SIZE = FLASH_MAX_SIZE(FLASH_ISCSI_CRASH_NSECS),
+	FLASH_LOC_ISCSI_CRASH,
 
 	/*
 	 * FCoE persistent/crash information.
 	 */
-	FLASH_FCOE_CRASH_START_SEC = 30,
-	FLASH_FCOE_CRASH_NSECS = 1,
-	FLASH_FCOE_CRASH_START = FLASH_START(FLASH_FCOE_CRASH_START_SEC),
-	FLASH_FCOE_CRASH_MAX_SIZE = FLASH_MAX_SIZE(FLASH_FCOE_CRASH_NSECS),
+	FLASH_LOC_FCOE_CRASH,
 
 	/*
-	 * Location of Firmware Configuration File in FLASH.  Since the FPGA
-	 * "FLASH" is smaller we need to store the Configuration File in a
-	 * different location -- which will overlap the end of the firmware
-	 * image if firmware ever gets that large ...
+	 * Location of Firmware Configuration File in FLASH.
 	 */
-	FLASH_CFG_START_SEC = 31,
-	FLASH_CFG_NSECS = 1,
-	FLASH_CFG_START = FLASH_START(FLASH_CFG_START_SEC),
-	FLASH_CFG_MAX_SIZE = FLASH_MAX_SIZE(FLASH_CFG_NSECS),
+	FLASH_LOC_CFG,
 
-	/* We don't support FLASH devices which can't support the full
-	 * standard set of sections which we need for normal
-	 * operations.
+	/*
+	 * CUDBG chip dump.
 	 */
-	FLASH_MIN_SIZE = FLASH_CFG_START + FLASH_CFG_MAX_SIZE,
+	FLASH_LOC_CUDBG,
 
-	FLASH_FPGA_CFG_START_SEC = 15,
-	FLASH_FPGA_CFG_START = FLASH_START(FLASH_FPGA_CFG_START_SEC),
+	/*
+	 * FW chip dump.
+	 */
+	FLASH_LOC_CHIP_DUMP,
 
 	/*
-	 * Sectors 32-63 are reserved for FLASH failover.
+	 * DPU boot information store.
 	 */
+	FLASH_LOC_DPU_BOOT,
+
+	/*
+	 * DPU peristent information store.
+	 */
+	FLASH_LOC_DPU_AREA,
+
+	/*
+	 * VPD location.
+	 */
+	FLASH_LOC_VPD,
+
+	/*
+	 * Backup init/vpd.
+	 */
+	FLASH_LOC_VPD_BACKUP,
+
+	/*
+	 * Sectors 32-63 for CUDBG.
+	 * Backup firmware image.
+	 */
+	FLASH_LOC_FW_BACKUP,
+
+	/*
+	 * Backup bootstrap firmware image.
+	 */
+	FLASH_LOC_FWBOOTSTRAP_BACKUP,
+
+	/*
+	 * Backup Location of Firmware Configuration File in FLASH.
+	 */
+	FLASH_LOC_CFG_BACK,
+
+	/*
+	 * Helper to retrieve info that spans the entire Boot related area.
+	 */
+	FLASH_LOC_BOOT_AREA,
+
+	/*
+	 * Helper to determine minimum standard set of sections needed for
+	 * normal operations.
+	 */
+	FLASH_LOC_MIN_SIZE,
+
+	/*
+	 * End of FLASH regions.
+	 */
+	FLASH_LOC_END
 };
 
-#undef FLASH_START
-#undef FLASH_MAX_SIZE
+struct t4_flash_loc_entry {
+	u16 start_sec;
+	u16 nsecs;
+};
 
 #define SGE_TIMESTAMP_S 0
 #define SGE_TIMESTAMP_M 0xfffffffffffffffULL
diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_tcb.h b/drivers/net/ethernet/chelsio/cxgb4/t4_tcb.h
index 22a0220123ad..1b7fc71dd835 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_tcb.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_tcb.h
@@ -141,4 +141,20 @@
 #define TF_NON_OFFLOAD_V(x)	((x) << TF_NON_OFFLOAD_S)
 #define TF_NON_OFFLOAD_F	TF_NON_OFFLOAD_V(1)
 
+#define TCB_T_RTT_TS_RECENT_AGE_W    6
+#define TCB_T_RTT_TS_RECENT_AGE_S    0
+#define TCB_T_RTT_TS_RECENT_AGE_M    0xffffffffULL
+#define TCB_T_RTT_TS_RECENT_AGE_V(x) ((x) << TCB_T_RTT_TS_RECENT_AGE_S)
+
+#define TF_MIGRATING_S    0
+#define TF_MIGRATING_V(x) ((x) << TF_MIGRATING_S)
+
+#define TF_RECV_TSTMP_S    53
+#define TF_RECV_TSTMP_V(x) ((__u64)(x) << TF_RECV_TSTMP_S)
+
+#define TF_PEND_CTL1_S    56
+#define TF_PEND_CTL1_V(x) ((__u64)(x) << TF_PEND_CTL1_S)
+
+#define TF_PEND_CTL2_S    57
+#define TF_PEND_CTL2_V(x) ((__u64)(x) << TF_PEND_CTL2_S)
 #endif /* __T4_TCB_H */
diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_values.h b/drivers/net/ethernet/chelsio/cxgb4/t4_values.h
index eb1aa82149db..a23527db6c20 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_values.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_values.h
@@ -119,18 +119,26 @@
 
 /* CIM register field values.
  */
-#define X_MBOWNER_FW			1
-#define X_MBOWNER_PL			2
+#define MBOWNER_FW_X			1
+#define MBOWNER_PL_X			2
 
 /* PCI-E definitions */
 #define WINDOW_SHIFT_X		10
 #define PCIEOFST_SHIFT_X	10
+#define T7_MEMOFST_SHIFT_X	4
 
 /* TP_VLAN_PRI_MAP controls which subset of fields will be present in the
  * Compressed Filter Tuple for LE filters.  Each bit set in TP_VLAN_PRI_MAP
  * selects for a particular field being present.  These fields, when present
  * in the Compressed Filter Tuple, have the following widths in bits.
  */
+#define FT_FIRST_S                      FCOE_S
+#define FT_LAST_S                       FRAGMENTATION_S
+
+#define T7_FT_FIRST_S                   IPSECIDX_S
+#define T7_FT_LAST_S                    TCPFLAGS_S
+
+#define FT_IPSECIDX_W                   12
 #define FT_FCOE_W                       1
 #define FT_PORT_W                       3
 #define FT_VNIC_ID_W                    17
@@ -141,6 +149,9 @@
 #define FT_MACMATCH_W                   9
 #define FT_MPSHITTYPE_W                 3
 #define FT_FRAGMENTATION_W              1
+#define FT_ROCE_W			1
+#define FT_SYNONLY_W			1
+#define FT_TCPFLAGS_W			12
 
 /* Some of the Compressed Filter Tuple fields have internal structure.  These
  * bit shifts/masks describe those structures.  All shifts are relative to the
-- 
2.39.1


