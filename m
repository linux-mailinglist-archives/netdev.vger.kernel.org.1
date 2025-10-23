Return-Path: <netdev+bounces-231953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1F9BFEDE1
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 03:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 32520350F27
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 01:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6448D154BE2;
	Thu, 23 Oct 2025 01:46:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8228713D891
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 01:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761184007; cv=none; b=aLLwfjQmNxmhBoXfXl4eltTpvqXCrtHaVaX3er2itFgmdREUdBcN4VtgCc+W6bKDhake250FXhZyn601185uDQ1Cv8J5shBAEDAZCcy4I51WbV6o1AnKAHCIJzjLR1nbSQCF554Tq0V0E/I5GZExFyqph0trpFQ3JvReaW7CZqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761184007; c=relaxed/simple;
	bh=nA8nggxrhudttRuR6oMBpK5P2GkibOFb0anXIzZ1SfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f00mntTN64YJi/QNEstErw88cZFNaTvhfxw6OQJjgQ1Li+x852+f/bBy2hYDfGg3dIpoI68H+TnBXGpsQUJZIH9WE99RModWHqwD/7kcqFGLM8zzR+IesqO4dnGxNMoDUCdTvGpTZM8gNyfXz8Els5SKe8e2t03e3blFfzFpFMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz20t1761183946t253721ec
X-QQ-Originating-IP: vw2d2Mes/wB2dbXw2imFzD5R7fDudTraXhngHLfiFP0=
Received: from lap-jiawenwu.trustnetic.com ( [60.186.187.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 23 Oct 2025 09:45:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11064877258441940471
EX-QQ-RecipientCnt: 9
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v2 1/3] net: txgbe: support RX desc merge mode
Date: Thu, 23 Oct 2025 09:45:36 +0800
Message-Id: <20251023014538.12644-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251023014538.12644-1-jiawenwu@trustnetic.com>
References: <20251023014538.12644-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Mutteg8H72qDIjTI+10lN2TdTB7TPs2uTHjafBhf0UBnga/lh+0Kalru
	/yRWc5If68oh632VUU12CGOKJi/ENy2HDF51ApjuVYHnUISuL3ETJgbV9N1qVROworH596C
	YHa08OxpnDQMjnyNncEZoKclJeGOzLdUPdC743v2nfjvOocI94Lc7co8IAQbVf3egQGKNO+
	YtO27q0LoUFfKDS+N/lZGbONctnOx5p8QLB34MTEy/dw3v0Y9y1eJUI+aZEij7NbRN5RXrq
	cFX3eON6VWFVN5a1eyqWraa2cciMIOUFzDtS8RXMgR8AXQcGOcays39dG7H1XaZj1Xe+DFq
	yMuE/9/z9Q4JRob6NpZLV7jAJWtos/GZCO+P8hAqx/qfwMSRpfy3h4FeGjEsbLS069SjgJc
	uiGf55d/3hhtldoL9z7du6Dx/Gt4niglb5x6mVUKnkyZhe+V1I4b18zuhgWEuVPXSPgOCf2
	nZcZL7y/A5cLCAnygMrJDc/1mfXWT5NW84hZ5kd75XFfDsF4L2orhICKXZ2tdaWHT/oLTaa
	+AFSq42Ru0uwbFe/S9EjWz6UyE+oHwHXv8NMvFxhnw/XuDL+bRlXcqfREJgCEivCc1WRkhc
	xO3EYG5RdPnrU6ke5x4EAA9ef8XNLM6vhCxbEb02Fh797ioMRkzqsN9lwumcmX0HRcFq3ii
	pOjjz5Lfjr0/lCuoxXwWhJeIjnaXQ44SFGbRbaZ7nZSDXtGUABd57BAPu95tIpI4Q3kbXOb
	OkaqgYVaE7TPor1EhH0Sveg0qvoZ35nAhoi10oog7mEu6uH0T2DrghzfU00qqoVrukJNOep
	RsZUmq2Pcbvs1OsreWGI6M2rX0ayGP07+ozBKHqtxHTC0DPh2pSNucleV761EKajRZRGGvw
	1+MM11pJxXJWnEOerzUuFi7x/wiDyhK7yXGGk5KGT14UASWCGp7kI44IPZhZZ5oiBCZPWJZ
	Jk4aPy3Suhn7LF/IqMunIvhgWnrIoJPwhALXKl5uamjyR34niKBL1sNjc9lSvrxQaAJ1RVI
	tbxkC1xuDGTeeEZKq3RAEVG2mj/NCwm/ELPyaQyg==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

RX descriptor merge mode is supported on AML devices. When it is
enabled, the hardware process the RX descriptors in batches.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c          | 10 ++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_type.h        |  7 +++++++
 drivers/net/ethernet/wangxun/libwx/wx_vf.h          |  1 +
 drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c      |  3 +++
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c     |  1 +
 drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c | 11 +++++++++++
 6 files changed, 33 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 1e2713f0c921..2dbbb42aa9c0 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -1935,6 +1935,10 @@ static void wx_configure_rx_ring(struct wx *wx,
 		rxdctl |= (ring->count / 128) << WX_PX_RR_CFG_RR_SIZE_SHIFT;
 
 	rxdctl |= 0x1 << WX_PX_RR_CFG_RR_THER_SHIFT;
+
+	if (test_bit(WX_FLAG_RX_MERGE_ENABLED, wx->flags))
+		rxdctl |= WX_PX_RR_CFG_DESC_MERGE;
+
 	wr32(wx, WX_PX_RR_CFG(reg_idx), rxdctl);
 
 	/* reset head and tail pointers */
@@ -2190,6 +2194,12 @@ void wx_configure_rx(struct wx *wx)
 	/* set_rx_buffer_len must be called before ring initialization */
 	wx_set_rx_buffer_len(wx);
 
+	if (test_bit(WX_FLAG_RX_MERGE_ENABLED, wx->flags)) {
+		wr32(wx, WX_RDM_DCACHE_CTL, WX_RDM_DCACHE_CTL_EN);
+		wr32m(wx, WX_RDM_RSC_CTL,
+		      WX_RDM_RSC_CTL_FREE_CTL | WX_RDM_RSC_CTL_FREE_CNT_DIS,
+		      WX_RDM_RSC_CTL_FREE_CTL);
+	}
 	/* Setup the HW Rx Head and Tail Descriptor Pointers and
 	 * the Base and Length of the Rx Descriptor Ring
 	 */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 4880268b620e..eb3f32551c14 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -83,8 +83,13 @@
 
 /*********************** Receive DMA registers **************************/
 #define WX_RDM_VF_RE(_i)             (0x12004 + ((_i) * 4))
+#define WX_RDM_RSC_CTL               0x1200C
+#define WX_RDM_RSC_CTL_FREE_CNT_DIS  BIT(8)
+#define WX_RDM_RSC_CTL_FREE_CTL      BIT(7)
 #define WX_RDM_PF_QDE(_i)            (0x12080 + ((_i) * 4))
 #define WX_RDM_VFRE_CLR(_i)          (0x120A0 + ((_i) * 4))
+#define WX_RDM_DCACHE_CTL            0x120A8
+#define WX_RDM_DCACHE_CTL_EN         BIT(0)
 #define WX_RDM_DRP_PKT               0x12500
 #define WX_RDM_PKT_CNT               0x12504
 #define WX_RDM_BYTE_CNT_LSB          0x12508
@@ -447,6 +452,7 @@ enum WX_MSCA_CMD_value {
 #define WX_PX_RR_CFG_VLAN            BIT(31)
 #define WX_PX_RR_CFG_DROP_EN         BIT(30)
 #define WX_PX_RR_CFG_SPLIT_MODE      BIT(26)
+#define WX_PX_RR_CFG_DESC_MERGE      BIT(19)
 #define WX_PX_RR_CFG_RR_THER_SHIFT   16
 #define WX_PX_RR_CFG_RR_HDR_SZ       GENMASK(15, 12)
 #define WX_PX_RR_CFG_RR_BUF_SZ       GENMASK(11, 8)
@@ -1232,6 +1238,7 @@ enum wx_pf_flags {
 	WX_FLAG_NEED_SFP_RESET,
 	WX_FLAG_NEED_UPDATE_LINK,
 	WX_FLAG_NEED_DO_RESET,
+	WX_FLAG_RX_MERGE_ENABLED,
 	WX_PF_FLAGS_NBITS               /* must be last */
 };
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf.h b/drivers/net/ethernet/wangxun/libwx/wx_vf.h
index 3f16de0fa427..ecb198592393 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf.h
@@ -74,6 +74,7 @@
 #define WX_VXRXDCTL_BUFSZ(f)     FIELD_PREP(GENMASK(11, 8), f)
 #define WX_VXRXDCTL_HDRSZ_MASK   GENMASK(15, 12)
 #define WX_VXRXDCTL_HDRSZ(f)     FIELD_PREP(GENMASK(15, 12), f)
+#define WX_VXRXDCTL_DESC_MERGE   BIT(19)
 #define WX_VXRXDCTL_RSCMAX_MASK  GENMASK(24, 23)
 #define WX_VXRXDCTL_RSCMAX(f)    FIELD_PREP(GENMASK(24, 23), f)
 #define WX_VXRXDCTL_RSCEN        BIT(29)
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
index a87887b9f8ee..f54107f3c6d7 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
@@ -272,6 +272,9 @@ void wx_configure_rx_ring_vf(struct wx *wx, struct wx_ring *ring)
 	rxdctl |= WX_VXRXDCTL_RSCMAX(0);
 	rxdctl |= WX_VXRXDCTL_RSCEN;
 
+	if (test_bit(WX_FLAG_RX_MERGE_ENABLED, wx->flags))
+		rxdctl |= WX_VXRXDCTL_DESC_MERGE;
+
 	wr32(wx, WX_VXRXDCTL(reg_idx), rxdctl);
 
 	/* pf/vf reuse */
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index c4c4d70d8466..60a04c5a7678 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -423,6 +423,7 @@ static int txgbe_sw_init(struct wx *wx)
 		break;
 	case wx_mac_aml:
 	case wx_mac_aml40:
+		set_bit(WX_FLAG_RX_MERGE_ENABLED, wx->flags);
 		set_bit(WX_FLAG_SWFW_RING, wx->flags);
 		wx->swfw_index = 0;
 		break;
diff --git a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
index 72663e3c4205..52c1e223bbd7 100644
--- a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
+++ b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
@@ -157,6 +157,17 @@ static int txgbevf_sw_init(struct wx *wx)
 
 	wx->set_num_queues = txgbevf_set_num_queues;
 
+	switch (wx->mac.type) {
+	case wx_mac_sp:
+		break;
+	case wx_mac_aml:
+	case wx_mac_aml40:
+		set_bit(WX_FLAG_RX_MERGE_ENABLED, wx->flags);
+		break;
+	default:
+		break;
+	}
+
 	return 0;
 err_reset_hw:
 	kfree(wx->vfinfo);
-- 
2.48.1


