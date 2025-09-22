Return-Path: <netdev+bounces-225186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A2CB8FD2C
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 11:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D3872A02EF
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 09:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2762F549B;
	Mon, 22 Sep 2025 09:45:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3352D8371
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758534307; cv=none; b=aE7VQ9DCBQUfbcR/X3OTLXwRNR85AWHjoZ86dOkXCAvmGwTud9JLxl5oFG6Ln/3VsIDzh8rfGR/vUFCV9Hztz0kHBetGBU53+tcL7ADjnyaQfO5DEq442c5id1d1+1SeRNBEph+P9zQRj+uA31AE28Ml5558TUZEN+BUHlkGh4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758534307; c=relaxed/simple;
	bh=VabUoo/8/D3VSuK43794lXhz20SCryE9Ue/aCXGV+fs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=INBYtck8tcPs52MfoWP8apb0MAOl1sXeE0gbp62p4Fa7H0EV01/Oqieh9nZPhOGTU9tJXoZ7tMu8sLsqU5D/gZnptVrxl0n4C3L8Q5kjofQ819E+6bIEJNn8zPlJmL0n3UQUEWqcNdaOQKW+pcQs1fJtGGAqh4I1iXgyLpjFWN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz3t1758534227tad14da70
X-QQ-Originating-IP: fE+HF2vvgUTWikdsEG0UT7JuKqtW37VyBfEnCSgE4S8=
Received: from lap-jiawenwu.trustnetic.com ( [122.231.221.166])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 22 Sep 2025 17:43:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7741034201694396774
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
Subject: [PATCH net-next v5 2/4] net: libwx: move rss_field to struct wx
Date: Mon, 22 Sep 2025 17:43:25 +0800
Message-Id: <20250922094327.26092-3-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: NHQD8NIzEAhRykYxOXqa4GaYZBmzfI0J8wE/dWLr23fhdJ1cGqe5LkpJ
	ddyz0zc0i9cETNgW622kD30/xlaZYJQbHLdFRLbL+SSbBgxMTXIZcCs7n7QtCxZgK4bS/94
	Mk4PJw4u3/fh/G/ta3/nVw6JzslY6J/kNF8SVLwqMEgCK9D5yVy36xMRkEYjT7FaF0q5WDh
	42UIBSYkYv2spMQL4uzwnG+hxhluKMcfpZGUJYikds2Srk63u98nMW7ZfYKFMqfaFWVCOQx
	kax2NIjGs+EicGKjXivMpsdAf5rh8+4MYJ00K63Ozj0nx/N1c4hjt67tYbQNr3JT6NlS09g
	T805aZEMdF5TxZk5g7Jf40FeCtlwqpxRjQPSgaLdp5NBxfOyTpSjx2KNrAdGKNzr1EptKx+
	0h/EJ2X26oC7IoUlxoTmud+VzxltWL1VKy4gIfLBXlT9aVm8aHm+JyUIQ4scqS3ITrwNnlx
	/oMhLoxedLQi1sWQ4KK50kQvf8GCVtlg1BFqzv3oVEq5LbYpRJgYGMmX2qjWJu+NGoTpLgE
	YC52bthfbiajZoulDYseHyfHYy4gaFLNKaer9xK/zMTX7S2rcdxmEsDIbAyllZ7qx1Wkngm
	nU0BhlGr4FxERNOLrpUcRV9tGEcEdIujGIbrpWH2YYoKJ7Q8EW4AcDRxj6IJoCcCFKRACyP
	rzM+M9HWJvCLbiGdIUAUYW3VL7hn08lpdCBTzfEhVoim0EARtq3Zc+LjPr/VH2RW8Cu/MFd
	3evYWXuu3VxIIYTY9+xww/PcCpWVe5g21Zu0ExrrQGSSpQ0nVEwO/Z0qySAtVW2bcD2oMc5
	leerX3vSOIuQZdvCiDnF2cqBhHMDEiiv1zSSkP+JO/5sB4VODStO4sK5vLCGpUQG4PF3AXK
	vsAbwjSBA1iNXRfshkiqnuUx/4Rjx2d7nq2ghFXDndnJj63kB6CPpG8ppU2KEgMMmjC/hnR
	H5INk4ozxvL94UzjRGWmtYPlPhWkDnMeI4pBINlLvTkiyO4Lg5EssMk8GsiqiFykpyub1jd
	jwPfsw7l3dnnpilQg7+AvgebCsgJ47KlZcY2RdlxGALACaGfSqW/5HblqD7fw=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

For global RSS and multiple RSS scheme, the RSS type fields are defined
identically in the registers. So they can be defined as the macros
WX_RSS_FIELD_* to cleanup the codes. And to prepare for the RXFH support
in the next patch, move the rss_field to struct wx.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c   | 17 +++++++++--------
 drivers/net/ethernet/wangxun/libwx/wx_type.h | 12 ++++++++++++
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 0bb4cddf7809..9bffa8984cbe 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -2078,16 +2078,11 @@ void wx_config_rss_field(struct wx *wx)
 {
 	u32 rss_field;
 
-	/* Global RSS and multiple RSS have the same type field */
-	rss_field = WX_RDB_RA_CTL_RSS_IPV4 |
-		    WX_RDB_RA_CTL_RSS_IPV4_TCP |
-		    WX_RDB_RA_CTL_RSS_IPV4_UDP |
-		    WX_RDB_RA_CTL_RSS_IPV6 |
-		    WX_RDB_RA_CTL_RSS_IPV6_TCP |
-		    WX_RDB_RA_CTL_RSS_IPV6_UDP;
-
 	if (test_bit(WX_FLAG_SRIOV_ENABLED, wx->flags) &&
 	    test_bit(WX_FLAG_MULTI_64_FUNC, wx->flags)) {
+		rss_field = rd32(wx, WX_RDB_PL_CFG(wx->num_vfs));
+		rss_field &= ~WX_RDB_PL_CFG_RSS_MASK;
+		rss_field |= FIELD_PREP(WX_RDB_PL_CFG_RSS_MASK, wx->rss_flags);
 		wr32(wx, WX_RDB_PL_CFG(wx->num_vfs), rss_field);
 
 		/* Enable global RSS and multiple RSS to make the RSS
@@ -2097,6 +2092,9 @@ void wx_config_rss_field(struct wx *wx)
 		      WX_RDB_RA_CTL_MULTI_RSS | WX_RDB_RA_CTL_RSS_EN,
 		      WX_RDB_RA_CTL_MULTI_RSS | WX_RDB_RA_CTL_RSS_EN);
 	} else {
+		rss_field = rd32(wx, WX_RDB_RA_CTL);
+		rss_field &= ~WX_RDB_RA_CTL_RSS_MASK;
+		rss_field |= FIELD_PREP(WX_RDB_RA_CTL_RSS_MASK, wx->rss_flags);
 		wr32(wx, WX_RDB_RA_CTL, rss_field);
 	}
 }
@@ -2450,6 +2448,9 @@ int wx_sw_init(struct wx *wx)
 		wx_err(wx, "rss key allocation failed\n");
 		return err;
 	}
+	wx->rss_flags = WX_RSS_FIELD_IPV4 | WX_RSS_FIELD_IPV4_TCP |
+			WX_RSS_FIELD_IPV6 | WX_RSS_FIELD_IPV6_TCP |
+			WX_RSS_FIELD_IPV4_UDP | WX_RSS_FIELD_IPV6_UDP;
 
 	wx->mac_table = kcalloc(wx->mac.num_rar_entries,
 				sizeof(struct wx_mac_addr),
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 0450e276ae28..bb03a9fdc711 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -169,6 +169,7 @@
 #define WX_RDB_PL_CFG_TUN_TUNHDR     BIT(4)
 #define WX_RDB_PL_CFG_TUN_OUTL2HDR   BIT(5)
 #define WX_RDB_PL_CFG_RSS_EN         BIT(24)
+#define WX_RDB_PL_CFG_RSS_MASK       GENMASK(23, 16)
 #define WX_RDB_RSSTBL(_i)            (0x19400 + ((_i) * 4))
 #define WX_RDB_RSSRK(_i)             (0x19480 + ((_i) * 4))
 #define WX_RDB_RA_CTL                0x194F4
@@ -180,6 +181,7 @@
 #define WX_RDB_RA_CTL_RSS_IPV6_TCP   BIT(21)
 #define WX_RDB_RA_CTL_RSS_IPV4_UDP   BIT(22)
 #define WX_RDB_RA_CTL_RSS_IPV6_UDP   BIT(23)
+#define WX_RDB_RA_CTL_RSS_MASK       GENMASK(23, 16)
 #define WX_RDB_FDIR_MATCH            0x19558
 #define WX_RDB_FDIR_MISS             0x1955C
 /* VM RSS */
@@ -1197,6 +1199,15 @@ struct vf_macvlans {
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
@@ -1307,6 +1318,7 @@ struct wx {
 #define WX_MAX_RETA_ENTRIES 128
 #define WX_RSS_INDIR_TBL_MAX 64
 	u8 rss_indir_tbl[WX_MAX_RETA_ENTRIES];
+	u8 rss_flags;
 	bool rss_enabled;
 #define WX_RSS_KEY_SIZE     40  /* size of RSS Hash Key in bytes */
 	u32 *rss_key;
-- 
2.48.1


