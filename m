Return-Path: <netdev+bounces-264694-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOhwI411qmnRRwEAu9opvQ
	(envelope-from <netdev+bounces-264694-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 07:34:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA8421C1C7
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 07:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 479EF3042940
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 06:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18C5371882;
	Fri,  6 Mar 2026 06:34:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A49371867
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 06:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772778841; cv=none; b=idhTMX4Nvs5vIYZJtZLrwvk9QKwrkJUZK0RlW9PheKl/t9CEDsdtducw/CAnqjnFR8M5aiOsX5KURBPP02ovUw01KkgVJoUy6I21ToLZYIUaKSnHXI9fcZbR8w5oy2ujia6WLoIBVjuHbXLtDoc6jTRwSE4zEZHx8PyhtmBpIS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772778841; c=relaxed/simple;
	bh=0P6Th2AA9HPFEDbA6PE3DormntvebDWvADhrZHe5iBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EK5yWou901zp67K1TGvGqJ0H+uqVgrWTBcE3St7GSMzAWp6LRYrDjxe4WtDiWTZnY0mwEur4hWgGedTLY0srv8028YcLT46KtNskauMQ8KqntoRw4an2m6w2ilAoDngNgdiVMvwpAGZMX9E1bHmIhSC6Ssu+DTCX5vKtQmnAiJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz3t1772778785t6c3b222c
X-QQ-Originating-IP: ha95oN1d0o3ZBtBF+pOfFqZzLBKxK8Cu0k/4o49Ho5U=
Received: from lap-jiawenwu.trustnetic.com ( [60.186.243.152])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 06 Mar 2026 14:33:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11482507724582654516
EX-QQ-RecipientCnt: 18
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Joe Damato <joe@dama.to>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v4 07/10] net: wangxun: move ethtool_ops.set_channels into libwx
Date: Fri,  6 Mar 2026 14:32:08 +0800
Message-Id: <20260306063211.20536-8-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260306063211.20536-1-jiawenwu@trustnetic.com>
References: <20260306063211.20536-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MudWgN0Vz5G/u+K27CzYLlrCT16/mOkhI+8LsdOPS1tUhDARHIGUoqx8
	H6IbGT5Vf9Gh3rqcJyxOJ/tdxDNvl9vVrZLHHV+wxFbh/GvRdGqc3J+P39LvTK62PfjnEoH
	dgS+1EAEE3ijGlsEda2d2GUHgl2aF9rGUXWH/pQwR3KFGXCWaaqmu7GBtNSI4rZIXbFNGQJ
	kjgaDacAQtlDgPJbnc4+TlXR2FrZYf3MLMmGQAB9MEh5zDVoUN15pI+TiHZdFX0D5R+Trxs
	Ml+WOcHhz4L52LX5CWn8LnqWxhZuPpjfeAfPtbDPX/hoT85jDp8zxIIE/ishHGRercrDyMi
	qdz/O9jceL7B9JQr3bW5BGDpI7gcUOmgkVX8dB5pkVVPKfcgp6J/kG3Wah2PC3bqgA2StmD
	iP7XYSPO/s/FrHIGJOHWDVEbLCrT29gwJ2V5Dx2ZyR8UY8+S4RyPfNg/7d9fDTSXoyCFNRp
	niCiakWHEK6s4RUOfdmnq5RHslrQ6vhcAnNMkvI2X9n5gjPCeJF/ttUKNNV1h4a/LcY1Xew
	XCxFyUB4aXxKRHG6iLGGH50n9YMzxyuloZcygzB2r8BRmJ7Mlr4b2EnUHk7+c1N/xGrJznK
	sNMwqFnx5q7xV7OERXMv1LU/XiLLlXZaF7kxhdlI0wbMvdn+YOPwcVrtYUYqj5TnUtrZPHi
	sBx6aZH5rHJ0lSKIQBffIxFbkPQlj3Oe2Mfe00c0vBf43NtWH+24fhmJiBB1swNKB9J/WDC
	xhX/W1dycvcMypIbdHlEJlykZ3fQ/B0hXPCbvL0yPg4Ztv2z4m5nlrjCcijRJnfiRGpEqDf
	/MLf9Cl5sZ6mylIOOZ3pD7Th/F98UCWTJIUATDwQR9GAw3Ann8S1Xw1G2OJwrauauRTLpa7
	C7yyXAd5De/DsqoK5FWlYilqyN4A79L3Q2hDEnrGMkVT4Ffn78e/ny/z4Xgu3ZB1Jcq/9mI
	sVDNMSzgchwUkzYIXjESrs3DTIsfZeHr4FranOYDtDOm75IF1MKS2jhc2yqkH70om+rOjoM
	Asw4igeuCi7LhuW7GyU8H5Ag7R12mJ5P4Sq952Ra7bFTPlPjPGHo01IW816AIUaG22ynu8v
	PQ7BSJJlm7Q5FSPgeuaQ2rbMMGObQ6OkScGsbwymvcW
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 0AA8421C1C7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264694-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,linux.intel.com,dama.to,debian.org,trustnetic.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,trustnetic.com:mid,trustnetic.com:email]
X-Rspamd-Action: no action

Since function ops wx->setup_tc() is set in txgbe and ngbe,
ethtool_ops.set_channels can be implemented in libwx to reduce
duplicated code.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_ethtool.c   |  2 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c  | 15 +--------------
 .../net/ethernet/wangxun/txgbe/txgbe_ethtool.c    | 15 +--------------
 3 files changed, 3 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 2fda1f6130c0..9ab7dce956e3 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -555,7 +555,7 @@ int wx_set_channels(struct net_device *dev,
 
 	wx->ring_feature[RING_F_RSS].limit = count;
 
-	return 0;
+	return wx->setup_tc(dev, netdev_get_num_tc(dev));
 }
 EXPORT_SYMBOL(wx_set_channels);
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index b86980c2418f..c37d108a85a1 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -67,19 +67,6 @@ static int ngbe_set_ringparam(struct net_device *netdev,
 	return err;
 }
 
-static int ngbe_set_channels(struct net_device *dev,
-			     struct ethtool_channels *ch)
-{
-	int err;
-
-	err = wx_set_channels(dev, ch);
-	if (err < 0)
-		return err;
-
-	/* use setup TC to update any traffic class queue mapping */
-	return ngbe_setup_tc(dev, netdev_get_num_tc(dev));
-}
-
 static const struct ethtool_ops ngbe_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ |
@@ -103,7 +90,7 @@ static const struct ethtool_ops ngbe_ethtool_ops = {
 	.get_coalesce		= wx_get_coalesce,
 	.set_coalesce		= wx_set_coalesce,
 	.get_channels		= wx_get_channels,
-	.set_channels		= ngbe_set_channels,
+	.set_channels		= wx_set_channels,
 	.get_rxfh_fields	= wx_get_rxfh_fields,
 	.set_rxfh_fields	= wx_set_rxfh_fields,
 	.get_rxfh_indir_size	= wx_rss_indir_size,
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
index c92eb71e0c15..fc5d98f38f66 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
@@ -91,19 +91,6 @@ static int txgbe_set_ringparam(struct net_device *netdev,
 	return err;
 }
 
-static int txgbe_set_channels(struct net_device *dev,
-			      struct ethtool_channels *ch)
-{
-	int err;
-
-	err = wx_set_channels(dev, ch);
-	if (err < 0)
-		return err;
-
-	/* use setup TC to update any traffic class queue mapping */
-	return txgbe_setup_tc(dev, netdev_get_num_tc(dev));
-}
-
 static int txgbe_get_ethtool_fdir_entry(struct txgbe *txgbe,
 					struct ethtool_rxnfc *cmd)
 {
@@ -589,7 +576,7 @@ static const struct ethtool_ops txgbe_ethtool_ops = {
 	.get_coalesce		= wx_get_coalesce,
 	.set_coalesce		= wx_set_coalesce,
 	.get_channels		= wx_get_channels,
-	.set_channels		= txgbe_set_channels,
+	.set_channels		= wx_set_channels,
 	.get_rxnfc		= txgbe_get_rxnfc,
 	.set_rxnfc		= txgbe_set_rxnfc,
 	.get_rx_ring_count	= txgbe_get_rx_ring_count,
-- 
2.48.1


