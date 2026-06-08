Return-Path: <netdev+bounces-296481-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nBZ5MbudJmp7ZwIAu9opvQ
	(envelope-from <netdev+bounces-296481-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 12:47:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D47B6554FA
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 12:47:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296481-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296481-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4EAB3303F277
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 10:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2B138BF9A;
	Mon,  8 Jun 2026 10:40:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F463B9DA9
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 10:40:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780915239; cv=none; b=VL+E8bgJOaKwVsnWf3FQssMG0kMQl/pXMBSlC6AXbx1xJx20aP4TKLZ8irorq8U3BDKCegHX02H3fE4TWimFjWkBqhXVDmKeaSUDqPEwGHuIc4A++r2BTwT2erBzgFlWTYzZUCDtrLOj0W0oig2NU7JPrrVPJ3m8q1+28OK4b5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780915239; c=relaxed/simple;
	bh=E+SheBLH6hsoqgR7+Wkc3OBWiA4Qtf3j30gOsNlgyAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SRHKVDmZllWTcNJ5QU0rdwYPkEFLOcbOundsZsO3WMzgtihiqusbG7umhnKLvxkVkjHXfuSG/Qcfrgb4WRwKuohv9NqQ2bUdU/0cH/KPfJKKi+/bMICV48jozkX8146w7WpeoH1tG8b3OWR+CmTtgEwhsq02PAtgNJycQLIY0Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=18.169.211.239
X-QQ-mid: esmtpgz10t1780915195taef874dc
X-QQ-Originating-IP: JW4ZB+tgZV9oE1LW8B+V9lQjcZqJmQrU/ZgiHfIbNCk=
Received: from localhost.localdomain ( [36.24.184.84])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 08 Jun 2026 18:39:54 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8796568228109399643
EX-QQ-RecipientCnt: 6
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	horms@kernel.org,
	kuba@kernel.org,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v4 3/3] net: libwx: support vf per-queue statistics via ethtool -S
Date: Mon,  8 Jun 2026 18:39:46 +0800
Message-Id: <20260608103946.25786-4-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20260608103946.25786-1-mengyuanlou@net-swift.com>
References: <20260608103946.25786-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: McnIZrOgyhy6kl1n9N8OHfUYK9Hcz7LJ6oXMY2a4whGkp2JTOJRSYQLB
	QdRpsDeNoIXsWHswdQzcHh5gGqo9UOea+PHOgJpIfcfwdd0thRQBMhfAwdmQEQwyZh/r1O4
	QKYDZWr1rjb/U2QcJS2GdMmLGLG5F8sWsun+LPxQNq7QNJrw+1bNfngTaCf1oIJAbHAWXi6
	KCNQnsPs+OmRvaJXabLuo8Z95Vj1j/Yc/tmDDCI8Lrg+FjLZkcWsz383gv/Sa9OlxZY9OkF
	jjBgpem5mWrmlhEGHGgVRTPoyohIEtN923Vv8fVABme/PY0rZcAIF3IC3ClUpISS776ah1p
	Sa6Yrv9kuPYXBJqMXTICVraJh1cgPoBpF8gV1bPBrT6STXVuGpWNZCRhq0HbvtNQ3OO+bki
	3aHlg+/kR+4aMaDHcsHeedJ3n0MUyDe1NWq+lUnWBumWbSIKga6ns1aBFO5T5GrLPL3Zpwh
	1wPRoRRgOVH+DoQweKKEJlmRlL8x25hg3w4X4THSgTC827sRdj3+undWheK6d1RxIhbiVZV
	3dBVcb4c7Ev+JvlhEwrbHI8kI0fx9uWbzGdK6o/h2Koz1pFFskQOlNv1X5WKiq+WCcSgCe8
	Rnw/Onypu7ATyHJsTuXrteNXJPK0ZDUTkZltkobxTov9wP3SNhzL40f+6TrJuJhejF2TKNR
	yUdFSwGuLZH+x3qaz/JIfsf+cQHysh3XbaqXe5jBcUA6wstYrblnfEoBLKdoY9sE2hxcGbF
	WswiSpMeD0p9aMQ7rvNzdJvXX3Es1G9w8pS3MS8oNLZdld+oJeu5ADbEwUPTmWrOTMatyZu
	sCEPyfmbWHNnnYLafcVLHoXvt5OFWz0tTA7U1sBuSg9whvFK6kxj9dDGiksFkEB2ys7uoa6
	4ZQ/2HJAoOrm/utYYh+zpdORTqQyEv+GfQ2i8BfqqfLQevH1eqH8mmWJSzVhRc+gQ0sKfk6
	wD/vV2LBg3OFziEzNlX35gJKdGImXSrBvFvX0XzrA+zYJYzxGy1KotIPgLJdShvTi+w+G/j
	eGLLFsVWhxX051JA04xAd7FSRWlrdlRsuZfpspzbvBGfEAovX1ChgL1tFXP4XhrEtZ23OwA
	edaudLyUuOaqigltSQeh9XrWqmYrmk3ggVY9W6JvRGlnwJoIVHbtvyvDw281CCbg12dfyvr
	0gphEqMp+Pi/xTg4Y3GBYHKaZg==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[net-swift.com];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:jiawenwu@trustnetic.com,m:duanqiangwen@net-swift.com,m:horms@kernel.org,m:kuba@kernel.org,m:mengyuanlou@net-swift.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-296481-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mengyuanlou@net-swift.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mengyuanlou@net-swift.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D47B6554FA

Add per-queue TX/RX packet and byte counters to the VF ethtool stats
table.
The stats length is now dynamically determined based on whether the
device is a VF or PF via wx_stats_len().

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 48 +++++++++++++++----
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  4 ++
 .../net/ethernet/wangxun/libwx/wx_vf_common.c |  2 +
 3 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 30c6ef6103ac..86f6ac63acf7 100644
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
@@ -69,15 +73,26 @@ static const struct wx_stats wx_gstrings_rsc_stats[] = {
 #define WX_QUEUE_STATS_LEN ( \
 		(WX_NUM_TX_QUEUES + WX_NUM_RX_QUEUES) * \
 		(sizeof(struct wx_queue_stats) / sizeof(u64)))
-#define WX_GLOBAL_STATS_LEN  ARRAY_SIZE(wx_gstrings_stats)
 #define WX_FDIR_STATS_LEN  ARRAY_SIZE(wx_gstrings_fdir_stats)
 #define WX_RSC_STATS_LEN  ARRAY_SIZE(wx_gstrings_rsc_stats)
-#define WX_STATS_LEN (WX_GLOBAL_STATS_LEN + WX_QUEUE_STATS_LEN)
+
+static inline unsigned int wx_global_stats_len(const struct wx *wx)
+{
+	return wx->pdev->is_virtfn ?
+	       ARRAY_SIZE(wx_gstrings_stats_vf) : ARRAY_SIZE(wx_gstrings_stats);
+}
+
+static inline unsigned int wx_stats_len(const struct wx *wx)
+{
+	struct net_device *netdev = wx->netdev;
+
+	return wx_global_stats_len(wx) + WX_QUEUE_STATS_LEN;
+}
 
 int wx_get_sset_count(struct net_device *netdev, int sset)
 {
 	struct wx *wx = netdev_priv(netdev);
-	int len = WX_STATS_LEN;
+	int len = wx_stats_len(wx);
 
 	switch (sset) {
 	case ETH_SS_STATS:
@@ -100,8 +115,11 @@ void wx_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 
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
@@ -134,10 +152,16 @@ void wx_get_ethtool_stats(struct net_device *netdev,
 
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
@@ -219,9 +243,10 @@ EXPORT_SYMBOL(wx_get_pause_stats);
 
 void wx_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *info)
 {
-	unsigned int stats_len = WX_STATS_LEN;
 	struct wx *wx = netdev_priv(netdev);
+	unsigned int stats_len;
 
+	stats_len = wx_stats_len(wx);
 	if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags))
 		stats_len += WX_FDIR_STATS_LEN;
 
@@ -851,6 +876,9 @@ static const struct ethtool_ops wx_ethtool_ops_vf = {
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


