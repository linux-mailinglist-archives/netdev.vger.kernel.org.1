Return-Path: <netdev+bounces-295681-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PUoqJa56ImqnYAEAu9opvQ
	(envelope-from <netdev+bounces-295681-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:28:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9442F645F90
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:28:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=JAfYZRRY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295681-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295681-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4FA393030D96
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 07:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525DD47AF66;
	Fri,  5 Jun 2026 07:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DD047AF5F
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 07:20:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644023; cv=none; b=CO6HCp1Cwaj7wQsZX/twaYebbySD0cKPgXxjFpyLCU87vjsFXPNNOpfsnSvTxEB8kp7INRv7Dlje0TGzzeD+CnqOuQyDWMSEC2eYsrv1iKuVAvggnXQs40THAW4AbdAcDYM5ap10Qh7u0dZ5Pxq1jmXA1oQbTTdBGV7u+wXd5l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644023; c=relaxed/simple;
	bh=lQDRxcjgvHnBXatnTQ2QbAVNZil0zT0OPFvKPDhkSRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hP28al6n/9Sw5R1UoCD3BWoKYPWz0KZ65VZJ1sFVXZtKL3lFkpU+t1o59xG/bOyaGQkflNzQLulgldti1CtykJh92tLkTbK1hmASYfsFMfjLVuksl75rMgodGMuV7LZdetuVwBeHDGwniAtOcBvdlIBGXY+UtGANYrRRg+y/JkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=JAfYZRRY; arc=none smtp.client-ip=23.88.38.48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780644019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l6ymu5WtKNXPSHwu5QBSvWS8PabPHSE8dRLENSvCWqE=;
	b=JAfYZRRYAD1mcR1rKlpgYhn08nHSD4uQ9zqI6wv8cS0bJiSPa8SfPJNTtdxDSC0Sj7H+bc
	6VWVJFQOisCRGVIFX3N2CLnXY/kT0wU9a+RYOM3l2TTUW+cLHgyVOWTOr5ISI8cUwrkePt
	zfU3qrRRJSaTEKkygVUxzbkgpuxugtD6IetHMgM4g0+nv4/o848+iAyTsinRFUcW9asN3C
	yqNulUJD9FYOX9Curyh41WI3xKMVg0sid/JTT4FoIfsD5P/WI3/XFRztgbrvA0GzHQ7FpB
	G1tD7fmi/h+kqENjkvg2XlAk1aczDG1ovi8XTBvte0w1RRcqLgT031S7uLu1Rg==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 11/11] batman-adv: fix kernel-doc typos and grammar errors
Date: Fri,  5 Jun 2026 09:20:05 +0200
Message-ID: <20260605072005.490368-12-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260605072005.490368-1-sw@simonwunderlich.de>
References: <20260605072005.490368-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[simonwunderlich.de,none];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-295681-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:b.a.t.m.a.n@lists.open-mesh.org,m:sven@narfation.org,m:sw@simonwunderlich.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,narfation.org:email,simonwunderlich.de:mid,simonwunderlich.de:dkim,simonwunderlich.de:from_mime,simonwunderlich.de:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9442F645F90

From: Sven Eckelmann <sven@narfation.org>

Various minor errors were gathered over the time in batman-adv's kernel-doc
comments. Get rid of many of them before they are copied (again) to new
functions.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_v.c          | 2 +-
 net/batman-adv/bat_v_ogm.c      | 8 ++++----
 net/batman-adv/bitarray.c       | 2 +-
 net/batman-adv/bitarray.h       | 2 +-
 net/batman-adv/fragmentation.c  | 3 ++-
 net/batman-adv/hash.h           | 4 ++--
 net/batman-adv/mesh-interface.c | 6 +++---
 net/batman-adv/netlink.c        | 4 ++--
 net/batman-adv/originator.c     | 4 ++--
 net/batman-adv/tvlv.c           | 4 ++--
 10 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index cb081038d14f5..fe7c0113d0df3 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -587,7 +587,7 @@ batadv_v_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_v_gw_is_eligible() - check if a originator would be selected as GW
+ * batadv_v_gw_is_eligible() - check if an originator would be selected as GW
  * @bat_priv: the bat priv with all the mesh interface information
  * @curr_gw_orig: originator representing the currently selected GW
  * @orig_node: the originator representing the new candidate
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 14920f4bb315b..81926ef9c02c9 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -515,7 +515,7 @@ static u32 batadv_v_forward_penalty(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the mesh interface information
  * @ogm_received: previously received OGM to be forwarded
  * @orig_node: the originator which has been updated
- * @neigh_node: the neigh_node through with the OGM has been received
+ * @neigh_node: the neigh_node through which the OGM has been received
  * @if_incoming: the interface on which this OGM was received on
  * @if_outgoing: the interface to which the OGM has to be forwarded to
  *
@@ -602,7 +602,7 @@ static void batadv_v_ogm_forward(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the mesh interface information
  * @ogm2: OGM2 structure
  * @orig_node: Originator structure for which the OGM has been received
- * @neigh_node: the neigh_node through with the OGM has been received
+ * @neigh_node: the neigh_node through which the OGM has been received
  * @if_incoming: the interface where this packet was received
  * @if_outgoing: the interface for which the packet should be considered
  *
@@ -686,7 +686,7 @@ static int batadv_v_ogm_metric_update(struct batadv_priv *bat_priv,
  * @ethhdr: the Ethernet header of the OGM2
  * @ogm2: OGM2 structure
  * @orig_node: Originator structure for which the OGM has been received
- * @neigh_node: the neigh_node through with the OGM has been received
+ * @neigh_node: the neigh_node through which the OGM has been received
  * @if_incoming: the interface where this packet was received
  * @if_outgoing: the interface for which the packet should be considered
  *
@@ -781,7 +781,7 @@ static bool batadv_v_ogm_route_update(struct batadv_priv *bat_priv,
  * @ethhdr: the Ethernet header of the OGM2
  * @ogm2: OGM2 structure
  * @orig_node: Originator structure for which the OGM has been received
- * @neigh_node: the neigh_node through with the OGM has been received
+ * @neigh_node: the neigh_node through which the OGM has been received
  * @if_incoming: the interface where this packet was received
  * @if_outgoing: the interface for which the packet should be considered
  */
diff --git a/net/batman-adv/bitarray.c b/net/batman-adv/bitarray.c
index 2c49b27116503..67cb356332bf1 100644
--- a/net/batman-adv/bitarray.c
+++ b/net/batman-adv/bitarray.c
@@ -24,7 +24,7 @@ static void batadv_bitmap_shift_left(unsigned long *seq_bits, s32 n)
  * batadv_bit_get_packet() - receive and process one packet within the sequence
  *  number window
  * @priv: the bat priv with all the mesh interface information
- * @seq_bits: pointer to the sequence number receive packet
+ * @seq_bits: pointer to the sequence number bitmap of received packets
  * @seq_num_diff: difference between the current/received sequence number and
  *  the last sequence number
  * @set_mark: whether this packet should be marked in seq_bits
diff --git a/net/batman-adv/bitarray.h b/net/batman-adv/bitarray.h
index 37f7ae413bc66..2b9f5dbb3ec41 100644
--- a/net/batman-adv/bitarray.h
+++ b/net/batman-adv/bitarray.h
@@ -17,7 +17,7 @@
 /**
  * batadv_test_bit() - check if bit is set in the current window
  *
- * @seq_bits: pointer to the sequence number receive packet
+ * @seq_bits: pointer to the sequence number bitmap of received packets
  * @last_seqno: latest sequence number in seq_bits
  * @curr_seqno: sequence number to test for
  *
diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 14ccf7811bf62..1e42cf99f8b33 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -309,7 +309,8 @@ batadv_frag_merge_packets(struct hlist_head *chain)
  * batadv_skb_is_frag() - check if newly merged skb contains unicast fragment
  * @skb: newly merged skb
  *
- * Return: if newly merged skb is of type BATADV_UNICAST_FRAG
+ * Return: true if the newly merged skb is of type BATADV_UNICAST_FRAG, false
+ *  otherwise
  */
 static bool batadv_skb_is_frag(struct sk_buff *skb)
 {
diff --git a/net/batman-adv/hash.h b/net/batman-adv/hash.h
index fb251c385a1bb..86a2c20000dcf 100644
--- a/net/batman-adv/hash.h
+++ b/net/batman-adv/hash.h
@@ -120,10 +120,10 @@ static inline int batadv_hash_add(struct batadv_hashtable *hash,
  * @choose: callback calculating the hash index
  * @data: data passed to the aforementioned callbacks as argument
  *
- * ata could be the structure you use with  just the key filled, we just need
+ * data could be the structure you use with just the key filled, we just need
  * the key for comparing.
  *
- * Return: returns pointer do data on success, so you can remove the used
+ * Return: returns pointer to data on success, so you can remove the used
  * structure yourself, or NULL on error
  */
 static inline void *batadv_hash_remove(struct batadv_hashtable *hash,
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index b6797654b18ab..44026810b99ce 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -392,13 +392,13 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
  * @orig_node: originator from which the batman-adv packet was sent
  *
  * Sends an ethernet frame to the receive path of the local @mesh_iface.
- * skb->data has still point to the batman-adv header with the size @hdr_size.
+ * skb->data must still point to the batman-adv header with the size @hdr_size.
  * The caller has to have parsed this header already and made sure that at least
  * @hdr_size bytes are still available for pull in @skb.
  *
  * The packet may still get dropped. This can happen when the encapsulated
- * ethernet frame is invalid or contains again an batman-adv packet. Also
- * unicast packets will be dropped directly when it was sent between two
+ * ethernet frame is invalid or contains again a batman-adv packet. Also
+ * unicast packets will be dropped directly when they were sent between two
  * isolated clients.
  */
 void batadv_interface_rx(struct net_device *mesh_iface,
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 1ba206e402733..4cf9e3c54ad3b 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -944,7 +944,7 @@ static int batadv_netlink_set_hardif(struct sk_buff *skb,
 }
 
 /**
- * batadv_netlink_dump_hardif() - Dump all hard interface into a messages
+ * batadv_netlink_dump_hardif() - Dump all hard interfaces into a message
  * @msg: Netlink message to dump into
  * @cb: Parameters from query
  *
@@ -1101,7 +1101,7 @@ static int batadv_netlink_get_vlan(struct sk_buff *skb, struct genl_info *info)
 }
 
 /**
- * batadv_netlink_set_vlan() - Get vlan attributes
+ * batadv_netlink_set_vlan() - Set vlan attributes
  * @skb: Netlink message with request data
  * @info: receiver information
  *
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index b161232c10885..9b38bd9e8da7e 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -439,7 +439,7 @@ batadv_orig_ifinfo_new(struct batadv_orig_node *orig_node,
 }
 
 /**
- * batadv_neigh_ifinfo_get() - find the ifinfo from an neigh_node
+ * batadv_neigh_ifinfo_get() - find the ifinfo from a neigh_node
  * @neigh: the neigh node to be queried
  * @if_outgoing: the interface for which the ifinfo should be acquired
  *
@@ -472,7 +472,7 @@ batadv_neigh_ifinfo_get(struct batadv_neigh_node *neigh,
 }
 
 /**
- * batadv_neigh_ifinfo_new() - search and possibly create an neigh_ifinfo object
+ * batadv_neigh_ifinfo_new() - search and possibly create a neigh_ifinfo object
  * @neigh: the neigh node to be queried
  * @if_outgoing: the interface for which the ifinfo should be acquired
  *
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index cd75daea478c5..403c854568704 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -48,7 +48,7 @@ static void batadv_tvlv_handler_release(struct kref *ref)
 }
 
 /**
- * batadv_tvlv_handler_put() - decrement the tvlv container refcounter and
+ * batadv_tvlv_handler_put() - decrement the tvlv handler refcounter and
  *  possibly release it
  * @tvlv_handler: the tvlv handler to free
  */
@@ -272,7 +272,7 @@ void batadv_tvlv_container_register(struct batadv_priv *bat_priv,
  * @additional_packet_len: requested additional packet size on top of minimum
  *  size
  *
- * Return: true of the packet buffer could be changed to the requested size,
+ * Return: true if the packet buffer could be changed to the requested size,
  * false otherwise.
  */
 static bool batadv_tvlv_realloc_packet_buff(struct batadv_ogm_buf *ogm_buff,
-- 
2.47.3


