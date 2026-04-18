Return-Path: <netdev+bounces-279446-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id prkGM5zo4mlrAAEAu9opvQ
	(envelope-from <netdev+bounces-279446-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 04:12:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C8541FAAE
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 04:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DC6E303A251
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 02:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC734271A71;
	Sat, 18 Apr 2026 02:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNJ3/bl/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF8A199E89
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 02:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776478361; cv=none; b=YtgICiSibW86k0j45P0FbzxJpv1pHqe5R18mSkvq6Dd9Qv/nrkE6o6zq0Ioh2R7JQZiVrNFodcEYDRLv7vAILQ2AUFype8IYbCYLDolXiLLz/SrtulKBLT5UQvsY5IgvYWVGjCDH1TEZvebJi7qbOlGbpJMFz+fgL0UPkcnic7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776478361; c=relaxed/simple;
	bh=rhiyBegILqA56v+BQgWvBziQDat7coaEwK1s5vvGJuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MmS1lF2oa2q0lzAcqjlb6yNnmaQsmIhBUyDrLTOG/p3D0grYL07nlizGezA/m8510JAphwwCc4xTZrAW1/zN8y/KSamu04QlZyqQSxNAJF0wKqM7BBvOA1YEC4/tuVCfhys8InRv0nzTivwCcLmlWO6hFLpbmjXwVrhNRU30mZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNJ3/bl/; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-94aaa5d3bfcso774009241.3
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 19:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776478359; x=1777083159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qtENGTAsRspA6IxTYSLNva2FaUMU08Xqs7csgDMJzvc=;
        b=RNJ3/bl/FCAdkzi+WRMCbSbYAwURhtQ/eStF49wBcWARfXIDNYidqNrHlp5fviDFWe
         rDJKUbPdORNWKUp2jda635/yVWMQ7b0Q3Xr+azyf924GMxA9ztFajwsYwGanG9/qPByt
         aMZlbASpGOnL3dFF6IUnr4KSOFnkp+fytwZwahXq18GWwnyc6wgFPbi5C2RVumha6V6+
         cYQdWpmCM+ZuGdf0dyC35V5urUSUmvCl5b3lZGsOrsEcppdn6kFOA5H0Oo96eYkl0Asn
         pkUP9xTi4NGEoZBHghKdGoRW+S2I1fttAX5W+mpqitoXaOIKcsnBnVbdfGiAyOf6gAUQ
         O7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776478359; x=1777083159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtENGTAsRspA6IxTYSLNva2FaUMU08Xqs7csgDMJzvc=;
        b=awFR694YdXA2p9RZNXMlwNFK/e+ooL/CctEobwI7n9uu6Xbp3YM4iyyFXLBZ6KYq4f
         6oO8Xx0wyHjYYHSnbCM+3abk7/nxbEhWufRpk6PqMGqabg5Zybq4/I4OCkR4ok8s8S+w
         9KUTaHVCIAxFQe9452/0cjOPyZDpZoIlvPVYvLXIW75nnVsTJ80JXjwvm50pHyf6AMfw
         odSLKdrLU49DJtW5LxvUGrZqthXutNVJh5sGt/jSHJD7TYCZt/kOBONVNbvBzSSkgLQp
         GWEAxpDvCzMpUpEPMoTAX+vF00oYGZ0UbwKa1K5lWfvsRSTBsxwskUJTsth/ePTparpt
         sRhQ==
X-Forwarded-Encrypted: i=1; AFNElJ/GDcVh7Ct73V4og+rwl8xLmLGd/yTqH38nD0wWHYnbrQTwoE00aG1INoNQZZ4yEs0Ptf2NrFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3jBqi3MwwyGbdjUSF+d1/hGDFfI37T93X8fpkCLRRnjorAxV2
	qIDo183RWpeZI5moxrPpFYj208bQI6B+scZD1BGEFzMSEgsqw1x9Rljv
X-Gm-Gg: AeBDieswAkJG3VRjwjR2OLo799dLSjnJ8qIahNRKati7QHfW54/29BS2/pTEw2yIl3u
	gM9lb/DWcwp8guYxCBxY1FECQS+Bojdjq1PyJADk23j8sNr8WggXcvz0T9/GZ0wrA2O0qZJsEMx
	lB0WvBXN6x8/uPsdS8fCxCMbB3QhdIXyE7zMyGoVOyuTEJJxWVLLEeo1tvFQnmPbjgG4boP29rL
	0XBs+MpI6QU6hK4YSt4vfUfvQHD1l2+iVHmwUmixFzX9bNXrEHMLbPc47auvi6t4b21R4GPVLmg
	+aBtNwaPOWOc3o/Mr56wA070KNsJ2HxuArX1G9XXylpjgw+G9tRldJR1gOhTY2twOtZ2ZJcYybu
	Ui9qu8Bmbei7mnGiiI5Ll3CDFphQRVKt8leotVtkuRgODU7G7EPvVJAs+UHgnHl74PgXpMwBENR
	8J6FJE/o2Qadvv/3x81yaaVeShL7QQud/i
X-Received: by 2002:a05:6102:f9e:b0:609:4d86:77b with SMTP id ada2fe7eead31-616f73fb077mr2761601137.24.1776478359242;
        Fri, 17 Apr 2026 19:12:39 -0700 (PDT)
Received: from nixos ([2804:d59:7f1c:1e00:868c:c43d:f565:df5b])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95890bcbbc7sm1614597241.9.2026.04.17.19.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 19:12:38 -0700 (PDT)
From: Gustavo Arantes <dev.gustavoa@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>,
	nic_swsd@realtek.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] r8169: report per-queue statistics through netdev qstats
Date: Fri, 17 Apr 2026 23:12:32 -0300
Message-ID: <20260418021232.5425-1-dev.gustavoa@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279446-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[devgustavoa@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 10C8541FAAE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

r8169 maintains synchronized per-CPU software counters for packet and byte
accounting, but does not expose them through the netdev qstats interface.

Add netdev_stat_ops callbacks and report the existing software counters
through queue 0 for both Rx and Tx. Provide zero base stats so device-scope
qstats report the packet and byte counters as supported and match the
existing RTNL statistics.

Signed-off-by: Gustavo Arantes <dev.gustavoa@gmail.com>
---
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
2.51.2


