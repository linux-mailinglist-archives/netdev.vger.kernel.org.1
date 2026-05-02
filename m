Return-Path: <netdev+bounces-283393-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOh+Lwrc9WkXQAIAu9opvQ
	(envelope-from <netdev+bounces-283393-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 13:12:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E32D4B1B73
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 13:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AEB06300D90C
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 11:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A803128D9;
	Sat,  2 May 2026 11:12:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F96231A21;
	Sat,  2 May 2026 11:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777720326; cv=none; b=PwWnWOqG/HRM1yNwTHUNsWZieq1sVzLh+6Dhs6fcgFK+oEzaQPafURv9ZtwR9QyY0L5HY+eVQ6w+QXMhfOgXsJNDIGR0HCPadozYURA6DfAcJGrlD2eIZMnupirkOeb1L0vGxGb3oDgzchCM47wjF7yVjpGoegdUWN3T7cc8SDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777720326; c=relaxed/simple;
	bh=6xd8XYBBRfH34GmxNLjSoqN0+MDrhUKk2oqtQc0jTog=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aVlkaiCvHy9DcxCbw4++53b8d7Yzj1urX0h5TPOU0EtzGbe+ko6v6cDXMH200z/xFELH9royKbqkBvQcBK+FeuRfGnN3zUCFlW784dCxvSrIE9wJe2m5vUOqK+f1V1EHoqSGr1Hhop1+e/zAf5l7lkU+VboiNnJRiBzoUpGCK/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wJ80C-000000007J3-2knb;
	Sat, 02 May 2026 10:55:16 +0000
Date: Sat, 2 May 2026 11:55:02 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>,
	Christian Marangi <ansuelsmth@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net v6] net: dsa: mt7530: fix .get_stats64 sleeping in atomic
 context
Message-ID: <6940b913da2c29156f0feff74b678d3c526ee84c.1777719253.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 0E32D4B1B73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283393-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[makrotopia.org];
	FREEMAIL_TO(0.00)[arinc9.com,makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,armlinux.org.uk,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,stats_work.work:url]

The .get_stats64 callback runs in atomic context, but on
MDIO-connected switches every register read acquires the MDIO bus
mutex, which can sleep:
[   12.645973] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:609
[   12.654442] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 759, name: grep
[   12.663377] preempt_count: 0, expected: 0
[   12.667410] RCU nest depth: 1, expected: 0
[   12.671511] INFO: lockdep is turned off.
[   12.675441] CPU: 0 UID: 0 PID: 759 Comm: grep Tainted: G S      W           7.0.0+ #0 PREEMPT
[   12.675453] Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
[   12.675456] Hardware name: Bananapi BPI-R64 (DT)
[   12.675459] Call trace:
[   12.675462]  show_stack+0x14/0x1c (C)
[   12.675477]  dump_stack_lvl+0x68/0x8c
[   12.675487]  dump_stack+0x14/0x1c
[   12.675495]  __might_resched+0x14c/0x220
[   12.675504]  __might_sleep+0x44/0x80
[   12.675511]  __mutex_lock+0x50/0xb10
[   12.675523]  mutex_lock_nested+0x20/0x30
[   12.675532]  mt7530_get_stats64+0x40/0x2ac
[   12.675542]  dsa_user_get_stats64+0x2c/0x40
[   12.675553]  dev_get_stats+0x44/0x1e0
[   12.675564]  dev_seq_printf_stats+0x24/0xe0
[   12.675575]  dev_seq_show+0x14/0x3c
[   12.675583]  seq_read_iter+0x37c/0x480
[   12.675595]  seq_read+0xd0/0xec
[   12.675605]  proc_reg_read+0x94/0xe4
[   12.675615]  vfs_read+0x98/0x29c
[   12.675625]  ksys_read+0x54/0xdc
[   12.675633]  __arm64_sys_read+0x18/0x20
[   12.675642]  invoke_syscall.constprop.0+0x54/0xec
[   12.675653]  do_el0_svc+0x3c/0xb4
[   12.675662]  el0_svc+0x38/0x200
[   12.675670]  el0t_64_sync_handler+0x98/0xdc
[   12.675679]  el0t_64_sync+0x158/0x15c

For MDIO-connected switches, poll MIB counters asynchronously using a
delayed workqueue every second and let .get_stats64 return the cached
values under a spinlock. A mod_delayed_work() call on each read
triggers an immediate refresh so counters stay responsive when queried
more frequently.

MMIO-connected switches (MT7988, EN7581, AN7583) are not affected
because their regmap does not sleep, so they continue to read MIB
counters directly in .get_stats64.

Fixes: 88c810f35ed5 ("net: dsa: mt7530: implement .get_stats64")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Acked-by: Chester A. Unal <chester.a.unal@arinc9.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v6:
 * reintroduce .teardown() for cancel_delayed_work_sync(), drop
   cancel_delayed_work_sync() from .remove()

v5:
 * spin_lock_init() and INIT_DELAYED_WORK() in probe()
 * drop teardown as cancel_delayed_work_sync() in remove() is
   sufficient and now symmetric with init happening in probe()

v4:
 * extract mt7530_stats_refresh() helper from mt7530_stats_poll()
   -> mt7530_stats_poll() now just refreshes and re-arms
 * call helper synchronously in mt753x_setup() to seed the cache
 * avoid zeroed counters during the first poll interval
 * avoid INITIAL_JIFFIES vs stats_last==0 wraparound on 32-bit
 * swap deprecated system_wq for system_percpu_wq in get_stats64
 * keeps on-demand refresh on the same queue as schedule_*_work

v3:
 * move `stats_last` access under the spinlock to avoid potential race

v2:
 * use spin_lock_bh()/spin_unlock_bh() to prevent potential deadlock
 * rate-limit mod_delayed_work() refresh to at most once per 100ms
 * move cancel_delayed_work_sync() after dsa_unregister_switch()
 * add mt753x_teardown() callback to cancel the stats work
 * fix commit message

 drivers/net/dsa/mt7530.c | 75 ++++++++++++++++++++++++++++++++++++++--
 drivers/net/dsa/mt7530.h |  8 +++++
 2 files changed, 80 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index b9423389c2ef..44d670904ad8 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -25,6 +25,9 @@
 
 #include "mt7530.h"
 
+#define MT7530_STATS_POLL_INTERVAL	(1 * HZ)
+#define MT7530_STATS_RATE_LIMIT		(HZ / 10)
+
 static struct mt753x_pcs *pcs_to_mt753x_pcs(struct phylink_pcs *pcs)
 {
 	return container_of(pcs, struct mt753x_pcs, pcs);
@@ -906,10 +909,9 @@ static void mt7530_get_rmon_stats(struct dsa_switch *ds, int port,
 	*ranges = mt7530_rmon_ranges;
 }
 
-static void mt7530_get_stats64(struct dsa_switch *ds, int port,
-			       struct rtnl_link_stats64 *storage)
+static void mt7530_read_port_stats64(struct mt7530_priv *priv, int port,
+				     struct rtnl_link_stats64 *storage)
 {
-	struct mt7530_priv *priv = ds->priv;
 	uint64_t data;
 
 	/* MIB counter doesn't provide a FramesTransmittedOK but instead
@@ -951,6 +953,54 @@ static void mt7530_get_stats64(struct dsa_switch *ds, int port,
 			       &storage->rx_crc_errors);
 }
 
+static void mt7530_stats_refresh(struct mt7530_priv *priv)
+{
+	struct rtnl_link_stats64 stats = {};
+	struct dsa_port *dp;
+	int port;
+
+	dsa_switch_for_each_user_port(dp, priv->ds) {
+		port = dp->index;
+
+		mt7530_read_port_stats64(priv, port, &stats);
+
+		spin_lock_bh(&priv->stats_lock);
+		priv->ports[port].stats = stats;
+		priv->stats_last = jiffies;
+		spin_unlock_bh(&priv->stats_lock);
+	}
+}
+
+static void mt7530_stats_poll(struct work_struct *work)
+{
+	struct mt7530_priv *priv = container_of(work, struct mt7530_priv,
+						stats_work.work);
+
+	mt7530_stats_refresh(priv);
+	schedule_delayed_work(&priv->stats_work,
+			      MT7530_STATS_POLL_INTERVAL);
+}
+
+static void mt7530_get_stats64(struct dsa_switch *ds, int port,
+			       struct rtnl_link_stats64 *storage)
+{
+	struct mt7530_priv *priv = ds->priv;
+	bool refresh;
+
+	if (priv->bus) {
+		spin_lock_bh(&priv->stats_lock);
+		*storage = priv->ports[port].stats;
+		refresh = time_after(jiffies, priv->stats_last +
+					      MT7530_STATS_RATE_LIMIT);
+		spin_unlock_bh(&priv->stats_lock);
+		if (refresh)
+			mod_delayed_work(system_percpu_wq,
+					 &priv->stats_work, 0);
+	} else {
+		mt7530_read_port_stats64(priv, port, storage);
+	}
+}
+
 static void mt7530_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
 				      struct ethtool_eth_ctrl_stats *ctrl_stats)
 {
@@ -3137,9 +3187,24 @@ mt753x_setup(struct dsa_switch *ds)
 	if (ret && priv->irq_domain)
 		mt7530_free_mdio_irq(priv);
 
+	if (!ret && priv->bus) {
+		mt7530_stats_refresh(priv);
+		schedule_delayed_work(&priv->stats_work,
+				      MT7530_STATS_POLL_INTERVAL);
+	}
+
 	return ret;
 }
 
+static void
+mt753x_teardown(struct dsa_switch *ds)
+{
+	struct mt7530_priv *priv = ds->priv;
+
+	if (priv->bus)
+		cancel_delayed_work_sync(&priv->stats_work);
+}
+
 static int mt753x_set_mac_eee(struct dsa_switch *ds, int port,
 			      struct ethtool_keee *e)
 {
@@ -3257,6 +3322,7 @@ static int mt7988_setup(struct dsa_switch *ds)
 static const struct dsa_switch_ops mt7530_switch_ops = {
 	.get_tag_protocol	= mtk_get_tag_protocol,
 	.setup			= mt753x_setup,
+	.teardown		= mt753x_teardown,
 	.preferred_default_local_cpu_port = mt753x_preferred_default_local_cpu_port,
 	.get_strings		= mt7530_get_strings,
 	.get_ethtool_stats	= mt7530_get_ethtool_stats,
@@ -3395,6 +3461,9 @@ mt7530_probe_common(struct mt7530_priv *priv)
 	priv->ds->ops = &mt7530_switch_ops;
 	priv->ds->phylink_mac_ops = &mt753x_phylink_mac_ops;
 	mutex_init(&priv->reg_mutex);
+	spin_lock_init(&priv->stats_lock);
+	INIT_DELAYED_WORK(&priv->stats_work, mt7530_stats_poll);
+
 	dev_set_drvdata(dev, priv);
 
 	return 0;
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 3e0090bed298..dd33b0df3419 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -796,6 +796,7 @@ struct mt7530_fdb {
  * @pvid:	The VLAN specified is to be considered a PVID at ingress.  Any
  *		untagged frames will be assigned to the related VLAN.
  * @sgmii_pcs:	Pointer to PCS instance for SerDes ports
+ * @stats:	Cached port statistics for MDIO-connected switches
  */
 struct mt7530_port {
 	bool enable;
@@ -803,6 +804,7 @@ struct mt7530_port {
 	u32 pm;
 	u16 pvid;
 	struct phylink_pcs *sgmii_pcs;
+	struct rtnl_link_stats64 stats;
 };
 
 /* Port 5 mode definitions of the MT7530 switch */
@@ -875,6 +877,9 @@ struct mt753x_info {
  * @create_sgmii:	Pointer to function creating SGMII PCS instance(s)
  * @active_cpu_ports:	Holding the active CPU ports
  * @mdiodev:		The pointer to the MDIO device structure
+ * @stats_lock:		Protects cached per-port stats from concurrent access
+ * @stats_work:		Delayed work for polling MIB counters on MDIO switches
+ * @stats_last:		Jiffies timestamp of last MIB counter poll
  */
 struct mt7530_priv {
 	struct device		*dev;
@@ -900,6 +905,9 @@ struct mt7530_priv {
 	int (*create_sgmii)(struct mt7530_priv *priv);
 	u8 active_cpu_ports;
 	struct mdio_device *mdiodev;
+	spinlock_t stats_lock; /* protects cached stats counters */
+	struct delayed_work stats_work;
+	unsigned long stats_last;
 };
 
 struct mt7530_hw_vlan_entry {
-- 
2.53.0

