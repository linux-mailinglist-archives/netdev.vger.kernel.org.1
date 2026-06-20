Return-Path: <netdev+bounces-300799-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 39KMIgJ5Nmq9AAcAu9opvQ
	(envelope-from <netdev+bounces-300799-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 13:26:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 203AF6A8CB9
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 13:26:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=szelinsky.de header.s=mail header.b="cn9Ra/te";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300799-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300799-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=szelinsky.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96117300E26D
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 11:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DBE39182C;
	Sat, 20 Jun 2026 11:25:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8713914E8;
	Sat, 20 Jun 2026 11:25:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781954733; cv=none; b=Rxmlu8gouf7ijmPj2knZyNSOJjaBJtQfGLDmH0cekaDcIZzQ0cML0vIw0H0uQxKK/4k+esfhrKy8S8WsCV5u1ucZiElpBMjwpAZ1aYZPzHbK0SDtzxUp7DkILAYXAW23YVjEJI1MWUcG4t+VIQFnMwNWpAETk2F+i8w36CM/grA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781954733; c=relaxed/simple;
	bh=RtzjEC00/1c4M3qwxKrLJiwk3ru3iayWC/pZExXiWtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8RqvTSZinNtf5lxj1fkvXg8lPqsGRNAz6Vyl0K7rCJb3SKrgxeG1dbYPyGNoibguIV9A6YjyvFLmxsnI2ya/ehr0Ka8baOwqgqE+2gSz6cdz0SvXDYYnvBp+1bRFqUXpYpKuAXjCCMMRwgQIVnsb6E5XD4uoa7MUYDPb369Weo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=cn9Ra/te; arc=none smtp.client-ip=85.214.127.56
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id DCF1FE837D4;
	Sat, 20 Jun 2026 13:25:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1781954730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7D/AJHG02DYHVHpDVk25bH2JSOa8jIzTKcJmEKWyiiw=;
	b=cn9Ra/te9vdLPbPFxhIHFhe9aXg6EONKMetdf5ffRYKXPbMOByORrmfz0x8Axu/teMXAkB
	LdFWcIyVDA4c4sadVek3lGwPf/k1a+aPaRMtfP9qEAxZamWFLOANsR8K1bakikzR9Aq4TJ
	3LnCgpZU5xAjGHkzd7cJMAcNF0Lwa/zmh6KQAG0oRAwPHpzZL5gJe4rC5EsS+25BmRFb/d
	Dk1yaCzX0JqHPx2YvFV31Jm9PxL7/yBdq2y6C+uRhhoSqY58dGkO308wjZA/qpNTSh5OCU
	Kzwve2PG93pibn0XxGAVh/TS8Cr46nFe6uTDPof9QhmXaDg2gFMlN361YQZkQw==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id QzQpFqpR1hFO; Sat, 20 Jun 2026 13:25:30 +0200 (CEST)
Received: from p14sgen5.lanhh (dslb-002-205-089-174.002.205.pools.vodafone-ip.de [2.205.89.174])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sat, 20 Jun 2026 13:25:30 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Corey Leavitt <corey@leavitt.info>,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net-next v2 3/4] net: pse-pd: fire lifecycle events on controller register/unregister
Date: Sat, 20 Jun 2026 13:24:39 +0200
Message-ID: <20260620112440.1734404-4-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260620112440.1734404-1-github@szelinsky.de>
References: <20260423-pse-notifier-decouple-v1-0-86ed750a9d62@leavitt.info>
 <20260620112440.1734404-1-github@szelinsky.de>
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
	DMARC_POLICY_ALLOW(-0.50)[szelinsky.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[szelinsky.de:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300799-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:corey@leavitt.info,m:jelonek.jonas@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:github@szelinsky.de,m:andrew@lunn.ch,m:jelonekjonas@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,bootlin.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[github@szelinsky.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[leavitt.info,gmail.com,vger.kernel.org,szelinsky.de];
	DKIM_TRACE(0.00)[szelinsky.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[github@szelinsky.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[szelinsky.de:dkim,szelinsky.de:email,szelinsky.de:mid,szelinsky.de:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,leavitt.info:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 203AF6A8CB9

From: Corey Leavitt <corey@leavitt.info>

Hook the newly-introduced pse_controller_notifier chain so that
pse_controller_register() fires PSE_REGISTERED after the controller
has been added to pse_controller_list (i.e. is now resolvable by
of_pse_control_get()), and pse_controller_unregister() fires
PSE_UNREGISTERED before the controller is removed from the list
(while it is still valid to dereference from a subscriber's
pse_control pointer targeting it).

With no subscribers yet, this is observably a no-op. A later change
wires the phy subsystem in as the first subscriber.

Signed-off-by: Corey Leavitt <corey@leavitt.info>
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 84c734ed4553..37ba4ab778af 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -1138,6 +1138,9 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
 	list_add(&pcdev->list, &pse_controller_list);
 	mutex_unlock(&pse_list_mutex);
 
+	blocking_notifier_call_chain(&pse_controller_notifier,
+				     PSE_REGISTERED, pcdev);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pse_controller_register);
@@ -1148,6 +1151,9 @@ EXPORT_SYMBOL_GPL(pse_controller_register);
  */
 void pse_controller_unregister(struct pse_controller_dev *pcdev)
 {
+	blocking_notifier_call_chain(&pse_controller_notifier,
+				     PSE_UNREGISTERED, pcdev);
+
 	pse_flush_pw_ds(pcdev);
 	pse_release_pis(pcdev);
 	if (pcdev->irq)
-- 
2.43.0


