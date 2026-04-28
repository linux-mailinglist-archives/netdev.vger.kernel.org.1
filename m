Return-Path: <netdev+bounces-281598-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FomMAIY8GmNOQEAu9opvQ
	(envelope-from <netdev+bounces-281598-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 04:14:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C45D47CA83
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 04:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E363305B03B
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 02:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E77B37A48A;
	Tue, 28 Apr 2026 02:12:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.77.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B0E30ACFB
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 02:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.77.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777342374; cv=none; b=Ng9fDluWdVl5FguNqo4DqoxrMLx/R3hr99lxkfaIJPWeSqcsYeUgcZpid7eimMpC78RAdufttPnah+4XybD4Ty2NFVDDK/Ng8QC+5OOwmrOLOT7NWJ4siFLJ8Zss9JLSMTzqvbLGcrT5UrCfVZ00LRXZC/oIzpPINLGytdhs8Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777342374; c=relaxed/simple;
	bh=GYquoJ1OJF63F1rXbC7ebsrzyvJH/znlX+DBQxoXMoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e/JvcyzPXPG6yxLVj82yN9bVGtSrIJzeVg/nxaFhyTZ+XbI6Qd4WTl1wRjaLMmTH9JNMn/uOZaQub3dzC4Vh+C5gYQTpS2VfvIVHC/Yw/ZCM6/6zs7Zqh63Hr5W9inTOwIRTyA0ZNNGpsBBjjyTYiPgec1WMnJ2BB3cYNRYEPnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=114.132.77.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz11t1777342325ta863fc72
X-QQ-Originating-IP: o+nimyvfbSicWv+mGXuCGbkfydiBdduJEKwr1gaCp7o=
Received: from lap-jiawenwu.trustnetic.com ( [36.24.191.108])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 28 Apr 2026 10:12:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3952486834042546466
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
Subject: [PATCH net-next v1 1/5] net: ngbe: implement libwx reset ops
Date: Tue, 28 Apr 2026 10:11:52 +0800
Message-Id: <20260428021156.13564-2-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: NyTsQ4JOu2J20lf578BUyoyZ6+3cCr+VOvdSpPDbIxj1CO9nqqvrrM4R
	nHwU86G+vGJQR/JgM0KP0J/PWOluAIwEBaMjJrdzVCTtoTqw24TF05JFH4VEjfH73SXpXX6
	4/RRCKHso+AvBPXQkQDGtAJA4/0F6f3BA5YllF8joxGFhn0K0dXXy2m2oMz6EzW7zpBRovD
	9fkVPHDWoRYk7ZrRrwN3ApM0D19JOVNkK7j+WkazrFxw2ZpKQ4zQhG5hLE/W5O6Mdb6an/0
	AGK9zAgoHyiJ6jYQ6RMw7jO6XkEqTh2bQur6T8QSQBypJCR9U2Oeu9iNK2WaccFv4ow7Rgs
	ECZ0G0wymNmDzbdiMr6jgrRi09H4oZzxciv0y4JGtJEDfXpAb8VRXbNYUguikLvtq5THIyT
	nAow/KNy9BkMn8Xk8KQ7YxFHc2qv0ChfQ7REF6lovTkQ8gXJtIEptl2fpwJCOAD38aUP08s
	2SQ+5Wr50lzNu2zQMaZK8v5bTBT358s//Fi+BR1bAr/UdV4cbJjz/rKMFbPZPs9OHg2WV4U
	VNJzLb33QBRloswd5xglUcs4I3augOH4Fbpb6Dj+cxs4yjvW7AR2vvNlzB82LP7WFAJ0whT
	wnIXBd9x1xtgxuCbgGREPIYAbQOO5lxMo2/b88LIDGgHimx2qkuz9U7WM6H0pKyKpCtiBol
	aiTN5Hv3ZYmB6heKC7YZbN2FxljaaHCZqdGfow9FPlleVm4GKGWw2Rhdse6WtwJmR/G5Rhr
	XI1AQyFSobAyvWwHEhNIj/OpAaSFnSaIaUqhFf9+JkmebHlKd1OBRbwByxOXxKg27jDqzuZ
	WAMrpgZA0Byowa25JctgtCeA/H/isuSa9K1yyWjjsoLFsH2fiQmsxkPh5Jgee4viz79tGrw
	Ttv/2+V1q0uIhLlAxlNDbwPJeQbUhqH9Vzp2DgAkeMSbv8ZkB2iz8ZH/mkY9fmkCztjuTNl
	tnHecGLqP7SV+SXKBPnQ54ZQaFxTa0E8ZmYEfDM9Z6k9qwOgvOvR+UQv1rMSrEIZ/GtLuXo
	Bg4uoe4rOlDGreua2zYvVh32WPHCeKyPjRKowgZa1ZPJ7HOIyhe2sblkTNhwfkeQD1+5+DX
	g==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 2C45D47CA83
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-281598-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,debian.org,dama.to,trustnetic.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.914];
	TAGGED_RCPT(0.00)[netdev];
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


