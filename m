Return-Path: <netdev+bounces-226574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83432BA23A7
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 04:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39C753A0700
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 02:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DC8261591;
	Fri, 26 Sep 2025 02:40:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F6126059F
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 02:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758854411; cv=none; b=tq7u2KUCWM4uqnlgr93pIsD4KZlxZcMmoXoAC32XwwjaN3f8LBCV0A3qPhIyzLnprwSYqn+0b8inNxXFNwTi9CKWyQwD/fsQIb2iSbzyvsqjYzfjy8XSPyYTb5ppoebH2U4LeTJifRkv0kdrqLl/U/ebN/vvjziPN2T8odKp1Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758854411; c=relaxed/simple;
	bh=VabUoo/8/D3VSuK43794lXhz20SCryE9Ue/aCXGV+fs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O84I53gEMjOLLuycXCR8mlqVDsj+TxAUVJQRgR3T4DL12lP4JeID3UYEwrkw8v/yJDsvaCPn5SJQnioK5wNd3BNlIVvItJ6YkhpEJeyxYbhCeZ/V0q6P3BHx6C/KDBNNP/Wl3bKAhWSmjfskSK7qgOQ4fJqYj9Zla/AHHyLV9BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz6t1758854335t67f7dc4d
X-QQ-Originating-IP: MV9TzVO32R7duq2TzoiVsn43evJVkGYTq2/1c48L1sA=
Received: from lap-jiawenwu.trustnetic.com ( [115.220.236.115])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 26 Sep 2025 10:38:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6594133304251475910
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
Subject: [PATCH net-next v6 2/4] net: libwx: move rss_field to struct wx
Date: Fri, 26 Sep 2025 10:38:41 +0800
Message-Id: <20250926023843.34340-3-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: NlS/C0FXcHUSSTAha+waNk5KKtK5u7Hvu3tbCjXCDmGmW9ZzU4LnOLxc
	c31oMn+J3t3QwcKRRZFY8ON0dJhczJGzhekI/lkRc76RU15yUP71hN3e3iY3WfvY5aCuueo
	HMaW0B36jOPotdDreI+L8DaEKZ+rsUc4K9KOkEbRptv/7FBmBdgU87PfzjcmAChLF5MTQpz
	+bwGJcYr4VkJSYxJWtRvtPOaXivsarcCk1T5ym582U0eKwxyGLudK+gjh4a+ZivX5zdiNet
	HM71vVkcVaesmQx63+PK0PYK64/7PlmQ01+6i0Zv9iLvRP1RuPyI+8nX1WAhlVauaLHw/YJ
	YYOOQOk2q8kjVucNsbeI3x1gJkc1Q5yZkJEqOA/huAmUbSXAxZ+ru7cAq6Lh+HRCo846v6F
	Fxl2HPxXmLZYfUp52D+FJKwyKjmr0SPH8KWQcSAVcOkuynViqqn2b7m6qY0CfKjhFCYWbAA
	golllPudoPYFq6nrqmrSQUTrIp72LMpMhjnvY8qlozjs+eCTRQkNEX6AbNcNPBjHYiL3u33
	mfIoE3z353+58YRSNE2OFCFU6Xf+qOUMdslWkb+vNQi41gVEtng1K508kNwAFyNfoVVCuKw
	8e24Nxeq59IDDA6knx2ANS3oV47Gl9FemAHkcdtzYpj2EbHEsh6id0g5IDwHHYLVTiid9GD
	Gg2nMGuOLBdl8AZYv8NEnakGjRxRd7traKhH8zloEdRGcHelrdgiHbNt3q4erI+E3HW0nbH
	fm3hE8tkUay7tvF357/CYKtne1dZn+edn9Qhg7KGBQHshB964fup/mehOnQHpTefHZbQ7Nz
	a/I+vrxEvahPGpseqyoV3TIAWORdV5Oaw9MI6Y+1kygywKVunfnPrOmyu8RhBEh/Aup1X9e
	neAhC7jO+tLuFTk/Ht68kX3QqiuudMiHhQMSUJOFLZl83cIVB2OFwWdkiVSVeBO0lSXOS9e
	/fR4CR3uATQbSLPcveJt1RQ3Du/L8CygMGuFaP2OjC94t9qnOmA3qDs1lBEC2uRIVkqLNdk
	iU98sNSxTyrvYEsiHMktEzyUE/unveIQRl3jOL7Ya4qJ4B8ffMg023x53DLA4HLvMYoKo6Z
	g==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
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


