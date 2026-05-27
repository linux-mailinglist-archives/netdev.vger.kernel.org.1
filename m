Return-Path: <netdev+bounces-292313-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +A/uIuz4FmrUywcAu9opvQ
	(envelope-from <netdev+bounces-292313-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:00:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E69CE5E5773
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A4DA307A0D6
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 13:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5A04266AA;
	Wed, 27 May 2026 13:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M580UgNA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453A3425CD6;
	Wed, 27 May 2026 13:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890088; cv=none; b=Dw1JScuQma90Z4bGIqq8u5De8MaBkBdsPuf4aiNydlCYQRe007ObnzxJ3OcOqmaxl3NQoNRROhTBiay0kwuPoAlfxHFDvTeZY/n0jdc1tgFyD7vMydT+Mg4AMLRGSTdfBDTklKnw3rJ3AAab699ibRUHYTyHq4WArOKPmDRTGq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890088; c=relaxed/simple;
	bh=PTA2tk37oIHoIeZUUQzgzeoil7nCSqx1Dch5pAf51cU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/dzMXjv64JpbxvFwrQ0Sfg3lybUxlYBnMqDrBDD/w8rPHGLnRFa/pGZPIjKOnY3xKgasjyFJ5E3ybMeOZZ8pnpqO69jyIVMgHlweRDdkL5KqZ2VOD/IQt1ZM6HZk5bZUs3r9ByPnCPH5sg9HF5oo/bOqEUnwo5E+/osQ4Fy9lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M580UgNA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DC01F00A3F;
	Wed, 27 May 2026 13:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779890087;
	bh=IPcDae4ZCfJ5pYPjGuJ/ARN0iiDxLlatSg3CAqEakb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M580UgNACIDqueuhGHAuknan5ZCaVI4wiXpBTdX74AUbHFQWJweInaENy443vM2fC
	 oQJcKIN+wN5y2P4s91RHVFuPaQiSnbIhnOhvtW6Yf6c47gyUlVaBXJljCN/I7UXn2s
	 6VM+7sLPaq/m8uMJrYekfvzT7N19xB+ltgOKg/EveyH/SQEXB0h0Dt3NFg46Duat4I
	 q+dTwalBpYya/uUVbuqrEiPRHWa0IUd36CZLhHtXbBuzVbS6vxPqzO8Au1wymlHgcA
	 73QsoOtwY97ThIjOF3jUISLl+7KhnQZ3OXBFx+/Ie26TPb43BzU9VNN5FHxcmYeSWX
	 dFU3m0YWNYq7g==
From: hawk@kernel.org
To: netdev@vger.kernel.org
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v6 5/5] veth: time-based BQL completion coalescing via ethtool tx-usecs
Date: Wed, 27 May 2026 15:54:16 +0200
Message-ID: <20260527135418.1166665-6-hawk@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527135418.1166665-1-hawk@kernel.org>
References: <20260527135418.1166665-1-hawk@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[tu-dortmund.de,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-292313-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,tu-dortmund.de:email]
X-Rspamd-Queue-Id: E69CE5E5773
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Simon Schippers <simon.schippers@tu-dortmund.de>

Per-packet BQL completion forces DQL to converge on limit=2, causing
excessive NAPI scheduling overhead and qdisc requeues.

Accumulate BQL completions and flush them when a configurable time
threshold is exceeded, letting DQL discover a limit that bounds actual
queuing delay to the configured interval. Coalescing state persists
across NAPI polls in struct veth_rq so completions can accumulate
beyond a single budget=64 cycle.

Add ethtool tx-usecs support for runtime tuning. Default is 100 us;
setting tx-usecs to 0 disables coalescing and falls back to per-packet
completion.

  ethtool -C <veth-dev> tx-usecs 500  # 500us coalescing
  ethtool -C <veth-dev> tx-usecs 0    # per-packet (no coalescing)

Co-developed-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---
 drivers/net/veth.c | 100 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 98 insertions(+), 2 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index d5675d9d5236..743d17b37223 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -28,6 +28,7 @@
 #include <linux/bpf_trace.h>
 #include <linux/net_tstamp.h>
 #include <linux/skbuff_ref.h>
+#include <linux/sched/clock.h>
 #include <net/page_pool/helpers.h>
 
 #define DRV_NAME	"veth"
@@ -44,6 +45,8 @@
 #define VETH_XDP_TX_BULK_SIZE	16
 #define VETH_XDP_BATCH		16
 
+#define VETH_BQL_COAL_TX_USECS	100 /* default tx-usecs for BQL batching */
+
 struct veth_stats {
 	u64	rx_drops;
 	/* xdp */
@@ -62,6 +65,11 @@ struct veth_rq_stats {
 	struct u64_stats_sync	syncp;
 };
 
+struct veth_bql_state {
+	u64	time;	/* sched_clock() when current coalescing window started */
+	int	n_bql;	/* BQL completions batched in the current window */
+};
+
 struct veth_rq {
 	struct napi_struct	xdp_napi;
 	struct napi_struct __rcu *napi; /* points to xdp_napi when the latter is initialized */
@@ -69,6 +77,7 @@ struct veth_rq {
 	struct bpf_prog __rcu	*xdp_prog;
 	struct xdp_mem_info	xdp_mem;
 	struct veth_rq_stats	stats;
+	struct veth_bql_state	bql_state;
 	bool			rx_notify_masked;
 	struct ptr_ring		xdp_ring;
 	struct xdp_rxq_info	xdp_rxq;
@@ -81,6 +90,7 @@ struct veth_priv {
 	struct bpf_prog		*_xdp_prog;
 	struct veth_rq		*rq;
 	unsigned int		requested_headroom;
+	unsigned int		tx_coal_usecs;	/* BQL completion coalescing */
 };
 
 struct veth_xdp_tx_bq {
@@ -265,7 +275,30 @@ static void veth_get_channels(struct net_device *dev,
 static int veth_set_channels(struct net_device *dev,
 			     struct ethtool_channels *ch);
 
+static int veth_get_coalesce(struct net_device *dev,
+			     struct ethtool_coalesce *ec,
+			     struct kernel_ethtool_coalesce *kernel_coal,
+			     struct netlink_ext_ack *extack)
+{
+	struct veth_priv *priv = netdev_priv(dev);
+
+	ec->tx_coalesce_usecs = priv->tx_coal_usecs;
+	return 0;
+}
+
+static int veth_set_coalesce(struct net_device *dev,
+			     struct ethtool_coalesce *ec,
+			     struct kernel_ethtool_coalesce *kernel_coal,
+			     struct netlink_ext_ack *extack)
+{
+	struct veth_priv *priv = netdev_priv(dev);
+
+	priv->tx_coal_usecs = ec->tx_coalesce_usecs;
+	return 0;
+}
+
 static const struct ethtool_ops veth_ethtool_ops = {
+	.supported_coalesce_params = ETHTOOL_COALESCE_TX_USECS,
 	.get_drvinfo		= veth_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
 	.get_strings		= veth_get_strings,
@@ -275,6 +308,8 @@ static const struct ethtool_ops veth_ethtool_ops = {
 	.get_ts_info		= ethtool_op_get_ts_info,
 	.get_channels		= veth_get_channels,
 	.set_channels		= veth_set_channels,
+	.get_coalesce		= veth_get_coalesce,
+	.set_coalesce		= veth_set_coalesce,
 };
 
 /* general routines */
@@ -937,13 +972,45 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 	return NULL;
 }
 
+static void veth_bql_complete(struct veth_bql_state *state,
+			      struct netdev_queue *peer_txq)
+{
+	netdev_tx_completed_queue(peer_txq, state->n_bql,
+				  state->n_bql * VETH_BQL_UNIT);
+	state->n_bql = 0;
+	state->time = sched_clock();
+}
+
+static void veth_bql_maybe_complete(struct veth_bql_state *state,
+				    struct netdev_queue *peer_txq,
+				    u64 coalescing_ns)
+{
+	if (state->n_bql && sched_clock() >= state->time + coalescing_ns)
+		veth_bql_complete(state, peer_txq);
+}
+
 static int veth_xdp_rcv(struct veth_rq *rq, int budget,
 			struct veth_xdp_tx_bq *bq,
 			struct veth_stats *stats,
 			struct netdev_queue *peer_txq)
 {
+	struct veth_bql_state *state = &rq->bql_state;
 	int i, done = 0, n_xdpf = 0;
 	void *xdpf[VETH_XDP_BATCH];
+	struct veth_priv *priv;
+	u64 bql_flush_ns;
+
+	priv = netdev_priv(rq->dev);
+	bql_flush_ns = (u64)priv->tx_coal_usecs * 1000;
+
+	/* Clamp stored timestamp in case we migrated to a CPU with a behind
+	 * sched_clock(); prevents the deadline from never firing.
+	 */
+	state->time = min(state->time, sched_clock());
+
+	/* Flush completions that timed out since the previous NAPI poll. */
+	if (peer_txq && bql_flush_ns)
+		veth_bql_maybe_complete(state, peer_txq, bql_flush_ns);
 
 	for (i = 0; i < budget; i++) {
 		void *ptr = __ptr_ring_consume(&rq->xdp_ring);
@@ -972,8 +1039,16 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
 			struct sk_buff *skb = veth_ptr_to_skb(ptr);
 
 			stats->xdp_bytes += skb->len;
-			if (peer_txq && bql_charged)
-				netdev_tx_completed_queue(peer_txq, 1, VETH_BQL_UNIT);
+			if (peer_txq && bql_charged) {
+				if (!bql_flush_ns) {
+					netdev_tx_completed_queue(peer_txq, 1,
+								  VETH_BQL_UNIT);
+				} else {
+					state->n_bql++;
+					veth_bql_maybe_complete(state, peer_txq,
+								bql_flush_ns);
+				}
+			}
 
 			skb = veth_xdp_rcv_skb(rq, skb, bq, stats);
 			if (skb) {
@@ -989,6 +1064,18 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
 	if (n_xdpf)
 		veth_xdp_rcv_bulk_skb(rq, xdpf, n_xdpf, bq, stats);
 
+	/* If the ring is now empty and the peer TX queue is stalled by DQL
+	 * backpressure, release completions immediately to unblock it.
+	 */
+	if (peer_txq && state->n_bql && __ptr_ring_empty(&rq->xdp_ring)) {
+		/* Pairs with smp_wmb() in __ptr_ring_produce(); ensure ring
+		 * emptiness is observed before reading peer_txq->state.
+		 */
+		smp_rmb();
+		if (test_bit(__QUEUE_STATE_STACK_XOFF, &peer_txq->state))
+			veth_bql_complete(state, peer_txq);
+	}
+
 	u64_stats_update_begin(&rq->stats.syncp);
 	rq->stats.vs.xdp_redirect += stats->xdp_redirect;
 	rq->stats.vs.xdp_bytes += stats->xdp_bytes;
@@ -1093,6 +1180,9 @@ static int __veth_napi_enable_range(struct net_device *dev, int start, int end)
 
 		napi_enable(&rq->xdp_napi);
 		rcu_assign_pointer(priv->rq[i].napi, &priv->rq[i].xdp_napi);
+
+		rq->bql_state.time = sched_clock();
+		rq->bql_state.n_bql = 0;
 	}
 
 	return 0;
@@ -1134,6 +1224,8 @@ static void veth_napi_del_range(struct net_device *dev, int start, int end)
 		struct veth_rq *rq = &priv->rq[i];
 
 		rq->rx_notify_masked = false;
+		rq->bql_state.n_bql = 0;
+		rq->bql_state.time = 0;
 		ptr_ring_cleanup(&rq->xdp_ring, veth_ptr_free);
 	}
 
@@ -1813,6 +1905,8 @@ static const struct xdp_metadata_ops veth_xdp_metadata_ops = {
 
 static void veth_setup(struct net_device *dev)
 {
+	struct veth_priv *priv = netdev_priv(dev);
+
 	ether_setup(dev);
 
 	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
@@ -1838,6 +1932,8 @@ static void veth_setup(struct net_device *dev)
 	dev->max_mtu = ETH_MAX_MTU;
 	dev->watchdog_timeo = msecs_to_jiffies(16000);
 
+	priv->tx_coal_usecs = VETH_BQL_COAL_TX_USECS;
+
 	dev->hw_features = VETH_FEATURES;
 	dev->hw_enc_features = VETH_FEATURES;
 	dev->mpls_features = NETIF_F_HW_CSUM | NETIF_F_GSO_SOFTWARE;
-- 
2.43.0


