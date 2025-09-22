Return-Path: <netdev+bounces-225188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB53AB8FD35
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 11:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4353618A14A7
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 09:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C76F26E715;
	Mon, 22 Sep 2025 09:45:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3E21FDA82
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758534316; cv=none; b=RIBBqefMxqKzzY5VI6NIhF/jUzZqlry+zp9qeCEj7a7gRKXvt1pxvW1QncQG3E/hfRRzB99q0sxLG1YnoMkiortWzNYEmuPGZ+/NeCxrcDXGARUlxMj5jqcN0u2AMa/7L10+aUYgfjtI0rOUl2p6fIYC5hZ5UjMuB5pSK/wSxaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758534316; c=relaxed/simple;
	bh=0L+QWozM/3ccYTAraqiWtYJjM4QtJCv4BRJYYLWvnPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=meponPExrgnmxo4FyM7E+7kjUBdSSaONeavldOagBhus3C9r/DAWk9KPJRA2gaXB3fTkcYw72SISZXcpcfdNRhsMjeW/n7FnSjUjrZI7rluGeC+qzWZrs4vpGa1QYiAMfbW8fMIOXem/A1roaaF+VuOWhVj6POOh0G67ecVVuWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz3t1758534225tc30424ac
X-QQ-Originating-IP: Ts6dEuqxeoJ3j/Fw+TcNMQsAn1RmUMpbUVqNrVMHd+k=
Received: from lap-jiawenwu.trustnetic.com ( [122.231.221.166])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 22 Sep 2025 17:43:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9090728377470924491
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v5 1/4] net: libwx: support separate RSS configuration for every pool
Date: Mon, 22 Sep 2025 17:43:24 +0800
Message-Id: <20250922094327.26092-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250922094327.26092-1-jiawenwu@trustnetic.com>
References: <20250922094327.26092-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Mw43FEVz/zQ/7HSwYHUALbsA3Q0QJlYqGquRPwfDNFpixUFvzcuRidb/
	UFXLKnZN2xV8gGfWHreYsKVF6W6qFpBlXGOWSxHaXkmYqqr4iDCdgqUXENGR+rVdvpMApO4
	XGJyXG61d2gK+US3Pteg5Q6IhsOACPUi6c7l2KVKuFAYAGfyWaFEGoWiZXqxXaABhTyJtec
	goj53Wkz9b5xKDImTKYhnixeb68M5lcCcRXGWO3/5mkvIUZOMeoOje/dZAgE2pQfNX+ZSKL
	MGtWipdWhFSS5z99fTh+4d6aOIitgs3mg3Ohb7OHV5okEOoctnovzS3/K8PT+Mb1cTBbhr+
	mhu5ZQI5XXG9xpMycVwDNgkWCG0FFdhEH5IhQyT2wN4+3oVXzpYzc+SYKaJ+q4+3hyiaktX
	a4Np/+uup+dnD7e6Tn/RAA3/tZ3lolZFH7MK+49LtvckyM2fTkstb50/PdYxKZCFGUouS8S
	8Ax3ihOPCHkFj6vo5vh/7SJdRwQI2zx/+VumWLpS77OaGRjjZXWBgBDWuoCqClmtxoAEggD
	UGNtAjunDN1uMUfQZqIWWHfmSIz8QY92WYW00ZurpDZ/FJY56pJ2XCq31J8C9JUHIqz1pla
	ZuxM9+e60cluGakk8YxiwjsIE7iXZLJLMJUXbZnVTvwLtAp/j1EUxV1GaM4w11dX4GY3O3L
	IZ6j0hF5gfu2GsRdhgZp6w9wqUblkpkE01uoJT1Vf/F1zqGbUpg7GeLblCrg4E4YsXZ+ZLe
	UiYaJYsr+wLu0Z85uSp73p54qrX1RmvzsPW5zo+VHSngsFNL9NYOaTwfSqKpmiJkFjxaFJk
	X1v3+SN1s6wYEeo95E+A8sh2RKt8iceyf3bMXvH2fHP8Hs2Sh6bZ2IllsajK9vHITOziFc4
	BE3rU4jwPXEd5Vp2TJsboh+DiP5cIQYlHHHrr4YWGU6gyw8X/7BfkIIsSFQuL30sQb4nJe2
	Ra/RzQeBrrrqklUK0bLqoENI6nuCPHS+sTe1Kzt6Wk68Y1u1ZhmNxYYNTpBiV4GWHe7QG6y
	ZE1N5X/iWX6TYm6pa1k1pWhUhUNkF5X5ZN8ZC1YaCJTaWfWs3e
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

For those devices which support 64 pools, they also support PF and VF
(i.e. different pools) to configure different RSS key and hash table.
Enable multiple RSS, use up to 64 RSS configurations and each pool has a
specific configuration.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c   | 111 ++++++++++++++-----
 drivers/net/ethernet/wangxun/libwx/wx_hw.h   |   5 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c  |  10 +-
 drivers/net/ethernet/wangxun/libwx/wx_type.h |   5 +
 4 files changed, 100 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 5cb353a97d6d..0bb4cddf7809 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -1998,8 +1998,17 @@ static void wx_restore_vlan(struct wx *wx)
 		wx_vlan_rx_add_vid(wx->netdev, htons(ETH_P_8021Q), vid);
 }
 
-static void wx_store_reta(struct wx *wx)
+u32 wx_rss_indir_tbl_entries(struct wx *wx)
 {
+	if (test_bit(WX_FLAG_SRIOV_ENABLED, wx->flags))
+		return 64;
+	else
+		return 128;
+}
+
+void wx_store_reta(struct wx *wx)
+{
+	u32 reta_entries = wx_rss_indir_tbl_entries(wx);
 	u8 *indir_tbl = wx->rss_indir_tbl;
 	u32 reta = 0;
 	u32 i;
@@ -2007,36 +2016,55 @@ static void wx_store_reta(struct wx *wx)
 	/* Fill out the redirection table as follows:
 	 *  - 8 bit wide entries containing 4 bit RSS index
 	 */
-	for (i = 0; i < WX_MAX_RETA_ENTRIES; i++) {
+	for (i = 0; i < reta_entries; i++) {
 		reta |= indir_tbl[i] << (i & 0x3) * 8;
 		if ((i & 3) == 3) {
-			wr32(wx, WX_RDB_RSSTBL(i >> 2), reta);
+			if (test_bit(WX_FLAG_SRIOV_ENABLED, wx->flags) &&
+			    test_bit(WX_FLAG_MULTI_64_FUNC, wx->flags))
+				wr32(wx, WX_RDB_VMRSSTBL(i >> 2, wx->num_vfs), reta);
+			else
+				wr32(wx, WX_RDB_RSSTBL(i >> 2), reta);
 			reta = 0;
 		}
 	}
 }
 
+void wx_store_rsskey(struct wx *wx)
+{
+	u32 key_size = WX_RSS_KEY_SIZE / 4;
+	u32 i;
+
+	if (test_bit(WX_FLAG_SRIOV_ENABLED, wx->flags) &&
+	    test_bit(WX_FLAG_MULTI_64_FUNC, wx->flags)) {
+		for (i = 0; i < key_size; i++)
+			wr32(wx, WX_RDB_VMRSSRK(i, wx->num_vfs),
+			     wx->rss_key[i]);
+	} else {
+		for (i = 0; i < key_size; i++)
+			wr32(wx, WX_RDB_RSSRK(i), wx->rss_key[i]);
+	}
+}
+
 static void wx_setup_reta(struct wx *wx)
 {
 	u16 rss_i = wx->ring_feature[RING_F_RSS].indices;
-	u32 random_key_size = WX_RSS_KEY_SIZE / 4;
+	u32 reta_entries = wx_rss_indir_tbl_entries(wx);
 	u32 i, j;
 
 	if (test_bit(WX_FLAG_SRIOV_ENABLED, wx->flags)) {
-		if (wx->mac.type == wx_mac_em)
-			rss_i = 1;
+		if (test_bit(WX_FLAG_MULTI_64_FUNC, wx->flags))
+			rss_i = rss_i < 2 ? 2 : rss_i;
 		else
-			rss_i = rss_i < 4 ? 4 : rss_i;
+			rss_i = 1;
 	}
 
 	/* Fill out hash function seeds */
-	for (i = 0; i < random_key_size; i++)
-		wr32(wx, WX_RDB_RSSRK(i), wx->rss_key[i]);
+	wx_store_rsskey(wx);
 
 	/* Fill out redirection table */
 	memset(wx->rss_indir_tbl, 0, sizeof(wx->rss_indir_tbl));
 
-	for (i = 0, j = 0; i < WX_MAX_RETA_ENTRIES; i++, j++) {
+	for (i = 0, j = 0; i < reta_entries; i++, j++) {
 		if (j == rss_i)
 			j = 0;
 
@@ -2046,6 +2074,52 @@ static void wx_setup_reta(struct wx *wx)
 	wx_store_reta(wx);
 }
 
+void wx_config_rss_field(struct wx *wx)
+{
+	u32 rss_field;
+
+	/* Global RSS and multiple RSS have the same type field */
+	rss_field = WX_RDB_RA_CTL_RSS_IPV4 |
+		    WX_RDB_RA_CTL_RSS_IPV4_TCP |
+		    WX_RDB_RA_CTL_RSS_IPV4_UDP |
+		    WX_RDB_RA_CTL_RSS_IPV6 |
+		    WX_RDB_RA_CTL_RSS_IPV6_TCP |
+		    WX_RDB_RA_CTL_RSS_IPV6_UDP;
+
+	if (test_bit(WX_FLAG_SRIOV_ENABLED, wx->flags) &&
+	    test_bit(WX_FLAG_MULTI_64_FUNC, wx->flags)) {
+		wr32(wx, WX_RDB_PL_CFG(wx->num_vfs), rss_field);
+
+		/* Enable global RSS and multiple RSS to make the RSS
+		 * field of each pool take effect.
+		 */
+		wr32m(wx, WX_RDB_RA_CTL,
+		      WX_RDB_RA_CTL_MULTI_RSS | WX_RDB_RA_CTL_RSS_EN,
+		      WX_RDB_RA_CTL_MULTI_RSS | WX_RDB_RA_CTL_RSS_EN);
+	} else {
+		wr32(wx, WX_RDB_RA_CTL, rss_field);
+	}
+}
+
+void wx_enable_rss(struct wx *wx, bool enable)
+{
+	if (test_bit(WX_FLAG_SRIOV_ENABLED, wx->flags) &&
+	    test_bit(WX_FLAG_MULTI_64_FUNC, wx->flags)) {
+		if (enable)
+			wr32m(wx, WX_RDB_PL_CFG(wx->num_vfs),
+			      WX_RDB_PL_CFG_RSS_EN, WX_RDB_PL_CFG_RSS_EN);
+		else
+			wr32m(wx, WX_RDB_PL_CFG(wx->num_vfs),
+			      WX_RDB_PL_CFG_RSS_EN, 0);
+	} else {
+		if (enable)
+			wr32m(wx, WX_RDB_RA_CTL, WX_RDB_RA_CTL_RSS_EN,
+			      WX_RDB_RA_CTL_RSS_EN);
+		else
+			wr32m(wx, WX_RDB_RA_CTL, WX_RDB_RA_CTL_RSS_EN, 0);
+	}
+}
+
 #define WX_RDB_RSS_PL_2		FIELD_PREP(GENMASK(31, 29), 1)
 #define WX_RDB_RSS_PL_4		FIELD_PREP(GENMASK(31, 29), 2)
 static void wx_setup_psrtype(struct wx *wx)
@@ -2076,27 +2150,14 @@ static void wx_setup_psrtype(struct wx *wx)
 
 static void wx_setup_mrqc(struct wx *wx)
 {
-	u32 rss_field = 0;
-
 	/* Disable indicating checksum in descriptor, enables RSS hash */
 	wr32m(wx, WX_PSR_CTL, WX_PSR_CTL_PCSD, WX_PSR_CTL_PCSD);
 
-	/* Perform hash on these packet types */
-	rss_field = WX_RDB_RA_CTL_RSS_IPV4 |
-		    WX_RDB_RA_CTL_RSS_IPV4_TCP |
-		    WX_RDB_RA_CTL_RSS_IPV4_UDP |
-		    WX_RDB_RA_CTL_RSS_IPV6 |
-		    WX_RDB_RA_CTL_RSS_IPV6_TCP |
-		    WX_RDB_RA_CTL_RSS_IPV6_UDP;
-
 	netdev_rss_key_fill(wx->rss_key, sizeof(wx->rss_key));
 
+	wx_config_rss_field(wx);
+	wx_enable_rss(wx, wx->rss_enabled);
 	wx_setup_reta(wx);
-
-	if (wx->rss_enabled)
-		rss_field |= WX_RDB_RA_CTL_RSS_EN;
-
-	wr32(wx, WX_RDB_RA_CTL, rss_field);
 }
 
 /**
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.h b/drivers/net/ethernet/wangxun/libwx/wx_hw.h
index 2393a743b564..13857376bbad 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.h
@@ -39,6 +39,11 @@ void wx_set_rx_mode(struct net_device *netdev);
 int wx_change_mtu(struct net_device *netdev, int new_mtu);
 void wx_disable_rx_queue(struct wx *wx, struct wx_ring *ring);
 void wx_enable_rx_queue(struct wx *wx, struct wx_ring *ring);
+u32 wx_rss_indir_tbl_entries(struct wx *wx);
+void wx_store_reta(struct wx *wx);
+void wx_store_rsskey(struct wx *wx);
+void wx_config_rss_field(struct wx *wx);
+void wx_enable_rss(struct wx *wx, bool enable);
 void wx_configure_rx(struct wx *wx);
 void wx_configure(struct wx *wx);
 void wx_start_hw(struct wx *wx);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 5086db060c61..5ec26349c91b 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -3016,14 +3016,12 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
 	struct wx *wx = netdev_priv(netdev);
 	bool need_reset = false;
 
-	if (features & NETIF_F_RXHASH) {
-		wr32m(wx, WX_RDB_RA_CTL, WX_RDB_RA_CTL_RSS_EN,
-		      WX_RDB_RA_CTL_RSS_EN);
+	if (features & NETIF_F_RXHASH)
 		wx->rss_enabled = true;
-	} else {
-		wr32m(wx, WX_RDB_RA_CTL, WX_RDB_RA_CTL_RSS_EN, 0);
+	else
 		wx->rss_enabled = false;
-	}
+
+	wx_enable_rss(wx, wx->rss_enabled);
 
 	netdev->features = features;
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index ec63e7ec8b24..0450e276ae28 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -168,9 +168,11 @@
 #define WX_RDB_PL_CFG_L2HDR          BIT(3)
 #define WX_RDB_PL_CFG_TUN_TUNHDR     BIT(4)
 #define WX_RDB_PL_CFG_TUN_OUTL2HDR   BIT(5)
+#define WX_RDB_PL_CFG_RSS_EN         BIT(24)
 #define WX_RDB_RSSTBL(_i)            (0x19400 + ((_i) * 4))
 #define WX_RDB_RSSRK(_i)             (0x19480 + ((_i) * 4))
 #define WX_RDB_RA_CTL                0x194F4
+#define WX_RDB_RA_CTL_MULTI_RSS      BIT(0)
 #define WX_RDB_RA_CTL_RSS_EN         BIT(2) /* RSS Enable */
 #define WX_RDB_RA_CTL_RSS_IPV4_TCP   BIT(16)
 #define WX_RDB_RA_CTL_RSS_IPV4       BIT(17)
@@ -180,6 +182,9 @@
 #define WX_RDB_RA_CTL_RSS_IPV6_UDP   BIT(23)
 #define WX_RDB_FDIR_MATCH            0x19558
 #define WX_RDB_FDIR_MISS             0x1955C
+/* VM RSS */
+#define WX_RDB_VMRSSRK(_i, _p)       (0x1A000 + ((_i) * 4) + ((_p) * 0x40))
+#define WX_RDB_VMRSSTBL(_i, _p)      (0x1B000 + ((_i) * 4) + ((_p) * 0x40))
 
 /******************************* PSR Registers *******************************/
 /* psr control */
-- 
2.48.1


