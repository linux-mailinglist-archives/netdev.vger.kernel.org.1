Return-Path: <netdev+bounces-141665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF909BBF01
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 21:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E30A1C21CE5
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 20:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5931F76A3;
	Mon,  4 Nov 2024 20:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFbxJ06E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7BE1F7569;
	Mon,  4 Nov 2024 20:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730753308; cv=none; b=jY6EeG6ADg7nvYkoER+UQLiX7xpZdvxb2P54ta0FBcWpHxHQg4Cr3DJ1VL95NILNS/7Detyp2ZN1uToKxLu6yAUKH+AUGehGy4rXqf/ygiJBI5A1NiF4KUrcIX8ZoV8x3U9UyeWp+Dc0bAvrR8Jy5vcth1XvDW4ce/htLMm2sO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730753308; c=relaxed/simple;
	bh=8EnhGD2qlhj8Z6sW8iG8NB8c0Is3MLT8Zp3OfNibmls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UfZRazksIOZMOy5A8nOX81Phz6JgpEig3MQ3D4smFwULa81pCai/7W23DZPcUhYxajDha3aUGQYiNNG+OvCgnVBV5KNiOG3MIvus31gDp84Zvm/HqSFkqTL7ez5fQxsBNo8WvQDMawfI/qHrAZ123RCUpX2JOYzkvPqCJN4sl1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFbxJ06E; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20ca388d242so46239395ad.2;
        Mon, 04 Nov 2024 12:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730753306; x=1731358106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fg1kGUhfncmA8PwYI9BJDMVXGlhNrkCz2YzfyCWQjec=;
        b=SFbxJ06EFjXT/t29Ed+YYUdBlBMylJ7uvdlKBb/bxpzsSDXpL8yAF+FR/uUhXHODcw
         uJXDeMO7M3Rmo71MSGgeePwLyaRxRJKm76YjQOcDf2wT2gznO4iecjRXuhlMjbdOiNao
         dWgqM4Q8gW0avR2SLnXN+WMChiPB/RI/sUqi/IG+jwiHamnCkdzHpnWYLQtwaQQfuzJr
         ge2jfbZ+CagevtsFaGqVS+GJELpEoFiSGh3VBrqfl2Cq4B9PcJDbZmrDFFiToY9fWR1O
         pHoRCrV7gDyfTzZAu55QU60CQxJiWAwNpTEqBLXKl39KpqSPBwZfI6rD1lyUmeTqcvuN
         XD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730753306; x=1731358106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fg1kGUhfncmA8PwYI9BJDMVXGlhNrkCz2YzfyCWQjec=;
        b=ABvzZbXYWwYeVEv0Svo/6E6TZ5DVLeatKzHF7fRtpG9jF3U9wkDZLTChYnul++vABk
         YPg2goPd+zCfbDEklBwEbD6GznM4UPwsU4ragtrzBqi8SqVuC0SPhfHM8U7Pm8S4NUbl
         156dg2UQI+U5gKXfWHlL4YVv6C62BNiyRb+HGiyHgrS1r5C1oD27kudh06xN8u0qazTg
         uzKGh5BIGkFHaxTASKlExuBYtBUjzknuxY64aACbt4m1qflUyNNYQitkiRVHQZKy0ex5
         tyh+D+GpT3ka/ME29bC8o29ErBChUoF//nf+zBPglR9HlqgyGjYSKblfkroU4yDzYDi4
         Cshg==
X-Forwarded-Encrypted: i=1; AJvYcCXtKIXmXIXjhSem6b2qOcAqsoQXP6kc3tJecrUhRFhON9h+NPIbQaU+DpZdWABCGYbeJQUso0UTQXzYHO4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3FO2Hmf/KqVWJPND5ijzrby2sdNVwThT3Zg3ri0ofTrCcAYmF
	iRv/MBfOtxr+RzLljcLy/VbKKy9USAfBbBvFGuD+O33SxMHaKMmPxvnoOX4t
X-Google-Smtp-Source: AGHT+IHfHRv0jMa19eosOtiDt2co1VlwhIZJtgvkHrlXq/nss6E70COsdiTiL3FykNuKgAYgTyWVrw==
X-Received: by 2002:a17:903:1c7:b0:206:a87c:2864 with SMTP id d9443c01a7336-2111afd6ca6mr155354385ad.42.1730753305647;
        Mon, 04 Nov 2024 12:48:25 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057a6815sm66245235ad.135.2024.11.04.12.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 12:48:25 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Jian Shen <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 net-next] net: hisilicon: hns3: use ethtool string helpers
Date: Mon,  4 Nov 2024 12:48:23 -0800
Message-ID: <20241104204823.297277-1-rosenp@gmail.com>
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
Reviewed-by: Jijie Shao <shaojijie@huawei.com>
Tested-by: Jijie Shao <shaojijie@huawei.com>
---
 v2: remove now useless define MAX_PREFIX_LENGTH
 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  2 +-
 .../hns3/hns3_common/hclge_comm_tqp_stats.c   | 11 ++--
 .../hns3/hns3_common/hclge_comm_tqp_stats.h   |  2 +-
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    | 54 ++++++-------------
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 50 +++++++----------
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      |  6 +--
 6 files changed, 44 insertions(+), 81 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 27dbe367f3d3..710a8f9f2248 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -677,7 +677,7 @@ struct hnae3_ae_ops {
 	void (*get_mac_stats)(struct hnae3_handle *handle,
 			      struct hns3_mac_stats *mac_stats);
 	void (*get_strings)(struct hnae3_handle *handle,
-			    u32 stringset, u8 *data);
+			    u32 stringset, u8 **data);
 	int (*get_sset_count)(struct hnae3_handle *handle, int stringset);
 
 	void (*get_regs)(struct hnae3_handle *handle, u32 *version,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats.c b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats.c
index 2b31188ff555..f9a3d6fc4416 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats.c
@@ -36,27 +36,22 @@ int hclge_comm_tqps_get_sset_count(struct hnae3_handle *handle)
 }
 EXPORT_SYMBOL_GPL(hclge_comm_tqps_get_sset_count);
 
-u8 *hclge_comm_tqps_get_strings(struct hnae3_handle *handle, u8 *data)
+void hclge_comm_tqps_get_strings(struct hnae3_handle *handle, u8 **data)
 {
 	struct hnae3_knic_private_info *kinfo = &handle->kinfo;
-	u8 *buff = data;
 	u16 i;
 
 	for (i = 0; i < kinfo->num_tqps; i++) {
 		struct hclge_comm_tqp *tqp =
 			container_of(kinfo->tqp[i], struct hclge_comm_tqp, q);
-		snprintf(buff, ETH_GSTRING_LEN, "txq%u_pktnum_rcd", tqp->index);
-		buff += ETH_GSTRING_LEN;
+		ethtool_sprintf(data, "txq%u_pktnum_rcd", tqp->index);
 	}
 
 	for (i = 0; i < kinfo->num_tqps; i++) {
 		struct hclge_comm_tqp *tqp =
 			container_of(kinfo->tqp[i], struct hclge_comm_tqp, q);
-		snprintf(buff, ETH_GSTRING_LEN, "rxq%u_pktnum_rcd", tqp->index);
-		buff += ETH_GSTRING_LEN;
+		ethtool_sprintf(data, "rxq%u_pktnum_rcd", tqp->index);
 	}
-
-	return buff;
 }
 EXPORT_SYMBOL_GPL(hclge_comm_tqps_get_strings);
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats.h b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats.h
index a46350162ee8..b9ff424c0bc2 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats.h
@@ -32,7 +32,7 @@ struct hclge_comm_tqp {
 
 u64 *hclge_comm_tqps_get_stats(struct hnae3_handle *handle, u64 *data);
 int hclge_comm_tqps_get_sset_count(struct hnae3_handle *handle);
-u8 *hclge_comm_tqps_get_strings(struct hnae3_handle *handle, u8 *data);
+void hclge_comm_tqps_get_strings(struct hnae3_handle *handle, u8 **data);
 void hclge_comm_reset_tqp_stats(struct hnae3_handle *handle);
 int hclge_comm_tqps_update_stats(struct hnae3_handle *handle,
 				 struct hclge_comm_hw *hw);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 97eaeec1952b..34a07fffadbb 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -509,54 +509,37 @@ static int hns3_get_sset_count(struct net_device *netdev, int stringset)
 	}
 }
 
-static void *hns3_update_strings(u8 *data, const struct hns3_stats *stats,
-		u32 stat_count, u32 num_tqps, const char *prefix)
+static void hns3_update_strings(u8 **data, const struct hns3_stats *stats,
+				u32 stat_count, u32 num_tqps,
+				const char *prefix)
 {
-#define MAX_PREFIX_SIZE (6 + 4)
-	u32 size_left;
 	u32 i, j;
-	u32 n1;
 
-	for (i = 0; i < num_tqps; i++) {
-		for (j = 0; j < stat_count; j++) {
-			data[ETH_GSTRING_LEN - 1] = '\0';
-
-			/* first, prepend the prefix string */
-			n1 = scnprintf(data, MAX_PREFIX_SIZE, "%s%u_",
-				       prefix, i);
-			size_left = (ETH_GSTRING_LEN - 1) - n1;
-
-			/* now, concatenate the stats string to it */
-			strncat(data, stats[j].stats_string, size_left);
-			data += ETH_GSTRING_LEN;
-		}
-	}
-
-	return data;
+	for (i = 0; i < num_tqps; i++)
+		for (j = 0; j < stat_count; j++)
+			ethtool_sprintf(data, "%s%u_%s", prefix, i,
+					stats[j].stats_string);
 }
 
-static u8 *hns3_get_strings_tqps(struct hnae3_handle *handle, u8 *data)
+static void hns3_get_strings_tqps(struct hnae3_handle *handle, u8 **data)
 {
 	struct hnae3_knic_private_info *kinfo = &handle->kinfo;
 	const char tx_prefix[] = "txq";
 	const char rx_prefix[] = "rxq";
 
 	/* get strings for Tx */
-	data = hns3_update_strings(data, hns3_txq_stats, HNS3_TXQ_STATS_COUNT,
-				   kinfo->num_tqps, tx_prefix);
+	hns3_update_strings(data, hns3_txq_stats, HNS3_TXQ_STATS_COUNT,
+			    kinfo->num_tqps, tx_prefix);
 
 	/* get strings for Rx */
-	data = hns3_update_strings(data, hns3_rxq_stats, HNS3_RXQ_STATS_COUNT,
-				   kinfo->num_tqps, rx_prefix);
-
-	return data;
+	hns3_update_strings(data, hns3_rxq_stats, HNS3_RXQ_STATS_COUNT,
+			    kinfo->num_tqps, rx_prefix);
 }
 
 static void hns3_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 {
 	struct hnae3_handle *h = hns3_get_handle(netdev);
 	const struct hnae3_ae_ops *ops = h->ae_algo->ops;
-	char *buff = (char *)data;
 	int i;
 
 	if (!ops->get_strings)
@@ -564,18 +547,15 @@ static void hns3_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 
 	switch (stringset) {
 	case ETH_SS_STATS:
-		buff = hns3_get_strings_tqps(h, buff);
-		ops->get_strings(h, stringset, (u8 *)buff);
+		hns3_get_strings_tqps(h, &data);
+		ops->get_strings(h, stringset, &data);
 		break;
 	case ETH_SS_TEST:
-		ops->get_strings(h, stringset, data);
+		ops->get_strings(h, stringset, &data);
 		break;
 	case ETH_SS_PRIV_FLAGS:
-		for (i = 0; i < HNS3_PRIV_FLAGS_LEN; i++) {
-			snprintf(buff, ETH_GSTRING_LEN, "%s",
-				 hns3_priv_flags[i].name);
-			buff += ETH_GSTRING_LEN;
-		}
+		for (i = 0; i < HNS3_PRIV_FLAGS_LEN; i++)
+			ethtool_puts(&data, hns3_priv_flags[i].name);
 		break;
 	default:
 		break;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 728f4777e51f..5fc08d686d25 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -595,25 +595,21 @@ static u64 *hclge_comm_get_stats(struct hclge_dev *hdev,
 	return buf;
 }
 
-static u8 *hclge_comm_get_strings(struct hclge_dev *hdev, u32 stringset,
-				  const struct hclge_comm_stats_str strs[],
-				  int size, u8 *data)
+static void hclge_comm_get_strings(struct hclge_dev *hdev, u32 stringset,
+				   const struct hclge_comm_stats_str strs[],
+				   int size, u8 **data)
 {
-	char *buff = (char *)data;
 	u32 i;
 
 	if (stringset != ETH_SS_STATS)
-		return buff;
+		return;
 
 	for (i = 0; i < size; i++) {
 		if (strs[i].stats_num > hdev->ae_dev->dev_specs.mac_stats_num)
 			continue;
 
-		snprintf(buff, ETH_GSTRING_LEN, "%s", strs[i].desc);
-		buff = buff + ETH_GSTRING_LEN;
+		ethtool_puts(data, strs[i].desc);
 	}
-
-	return (u8 *)buff;
 }
 
 static void hclge_update_stats_for_all(struct hclge_dev *hdev)
@@ -718,44 +714,38 @@ static int hclge_get_sset_count(struct hnae3_handle *handle, int stringset)
 }
 
 static void hclge_get_strings(struct hnae3_handle *handle, u32 stringset,
-			      u8 *data)
+			      u8 **data)
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
-	u8 *p = (char *)data;
+	const char *str;
 	int size;
 
 	if (stringset == ETH_SS_STATS) {
 		size = ARRAY_SIZE(g_mac_stats_string);
-		p = hclge_comm_get_strings(hdev, stringset, g_mac_stats_string,
-					   size, p);
-		p = hclge_comm_tqps_get_strings(handle, p);
+		hclge_comm_get_strings(hdev, stringset, g_mac_stats_string,
+				       size, data);
+		hclge_comm_tqps_get_strings(handle, data);
 	} else if (stringset == ETH_SS_TEST) {
 		if (handle->flags & HNAE3_SUPPORT_EXTERNAL_LOOPBACK) {
-			memcpy(p, hns3_nic_test_strs[HNAE3_LOOP_EXTERNAL],
-			       ETH_GSTRING_LEN);
-			p += ETH_GSTRING_LEN;
+			str = hns3_nic_test_strs[HNAE3_LOOP_EXTERNAL];
+			ethtool_puts(data, str);
 		}
 		if (handle->flags & HNAE3_SUPPORT_APP_LOOPBACK) {
-			memcpy(p, hns3_nic_test_strs[HNAE3_LOOP_APP],
-			       ETH_GSTRING_LEN);
-			p += ETH_GSTRING_LEN;
+			str = hns3_nic_test_strs[HNAE3_LOOP_APP];
+			ethtool_puts(data, str);
 		}
 		if (handle->flags & HNAE3_SUPPORT_SERDES_SERIAL_LOOPBACK) {
-			memcpy(p, hns3_nic_test_strs[HNAE3_LOOP_SERIAL_SERDES],
-			       ETH_GSTRING_LEN);
-			p += ETH_GSTRING_LEN;
+			str = hns3_nic_test_strs[HNAE3_LOOP_SERIAL_SERDES];
+			ethtool_puts(data, str);
 		}
 		if (handle->flags & HNAE3_SUPPORT_SERDES_PARALLEL_LOOPBACK) {
-			memcpy(p,
-			       hns3_nic_test_strs[HNAE3_LOOP_PARALLEL_SERDES],
-			       ETH_GSTRING_LEN);
-			p += ETH_GSTRING_LEN;
+			str = hns3_nic_test_strs[HNAE3_LOOP_PARALLEL_SERDES];
+			ethtool_puts(data, str);
 		}
 		if (handle->flags & HNAE3_SUPPORT_PHY_LOOPBACK) {
-			memcpy(p, hns3_nic_test_strs[HNAE3_LOOP_PHY],
-			       ETH_GSTRING_LEN);
-			p += ETH_GSTRING_LEN;
+			str = hns3_nic_test_strs[HNAE3_LOOP_PHY];
+			ethtool_puts(data, str);
 		}
 	}
 }
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 896f1eb172d3..8739da317897 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -130,12 +130,10 @@ static int hclgevf_get_sset_count(struct hnae3_handle *handle, int strset)
 }
 
 static void hclgevf_get_strings(struct hnae3_handle *handle, u32 strset,
-				u8 *data)
+				u8 **data)
 {
-	u8 *p = (char *)data;
-
 	if (strset == ETH_SS_STATS)
-		p = hclge_comm_tqps_get_strings(handle, p);
+		hclge_comm_tqps_get_strings(handle, data);
 }
 
 static void hclgevf_get_stats(struct hnae3_handle *handle, u64 *data)
-- 
2.47.0


