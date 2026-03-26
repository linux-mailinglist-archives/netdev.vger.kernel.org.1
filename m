Return-Path: <netdev+bounces-271807-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMh/FT2YxGkk1QQAu9opvQ
	(envelope-from <netdev+bounces-271807-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 03:21:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C288432E564
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 03:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CE3B300BC85
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 02:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB8637F8AD;
	Thu, 26 Mar 2026 02:17:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58A42116F6
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 02:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774491462; cv=none; b=SBn100E2SVAq+cauRqEG4AelLKyyNX5EakmzxRDWDTVQr289Lq8L39a4cVyNvTnepGY8grQtoZTwcDUjtVPwj6qqR+JbTBjkrIVIF+wECspM2s7GHnY+wLuBeuPSzSVYNgcZZfaP/gntzEp2EwPJxBcT/HJoyvg1uoK3SMQH+oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774491462; c=relaxed/simple;
	bh=6UnVheaexUHoIUCUZg7fVg1nnIhqbeJ2u8gvPc4xZSM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vBjwTxrykD7UXk6SBiObrg1pKI5eh40MlC2/lqVZj2rbTF9XyAUB74WeBp4S5gNpiOsm0vvbM98drWw1yuEiQTIZ4xUAdtg0vN3imdQOD4ILjDqwEcZ6iTrRCOdEj52nck9eRdQUH8SOxX86JYSv8p2z74GE9AtdGPd/Wv/VMzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz11t1774491344t66de6181
X-QQ-Originating-IP: fxd5+fCJQsSzxTb7Z7Gajv/JG0pKxM4WJ1jZprnP9Q0=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.60.44])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 26 Mar 2026 10:15:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7126546818717435921
EX-QQ-RecipientCnt: 18
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
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
Subject: [PATCH net-next v6 10/11] net: wangxun: improve flow control setting
Date: Thu, 26 Mar 2026 10:14:05 +0800
Message-Id: <20260326021406.30444-11-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260326021406.30444-1-jiawenwu@trustnetic.com>
References: <20260326021406.30444-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NGjsA6rwgPvymaDFfDIEsPlo2B0VBdWA43nkbShPPZa7TTgT+Zbnz2wo
	gk5j5sgef1wx5OGagbIF1wH1lpidcbBkZDTjzu5Bm6pxHh1ExRaP0gQ8JFDxhHX1WoYS5hB
	xN4+VEZhruFN2VBB8w8FDadt18mnALv2MIrpOWb9oXzJucJ5dn6DBPqHQuQl4cAXE5zXExa
	bA7ZwMexc6LUtRhpr2m9ydvDpg9uAQ3bIZUDYQg+aq39jh6GDpp7cN3f1W1Ffj0pVSOi+gM
	VJ639DOyTjQjDyW07adZ7pd9efRcWIbVE/1kaSW2tsoa0mXR/LfdGh8GKCGBXgPeOF6wJ0s
	m965j9BssIhBG/zGtjxFolhdN5j4whYDXOPh1OkCnYe1g5F1fm3Gk65mhc9wRsJem85RmIa
	Sg53X57MuNK6I/Bd+kZxm7mUdlGTmJ8Pl5UkHsrDN7cch7fllvuJ1T0tXGgjOAl2j/29BuV
	5ao3+T9Jf6QUT0FDW74XCOkEvxc5WzOVQqb+B9TOWN08Ejus1yiT+3mAAZ1h2pQwTBqKfYw
	zNgvvBCNy/37G5mkg6Smw0ISc7VxyLWxPmvnovdlTQ+MAXsto59749xOJDFcNPdwOZb5XlD
	XVaK+IKBnMGlSfs3KclOmkgW0m+Ilzio2BCbSudXRVcyb7dcpPY0/dxkSGM+Fos4LC9fTnW
	2FBcqNrhGMuGEDqrG87FegyQwW2q0dl+OGn4/FvsKx6+rWb17cYLozF4dmQYE9mvMVqPfnm
	4BczL5gDjTL69tjWs1Yg4DytT10kG114HFnEjuB/FhKXCtgbr2imXdTFcmQuxCtB6JMoIn0
	JdHwiDA309rwqA5hTjLXogkXkvLLuQheL3pi6Wy8Tgvh53ORgLry8GndVXh3jF+yZjv7/s6
	Gem8fQgYwE2HbI3o/VIejnMEfzb53q8ki6zRDejOeqQ0V8LlNs65Yz9HfzD1ULkEiXcXBQc
	Fb0AnL6br/CnjNoquKSUGLmWToAHu25GzbFHJZRDQIXXapgHhylMHMRW0EczfLkeOIInJVJ
	fumuwzRwWZwohgAfiAlAbPjRdG3y3UYeXmIY1YLfMfCey02JSs5SdO1JchXL8OqmQ1YtA5O
	BL+lmsm+Wjq1077XeBp4EFa+3n8/+WaT3qhxPw6b4BD
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271807-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,linux.intel.com,intel.com,dama.to,debian.org,trustnetic.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,trustnetic.com:email,trustnetic.com:mid]
X-Rspamd-Queue-Id: C288432E564
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Save the current mode of flow control, check the pause frame statistics
in watchdog to clear WX_HANG_CHECK_ARMED.

The received pause frames are divided into XON and XOFF to be counted.
And due to the hardware defect of SP devices, XON packets cannot be
trasmitted correctly, so Tx XON pause is disabled by default for those
devices.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |  2 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 52 +++++++++++++++++--
 drivers/net/ethernet/wangxun/libwx/wx_type.h  | 16 +++++-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  3 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  3 +-
 5 files changed, 66 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 9ab7dce956e3..d1356ff5d69b 100644
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
index 2f71dc24306d..4e0195f7df39 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -2772,6 +2772,15 @@ int wx_fc_enable(struct wx *wx, bool tx_pause, bool rx_pause)
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
@@ -2790,7 +2799,9 @@ int wx_fc_enable(struct wx *wx, bool tx_pause, bool rx_pause)
 
 	/* Set up and enable Rx high/low water mark thresholds, enable XON. */
 	if (tx_pause && wx->fc.high_water) {
-		fcrtl = (wx->fc.low_water << 10) | WX_RDB_RFCL_XONE;
+		fcrtl = (wx->fc.low_water << 10);
+		if (wx->mac.type != wx_mac_sp)
+			fcrtl |= WX_RDB_RFCL_XONE;
 		wr32(wx, WX_RDB_RFCL, fcrtl);
 		fcrth = (wx->fc.high_water << 10) | WX_RDB_RFCH_XOFFE;
 	} else {
@@ -2831,6 +2842,28 @@ int wx_fc_enable(struct wx *wx, bool tx_pause, bool rx_pause)
 }
 EXPORT_SYMBOL(wx_fc_enable);
 
+static void wx_update_xoff_rx_lfc(struct wx *wx)
+{
+	struct wx_hw_stats *hwstats = &wx->stats;
+	u64 data;
+	int i;
+
+	if (wx->fc.mode != wx_fc_full &&
+	    wx->fc.mode != wx_fc_rx_pause)
+		return;
+
+	data = rd64(wx, WX_MAC_LXOFFRXC);
+	hwstats->lxoffrxc += data;
+
+	/* refill credits (no tx hang) if we received xoff */
+	if (!data)
+		return;
+
+	for (i = 0; i < wx->num_tx_queues; i++)
+		clear_bit(WX_HANG_CHECK_ARMED,
+			  wx->tx_ring[i]->state);
+}
+
 /**
  * wx_update_stats - Update the board statistics counters.
  * @wx: board private structure
@@ -2844,6 +2877,10 @@ void wx_update_stats(struct wx *wx)
 	u64 restart_queue = 0, tx_busy = 0;
 	u32 i;
 
+	if (!netif_running(wx->netdev) ||
+	    test_bit(WX_STATE_RESETTING, wx->state))
+		return;
+
 	/* gather some stats to the wx struct that are per queue */
 	for (i = 0; i < wx->num_rx_queues; i++) {
 		struct wx_ring *rx_ring = wx->rx_ring[i];
@@ -2879,6 +2916,8 @@ void wx_update_stats(struct wx *wx)
 	wx->restart_queue = restart_queue;
 	wx->tx_busy = tx_busy;
 
+	wx_update_xoff_rx_lfc(wx);
+
 	hwstats->gprc += rd32(wx, WX_RDM_PKT_CNT);
 	hwstats->gptc += rd32(wx, WX_TDM_PKT_CNT);
 	hwstats->gorc += rd64(wx, WX_RDM_BYTE_CNT_LSB);
@@ -2893,7 +2932,10 @@ void wx_update_stats(struct wx *wx)
 	hwstats->mptc += rd64(wx, WX_TX_MC_FRAMES_GOOD_L);
 	hwstats->roc += rd32(wx, WX_RX_OVERSIZE_FRAMES_GOOD);
 	hwstats->ruc += rd32(wx, WX_RX_UNDERSIZE_FRAMES_GOOD);
-	hwstats->lxonoffrxc += rd32(wx, WX_MAC_LXONOFFRXC);
+	if (wx->mac.type >= wx_mac_aml)
+		hwstats->lxonrxc = rd32(wx, WX_MAC_LXONRXC_AML);
+	else
+		hwstats->lxonrxc += rd32(wx, WX_MAC_LXONRXC);
 	hwstats->lxontxc += rd32(wx, WX_RDB_LXONTXC);
 	hwstats->lxofftxc += rd32(wx, WX_RDB_LXOFFTXC);
 	hwstats->o2bgptc += rd32(wx, WX_TDM_OS2BMC_CNT);
@@ -2946,7 +2988,11 @@ void wx_clear_hw_cntrs(struct wx *wx)
 	rd64(wx, WX_RX_LEN_ERROR_FRAMES_L);
 	rd32(wx, WX_RDB_LXONTXC);
 	rd32(wx, WX_RDB_LXOFFTXC);
-	rd32(wx, WX_MAC_LXONOFFRXC);
+	if (wx->mac.type >= wx_mac_aml)
+		wr32(wx, WX_MAC_LXONRXC_AML, 0);
+	else
+		rd32(wx, WX_MAC_LXONRXC);
+	rd32(wx, WX_MAC_LXOFFRXC);
 }
 EXPORT_SYMBOL(wx_clear_hw_cntrs);
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 434a582393d7..510fab4b3a0f 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -79,7 +79,9 @@
 #define WX_RX_LEN_ERROR_FRAMES_L     0x11978
 #define WX_RX_UNDERSIZE_FRAMES_GOOD  0x11938
 #define WX_RX_OVERSIZE_FRAMES_GOOD   0x1193C
-#define WX_MAC_LXONOFFRXC            0x11E0C
+#define WX_MAC_LXOFFRXC              0x11988
+#define WX_MAC_LXONRXC               0x11E0C
+#define WX_MAC_LXONRXC_AML           0x11F84
 
 /*********************** Receive DMA registers **************************/
 #define WX_RDM_VF_RE(_i)             (0x12004 + ((_i) * 4))
@@ -1156,9 +1158,18 @@ enum wx_isb_idx {
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
@@ -1175,7 +1186,8 @@ struct wx_hw_stats {
 	u64 mptc;
 	u64 roc;
 	u64 ruc;
-	u64 lxonoffrxc;
+	u64 lxonrxc;
+	u64 lxoffrxc;
 	u64 lxontxc;
 	u64 lxofftxc;
 	u64 o2bgptc;
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index b8db772c37c5..080310a51ef8 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -150,6 +150,7 @@ static void ngbe_service_task(struct work_struct *work)
 	struct wx *wx = container_of(work, struct wx, service_task);
 
 	wx_handle_errors_subtask(wx);
+	wx_update_stats(wx);
 
 	wx_service_event_complete(wx);
 }
@@ -401,8 +402,6 @@ static void ngbe_disable_device(struct wx *wx)
 
 		wr32(wx, WX_PX_TR_CFG(reg_idx), WX_PX_TR_CFG_SWFLSH);
 	}
-
-	wx_update_stats(wx);
 }
 
 static void ngbe_reset(struct wx *wx)
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index d4f87fbb9565..e9439e4ebe61 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -132,6 +132,7 @@ static void txgbe_service_task(struct work_struct *work)
 	wx_handle_errors_subtask(wx);
 	txgbe_module_detection_subtask(wx);
 	txgbe_link_config_subtask(wx);
+	wx_update_stats(wx);
 
 	wx_service_event_complete(wx);
 }
@@ -261,8 +262,6 @@ static void txgbe_disable_device(struct wx *wx)
 
 	/* Disable the Tx DMA engine */
 	wr32m(wx, WX_TDM_CTL, WX_TDM_CTL_TE, 0);
-
-	wx_update_stats(wx);
 }
 
 void txgbe_down(struct wx *wx)
-- 
2.48.1


