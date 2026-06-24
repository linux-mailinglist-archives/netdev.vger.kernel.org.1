Return-Path: <netdev+bounces-301772-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BdfMFEtCPGoylwgAu9opvQ
	(envelope-from <netdev+bounces-301772-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 22:47:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A249A6C140D
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 22:47:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=szelinsky.de header.s=mail header.b=jvL4gJfJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301772-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301772-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=szelinsky.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFF97311E5B8
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 20:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7B73E1D16;
	Wed, 24 Jun 2026 20:40:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DB23E2764;
	Wed, 24 Jun 2026 20:40:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782333631; cv=none; b=H6aWGfh9ftznYxlZmoWF4ts/mbB4Vq+WW4+XaJ+Qz7bQMqlBW6K+qef3ZKcouMvzNpMIDOhrz9qGs+OYyBzJ+aRxAAqLECyRWte4xakpjIaCI+AI6FADfuv3B1TKwLUBhJ26Qie48YDiQ2+qJR32j6AaSBB/HdvYsS056PTA8Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782333631; c=relaxed/simple;
	bh=YLbMAwskt7L0WxpL5RKlc+2Uku1Pkzex9CfmRPGF/6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lPCtS46GdwQEoTUvf3pCPW/+yBLhxBFu16NUDbAkkItMUOuEv5p+dYIFJ+mUDJjOnQmLPM69i3PQeko3hZRQY1ggB564tBDJeZz//p54mZrvwx4Ex/dCnXKGzWyTW8MmcXb0528AIuRD6FxgSAkNfgIS4dZUYakFUbdw0CY3yIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=jvL4gJfJ; arc=none smtp.client-ip=85.214.127.56
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 8258AE830EC;
	Wed, 24 Jun 2026 22:40:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1782333621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Rggi+aPv19PS773gU4BgfR3PVwD8NpJEYnikVMMug58=;
	b=jvL4gJfJQgniwv8ngBrLO2TMYfS656/7H/McdZ9i92byj6mfSGlS4CtDazKlm6/liPiFQX
	3pqgl0nyAduR9vqLxi/b9FQoYmzRof7bodSYAEDkfFdoYZbfolZfJD78/SrxIAsF5+q6xs
	T/QYw+RLeyyo9EE0D3quN91eVYHgyxUijxfnxkefKKK+7CRl16AA8obsHpXlv9Q/hzh8Ep
	CPSAJbfyAaKkX07LIrj05LD+nSWjkbeegDuGAvO/f2r0PeoMpXHCXotswqDvwvBnlN43x5
	gMrug1k9i6Q93CCAegeHygSFvB6BxjmekuQwNdvUq3WTpqDiuZrPse6YFsAfXQ==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id 2aR3pwkZrhjJ; Wed, 24 Jun 2026 22:40:21 +0200 (CEST)
Received: from p14sgen5.lanhh (dslb-088-070-183-212.088.070.pools.vodafone-ip.de [88.70.183.212])
	by szelinsky.de (Postfix) with ESMTPSA;
	Wed, 24 Jun 2026 22:40:20 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Corey Leavitt <corey@leavitt.info>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net v2] net: pse-pd: scope pse_control regulator handle to kref lifetime
Date: Wed, 24 Jun 2026 22:40:16 +0200
Message-ID: <20260624204017.2752934-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[szelinsky.de,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[szelinsky.de:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,leavitt.info,gmail.com,armlinux.org.uk,vger.kernel.org,szelinsky.de];
	TAGGED_FROM(0.00)[bounces-301772-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:corey@leavitt.info,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:github@szelinsky.de,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[github@szelinsky.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[github@szelinsky.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[szelinsky.de:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,szelinsky.de:dkim,szelinsky.de:email,szelinsky.de:mid,szelinsky.de:from_mime,bootlin.com:email,leavitt.info:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A249A6C140D

From: Corey Leavitt <corey@leavitt.info>

__pse_control_release() drops psec->ps via devm_regulator_put(), which
only succeeds if the devres entry added by the matching
devm_regulator_get_exclusive() is still present on pcdev->dev at the
time the pse_control's kref hits zero.

That assumption does not hold when the controller is unbound while a
pse_control still has consumers: pcdev->dev's devres list is released
LIFO, so every per-attach regulator-GET devres runs (and
regulator_put()s the underlying regulator) before
pse_controller_unregister() itself is invoked. Any later
pse_control_put() from that unbind path then reads psec->ps as a
dangling pointer inside devm_regulator_put() and WARNs at
drivers/regulator/devres.c:232 (devres_release() fails to find the
already-released match).

The pse_control's consumer handle is logically scoped to the
pse_control's refcount, not to pcdev->dev's devres lifetime. Switch to
the plain regulator_get_exclusive() / regulator_put() pair so the
regulator put in __pse_control_release() no longer depends on the
controller's devres still being present. No change to the
regulator-framework-visible refcount or lifetime of the underlying
regulator: a single get paired with a single put. The existing
devm_regulator_register() for the per-PI rails is unchanged (those ARE
correctly scoped to the controller's lifetime).

This addresses only the regulator handle. The same unbind-while-held
scenario also leaves __pse_control_release() reading psec->pcdev->pi[]
and psec->pcdev->owner after pse_controller_unregister() has freed
pcdev->pi, because the controller does not drain its outstanding
pse_control references on unregister. That wider pse_control vs
pcdev lifetime problem pre-dates this change and is addressed by the
PSE controller notifier series, which drains phydev->psec on
PSE_UNREGISTERED before pcdev->pi is freed.

Link: https://lore.kernel.org/netdev/20260620112440.1734404-1-github@szelinsky.de/
Fixes: d83e13761d5b ("net: pse-pd: Use regulator framework within PSE framework")
Signed-off-by: Corey Leavitt <corey@leavitt.info>
Acked-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
This is patch 1 of the "decouple controller lookup from MDIO probe"
series, reposted on its own for net as Jakub suggested. The rest of the
series targets net-next and is deferred until it reopens.

Changes in v2:
- Reword the commit message to scope the fix to the regulator handle.
  As Simon's review pointed out, the same unbind-while-held path also
  reads pcdev->pi[] and pcdev->owner after pse_release_pis(); that wider
  pse_control vs pcdev lifetime issue is fixed by the notifier series,
  not here. No code change.
  Link: https://lore.kernel.org/netdev/20260624151251.1137250-1-horms@kernel.org/
v1: https://lore.kernel.org/netdev/20260622192839.2508733-1-github@szelinsky.de/
---
 drivers/net/pse-pd/pse_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 69dbdbde9d71..a5e6d7b26b9f 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -1367,7 +1367,7 @@ static void __pse_control_release(struct kref *kref)
 
 	if (psec->pcdev->pi[psec->id].admin_state_enabled)
 		regulator_disable(psec->ps);
-	devm_regulator_put(psec->ps);
+	regulator_put(psec->ps);
 
 	module_put(psec->pcdev->owner);
 
@@ -1436,8 +1436,8 @@ pse_control_get_internal(struct pse_controller_dev *pcdev, unsigned int index,
 		goto free_psec;
 
 	pcdev->pi[index].admin_state_enabled = ret;
-	psec->ps = devm_regulator_get_exclusive(pcdev->dev,
-						rdev_get_name(pcdev->pi[index].rdev));
+	psec->ps = regulator_get_exclusive(pcdev->dev,
+					   rdev_get_name(pcdev->pi[index].rdev));
 	if (IS_ERR(psec->ps)) {
 		ret = PTR_ERR(psec->ps);
 		goto put_module;

base-commit: d87363b0edfc7504ff2b144fe4cdd8154f90f42e
-- 
2.43.0


