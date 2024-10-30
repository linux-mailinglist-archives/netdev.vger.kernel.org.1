Return-Path: <netdev+bounces-140553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE8D9B6E25
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 21:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 417E01C2329F
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 20:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6440C1EBA1B;
	Wed, 30 Oct 2024 20:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhS3zy3w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BBC1CBE9D;
	Wed, 30 Oct 2024 20:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730321512; cv=none; b=UkbcENgEGh8S1Pr4gvFDkgmGo1ReqHQMnazJvoBrJCELSSo7UFMi46bqPQlcMB786QrhHC9/YPIz13mj0ecEgmOFsaJhulX5q0y+CPUGx8qReXhFAf2lT+jOnI0+pl+/dXlCYso5eQ6AUkSyvP4+6UZKInUTxPZ1lDD2MbZGhdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730321512; c=relaxed/simple;
	bh=oBhmGXIzoWMrEGOBvgCoKpinjlkHJVkkvHT6rk+OfDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VH07R2JOVvm4Cj5PS1sLNFWA5kyNVAdlcfgCkM8bW2WEm6I54GRg5NaFbqry4uN3LvAWJM7tnCfOk6iNqvrSHtsJeQZj6qVr81NUeSuT/1Ykzb/8UEz/F3e7vgYp0Bbb+JMajRlpuUBzk1c5Z7xAw50NxHNetqdI96NDwQ/Hris=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhS3zy3w; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7eda47b7343so255791a12.0;
        Wed, 30 Oct 2024 13:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730321509; x=1730926309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vIDzkbaRW84oze4Y/ABSAauGRkTZdpvmjx0lVai7SMU=;
        b=VhS3zy3w0fklcFJyHMFFvChYodOFrIENiXBFfmYmX8SzO96iJj54wefgsWclCOhEM3
         rxtfZsNURSC8ypd3BgjUECZwKqQakjK1dQNLR1uQnr2vLm/uwrd28AN17sl+pXQ0k4AJ
         lmMeCk+WEJpzN5hbtoHqN2KYda7nMTJEuNq1A4nY7z902dOirUArJbbI4Qx/nh5Z9een
         WCbzxmsafrYY/Vp7lsix4NHcmRCuj9lspGJHbpZcsaS7U7G5KZdHSQXp/PB4H7HR2qJo
         9+KE0ncJCmP7gNDXtR/oLlXlV8jBJvPgMefRdae0hJmH75Ta07f5JW139Q4OFERF/vy2
         pmqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730321509; x=1730926309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vIDzkbaRW84oze4Y/ABSAauGRkTZdpvmjx0lVai7SMU=;
        b=WSPr7dQENAalBgkjnv19ti1pCfFXbiroteutpYMZz3j5oHhl6hnl6YTJn36VZbGppr
         CNusenTarbbVtkpsPA38zgT7VnQiwkxjTLSeNpj9/Z8Qpot1dOQKaP5FmLsTEGYiCeO/
         5Ft8K7v2tBOn+Qwkzp4/fz/3ik4Vi18IrAgtBPoCnTh5pKW/oeGw8Tj79j3vk1mT8pI+
         qj03mfPn3YbI/XwRnanSi4nhttcXTvge2C00x6wiU02/ZQLgLNWZ3pzquZPVpnlAmyRg
         8sYn9SbGinz+ZK/nT/B1ooyZyub3xRCLjykoUebSk3TjrvD3Oc5HyHHwWq/8o7d2zHoJ
         j9hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUah904ahfF4lnE/+iIS3Rxor0Q6j2rHI6hS9G3x+uLYxlPX+MeC7PdF3q0psRU419arkYSWJ9vZHnuguU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOaJx+Cv+DOQb3kuHXvRWTsZl2iFwH+aT7XnSjZ/YlHWETr7mk
	678iFmhnpd2pFzS/rCMI6KEpIkuhxod6TPQQAvtsRxcrpPj6ukd9NABAAbyb
X-Google-Smtp-Source: AGHT+IEvYLKOdk+3JJQHk6lC9vpHW0BipavnlkXj8PXYB97QvRmZRl9rprLdq6TfCIo1NMRb31Owjw==
X-Received: by 2002:a05:6a21:e96:b0:1d2:eaca:4fa8 with SMTP id adf61e73a8af0-1d9a84d9df9mr25626864637.35.1730321509079;
        Wed, 30 Oct 2024 13:51:49 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fc00856sm2329635a91.54.2024.10.30.13.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 13:51:48 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: bnx2x: use ethtool string helpers
Date: Wed, 30 Oct 2024 13:51:47 -0700
Message-ID: <20241030205147.7442-1-rosenp@gmail.com>
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
 v1: split off from main broadcom patch.
 .../ethernet/broadcom/bnx2x/bnx2x_ethtool.c   | 66 ++++++++-----------
 1 file changed, 29 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
index adf7b6b94941..65d65aabf16a 100644
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
+		for (i = start; i < BNX2X_NUM_TESTS_SF; i++)
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
-- 
2.47.0


