Return-Path: <netdev+bounces-256186-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAbNOkmrgWn0IQMAu9opvQ
	(envelope-from <netdev+bounces-256186-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 09:01:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9B2D5F00
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 09:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5020E3017242
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 08:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF223921F3;
	Tue,  3 Feb 2026 08:00:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3AB2264DC
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 08:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770105612; cv=none; b=HZqp0uCnxrkTwCUEC2y1zz6WnS44w6UvqZ5H7A2BJi15EEzzNdBbD5uVyKk/1po+jmxNUw9K5Dxl+4B+ZDtshLlP8oG9eM94jlQBCB/VKqMwKujTxovg53c/MsQRmDp/rwXhX6QLmD1nvaUNHMChWzV30TW0Mg52NTf+qRfGiqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770105612; c=relaxed/simple;
	bh=VbW7h1VgAex+Bu/ExpsNtN7phKN/Knq9x/YrXf74G64=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZavFslUMirDDrxS5+idFpXRUBKJp8bVOZtb6ag5OUUj90kx6AH3+24aEiZbEqE1fBf4HDI8ZIiEe9MwJGmj8RgudN9m+Wq+S1o4YIAvBzimd8LGZyO+wdtLKbECUO73PVnov2c/YDJFVL5FdvrXBDbOg3PxPr0anwISHRG41xXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz7t1770105510ted43ad1b
X-QQ-Originating-IP: KYD4tUjI24SuOKohqPflP3gdJ9fGhiRAT2vx8ofBTEU=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.47.234])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 03 Feb 2026 15:58:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3809538947437535087
EX-QQ-RecipientCnt: 9
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v1 5/7] net: wangxun: move ethtool_ops.set_channels into libwx
Date: Tue,  3 Feb 2026 15:57:57 +0800
Message-Id: <20260203075759.5852-6-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260203075759.5852-1-jiawenwu@trustnetic.com>
References: <20260203075759.5852-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NGKAM81q4BTs014ffE87QWF0buVMv4O6o8Y3oUNlHXC+m4xS7/NSOg/k
	LXh9OzcXmeSgnRfR3LFIdqZvqxLLnU5jsLwktxYx69SvI/7rgXfk+DSbPHgKuKiiUIV/3ca
	jN0UcUUQIVvgbOuowLKxXHlVVABYGupiW8c9ZODIfDfaESKE+J1+iKV4pG2llEQJCZBWkqh
	y7gIfADTHQGXc5Slmivy0LLNUymMpls8vNcfkAI9VwDYh+c6UIgHFbAiLFXfiKiHlmL19nL
	UCXrE41JvIo15uLygPoBJxK+pSbMiF9kS+i5O6pARQUICQvSbgtDjfr+xyNwGHNlXgsaV5l
	BRC0se6hsRXEzLRxmAgMvLBtSyxmJbwcK1LY0cYJbjQ0hISmjgYEuRTQYc7FV1cvOJHKc5p
	GQ8Ix8I3DnBqyd9qoueDIFIgWlqkfSo4TDHJaShEPan21jo8kcq+gy3vgTgt/Ls39ruAt+S
	WnnpdsbkjCqC0JA1YnLiPX5iIBP12CB1d/3rh0j+IN2yMrVv/HJcPpUfFJ0VXlcd01xwjAy
	IR0ENCThvePQMINbMUrljScR0DaEmnyMQ+VznQx05G7mFcU64vybLw0bUwoyqlgyn5hVqGJ
	EATk0gsHSeENqTH7zrmT8q7T0yz39//ZJ1bnQjZaVBn4ppq0DQvUemafVTfugQCI9b8kauO
	Q7vkUaH0fIFwFVgIGWEiNNRnKKcKSQk9Z1E90Fq0NMrKEQWBA1lf/pUwe0NF38mUlAiG+so
	VnIED1zodZLmHX60RAdADb0YRtd8J3BXox5UlmtbXX8PRaMF+jqPx4jvYo5b/kt9yShJx0q
	n6IFeWOF9Fgl0vARhzUGvOdK78C+aLhSE921hL44RbtV9cBGcj8SHZrk7nwYXQJY1Z0l/9+
	wu9almbsEXpLwIor2eaHEZM0MJBzCyvl35wwLPj85E5MahKbe9oRXH2vcxXIwiGG2OsFyxY
	GXbZAMHHjsRVQlZ9dKxhLxm3V68D+waDALB//sW2Wkj05+d3o6jD18zh1M7fSSHkp3cNgtH
	Es6cE37L+mafbeqkF5lfAq2CTDkcgYs892vRxqN9cJvKub9/8p3VSAFLksvdb9jDHkRmzwR
	6gZNIDSU1Lc65pjtcRbvxw=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256186-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[trustnetic.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trustnetic.com:mid,trustnetic.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6B9B2D5F00
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
index 9fd8cbe62f0c..27221e259aad 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -556,7 +556,7 @@ int wx_set_channels(struct net_device *dev,
 
 	wx->ring_feature[RING_F_RSS].limit = count;
 
-	return 0;
+	return wx->setup_tc(dev, netdev_get_num_tc(dev));
 }
 EXPORT_SYMBOL(wx_set_channels);
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index 1a3082c1d15c..8d23b1b248db 100644
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
index 183ec7f0166a..9e664279be12 100644
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


