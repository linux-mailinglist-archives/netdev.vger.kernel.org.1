Return-Path: <netdev+bounces-305528-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iBb0J24pTWoPwAEAu9opvQ
	(envelope-from <netdev+bounces-305528-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 18:29:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3396C71DDF6
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 18:29:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=agner.ch header.s=dkim header.b=OExklQX0;
	dmarc=pass (policy=none) header.from=agner.ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305528-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-305528-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB4A33009CF3
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 16:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B47434E29;
	Tue,  7 Jul 2026 16:29:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.kmu-office.ch (mail.kmu-office.ch [178.209.48.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EC137DAA9
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 16:29:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783441771; cv=none; b=RxFVGYG6CMpEdlozf6qoja36X+T5oANWwt01PLoMEwPhtWCcoWlvHeJALNieVsqwtLSYNxiHFXNqt5m4jqdRz91hc4MqgS8IdrpX+uZvdk6wCIQhLVwTEubX3KiSEbNqqIf7+aSUdEoo9gnl3sKWk8gE6FNj35CiLy/p/xPnYtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783441771; c=relaxed/simple;
	bh=iStYC0Iq8iFRqb83/hsfeJQsuMLUUC870SWEGOWoh+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B2+ZZ1N21hzZHsa/a/t9GBueAkCvXHn8B3NrSLJN/rDz6MTnNG3Imjkl9kdKOVYrf6U0jblEsbJaeSdydRplFwdOSWPW8o3/ZWg7n/DI6yuTZ3vMHAPtbjoDo18gg49d45sJ/DHh+v5cW4WOmqpdwv99Tt3EDHqJJ2eTKVT4GPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=agner.ch; spf=pass smtp.mailfrom=agner.ch; dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b=OExklQX0; arc=none smtp.client-ip=178.209.48.109
Received: from allenwind.lan (unknown [IPv6:2a02:169:3c38:10::3a0])
	by mail.kmu-office.ch (Postfix) with ESMTPSA id 5A49C5CA16B;
	Tue,  7 Jul 2026 18:21:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
	t=1783441310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:
	 content-transfer-encoding:content-transfer-encoding:in-reply-to:
	 references; bh=1lw1VBDE1/D2I6ja8qlx//S0jIyLgr96wpIl4MJHkxE=;
	b=OExklQX0Z1RbE+wjJPmTMPSVhBQoTHdvN82uETaE1DHuFypcgBk2aUoB16NyUEuQN0lUe4
	0X/5M9sDKZj7IoVSnybczAGLz9yKrX1VHWAUjX1+XzzOmz6OPBeG2pUd6bb87VxYv6/OwM
	AlvuAaXr2C2jIkXgK31f8EO6df7/474=
From: Stefan Agner <stefan@agner.ch>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	regressions@lists.linux.dev,
	Stefan Agner <stefan@agner.ch>
Subject: [PATCH net] net: stmmac: resume PHY before reopening the interface on MTU change
Date: Tue,  7 Jul 2026 18:21:46 +0200
Message-ID: <20260707162146.73823-1-stefan@agner.ch>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[agner.ch,none];
	R_DKIM_ALLOW(-0.20)[agner.ch:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305528-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[stefan@agner.ch,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:ovidiu.panait.rb@renesas.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:netdev@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:regressions@lists.linux.dev,m:stefan@agner.ch,m:andrew@lunn.ch,m:rmk@armlinux.org.uk,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[armlinux.org.uk,bootlin.com,renesas.com,gmail.com,foss.st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,agner.ch];
	DKIM_TRACE(0.00)[agner.ch:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stefan@agner.ch,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,agner.ch:from_mime,agner.ch:email,agner.ch:mid,agner.ch:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3396C71DDF6

Since the referenced commit, changing the MTU on a running interface no
longer disconnects and reconnects the PHY; __stmmac_release() merely
stops phylink, which also suspends the PHY (BMCR power-down) when WoL
is not enabled. __stmmac_open() then performs the DMA software reset in
stmmac_hw_setup() before phylink_start() resumes the PHY again.

IEEE 802.3 22.2.4.1.5 allows a PHY to stop its receive clock while
powered down, and stmmac requires a running receive clock for the DMA
software reset to complete (the phylink config sets mac_requires_rxc).
On such setups, e.g. the RK3566-based Home Assistant Green with an
RTL8211F-VD PHY in RGMII mode, any runtime MTU change now times out and
leaves the interface dead:

  rk_gmac-dwmac fe010000.ethernet end0: Failed to reset the dma
  rk_gmac-dwmac fe010000.ethernet end0: stmmac_hw_setup: DMA engine initialization failed
  rk_gmac-dwmac fe010000.ethernet end0: __stmmac_open: Hw setup failed
  rk_gmac-dwmac fe010000.ethernet end0: failed reopening the interface after MTU change

In the field this is triggered by NetworkManager applying an MTU while
activating the connection, breaking networking entirely.

Resume the PHY before reopening the interface, like stmmac_resume()
does, to ensure the receive clock is running for the DMA software
reset.

Fixes: db299a0c09e9 ("net: stmmac: move PHY handling out of __stmmac_open()/release()")
Link: https://github.com/home-assistant/operating-system/issues/4858
Assisted-by: Claude:claude-fable-5
Tested-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Note: phylink_prepare_resume()'s kernel-doc says it is to be called
prior to phylink_resume(); here it is paired with phylink_start()
(called from __stmmac_open()) instead, which phylink_resume() itself
uses to restart the machinery. If preferred, I can extend the
kernel-doc or introduce a more generically named helper.

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5884,6 +5884,15 @@
 
 		__stmmac_release(dev);
 
+		/* phylink_stop() in __stmmac_release() suspends the PHY.
+		 * IEEE 802.3 allows PHYs to stop their receive clock while
+		 * powered down, but the DMA software reset performed by
+		 * stmmac_hw_setup() requires a running receive clock.
+		 * Resume the PHY, as on system resume, to ensure its clocks
+		 * are running before reopening the interface.
+		 */
+		phylink_prepare_resume(priv->phylink);
+
 		ret = __stmmac_open(dev, dma_conf);
 		if (ret) {
 			free_dma_desc_resources(priv, dma_conf);
-- 
2.49.0

