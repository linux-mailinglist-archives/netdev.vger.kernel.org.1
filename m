Return-Path: <netdev+bounces-261749-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MunOR1KoWnWrwQAu9opvQ
	(envelope-from <netdev+bounces-261749-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 08:39:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DBA1B4033
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 08:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC1953156B1F
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 07:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DE326B756;
	Fri, 27 Feb 2026 07:36:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB3620D4E9
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 07:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772177786; cv=none; b=AwdTVQN63DG+aF9oDgpHe7/lezQSXxYaeXWgKVzUhi/nd4G38RjAUXbLP7W+jsaAhSiNPTPC0rbmtCu5Am5VU/szuSxriO/yIlRRnSO8aIp5uXPeYGARQUJrLzRjtRlPeUmtUCEQsIpcTduwUXtRy6+X4oPnqlI9QzPSPFt4ZeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772177786; c=relaxed/simple;
	bh=oAGKgY2U2YKpp9PPl5aWF32BwD+p2XRKDNCA2cIY8HY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hveT4iA2sLfHTnUrEACpdImV+t2DU8c10HP1PBP9Qc3aLp2mjfB1QdjUAYIdUtMjMSjLEyvDU3bYcX1mIrEQWPq9bztP8XCKs/j5BnwBPebkURAn9UXxUSlB8WKeVVcWkAU6oR27Gg3ptNC5Hb7autJVYnGphhZiJPMRoZ+W7QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz16t1772177716t38f7826c
X-QQ-Originating-IP: P+lPzPZVhROiuqnYfZ/ZrNy3nlsfPVNUfeexQLXDYhs=
Received: from lap-jiawenwu.trustnetic.com ( [36.24.96.164])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 27 Feb 2026 15:35:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14891241328612078866
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
Subject: [PATCH net-next v2 6/8] net: wangxun: move ethtool_ops.set_channels into libwx
Date: Fri, 27 Feb 2026 15:34:48 +0800
Message-Id: <20260227073450.23680-7-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260227073450.23680-1-jiawenwu@trustnetic.com>
References: <20260227073450.23680-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: N6XSuZ3V4KqE92kIG74zbrFNQFPeE1/GBmMCSpKEgiOnWzPCYq7MQcFq
	eVt9ahXwXDkRDOBFYvd6CAXPhc9pEdDQSQQtWEsGpWhAzR00gX9kDBRfcin2DjsUM1Hnyhw
	OlHaBxN68T706SllGnyTvUyGEyO2rZKk2FV2ECnrSsdmj+oNIbu/A3HtsDu2TMVMZ1SF+hH
	9yLc+++HpsDcw0iaj+NQaSHZyqbR7YopMHiMOuauiuK1Du2BvDVT8GiAf89WBRVKd4M6+6O
	Evy9V2DOOK8aTKR1HUrcVaKOBEGUrG/tDmJzg74S3ZH+2K5iRLM40Rjw6S/+EbkNeFw3PS9
	Tcef35SE4XWEmROnNW35zh9CiqG49N/vz4q+4lUSnamWYoCjhLnsfAvA1iyr9ZsApTmR6/w
	ynhb0d2qPReS+nWfbPxFBKwAHbocVipuydMpF/zteU5330MrhKNEPkgzIpECgs5hRXWzegC
	Hz3QdapAHaO52nFbzmxu2hBffdZTkw78C0uSjNpkgtvaaPM5lhVgtIC0nmoeGD/IF273A0T
	g7uscXxLnxO4viWhT0+cBKeNZ5S+MVkUIgZ+dpMBrVDjQEWk50+X7IT3JJeF1P1FGXq2Oug
	Hvuirw3pYZe0SwIrniozC9lo5xzWHe7LjF4YUC9TvvSmV/WUYvnIg+PJveUSuNvelNcO7x9
	DvUpOjTCOayKcqOyM+7Og0J1b2MiU91sg6ZCNYo4TjgjJDvQsawmexDQwsTWtZ8zoflogLy
	HlcOGyH8B0d7YT1jrhdo30cuWe1aKA4Xut/jcpIWbPMtEPDup0qMtmlyBv3g4Heydzeg78a
	WT3TIxKny3ym0rbJZiW/v1PLmee+DP7iG/RHPTS95Y6hVsNSoNYmL8VpTNkc+NH0XflKm76
	Ctj2aDNT0QU/su8MvdGhNDsiCEyiQuxxKD7ScwaNKUow6v8+zmsvMGv0QSS9+pGbd4+N1MH
	RcJC6t+rfDgUTt+aPaZZCnjNG6hUyDNdstht6fxxyp9AnA4zdd8+5CYzRRPh+G7Zo2OfvhD
	48C5/zz/V4oE6zIH1EN8nJesbIkGoeddJKRImVCe7T7Newi+ASUXVHak9RSTMVkx2n2D/mr
	f8AXWiOpU0YQp4qZ9RfLng=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261749-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[trustnetic.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.970];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,trustnetic.com:mid,trustnetic.com:email]
X-Rspamd-Queue-Id: 41DBA1B4033
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


