Return-Path: <netdev+bounces-140560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3603A9B6FAC
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 23:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA5711F221DC
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 22:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67A61EB9FD;
	Wed, 30 Oct 2024 22:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3FtJzsq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60E41BD9E2;
	Wed, 30 Oct 2024 22:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730326079; cv=none; b=Jq1XUnzeGWUU4B6982kqNkansDrQBXgaefgW0bKrmQeTQwtpXa96qUbwi/cUT6C/+F4EIfAD3qz3qHh6UZS6VVOImoeQX8bkeh5ZUYxpiOr8b8SVwgAXq/ffHtwZb/l7xVY8x+aApN8vkVpb2b1t7PdnYBEuTgQ1b6fEWjS5Zhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730326079; c=relaxed/simple;
	bh=axVjjRPy0WfFhLnxV5BnFjw5AXWTMWzF5YzVcauai6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=puUuUMrhBZYntNTYrfTT2kPDqZ1rzw9C6agnWiPHWmWm4kJKygUQ5f+2ziwHSqFyx24PQkjRVO/LE5H6WPYECLHm5g0wHKH8kSaFKDJUFJvURgjMaa/zCB6ysf6TQgfAUTkPT0HxtxCILPyIfu1HpekW4SWbvIkjq6YQT/7JC/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3FtJzsq; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20e6981ca77so3626575ad.2;
        Wed, 30 Oct 2024 15:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730326070; x=1730930870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FakfmVmmn66WHw9K9uiNMPfhjtkFKPJU3sd8XCgu1DY=;
        b=G3FtJzsqa5A/jeTrGCYjI9Nnu1gS7IHOEyt/lDJdUu0rKezSqgVhG1/8aa6dRK4Myo
         xrBSC3PpyICqbb7W56VzJQvUT63O//F4hH646AXaE8uD5NpZXxjcRyXikMsyqPHy4Vh8
         1DLjxO13/rsUWDTg/yYVKiHJu5eV3fEmtsiNRswVLhbjVfL+9ekGVMvcQK7CyklZ3s9u
         2FHDhYfqQjJ2IKKpudoePOwdsEu8aYz29NsUMhhLGoKUSfcDbDNh+8GFr0Hr36Tm8gGe
         U8tne3tHG3KadGrfnlkucZuuI0E+jNNCrEcHOlRZmP5R31oSVykiyjbkEPTMd+IbrFQa
         PI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730326070; x=1730930870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FakfmVmmn66WHw9K9uiNMPfhjtkFKPJU3sd8XCgu1DY=;
        b=i6QfCVHI3v59yNGiUbP4sRbZ8zS7IrGdAtl8+ORxf/Cs+pbz8s9+fXPgWcHyBgiK63
         8Ydg9Gc5/GiVx0oo3wG5PMol1g2l26mDRsQjCLac2IavZVF0q7rii3mRn3cjQauXZigV
         lvDtR9C5+orEn9DZpQiir+ymgO1nCQip5CJ5KdTlVxs1QYKQKju8uDTvwmEesD1GbU8n
         gWqQdL+MXhmLm4FW/9JMy4mLXpx+rlG7FWJjSadfmhgzKWA88dSxjGxcFIE+Vtxd6gDq
         RY5D19YZI7XSX94FQz+LXN3OUtSJ3teCAeE9uxHUgEIp/nUzALXWSmgO4T4pHY42J1QU
         8Mfw==
X-Forwarded-Encrypted: i=1; AJvYcCU3NfJuAk3D3UlXMQwim80toRjta/ID60TIjirA72hplZiOFPIPTjWobkE1HaNL314OEWnKtSPXs5Uy3yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ83EeEx3LnMX2EUetUChhvS+SZ9Y4yvgEvUIdlKYkm8mOHCcP
	xkGdq1oQuNdzNgH7nztrSRxXITVDsXKtnsxyhHvJk4Nw5BHAo6T3t3OAhLBB
X-Google-Smtp-Source: AGHT+IESbNdXGEdLKrxiy+n2N3/i+rpcsZ2GgtLzFLOZpQfizkmaVxdeyhwccIjCDO+eee8oLceFXA==
X-Received: by 2002:a17:903:41c7:b0:20c:98f8:e0f5 with SMTP id d9443c01a7336-21103c59dd3mr14599975ad.43.1730326069577;
        Wed, 30 Oct 2024 15:07:49 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057c6511sm611615ad.195.2024.10.30.15.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 15:07:49 -0700 (PDT)
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
	Rosen Penev <rosenp@gmail.com>,
	Wei Fang <wei.fang@nxp.com>,
	Louis Peens <louis.peens@corigine.com>,
	"justinstitt@google.com" <justinstitt@google.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Yonglong Liu <liuyonglong@huawei.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Simon Horman <horms@kernel.org>,
	Jie Wang <wangjie125@huawei.com>,
	Peiyang Wang <wangpeiyang1@huawei.com>,
	Hao Lan <lanhao@huawei.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: hisilicon: use ethtool string helpers
Date: Wed, 30 Oct 2024 15:07:46 -0700
Message-ID: <20241030220746.305924-1-rosenp@gmail.com>
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
 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  2 +-
 .../hns3/hns3_common/hclge_comm_tqp_stats.c   | 11 +--
 .../hns3/hns3_common/hclge_comm_tqp_stats.h   |  2 +-
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    | 53 +++++---------
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 50 ++++++-------
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      |  6 +-
 19 files changed, 166 insertions(+), 237 deletions(-)

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
index b1e988347347..a6b1ab7d6ee2 100644
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
index bd86efd92a5a..05942fa78b11 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -594,25 +594,21 @@ static u64 *hclge_comm_get_stats(struct hclge_dev *hdev,
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
@@ -717,44 +713,38 @@ static int hclge_get_sset_count(struct hnae3_handle *handle, int stringset)
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
index 094a7c7b5592..2f6ffb88e700 100644
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


