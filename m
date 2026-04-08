Return-Path: <netdev+bounces-276457-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDqPFANA1mkFCwgAu9opvQ
	(envelope-from <netdev+bounces-276457-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 13:46:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F443BB6DE
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 13:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3F513034642
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 11:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61462388E50;
	Wed,  8 Apr 2026 11:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jKNBcrEB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E905033C52F
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 11:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775648670; cv=none; b=ZkFELl+pHzn7ZDKzzZF1bJJ4UkodColoOHQzDFVBk5hkQOV6rQ//HUleD4EjIrcnfRhtpd/wCMiR6LNwnBSXNJ2CCtOatBIkqr7+npRGrAp44sc6bratMRm+WGaH0tIflPljYQNF54NA/2aDh599Mm+PpkB0W08RJ26q7w+GnLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775648670; c=relaxed/simple;
	bh=eaDNAfFoNI+f+ubir42g+VQNnnUC6EChAbBzsvcegaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYnoM/LQLGgZ2Tcmr16r5rIT2CFAUg4PxCSNVBbls7Z4YVS0zi1n2sy+9OgJds5pMrmcjoOwEerOAWGqGzkPSmEXepaxXr+H863h/C3Idh3NaZhfJOP2qqeOFz0tPm7zReCuI+204vnKTxRpt7VcqrkPjPqRjVBdjNBQsD1RyFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jKNBcrEB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775648667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f7q0qRSRszARAN4LccnaXW/nt7S9HdGvFiuMTOZO9xM=;
	b=jKNBcrEBTPVt3UUqfUAdszvjPTHtbokxUkorefcT2yCjJwkEm7ysmI7J6WAuUxExEseW1b
	wpap/Gh9uGrtxLLcY3EmeIEPbygS6gFdPsb+7pIgf+P57BvPg+Tgdqfjcfkg3POc/LLBMJ
	fIu5njks9CAl2zYe5ZzShaTWfMWBr0Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-P6M8fJ2NMHqDWmenjB8qug-1; Wed,
 08 Apr 2026 07:44:22 -0400
X-MC-Unique: P6M8fJ2NMHqDWmenjB8qug-1
X-Mimecast-MFC-AGG-ID: P6M8fJ2NMHqDWmenjB8qug_1775648660
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7812019560A1;
	Wed,  8 Apr 2026 11:44:20 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.173])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2A01E1800361;
	Wed,  8 Apr 2026 11:44:15 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	netdev@vger.kernel.org
Subject: [PATCH iwl-next 2/2] i40e: keep track of per queue gso counters.
Date: Wed,  8 Apr 2026 13:43:46 +0200
Message-ID: <c70f2e9d8cbc4af419356ed022bc60a8c9cfc7d2.1775648513.git.pabeni@redhat.com>
In-Reply-To: <cover.1775648513.git.pabeni@redhat.com>
References: <cover.1775648513.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-276457-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C2F443BB6DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Track the number of GSO and wire packets transmitted and expose the
counters via the queue stats.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h             |  2 ++
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 13 ++++++++++++-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |  8 +++++++-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h        |  2 ++
 drivers/net/ethernet/intel/i40e/i40e_txrx_common.h |  6 +++++-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c         |  2 +-
 6 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index fe642c464e9c..4a88c7d69f61 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -845,6 +845,8 @@ struct i40e_vsi {
 	u64 tx_stopped_base;
 	u64 tx_bytes;
 	u64 tx_packets;
+	u64 tx_gso_packets;
+	u64 tx_gso_wire_packets;
 	u64 rx_buf_failed;
 	u64 rx_page_failed;
 	u64 rx_page_reuse;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 0d0b3619ec56..7c2af738ccc5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11695,6 +11695,8 @@ static void i40e_vsi_aggregate_tx_counters(struct i40e_vsi *vsi,
 
 	vsi->tx_bytes += tx_ring->stats.bytes;
 	vsi->tx_packets += tx_ring->stats.packets;
+	vsi->tx_gso_packets += tx_ring->tx_stats.tx_gso_packets;
+	vsi->tx_gso_wire_packets += tx_ring->tx_stats.tx_gso_wire_packets;
 }
 
 static void i40e_vsi_aggregate_rx_counters(struct i40e_vsi *vsi,
@@ -13684,6 +13686,8 @@ static void i40e_zero_tx_ring_stats(struct netdev_queue_stats_tx *tx)
 {
 	tx->bytes = 0;
 	tx->packets = 0;
+	tx->hw_gso_packets = 0;
+	tx->hw_gso_wire_packets = 0;
 	tx->stop = 0;
 	tx->wake = 0;
 	tx->hw_drops = 0;
@@ -13692,17 +13696,21 @@ static void i40e_zero_tx_ring_stats(struct netdev_queue_stats_tx *tx)
 static void i40e_add_tx_ring_stats(struct i40e_ring *tx_ring,
 				   struct netdev_queue_stats_tx *tx)
 {
-	u64 bytes, packets;
+	u64 bytes, packets, gso_packets, gso_wire_packets;
 	unsigned int start;
 
 	do {
 		start = u64_stats_fetch_begin(&tx_ring->syncp);
 		bytes = tx_ring->stats.bytes;
 		packets = tx_ring->stats.packets;
+		gso_packets = tx_ring->tx_stats.tx_gso_packets;
+		gso_wire_packets = tx_ring->tx_stats.tx_gso_wire_packets;
 	} while (u64_stats_fetch_retry(&tx_ring->syncp, start));
 
 	tx->bytes += bytes;
 	tx->packets += packets;
+	tx->hw_gso_packets += gso_packets;
+	tx->hw_gso_wire_packets += gso_wire_packets;
 
 	tx->stop += tx_ring->tx_stats.tx_stopped;
 	tx->wake += tx_ring->tx_stats.restart_queue;
@@ -13743,6 +13751,9 @@ static void i40e_get_base_stats(struct net_device *dev,
 
 	tx->bytes = vsi->tx_bytes;
 	tx->packets = vsi->tx_packets;
+	tx->hw_gso_packets = vsi->tx_gso_packets;
+	tx->hw_gso_wire_packets = vsi->tx_gso_wire_packets;
+
 	tx->wake = vsi->tx_restart_base;
 	tx->stop = vsi->tx_stopped_base;
 	tx->hw_drops = vsi->tx_busy_base;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 894f2d06d39d..ec61cc43ae39 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -928,6 +928,7 @@ static bool i40e_clean_tx_irq(struct i40e_vsi *vsi,
 			      struct i40e_ring *tx_ring, int napi_budget,
 			      unsigned int *tx_cleaned)
 {
+	unsigned int total_gso_packets = 0, total_gso_wire_packets = 0;
 	int i = tx_ring->next_to_clean;
 	struct i40e_tx_buffer *tx_buf;
 	struct i40e_tx_desc *tx_head;
@@ -959,6 +960,10 @@ static bool i40e_clean_tx_irq(struct i40e_vsi *vsi,
 		/* update the statistics for this packet */
 		total_bytes += tx_buf->bytecount;
 		total_packets += tx_buf->gso_segs;
+		if (tx_buf->gso_segs > 1) {
+			total_gso_packets++;
+			total_gso_wire_packets += tx_buf->gso_segs;
+		}
 
 		/* free the skb/XDP data */
 		if (ring_is_xdp(tx_ring))
@@ -1018,7 +1023,8 @@ static bool i40e_clean_tx_irq(struct i40e_vsi *vsi,
 
 	i += tx_ring->count;
 	tx_ring->next_to_clean = i;
-	i40e_update_tx_stats(tx_ring, total_packets, total_bytes);
+	i40e_update_tx_stats(tx_ring, total_packets, total_bytes,
+			     total_gso_packets, total_gso_wire_packets);
 	i40e_arm_wb(tx_ring, vsi, budget);
 
 	if (ring_is_xdp(tx_ring))
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index 1e5fd63d47f4..15c608378467 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -295,6 +295,8 @@ struct i40e_tx_queue_stats {
 	u64 tx_linearize;
 	u64 tx_force_wb;
 	u64 tx_stopped;
+	u64 tx_gso_packets;
+	u64 tx_gso_wire_packets;
 	int prev_pkt_ctr;
 };
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h b/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
index e26807fd2123..24220594ff1a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
@@ -45,11 +45,15 @@ static inline __le64 build_ctob(u32 td_cmd, u32 td_offset, unsigned int size,
  **/
 static inline void i40e_update_tx_stats(struct i40e_ring *tx_ring,
 					unsigned int total_packets,
-					unsigned int total_bytes)
+					unsigned int total_bytes,
+					unsigned int total_gso,
+					unsigned int total_gso_wire)
 {
 	u64_stats_update_begin(&tx_ring->syncp);
 	tx_ring->stats.bytes += total_bytes;
 	tx_ring->stats.packets += total_packets;
+	tx_ring->tx_stats.tx_gso_packets += total_gso;
+	tx_ring->tx_stats.tx_gso_wire_packets += total_gso_wire;
 	u64_stats_update_end(&tx_ring->syncp);
 	tx_ring->q_vector->tx.total_bytes += total_bytes;
 	tx_ring->q_vector->tx.total_packets += total_packets;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 9f47388eaba5..c2a465416a33 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -599,7 +599,7 @@ static bool i40e_xmit_zc(struct i40e_ring *xdp_ring, unsigned int budget)
 	i40e_set_rs_bit(xdp_ring);
 	i40e_xdp_ring_update_tail(xdp_ring);
 
-	i40e_update_tx_stats(xdp_ring, nb_pkts, total_bytes);
+	i40e_update_tx_stats(xdp_ring, nb_pkts, total_bytes, 0, 0);
 
 	return nb_pkts < budget;
 }
-- 
2.53.0


