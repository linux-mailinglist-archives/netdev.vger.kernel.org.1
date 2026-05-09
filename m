Return-Path: <netdev+bounces-286137-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBgtEUYH/2lg1QAAu9opvQ
	(envelope-from <netdev+bounces-286137-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 12:07:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C804B4FF18A
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 12:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C759E3021B15
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 10:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7930C3914EE;
	Sat,  9 May 2026 10:06:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E440C3A0B3B
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 10:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778321194; cv=none; b=p7UUg+uUvGe+e0LNFAmsnw9TborRJkWiCgucvN/kgNZrGQgAPLit9gvTAs2RGj3wQP/E1/uT05/Y4LXr9UvSj4WNErjWUS3gIGTbjvXVYjXM2JO/WKm/gKi+AN/NqC/cphJDRZ8rwLSKSyWflSZDXLSRnxPs2NcLUwY/Fud0WhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778321194; c=relaxed/simple;
	bh=ZX/VmsaFSinIMxLvnekKmzxlMhfBTah8SLSu0IbbOOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PUuoUxDtkBdhpfjLiR0v20wNrOOxvBIReyHdQ9SzAxzQKuXrA8Xth0MkKCnbJKBFbh+XBsPdEkCUv84ytuxAemO/pbwe4uMTb8CEM1hKpJGo6hoeKdUS4jBBuw0/XcDgkE/bqSeA51FTIPAGKJiCtR+OI5mlAxU8oPWGehyhG9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz17t1778321159t9cf266c4
X-QQ-Originating-IP: 6jeU2ycNxOfX6WNIRKRaOVPaCNTy62+aNRx/veos5xA=
Received: from lap-jiawenwu.trustnetic.com ( [115.204.251.157])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 09 May 2026 18:05:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18185282068799683786
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
Subject: [PATCH net-next v3 4/5] net: wangxun: extract the close_suspend sequence
Date: Sat,  9 May 2026 18:05:39 +0800
Message-Id: <20260509100540.32612-5-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260509100540.32612-1-jiawenwu@trustnetic.com>
References: <20260509100540.32612-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MaHg5zel0g/X/eZ8Gl7agS3HSqu2uvAQ4XtZ+4f1b92cK8B3lXxA1uFr
	YzIXCApY7X6b5cWP9BDO+O+ENsrwGSiEaMk4vCrD8MkQkxw1Qn4hkw/KkwFlow9BbVdwaYf
	vt5zH8yI0UPdQzzc43YliO3LvnAm1zhYy80r3fJgkhunaAU+bh+9xc66pPnt7Sd5ksu6VPC
	xG9fU4C14+L6CNIf28wD38PUv2fgFk9MsV9bJHtS2Rn+arW3VvFRoe/DpY5nxcmeTSRTINF
	1MxL13tiLQYRBBPXOy8uGIuW2xGN0oCyiuKQ8s/HnorAiS2QxjuGrl9r+Vnyndvm1Sb+7fu
	17/n9BLTXF5ZCGEEJ1IyefEafF8b8J1ve09+AvnzzCrFkcSN86egae1oWnGNFFMSq87+Nvr
	qyoi0pddzRKQu+8HQPHiZWqyDguQhUeFpNmkC23z/GaZ/6cq6OEe64eln6ijPECHriNgM/J
	BIyVGEDAgb4tP9RNfQKAP2JHuGdgefEN/kqXukohjYnUA83DJV8XQ/8rhr3dSNPmUE/Amge
	mgeJujT1Yo/ui9m8s4HW6l2S1cOP9vnRUGp2EkGUongJkL5SdJyRw2b4ttgyrqqJFMAwri/
	AmQyM0/rXpfn+zpu+q6FTShUpv+VoYWK20qHij39SLaGBFM6KX/6S3/qlVjU5m8GutfTpGZ
	a7r/EaMJZlO4lap8zWoilLs/wlSnp6OynwFlz6neOs7oa9JHh2RXiRE14aBxsZuqYQ//MK/
	hGXtbcIW0Pf37fJ1nB5EWdTbqd+dM5AklPvwdbWE0qZtrEQZAVi7AAyoGqAZT4cxHcDj/b6
	t9z8tKDX+AU/6CBC4YLq1eEWrnoo2DSQ8ejpehJDIAxw155nyyeVIX2LSTkj9WNRo/Xf/NB
	jM76J9e4kCgb3wl7PlnotNDAZ/E1I+WpTYKy/rZtV6GNwvDFn9Ic1WLDgPBJFV0pA1hXsmS
	anCbIXrPz/PSwn+e0/MgxGxkzbShRjZFa+6HIESHMuDK6q5cuQ+i9AHQMsVc3uDZHIN1K1i
	1eAa/qMd6BIr76568AweJFmagZfow9ZgqaiBRwPrunLAs15ie7+Bd90dgoHYgc53vvfnNT5
	HF0sUOlqLqkjl86Q9Uw/wSkcFqJeVatRQ==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: C804B4FF18A
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
	TAGGED_FROM(0.00)[bounces-286137-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,debian.org,dama.to,trustnetic.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.626];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,trustnetic.com:email,trustnetic.com:mid]
X-Rspamd-Action: no action

Refactor the .ndo_close implementation by extracting the necessary
hardware shutdown sequence into a dedicated close_suspend function.

This is for later implementation of PCIe error callback function in
libwx.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  1 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 21 ++++++++++++-------
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |  1 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 16 +++++++-------
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  1 +
 5 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 33051ce82cb3..c3befb272274 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1408,6 +1408,7 @@ struct wx {
 	void (*configure_fdir)(struct wx *wx);
 	int (*setup_tc)(struct net_device *netdev, u8 tc);
 	void (*do_reset)(struct net_device *netdev, bool reinit);
+	void (*close_suspend)(struct wx *wx);
 	int (*ptp_setup_sdp)(struct wx *wx);
 	void (*set_num_queues)(struct wx *wx);
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 4b70390936d2..891f057470d4 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -135,6 +135,7 @@ static int ngbe_sw_init(struct wx *wx)
 	wx->mbx.size = WX_VXMAILBOX_SIZE;
 	wx->setup_tc = ngbe_setup_tc;
 	wx->do_reset = ngbe_do_reset;
+	wx->close_suspend = ngbe_close_suspend;
 	set_bit(0, &wx->fwd_bitmask);
 
 	return 0;
@@ -512,6 +513,16 @@ void ngbe_up(struct wx *wx)
 	ngbe_up_complete(wx);
 }
 
+void ngbe_close_suspend(struct wx *wx)
+{
+	wx_ptp_stop(wx);
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
@@ -527,12 +538,8 @@ static int ngbe_close(struct net_device *netdev)
 {
 	struct wx *wx = netdev_priv(netdev);
 
-	wx_ptp_stop(wx);
-	ngbe_down(wx);
-	wx_free_irq(wx);
-	wx_free_isb_resources(wx);
-	wx_free_resources(wx);
-	phylink_disconnect_phy(wx->phylink);
+	if (netif_device_present(netdev))
+		ngbe_close_suspend(wx);
 	wx_control_hw(wx, false);
 
 	return 0;
@@ -549,7 +556,7 @@ static void ngbe_dev_shutdown(struct pci_dev *pdev, bool *enable_wake)
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
index 79909e3b1d8e..ae91379d847d 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -417,6 +417,7 @@ static int txgbe_sw_init(struct wx *wx)
 
 	wx->setup_tc = txgbe_setup_tc;
 	wx->do_reset = txgbe_do_reset;
+	wx->close_suspend = txgbe_close_suspend;
 	set_bit(0, &wx->fwd_bitmask);
 
 	switch (wx->mac.type) {
@@ -505,10 +506,12 @@ static int txgbe_open(struct net_device *netdev)
  * This function should contain the necessary work common to both suspending
  * and closing of the device.
  */
-static void txgbe_close_suspend(struct wx *wx)
+void txgbe_close_suspend(struct wx *wx)
 {
-	wx_ptp_suspend(wx);
-	txgbe_disable_device(wx);
+	wx_ptp_stop(wx);
+	txgbe_down(wx);
+	wx_free_irq(wx);
+	txgbe_free_misc_irq(wx->priv);
 	wx_free_resources(wx);
 }
 
@@ -527,11 +530,8 @@ static int txgbe_close(struct net_device *netdev)
 {
 	struct wx *wx = netdev_priv(netdev);
 
-	wx_ptp_stop(wx);
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


