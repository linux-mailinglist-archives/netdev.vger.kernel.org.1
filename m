Return-Path: <netdev+bounces-275856-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OB1iJQlz1GmSuAcAu9opvQ
	(envelope-from <netdev+bounces-275856-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 04:59:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D2C3A948B
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 04:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8C45303CE0A
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 02:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF93372B37;
	Tue,  7 Apr 2026 02:57:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1CA28AB0B
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 02:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775530660; cv=none; b=LPztTsKFincq4btiCvkLU/0TMJPwRky4r8qCiDpFLJqx2bLHPogoP3JPu01rVWWkhY3zll5XW1LJaPAN+CbHGjuOvkTFPAJOL0YkYMpfjHMmyrNOr0lxa/KIfOjCKGMcr/zCauBdc/fZH8HFrQO0EY0TgEE3rsPtpUafZe5NFXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775530660; c=relaxed/simple;
	bh=GmpsRA5uFz9AlBF6nKTXsRWUUxGPkWDUJ/9Vifvu6JY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qyHrWSJUrbL1yImRZZne599od6FWw83JvZlTMvqYsQVGHQZSd11x2N2ct4SUyB9udRvV0kWv1Jt6yzXu3V3HE4yF2UWGXJotPWNM9mb7BI8UK/F8tqZU1vLlJsyoo9lmt6T1pLHZjTNbmneXns4XVPosn71tnxfXxgl9JGpvnQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz3t1775530621tbd897b10
X-QQ-Originating-IP: sEMVlLrI4vuwBrf+COvGwvtsxdJ0CzmP1zoTLFkOH1g=
Received: from lap-jiawenwu.trustnetic.com ( [115.220.225.134])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 07 Apr 2026 10:56:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 877228334490993617
EX-QQ-RecipientCnt: 17
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Joe Damato <joe@dama.to>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v7 9/9] net: libwx: improve flow control setting
Date: Tue,  7 Apr 2026 10:56:16 +0800
Message-Id: <20260407025616.33652-10-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260407025616.33652-1-jiawenwu@trustnetic.com>
References: <20260407025616.33652-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NBplAH1p/X/ddF3xIujw4TO9t1ms3jmiJbB7852Aej2OkPzE3PuB/+rp
	QyLu0y2/wjNQMorgED/I36N0x8Jd17u/ufc1p+8jNM2WQ3EJVEUrkoBHJLonOjhexHwD79S
	LCxdzm28dXkssLJWqiyh5mpQ132r1mvVRmDwPkvdRxkZw0fXh1CxRp7eBxDSsckigMYslA/
	oH4WduH0d6HUUHmSZNJ63fhyJ+6yWF9aKQriJEMAlxepCcOq32ekXt536/8BFdFfm4rKs2/
	TXmoI8c9VsEeU8PLKGCcNUa9jlvk6iuyfL8Aj6v/saP9oN2LxSgodmjb5VpZCAVSozF+Xxr
	aGBNwf/yOkUNcU3hvTqYMpnOViSFu1+Fg/Q+U5r0+QjADV8fYMcrVXtYZiLruIvwmVRbAJD
	rulHBpQ5x9CnAEGwrRIygcF2mxjXq2Fe4FzyI1lvCf1V5Rzxsb1ORFCrx4qiaGerNkSzjAD
	Loo81s1tDPkavbokH6Av1Apyhmazix2eQlnWkFaT2c0wRN6CNoeQvHcUVc2m4W1hRekcHTf
	GQ2jKE5tAh438G/tpVTU1hnJ3dAdU6f6Or9XdI8A/b8JqAlboGrvvrMHjgAS+UMLPSubMUX
	jvkhBlRRJ6zJUwWWSCBGUPLyGER30x4KIbTpnCWrVRQjWrsNk1fsIBIOCLt1bBEuKmY6yiR
	zScFUO1VlcZPainMSIHxuTX+ErvG2a2sQUFk7cfwIjV+Kl2uDxpL2md7OeGMoYNItIXDsuh
	zE+9pBGWd7d0rH7nk/BcZPZn/W5b91LPKYcz/XdKU0Il6EvK4Ot90K/Dhrr80Fr3Q0vFRtI
	cM90bz9+2wRHmEC2yUt/rGbNcdu5s0xt4CtjCjYQ2Fn6ajw2JdFERlDwL52BshAXQAOYbHv
	wRAizKZi/25SEq6Kc3Kw4lOe4iLVyddnwbKUDaS8X8EBo2TiUzT2tZQZhp8VfrxzQ2XRNf7
	fNK6W5KTfmuN6tBpiaFk+nbEaSU86MPkmisvRX6flN3fcE0m7g4pmWXb9+KlzLDPe5bTSWp
	egyNi+FB8RDi7zTfn2H+oOmyJn6LegD5UZgw9opSAd5pacgx7eDQmHL+vJvn/UZWu6Ijz7S
	ZOCJFfvkTfq
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275856-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,linux.intel.com,intel.com,dama.to,gmail.com,debian.org,trustnetic.com];
	NEURAL_SPAM(0.00)[0.305];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trustnetic.com:email,trustnetic.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E1D2C3A948B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Save the current mode of flow control, and enhance the statistics of
pause frames.

The received pause frames are divided into XON and XOFF to be counted.
And due to the hardware defect of SP devices, XON packets cannot be
trasmitted correctly, so Tx XON pause is disabled by default for those
devices.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |  2 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 46 +++++++++++++++++--
 drivers/net/ethernet/wangxun/libwx/wx_type.h  | 19 +++++++-
 3 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 6adb8cbcad1f..5df971aca9e3 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -211,7 +211,7 @@ void wx_get_pause_stats(struct net_device *netdev,
 
 	hwstats = &wx->stats;
 	stats->tx_pause_frames = hwstats->lxontxc + hwstats->lxofftxc;
-	stats->rx_pause_frames = hwstats->lxonoffrxc;
+	stats->rx_pause_frames = hwstats->lxonrxc + hwstats->lxoffrxc;
 }
 EXPORT_SYMBOL(wx_get_pause_stats);
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 57d6671ec618..d3772d01e00b 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -2774,6 +2774,15 @@ int wx_fc_enable(struct wx *wx, bool tx_pause, bool rx_pause)
 		}
 	}
 
+	if (rx_pause && tx_pause)
+		wx->fc.mode = wx_fc_full;
+	else if (rx_pause)
+		wx->fc.mode = wx_fc_rx_pause;
+	else if (tx_pause)
+		wx->fc.mode = wx_fc_tx_pause;
+	else
+		wx->fc.mode = wx_fc_none;
+
 	/* Disable any previous flow control settings */
 	mflcn_reg = rd32(wx, WX_MAC_RX_FLOW_CTRL);
 	mflcn_reg &= ~WX_MAC_RX_FLOW_CTRL_RFE;
@@ -2792,7 +2801,9 @@ int wx_fc_enable(struct wx *wx, bool tx_pause, bool rx_pause)
 
 	/* Set up and enable Rx high/low water mark thresholds, enable XON. */
 	if (tx_pause && wx->fc.high_water) {
-		fcrtl = (wx->fc.low_water << 10) | WX_RDB_RFCL_XONE;
+		fcrtl = (wx->fc.low_water << 10);
+		if (wx->mac.type != wx_mac_sp)
+			fcrtl |= WX_RDB_RFCL_XONE;
 		wr32(wx, WX_RDB_RFCL, fcrtl);
 		fcrth = (wx->fc.high_water << 10) | WX_RDB_RFCH_XOFFE;
 	} else {
@@ -2833,6 +2844,21 @@ int wx_fc_enable(struct wx *wx, bool tx_pause, bool rx_pause)
 }
 EXPORT_SYMBOL(wx_fc_enable);
 
+static void wx_update_xoff_rx_lfc(struct wx *wx)
+{
+	struct wx_hw_stats *hwstats = &wx->stats;
+
+	if (wx->fc.mode != wx_fc_full &&
+	    wx->fc.mode != wx_fc_rx_pause)
+		return;
+
+	if (wx->mac.type >= wx_mac_aml)
+		hwstats->lxoffrxc += rd32_wrap(wx, WX_MAC_LXOFFRXC_AML,
+					       &wx->last_stats.lxoffrxc);
+	else
+		hwstats->lxoffrxc += rd64(wx, WX_MAC_LXOFFRXC);
+}
+
 /**
  * wx_update_stats - Update the board statistics counters.
  * @wx: board private structure
@@ -2887,6 +2913,8 @@ void wx_update_stats(struct wx *wx)
 	wx->restart_queue = restart_queue;
 	wx->tx_busy = tx_busy;
 
+	wx_update_xoff_rx_lfc(wx);
+
 	hwstats->gprc += rd32(wx, WX_RDM_PKT_CNT);
 	hwstats->gptc += rd32(wx, WX_TDM_PKT_CNT);
 	hwstats->gorc += rd64(wx, WX_RDM_BYTE_CNT_LSB);
@@ -2901,7 +2929,11 @@ void wx_update_stats(struct wx *wx)
 	hwstats->mptc += rd64(wx, WX_TX_MC_FRAMES_GOOD_L);
 	hwstats->roc += rd32(wx, WX_RX_OVERSIZE_FRAMES_GOOD);
 	hwstats->ruc += rd32(wx, WX_RX_UNDERSIZE_FRAMES_GOOD);
-	hwstats->lxonoffrxc += rd32(wx, WX_MAC_LXONOFFRXC);
+	if (wx->mac.type >= wx_mac_aml)
+		hwstats->lxonrxc += rd32_wrap(wx, WX_MAC_LXONRXC_AML,
+					      &wx->last_stats.lxonrxc);
+	else
+		hwstats->lxonrxc += rd32(wx, WX_MAC_LXONRXC);
 	hwstats->lxontxc += rd32(wx, WX_RDB_LXONTXC);
 	hwstats->lxofftxc += rd32(wx, WX_RDB_LXOFFTXC);
 	hwstats->o2bgptc += rd32(wx, WX_TDM_OS2BMC_CNT);
@@ -2958,7 +2990,15 @@ void wx_clear_hw_cntrs(struct wx *wx)
 	rd64(wx, WX_RX_LEN_ERROR_FRAMES_L);
 	rd32(wx, WX_RDB_LXONTXC);
 	rd32(wx, WX_RDB_LXOFFTXC);
-	rd32(wx, WX_MAC_LXONOFFRXC);
+	if (wx->mac.type >= wx_mac_aml) {
+		wr32(wx, WX_MAC_LXONRXC_AML, 0);
+		wr32(wx, WX_MAC_LXOFFRXC_AML, 0);
+		wx->last_stats.lxonrxc = 0;
+		wx->last_stats.lxoffrxc = 0;
+	} else {
+		rd32(wx, WX_MAC_LXONRXC);
+		rd64(wx, WX_MAC_LXOFFRXC);
+	}
 }
 EXPORT_SYMBOL(wx_clear_hw_cntrs);
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 3c5a351974dd..0da5565ee4ff 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -79,7 +79,10 @@
 #define WX_RX_LEN_ERROR_FRAMES_L     0x11978
 #define WX_RX_UNDERSIZE_FRAMES_GOOD  0x11938
 #define WX_RX_OVERSIZE_FRAMES_GOOD   0x1193C
-#define WX_MAC_LXONOFFRXC            0x11E0C
+#define WX_MAC_LXOFFRXC              0x11988
+#define WX_MAC_LXONRXC               0x11E0C
+#define WX_MAC_LXOFFRXC_AML          0x11F80
+#define WX_MAC_LXONRXC_AML           0x11F84
 
 /*********************** Receive DMA registers **************************/
 #define WX_RDM_VF_RE(_i)             (0x12004 + ((_i) * 4))
@@ -1148,9 +1151,18 @@ enum wx_isb_idx {
 	WX_ISB_MAX
 };
 
+/* Flow Control Settings */
+enum wx_fc_mode {
+	wx_fc_none = 0,
+	wx_fc_rx_pause,
+	wx_fc_tx_pause,
+	wx_fc_full
+};
+
 struct wx_fc_info {
 	u32 high_water; /* Flow Ctrl High-water */
 	u32 low_water; /* Flow Ctrl Low-water */
+	enum wx_fc_mode mode; /* Flow Control Mode */
 };
 
 /* Statistics counters collected by the MAC */
@@ -1167,7 +1179,8 @@ struct wx_hw_stats {
 	u64 mptc;
 	u64 roc;
 	u64 ruc;
-	u64 lxonoffrxc;
+	u64 lxonrxc;
+	u64 lxoffrxc;
 	u64 lxontxc;
 	u64 lxofftxc;
 	u64 o2bgptc;
@@ -1184,6 +1197,8 @@ struct wx_hw_stats {
 
 struct wx_last_stats {
 	u32 qmprc[128];
+	u32 lxoffrxc;
+	u32 lxonrxc;
 };
 
 enum wx_state {
-- 
2.48.1


