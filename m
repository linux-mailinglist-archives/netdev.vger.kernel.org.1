Return-Path: <netdev+bounces-277621-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLeGHWmT2WnxqwgAu9opvQ
	(envelope-from <netdev+bounces-277621-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 02:18:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C516A3DDB3B
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 02:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BAED30724FE
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 00:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DBF1A2C0B;
	Sat, 11 Apr 2026 00:13:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850B31A2392;
	Sat, 11 Apr 2026 00:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775866425; cv=none; b=p6g3yOGILFipWeDizywlaX5HSKgU0tbO7jfZJWei/gFouHEPEo/Jw0ZEJemRGOn5od5TMzB1JFvI/ZlWeg1ukwjelvxrwFr1cwIjf09IbINmc1bnHToF8vtVOkq/1kUtf+VVKeMjZvARjWWeXiDd2OTl8gtmWLmapBfUr/dmB7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775866425; c=relaxed/simple;
	bh=fBXPu/qJrXYzLZgDKSLk7+jXw874VJUADGugUTiSuFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pF4LJGNp9QKcQv1VlPBCqnfhaHljwx5M8n9jXRb3RCwVl7rGdtv+F7ZV57Tg692YAiEPY+BJqV9cImJhgmHehe4hJ0SAbkyF8uejsAhX5mNdhkgcLu9NLrQ2fReggo7D5445g3BPNJTbFCxFBJ7tmcWnSUd3U8Fv4hczi5yDND0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wBLyl-0000000071v-16JN;
	Sat, 11 Apr 2026 00:13:39 +0000
Date: Sat, 11 Apr 2026 01:13:36 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next 2/2] net: dsa: mxl862xx: implement .get_stats64
Message-ID: <57737946ae9e76006fbe65ca83cb8143a8074b22.1775865049.git.daniel@makrotopia.org>
References: <cover.1775865049.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1775865049.git.daniel@makrotopia.org>
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[makrotopia.org];
	TAGGED_FROM(0.00)[bounces-277621-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FREEMAIL_CC(0.00)[gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[makrotopia.org:email,makrotopia.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C516A3DDB3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Poll free-running firmware RMON counters every 2 seconds and accumulate
deltas into 64-bit per-port statistics. 32-bit packet counters wrap
in ~220s at 10 Gbps line rate with minimum-size frames; the 2s polling
interval provides a comfortable margin. The .get_stats64 callback
forces a fresh poll so that counters are always up to date when queried.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/mxl862xx/mxl862xx-host.c |   8 +-
 drivers/net/dsa/mxl862xx/mxl862xx.c      | 174 +++++++++++++++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx.h      |  94 +++++++++++-
 3 files changed, 269 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-host.c b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
index cadbdb590cf43..d55f9dff6433e 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-host.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
@@ -48,7 +48,7 @@ static void mxl862xx_crc_err_work_fn(struct work_struct *work)
 		dev_close(dp->conduit);
 	rtnl_unlock();
 
-	clear_bit(0, &priv->crc_err);
+	clear_bit(MXL862XX_FLAG_CRC_ERR, &priv->flags);
 }
 
 /* Firmware CRC error codes (outside normal Zephyr errno range). */
@@ -247,7 +247,7 @@ static int mxl862xx_issue_cmd(struct mxl862xx_priv *priv, u16 cmd, u16 len)
 
 	ret = mxl862xx_crc6_verify(ctrl_enc, len_enc, &fw_result);
 	if (ret) {
-		if (!test_and_set_bit(0, &priv->crc_err))
+		if (!test_and_set_bit(MXL862XX_FLAG_CRC_ERR, &priv->flags))
 			schedule_work(&priv->crc_err_work);
 		return -EIO;
 	}
@@ -314,7 +314,7 @@ static int mxl862xx_send_cmd(struct mxl862xx_priv *priv, u16 cmd, u16 size,
 	if (ret < 0) {
 		if ((ret == MXL862XX_FW_CRC6_ERR ||
 		     ret == MXL862XX_FW_CRC16_ERR) &&
-		    !test_and_set_bit(0, &priv->crc_err))
+		    !test_and_set_bit(MXL862XX_FLAG_CRC_ERR, &priv->flags))
 			schedule_work(&priv->crc_err_work);
 		if (!quiet)
 			dev_err(&priv->mdiodev->dev,
@@ -458,7 +458,7 @@ int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *_data,
 	}
 
 	if (crc16(0xffff, (const u8 *)data, size) != crc) {
-		if (!test_and_set_bit(0, &priv->crc_err))
+		if (!test_and_set_bit(MXL862XX_FLAG_CRC_ERR, &priv->flags))
 			schedule_work(&priv->crc_err_work);
 		ret = -EIO;
 		goto out;
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
index 8159f6a66d724..01b3ebd62231a 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
@@ -30,6 +30,12 @@
 #define MXL862XX_API_READ_QUIET(dev, cmd, data) \
 	mxl862xx_api_wrap(dev, cmd, &(data), sizeof((data)), true, true)
 
+/* Polling interval for RMON counter accumulation. At 2.5 Gbps with
+ * minimum-size (64-byte) frames, a 32-bit packet counter wraps in ~880s.
+ * 2s gives a comfortable margin.
+ */
+#define MXL862XX_STATS_POLL_INTERVAL	(2 * HZ)
+
 struct mxl862xx_mib_desc {
 	unsigned int size;
 	unsigned int offset;
@@ -686,6 +692,9 @@ static int mxl862xx_setup(struct dsa_switch *ds)
 	if (ret)
 		return ret;
 
+	schedule_delayed_work(&priv->stats_work,
+			      MXL862XX_STATS_POLL_INTERVAL);
+
 	return mxl862xx_setup_mdio(ds);
 }
 
@@ -1879,6 +1888,158 @@ static void mxl862xx_get_pause_stats(struct dsa_switch *ds, int port,
 	pause_stats->rx_pause_frames = le32_to_cpu(cnt.rx_good_pause_pkts);
 }
 
+/* Compute the delta between two 32-bit free-running counter snapshots,
+ * handling a single wrap-around correctly via unsigned subtraction.
+ */
+static u64 mxl862xx_delta32(u32 cur, u32 prev)
+{
+	return (u32)(cur - prev);
+}
+
+/**
+ * mxl862xx_stats_poll - Read RMON counters and accumulate into 64-bit stats
+ * @ds: DSA switch
+ * @port: port index
+ *
+ * The firmware RMON counters are free-running 32-bit values (64-bit for
+ * byte counters). This function reads the hardware via MDIO (may sleep),
+ * computes deltas from the previous snapshot, and accumulates them into
+ * 64-bit per-port stats under a spinlock.
+ *
+ * Called only from the stats polling workqueue -- serialized by the
+ * single-threaded delayed_work, so no MDIO locking is needed here.
+ */
+static void mxl862xx_stats_poll(struct dsa_switch *ds, int port)
+{
+	struct mxl862xx_priv *priv = ds->priv;
+	struct mxl862xx_port_stats *s = &priv->ports[port].stats;
+	u32 rx_fcserr, rx_under, rx_over, rx_align, tx_drop;
+	u32 rx_drop, rx_evlan, mtu_exc, tx_acm;
+	struct mxl862xx_rmon_port_cnt cnt;
+	u64 rx_bytes, tx_bytes;
+	u32 rx_mcast, tx_coll;
+	u32 rx_pkts, tx_pkts;
+
+	/* MDIO read -- may sleep, done outside the spinlock. */
+	if (mxl862xx_read_rmon(ds, port, &cnt))
+		return;
+
+	rx_pkts   = le32_to_cpu(cnt.rx_good_pkts);
+	tx_pkts   = le32_to_cpu(cnt.tx_good_pkts);
+	rx_bytes  = le64_to_cpu(cnt.rx_good_bytes);
+	tx_bytes  = le64_to_cpu(cnt.tx_good_bytes);
+	rx_fcserr = le32_to_cpu(cnt.rx_fcserror_pkts);
+	rx_under  = le32_to_cpu(cnt.rx_under_size_error_pkts);
+	rx_over   = le32_to_cpu(cnt.rx_oversize_error_pkts);
+	rx_align  = le32_to_cpu(cnt.rx_align_error_pkts);
+	tx_drop   = le32_to_cpu(cnt.tx_dropped_pkts);
+	rx_drop   = le32_to_cpu(cnt.rx_dropped_pkts);
+	rx_evlan  = le32_to_cpu(cnt.rx_extended_vlan_discard_pkts);
+	mtu_exc   = le32_to_cpu(cnt.mtu_exceed_discard_pkts);
+	tx_acm    = le32_to_cpu(cnt.tx_acm_dropped_pkts);
+	rx_mcast  = le32_to_cpu(cnt.rx_multicast_pkts);
+	tx_coll   = le32_to_cpu(cnt.tx_coll_count);
+
+	/* Accumulate deltas under spinlock -- .get_stats64 reads these. */
+	spin_lock_bh(&priv->ports[port].stats_lock);
+
+	s->rx_packets += mxl862xx_delta32(rx_pkts, s->prev_rx_good_pkts);
+	s->tx_packets += mxl862xx_delta32(tx_pkts, s->prev_tx_good_pkts);
+	s->rx_bytes   += rx_bytes - s->prev_rx_good_bytes;
+	s->tx_bytes   += tx_bytes - s->prev_tx_good_bytes;
+
+	s->rx_errors +=
+		mxl862xx_delta32(rx_fcserr, s->prev_rx_fcserror_pkts) +
+		mxl862xx_delta32(rx_under, s->prev_rx_under_size_error_pkts) +
+		mxl862xx_delta32(rx_over, s->prev_rx_oversize_error_pkts) +
+		mxl862xx_delta32(rx_align, s->prev_rx_align_error_pkts);
+	s->tx_errors +=
+		mxl862xx_delta32(tx_drop, s->prev_tx_dropped_pkts);
+
+	s->rx_dropped +=
+		mxl862xx_delta32(rx_drop, s->prev_rx_dropped_pkts) +
+		mxl862xx_delta32(rx_evlan, s->prev_rx_evlan_discard_pkts) +
+		mxl862xx_delta32(mtu_exc, s->prev_mtu_exceed_discard_pkts);
+	s->tx_dropped +=
+		mxl862xx_delta32(tx_drop, s->prev_tx_dropped_pkts) +
+		mxl862xx_delta32(tx_acm, s->prev_tx_acm_dropped_pkts);
+
+	s->multicast  += mxl862xx_delta32(rx_mcast, s->prev_rx_multicast_pkts);
+	s->collisions += mxl862xx_delta32(tx_coll, s->prev_tx_coll_count);
+
+	s->rx_length_errors +=
+		mxl862xx_delta32(rx_under, s->prev_rx_under_size_error_pkts) +
+		mxl862xx_delta32(rx_over, s->prev_rx_oversize_error_pkts);
+	s->rx_crc_errors +=
+		mxl862xx_delta32(rx_fcserr, s->prev_rx_fcserror_pkts);
+	s->rx_frame_errors +=
+		mxl862xx_delta32(rx_align, s->prev_rx_align_error_pkts);
+
+	s->prev_rx_good_pkts             = rx_pkts;
+	s->prev_tx_good_pkts             = tx_pkts;
+	s->prev_rx_good_bytes            = rx_bytes;
+	s->prev_tx_good_bytes            = tx_bytes;
+	s->prev_rx_fcserror_pkts         = rx_fcserr;
+	s->prev_rx_under_size_error_pkts = rx_under;
+	s->prev_rx_oversize_error_pkts   = rx_over;
+	s->prev_rx_align_error_pkts      = rx_align;
+	s->prev_tx_dropped_pkts          = tx_drop;
+	s->prev_rx_dropped_pkts          = rx_drop;
+	s->prev_rx_evlan_discard_pkts    = rx_evlan;
+	s->prev_mtu_exceed_discard_pkts  = mtu_exc;
+	s->prev_tx_acm_dropped_pkts      = tx_acm;
+	s->prev_rx_multicast_pkts        = rx_mcast;
+	s->prev_tx_coll_count            = tx_coll;
+
+	spin_unlock_bh(&priv->ports[port].stats_lock);
+}
+
+static void mxl862xx_stats_work_fn(struct work_struct *work)
+{
+	struct mxl862xx_priv *priv =
+		container_of(work, struct mxl862xx_priv, stats_work.work);
+	struct dsa_switch *ds = priv->ds;
+	struct dsa_port *dp;
+
+	dsa_switch_for_each_available_port(dp, ds)
+		mxl862xx_stats_poll(ds, dp->index);
+
+	if (!test_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags))
+		schedule_delayed_work(&priv->stats_work,
+				      MXL862XX_STATS_POLL_INTERVAL);
+}
+
+static void mxl862xx_get_stats64(struct dsa_switch *ds, int port,
+				 struct rtnl_link_stats64 *s)
+{
+	struct mxl862xx_priv *priv = ds->priv;
+	struct mxl862xx_port_stats *ps = &priv->ports[port].stats;
+
+	spin_lock_bh(&priv->ports[port].stats_lock);
+
+	s->rx_packets = ps->rx_packets;
+	s->tx_packets = ps->tx_packets;
+	s->rx_bytes = ps->rx_bytes;
+	s->tx_bytes = ps->tx_bytes;
+	s->rx_errors = ps->rx_errors;
+	s->tx_errors = ps->tx_errors;
+	s->rx_dropped = ps->rx_dropped;
+	s->tx_dropped = ps->tx_dropped;
+	s->multicast = ps->multicast;
+	s->collisions = ps->collisions;
+	s->rx_length_errors = ps->rx_length_errors;
+	s->rx_crc_errors = ps->rx_crc_errors;
+	s->rx_frame_errors = ps->rx_frame_errors;
+
+	spin_unlock_bh(&priv->ports[port].stats_lock);
+
+	/* Trigger a fresh poll so the next read sees up-to-date counters.
+	 * No-op if the work is already pending, running, or teardown started.
+	 */
+	if (!test_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags))
+		schedule_delayed_work(&priv->stats_work, 0);
+}
+
 static const struct dsa_switch_ops mxl862xx_switch_ops = {
 	.get_tag_protocol = mxl862xx_get_tag_protocol,
 	.setup = mxl862xx_setup,
@@ -1909,6 +2070,7 @@ static const struct dsa_switch_ops mxl862xx_switch_ops = {
 	.get_eth_mac_stats = mxl862xx_get_eth_mac_stats,
 	.get_eth_ctrl_stats = mxl862xx_get_eth_ctrl_stats,
 	.get_pause_stats = mxl862xx_get_pause_stats,
+	.get_stats64 = mxl862xx_get_stats64,
 };
 
 static void mxl862xx_phylink_mac_config(struct phylink_config *config,
@@ -1970,16 +2132,22 @@ static int mxl862xx_probe(struct mdio_device *mdiodev)
 		priv->ports[i].priv = priv;
 		INIT_WORK(&priv->ports[i].host_flood_work,
 			  mxl862xx_host_flood_work_fn);
+		spin_lock_init(&priv->ports[i].stats_lock);
 	}
 
+	INIT_DELAYED_WORK(&priv->stats_work, mxl862xx_stats_work_fn);
+
 	dev_set_drvdata(dev, ds);
 
 	err = dsa_register_switch(ds);
 	if (err) {
+		set_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags);
+		cancel_delayed_work_sync(&priv->stats_work);
 		mxl862xx_host_shutdown(priv);
 		for (i = 0; i < MXL862XX_MAX_PORTS; i++)
 			cancel_work_sync(&priv->ports[i].host_flood_work);
 	}
+
 	return err;
 }
 
@@ -1994,6 +2162,9 @@ static void mxl862xx_remove(struct mdio_device *mdiodev)
 
 	priv = ds->priv;
 
+	set_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags);
+	cancel_delayed_work_sync(&priv->stats_work);
+
 	dsa_unregister_switch(ds);
 
 	mxl862xx_host_shutdown(priv);
@@ -2020,6 +2191,9 @@ static void mxl862xx_shutdown(struct mdio_device *mdiodev)
 
 	dsa_switch_shutdown(ds);
 
+	set_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags);
+	cancel_delayed_work_sync(&priv->stats_work);
+
 	mxl862xx_host_shutdown(priv);
 
 	for (i = 0; i < MXL862XX_MAX_PORTS; i++)
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.h b/drivers/net/dsa/mxl862xx/mxl862xx.h
index a010cf6b961a9..80053ab40e4ce 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.h
@@ -116,6 +116,79 @@ struct mxl862xx_evlan_block {
 	u16 n_active;
 };
 
+/**
+ * struct mxl862xx_port_stats - 64-bit accumulated hardware port statistics
+ * @rx_packets: total received packets
+ * @tx_packets: total transmitted packets
+ * @rx_bytes: total received bytes
+ * @tx_bytes: total transmitted bytes
+ * @rx_errors: total receive errors
+ * @tx_errors: total transmit errors
+ * @rx_dropped: total received packets dropped
+ * @tx_dropped: total transmitted packets dropped
+ * @multicast: total received multicast packets
+ * @collisions: total transmit collisions
+ * @rx_length_errors: received length errors (undersize + oversize)
+ * @rx_crc_errors: received FCS errors
+ * @rx_frame_errors: received alignment errors
+ * @prev_rx_good_pkts: previous snapshot of rx good packet counter
+ * @prev_tx_good_pkts: previous snapshot of tx good packet counter
+ * @prev_rx_good_bytes: previous snapshot of rx good byte counter
+ * @prev_tx_good_bytes: previous snapshot of tx good byte counter
+ * @prev_rx_fcserror_pkts: previous snapshot of rx FCS error counter
+ * @prev_rx_under_size_error_pkts: previous snapshot of rx undersize
+ *                                 error counter
+ * @prev_rx_oversize_error_pkts: previous snapshot of rx oversize
+ *                               error counter
+ * @prev_rx_align_error_pkts: previous snapshot of rx alignment
+ *                            error counter
+ * @prev_tx_dropped_pkts: previous snapshot of tx dropped counter
+ * @prev_rx_dropped_pkts: previous snapshot of rx dropped counter
+ * @prev_rx_evlan_discard_pkts: previous snapshot of extended VLAN
+ *                              discard counter
+ * @prev_mtu_exceed_discard_pkts: previous snapshot of MTU exceed
+ *                                discard counter
+ * @prev_tx_acm_dropped_pkts: previous snapshot of tx ACM dropped
+ *                            counter
+ * @prev_rx_multicast_pkts: previous snapshot of rx multicast counter
+ * @prev_tx_coll_count: previous snapshot of tx collision counter
+ *
+ * The firmware RMON counters are 32-bit free-running (64-bit for byte
+ * counters). This structure holds 64-bit accumulators alongside the
+ * previous raw snapshot so that deltas can be computed across polls,
+ * handling 32-bit wrap correctly via unsigned subtraction.
+ */
+struct mxl862xx_port_stats {
+	u64 rx_packets;
+	u64 tx_packets;
+	u64 rx_bytes;
+	u64 tx_bytes;
+	u64 rx_errors;
+	u64 tx_errors;
+	u64 rx_dropped;
+	u64 tx_dropped;
+	u64 multicast;
+	u64 collisions;
+	u64 rx_length_errors;
+	u64 rx_crc_errors;
+	u64 rx_frame_errors;
+	u32 prev_rx_good_pkts;
+	u32 prev_tx_good_pkts;
+	u64 prev_rx_good_bytes;
+	u64 prev_tx_good_bytes;
+	u32 prev_rx_fcserror_pkts;
+	u32 prev_rx_under_size_error_pkts;
+	u32 prev_rx_oversize_error_pkts;
+	u32 prev_rx_align_error_pkts;
+	u32 prev_tx_dropped_pkts;
+	u32 prev_rx_dropped_pkts;
+	u32 prev_rx_evlan_discard_pkts;
+	u32 prev_mtu_exceed_discard_pkts;
+	u32 prev_tx_acm_dropped_pkts;
+	u32 prev_rx_multicast_pkts;
+	u32 prev_tx_coll_count;
+};
+
 /**
  * struct mxl862xx_port - per-port state tracked by the driver
  * @priv:                back-pointer to switch private data; needed by
@@ -145,6 +218,10 @@ struct mxl862xx_evlan_block {
  *                       The worker acquires rtnl_lock() to serialize with
  *                       DSA callbacks and checks @setup_done to avoid
  *                       acting on torn-down ports.
+ * @stats:               64-bit accumulated hardware statistics; updated
+ *                       periodically by the stats polling work
+ * @stats_lock:          protects accumulator reads in .get_stats64 against
+ *                       concurrent updates from the polling work
  */
 struct mxl862xx_port {
 	struct mxl862xx_priv *priv;
@@ -160,16 +237,24 @@ struct mxl862xx_port {
 	bool host_flood_uc;
 	bool host_flood_mc;
 	struct work_struct host_flood_work;
+	struct mxl862xx_port_stats stats;
+	spinlock_t stats_lock; /* protects stats accumulators */
 };
 
+/* Bit indices for struct mxl862xx_priv::flags */
+#define MXL862XX_FLAG_CRC_ERR		0
+#define MXL862XX_FLAG_WORK_STOPPED	1
+
 /**
  * struct mxl862xx_priv - driver private data for an MxL862xx switch
  * @ds:                 pointer to the DSA switch instance
  * @mdiodev:            MDIO device used to communicate with the switch firmware
  * @crc_err_work:       deferred work for shutting down all ports on MDIO CRC
  *                      errors
- * @crc_err:            set atomically before CRC-triggered shutdown, cleared
- *                      after
+ * @flags:              atomic status flags; %MXL862XX_FLAG_CRC_ERR is set
+ *                      before CRC-triggered shutdown and cleared after;
+ *                      %MXL862XX_FLAG_WORK_STOPPED is set before cancelling
+ *                      stats_work to prevent rescheduling during teardown
  * @drop_meter:         index of the single shared zero-rate firmware meter
  *                      used to unconditionally drop traffic (used to block
  *                      flooding)
@@ -181,18 +266,21 @@ struct mxl862xx_port {
  * @evlan_ingress_size: per-port ingress Extended VLAN block size
  * @evlan_egress_size:  per-port egress Extended VLAN block size
  * @vf_block_size:      per-port VLAN Filter block size
+ * @stats_work:         periodic work item that polls RMON hardware counters
+ *                      and accumulates them into 64-bit per-port stats
  */
 struct mxl862xx_priv {
 	struct dsa_switch *ds;
 	struct mdio_device *mdiodev;
 	struct work_struct crc_err_work;
-	unsigned long crc_err;
+	unsigned long flags;
 	u16 drop_meter;
 	struct mxl862xx_port ports[MXL862XX_MAX_PORTS];
 	u16 bridges[MXL862XX_MAX_BRIDGES + 1];
 	u16 evlan_ingress_size;
 	u16 evlan_egress_size;
 	u16 vf_block_size;
+	struct delayed_work stats_work;
 };
 
 #endif /* __MXL862XX_H */
-- 
2.53.0

