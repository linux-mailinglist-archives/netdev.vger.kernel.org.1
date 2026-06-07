Return-Path: <netdev+bounces-296133-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HQD7H2ppJGpe6AEAu9opvQ
	(envelope-from <netdev+bounces-296133-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 20:39:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8E164E0A0
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 20:39:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296133-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296133-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=chelsio.com (policy=reject);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97D2C3014287
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 18:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B673783C0;
	Sat,  6 Jun 2026 18:39:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stargate.chelsio.com (unknown [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDAF3B47E1
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 18:39:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780771151; cv=none; b=LKYwEGGfNsm1RLzTh8Nv8xgg/up5vOpqHrCEnHBG5LP0TbV4pf9tir0vQMAYlbgbbqYJFm/WXT4gVxtOuw2Q1XqQD5PEXAJqDvCVVnU69r0dvqBv0j6KheoHlHYMReRonHEIAtWDLiZlY5d7RHk461x2oNPeuBmQUbJmkeUSRik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780771151; c=relaxed/simple;
	bh=aqcniQuC0+KuKaZtPmgYp/xS1qwmbfSo/IyUDH+AoXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=if90egwGLfaWzpsL79P+v34UAhiODLZFeakBdW1v96A7jSMS7KlVoBB9h3VZzeREqKYMTRhYUSVenKbs3lSO/PiQgMKW5K2S+RMz4j8zIj2rwOZveZpaqQ4uoldnG+QECRZ/MbP7McAr7pD0sJe+kv5eeSiKUXwpNxyDhGbMXCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Received: from mehrangarh-blr-asicdesigners-com.asicdesigners.com (mehrangarh.blr.asicdesigners.com [10.193.185.169])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 656IKSGD029679;
	Sat, 6 Jun 2026 11:20:45 -0700
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, bharat@chelsio.com
Subject: [PATCH net-next v1 03/10] cxgb4: Add T7 CPL messages, FW constants, and PCI IDs
Date: Sat,  6 Jun 2026 23:52:13 -0400
Message-Id: <20260607035220.528439-4-bharat@chelsio.com>
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
	TAGGED_FROM(0.00)[bounces-296133-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: CC8E164E0A0
X-Spam: Yes

Extend the core protocol and firmware messaging interfaces to support the
T7 hardware generation, and register the matching T7 physical PCI IDs.

Update CPL structures within t4_msg.h for the expanded traffic
management pipelines. This introduces the CPL_SET_LE_REQ opcode and
tracking structures for hardware Lookup Engine and TCAM programming.
implements cpl_t7_act_open_req and cpl_t7_act_open_req6 layouts,
remove stale, duplicate legacy macros for CPL_TX_TNL_LSO to clean
up the file.

Expand firmware command definitions within t4fw_api.h and t4fw_version.h
to interact with new T7 engine features. This includes adding multi-core
queue assignment parameters, SWAPMAC and TX_LOOP offload capabilities,
and definitions for next-generation physical interfaces like SFP56,
QSFP56, OSFP, and QSFPDD. The firmware header layout is refactored to
support the T7 chip marker.

Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
 drivers/net/ethernet/chelsio/cxgb4/t4_msg.h   | 109 ++++++++++++++++--
 .../ethernet/chelsio/cxgb4/t4_pci_id_tbl.h    |  21 ++++
 drivers/net/ethernet/chelsio/cxgb4/t4fw_api.h |  82 +++++++++++--
 .../net/ethernet/chelsio/cxgb4/t4fw_version.h |   9 ++
 4 files changed, 203 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_msg.h b/drivers/net/ethernet/chelsio/cxgb4/t4_msg.h
index fed5f93bf620..66a55ddf0c24 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_msg.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_msg.h
@@ -88,6 +88,7 @@ enum {
 
 	CPL_RDMA_READ_REQ     = 0x60,
 
+	CPL_SET_LE_REQ        = 0x80,
 	CPL_PASS_OPEN_REQ6    = 0x81,
 	CPL_ACT_OPEN_REQ6     = 0x83,
 
@@ -544,6 +545,26 @@ struct cpl_t6_act_open_req {
 	__be32 opt3;
 };
 
+struct cpl_t7_act_open_req {
+	WR_HDR;
+	union opcode_tid ot;
+	__be16 local_port;
+	__be16 peer_port;
+	__be32 local_ip;
+	__be32 peer_ip;
+	__be64 opt0;
+	__be32 iss;
+	__be32 opt2;
+	__be64 params;
+	__be32 rsvd2;
+	__be32 opt3;
+};
+
+#define T7_FILTER_TUPLE_S       1
+#define T7_FILTER_TUPLE_M       0x7FFFFFFFFFFFFFFFULL
+#define T7_FILTER_TUPLE_V(x)    ((x) << T7_FILTER_TUPLE_S)
+#define T7_FILTER_TUPLE_G(x)    (((x) >> T7_FILTER_TUPLE_S) & T7_FILTER_TUPLE_M)
+
 struct cpl_act_open_req6 {
 	WR_HDR;
 	union opcode_tid ot;
@@ -590,6 +611,23 @@ struct cpl_t6_act_open_req6 {
 	__be32 opt3;
 };
 
+struct cpl_t7_act_open_req6 {
+	WR_HDR;
+	union opcode_tid ot;
+	__be16 local_port;
+	__be16 peer_port;
+	__be64 local_ip_hi;
+	__be64 local_ip_lo;
+	__be64 peer_ip_hi;
+	__be64 peer_ip_lo;
+	__be64 opt0;
+	__be32 iss;
+	__be32 opt2;
+	__be64 params;
+	__be32 rsvd2;
+	__be32 opt3;
+};
+
 struct cpl_act_open_rpl {
 	union opcode_tid ot;
 	__be32 atid_status;
@@ -682,10 +720,20 @@ struct cpl_get_tcb {
 #define QUEUENO_S    0
 #define QUEUENO_V(x) ((x) << QUEUENO_S)
 
+#define T7_QUEUENO_S    0
+#define T7_QUEUENO_M    0xFFF
+#define T7_QUEUENO_V(x) ((x) << T7_QUEUENO_S)
+#define T7_QUEUENO_G(x) (((x) >> T7_QUEUENO_S) & T7_QUEUENO_M)
+
 #define REPLY_CHAN_S    14
 #define REPLY_CHAN_V(x) ((x) << REPLY_CHAN_S)
 #define REPLY_CHAN_F    REPLY_CHAN_V(1U)
 
+#define T7_REPLY_CHAN_S	 12
+#define T7_REPLY_CHAN_M	 0x7
+#define T7_REPLY_CHAN_V(x)      ((x) << T7_REPLY_CHAN_S)
+#define T7_REPLY_CHAN_G(x)      (((x) >> T7_REPLY_CHAN_S) & T7_REPLY_CHAN_M)
+
 #define NO_REPLY_S    15
 #define NO_REPLY_V(x) ((x) << NO_REPLY_S)
 #define NO_REPLY_F    NO_REPLY_V(1U)
@@ -1363,6 +1411,53 @@ struct cpl_smt_write_rpl {
 #define SMTW_NORPL_V(x)	((x) << SMTW_NORPL_S)
 #define SMTW_NORPL_F	SMTW_NORPL_V(1U)
 
+struct cpl_set_le_req {
+	WR_HDR;
+	union opcode_tid ot;
+	__be16 reply_ctrl;
+	__be16 params;
+	__be64 mask_hi;
+	__be64 mask_lo;
+	__be64 val_hi;
+	__be64 val_lo;
+};
+
+/* cpl_set_le_req.reply_ctrl additional fields */
+#define LE_REQ_RXCHANNEL_S      14
+#define LE_REQ_RXCHANNEL_M      0x1
+#define LE_REQ_RXCHANNEL_V(x)   ((x) << LE_REQ_RXCHANNEL_S)
+#define LE_REQ_RXCHANNEL_G(x) (((x) >> LE_REQ_RXCHANNEL_S) & LE_REQ_RXCHANNEL_M)
+#define LE_REQ_RXCHANNEL_F      LE_REQ_RXCHANNEL_V(1U)
+
+#define LE_REQ_IP6_S    13
+#define LE_REQ_IP6_V(x) ((x) << LE_REQ_IP6_S)
+#define LE_REQ_IP6_F    LE_REQ_IP6_V(1U)
+
+/* cpl_set_le_req.params fields */
+#define LE_CHAN_S    0
+#define LE_CHAN_M    0x3
+#define LE_CHAN_V(x) ((x) << LE_CHAN_S)
+#define LE_CHAN_G(x) (((x) >> LE_CHAN_S) & LE_CHAN_M)
+
+#define LE_OFFSET_S    5
+#define LE_OFFSET_M    0x7
+#define LE_OFFSET_V(x) ((x) << LE_OFFSET_S)
+#define LE_OFFSET_G(x) (((x) >> LE_OFFSET_S) & LE_OFFSET_M)
+
+#define LE_MORE_S    8
+#define LE_MORE_V(x) ((x) << LE_MORE_S)
+#define LE_MORE_F    LE_MORE_V(1U)
+
+#define LE_REQSIZE_S    9
+#define LE_REQSIZE_M    0x7
+#define LE_REQSIZE_V(x) ((x) << LE_REQSIZE_S)
+#define LE_REQSIZE_G(x) (((x) >> LE_REQSIZE_S) & LE_REQSIZE_M)
+
+#define LE_REQCMD_S    12
+#define LE_REQCMD_M    0xF
+#define LE_REQCMD_V(x) ((x) << LE_REQCMD_S)
+#define LE_REQCMD_G(x) (((x) >> LE_REQCMD_S) & LE_REQCMD_M)
+
 struct cpl_rdma_terminate {
 	union opcode_tid ot;
 	__be16 rsvd;
@@ -1631,10 +1726,10 @@ struct cpl_tx_tnl_lso {
 	(((x) >> CPL_TX_TNL_LSO_IPV6OUT_S) & CPL_TX_TNL_LSO_IPV6OUT_M)
 #define CPL_TX_TNL_LSO_IPV6OUT_F        CPL_TX_TNL_LSO_IPV6OUT_V(1U)
 
-#define CPL_TX_TNL_LSO_ETHHDRLEN_S	16
-#define CPL_TX_TNL_LSO_ETHHDRLEN_M	0xf
-#define CPL_TX_TNL_LSO_ETHHDRLEN_V(x)	((x) << CPL_TX_TNL_LSO_ETHHDRLEN_S)
-#define CPL_TX_TNL_LSO_ETHHDRLEN_G(x)	\
+#define CPL_TX_TNL_LSO_ETHHDRLEN_S     16
+#define CPL_TX_TNL_LSO_ETHHDRLEN_M     0xf
+#define CPL_TX_TNL_LSO_ETHHDRLEN_V(x)  ((x) << CPL_TX_TNL_LSO_ETHHDRLEN_S)
+#define CPL_TX_TNL_LSO_ETHHDRLEN_G(x)  \
 	(((x) >> CPL_TX_TNL_LSO_ETHHDRLEN_S) & CPL_TX_TNL_LSO_ETHHDRLEN_M)
 
 #define CPL_TX_TNL_LSO_IPHDRLEN_S	4
@@ -1719,12 +1814,6 @@ struct cpl_tx_tnl_lso {
 #define CPL_TX_TNL_LSO_TNLTYPE_G(x)	\
 	(((x) >> CPL_TX_TNL_LSO_TNLTYPE_S) & CPL_TX_TNL_LSO_TNLTYPE_M)
 
-#define S_CPL_TX_TNL_LSO_ETHHDRLEN	16
-#define M_CPL_TX_TNL_LSO_ETHHDRLEN	0xf
-#define V_CPL_TX_TNL_LSO_ETHHDRLEN(x)	((x) << S_CPL_TX_TNL_LSO_ETHHDRLEN)
-#define G_CPL_TX_TNL_LSO_ETHHDRLEN(x)	\
-	(((x) >> S_CPL_TX_TNL_LSO_ETHHDRLEN) & M_CPL_TX_TNL_LSO_ETHHDRLEN)
-
 #define CPL_TX_TNL_LSO_TNLHDRLEN_S      0
 #define CPL_TX_TNL_LSO_TNLHDRLEN_M      0xfff
 #define CPL_TX_TNL_LSO_TNLHDRLEN_V(x)	((x) << CPL_TX_TNL_LSO_TNLHDRLEN_S)
diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_pci_id_tbl.h b/drivers/net/ethernet/chelsio/cxgb4/t4_pci_id_tbl.h
index 0b1b5f9c67d4..d0921b76049d 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_pci_id_tbl.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_pci_id_tbl.h
@@ -220,6 +220,27 @@ CH_PCI_DEVICE_ID_TABLE_DEFINE_BEGIN
 	CH_PCI_ID_TABLE_FENTRY(0x608a), /* Custom T62100-CR */
 	CH_PCI_ID_TABLE_FENTRY(0x608b), /* Custom T6225-CR */
 	CH_PCI_ID_TABLE_FENTRY(0x6092), /* Custom T62100-CR-LOM */
+
+	/* T7 adapter */
+	CH_PCI_ID_TABLE_FENTRY(0x7000), /* T7-DBG */
+	CH_PCI_ID_TABLE_FENTRY(0x7001), /* T7250 */
+	CH_PCI_ID_TABLE_FENTRY(0x7002), /* S7250 */
+	CH_PCI_ID_TABLE_FENTRY(0x7003), /* T7450 */
+	CH_PCI_ID_TABLE_FENTRY(0x7004), /* S7450 */
+	CH_PCI_ID_TABLE_FENTRY(0x7005), /* T72200 */
+	CH_PCI_ID_TABLE_FENTRY(0x7006), /* S72200 */
+	CH_PCI_ID_TABLE_FENTRY(0x7007), /* T72200-FH */
+	CH_PCI_ID_TABLE_FENTRY(0x7008), /* T71400 */
+	CH_PCI_ID_TABLE_FENTRY(0x7009), /* S7210-BT */
+	CH_PCI_ID_TABLE_FENTRY(0x700a), /* T7450-RC */
+	CH_PCI_ID_TABLE_FENTRY(0x700b), /* T72200-RC */
+	CH_PCI_ID_TABLE_FENTRY(0x700c), /* T72200-FH-RC */
+	CH_PCI_ID_TABLE_FENTRY(0x700d), /* S72200-OCP3 */
+	CH_PCI_ID_TABLE_FENTRY(0x700e), /* S7450-OCP3 */
+	CH_PCI_ID_TABLE_FENTRY(0x700f), /* S7410-BT-OCP3 */
+	CH_PCI_ID_TABLE_FENTRY(0x7010), /* S7210-BT-A */
+	CH_PCI_ID_TABLE_FENTRY(0x7011), /* T7_MAYRA_7 */
+	CH_PCI_ID_TABLE_FENTRY(0x7012), /* T7-iNIC */
 CH_PCI_DEVICE_ID_TABLE_DEFINE_END;
 
 #endif /* __T4_PCI_ID_TBL_H__ */
diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4fw_api.h b/drivers/net/ethernet/chelsio/cxgb4/t4fw_api.h
index 2419459a0b85..e4fb8999daf1 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4fw_api.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4fw_api.h
@@ -35,6 +35,8 @@
 #ifndef _T4FW_INTERFACE_H_
 #define _T4FW_INTERFACE_H_
 
+#include <linux/if_ether.h>
+
 enum fw_retval {
 	FW_SUCCESS		= 0,	/* completed successfully */
 	FW_EPERM		= 1,	/* operation not permitted */
@@ -434,6 +436,13 @@ struct fw_filter2_wr {
 #define FW_FILTER_WR_RX_RPL_IQ_G(x)     \
 	(((x) >> FW_FILTER_WR_RX_RPL_IQ_S) & FW_FILTER_WR_RX_RPL_IQ_M)
 
+#define FW_FILTER2_WR_SWAPMAC_S	 0
+#define FW_FILTER2_WR_SWAPMAC_M	 0x1
+#define FW_FILTER2_WR_SWAPMAC_V(x)      ((x) << FW_FILTER2_WR_SWAPMAC_S)
+#define FW_FILTER2_WR_SWAPMAC_G(x) \
+	(((x) >> FW_FILTER2_WR_SWAPMAC_S) & FW_FILTER2_WR_SWAPMAC_M)
+#define FW_FILTER2_WR_SWAPMAC_F	 FW_FILTER2_WR_SWAPMAC_V(1U)
+
 #define FW_FILTER2_WR_FILTER_TYPE_S	1
 #define FW_FILTER2_WR_FILTER_TYPE_M	0x1
 #define FW_FILTER2_WR_FILTER_TYPE_V(x)	((x) << FW_FILTER2_WR_FILTER_TYPE_S)
@@ -460,6 +469,13 @@ struct fw_filter2_wr {
 #define FW_FILTER2_WR_ULP_TYPE_G(x)     \
 	(((x) >> FW_FILTER2_WR_ULP_TYPE_S) & FW_FILTER2_WR_ULP_TYPE_M)
 
+#define FW_FILTER2_WR_TX_LOOP_S	 29
+#define FW_FILTER2_WR_TX_LOOP_M	 0x1
+#define FW_FILTER2_WR_TX_LOOP_V(x)      ((x) << FW_FILTER2_WR_TX_LOOP_S)
+#define FW_FILTER2_WR_TX_LOOP_G(x)      \
+	    (((x) >> FW_FILTER2_WR_TX_LOOP_S) & FW_FILTER2_WR_TX_LOOP_M)
+#define FW_FILTER2_WR_TX_LOOP_F	 FW_FILTER2_WR_TX_LOOP_V(1U)
+
 #define FW_FILTER_WR_MACI_S     23
 #define FW_FILTER_WR_MACI_M     0x1ff
 #define FW_FILTER_WR_MACI_V(x)  ((x) << FW_FILTER_WR_MACI_S)
@@ -1882,6 +1898,12 @@ struct fw_eq_eth_cmd {
 #define FW_EQ_ETH_CMD_EQSTOP_V(x)	((x) << FW_EQ_ETH_CMD_EQSTOP_S)
 #define FW_EQ_ETH_CMD_EQSTOP_F	FW_EQ_ETH_CMD_EQSTOP_V(1U)
 
+#define FW_EQ_ETH_CMD_COREGROUP_S      16
+#define FW_EQ_ETH_CMD_COREGROUP_M      0x3f
+#define FW_EQ_ETH_CMD_COREGROUP_V(x)   ((x) << FW_EQ_ETH_CMD_COREGROUP_S)
+#define FW_EQ_ETH_CMD_COREGROUP_G(x) \
+	(((x) >> FW_EQ_ETH_CMD_COREGROUP_S) & FW_EQ_ETH_CMD_COREGROUP_M)
+
 #define FW_EQ_ETH_CMD_EQID_S	0
 #define FW_EQ_ETH_CMD_EQID_M	0xfffff
 #define FW_EQ_ETH_CMD_EQID_V(x)	((x) << FW_EQ_ETH_CMD_EQID_S)
@@ -2010,6 +2032,12 @@ struct fw_eq_ctrl_cmd {
 #define FW_EQ_CTRL_CMD_CMPLIQID_S	20
 #define FW_EQ_CTRL_CMD_CMPLIQID_V(x)	((x) << FW_EQ_CTRL_CMD_CMPLIQID_S)
 
+#define FW_EQ_CTRL_CMD_COREGROUP_S     16
+#define FW_EQ_CTRL_CMD_COREGROUP_M     0x3f
+#define FW_EQ_CTRL_CMD_COREGROUP_V(x)  ((x) << FW_EQ_CTRL_CMD_COREGROUP_S)
+#define FW_EQ_CTRL_CMD_COREGROUP_G(x) \
+	(((x) >> FW_EQ_CTRL_CMD_COREGROUP_S) & FW_EQ_CTRL_CMD_COREGROUP_M)
+
 #define FW_EQ_CTRL_CMD_EQID_S		0
 #define FW_EQ_CTRL_CMD_EQID_M		0xfffff
 #define FW_EQ_CTRL_CMD_EQID_V(x)	((x) << FW_EQ_CTRL_CMD_EQID_S)
@@ -2597,7 +2625,7 @@ struct fw_acl_vlan_cmd {
 #define FW_ACL_VLAN_CMD_EN_M		0x1
 #define FW_ACL_VLAN_CMD_EN_V(x)		((x) << FW_ACL_VLAN_CMD_EN_S)
 #define FW_ACL_VLAN_CMD_EN_G(x)         \
-	(((x) >> S_FW_ACL_VLAN_CMD_EN_S) & FW_ACL_VLAN_CMD_EN_M)
+	(((x) >> FW_ACL_VLAN_CMD_EN_S_S) & FW_ACL_VLAN_CMD_EN_M)
 #define FW_ACL_VLAN_CMD_EN_F            FW_ACL_VLAN_CMD_EN_V(1U)
 
 #define FW_ACL_VLAN_CMD_DROPNOVLAN_S	7
@@ -3107,8 +3135,26 @@ enum fw_port_type {
 	FW_PORT_TYPE_SFP28,
 	FW_PORT_TYPE_KR_SFP28,
 	FW_PORT_TYPE_KR_XLAUI,
-
-	FW_PORT_TYPE_NONE = FW_PORT_CMD_PTYPE_M
+	/* Applicable on T7 */
+	FW_PORT_TYPE_BARE_LINK_50G    = 23,   /* No, 1, 50G */
+	FW_PORT_TYPE_BARE_LINK_100G   = 24,   /* No, 2, 100G/50G */
+	FW_PORT_TYPE_BARE_LINK_200G   = 25,   /* No, 4, 200G/100G/50G */
+	FW_PORT_TYPE_SFP56	      = 26,   /* No, 1, 50G/25G */
+	FW_PORT_TYPE_QSFP56	      = 27,   /* No, 4, 200G/100G/50G/25G */
+	FW_PORT_TYPE_QSFP56_4_50G     = 28,   /* No, 1, 50G */
+	FW_PORT_TYPE_KR_50G	      = 29,   /* No, 1, 50G */
+	FW_PORT_TYPE_KR2_100G	      = 30,   /* No, 2, 100G/50G */
+	FW_PORT_TYPE_KR4_200G	      = 31,   /* No, 4, 200G/100G/50G */
+	FW_PORT_TYPE_QSFP56_2_50G     = 32,   /* No, 1, 50G */
+	FW_PORT_TYPE_OSFP	      = 33,   /* No, 8, 400G/200G/100G/50G */
+	FW_PORT_TYPE_QSFPDD	      = 34,   /* No, 8, 400G/200G/100G/50G  */
+	FW_PORT_TYPE_OSFP_2_200G      = 35,   /* No, 4, 200G/100G/50G */
+	FW_PORT_TYPE_QSFP_4_100G      = 36,   /* No, 2, 100G/50G */
+	FW_PORT_TYPE_QSFPDD_2_200G    = 37,   /* No, 4, 200G/100G/50G */
+	FW_PORT_TYPE_KR8_400G	      = 38,   /* No, 8, 400G/200G/100G/50G? */
+	FW_PORT_TYPE_MAX,
+
+	FW_PORT_TYPE_NONE = FW_PORT_CMD_PORTTYPE32_M
 };
 
 enum fw_port_module_type {
@@ -3119,6 +3165,7 @@ enum fw_port_module_type {
 	FW_PORT_MOD_TYPE_TWINAX_PASSIVE,
 	FW_PORT_MOD_TYPE_TWINAX_ACTIVE,
 	FW_PORT_MOD_TYPE_LRM,
+	FW_PORT_MOD_TYPE_DR,
 	FW_PORT_MOD_TYPE_ERROR		= FW_PORT_CMD_MODTYPE_M - 3,
 	FW_PORT_MOD_TYPE_UNKNOWN	= FW_PORT_CMD_MODTYPE_M - 2,
 	FW_PORT_MOD_TYPE_NOTSUPPORTED	= FW_PORT_CMD_MODTYPE_M - 1,
@@ -3770,13 +3817,17 @@ struct fw_hdr {
 	__u32   reserved3;
 	__u32   reserved4;
 	__be32  flags;
-	__be32  reserved6[23];
+	__be32  reserved6[4];
+	__u8    reserved7[3];
+	__u8    dsign_len;
+	__u8    dsign[72];	      /* fw binary digital signature */
 };
 
 enum fw_hdr_chip {
 	FW_HDR_CHIP_T4,
 	FW_HDR_CHIP_T5,
-	FW_HDR_CHIP_T6
+	FW_HDR_CHIP_T6,
+	FW_HDR_CHIP_T7
 };
 
 #define FW_HDR_FW_VER_MAJOR_S	24
@@ -3888,7 +3939,9 @@ struct fw_devlog_cmd {
 	__u8   r2[7];
 	__be32 memtype_devlog_memaddr16_devlog;
 	__be32 memsize_devlog;
-	__be32 r3[2];
+	__u8   num_devlog;
+	__u8   r3[3];
+	__be32 r4;
 };
 
 #define FW_DEVLOG_CMD_MEMTYPE_DEVLOG_S		28
@@ -3915,8 +3968,14 @@ struct fw_devlog_cmd {
  */
 #define PCIE_FW_PF_DEVLOG		7
 
+#define PCIE_FW_PF_DEVLOG_COUNT_MSB_S  31
+#define PCIE_FW_PF_DEVLOG_COUNT_MSB_M  0x1
+#define PCIE_FW_PF_DEVLOG_COUNT_MSB_V(x) ((x) << PCIE_FW_PF_DEVLOG_COUNT_MSB_S)
+#define PCIE_FW_PF_DEVLOG_COUNT_MSB_G(x) \
+	(((x) >> PCIE_FW_PF_DEVLOG_COUNT_MSB_S) & PCIE_FW_PF_DEVLOG_COUNT_MSB_M)
+
 #define PCIE_FW_PF_DEVLOG_NENTRIES128_S	28
-#define PCIE_FW_PF_DEVLOG_NENTRIES128_M	0xf
+#define PCIE_FW_PF_DEVLOG_NENTRIES128_M	0x7
 #define PCIE_FW_PF_DEVLOG_NENTRIES128_V(x) \
 	((x) << PCIE_FW_PF_DEVLOG_NENTRIES128_S)
 #define PCIE_FW_PF_DEVLOG_NENTRIES128_G(x) \
@@ -3929,8 +3988,15 @@ struct fw_devlog_cmd {
 #define PCIE_FW_PF_DEVLOG_ADDR16_G(x) \
 	(((x) >> PCIE_FW_PF_DEVLOG_ADDR16_S) & PCIE_FW_PF_DEVLOG_ADDR16_M)
 
+#define PCIE_FW_PF_DEVLOG_COUNT_LSB_S  3
+#define PCIE_FW_PF_DEVLOG_COUNT_LSB_M  0x1
+#define PCIE_FW_PF_DEVLOG_COUNT_LSB_V(x) \
+	((x) << PCIE_FW_PF_DEVLOG_COUNT_LSB_S)
+#define PCIE_FW_PF_DEVLOG_COUNT_LSB_G(x) \
+	(((x) >> PCIE_FW_PF_DEVLOG_COUNT_LSB_S) & PCIE_FW_PF_DEVLOG_COUNT_LSB_M)
+
 #define PCIE_FW_PF_DEVLOG_MEMTYPE_S	0
-#define PCIE_FW_PF_DEVLOG_MEMTYPE_M	0xf
+#define PCIE_FW_PF_DEVLOG_MEMTYPE_M	0x7
 #define PCIE_FW_PF_DEVLOG_MEMTYPE_V(x)	((x) << PCIE_FW_PF_DEVLOG_MEMTYPE_S)
 #define PCIE_FW_PF_DEVLOG_MEMTYPE_G(x) \
 	(((x) >> PCIE_FW_PF_DEVLOG_MEMTYPE_S) & PCIE_FW_PF_DEVLOG_MEMTYPE_M)
diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4fw_version.h b/drivers/net/ethernet/chelsio/cxgb4/t4fw_version.h
index a02b1dff403e..d19979c8bfc0 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4fw_version.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4fw_version.h
@@ -61,4 +61,13 @@
 #define T6FW_MIN_VERSION_MAJOR 0x00
 #define T6FW_MIN_VERSION_MINOR 0x00
 #define T6FW_MIN_VERSION_MICRO 0x00
+
+#define T7FW_VERSION_MAJOR 0x01
+#define T7FW_VERSION_MINOR 0x19
+#define T7FW_VERSION_MICRO 0x01
+#define T7FW_VERSION_BUILD 0x1B
+
+#define T7FW_MIN_VERSION_MAJOR 0x00
+#define T7FW_MIN_VERSION_MINOR 0x00
+#define T7FW_MIN_VERSION_MICRO 0x00
 #endif
-- 
2.39.1


