Return-Path: <netdev+bounces-282703-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CL8wMIQS82k4xAEAu9opvQ
	(envelope-from <netdev+bounces-282703-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:27:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D1349F3AC
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6387301C88A
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 08:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6C639C632;
	Thu, 30 Apr 2026 08:26:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD883A6EFF
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 08:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777537590; cv=none; b=CG8NdfmZ8iZhuD6l1hzB1CbJXdN7fgEWkuZtkupS59GVFHmahqtmTkFNudYY7cCaPYYPM9QSQpl/m8mH4O6lD36DEXLmG5UC20G0RQOA3SvQmUxGRWaKGOI/oYSQI40UGW3QHII1d/9mKiC/dhNGbLJAg99NPs1JD6mi8bTPc8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777537590; c=relaxed/simple;
	bh=GYquoJ1OJF63F1rXbC7ebsrzyvJH/znlX+DBQxoXMoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QAj5CBlZ2zOqgOrEqc+O4sOgM6l6KzIpNndimaAfrMErXkv0ZJafV6EKMo48Qgc9ACFAIDgl6r93ZgQC7OmUYLiVQWWzzk6EYTA7KFVut6Prp9PhniYElgy//CQNbX1unRSh40IRO2yjOqaftXwRf+56v2ftz3KaGZUk0DtPn4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz3t1777537544tfc193513
X-QQ-Originating-IP: H072Bn5+Fn8qyOnEFq7CpD6TATKJXSTI2lJLPIpu7sg=
Received: from lap-jiawenwu.trustnetic.com ( [122.235.155.141])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 30 Apr 2026 16:25:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17471313869406069773
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
Subject: [PATCH net-next v2 1/6] net: ngbe: implement libwx reset ops
Date: Thu, 30 Apr 2026 16:25:12 +0800
Message-Id: <20260430082517.19612-2-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: NchHDkd43sBt0oyF7LccwFktToMG85x1u+6JjQ8SP1WBh7pFpSr+o2eX
	1OhwGDu65UcHTh4WTvYljtemH2KkQlTWHt7ulJFw3vlb52y33zse1U52Z3u/WTmFu1OluxG
	kyB9pebh0zaFPbCJFX7d+buqcZaW2w6N/Vl3sAh8nhs0DZ6ffITqwkHwzwHm9kQ8Jj5UyAp
	ivK+tCdJc1UNrF+i4KtP6oWRZqWVBtamAZXWYDxzV/Mxjks8PLV32mbjRRRZuRTwGeSiyHu
	mJYdwfn0P4VbYi+Xkxj0vWQfEY8b9MRQ5HJoORt1OG0f0uBh/krR5PugZBT3l2H61l3iZfU
	yflzlna5xvpcH2kcBt2gHVxbPx9nWyS5kFSU5D90tnxXyfwomoFLw1WQmUKnB040sjIL5T9
	z9gY5ei4N8N9buK7pc5/CqPDWNyDHRIliq0NKi3vn5QSmuDoXamv0DFYpDUnbX/F66QlCOw
	lUNUeKRxzot0LOVMCDJk0qpYZfYm6iHFqvUAf3vrTJhkr5dHHT36y0SoNg/Go0fO6UtEjOY
	mC9HbYVKOPs8tHNU+WnBYU4NDfIQcaVsiMtUt0/xQGXEAnClynGEyXyruWGW5HorBrUHaNx
	LRoDtLlt8O9+rOVW+FluhPX8yet0mBIy/6ktM/dANqsOKQCKPEzqr566Phls79WGaZaqgqx
	7grrNACV/H/B/JMAbrSQPhZBuNVQZDmbbffNQ8F25kqAKoB4l2z5fsn5hSzXZVHeDCyDxWn
	SkIwSdqBlyMUULClnlHEZnplK8jfZq90ZdWfJCD0E7ySlOoXUS+Meqw+/sQAOtNZyFCPpVD
	kMi+raZqClWss81mm7JTkHPlLwsGnRU8lR7tZ5eVNWS1G0i+fQcjO2NaQKNSOWAPEWx8PYx
	hSuUK9s+AbWfOhzR7jHptIiqCaOA6XrCJbl8R8/MT9CFczH8/86IoqCzwMzQatlF0cQvQXb
	cFAuLdmthYGDFVm+A9lHfjaEi1WlKlPEoYUOJOnGveZMGziLwST4IKXEBFqo07bnO42GYmH
	GEVC8/6zimspUcAHZEvGCv9+MaSVwL3TXu/sdohvjJuB+Xm1e961ChTe1iOmc=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 49D1349F3AC
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
	TAGGED_FROM(0.00)[bounces-282703-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,debian.org,dama.to,trustnetic.com];
	NEURAL_SPAM(0.00)[0.939];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,trustnetic.com:mid,trustnetic.com:email]

Implement wx->do_reset() for library module calling.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |  1 -
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 37 ++++++++++++++++++-
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |  1 +
 3 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index b2e191982803..1960f7154151 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -59,7 +59,6 @@ static int ngbe_set_ringparam(struct net_device *netdev,
 	wx_set_ring(wx, new_tx_count, new_rx_count, temp_ring);
 	kvfree(temp_ring);
 
-	wx_configure(wx);
 	ngbe_up(wx);
 
 clear_reset:
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index d8e3827a8b1f..bd905e267575 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -133,6 +133,7 @@ static int ngbe_sw_init(struct wx *wx)
 
 	wx->mbx.size = WX_VXMAILBOX_SIZE;
 	wx->setup_tc = ngbe_setup_tc;
+	wx->do_reset = ngbe_do_reset;
 	set_bit(0, &wx->fwd_bitmask);
 
 	return 0;
@@ -422,7 +423,7 @@ void ngbe_down(struct wx *wx)
 	wx_clean_all_rx_rings(wx);
 }
 
-void ngbe_up(struct wx *wx)
+static void ngbe_up_complete(struct wx *wx)
 {
 	wx_configure_vectors(wx);
 
@@ -488,7 +489,7 @@ static int ngbe_open(struct net_device *netdev)
 
 	wx_ptp_init(wx);
 
-	ngbe_up(wx);
+	ngbe_up_complete(wx);
 
 	return 0;
 err_dis_phy:
@@ -501,6 +502,12 @@ static int ngbe_open(struct net_device *netdev)
 	return err;
 }
 
+void ngbe_up(struct wx *wx)
+{
+	wx_configure(wx);
+	ngbe_up_complete(wx);
+}
+
 /**
  * ngbe_close - Disables a network interface
  * @netdev: network interface device structure
@@ -588,6 +595,8 @@ int ngbe_setup_tc(struct net_device *dev, u8 tc)
 	 */
 	if (netif_running(dev))
 		ngbe_close(dev);
+	else
+		ngbe_reset(wx);
 
 	wx_clear_interrupt_scheme(wx);
 
@@ -604,6 +613,30 @@ int ngbe_setup_tc(struct net_device *dev, u8 tc)
 	return 0;
 }
 
+static void ngbe_reinit_locked(struct wx *wx)
+{
+	netif_trans_update(wx->netdev);
+
+	mutex_lock(&wx->reset_lock);
+	set_bit(WX_STATE_RESETTING, wx->state);
+
+	ngbe_down(wx);
+	ngbe_up(wx);
+
+	clear_bit(WX_STATE_RESETTING, wx->state);
+	mutex_unlock(&wx->reset_lock);
+}
+
+void ngbe_do_reset(struct net_device *netdev)
+{
+	struct wx *wx = netdev_priv(netdev);
+
+	if (netif_running(netdev))
+		ngbe_reinit_locked(wx);
+	else
+		ngbe_reset(wx);
+}
+
 static const struct net_device_ops ngbe_netdev_ops = {
 	.ndo_open               = ngbe_open,
 	.ndo_stop               = ngbe_close,
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
index 7077a0da4c98..4f648f272c08 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
@@ -125,5 +125,6 @@ extern char ngbe_driver_name[];
 void ngbe_down(struct wx *wx);
 void ngbe_up(struct wx *wx);
 int ngbe_setup_tc(struct net_device *dev, u8 tc);
+void ngbe_do_reset(struct net_device *netdev);
 
 #endif /* _NGBE_TYPE_H_ */
-- 
2.51.0


