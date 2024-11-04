Return-Path: <netdev+bounces-141659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B40119BBEBD
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 21:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 394121F21AF7
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 20:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858CA1E491B;
	Mon,  4 Nov 2024 20:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PG1TYxxF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75A11CC178;
	Mon,  4 Nov 2024 20:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730751811; cv=none; b=FgIczvtGim/jh+lHdM4iaAXgLx2ukasBKJgsKsyIQPV561moVxquyZ4zm78tzdb4OglZauJA9IiJjlQtEuKlMnINaFG7p4InpDKH0HQvN//E9jLh1GPcDsjnoTtMRX6+je3Jej4FA7TdUQWIiUfPRG6kpjJsbg9hxj6FHyikkQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730751811; c=relaxed/simple;
	bh=bVRTVkdVLpt3k2Sz3dR1IgaViZm9u/+auAbXEsHZa5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EMhz5WuFcW0a+vxCni66RF1Yarx/h9KEwfd/BZTMEaaTS9Blyd5+o3isvZ6s5uHoF/tcN93kqlGg+ou0Eyd+AFzXN93JX0hYwSpwtJektVnKhEl4IH08XykNx5cQQPU67IbdT4JrxtRkPYZMBRfODVgnoEYO6txsk4jjSYtdz/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PG1TYxxF; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c8c50fdd9so37538245ad.0;
        Mon, 04 Nov 2024 12:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730751809; x=1731356609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M+5x6kMVU1G6KEqc3nr1gaq6PpBkuKcx3+eLAbZss6k=;
        b=PG1TYxxF1R3eg7RfTAjHo8JcIa1CkJzDHt9j48SDpzzE923MsFrYW+FoO2Vb6iYzvs
         6NXvuykDkb89MzGqrdZtLMtPtuOAmgnRywweXvjPc/4OeJXg9843roF5BAA0A73q38R/
         sSRsxw40/FPk6vZRbBiIzX9cAjkVjPVa5BU1zbKQWphQEBqfOchznQthAzUobVdA7LN+
         7S71stdmKoNA9SOSot/K6rPyaH4vya4h7KAxxYXuuLBcyafZFhJIJ9gcU0T7fig2qzuD
         OFxX9LSNiavdFOXS0B4fn47yabRcOv5LJQ4EeakbY8MT3cGo0viOC8wOksGI7B468KCm
         AjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730751809; x=1731356609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M+5x6kMVU1G6KEqc3nr1gaq6PpBkuKcx3+eLAbZss6k=;
        b=D0r0WrrypNscnvdOBQNcdSHPc5ZsnyK7eosdGlp4Pfh9+FAeGuQ5swCdaAbVyy9guw
         vY7ewPaY46n7gQY7DF26QwtKTrWUvwYF/ozUgPt55BO+lCz9r5b4wPd1pV8mMeUB5peg
         g0ujQHTeGorfH6bnGyRsmvIRTZ8Day0O8gInAqO6+dtNSEVEhUDynDFT3Qae7SM9/R7p
         vNp/EV4Cnv5vaiGdeNmq6ISmRyYdQsFT56gD+capkvLtRht/J6yEHdm4CAD5w4i3feba
         mrIml+1dveoPVm60EBTeEXj7Z7GE6Hq4z/441TkED18T93alsfR7R1hghOYcR3HbrdMy
         JNig==
X-Forwarded-Encrypted: i=1; AJvYcCU+1YQYdKWCHXf46b6IQuK7PWkNfvX/7VczUUaoh3s9gFUAWbXlaDs8QrWGA0C4PZfxFFxeNdnAAu6h1YA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA6DFw90Neqrsi73u10TFheGKL1cxhu6FaZKrT6jDt4YKAHP7O
	UoieiIoOuQO9U6hQBFNarUdOHADMAyiLM5K0Cemhq5QJDnvYoxjrsrgv+w==
X-Google-Smtp-Source: AGHT+IFie9ycNzrKoyUya76A8gnuPRJNJn/rr1vkTgiP7mo1hOVSdwoxYiZl+CB9V9WHImDp12W3tQ==
X-Received: by 2002:a17:90b:4ac7:b0:2e9:20d8:414c with SMTP id 98e67ed59e1d1-2e94bcdcb02mr22005352a91.5.1730751808955;
        Mon, 04 Nov 2024 12:23:28 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa57cc3sm10315054a91.32.2024.11.04.12.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 12:23:28 -0800 (PST)
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
Subject: [PATCHv2 net-next] net: bnx2x: use ethtool string helpers
Date: Mon,  4 Nov 2024 12:23:26 -0800
Message-ID: <20241104202326.78418-1-rosenp@gmail.com>
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
 v2: handle IS_VF
 v1: split off from main broadcom patch.
 .../ethernet/broadcom/bnx2x/bnx2x_ethtool.c   | 68 +++++++++----------
 1 file changed, 31 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
index adf7b6b94941..44199855ebfb 100644
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
@@ -3184,49 +3184,43 @@ static u32 bnx2x_get_private_flags(struct net_device *dev)
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
 
 	case ETH_SS_TEST:
+		if (IS_VF(bp))
+			break;
 		/* First 4 tests cannot be done in MF mode */
 		if (!IS_MF(bp))
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


