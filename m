Return-Path: <netdev+bounces-262023-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLToAlc+ommq1AQAu9opvQ
	(envelope-from <netdev+bounces-262023-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 02:01:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9F71BF92B
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 02:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E4BE3007C88
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 01:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792B63D6F;
	Sat, 28 Feb 2026 01:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sG1orqJL"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FFA284694
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 01:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772240468; cv=none; b=aOhxTEMJoCFP+phlSioXodNG8lZ5VqOA05T/OBo6z2zJ+WAvnx64J47DfK5yku+EMlMBPEZCCikJC7m3OMR02yCdLQnLlbcCYDSRGKKb7Na/wL/yAE+PPYiaOLwo49uhMrfObBdRY5GGs2KOl0dNmCtm7UOgW2mUzzJS11wN0Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772240468; c=relaxed/simple;
	bh=xtI+JdN6nET2C9MwR6hNYFuFROLKg8VHazkUZUYVMHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YrlyvLE83dMRYt7CVLzzXtjx5pB61dNZ+b3SX7w2e7Z77Ms8Zo+JCuQMr4bpxXx3dWh+8TC3/GTGoHqG436bBcTAwhPCbYNxcgVJtjjd70cvj7lNKYFK+pb6FtSjwMBKVsu6+e8pajeQI+7KL5XRO4zkj+hqDPvDzO3xvdvt3GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sG1orqJL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=vEwBgonYNGd5qwfg1vSP7c8quUinzxyWcscpvtgY8NQ=; b=sG1orqJL5j+PagkexFTwSo23Dq
	c/2RbCv0bSzIfsDv243IRnKPywH7uv0w80rgxpYQzFaY09U66EgzGDUcK+/OgfR7/E/KaXpliow/8
	rJO2GDvpHEuPeCLJ5raya6CLoKZpQcDv7Wg8u577EfgvnQonfjMaeiqmrfsjuuw6fovc18ue5Elht
	0q4itziOPzBivHgFc38GNtb5JspQrXwwaOo3MWAyrf6nqpwZCe7fxE6U3QSiOG/JlHWSK6xazfotC
	SV7tfVK0BFOBFwaBQ8vzFyTsjJHUQYBPD2XyRUtjLv+v806snSsenmO8dc1LUrN0g/NjnVK88sIL0
	KV0rLifw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw8hX-00000009Mbd-46Y8;
	Sat, 28 Feb 2026 01:01:00 +0000
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
Subject: [PATCH net v2] net: openvswitch: clean up some kernel-doc warnings
Date: Fri, 27 Feb 2026 17:00:58 -0800
Message-ID: <20260228010058.2385110-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262023-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5E9F71BF92B
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

 include/uapi/linux/openvswitch.h |   72 ++++++++++++++++++++++++++---
 1 file changed, 65 insertions(+), 7 deletions(-)

--- linux-next-20260227.orig/include/uapi/linux/openvswitch.h
+++ linux-next-20260227/include/uapi/linux/openvswitch.h
@@ -70,12 +70,14 @@ enum ovs_datapath_cmd {
  * set on the datapath port (for OVS_ACTION_ATTR_MISS).  Only valid on
  * %OVS_DP_CMD_NEW requests. A value of zero indicates that upcalls should
  * not be sent.
+ * @OVS_DP_ATTR_MASKS_CACHE_SIZE: Size of the flow table masks cache (bytes).
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
@@ -83,18 +85,23 @@ enum ovs_datapath_cmd {
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
 
@@ -181,6 +188,7 @@ enum ovs_packet_cmd {
  * %OVS_USERSPACE_ATTR_EGRESS_TUN_PORT attribute, which is sent only if the
  * output port is actually a tunnel port. Contains the output tunnel key
  * extracted from the packet as nested %OVS_TUNNEL_KEY_ATTR_* attributes.
+ * @OVS_PACKET_ATTR_PROBE: Packet operation is a feature probe.
  * @OVS_PACKET_ATTR_MRU: Present for an %OVS_PACKET_CMD_ACTION and
  * @OVS_PACKET_ATTR_LEN: Packet size before truncation.
  * %OVS_PACKET_ATTR_USERSPACE action specify the Maximum received fragment
@@ -196,21 +204,26 @@ enum ovs_packet_cmd {
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
 
@@ -257,6 +270,10 @@ enum ovs_vport_type {
  * upcalls should not be sent.
  * @OVS_VPORT_ATTR_STATS: A &struct ovs_vport_stats giving statistics for
  * packets sent or received through the vport.
+ * @OVS_VPORT_ATTR_IFINDEX: Get the vport ifindex or put the desired ifindex
+ * @OVS_VPORT_ATTR_NETNSID: Get the vport id of a peer netns. If there isn't
+ * one, a new netns is allocated.
+ * @OVS_VPORT_ATTR_UPCALL_STATS: Provides upcall stats for a device.
  *
  * These attributes follow the &struct ovs_header within the Generic Netlink
  * payload for %OVS_VPORT_* commands.
@@ -272,7 +289,9 @@ enum ovs_vport_type {
  * ovs_header plus %OVS_VPORT_ATTR_PORT_NO determine the vport.
  */
 enum ovs_vport_attr {
+	/* private: */
 	OVS_VPORT_ATTR_UNSPEC,
+	/* public: */
 	OVS_VPORT_ATTR_PORT_NO,	/* u32 port number within datapath */
 	OVS_VPORT_ATTR_TYPE,	/* u32 OVS_VPORT_TYPE_* constant. */
 	OVS_VPORT_ATTR_NAME,	/* string name, up to IFNAMSIZ bytes long */
@@ -280,10 +299,13 @@ enum ovs_vport_attr {
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
 
@@ -291,12 +313,13 @@ enum ovs_vport_attr {
 
 /**
  * enum ovs_vport_upcall_attr - attributes for %OVS_VPORT_UPCALL* commands
- * @OVS_VPORT_UPCALL_SUCCESS: 64-bit upcall success packets.
- * @OVS_VPORT_UPCALL_FAIL: 64-bit upcall fail packets.
+ * @OVS_VPORT_UPCALL_ATTR_SUCCESS: 64-bit upcall success packets.
+ * @OVS_VPORT_UPCALL_ATTR_FAIL: 64-bit upcall fail packets.
  */
 enum ovs_vport_upcall_attr {
 	OVS_VPORT_UPCALL_ATTR_SUCCESS,
 	OVS_VPORT_UPCALL_ATTR_FAIL,
+	/* private: */
 	__OVS_VPORT_UPCALL_ATTR_MAX
 };
 
@@ -431,6 +454,7 @@ enum ovs_frag_type {
 	OVS_FRAG_TYPE_NONE,
 	OVS_FRAG_TYPE_FIRST,
 	OVS_FRAG_TYPE_LATER,
+	/* private: */
 	__OVS_FRAG_TYPE_MAX
 };
 
@@ -604,6 +628,8 @@ struct ovs_nsh_key_md1 {
  * a wildcarded match. Omitting attribute is treated as wildcarding all
  * corresponding fields. Optional for all requests. If not present,
  * all flow key bits are exact match bits.
+ * @OVS_FLOW_ATTR_PROBE: Flow operation is a feature probe, error logging
+ * should be suppressed.
  * @OVS_FLOW_ATTR_UFID: A value between 1-16 octets specifying a unique
  * identifier for the flow. Causes the flow to be indexed by this value rather
  * than the value of the %OVS_FLOW_ATTR_KEY attribute. Optional for all
@@ -617,7 +643,9 @@ struct ovs_nsh_key_md1 {
  * payload for %OVS_FLOW_* commands.
  */
 enum ovs_flow_attr {
+	/* private: */
 	OVS_FLOW_ATTR_UNSPEC,
+	/* public: */
 	OVS_FLOW_ATTR_KEY,       /* Sequence of OVS_KEY_ATTR_* attributes. */
 	OVS_FLOW_ATTR_ACTIONS,   /* Nested OVS_ACTION_ATTR_* attributes. */
 	OVS_FLOW_ATTR_STATS,     /* struct ovs_flow_stats. */
@@ -629,13 +657,14 @@ enum ovs_flow_attr {
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
@@ -652,6 +681,8 @@ enum ovs_flow_attr {
  * %UINT32_MAX samples all packets and intermediate values sample intermediate
  * fractions of packets.
  * @OVS_SAMPLE_ATTR_ACTIONS: Set of actions to execute in sampling event.
+ * @OVS_SAMPLE_ATTR_ARG: same as @OVS_SAMPLE_ATTR_PROBABILITY, for in-kernel
+ * use, passing &struct sample_arg.
  * Actions are passed as nested attributes.
  *
  * Executes the specified actions with the given probability on a per-packet
@@ -659,11 +690,15 @@ enum ovs_flow_attr {
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
@@ -693,12 +728,15 @@ struct sample_arg {
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
 
@@ -819,7 +857,9 @@ struct ovs_action_hash {
  * @OVS_CT_ATTR_TIMEOUT: Variable length string defining conntrack timeout.
  */
 enum ovs_ct_attr {
+	/* private: */
 	OVS_CT_ATTR_UNSPEC,
+	/* public: */
 	OVS_CT_ATTR_COMMIT,     /* No argument, commits connection. */
 	OVS_CT_ATTR_ZONE,       /* u16 zone id. */
 	OVS_CT_ATTR_MARK,       /* mark to associate with this connection. */
@@ -831,6 +871,7 @@ enum ovs_ct_attr {
 	OVS_CT_ATTR_EVENTMASK,  /* u32 mask of IPCT_* events. */
 	OVS_CT_ATTR_TIMEOUT,	/* Associate timeout with this connection for
 				 * fine-grain timeout tuning. */
+	/* private: */
 	__OVS_CT_ATTR_MAX
 };
 
@@ -859,7 +900,9 @@ enum ovs_ct_attr {
  * @OVS_NAT_ATTR_PROTO_RANDOM: Flag for fully randomized L4 port mapping
  */
 enum ovs_nat_attr {
+	/* private: */
 	OVS_NAT_ATTR_UNSPEC,
+	/* public: */
 	OVS_NAT_ATTR_SRC,
 	OVS_NAT_ATTR_DST,
 	OVS_NAT_ATTR_IP_MIN,
@@ -869,38 +912,44 @@ enum ovs_nat_attr {
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
+ * @OVS_CHECK_PKT_LEN_ATTR_ARG: similar to @OVS_CHECK_PKT_LEN_ATTR_PKT_LEN,
+ * used in-kernel, passes &struct check_pkt_len_arg.
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
@@ -968,6 +1017,10 @@ enum ovs_psample_attr {
  * from the packet.
  * @OVS_ACTION_ATTR_SAMPLE: Probabilitically executes actions, as specified in
  * the nested %OVS_SAMPLE_ATTR_* attributes.
+ * @OVS_ACTION_ATTR_RECIRC: Execute actions on the clone of the packet
+ * (u32 recirc_id).
+ * @OVS_ACTION_ATTR_HASH: Compute hash prior to recirculation, using
+ * &struct ovs_action_hash.
  * @OVS_ACTION_ATTR_PUSH_MPLS: Push a new MPLS label stack entry onto the
  * top of the packets MPLS label stack.  Set the ethertype of the
  * encapsulating frame to either %ETH_P_MPLS_UC or %ETH_P_MPLS_MC to
@@ -997,6 +1050,7 @@ enum ovs_psample_attr {
  * start of the packet or at the start of the l3 header depending on the value
  * of l3 tunnel flag in the tun_flags field of OVS_ACTION_ATTR_ADD_MPLS
  * argument.
+ * @OVS_ACTION_ATTR_DEC_TTL: Nested OVS_DEC_TTL_ATTR_* action.
  * @OVS_ACTION_ATTR_DROP: Explicit drop action.
  * @OVS_ACTION_ATTR_PSAMPLE: Send a sample of the packet to external observers
  * via psample.
@@ -1010,7 +1064,9 @@ enum ovs_psample_attr {
  */
 
 enum ovs_action_attr {
+	/* private: */
 	OVS_ACTION_ATTR_UNSPEC,
+	/* public: */
 	OVS_ACTION_ATTR_OUTPUT,	      /* u32 port number. */
 	OVS_ACTION_ATTR_USERSPACE,    /* Nested OVS_USERSPACE_ATTR_*. */
 	OVS_ACTION_ATTR_SET,          /* One nested OVS_KEY_ATTR_*. */
@@ -1040,9 +1096,11 @@ enum ovs_action_attr {
 	OVS_ACTION_ATTR_DROP,         /* u32 error code. */
 	OVS_ACTION_ATTR_PSAMPLE,      /* Nested OVS_PSAMPLE_ATTR_*. */
 
+	/* private: */
 	__OVS_ACTION_ATTR_MAX,	      /* Nothing past this will be accepted
 				       * from userspace. */
 
+	/* public: */
 #ifdef __KERNEL__
 	OVS_ACTION_ATTR_SET_TO_MASKED, /* Kernel module internal masked
 					* set action converted from

