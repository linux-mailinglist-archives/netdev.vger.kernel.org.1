Return-Path: <netdev+bounces-157701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCCCA0B43B
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 11:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD9DC3A8B2F
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 10:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F28A2045A3;
	Mon, 13 Jan 2025 10:12:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EBD186A
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 10:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736763131; cv=none; b=u7hqinsfXeW0HCk/DwrT0MAMVHnW/C44AhhCjUStC+pkbTo0MhhoPq+5k1gdg/rLDdTBpKrhaj/3FQGZre6GAmGYL4wYcXoy9v/Ho335fS+9FOMHwuyiHV/hcC+lSrCNTlpBwxNTNltTtHhARE4HoF7qh7j2yg/pcefUGO1I5yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736763131; c=relaxed/simple;
	bh=fd/vLrVzgYS8oB96GueaaMLtErCB+MtSVkJ8lhdVbhA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PFjGw9thKCrlmF6hvHv3udKE2sjwUOBjU1hPA1Y/UM+8YH14NCa+0zDjam+ASvrJP24B8lsF1ckGKf/tju9UhJewharmBkna8YwxCcc/WcgsAnnRoz411py7ReazVRqzTi0GHT2NpEZA2lGXA3yIsDgaBAvOKMClKdojwxLbKmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz15t1736763026tvp9ig
X-QQ-Originating-IP: GTLHkDs77nb08nZ+PSgrN3/IpdsVTIi4R1mtm92dFWw=
Received: from wxdbg.localdomain.com ( [36.20.58.48])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 13 Jan 2025 18:10:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11793313299786683594
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	horms@kernel.org,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v2 2/2] net: wangxun: Replace the judgement of MAC type with flags
Date: Mon, 13 Jan 2025 18:31:02 +0800
Message-Id: <20250113103102.2185782-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250113103102.2185782-1-jiawenwu@trustnetic.com>
References: <20250113103102.2185782-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NUbJ1FBQTTPuPXSyGPvyoQkQdE5V3NBjlzL6OZBQMa0JxNgd7aP9ufbU
	2s1f4PHHLJ+GxukVM/FjJFDBgftAyPvnTRNAciTovpRWz4t3pJiEb6Z5Yp8X1RK1IY3I4qP
	QWkOwcDfSjmMsib6L5rEVuTiZokX7XgRoGC4TwIWBufyIrpHzzsUSVLlGeH/SVQXTwaDnmJ
	DGOSRBmN7BZKP3+uyQyBWcY2mzu6NS+DStDgOe5IvRiZIdLeYAqUs4Rzm56PgBz5Wa4nfcI
	dBe6LdOSiOTtLYb5ckLz7oB7qdvVBu4/lOtJuru48RLSvSyS47heSrihbqYeE2bwCx7qimr
	HrNU/1K1P3iHWD7II+0Cz+2vV12C9SiHw7q2J3A+Dl6pDMaIGXENXpPbNhMXVTzp1LnuG88
	nvNEkjCGONZOomaIUVvRShWJLHnWhEsXWR7hDr+lU1ZE1oVi6OJ4A/+dTCtacoMeviIngq3
	WDP7R2ttFhCwz98jLGKiun7ETgawmkrowcOXkIp5qRnaRQ1uFQ0onz7hOEF0pKeEJpoHQhR
	Qt6mzihxwJgdTEXQxnEUDLgFni551ShcYETMKA4xKDtJHNH5eWCiuGqonkHlHQsu9Ef19Ng
	fRDADyjBq05N6rB7jeB7tj0kWM+Mb5RrYgaPK8QO+gMtWTf+sl2BqpAYWrm44BNfilcQcZ4
	ZzgU+OTxD1Dcrqq9PpJ4wIchdyNs98aOmoPfJz2P5tQ7CoABhAoU93nY+TUXpxlvyZbNOyN
	KCVrbBaBcjIlfI/qv4SAvW2mcp2pCg+JQcrrqPLQjxak+BZB7MseH+1/7CVNPsuXqfqB4bL
	fVPGSnyZOm/Mzz5YqcGHtWK87u5qCtjEqLNNwkptex3NPq5yvvQwY2AdKNVxBYHIRrxFk94
	qe7e2J/MGGTUPqHVXHshIeuSYKlCxgoUBftF9PIyuKo9bWC7C/U6chPXqv0TCekaFgrC5lv
	IbRmWA/ledBv8MJwlv37hN24MTygc+aOQGVJQDON1Dx729qDupGIOVwm8T51FA8wNAbGRjM
	iorzafZbAr8wcojUF4
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

Since device MAC types are constantly being added, the judgments of
wx->mac.type are complex. Try to convert the types to flags depending
on functions.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_ethtool.c | 8 ++++----
 drivers/net/ethernet/wangxun/libwx/wx_hw.c      | 4 ++--
 drivers/net/ethernet/wangxun/libwx/wx_type.h    | 1 +
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c | 2 ++
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index f6b1323e606b..10cc7260fc4e 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -69,7 +69,7 @@ int wx_get_sset_count(struct net_device *netdev, int sset)
 
 	switch (sset) {
 	case ETH_SS_STATS:
-		return (wx->mac.type == wx_mac_sp) ?
+		return (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags)) ?
 			WX_STATS_LEN + WX_FDIR_STATS_LEN : WX_STATS_LEN;
 	default:
 		return -EOPNOTSUPP;
@@ -87,7 +87,7 @@ void wx_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 	case ETH_SS_STATS:
 		for (i = 0; i < WX_GLOBAL_STATS_LEN; i++)
 			ethtool_puts(&p, wx_gstrings_stats[i].stat_string);
-		if (wx->mac.type == wx_mac_sp) {
+		if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags)) {
 			for (i = 0; i < WX_FDIR_STATS_LEN; i++)
 				ethtool_puts(&p, wx_gstrings_fdir_stats[i].stat_string);
 		}
@@ -121,7 +121,7 @@ void wx_get_ethtool_stats(struct net_device *netdev,
 			   sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
 	}
 
-	if (wx->mac.type == wx_mac_sp) {
+	if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags)) {
 		for (k = 0; k < WX_FDIR_STATS_LEN; k++) {
 			p = (char *)wx + wx_gstrings_fdir_stats[k].stat_offset;
 			data[i++] = *(u64 *)p;
@@ -196,7 +196,7 @@ void wx_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *info)
 	unsigned int stats_len = WX_STATS_LEN;
 	struct wx *wx = netdev_priv(netdev);
 
-	if (wx->mac.type == wx_mac_sp)
+	if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags))
 		stats_len += WX_FDIR_STATS_LEN;
 
 	strscpy(info->driver, wx->driver_name, sizeof(info->driver));
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index ff39722da98d..b88a28cf3b99 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -1838,7 +1838,7 @@ void wx_configure_rx(struct wx *wx)
 	/* enable hw crc stripping */
 	wr32m(wx, WX_RSC_CTL, WX_RSC_CTL_CRC_STRIP, WX_RSC_CTL_CRC_STRIP);
 
-	if (wx->mac.type == wx_mac_sp) {
+	if (test_bit(WX_FLAG_RSC_CAPABLE, wx->flags)) {
 		u32 psrctl;
 
 		/* RSC Setup */
@@ -2490,7 +2490,7 @@ void wx_update_stats(struct wx *wx)
 	hwstats->b2ogprc += rd32(wx, WX_RDM_BMC2OS_CNT);
 	hwstats->rdmdrop += rd32(wx, WX_RDM_DRP_PKT);
 
-	if (wx->mac.type == wx_mac_sp) {
+	if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags)) {
 		hwstats->fdirmatch += rd32(wx, WX_RDB_FDIR_MATCH);
 		hwstats->fdirmiss += rd32(wx, WX_RDB_FDIR_MISS);
 	}
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 2969af0dbb57..84da4786ab9f 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1051,6 +1051,7 @@ enum wx_pf_flags {
 	WX_FLAG_FDIR_CAPABLE,
 	WX_FLAG_FDIR_HASH,
 	WX_FLAG_FDIR_PERFECT,
+	WX_FLAG_RSC_CAPABLE,
 	WX_PF_FLAGS_NBITS               /* must be last */
 };
 
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index ffe42b77de3e..12bb947daba4 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -293,6 +293,8 @@ static int txgbe_sw_init(struct wx *wx)
 	wx->atr = txgbe_atr;
 	wx->configure_fdir = txgbe_configure_fdir;
 
+	set_bit(WX_FLAG_RSC_CAPABLE, wx->flags);
+
 	/* enable itr by default in dynamic mode */
 	wx->rx_itr_setting = 1;
 	wx->tx_itr_setting = 1;
-- 
2.27.0


