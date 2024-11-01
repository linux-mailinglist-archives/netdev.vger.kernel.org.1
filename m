Return-Path: <netdev+bounces-141127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A0E9B9A83
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 23:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A5CC1C20C30
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 22:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DE91DB344;
	Fri,  1 Nov 2024 22:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XG4s0D6d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB62D158DC4;
	Fri,  1 Nov 2024 22:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730498429; cv=none; b=IQBTWuSbxUSd3O4J5gg5UgXkBynh4DNdtZzLgYvY+7gTeHWHoD8t6ZpGN4/caGKS0vyXKhbDzyLqFCiKqwjFLsGSGB48aKe1RnhfgJuN+cIr/ReOC/rAQ+6ZvQ1Qm4jH10zyXQDEpgNFo0hOI3YodceC1hUGwn98PRHj/hEiXGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730498429; c=relaxed/simple;
	bh=ndUK1eWvJ/z/dMzmbTtZND76oqrX78enXLf7EMDKl0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GH0Pv383OOdYZDoHOa1JfnHehgDGcJi5OXFdPpzWyC4t9oz9yaYGbXZijZzVe85AFNkI61RsQ9K7COaHKp4KeM1bmUTlkUPTNlIJICPVm876fl3JNFYFUCPOgyYHSv2S5arJhyBK1G+kYkeFPUXtgSOUjfS4JEjuNrdUynGeGCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XG4s0D6d; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20e576dbc42so25017935ad.0;
        Fri, 01 Nov 2024 15:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730498426; x=1731103226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1IoTC4eJ+EZ10taU+OqR7WwLFZfxBZnW0OgYTSox+9Q=;
        b=XG4s0D6dfM9Om2MHn6CMqvDfGcqipJZJCfAsr16t3JueisAnsBYsW+X/UiRY8hQZwD
         2vHQiXdh+AdI2xLkMgUlRadGb9avSl1qW5uCjsRVV6yka7584JDyhI1ZR1G3Uq1swlsf
         KPYDMohyVSXwfotKMJXhQ7AHOzHaNsbJBUAKKf0p8f7zY194HNWD08jjXKZ6DmBBfOX/
         2SiAPjVJ/+N6xccnBTl+8VshgW6dPMPiLpXScMMkcG3JhChXuAt8ahIOVSi6XMEZaYQt
         NLFZZh2Ipe2KJF6N8dCzFLJS2u9utvPsym/jv1/JejXchu00n6H1T1P9pymp69c1Pwvy
         UwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730498426; x=1731103226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1IoTC4eJ+EZ10taU+OqR7WwLFZfxBZnW0OgYTSox+9Q=;
        b=eycHlXAqIzBRScqWchtQZ4TN8VtIGSfjA0nXRBLlWGYAehn/2z9cLQQkvZqVJtaNwr
         mVxmTMMzIArHqZu61lnrPWAuat9qMzsQ9QCETeesGit5flLEIjeC8Da17vnG8cx+LVXH
         jBJVQkl00fMKuwoxuMWgJmCxfjqnNoL+LP1gMMoHRGCLZ/gjLrU5kNThx1fz0bgMrUJ/
         O03w6MucWcrDzb+KuxeXjEWsKYxWUXEgytZ3lEROmSh+tTMpP7wHuKAQHsQfYdtxnyd3
         +o5fLCEYu5i0Zc5B1RTi8gEEwEvJTZBt0EYJfDUvuIHoaZEdLLKaVKoNmN7ltta10dno
         0lBw==
X-Forwarded-Encrypted: i=1; AJvYcCXo7qfsAtwJmIz93Fjjcc160NMrWB08mPgurps5xBn7sDteiBTpssvjWAnvb+UMkdffZkGKKiOYKeK9DSE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6h8s/mX/aoMSJO4TKXebwrGZY2DxSeUTEUdrPagTD0EV0v3p2
	LaT5rdAjYedy0or5U4rqEmrLDq2dTBwi3jF6dg9s1l4wM1mAfW4h8i+wOcZZ
X-Google-Smtp-Source: AGHT+IFwa1uNd0bMCxgG8/TGwCOt6PYdjy+tf6z95k0Vs8zwdnMG5VKlasDsple6Fy7R+Owz0jcrJw==
X-Received: by 2002:a17:902:e801:b0:20b:9547:9b36 with SMTP id d9443c01a7336-21103c786f3mr99976185ad.46.1730498425785;
        Fri, 01 Nov 2024 15:00:25 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056ef5e0sm25555235ad.34.2024.11.01.15.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 15:00:25 -0700 (PDT)
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
Subject: [PATCH net-next] net: hisilicon: hns: use ethtool string helpers
Date: Fri,  1 Nov 2024 15:00:22 -0700
Message-ID: <20241101220023.290926-1-rosenp@gmail.com>
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
---
 drivers/net/ethernet/hisilicon/hns/hnae.h     |  2 +-
 .../net/ethernet/hisilicon/hns/hns_ae_adapt.c | 20 ++----
 .../ethernet/hisilicon/hns/hns_dsaf_gmac.c    |  5 +-
 .../net/ethernet/hisilicon/hns/hns_dsaf_mac.c |  3 +-
 .../net/ethernet/hisilicon/hns/hns_dsaf_mac.h |  4 +-
 .../ethernet/hisilicon/hns/hns_dsaf_main.c    | 70 +++++++------------
 .../ethernet/hisilicon/hns/hns_dsaf_main.h    |  2 +-
 .../net/ethernet/hisilicon/hns/hns_dsaf_ppe.c | 31 ++++----
 .../net/ethernet/hisilicon/hns/hns_dsaf_ppe.h |  2 +-
 .../net/ethernet/hisilicon/hns/hns_dsaf_rcb.c | 66 +++++++++--------
 .../net/ethernet/hisilicon/hns/hns_dsaf_rcb.h |  2 +-
 .../ethernet/hisilicon/hns/hns_dsaf_xgmac.c   |  5 +-
 .../net/ethernet/hisilicon/hns/hns_ethtool.c  | 67 +++++++++---------
 13 files changed, 122 insertions(+), 157 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hnae.h b/drivers/net/ethernet/hisilicon/hns/hnae.h
index d72657444ef3..2ae34d01fd36 100644
--- a/drivers/net/ethernet/hisilicon/hns/hnae.h
+++ b/drivers/net/ethernet/hisilicon/hns/hnae.h
@@ -512,7 +512,7 @@ struct hnae_ae_ops {
 			     struct net_device_stats *net_stats);
 	void (*get_stats)(struct hnae_handle *handle, u64 *data);
 	void (*get_strings)(struct hnae_handle *handle,
-			    u32 stringset, u8 *data);
+			    u32 stringset, u8 **data);
 	int (*get_sset_count)(struct hnae_handle *handle, int stringset);
 	void (*update_led_status)(struct hnae_handle *handle);
 	int (*set_led_id)(struct hnae_handle *handle,
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c b/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
index bc3e406f0139..8ce910f8d0cc 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
@@ -730,15 +730,14 @@ static void hns_ae_get_stats(struct hnae_handle *handle, u64 *data)
 		hns_dsaf_get_stats(vf_cb->dsaf_dev, p, vf_cb->port_index);
 }
 
-static void hns_ae_get_strings(struct hnae_handle *handle,
-			       u32 stringset, u8 *data)
+static void hns_ae_get_strings(struct hnae_handle *handle, u32 stringset,
+			       u8 **data)
 {
 	int port;
 	int idx;
 	struct hns_mac_cb *mac_cb;
 	struct hns_ppe_cb *ppe_cb;
 	struct dsaf_device *dsaf_dev = hns_ae_get_dsaf_dev(handle->dev);
-	u8 *p = data;
 	struct	hnae_vf_cb *vf_cb;
 
 	assert(handle);
@@ -748,19 +747,14 @@ static void hns_ae_get_strings(struct hnae_handle *handle,
 	mac_cb = hns_get_mac_cb(handle);
 	ppe_cb = hns_get_ppe_cb(handle);
 
-	for (idx = 0; idx < handle->q_num; idx++) {
-		hns_rcb_get_strings(stringset, p, idx);
-		p += ETH_GSTRING_LEN * hns_rcb_get_ring_sset_count(stringset);
-	}
-
-	hns_ppe_get_strings(ppe_cb, stringset, p);
-	p += ETH_GSTRING_LEN * hns_ppe_get_sset_count(stringset);
+	for (idx = 0; idx < handle->q_num; idx++)
+		hns_rcb_get_strings(stringset, data, idx);
 
-	hns_mac_get_strings(mac_cb, stringset, p);
-	p += ETH_GSTRING_LEN * hns_mac_get_sset_count(mac_cb, stringset);
+	hns_ppe_get_strings(ppe_cb, stringset, data);
+	hns_mac_get_strings(mac_cb, stringset, data);
 
 	if (mac_cb->mac_type == HNAE_PORT_SERVICE)
-		hns_dsaf_get_strings(stringset, p, port, dsaf_dev);
+		hns_dsaf_get_strings(stringset, data, port, dsaf_dev);
 }
 
 static int hns_ae_get_sset_count(struct hnae_handle *handle, int stringset)
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
index bdb7afaabdd0..400933ca1a29 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
@@ -669,16 +669,15 @@ static void hns_gmac_get_stats(void *mac_drv, u64 *data)
 	}
 }
 
-static void hns_gmac_get_strings(u32 stringset, u8 *data)
+static void hns_gmac_get_strings(u32 stringset, u8 **data)
 {
-	u8 *buff = data;
 	u32 i;
 
 	if (stringset != ETH_SS_STATS)
 		return;
 
 	for (i = 0; i < ARRAY_SIZE(g_gmac_stats_string); i++)
-		ethtool_puts(&buff, g_gmac_stats_string[i].desc);
+		ethtool_puts(data, g_gmac_stats_string[i].desc);
 }
 
 static int hns_gmac_get_sset_count(int stringset)
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
index 5fa9b2eeb929..bc6b269be299 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
@@ -1190,8 +1190,7 @@ void hns_mac_get_stats(struct hns_mac_cb *mac_cb, u64 *data)
 	mac_ctrl_drv->get_ethtool_stats(mac_ctrl_drv, data);
 }
 
-void hns_mac_get_strings(struct hns_mac_cb *mac_cb,
-			 int stringset, u8 *data)
+void hns_mac_get_strings(struct hns_mac_cb *mac_cb, int stringset, u8 **data)
 {
 	struct mac_driver *mac_ctrl_drv = hns_mac_get_drv(mac_cb);
 
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.h b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.h
index edf0bcf76ac9..630f01cf7a71 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.h
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.h
@@ -378,7 +378,7 @@ struct mac_driver {
 	void (*get_regs)(void *mac_drv, void *data);
 	int (*get_regs_count)(void);
 	/* get strings name for ethtool statistic */
-	void (*get_strings)(u32 stringset, u8 *data);
+	void (*get_strings)(u32 stringset, u8 **data);
 	/* get the number of strings*/
 	int (*get_sset_count)(int stringset);
 
@@ -445,7 +445,7 @@ int hns_mac_config_mac_loopback(struct hns_mac_cb *mac_cb,
 				enum hnae_loop loop, int en);
 void hns_mac_update_stats(struct hns_mac_cb *mac_cb);
 void hns_mac_get_stats(struct hns_mac_cb *mac_cb, u64 *data);
-void hns_mac_get_strings(struct hns_mac_cb *mac_cb, int stringset, u8 *data);
+void hns_mac_get_strings(struct hns_mac_cb *mac_cb, int stringset, u8 **data);
 int hns_mac_get_sset_count(struct hns_mac_cb *mac_cb, int stringset);
 void hns_mac_get_regs(struct hns_mac_cb *mac_cb, void *data);
 int hns_mac_get_regs_count(struct hns_mac_cb *mac_cb);
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
index eb60f45a3460..851490346261 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
@@ -2590,55 +2590,34 @@ void hns_dsaf_get_regs(struct dsaf_device *ddev, u32 port, void *data)
 		p[i] = 0xdddddddd;
 }
 
-static char *hns_dsaf_get_node_stats_strings(char *data, int node,
-					     struct dsaf_device *dsaf_dev)
+static void hns_dsaf_get_node_stats_strings(u8 **data, int node,
+					    struct dsaf_device *dsaf_dev)
 {
-	char *buff = data;
-	int i;
 	bool is_ver1 = AE_IS_VER1(dsaf_dev->dsaf_ver);
+	int i;
 
-	snprintf(buff, ETH_GSTRING_LEN, "innod%d_pad_drop_pkts", node);
-	buff += ETH_GSTRING_LEN;
-	snprintf(buff, ETH_GSTRING_LEN, "innod%d_manage_pkts", node);
-	buff += ETH_GSTRING_LEN;
-	snprintf(buff, ETH_GSTRING_LEN, "innod%d_rx_pkts", node);
-	buff += ETH_GSTRING_LEN;
-	snprintf(buff, ETH_GSTRING_LEN, "innod%d_rx_pkt_id", node);
-	buff += ETH_GSTRING_LEN;
-	snprintf(buff, ETH_GSTRING_LEN, "innod%d_rx_pause_frame", node);
-	buff += ETH_GSTRING_LEN;
-	snprintf(buff, ETH_GSTRING_LEN, "innod%d_release_buf_num", node);
-	buff += ETH_GSTRING_LEN;
-	snprintf(buff, ETH_GSTRING_LEN, "innod%d_sbm_drop_pkts", node);
-	buff += ETH_GSTRING_LEN;
-	snprintf(buff, ETH_GSTRING_LEN, "innod%d_crc_false_pkts", node);
-	buff += ETH_GSTRING_LEN;
-	snprintf(buff, ETH_GSTRING_LEN, "innod%d_bp_drop_pkts", node);
-	buff += ETH_GSTRING_LEN;
-	snprintf(buff, ETH_GSTRING_LEN, "innod%d_lookup_rslt_drop_pkts", node);
-	buff += ETH_GSTRING_LEN;
-	snprintf(buff, ETH_GSTRING_LEN, "innod%d_local_rslt_fail_pkts", node);
-	buff += ETH_GSTRING_LEN;
-	snprintf(buff, ETH_GSTRING_LEN, "innod%d_vlan_drop_pkts", node);
-	buff += ETH_GSTRING_LEN;
-	snprintf(buff, ETH_GSTRING_LEN, "innod%d_stp_drop_pkts", node);
-	buff += ETH_GSTRING_LEN;
+	ethtool_sprintf(data, "innod%d_pad_drop_pkts", node);
+	ethtool_sprintf(data, "innod%d_manage_pkts", node);
+	ethtool_sprintf(data, "innod%d_rx_pkts", node);
+	ethtool_sprintf(data, "innod%d_rx_pkt_id", node);
+	ethtool_sprintf(data, "innod%d_rx_pause_frame", node);
+	ethtool_sprintf(data, "innod%d_release_buf_num", node);
+	ethtool_sprintf(data, "innod%d_sbm_drop_pkts", node);
+	ethtool_sprintf(data, "innod%d_crc_false_pkts", node);
+	ethtool_sprintf(data, "innod%d_bp_drop_pkts", node);
+	ethtool_sprintf(data, "innod%d_lookup_rslt_drop_pkts", node);
+	ethtool_sprintf(data, "innod%d_local_rslt_fail_pkts", node);
+	ethtool_sprintf(data, "innod%d_vlan_drop_pkts", node);
+	ethtool_sprintf(data, "innod%d_stp_drop_pkts", node);
 	if (node < DSAF_SERVICE_NW_NUM && !is_ver1) {
 		for (i = 0; i < DSAF_PRIO_NR; i++) {
-			snprintf(buff + 0 * ETH_GSTRING_LEN * DSAF_PRIO_NR,
-				 ETH_GSTRING_LEN, "inod%d_pfc_prio%d_pkts",
-				 node, i);
-			snprintf(buff + 1 * ETH_GSTRING_LEN * DSAF_PRIO_NR,
-				 ETH_GSTRING_LEN, "onod%d_pfc_prio%d_pkts",
-				 node, i);
-			buff += ETH_GSTRING_LEN;
+			ethtool_sprintf(data, "inod%d_pfc_prio%d_pkts", node,
+					i);
+			ethtool_sprintf(data, "onod%d_pfc_prio%d_pkts", node,
+					i);
 		}
-		buff += 1 * DSAF_PRIO_NR * ETH_GSTRING_LEN;
 	}
-	snprintf(buff, ETH_GSTRING_LEN, "onnod%d_tx_pkts", node);
-	buff += ETH_GSTRING_LEN;
-
-	return buff;
+	ethtool_sprintf(data, "onnod%d_tx_pkts", node);
 }
 
 static u64 *hns_dsaf_get_node_stats(struct dsaf_device *ddev, u64 *data,
@@ -2720,21 +2699,20 @@ int hns_dsaf_get_sset_count(struct dsaf_device *dsaf_dev, int stringset)
  *@port:port index
  *@dsaf_dev: dsaf device
  */
-void hns_dsaf_get_strings(int stringset, u8 *data, int port,
+void hns_dsaf_get_strings(int stringset, u8 **data, int port,
 			  struct dsaf_device *dsaf_dev)
 {
-	char *buff = (char *)data;
 	int node = port;
 
 	if (stringset != ETH_SS_STATS)
 		return;
 
 	/* for ge/xge node info */
-	buff = hns_dsaf_get_node_stats_strings(buff, node, dsaf_dev);
+	hns_dsaf_get_node_stats_strings(data, node, dsaf_dev);
 
 	/* for ppe node info */
 	node = port + DSAF_PPE_INODE_BASE;
-	(void)hns_dsaf_get_node_stats_strings(buff, node, dsaf_dev);
+	hns_dsaf_get_node_stats_strings(data, node, dsaf_dev);
 }
 
 /**
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h
index 5526a10caac5..0eb03dff1a8b 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h
@@ -442,7 +442,7 @@ void hns_dsaf_update_stats(struct dsaf_device *dsaf_dev, u32 inode_num);
 
 int hns_dsaf_get_sset_count(struct dsaf_device *dsaf_dev, int stringset);
 void hns_dsaf_get_stats(struct dsaf_device *ddev, u64 *data, int port);
-void hns_dsaf_get_strings(int stringset, u8 *data, int port,
+void hns_dsaf_get_strings(int stringset, u8 **data, int port,
 			  struct dsaf_device *dsaf_dev);
 
 void hns_dsaf_get_regs(struct dsaf_device *ddev, u32 port, void *data);
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c
index a08d1f0a5a16..5013beb4d282 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c
@@ -457,24 +457,23 @@ int hns_ppe_get_regs_count(void)
  * @stringset: string set type
  * @data: output string
  */
-void hns_ppe_get_strings(struct hns_ppe_cb *ppe_cb, int stringset, u8 *data)
+void hns_ppe_get_strings(struct hns_ppe_cb *ppe_cb, int stringset, u8 **data)
 {
 	int index = ppe_cb->index;
-	u8 *buff = data;
-
-	ethtool_sprintf(&buff, "ppe%d_rx_sw_pkt", index);
-	ethtool_sprintf(&buff, "ppe%d_rx_pkt_ok", index);
-	ethtool_sprintf(&buff, "ppe%d_rx_drop_pkt_no_bd", index);
-	ethtool_sprintf(&buff, "ppe%d_rx_alloc_buf_fail", index);
-	ethtool_sprintf(&buff, "ppe%d_rx_alloc_buf_wait", index);
-	ethtool_sprintf(&buff, "ppe%d_rx_pkt_drop_no_buf", index);
-	ethtool_sprintf(&buff, "ppe%d_rx_pkt_err_fifo_full", index);
-
-	ethtool_sprintf(&buff, "ppe%d_tx_bd", index);
-	ethtool_sprintf(&buff, "ppe%d_tx_pkt", index);
-	ethtool_sprintf(&buff, "ppe%d_tx_pkt_ok", index);
-	ethtool_sprintf(&buff, "ppe%d_tx_pkt_err_fifo_empty", index);
-	ethtool_sprintf(&buff, "ppe%d_tx_pkt_err_csum_fail", index);
+
+	ethtool_sprintf(data, "ppe%d_rx_sw_pkt", index);
+	ethtool_sprintf(data, "ppe%d_rx_pkt_ok", index);
+	ethtool_sprintf(data, "ppe%d_rx_drop_pkt_no_bd", index);
+	ethtool_sprintf(data, "ppe%d_rx_alloc_buf_fail", index);
+	ethtool_sprintf(data, "ppe%d_rx_alloc_buf_wait", index);
+	ethtool_sprintf(data, "ppe%d_rx_pkt_drop_no_buf", index);
+	ethtool_sprintf(data, "ppe%d_rx_pkt_err_fifo_full", index);
+
+	ethtool_sprintf(data, "ppe%d_tx_bd", index);
+	ethtool_sprintf(data, "ppe%d_tx_pkt", index);
+	ethtool_sprintf(data, "ppe%d_tx_pkt_ok", index);
+	ethtool_sprintf(data, "ppe%d_tx_pkt_err_fifo_empty", index);
+	ethtool_sprintf(data, "ppe%d_tx_pkt_err_csum_fail", index);
 }
 
 void hns_ppe_get_stats(struct hns_ppe_cb *ppe_cb, u64 *data)
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.h b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.h
index 7e00231c1acf..602c8e971fe4 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.h
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.h
@@ -109,7 +109,7 @@ int hns_ppe_get_sset_count(int stringset);
 int hns_ppe_get_regs_count(void);
 void hns_ppe_get_regs(struct hns_ppe_cb *ppe_cb, void *data);
 
-void hns_ppe_get_strings(struct hns_ppe_cb *ppe_cb, int stringset, u8 *data);
+void hns_ppe_get_strings(struct hns_ppe_cb *ppe_cb, int stringset, u8 **data);
 void hns_ppe_get_stats(struct hns_ppe_cb *ppe_cb, u64 *data);
 void hns_ppe_set_tso_enable(struct hns_ppe_cb *ppe_cb, u32 value);
 void hns_ppe_set_rss_key(struct hns_ppe_cb *ppe_cb,
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
index 93344563a259..46af467aa596 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
@@ -923,44 +923,42 @@ int hns_rcb_get_ring_regs_count(void)
  *@data:strings name value
  *@index:queue index
  */
-void hns_rcb_get_strings(int stringset, u8 *data, int index)
+void hns_rcb_get_strings(int stringset, u8 **data, int index)
 {
-	u8 *buff = data;
-
 	if (stringset != ETH_SS_STATS)
 		return;
 
-	ethtool_sprintf(&buff, "tx_ring%d_rcb_pkt_num", index);
-	ethtool_sprintf(&buff, "tx_ring%d_ppe_tx_pkt_num", index);
-	ethtool_sprintf(&buff, "tx_ring%d_ppe_drop_pkt_num", index);
-	ethtool_sprintf(&buff, "tx_ring%d_fbd_num", index);
-
-	ethtool_sprintf(&buff, "tx_ring%d_pkt_num", index);
-	ethtool_sprintf(&buff, "tx_ring%d_bytes", index);
-	ethtool_sprintf(&buff, "tx_ring%d_err_cnt", index);
-	ethtool_sprintf(&buff, "tx_ring%d_io_err", index);
-	ethtool_sprintf(&buff, "tx_ring%d_sw_err", index);
-	ethtool_sprintf(&buff, "tx_ring%d_seg_pkt", index);
-	ethtool_sprintf(&buff, "tx_ring%d_restart_queue", index);
-	ethtool_sprintf(&buff, "tx_ring%d_tx_busy", index);
-
-	ethtool_sprintf(&buff, "rx_ring%d_rcb_pkt_num", index);
-	ethtool_sprintf(&buff, "rx_ring%d_ppe_pkt_num", index);
-	ethtool_sprintf(&buff, "rx_ring%d_ppe_drop_pkt_num", index);
-	ethtool_sprintf(&buff, "rx_ring%d_fbd_num", index);
-
-	ethtool_sprintf(&buff, "rx_ring%d_pkt_num", index);
-	ethtool_sprintf(&buff, "rx_ring%d_bytes", index);
-	ethtool_sprintf(&buff, "rx_ring%d_err_cnt", index);
-	ethtool_sprintf(&buff, "rx_ring%d_io_err", index);
-	ethtool_sprintf(&buff, "rx_ring%d_sw_err", index);
-	ethtool_sprintf(&buff, "rx_ring%d_seg_pkt", index);
-	ethtool_sprintf(&buff, "rx_ring%d_reuse_pg", index);
-	ethtool_sprintf(&buff, "rx_ring%d_len_err", index);
-	ethtool_sprintf(&buff, "rx_ring%d_non_vld_desc_err", index);
-	ethtool_sprintf(&buff, "rx_ring%d_bd_num_err", index);
-	ethtool_sprintf(&buff, "rx_ring%d_l2_err", index);
-	ethtool_sprintf(&buff, "rx_ring%d_l3l4csum_err", index);
+	ethtool_sprintf(data, "tx_ring%d_rcb_pkt_num", index);
+	ethtool_sprintf(data, "tx_ring%d_ppe_tx_pkt_num", index);
+	ethtool_sprintf(data, "tx_ring%d_ppe_drop_pkt_num", index);
+	ethtool_sprintf(data, "tx_ring%d_fbd_num", index);
+
+	ethtool_sprintf(data, "tx_ring%d_pkt_num", index);
+	ethtool_sprintf(data, "tx_ring%d_bytes", index);
+	ethtool_sprintf(data, "tx_ring%d_err_cnt", index);
+	ethtool_sprintf(data, "tx_ring%d_io_err", index);
+	ethtool_sprintf(data, "tx_ring%d_sw_err", index);
+	ethtool_sprintf(data, "tx_ring%d_seg_pkt", index);
+	ethtool_sprintf(data, "tx_ring%d_restart_queue", index);
+	ethtool_sprintf(data, "tx_ring%d_tx_busy", index);
+
+	ethtool_sprintf(data, "rx_ring%d_rcb_pkt_num", index);
+	ethtool_sprintf(data, "rx_ring%d_ppe_pkt_num", index);
+	ethtool_sprintf(data, "rx_ring%d_ppe_drop_pkt_num", index);
+	ethtool_sprintf(data, "rx_ring%d_fbd_num", index);
+
+	ethtool_sprintf(data, "rx_ring%d_pkt_num", index);
+	ethtool_sprintf(data, "rx_ring%d_bytes", index);
+	ethtool_sprintf(data, "rx_ring%d_err_cnt", index);
+	ethtool_sprintf(data, "rx_ring%d_io_err", index);
+	ethtool_sprintf(data, "rx_ring%d_sw_err", index);
+	ethtool_sprintf(data, "rx_ring%d_seg_pkt", index);
+	ethtool_sprintf(data, "rx_ring%d_reuse_pg", index);
+	ethtool_sprintf(data, "rx_ring%d_len_err", index);
+	ethtool_sprintf(data, "rx_ring%d_non_vld_desc_err", index);
+	ethtool_sprintf(data, "rx_ring%d_bd_num_err", index);
+	ethtool_sprintf(data, "rx_ring%d_l2_err", index);
+	ethtool_sprintf(data, "rx_ring%d_l3l4csum_err", index);
 }
 
 void hns_rcb_get_common_regs(struct rcb_common_cb *rcb_com, void *data)
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h
index c1e9b6997853..0f4cc184ef39 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h
@@ -157,7 +157,7 @@ int hns_rcb_get_ring_regs_count(void);
 
 void hns_rcb_get_ring_regs(struct hnae_queue *queue, void *data);
 
-void hns_rcb_get_strings(int stringset, u8 *data, int index);
+void hns_rcb_get_strings(int stringset, u8 **data, int index);
 void hns_rcb_set_rx_ring_bs(struct hnae_queue *q, u32 buf_size);
 void hns_rcb_set_tx_ring_bs(struct hnae_queue *q, u32 buf_size);
 
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c
index c58833eb4830..dbc44c2c26c2 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c
@@ -743,16 +743,15 @@ static void hns_xgmac_get_stats(void *mac_drv, u64 *data)
  *@stringset: type of values in data
  *@data:data for value of string name
  */
-static void hns_xgmac_get_strings(u32 stringset, u8 *data)
+static void hns_xgmac_get_strings(u32 stringset, u8 **data)
 {
-	u8 *buff = data;
 	u32 i;
 
 	if (stringset != ETH_SS_STATS)
 		return;
 
 	for (i = 0; i < ARRAY_SIZE(g_xgmac_stats_string); i++)
-		ethtool_puts(&buff, g_xgmac_stats_string[i].desc);
+		ethtool_puts(data, g_xgmac_stats_string[i].desc);
 }
 
 /**
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
index a5bb306b2cf1..6c458f037262 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
@@ -903,7 +903,6 @@ static void hns_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 {
 	struct hns_nic_priv *priv = netdev_priv(netdev);
 	struct hnae_handle *h = priv->ae_handle;
-	u8 *buff = data;
 
 	if (!h->dev->ops->get_strings) {
 		netdev_err(netdev, "h->dev->ops->get_strings is null!\n");
@@ -912,43 +911,43 @@ static void hns_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 
 	if (stringset == ETH_SS_TEST) {
 		if (priv->ae_handle->phy_if != PHY_INTERFACE_MODE_XGMII)
-			ethtool_puts(&buff,
+			ethtool_puts(&data,
 				     hns_nic_test_strs[MAC_INTERNALLOOP_MAC]);
-		ethtool_puts(&buff, hns_nic_test_strs[MAC_INTERNALLOOP_SERDES]);
+		ethtool_puts(&data, hns_nic_test_strs[MAC_INTERNALLOOP_SERDES]);
 		if ((netdev->phydev) && (!netdev->phydev->is_c45))
-			ethtool_puts(&buff,
+			ethtool_puts(&data,
 				     hns_nic_test_strs[MAC_INTERNALLOOP_PHY]);
 
 	} else {
-		ethtool_puts(&buff, "rx_packets");
-		ethtool_puts(&buff, "tx_packets");
-		ethtool_puts(&buff, "rx_bytes");
-		ethtool_puts(&buff, "tx_bytes");
-		ethtool_puts(&buff, "rx_errors");
-		ethtool_puts(&buff, "tx_errors");
-		ethtool_puts(&buff, "rx_dropped");
-		ethtool_puts(&buff, "tx_dropped");
-		ethtool_puts(&buff, "multicast");
-		ethtool_puts(&buff, "collisions");
-		ethtool_puts(&buff, "rx_over_errors");
-		ethtool_puts(&buff, "rx_crc_errors");
-		ethtool_puts(&buff, "rx_frame_errors");
-		ethtool_puts(&buff, "rx_fifo_errors");
-		ethtool_puts(&buff, "rx_missed_errors");
-		ethtool_puts(&buff, "tx_aborted_errors");
-		ethtool_puts(&buff, "tx_carrier_errors");
-		ethtool_puts(&buff, "tx_fifo_errors");
-		ethtool_puts(&buff, "tx_heartbeat_errors");
-		ethtool_puts(&buff, "rx_length_errors");
-		ethtool_puts(&buff, "tx_window_errors");
-		ethtool_puts(&buff, "rx_compressed");
-		ethtool_puts(&buff, "tx_compressed");
-		ethtool_puts(&buff, "netdev_rx_dropped");
-		ethtool_puts(&buff, "netdev_tx_dropped");
-
-		ethtool_puts(&buff, "netdev_tx_timeout");
-
-		h->dev->ops->get_strings(h, stringset, buff);
+		ethtool_puts(&data, "rx_packets");
+		ethtool_puts(&data, "tx_packets");
+		ethtool_puts(&data, "rx_bytes");
+		ethtool_puts(&data, "tx_bytes");
+		ethtool_puts(&data, "rx_errors");
+		ethtool_puts(&data, "tx_errors");
+		ethtool_puts(&data, "rx_dropped");
+		ethtool_puts(&data, "tx_dropped");
+		ethtool_puts(&data, "multicast");
+		ethtool_puts(&data, "collisions");
+		ethtool_puts(&data, "rx_over_errors");
+		ethtool_puts(&data, "rx_crc_errors");
+		ethtool_puts(&data, "rx_frame_errors");
+		ethtool_puts(&data, "rx_fifo_errors");
+		ethtool_puts(&data, "rx_missed_errors");
+		ethtool_puts(&data, "tx_aborted_errors");
+		ethtool_puts(&data, "tx_carrier_errors");
+		ethtool_puts(&data, "tx_fifo_errors");
+		ethtool_puts(&data, "tx_heartbeat_errors");
+		ethtool_puts(&data, "rx_length_errors");
+		ethtool_puts(&data, "tx_window_errors");
+		ethtool_puts(&data, "rx_compressed");
+		ethtool_puts(&data, "tx_compressed");
+		ethtool_puts(&data, "netdev_rx_dropped");
+		ethtool_puts(&data, "netdev_tx_dropped");
+
+		ethtool_puts(&data, "netdev_tx_timeout");
+
+		h->dev->ops->get_strings(h, stringset, &data);
 	}
 }
 
@@ -970,7 +969,7 @@ static int hns_get_sset_count(struct net_device *netdev, int stringset)
 		return -EOPNOTSUPP;
 	}
 	if (stringset == ETH_SS_TEST) {
-		u32 cnt = (sizeof(hns_nic_test_strs) / ETH_GSTRING_LEN);
+		u32 cnt = ARRAY_SIZE(hns_nic_test_strs);
 
 		if (priv->ae_handle->phy_if == PHY_INTERFACE_MODE_XGMII)
 			cnt--;
-- 
2.47.0


