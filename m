Return-Path: <netdev+bounces-218188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F6AB3B6FA
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 11:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D8EA3A19B0
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 09:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3E82FDC21;
	Fri, 29 Aug 2025 09:19:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CEE2E36EC
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 09:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756459191; cv=none; b=sVsddlCxqS2TGnvYTEtg8k0/zsB+wTDFSK2szPqYSW9msNa4Ft+8qFpH9Zl8swWMMc+kMdkz2l51U2QXD4C8OKlY5DwXFSsYsB6Lc2F9jSECXFlp6ejsDJMtj4EZqHYfwgkLBuJhdsMeOSy4nrFB4VzlVd5+FvnGn1ZVB/wtpPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756459191; c=relaxed/simple;
	bh=EH6t7yVlGwEwv34qyWJmWV+EC2hwAjlecQvGy2ONTis=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B2D7Xa3Oj0Mo8FUqCqloUXLC3pXrwLsMkuK1ZY2/TIJiOeGAVsG/Dr2hrfpCFhaGLzajyVRSTGjxQGagCnKD72tG7Evm53uMitfxQ/cs2/Jvbve3IPbD10gXCtozC40+hnmat1MvLL12lQBsQnaGBHX0gVWsvT5uq07CKwa8H4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz2t1756459089t71c99e26
X-QQ-Originating-IP: CnwCW16/QwqWmBlTUMWFKHEiepEelSYNbshXDXWZsE8=
Received: from lap-jiawenwu.trustnetic.com ( [60.188.194.79])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 29 Aug 2025 17:18:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15186092782330316508
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
Subject: [PATCH net-next v2 1/2] net: libwx: support multiple RSS for every pool
Date: Fri, 29 Aug 2025 17:17:51 +0800
Message-Id: <20250829091752.24436-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250829091752.24436-1-jiawenwu@trustnetic.com>
References: <20250829091752.24436-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MB5+LsFw85NoQu2uiv3l2wgJ11B4+p0XPBRdA1p7MGNT5BSi7S78exbm
	AObdHK/7LWXlW5NkpNGt4ol1ovJgmm+UkkyLkWEmQNvtqZamGE1Tcrm2y/EqefMtGIZwpbH
	4Yx+QMix92oxe6VOLP/DBqqX08Dk1zZAMXj79UxF6m8mBaTedinigG+x7HpBy+OLG6NEXWE
	ILzhBNyLwLIvIyL/RlOrK2Rnol0rWrjYo2AEKT/AUyIA9fZ8Dtwngip1zDEZ+0saP4ztQkp
	rTY5xisKpgduCPP26jqWa0bWevBbv3+qvtYELVUFsHGMXZmlKCl0g3Z2MDDyAGDSXDfFcVk
	c4c9n4pWMtVQ2RtKbCyiLhdWS1ZuatbqYFKeQZ/QOhzv0dE2gN3fJZiRPeUelucchbpxxVr
	m8xthlLbOKCzXYTyEkp1O+eDj0D+7r1ELzTTtO366dN9ApM5f9H/MGhnM4EF7KZwcmSp3Q4
	xxU2s3/Ik4cNO0X/ELnG3YbDuDxMkHCjBNhWoPMVJNK5pv7ix4FmC2MJnSJLjHKcDcuwCqb
	9368izkCcRjIuRqaouQEKDqAIbB3t5GlzP0mauuU/aTBQSmIYBayI6/e6obgvStNU9Iepiq
	V15otrChh0TCt/ihNgPFRXV5RfmJFn0BXCjI8AFYH+2jjeaN4vUxxJM3Jk9iTPkU+kfhFgP
	ho+YFKpT3ofvgdmwYlCaVeEwg0LbG2sMk+AgKiczIp+DVbbMOcyp6TcoLX5GfUjtQHADVji
	HpkmV9xj+quh4esH1yfCHrrH1Zth3tGlj6TgiYHdqmtlRYpqZfSPyJwUPeh7ecdfxyyVUvq
	4/Rzl7oeY1potHHibEGqF3J//vDtE0fn5ahvPuDtzz02oRA0EB3OsEk4B+AMoWONw4iWKBK
	eFe+NowP7p8thw7WZ/mEyATVYMGf+qOVdsn8f6BOFsxZpNbMPII5jmJqqnrFUyENqDfeSVz
	aC0wDwZ/HrAwF6Ii7TY2fSEEd07tIsqXSL9oBH3EiTfIKDuj1nJvMGDKUKQfXegtoDZ+Drx
	PZrShkxBcjDDWWRGN6oe8fho0L/MOSsM6lxEUuxGXqDWiSJmjfuZl0IKNZsZ3mh1Cr6IYH9
	w==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

For those devices which support 64 pools, they also support PF and VF
(i.e. different pools) to configure different RSS key. Enable multiple
RSS, use up to 64 RSS keys and that is one key per pool.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c   | 111 ++++++++++++++-----
 drivers/net/ethernet/wangxun/libwx/wx_hw.h   |   5 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c  |  10 +-
 drivers/net/ethernet/wangxun/libwx/wx_type.h |  17 +++
 4 files changed, 112 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index bcd07a715752..f7ebe2e3e1ab 100644
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
+	u32 random_key_size = WX_RSS_KEY_SIZE / 4;
+	u32 i;
+
+	if (test_bit(WX_FLAG_SRIOV_ENABLED, wx->flags) &&
+	    test_bit(WX_FLAG_MULTI_64_FUNC, wx->flags)) {
+		for (i = 0; i < random_key_size; i++)
+			wr32(wx, WX_RDB_VMRSSRK(i, wx->num_vfs),
+			     *(wx->rss_key + i));
+	} else {
+		for (i = 0; i < random_key_size; i++)
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
 
@@ -2046,6 +2074,50 @@ static void wx_setup_reta(struct wx *wx)
 	wx_store_reta(wx);
 }
 
+void wx_config_rss_field(struct wx *wx)
+{
+	u32 rss_field;
+
+	if (test_bit(WX_FLAG_SRIOV_ENABLED, wx->flags) &&
+	    test_bit(WX_FLAG_MULTI_64_FUNC, wx->flags)) {
+		rss_field = rd32(wx, WX_RDB_PL_CFG(wx->num_vfs));
+		rss_field &= ~WX_RDB_PL_CFG_RSS_MASK;
+		rss_field |= FIELD_PREP(WX_RDB_PL_CFG_RSS_MASK, wx->rss_flags);
+		wr32(wx, WX_RDB_PL_CFG(wx->num_vfs), rss_field);
+
+		/* Enable global RSS and multiple RSS to make the RSS
+		 * field of each pool take effect.
+		 */
+		wr32m(wx, WX_RDB_RA_CTL,
+		      WX_RDB_RA_CTL_MULTI_RSS | WX_RDB_RA_CTL_RSS_EN,
+		      WX_RDB_RA_CTL_MULTI_RSS | WX_RDB_RA_CTL_RSS_EN);
+	} else {
+		rss_field = rd32(wx, WX_RDB_RA_CTL);
+		rss_field &= ~WX_RDB_RA_CTL_RSS_MASK;
+		rss_field |= FIELD_PREP(WX_RDB_RA_CTL_RSS_MASK, wx->rss_flags);
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
@@ -2076,8 +2148,6 @@ static void wx_setup_psrtype(struct wx *wx)
 
 static void wx_setup_mrqc(struct wx *wx)
 {
-	u32 rss_field = 0;
-
 	/* VT, and RSS do not coexist at the same time */
 	if (test_bit(WX_FLAG_VMDQ_ENABLED, wx->flags))
 		return;
@@ -2085,22 +2155,11 @@ static void wx_setup_mrqc(struct wx *wx)
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
@@ -2393,6 +2452,8 @@ int wx_sw_init(struct wx *wx)
 		wx_err(wx, "rss key allocation failed\n");
 		return err;
 	}
+	wx->rss_flags = WX_RSS_FIELD_IPV4 | WX_RSS_FIELD_IPV4_TCP |
+			WX_RSS_FIELD_IPV6 | WX_RSS_FIELD_IPV6_TCP;
 
 	wx->mac_table = kcalloc(wx->mac.num_rar_entries,
 				sizeof(struct wx_mac_addr),
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
index ec63e7ec8b24..bb03a9fdc711 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -168,9 +168,12 @@
 #define WX_RDB_PL_CFG_L2HDR          BIT(3)
 #define WX_RDB_PL_CFG_TUN_TUNHDR     BIT(4)
 #define WX_RDB_PL_CFG_TUN_OUTL2HDR   BIT(5)
+#define WX_RDB_PL_CFG_RSS_EN         BIT(24)
+#define WX_RDB_PL_CFG_RSS_MASK       GENMASK(23, 16)
 #define WX_RDB_RSSTBL(_i)            (0x19400 + ((_i) * 4))
 #define WX_RDB_RSSRK(_i)             (0x19480 + ((_i) * 4))
 #define WX_RDB_RA_CTL                0x194F4
+#define WX_RDB_RA_CTL_MULTI_RSS      BIT(0)
 #define WX_RDB_RA_CTL_RSS_EN         BIT(2) /* RSS Enable */
 #define WX_RDB_RA_CTL_RSS_IPV4_TCP   BIT(16)
 #define WX_RDB_RA_CTL_RSS_IPV4       BIT(17)
@@ -178,8 +181,12 @@
 #define WX_RDB_RA_CTL_RSS_IPV6_TCP   BIT(21)
 #define WX_RDB_RA_CTL_RSS_IPV4_UDP   BIT(22)
 #define WX_RDB_RA_CTL_RSS_IPV6_UDP   BIT(23)
+#define WX_RDB_RA_CTL_RSS_MASK       GENMASK(23, 16)
 #define WX_RDB_FDIR_MATCH            0x19558
 #define WX_RDB_FDIR_MISS             0x1955C
+/* VM RSS */
+#define WX_RDB_VMRSSRK(_i, _p)       (0x1A000 + ((_i) * 4) + ((_p) * 0x40))
+#define WX_RDB_VMRSSTBL(_i, _p)      (0x1B000 + ((_i) * 4) + ((_p) * 0x40))
 
 /******************************* PSR Registers *******************************/
 /* psr control */
@@ -1192,6 +1199,15 @@ struct vf_macvlans {
 	u8 vf_macvlan[ETH_ALEN];
 };
 
+#define WX_RSS_FIELD_IPV4_TCP      BIT(0)
+#define WX_RSS_FIELD_IPV4          BIT(1)
+#define WX_RSS_FIELD_IPV4_SCTP     BIT(2)
+#define WX_RSS_FIELD_IPV6_SCTP     BIT(3)
+#define WX_RSS_FIELD_IPV6_TCP      BIT(4)
+#define WX_RSS_FIELD_IPV6          BIT(5)
+#define WX_RSS_FIELD_IPV4_UDP      BIT(6)
+#define WX_RSS_FIELD_IPV6_UDP      BIT(7)
+
 enum wx_pf_flags {
 	WX_FLAG_MULTI_64_FUNC,
 	WX_FLAG_SWFW_RING,
@@ -1302,6 +1318,7 @@ struct wx {
 #define WX_MAX_RETA_ENTRIES 128
 #define WX_RSS_INDIR_TBL_MAX 64
 	u8 rss_indir_tbl[WX_MAX_RETA_ENTRIES];
+	u8 rss_flags;
 	bool rss_enabled;
 #define WX_RSS_KEY_SIZE     40  /* size of RSS Hash Key in bytes */
 	u32 *rss_key;
-- 
2.48.1


