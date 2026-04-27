Return-Path: <netdev+bounces-281493-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDNVHVHO72mBGQEAu9opvQ
	(envelope-from <netdev+bounces-281493-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 23:00:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DBB47A724
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 22:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0337430069BC
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 20:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8113E401A03;
	Mon, 27 Apr 2026 20:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIEeEwTI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A833FE65D
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 20:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777323596; cv=none; b=lw/SFkBulemvE4f2w+yTycEeu44XuZlfxn16/RBurZmOuH9o0JBxX0XJkyGiht38JlEJ1S86tTPelsv/psfrEsz6uT95HOZesJ9IXhfh5CqnlsUGdSVn1QsgHvrJF34hqdy7PCWMFloyigDG4BQDTRBpZqNFfDwzbFjnY2zgkfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777323596; c=relaxed/simple;
	bh=T8j9eotcWVWo4HMzwY+nJE5ckP5eTodFyffIwLxlKDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ws4PnNz3UO5CQ2oLKWLVl3cUU83o90ALZp7HRTc9wZgZOFlR20D9bd92BeNxLx0CN1VNegDTn1u3PgwUiEa+gBVs90UnUZQfFuApQ1wp+WP0Vv6JQILFHXTNGbojE0FWgnrNO/6xyLKFdm38Y43gw87hBnB9ITAtwE/63eqXfgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIEeEwTI; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-79ab5fd969aso119590917b3.0
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 13:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777323590; x=1777928390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y90erLgpJzp5pcD4oJdjl1uzgncCBbxWXvu4GrKeDyU=;
        b=XIEeEwTI87RpK+dOifgibvR/UYx42HHsKzF9L2S8mTEA+sTD8Sl/XCHpRBKc60WZn7
         FA9Hq+ld6WvKJVWT6fvkc20DWFcXoKvRP02a0w1ZO0k36unx205x5kdhkxmZcT035O4O
         yBjRpv961Ygha3hOLZu7XWq0UxdGNK99I3H6A4Ds2mBYrdvf7A5kiuMoLBsQcQqs89sZ
         VY053zB0XJfU0vEwDEjYyfuUCQ/VdGX1Ob1t86ECv029EBUEmrTgMjI8CVnX6H8LifPw
         7dyoOdkiIuDHp+63lfAMR4WMfPlubAzYDxK3G5AI/GQxl0rj+rWyo/1YgACYrnmmRXtw
         MAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777323590; x=1777928390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y90erLgpJzp5pcD4oJdjl1uzgncCBbxWXvu4GrKeDyU=;
        b=FcB7hj7QQW24RvQl9hYoSuNBJPQr7Fr9TyK0Hz8JQzfQ/XIfEzloE8aCe3FzOjihvZ
         moPOqtwZZ4Wyut4Dhg+ac7Fja8+SK2vBGbSHwsuYfQwDyHLiBeG2VhWtHPQ+cZpYxS2+
         3/kB9EVZS7H8C47R2pZCCOlBpx8osdmxvEr++opMtBz/JrUo7xXUDVodaJp+P/Vt3iP1
         q1M3OH9bGklECSJx0VP671QpzukL9X7UE1TX1boi+XhhPalPONmbw3Joy8kj3S48t/cP
         snek8G9I5Tv35Ijx/FtOXZosy+OyDyTjKVDjgUQv6bzueuA5kI/BOiTF/s3wYstG+1LP
         pvGw==
X-Forwarded-Encrypted: i=1; AFNElJ++zSnOcDJcPvfC4y2527wjGKYsD53b+BVIDzsQvSRj1VN8zBkY2s5ThS2inqIThDd92h/efJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+ljeIB4rMJwJ5/32WBfcHgVAfMd1e7zrsdUUNUReWOVDmhudX
	NHCSwMDoCQJNhKsn32ogGmpvZMP6/Zm+PVdW33DbKWzIGpiVlH6/kS/c
X-Gm-Gg: AeBDiev6r83RzrxZFV+C1y6d1/qBfZZhXvO8GaBweIGXidtojuJEr0TNBbTDdvGCUfL
	76A9/cVVl8Acc4yIR3UH1uTSx+rmBT0feeSswD9J3wmk18gA15LVJo1dzuJoXSQpkH2Sj2hl2Vr
	LcCheWfyHrkTgNv0/rRkGsVlvT5VdSOkQI++rlTiS/noXNlpxJox1eoJrm7uGuvAv6XAxbvpr8G
	AiGlJRkAWu45+dXFPM78zbcVg+ErH4GKNYV+hnznkWnCqiXFRQZpx79yH7nJOComGR2LiY25Pl6
	ufPeLtlPUwMN8/58jlad4NvEJF+f0qEpxbXjnTxljPF2mFaJz2xKQ+WJiX34C5iJq6ED7xpTuOl
	WtYAsHeytdjM0YdUwtoNcWFsb7GtAkHwIPNrxotU8dKrAfHfFRo3ilo5MvR9Qh7p4n2XwYDqHB/
	2uxVhhIjzD9dSQqO+gUI3QVLC/nn8ReL+n8gjuRxx8TnvWwiTgaamnBw==
X-Received: by 2002:a05:690c:c512:b0:7ba:ee75:f115 with SMTP id 00721157ae682-7bcf4fc4fcamr2613427b3.4.1777323590345;
        Mon, 27 Apr 2026 13:59:50 -0700 (PDT)
Received: from localhost.localdomain ([2804:d59:7f1c:1e00:6632:a8ff:fea4:c8d3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bcf05e6149sm2324407b3.11.2026.04.27.13.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 13:59:49 -0700 (PDT)
From: Gustavo Arantes <dev.gustavoa@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>,
	nic_swsd@realtek.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Javen Xu <javen_xu@realsil.com.cn>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gustavo Arantes <dev.gustavoa@gmail.com>
Subject: [PATCH net-next v2] r8169: expose software counters through netdev qstats
Date: Mon, 27 Apr 2026 17:59:31 -0300
Message-ID: <20260427205931.5884-1-dev.gustavoa@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 69DBB47A724
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,realsil.com.cn,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-281493-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[devgustavoa@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

r8169 maintains synchronized per-CPU software counters for packet and
byte accounting and exposes them through ndo_get_stats64(), but
userspace using the structured netdev qstats API cannot retrieve them from
this driver.

Expose the same counters through netdev_stat_ops. r8169 has a single Rx
and Tx queue, so report the accumulated counters on queue 0. Use zero
base stats so device-scope qstats are derived from the queue counters
and match the packet and byte values reported through RTNL.

This does not add new accounting and does not touch the data path. It
only makes the existing counters available through the common qstats
interface, which lets generic userspace tooling query r8169 the same way
it queries other drivers with qstats support.

Signed-off-by: Gustavo Arantes <dev.gustavoa@gmail.com>
---
v2:
  - Submit again now that net-next has reopened.
  - Expand commit message to explain the qstats userspace benefit.

Tested on a Realtek RTL8111/8168/8211/8411 PCIe Gigabit Ethernet
controller using the r8169 driver.

v1: https://lore.kernel.org/netdev/20260418021232.5425-1-dev.gustavoa@gmail.com/

 drivers/net/ethernet/realtek/r8169_main.c | 70 +++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 791277e750ba..9d833b446383 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5175,6 +5175,75 @@ rtl8169_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
 	pm_runtime_put_noidle(&pdev->dev);
 }

+static void rtl8169_fetch_sw_stats(struct net_device *dev,
+				   struct netdev_queue_stats_rx *rx,
+				   struct netdev_queue_stats_tx *tx)
+{
+	const struct pcpu_sw_netstats *stats;
+	unsigned int start;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		u64 rx_packets, rx_bytes, tx_packets, tx_bytes;
+
+		stats = per_cpu_ptr(dev->tstats, cpu);
+		do {
+			start = u64_stats_fetch_begin(&stats->syncp);
+			rx_packets = u64_stats_read(&stats->rx_packets);
+			rx_bytes = u64_stats_read(&stats->rx_bytes);
+			tx_packets = u64_stats_read(&stats->tx_packets);
+			tx_bytes = u64_stats_read(&stats->tx_bytes);
+		} while (u64_stats_fetch_retry(&stats->syncp, start));
+
+		rx->packets += rx_packets;
+		rx->bytes += rx_bytes;
+		tx->packets += tx_packets;
+		tx->bytes += tx_bytes;
+	}
+}
+
+static void rtl8169_get_queue_stats_rx(struct net_device *dev, int idx,
+				       struct netdev_queue_stats_rx *rx)
+{
+	struct netdev_queue_stats_tx tx = {};
+
+	if (idx)
+		return;
+
+	rx->packets = 0;
+	rx->bytes = 0;
+	rtl8169_fetch_sw_stats(dev, rx, &tx);
+}
+
+static void rtl8169_get_queue_stats_tx(struct net_device *dev, int idx,
+				       struct netdev_queue_stats_tx *tx)
+{
+	struct netdev_queue_stats_rx rx = {};
+
+	if (idx)
+		return;
+
+	tx->packets = 0;
+	tx->bytes = 0;
+	rtl8169_fetch_sw_stats(dev, &rx, tx);
+}
+
+static void rtl8169_get_base_stats(struct net_device *dev,
+				   struct netdev_queue_stats_rx *rx,
+				   struct netdev_queue_stats_tx *tx)
+{
+	rx->packets = 0;
+	rx->bytes = 0;
+	tx->packets = 0;
+	tx->bytes = 0;
+}
+
+static const struct netdev_stat_ops rtl8169_stat_ops = {
+	.get_queue_stats_rx	= rtl8169_get_queue_stats_rx,
+	.get_queue_stats_tx	= rtl8169_get_queue_stats_tx,
+	.get_base_stats		= rtl8169_get_base_stats,
+};
+
 static void rtl8169_net_suspend(struct rtl8169_private *tp)
 {
 	netif_device_detach(tp->dev);
@@ -5615,6 +5684,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)

 	SET_NETDEV_DEV(dev, &pdev->dev);
 	dev->netdev_ops = &rtl_netdev_ops;
+	dev->stat_ops = &rtl8169_stat_ops;
 	tp = netdev_priv(dev);
 	tp->dev = dev;
 	tp->pci_dev = pdev;
--
2.54.0


