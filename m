Return-Path: <netdev+bounces-280373-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGSmBu+c6GlNNQIAu9opvQ
	(envelope-from <netdev+bounces-280373-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 12:03:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 133F6444646
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 12:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 00DE43014889
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 09:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28E03CAE75;
	Wed, 22 Apr 2026 09:57:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E249F34C9AC
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 09:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.80.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776851860; cv=none; b=lu+nHV7AEiWj1Kt6JZ89uN7h9IdWWlQh2pnQ5cIN6o6UAPZ6HaWHeSqIgNp8coyGUHDpRjG5CvKjL+D793kTtI6WDKV8Qeq8nfAKhThpaQfKe67j9GSBtYrOPPcS4KUdItGpq7E+g8hUsawJ71CKT07K5e9joaa6CwifyCAMHAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776851860; c=relaxed/simple;
	bh=ROKXz7YF6h4iQ+4GMBlI+f7HlGCkV8aFapmEXilQTaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SiBdJoLLgGiRsDPrpthQNuPONGclAaV5Id1icqArrQeZ9G/Dg5rnOklH0NwgMRUWETjo9jJ+UiX5alTNjGx3eytcZOAJXVl9KXMFIalZeN3eij6Tb5HogXhSEe95UMDv1o0CeD8GSngjRukh2rTqre8IiDnywAMlJmRmyi+mrMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=43.155.80.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz13t1776851803t80cf47a6
X-QQ-Originating-IP: UGTAT+LLltwHgx4n3VCaP+5RxAdzEQvfR5j+fby35Ug=
Received: from lap-jiawenwu.trustnetic.com ( [115.220.225.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 22 Apr 2026 17:56:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3416905793464026157
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
Subject: [RFC PATCH net-next 4/5] net: wangxun: extract the close_suspend sequence
Date: Wed, 22 Apr 2026 17:56:16 +0800
Message-Id: <20260422095617.27080-5-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260422095617.27080-1-jiawenwu@trustnetic.com>
References: <20260422095617.27080-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NUf6+VF7Eky6fFWqA/xdK13F1JB6aVc2eBrvbkbjHomsRpz9fnlo2zcK
	bJTY2XasmYaOF85+NAXOaHg9MpzXZXK6htIY6e/XXyxIE06VHyzIM04XXhGRM35vcXjxSNz
	XAlFfOUKYWHpQ5oVwPI6uEXeNg2p29kxiI4624KAFWRCuT2GmVvc1SGUeYUefXOT0KcULVD
	H3QlQ7//19/Z59pEWlNEol7CLjNir7y112O0zhp8iZHHbcc0JeSoMuXziQG0Pm6DDkLorZS
	4tAqg9QY2qDiLu9ABxyTl92hUDN76SgoReFa8QJ4VK/eDHV0oDZscJ186ymRbxeo0E+OcoI
	EPZW2fujjC8JWelcWYcqEVsTO8dkO/9iuEHKDvV39G/kRaXvFYwDJ9ADTm0OmT5MdOx7Aey
	IJIsm9UlVe/uC04JSscLacOK6g195vmWjKRI6HKU3fqaaVt6tevsLMnOkKmKNJ41hK54OkY
	L2Y8YZ/g8rsTLn0a2CBhibtoklMuMFuRl6FqUbgRcetcasPaxpodnkDc+N+slOtzNjIOPhr
	iN+n1rmKQQ9g84dSAyk9Y9X5CUfGrTbJvdx6RYcMuUaUCMGluA7Nkh6/sqsFUKMxXBb7I6F
	Z5LsFiY/w2rXL3GSAshoLIzkLvBb0S/iJAo3lYkgaeF6mmSuAm7lJXUg+eCjRRNJw7KmIEs
	Cc68fZK0Ld/xqZvhXNMxa3RDkoppagGE50j4bF+mXj5u4hq4oCbesO4r58tbl10NapWIbXI
	NiD6PMDHGkFtzRUAzRPtGSkVLAwKMpEn7qxrQ8zYpNR0l7Yd173nHlVDsX7adrQKE3c3sNi
	W/dxKcMPTwqgXM6oyQmHIgV0dJvnXed2qCwWzfyu3UoiTbRn2NkGnsKGG8Blwz6pLgbJtVh
	FQCm6kBFY3kG6UGqTavsv9U74R3oLSSz+scldC5yJTz1m6D42Sy7DmtVsUObWa4lX6SQq59
	xI/2++fV0kg8SaDblm+rAV8o22g3y2m7HVLE2PCwWmzj2RymFEEBvXIqs4P7v4eaFeb5QL9
	TgDBvoOoih+lJQ2Qj6F2Au3YbMrkVO7FMDNYkjkSUSOOY9lg/VlGqemotILI4ydM7wPAeTN
	w==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280373-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,debian.org,dama.to,trustnetic.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,trustnetic.com:mid,trustnetic.com:email]
X-Rspamd-Queue-Id: 133F6444646
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Refactor the .ndo_close implementation by extracting the necessary
hardware shutdown sequence into a dedicated close_suspend function.

This is for later implementation of PCIe error callback function in
libwx.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_type.h   |  1 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c  | 18 +++++++++++++-----
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h  |  1 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c    | 13 +++++++------
 .../net/ethernet/wangxun/txgbe/txgbe_type.h    |  1 +
 5 files changed, 23 insertions(+), 11 deletions(-)

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
index ec14dd47cd42..bd6c0c9c51ba 100644
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
index f6050775af71..20969dd7d47a 100644
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


