Return-Path: <netdev+bounces-263011-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOjWGwVQpmmxNwAAu9opvQ
	(envelope-from <netdev+bounces-263011-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 04:05:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3AD1E84F6
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 04:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7A7330B1021
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 03:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90021375F96;
	Tue,  3 Mar 2026 03:04:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2EE19995E
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 03:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772507090; cv=none; b=Oa0IUIWLCDl7Jyz9WNUHccuTi3qmbPRKEXVLDGEbaNU1gJzfI59pR+XzRD/OYVTTc1MGkBRZEE9Vx7TdivJZHxraHCDgoGD6HwwKTgpBmjskGE+otq3SLKh46UiVLjlqQIYTJbm9viOwduJfXpEIy6eeL5FH/RJVfyT/3taaEKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772507090; c=relaxed/simple;
	bh=oAGKgY2U2YKpp9PPl5aWF32BwD+p2XRKDNCA2cIY8HY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WslPE8/UWHPJ8qauPUQ0aamJobCUvyUHPKEH9h6+J9OhOAaZyWY10zedNHCfzC+18eU5Wga/J+kXRBH1Rq++uUPe8FqKS4wczZjtN2d1c6oCt2MxX0rD/Sb7t+KQcn5OtU+I4RizOz2c2YUQbbaa8uZnOL03KgYFQELYhE3L0Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz19t1772507043t14bb7589
X-QQ-Originating-IP: MWarKqZYNU6Zw3wSTsJsd7coCjHGFl88VTJiAWxIELY=
Received: from lap-jiawenwu.trustnetic.com ( [125.120.70.252])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 03 Mar 2026 11:04:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10807151750713144265
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
	Kees Cook <kees@kernel.org>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Joe Damato <joe@dama.to>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v3 6/9] net: wangxun: move ethtool_ops.set_channels into libwx
Date: Tue,  3 Mar 2026 11:03:28 +0800
Message-Id: <20260303030331.24076-7-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260303030331.24076-1-jiawenwu@trustnetic.com>
References: <20260303030331.24076-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NrnJSkE52p6cZC62gExWTM9J//8otDBsTJDIVmP9RF7+gvCQR1m9cBqL
	6jLI63p0rMOhx7wP59Kk4E+d5Bs1Go79YeBA/wz4JJLqhLscq+rSlLlFLwx2vNEG9gYwWfC
	3CarTPkEwaPxXAGgM3PG/e0ezkS4Zd4XR9yXDpK6kPqmFttODTSXUv+h3rM4N5t1VPOPp6j
	EHaEUzF6seGxy9g2Ah0j7oyYxtWcj+vcwsN2oJ6GZ0Um4nrEN3foTLYMEyHLoBLtLkeFZys
	8dx6bcNHwy35P25MdbrxlKj/j+OCKtdg6nkRKG1XscHWyxA/46AubjyODXjzOqAgcWjTz1+
	tstQZSRzuFQw49FQIsy0Oc/rjFI2sBl5C6XjyK3LVc5/wnnUbLi7djQU/fTWCfryNdxVtvI
	4pxJ2BF72XsLuuwpyTzOqvuK5MxnxpQeiS3WeFCCXZ3kNFEiUTM9Wy+Tw1I96cF96PRGBpO
	mYlDPu3mTWnG2Gqxqi1VtzRHlrM9j4cr9haBHHlKcmiao7P/D5MfhngokhKKYkhVw8okrmM
	/L83To2pXycOeKJ77WDYMm8IuW38+yDyBZSQ3f8OPs8xjmOT2DTGz6VBQ1EMzrkJrjj6FZQ
	1I4BiPCrfbehw4BzCeHYW3nhjygbd9fJ+KPvbdmRtuvdw4Kj05SaohFU5PMOWF/nu58UEG3
	cIGxkixn2L07DpuuFIz2v3aIGwJB3kf8XmfjUn/KqIstjAVabV7YhvSEy5pdnpNkz1Macwi
	3+q5rHnOioNUGAXTxkiIIZwa8zTDGPAwenSPl1iXFN8nvaw4P4qfydfGM5kh8igWfCOBJr+
	mP4uOkj6K6FQtgVPn8xB9hQk1c1amh9G5XjTpxekzocwt9QYfzwSL38RDUfp9QANwGRboCp
	tz0utt9oYYhpimDEtnYHBpjOeGLBrI4Kz7GeHNsk8rPDsiEfh8oisbsIda3k/snR19JdpLT
	0x3k0veNwq5XlrKuGHfULkHHgup9N9GEjj4/YsGqJ69XwzaK+n1Q4jH/6wrfPIyGpPkI0GA
	DfHVp/1OJix5vWYFtNBAF9oQmW1YTnWB/G676sw+8meo7qf3GtIGqMahaYILZ5GkbdVjg+7
	m0v8eCzn/2RvomL7rGYwKQ3ZC+46sjMui9irzZEx0bo
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: DA3AD1E84F6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263011-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,dama.to,debian.org,trustnetic.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.817];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,trustnetic.com:mid,trustnetic.com:email]
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


