Return-Path: <netdev+bounces-211811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03723B1BC30
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 23:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3AF73B42D2
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 21:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B737A293B48;
	Tue,  5 Aug 2025 21:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CvlzPVMm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DB4289804
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 21:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754430753; cv=none; b=J38Kt8UhP9zaAx1VKaoVOtdDZiBO29FYXsyix82ICyXqgQkDqPrL3MIuhJmNJDcBIgQ+STWV1C4ERHGXGxEMFE8zccOopVv8XXtbDAW/o4BDYeD/75e+t7B50zl7v2jstnWUHNL2rTGll0ga2FjkXaEsiPDo0/Em4eciPfigs+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754430753; c=relaxed/simple;
	bh=GpE21D7A6WAgcI9z9Ofy11g6Qh+XMD2fAAFGrIwWZ2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eVhlUHxBGc6Yh2au3J4DpoNHNY3l6Me4IyzPUVNwhFUlHC2C2c+PD9Gpm+XFxHmO2JtvBLfZyvVQ0lsu6pkb36p+7RVP1JsICkqXN6HSyiyI74lkcptvcKpO4jKZMKclABMEWR7ce/NuhmB7sp6rfbz1l9+ornXmd/ZPjwu4dfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CvlzPVMm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754430750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ryKctY1hyx9C0SkxLiYJ6Kx2RUvA+Y9P19z9/L9mBa8=;
	b=CvlzPVMmAmOR0OGO53xNjgLGPZcbpddXxKyrrYkAPIm2GyOsQ4WwSYaPb0bm/t+3/fa0Oc
	NYpyenAAUVhBd/DzJHFmaaX6lyWwPNPqOI7X/wjxo/uroHR6WnrETz3+8VeqIlzPpRR4Je
	izZffL/6nGQ+J88di3lqH3wr3gBYrdw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-Kwuk70bcNwiO3j8s0gUb1Q-1; Tue,
 05 Aug 2025 17:52:27 -0400
X-MC-Unique: Kwuk70bcNwiO3j8s0gUb1Q-1
X-Mimecast-MFC-AGG-ID: Kwuk70bcNwiO3j8s0gUb1Q_1754430746
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 32CA719560B0;
	Tue,  5 Aug 2025 21:52:26 +0000 (UTC)
Received: from lima-lima (unknown [10.22.80.60])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7BBF53000199;
	Tue,  5 Aug 2025 21:52:24 +0000 (UTC)
From: Dennis Chen <dechen@redhat.com>
To: netdev@vger.kernel.org
Cc: dechen@redhat.com,
	dchen27@ncsu.edu,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	petrm@nvidia.com
Subject: [PATCH net-next 2/3] netdevsim: Add mock stats for ethtool
Date: Tue,  5 Aug 2025 17:33:55 -0400
Message-ID: <20250805213356.3348348-3-dechen@redhat.com>
In-Reply-To: <20250805213356.3348348-2-dechen@redhat.com>
References: <20250805213356.3348348-1-dechen@redhat.com>
 <20250805213356.3348348-2-dechen@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add mock stats exposed through ethtool -S for netdevsim. The stats are
incremented every 100ms. Mock stats are enabled/disabled through a
debugfs toggle.

        # echo y > /sys/kernel/debug/netdevsim/$DEV/ports/0/ethtool/mock_stats/enabled

Signed-off-by: Dennis Chen <dechen@redhat.com>
---
 drivers/net/netdevsim/ethtool.c   | 127 +++++++++++++++++++++++++++++-
 drivers/net/netdevsim/netdev.c    |   1 +
 drivers/net/netdevsim/netdevsim.h |  11 +++
 3 files changed, 138 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
index 33d39dfdd6d9..78aea02f8bf1 100644
--- a/drivers/net/netdevsim/ethtool.c
+++ b/drivers/net/netdevsim/ethtool.c
@@ -16,6 +16,10 @@ struct nsim_stat_desc {
 	.desc = #s,  \
 	.offset = offsetof(struct rtnl_link_stats64, s) }
 
+#define NSIM_MOCK_STAT_ENTRY(s) { \
+	.desc = #s,  \
+	.offset = offsetof(struct nsim_mock_stats, s) }
+
 static const struct nsim_stat_desc nsim_stats_desc[] = {
 	NSIM_STAT_ENTRY(tx_packets),
 	NSIM_STAT_ENTRY(rx_packets),
@@ -27,6 +31,14 @@ static const struct nsim_stat_desc nsim_stats_desc[] = {
 
 #define NSIM_STATS_LEN	ARRAY_SIZE(nsim_stats_desc)
 
+#define NSIM_MOCK_STATS_LEN	ARRAY_SIZE(nsim_mock_stats_desc)
+
+static const struct nsim_stat_desc nsim_mock_stats_desc[] = {
+	NSIM_MOCK_STAT_ENTRY(hw_out_of_sequence),
+	NSIM_MOCK_STAT_ENTRY(hw_out_of_buffer),
+	NSIM_MOCK_STAT_ENTRY(hw_packet_seq_err),
+};
+
 static void
 nsim_get_pause_stats(struct net_device *dev,
 		     struct ethtool_pause_stats *pause_stats)
@@ -204,9 +216,12 @@ static int nsim_get_ts_info(struct net_device *dev,
 
 static int nsim_sset_count(struct net_device *dev, int sset)
 {
+	struct netdevsim *ns = netdev_priv(dev);
+
 	switch (sset) {
 	case ETH_SS_STATS:
-		return NSIM_STATS_LEN;
+		return ns->ethtool.mock_stats.enabled ?
+			NSIM_STATS_LEN + NSIM_MOCK_STATS_LEN : NSIM_STATS_LEN;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -214,20 +229,51 @@ static int nsim_sset_count(struct net_device *dev, int sset)
 
 static void nsim_get_strings(struct net_device *dev, u32 sset, u8 *data)
 {
+	struct netdevsim *ns = netdev_priv(dev);
+
 	int i;
 
 	switch (sset) {
 	case ETH_SS_STATS:
 		for (i = 0; i < NSIM_STATS_LEN; i++)
 			ethtool_puts(&data, nsim_stats_desc[i].desc);
+		if (ns->ethtool.mock_stats.enabled)
+			for (i = 0; i < NSIM_MOCK_STATS_LEN; i++)
+				ethtool_puts(&data,
+					     nsim_mock_stats_desc[i].desc);
+
 		break;
 	}
 }
 
+static void nsim_ethtool_add_mock_stats(struct netdevsim *ns,
+					u64 *data)
+{
+	unsigned int start, i;
+	const u8 *stats_base;
+	const u64_stats_t *p;
+	size_t offset;
+
+	stats_base = (const u8 *)&ns->ethtool.mock_stats;
+
+	data += NSIM_STATS_LEN;
+
+	do {
+		start = u64_stats_fetch_begin(&ns->ethtool.mock_stats.syncp);
+		for (i = 0; i < NSIM_MOCK_STATS_LEN; i++) {
+			offset = nsim_mock_stats_desc[i].offset;
+
+			p = (const u64_stats_t *)(stats_base + offset);
+			data[i] = u64_stats_read(p);
+		}
+	} while (u64_stats_fetch_retry(&ns->ethtool.mock_stats.syncp, start));
+}
+
 static void nsim_get_ethtool_stats(struct net_device *dev,
 				   struct ethtool_stats *stats,
 				   u64 *data)
 {
+	struct netdevsim *ns;
 	struct rtnl_link_stats64 rtstats = {};
 	int i;
 
@@ -235,6 +281,33 @@ static void nsim_get_ethtool_stats(struct net_device *dev,
 
 	for (i = 0; i < NSIM_STATS_LEN; i++)
 		data[i] = *(u64 *)((u8 *)&rtstats + nsim_stats_desc[i].offset);
+
+	ns = netdev_priv(dev);
+
+	if (ns->ethtool.mock_stats.enabled)
+		nsim_ethtool_add_mock_stats(ns, data);
+}
+
+#define NSIM_MOCK_STATS_INTERVAL_MS 100
+
+static void nsim_mock_stats_traffic_bump(struct nsim_mock_stats *stats)
+{
+	if (stats->enabled) {
+		stats->hw_out_of_buffer += 1;
+		stats->hw_out_of_sequence += 1;
+		stats->hw_packet_seq_err += 1;
+	}
+}
+
+static void nsim_mock_stats_traffic_work(struct work_struct *work)
+{
+	struct nsim_mock_stats *stats;
+
+	stats = container_of(work, struct nsim_mock_stats, traffic_dw.work);
+	nsim_mock_stats_traffic_bump(stats);
+
+	schedule_delayed_work(&stats->traffic_dw,
+			      msecs_to_jiffies(NSIM_MOCK_STATS_INTERVAL_MS));
 }
 
 static const struct ethtool_ops nsim_ethtool_ops = {
@@ -269,6 +342,44 @@ static void nsim_ethtool_ring_init(struct netdevsim *ns)
 	ns->ethtool.ring.tx_max_pending = 4096;
 }
 
+static void mock_stats_reset(struct nsim_mock_stats *mock_stats)
+{
+	mock_stats->hw_out_of_buffer = 0;
+	mock_stats->hw_out_of_sequence = 0;
+	mock_stats->hw_packet_seq_err = 0;
+}
+
+static ssize_t mock_stats_enabled_write(struct file *filp,
+					const char __user *ubuf,
+					size_t count,
+					loff_t *offp)
+{
+	bool enabled;
+	int r;
+	struct nsim_mock_stats *mock_stats = filp->private_data;
+	struct dentry *dentry = filp->f_path.dentry;
+
+	r = kstrtobool_from_user(ubuf, count, &enabled);
+	if (!r) {
+		r = debugfs_file_get(dentry);
+		if (unlikely(r))
+			return r;
+
+		mock_stats->enabled = enabled;
+		if (!enabled)
+			mock_stats_reset(mock_stats);
+
+		debugfs_file_put(dentry);
+	}
+
+	return count;
+}
+
+static struct debugfs_short_fops mock_stats_fops = {
+	.write = mock_stats_enabled_write,
+	.llseek = generic_file_llseek
+};
+
 void nsim_ethtool_init(struct netdevsim *ns)
 {
 	struct dentry *ethtool, *dir;
@@ -305,4 +416,18 @@ void nsim_ethtool_init(struct netdevsim *ns)
 			   &ns->ethtool.ring.rx_mini_max_pending);
 	debugfs_create_u32("tx_max_pending", 0600, dir,
 			   &ns->ethtool.ring.tx_max_pending);
+
+	dir = debugfs_create_dir("mock_stats", ethtool);
+	debugfs_create_file("enabled", 0600, dir, &ns->ethtool.mock_stats,
+			    &mock_stats_fops);
+
+	INIT_DELAYED_WORK(&ns->ethtool.mock_stats.traffic_dw,
+			  &nsim_mock_stats_traffic_work);
+	schedule_delayed_work(&ns->ethtool.mock_stats.traffic_dw,
+			      msecs_to_jiffies(NSIM_MOCK_STATS_INTERVAL_MS));
+}
+
+void nsim_ethtool_exit(struct netdevsim *ns)
+{
+	cancel_delayed_work_sync(&ns->ethtool.mock_stats.traffic_dw);
 }
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 39fe28af48b9..d1864b7cbbd5 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -1143,6 +1143,7 @@ void nsim_destroy(struct netdevsim *ns)
 	rtnl_unlock();
 	if (nsim_dev_port_is_pf(ns->nsim_dev_port))
 		nsim_exit_netdevsim(ns);
+	nsim_ethtool_exit(ns);
 
 	/* Put this intentionally late to exercise the orphaning path */
 	if (ns->page) {
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index bddd24c1389d..57631ec8887a 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -82,6 +82,15 @@ struct nsim_ethtool_pauseparam {
 	bool report_stats_tx;
 };
 
+struct nsim_mock_stats {
+	u64 hw_out_of_sequence;
+	u64 hw_out_of_buffer;
+	u64 hw_packet_seq_err;
+	struct u64_stats_sync syncp;
+	struct delayed_work traffic_dw;
+	bool enabled;
+};
+
 struct nsim_ethtool {
 	u32 get_err;
 	u32 set_err;
@@ -90,6 +99,7 @@ struct nsim_ethtool {
 	struct ethtool_coalesce coalesce;
 	struct ethtool_ringparam ring;
 	struct ethtool_fecparam fec;
+	struct nsim_mock_stats mock_stats;
 };
 
 struct nsim_rq {
@@ -150,6 +160,7 @@ void nsim_destroy(struct netdevsim *ns);
 bool netdev_is_nsim(struct net_device *dev);
 
 void nsim_ethtool_init(struct netdevsim *ns);
+void nsim_ethtool_exit(struct netdevsim *ns);
 
 void nsim_udp_tunnels_debugfs_create(struct nsim_dev *nsim_dev);
 int nsim_udp_tunnels_info_create(struct nsim_dev *nsim_dev,
-- 
2.50.1


