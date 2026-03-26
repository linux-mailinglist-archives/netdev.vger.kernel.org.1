Return-Path: <netdev+bounces-271797-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sP8/JKGXxGnn1AQAu9opvQ
	(envelope-from <netdev+bounces-271797-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 03:19:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFE832E4E8
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 03:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 530EC3036751
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 02:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA813081D6;
	Thu, 26 Mar 2026 02:16:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0A52DAFA9
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 02:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774491366; cv=none; b=fk8ACaNtH7ym75RmEsXJWLQXZZmw5kEs/Cp6IVV2cxeiTpG9vXblKWAp5d+jA4EYyZ6BaOyWvXuRkvb49StbbGOmw37tJuyhPC2LiK7105C7VIAQI+dREwFugVqSYBj30tNZY3u57H8/a9VIedlnG9HmjAG3elDymSHUQ65C8so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774491366; c=relaxed/simple;
	bh=8FwoAB2Qn6JT0S94FPkcOAVOsJW2wIi9quOEbH7/Jos=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=InXBVRhhzHqCSbFo4xFBXSqoaZU4gSUDc8R15vThv7O05YgQhqOi6yYWJ6f+TDmkM8/i0C1VtSkXx1642l70yJDzdQ31PANKBVJOvo3mGv29U1U2QNFQ6znU5JYzU/VAvgcLqssEjZKOuFFMEoY5MMa8SyoIXMc0R5MaT2rHxt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz11t1774491314t19ed35e6
X-QQ-Originating-IP: mN5syP5Ku6XE1BXSv5yIaX54BgL9T3id9fWvZrqGcgA=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.60.44])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 26 Mar 2026 10:15:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 975269688057524013
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
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Joe Damato <joe@dama.to>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v6 04/11] net: ngbe: implement libwx reset ops
Date: Thu, 26 Mar 2026 10:13:59 +0800
Message-Id: <20260326021406.30444-5-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260326021406.30444-1-jiawenwu@trustnetic.com>
References: <20260326021406.30444-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OY7kNFRo2XI48EcWeWfLXTWAPifrs1Tja8tRyTuAWlJHe9ZGDEfXAfl+
	5pbqyox7l9Ak4rqgANeVSiNI2tswNqsQKhaaOadM97q31DjgZlbK2s1mkF640D3Ae7BOdka
	gzAQb1flNm0hKoAlwXnQFufZt2yc926tWGMiLjG1aa7ljg/nlpJ0pqDajNGXvp2FNH5Y0KQ
	5G93DCQu1Sa9na7xpED8yuUBUM7i9LlUPBeFDO2jZZ9XtrNi9AAhJ0QEO3pGQPT9hKbRhOE
	RTkOotnPTno+GcWA8loVhVqHD89UECibpo7avbC1djEgZns8eosbGD10EPiLPRqReeMxEbO
	zioG3ZgRsI3Bif2y77T94ci6MASf/ef90Kp0afe4GMrAPsMS3VvqU3qQBe6NqTYTCxNlERk
	qjTHSXeG36LlEZOn1u5TdnwLZb7I0DQdkfKuUZRqRXoa6xwI2TCw8QsUnPIt2MWVN/gc4gg
	+5zPRIEnO23EhvYB1imT8w7ehlKmmuTOlSEFZKJanX5nL7w6mo3a+Zs6ZL9bmA2nknTRjK0
	kTy9ORfbSeXPyz2zBI17KJze3xLnbbmYDnfmpgoEkLk+Y9U8t2udbcPT3bftRJxgUa7CbWa
	4WfuGzopSbaAA+ky7BqCs9bniu1mlBxpvd0D5ezL7XKJ/upTNcGTzzKvM8bOGNsl7/ktPlK
	4mk8BhPN6XtlwbOy2h7LoK3qGRGF4sz/m7swYdXPNNMqCdh5WDDb6Hj6kJwpsXuwuyMEeJc
	Xlx93E/iA1V55MW8xvYuar5okLIOVZXch0ufOuyUvqO7nScLzV43TUUID41ccQi6v+HB8Ul
	mRg6kpIguxItBwaW096HOxJG5oFjswUNFsIl1dfrCJZo0IrYXeW1aMN+Ays1cj0D3mbRllb
	48aWWvU59kU/vEc572ZVOnEIcriKUwpHzWUGlf9q2dZv+g7UtAQQVBsNevHjKpI95KH7BMV
	1+RKGUGFRXoRtTvAOOPIlgKNH3vJFjrxvzhtXuB0Qlz0EphuzbYvBZnwvkKXlKay0fBiPoC
	psM9R3f9rGJAkPn+XXIcTB/X2afwZtYzCigIRBgBOJJlrDFhRd6E7WImDc715ZAqxBc6bq/
	coT7NiLxlgYCGUXmJ8GY0U=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271797-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,linux.intel.com,intel.com,dama.to,debian.org,trustnetic.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,trustnetic.com:email,trustnetic.com:mid]
X-Rspamd-Queue-Id: 3DFE832E4E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement wx->do_reset() for library module calling. Since LAN reset is
not necessary for NGBE devices, only ngbe_down() and ngbe_up() calls are
considered while the device is running.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |  1 -
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 37 ++++++++++++++++++-
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |  1 +
 3 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index 2b6356622a13..b86980c2418f 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -60,7 +60,6 @@ static int ngbe_set_ringparam(struct net_device *netdev,
 	wx_set_ring(wx, new_tx_count, new_rx_count, temp_ring);
 	kvfree(temp_ring);
 
-	wx_configure(wx);
 	ngbe_up(wx);
 
 clear_reset:
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 8c9d505721b1..50a13dcf4b3c 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -133,6 +133,7 @@ static int ngbe_sw_init(struct wx *wx)
 
 	wx->mbx.size = WX_VXMAILBOX_SIZE;
 	wx->setup_tc = ngbe_setup_tc;
+	wx->do_reset = ngbe_do_reset;
 	set_bit(0, &wx->fwd_bitmask);
 
 	return 0;
@@ -398,7 +399,7 @@ void ngbe_down(struct wx *wx)
 	wx_clean_all_rx_rings(wx);
 }
 
-void ngbe_up(struct wx *wx)
+static void ngbe_up_complete(struct wx *wx)
 {
 	wx_configure_vectors(wx);
 
@@ -463,7 +464,7 @@ static int ngbe_open(struct net_device *netdev)
 
 	wx_ptp_init(wx);
 
-	ngbe_up(wx);
+	ngbe_up_complete(wx);
 
 	return 0;
 err_dis_phy:
@@ -502,6 +503,12 @@ static int ngbe_close(struct net_device *netdev)
 	return 0;
 }
 
+void ngbe_up(struct wx *wx)
+{
+	wx_configure(wx);
+	ngbe_up_complete(wx);
+}
+
 static void ngbe_dev_shutdown(struct pci_dev *pdev, bool *enable_wake)
 {
 	struct wx *wx = pci_get_drvdata(pdev);
@@ -579,6 +586,32 @@ int ngbe_setup_tc(struct net_device *dev, u8 tc)
 	return 0;
 }
 
+static void ngbe_reinit_locked(struct wx *wx)
+{
+	int err = 0;
+
+	netif_trans_update(wx->netdev);
+
+	err = wx_set_state_reset(wx);
+	if (err) {
+		wx_err(wx, "wait device reset timeout\n");
+		return;
+	}
+
+	ngbe_down(wx);
+	ngbe_up(wx);
+
+	clear_bit(WX_STATE_RESETTING, wx->state);
+}
+
+void ngbe_do_reset(struct net_device *netdev)
+{
+	struct wx *wx = netdev_priv(netdev);
+
+	if (netif_running(netdev))
+		ngbe_reinit_locked(wx);
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
2.48.1


