Return-Path: <netdev+bounces-230811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5D9BEFF22
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 10:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF9844F031A
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 08:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30E32EBDD3;
	Mon, 20 Oct 2025 08:27:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BD02EAB6B
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 08:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760948846; cv=none; b=uoIfEyRPo2nCJ98aFYRnXgyQ0Z3F8ZFC9ZJwqLCj0CqXEOKup6xc7P+94Lzc7/cExFmViHtraWCi/Ajna3xrsG41ccDv2JZyRORqHrmCDF+6YxDSMS0qTfTaqAfLRIR+dhJGiE6CYpXidBcvyhabnKooN/2hFZONQ7sCb3ux98M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760948846; c=relaxed/simple;
	bh=nA8nggxrhudttRuR6oMBpK5P2GkibOFb0anXIzZ1SfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CDJaaA2WnVPeDevm+kUD6ajaP8/VHIaYAITKR8TZaapD9WBH570QPcsQkHXl7NB+YCuqMKXOK/YFVQuYwJJYMa73F2OpJOaAH4PwKivSguowNW17y2afLFBY0t8WyuIIOxM6SL0cpD+sk4GVK55orCVq5yr8DSSF+jj+VjrBix4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz7t1760948779t8c96fd5a
X-QQ-Originating-IP: D+Dpd8a7CCgQVbTXm158hwNfsvCNuj+e35Xkyi29+G0=
Received: from lap-jiawenwu.trustnetic.com ( [60.186.187.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 20 Oct 2025 16:26:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16559476465239066724
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
Subject: [PATCH net-next 1/3] net: txgbe: support RX desc merge mode
Date: Mon, 20 Oct 2025 16:26:07 +0800
Message-Id: <20251020082609.6724-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251020082609.6724-1-jiawenwu@trustnetic.com>
References: <20251020082609.6724-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OST2d686M2k2jHZNBB55SHZT0XUVm+ZQf4EARRAE1Fx7mM/KKFlSc+k9
	BHnXXGk1EDP5cC/He6GJb1pYeBCDhozVnJOs9C5HV6dRnRrmRTIzlUBcyD16Vgxx7ZflHVP
	p/lmVBEe0zuPsXjNjjZFqq3t4EnxlJKowjXfcSgBb6NFWOJRxmMD5IwcIJEN90+yM7FWGrI
	Mr64SZTV3qlt4N2gGpgg6p9Olt10gpT3rPdXyY7GAXdgma9VOBq7C1N1St+Yl6sSJ9GfM9c
	M2nL0n469XWp4GLH/yn1Bj+5W/V+SvRQqfAvYEcjiwguzmauVjLvxjTOO18UygFjmvmq/7Y
	s8mQCHP9WxSUI2lZzG+Cwf2LlC/xSmmvP/gqe0tlMO+V27AjB0kKH58CLgJZfCS3w3OWcIY
	PYdLqM4cODj0aikPTS8OBal/IzNsMl9yrinSdVlSMQV0JvzJhKfwG+rzC5cfKezmujOQMuB
	f2R5Y+xMSpitGKFOaCKbJ8bpfIhEEjltNd4zbZs016NwMTmnucE3nFPvocOwqJxIK8kM/u+
	aIoibg+tE3X8eAYTCTadpFW+QfBIcerAE9H3AwbKyVsDN8++Cwd49Ycq1at0da4TOvcdnG0
	fEhSBL7s9lS3bDZYTOk5KRvpFC9w/55kgJ80yi8HI0mT/0ny6eXbHj7H3LSi+0+y4S7znLr
	CYflT1T63z+xwTj5IEvQ4yzGKJj4K2FTyVshA9gEFMbNCeaJvO3i3RO00/Y3drZfSejmwNN
	YG88gNBY5PTgYSJXFpHJSO14L56zQmMJK1ZwFEbwt/gjmrbCDVa3yO6JunzTzxI56+Ks4TI
	ZZHl376IvfsTU4oc9WaHaY2dkj6gMuQIK0vZVKyoLlsDGSLEKSD+i5KVyy6j0Gsa2FuukFr
	w9vUAqg2eOy2ap0jKHY8SbmAXa+IWd2crJcjqARr+3H6wVgvRpJJCY3L9yFZK7DZV1dPUYe
	Vp8BoIbF6KBJbav87dP+6ucvGiIakSfNSx1dm/Pt8mwIVL5Df/ncId83/chfhohCAMK2dgx
	L3kWtLwZtz8kIhcqL4bve8ofXNHnZfqYVv1OYYpYEp0Ic4M9rJ
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
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


