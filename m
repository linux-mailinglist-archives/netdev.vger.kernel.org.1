Return-Path: <netdev+bounces-190979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37316AB98F6
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 11:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DA603AA74F
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 09:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A4B22F386;
	Fri, 16 May 2025 09:34:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE71522FAF8
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 09:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747388069; cv=none; b=WRyGuLpX/e0fnf3Gwd2hwR5sgIl+mYIjXaqozIFanB2aPsO//f2GXbzGq8V6M4Lg1jLcYaIGzUf93TRMPPihSXkiOo5I6d05rJT2VYSW0XNAiu6802BhPM72wwm3Y3OGc6qa93QxD9KvOduFY+gpp3AjGKzsKDqt3z42DmcZoBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747388069; c=relaxed/simple;
	bh=XDtDgQl5o+dwE+H9DVQmPRSzDXMYFiXMN610xWSFjkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qjan+OIk1EyRSOABCZLQ2Om18ZfW4f8+KOr8sy5sv8b/vXlS0RJupnq5KyrrrFVmv3+Kuzdgkl5tB4wE8syQ+myQnd93VZf5kWM8UlUmxgdBeZ+jlBmuAwRZM4Z6CT1bWSJk97ihOCIBuPuntLYlo0cDa55VoIkvOu+3ejKRkRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz17t1747387973tcb667559
X-QQ-Originating-IP: A33E0v/fMzlOzYeY/WhRZl/77/VVIwLUiHWcpewg95g=
Received: from w-MS-7E16.trustnetic.com ( [122.233.195.51])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 16 May 2025 17:32:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4063943926388249656
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	richardcochran@gmail.com,
	linux@armlinux.org.uk,
	horms@kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next 6/9] net: txgbe: Correct the currect link settings
Date: Fri, 16 May 2025 17:32:17 +0800
Message-ID: <48E2D9072A4EF7A0+20250516093220.6044-7-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250516093220.6044-1-jiawenwu@trustnetic.com>
References: <20250516093220.6044-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MhRA+Wg7eZqsJex1Y2U6Sos/ElgG0LkeM41sbjkumwgx02Rqc7glFKTW
	9TWDPfPoDHYaADARC2jNzSA8AW3crLm9du7rpN9oDnq5Bkqo6x/CA+MF1Uzgr6BjjxYVVJ0
	OswB5e5cvQ5xlVsrhlSXG44Ktocm6+biQKFHmTi41LaOlNynJEiuYTXQMKGXfWHasSut0Xu
	F/gvWIWMgFCy1HhD79JA0BoDHwCiz0zueHv3dn+R9M10Z3VeMo7h5D6piIkVTFquRyfoIMh
	tea4R0OVsJMqj90kSDSk8PZ5B0owTTjT5mhhJi1R7gj6c5xs5PN8yY097grkmWnPqutUuJF
	Fx9uIP2oEJaIeklxehdPZM1D8HGn1Kq3fbJAEoo/52bU9wSlpwsHMoB1VjQh0aijs6C+U+y
	5/sciUljz2KWkoHSObwSBu7okgxn8zlgzA1eh54b4TgLpba0P2duY8QpBuGrsspNrQrfQPF
	pBsC63fvOs2kCoXmzxLGaa1NURUe7YcAFGz9UH5DheJoAXuBdzN5MraSbvwBBiLWoMnId+p
	LPSshuU7PkblXe1wzQNUy6kmmO/k9KuGxXIEKWBR7QDqNLBmnAt2KkfAFbPMGs3PNlAR/nu
	HBqhMt4KvEqx2LUv6oP+vpldZptjk1OtaQfhXLhFU/tnglMWGRMTXMw+zFZ9ufXeSR9rQGs
	psZ66QUO9q4mi8tQt0WPhXANQV5RpaRAJYpQKAWQJnph1JjIHwRBNmMf4dHrviLAKc6+3HA
	cI+1KKNdAskISclbyur//BPgZjx4mOr/2R5EIiWPq0c+Lf1IosNJlet7yDgpvrnChln2tDp
	aMGlSp1IlNvbg1I6ntt7i2lZUoCejiLw22n5H09BhR8t6WI+QW569zzs7Hs/4Ik1TvvFiHW
	9EnZPrFaAuqJGYwbRc+4Qz+KWSxaOVrmFwx6Itpabtbi/klRyB8XNCnYyLiFQzZHMlcDj+h
	ijq6vX45GSIp3jmc5m5LrU4QHFIJA6bQyhPGioPAdUto3xSjJdPdFrVt6y6sBsU4CWPPprr
	doxScaySI1io7+baPjTZSAazTUjayYZqu0b+bqBg==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

For AML 25G devices, some of the information returned from
phylink_ethtool_ksettings_get() is not correct, since there is a
fixed-link mode. So add additional corrections.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |  3 ---
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    | 27 ++++++++++++++++++-
 .../ethernet/wangxun/txgbe/txgbe_ethtool.h    |  2 ++
 3 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 86c0159e8a2d..c12a4cb951f6 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -231,9 +231,6 @@ int wx_get_link_ksettings(struct net_device *netdev,
 {
 	struct wx *wx = netdev_priv(netdev);
 
-	if (wx->mac.type == wx_mac_aml40)
-		return -EOPNOTSUPP;
-
 	return phylink_ethtool_ksettings_get(wx->phylink, cmd);
 }
 EXPORT_SYMBOL(wx_get_link_ksettings);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
index 78999d484f18..fa770961df5f 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
@@ -12,6 +12,31 @@
 #include "txgbe_fdir.h"
 #include "txgbe_ethtool.h"
 
+int txgbe_get_link_ksettings(struct net_device *netdev,
+			     struct ethtool_link_ksettings *cmd)
+{
+	struct wx *wx = netdev_priv(netdev);
+	struct txgbe *txgbe = wx->priv;
+	int err;
+
+	if (wx->mac.type == wx_mac_aml40)
+		return -EOPNOTSUPP;
+
+	err = wx_get_link_ksettings(netdev, cmd);
+	if (err)
+		return err;
+
+	if (wx->mac.type == wx_mac_sp)
+		return 0;
+
+	cmd->base.port = txgbe->link_port;
+	cmd->base.autoneg = AUTONEG_DISABLE;
+	linkmode_copy(cmd->link_modes.supported, txgbe->sfp_support);
+	linkmode_copy(cmd->link_modes.advertising, txgbe->advertising);
+
+	return 0;
+}
+
 static int txgbe_set_ringparam(struct net_device *netdev,
 			       struct ethtool_ringparam *ring,
 			       struct kernel_ethtool_ringparam *kernel_ring,
@@ -510,7 +535,7 @@ static const struct ethtool_ops txgbe_ethtool_ops = {
 	.get_drvinfo		= wx_get_drvinfo,
 	.nway_reset		= wx_nway_reset,
 	.get_link		= ethtool_op_get_link,
-	.get_link_ksettings	= wx_get_link_ksettings,
+	.get_link_ksettings	= txgbe_get_link_ksettings,
 	.set_link_ksettings	= wx_set_link_ksettings,
 	.get_sset_count		= wx_get_sset_count,
 	.get_strings		= wx_get_strings,
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.h
index ace1b3571012..66dbc8ec1bb6 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.h
@@ -4,6 +4,8 @@
 #ifndef _TXGBE_ETHTOOL_H_
 #define _TXGBE_ETHTOOL_H_
 
+int txgbe_get_link_ksettings(struct net_device *netdev,
+			     struct ethtool_link_ksettings *cmd);
 void txgbe_set_ethtool_ops(struct net_device *netdev);
 
 #endif /* _TXGBE_ETHTOOL_H_ */
-- 
2.48.1


