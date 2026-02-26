Return-Path: <netdev+bounces-261605-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YC71DQbFoGnImQQAu9opvQ
	(envelope-from <netdev+bounces-261605-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 23:11:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC5D1B0370
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 23:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F1A530293C4
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 22:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E9D42849F;
	Thu, 26 Feb 2026 22:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="es7DCl/u"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE5A36212E
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 22:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772143859; cv=none; b=NG+0o/EtoQ718omwxP3oKbqtdSybU16PPSSDOxMvo8Y7E6DGa0cR2X7zBAATaJfd29bBBHMj56pSS2qrR8+sxl1vTHrKqETe/Esq1g14rvp6fcKnxeORGqhVARI2dWdthFew3tdCVQAUuqzwyEtJS/BRreANAemXL6TGqqanM+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772143859; c=relaxed/simple;
	bh=Yu7C7aDFSluiEl/lUp1M3M/Q3ivyWwW3ofnsPjmOhgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d0IcYAKZcM4mY/cMay2OLCRp17QY9vQ9ox9/831b/nB5eVF8mFkYmo8xZXRZM28QfkpfQoRw9vpIVxYPI8Sy2PlLmltlQaJMUg7aXYd2z3DjgOcYhw1QEmUGoGWX2+EOpWPvm0owiJKcoQWinvSJkAA39XsjEjSmh1gtHsDjIXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=es7DCl/u; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=JZmI/scYy+SW1HtvjZt3L6D64yhI1HExfXYX1CKXVhk=; b=es7DCl/uVxCSxgScYf15FSZMDi
	n+aTFPQGQsdXj+Gf34sRKHrxAeDU/3m88zlq+T89mZ42FH5zqzvlLW43lggLPR11daD77xYbFWC4S
	Oc3l1XIsPUwbxMTlUoP2sknQnYcPkz1ffQpvEphuzG0EzlcfRouLAPWwD2LXtSi4THW0YjPoN2EYh
	3weg7NO/rqnOafkWlScuXNB36Cj4eUjpmLiRlYBCW7mXvgFfdFDgvb92HVMXVfBqdJsiAZ0CDhL5R
	eJb39bE2UC3Y0F7TzuWrBsNxnIGyL8DgyVqYCR0r1NN6bpedPir7fX5LAm6QkH6/5ywzxLm8pSRaZ
	W0MT6xcQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvjZP-00000007HlL-1Zq9;
	Thu, 26 Feb 2026 22:10:56 +0000
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
Subject: [PATCH -net] net: openvswitch: clean up some kernel-doc warnings
Date: Thu, 26 Feb 2026 14:10:54 -0800
Message-ID: <20260226221054.1041044-1-rdunlap@infradead.org>
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
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261605-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:mid,infradead.org:dkim,infradead.org:email]
X-Rspamd-Queue-Id: 7CC5D1B0370
X-Rspamd-Action: no action

Fix some kernel-doc warnings in openvswitch.h:

Mark enum placeholders that are not used as "private" so that kernel-doc
comments are not needed for them.

Correct names for 2 enum values:
Warning: include/uapi/linux/openvswitch.h:300 Excess enum value
 '@OVS_VPORT_UPCALL_SUCCESS' description in 'ovs_vport_upcall_attr'
Warning: include/uapi/linux/openvswitch.h:300 Excess enum value
 '@OVS_VPORT_UPCALL_FAIL' description in 'ovs_vport_upcall_attr'

Warning: include/uapi/linux/openvswitch.h:638 This comment starts with
 '/**', but isn't a kernel-doc comment.
 * Omit attributes for notifications.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Aaron Conole <aconole@redhat.com>
Cc: Eelco Chaudron <echaudro@redhat.com>
Cc: Ilya Maximets <i.maximets@ovn.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: dev@openvswitch.org

 include/uapi/linux/openvswitch.h |   43 ++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

--- linux-next-20260226.orig/include/uapi/linux/openvswitch.h
+++ linux-next-20260226/include/uapi/linux/openvswitch.h
@@ -83,18 +83,23 @@ enum ovs_datapath_cmd {
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
 
@@ -181,6 +186,7 @@ enum ovs_packet_cmd {
  * %OVS_USERSPACE_ATTR_EGRESS_TUN_PORT attribute, which is sent only if the
  * output port is actually a tunnel port. Contains the output tunnel key
  * extracted from the packet as nested %OVS_TUNNEL_KEY_ATTR_* attributes.
+ * @OVS_PACKET_ATTR_PROBE: Packet operation is a feature probe.
  * @OVS_PACKET_ATTR_MRU: Present for an %OVS_PACKET_CMD_ACTION and
  * @OVS_PACKET_ATTR_LEN: Packet size before truncation.
  * %OVS_PACKET_ATTR_USERSPACE action specify the Maximum received fragment
@@ -196,21 +202,26 @@ enum ovs_packet_cmd {
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
 
@@ -272,7 +283,9 @@ enum ovs_vport_type {
  * ovs_header plus %OVS_VPORT_ATTR_PORT_NO determine the vport.
  */
 enum ovs_vport_attr {
+	/* private: */
 	OVS_VPORT_ATTR_UNSPEC,
+	/* public: */
 	OVS_VPORT_ATTR_PORT_NO,	/* u32 port number within datapath */
 	OVS_VPORT_ATTR_TYPE,	/* u32 OVS_VPORT_TYPE_* constant. */
 	OVS_VPORT_ATTR_NAME,	/* string name, up to IFNAMSIZ bytes long */
@@ -280,10 +293,13 @@ enum ovs_vport_attr {
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
 
@@ -291,12 +307,13 @@ enum ovs_vport_attr {
 
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
 
@@ -431,6 +448,7 @@ enum ovs_frag_type {
 	OVS_FRAG_TYPE_NONE,
 	OVS_FRAG_TYPE_FIRST,
 	OVS_FRAG_TYPE_LATER,
+	/* private: */
 	__OVS_FRAG_TYPE_MAX
 };
 
@@ -617,7 +635,9 @@ struct ovs_nsh_key_md1 {
  * payload for %OVS_FLOW_* commands.
  */
 enum ovs_flow_attr {
+	/* private: */
 	OVS_FLOW_ATTR_UNSPEC,
+	/* public: */
 	OVS_FLOW_ATTR_KEY,       /* Sequence of OVS_KEY_ATTR_* attributes. */
 	OVS_FLOW_ATTR_ACTIONS,   /* Nested OVS_ACTION_ATTR_* attributes. */
 	OVS_FLOW_ATTR_STATS,     /* struct ovs_flow_stats. */
@@ -629,13 +649,14 @@ enum ovs_flow_attr {
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
@@ -659,9 +680,12 @@ enum ovs_flow_attr {
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
 
 #ifdef __KERNEL__
@@ -693,12 +717,15 @@ struct sample_arg {
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
 
@@ -819,7 +846,9 @@ struct ovs_action_hash {
  * @OVS_CT_ATTR_TIMEOUT: Variable length string defining conntrack timeout.
  */
 enum ovs_ct_attr {
+	/* private: */
 	OVS_CT_ATTR_UNSPEC,
+	/* public: */
 	OVS_CT_ATTR_COMMIT,     /* No argument, commits connection. */
 	OVS_CT_ATTR_ZONE,       /* u16 zone id. */
 	OVS_CT_ATTR_MARK,       /* mark to associate with this connection. */
@@ -831,6 +860,7 @@ enum ovs_ct_attr {
 	OVS_CT_ATTR_EVENTMASK,  /* u32 mask of IPCT_* events. */
 	OVS_CT_ATTR_TIMEOUT,	/* Associate timeout with this connection for
 				 * fine-grain timeout tuning. */
+	/* private: */
 	__OVS_CT_ATTR_MAX
 };
 
@@ -859,7 +889,9 @@ enum ovs_ct_attr {
  * @OVS_NAT_ATTR_PROTO_RANDOM: Flag for fully randomized L4 port mapping
  */
 enum ovs_nat_attr {
+	/* private: */
 	OVS_NAT_ATTR_UNSPEC,
+	/* public: */
 	OVS_NAT_ATTR_SRC,
 	OVS_NAT_ATTR_DST,
 	OVS_NAT_ATTR_IP_MIN,
@@ -869,6 +901,7 @@ enum ovs_nat_attr {
 	OVS_NAT_ATTR_PERSISTENT,
 	OVS_NAT_ATTR_PROTO_HASH,
 	OVS_NAT_ATTR_PROTO_RANDOM,
+	/* private: */
 	__OVS_NAT_ATTR_MAX,
 };
 
@@ -1010,7 +1043,9 @@ enum ovs_psample_attr {
  */
 
 enum ovs_action_attr {
+	/* private: */
 	OVS_ACTION_ATTR_UNSPEC,
+	/* public: */
 	OVS_ACTION_ATTR_OUTPUT,	      /* u32 port number. */
 	OVS_ACTION_ATTR_USERSPACE,    /* Nested OVS_USERSPACE_ATTR_*. */
 	OVS_ACTION_ATTR_SET,          /* One nested OVS_KEY_ATTR_*. */
@@ -1040,9 +1075,11 @@ enum ovs_action_attr {
 	OVS_ACTION_ATTR_DROP,         /* u32 error code. */
 	OVS_ACTION_ATTR_PSAMPLE,      /* Nested OVS_PSAMPLE_ATTR_*. */
 
+	/* private: */
 	__OVS_ACTION_ATTR_MAX,	      /* Nothing past this will be accepted
 				       * from userspace. */
 
+	/* public: */
 #ifdef __KERNEL__
 	OVS_ACTION_ATTR_SET_TO_MASKED, /* Kernel module internal masked
 					* set action converted from

