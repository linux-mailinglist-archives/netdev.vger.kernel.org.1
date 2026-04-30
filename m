Return-Path: <netdev+bounces-282699-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJg5BzkS82k4xAEAu9opvQ
	(envelope-from <netdev+bounces-282699-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:26:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3B049F371
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16A5B301FFB2
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 08:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADA13FB06F;
	Thu, 30 Apr 2026 08:26:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B541B4F09
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 08:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777537583; cv=none; b=rVliOoMQ1xtOvmWqaZkG+Q9NqbAgwNEOEouWn3h1E1tUqbFI9tr8OHtdb+8y5FGcGwiQXRDa1NkYTU/urjQhfpn7BkvWWT8NZtBg3YMhs5BFV1cAsvcNdDre4PMwRkx/udnQxGtNq4nenHyaQtd24eXN+6kTR1TfA1auErfJFoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777537583; c=relaxed/simple;
	bh=lYTToc3f6kN0b5B2yupR0EbkZkheODMJ04V/Ay1fGJY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oepN0ITISG5tgml7pJV1PY9dc5+ZSc/7MnraKb7tpYyDK1CEtSJt/pxmyLBf4Ut26I1J7bEsquN7B6h3PpbK8XGCNfj0UX66N4vyW48HkII6gZ2Bg03JbO+/Zg8KTNFA8j5EC+RmZn1e/PC2DNjBLouXeAoMCXv6pf4bh15Fe3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz3t1777537552t72caa075
X-QQ-Originating-IP: 31tYquZ8PmkgW5/hkfYXKCX3feAEZY7PubM3oD3ik4Q=
Received: from lap-jiawenwu.trustnetic.com ( [122.235.155.141])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 30 Apr 2026 16:25:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2925687999429587953
EX-QQ-RecipientCnt: 17
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
	Kees Cook <kees@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Joe Damato <joe@dama.to>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v2 4/6] net: wangxun: extract the close_suspend sequence
Date: Thu, 30 Apr 2026 16:25:15 +0800
Message-Id: <20260430082517.19612-5-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260430082517.19612-1-jiawenwu@trustnetic.com>
References: <20260430082517.19612-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Nop0iFvUVq8tYOmbNAz7pfPbaC3YUQsVR28+AcuF+evfiYLZXznmKkYW
	IDRA/RSqGRNhYKPP63m5Ka7gFy6GHDgOBcNbm4GQ4Xax/TVVIF182h4fP3Fhviutm9jE2Z9
	uxXU1iHCjJ54V+b5qpmdAKBBJ1QN35056H1oKEzZgj5hZWTOjgrNX1pRrrZrVhdY6lkZ7Bh
	FK+rKs9DlGIzmUhx08mCmqVLG4OgpIUvCz0CmnYV4YQauLNYrpRFvW10nF3uop2kUg/Hnoa
	/jnDDn1g/OZCUQMBaJh84/Pq+ImaAYtsdBJClKjvw2Ho8vOAyQFxiL49V3Adv9b7EbYEsZI
	E/E8bJ5uJzw5iffa/kwUyfwNBobUuHNdjRBCcRIi+eRcRsZ7xHr2UxVLw5RAYWdrBd55ttn
	cbKd1rdsKYMYDaQv+kcTAkVnbh2nXHBUt2RCzD1vslKbjYjLzhm4lNZyEMkc0xnLYksXG/A
	UARaalUno9m9DeGPzWnymSiec0xX/uGWNqayEC9FNgSDe+UNJaHkbTopm+UQLKG8QS3ws1Q
	WaTgPd1kv4lWlPOh1AzXUT3lYj0j06ykn9xRZmdc2WUYcOWpaHaWb8jvcZW74aNnN0CCqm5
	ay5uIOjplRi6jFHlWJDzWAx2GIxhBSwEtYrtmgAvnAP9GeU0E5865KQAAFSEKvK4jQdxKNF
	r2IP74i/O4rsJkZkVeH2LyNI0mmV+qOLo6D9ufenerPARCsnOpZLL6j1KFuyJ9RkCKq46+8
	+RkPg1x8WoZ8jXBrNQfP8/SvmqSSVRiNF3PLh3v/YzuwMSJGyD/xRN260hHm0oRRRTf132p
	/I1onrX3SymMUG8rl6b3GQo5Kap9L/oHDIAFBYwJStFZV/KEn8HmyvJxH0iHbBxe38Qp5Yi
	lPA4fQ4VwRvvIWiutUYToAzg1Lu+X81KP7NFGEJJn8j8Keco2HjC69bTBVaZ1I2s7kmC4Kv
	idkj/ArDSqeRTp8/i81/cjyWp9+CDRJJiopyyFVEuHJ68dShFRyFD6B4G6YN7+Y4Gq5nSHk
	demxYV13z811ehdE4TwaeYp+XjACrwWkz43kj0Vw/1LHQXYIdjLeH/3ZCqkUZqSkpvbhRfn
	8tkYnU9p78k
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 6E3B049F371
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282699-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,debian.org,dama.to,trustnetic.com];
	NEURAL_SPAM(0.00)[0.934];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trustnetic.com:mid,trustnetic.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Refactor the .ndo_close implementation by extracting the necessary
hardware shutdown sequence into a dedicated close_suspend function.

This is for later implementation of PCIe error callback function in
libwx.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  1 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 20 +++++++++++++------
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |  1 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 13 ++++++------
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  1 +
 5 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 671ac0a19dee..4b72835ddec1 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1403,6 +1403,7 @@ struct wx {
 	void (*configure_fdir)(struct wx *wx);
 	int (*setup_tc)(struct net_device *netdev, u8 tc);
 	void (*do_reset)(struct net_device *netdev, bool reinit);
+	void (*close_suspend)(struct wx *wx);
 	int (*ptp_setup_sdp)(struct wx *wx);
 	void (*set_num_queues)(struct wx *wx);
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index ec14dd47cd42..2bd00eade11d 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -135,6 +135,7 @@ static int ngbe_sw_init(struct wx *wx)
 	wx->mbx.size = WX_VXMAILBOX_SIZE;
 	wx->setup_tc = ngbe_setup_tc;
 	wx->do_reset = ngbe_do_reset;
+	wx->close_suspend = ngbe_close_suspend;
 	set_bit(0, &wx->fwd_bitmask);
 
 	return 0;
@@ -510,6 +511,16 @@ void ngbe_up(struct wx *wx)
 	ngbe_up_complete(wx);
 }
 
+void ngbe_close_suspend(struct wx *wx)
+{
+	wx_ptp_suspend(wx);
+	ngbe_down(wx);
+	wx_free_irq(wx);
+	wx_free_isb_resources(wx);
+	wx_free_resources(wx);
+	phylink_disconnect_phy(wx->phylink);
+}
+
 /**
  * ngbe_close - Disables a network interface
  * @netdev: network interface device structure
@@ -526,11 +537,8 @@ static int ngbe_close(struct net_device *netdev)
 	struct wx *wx = netdev_priv(netdev);
 
 	wx_ptp_stop(wx);
-	ngbe_down(wx);
-	wx_free_irq(wx);
-	wx_free_isb_resources(wx);
-	wx_free_resources(wx);
-	phylink_disconnect_phy(wx->phylink);
+	if (netif_device_present(netdev))
+		ngbe_close_suspend(wx);
 	wx_control_hw(wx, false);
 
 	return 0;
@@ -547,7 +555,7 @@ static void ngbe_dev_shutdown(struct pci_dev *pdev, bool *enable_wake)
 	netif_device_detach(netdev);
 
 	if (netif_running(netdev))
-		ngbe_close(netdev);
+		ngbe_close_suspend(wx);
 	wx_clear_interrupt_scheme(wx);
 	rtnl_unlock();
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
index c9233dc7ae50..eb5c92edae06 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
@@ -126,5 +126,6 @@ void ngbe_down(struct wx *wx);
 void ngbe_up(struct wx *wx);
 int ngbe_setup_tc(struct net_device *dev, u8 tc);
 void ngbe_do_reset(struct net_device *netdev, bool reinit);
+void ngbe_close_suspend(struct wx *wx);
 
 #endif /* _NGBE_TYPE_H_ */
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 9887638203cb..3bfb3328b8f3 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -415,6 +415,7 @@ static int txgbe_sw_init(struct wx *wx)
 
 	wx->setup_tc = txgbe_setup_tc;
 	wx->do_reset = txgbe_do_reset;
+	wx->close_suspend = txgbe_close_suspend;
 	set_bit(0, &wx->fwd_bitmask);
 
 	switch (wx->mac.type) {
@@ -503,10 +504,12 @@ static int txgbe_open(struct net_device *netdev)
  * This function should contain the necessary work common to both suspending
  * and closing of the device.
  */
-static void txgbe_close_suspend(struct wx *wx)
+void txgbe_close_suspend(struct wx *wx)
 {
 	wx_ptp_suspend(wx);
-	txgbe_disable_device(wx);
+	txgbe_down(wx);
+	wx_free_irq(wx);
+	txgbe_free_misc_irq(wx->priv);
 	wx_free_resources(wx);
 }
 
@@ -526,10 +529,8 @@ static int txgbe_close(struct net_device *netdev)
 	struct wx *wx = netdev_priv(netdev);
 
 	wx_ptp_stop(wx);
-	txgbe_down(wx);
-	wx_free_irq(wx);
-	txgbe_free_misc_irq(wx->priv);
-	wx_free_resources(wx);
+	if (netif_device_present(netdev))
+		txgbe_close_suspend(wx);
 	txgbe_fdir_filter_exit(wx);
 	wx_control_hw(wx, false);
 
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 1e373f7fd9b5..cd50ff1ef2ed 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -314,6 +314,7 @@ void txgbe_down(struct wx *wx);
 void txgbe_up(struct wx *wx);
 int txgbe_setup_tc(struct net_device *dev, u8 tc);
 void txgbe_do_reset(struct net_device *netdev, bool reinit);
+void txgbe_close_suspend(struct wx *wx);
 
 #define TXGBE_LINK_SPEED_UNKNOWN        0
 #define TXGBE_LINK_SPEED_10GB_FULL      4
-- 
2.51.0


