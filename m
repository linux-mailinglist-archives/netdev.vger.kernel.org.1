Return-Path: <netdev+bounces-158453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 488A7A11EE2
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 11:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B83AA188B1DD
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 10:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEF41F9A9F;
	Wed, 15 Jan 2025 10:05:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7796F1EBFE8
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 10:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736935522; cv=none; b=bhNlqTIQzJ7cTclogLY/3mFWBsZtXKzrRkH+TFLnkeT5xeE+Xz+T/YU6PoJOTsWQhNqYuiiwbtw9d2LRWnDIhkgiNuyH0MX0RF7JltnUis3fkBLxIIccrCFTTjC10wD6QrG/kL87tN1joxOd9aqhZKqjVRkPwFQnLR/+/In0RVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736935522; c=relaxed/simple;
	bh=C2kGi8wUKt/SOYuDRx7x16y/56MPkSjishwWdCMxxZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BUmrxsRb6v1dYtWagrpuC4DvTPCGR7bBHhRDMQbsf8d047EM/o3KY4Q252WEH0+inM6KMMJAKBevaRJ2f31nSmj0ctMFismBWbAEVHpnYFYdFWaKY4GIBdb56K0ABtkQAvXc8oStCm94zdF5GDPpiswpL+BBYLa4q8kcyndFjL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp79t1736935418t5f3ubvc
X-QQ-Originating-IP: hXyX6IAOXwcCXM34XTmSkL4atrm1UDs3Og0CVezkYVg=
Received: from wxdbg.localdomain.com ( [36.24.187.167])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 15 Jan 2025 18:03:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1522690815015460781
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
Subject: [PATCH net-next v3 2/2] net: wangxun: Replace the judgement of MAC type with flags
Date: Wed, 15 Jan 2025 18:24:08 +0800
Message-Id: <20250115102408.2225055-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250115102408.2225055-1-jiawenwu@trustnetic.com>
References: <20250115102408.2225055-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MOfz9TzWtqadpJNf7SJnfCINRKD/pmlNz1z7mv4jb6F2ldyV4bvTNnqY
	oQ3l83Mp206jL/C6wiv7g944rAhpJnOXZFHkujiSakYnnBmBukj5fUpdCV3CSXPt+/fT+cb
	EWLb+x3gvwqgWBiNffN0x2Z6vRJcZ5+yqSlP9xV924kbG/VfffDSVriRBxwBR3hea7iG7mz
	6cD4zQ6wXAbaYJ6PZePfXuKFMo3B7MLyuDDX9WX59CBZwN8dD7pcLfpZFqioj86AfZAa4Z3
	SrF6Feipmycz15cYR18m35561lbSSuyX4xqqNhiYtZfcWzq1TI1zMCApqc3LxUlqaPRs10s
	lGmlwJ5oOKIvM8KlrxK8NbmuuHsRXq4dOEoPs48gvK7LRiM5qlswsvbepdZM5JaKJ+mnS+M
	/Hsa9fEp4ECsLh8hWEK5Paazzd2dH3Q59D+RB9ldfCgiptHvIbotrpAbXLkAlk9isl1LeNk
	OscJ4fXLtT9q8MvfJ7ruszw4ChZpyirfiXIyEgfxOLrFmUUtgA8PB3JvcVK1RxeRoDqptbl
	zJdbfNF215wm/skGdFJ4diqCDNTiMPEe3bnhQVvZ+T5ahA2bBDzIMtVD49IaKDonyyPOzCu
	mMGI0eRuXtqCHQRcXkq1b/yxf39ciUFUb+F/+TDR3OLnyMIlz7lD2x82YYlu0qKFha9ycfa
	ejFwDdsWVB9JpQlBfNT8FgXnh2YtO+h8L57Qf5D2it68d04HePEzpijsmSPNqK7dXlyzwEl
	nSMtbEsvY0EJHmq975PfOzL1znAZYAjp26jWjnsjamJRyAs1haFUueNlDrMuk23NhuR8K+q
	VI6KgYOY4rIYHh0xr5JDQ12faCI5JxNDda+BOQZZmMMa7CGn3vJSoG6N+6I7iYNBHG2lBSV
	GG8XuSXhaOSZAvZR6hkl+dJi6hqbwifyk2n7JBXobZsvZ6H82M8IjAFl+8RYvnQd+CN3cep
	m0Dz8njy/Vax1zhXaS7xGAwko9Z4GOKSZFG48aLBEsuI289qFXY4NHdRK3X+RKRqdAsOJi7
	1rAWetAZd+pUV4kghbDaqA187tEcg=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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
index 7198650de096..10c42f681256 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -1843,7 +1843,7 @@ void wx_configure_rx(struct wx *wx)
 	/* enable hw crc stripping */
 	wr32m(wx, WX_RSC_CTL, WX_RSC_CTL_CRC_STRIP, WX_RSC_CTL_CRC_STRIP);
 
-	if (wx->mac.type == wx_mac_sp) {
+	if (test_bit(WX_FLAG_RSC_CAPABLE, wx->flags)) {
 		u32 psrctl;
 
 		/* RSC Setup */
@@ -2495,7 +2495,7 @@ void wx_update_stats(struct wx *wx)
 	hwstats->b2ogprc += rd32(wx, WX_RDM_BMC2OS_CNT);
 	hwstats->rdmdrop += rd32(wx, WX_RDM_DRP_PKT);
 
-	if (wx->mac.type == wx_mac_sp) {
+	if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags)) {
 		hwstats->fdirmatch += rd32(wx, WX_RDB_FDIR_MATCH);
 		hwstats->fdirmiss += rd32(wx, WX_RDB_FDIR_MISS);
 	}
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index ba6e45eeaba6..c0d8ecfd7f03 100644
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


