Return-Path: <netdev+bounces-299395-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 97VLANfYL2qJHwUAu9opvQ
	(envelope-from <netdev+bounces-299395-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 12:49:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DF368579E
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 12:49:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299395-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299395-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 922A1301626C
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 10:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C6D33262A;
	Mon, 15 Jun 2026 10:49:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ED1309DB1
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 10:49:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781520581; cv=none; b=f0U1RcBVuoH5Lhqk+LY3KtI2jRu3FOiXWZvHQYZ93GCBdbRuR/U1zI5G6MNiwl+/WHdZurHpYvKlANkuJpF7UWmFTDxD2qoXP6lDgIAm/96Gyxa5/v/f+UPe/VXPxaXnYYXM7izeZW443nv3GkfGWbx/qachzmoxAjSSUA5lPmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781520581; c=relaxed/simple;
	bh=oClq9joEFN9YdwhUiAV4YyU6TlmQI1V9SXgvORg1Lhw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q169S8iCItud1HM66LfOpRWIL4BHrkkIkyQiJiYkvIxlP5/+GE+EKBzyxEB0ah0MCaP3teesYzNbidq5oAHO84u7E/MCmn0CVDYRWHVbTd9KWZSd3H3nD3NhxK3+cJlkLaeB5/z23wCkcmP4V6s3vZeiKo3n+lllezIrcg4sDDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.206.34.216
X-QQ-mid: esmtpsz19t1781520539tb46e1a11
X-QQ-Originating-IP: xkcMglleC3Nz9npszMHZHKTVSzmrE+3FW2OPm3oU0O8=
Received: from localhost.localdomain ( [183.157.22.210])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 15 Jun 2026 18:48:58 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13065718457049212845
EX-QQ-RecipientCnt: 7
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	horms@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v5 3/3] net: libwx: support vf per-queue statistics via ethtool -S
Date: Mon, 15 Jun 2026 18:48:49 +0800
Message-Id: <20260615104849.60444-4-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20260615104849.60444-1-mengyuanlou@net-swift.com>
References: <20260615104849.60444-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: Nn63v61n7E7W8tPtGXV1vXu+uXIp/jihCr//iUR9uaFDls6XC4stdGon
	9Ytf9QwynCl/bGm+qSJ5EAjsr6/+eu9+t0rkczZKR62RXo4fCJs1bytNZiXiqZ+/OzkArWP
	Db74of5ps+vtTJ0khaaR53F4qf1maHsGMy+ArhP/5/6GYtaywpsHl+Ae1HRPLAp6Lma9Fd5
	G8upPwtstBU/NUuIo2fr+4tiEBM7HV4KbBNJ+0u2bLBmGk9GJ1utTUqb4etlBKdY+zQYSVF
	J3JPY3jwEbRsBQK0EcfNuLOKnkaB2IfFJnMAjF5g/CzRnoSSXyGSpobNjdr+5FiUwtdJqQy
	7LIM6hUALGyVpTndBCCq9Sl1SpWcOfuJ/T8DVnKOK89gz8+N0IvejUEcb8j30pdpYzUoQKB
	gUfQkRQpp9/DyLjG4SC3XiTVyJp9+5czAn/o66SewXzK+nWr4KUzataiuhQ8TQeF0oazthI
	Q/WQg+H2xlVmQP0qoTHQQzPnO0EtKT3YIZGrf3Ifhd+FGAjZBO9QIMIKn6We9sXIN00vinE
	Ea5iJHduAj2kUtYGrfdgabQhcoJ6vCC8shDhhMXvr4YgRynUPVK9sMxF5Oy4pgUvStXrhgy
	RpC/7g/MMWfbA4RjH1I7ZJrrIRQWv/GgWvY9laCv4ypyesiRIL49EWiObTFm7hoIgPefwVD
	nOuzfYpMkFxUwhJIfbv4lzBqbNQQFhNFLGLL40CRBE/cnAL9K6qjVds95pd54s7dMLKsu/w
	OGpGBYmfylzSWFm2NgDvYgX7aDp7UNbv/0wVSrEL5qdy26NglI56KenvPfhNHuPd1hFXpkM
	305X04Hf/53gCI1WdDmwX34R6Sol+sD6epjq37jTuCjv7qTCO96+wyNt1zDv5OvPZWyzaH/
	D9nkS9ZKH08SqgdI7bbxY8ZIy/wYUgLig6mms37X1+knlrDjugGp/DCT/302JemIKaBdd4B
	MDSOia2TdEXMBN4wX4qKhD3nSw8RslZ9KiHR/ImORIgGnzkQhhjLgnUkisOHFs2ol0/5u01
	XsqI6v1IYkb7HVfUNJ6plLt7owlhwvJYFLE04DRiIZUpnd4l4XCBEw/m2CGK4ngR0BxsYwx
	l02+SZtWIZh0LoVW21Ho+ks8Xk/1ljVzNNCNCQI7O08G7e2nyxOeHejOH/oS9WGasuPmml7
	NAfUIeiDCRvX2l/qxLqJHHykEYZE0s/s5Gz8
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299395-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[net-swift.com];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:jiawenwu@trustnetic.com,m:duanqiangwen@net-swift.com,m:horms@kernel.org,m:kuba@kernel.org,m:pabeni@redhat.com,m:mengyuanlou@net-swift.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mengyuanlou@net-swift.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mengyuanlou@net-swift.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 44DF368579E

Add per-queue TX/RX packet and byte counters to the VF ethtool stats
table.
Convert WX_NUM_{RX,TX}_QUEUES macros to take explicit netdev parameter.
Then replace both WX_GLOBAL_STATS_LEN and WX_STATS_LEN macros with
type-safe static helpers wx_global_stats_len() and wx_stats_len().
The stats length is now dynamically determined based on whether the
device is a VF or PF via wx_stats_len().

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 71 +++++++++++++------
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  4 ++
 .../net/ethernet/wangxun/libwx/wx_vf_common.c |  2 +
 3 files changed, 56 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 30c6ef6103ac..d8b7576fbfaa 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -48,6 +48,10 @@ static const struct wx_stats wx_gstrings_stats[] = {
 	WX_STAT("rx_hwtstamp_cleared", rx_hwtstamp_cleared),
 };
 
+static const struct wx_stats wx_gstrings_stats_vf[] = {
+	WX_STAT("non_eop_descs", non_eop_descs),
+};
+
 static const struct wx_stats wx_gstrings_fdir_stats[] = {
 	WX_STAT("fdir_match", stats.fdirmatch),
 	WX_STAT("fdir_miss", stats.fdirmiss),
@@ -63,21 +67,33 @@ static const struct wx_stats wx_gstrings_rsc_stats[] = {
  * used because we do not have a good way to get the max number of
  * rx queues with CONFIG_RPS disabled.
  */
-#define WX_NUM_RX_QUEUES netdev->num_tx_queues
-#define WX_NUM_TX_QUEUES netdev->num_tx_queues
-
-#define WX_QUEUE_STATS_LEN ( \
-		(WX_NUM_TX_QUEUES + WX_NUM_RX_QUEUES) * \
-		(sizeof(struct wx_queue_stats) / sizeof(u64)))
-#define WX_GLOBAL_STATS_LEN  ARRAY_SIZE(wx_gstrings_stats)
+#define WX_NUM_RX_QUEUES(netdev) ((netdev)->num_tx_queues)
+#define WX_NUM_TX_QUEUES(netdev) ((netdev)->num_tx_queues)
 #define WX_FDIR_STATS_LEN  ARRAY_SIZE(wx_gstrings_fdir_stats)
 #define WX_RSC_STATS_LEN  ARRAY_SIZE(wx_gstrings_rsc_stats)
-#define WX_STATS_LEN (WX_GLOBAL_STATS_LEN + WX_QUEUE_STATS_LEN)
+
+static unsigned int wx_global_stats_len(const struct wx *wx)
+{
+	return wx->pdev->is_virtfn ?
+	       ARRAY_SIZE(wx_gstrings_stats_vf) : ARRAY_SIZE(wx_gstrings_stats);
+}
+
+static unsigned int wx_stats_len(const struct wx *wx)
+{
+	struct net_device *netdev = wx->netdev;
+	unsigned int queue_stats_len;
+
+	queue_stats_len = (WX_NUM_TX_QUEUES(netdev) +
+			   WX_NUM_RX_QUEUES(netdev)) *
+			  (sizeof(struct wx_queue_stats) / sizeof(u64));
+
+	return wx_global_stats_len(wx) + queue_stats_len;
+}
 
 int wx_get_sset_count(struct net_device *netdev, int sset)
 {
 	struct wx *wx = netdev_priv(netdev);
-	int len = WX_STATS_LEN;
+	int len = wx_stats_len(wx);
 
 	switch (sset) {
 	case ETH_SS_STATS:
@@ -100,8 +116,11 @@ void wx_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 
 	switch (stringset) {
 	case ETH_SS_STATS:
-		for (i = 0; i < WX_GLOBAL_STATS_LEN; i++)
-			ethtool_puts(&p, wx_gstrings_stats[i].stat_string);
+		for (i = 0; i < wx_global_stats_len(wx); i++)
+			if (wx->pdev->is_virtfn)
+				ethtool_puts(&p, wx_gstrings_stats_vf[i].stat_string);
+			else
+				ethtool_puts(&p, wx_gstrings_stats[i].stat_string);
 		if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags)) {
 			for (i = 0; i < WX_FDIR_STATS_LEN; i++)
 				ethtool_puts(&p, wx_gstrings_fdir_stats[i].stat_string);
@@ -114,7 +133,7 @@ void wx_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
 			ethtool_sprintf(&p, "tx_queue_%u_bytes", i);
 		}
-		for (i = 0; i < WX_NUM_RX_QUEUES; i++) {
+		for (i = 0; i < WX_NUM_RX_QUEUES(netdev); i++) {
 			ethtool_sprintf(&p, "rx_queue_%u_packets", i);
 			ethtool_sprintf(&p, "rx_queue_%u_bytes", i);
 		}
@@ -134,10 +153,16 @@ void wx_get_ethtool_stats(struct net_device *netdev,
 
 	wx_update_stats(wx);
 
-	for (i = 0; i < WX_GLOBAL_STATS_LEN; i++) {
-		p = (char *)wx + wx_gstrings_stats[i].stat_offset;
-		data[i] = (wx_gstrings_stats[i].sizeof_stat ==
-			   sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
+	for (i = 0; i < wx_global_stats_len(wx); i++) {
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
@@ -169,7 +194,7 @@ void wx_get_ethtool_stats(struct net_device *netdev,
 		} while (u64_stats_fetch_retry(&ring->syncp, start));
 		i += 2;
 	}
-	for (j = 0; j < WX_NUM_RX_QUEUES; j++) {
+	for (j = 0; j < WX_NUM_RX_QUEUES(netdev); j++) {
 		ring = wx->rx_ring[j];
 		if (!ring) {
 			data[i++] = 0;
@@ -219,19 +244,20 @@ EXPORT_SYMBOL(wx_get_pause_stats);
 
 void wx_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *info)
 {
-	unsigned int stats_len = WX_STATS_LEN;
 	struct wx *wx = netdev_priv(netdev);
+	unsigned int stats_len;
 
+	stats_len = wx_stats_len(wx);
 	if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags))
 		stats_len += WX_FDIR_STATS_LEN;
 
 	strscpy(info->driver, wx->driver_name, sizeof(info->driver));
 	strscpy(info->fw_version, wx->eeprom_id, sizeof(info->fw_version));
 	strscpy(info->bus_info, pci_name(wx->pdev), sizeof(info->bus_info));
-	if (wx->num_tx_queues <= WX_NUM_TX_QUEUES) {
+	if (wx->num_tx_queues <= WX_NUM_TX_QUEUES(netdev)) {
 		info->n_stats = stats_len -
-				   (WX_NUM_TX_QUEUES - wx->num_tx_queues) *
-				   (sizeof(struct wx_queue_stats) / sizeof(u64)) * 2;
+				(WX_NUM_TX_QUEUES(netdev) - wx->num_tx_queues) *
+				(sizeof(struct wx_queue_stats) / sizeof(u64)) * 2;
 	} else {
 		info->n_stats = stats_len;
 	}
@@ -851,6 +877,9 @@ static const struct ethtool_ops wx_ethtool_ops_vf = {
 	.set_coalesce		= wx_set_coalesce,
 	.get_ts_info		= ethtool_op_get_ts_info,
 	.get_link_ksettings	= wx_get_link_ksettings_vf,
+	.get_sset_count		= wx_get_sset_count,
+	.get_strings		= wx_get_strings,
+	.get_ethtool_stats	= wx_get_ethtool_stats,
 };
 
 void wx_set_ethtool_ops_vf(struct net_device *netdev)
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 260e14d5d541..ce172b6deb80 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -2917,6 +2917,9 @@ void wx_update_stats(struct wx *wx)
 	wx->restart_queue = restart_queue;
 	wx->tx_busy = tx_busy;
 
+	if (wx->pdev->is_virtfn)
+		goto skip_hw_stats;
+
 	wx_update_xoff_rx_lfc(wx);
 
 	hwstats->gprc += rd32(wx, WX_RDM_PKT_CNT);
@@ -2956,6 +2959,7 @@ void wx_update_stats(struct wx *wx)
 		hwstats->qmprc += rd32_wrap(wx, WX_PX_MPRC(i),
 					    &wx->last_stats.qmprc[i]);
 
+skip_hw_stats:
 	spin_unlock(&wx->hw_stats_lock);
 }
 EXPORT_SYMBOL(wx_update_stats);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
index 26de78e9a69e..1d84fe35d7d9 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
@@ -5,6 +5,7 @@
 #include <linux/pci.h>
 
 #include "wx_type.h"
+#include "wx_hw.h"
 #include "wx_mbx.h"
 #include "wx_lib.h"
 #include "wx_vf.h"
@@ -409,6 +410,7 @@ static void wxvf_service_task(struct work_struct *work)
 
 	wxvf_link_config_subtask(wx);
 	wxvf_reset_subtask(wx);
+	wx_update_stats(wx);
 	wx_service_event_complete(wx);
 }
 
-- 
2.30.1


