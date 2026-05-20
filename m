Return-Path: <netdev+bounces-289754-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIROJj0sDWqYuAUAu9opvQ
	(envelope-from <netdev+bounces-289754-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 05:36:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5233A587509
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 05:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ADEDA300FB71
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 03:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF6136A358;
	Wed, 20 May 2026 03:35:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-99.mail.aliyun.com (out28-99.mail.aliyun.com [115.124.28.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B80367B91;
	Wed, 20 May 2026 03:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779248133; cv=none; b=KLor7bh/fWfTKacXz9TDcKA4aNkWnc127gocjqy9E+Xr2R/FZJ46j0vyRbSCoocnePjpsEMp+swJkBl2bW5H472mKqbPl+7PSC/VGaLjCv8ktvui3/wPdg74sPg6cTrd0BcGafnxLzBuYFEGOp2Dubd5I3vCAhdceyQPhQB21Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779248133; c=relaxed/simple;
	bh=GcPkJta3vQ2UoCEwbkp/tlxLXBOPPLEfbjE1ivUC1p8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Htt21ZYs1waRYDFvFFiQ16buB71RdHJGhj+4AqJtO9h9bIpnOq3p6r/1CQyHBvQm1LcPiOA5V1gEIv8uShziGL21Ur5TCfVW/nQj/tyMoz/CcQZitcN916b8nb8xiYxT1W5d6fTJ+pBCOwMN6NaJpzHximJBHik4HsTLnclniOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.171681-0.0173666-0.810952;FP=17472118401974928308|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032053168;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.hbYx4-P_1779247798;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.hbYx4-P_1779247798 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 20 May 2026 11:29:59 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	corbet@lwn.net,
	kuba@kernel.org,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	enelsonmoore@gmail.com,
	skhan@linuxfoundation.org,
	hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v15 net-next 04/11] net/nebula-matrix: channel msg value and msg struct
Date: Wed, 20 May 2026 11:29:36 +0800
Message-ID: <20260520032950.4874-5-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520032950.4874-1-illusion.wang@nebula-matrix.com>
References: <20260520032950.4874-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289754-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[nebula-matrix.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,lwn.net,kernel.org,vger.kernel.org,redhat.com,linux.dev,google.com,gmail.com,linuxfoundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FROM_NEQ_ENVFROM(0.00)[illusion.wang@nebula-matrix.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[18];
	DBL_BLOCKED_OPENRESOLVER(0.00)[illusion.wang:url,nebula-matrix.com:mid,nebula-matrix.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5233A587509
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch introduces the channel message ID enumeration and several
message parameter structures for the nebula-matrix driver.

To ensure compatibility, the msg ID values are fixed, and fields can
only be appended to existing structures, not removed. Additionally,
any newly added fields must be placed on new Data Words (DWs) to
maintain alignment and compatibility. For array-type fields,
the length of individual array members cannot be changed once defined.

When modifying request structures, if a new field is added, the
corresponding response function must define a new stack variable
of the updated request message structure. The newly added fields
should be initialized to invalid values, and a minimal copy of the
original data should be performed to preserve compatibility with
existing implementations.

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
---
 .../nbl/nbl_include/nbl_def_channel.h         | 251 ++++++++++++++++++
 1 file changed, 251 insertions(+)

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
index ff03a53b9f5d..88470f15c619 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
@@ -6,8 +6,259 @@
 #ifndef _NBL_DEF_CHANNEL_H_
 #define _NBL_DEF_CHANNEL_H_
 
+#include <linux/types.h>
+
 struct nbl_channel_mgt;
 struct nbl_adapter;
+enum nbl_chan_msg_type {
+	NBL_CHAN_MSG_ACK,
+	NBL_CHAN_MSG_ADD_MACVLAN,
+	NBL_CHAN_MSG_DEL_MACVLAN,
+	NBL_CHAN_MSG_ADD_MULTI_RULE,
+	NBL_CHAN_MSG_DEL_MULTI_RULE,
+	NBL_CHAN_MSG_SETUP_MULTI_GROUP,
+	NBL_CHAN_MSG_REMOVE_MULTI_GROUP,
+	NBL_CHAN_MSG_REGISTER_NET,
+	NBL_CHAN_MSG_UNREGISTER_NET,
+	NBL_CHAN_MSG_ALLOC_TXRX_QUEUES,
+	NBL_CHAN_MSG_FREE_TXRX_QUEUES,
+	NBL_CHAN_MSG_SETUP_QUEUE,
+	NBL_CHAN_MSG_REMOVE_ALL_QUEUES,
+	NBL_CHAN_MSG_CFG_DSCH,
+	NBL_CHAN_MSG_SETUP_CQS,
+	NBL_CHAN_MSG_REMOVE_CQS,
+	NBL_CHAN_MSG_CFG_QDISC_MQPRIO,
+	NBL_CHAN_MSG_CONFIGURE_MSIX_MAP,
+	NBL_CHAN_MSG_DESTROY_MSIX_MAP,
+	NBL_CHAN_MSG_MAILBOX_ENABLE_IRQ,
+	NBL_CHAN_MSG_GET_GLOBAL_VECTOR,
+	NBL_CHAN_MSG_GET_VSI_ID,
+	NBL_CHAN_MSG_SET_PROMISC_MODE,
+	NBL_CHAN_MSG_GET_FIRMWARE_VERSION,
+	NBL_CHAN_MSG_GET_QUEUE_ERR_STATS,
+	NBL_CHAN_MSG_GET_COALESCE,
+	NBL_CHAN_MSG_SET_COALESCE,
+	NBL_CHAN_MSG_SET_SPOOF_CHECK_ADDR,
+	NBL_CHAN_MSG_SET_VF_SPOOF_CHECK,
+	NBL_CHAN_MSG_GET_RXFH_INDIR_SIZE,
+	NBL_CHAN_MSG_GET_RXFH_INDIR,
+	NBL_CHAN_MSG_GET_RXFH_RSS_KEY,
+	NBL_CHAN_MSG_GET_RXFH_RSS_ALG_SEL,
+	NBL_CHAN_MSG_GET_HW_CAPS,
+	NBL_CHAN_MSG_GET_HW_STATE,
+	NBL_CHAN_MSG_REGISTER_RDMA,
+	NBL_CHAN_MSG_UNREGISTER_RDMA,
+	NBL_CHAN_MSG_GET_REAL_HW_ADDR,
+	NBL_CHAN_MSG_GET_REAL_BDF,
+	NBL_CHAN_MSG_GRC_PROCESS,
+	NBL_CHAN_MSG_SET_SFP_STATE,
+	NBL_CHAN_MSG_SET_ETH_LOOPBACK,
+	NBL_CHAN_MSG_CHECK_ACTIVE_VF,
+	NBL_CHAN_MSG_GET_PRODUCT_FLEX_CAP,
+	NBL_CHAN_MSG_ALLOC_KTLS_TX_INDEX,
+	NBL_CHAN_MSG_FREE_KTLS_TX_INDEX,
+	NBL_CHAN_MSG_CFG_KTLS_TX_KEYMAT,
+	NBL_CHAN_MSG_ALLOC_KTLS_RX_INDEX,
+	NBL_CHAN_MSG_FREE_KTLS_RX_INDEX,
+	NBL_CHAN_MSG_CFG_KTLS_RX_KEYMAT,
+	NBL_CHAN_MSG_CFG_KTLS_RX_RECORD,
+	NBL_CHAN_MSG_ADD_KTLS_RX_FLOW,
+	NBL_CHAN_MSG_DEL_KTLS_RX_FLOW,
+	NBL_CHAN_MSG_ALLOC_IPSEC_TX_INDEX,
+	NBL_CHAN_MSG_FREE_IPSEC_TX_INDEX,
+	NBL_CHAN_MSG_ALLOC_IPSEC_RX_INDEX,
+	NBL_CHAN_MSG_FREE_IPSEC_RX_INDEX,
+	NBL_CHAN_MSG_CFG_IPSEC_TX_SAD,
+	NBL_CHAN_MSG_CFG_IPSEC_RX_SAD,
+	NBL_CHAN_MSG_ADD_IPSEC_TX_FLOW,
+	NBL_CHAN_MSG_DEL_IPSEC_TX_FLOW,
+	NBL_CHAN_MSG_ADD_IPSEC_RX_FLOW,
+	NBL_CHAN_MSG_DEL_IPSEC_RX_FLOW,
+	NBL_CHAN_MSG_NOTIFY_IPSEC_HARD_EXPIRE,
+	NBL_CHAN_MSG_GET_MBX_IRQ_NUM,
+	NBL_CHAN_MSG_CLEAR_FLOW,
+	NBL_CHAN_MSG_CLEAR_QUEUE,
+	NBL_CHAN_MSG_GET_ETH_ID,
+	NBL_CHAN_MSG_SET_OFFLOAD_STATUS,
+	NBL_CHAN_MSG_INIT_OFLD,
+	NBL_CHAN_MSG_INIT_CMDQ,
+	NBL_CHAN_MSG_DESTROY_CMDQ,
+	NBL_CHAN_MSG_RESET_CMDQ,
+	NBL_CHAN_MSG_INIT_FLOW,
+	NBL_CHAN_MSG_DEINIT_FLOW,
+	NBL_CHAN_MSG_OFFLOAD_FLOW_RULE,
+	NBL_CHAN_MSG_GET_ACL_SWITCH,
+	NBL_CHAN_MSG_GET_VSI_GLOBAL_QUEUE_ID,
+	NBL_CHAN_MSG_INIT_REP,
+	NBL_CHAN_MSG_GET_LINE_RATE_INFO,
+	NBL_CHAN_MSG_REGISTER_NET_REP,
+	NBL_CHAN_MSG_UNREGISTER_NET_REP,
+	NBL_CHAN_MSG_REGISTER_ETH_REP,
+	NBL_CHAN_MSG_UNREGISTER_ETH_REP,
+	NBL_CHAN_MSG_REGISTER_UPCALL_PORT,
+	NBL_CHAN_MSG_UNREGISTER_UPCALL_PORT,
+	NBL_CHAN_MSG_GET_PORT_STATE,
+	NBL_CHAN_MSG_SET_PORT_ADVERTISING,
+	NBL_CHAN_MSG_GET_MODULE_INFO,
+	NBL_CHAN_MSG_GET_MODULE_EEPROM,
+	NBL_CHAN_MSG_GET_LINK_STATE,
+	NBL_CHAN_MSG_NOTIFY_LINK_STATE,
+	NBL_CHAN_MSG_GET_QUEUE_CXT,
+	NBL_CHAN_MSG_CFG_LOG,
+	NBL_CHAN_MSG_INIT_VDPAQ,
+	NBL_CHAN_MSG_DESTROY_VDPAQ,
+	NBL_CHAN_MSG_GET_UPCALL_PORT,
+	NBL_CHAN_MSG_NOTIFY_ETH_REP_LINK_STATE,
+	NBL_CHAN_MSG_SET_ETH_MAC_ADDR,
+	NBL_CHAN_MSG_GET_FUNCTION_ID,
+	NBL_CHAN_MSG_GET_CHIP_TEMPERATURE,
+	NBL_CHAN_MSG_DISABLE_HW_FLOW,
+	NBL_CHAN_MSG_ENABLE_HW_FLOW,
+	NBL_CHAN_MSG_SET_UPCALL_RULE,
+	NBL_CHAN_MSG_UNSET_UPCALL_RULE,
+	NBL_CHAN_MSG_GET_REG_DUMP,
+	NBL_CHAN_MSG_GET_REG_DUMP_LEN,
+	NBL_CHAN_MSG_CFG_LAG_HASH_ALGORITHM,
+	NBL_CHAN_MSG_CFG_LAG_MEMBER_FWD,
+	NBL_CHAN_MSG_CFG_LAG_MEMBER_LIST,
+	NBL_CHAN_MSG_CFG_LAG_MEMBER_UP_ATTR,
+	NBL_CHAN_MSG_ADD_LAG_FLOW,
+	NBL_CHAN_MSG_DEL_LAG_FLOW,
+	NBL_CHAN_MSG_SWITCHDEV_INIT_CMDQ,
+	NBL_CHAN_MSG_SWITCHDEV_DEINIT_CMDQ,
+	NBL_CHAN_MSG_SET_TC_FLOW_INFO,
+	NBL_CHAN_MSG_UNSET_TC_FLOW_INFO,
+	NBL_CHAN_MSG_INIT_ACL,
+	NBL_CHAN_MSG_UNINIT_ACL,
+	NBL_CHAN_MSG_CFG_LAG_MCC,
+	NBL_CHAN_MSG_REGISTER_VSI2Q,
+	NBL_CHAN_MSG_SETUP_Q2VSI,
+	NBL_CHAN_MSG_REMOVE_Q2VSI,
+	NBL_CHAN_MSG_SETUP_RSS,
+	NBL_CHAN_MSG_REMOVE_RSS,
+	NBL_CHAN_MSG_GET_REP_QUEUE_INFO,
+	NBL_CHAN_MSG_CTRL_PORT_LED,
+	NBL_CHAN_MSG_NWAY_RESET,
+	NBL_CHAN_MSG_SET_INTL_SUPPRESS_LEVEL,
+	NBL_CHAN_MSG_GET_ETH_STATS,
+	NBL_CHAN_MSG_GET_MODULE_TEMPERATURE,
+	NBL_CHAN_MSG_GET_BOARD_INFO,
+	NBL_CHAN_MSG_GET_P4_USED,
+	NBL_CHAN_MSG_GET_VF_BASE_VSI_ID,
+	NBL_CHAN_MSG_ADD_LLDP_FLOW,
+	NBL_CHAN_MSG_DEL_LLDP_FLOW,
+	NBL_CHAN_MSG_CFG_ETH_BOND_INFO,
+	NBL_CHAN_MSG_CFG_DUPPKT_MCC,
+	NBL_CHAN_MSG_ADD_ND_UPCALL_FLOW,
+	NBL_CHAN_MSG_DEL_ND_UPCALL_FLOW,
+	NBL_CHAN_MSG_GET_BOARD_ID,
+	NBL_CHAN_MSG_SET_SHAPING_DPORT_VLD,
+	NBL_CHAN_MSG_SET_DPORT_FC_TH_VLD,
+	NBL_CHAN_MSG_REGISTER_RDMA_BOND,
+	NBL_CHAN_MSG_UNREGISTER_RDMA_BOND,
+	NBL_CHAN_MSG_RESTORE_NETDEV_QUEUE,
+	NBL_CHAN_MSG_RESTART_NETDEV_QUEUE,
+	NBL_CHAN_MSG_RESTORE_HW_QUEUE,
+	NBL_CHAN_MSG_KEEP_ALIVE,
+	NBL_CHAN_MSG_GET_BASE_MAC_ADDR,
+	NBL_CHAN_MSG_CFG_BOND_SHAPING,
+	NBL_CHAN_MSG_CFG_BGID_BACK_PRESSURE,
+	NBL_CHAN_MSG_ALLOC_KT_BLOCK,
+	NBL_CHAN_MSG_FREE_KT_BLOCK,
+	NBL_CHAN_MSG_GET_USER_QUEUE_INFO,
+	NBL_CHAN_MSG_GET_ETH_BOND_INFO,
+	NBL_CHAN_MSG_CLEAR_ACCEL_FLOW,
+	NBL_CHAN_MSG_SET_BRIDGE_MODE,
+	NBL_CHAN_MSG_GET_VF_FUNCTION_ID,
+	NBL_CHAN_MSG_NOTIFY_LINK_FORCED,
+	NBL_CHAN_MSG_SET_PMD_DEBUG,
+	NBL_CHAN_MSG_REGISTER_FUNC_MAC,
+	NBL_CHAN_MSG_SET_TX_RATE,
+	NBL_CHAN_MSG_REGISTER_FUNC_LINK_FORCED,
+	NBL_CHAN_MSG_GET_LINK_FORCED,
+	NBL_CHAN_MSG_REGISTER_FUNC_VLAN,
+	NBL_CHAN_MSG_GET_FD_FLOW,
+	NBL_CHAN_MSG_GET_FD_FLOW_CNT,
+	NBL_CHAN_MSG_GET_FD_FLOW_ALL,
+	NBL_CHAN_MSG_GET_FD_FLOW_MAX,
+	NBL_CHAN_MSG_REPLACE_FD_FLOW,
+	NBL_CHAN_MSG_REMOVE_FD_FLOW,
+	NBL_CHAN_MSG_CFG_FD_FLOW_STATE,
+	NBL_CHAN_MSG_REGISTER_FUNC_RATE,
+	NBL_CHAN_MSG_NOTIFY_VLAN,
+	NBL_CHAN_MSG_GET_XDP_QUEUE_INFO,
+	NBL_CHAN_MSG_STOP_ABNORMAL_SW_QUEUE,
+	NBL_CHAN_MSG_STOP_ABNORMAL_HW_QUEUE,
+	NBL_CHAN_MSG_NOTIFY_RESET_EVENT,
+	NBL_CHAN_MSG_ACK_RESET_EVENT,
+	NBL_CHAN_MSG_GET_VF_VSI_ID,
+	NBL_CHAN_MSG_CONFIGURE_QOS,
+	NBL_CHAN_MSG_GET_PFC_BUFFER_SIZE,
+	NBL_CHAN_MSG_SET_PFC_BUFFER_SIZE,
+	NBL_CHAN_MSG_GET_VF_STATS,
+	NBL_CHAN_MSG_REGISTER_FUNC_TRUST,
+	NBL_CHAN_MSG_NOTIFY_TRUST,
+	NBL_CHAN_MSG_CHECK_VF_IS_ACTIVE,
+	NBL_CHAN_MSG_GET_ETH_ABNORMAL_STATS,
+	NBL_CHAN_MSG_GET_ETH_CTRL_STATS,
+	NBL_CHAN_MSG_GET_PAUSE_STATS,
+	NBL_CHAN_MSG_GET_ETH_MAC_STATS,
+	NBL_CHAN_MSG_GET_FEC_STATS,
+	NBL_CHAN_MSG_CFG_MULTI_MCAST_RULE,
+	NBL_CHAN_MSG_GET_LINK_DOWN_COUNT,
+	NBL_CHAN_MSG_GET_LINK_STATUS_OPCODE,
+	NBL_CHAN_MSG_GET_RMON_STATS,
+	NBL_CHAN_MSG_REGISTER_PF_NAME,
+	NBL_CHAN_MSG_GET_PF_NAME,
+	NBL_CHAN_MSG_CONFIGURE_RDMA_BW,
+	NBL_CHAN_MSG_SET_RATE_LIMIT,
+	NBL_CHAN_MSG_SET_TC_WGT,
+	NBL_CHAN_MSG_REMOVE_QUEUE,
+	NBL_CHAN_MSG_GET_MIRROR_TABLE_ID,
+	NBL_CHAN_MSG_CONFIGURE_MIRROR,
+	NBL_CHAN_MSG_CONFIGURE_MIRROR_TABLE,
+	NBL_CHAN_MSG_CLEAR_MIRROR_CFG,
+	NBL_CHAN_MSG_MIRROR_OUTPUTPORT_NOTIFY,
+	NBL_CHAN_MSG_CHECK_FLOWTABLE_SPEC,
+	NBL_CHAN_MSG_CHECK_VF_IS_VDPA,
+	NBL_CHAN_MSG_GET_VDPA_VF_STATS,
+	NBL_CHAN_MSG_SET_RX_RATE,
+	NBL_CHAN_MSG_GET_UVN_PKT_DROP_STATS,
+	NBL_CHAN_MSG_GET_USTORE_PKT_DROP_STATS,
+	NBL_CHAN_MSG_GET_USTORE_TOTAL_PKT_DROP_STATS,
+	NBL_CHAN_MSG_SET_WOL,
+	NBL_CHAN_MSG_INIT_VF_MSIX_MAP,
+	NBL_CHAN_MSG_GET_ST_NAME,
+	/* mailbox msg end */
+	NBL_CHAN_MSG_MAILBOX_MAX,
+};
+
+struct nbl_chan_param_cfg_msix_map {
+	__le16 num_net_msix;
+	__le16 num_others_msix;
+	__le16 msix_mask_en;
+	__le16 rsvd;
+};
+
+struct nbl_chan_param_set_mailbox_irq {
+	__le16 vector_id;
+	u8 enable_msix;
+	u8 rsvd;
+};
+
+struct nbl_chan_param_get_vsi_id {
+	__le16 vsi_id;
+	__le16 type;
+};
+
+struct nbl_chan_param_get_eth_id {
+	__le16 vsi_id;
+	u8 eth_num;
+	u8 eth_id;
+	u8 logic_eth_id;
+	u8 rsvd[3];
+};
+
 enum nbl_channel_type {
 	NBL_CHAN_TYPE_MAILBOX,
 	NBL_CHAN_TYPE_MAX
-- 
2.47.3


