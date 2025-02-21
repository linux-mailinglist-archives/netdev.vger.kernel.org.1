Return-Path: <netdev+bounces-168399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42277A3ECE1
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 07:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A71E188FE71
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 06:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F7C1FC114;
	Fri, 21 Feb 2025 06:34:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D23B1FBCB0
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 06:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740119663; cv=none; b=YGNV60ZFfd4Vq6wPDFQgUSWsv+H0Oo24+9/+lBJS2MVrPx5rczcUr3XVFcx59uDFheTQYJgvJZmuZaEqofqy029+qfYozmacV1pVMV4amyPNMPQcuaH+pAMcxbAHi4+ccw+ggjEaMDqaSEV+rQ5LnJi5V3N3DHdbkMcFDuwrZ4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740119663; c=relaxed/simple;
	bh=dio5TachoH3MW0I26xOcVFNSNGPQxE7vSbMfdl+jg80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f7mbfEqnOWoX0HgDnj/LR84xB6t13HKKHp6DyoEZJEvWQlKGKcorOnRcIIXpnf0nKJb3kriwyNixVI64qAtDYqtI2Zgdjng//XGWRl3hTjsrjWWRIr7EXUWuxe9zPOJaU6uV+wKfTP5MYZTN3l6ucqbwcrKNvMT3suziLStiR5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp78t1740119540tzxbkgx4
X-QQ-Originating-IP: J5upqMvBDXo6ppZqInMHP2zfBA7ttgJZA5GMmqP2i/M=
Received: from wxdbg.localdomain.com ( [115.204.250.88])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 21 Feb 2025 14:32:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15338892124135661940
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	vadim.fedorenko@linux.dev,
	horms@kernel.org,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v4 2/2] net: wangxun: Replace the judgement of MAC type with flags
Date: Fri, 21 Feb 2025 14:57:18 +0800
Message-Id: <20250221065718.197544-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250221065718.197544-1-jiawenwu@trustnetic.com>
References: <20250221065718.197544-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MXHIEC8P0R7hxSclS+hP8MgwLAtriOE2HqYJayd4q5QuBd/ig2fWLVBO
	sL8Em1KJ8kvndrlaFeUflFoiKJoEJ9zwwHfFzDBQFQ4jzal4nZxk4WCTGJxg4VpqIngxg75
	22/h4Wa/CVQUmjuCbwFurcsV8/EXd0F9UAoYFlhxNB4/sDMXGSBeOmEvrXJ4nsfc+bUjs2V
	1geZ10TzQIZpas8VcHQhpy2hLQPL1pPVbLQO/o8z+YJKRECOPdur+zGWhzaFIw4ggBKwayN
	wa9H6IOqXF2fqM0+M0S3e0vCk4fkPoFxBB/vukp1gyrfgF8tlGVTbMCJQ/6czFLfJ14iZz5
	FZTNMIlcWmYg4i79UofADOCcsq71hrF8c+EvLzMekRexrHG5UO/NIUvOwpNkH9+L0WezyrE
	LsLAgompaN5FnnJ7jUCkttQwE2d1VfLD+qkJrb6Mgg20Hx8SuA0Hi/coRLJZ6Y9BUr8RMGr
	0Os/CFHFzxv+x+RvLfGjC2tHcHJBDQI6vUBw97VCJMVBV4kQlMKllu4mgT7Iwa6Z446D78A
	oZkSal+NAGirC7SWRtyC7nRon6OAKia3j1bAwfBGjJOtC2T5s5tOi+NNMAb+jxewOT/Arh2
	pAPUWtmzg0vBI3Mxuv+RhUh/JfRjEZQ85+0TPC3U6AJba6INUiqhRZCaDH92lx1NNJoU1Ow
	ZbCcG26vG0wy/WgnIQKQ8yjYrvzZbUvPCWyiEHd67m6WY5qrjZFRnkLtOhV2amNUvuIPiyU
	2z3zpzs7xL4vtdd+r7RSch0yNy4z/vQgL7aY62XSWs4GNRsGm/8RzdpEpaSnoTWHimHYYYU
	dMAQvaQOHOMpBRNN31oST5Gvz2Xf7rbSdpY20X/hlauP+JyCYMMhrmYE23loyZlKhavzAt3
	d5qfTM8dxiX3t6yqNlf/s/DxEw2F+IaEdJbcay+BGDNngEhbhjOTXbkBDnG6092VNF+GT0n
	jUI7XgsFnwOcAqofvPiNt2+Ekg6Es52XNrXHwu97QKR45+Ye8J2yNJcMBr0d3mI/goJmyf3
	KtOZmqoooFcCCp+zzIRC71uD8VG0oxxD3ZGZSoXQ7S/eVoe3gh
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
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
index 6d3b57233a39..43019ec9329c 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -72,7 +72,7 @@ int wx_get_sset_count(struct net_device *netdev, int sset)
 
 	switch (sset) {
 	case ETH_SS_STATS:
-		return (wx->mac.type == wx_mac_sp) ?
+		return (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags)) ?
 			WX_STATS_LEN + WX_FDIR_STATS_LEN : WX_STATS_LEN;
 	default:
 		return -EOPNOTSUPP;
@@ -90,7 +90,7 @@ void wx_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 	case ETH_SS_STATS:
 		for (i = 0; i < WX_GLOBAL_STATS_LEN; i++)
 			ethtool_puts(&p, wx_gstrings_stats[i].stat_string);
-		if (wx->mac.type == wx_mac_sp) {
+		if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags)) {
 			for (i = 0; i < WX_FDIR_STATS_LEN; i++)
 				ethtool_puts(&p, wx_gstrings_fdir_stats[i].stat_string);
 		}
@@ -124,7 +124,7 @@ void wx_get_ethtool_stats(struct net_device *netdev,
 			   sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
 	}
 
-	if (wx->mac.type == wx_mac_sp) {
+	if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags)) {
 		for (k = 0; k < WX_FDIR_STATS_LEN; k++) {
 			p = (char *)wx + wx_gstrings_fdir_stats[k].stat_offset;
 			data[i++] = *(u64 *)p;
@@ -199,7 +199,7 @@ void wx_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *info)
 	unsigned int stats_len = WX_STATS_LEN;
 	struct wx *wx = netdev_priv(netdev);
 
-	if (wx->mac.type == wx_mac_sp)
+	if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags))
 		stats_len += WX_FDIR_STATS_LEN;
 
 	strscpy(info->driver, wx->driver_name, sizeof(info->driver));
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index b5f35b187077..aed45abafb1b 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -1861,7 +1861,7 @@ void wx_configure_rx(struct wx *wx)
 	/* enable hw crc stripping */
 	wr32m(wx, WX_RSC_CTL, WX_RSC_CTL_CRC_STRIP, WX_RSC_CTL_CRC_STRIP);
 
-	if (wx->mac.type == wx_mac_sp) {
+	if (test_bit(WX_FLAG_RSC_CAPABLE, wx->flags)) {
 		u32 psrctl;
 
 		/* RSC Setup */
@@ -2513,7 +2513,7 @@ void wx_update_stats(struct wx *wx)
 	hwstats->b2ogprc += rd32(wx, WX_RDM_BMC2OS_CNT);
 	hwstats->rdmdrop += rd32(wx, WX_RDM_DRP_PKT);
 
-	if (wx->mac.type == wx_mac_sp) {
+	if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags)) {
 		hwstats->fdirmatch += rd32(wx, WX_RDB_FDIR_MATCH);
 		hwstats->fdirmiss += rd32(wx, WX_RDB_FDIR_MISS);
 	}
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index f79746ac6aca..5b230ecbbabb 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1112,6 +1112,7 @@ enum wx_pf_flags {
 	WX_FLAG_FDIR_CAPABLE,
 	WX_FLAG_FDIR_HASH,
 	WX_FLAG_FDIR_PERFECT,
+	WX_FLAG_RSC_CAPABLE,
 	WX_FLAG_RX_HWTSTAMP_ENABLED,
 	WX_FLAG_RX_HWTSTAMP_IN_REGISTER,
 	WX_FLAG_PTP_PPS_ENABLED,
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index ce83811a45e2..a2e245e3b016 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -298,6 +298,8 @@ static int txgbe_sw_init(struct wx *wx)
 	wx->atr = txgbe_atr;
 	wx->configure_fdir = txgbe_configure_fdir;
 
+	set_bit(WX_FLAG_RSC_CAPABLE, wx->flags);
+
 	/* enable itr by default in dynamic mode */
 	wx->rx_itr_setting = 1;
 	wx->tx_itr_setting = 1;
-- 
2.27.0


