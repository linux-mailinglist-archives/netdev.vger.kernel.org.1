Return-Path: <netdev+bounces-300516-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1yNYO201NGoeRgYAu9opvQ
	(envelope-from <netdev+bounces-300516-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 20:14:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAA76A2113
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 20:14:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OY8kDmta;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300516-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300516-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9C093025292
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 18:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CFC3563F6;
	Thu, 18 Jun 2026 18:14:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B0F2BEFFF
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 18:14:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781806442; cv=none; b=PaSYNLnpcVNJqy2CNRm/gTqgE2/nywmQZFlYaLLuOerdxtxINJXfs5UzU4JuUhoeb8VugFApkqg5InZ+sYC4nRyTwoYOMvGO88AP/9D7Kzfm65POD30hkKPn8H3Gj6/KIAwes3pXu/ewrm3LBEYJRPZTYaIpvUMQLp0+jlrdhco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781806442; c=relaxed/simple;
	bh=gUG1uHxZ678hOX6pgWw39VDHLrV03DeE5BNTge89lKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tgWDtkk1D9Qhf9m5Spv5SK1HwTo3uAiwPG+L6pMxKWcJTOSsxB69VyI4ZjvzatFsJ+ZykiP31YIcJzWP1dPKnWn8IjluqW8ZweVX5DahOastnLqb7zXO9VtoF+OCTmJbrBEfBsKm0EIvxZQeBMSkN0CRz8/6YfKf3JCFVSb6q4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OY8kDmta; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4831F000E9;
	Thu, 18 Jun 2026 18:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781806441;
	bh=8VoVWMHy2fc5Sk1hPQECjKS/Z9dsos1yQRYbFOl/neY=;
	h=From:To:Cc:Subject:Date;
	b=OY8kDmtawlJfhh0szkzCvMCa6IHDyLY0B/Qa57SPO/GWxfc08bWakwU/g3xj+6zrD
	 mYsKbjzBk0JdP9zNuTBuLmhdkUPkeEE6hFE4XwZY5Oo0159r8uitRy3xw6sxdXFcAL
	 hlHd8DKPudfDdXP5fEjvKu7bxRUqQTj+MjBvLXrYM5yexa29CXolc6iS55bsFSnm90
	 2NXubiOxbMQzNWX0GH5VRPmIMAuIES3/EGx24oxFE5UZumI9s2xh0TxIbLuJFdOhHt
	 ByoYJbhQj8CVfN5osj4ACEIlptX4N4qABCzQVuHPr6voXee0rGSMzuJupd3okYXpOq
	 UlqSAQ34WD1lw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com
Subject: [PATCH net] eth: bnxt: improve the timing of stats
Date: Thu, 18 Jun 2026 11:13:58 -0700
Message-ID: <20260618181358.3037661-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300516-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:kuba@kernel.org,m:michael.chan@broadcom.com,m:pavan.chebbi@broadcom.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ntuple.py:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1FAA76A2113

Kernel selftests wait 1.25x of the promised stats refresh time
(as read from ethtool -c). bnxt reports 1sec by default, but
the stats update process has two steps. First device DMAs the
new values, then the service task performs update in full-width
SW counters. So the worst case delay is actually 2x.

Note that there is bnxt_hwrm_port_qstats() but the qstats here
probably stands for "query stats", and the command itself
updates detailed MAC-level stats (MAC errors, RMON histogram etc.)
It must not be updating the stats we care about, otherwise
update would be synchronous, and this patch would make no
difference (and it does help).

The problem of stale stats impacts not only tests but real workloads
which monitor egress bandwidth of a NIC. The inaccuracy causes double
counting in the next cycle and spurious overload alarms.

Try to read from the DMA buffer more aggressively, to mitigate
timing issues between DMA and service task. The SW update should
be cheap.

Fixes: 51f307856b60 ("bnxt_en: Allow statistics DMA to be configurable using ethtool -C.")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: michael.chan@broadcom.com
CC: pavan.chebbi@broadcom.com

With this patch I had a 50 clean runs of ntuple.py in a row.
Previously it'd fail within 5 runs at most.

Hopefully this is good enough, in the past I sent an RFC to
convert the driver to use SW stats for everything. That felt
a little drastic.
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  4 +++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 36 +++++++++++++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  8 +++++
 3 files changed, 48 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 6d312259f852..aab6e88c3ca1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2620,6 +2620,9 @@ struct bnxt {
 #define BNXT_MIN_STATS_COAL_TICKS	  250000
 #define BNXT_MAX_STATS_COAL_TICKS	 1000000
 
+	spinlock_t		stats_lock;
+	unsigned long		stats_updated_jiffies;
+
 	struct work_struct	sp_task;
 	unsigned long		sp_event;
 #define BNXT_RX_NTP_FLTR_SP_EVENT	1
@@ -3027,6 +3030,7 @@ void bnxt_reenable_sriov(struct bnxt *bp);
 void bnxt_close_nic(struct bnxt *, bool, bool);
 void bnxt_get_ring_drv_stats(struct bnxt *bp,
 			     struct bnxt_total_ring_drv_stats *stats);
+void bnxt_sync_stats(struct bnxt *bp);
 bool bnxt_rfs_capable(struct bnxt *bp, bool new_rss_ctx);
 int bnxt_dbg_hwrm_rd_reg(struct bnxt *bp, u32 reg_off, u16 num_words,
 			 u32 *reg_buf);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 055e93a417b6..25462f854478 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10575,6 +10575,35 @@ static void bnxt_accumulate_all_stats(struct bnxt *bp)
 	}
 }
 
+/* Re-accumulate stats from DMA buffers if stale.
+ * uAPIs for reading sw_stats should call this first.
+ *
+ * We promise user space update frequency of bp->stats_coal_ticks but
+ * the update is a two step process - first device updates the DMA buffer,
+ * then we have to update from that buffer to driver stats in the service work.
+ * Worst case we would be 2x off from the desired frequency.
+ * Sync the stats sooner, if stale. The 20% threshold was chosen arbitrarily.
+ *
+ * Ideally we would split the user-configured time into two portions,
+ * i.e. also lower the DMA period by the 20%. But the DMA timer seems to have
+ * too coarse granularity to play such tricks.
+ */
+void bnxt_sync_stats(struct bnxt *bp)
+{
+	unsigned long stale;
+
+	if (!netif_running(bp->dev) || !bp->stats_coal_ticks)
+		return;
+
+	spin_lock(&bp->stats_lock);
+	stale = usecs_to_jiffies(bp->stats_coal_ticks / 5);
+	if (time_after_eq(jiffies, bp->stats_updated_jiffies + stale)) {
+		bnxt_accumulate_all_stats(bp);
+		bp->stats_updated_jiffies = jiffies;
+	}
+	spin_unlock(&bp->stats_lock);
+}
+
 static int bnxt_hwrm_port_qstats(struct bnxt *bp, u8 flags)
 {
 	struct hwrm_port_qstats_input *req;
@@ -13577,6 +13606,7 @@ bnxt_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
 		return;
 	}
 
+	bnxt_sync_stats(bp);
 	bnxt_get_ring_stats(bp, stats);
 	bnxt_add_prev_stats(bp, stats);
 
@@ -14753,7 +14783,10 @@ static void bnxt_sp_task(struct work_struct *work)
 	if (test_and_clear_bit(BNXT_PERIODIC_STATS_SP_EVENT, &bp->sp_event)) {
 		bnxt_hwrm_port_qstats(bp, 0);
 		bnxt_hwrm_port_qstats_ext(bp, 0);
+		spin_lock(&bp->stats_lock);
 		bnxt_accumulate_all_stats(bp);
+		bp->stats_updated_jiffies = jiffies;
+		spin_unlock(&bp->stats_lock);
 	}
 
 	if (test_and_clear_bit(BNXT_LINK_CHNG_SP_EVENT, &bp->sp_event)) {
@@ -15488,6 +15521,7 @@ static int bnxt_init_board(struct pci_dev *pdev, struct net_device *dev)
 	INIT_DELAYED_WORK(&bp->fw_reset_task, bnxt_fw_reset_task);
 
 	spin_lock_init(&bp->ntp_fltr_lock);
+	spin_lock_init(&bp->stats_lock);
 #if BITS_PER_LONG == 32
 	spin_lock_init(&bp->db_lock);
 #endif
@@ -16056,6 +16090,7 @@ static void bnxt_get_queue_stats_rx(struct net_device *dev, int i,
 	if (!bp->bnapi)
 		return;
 
+	bnxt_sync_stats(bp);
 	cpr = &bp->bnapi[i]->cp_ring;
 	sw = cpr->stats.sw_stats;
 
@@ -16084,6 +16119,7 @@ static void bnxt_get_queue_stats_tx(struct net_device *dev, int i,
 	if (!bp->tx_ring)
 		return;
 
+	bnxt_sync_stats(bp);
 	bnapi = bp->tx_ring[bp->tx_ring_map[i]].bnapi;
 	sw = bnapi->cp_ring.stats.sw_stats;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 56d74a3c24b7..835b54287579 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -606,6 +606,7 @@ static void bnxt_get_ethtool_stats(struct net_device *dev,
 		goto skip_ring_stats;
 	}
 
+	bnxt_sync_stats(bp);
 	tpa_stats = bnxt_get_num_tpa_ring_stats(bp);
 	for (i = 0; i < bp->cp_nr_rings; i++) {
 		struct bnxt_napi *bnapi = bp->bnapi[i];
@@ -3310,6 +3311,7 @@ static void bnxt_get_fec_stats(struct net_device *dev,
 	if (BNXT_VF(bp) || !(bp->flags & BNXT_FLAG_PORT_STATS_EXT))
 		return;
 
+	bnxt_sync_stats(bp);
 	rx = bp->rx_port_stats_ext.sw_stats;
 	fec_stats->corrected_bits.total =
 		*(rx + BNXT_RX_STATS_EXT_OFFSET(rx_corrected_bits));
@@ -3409,6 +3411,7 @@ static void bnxt_get_pause_stats(struct net_device *dev,
 	if (BNXT_VF(bp) || !(bp->flags & BNXT_FLAG_PORT_STATS))
 		return;
 
+	bnxt_sync_stats(bp);
 	rx = bp->port_stats.sw_stats;
 	tx = bp->port_stats.sw_stats + BNXT_TX_PORT_STATS_BYTE_OFFSET / 8;
 
@@ -5572,6 +5575,7 @@ static void bnxt_get_eth_phy_stats(struct net_device *dev,
 	if (BNXT_VF(bp) || !(bp->flags & BNXT_FLAG_PORT_STATS_EXT))
 		return;
 
+	bnxt_sync_stats(bp);
 	rx = bp->rx_port_stats_ext.sw_stats;
 	phy_stats->SymbolErrorDuringCarrier =
 		*(rx + BNXT_RX_STATS_EXT_OFFSET(rx_pcs_symbol_err));
@@ -5586,6 +5590,7 @@ static void bnxt_get_eth_mac_stats(struct net_device *dev,
 	if (BNXT_VF(bp) || !(bp->flags & BNXT_FLAG_PORT_STATS))
 		return;
 
+	bnxt_sync_stats(bp);
 	rx = bp->port_stats.sw_stats;
 	tx = bp->port_stats.sw_stats + BNXT_TX_PORT_STATS_BYTE_OFFSET / 8;
 
@@ -5610,6 +5615,7 @@ static void bnxt_get_eth_ctrl_stats(struct net_device *dev,
 	if (BNXT_VF(bp) || !(bp->flags & BNXT_FLAG_PORT_STATS))
 		return;
 
+	bnxt_sync_stats(bp);
 	rx = bp->port_stats.sw_stats;
 	ctrl_stats->MACControlFramesReceived =
 		BNXT_GET_RX_PORT_STATS64(rx, rx_ctrl_frames);
@@ -5639,6 +5645,7 @@ static void bnxt_get_rmon_stats(struct net_device *dev,
 	if (BNXT_VF(bp) || !(bp->flags & BNXT_FLAG_PORT_STATS))
 		return;
 
+	bnxt_sync_stats(bp);
 	rx = bp->port_stats.sw_stats;
 	tx = bp->port_stats.sw_stats + BNXT_TX_PORT_STATS_BYTE_OFFSET / 8;
 
@@ -5712,6 +5719,7 @@ static void bnxt_get_link_ext_stats(struct net_device *dev,
 	if (BNXT_VF(bp) || !(bp->flags & BNXT_FLAG_PORT_STATS_EXT))
 		return;
 
+	bnxt_sync_stats(bp);
 	rx = bp->rx_port_stats_ext.sw_stats;
 	stats->link_down_events =
 		*(rx + BNXT_RX_STATS_EXT_OFFSET(link_down_events));
-- 
2.54.0


