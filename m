Return-Path: <netdev+bounces-268464-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GCJO28FuWmEnAEAu9opvQ
	(envelope-from <netdev+bounces-268464-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 08:40:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D05F2A4F4E
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 08:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F7833054BBF
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 07:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB390391828;
	Tue, 17 Mar 2026 07:39:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A838391839
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 07:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773733175; cv=none; b=shSfMD79rqg0WbMbL2vccDCRKOy99vCuYNjbW/0CtYmGC85MEe0c7lspTe1s7Vn52rRNPyPL2K6h++B+BY3Ex3Y1Zjvm9Ga57cxXuALYAcRVuEqkBTbk5JSbquCakWr9ufr0R2diVuBgtecYGN7XICbpq2xoHvAEJwEYLJKsqkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773733175; c=relaxed/simple;
	bh=KFZR9V8u6CMrm/XfjAFQ+uIEysANP+mps6jVcXyxpl0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jDObcB1oNvYI4Nd6rZ9e5r4fhFalLbRQ4p9GLKQXCwWkJOjXuyvpUN+qxCK+wdaSDm0e5Lwm94A15qCn/ss02IqKUI5KlPem8DmD7XK4oElSfYsue5Tcod/8B6ZiT0kCXAmTFSK1HW6Au1Q9zE57YW5s46s+DnMiG9LpFRBFpT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz11t1773733122t05b00d90
X-QQ-Originating-IP: 5ltvSbnybXWr3PMLDobtrADZuRMJ4QvWHjnM5pi83iA=
Received: from lap-jiawenwu.trustnetic.com ( [122.235.239.227])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 17 Mar 2026 15:38:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8686269013080191966
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
Subject: [PATCH net-next v5 01/11] net: ngbe: remove netdev->ethtool->wol_enabled setting
Date: Tue, 17 Mar 2026 15:38:17 +0800
Message-Id: <20260317073827.4300-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260317073827.4300-1-jiawenwu@trustnetic.com>
References: <20260317073827.4300-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: N/yb1h3vF8ExbXUsk6qpSD5W8/Rqd/8j0KzahaqlkdQb0IkdUTl86Co8
	P06Ql/YqjFdJ70yMEY/g84+34xtTfl1aoqnpELhIUaiQXnXZCYq6VPOBaEFemT3CbGOj40M
	XtzbdU8r3WYxp0UGutM9R4I3w1vpBPMHetgmFNFSTIAZv5C29Vnz7VE8NWk8DkRECFdLbt3
	AQmPe2iw7OOKyVXIsCa2DNKDkvfgezYwdrYs/j7fw6fz6i7wEJyTvvHUq92feM0+CeqVOec
	BW/1oWCYO8QtPZF1LpfFyRzONaWUHA9+5fM2o66TrAX/aP6D1gVdC1324JbPUByvrPfWL20
	Y6B8GfxJVYnCZmBMHnkr0kWnytJs5/OVUpTM1iZYWafb8eMwsCYKwMygesnsWenUcp1ZeiZ
	3jc0pN6vkHhygc09W6gTQKylTk+xzotbl7gAwHZJ6TAlmkab0bw3oDnPm+lXm9d7j7djL72
	HSG07s3+HZ5glDSrqJtqKA0PNyXFVP7+ihxjpeuLsz4luywvc5HpQQyGGlKaXLblvFgVn4S
	LwZWyRZwZtNWdoKSC2zreyaJmmSHwzf83BNAJ0Cgodla9TvpRd1J1PC642ZcaMB4NBpfbzx
	W4Dx6i/zldgJ8tqf1oY2Iw/KWxhFNrG0kdZTGL78WTkU+URvZ7JBAcNhCfWsMq1UfITSTH3
	z1etoZOhjKF8VmQQreXgYLX1KCA93a3L3JNyi/1UyYzNncv1dIqLQwW/NdYTR0IzFRFf6H5
	40Ku/MfwhcdCXgBGcCP6xPfaRF7HyjJnzhTNphpNJy44CPxxacoY+N/WO27ZTiZOh43G3pR
	BGfNQepl7KAPeP6BStv09Sor9gkJ1Vxg2txIuZods1iFOS/ihGfeF5Egr+gRzagDlxSAGsr
	wTQ7KFykkhy5MWnULzJkaANPddEobM3G4VYthFdB0qDc6OTM5dkXVtMODKipeN7/N/3Pd1B
	ksTaVAKmjwB1jbhJ3pRcAQgrLRFLPxy6PiCn2z8Tqk6BRb9EcWQ2Qpfv5aEAoebSz4ybate
	cmEesJTwabBs7fQ+c576IUFFHd7l1AKkebacjpTgG8AS6w5TOVbaQG7HtXH9nP3b/Ppuj2e
	/brvTyi0O3sxwD3xGSQiKI=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268464-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,dama.to,debian.org,trustnetic.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.818];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,trustnetic.com:email,trustnetic.com:mid]
X-Rspamd-Queue-Id: 6D05F2A4F4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

netdev->ethtool->wol_enabled is set in ethtool core code, so remove the
redundant setting in ngbe_set_wol().

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index fc04040957bf..40779fee0fdf 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -37,9 +37,8 @@ static int ngbe_set_wol(struct net_device *netdev,
 	wx->wol = 0;
 	if (wol->wolopts & WAKE_MAGIC)
 		wx->wol = WX_PSR_WKUP_CTL_MAG;
-	netdev->ethtool->wol_enabled = !!(wx->wol);
 	wr32(wx, WX_PSR_WKUP_CTL, wx->wol);
-	device_set_wakeup_enable(&pdev->dev, netdev->ethtool->wol_enabled);
+	device_set_wakeup_enable(&pdev->dev, !!(wx->wol));
 
 	return 0;
 }
-- 
2.48.1


