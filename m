Return-Path: <netdev+bounces-131666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E00B98F356
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 17:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBA5E1C20B6A
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 15:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DEE1A3AA7;
	Thu,  3 Oct 2024 15:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXVQv6BV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6129C1A0722;
	Thu,  3 Oct 2024 15:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727971008; cv=none; b=ZBm/gxiPLLX/ikWPjR2wUuyiTseHpzfNXKV6ZJIa/+QAq5Nu7L7dJzgsy6uYopoVJo72CcEBQsAlkFjwE3ISP2bAAOzrrniB7NQZZVZt4PEhSDQNRkMXUYYZqEsJxlhuveeCIe/IvnCEr7CekfyNLTEeQ9da8MGk7nXGEJ1R+Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727971008; c=relaxed/simple;
	bh=CWe3qeSufdkyrtmtM6u+5P9ovbXu+ZiAiRirvxh41Bc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=StudgJGUN43O4Z5BlH52TJs0zCa0ox59f2fzni/Ns41UuBVyoP3Kwf5VT7fmq972PBeltIeg7Vb5RdM5auXrzD7Q4txq69pMNVI70WPxhMJvWL+A7IycR2Ruc/QcLr3qEw6Hq15L1GLKq/yS4i1FJ5fvKnthcVAbnnccyYJPMEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXVQv6BV; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37cfa129074so890803f8f.1;
        Thu, 03 Oct 2024 08:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727971005; x=1728575805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oqkDUAEikU7mCD/D2xA0iEcZc4afdA+pWc3yCDGeyLg=;
        b=WXVQv6BVE2poxj8UskTqB3m+KJj0yyeb15coHc/iliQG6Jr8MGVN1mTbb9wgyzk7sf
         VhZtyEKDNFOD51baykqk4FkPWSRoO1NHu+K7Ka2R3ff7OdBI4LuMqYdlJQt7pDl9ssc3
         8y2V1w7dB8zlgWT0N4e/gehAxu8j2YSZ+iBeFmN76qOdjR4mTOktjAv/4mhidUIbqhet
         QwCm1fa1fdl/kETjKH1EKU4XN9LoKTjYbRsDaAHBu0WGgKDs+hPvRDIbf/g9ljnHCTe5
         n9alzPdUkNODaBrZeGo+Yxp9EeoM9bS1PobFrVFxlG9kzvMRBqMlPcV9nxzaGHcToWsY
         xMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727971005; x=1728575805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oqkDUAEikU7mCD/D2xA0iEcZc4afdA+pWc3yCDGeyLg=;
        b=crik/g6KCHlxDCxDRwuyJYZ+kVqZPk1RTppEbp3HPI0SGokPwKlYZeLnlb/hOMqyT0
         8hfkHUtEgWnLr/CFNr5aBY/9/M8i+E2e+tGCu3TLKfdBXWPdZkJqy4iEAfSnhcKn86pb
         Ou2xjXlWEeg4JwfU1zvUwg+1W9jrxC0ADnWvlxr+SaA3ilUKoMfg3os4sXi5VI9z3RXg
         1rF8YASb07UneZhavJwgN3QGVvWxvnFKTyo/g8Lsmqe0jHgLEJKeXROcZTxGRq3U3JL5
         2JEBoUpyBzNo+3QNnkX4VszKo0bicem6NgWP9MVrmFn7nwUPVYXzEy+8AZhw6BCy2Wpj
         qglw==
X-Forwarded-Encrypted: i=1; AJvYcCVqLOdDpS8PLGqOY6qmcp1gvzTTpar6C0cjbKpyNFbDlrnerPnYxMsCvKBjtLlUX7qYuSstG8/qHkSu@vger.kernel.org, AJvYcCXcC4im2Zn+YDLS5Ioxts4GfQVW0RFSYcjHK+tvLRTS3QHxeaADSmHyk3FcsphZqBX6ruEyTVJP@vger.kernel.org, AJvYcCXzDFCaILN3Wfnz5jzNfg1y+N8Vsw77fsLOSHv62m0cnHUmGoevbLoO3LuHhvgBdSqaex9Zn4m6rRwZapA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJb31EvAgqJwkxjnSPmuIr9qc1O+/thQ6MWjriuG+Yp+YzTv7/
	8/XrGxuU/05ExzYhurzKdL/fq3Dga5SQy3UeUJY2jAGkPATQWN9n
X-Google-Smtp-Source: AGHT+IEHt4U6AwWWR+y0XGh0T1w/8a/hdJB31k+osCqnhbAzcTQfuLKVBacOPG/TZgTthZ6jsxTPRQ==
X-Received: by 2002:adf:e784:0:b0:37c:cca1:b1e3 with SMTP id ffacd0b85a97d-37cfba078a4mr5505442f8f.41.1727971004547;
        Thu, 03 Oct 2024 08:56:44 -0700 (PDT)
Received: from ubuntu-20.04.myguest.virtualbox.org ([77.137.66.252])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37d0822995fsm1563588f8f.38.2024.10.03.08.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 08:56:44 -0700 (PDT)
From: Liel Harel <liel.harel@gmail.com>
To: 
Cc: liel.harel@gmail.com,
	Steve Glendinning <steve.glendinning@shawell.net>,
	UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] smsc95xx: Fix some coding style issues
Date: Thu,  3 Oct 2024 18:56:23 +0300
Message-Id: <20241003155624.55998-1-liel.harel@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix some coding style issues in drivers/net/usb/smsc95xx.c that
checkpatch.pl script reported.

Signed-off-by: Liel Harel <liel.harel@gmail.com>
---
 drivers/net/usb/smsc95xx.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index 8e82184be..000a11818 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -137,7 +137,8 @@ static int __must_check smsc95xx_write_reg(struct usbnet *dev, u32 index,
 }
 
 /* Loop until the read is completed with timeout
- * called with phy_mutex held */
+ * called with phy_mutex held
+ */
 static int __must_check smsc95xx_phy_wait_not_busy(struct usbnet *dev)
 {
 	unsigned long start_time = jiffies;
@@ -470,7 +471,8 @@ static int __must_check smsc95xx_write_reg_async(struct usbnet *dev, u16 index,
 
 /* returns hash bit number for given MAC address
  * example:
- * 01 00 5E 00 00 01 -> returns bit number 31 */
+ * 01 00 5E 00 00 01 -> returns bit number 31
+ */
 static unsigned int smsc95xx_hash(char addr[ETH_ALEN])
 {
 	return (ether_crc(ETH_ALEN, addr) >> 26) & 0x3f;
@@ -882,7 +884,7 @@ static int smsc95xx_reset(struct usbnet *dev)
 	u32 read_buf, burst_cap;
 	int ret = 0, timeout;
 
-	netif_dbg(dev, ifup, dev->net, "entering smsc95xx_reset\n");
+	netif_dbg(dev, ifup, dev->net, "entering %s\n", __func__);
 
 	ret = smsc95xx_write_reg(dev, HW_CFG, HW_CFG_LRST_);
 	if (ret < 0)
@@ -1065,7 +1067,7 @@ static int smsc95xx_reset(struct usbnet *dev)
 		return ret;
 	}
 
-	netif_dbg(dev, ifup, dev->net, "smsc95xx_reset, return 0\n");
+	netif_dbg(dev, ifup, dev->net, "%s, return 0\n", __func__);
 	return 0;
 }
 
@@ -1076,7 +1078,7 @@ static const struct net_device_ops smsc95xx_netdev_ops = {
 	.ndo_tx_timeout		= usbnet_tx_timeout,
 	.ndo_change_mtu		= usbnet_change_mtu,
 	.ndo_get_stats64	= dev_get_tstats64,
-	.ndo_set_mac_address 	= eth_mac_addr,
+	.ndo_set_mac_address = eth_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_eth_ioctl		= smsc95xx_ioctl,
 	.ndo_set_rx_mode	= smsc95xx_set_multicast,
@@ -1471,7 +1473,8 @@ static int smsc95xx_autosuspend(struct usbnet *dev, u32 link_up)
 		/* link is down so enter EDPD mode, but only if device can
 		 * reliably resume from it.  This check should be redundant
 		 * as current FEATURE_REMOTE_WAKEUP parts also support
-		 * FEATURE_PHY_NLP_CROSSOVER but it's included for clarity */
+		 * FEATURE_PHY_NLP_CROSSOVER but it's included for clarity
+		 */
 		if (!(pdata->features & FEATURE_PHY_NLP_CROSSOVER)) {
 			netdev_warn(dev->net, "EDPD not supported\n");
 			return -EBUSY;
@@ -1922,11 +1925,11 @@ static u32 smsc95xx_calc_csum_preamble(struct sk_buff *skb)
  */
 static bool smsc95xx_can_tx_checksum(struct sk_buff *skb)
 {
-       unsigned int len = skb->len - skb_checksum_start_offset(skb);
+	unsigned int len = skb->len - skb_checksum_start_offset(skb);
 
-       if (skb->len <= 45)
-	       return false;
-       return skb->csum_offset < (len - (4 + 1));
+	if (skb->len <= 45)
+		return false;
+	return skb->csum_offset < (len - (4 + 1));
 }
 
 static struct sk_buff *smsc95xx_tx_fixup(struct usbnet *dev,
@@ -1955,7 +1958,8 @@ static struct sk_buff *smsc95xx_tx_fixup(struct usbnet *dev,
 	if (csum) {
 		if (!smsc95xx_can_tx_checksum(skb)) {
 			/* workaround - hardware tx checksum does not work
-			 * properly with extremely small packets */
+			 * properly with extremely small packets
+			 */
 			long csstart = skb_checksum_start_offset(skb);
 			__wsum calc = csum_partial(skb->data + csstart,
 				skb->len - csstart, 0);
-- 
2.25.1


