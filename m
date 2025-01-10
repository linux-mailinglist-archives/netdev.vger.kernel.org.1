Return-Path: <netdev+bounces-156991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A0BA089F8
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F9261680ED
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 08:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66534207DEB;
	Fri, 10 Jan 2025 08:23:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BA4207A33
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 08:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736497433; cv=none; b=l1tNk/NQHsHVAz8dfSci+PH9JHEPGi5XRo5kp15NpOPXuwJTYlb+XBuuXsQC5ukJxIZOdvRAdVCQ12DG9UMopYhTJi8fZhIQaIywQ7KKDtY4FZ5xip8P+0V3CbO32mfVrC8U6iN9wOKKDsOEA/z+06qGl52yrmcXq7y9QdaSLsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736497433; c=relaxed/simple;
	bh=knGmlm2aibEB+rRaVj2uOiB0hJjDfYEg5FUAKAIptNM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=arnQpt+VO4wpX1Nja7EKtkCjpiPDN75GO7by2JwklIUCAHqswejLJKKkqx734BBIWlCS7gDgL9G0/D6Z0GErh9+FUHA98bK1oCbDPs++Mu1AYhHojQyFQ/wdeVZDxSQKShreYSHLEUWME1FTsM94yL8yl1+icXYrq3wfpMv5IBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp86t1736497328tejbg235
X-QQ-Originating-IP: 84rb5IFDjMCvqU/qC7oqwQaAXCvQYcLxuU8U0wClsUY=
Received: from wxdbg.localdomain.com ( [218.72.126.41])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 10 Jan 2025 16:22:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5580892351730362765
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
Subject: [PATCH net-next 2/2] net: wangxun: Replace the judgement of MAC type with flags
Date: Fri, 10 Jan 2025 16:42:49 +0800
Message-Id: <20250110084249.2129839-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250110084249.2129839-1-jiawenwu@trustnetic.com>
References: <20250110084249.2129839-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NyTsQ4JOu2J2ocwaXM2l/oxuFfTCTR0vovzgAoIwXQn2UtLuDbl+QNZo
	650/j/AZioGa02VrPTE9UE6FiIE3TrNP8sh2WQzFeqFUPMJNC756XurUu2MmXHiH9zeVcl6
	RLBGk6PvlNbywo5w6SB7lV+hjHuggf/wCSW7fWyY9ONjPuieBy8tSL/4l8OiYXUSAwGAo7o
	/icW/Mx6FyNE3XFn38YVrwtSo8/ZDeiGpVAkVlu/h/bZNh7GzT/bfAZnfPAQbP2L23PH5s3
	lM92Aiqy7xDxekH5VKQPCbmmK0tlV0NeTYP/ML/3GFNvMhSOAHrZ9EyDsRwQvZJ3XU+nsuA
	Hd9dHLZUrDkakDHkbKRKTCJy79GM5ya+NaF0yKx93jcg1DVi9f0QpeLmsYmfaakk/pGiHry
	466+cPsAJQmqNTXsFJe7YhdcEtHINYeETa8086pcSI5WXdfXq2PflXwH3CSuBBNNBSFJOph
	kGDXYXaCxG7FI8v90KD1WDaTukQXfi7+NSglTXs2Q2APwEeWs9sWNIEZD2hz8fTQPwI2VyN
	KNLXHol6OmcZgbVg4zHu9zHJtQpqt5GpLKMa6IByejkjYZH9knJn+H8WAoqI4BrO03asIAp
	AmZ5wqSlzjSeP8co+i+J3jiEWQ5rTWrNfv0p7yWF3NyD/bqCpHDCNp9fiXtPspEaqpkVYKJ
	bXPfaLyDXsrT7aD8mFWMawD1iCWO/PgkxNiaunE+aX02ZuBRk32nhQwcaCb/2AYNsnzji/3
	JdRlBWlYLF/KDB1h24O7LXDwwtVwP3HDfbFMVsraXvjRntXJoKU6e50HcEke5ypK64aUB7j
	Z8uAGxtxbK5/xTB2G6BCds8jhkEY22YRpBMEun6Yz0Tbd143o56m+bMQeN6s2pXio/nlsL6
	0inAkYqbmcH9CWgQ9RTW57qqH4qHf1aAKYrlATh9y/4c3C2tLN/QwGh96l4q89QjT0Td1M5
	WWPv/fvMdpoC6RDXCZoZ/Jaos2rtx3pxf5KZYb908tFR0T2DargOpOx3EjhmQQbvz82+Llh
	SIkGBkT9iK56ODZQLySLQuktASrJU=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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
index dbba8ddd2b01..0c6f186f8d90 100644
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
index 9c3f7d9389c1..0c39d2fe60cc 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1050,6 +1050,7 @@ enum wx_pf_flags {
 	WX_FLAG_FDIR_CAPABLE,
 	WX_FLAG_FDIR_HASH,
 	WX_FLAG_FDIR_PERFECT,
+	WX_FLAG_RSC_CAPABLE,
 	WX_PF_FLAGS_NBITS               /* must be last */
 };
 
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 5c035aa720fe..84a59a6f579d 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -285,6 +285,8 @@ static int txgbe_sw_init(struct wx *wx)
 	wx->atr = txgbe_atr;
 	wx->configure_fdir = txgbe_configure_fdir;
 
+	set_bit(WX_FLAG_RSC_CAPABLE, wx->flags);
+
 	/* enable itr by default in dynamic mode */
 	wx->rx_itr_setting = 1;
 	wx->tx_itr_setting = 1;
-- 
2.27.0


