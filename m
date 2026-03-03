Return-Path: <netdev+bounces-262976-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JaBNIU3pmmfMgAAu9opvQ
	(envelope-from <netdev+bounces-262976-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 02:21:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B81F21E79E8
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 02:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 26FF730240A1
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 01:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764E6367F34;
	Tue,  3 Mar 2026 01:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SpLQIlfq"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0744C366DB4
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 01:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772500866; cv=none; b=jzw8SzN6T0ARrped1Na7yMChxlNInq1IfdvkkwcIi0ryEPX+NcVUimNXtaxCHZVBJAxg/wvk8lWp2MujYcaGOPre50nXXV2ykFupzcrAT5ynNz7mN4qjtCvN6tuTg27Dxty+sYTTSME+w2BB8+ic8f1u3/14w+M7L0+FS+dbyEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772500866; c=relaxed/simple;
	bh=0Y4aT60dnAC3ZdmhvwQ7M4F3eUYTKbGUf8Me6aj/A84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BrEp57t2QeC2pcC1cG0yo8tdgKykCTiHmDDHHOtJU2uuZ/Eh9B/iUPXAWmcsBpeiYfplV70eHglbUwN4hliJJkVqVqpW11cPQqecFWR6OeEfp04IxS2VXkLl3X9+T06Fu7LJlYetqgX8Q6nY98JdtFGNKtLUxRxoO/7YRPzmclk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SpLQIlfq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=gMS2Isd4Ors9wU6b6tTzWChTGuyH90oR2jtNebewLwY=; b=SpLQIlfqwqAVXrTYCQphkixbR8
	bVphjDuddRIo8RuLrw1LG6F087LLGUHW1qHCvBDCewJDlm9qhNnQYxUGcSAIDQvta4r0VAMHc+Iwq
	Ga0slrteg/KmwYazYNPzxupQZuHhdPPy0HQXsyn+nCG3ewl5yBI/VMdyi7G0rkJ755jGjJrhaSwsn
	WifsYrWk130WsHNZsfFp2aFCQJK7rsHwpaeFMZbVLsktuLrUNlTxyYG4+WyH1es60/P+gXrnmdrDV
	hbkpCtF4Ju7d28SlClr2ifhWG46NG6AFd6uVFH32RQmL90bch4z9+xnUrymhNpcd5JOvEY/USAVLv
	UfWlDMAg==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxERR-0000000EL2l-4BTk;
	Tue, 03 Mar 2026 01:20:54 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	dev@openvswitch.org
Subject: [PATCH net-next v4] net: openvswitch: clean up some kernel-doc warnings
Date: Mon,  2 Mar 2026 17:20:52 -0800
Message-ID: <20260303012052.4065482-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B81F21E79E8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262976-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[infradead.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Fix some kernel-doc warnings in openvswitch.h:

Mark enum placeholders that are not used as "private" so that kernel-doc
comments are not needed for them.

Correct names for 2 enum values:
Warning: include/uapi/linux/openvswitch.h:300 Excess enum value
 '@OVS_VPORT_UPCALL_SUCCESS' description in 'ovs_vport_upcall_attr'
Warning: include/uapi/linux/openvswitch.h:300 Excess enum value
 '@OVS_VPORT_UPCALL_FAIL' description in 'ovs_vport_upcall_attr'

Convert one comment from "/**" kernel-doc to a plain C "/*" comment:
Warning: include/uapi/linux/openvswitch.h:638 This comment starts with
 '/**', but isn't a kernel-doc comment.
 * Omit attributes for notifications.

Add more kernel-doc:
- add kernel-doc for kernel-only enums;
- add missing kernel-doc for enum ovs_datapath_attr;
- add missing kernel-doc for enum ovs_flow_attr;
- add missing kernel-doc for enum ovs_sample_attr;
- add kernel-doc for enum ovs_check_pkt_len_attr;
- add kernel-doc for enum ovs_action_attr;
- add kernel-doc for enum ovs_action_push_eth;
- add kernel-doc for enum ovs_vport_attr;

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v4: more updates/corrections from Ilya (Thanks!);
    use "net-next" (Jakub);
v3: update descriptions based on Ilya's feedback;
v2: correct -net to net for tree destination/designation;
    add more kernel-doc for various enums;

Cc: Aaron Conole <aconole@redhat.com>
Cc: Eelco Chaudron <echaudro@redhat.com>
Cc: Ilya Maximets <i.maximets@ovn.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: dev@openvswitch.org

 include/uapi/linux/openvswitch.h |   76 +++++++++++++++++++++++++----
 1 file changed, 68 insertions(+), 8 deletions(-)

--- linux-next-20260227.orig/include/uapi/linux/openvswitch.h
+++ linux-next-20260227/include/uapi/linux/openvswitch.h
@@ -70,12 +70,15 @@ enum ovs_datapath_cmd {
  * set on the datapath port (for OVS_ACTION_ATTR_MISS).  Only valid on
  * %OVS_DP_CMD_NEW requests. A value of zero indicates that upcalls should
  * not be sent.
+ * @OVS_DP_ATTR_MASKS_CACHE_SIZE: Number of the entries in the flow table
+ * masks cache.
  * @OVS_DP_ATTR_PER_CPU_PIDS: Per-cpu array of PIDs for upcalls when
  * OVS_DP_F_DISPATCH_UPCALL_PER_CPU feature is set.
  * @OVS_DP_ATTR_STATS: Statistics about packets that have passed through the
  * datapath.  Always present in notifications.
  * @OVS_DP_ATTR_MEGAFLOW_STATS: Statistics about mega flow masks usage for the
  * datapath. Always present in notifications.
+ * @OVS_DP_ATTR_USER_FEATURES: OVS_DP_F_* flags.
  * @OVS_DP_ATTR_IFINDEX: Interface index for a new datapath netdev. Only
  * valid for %OVS_DP_CMD_NEW requests.
  *
@@ -83,18 +86,23 @@ enum ovs_datapath_cmd {
  * payload for %OVS_DP_* commands.
  */
 enum ovs_datapath_attr {
+	/* private: */
 	OVS_DP_ATTR_UNSPEC,
+	/* public: */
 	OVS_DP_ATTR_NAME,		/* name of dp_ifindex netdev */
 	OVS_DP_ATTR_UPCALL_PID,		/* Netlink PID to receive upcalls */
 	OVS_DP_ATTR_STATS,		/* struct ovs_dp_stats */
 	OVS_DP_ATTR_MEGAFLOW_STATS,	/* struct ovs_dp_megaflow_stats */
 	OVS_DP_ATTR_USER_FEATURES,	/* OVS_DP_F_*  */
+	/* private: */
 	OVS_DP_ATTR_PAD,
+	/* public: */
 	OVS_DP_ATTR_MASKS_CACHE_SIZE,
 	OVS_DP_ATTR_PER_CPU_PIDS,   /* Netlink PIDS to receive upcalls in
 				     * per-cpu dispatch mode
 				     */
 	OVS_DP_ATTR_IFINDEX,
+	/* private: */
 	__OVS_DP_ATTR_MAX
 };
 
@@ -181,6 +189,7 @@ enum ovs_packet_cmd {
  * %OVS_USERSPACE_ATTR_EGRESS_TUN_PORT attribute, which is sent only if the
  * output port is actually a tunnel port. Contains the output tunnel key
  * extracted from the packet as nested %OVS_TUNNEL_KEY_ATTR_* attributes.
+ * @OVS_PACKET_ATTR_PROBE: Packet operation is a feature probe.
  * @OVS_PACKET_ATTR_MRU: Present for an %OVS_PACKET_CMD_ACTION and
  * @OVS_PACKET_ATTR_LEN: Packet size before truncation.
  * %OVS_PACKET_ATTR_USERSPACE action specify the Maximum received fragment
@@ -196,21 +205,26 @@ enum ovs_packet_cmd {
  * payload for %OVS_PACKET_* commands.
  */
 enum ovs_packet_attr {
+	/* private: */
 	OVS_PACKET_ATTR_UNSPEC,
+	/* public: */
 	OVS_PACKET_ATTR_PACKET,      /* Packet data. */
 	OVS_PACKET_ATTR_KEY,         /* Nested OVS_KEY_ATTR_* attributes. */
 	OVS_PACKET_ATTR_ACTIONS,     /* Nested OVS_ACTION_ATTR_* attributes. */
 	OVS_PACKET_ATTR_USERDATA,    /* OVS_ACTION_ATTR_USERSPACE arg. */
 	OVS_PACKET_ATTR_EGRESS_TUN_KEY,  /* Nested OVS_TUNNEL_KEY_ATTR_*
 					    attributes. */
+	/* private: */
 	OVS_PACKET_ATTR_UNUSED1,
 	OVS_PACKET_ATTR_UNUSED2,
+	/* public: */
 	OVS_PACKET_ATTR_PROBE,      /* Packet operation is a feature probe,
 				       error logging should be suppressed. */
 	OVS_PACKET_ATTR_MRU,	    /* Maximum received IP fragment size. */
 	OVS_PACKET_ATTR_LEN,	    /* Packet size before truncation. */
 	OVS_PACKET_ATTR_HASH,	    /* Packet hash. */
 	OVS_PACKET_ATTR_UPCALL_PID, /* u32 Netlink PID. */
+	/* private: */
 	__OVS_PACKET_ATTR_MAX
 };
 
@@ -257,6 +271,11 @@ enum ovs_vport_type {
  * upcalls should not be sent.
  * @OVS_VPORT_ATTR_STATS: A &struct ovs_vport_stats giving statistics for
  * packets sent or received through the vport.
+ * @OVS_VPORT_ATTR_IFINDEX: Get the vport ifindex or put the desired ifindex.
+ * Only valid for vport type %OVS_VPORT_TYPE_INTERNAL.
+ * @OVS_VPORT_ATTR_NETNSID: Provides the netns id of the vport if it's not local.
+ * @OVS_VPORT_ATTR_UPCALL_STATS: Provides upcall statistics for a vport.
+ * Contains nested %OVS_VPORT_UPCALL_ATTR_* attributes.
  *
  * These attributes follow the &struct ovs_header within the Generic Netlink
  * payload for %OVS_VPORT_* commands.
@@ -272,7 +291,9 @@ enum ovs_vport_type {
  * ovs_header plus %OVS_VPORT_ATTR_PORT_NO determine the vport.
  */
 enum ovs_vport_attr {
+	/* private: */
 	OVS_VPORT_ATTR_UNSPEC,
+	/* public: */
 	OVS_VPORT_ATTR_PORT_NO,	/* u32 port number within datapath */
 	OVS_VPORT_ATTR_TYPE,	/* u32 OVS_VPORT_TYPE_* constant. */
 	OVS_VPORT_ATTR_NAME,	/* string name, up to IFNAMSIZ bytes long */
@@ -280,23 +301,27 @@ enum ovs_vport_attr {
 	OVS_VPORT_ATTR_UPCALL_PID, /* array of u32 Netlink socket PIDs for */
 				/* receiving upcalls */
 	OVS_VPORT_ATTR_STATS,	/* struct ovs_vport_stats */
+	/* private: */
 	OVS_VPORT_ATTR_PAD,
+	/* public: */
 	OVS_VPORT_ATTR_IFINDEX,
 	OVS_VPORT_ATTR_NETNSID,
 	OVS_VPORT_ATTR_UPCALL_STATS,
+	/* private: */
 	__OVS_VPORT_ATTR_MAX
 };
 
 #define OVS_VPORT_ATTR_MAX (__OVS_VPORT_ATTR_MAX - 1)
 
 /**
- * enum ovs_vport_upcall_attr - attributes for %OVS_VPORT_UPCALL* commands
- * @OVS_VPORT_UPCALL_SUCCESS: 64-bit upcall success packets.
- * @OVS_VPORT_UPCALL_FAIL: 64-bit upcall fail packets.
+ * enum ovs_vport_upcall_attr - attributes for %OVS_VPORT_ATTR_UPCALL_STATS
+ * @OVS_VPORT_UPCALL_ATTR_SUCCESS: 64-bit upcall success packets.
+ * @OVS_VPORT_UPCALL_ATTR_FAIL: 64-bit upcall fail packets.
  */
 enum ovs_vport_upcall_attr {
 	OVS_VPORT_UPCALL_ATTR_SUCCESS,
 	OVS_VPORT_UPCALL_ATTR_FAIL,
+	/* private: */
 	__OVS_VPORT_UPCALL_ATTR_MAX
 };
 
@@ -431,6 +456,7 @@ enum ovs_frag_type {
 	OVS_FRAG_TYPE_NONE,
 	OVS_FRAG_TYPE_FIRST,
 	OVS_FRAG_TYPE_LATER,
+	/* private: */
 	__OVS_FRAG_TYPE_MAX
 };
 
@@ -604,6 +630,8 @@ struct ovs_nsh_key_md1 {
  * a wildcarded match. Omitting attribute is treated as wildcarding all
  * corresponding fields. Optional for all requests. If not present,
  * all flow key bits are exact match bits.
+ * @OVS_FLOW_ATTR_PROBE: Flow operation is a feature probe, error logging
+ * should be suppressed.
  * @OVS_FLOW_ATTR_UFID: A value between 1-16 octets specifying a unique
  * identifier for the flow. Causes the flow to be indexed by this value rather
  * than the value of the %OVS_FLOW_ATTR_KEY attribute. Optional for all
@@ -617,7 +645,9 @@ struct ovs_nsh_key_md1 {
  * payload for %OVS_FLOW_* commands.
  */
 enum ovs_flow_attr {
+	/* private: */
 	OVS_FLOW_ATTR_UNSPEC,
+	/* public: */
 	OVS_FLOW_ATTR_KEY,       /* Sequence of OVS_KEY_ATTR_* attributes. */
 	OVS_FLOW_ATTR_ACTIONS,   /* Nested OVS_ACTION_ATTR_* attributes. */
 	OVS_FLOW_ATTR_STATS,     /* struct ovs_flow_stats. */
@@ -629,13 +659,14 @@ enum ovs_flow_attr {
 				  * logging should be suppressed. */
 	OVS_FLOW_ATTR_UFID,      /* Variable length unique flow identifier. */
 	OVS_FLOW_ATTR_UFID_FLAGS,/* u32 of OVS_UFID_F_*. */
+	/* private: */
 	OVS_FLOW_ATTR_PAD,
 	__OVS_FLOW_ATTR_MAX
 };
 
 #define OVS_FLOW_ATTR_MAX (__OVS_FLOW_ATTR_MAX - 1)
 
-/**
+/*
  * Omit attributes for notifications.
  *
  * If a datapath request contains an %OVS_UFID_F_OMIT_* flag, then the datapath
@@ -653,17 +684,23 @@ enum ovs_flow_attr {
  * fractions of packets.
  * @OVS_SAMPLE_ATTR_ACTIONS: Set of actions to execute in sampling event.
  * Actions are passed as nested attributes.
+ * @OVS_SAMPLE_ATTR_ARG: For in-kernel use, passing &struct sample_arg
+ * derived from other attributes.
  *
  * Executes the specified actions with the given probability on a per-packet
  * basis. Nested actions will be able to access the probability value of the
  * parent @OVS_ACTION_ATTR_SAMPLE.
  */
 enum ovs_sample_attr {
+	/* private: */
 	OVS_SAMPLE_ATTR_UNSPEC,
+	/* public: */
 	OVS_SAMPLE_ATTR_PROBABILITY, /* u32 number */
 	OVS_SAMPLE_ATTR_ACTIONS,     /* Nested OVS_ACTION_ATTR_* attributes. */
+	/* private: */
 	__OVS_SAMPLE_ATTR_MAX,
 
+	/* public: */
 #ifdef __KERNEL__
 	OVS_SAMPLE_ATTR_ARG          /* struct sample_arg  */
 #endif
@@ -693,12 +730,15 @@ struct sample_arg {
  * @OVS_USERSPACE_ATTR_ACTIONS: If present, send actions with upcall.
  */
 enum ovs_userspace_attr {
+	/* private: */
 	OVS_USERSPACE_ATTR_UNSPEC,
+	/* public: */
 	OVS_USERSPACE_ATTR_PID,	      /* u32 Netlink PID to receive upcalls. */
 	OVS_USERSPACE_ATTR_USERDATA,  /* Optional user-specified cookie. */
 	OVS_USERSPACE_ATTR_EGRESS_TUN_PORT,  /* Optional, u32 output port
 					      * to get tunnel info. */
 	OVS_USERSPACE_ATTR_ACTIONS,   /* Optional flag to get actions. */
+	/* private: */
 	__OVS_USERSPACE_ATTR_MAX
 };
 
@@ -819,7 +859,9 @@ struct ovs_action_hash {
  * @OVS_CT_ATTR_TIMEOUT: Variable length string defining conntrack timeout.
  */
 enum ovs_ct_attr {
+	/* private: */
 	OVS_CT_ATTR_UNSPEC,
+	/* public: */
 	OVS_CT_ATTR_COMMIT,     /* No argument, commits connection. */
 	OVS_CT_ATTR_ZONE,       /* u16 zone id. */
 	OVS_CT_ATTR_MARK,       /* mark to associate with this connection. */
@@ -831,6 +873,7 @@ enum ovs_ct_attr {
 	OVS_CT_ATTR_EVENTMASK,  /* u32 mask of IPCT_* events. */
 	OVS_CT_ATTR_TIMEOUT,	/* Associate timeout with this connection for
 				 * fine-grain timeout tuning. */
+	/* private: */
 	__OVS_CT_ATTR_MAX
 };
 
@@ -859,7 +902,9 @@ enum ovs_ct_attr {
  * @OVS_NAT_ATTR_PROTO_RANDOM: Flag for fully randomized L4 port mapping
  */
 enum ovs_nat_attr {
+	/* private: */
 	OVS_NAT_ATTR_UNSPEC,
+	/* public: */
 	OVS_NAT_ATTR_SRC,
 	OVS_NAT_ATTR_DST,
 	OVS_NAT_ATTR_IP_MIN,
@@ -869,38 +914,44 @@ enum ovs_nat_attr {
 	OVS_NAT_ATTR_PERSISTENT,
 	OVS_NAT_ATTR_PROTO_HASH,
 	OVS_NAT_ATTR_PROTO_RANDOM,
+	/* private: */
 	__OVS_NAT_ATTR_MAX,
 };
 
 #define OVS_NAT_ATTR_MAX (__OVS_NAT_ATTR_MAX - 1)
 
-/*
+/**
  * struct ovs_action_push_eth - %OVS_ACTION_ATTR_PUSH_ETH action argument.
  * @addresses: Source and destination MAC addresses.
- * @eth_type: Ethernet type
  */
 struct ovs_action_push_eth {
 	struct ovs_key_ethernet addresses;
 };
 
-/*
+/**
  * enum ovs_check_pkt_len_attr - Attributes for %OVS_ACTION_ATTR_CHECK_PKT_LEN.
  *
  * @OVS_CHECK_PKT_LEN_ATTR_PKT_LEN: u16 Packet length to check for.
  * @OVS_CHECK_PKT_LEN_ATTR_ACTIONS_IF_GREATER: Nested OVS_ACTION_ATTR_*
  * actions to apply if the packer length is greater than the specified
  * length in the attr - OVS_CHECK_PKT_LEN_ATTR_PKT_LEN.
- * @OVS_CHECK_PKT_LEN_ATTR_ACTIONS_IF_LESS_EQUAL - Nested OVS_ACTION_ATTR_*
+ * @OVS_CHECK_PKT_LEN_ATTR_ACTIONS_IF_LESS_EQUAL: Nested OVS_ACTION_ATTR_*
  * actions to apply if the packer length is lesser or equal to the specified
  * length in the attr - OVS_CHECK_PKT_LEN_ATTR_PKT_LEN.
+ * @OVS_CHECK_PKT_LEN_ATTR_ARG: For in-kernel use, passing &struct
+ * check_pkt_len_arg derived from other attributes.
  */
 enum ovs_check_pkt_len_attr {
+	/* private: */
 	OVS_CHECK_PKT_LEN_ATTR_UNSPEC,
+	/* public: */
 	OVS_CHECK_PKT_LEN_ATTR_PKT_LEN,
 	OVS_CHECK_PKT_LEN_ATTR_ACTIONS_IF_GREATER,
 	OVS_CHECK_PKT_LEN_ATTR_ACTIONS_IF_LESS_EQUAL,
+	/* private: */
 	__OVS_CHECK_PKT_LEN_ATTR_MAX,
 
+	/* public: */
 #ifdef __KERNEL__
 	OVS_CHECK_PKT_LEN_ATTR_ARG          /* struct check_pkt_len_arg  */
 #endif
@@ -968,6 +1019,9 @@ enum ovs_psample_attr {
  * from the packet.
  * @OVS_ACTION_ATTR_SAMPLE: Probabilitically executes actions, as specified in
  * the nested %OVS_SAMPLE_ATTR_* attributes.
+ * @OVS_ACTION_ATTR_RECIRC: Recirculate the clone of the packet through the
+ * datapath with the new id (u32 recirc_id).
+ * @OVS_ACTION_ATTR_HASH: Compute the packet hash, using &struct ovs_action_hash.
  * @OVS_ACTION_ATTR_PUSH_MPLS: Push a new MPLS label stack entry onto the
  * top of the packets MPLS label stack.  Set the ethertype of the
  * encapsulating frame to either %ETH_P_MPLS_UC or %ETH_P_MPLS_MC to
@@ -997,6 +1051,8 @@ enum ovs_psample_attr {
  * start of the packet or at the start of the l3 header depending on the value
  * of l3 tunnel flag in the tun_flags field of OVS_ACTION_ATTR_ADD_MPLS
  * argument.
+ * @OVS_ACTION_ATTR_DEC_TTL: Decrement TTL or hop limit of the packet. Execute
+ * nested %OVS_DEC_TTL_ATTR_* actions if the value is less or equal to 1.
  * @OVS_ACTION_ATTR_DROP: Explicit drop action.
  * @OVS_ACTION_ATTR_PSAMPLE: Send a sample of the packet to external observers
  * via psample.
@@ -1010,7 +1066,9 @@ enum ovs_psample_attr {
  */
 
 enum ovs_action_attr {
+	/* private: */
 	OVS_ACTION_ATTR_UNSPEC,
+	/* public: */
 	OVS_ACTION_ATTR_OUTPUT,	      /* u32 port number. */
 	OVS_ACTION_ATTR_USERSPACE,    /* Nested OVS_USERSPACE_ATTR_*. */
 	OVS_ACTION_ATTR_SET,          /* One nested OVS_KEY_ATTR_*. */
@@ -1040,9 +1098,11 @@ enum ovs_action_attr {
 	OVS_ACTION_ATTR_DROP,         /* u32 error code. */
 	OVS_ACTION_ATTR_PSAMPLE,      /* Nested OVS_PSAMPLE_ATTR_*. */
 
+	/* private: */
 	__OVS_ACTION_ATTR_MAX,	      /* Nothing past this will be accepted
 				       * from userspace. */
 
+	/* public: */
 #ifdef __KERNEL__
 	OVS_ACTION_ATTR_SET_TO_MASKED, /* Kernel module internal masked
 					* set action converted from

