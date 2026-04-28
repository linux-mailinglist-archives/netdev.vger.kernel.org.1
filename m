Return-Path: <netdev+bounces-281597-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLg+IwEY8GmNOQEAu9opvQ
	(envelope-from <netdev+bounces-281597-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 04:14:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CAB47CA7C
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 04:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E8C2305AD52
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 02:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973F6379EE0;
	Tue, 28 Apr 2026 02:12:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE60374E66
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 02:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.67.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777342374; cv=none; b=i6d4LzjEEGdc2BVG5KBe0tMLHHwz1dmQFmmBgRISdn5fBF0oRd12+45ZRiuSYwpryDy2VtzpxbYIGbpDpuEiH2BEv0Al+p754zJjEXV0cB4Z1PQgtuIQXV5YaHKLM67dhoQ+zMyIqRl2viBU3MN7kqTmsN83zftVPUEsiQy1SaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777342374; c=relaxed/simple;
	bh=BcFg4C86DBm+oKqYnwDT6GVScQqzf+v54pa4vMbJXFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZBJhFcCYfvW5gRQySOuLeMer49xyh9dpZTOuZSe00jLnwCMIBu+8RxpjI7K3mWehK95wKU/JB59lIS8oc8811vqHceenG5AyTqRgWwrYz+v8sUIOBVzhbTvQIl2mNzYYrgAcMERBcxCV5qZgP/2RDkCUqxu8OCWuKZTz+HBsRms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=114.132.67.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz11t1777342334t65cdae63
X-QQ-Originating-IP: h6VH4ce6pHGjLfAPO4EJ+y4I46fgI648ryv+j/HEJm0=
Received: from lap-jiawenwu.trustnetic.com ( [36.24.191.108])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 28 Apr 2026 10:12:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16562929001597028792
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
Subject: [PATCH net-next v1 4/5] net: wangxun: extract the close_suspend sequence
Date: Tue, 28 Apr 2026 10:11:55 +0800
Message-Id: <20260428021156.13564-5-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260428021156.13564-1-jiawenwu@trustnetic.com>
References: <20260428021156.13564-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MdzdX6p4PZzkYhzHOEPzveOCPPlT86Q1F/jm5MNkrp3Xji6+wNSlw5J4
	fvq93wg3QnwB3veViT13v1j6Lzt0pge40ZKUGY6vN9k2PVUFaLOmfQRxZZydDw4OZCC/2xg
	n8rAFVW5RA/Yx5+ZZ3ONcSBqaTDEzarWZiZc3gRAkgmck3/cOC66OBvoNYoWH7iR/0hjtyb
	gyXUjqW2EXnFbnggVxGeFCm97U+jACoR2FYH9Y9TyThpuneTpL2jx4nSDiEJZXVXMUvja7e
	ti3k4p5wEwRwKNJ5SGL1+wIqF3Emvg8OpoTL0bMPnc8Yr0PBN7jmpFMbKCulPPHVDEIeZRb
	6JZzvV83TZMbjQMark2bpjfAAl89b+RwpNuLXlm2asy68t3QRUBXen4Xtstp4qknfOcrofp
	ig3BW/d7HfCvjmvqigaGemYfYXTU9nzRwEClZtvz16PiOfd6G9HDb5DJSErEv3kB0ynAvam
	qfYgx1ZrDBewtrNvMmjT9wxdR/+oDwkhFqxVdC41VksA1+/X4LObGhuG+gnaL7nQlKsvNbb
	H64K5pYf5LH6Sn7zKLDQyShbNIBNJit9JNyvTX4xWWMpnRXlmZQuf3UqRoeinUuRZHvz3vW
	nrbwVNMhWblFTgk0TOLA2lyFp8OqAHOKzMEvlmsWgcHGLkDH27pdNRwOOzi/IhdpLpu1yxr
	GEAjfdHaGx+LWlJD1iPgIo5s1KQar/mmiT7k8II2/ECCJL1n50NieOGzVe6OXJ3/tfXR6EA
	DYfF2IG64/ERZ8TojsQvSx2mn6KM7abKOzeX6nywihzDJazEfjQxpVtpKvLO+MURUzHh2i4
	3HmVwMsCowSUVLzzUweL7p8pleMJuoFtr+8kF+zC2ZUYXZUVLW/lCqoji3wiMnRtTKRjawR
	XsEK4wSpHJRDgY0rQYgEcT6O0814K7Ih+lGmwph92Vkhb+iywxQSN0UBaaedFzEC4oVBMX8
	sLwzN44HR45nbC4Y7L5fREcsPSTjuu+LNr9FIVY6mKi0ZtZan7YX4mWlQvFDkEXJ/LeC+g3
	/NLZrgCXR6K48IafxVGjVzkGyi0eAlKtIdIlEY0Qt6kyXuaWgtltpiDkAknH4=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: E4CAB47CA7C
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-281597-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.915];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,trustnetic.com:mid,trustnetic.com:email]

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


