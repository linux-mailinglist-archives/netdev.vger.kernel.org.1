Return-Path: <netdev+bounces-141128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB859B9A84
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 23:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D3941F21FE7
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 22:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49151E6DD5;
	Fri,  1 Nov 2024 22:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEpPxe0Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E18E140E34;
	Fri,  1 Nov 2024 22:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730498429; cv=none; b=PiDVUaRteDk9ZVHwmcp2pFwtda4vmjRITOMNRBOz22UvhAI34WYUe+Djeo7uE0+zEQEK/6zySLAPTw6eCCCNnyqH1DoIydfYRRNeD8Axk0YsuI08miuVuOZbiH4UuvithYD3KrDPv2o8JRskQnplmNsIdl3Aw3CQqBmh3GH1tWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730498429; c=relaxed/simple;
	bh=868UjNU7I8Jx0s4rzZ034VXHhGbSs/hiS0NKYG9xSyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CTgRlFdpv9ZnRVNDaUdKVO2Q0Zkm4YFrUXMvqSMpp6EHGqeWcJIzGzdeMLV4DStB4IOy54OvuoiuUB7v/hlC9MeQktY+bafefSzKXyyszMgKinQ7gRRIj09vkR3nPiiD0QQjg4dmFDjyQNQJhUIwYRcE80Vwf1nllQYCQWKuJMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEpPxe0Z; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7d916b6a73aso1608867a12.1;
        Fri, 01 Nov 2024 15:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730498427; x=1731103227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skk3hYFeBwotAyy4dz+Y4hArHx0owADLBB7g9pIcvx4=;
        b=aEpPxe0ZLVneW72bhsAY08bDd/vCg+Ithrc7j/TngPewbwLBeeObgunIAsAQJ5s+vT
         WYjEaSeRcKxjrJQhh0QAPhk+8xmRgDdFc0Ay7fuLgygLRS6XX9zfRkWiDnQx63EWxAx+
         BU8WeC4Qd0rn9noZ5O9j9KAQEod/UQIL2GqWvfYhjsXuNj+usZnUN3CI4yBz5gkGmsRz
         hOJVHPPfGZZTfK+YtslsEgDcBjhXe+giVihmF/Rwkxq+U0uz8ZO7kr65UX82q4SO5YYI
         UMHu1PMo8c80VWu0ONXvNl1UJjtmyE7ceE8Wk8sdT7G/kivHCOd/GaJu7+nlGFYxBUqB
         epLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730498427; x=1731103227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=skk3hYFeBwotAyy4dz+Y4hArHx0owADLBB7g9pIcvx4=;
        b=Q4m6ygG+d76HEAwOHnhxj6T0fBQ+bnyN81lyuba34U3lV5pccd2wSARaBKEqNMoMQC
         rbzxr+n/Xn/U8tcztyhClknEy4um9Ti31Qerq0m1nMFaJpjCFF3g7CKPiyUJx2/snUsB
         fPa4EqM6bgiaEV4V1W21pHNB5Cx6fgFCLAd6sc6r5mhgPPro6KMZ3dgdzo7p/k7uBipc
         8K1pu+/Lif+Xk3g+6OACFotxU9ZEAR+2uuOwwxytKI0fu3s0uSxNU1zY/vo29OcwKkEK
         SdfT6M2FEfejlKGP1ROFPzttfuWRn4bflt+oheLYRkqZNsh/X0A1OHgwOCxbGOma+077
         eBZA==
X-Forwarded-Encrypted: i=1; AJvYcCU4dLh8yEKzuSxtnfby9uwuBrNuOuUR8d0P+VZZdW5OddBt8NlI9+kTJ+UR/kIcimP8sTfqCos0N0rMek8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvQUlchL6qCqCY+24S971Mx5PXueE28QmVoPjKJDOs9aL43efA
	wDCmk58Tu72oDYHly0Xb3nqvLRoHFcoapy4+d5doiLd02AvuWxtne/W5ieat
X-Google-Smtp-Source: AGHT+IGWZBq1YoCZhCrTgTr+pRwmZG7oZ8xq2UIi5WVuc2ZgZUAKt36Hz+YY1uVXXCOyZELIC2UN5g==
X-Received: by 2002:a17:903:18c:b0:211:898:7cf0 with SMTP id d9443c01a7336-211089883aamr82985085ad.12.1730498427214;
        Fri, 01 Nov 2024 15:00:27 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056ef5e0sm25555235ad.34.2024.11.01.15.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 15:00:26 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Jian Shen <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jijie Shao <shaojijie@huawei.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: hisilicon: hns3: use ethtool string helpers
Date: Fri,  1 Nov 2024 15:00:23 -0700
Message-ID: <20241101220023.290926-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241101220023.290926-1-rosenp@gmail.com>
References: <20241101220023.290926-1-rosenp@gmail.com>
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
 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  2 +-
 .../hns3/hns3_common/hclge_comm_tqp_stats.c   | 11 ++--
 .../hns3/hns3_common/hclge_comm_tqp_stats.h   |  2 +-
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    | 53 ++++++-------------
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 50 +++++++----------
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      |  6 +--
 6 files changed, 44 insertions(+), 80 deletions(-)

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
index 97eaeec1952b..b6cc51bfdd33 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -509,54 +509,38 @@ static int hns3_get_sset_count(struct net_device *netdev, int stringset)
 	}
 }
 
-static void *hns3_update_strings(u8 *data, const struct hns3_stats *stats,
-		u32 stat_count, u32 num_tqps, const char *prefix)
+static void hns3_update_strings(u8 **data, const struct hns3_stats *stats,
+				u32 stat_count, u32 num_tqps,
+				const char *prefix)
 {
 #define MAX_PREFIX_SIZE (6 + 4)
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
@@ -564,18 +548,15 @@ static void hns3_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 
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


