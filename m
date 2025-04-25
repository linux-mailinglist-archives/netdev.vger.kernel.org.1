Return-Path: <netdev+bounces-185872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5787CA9BF60
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 09:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BAA09A3C5A
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 07:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B9F22DFAC;
	Fri, 25 Apr 2025 07:11:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B19E22A4E3
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 07:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745565107; cv=none; b=TVFOoXmoEgZzOzPAjDQJ6xpb+JXTXmg5B8/Aeh089ffZdvwcE19AIHB2ovebLF15SssM/dIRG0QLt/bjOIrySsTu2Z/d0Go6BHqhncy7QHiBkKF81nCshy5qDtw9s2pLCyPItARHWkiLVIDDHVSiAvStdyPrTpEt6DVdQKC+DTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745565107; c=relaxed/simple;
	bh=/VgUpElTEeiMK3Ipm1SRCKDAY2vrmfOJRPBvkhluAbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qjLAOQ1Y6hTnlYxpC2u0ZUbXPreDPERa4j5iCZY8CqcEyiJnfrOLr3v5lmfvEa1TrK1nP7lpU/fpOQ1WjYeozH4za1eFbR/45LiJ+hXCpjqHs+Es5X6r7YI+WW7fo4HCTsz6lVyAO3zNKGEuXHSQym+0LgjDzN9nUFQ/nVhTAQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz3t1745565000t2dcf1c2c
X-QQ-Originating-IP: FTT8rHwW0iN6pfzbYBaRZ9DrTN8AwJNK8lkUymn+tQs=
Received: from w-MS-7E16.trustnetic.com ( [36.24.188.93])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 25 Apr 2025 15:09:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9025048391018927750
EX-QQ-RecipientCnt: 9
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	linux@armlinux.org.uk,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net] net: libwx: fix to set pause param
Date: Fri, 25 Apr 2025 15:09:42 +0800
Message-ID: <6A2C0EF528DE9E00+20250425070942.4505-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NhdiEwnVOUqEj+JixI75sdGEMN6TCsLgBe0dQAjlY0vYG55CjLooSNK9
	XMeOzimqOKbiU+R3cs7O7O+aQvKI0IeGqqKHJun1WCXPHa1KY7EIBOxKj1HG9jRyVvaSquG
	XUIhwostVEPSxDB4ks0ghWEuZteqdqirJhacPUanEvWzuK49t+bzJE6Uv1XcSwENu9JJDXX
	IrCAKmnucKAm0zdfGcb2R2QuPZfxvA+03vLjITkiEwPDeCy/dY/wzQHPIrbyiUcQvRjREAG
	HV6608blEV1LN9BLmLyz7WQrAgcGk3kEaN7kY3zwHReEgVpB8Jzyu8FKRTFMkc2L7PQYsAz
	lz4zLHy0ZPKqbXBemwuPN8iihBq3y10sfv9qcEBA2P9JJ1sH0yef6eGYXJQWWFJo6RH7lsp
	5zdkRKPtkVsyEGl941xoLvlHcU2vti2Xekk+s12ogkilsVWuRNlcPO5nhNbsITKj85FWcl7
	DgmI+m2vaX/JzyEjJUht8NqsTiALMopuM5McxZ6xlxnpExWFZpCndJN7DTUP92CvkIc0KXr
	Rh1jtmwTIrI0By07hzw+qOdzx+1GKSS8kU7qoMRdoosG65SayLe1rPerzHLHYt/F9SfQYQd
	XvECzZS2IslEKdCSmN1Cy6bX9WEgrJDclljlUI9PXxC1Alq8C2PXYBGTbhzXgKGeJFzLQO7
	gA81Ilz4F3RuXIjxTOcgZAauj5sF4ssXAITZ1RtiuwWbMmi5mGHlO5rC4yQxvZihjfrsDOZ
	vMr193PLvdHRxKdNtb4Ti8RQzUKsgr+xqJDlrG8fbC6zb+3JG7pY+V9IrWwxPhbLuJY7mNZ
	l8D+RRQmbVFGIWVZjnxoNDiTUoTJILfWayl0xdNFepFg8z8sKBpilv/5mAib+run0h34rIm
	dNJtsSNr2elPqCn138eufJT3RMIa1yOCbCVT7YFNMOIzZeb3m2f4Wpk/86ldCNJqiLiyPSL
	oYBZgU+KVZzvIdXOSw+mDolJhI3fP9WckpFzNPhcKpw/s9x8UCJms0pzHo2xtDWeOyZ5JEG
	+LoBczL05uEPl+bcGs
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

For some interfaces like PHY_INTERFACE_MODE_10GBASER, no link events
occur when the manual pause modes are changed. So add extra judgment to
configure the MAC.

Fixes: 2fe2ca09da95 ("net: wangxun: add flow control support")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_ethtool.c | 11 ++++++++++-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c      |  3 +++
 drivers/net/ethernet/wangxun/libwx/wx_type.h    |  2 ++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 43019ec9329c..1b4f97ecee4a 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -266,11 +266,20 @@ int wx_set_pauseparam(struct net_device *netdev,
 		      struct ethtool_pauseparam *pause)
 {
 	struct wx *wx = netdev_priv(netdev);
+	int err;
 
 	if (wx->mac.type == wx_mac_aml)
 		return -EOPNOTSUPP;
 
-	return phylink_ethtool_set_pauseparam(wx->phylink, pause);
+	err = phylink_ethtool_set_pauseparam(wx->phylink, pause);
+	if (err)
+		return err;
+
+	if (wx->fc.rx_pause != pause->rx_pause ||
+	    wx->fc.tx_pause != pause->tx_pause)
+		return wx_fc_enable(wx, pause->tx_pause, pause->rx_pause);
+
+	return 0;
 }
 EXPORT_SYMBOL(wx_set_pauseparam);
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index aed45abafb1b..2a56c9fdb3e8 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -2450,6 +2450,9 @@ int wx_fc_enable(struct wx *wx, bool tx_pause, bool rx_pause)
 			wx_disable_rx_drop(wx, wx->rx_ring[i]);
 	}
 
+	wx->fc.rx_pause = rx_pause;
+	wx->fc.tx_pause = tx_pause;
+
 	return 0;
 }
 EXPORT_SYMBOL(wx_fc_enable);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 4c545b2aa997..b1c6483c485a 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1067,6 +1067,8 @@ enum wx_isb_idx {
 struct wx_fc_info {
 	u32 high_water; /* Flow Ctrl High-water */
 	u32 low_water; /* Flow Ctrl Low-water */
+	bool rx_pause;
+	bool tx_pause;
 };
 
 /* Statistics counters collected by the MAC */
-- 
2.48.1


