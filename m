Return-Path: <netdev+bounces-138869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAE59AF41E
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 22:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 669CEB21C3F
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 20:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEAA2170DA;
	Thu, 24 Oct 2024 20:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKI4GZQv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536F32170D3;
	Thu, 24 Oct 2024 20:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729803183; cv=none; b=VB3bArAKWep++WgxixvupYmQtjz78FlrZnhaHzjLnUKaelMSW3PJkh+6lwMUT19w0XojWv5g4m1IAwyxdJhHTULcqTPcrDFnKrHfI0mXpV67y/NvSxyC9QJKcoQiKnojeknUAO/lX2IlSIQ0aNo5LRHbEIFzhVC7Np3eU0uyktQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729803183; c=relaxed/simple;
	bh=PbuXyXJQ2XyS9EY4LHP4YJU3KRWDBqPswcwJKt2TYP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oIDLRdG7nP4dV3hxiu4rG3YHPLfxMU8mwTR50qz+IXEzsQJqo1RAbcWYeUgSm0NFIjFqDMYWva54ddtLHlPgOdaYm2a1l5gDB/rJh5W4AyKdRzfcxohgbaxLotsC5W4Hp4N8t6LruQZW74TpG1PcD0hLIdgCy2pdxXvOpvxrn9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKI4GZQv; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-28cdd9d8d01so799181fac.1;
        Thu, 24 Oct 2024 13:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729803180; x=1730407980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hY+ADBkdKrw8rogh6XPTp8lQ9D2YsO/t/WvfK9oXDeM=;
        b=FKI4GZQvBKx+aHFVrE2XcXloypfLIJhofD7nFYn2chOi6jwDzuwwAScF8oyXfilEQ3
         7iVjcVuhlfb0/nlWUXlHY0IIKXx1XLwDql6BR/mmGZBgefuKokqDmaRtG7MDSNOjA2vI
         8E0ztBCu4L4EpdSkqV2MhT+mB2qv2S7uuYOMn0AJYuZOye3VHngRCEbohD4YgQW7cRVF
         7r76SgT2Iedkylk9LoFk4CBmeBYUMghxgrNzueqfO+ddMI8/UdmJlsCH5Uh+JIV41yKJ
         TBy+gPI6RqFLNMnmdi2Q1L0S1M5mQGZCknOOgflkwnUBWidfMX2VU8rnIcvShydRjR+n
         Txjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729803180; x=1730407980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hY+ADBkdKrw8rogh6XPTp8lQ9D2YsO/t/WvfK9oXDeM=;
        b=TXHd1bLunGzbx/P+SYFPnQHXRzEoEDUyiIaLTSLMKbQW3tFkaBNmFZ39oIOIg92Yp+
         74MtiPi+qZNxlUC4gQgZ97iuIiXQPTcT8lBimhza4F5y/uPo9n8jJS088C3fAVKUQ5U+
         JXTLuFEkwyXC39ZxAiWBYBatUAbRqBhSh70ujAVOi6C5tqsYENqt5QBQys0kEnV6oprx
         Ix5UWwEFdRJJxj/5ZIQ7tcX7jUV9rl1B0DPGJ5yBkliu62VWhKQ8OwPOhIW/E8H2mgyh
         CXbjZWYL6VIa0o6qLVfibbkZQco9Qem9a0vB1KAW0NcNoE9MTBAfe3CfBlkxvyCbcz+/
         IuEg==
X-Forwarded-Encrypted: i=1; AJvYcCXWghS0A8KjYmzQtL73zemoJQqYTu4kYkxf+Q2u3qHpLgtm5uKaRfR+h0BGeRdimzrW5ateP9TKbknRqpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgquPCKKAq3gU35A4ZeE92pad+pnnsWviOwZkKGe5JCy9O4qVT
	qUybXT2CcIHLj6SsgWCdLrhUvhDfdi7vE/6xp5eKVRZHDYWQF9+cawGMgsBx
X-Google-Smtp-Source: AGHT+IHdMbp3i3HbP3R3LasrH5g+p6K06Cq3lshvlhP40J7GZunkcV9Vn+vdpgz8CCfHJO5fbN/vXA==
X-Received: by 2002:a05:6870:470a:b0:284:ff51:58ad with SMTP id 586e51a60fabf-28ccb52d823mr7353934fac.27.1729803180165;
        Thu, 24 Oct 2024 13:53:00 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeab1dc5esm9132231a12.25.2024.10.24.13.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 13:52:59 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Madalin Bucur <madalin.bucur@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Rosen Penev <rosenp@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE QUICC ENGINE UCC ETHERNET DRIVER)
Subject: [PATCH net-next] net: freescale: use ethtool string helpers
Date: Thu, 24 Oct 2024 13:52:57 -0700
Message-ID: <20241024205257.574836-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The latter is the preferred way to copy ethtool strings.

Avoids manually incrementing the pointer. Cleans up the code quite well.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../ethernet/freescale/dpaa/dpaa_ethtool.c    | 40 ++++++-------------
 .../ethernet/freescale/dpaa2/dpaa2-ethtool.c  | 15 +++----
 .../net/ethernet/freescale/dpaa2/dpaa2-mac.c  |  7 +---
 .../freescale/dpaa2/dpaa2-switch-ethtool.c    |  9 ++---
 .../ethernet/freescale/enetc/enetc_ethtool.c  | 35 +++++-----------
 .../net/ethernet/freescale/gianfar_ethtool.c  |  8 ++--
 .../net/ethernet/freescale/ucc_geth_ethtool.c | 21 +++++-----
 7 files changed, 49 insertions(+), 86 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
index b0060cf96090..10c5fa4d23d2 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
@@ -243,38 +243,24 @@ static void dpaa_get_ethtool_stats(struct net_device *net_dev,
 static void dpaa_get_strings(struct net_device *net_dev, u32 stringset,
 			     u8 *data)
 {
-	unsigned int i, j, num_cpus, size;
-	char string_cpu[ETH_GSTRING_LEN];
-	u8 *strings;
+	unsigned int i, j, num_cpus;
 
-	memset(string_cpu, 0, sizeof(string_cpu));
-	strings   = data;
-	num_cpus  = num_online_cpus();
-	size      = DPAA_STATS_GLOBAL_LEN * ETH_GSTRING_LEN;
+	num_cpus = num_online_cpus();
 
 	for (i = 0; i < DPAA_STATS_PERCPU_LEN; i++) {
-		for (j = 0; j < num_cpus; j++) {
-			snprintf(string_cpu, ETH_GSTRING_LEN, "%s [CPU %d]",
-				 dpaa_stats_percpu[i], j);
-			memcpy(strings, string_cpu, ETH_GSTRING_LEN);
-			strings += ETH_GSTRING_LEN;
-		}
-		snprintf(string_cpu, ETH_GSTRING_LEN, "%s [TOTAL]",
-			 dpaa_stats_percpu[i]);
-		memcpy(strings, string_cpu, ETH_GSTRING_LEN);
-		strings += ETH_GSTRING_LEN;
-	}
-	for (j = 0; j < num_cpus; j++) {
-		snprintf(string_cpu, ETH_GSTRING_LEN,
-			 "bpool [CPU %d]", j);
-		memcpy(strings, string_cpu, ETH_GSTRING_LEN);
-		strings += ETH_GSTRING_LEN;
+		for (j = 0; j < num_cpus; j++)
+			ethtool_sprintf(&data, "%s [CPU %d]",
+					dpaa_stats_percpu[i], j);
+
+		ethtool_sprintf(&data, "%s [TOTAL]", dpaa_stats_percpu[i]);
 	}
-	snprintf(string_cpu, ETH_GSTRING_LEN, "bpool [TOTAL]");
-	memcpy(strings, string_cpu, ETH_GSTRING_LEN);
-	strings += ETH_GSTRING_LEN;
+	for (i = 0; j < num_cpus; i++)
+		ethtool_sprintf(&data, "bpool [CPU %d]", i);
+
+	ethtool_puts(&data, "bpool [TOTAL]");
 
-	memcpy(strings, dpaa_stats_global, size);
+	for (i = 0; i < DPAA_STATS_GLOBAL_LEN; i++)
+		ethtool_puts(&data, dpaa_stats_global[i]);
 }
 
 static int dpaa_get_hash_opts(struct net_device *dev,
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c
index 7f476519b7ad..fd05dd12f107 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c
@@ -217,20 +217,15 @@ static int dpaa2_eth_set_pauseparam(struct net_device *net_dev,
 static void dpaa2_eth_get_strings(struct net_device *netdev, u32 stringset,
 				  u8 *data)
 {
-	u8 *p = data;
 	int i;
 
 	switch (stringset) {
 	case ETH_SS_STATS:
-		for (i = 0; i < DPAA2_ETH_NUM_STATS; i++) {
-			strscpy(p, dpaa2_ethtool_stats[i], ETH_GSTRING_LEN);
-			p += ETH_GSTRING_LEN;
-		}
-		for (i = 0; i < DPAA2_ETH_NUM_EXTRA_STATS; i++) {
-			strscpy(p, dpaa2_ethtool_extras[i], ETH_GSTRING_LEN);
-			p += ETH_GSTRING_LEN;
-		}
-		dpaa2_mac_get_strings(p);
+		for (i = 0; i < DPAA2_ETH_NUM_STATS; i++)
+			ethtool_puts(&data, dpaa2_ethtool_stats[i]);
+		for (i = 0; i < DPAA2_ETH_NUM_EXTRA_STATS; i++)
+			ethtool_puts(&data, dpaa2_ethtool_extras[i]);
+		dpaa2_mac_get_strings(data);
 		break;
 	}
 }
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
index a69bb22c37ea..892ed2f91084 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
@@ -560,13 +560,10 @@ int dpaa2_mac_get_sset_count(void)
 
 void dpaa2_mac_get_strings(u8 *data)
 {
-	u8 *p = data;
 	int i;
 
-	for (i = 0; i < DPAA2_MAC_NUM_STATS; i++) {
-		strscpy(p, dpaa2_mac_ethtool_stats[i], ETH_GSTRING_LEN);
-		p += ETH_GSTRING_LEN;
-	}
+	for (i = 0; i < DPAA2_MAC_NUM_STATS; i++)
+		ethtool_puts(&data, dpaa2_mac_ethtool_stats[i]);
 }
 
 void dpaa2_mac_get_ethtool_stats(struct dpaa2_mac *mac, u64 *data)
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-ethtool.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-ethtool.c
index 6bc1988be311..cdcf03c8c552 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-ethtool.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-ethtool.c
@@ -170,17 +170,16 @@ dpaa2_switch_ethtool_get_sset_count(struct net_device *netdev, int sset)
 static void dpaa2_switch_ethtool_get_strings(struct net_device *netdev,
 					     u32 stringset, u8 *data)
 {
-	u8 *p = data;
+	const char *str;
 	int i;
 
 	switch (stringset) {
 	case ETH_SS_STATS:
 		for (i = 0; i < DPAA2_SWITCH_NUM_COUNTERS; i++) {
-			memcpy(p, dpaa2_switch_ethtool_counters[i].name,
-			       ETH_GSTRING_LEN);
-			p += ETH_GSTRING_LEN;
+			str = dpaa2_switch_ethtool_counters[i].name;
+			ethtool_puts(&data, str);
 		}
-		dpaa2_mac_get_strings(p);
+		dpaa2_mac_get_strings(data);
 		break;
 	}
 }
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 2563eb8ac7b6..e1745b89362d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -247,38 +247,25 @@ static int enetc_get_sset_count(struct net_device *ndev, int sset)
 static void enetc_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	u8 *p = data;
 	int i, j;
 
 	switch (stringset) {
 	case ETH_SS_STATS:
-		for (i = 0; i < ARRAY_SIZE(enetc_si_counters); i++) {
-			strscpy(p, enetc_si_counters[i].name, ETH_GSTRING_LEN);
-			p += ETH_GSTRING_LEN;
-		}
-		for (i = 0; i < priv->num_tx_rings; i++) {
-			for (j = 0; j < ARRAY_SIZE(tx_ring_stats); j++) {
-				snprintf(p, ETH_GSTRING_LEN, tx_ring_stats[j],
-					 i);
-				p += ETH_GSTRING_LEN;
-			}
-		}
-		for (i = 0; i < priv->num_rx_rings; i++) {
-			for (j = 0; j < ARRAY_SIZE(rx_ring_stats); j++) {
-				snprintf(p, ETH_GSTRING_LEN, rx_ring_stats[j],
-					 i);
-				p += ETH_GSTRING_LEN;
-			}
-		}
+		for (i = 0; i < ARRAY_SIZE(enetc_si_counters); i++)
+			ethtool_puts(&data, enetc_si_counters[i].name);
+		for (i = 0; i < priv->num_tx_rings; i++)
+			for (j = 0; j < ARRAY_SIZE(tx_ring_stats); j++)
+				ethtool_sprintf(&data, tx_ring_stats[j], i);
+		for (i = 0; i < priv->num_rx_rings; i++)
+			for (j = 0; j < ARRAY_SIZE(rx_ring_stats); j++)
+				ethtool_sprintf(&data, rx_ring_stats[j], i);
 
 		if (!enetc_si_is_pf(priv->si))
 			break;
 
-		for (i = 0; i < ARRAY_SIZE(enetc_port_counters); i++) {
-			strscpy(p, enetc_port_counters[i].name,
-				ETH_GSTRING_LEN);
-			p += ETH_GSTRING_LEN;
-		}
+		for (i = 0; i < ARRAY_SIZE(enetc_port_counters); i++)
+			ethtool_puts(&data, enetc_port_counters[i].name);
+
 		break;
 	}
 }
diff --git a/drivers/net/ethernet/freescale/gianfar_ethtool.c b/drivers/net/ethernet/freescale/gianfar_ethtool.c
index a99b95c4bcfb..781d92e703cb 100644
--- a/drivers/net/ethernet/freescale/gianfar_ethtool.c
+++ b/drivers/net/ethernet/freescale/gianfar_ethtool.c
@@ -115,12 +115,14 @@ static const char stat_gstrings[][ETH_GSTRING_LEN] = {
 static void gfar_gstrings(struct net_device *dev, u32 stringset, u8 * buf)
 {
 	struct gfar_private *priv = netdev_priv(dev);
+	int i;
 
 	if (priv->device_flags & FSL_GIANFAR_DEV_HAS_RMON)
-		memcpy(buf, stat_gstrings, GFAR_STATS_LEN * ETH_GSTRING_LEN);
+		for (i = 0; i < GFAR_STATS_LEN; i++)
+			ethtool_puts(&buf, stat_gstrings[i]);
 	else
-		memcpy(buf, stat_gstrings,
-		       GFAR_EXTRA_STATS_LEN * ETH_GSTRING_LEN);
+		for (i = 0; i < GFAR_EXTRA_STATS_LEN; i++)
+			ethtool_puts(&buf, stat_gstrings[i]);
 }
 
 /* Fill in an array of 64-bit statistics from various sources.
diff --git a/drivers/net/ethernet/freescale/ucc_geth_ethtool.c b/drivers/net/ethernet/freescale/ucc_geth_ethtool.c
index 601beb93d3b3..699f346faf5c 100644
--- a/drivers/net/ethernet/freescale/ucc_geth_ethtool.c
+++ b/drivers/net/ethernet/freescale/ucc_geth_ethtool.c
@@ -287,20 +287,17 @@ static void uec_get_strings(struct net_device *netdev, u32 stringset, u8 *buf)
 {
 	struct ucc_geth_private *ugeth = netdev_priv(netdev);
 	u32 stats_mode = ugeth->ug_info->statisticsMode;
+	int i;
 
-	if (stats_mode & UCC_GETH_STATISTICS_GATHERING_MODE_HARDWARE) {
-		memcpy(buf, hw_stat_gstrings, UEC_HW_STATS_LEN *
-			       	ETH_GSTRING_LEN);
-		buf += UEC_HW_STATS_LEN * ETH_GSTRING_LEN;
-	}
-	if (stats_mode & UCC_GETH_STATISTICS_GATHERING_MODE_FIRMWARE_TX) {
-		memcpy(buf, tx_fw_stat_gstrings, UEC_TX_FW_STATS_LEN *
-			       	ETH_GSTRING_LEN);
-		buf += UEC_TX_FW_STATS_LEN * ETH_GSTRING_LEN;
-	}
+	if (stats_mode & UCC_GETH_STATISTICS_GATHERING_MODE_HARDWARE)
+		for (i = 0; i < UEC_HW_STATS_LEN; i++)
+			ethtool_puts(&buf, hw_stat_gstrings[i]);
+	if (stats_mode & UCC_GETH_STATISTICS_GATHERING_MODE_FIRMWARE_TX)
+		for (i = 0; i < UEC_TX_FW_STATS_LEN; i++)
+			ethtool_puts(&buf, tx_fw_stat_gstrings[i]);
 	if (stats_mode & UCC_GETH_STATISTICS_GATHERING_MODE_FIRMWARE_RX)
-		memcpy(buf, rx_fw_stat_gstrings, UEC_RX_FW_STATS_LEN *
-			       	ETH_GSTRING_LEN);
+		for (i = 0; i < UEC_RX_FW_STATS_LEN; i++)
+			ethtool_puts(&buf, rx_fw_stat_gstrings[i]);
 }
 
 static void uec_get_ethtool_stats(struct net_device *netdev,
-- 
2.47.0


