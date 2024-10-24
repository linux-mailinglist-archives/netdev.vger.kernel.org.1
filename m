Return-Path: <netdev+bounces-138855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 039529AF307
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 21:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB5D41C21FE2
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 19:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D7D189F5F;
	Thu, 24 Oct 2024 19:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KO3Un1de"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41B222B656;
	Thu, 24 Oct 2024 19:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729799740; cv=none; b=SrFzJLyfB1dzHzQBtv0SuEqMB07Ryp8xIJLKJ6fzQTZQLvCX6nJ5ef0kRbJ+0D9V+WegcGiZOKFTMfup6Wik/0FreX1qGNg0UD2/ShqDaDMf/S2WytG6hAsoP2FLcpxuj31HLup5Y5gtICFC8rr3HrC3xY3NDGMtNkMTQg2eq4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729799740; c=relaxed/simple;
	bh=DhC3yV7jteAllfw5xO8wBghk7B8ZPwutubdHHUCsCvU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N0AC1qTsX6bhJxAbh4L67DYcF1JRqJIsXnCCzt9uqutjIdksUOc/e2wBu11oyjQBEm+ETOS+rGoDKyAVVLu+swTnBcJ64X5mKjxhydxaps9ytBHX4Zmd9De7AWlpjInR2e2slFBM0r6yZF0Ux5t24mbjjMZGdGbiDW/MGFXd4xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KO3Un1de; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7ed67cfc1fcso819468a12.1;
        Thu, 24 Oct 2024 12:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729799737; x=1730404537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c1iF9Thwc+yGUEwDLEcTY5agqXsTr0Wwj9/zAQzfIVM=;
        b=KO3Un1deWQ+i6z5byII8czG5bKEXTECrQMfDvM4U1PEiOuNZx5s5kFWxjcas8CKdio
         qJLkZaBzehrdA5wXcLBfcIUnObie/UaPDdS/hQIjANE2SJo0t/Ln1RDbZXZLM3aF/EJ0
         pnYTdGnExKSAfstmGWMrqihcYm5wBQdmeBweASdohcZ0zkQKdNocqzQu2gzZTyZBnfxs
         ZMD2/3HA9KxhpzKT7HoVxo4l7moraYUMBrsMnZd/zS2L9+4qaO6pY6Mw+b0y6zWhAWeq
         Cirns0H4ge3GzWfDxoff7+43xykQ9FUwcXXq3l/0Ih8QCLmLFL/ry+eUdPkAtyj6Dw8C
         OBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729799737; x=1730404537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c1iF9Thwc+yGUEwDLEcTY5agqXsTr0Wwj9/zAQzfIVM=;
        b=UqHFiPFBF5Be9OQJdGVk6nEDNVdJAdwKSHSNlW4GHwB/DQ0XBgsPMgeHHgZu1BEyBC
         50/sbr5qg4+MNWycipEC4khuUgghH5kHJouZv0nkcnW54khTEay4OTjsKPmU2S6KCKxp
         2JxgQmLOqPqBloQzFbwRoo6Kz89DaC4t/CDlwOiRtJ4lj1sGigf1Yx73bqJvXBqExio5
         CLD69ECbnCkglTEzVj9FIKt4rpXnp6i31TDveiUmR677U3elcVssilJB8olmKvfzhphH
         vuhrHTT2+LmLkGhCjsyxRziL7IuJmY0uAfwIspyJkXTMcO7u3A+TpQ7Lbnk/RKGDW81+
         TEgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHzkn1msGIF9GyvhGAr0+LEjF+35okM9e71UI8aB1mDsjhmiuGzq/Gg+CnWgENDJDxYvaI0WgJwh/9nGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXZaXwgZGoXE4iF90IO+/Sle3sQe2tz6FsfQ/WaT+3tsC0Kioj
	5TG6JBu0ohIfTf/pHGdfiY7f8Z61KIabduU3zPNpWqfc/5ajK+UTXvKf1hwh
X-Google-Smtp-Source: AGHT+IF+fM6B86uXWQnlx1dhpzVIUWhViHw1SFL741p5iHKFuFSUPK1oU+ysaYdhNCguJIra1Mt+Bg==
X-Received: by 2002:a05:6a21:7702:b0:1d9:a94:8d90 with SMTP id adf61e73a8af0-1d978b3ea6dmr9251015637.27.1729799736623;
        Thu, 24 Oct 2024 12:55:36 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec132ffadsm8297684b3a.52.2024.10.24.12.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:55:36 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Manish Chopra <manishc@marvell.com>,
	Rahul Verma <rahulv@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com (supporter:NETXEN (1/10) GbE SUPPORT),
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shahed Shaikh <shshaikh@marvell.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: qlogic: use ethtool string helpers
Date: Thu, 24 Oct 2024 12:55:34 -0700
Message-ID: <20241024195534.176410-1-rosenp@gmail.com>
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
 .../qlogic/netxen/netxen_nic_ethtool.c        | 14 ++---
 .../net/ethernet/qlogic/qede/qede_ethtool.c   | 34 +++++------
 .../ethernet/qlogic/qlcnic/qlcnic_ethtool.c   | 60 +++++++++----------
 3 files changed, 50 insertions(+), 58 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_ethtool.c b/drivers/net/ethernet/qlogic/netxen/netxen_nic_ethtool.c
index 8c4cb910e09b..e7d8999049e1 100644
--- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_ethtool.c
+++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_ethtool.c
@@ -648,18 +648,18 @@ netxen_nic_diag_test(struct net_device *dev, struct ethtool_test *eth_test,
 static void
 netxen_nic_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 {
-	int index;
+	const char *str;
+	int i;
 
 	switch (stringset) {
 	case ETH_SS_TEST:
-		memcpy(data, *netxen_nic_gstrings_test,
-		       NETXEN_NIC_TEST_LEN * ETH_GSTRING_LEN);
+		for (i = 0; i < NETXEN_NIC_TEST_LEN; i++)
+			ethtool_puts(&data, netxen_nic_gstrings_test[i]);
 		break;
 	case ETH_SS_STATS:
-		for (index = 0; index < NETXEN_NIC_STATS_LEN; index++) {
-			memcpy(data + index * ETH_GSTRING_LEN,
-			       netxen_nic_gstrings_stats[index].stat_string,
-			       ETH_GSTRING_LEN);
+		for (i = 0; i < NETXEN_NIC_STATS_LEN; i++) {
+			str = netxen_nic_gstrings_stats[i].stat_string;
+			ethtool_puts(&data, str);
 		}
 		break;
 	}
diff --git a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
index 97b059be1041..e50e1df0a433 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
@@ -272,16 +272,14 @@ static void qede_get_strings_stats_txq(struct qede_dev *edev,
 {
 	int i;
 
-	for (i = 0; i < QEDE_NUM_TQSTATS; i++) {
+	for (i = 0; i < QEDE_NUM_TQSTATS; i++)
 		if (txq->is_xdp)
-			sprintf(*buf, "%d [XDP]: %s",
-				QEDE_TXQ_XDP_TO_IDX(edev, txq),
-				qede_tqstats_arr[i].string);
+			ethtool_sprintf(buf, "%d [XDP]: %s",
+					QEDE_TXQ_XDP_TO_IDX(edev, txq),
+					qede_tqstats_arr[i].string);
 		else
-			sprintf(*buf, "%d_%d: %s", txq->index, txq->cos,
-				qede_tqstats_arr[i].string);
-		*buf += ETH_GSTRING_LEN;
-	}
+			ethtool_sprintf(buf, "%d_%d: %s", txq->index, txq->cos,
+					qede_tqstats_arr[i].string);
 }
 
 static void qede_get_strings_stats_rxq(struct qede_dev *edev,
@@ -289,11 +287,9 @@ static void qede_get_strings_stats_rxq(struct qede_dev *edev,
 {
 	int i;
 
-	for (i = 0; i < QEDE_NUM_RQSTATS; i++) {
-		sprintf(*buf, "%d: %s", rxq->rxq_id,
-			qede_rqstats_arr[i].string);
-		*buf += ETH_GSTRING_LEN;
-	}
+	for (i = 0; i < QEDE_NUM_RQSTATS; i++)
+		ethtool_sprintf(buf, "%d: %s", rxq->rxq_id,
+				qede_rqstats_arr[i].string);
 }
 
 static bool qede_is_irrelevant_stat(struct qede_dev *edev, int stat_index)
@@ -331,26 +327,26 @@ static void qede_get_strings_stats(struct qede_dev *edev, u8 *buf)
 	for (i = 0; i < QEDE_NUM_STATS; i++) {
 		if (qede_is_irrelevant_stat(edev, i))
 			continue;
-		strcpy(buf, qede_stats_arr[i].string);
-		buf += ETH_GSTRING_LEN;
+		ethtool_puts(&buf, qede_stats_arr[i].string);
 	}
 }
 
 static void qede_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
 {
 	struct qede_dev *edev = netdev_priv(dev);
+	int i;
 
 	switch (stringset) {
 	case ETH_SS_STATS:
 		qede_get_strings_stats(edev, buf);
 		break;
 	case ETH_SS_PRIV_FLAGS:
-		memcpy(buf, qede_private_arr,
-		       ETH_GSTRING_LEN * QEDE_PRI_FLAG_LEN);
+		for (i = 0; i < QEDE_PRI_FLAG_LEN; i++)
+			ethtool_puts(&buf, qede_private_arr[i]);
 		break;
 	case ETH_SS_TEST:
-		memcpy(buf, qede_tests_str_arr,
-		       ETH_GSTRING_LEN * QEDE_ETHTOOL_TEST_MAX);
+		for (i = 0; i < QEDE_ETHTOOL_TEST_MAX; i++)
+			ethtool_puts(&buf, qede_tests_str_arr[i]);
 		break;
 	default:
 		DP_VERBOSE(edev, QED_MSG_DEBUG,
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c
index c1436e1554de..17450e05c437 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c
@@ -1196,60 +1196,56 @@ qlcnic_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 {
 	struct qlcnic_adapter *adapter = netdev_priv(dev);
 	int index, i, num_stats;
+	const char *str;
 
 	switch (stringset) {
 	case ETH_SS_TEST:
-		memcpy(data, *qlcnic_gstrings_test,
-		       QLCNIC_TEST_LEN * ETH_GSTRING_LEN);
+		for (i = 0; i < QLCNIC_TEST_LEN; i++)
+			ethtool_puts(&data, qlcnic_gstrings_test[i]);
 		break;
 	case ETH_SS_STATS:
 		num_stats = ARRAY_SIZE(qlcnic_tx_queue_stats_strings);
-		for (i = 0; i < adapter->drv_tx_rings; i++) {
+		for (i = 0; i < adapter->drv_tx_rings; i++)
 			for (index = 0; index < num_stats; index++) {
-				sprintf(data, "tx_queue_%d %s", i,
-					qlcnic_tx_queue_stats_strings[index]);
-				data += ETH_GSTRING_LEN;
+				str = qlcnic_tx_queue_stats_strings[index];
+				ethtool_sprintf(&data, "tx_queue_%d %s", i,
+						str);
 			}
-		}
 
-		for (index = 0; index < QLCNIC_STATS_LEN; index++) {
-			memcpy(data + index * ETH_GSTRING_LEN,
-			       qlcnic_gstrings_stats[index].stat_string,
-			       ETH_GSTRING_LEN);
+		for (i = 0; i < QLCNIC_STATS_LEN; i++) {
+			str = qlcnic_gstrings_stats[i].stat_string;
+			ethtool_puts(&data, str);
 		}
 
 		if (qlcnic_83xx_check(adapter)) {
 			num_stats = ARRAY_SIZE(qlcnic_83xx_tx_stats_strings);
-			for (i = 0; i < num_stats; i++, index++)
-				memcpy(data + index * ETH_GSTRING_LEN,
-				       qlcnic_83xx_tx_stats_strings[i],
-				       ETH_GSTRING_LEN);
+			for (i = 0; i < num_stats; i++) {
+				str = qlcnic_83xx_tx_stats_strings[i];
+				ethtool_puts(&data, str);
+			}
 			num_stats = ARRAY_SIZE(qlcnic_83xx_mac_stats_strings);
-			for (i = 0; i < num_stats; i++, index++)
-				memcpy(data + index * ETH_GSTRING_LEN,
-				       qlcnic_83xx_mac_stats_strings[i],
-				       ETH_GSTRING_LEN);
+			for (i = 0; i < num_stats; i++) {
+				str = qlcnic_83xx_mac_stats_strings[i];
+				ethtool_puts(&data, str);
+			}
 			num_stats = ARRAY_SIZE(qlcnic_83xx_rx_stats_strings);
-			for (i = 0; i < num_stats; i++, index++)
-				memcpy(data + index * ETH_GSTRING_LEN,
-				       qlcnic_83xx_rx_stats_strings[i],
-				       ETH_GSTRING_LEN);
+			for (i = 0; i < num_stats; i++) {
+				str = qlcnic_83xx_rx_stats_strings[i];
+				ethtool_puts(&data, str);
+			}
 			return;
 		} else {
 			num_stats = ARRAY_SIZE(qlcnic_83xx_mac_stats_strings);
-			for (i = 0; i < num_stats; i++, index++)
-				memcpy(data + index * ETH_GSTRING_LEN,
-				       qlcnic_83xx_mac_stats_strings[i],
-				       ETH_GSTRING_LEN);
+			for (i = 0; i < num_stats; i++) {
+				str = qlcnic_83xx_mac_stats_strings[i];
+				ethtool_puts(&data, str);
+			}
 		}
 		if (!(adapter->flags & QLCNIC_ESWITCH_ENABLED))
 			return;
 		num_stats = ARRAY_SIZE(qlcnic_device_gstrings_stats);
-		for (i = 0; i < num_stats; index++, i++) {
-			memcpy(data + index * ETH_GSTRING_LEN,
-			       qlcnic_device_gstrings_stats[i],
-			       ETH_GSTRING_LEN);
-		}
+		for (i = 0; i < num_stats; i++)
+			ethtool_puts(&data, qlcnic_device_gstrings_stats[i]);
 	}
 }
 
-- 
2.47.0


