Return-Path: <netdev+bounces-143431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE789C26BB
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 21:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A80EF283D39
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 20:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7035E2123FC;
	Fri,  8 Nov 2024 20:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/p3BSXo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBEE2123D8;
	Fri,  8 Nov 2024 20:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731098519; cv=none; b=RqgXICRELnONPDh5h7X3Q2VsJCo9j7yMj7cVhrSyBxt9aUvdQ8mbre1ceudc9/EEDShOxuda5OvsHjZ90e4maL9uQe5BVuXdr/CUuCNTjSzbXQe3v3WI47+1cd+iInlHKZH6MESwha7RcCBJMx8yelKRTMg7Q3MnrKZD8dZ22Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731098519; c=relaxed/simple;
	bh=6Xi8SnymfUK1MWx7BqI8kyX68lcBO9ziF5nJTzT20LI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IY94rS/Uj4OFcmCs/vdG/RMBByC8KEeDfg0pOeqtQO4jRjt8iAJnsWFDBC6vXsH0xlP/ghXgbsmunAPJq5fyYoOZUKRMafi7vtBZRSHq2uXZcaIKCzn2ncUD722QAIxXjzQT3W+IgMHddbqnURnDLJX/zURaqg3jrxXBn99MHFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/p3BSXo; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e52582cf8so2164047b3a.2;
        Fri, 08 Nov 2024 12:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731098517; x=1731703317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LLUbqVUKNMQW8QHgPLbTdXartn9a/TySG3n47H01Lgc=;
        b=i/p3BSXovN7e4nhnVnY5K4uZ31YPiCEbn8wdu/WgVWmA4adiFXGjA7MWo2j72+mXVK
         3gLnBOOh8iW7+z9Im4xXoAhE0l8qK8YRnVj2rswYmJ8sOriwTlX5bTzTzgqDUlq6wlkt
         WpM1KtOsxqFvDPj+K5GcGPeerAoPdXhA/k1oTzsAdb1f9FsYE2Ovw3PE4H1Q/B5o3x7p
         KIOpyhtBOLDnXGvESG3ifVu4NtZH2GWmLfQiMTJPCOhq3hMHJ/v4ST/wD7uRnULVGoOu
         l7Jbf5FDVotj0Gr1ELN4pmD2SOV5Qy8gfxMIfXcHJimrAiXymEXDjeU+QifM/n99SJh9
         52/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731098517; x=1731703317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LLUbqVUKNMQW8QHgPLbTdXartn9a/TySG3n47H01Lgc=;
        b=KTkxgys24ycqbo8wDM96fyFtuxKCA6KI2IUe46EVaB0CS6OmaQu696aLeiZndc1l/w
         c03liNdQ4k0B7KAnrNbGKkf/lNnZkmVzHB1cSHCUihtvCYmCi28u/TvQqys0dnMrLP/u
         wV6Qe4WJBvdTkgm6g7WjJQyRBqZNLIVAn3CL6DdpGQ2DFqXnuTDP9mvRE26g4jN2gdf4
         LyqtTncG75B5TBkTeAmku1pfq5ErNQlcWg0C+dDyf4AHSbSQsEuLmKhqF7U9xYeISO2v
         IXeodcmdfEabHVXSpKuX9JWLeBf15yRIdEElBfLtTviuV4D8afvSj2x8U47A+Gk7JgNm
         P8NQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc1u6/svUloW0aehqJdqzL6Q+eFT7K381tMgP5J+tLWhYMBNsAzc8uG341XdOGgmLMhS7GcUzxbcU9eCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPIMYkBwuPxe1krRzYxYvb1CyxCyTHI56gIK0Vi0zBp8qzJVte
	qoRK+p9O2shDcD2p5w2kvBEr2/Loo6i/+o6pGgOKNkRkN64vFQhFkz/9uA==
X-Google-Smtp-Source: AGHT+IGACG82dpVJpadT/3v7VY/TjramC/FO30igl9LwCB+QBnSGZUZwSyiI9vS1Y/BpeKcrZPWL8A==
X-Received: by 2002:a05:6a20:1594:b0:1db:e1b0:b673 with SMTP id adf61e73a8af0-1dc22826528mr5752392637.9.1731098516542;
        Fri, 08 Nov 2024 12:41:56 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f5ea0d5sm3957987a12.47.2024.11.08.12.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 12:41:56 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Louis Peens <louis.peens@corigine.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	oss-drivers@corigine.com (open list:NETRONOME ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net: netronome: use double ptr for gstrings
Date: Fri,  8 Nov 2024 12:41:54 -0800
Message-ID: <20241108204154.305560-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the code copies a pointer and propagates increments that way.

Instead of doing that, increment with a double pointer, which the
ethtool string helpers expect.

Also converted some memcpy calls to ethtool_puts, as they should be.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/netronome/nfp/abm/main.c |  12 +-
 drivers/net/ethernet/netronome/nfp/nfp_app.c  |   6 +-
 drivers/net/ethernet/netronome/nfp/nfp_app.h  |   6 +-
 .../ethernet/netronome/nfp/nfp_net_ethtool.c  | 119 ++++++++----------
 4 files changed, 65 insertions(+), 78 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/abm/main.c b/drivers/net/ethernet/netronome/nfp/abm/main.c
index 5d3df28c648f..ee6dbe4f8c42 100644
--- a/drivers/net/ethernet/netronome/nfp/abm/main.c
+++ b/drivers/net/ethernet/netronome/nfp/abm/main.c
@@ -407,22 +407,20 @@ nfp_abm_port_get_stats_count(struct nfp_app *app, struct nfp_port *port)
 	return alink->vnic->dp.num_r_vecs * 2;
 }
 
-static u8 *
-nfp_abm_port_get_stats_strings(struct nfp_app *app, struct nfp_port *port,
-			       u8 *data)
+static void nfp_abm_port_get_stats_strings(struct nfp_app *app,
+					   struct nfp_port *port, u8 **data)
 {
 	struct nfp_repr *repr = netdev_priv(port->netdev);
 	struct nfp_abm_link *alink;
 	unsigned int i;
 
 	if (port->type != NFP_PORT_PF_PORT)
-		return data;
+		return;
 	alink = repr->app_priv;
 	for (i = 0; i < alink->vnic->dp.num_r_vecs; i++) {
-		ethtool_sprintf(&data, "q%u_no_wait", i);
-		ethtool_sprintf(&data, "q%u_delayed", i);
+		ethtool_sprintf(data, "q%u_no_wait", i);
+		ethtool_sprintf(data, "q%u_delayed", i);
 	}
-	return data;
 }
 
 static int nfp_abm_fw_init_reset(struct nfp_abm *abm)
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_app.c b/drivers/net/ethernet/netronome/nfp/nfp_app.c
index bb3f46c74f77..294181c7ebad 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_app.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_app.c
@@ -92,11 +92,11 @@ int nfp_app_port_get_stats_count(struct nfp_port *port)
 	return port->app->type->port_get_stats_count(port->app, port);
 }
 
-u8 *nfp_app_port_get_stats_strings(struct nfp_port *port, u8 *data)
+void nfp_app_port_get_stats_strings(struct nfp_port *port, u8 **data)
 {
 	if (!port || !port->app || !port->app->type->port_get_stats_strings)
-		return data;
-	return port->app->type->port_get_stats_strings(port->app, port, data);
+		return;
+	port->app->type->port_get_stats_strings(port->app, port, data);
 }
 
 struct sk_buff *
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_app.h b/drivers/net/ethernet/netronome/nfp/nfp_app.h
index 90707346a4ef..fc4dbcc8c7e1 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_app.h
+++ b/drivers/net/ethernet/netronome/nfp/nfp_app.h
@@ -116,8 +116,8 @@ struct nfp_app_type {
 	u64 *(*port_get_stats)(struct nfp_app *app,
 			       struct nfp_port *port, u64 *data);
 	int (*port_get_stats_count)(struct nfp_app *app, struct nfp_port *port);
-	u8 *(*port_get_stats_strings)(struct nfp_app *app,
-				      struct nfp_port *port, u8 *data);
+	void (*port_get_stats_strings)(struct nfp_app *app,
+				       struct nfp_port *port, u8 **data);
 
 	int (*start)(struct nfp_app *app);
 	void (*stop)(struct nfp_app *app);
@@ -421,7 +421,7 @@ struct nfp_app *nfp_app_from_netdev(struct net_device *netdev);
 
 u64 *nfp_app_port_get_stats(struct nfp_port *port, u64 *data);
 int nfp_app_port_get_stats_count(struct nfp_port *port);
-u8 *nfp_app_port_get_stats_strings(struct nfp_port *port, u8 *data);
+void nfp_app_port_get_stats_strings(struct nfp_port *port, u8 **data);
 
 struct nfp_reprs *
 nfp_reprs_get_locked(struct nfp_app *app, enum nfp_repr_type type);
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c b/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
index fbca8d0efd85..6dfaaca737e2 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
@@ -848,37 +848,35 @@ static unsigned int nfp_vnic_get_sw_stats_count(struct net_device *netdev)
 		NN_CTRL_PATH_STATS;
 }
 
-static u8 *nfp_vnic_get_sw_stats_strings(struct net_device *netdev, u8 *data)
+static void nfp_vnic_get_sw_stats_strings(struct net_device *netdev, u8 **data)
 {
 	struct nfp_net *nn = netdev_priv(netdev);
 	int i;
 
 	for (i = 0; i < nn->max_r_vecs; i++) {
-		ethtool_sprintf(&data, "rvec_%u_rx_pkts", i);
-		ethtool_sprintf(&data, "rvec_%u_tx_pkts", i);
-		ethtool_sprintf(&data, "rvec_%u_tx_busy", i);
-	}
-
-	ethtool_puts(&data, "hw_rx_csum_ok");
-	ethtool_puts(&data, "hw_rx_csum_inner_ok");
-	ethtool_puts(&data, "hw_rx_csum_complete");
-	ethtool_puts(&data, "hw_rx_csum_err");
-	ethtool_puts(&data, "rx_replace_buf_alloc_fail");
-	ethtool_puts(&data, "rx_tls_decrypted_packets");
-	ethtool_puts(&data, "hw_tx_csum");
-	ethtool_puts(&data, "hw_tx_inner_csum");
-	ethtool_puts(&data, "tx_gather");
-	ethtool_puts(&data, "tx_lso");
-	ethtool_puts(&data, "tx_tls_encrypted_packets");
-	ethtool_puts(&data, "tx_tls_ooo");
-	ethtool_puts(&data, "tx_tls_drop_no_sync_data");
-
-	ethtool_puts(&data, "hw_tls_no_space");
-	ethtool_puts(&data, "rx_tls_resync_req_ok");
-	ethtool_puts(&data, "rx_tls_resync_req_ign");
-	ethtool_puts(&data, "rx_tls_resync_sent");
-
-	return data;
+		ethtool_sprintf(data, "rvec_%u_rx_pkts", i);
+		ethtool_sprintf(data, "rvec_%u_tx_pkts", i);
+		ethtool_sprintf(data, "rvec_%u_tx_busy", i);
+	}
+
+	ethtool_puts(data, "hw_rx_csum_ok");
+	ethtool_puts(data, "hw_rx_csum_inner_ok");
+	ethtool_puts(data, "hw_rx_csum_complete");
+	ethtool_puts(data, "hw_rx_csum_err");
+	ethtool_puts(data, "rx_replace_buf_alloc_fail");
+	ethtool_puts(data, "rx_tls_decrypted_packets");
+	ethtool_puts(data, "hw_tx_csum");
+	ethtool_puts(data, "hw_tx_inner_csum");
+	ethtool_puts(data, "tx_gather");
+	ethtool_puts(data, "tx_lso");
+	ethtool_puts(data, "tx_tls_encrypted_packets");
+	ethtool_puts(data, "tx_tls_ooo");
+	ethtool_puts(data, "tx_tls_drop_no_sync_data");
+
+	ethtool_puts(data, "hw_tls_no_space");
+	ethtool_puts(data, "rx_tls_resync_req_ok");
+	ethtool_puts(data, "rx_tls_resync_req_ign");
+	ethtool_puts(data, "rx_tls_resync_sent");
 }
 
 static u64 *nfp_vnic_get_sw_stats(struct net_device *netdev, u64 *data)
@@ -937,8 +935,8 @@ static unsigned int nfp_vnic_get_hw_stats_count(unsigned int num_vecs)
 	return NN_ET_GLOBAL_STATS_LEN + num_vecs * 4;
 }
 
-static u8 *
-nfp_vnic_get_hw_stats_strings(u8 *data, unsigned int num_vecs, bool repr)
+static void nfp_vnic_get_hw_stats_strings(u8 **data, unsigned int num_vecs,
+					  bool repr)
 {
 	int swap_off, i;
 
@@ -950,22 +948,20 @@ nfp_vnic_get_hw_stats_strings(u8 *data, unsigned int num_vecs, bool repr)
 	swap_off = repr * NN_ET_SWITCH_STATS_LEN;
 
 	for (i = 0; i < NN_ET_SWITCH_STATS_LEN; i++)
-		ethtool_puts(&data, nfp_net_et_stats[i + swap_off].name);
+		ethtool_puts(data, nfp_net_et_stats[i + swap_off].name);
 
 	for (i = NN_ET_SWITCH_STATS_LEN; i < NN_ET_SWITCH_STATS_LEN * 2; i++)
-		ethtool_puts(&data, nfp_net_et_stats[i - swap_off].name);
+		ethtool_puts(data, nfp_net_et_stats[i - swap_off].name);
 
 	for (i = NN_ET_SWITCH_STATS_LEN * 2; i < NN_ET_GLOBAL_STATS_LEN; i++)
-		ethtool_puts(&data, nfp_net_et_stats[i].name);
+		ethtool_puts(data, nfp_net_et_stats[i].name);
 
 	for (i = 0; i < num_vecs; i++) {
-		ethtool_sprintf(&data, "rxq_%u_pkts", i);
-		ethtool_sprintf(&data, "rxq_%u_bytes", i);
-		ethtool_sprintf(&data, "txq_%u_pkts", i);
-		ethtool_sprintf(&data, "txq_%u_bytes", i);
+		ethtool_sprintf(data, "rxq_%u_pkts", i);
+		ethtool_sprintf(data, "rxq_%u_bytes", i);
+		ethtool_sprintf(data, "txq_%u_pkts", i);
+		ethtool_sprintf(data, "txq_%u_bytes", i);
 	}
-
-	return data;
 }
 
 static u64 *
@@ -991,7 +987,7 @@ static unsigned int nfp_vnic_get_tlv_stats_count(struct nfp_net *nn)
 	return nn->tlv_caps.vnic_stats_cnt + nn->max_r_vecs * 4;
 }
 
-static u8 *nfp_vnic_get_tlv_stats_strings(struct nfp_net *nn, u8 *data)
+static void nfp_vnic_get_tlv_stats_strings(struct nfp_net *nn, u8 **data)
 {
 	unsigned int i, id;
 	u8 __iomem *mem;
@@ -1006,22 +1002,18 @@ static u8 *nfp_vnic_get_tlv_stats_strings(struct nfp_net *nn, u8 *data)
 		id_word >>= 16;
 
 		if (id < ARRAY_SIZE(nfp_tlv_stat_names) &&
-		    nfp_tlv_stat_names[id][0]) {
-			memcpy(data, nfp_tlv_stat_names[id], ETH_GSTRING_LEN);
-			data += ETH_GSTRING_LEN;
-		} else {
-			ethtool_sprintf(&data, "dev_unknown_stat%u", id);
-		}
+		    nfp_tlv_stat_names[id][0])
+			ethtool_puts(data, nfp_tlv_stat_names[id]);
+		else
+			ethtool_sprintf(data, "dev_unknown_stat%u", id);
 	}
 
 	for (i = 0; i < nn->max_r_vecs; i++) {
-		ethtool_sprintf(&data, "rxq_%u_pkts", i);
-		ethtool_sprintf(&data, "rxq_%u_bytes", i);
-		ethtool_sprintf(&data, "txq_%u_pkts", i);
-		ethtool_sprintf(&data, "txq_%u_bytes", i);
+		ethtool_sprintf(data, "rxq_%u_pkts", i);
+		ethtool_sprintf(data, "rxq_%u_bytes", i);
+		ethtool_sprintf(data, "txq_%u_pkts", i);
+		ethtool_sprintf(data, "txq_%u_bytes", i);
 	}
-
-	return data;
 }
 
 static u64 *nfp_vnic_get_tlv_stats(struct nfp_net *nn, u64 *data)
@@ -1056,19 +1048,17 @@ static unsigned int nfp_mac_get_stats_count(struct net_device *netdev)
 	return ARRAY_SIZE(nfp_mac_et_stats);
 }
 
-static u8 *nfp_mac_get_stats_strings(struct net_device *netdev, u8 *data)
+static void nfp_mac_get_stats_strings(struct net_device *netdev, u8 **data)
 {
 	struct nfp_port *port;
 	unsigned int i;
 
 	port = nfp_port_from_netdev(netdev);
 	if (!__nfp_port_get_eth_port(port) || !port->eth_stats)
-		return data;
+		return;
 
 	for (i = 0; i < ARRAY_SIZE(nfp_mac_et_stats); i++)
-		ethtool_sprintf(&data, "mac.%s", nfp_mac_et_stats[i].name);
-
-	return data;
+		ethtool_sprintf(data, "mac.%s", nfp_mac_et_stats[i].name);
 }
 
 static u64 *nfp_mac_get_stats(struct net_device *netdev, u64 *data)
@@ -1093,15 +1083,14 @@ static void nfp_net_get_strings(struct net_device *netdev,
 
 	switch (stringset) {
 	case ETH_SS_STATS:
-		data = nfp_vnic_get_sw_stats_strings(netdev, data);
+		nfp_vnic_get_sw_stats_strings(netdev, &data);
 		if (!nn->tlv_caps.vnic_stats_off)
-			data = nfp_vnic_get_hw_stats_strings(data,
-							     nn->max_r_vecs,
-							     false);
+			nfp_vnic_get_hw_stats_strings(&data, nn->max_r_vecs,
+						      false);
 		else
-			data = nfp_vnic_get_tlv_stats_strings(nn, data);
-		data = nfp_mac_get_stats_strings(netdev, data);
-		data = nfp_app_port_get_stats_strings(nn->port, data);
+			nfp_vnic_get_tlv_stats_strings(nn, &data);
+		nfp_mac_get_stats_strings(netdev, &data);
+		nfp_app_port_get_stats_strings(nn->port, &data);
 		break;
 	case ETH_SS_TEST:
 		nfp_get_self_test_strings(netdev, data);
@@ -1155,10 +1144,10 @@ static void nfp_port_get_strings(struct net_device *netdev,
 	switch (stringset) {
 	case ETH_SS_STATS:
 		if (nfp_port_is_vnic(port))
-			data = nfp_vnic_get_hw_stats_strings(data, 0, true);
+			nfp_vnic_get_hw_stats_strings(&data, 0, true);
 		else
-			data = nfp_mac_get_stats_strings(netdev, data);
-		data = nfp_app_port_get_stats_strings(port, data);
+			nfp_mac_get_stats_strings(netdev, &data);
+		nfp_app_port_get_stats_strings(port, &data);
 		break;
 	case ETH_SS_TEST:
 		nfp_get_self_test_strings(netdev, data);
-- 
2.47.0


