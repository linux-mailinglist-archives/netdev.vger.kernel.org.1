Return-Path: <netdev+bounces-300021-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l0GUK0onMmokvwUAu9opvQ
	(envelope-from <netdev+bounces-300021-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 06:49:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 423BE6967DE
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 06:49:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300021-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300021-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BCEF311E29D
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 04:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CD9326942;
	Wed, 17 Jun 2026 04:47:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-124.mail.aliyun.com (out28-124.mail.aliyun.com [115.124.28.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9065431D372;
	Wed, 17 Jun 2026 04:47:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781671639; cv=none; b=P31dSlbBd5G/haUpH9wFhTZsFsfQhb96qIEAryv+4kfY2vqUX//LT38lHz/sDGaFztaPDOUO41XElMrplsX45YL7lCLqk9TBYqHUFsKj9QKcRposUh3ontBXlAd6/yQjQOrE29YPqzIyYQMWp1U5on9y1fOM+Zip2TXm/O0hQfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781671639; c=relaxed/simple;
	bh=DqWIaSzY6ahMB/M7dCs/QmvdpO/LdbGljq41Itd+5IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ABvadLxiqFb/FHEiKyv6/8Rve0xkFRvTL/jjw1p3+y/hvE7ixkh0FBAOr3FpEEXWXTfTLM5jokek5TzF+OD6efJZRP7FslmOTLatg24FitqdOGJCTg/pvzxGmnhR1YRGwfi+KzfCtpjnCEkAC0FlV4feEnNmYD2b2y9/RGKGwaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.124
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0733225-0.0166933-0.909984;FP=18048297645189366516|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033037025160;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.i-FkB62_1781671630;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.i-FkB62_1781671630 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 17 Jun 2026 12:47:11 +0800
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
Subject: [PATCH v19 net-next 04/11] net/nebula-matrix: channel msg value and msg struct
Date: Wed, 17 Jun 2026 12:46:49 +0800
Message-ID: <20260617044702.2439-5-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260617044702.2439-1-illusion.wang@nebula-matrix.com>
References: <20260617044702.2439-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-300021-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[illusion.wang@nebula-matrix.com,netdev@vger.kernel.org];
	DMARC_NA(0.00)[nebula-matrix.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[lunn.ch,lwn.net,kernel.org,vger.kernel.org,redhat.com,linux.dev,google.com,gmail.com,linuxfoundation.org];
	FORGED_RECIPIENTS(0.00)[m:dimon.zhao@nebula-matrix.com,m:illusion.wang@nebula-matrix.com,m:alvin.wang@nebula-matrix.com,m:sam.chen@nebula-matrix.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:corbet@lwn.net,m:kuba@kernel.org,m:horms@kernel.org,m:linux-doc@vger.kernel.org,m:pabeni@redhat.com,m:vadim.fedorenko@linux.dev,m:lukas.bulwahn@redhat.com,m:edumazet@google.com,m:enelsonmoore@gmail.com,m:skhan@linuxfoundation.org,m:hkallweit1@gmail.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[illusion.wang@nebula-matrix.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,illusion.wang:url,nebula-matrix.com:email,nebula-matrix.com:mid,nebula-matrix.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 423BE6967DE

The msg ID values are derived from enum ordinal and serve as wire
opcodes. The set is stable and must not be reordered or extended
without a wire-format change.

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
---
 .../nbl/nbl_include/nbl_def_channel.h         | 225 ++++++++++++++++++
 1 file changed, 225 insertions(+)

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
index ff03a53b9f5d..32e870ad2554 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
@@ -6,8 +6,233 @@
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
+	NBL_CHAN_MSG_MAILBOX_SET_IRQ,
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
 enum nbl_channel_type {
 	NBL_CHAN_TYPE_MAILBOX,
 	NBL_CHAN_TYPE_MAX
-- 
2.47.3


