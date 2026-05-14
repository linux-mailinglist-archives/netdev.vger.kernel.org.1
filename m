Return-Path: <netdev+bounces-287911-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCKnKJelBWppZQIAu9opvQ
	(envelope-from <netdev+bounces-287911-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:36:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0594D540713
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6CC7303FA96
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 10:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCA038237C;
	Thu, 14 May 2026 10:34:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B9836F919
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 10:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778754869; cv=none; b=reVTihvmv8cbj30TibLDxzyXsY/j2pBjNvjSfnCLZMPG0pNEw2Wvd6/gzjiPxDklHbLA9Rxep7UnqWF481NovjXYB3odte8E2UAwHy3f6b2XG/TM/JS1wfoYS6mKxjZvqD3Q+XQrWJHV+nhrue5qQ5IJfeKDP7AjderxtsspbPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778754869; c=relaxed/simple;
	bh=hLJo12U+SwRNbs/fFkXjH3riaOGF9epMHlFM5N56r1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Aoh0K0OA5GEtXZ45mA0x6pd7JaEki81o55xP2uxlM45XjAFjS0ivZZwgnj9F+anTa6ul2t9CkAqFF9IaZhSYOyBfGdrVR1WFCWvnvaOXUV/dqsWiC/BwzzkZPiEh6bWj/VByiyyL7hy7NqbdEwJ/ciHEWg/zFKntDXxr8RfXCn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: esmtpgz12t1778754853te30a8287
X-QQ-Originating-IP: Yij0+kIqukB3gyY98Wq/9mKuXQrEZpWhE5/5gjc3+LA=
Received: from localhost.localdomain ( [115.227.149.194])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 14 May 2026 18:34:12 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 1675344132411624728
EX-QQ-RecipientCnt: 4
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next 1/3] net: libwx: add support for set_ringparam in wx_ethtool_ops_vf
Date: Thu, 14 May 2026 18:34:03 +0800
Message-Id: <20260514103405.42175-2-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20260514103405.42175-1-mengyuanlou@net-swift.com>
References: <20260514103405.42175-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MZLZRaHLQI1R2jSYCWd8C/1DNCPk+gpmp2BklrkD9gx8du2IypQIsoiu
	MulDZAqpnK7wBV+B1RgVRXhcvCTS/SGGTPoCxy3Ip1Qu1gQ8TuzacFZqkGcoAzUFlJhQfIW
	pBpDdnYJRFrwCP6TvalQWetA+leXKAJP5TSOizwJgNiWddFG7f9UbYK11S4mUDQJaoOLKmh
	FMJjfrX4ratjbHQfPgzecn8uNrsdUgAAPF2BudUW9BfSTBIeKDrnKToCdgyNTqS/zoPKIAT
	QXQ88sF3noXOAr1m1iK2BZbH2tx178NhP1q31eT/XBcwmetRnSxuH/8OzcrzIQ0cXlx0EFZ
	PyESqWipJTVZxkmrlq4sk4CXxuhGd9IY5Yz79XHWrMcXdfMXT3fFHZ4AI6lDz5YfBhuq2IL
	1hx26x5+etuEfDDpFxSNFGjvsdaHCUxXkVhMFU41u+ds/xbGfiZAEMLo7MWsvu+xJdtNr/m
	JLI6NgPX0mP1UiHm0OImwltXBv+8v6Px0+XVWrThS5ZknPTdc2+aKmtRPRFJkZ4GNYL9Dti
	SdLkn87LNNld0i08SbXIeVtTt7c2LJmSuelCbHmDgvvEzfrkOOjnFIwwqoV7/0lZyHYEXP8
	gAA7dACYPfYTV1UD9rMNWbVXcQBNWNv33qcmoOnSlM/gD99p8iaOqREDM6h4knJ/HooiTmH
	6zBcr6JBuE88X8Sciua5drP5qou5+zV6p6qvio2tfFeERzRBPi2rwp6UOAeIKuVPZ8O6FUD
	yrmI1wknPqS4VGXaeY4FzcdX1rWCbM+gPFCcCwcSGTd3i6gBJg/oQtVGBTKC7dj66WTb2vn
	RUM7yEXX1u+NxFljwKG/qbU5kfr/GeO6STFz9evb9tMGw02nsb+GMnSLOuS0uOlh256luIs
	V4lBJdQFxRAkfmfYlJCdiragKFOGq0Xf5jbTTwu0OCE4lefjQYVQFOB/wyh4OBs+OuC83vW
	ad260lISrpyOaWFyJs1PwXJTDsUh4vH7XkepRYcTMS5tkMFYOwCrjkpiJcf9nLjCTaSSqVE
	vhv9Tp3nB7pcVfzvMXSFGvu/ggNFJWYyLgNnFF42peC04JQIAd7QcyJQ12eOARBXaJN2iBq
	U8Z7tS8DBpoYS03MjwF/zm89E5sfgWqpGYFqRqcVA4jTQ6oMKsYOS9Bs1xzGgdxknIASefv
	ZhYi
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 0594D540713
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[net-swift.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287911-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mengyuanlou@net-swift.com,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.965];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,net-swift.com:email,net-swift.com:mid]
X-Rspamd-Action: no action

Add support for the set_ringparam in wx_ethtool_ops_vf,
which is used to set ring sizes for ngbevf and txgbevf.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 60 +++++++++++++++++++
 .../net/ethernet/wangxun/libwx/wx_vf_common.c |  4 +-
 .../net/ethernet/wangxun/libwx/wx_vf_common.h |  2 +
 3 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index 5df971aca9e3..31034cd20870 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -9,6 +9,7 @@
 #include "wx_ethtool.h"
 #include "wx_hw.h"
 #include "wx_lib.h"
+#include "wx_vf_common.h"
 
 struct wx_stats {
 	char stat_string[ETH_GSTRING_LEN];
@@ -775,6 +776,64 @@ static int wx_get_link_ksettings_vf(struct net_device *netdev,
 	return 0;
 }
 
+static int wx_set_ringparam_vf(struct net_device *netdev,
+			       struct ethtool_ringparam *ring,
+			       struct kernel_ethtool_ringparam *kernel_ring,
+			       struct netlink_ext_ack *extack)
+{
+	struct wx *wx = netdev_priv(netdev);
+	u32 new_rx_count, new_tx_count;
+	struct wx_ring *temp_ring;
+	int i, err = 0;
+
+	new_tx_count = clamp_t(u32, ring->tx_pending, WX_MIN_TXD, WX_MAX_TXD);
+	new_tx_count = ALIGN(new_tx_count, WX_REQ_TX_DESCRIPTOR_MULTIPLE);
+
+	new_rx_count = clamp_t(u32, ring->rx_pending, WX_MIN_RXD, WX_MAX_RXD);
+	new_rx_count = ALIGN(new_rx_count, WX_REQ_RX_DESCRIPTOR_MULTIPLE);
+
+	if (new_tx_count == wx->tx_ring_count &&
+	    new_rx_count == wx->rx_ring_count)
+		return 0;
+
+	mutex_lock(&wx->reset_lock);
+	set_bit(WX_STATE_RESETTING, wx->state);
+
+	if (!netif_running(wx->netdev)) {
+		for (i = 0; i < wx->num_tx_queues; i++)
+			wx->tx_ring[i]->count = new_tx_count;
+		for (i = 0; i < wx->num_rx_queues; i++)
+			wx->rx_ring[i]->count = new_rx_count;
+		wx->tx_ring_count = new_tx_count;
+		wx->rx_ring_count = new_rx_count;
+
+		goto clear_reset;
+	}
+
+	/* allocate temporary buffer to store rings in */
+	i = max_t(int, wx->num_tx_queues, wx->num_rx_queues);
+	temp_ring = kvmalloc_objs(struct wx_ring, i);
+	if (!temp_ring) {
+		err = -ENOMEM;
+		goto clear_reset;
+	}
+
+	wxvf_down(wx);
+	wx_free_irq(wx);
+
+	wx_set_ring(wx, new_tx_count, new_rx_count, temp_ring);
+	kvfree(temp_ring);
+
+	wx_configure_vf(wx);
+	wx_request_msix_irqs_vf(wx);
+	wxvf_up_complete(wx);
+
+clear_reset:
+	clear_bit(WX_STATE_RESETTING, wx->state);
+	mutex_unlock(&wx->reset_lock);
+	return err;
+}
+
 static const struct ethtool_ops wx_ethtool_ops_vf = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ |
@@ -782,6 +841,7 @@ static const struct ethtool_ops wx_ethtool_ops_vf = {
 	.get_drvinfo		= wx_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
 	.get_ringparam		= wx_get_ringparam,
+	.set_ringparam		= wx_set_ringparam_vf,
 	.get_msglevel		= wx_get_msglevel,
 	.get_coalesce		= wx_get_coalesce,
 	.get_ts_info		= ethtool_op_get_ts_info,
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
index 94ff8f5f0b4c..a3361696b783 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
@@ -269,7 +269,7 @@ static void wxvf_irq_enable(struct wx *wx)
 	wr32(wx, WX_VXIMC, wx->eims_enable_mask);
 }
 
-static void wxvf_up_complete(struct wx *wx)
+void wxvf_up_complete(struct wx *wx)
 {
 	/* Always set the carrier off */
 	netif_carrier_off(wx->netdev);
@@ -323,7 +323,7 @@ int wxvf_open(struct net_device *netdev)
 }
 EXPORT_SYMBOL(wxvf_open);
 
-static void wxvf_down(struct wx *wx)
+void wxvf_down(struct wx *wx)
 {
 	struct net_device *netdev = wx->netdev;
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h
index cbbb1b178cb2..d45d5d8ac3ab 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h
@@ -15,7 +15,9 @@ void wx_set_rx_mode_vf(struct net_device *netdev);
 void wx_configure_vf(struct wx *wx);
 int wx_set_mac_vf(struct net_device *netdev, void *p);
 void wxvf_watchdog_update_link(struct wx *wx);
+void wxvf_up_complete(struct wx *wx);
 int wxvf_open(struct net_device *netdev);
+void wxvf_down(struct wx *wx);
 int wxvf_close(struct net_device *netdev);
 void wxvf_init_service(struct wx *wx);
 
-- 
2.50.1 (Apple Git-155)


