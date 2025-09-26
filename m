Return-Path: <netdev+bounces-226577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3A7BA23B0
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 04:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E680D1C27A52
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 02:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B67261393;
	Fri, 26 Sep 2025 02:40:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB63261591
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 02:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758854423; cv=none; b=kmflUTjXPC/gZOR3qF+kuRxzjI+TGqKlFCPNgUeYHvPsUfEHs7jzd8v1+y6l12Pocb7mgM00GPoaClCEMnBJRueR4+zu9laQhHCgBh3k2eTrsisKLmBXN0O34lVkFsMFkweUGZxelYqD60Zc+SdRCqwXEDSKMnkFt4s48aGYaQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758854423; c=relaxed/simple;
	bh=7miwnO4RYT0Z0y7ZCex68av2dv4r48Wyqn41RChuzOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qc+oUy/GsI13gAr6jATOpmCVFVd2S2yuVfzkoK06yMIg+WMX2nvhPI7M5hbMV7fW0oDteuvJ0fSaILPrE0PW8n3SqNnZZmV6/u2ESF1B9iSaGY6qliq/7FDBGhOHNbEDjipJMxpNyLIiEfKXoYVNjEWgkc1xGbk8EYvAt73r4t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz6t1758854333t3e6011ec
X-QQ-Originating-IP: fprkMie2hCXDgQ0w3fLtCJLGmvv5Uxt3dWaoOj7Pg5w=
Received: from lap-jiawenwu.trustnetic.com ( [115.220.236.115])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 26 Sep 2025 10:38:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17272255023951691600
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
Subject: [PATCH net-next v6 1/4] net: libwx: support separate RSS configuration for every pool
Date: Fri, 26 Sep 2025 10:38:40 +0800
Message-Id: <20250926023843.34340-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250926023843.34340-1-jiawenwu@trustnetic.com>
References: <20250926023843.34340-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NnKWXRC3r3tSlWLQz9abFG12enZILChiSZl5eHTQtkl9gJhA0sRpy4CD
	hzbB3/jgjlV/ZLZuxvhtgbM/UuSFQl7eqYfa3d95hhdTbH39yKwDErfKnN94YYgSMhbv2E3
	Mf9EWgpc4g1+erzvCJFt7bTjA6F7qwY73nmCspl9Rph0vQoT4U8SRDHaxPXUdvLAORnOraS
	5bs42KmWmtpdasxNoTDLFqMl4d1+RTf6CCc86DifCwOb1v/QTf//ydzGHMlTSXl3idqJFGU
	lyHJnKdxGSqOeJSM6fksTnk89+Xk8LQoJ9uRuaeMGDimg1lRvbrZl5RE6Tr27FuqZUh8cxf
	mzy/7Ygq+UcXzcHdgZeaNvKB2yN25QSi4wHsE6R0cN1QBxVL4/RvfKNRTY3RIvpnhU+cSz3
	NtcTHI4nIu0hdZIzhBhhTmZPPIAuS+WY9g1sZI9odOis+DOVsp1KKOfdxeLrpQC9/k+hwqX
	3nloZztT379NpQ195tXbDRi7JdryuyY4mPbKadX9oO72jfj0C1UD4HrfpI3tpKbrkTBccrB
	VUuUSsG5AOzFJZOf48NfBRqTjsRhitJQBIQBmx2WiRae+a3UZ/1tJy+4nyBLd0yvHIw9KOO
	9TgmvaAJcSxwBo8Xn6gI8ga6rvWfKLLKlGxHALa3Yrcnm9b4AZCGTlnSy0QbijCH11G30BG
	oFD76I5cxLDxzQUyUDpCgQgaq7F6vlJLDfxAMNudqJwgL4CniGVuFv4L1KFqGPH9izDxWfU
	8Uuyc8AW6FXoWQxZl/whhpINghausL9lWzaWt6uWx+Rgu/PhITyyxgF6JICjJp7QwmXX1nj
	ilsrmiHPri61Tw8oPdPtgHKEhZPMW/IBtKEbobFe529MNGyd37OtJvX3W+Y9NCGP9DW1LYt
	MY0ZSCGFN1Pu4uIu0uxXHYzMKSX7LemUq/SpzRVrfmNGilKzc6Nz8LRCIl/+WWOfsYh7pxu
	kTnl8SlyCARshEqCzalmaPrWxkeOKP6swJkphQsD1+LdJ23bUj9GBU077kpNG4oLZGBejO0
	ks/ihNDsyzit8PnmmkVW15fhjW6/+k00pccYESlpbrRBqd7TRZ
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
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
 4 files changed, 98 insertions(+), 33 deletions(-)

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
index 5086db060c61..3adf7048320a 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -3016,14 +3016,8 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
 	struct wx *wx = netdev_priv(netdev);
 	bool need_reset = false;
 
-	if (features & NETIF_F_RXHASH) {
-		wr32m(wx, WX_RDB_RA_CTL, WX_RDB_RA_CTL_RSS_EN,
-		      WX_RDB_RA_CTL_RSS_EN);
-		wx->rss_enabled = true;
-	} else {
-		wr32m(wx, WX_RDB_RA_CTL, WX_RDB_RA_CTL_RSS_EN, 0);
-		wx->rss_enabled = false;
-	}
+	wx->rss_enabled = !!(features & NETIF_F_RXHASH);
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


