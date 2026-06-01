Return-Path: <netdev+bounces-293590-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPn4CoMzHWoqWQkAu9opvQ
	(envelope-from <netdev+bounces-293590-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 09:23:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC9561ACF3
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 09:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C09D2300B985
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 07:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999AA38399B;
	Mon,  1 Jun 2026 07:23:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1316B367B82
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 07:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780298623; cv=none; b=ZBbuO3hSpz+SzRNqY68eLzqvh38wqkllqVq+RZ1/0m2GG2CBb3/ioNbWk9JEIJ2uUj5QFNUqWLZTf85gpHYXgxhuhI50QpVj0YBfxaA+ADNPEbe2cYhjzeIo9hKfDs86ZT2pGlMTjYUARFpAsA7DYmx0bL7KZWbdky3kGziKFc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780298623; c=relaxed/simple;
	bh=w0NtpWlY0v9CWP3TxjvPoox+ZZbwr9exnMcysIfxIcw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VbqdpbAT9Y5w2+01Dp/w/Ps3wEWb6+laMbzHYs/cXxcK0q/ms4Sdq/5+C8eNVSrcc/In+XPDftt+OLxDifxDU0AhXpOmAAVtm5dGaHj+Am6EaT4YxfRLkhaI0CKxI1eCrC845zhhrENMhL6wdqH0Gm/+AXkKWpcpboKGC2o4CL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz14t1780298562td235b2f3
X-QQ-Originating-IP: qNe7leLFqcjPztUjgH+i6NiriTRwBLarbDFVxvuwYEI=
Received: from lap-jiawenwu.trustnetic.com ( [183.156.95.204])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 01 Jun 2026 15:22:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8037164078413693200
EX-QQ-RecipientCnt: 22
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
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Joe Damato <joe@dama.to>,
	Breno Leitao <leitao@debian.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v4 4/5] net: wangxun: introduce soft quiesce callbacks for AER recovery
Date: Mon,  1 Jun 2026 15:22:20 +0800
Message-Id: <20260601072221.2952-5-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260601072221.2952-1-jiawenwu@trustnetic.com>
References: <20260601072221.2952-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NovCFWrsOaVAE8+0Oyn0NQeveR2WSPuFaqqORU3hm7LKrKwqcWLJ9eld
	K+0imxbkQ7pFodHBjfkq04nzACMACpxegzW2lAFjXRTPGF3iBoY6jfg1NSJvTa2BR6Hrgp5
	nQzccWozu55TfURBYlg9CTEPpnCiNdgJST0ubFRItvzupbQLJtqzrBJP88y3wtDJFv+XdEn
	cFhNQT5cWfDLpHK/7lardyxA+p44CTAlKZVuGmj/TFnmLC7QR8vU06QVqVzU453dNv0/ICt
	7QpcnC9+aiq6rKiX0Hk4wkzdc38Ie1eOV2sL56TcSmHB1MjItBTGh45uls1sOG3LsKfCAwQ
	/898cvCRHc6UAFaOCHY3XB6cmmRSFmkHCvFIaqC7jMDFSNJhx1o4T1lT0uJzBCDoynsYo1N
	5zDt9AwEErF1bfQekI+/+0X4LKRxSpveUW/eUJAJCIDynQzEI0HSXn25o2/sFM1qcy9D/4L
	0lL2iShYs33TJYIWLWvYkVH0Qj4uxTW4G4PW0RQiWwYdzQapLQR17UnOov1bvj1glyGL+xD
	DuGgH+b35Fz+AR8xyzmtNYw4YRsRaa2YKS8ZvFH0NrY2JWhO+FcBuJuzITbeUDmHYkEhlCn
	I1ie5e0U+smjZ4ZLb2KN+YXdOOq+yNGciVe2i75NLhcwm1BNmcXXkC6SBAdsPaTGOm5gtDn
	lBQwItMtKsgQe3BzC/T08RfVQ6c1f0aIXkqkv81JzmcZQ+W/XEp5wJuYgJrdRxhGOmeB8Qy
	hbLJrF35cDcpt9QWCNhBWdfb3zQBI5WlOq7zqiDvACWaOZwbvM6LJsvohVvgF6yRKqIAvBu
	bBaeqqFP834Dcr4X+e9Fw687EFJ2PcsyCyokOlCgysCp/7pPlckHjeUfWFtqFhRKWISGIsU
	fMYhSMSqu5d9ppS7gbH1hMmwe3kHVs8S3t5qmVpFrf+d15w/4aEzxCdUP3hAXGAdbukNymi
	xZSZvrhKm67TA6wcYF2Zwf+aiIS2Iu/DVHGU7AxGsO/VnAQtCXjbPzvTqU0ZTfTJgm61u+V
	TXxgwLpb4qHU1RxG+JKmDqX+Tjh9zspX/0lP3lyGbBf/L6i15YmuzIIavKi44u9eAv3x5jc
	4YIQ+u27FRqU6TXDZeWlCIjSpRIWNFjow==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293590-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,linux.intel.com,dama.to,debian.org,baylibre.com,sipsolutions.net,trustnetic.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.954];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,trustnetic.com:mid,trustnetic.com:email]
X-Rspamd-Queue-Id: 7AC9561ACF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce device-specific soft quiesce callbacks for ngbe and txgbe to
provide a lightweight shutdown path during PCI error recovery. It avoids
MMIO-dependent operations in PCI error status, for the later
implementation of PCIe error callback function in libwx.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  1 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 23 +++++++++++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 22 ++++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index a8b4e84787f4..1b25a52188f7 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1409,6 +1409,7 @@ struct wx {
 	void (*configure_fdir)(struct wx *wx);
 	int (*setup_tc)(struct net_device *netdev, u8 tc);
 	void (*do_reset)(struct net_device *netdev, bool reinit);
+	void (*soft_quiesce)(struct wx *wx);
 	int (*ptp_setup_sdp)(struct wx *wx);
 	void (*set_num_queues)(struct wx *wx);
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 3dc8342dd3a7..2484d3177034 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -47,6 +47,28 @@ static const struct pci_device_id ngbe_pci_tbl[] = {
 	{ }
 };
 
+static void ngbe_soft_quiesce(struct wx *wx)
+{
+	if (test_and_set_bit(WX_STATE_DOWN, wx->state))
+		return;
+
+	wx_ptp_stop(wx);
+	phylink_stop(wx->phylink);
+	pci_clear_master(wx->pdev);
+	wx_napi_disable_all(wx);
+
+	clear_bit(WX_FLAG_NEED_PF_RESET, wx->flags);
+	timer_delete_sync(&wx->service_timer);
+
+	wx_clean_all_tx_rings(wx);
+	wx_clean_all_rx_rings(wx);
+
+	wx_free_irq(wx);
+	wx_free_isb_resources(wx);
+	wx_free_resources(wx);
+	phylink_disconnect_phy(wx->phylink);
+}
+
 /**
  *  ngbe_init_type_code - Initialize the shared code
  *  @wx: pointer to hardware structure
@@ -135,6 +157,7 @@ static int ngbe_sw_init(struct wx *wx)
 	wx->mbx.size = WX_VXMAILBOX_SIZE;
 	wx->setup_tc = ngbe_setup_tc;
 	wx->do_reset = ngbe_do_reset;
+	wx->soft_quiesce = ngbe_soft_quiesce;
 	set_bit(0, &wx->fwd_bitmask);
 
 	return 0;
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index b37c9ed57cf7..816aba4a9099 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -296,6 +296,27 @@ void txgbe_up(struct wx *wx)
 	txgbe_up_complete(wx);
 }
 
+static void txgbe_soft_quiesce(struct wx *wx)
+{
+	if (test_and_set_bit(WX_STATE_DOWN, wx->state))
+		return;
+
+	wx_ptp_stop(wx);
+	phylink_stop(wx->phylink);
+	pci_clear_master(wx->pdev);
+	wx_napi_disable_all(wx);
+
+	clear_bit(WX_FLAG_NEED_PF_RESET, wx->flags);
+	timer_delete_sync(&wx->service_timer);
+
+	wx_clean_all_tx_rings(wx);
+	wx_clean_all_rx_rings(wx);
+
+	wx_free_irq(wx);
+	txgbe_free_misc_irq(wx->priv);
+	wx_free_resources(wx);
+}
+
 /**
  *  txgbe_init_type_code - Initialize the shared code
  *  @wx: pointer to hardware structure
@@ -412,6 +433,7 @@ static int txgbe_sw_init(struct wx *wx)
 
 	wx->setup_tc = txgbe_setup_tc;
 	wx->do_reset = txgbe_do_reset;
+	wx->soft_quiesce = txgbe_soft_quiesce;
 	set_bit(0, &wx->fwd_bitmask);
 
 	switch (wx->mac.type) {
-- 
2.51.0


