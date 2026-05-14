Return-Path: <netdev+bounces-287910-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPn7I3mlBWppZQIAu9opvQ
	(envelope-from <netdev+bounces-287910-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:35:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9B554070A
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10FB93017251
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 10:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2E937998C;
	Thu, 14 May 2026 10:34:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6680036F909
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 10:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778754868; cv=none; b=h0g4XZp2F6rURYh9QAMEOpSHTg5hGgDZOHWC4gNxsL+BrZW8KRQOotFhcs1EWoKqJkzNGde8WV4my6qamik5KZW3594wjTjAQI6NGCkntojV0+ax7H7Y1TM/lKIf+/2ITD0nklbGFwjd+R3xecYrbv4Jji/jWXBxtEyOW0vWQF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778754868; c=relaxed/simple;
	bh=9RkugBgjjNFxSgYQgwQY3TEjr1ihrnm3Sgqnhh7vr+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bp71bW+O/TmPJ5097Pj5RJUzQSB8UMXVlENaX1UCR9RAEGDoDblhCoDCFsMzlUGKxeEGDNYuhHzDoW410GGTPMpD1qbopHhU/idP+kv0+Vl6qYTURD1fr+61PZqFEsKKkoNgdVQIAkdN4mPlj2rS5qlrMCDDR13KL1+xprRFadc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: esmtpgz12t1778754856td38f43df
X-QQ-Originating-IP: +eb7q14dPlOA1x3iiW+g8bX7q2mS/B1H8UPB5y9x2Do=
Received: from localhost.localdomain ( [115.227.149.194])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 14 May 2026 18:34:16 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 13453335272729385309
EX-QQ-RecipientCnt: 4
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next 3/3] net: libwx: support vf hardware statistics
Date: Thu, 14 May 2026 18:34:05 +0800
Message-Id: <20260514103405.42175-4-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20260514103405.42175-1-mengyuanlou@net-swift.com>
References: <20260514103405.42175-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MDo0YgvfYJuR5RxmdvntkZz1cgM0HjGvVk7582QFZFA2qfCAHnob8KbQ
	AVMrG3HvYpGQrhbje4ZW62O+YYGJTb0KfjipbQcdwPTOba/PYTttTNSQC12VX5fDf9BygjJ
	jNVE3XEsQ7vO+hVewbh2OVuYNCLHRjiYVJp8ztgY2FkULDG1eT3+cfs1UhPDEYrpsBG5c13
	QDj8iH+z5hJhaE66WSBInJ0SwhbK10fH6LtOG93SXNyWjyK2UPVHcB64/FEbMCzgseK5L9X
	sc3lAnScmjvfD5iipJJR6oWkyFOntiz2lstlGJMJGa50i9b0oEChp9B0gRkVzJcDV2H8rdK
	cwoFnLdfIupfLsz4HvCjSkX6QzXrRkxQUoRosGo6UMQuXowKOkTCOScSk1GzkE4Pfydv1jE
	hW1A5WvLlSJa92k6JABhSZYGIkRXeXsL3h9EaZBMbb5Pffyklsx4ekBRM0aOjuGyU2uxS2e
	5hWcXbUwnhcEd8AiTU16KZCTOHEXD2ayInJ0B2K/odDKY5lAzW6W/AKssvUaCgOMlrHTrcU
	SnuuB6n0S6m1lShuZamPfiKc7Msk1xUfhm9ugd8rGrNy4KCFiqY8jhnD8S49PY1jJmD1Jne
	hbmrA5rqAgSXg2JHh6/LBOW3ibNQe6hviIPrlH6e3EewYLG9Nj9PMyUL5otLud6sX8sCagZ
	72fWeX8I4qy4f7nBBZbZQeUEAZSTmbzivgHiRe6O81zomUTiNeK45Z8lkcvCTKaCM0zUngG
	OiXJqfxZV8c89ap8YTZJr6ihdGRCYXjqXbNeHkHKnlA92sA0e+k7nWLVbEGBLIvOC+F2zcg
	k3RbL6XQo/TjMr1a2+f1Hv/X3uqnK+X99TUQfy5DnItdMe/roFf4cAl4CsJ22Wzq+6tZOL4
	oifLcA13mtosX/jJoPC2XC+TVYIuPxU6vefTfVjzKioDfQh2JdzINbx/MNaaOMMWlR+lc/r
	hd0ulWyBYS0JMo9FcRCG8q5aQi+WQyA5AReYviFPrHiXsk38XoxGUN/rzGDWtCopkFjlTmV
	fCZ3xB64gfdW2jksQAM5Y4o/xsK5sCYlKxhdyWPZ7IK4EQDzCiA3/QeDJU3OXDc0qm/dkAM
	vyNLBn3eq/bbTV88dSCR5QJ36yU6SF100gDA5ejKtOcyanPNYrPgoEPEYbwNYH1knmkNqMu
	pE4970jNlumm8TDTx+ZvEmZKtA==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 1B9B554070A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[net-swift.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287910-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mengyuanlou@net-swift.com,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.966];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[net-swift.com:email,net-swift.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add support to show hardware statistics for ethtool -S ethx.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 35 +++++++--
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 75 ++++++++++---------
 .../net/ethernet/wangxun/libwx/wx_vf_common.c |  3 +
 3 files changed, 70 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index ab8796ea6535..6380074e23dd 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -48,6 +48,14 @@ static const struct wx_stats wx_gstrings_stats[] = {
 	WX_STAT("rx_hwtstamp_cleared", rx_hwtstamp_cleared),
 };
 
+static const struct wx_stats wx_gstrings_stats_vf[] = {
+	WX_STAT("tx_busy", tx_busy),
+	WX_STAT("non_eop_descs", non_eop_descs),
+	WX_STAT("rx_csum_offload_good_count", hw_csum_rx_good),
+	WX_STAT("rx_csum_offload_errors", hw_csum_rx_error),
+	WX_STAT("alloc_rx_buff_failed", alloc_rx_buff_failed),
+};
+
 static const struct wx_stats wx_gstrings_fdir_stats[] = {
 	WX_STAT("fdir_match", stats.fdirmatch),
 	WX_STAT("fdir_miss", stats.fdirmiss),
@@ -69,7 +77,9 @@ static const struct wx_stats wx_gstrings_rsc_stats[] = {
 #define WX_QUEUE_STATS_LEN ( \
 		(WX_NUM_TX_QUEUES + WX_NUM_RX_QUEUES) * \
 		(sizeof(struct wx_queue_stats) / sizeof(u64)))
-#define WX_GLOBAL_STATS_LEN  ARRAY_SIZE(wx_gstrings_stats)
+#define WX_GLOBAL_STATS_LEN (wx->pdev->is_virtfn ? \
+		ARRAY_SIZE(wx_gstrings_stats_vf) : \
+		ARRAY_SIZE(wx_gstrings_stats))
 #define WX_FDIR_STATS_LEN  ARRAY_SIZE(wx_gstrings_fdir_stats)
 #define WX_RSC_STATS_LEN  ARRAY_SIZE(wx_gstrings_rsc_stats)
 #define WX_STATS_LEN (WX_GLOBAL_STATS_LEN + WX_QUEUE_STATS_LEN)
@@ -101,7 +111,10 @@ void wx_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 	switch (stringset) {
 	case ETH_SS_STATS:
 		for (i = 0; i < WX_GLOBAL_STATS_LEN; i++)
-			ethtool_puts(&p, wx_gstrings_stats[i].stat_string);
+			if (wx->pdev->is_virtfn)
+				ethtool_puts(&p, wx_gstrings_stats_vf[i].stat_string);
+			else
+				ethtool_puts(&p, wx_gstrings_stats[i].stat_string);
 		if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags)) {
 			for (i = 0; i < WX_FDIR_STATS_LEN; i++)
 				ethtool_puts(&p, wx_gstrings_fdir_stats[i].stat_string);
@@ -135,9 +148,15 @@ void wx_get_ethtool_stats(struct net_device *netdev,
 	wx_update_stats(wx);
 
 	for (i = 0; i < WX_GLOBAL_STATS_LEN; i++) {
-		p = (char *)wx + wx_gstrings_stats[i].stat_offset;
-		data[i] = (wx_gstrings_stats[i].sizeof_stat ==
-			   sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
+		if (wx->pdev->is_virtfn) {
+			p = (char *)wx + wx_gstrings_stats_vf[i].stat_offset;
+			data[i] = (wx_gstrings_stats_vf[i].sizeof_stat ==
+				   sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
+		} else {
+			p = (char *)wx + wx_gstrings_stats[i].stat_offset;
+			data[i] = (wx_gstrings_stats[i].sizeof_stat ==
+				   sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
+		}
 	}
 
 	if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags)) {
@@ -219,9 +238,10 @@ EXPORT_SYMBOL(wx_get_pause_stats);
 
 void wx_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *info)
 {
-	unsigned int stats_len = WX_STATS_LEN;
 	struct wx *wx = netdev_priv(netdev);
+	unsigned int stats_len;
 
+	stats_len = WX_STATS_LEN;
 	if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags))
 		stats_len += WX_FDIR_STATS_LEN;
 
@@ -851,6 +871,9 @@ static const struct ethtool_ops wx_ethtool_ops_vf = {
 	.set_coalesce		= wx_set_coalesce,
 	.get_ts_info		= ethtool_op_get_ts_info,
 	.get_link_ksettings	= wx_get_link_ksettings_vf,
+	.get_sset_count		= wx_get_sset_count,
+	.get_strings		= wx_get_strings,
+	.get_ethtool_stats	= wx_get_ethtool_stats,
 };
 
 void wx_set_ethtool_ops_vf(struct net_device *netdev)
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 2451f6b20b11..7244aee3fc74 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -2916,45 +2916,46 @@ void wx_update_stats(struct wx *wx)
 	wx->restart_queue = restart_queue;
 	wx->tx_busy = tx_busy;
 
-	wx_update_xoff_rx_lfc(wx);
-
-	hwstats->gprc += rd32(wx, WX_RDM_PKT_CNT);
-	hwstats->gptc += rd32(wx, WX_TDM_PKT_CNT);
-	hwstats->gorc += rd64(wx, WX_RDM_BYTE_CNT_LSB);
-	hwstats->gotc += rd64(wx, WX_TDM_BYTE_CNT_LSB);
-	hwstats->tpr += rd64(wx, WX_RX_FRAME_CNT_GOOD_BAD_L);
-	hwstats->tpt += rd64(wx, WX_TX_FRAME_CNT_GOOD_BAD_L);
-	hwstats->crcerrs += rd64(wx, WX_RX_CRC_ERROR_FRAMES_L);
-	hwstats->rlec += rd64(wx, WX_RX_LEN_ERROR_FRAMES_L);
-	hwstats->bprc += rd64(wx, WX_RX_BC_FRAMES_GOOD_L);
-	hwstats->bptc += rd64(wx, WX_TX_BC_FRAMES_GOOD_L);
-	hwstats->mprc += rd64(wx, WX_RX_MC_FRAMES_GOOD_L);
-	hwstats->mptc += rd64(wx, WX_TX_MC_FRAMES_GOOD_L);
-	hwstats->roc += rd32(wx, WX_RX_OVERSIZE_FRAMES_GOOD);
-	hwstats->ruc += rd32(wx, WX_RX_UNDERSIZE_FRAMES_GOOD);
-	if (wx->mac.type >= wx_mac_aml)
-		hwstats->lxonrxc += rd32_wrap(wx, WX_MAC_LXONRXC_AML,
-					      &wx->last_stats.lxonrxc);
-	else
-		hwstats->lxonrxc += rd32(wx, WX_MAC_LXONRXC);
-	hwstats->lxontxc += rd32(wx, WX_RDB_LXONTXC);
-	hwstats->lxofftxc += rd32(wx, WX_RDB_LXOFFTXC);
-	hwstats->o2bgptc += rd32(wx, WX_TDM_OS2BMC_CNT);
-	hwstats->b2ospc += rd32(wx, WX_MNG_BMC2OS_CNT);
-	hwstats->o2bspc += rd32(wx, WX_MNG_OS2BMC_CNT);
-	hwstats->b2ogprc += rd32(wx, WX_RDM_BMC2OS_CNT);
-	hwstats->rdmdrop += rd32(wx, WX_RDM_DRP_PKT);
+	if (wx->pdev->is_physfn) {
+		wx_update_xoff_rx_lfc(wx);
+
+		hwstats->gprc += rd32(wx, WX_RDM_PKT_CNT);
+		hwstats->gptc += rd32(wx, WX_TDM_PKT_CNT);
+		hwstats->gorc += rd64(wx, WX_RDM_BYTE_CNT_LSB);
+		hwstats->gotc += rd64(wx, WX_TDM_BYTE_CNT_LSB);
+		hwstats->tpr += rd64(wx, WX_RX_FRAME_CNT_GOOD_BAD_L);
+		hwstats->tpt += rd64(wx, WX_TX_FRAME_CNT_GOOD_BAD_L);
+		hwstats->crcerrs += rd64(wx, WX_RX_CRC_ERROR_FRAMES_L);
+		hwstats->rlec += rd64(wx, WX_RX_LEN_ERROR_FRAMES_L);
+		hwstats->bprc += rd64(wx, WX_RX_BC_FRAMES_GOOD_L);
+		hwstats->bptc += rd64(wx, WX_TX_BC_FRAMES_GOOD_L);
+		hwstats->mprc += rd64(wx, WX_RX_MC_FRAMES_GOOD_L);
+		hwstats->mptc += rd64(wx, WX_TX_MC_FRAMES_GOOD_L);
+		hwstats->roc += rd32(wx, WX_RX_OVERSIZE_FRAMES_GOOD);
+		hwstats->ruc += rd32(wx, WX_RX_UNDERSIZE_FRAMES_GOOD);
+		if (wx->mac.type >= wx_mac_aml)
+			hwstats->lxonrxc += rd32_wrap(wx, WX_MAC_LXONRXC_AML,
+						&wx->last_stats.lxonrxc);
+		else
+			hwstats->lxonrxc += rd32(wx, WX_MAC_LXONRXC);
+		hwstats->lxontxc += rd32(wx, WX_RDB_LXONTXC);
+		hwstats->lxofftxc += rd32(wx, WX_RDB_LXOFFTXC);
+		hwstats->o2bgptc += rd32(wx, WX_TDM_OS2BMC_CNT);
+		hwstats->b2ospc += rd32(wx, WX_MNG_BMC2OS_CNT);
+		hwstats->o2bspc += rd32(wx, WX_MNG_OS2BMC_CNT);
+		hwstats->b2ogprc += rd32(wx, WX_RDM_BMC2OS_CNT);
+		hwstats->rdmdrop += rd32(wx, WX_RDM_DRP_PKT);
+
+		if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags)) {
+			hwstats->fdirmatch += rd32(wx, WX_RDB_FDIR_MATCH);
+			hwstats->fdirmiss += rd32(wx, WX_RDB_FDIR_MISS);
+		}
 
-	if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags)) {
-		hwstats->fdirmatch += rd32(wx, WX_RDB_FDIR_MATCH);
-		hwstats->fdirmiss += rd32(wx, WX_RDB_FDIR_MISS);
+		for (i = wx->num_vfs * wx->num_rx_queues_per_pool;
+		     i < wx->mac.max_rx_queues; i++)
+			hwstats->qmprc += rd32_wrap(wx, WX_PX_MPRC(i),
+						&wx->last_stats.qmprc[i]);
 	}
-
-	for (i = wx->num_vfs * wx->num_rx_queues_per_pool;
-	     i < wx->mac.max_rx_queues; i++)
-		hwstats->qmprc += rd32_wrap(wx, WX_PX_MPRC(i),
-					    &wx->last_stats.qmprc[i]);
-
 	spin_unlock(&wx->hw_stats_lock);
 }
 EXPORT_SYMBOL(wx_update_stats);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
index a3361696b783..6ac1a523ce08 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
@@ -5,6 +5,7 @@
 #include <linux/pci.h>
 
 #include "wx_type.h"
+#include "wx_hw.h"
 #include "wx_mbx.h"
 #include "wx_lib.h"
 #include "wx_vf.h"
@@ -332,6 +333,7 @@ void wxvf_down(struct wx *wx)
 	netif_tx_disable(netdev);
 	netif_carrier_off(netdev);
 	wx_napi_disable_all(wx);
+	wx_update_stats(wx);
 	wx_reset_vf(wx);
 
 	wx_clean_all_tx_rings(wx);
@@ -405,6 +407,7 @@ static void wxvf_service_task(struct work_struct *work)
 
 	wxvf_link_config_subtask(wx);
 	wxvf_reset_subtask(wx);
+	wx_update_stats(wx);
 	wx_service_event_complete(wx);
 }
 
-- 
2.50.1 (Apple Git-155)


