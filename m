Return-Path: <netdev+bounces-138047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D599ABB00
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 03:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6051284E4D
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 01:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247C02D047;
	Wed, 23 Oct 2024 01:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAGvU/0X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E1938DFC;
	Wed, 23 Oct 2024 01:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729646860; cv=none; b=FKJAeTLNZvw1r/OORvvOwWNzRmvufHwr6oDSm6DKAQkxpZLjShCItOcRUs5QZ4gKvld8FmgfDI16aPITmZYE/qqK27OoXvEtVObWlJeMraeJivV9iqd75IbGIVsv6IGtCGGYudaxaH25oNTXGYD3Xsb1uWv4oiL3LOE4+cKZEJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729646860; c=relaxed/simple;
	bh=vnDxKiEUDJSmoTK7eGYeMygxNDZ0ZwnKVp+Qeq6ZDF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mVCeTdAq+uVTMoi06c3mmj1h67pJClvdj3lMFlY8snfXuWmPNXcBPQLtSADmkKscIzSsp4QCbnPh7UC2Y46k1JcqubRWgYf/sTy9gR4ctj0QrrJMJJuG6ZvEPA9kgU1PIeZEu80z87APX+LB5Lm3zIndRLLVGwz28nd6Z8eOqm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAGvU/0X; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71eb1d0e3c2so2855564b3a.2;
        Tue, 22 Oct 2024 18:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729646857; x=1730251657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=btLBOqpFZBf7cvyoboOc8H4Rhhkr257kCzopKF2tc2Y=;
        b=HAGvU/0XB9SAqDLV6yhz59Tn7pp6sSFFfdroY+X27Veu1NnSUxK3jnPM/DvhzJg1iO
         Nv9Js8Y7P+sC6dG9l+yCESF/61KU6DSRbeh8JY/tdfvJ9u52VHyAiaqAMG8KRONjkWhC
         ALi0WGAUidZ6neXWruVfyqfYfvUOIixuQA+EY4dzVOv7QPgzD8vVGDEWw4dPaXYutlWe
         7UvHEjQiYRWTmrqjhgXr3PLoZGHVvDeBAX3gRMQGMmS0XX9K85Uwl0tMK8QYyozkDVbm
         augRbs3YTDu1Qr8lqchtI8c0sLUPA8YJ3PcXUXBCOc6fb+7rbfPdI9kX361BBU7/k7FT
         GixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729646857; x=1730251657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=btLBOqpFZBf7cvyoboOc8H4Rhhkr257kCzopKF2tc2Y=;
        b=HQ92yogqDJMa9i/C0XMsbMReEVTvQ046MxHwBtLszo9taYsjoeVhtK9HMFtTJE4EAy
         RybsOq+EJ6IfjO14Fesye4ouri9MvVOHhpD9vrLHFZE17hC88mVW1aEUbqG6ijliccVf
         14rYti4eS93tXJFNHV/ZnCO9tKGso59BXEqnNleLC9sSAThvz2SeYX90eD2OTxN/Xi8n
         R5HjH93cAp6Gq+pLAd9gBFydI+KMX5o9rhXoU30HuN3FvoCreM5B6vxtqX5E0Nf06Nm9
         2HcRLOYgM7u/wPPzNIQ8ZwdpBILzudCnchqEGG+K7ZYcghM3W82QwUFU3FZOz3FvsH4E
         vYHw==
X-Forwarded-Encrypted: i=1; AJvYcCViO4L+IkHyJrT0QM5SZNKBlgZYxBcf6kqRrIfqkCMH7pUHPHH01IgMi0rUJH4HcGnxPTGgTzIDQPyyH30=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKaj+/xgUpEOm2XqeEfxsWmGLjHvf7Ienqu4MNkxctAzHxXaa4
	EhdoJw3xzWctx4Dml7pOJzhrIDY5fAZ+r9g0hgNPuJYuNIrTjOk8t2NOK0IH
X-Google-Smtp-Source: AGHT+IG3FPm7jaWmsrLtAL00/Qpa/npZijViziRr2xtFhvVIeiSs+SMz9s6e6X+iFbM0PbbcFbY84Q==
X-Received: by 2002:a05:6a21:2d05:b0:1d9:1124:ab06 with SMTP id adf61e73a8af0-1d978aeade5mr1257755637.8.1729646857171;
        Tue, 22 Oct 2024 18:27:37 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e76e0849c0sm110069a91.51.2024.10.22.18.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 18:27:36 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Justin Chen <justin.chen@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Doug Berger <opendmb@gmail.com>,
	Rosen Penev <rosenp@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: broadcom: use ethtool string helpers
Date: Tue, 22 Oct 2024 18:27:34 -0700
Message-ID: <20241023012734.766789-1-rosenp@gmail.com>
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
 .../ethernet/broadcom/asp2/bcmasp_ethtool.c   |  6 +-
 drivers/net/ethernet/broadcom/bcm63xx_enet.c  | 12 ++--
 drivers/net/ethernet/broadcom/bcmsysport.c    | 20 ++----
 drivers/net/ethernet/broadcom/bgmac.c         |  3 +-
 .../ethernet/broadcom/bnx2x/bnx2x_ethtool.c   | 66 ++++++++-----------
 .../net/ethernet/broadcom/genet/bcmgenet.c    |  6 +-
 6 files changed, 47 insertions(+), 66 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
index 67928b5d8a26..9da5ae29a105 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
@@ -101,14 +101,14 @@ static int bcmasp_get_sset_count(struct net_device *dev, int string_set)
 static void bcmasp_get_strings(struct net_device *dev, u32 stringset,
 			       u8 *data)
 {
+	const char *str;
 	unsigned int i;
 
 	switch (stringset) {
 	case ETH_SS_STATS:
 		for (i = 0; i < BCMASP_STATS_LEN; i++) {
-			memcpy(data + i * ETH_GSTRING_LEN,
-			       bcmasp_gstrings_stats[i].stat_string,
-			       ETH_GSTRING_LEN);
+			str = bcmasp_gstrings_stats[i].stat_string;
+			ethtool_puts(&data, str);
 		}
 		break;
 	default:
diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.c b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
index e5e03aaa49f9..65e3a0656a4c 100644
--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
@@ -1339,14 +1339,14 @@ static int bcm_enet_get_sset_count(struct net_device *netdev,
 static void bcm_enet_get_strings(struct net_device *netdev,
 				 u32 stringset, u8 *data)
 {
+	const char *str;
 	int i;
 
 	switch (stringset) {
 	case ETH_SS_STATS:
 		for (i = 0; i < BCM_ENET_STATS_LEN; i++) {
-			memcpy(data + i * ETH_GSTRING_LEN,
-			       bcm_enet_gstrings_stats[i].stat_string,
-			       ETH_GSTRING_LEN);
+			str = bcm_enet_gstrings_stats[i].stat_string;
+			ethtool_puts(&data, str);
 		}
 		break;
 	}
@@ -2503,14 +2503,14 @@ static const struct bcm_enet_stats bcm_enetsw_gstrings_stats[] = {
 static void bcm_enetsw_get_strings(struct net_device *netdev,
 				   u32 stringset, u8 *data)
 {
+	const char *str;
 	int i;
 
 	switch (stringset) {
 	case ETH_SS_STATS:
 		for (i = 0; i < BCM_ENETSW_STATS_LEN; i++) {
-			memcpy(data + i * ETH_GSTRING_LEN,
-			       bcm_enetsw_gstrings_stats[i].stat_string,
-			       ETH_GSTRING_LEN);
+			str = bcm_enetsw_gstrings_stats[i].stat_string;
+			ethtool_puts(&data, str);
 		}
 		break;
 	}
diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index 0b7088ca4822..78058aa4e008 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -370,32 +370,22 @@ static void bcm_sysport_get_strings(struct net_device *dev,
 {
 	struct bcm_sysport_priv *priv = netdev_priv(dev);
 	const struct bcm_sysport_stats *s;
-	char buf[128];
-	int i, j;
+	int i;
 
 	switch (stringset) {
 	case ETH_SS_STATS:
-		for (i = 0, j = 0; i < BCM_SYSPORT_STATS_LEN; i++) {
+		for (i = 0; i < BCM_SYSPORT_STATS_LEN; i++) {
 			s = &bcm_sysport_gstrings_stats[i];
 			if (priv->is_lite &&
 			    !bcm_sysport_lite_stat_valid(s->type))
 				continue;
 
-			memcpy(data + j * ETH_GSTRING_LEN, s->stat_string,
-			       ETH_GSTRING_LEN);
-			j++;
+			ethtool_puts(&data, s->stat_string);
 		}
 
 		for (i = 0; i < dev->num_tx_queues; i++) {
-			snprintf(buf, sizeof(buf), "txq%d_packets", i);
-			memcpy(data + j * ETH_GSTRING_LEN, buf,
-			       ETH_GSTRING_LEN);
-			j++;
-
-			snprintf(buf, sizeof(buf), "txq%d_bytes", i);
-			memcpy(data + j * ETH_GSTRING_LEN, buf,
-			       ETH_GSTRING_LEN);
-			j++;
+			ethtool_sprintf(&data, "txq%d_packets", i);
+			ethtool_sprintf(&data, "txq%d_bytes", i);
 		}
 		break;
 	default:
diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index 2599ffe46e27..18badb51a2f8 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -1367,8 +1367,7 @@ static void bgmac_get_strings(struct net_device *dev, u32 stringset,
 		return;
 
 	for (i = 0; i < BGMAC_STATS_LEN; i++)
-		strscpy(data + i * ETH_GSTRING_LEN,
-			bgmac_get_strings_stats[i].name, ETH_GSTRING_LEN);
+		ethtool_puts(&data, bgmac_get_strings_stats[i].name);
 }
 
 static void bgmac_get_ethtool_stats(struct net_device *dev,
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
index adf7b6b94941..c875faffbf1c 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
@@ -39,34 +39,34 @@ static const struct {
 	int size;
 	char string[ETH_GSTRING_LEN];
 } bnx2x_q_stats_arr[] = {
-/* 1 */	{ Q_STATS_OFFSET32(total_bytes_received_hi), 8, "[%s]: rx_bytes" },
+/* 1 */	{ Q_STATS_OFFSET32(total_bytes_received_hi), 8, "[%d]: rx_bytes" },
 	{ Q_STATS_OFFSET32(total_unicast_packets_received_hi),
-						8, "[%s]: rx_ucast_packets" },
+						8, "[%d]: rx_ucast_packets" },
 	{ Q_STATS_OFFSET32(total_multicast_packets_received_hi),
-						8, "[%s]: rx_mcast_packets" },
+						8, "[%d]: rx_mcast_packets" },
 	{ Q_STATS_OFFSET32(total_broadcast_packets_received_hi),
-						8, "[%s]: rx_bcast_packets" },
-	{ Q_STATS_OFFSET32(no_buff_discard_hi),	8, "[%s]: rx_discards" },
+						8, "[%d]: rx_bcast_packets" },
+	{ Q_STATS_OFFSET32(no_buff_discard_hi),	8, "[%d]: rx_discards" },
 	{ Q_STATS_OFFSET32(rx_err_discard_pkt),
-					 4, "[%s]: rx_phy_ip_err_discards"},
+					 4, "[%d]: rx_phy_ip_err_discards"},
 	{ Q_STATS_OFFSET32(rx_skb_alloc_failed),
-					 4, "[%s]: rx_skb_alloc_discard" },
-	{ Q_STATS_OFFSET32(hw_csum_err), 4, "[%s]: rx_csum_offload_errors" },
-	{ Q_STATS_OFFSET32(driver_xoff), 4, "[%s]: tx_exhaustion_events" },
-	{ Q_STATS_OFFSET32(total_bytes_transmitted_hi),	8, "[%s]: tx_bytes" },
+					 4, "[%d]: rx_skb_alloc_discard" },
+	{ Q_STATS_OFFSET32(hw_csum_err), 4, "[%d]: rx_csum_offload_errors" },
+	{ Q_STATS_OFFSET32(driver_xoff), 4, "[%d]: tx_exhaustion_events" },
+	{ Q_STATS_OFFSET32(total_bytes_transmitted_hi),	8, "[%d]: tx_bytes" },
 /* 10 */{ Q_STATS_OFFSET32(total_unicast_packets_transmitted_hi),
-						8, "[%s]: tx_ucast_packets" },
+						8, "[%d]: tx_ucast_packets" },
 	{ Q_STATS_OFFSET32(total_multicast_packets_transmitted_hi),
-						8, "[%s]: tx_mcast_packets" },
+						8, "[%d]: tx_mcast_packets" },
 	{ Q_STATS_OFFSET32(total_broadcast_packets_transmitted_hi),
-						8, "[%s]: tx_bcast_packets" },
+						8, "[%d]: tx_bcast_packets" },
 	{ Q_STATS_OFFSET32(total_tpa_aggregations_hi),
-						8, "[%s]: tpa_aggregations" },
+						8, "[%d]: tpa_aggregations" },
 	{ Q_STATS_OFFSET32(total_tpa_aggregated_frames_hi),
-					8, "[%s]: tpa_aggregated_frames"},
-	{ Q_STATS_OFFSET32(total_tpa_bytes_hi),	8, "[%s]: tpa_bytes"},
+					8, "[%d]: tpa_aggregated_frames"},
+	{ Q_STATS_OFFSET32(total_tpa_bytes_hi),	8, "[%d]: tpa_bytes"},
 	{ Q_STATS_OFFSET32(driver_filtered_tx_pkt),
-					4, "[%s]: driver_filtered_tx_pkt" }
+					4, "[%d]: driver_filtered_tx_pkt" }
 };
 
 #define BNX2X_NUM_Q_STATS ARRAY_SIZE(bnx2x_q_stats_arr)
@@ -3184,32 +3184,24 @@ static u32 bnx2x_get_private_flags(struct net_device *dev)
 static void bnx2x_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
 {
 	struct bnx2x *bp = netdev_priv(dev);
-	int i, j, k, start;
-	char queue_name[MAX_QUEUE_NAME_LEN+1];
+	const char *str;
+	int i, j, start;
 
 	switch (stringset) {
 	case ETH_SS_STATS:
-		k = 0;
 		if (is_multi(bp)) {
 			for_each_eth_queue(bp, i) {
-				memset(queue_name, 0, sizeof(queue_name));
-				snprintf(queue_name, sizeof(queue_name),
-					 "%d", i);
-				for (j = 0; j < BNX2X_NUM_Q_STATS; j++)
-					snprintf(buf + (k + j)*ETH_GSTRING_LEN,
-						ETH_GSTRING_LEN,
-						bnx2x_q_stats_arr[j].string,
-						queue_name);
-				k += BNX2X_NUM_Q_STATS;
+				for (j = 0; j < BNX2X_NUM_Q_STATS; j++) {
+					str = bnx2x_q_stats_arr[j].string;
+					ethtool_sprintf(&buf, str, i);
+				}
 			}
 		}
 
-		for (i = 0, j = 0; i < BNX2X_NUM_STATS; i++) {
+		for (i = 0; i < BNX2X_NUM_STATS; i++) {
 			if (HIDE_PORT_STAT(bp) && IS_PORT_STAT(i))
 				continue;
-			strcpy(buf + (k + j)*ETH_GSTRING_LEN,
-				   bnx2x_stats_arr[i].string);
-			j++;
+			ethtool_puts(&buf, bnx2x_stats_arr[i].string);
 		}
 
 		break;
@@ -3220,13 +3212,13 @@ static void bnx2x_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
 			start = 0;
 		else
 			start = 4;
-		memcpy(buf, bnx2x_tests_str_arr + start,
-		       ETH_GSTRING_LEN * BNX2X_NUM_TESTS(bp));
+		for (i = start; i < BNX2X_NUM_TESTS(bp); i++)
+			ethtool_puts(&buf, bnx2x_tests_str_arr[i]);
 		break;
 
 	case ETH_SS_PRIV_FLAGS:
-		memcpy(buf, bnx2x_private_arr,
-		       ETH_GSTRING_LEN * BNX2X_PRI_FLAG_LEN);
+		for (i = 0; i < BNX2X_PRI_FLAG_LEN; i++)
+			ethtool_puts(&buf, bnx2x_private_arr[i]);
 		break;
 	}
 }
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 10966ab15373..244c5b9523b4 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1144,14 +1144,14 @@ static int bcmgenet_get_sset_count(struct net_device *dev, int string_set)
 static void bcmgenet_get_strings(struct net_device *dev, u32 stringset,
 				 u8 *data)
 {
+	const char *str;
 	int i;
 
 	switch (stringset) {
 	case ETH_SS_STATS:
 		for (i = 0; i < BCMGENET_STATS_LEN; i++) {
-			memcpy(data + i * ETH_GSTRING_LEN,
-			       bcmgenet_gstrings_stats[i].stat_string,
-			       ETH_GSTRING_LEN);
+			str = bcmgenet_gstrings_stats[i].stat_string;
+			ethtool_puts(&data, str);
 		}
 		break;
 	}
-- 
2.47.0


