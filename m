Return-Path: <netdev+bounces-302244-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6RmrObKwPmoyKQkAu9opvQ
	(envelope-from <netdev+bounces-302244-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 19:02:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B17E6CF514
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 19:02:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=szelinsky.de header.s=mail header.b=bxsBwFt2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302244-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302244-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=szelinsky.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 652C630ACD79
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 17:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3F12F546D;
	Fri, 26 Jun 2026 17:00:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3335C401A25;
	Fri, 26 Jun 2026 17:00:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782493217; cv=none; b=HFpu399kSB0YyZNGtRSPwQB2KKl3vqrK4wRoa+p5u0a1G9qRJLbc0y0LVkVms8CKew2TieswNV7RP1uuSlWO9lIi8jsv+KdM6mbznBW4w4JH4s/v9RQl25kxA3l0BrS6SkIYjHza/TNpPVP/YMuNelfDSGH0de8mZXOCC/32lvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782493217; c=relaxed/simple;
	bh=Y6+5qepS+YeXyE3tdWCBNEUe0gdsOnQyh/Moqih+Tck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mLshUpLWOaX0RP9e/awfVqI23DysseK63PtVBMNwPIxN7VFQ2JyTiuqtgY3GpzLoGbhoR9/c0D0vp4JkE5B8HetwRrZfTsT50P7f7MFQ9gTf/XXEBbcUcyyE14KoqbuEqD0arXzYlkY6fmjPM27YLe2ksKCgvg7g5TOFJXzJu5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=bxsBwFt2; arc=none smtp.client-ip=85.214.127.56
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id B53DAE833E4;
	Fri, 26 Jun 2026 18:59:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1782493197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hl2c4C1zfRutMZ0q3xXwaH9XYCKVjPo/8MxgsRvbOlw=;
	b=bxsBwFt2i+fxdzN8bvuC8mS017Vve2cDi1xtT28ibv6dgqg8bh5PssKhS9TSnXJa/95Whk
	kTtOuvwcKmNmvKI0nCz/FMoMDMpXrHUFBF03XJoAxNuL+D/FbINu1ihbqY/2dDPUfiYzu3
	rmqugWowqJhvD9kQ84NVnX0YjfJR0i7fTRoV0Emro8iKyaTW929OjQM+Oc+OSFtCmfksNs
	hte1X4ueY+0iY82GAcYRq9Qls2jjjRKE86h8S+VVz/D26m4igZayuKTcWBeRrTWLJccl1U
	G1CcEMBuzqoQIqOA7CH/CzZFz7twneNzmAVAcVi/3FVIHJSgymw754eL8ya1GQ==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id PqosfwpXgARf; Fri, 26 Jun 2026 18:59:57 +0200 (CEST)
Received: from p14sgen5.lan (p5784dea5.dip0.t-ipconnect.de [87.132.222.165])
	by szelinsky.de (Postfix) with ESMTPSA;
	Fri, 26 Jun 2026 18:59:56 +0200 (CEST)
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
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net-next v3 2/3] net: pse-pd: fire lifecycle events on controller register/unregister
Date: Fri, 26 Jun 2026 18:59:28 +0200
Message-ID: <20260626165929.2908782-3-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626165929.2908782-1-github@szelinsky.de>
References: <20260626165929.2908782-1-github@szelinsky.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[szelinsky.de:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302244-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:corey@leavitt.info,m:jelonek.jonas@gmail.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:github@szelinsky.de,m:andrew@lunn.ch,m:jelonekjonas@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,bootlin.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[github@szelinsky.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[leavitt.info,gmail.com,kernel.org,vger.kernel.org,szelinsky.de];
	DKIM_TRACE(0.00)[szelinsky.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[github@szelinsky.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,szelinsky.de:dkim,szelinsky.de:email,szelinsky.de:mid,szelinsky.de:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B17E6CF514

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
index 3c4d09f1d6e4..0190fac33c78 100644
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


