Return-Path: <netdev+bounces-296134-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0ZXEN3tpJGph6AEAu9opvQ
	(envelope-from <netdev+bounces-296134-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 20:39:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1560164E0A8
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 20:39:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296134-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296134-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=chelsio.com (policy=reject);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45442301F488
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 18:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3011B3B8BC4;
	Sat,  6 Jun 2026 18:39:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stargate.chelsio.com (unknown [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB47C3B5F50
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 18:39:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780771166; cv=none; b=CsShTNMEsosvmZoTL4cOdHzMrTRa+mA+e6rO5dpFxhOcs2hUc4AlQuiR14JlmDNtk+2S7Ok2HNO80QPqvZObTQ5zwYch9vm7oKTgbYe+4LFd8Sw3HIHbKPXDMzoo9syRy6/o3minODsDLav+4SY8j4CPaNUlzC146BNFex/1mt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780771166; c=relaxed/simple;
	bh=R346ITtoITjRO3T0pKYm0p+EajvyvR5PdZiktUvH874=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=umdmAI1gRJipAbjnmtdPyqcYZ8mNYPyVgCtouQhqh5s4lvRDCsUdzIiU+hrEDS1vbOc3fYwgjxFKzAihGkkZtoIxUDk8kYW3NWPqAKbrL9gsrTmVE2NCc6aXORT+Cp3INUSLQu5Mkp/S5FyZzJzJklVqYOZ5UkvPtHGarDUiCJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Received: from mehrangarh-blr-asicdesigners-com.asicdesigners.com (mehrangarh.blr.asicdesigners.com [10.193.185.169])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 656IKSGB029679;
	Sat, 6 Jun 2026 11:20:35 -0700
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, bharat@chelsio.com
Subject: [PATCH net-next v1 01/10] cxgb4: Add T7 register definitions and core structures
Date: Sat,  6 Jun 2026 23:52:11 -0400
Message-Id: <20260607035220.528439-2-bharat@chelsio.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:bharat@chelsio.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296134-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1560164E0A8
X-Spam: Yes

Prepare the cxgb4 driver for the upcoming T7 adapter family by adding
the required hardware register layouts, macros, and core structural
updates.

Add T7 register addresses and macro strides to t4_regs.h. This includes
the widened 16-byte memory access spacing via T7_PCIE_MEM_ACCESS_REG,
expanded SGE interrupt tracks, and new hardware error bits for timer
overflows and queue ID pauses. Structural macros like MAX_CTRL_QUEUES
are scaled up to support multi-core scaling architectures.

Update cxgb4.h to incorporate these changes into the driver layout:
 - Add uniform CH_MSG logging helpers and log-level macro wrappers.
 - Expand struct tp_params and ch_filter_tuple with dedicated parameter
   shifts and wider filter fields to support advanced traffic engines.
 - Turn the adapter devlog parameter into a multi-core array tracking
   system and extend SGE descriptor structures to hold hardware physical
   doorbells and ring buffer group configurations.
 - Expose lifecycle, flash allocation helpers, and low-level CIM, SGE,
   and mailbox interface prototypes required by the incoming hardware.

Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h   | 194 ++++++--
 drivers/net/ethernet/chelsio/cxgb4/t4_regs.h | 478 ++++++++++++++++++-
 2 files changed, 625 insertions(+), 47 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
index f20f4bc58492..ca657961ae77 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
@@ -56,10 +56,28 @@
 #include <linux/thermal.h>
 #include <asm/io.h>
 #include "t4_chip_type.h"
+
+struct adapter;
+enum dev_state {
+	DEV_STATE_UNINIT,
+	DEV_STATE_INIT,
+	DEV_STATE_ERR
+};
+
+/* Max # of ATIDs.  The absolute HW max is 16K but we keep it lower.
+ */
+#define CXGB4_MAX_ATIDS 8192U
+
 #include "cxgb4_uld.h"
 #include "t4fw_api.h"
+#include "t4_values.h"
+#include "cxgb4_pci.h"
+
+#define CH_INFO(adap, fmt, ...) dev_info((adap)->pdev_dev, fmt, ##__VA_ARGS__)
+#define CH_ERR(adap, fmt, ...) dev_err((adap)->pdev_dev, fmt, ##__VA_ARGS__)
+#define CH_WARN(adap, fmt, ...) dev_warn((adap)->pdev_dev, fmt, ##__VA_ARGS__)
+#define CH_ALERT(adap, fmt, ...) dev_alert((adap)->pdev_dev, fmt, ##__VA_ARGS__)
 
-#define CH_WARN(adap, fmt, ...) dev_warn(adap->pdev_dev, fmt, ## __VA_ARGS__)
 extern struct list_head adapter_list;
 extern struct list_head uld_list;
 extern struct mutex uld_mutex;
@@ -121,12 +139,6 @@ enum dev_master {
 	MASTER_MUST
 };
 
-enum dev_state {
-	DEV_STATE_UNINIT,
-	DEV_STATE_INIT,
-	DEV_STATE_ERR
-};
-
 enum cc_pause {
 	PAUSE_RX      = 1 << 0,
 	PAUSE_TX      = 1 << 1,
@@ -136,7 +148,8 @@ enum cc_pause {
 enum cc_fec {
 	FEC_AUTO      = 1 << 0,	 /* IEEE 802.3 "automatic" */
 	FEC_RS        = 1 << 1,  /* Reed-Solomon */
-	FEC_BASER_RS  = 1 << 2   /* BaseR/Reed-Solomon */
+	FEC_BASER_RS  = 1 << 2,  /* BaseR/Reed-Solomon */
+	FEC_FORCE     = 1 << 3	 /* Forcefully set FEC */
 };
 
 enum {
@@ -374,6 +387,7 @@ struct tp_params {
 	 * places we store their offsets here, or a -1 if the field isn't
 	 * present.
 	 */
+	int ipsecidx_shift;
 	int fcoe_shift;
 	int port_shift;
 	int vnic_shift;
@@ -384,6 +398,13 @@ struct tp_params {
 	int macmatch_shift;
 	int matchtype_shift;
 	int frag_shift;
+	int roce_shift;
+	int synonly_shift;
+	int tcpflags_shift;
+
+	u8 lb_mode;                     /* Load Balancer Mode */
+	u8 nports;                      /* # of ports activated by FW */
+	u32 channel_map[NCHAN];         /* saved TP Channel Map from FW */
 
 	u64 hash_filter_mask;
 };
@@ -412,6 +433,8 @@ struct pf_resources {
 };
 
 struct pci_params {
+	u16 vendor_id;
+	u16 device_id;
 	unsigned char speed;
 	unsigned char width;
 };
@@ -439,7 +462,7 @@ struct adapter_params {
 	struct vpd_params vpd;
 	struct pf_resources pfres;
 	struct pci_params pci;
-	struct devlog_params devlog;
+	struct devlog_params devlog[MAX_UP_CORES];
 	enum pcie_memwin drv_memwin;
 
 	unsigned int cim_la_size;
@@ -463,7 +486,7 @@ struct adapter_params {
 	unsigned char portvec;
 	enum chip_type chip;               /* chip code */
 	struct arch_specific_params arch;  /* chip specific params */
-	unsigned char offload;
+	unsigned int offload;
 	unsigned char crypto;		/* HW capability for crypto */
 	unsigned char ethofld;		/* QoS support */
 
@@ -472,6 +495,7 @@ struct adapter_params {
 
 	unsigned int ofldq_wr_cred;
 	bool ulptx_memwrite_dsgl;          /* use of T5 DSGL allowed */
+	bool dev_512sgl_mr;		   /* support 512 pbl entries per FR MR*/
 
 	unsigned int nsched_cls;          /* number of traffic classes */
 	unsigned int max_ordird_qp;       /* Max read depth per RDMA QP */
@@ -487,6 +511,12 @@ struct adapter_params {
 	u8 mps_bg_map[MAX_NPORTS];	/* MPS Buffer Group Map */
 	bool write_w_imm_support;       /* FW supports WRITE_WITH_IMMEDIATE */
 	bool write_cmpl_support;        /* FW supports WRITE_CMPL */
+
+	bool tx_sendpath;               /* FW supports Tx Sendpath */
+
+	u8 num_up_cores; /* # of enabled uP cores */
+	u32 tid_qid_sel_mask; /* TID based QID selection mask for uP cores */
+	u8 tid_qid_sel_shift; /* TID based QID selection shift for uP cores */
 };
 
 /* State needed to monitor the forward progress of SGE Ingress DMA activities
@@ -605,7 +635,7 @@ struct link_config {
 enum {
 	MAX_ETH_QSETS = 32,           /* # of Ethernet Tx/Rx queue sets */
 	MAX_OFLD_QSETS = 16,          /* # of offload Tx, iscsi Rx queue sets */
-	MAX_CTRL_QUEUES = NCHAN,      /* # of control Tx queues */
+	MAX_CTRL_QUEUES = NCHAN * MAX_UP_CORES,      /* # of control Tx queues */
 };
 
 enum {
@@ -641,7 +671,6 @@ enum {
 #define PRIV_FLAGS_ADAP			0
 #define PRIV_FLAGS_PORT			PRIV_FLAG_PORT_TX_VM
 
-struct adapter;
 struct sge_rspq;
 
 #include "cxgb4_dcb.h"
@@ -874,6 +903,7 @@ struct sge_eth_txq {                /* state for an SGE Ethernet Tx queue */
 	unsigned long tx_cso;       /* # of Tx checksum offloads */
 	unsigned long vlan_ins;     /* # of Tx VLAN insertions */
 	unsigned long mapping_err;  /* # of I/O MMU packet mapping errors */
+	u8 group_id;
 } ____cacheline_aligned_in_smp;
 
 struct sge_uld_txq {               /* state for an SGE offload Tx queue */
@@ -881,8 +911,8 @@ struct sge_uld_txq {               /* state for an SGE offload Tx queue */
 	struct adapter *adap;
 	struct sk_buff_head sendq;  /* list of backpressured packets */
 	struct tasklet_struct qresume_tsk; /* restarts the queue */
-	bool service_ofldq_running; /* service_ofldq() is processing sendq */
-	u8 full;                    /* the Tx ring is full */
+	u8 service_ofldq_running;     /* service_ofldq() is processing sendq */
+	u8 full;                      /* the Tx ring is full */
 	unsigned long mapping_err;  /* # of I/O MMU packet mapping errors */
 } ____cacheline_aligned_in_smp;
 
@@ -892,6 +922,7 @@ struct sge_ctrl_txq {               /* state for an SGE control Tx queue */
 	struct sk_buff_head sendq;  /* list of backpressured packets */
 	struct tasklet_struct qresume_tsk; /* restarts the queue */
 	u8 full;                    /* the Tx ring is full */
+	u8 tid_qid_group_id;
 } ____cacheline_aligned_in_smp;
 
 struct sge_uld_rxq_info {
@@ -962,6 +993,10 @@ struct sge_eohw_txq {
 };
 
 struct sge {
+	void __iomem *tx_db_addr; /* Tx doorbell */
+	void __iomem *rx_db_addr; /* Rx doorbell */
+	u64 db_gts_pa;            /* physical address of doorbell and GTS register */
+
 	struct sge_eth_txq ethtxq[MAX_ETH_QSETS];
 	struct sge_eth_txq ptptxq;
 	struct sge_ctrl_txq ctrlq[MAX_CTRL_QUEUES];
@@ -1014,6 +1049,29 @@ struct sge {
 	int nd_msix_idx; /* Index to non-data interrupts MSI-X info */
 };
 
+/*
+ * Return a Response Queue's Ingress Packet Count Interrupt Threshold.
+ * Returns 0 if not enabled.
+ */
+static inline unsigned int rspq_intr_pktcnt(const struct sge *s,
+					    const struct sge_rspq *rspq)
+{
+	return ((rspq->intr_params & QINTR_CNT_EN_F) ?
+			s->counter_val[rspq->pktcnt_idx] :
+			0);
+}
+
+/*
+ * Return a Response Queue's interrupt hold-off time in us.  0 means no timer.
+ */
+static inline unsigned int rspq_intr_timer(const struct sge *s,
+					   const struct sge_rspq *rspq)
+{
+	unsigned int timer_idx = QINTR_TIMER_IDX_G(rspq->intr_params);
+
+	return (timer_idx < SGE_NTIMERS ? s->timer_val[timer_idx] : 0);
+}
+
 #define for_each_ethrxq(sge, i) for (i = 0; i < (sge)->ethqsets; i++)
 #define for_each_ofldtxq(sge, i) for (i = 0; i < (sge)->ofldqsets; i++)
 
@@ -1109,7 +1167,9 @@ struct adapter {
 	struct device *pdev_dev;
 	const char *name;
 	unsigned int mbox;
+	struct mbox_chan *mbox_chan;
 	unsigned int pf;
+	u8 primary_pf;
 	unsigned int flags;
 	unsigned int adap_idx;
 	enum chip_type chip;
@@ -1146,8 +1206,10 @@ struct adapter {
 	unsigned int rawf_start;
 	unsigned int rawf_cnt;
 	struct smt_data *smt;
+
 	struct cxgb4_uld_info *uld;
 	void *uld_handle[CXGB4_ULD_MAX];
+
 	unsigned int num_uld;
 	unsigned int num_ofld_uld;
 	struct list_head list_node;
@@ -1179,6 +1241,7 @@ struct adapter {
 	struct mutex uld_mutex;
 
 	struct dentry *debugfs_root;
+	struct dentry *debugfs_multicore[MAX_UP_CORES];
 	bool use_bd;     /* Use SGE Back Door intfc for reading SGE Contexts */
 	bool trace_rss;	/* 1 implies that different RSS flit per filter is
 			 * used per filter else if 0 default RSS flit is
@@ -1297,7 +1360,7 @@ struct ch_sched_flowc {
 };
 
 /* Defined bit width of user definable filter tuples
- */
+*/
 #define ETHTYPE_BITWIDTH 16
 #define FRAG_BITWIDTH 1
 #define MACIDX_BITWIDTH 9
@@ -1311,6 +1374,7 @@ struct ch_sched_flowc {
 #define IVLAN_BITWIDTH 16
 #define OVLAN_BITWIDTH 16
 #define ENCAP_VNI_BITWIDTH 24
+#define SYNONLY_BITWIDTH 1
 
 /* Filter matching rules.  These consist of a set of ingress packet field
  * (value, mask) tuples.  The associated ingress packet field matches the
@@ -1341,7 +1405,7 @@ struct ch_filter_tuple {
 	uint32_t ivlan_vld:1;                   /* inner VLAN valid */
 	uint32_t ovlan_vld:1;                   /* outer VLAN valid */
 	uint32_t pfvf_vld:1;                    /* PF/VF valid */
-	uint32_t encap_vld:1;			/* Encapsulation valid */
+	uint32_t encap_vld:1;                   /* Encapsulation valid */
 	uint32_t macidx:MACIDX_BITWIDTH;        /* exact match MAC index */
 	uint32_t fcoe:FCOE_BITWIDTH;            /* FCoE packet */
 	uint32_t iport:IPORT_BITWIDTH;          /* ingress port */
@@ -1352,7 +1416,8 @@ struct ch_filter_tuple {
 	uint32_t vf:VF_BITWIDTH;                /* PCI-E VF ID */
 	uint32_t ivlan:IVLAN_BITWIDTH;          /* inner VLAN */
 	uint32_t ovlan:OVLAN_BITWIDTH;          /* outer VLAN */
-	uint32_t vni:ENCAP_VNI_BITWIDTH;	/* VNI of tunnel */
+	uint32_t vni:ENCAP_VNI_BITWIDTH;        /* VNI of tunnel */
+	uint32_t synonly:SYNONLY_BITWIDTH;      /* SYN packet match only */
 
 	/* Uncompressed header matching field rules.  These are always
 	 * available for field rules.
@@ -1364,10 +1429,10 @@ struct ch_filter_tuple {
 };
 
 /* A filter ioctl command.
- */
+*/
 struct ch_filter_specification {
 	/* Administrative fields for filter.
-	 */
+	*/
 	uint32_t hitcnts:1;     /* count filter hits in TCB */
 	uint32_t prio:1;        /* filter has priority over active/server */
 
@@ -1375,7 +1440,7 @@ struct ch_filter_specification {
 	 * matching that doesn't exist as a (value, mask) tuple.
 	 */
 	uint32_t type:1;        /* 0 => IPv4, 1 => IPv6 */
-	u32 hash:1;		/* 0 => wild-card, 1 => exact-match */
+	u32 hash:1;             /* 0 => wild-card, 1 => exact-match */
 
 	/* Packet dispatch information.  Ingress packets which match the
 	 * filter rules will be dropped, passed to the host or switched back
@@ -1390,7 +1455,7 @@ struct ch_filter_specification {
 
 	uint32_t maskhash:1;    /* dirsteer=0: store RSS hash in TCB */
 	uint32_t dirsteerhash:1;/* dirsteer=1: 0 => TCB contains RSS hash */
-				/*             1 => TCB contains IQ ID */
+	/*             1 => TCB contains IQ ID */
 
 	/* Switch proxy/rewrite fields.  An ingress packet which matches a
 	 * filter with "switch" set will be looped back out as an egress
@@ -1405,19 +1470,19 @@ struct ch_filter_specification {
 	uint8_t smac[ETH_ALEN]; /* new source MAC address */
 	uint16_t vlan;          /* VLAN Tag to insert */
 
-	u8 nat_lip[16];		/* local IP to use after NAT'ing */
-	u8 nat_fip[16];		/* foreign IP to use after NAT'ing */
-	u16 nat_lport;		/* local port to use after NAT'ing */
-	u16 nat_fport;		/* foreign port to use after NAT'ing */
+	u8 nat_lip[16];         /* local IP to use after NAT'ing */
+	u8 nat_fip[16];         /* foreign IP to use after NAT'ing */
+	u16 nat_lport;          /* local port to use after NAT'ing */
+	u16 nat_fport;          /* foreign port to use after NAT'ing */
 
-	u32 tc_prio;		/* TC's filter priority index */
-	u64 tc_cookie;		/* Unique cookie identifying TC rules */
+	u32 tc_prio;            /* TC's filter priority index */
+	u64 tc_cookie;          /* Unique cookie identifying TC rules */
 
 	/* reservation for future additions */
 	u8 rsvd[12];
 
 	/* Filter rule value/mask pairs.
-	 */
+	*/
 	struct ch_filter_tuple val;
 	struct ch_filter_tuple mask;
 };
@@ -1582,6 +1647,15 @@ static inline struct adapter *netdev2adap(const struct net_device *dev)
 	return netdev2pinfo(dev)->adapter;
 }
 
+/**
+ * t4_os_lock_init - initialize spinlock
+ * @lock: the spinlock
+ */
+static inline void t4_os_lock_init(spinlock_t *lock)
+{
+	spin_lock_init(lock);
+}
+
 /* Return a version number to identify the type of adapter.  The scheme is:
  * - bits 0..9: chip version
  * - bits 10..15: chip revision
@@ -1608,6 +1682,11 @@ extern char cxgb4_driver_name[];
 void t4_os_portmod_changed(struct adapter *adap, int port_id);
 void t4_os_link_changed(struct adapter *adap, int port_id, int link_stat);
 
+void cxgb4_work_queue(struct workqueue_struct *workq, struct work_struct *work);
+void cxgb4_work_cancel(struct workqueue_struct *workq, struct work_struct *work);
+bool cxgb4_msix_enabled(struct adapter *adap);
+bool cxgb4_msi_enabled(struct adapter *adap);
+struct net_device *cxgb4_port_chan_to_netdev(struct adapter *adap, u8 chan);
 void t4_free_sge_resources(struct adapter *adap);
 irq_handler_t t4_intr_handler(struct adapter *adap);
 netdev_tx_t t4_start_xmit(struct sk_buff *skb, struct net_device *dev);
@@ -1622,10 +1701,10 @@ int t4_sge_alloc_rxq(struct adapter *adap, struct sge_rspq *iq, bool fwevtq,
 		     rspq_flush_handler_t flush_handler, int cong);
 int t4_sge_alloc_eth_txq(struct adapter *adap, struct sge_eth_txq *txq,
 			 struct net_device *dev, struct netdev_queue *netdevq,
-			 unsigned int iqid, u8 dbqt);
+			 unsigned int iqid, u8 dbqt, int index);
 int t4_sge_alloc_ctrl_txq(struct adapter *adap, struct sge_ctrl_txq *txq,
 			  struct net_device *dev, unsigned int iqid,
-			  unsigned int cmplqid);
+			  unsigned int cmplqid, int index);
 int t4_sge_mod_ctrl_txq(struct adapter *adap, unsigned int eqid,
 			unsigned int cmplqid);
 int t4_sge_alloc_uld_txq(struct adapter *adap, struct sge_uld_txq *txq,
@@ -1731,6 +1810,10 @@ static inline int t4_wr_mbox_ns(struct adapter *adap, int mbox, const void *cmd,
 	return t4_wr_mbox_meat(adap, mbox, cmd, size, rpl, false);
 }
 
+unsigned int t4_pcie_mem_access_base_win_reg(struct adapter *adap, int win);
+unsigned int t4_pcie_mem_access_offset_reg(struct adapter *adap, int win);
+void t4_pcie_mem_access_offset_write(struct adapter *adap, u32 off, int win,
+				     u32 pf);
 /**
  *	hash_mac_addr - return the hash value of a MAC address
  *	@addr: the 48-bit Ethernet MAC address
@@ -1784,6 +1867,9 @@ void t4_read_indirect(struct adapter *adap, unsigned int addr_reg,
 		      unsigned int start_idx);
 void t4_hw_pci_read_cfg4(struct adapter *adapter, int reg, u32 *val);
 
+void t4_record_mbox(struct adapter *adapter, const __be64 *cmd,
+		    unsigned int size, int access, int execute);
+
 struct fw_filter_wr;
 
 void t4_intr_enable(struct adapter *adapter);
@@ -1866,6 +1952,7 @@ void t4_dump_version_info(struct adapter *adapter);
 int t4_prep_fw(struct adapter *adap, struct fw_info *fw_info,
 	       const u8 *fw_data, unsigned int fw_size,
 	       struct fw_hdr *card_fw, enum dev_state state, int *reset);
+enum chip_type t4_get_chip_type(struct adapter *adap, int ver);
 int t4_prep_adapter(struct adapter *adapter);
 int t4_shutdown_adapter(struct adapter *adapter);
 
@@ -1881,6 +1968,7 @@ unsigned int qtimer_val(const struct adapter *adap,
 			const struct sge_rspq *q);
 
 int t4_init_devlog_params(struct adapter *adapter);
+unsigned int t4_sge_get_qpp(struct adapter *adap, unsigned int qtype);
 int t4_init_sge_params(struct adapter *adapter);
 int t4_init_tp_params(struct adapter *adap, bool sleep_ok);
 int t4_filter_field_shift(const struct adapter *adap, int filter_sel);
@@ -1909,24 +1997,41 @@ void t4_read_rss_vf_config(struct adapter *adapter, unsigned int index,
 u32 t4_read_rss_pf_map(struct adapter *adapter, bool sleep_ok);
 u32 t4_read_rss_pf_mask(struct adapter *adapter, bool sleep_ok);
 
+u8 t4_get_tp_port_chan(struct adapter *adap, u8 pidx);
 unsigned int t4_get_mps_bg_map(struct adapter *adapter, int pidx);
 unsigned int t4_get_tp_ch_map(struct adapter *adapter, int pidx);
 void t4_pmtx_get_stats(struct adapter *adap, u32 cnt[], u64 cycles[]);
 void t4_pmrx_get_stats(struct adapter *adap, u32 cnt[], u64 cycles[]);
+void t4_pmrx_cache_get_stats(struct adapter *adap, u32 stats[]);
+u8 t4_cim_num_ibq(struct adapter *adap);
+u8 t4_cim_num_obq(struct adapter *adap);
+void t4_read_cimq_cfg_core(struct adapter *adap, u8 coreid, u16 *base,
+			   u16 *size, u16 *thres);
 int t4_read_cim_ibq(struct adapter *adap, unsigned int qid, u32 *data,
 		    size_t n);
+int t4_read_cim_obq_core(struct adapter *adap, u8 coreid, u32 qid, u32 *data,
+			 size_t n);
 int t4_read_cim_obq(struct adapter *adap, unsigned int qid, u32 *data,
 		    size_t n);
+int t4_cim_read_core(struct adapter *adap, u8 group, u8 coreid,
+		     unsigned int addr, unsigned int n, unsigned int *valp);
 int t4_cim_read(struct adapter *adap, unsigned int addr, unsigned int n,
 		unsigned int *valp);
+int t4_cim_write_core(struct adapter *adap, u8 group, u8 coreid,
+		      unsigned int addr, unsigned int n,
+		      const unsigned int *valp);
 int t4_cim_write(struct adapter *adap, unsigned int addr, unsigned int n,
 		 const unsigned int *valp);
+int t4_cim_read_la_core(struct adapter *adap, u8 coreid, u32 *la_buf,
+			u32 *wrptr);
 int t4_cim_read_la(struct adapter *adap, u32 *la_buf, unsigned int *wrptr);
 void t4_cim_read_pif_la(struct adapter *adap, u32 *pif_req, u32 *pif_rsp,
 			unsigned int *pif_req_wrptr,
 			unsigned int *pif_rsp_wrptr);
 void t4_cim_read_ma_la(struct adapter *adap, u32 *ma_req, u32 *ma_rsp);
 void t4_read_cimq_cfg(struct adapter *adap, u16 *base, u16 *size, u16 *thres);
+int t4_read_cim_ibq_core(struct adapter *adap, u8 coreid, u32 qid, u32 *data,
+			 size_t n);
 const char *t4_get_port_type_description(enum fw_port_type port_type);
 void t4_get_port_stats(struct adapter *adap, int idx, struct port_stats *p);
 void t4_get_port_stats_offset(struct adapter *adap, int idx,
@@ -2016,6 +2121,21 @@ int t4_free_mac_filt(struct adapter *adap, unsigned int mbox,
 		     const u8 **addr, bool sleep_ok);
 int t4_change_mac(struct adapter *adap, unsigned int mbox, unsigned int viid,
 		  int idx, const u8 *addr, bool persist, u8 *smt_idx);
+int cxgb4_is_primary_pf(struct adapter *adapter);
+struct adapter *cxgb4_adap_alloc(struct device *dev);
+int cxgb4_mbox_log_init(struct adapter *adap);
+void cxgb4_mbox_log_free(struct adapter *adap);
+
+pci_ers_result_t cxgb4_pci_eeh_err_detected(struct pci_dev *pdev,
+					    pci_channel_state_t state);
+pci_ers_result_t cxgb4_pci_eeh_slot_reset(struct pci_dev *pdev);
+void cxgb4_pci_eeh_resume(struct pci_dev *pdev);
+void cxgb4_pci_eeh_reset_prepare(struct pci_dev *pdev);
+void cxgb4_pci_eeh_reset_done(struct pci_dev *pdev);
+int cxgb4_iov_configure(struct pci_dev *pdev, int num_vfs);
+int cxgb4_adap_probe(struct adapter *adapter);
+void cxgb4_adap_remove(struct adapter *adapter);
+void cxgb4_adap_shutdown(struct adapter *adapter);
 int t4_set_addr_hash(struct adapter *adap, unsigned int mbox, unsigned int viid,
 		     bool ucast, u64 vec, bool sleep_ok);
 int t4_enable_vi_params(struct adapter *adap, unsigned int mbox,
@@ -2057,6 +2177,7 @@ int t4_set_trace_filter(struct adapter *adapter, const struct trace_params *tp,
 			int filter_index, int enable);
 void t4_get_trace_filter(struct adapter *adapter, struct trace_params *tp,
 			 int filter_index, int *enabled);
+void t4_set_trace_rss_control(struct adapter *adap, u8 chan, u16 qid);
 int t4_fwaddrspace_write(struct adapter *adap, unsigned int mbox,
 			 u32 addr, u32 val);
 void t4_read_pace_tbl(struct adapter *adap, unsigned int pace_vals[NTX_SCHED]);
@@ -2121,6 +2242,12 @@ void cxgb4_write_partial_sgl(const struct sk_buff *skb, struct sge_txq *q,
 void cxgb4_ring_tx_db(struct adapter *adap, struct sge_txq *q, int n);
 int t4_set_vlan_acl(struct adapter *adap, unsigned int mbox, unsigned int vf,
 		    u16 vlan);
+
+/* Flash Layout helpers */
+int t4_flash_location_start_sec(struct adapter *adap, enum t4_flash_loc loc);
+int t4_flash_location_nsecs(struct adapter *adap, enum t4_flash_loc loc);
+int t4_flash_location_start(struct adapter *adap, enum t4_flash_loc loc);
+int t4_flash_location_size(struct adapter *adap, enum t4_flash_loc loc);
 int cxgb4_dcb_enabled(const struct net_device *dev);
 
 int cxgb4_thermal_init(struct adapter *adap);
@@ -2141,6 +2268,12 @@ int cxgb4_free_mac_filt(struct adapter *adap, unsigned int viid,
 			unsigned int naddr, const u8 **addr, bool sleep_ok);
 int cxgb4_init_mps_ref_entries(struct adapter *adap);
 void cxgb4_free_mps_ref_entries(struct adapter *adap);
+int cxgb4_alloc_encap_mac_filt(struct adapter *adap, unsigned int viid,
+			       const u8 *addr, const u8 *mask,
+			       unsigned int vni, unsigned int vni_mask,
+			       u8 dip_hit, u8 lookup_type, bool sleep_ok);
+int cxgb4_free_encap_mac_filt(struct adapter *adap, unsigned int viid,
+			      int idx, bool sleep_ok);
 int cxgb4_update_mac_filt(struct port_info *pi, unsigned int viid,
 			  int *tcam_idx, const u8 *addr,
 			  bool persistent, u8 *smt_idx);
@@ -2153,4 +2286,5 @@ void cxgb4_port_mirror_free(struct net_device *dev);
 #if IS_ENABLED(CONFIG_CHELSIO_TLS_DEVICE)
 int cxgb4_set_ktls_feature(struct adapter *adap, bool enable);
 #endif
+bool cxgb4_pcie_relaxed_ordering_enabled(struct adapter *adap);
 #endif /* __CXGB4_H__ */
diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_regs.h b/drivers/net/ethernet/chelsio/cxgb4/t4_regs.h
index 695916ba0405..535854b18188 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_regs.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_regs.h
@@ -45,6 +45,7 @@
 #define PF_BASE(idx) (PF0_BASE + (idx) * PF_STRIDE)
 #define PF_REG(idx, reg) (PF_BASE(idx) + (reg))
 
+#define NUM_UP_TSCH_CHANNEL_INSTANCES 4
 #define NUM_CIM_CTL_TSCH_CHANNEL_INSTANCES 4
 #define NUM_CIM_CTL_TSCH_CHANNEL_TSCH_CLASS_INSTANCES 16
 
@@ -66,6 +67,8 @@
 #define MC_BIST_STATUS_REG(reg_addr, idx) ((reg_addr) + (idx) * 4)
 #define EDC_BIST_STATUS_REG(reg_addr, idx) ((reg_addr) + (idx) * 4)
 
+#define T7_PCIE_MEM_ACCESS_REG(reg_addr, idx) ((reg_addr) + (idx) * 16)
+
 #define PCIE_FW_REG(reg_addr, idx) ((reg_addr) + (idx) * 4)
 
 #define NUM_LE_DB_DBGI_REQ_DATA_INSTANCES 17
@@ -109,9 +112,10 @@
 #define CIDXINC_M    0xfffU
 #define CIDXINC_V(x) ((x) << CIDXINC_S)
 
-#define SGE_CONTROL_A	0x1008
 #define SGE_CONTROL2_A	0x1124
 
+#define SGE_CONTROL_A	0x1008
+
 #define RXPKTCPLMODE_S    18
 #define RXPKTCPLMODE_V(x) ((x) << RXPKTCPLMODE_S)
 #define RXPKTCPLMODE_F    RXPKTCPLMODE_V(1U)
@@ -172,6 +176,7 @@
 
 #define SGE_CTXT_DATA0_A 0x1200
 #define SGE_CTXT_DATA5_A 0x1214
+#define SGE_CTXT_DATA6_A 0x1218
 
 #define GLOBALENABLE_S    0
 #define GLOBALENABLE_V(x) ((x) << GLOBALENABLE_S)
@@ -232,6 +237,11 @@
 #define SGE_INT_CAUSE1_A	0x1024
 #define SGE_INT_CAUSE2_A	0x1030
 #define SGE_INT_CAUSE3_A	0x103c
+#define SGE_INT_CAUSE4_A	0x10dc
+#define SGE_INT_CAUSE5_A	0x110c
+#define SGE_INT_CAUSE6_A	0x1128
+#define SGE_INT_CAUSE7_A	0x1360
+#define SGE_INT_CAUSE8_A	0x11c8
 
 #define ERR_FLM_DBP_S    31
 #define ERR_FLM_DBP_V(x) ((x) << ERR_FLM_DBP_S)
@@ -265,6 +275,10 @@
 #define ERR_PCIE_ERROR0_V(x) ((x) << ERR_PCIE_ERROR0_S)
 #define ERR_PCIE_ERROR0_F    ERR_PCIE_ERROR0_V(1U)
 
+#define ERR_TIMER_ABOVE_MAX_QID_S    23
+#define ERR_TIMER_ABOVE_MAX_QID_V(x) ((x) << ERR_TIMER_ABOVE_MAX_QID_S)
+#define ERR_TIMER_ABOVE_MAX_QID_F    ERR_TIMER_ABOVE_MAX_QID_V(1U)
+
 #define ERR_CPL_EXCEED_IQE_SIZE_S    22
 #define ERR_CPL_EXCEED_IQE_SIZE_V(x) ((x) << ERR_CPL_EXCEED_IQE_SIZE_S)
 #define ERR_CPL_EXCEED_IQE_SIZE_F    ERR_CPL_EXCEED_IQE_SIZE_V(1U)
@@ -273,6 +287,10 @@
 #define ERR_INVALID_CIDX_INC_V(x) ((x) << ERR_INVALID_CIDX_INC_S)
 #define ERR_INVALID_CIDX_INC_F    ERR_INVALID_CIDX_INC_V(1U)
 
+#define ERR_ITP_TIME_PAUSED_S    20
+#define ERR_ITP_TIME_PAUSED_V(x) ((x) << ERR_ITP_TIME_PAUSED_S)
+#define ERR_ITP_TIME_PAUSED_F    ERR_ITP_TIME_PAUSED_V(1U)
+
 #define ERR_CPL_OPCODE_0_S    19
 #define ERR_CPL_OPCODE_0_V(x) ((x) << ERR_CPL_OPCODE_0_S)
 #define ERR_CPL_OPCODE_0_F    ERR_CPL_OPCODE_0_V(1U)
@@ -305,6 +323,10 @@
 #define ERR_BAD_DB_PIDX0_V(x) ((x) << ERR_BAD_DB_PIDX0_S)
 #define ERR_BAD_DB_PIDX0_F    ERR_BAD_DB_PIDX0_V(1U)
 
+#define ERR_ING_PCIE_CHAN_S    11
+#define ERR_ING_PCIE_CHAN_V(x) ((x) << ERR_ING_PCIE_CHAN_S)
+#define ERR_ING_PCIE_CHAN_F    ERR_ING_PCIE_CHAN_V(1U)
+
 #define ERR_ING_CTXT_PRIO_S    10
 #define ERR_ING_CTXT_PRIO_V(x) ((x) << ERR_ING_CTXT_PRIO_S)
 #define ERR_ING_CTXT_PRIO_F    ERR_ING_CTXT_PRIO_V(1U)
@@ -321,6 +343,10 @@
 #define DBFIFO_LP_INT_V(x) ((x) << DBFIFO_LP_INT_S)
 #define DBFIFO_LP_INT_F    DBFIFO_LP_INT_V(1U)
 
+#define REG_ADDRESS_ERR_S    6
+#define REG_ADDRESS_ERR_V(x) ((x) << REG_ADDRESS_ERR_S)
+#define REG_ADDRESS_ERR_F    REG_ADDRESS_ERR_V(1U)
+
 #define INGRESS_SIZE_ERR_S    5
 #define INGRESS_SIZE_ERR_V(x) ((x) << INGRESS_SIZE_ERR_S)
 #define INGRESS_SIZE_ERR_F    INGRESS_SIZE_ERR_V(1U)
@@ -329,6 +355,14 @@
 #define EGRESS_SIZE_ERR_V(x) ((x) << EGRESS_SIZE_ERR_S)
 #define EGRESS_SIZE_ERR_F    EGRESS_SIZE_ERR_V(1U)
 
+#define DBP_TBUF_FULL_S    8
+#define DBP_TBUF_FULL_V(x) ((x) << DBP_TBUF_FULL_S)
+#define DBP_TBUF_FULL_F    DBP_TBUF_FULL_V(1U)
+
+#define FATAL_WRE_LEN_S    7
+#define FATAL_WRE_LEN_V(x) ((x) << FATAL_WRE_LEN_S)
+#define FATAL_WRE_LEN_F    FATAL_WRE_LEN_V(1U)
+
 #define SGE_INT_ENABLE3_A 0x1040
 #define SGE_FL_BUFFER_SIZE0_A 0x1044
 #define SGE_FL_BUFFER_SIZE1_A 0x1048
@@ -406,6 +440,7 @@
 #define TSVAL_G(x) (((x) >> TSVAL_S) & TSVAL_M)
 
 #define SGE_DBFIFO_STATUS_A 0x10a4
+
 #define SGE_DBVFIFO_SIZE_A 0x113c
 
 #define HP_INT_THRESH_S    28
@@ -761,6 +796,7 @@
 
 #define PCIE_NONFAT_ERR_A	0x3010
 #define PCIE_CFG_SPACE_REQ_A	0x3060
+
 #define PCIE_CFG_SPACE_DATA_A	0x3064
 #define PCIE_MEM_ACCESS_BASE_WIN_A 0x3068
 
@@ -884,6 +920,9 @@
 #define TDUE_V(x) ((x) << TDUE_S)
 #define TDUE_F    TDUE_V(1U)
 
+#define PCIE_MEM_ACCESS_OFFSET0_A 0x3708
+#define T7_PCIE_MEM_ACCESS_BASE_WIN_A 0x3700
+
 /* SPARE2 register contains 32-bit value at offset 0x6 in Serial INIT
  * Configuration flashed on EEPROM. This value corresponds to 32-bit
  * Serial Configuration Version information.
@@ -944,6 +983,8 @@
 #define MC_BIST_DATA_PATTERN_A 0x760c
 
 #define MC_BIST_STATUS_RDATA_A 0x7688
+#define T7_MC_P_INT_CAUSE_A 0x49320
+#define T7_MC_P_ECC_STATUS_A 0x4932c
 
 /* registers for module MA */
 #define MA_EDRAM0_BAR_A 0x77c0
@@ -957,6 +998,11 @@
 #define EDRAM0_SIZE_V(x) ((x) << EDRAM0_SIZE_S)
 #define EDRAM0_SIZE_G(x) (((x) >> EDRAM0_SIZE_S) & EDRAM0_SIZE_M)
 
+#define T7_EDRAM0_SIZE_S    0
+#define T7_EDRAM0_SIZE_M    0xffffU
+#define T7_EDRAM0_SIZE_V(x) ((x) << T7_EDRAM0_SIZE_S)
+#define T7_EDRAM0_SIZE_G(x) (((x) >> T7_EDRAM0_SIZE_S) & T7_EDRAM0_SIZE_M)
+
 #define MA_EDRAM1_BAR_A 0x77c4
 
 #define EDRAM1_BASE_S    16
@@ -968,6 +1014,11 @@
 #define EDRAM1_SIZE_V(x) ((x) << EDRAM1_SIZE_S)
 #define EDRAM1_SIZE_G(x) (((x) >> EDRAM1_SIZE_S) & EDRAM1_SIZE_M)
 
+#define T7_EDRAM1_SIZE_S    0
+#define T7_EDRAM1_SIZE_M    0xffffU
+#define T7_EDRAM1_SIZE_V(x) ((x) << T7_EDRAM1_SIZE_S)
+#define T7_EDRAM1_SIZE_G(x) (((x) >> T7_EDRAM1_SIZE_S) & T7_EDRAM1_SIZE_M)
+
 #define MA_EXT_MEMORY_BAR_A 0x77c8
 
 #define EXT_MEM_BASE_S    16
@@ -995,6 +1046,18 @@
 #define EXT_MEM1_SIZE_V(x) ((x) << EXT_MEM1_SIZE_S)
 #define EXT_MEM1_SIZE_G(x) (((x) >> EXT_MEM1_SIZE_S) & EXT_MEM1_SIZE_M)
 
+#define T7_EXT_MEM1_SIZE_S    0
+#define T7_EXT_MEM1_SIZE_M    0xffffU
+#define T7_EXT_MEM1_SIZE_V(x) ((x) << T7_EXT_MEM1_SIZE_S)
+#define T7_EXT_MEM1_SIZE_G(x) (((x) >> T7_EXT_MEM1_SIZE_S) & T7_EXT_MEM1_SIZE_M)
+
+#define MA_HOST_MEMORY_BAR_A 0x77cc
+
+#define T7_HMA_SIZE_S    0
+#define T7_HMA_SIZE_M    0xffffU
+#define T7_HMA_SIZE_V(x) ((x) << T7_HMA_SIZE_S)
+#define T7_HMA_SIZE_G(x) (((x) >> T7_HMA_SIZE_S) & T7_HMA_SIZE_M)
+
 #define MA_EXT_MEMORY0_BAR_A 0x77c8
 
 #define EXT_MEM0_BASE_S    16
@@ -1006,6 +1069,11 @@
 #define EXT_MEM0_SIZE_V(x) ((x) << EXT_MEM0_SIZE_S)
 #define EXT_MEM0_SIZE_G(x) (((x) >> EXT_MEM0_SIZE_S) & EXT_MEM0_SIZE_M)
 
+#define T7_EXT_MEM0_SIZE_S    0
+#define T7_EXT_MEM0_SIZE_M    0xffffU
+#define T7_EXT_MEM0_SIZE_V(x) ((x) << T7_EXT_MEM0_SIZE_S)
+#define T7_EXT_MEM0_SIZE_G(x) (((x) >> T7_EXT_MEM0_SIZE_S) & T7_EXT_MEM0_SIZE_M)
+
 #define MA_TARGET_MEM_ENABLE_A 0x77d8
 
 #define EXT_MEM_ENABLE_S    2
@@ -1028,6 +1096,10 @@
 #define EXT_MEM0_ENABLE_V(x) ((x) << EXT_MEM0_ENABLE_S)
 #define EXT_MEM0_ENABLE_F    EXT_MEM0_ENABLE_V(1U)
 
+#define MC_SPLIT_S    6
+#define MC_SPLIT_V(x) ((x) << MC_SPLIT_S)
+#define MC_SPLIT_F    MC_SPLIT_V(1U)
+
 #define MA_INT_CAUSE_A	0x77e0
 
 #define MEM_PERR_INT_CAUSE_S    1
@@ -1053,6 +1125,9 @@
 #define MA_PARITY_ERROR_STATUS1_A	0x77f4
 #define MA_PARITY_ERROR_STATUS2_A	0x7804
 
+#define MA_LOCAL_DEBUG_CFG_A 0x78f8
+#define MA_LOCAL_DEBUG_PERF_CFG_A 0x7914
+
 /* registers for module EDC_0 */
 #define EDC_0_BASE_ADDR		0x7900
 
@@ -1633,6 +1708,62 @@
 #define FCOEMASK_V(x) ((x) << FCOEMASK_S)
 #define FCOEMASK_F    FCOEMASK_V(1U)
 
+#define TCPFLAGS_S    13
+#define TCPFLAGS_V(x) ((x) << TCPFLAGS_S)
+#define TCPFLAGS_F    TCPFLAGS_V(1U)
+
+#define SYNONLY_S    12
+#define SYNONLY_V(x) ((x) << SYNONLY_S)
+#define SYNONLY_F    SYNONLY_V(1U)
+
+#define ROCE_S    11
+#define ROCE_V(x) ((x) << ROCE_S)
+#define ROCE_F    ROCE_V(1U)
+
+#define T7_FRAGMENTATION_S    10
+#define T7_FRAGMENTATION_V(x) ((x) << T7_FRAGMENTATION_S)
+#define T7_FRAGMENTATION_F    T7_FRAGMENTATION_V(1U)
+
+#define T7_MPSHITTYPE_S    9
+#define T7_MPSHITTYPE_V(x) ((x) << T7_MPSHITTYPE_S)
+#define T7_MPSHITTYPE_F    T7_MPSHITTYPE_V(1U)
+
+#define T7_MACMATCH_S    8
+#define T7_MACMATCH_V(x) ((x) << T7_MACMATCH_S)
+#define T7_MACMATCH_F    T7_MACMATCH_V(1U)
+
+#define T7_ETHERTYPE_S    7
+#define T7_ETHERTYPE_V(x) ((x) << T7_ETHERTYPE_S)
+#define T7_ETHERTYPE_F    T7_ETHERTYPE_V(1U)
+
+#define T7_PROTOCOL_S    6
+#define T7_PROTOCOL_V(x) ((x) << T7_PROTOCOL_S)
+#define T7_PROTOCOL_F    T7_PROTOCOL_V(1U)
+
+#define T7_TOS_S    5
+#define T7_TOS_V(x) ((x) << T7_TOS_S)
+#define T7_TOS_F    T7_TOS_V(1U)
+
+#define T7_VLAN_S    4
+#define T7_VLAN_V(x) ((x) << T7_VLAN_S)
+#define T7_VLAN_F    T7_VLAN_V(1U)
+
+#define T7_VNIC_ID_S    3
+#define T7_VNIC_ID_V(x) ((x) << T7_VNIC_ID_S)
+#define T7_VNIC_ID_F    T7_VNIC_ID_V(1U)
+
+#define T7_PORT_S    2
+#define T7_PORT_V(x) ((x) << T7_PORT_S)
+#define T7_PORT_F    T7_PORT_V(1U)
+
+#define T7_FCOE_S    1
+#define T7_FCOE_V(x) ((x) << T7_FCOE_S)
+#define T7_FCOE_F    T7_FCOE_V(1U)
+
+#define IPSECIDX_S    0
+#define IPSECIDX_V(x) ((x) << IPSECIDX_S)
+#define IPSECIDX_F    IPSECIDX_V(1U)
+
 #define TP_INGRESS_CONFIG_A	0x141
 
 #define VNIC_S    11
@@ -1670,6 +1801,13 @@
 #define TP_MIB_FCOE_BYTE_0_HI_A	0x50
 #define TP_MIB_OFD_VLN_DROP_0_A	0x58
 #define TP_MIB_USM_PKTS_A	0x5c
+#define TP_CHANNEL_MAP_A 0x27
+
+#define T7_LB_MODE_S    30
+#define T7_LB_MODE_M    0x3U
+#define T7_LB_MODE_V(x) ((x) << T7_LB_MODE_S)
+#define T7_LB_MODE_G(x) (((x) >> T7_LB_MODE_S) & T7_LB_MODE_M)
+
 #define TP_MIB_RQE_DFR_PKT_A	0x64
 
 #define ULP_TX_INT_CAUSE_A	0x8dcc
@@ -1745,6 +1883,7 @@
 #define PM_TX_STAT_LSB_A 0x8ff0
 #define PM_TX_DBG_CTRL_A 0x8ff0
 #define PM_TX_DBG_DATA_A 0x8ff4
+#define T7_PM_TX_DBG_STAT_MSB_A 0x10000
 #define PM_TX_DBG_STAT_MSB_A 0x1001a
 
 #define PCMD_LEN_OVFL0_S    31
@@ -1907,6 +2046,7 @@
 #define MPS_PORT_STAT_RX_PORT_LESS_64B_H 0x614
 #define MAC_PORT_MAGIC_MACID_LO 0x824
 #define MAC_PORT_MAGIC_MACID_HI 0x828
+#define T7_MAC_PORT_TX_TS_VAL_LO 0x88c
 #define MAC_PORT_TX_TS_VAL_LO   0x928
 #define MAC_PORT_TX_TS_VAL_HI   0x92c
 
@@ -2084,6 +2224,9 @@
 
 #define MPS_TRC_FILTER_MATCH_CTL_A_A 0x9810
 #define MPS_TRC_FILTER_MATCH_CTL_B_A 0x9820
+#define T7_MPS_TRC_FILTER_MATCH_CTL_A_A 0xa460
+#define T7_MPS_TRC_FILTER_MATCH_CTL_B_A 0xa480
+#define T7_MPS_T5_TRC_RSS_CONTROL_A 0xa434
 
 #define TFMINPKTSIZE_S    16
 #define TFMINPKTSIZE_M    0x1ffU
@@ -2446,6 +2589,7 @@
 #define T6_VFWRADDR_G(x) (((x) >> T6_VFWRADDR_S) & T6_VFWRADDR_M)
 
 #define TP_RSS_CONFIG_CNG_A 0x7e04
+#define TP_RSS_CONFIG_SRAM_A 0x7e0c
 #define TP_RSS_SECRET_KEY0_A 0x40
 #define TP_RSS_PF0_CONFIG_A 0x30
 #define TP_RSS_PF_MAP_A 0x38
@@ -2591,6 +2735,9 @@
 #define GENEVE_V(x) ((x) << GENEVE_S)
 #define GENEVE_G(x) (((x) >> GENEVE_S) & GENEVE_M)
 
+#define T7_MPS_TRC_INT_CAUSE_A 0xa4e4
+#define T7_MPS_RX_VXLAN_TYPE_A 0x1123c
+#define T7_MPS_RX_GENEVE_TYPE_A 0x11240
 #define MPS_CLS_TCAM_Y_L_A 0xf000
 #define MPS_CLS_TCAM_DATA0_A 0xf000
 #define MPS_CLS_TCAM_DATA1_A 0xf004
@@ -2637,6 +2784,9 @@
 #define DATAVIDH1_M    0x7fU
 #define DATAVIDH1_G(x) (((x) >> DATAVIDH1_S) & DATAVIDH1_M)
 
+#define MPS_CLS_TCAM0_RDATA0_REQ_ID1_A 0xf01c
+#define MPS_CLS_TCAM0_RDATA1_REQ_ID1_A 0xf020
+#define MPS_CLS_TCAM0_RDATA2_REQ_ID1_A 0xf024
 #define MPS_CLS_TCAM_RDATA0_REQ_ID1_A 0xf020
 #define MPS_CLS_TCAM_RDATA1_REQ_ID1_A 0xf024
 #define MPS_CLS_TCAM_RDATA2_REQ_ID1_A 0xf028
@@ -2683,6 +2833,16 @@
 #define MPS_CLS_TCAM_X_L(idx) (MPS_CLS_TCAM_X_L_A + (idx) * 16)
 #define NUM_MPS_CLS_TCAM_X_L_INSTANCES 512
 
+#define T7_CTLTCAMSEL_S    26
+#define T7_CTLTCAMSEL_M    0x3U
+#define T7_CTLTCAMSEL_V(x) ((x) << T7_CTLTCAMSEL_S)
+#define T7_CTLTCAMSEL_G(x) (((x) >> T7_CTLTCAMSEL_S) & T7_CTLTCAMSEL_M)
+
+#define T7_1_CTLTCAMINDEX_S    17
+#define T7_1_CTLTCAMINDEX_M    0x1ffU
+#define T7_1_CTLTCAMINDEX_V(x) ((x) << T7_1_CTLTCAMINDEX_S)
+#define T7_1_CTLTCAMINDEX_G(x) (((x) >> T7_1_CTLTCAMINDEX_S) & T7_1_CTLTCAMINDEX_M)
+
 #define MPS_CLS_SRAM_L_A 0xe000
 
 #define T6_MULTILISTEN0_S    26
@@ -2850,6 +3010,21 @@
 
 #define ULP_RX_TDDP_PSZ_A 0x19178
 
+#define MPS_CLS_TCAM0_RDATA1_REQ_ID1_A 0xf020
+#define MPS_CLS_TCAM0_RDATA0_REQ_ID1_A 0xf01c
+#define MPS_CLS_TCAM0_RDATA2_REQ_ID1_A 0xf024
+#define MPS_T5_CLS_SRAM_L_A 0xe000
+#define MPS_T5_CLS_SRAM_H_A 0xe004
+
+#define SRAMWRN_S    31
+#define SRAMWRN_V(x) ((x) << SRAMWRN_S)
+#define SRAMWRN_F    SRAMWRN_V(1U)
+
+#define SRAMINDEX_S    16
+#define SRAMINDEX_M    0x7ffU
+#define SRAMINDEX_V(x) ((x) << SRAMINDEX_S)
+#define SRAMINDEX_G(x) (((x) >> SRAMINDEX_S) & SRAMINDEX_M)
+
 /* registers for module SF */
 #define SF_DATA_A 0x193f8
 #define SF_OP_A 0x193fc
@@ -2873,6 +3048,10 @@
 #define OP_V(x) ((x) << OP_S)
 #define OP_F    OP_V(1U)
 
+#define QUADREADDISABLE_S    5
+#define QUADREADDISABLE_V(x) ((x) << QUADREADDISABLE_S)
+#define QUADREADDISABLE_F    QUADREADDISABLE_V(1U)
+
 #define PL_PF_INT_CAUSE_A 0x3c0
 
 #define PFSW_S    3
@@ -2926,6 +3105,50 @@
 #define MA_V(x) ((x) << MA_S)
 #define MA_F    MA_V(1U)
 
+#define T7_ULP_TX_S    29
+#define T7_ULP_TX_V(x) ((x) << T7_ULP_TX_S)
+#define T7_ULP_TX_F    T7_ULP_TX_V(1U)
+
+#define T7_SGE_S    28
+#define T7_SGE_V(x) ((x) << T7_SGE_S)
+#define T7_SGE_F    T7_SGE_V(1U)
+
+#define T7_CPL_SWITCH_S    26
+#define T7_CPL_SWITCH_V(x) ((x) << T7_CPL_SWITCH_S)
+#define T7_CPL_SWITCH_F    T7_CPL_SWITCH_V(1U)
+
+#define T7_ULP_RX_S    25
+#define T7_ULP_RX_V(x) ((x) << T7_ULP_RX_S)
+#define T7_ULP_RX_F    T7_ULP_RX_V(1U)
+
+#define T7_PM_RX_S    24
+#define T7_PM_RX_V(x) ((x) << T7_PM_RX_S)
+#define T7_PM_RX_F    T7_PM_RX_V(1U)
+
+#define T7_PM_TX_S    23
+#define T7_PM_TX_V(x) ((x) << T7_PM_TX_S)
+#define T7_PM_TX_F    T7_PM_TX_V(1U)
+
+#define T7_MA_S    22
+#define T7_MA_V(x) ((x) << T7_MA_S)
+#define T7_MA_F    T7_MA_V(1U)
+
+#define T7_TP_S    21
+#define T7_TP_V(x) ((x) << T7_TP_S)
+#define T7_TP_F    T7_TP_V(1U)
+
+#define T7_LE_S    20
+#define T7_LE_V(x) ((x) << T7_LE_S)
+#define T7_LE_F    T7_LE_V(1U)
+
+#define T7_EDC1_S    19
+#define T7_EDC1_V(x) ((x) << T7_EDC1_S)
+#define T7_EDC1_F    T7_EDC1_V(1U)
+
+#define T7_EDC0_S    18
+#define T7_EDC0_V(x) ((x) << T7_EDC0_S)
+#define T7_EDC0_F    T7_EDC0_V(1U)
+
 #define TP_S    19
 #define TP_V(x) ((x) << TP_S)
 #define TP_F    TP_V(1U)
@@ -2950,6 +3173,10 @@
 #define PCIE_V(x) ((x) << PCIE_S)
 #define PCIE_F    PCIE_V(1U)
 
+#define T7_PCIE_S    15
+#define T7_PCIE_V(x) ((x) << T7_PCIE_S)
+#define T7_PCIE_F    T7_PCIE_V(1U)
+
 #define XGMAC_KR1_S    12
 #define XGMAC_KR1_V(x) ((x) << XGMAC_KR1_S)
 #define XGMAC_KR1_F    XGMAC_KR1_V(1U)
@@ -2995,6 +3222,15 @@
 #define MC1_F    MC1_V(1U)
 
 #define PL_INT_ENABLE_A 0x19410
+
+#define T7_MC1_S    17
+#define T7_MC1_V(x) ((x) << T7_MC1_S)
+#define T7_MC1_F    T7_MC1_V(1U)
+
+#define T7_MC0_S    16
+#define T7_MC0_V(x) ((x) << T7_MC0_S)
+#define T7_MC0_F    T7_MC0_V(1U)
+
 #define PL_INT_MAP0_A 0x19414
 #define PL_RST_A 0x19428
 
@@ -3012,6 +3248,10 @@
 #define FATALPERR_V(x) ((x) << FATALPERR_S)
 #define FATALPERR_F    FATALPERR_V(1U)
 
+#define INVALIDACCESS_S    3
+#define INVALIDACCESS_V(x) ((x) << INVALIDACCESS_S)
+#define INVALIDACCESS_F    INVALIDACCESS_V(1U)
+
 #define PERRVFID_S    0
 #define PERRVFID_V(x) ((x) << PERRVFID_S)
 #define PERRVFID_F    PERRVFID_V(1U)
@@ -3027,22 +3267,6 @@
 #define HASHTBLMEMCRCERR_V(x) ((x) << HASHTBLMEMCRCERR_S)
 #define HASHTBLMEMCRCERR_F    HASHTBLMEMCRCERR_V(1U)
 
-#define CMDTIDERR_S    22
-#define CMDTIDERR_V(x) ((x) << CMDTIDERR_S)
-#define CMDTIDERR_F    CMDTIDERR_V(1U)
-
-#define T6_UNKNOWNCMD_S    3
-#define T6_UNKNOWNCMD_V(x) ((x) << T6_UNKNOWNCMD_S)
-#define T6_UNKNOWNCMD_F    T6_UNKNOWNCMD_V(1U)
-
-#define T6_LIP0_S    2
-#define T6_LIP0_V(x) ((x) << T6_LIP0_S)
-#define T6_LIP0_F    T6_LIP0_V(1U)
-
-#define T6_LIPMISS_S    1
-#define T6_LIPMISS_V(x) ((x) << T6_LIPMISS_S)
-#define T6_LIPMISS_F    T6_LIPMISS_V(1U)
-
 #define LE_DB_CONFIG_A 0x19c04
 #define LE_DB_ROUTING_TABLE_INDEX_A 0x19c10
 #define LE_DB_ACTIVE_TABLE_START_INDEX_A 0x19c10
@@ -3069,6 +3293,134 @@
 #define LE_DB_TID_HASHBASE_A 0x19df8
 #define T6_LE_DB_HASH_TID_BASE_A 0x19df8
 
+#define CACHEINTPERR_S    31
+#define CACHEINTPERR_V(x) ((x) << CACHEINTPERR_S)
+#define CACHEINTPERR_F    CACHEINTPERR_V(1U)
+
+#define CACHESRAMPERR_S    30
+#define CACHESRAMPERR_V(x) ((x) << CACHESRAMPERR_S)
+#define CACHESRAMPERR_F    CACHESRAMPERR_V(1U)
+
+#define CLIPSUBERR_S    29
+#define CLIPSUBERR_V(x) ((x) << CLIPSUBERR_S)
+#define CLIPSUBERR_F    CLIPSUBERR_V(1U)
+
+#define CLCAMFIFOERR_S    28
+#define CLCAMFIFOERR_V(x) ((x) << CLCAMFIFOERR_S)
+#define CLCAMFIFOERR_F    CLCAMFIFOERR_V(1U)
+
+#define HASHTBLMEMCRCERR_S    27
+#define HASHTBLMEMCRCERR_V(x) ((x) << HASHTBLMEMCRCERR_S)
+#define HASHTBLMEMCRCERR_F    HASHTBLMEMCRCERR_V(1U)
+
+#define CTCAMINVLDENT_S    26
+#define CTCAMINVLDENT_V(x) ((x) << CTCAMINVLDENT_S)
+#define CTCAMINVLDENT_F    CTCAMINVLDENT_V(1U)
+
+#define TCAMINVLDENT_S    25
+#define TCAMINVLDENT_V(x) ((x) << TCAMINVLDENT_S)
+#define TCAMINVLDENT_F    TCAMINVLDENT_V(1U)
+
+#define TOTCNTERR_S    24
+#define TOTCNTERR_V(x) ((x) << TOTCNTERR_S)
+#define TOTCNTERR_F    TOTCNTERR_V(1U)
+
+#define CMDPRSRINTERR_S    23
+#define CMDPRSRINTERR_V(x) ((x) << CMDPRSRINTERR_S)
+#define CMDPRSRINTERR_F    CMDPRSRINTERR_V(1U)
+
+#define CMDTIDERR_S    22
+#define CMDTIDERR_V(x) ((x) << CMDTIDERR_S)
+#define CMDTIDERR_F    CMDTIDERR_V(1U)
+
+#define T6_ACTRGNFULL_S    21
+#define T6_ACTRGNFULL_V(x) ((x) << T6_ACTRGNFULL_S)
+#define T6_ACTRGNFULL_F    T6_ACTRGNFULL_V(1U)
+
+#define T6_ACTCNTIPV6TZERO_S    20
+#define T6_ACTCNTIPV6TZERO_V(x) ((x) << T6_ACTCNTIPV6TZERO_S)
+#define T6_ACTCNTIPV6TZERO_F    T6_ACTCNTIPV6TZERO_V(1U)
+
+#define T6_ACTCNTIPV4TZERO_S    19
+#define T6_ACTCNTIPV4TZERO_V(x) ((x) << T6_ACTCNTIPV4TZERO_S)
+#define T6_ACTCNTIPV4TZERO_F    T6_ACTCNTIPV4TZERO_V(1U)
+
+#define T6_ACTCNTIPV6ZERO_S    18
+#define T6_ACTCNTIPV6ZERO_V(x) ((x) << T6_ACTCNTIPV6ZERO_S)
+#define T6_ACTCNTIPV6ZERO_F    T6_ACTCNTIPV6ZERO_V(1U)
+
+#define T6_ACTCNTIPV4ZERO_S    17
+#define T6_ACTCNTIPV4ZERO_V(x) ((x) << T6_ACTCNTIPV4ZERO_S)
+#define T6_ACTCNTIPV4ZERO_F    T6_ACTCNTIPV4ZERO_V(1U)
+
+#define MAIFWRINTPERR_S    16
+#define MAIFWRINTPERR_V(x) ((x) << MAIFWRINTPERR_S)
+#define MAIFWRINTPERR_F    MAIFWRINTPERR_V(1U)
+
+#define HASHTBLMEMACCERR_S    15
+#define HASHTBLMEMACCERR_V(x) ((x) << HASHTBLMEMACCERR_S)
+#define HASHTBLMEMACCERR_F    HASHTBLMEMACCERR_V(1U)
+
+#define TCAMCRCERR_S    14
+#define TCAMCRCERR_V(x) ((x) << TCAMCRCERR_S)
+#define TCAMCRCERR_F    TCAMCRCERR_V(1U)
+
+#define TCAMINTPERR_S    13
+#define TCAMINTPERR_V(x) ((x) << TCAMINTPERR_S)
+#define TCAMINTPERR_F    TCAMINTPERR_V(1U)
+
+#define VFSRAMPERR_S    12
+#define VFSRAMPERR_V(x) ((x) << VFSRAMPERR_S)
+#define VFSRAMPERR_F    VFSRAMPERR_V(1U)
+
+#define SRVSRAMPERR_S    11
+#define SRVSRAMPERR_V(x) ((x) << SRVSRAMPERR_S)
+#define SRVSRAMPERR_F    SRVSRAMPERR_V(1U)
+
+#define SSRAMINTPERR_S    10
+#define SSRAMINTPERR_V(x) ((x) << SSRAMINTPERR_S)
+#define SSRAMINTPERR_F    SSRAMINTPERR_V(1U)
+
+#define CLCAMINTPERR_S    9
+#define CLCAMINTPERR_V(x) ((x) << CLCAMINTPERR_S)
+#define CLCAMINTPERR_F    CLCAMINTPERR_V(1U)
+
+#define CLCAMCRCPARERR_S    8
+#define CLCAMCRCPARERR_V(x) ((x) << CLCAMCRCPARERR_S)
+#define CLCAMCRCPARERR_F    CLCAMCRCPARERR_V(1U)
+
+#define HASHTBLACCFAIL_S    7
+#define HASHTBLACCFAIL_V(x) ((x) << HASHTBLACCFAIL_S)
+#define HASHTBLACCFAIL_F    HASHTBLACCFAIL_V(1U)
+
+#define TCAMACCFAIL_S    6
+#define TCAMACCFAIL_V(x) ((x) << TCAMACCFAIL_S)
+#define TCAMACCFAIL_F    TCAMACCFAIL_V(1U)
+
+#define SRVSRAMACCFAIL_S    5
+#define SRVSRAMACCFAIL_V(x) ((x) << SRVSRAMACCFAIL_S)
+#define SRVSRAMACCFAIL_F    SRVSRAMACCFAIL_V(1U)
+
+#define CLIPTCAMACCFAIL_S    4
+#define CLIPTCAMACCFAIL_V(x) ((x) << CLIPTCAMACCFAIL_S)
+#define CLIPTCAMACCFAIL_F    CLIPTCAMACCFAIL_V(1U)
+
+#define T6_UNKNOWNCMD_S    3
+#define T6_UNKNOWNCMD_V(x) ((x) << T6_UNKNOWNCMD_S)
+#define T6_UNKNOWNCMD_F    T6_UNKNOWNCMD_V(1U)
+
+#define T6_LIP0_S    2
+#define T6_LIP0_V(x) ((x) << T6_LIP0_S)
+#define T6_LIP0_F    T6_LIP0_V(1U)
+
+#define T6_LIPMISS_S    1
+#define T6_LIPMISS_V(x) ((x) << T6_LIPMISS_S)
+#define T6_LIPMISS_F    T6_LIPMISS_V(1U)
+
+#define PIPELINEERR_S    0
+#define PIPELINEERR_V(x) ((x) << PIPELINEERR_S)
+#define PIPELINEERR_F    PIPELINEERR_V(1U)
+
 #define HASHEN_S    20
 #define HASHEN_V(x) ((x) << HASHEN_S)
 #define HASHEN_F    HASHEN_V(1U)
@@ -3171,6 +3523,7 @@
 #define ADDRESS_V(x) ((x) << ADDRESS_S)
 
 #define MAC_PORT_INT_CAUSE_A 0x8dc
+#define T7_MAC_PORT_INT_CAUSE_A 0x86c
 #define XGMAC_PORT_INT_CAUSE_A 0x10dc
 
 #define TP_TX_MOD_QUEUE_REQ_MAP_A 0x7e28
@@ -3200,11 +3553,28 @@
 #define NUM_MPS_CLS_SRAM_L_INSTANCES 336
 #define NUM_MPS_T5_CLS_SRAM_L_INSTANCES 512
 
+#define MPS_T5_CLS_SRAM_L_A 0xe000
+#define MPS_T5_CLS_SRAM_H_A 0xe004
+
+#define SRAMWRN_S    31
+#define SRAMWRN_V(x) ((x) << SRAMWRN_S)
+#define SRAMWRN_F    SRAMWRN_V(1U)
+
+#define SRAMINDEX_S    16
+#define SRAMINDEX_M    0x7ffU
+#define SRAMINDEX_V(x) ((x) << SRAMINDEX_S)
+#define SRAMINDEX_G(x) (((x) >> SRAMINDEX_S) & SRAMINDEX_M)
+
 #define T5_PORT0_BASE 0x30000
 #define T5_PORT_STRIDE 0x4000
 #define T5_PORT_BASE(idx) (T5_PORT0_BASE + (idx) * T5_PORT_STRIDE)
 #define T5_PORT_REG(idx, reg) (T5_PORT_BASE(idx) + (reg))
 
+#define T7_PORT0_BASE 0x30000
+#define T7_PORT_STRIDE 0x2000
+#define T7_PORT_BASE(idx) (T7_PORT0_BASE + (idx) * T7_PORT_STRIDE)
+#define T7_PORT_REG(idx, reg) (T7_PORT_BASE(idx) + (reg))
+
 #define MC_0_BASE_ADDR 0x40000
 #define MC_1_BASE_ADDR 0x48000
 #define MC_STRIDE (MC_1_BASE_ADDR - MC_0_BASE_ADDR)
@@ -3248,13 +3618,41 @@
 #define HOSTWRITE_V(x)	((x) << HOSTWRITE_S)
 #define HOSTWRITE_F	HOSTWRITE_V(1U)
 
+#define T7_HOSTBUSY_S    31
+#define T7_HOSTBUSY_V(x) ((x) << T7_HOSTBUSY_S)
+#define T7_HOSTBUSY_F    T7_HOSTBUSY_V(1U)
+
+#define T7_HOSTWRITE_S    30
+#define T7_HOSTWRITE_V(x) ((x) << T7_HOSTWRITE_S)
+#define T7_HOSTWRITE_F    T7_HOSTWRITE_V(1U)
+
+#define HOSTGRPSEL_S    28
+#define HOSTGRPSEL_M    0x3U
+#define HOSTGRPSEL_V(x) ((x) << HOSTGRPSEL_S)
+#define HOSTGRPSEL_G(x) (((x) >> HOSTGRPSEL_S) & HOSTGRPSEL_M)
+
+#define HOSTCORESEL_S    24
+#define HOSTCORESEL_M    0xfU
+#define HOSTCORESEL_V(x) ((x) << HOSTCORESEL_S)
+#define HOSTCORESEL_G(x) (((x) >> HOSTCORESEL_S) & HOSTCORESEL_M)
+
 #define CIM_IBQ_DBG_CFG_A 0x7b60
 
+#define IBQDBGCORE_S    28
+#define IBQDBGCORE_M    0xfU
+#define IBQDBGCORE_V(x) ((x) << IBQDBGCORE_S)
+#define IBQDBGCORE_G(x) (((x) >> IBQDBGCORE_S) & IBQDBGCORE_M)
+
 #define IBQDBGADDR_S    16
 #define IBQDBGADDR_M    0xfffU
 #define IBQDBGADDR_V(x) ((x) << IBQDBGADDR_S)
 #define IBQDBGADDR_G(x) (((x) >> IBQDBGADDR_S) & IBQDBGADDR_M)
 
+#define T7_IBQDBGADDR_S    12
+#define T7_IBQDBGADDR_M    0x1fffU
+#define T7_IBQDBGADDR_V(x) ((x) << T7_IBQDBGADDR_S)
+#define T7_IBQDBGADDR_G(x) (((x) >> T7_IBQDBGADDR_S) & T7_IBQDBGADDR_M)
+
 #define IBQDBGBUSY_S    1
 #define IBQDBGBUSY_V(x) ((x) << IBQDBGBUSY_S)
 #define IBQDBGBUSY_F    IBQDBGBUSY_V(1U)
@@ -3265,6 +3663,16 @@
 
 #define CIM_OBQ_DBG_CFG_A 0x7b64
 
+#define OBQDBGCORE_S    28
+#define OBQDBGCORE_M    0xfU
+#define OBQDBGCORE_V(x) ((x) << OBQDBGCORE_S)
+#define OBQDBGCORE_G(x) (((x) >> OBQDBGCORE_S) & OBQDBGCORE_M)
+
+#define T7_OBQDBGADDR_S    12
+#define T7_OBQDBGADDR_M    0x1fffU
+#define T7_OBQDBGADDR_V(x) ((x) << T7_OBQDBGADDR_S)
+#define T7_OBQDBGADDR_G(x) (((x) >> T7_OBQDBGADDR_S) & T7_OBQDBGADDR_M)
+
 #define OBQDBGADDR_S    16
 #define OBQDBGADDR_M    0xfffU
 #define OBQDBGADDR_V(x) ((x) << OBQDBGADDR_S)
@@ -3329,6 +3737,25 @@
 #define UPDBGLACAPTPCONLY_F	UPDBGLACAPTPCONLY_V(1U)
 
 #define CIM_QUEUE_CONFIG_REF_A 0x7b48
+
+#define CORESELECT_S    6
+#define CORESELECT_M    0xfU
+#define CORESELECT_V(x) ((x) << CORESELECT_S)
+#define CORESELECT_G(x) (((x) >> CORESELECT_S) & CORESELECT_M)
+
+#define T7_OBQSELECT_S    5
+#define T7_OBQSELECT_V(x) ((x) << T7_OBQSELECT_S)
+#define T7_OBQSELECT_F    T7_OBQSELECT_V(1U)
+
+#define T7_IBQSELECT_S    4
+#define T7_IBQSELECT_V(x) ((x) << T7_IBQSELECT_S)
+#define T7_IBQSELECT_F    T7_IBQSELECT_V(1U)
+
+#define T7_QUENUMSELECT_S    0
+#define T7_QUENUMSELECT_M    0xfU
+#define T7_QUENUMSELECT_V(x) ((x) << T7_QUENUMSELECT_S)
+#define T7_QUENUMSELECT_G(x) (((x) >> T7_QUENUMSELECT_S) & T7_QUENUMSELECT_M)
+
 #define CIM_QUEUE_CONFIG_CTRL_A 0x7b4c
 
 #define CIMQSIZE_S    24
@@ -3383,4 +3810,21 @@
 #define QUENUMSELECT_S    0
 #define QUENUMSELECT_V(x) ((x) << QUENUMSELECT_S)
 
+#define T7_UP_IBQ_0_SHADOW_RDADDR_A 0x400
+#define T7_UP_OBQ_0_SHADOW_RDADDR_A 0x600
+#define T7_UP_OBQ_0_SHADOW_REALADDR_A 0x704
+
+/* registers for module HMA */
+#define HMA_LOCAL_DEBUG_CFG_A 0x51320
+
+/* registers for module UP */
+#define T7_UP_IBQ_0_SHADOW_RDADDR_A 0x400
+#define T7_UP_OBQ_0_SHADOW_RDADDR_A 0x600
+#define T7_UP_OBQ_0_SHADOW_REALADDR_A 0x704
+
+#define T7_QUEREMFLITS_S    0
+#define T7_QUEREMFLITS_M    0xfffU
+#define T7_QUEREMFLITS_V(x) ((x) << T7_QUEREMFLITS_S)
+#define T7_QUEREMFLITS_G(x) (((x) >> T7_QUEREMFLITS_S) & T7_QUEREMFLITS_M)
+
 #endif /* __T4_REGS_H */
-- 
2.39.1


