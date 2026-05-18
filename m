Return-Path: <netdev+bounces-288919-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aG7CFu/MCmqf8AQAu9opvQ
	(envelope-from <netdev+bounces-288919-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 10:25:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F1C568AF3
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 10:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7636D301E77C
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 08:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3603E3D86;
	Mon, 18 May 2026 08:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="FNmez8+J"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBE03E2768;
	Mon, 18 May 2026 08:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092608; cv=none; b=PlHMgtCFg7zxTVVCW8uUXbTzZwLeq3Z3iTLR80Q/Z2xwOVHeCMnSNBt/qhi8jU8fLTBLKc6g/gw9yo1aFrR/G0PpGQV6FbyAQwA0LPcsotFrxpdqt+ood9FP2pqv1kvPrmx7JBFAnw9/uHVhABcoI7hD2NcEZ15hfQ+a57T/wmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092608; c=relaxed/simple;
	bh=AsqFlT2AxPBAm+rv40Da/5KbtsG8QzIHSFexj3+Zkd0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BbMFeAzKC6IBYX2d2wekOEsd5sV8u+nHrP7o6qYJ0Qu3paT5OPdzngXHc6kHtAqXBnQEOfmG8CojecX6CoCL+uHEEbacv7vzeZbI3SCzB2LEunjcLa2LIJ6iUu0q9WdPZpDTheEPbhty0mjR1Erk1rg5Qg8ckDHvF3Xwn1X2NL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=FNmez8+J; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 630D8A4F8A;
	Mon, 18 May 2026 10:23:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1779092596; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=b+0Fj2XVBlztwa4aMETMdgSMnSo9rICEod6EcX1HPFw=;
	b=FNmez8+JkzoiPWxmaRTL3PFjvKLPFt44zPOlMd9bXQ6VmrB9fBr9sP27SWRUNSDj8s/gmR
	xTCET9R1nQ3fpyU2h3PZ+JFfkvTSeDKX9l1HRwsFTegIRRgsrEkVA5aKx4vZKQuFmkn42x
	UHASLzgghRYLRLFfUAwvNSiS2QnS7kBbCx6xkP0b2xsDciWPfq1p3WuIWNCjDvl2jBjbmy
	kftnR72Zl2QbUkE8fPEHNrKwDvgy30oJb4KBzon37/tppzdGFBbH9hNxAvUS6L5sYkuztJ
	Ynk3UOapa6WHYrNraqSapzXoLypIfFwpW42tNgm0e3Gl2zJ00BFd/+zrhAGqlg==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Mon, 18 May 2026 10:23:09 +0200
Subject: [PATCH net v2 1/2] net: phy: honor eee_disabled_modes in
 phy_support_eee()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-devel-phy-support-eee-fix-v2-1-05b52626fa68@tipi-net.de>
References: <20260518-devel-phy-support-eee-fix-v2-0-05b52626fa68@tipi-net.de>
In-Reply-To: <20260518-devel-phy-support-eee-fix-v2-0-05b52626fa68@tipi-net.de>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 00F1C568AF3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,pengutronix.de];
	DMARC_NA(0.00)[tipi-net.de];
	TAGGED_FROM(0.00)[bounces-288919-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tipi-net.de:email,tipi-net.de:mid,tipi-net.de:dkim]
X-Rspamd-Action: no action

phy_support_eee() copies supported_eee into advertising_eee
unconditionally, overwriting any filtering applied during phy_probe()
based on DT eee-broken-* properties or driver-populated
eee_disabled_modes. MAC drivers that call phy_support_eee() after
probe (e.g. bcmgenet, fec, lan743x, lan78xx, r8169) then cause the PHY
to advertise EEE for modes the user marked as broken.

The symptom is that ethtool --show-eee on the local interface reports
"not supported" (supported & ~eee_disabled_modes is empty) while the
link partner sees EEE negotiated and active.

phy_probe() already filters advertising_eee via eee_disabled_modes
after calling of_set_phy_eee_broken(). Apply the same mask in
phy_support_eee() so the filtering survives the copy.

Fixes: 49168d1980e2 ("net: phy: Add phy_support_eee() indicating MAC support EEE")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/phy/phy_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index c2cdf1ae354249c033445f2d942e07220205b41c..83b074bc4a8f716b3e10c8ff57aff7c7abba0236 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2903,7 +2903,8 @@ EXPORT_SYMBOL_GPL(phy_advertise_eee_all);
  */
 void phy_support_eee(struct phy_device *phydev)
 {
-	linkmode_copy(phydev->advertising_eee, phydev->supported_eee);
+	linkmode_andnot(phydev->advertising_eee, phydev->supported_eee,
+			phydev->eee_disabled_modes);
 	phydev->eee_cfg.tx_lpi_enabled = true;
 	phydev->eee_cfg.eee_enabled = true;
 

-- 
2.51.0


