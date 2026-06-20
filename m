Return-Path: <netdev+bounces-300797-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jQx2GsB4NmquAAcAu9opvQ
	(envelope-from <netdev+bounces-300797-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 13:25:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D19ED6A8CA8
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 13:25:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=szelinsky.de header.s=mail header.b=QdUfuPh8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300797-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300797-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=szelinsky.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BF003013A56
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 11:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8AF36828B;
	Sat, 20 Jun 2026 11:25:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851F023B63E;
	Sat, 20 Jun 2026 11:25:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781954728; cv=none; b=QuSEdpvu0zOM9b6QICreweFPG63BVM2nfKrO6laxuRT8OiJ+Lvli5AAYwwT8x1/0uyJajA7uaIEA4aH31se4NK5WflWhDvhKMHqt/OjTZa8mOIFh7Zscjy8/5nuJINWYmPMgnI9TI3xeaHbCmp5EpXqkJZakRBwoYgyUqrqCXwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781954728; c=relaxed/simple;
	bh=xC2c6x46nwoyHLo3yv4J3V+7eoNDWuxhiMLafw8euBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ck+8ZRPrPOU13cynVJjmnP4wf6sFBSm/f/1i9tkCgrwW6fupBrqnDrVY8q4hJFskOgQB/3DlKctVhX6VIDl3LT/gJiAfB/fTbgxfr3KPZ3NN0N4AHlcW2RvhrmiRzz5GDm9zfGgv3rocDsYncadl5Qhpe4eRn43bCck8HGKS9ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=QdUfuPh8; arc=none smtp.client-ip=85.214.127.56
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 6D438E8376F;
	Sat, 20 Jun 2026 13:25:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1781954725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qFI5fM5V2kWhCfbQgXoItwJOnglnpa8KAfRrVLMZTU4=;
	b=QdUfuPh8CP57toXk/7U0ViUGkjj5wqBx9c5eHF+YpTTB2o8Z+bEVxx9qHjs00vEFcIQ7Y9
	Nx7YygaiRIP/pN0MCkj9Y6Wt8dhiPLrFfi7i+zX9RqXXevdu7CrE9eYFVMct2NCrejTQvW
	Hq2bS4Sp5yWgmfI9/0pCMmBDjkqWEeaQnjKYJJllAuRrOfCPZ5dB+lLsFPHdkP/X39Kq7Q
	8IuW4BZOKHcR9QUvHTL93ST5zYgf8ceKabmuNeLAZ74u2vjYaHoiUuipSY6vSErF/TTZCc
	oJDjio60+d7s3naeE5ZpMezISER+W0fDubSQeNjJYwbAqddVetC/x87abosLQQ==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id iLQrpipqxuiy; Sat, 20 Jun 2026 13:25:25 +0200 (CEST)
Received: from p14sgen5.lanhh (dslb-002-205-089-174.002.205.pools.vodafone-ip.de [2.205.89.174])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sat, 20 Jun 2026 13:25:24 +0200 (CEST)
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
Subject: [PATCH net-next v2 1/4] net: pse-pd: scope pse_control regulator handle to kref lifetime
Date: Sat, 20 Jun 2026 13:24:37 +0200
Message-ID: <20260620112440.1734404-2-github@szelinsky.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[szelinsky.de:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300797-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[szelinsky.de:dkim,szelinsky.de:email,szelinsky.de:mid,szelinsky.de:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D19ED6A8CA8

From: Corey Leavitt <corey@leavitt.info>

__pse_control_release() drops psec->ps via devm_regulator_put(), which
only succeeds if the devres entry added by the matching
devm_regulator_get_exclusive() is still present on pcdev->dev at the
time the pse_control's kref hits zero.

In practice that assumption does not hold when the controller is
unbound while any pse_control still has consumers: pcdev->dev's
devres list is released LIFO, so every per-attach regulator-GET
devres runs (and regulator_put()s the underlying regulator) before
pse_controller_unregister() itself is invoked. Any later
pse_control_put() from that unbind path then reads psec->ps as a
dangling pointer inside devm_regulator_put() and WARNs at
drivers/regulator/devres.c:232 (devres_release() fails to find the
already-released match).

The pse_control's consumer handle is logically scoped to the
pse_control's refcount, not to pcdev->dev's devres lifetime. Switch
to the plain regulator_get_exclusive() / regulator_put() pair so
__pse_control_release() does the right put regardless of whether
the controller's devres has already been unwound.

No change to the regulator-framework-visible refcount or lifetime of
the underlying regulator: a single get paired with a single put. The
existing devm_regulator_register() for the per-PI rails is unchanged
(those ARE correctly scoped to the controller's lifetime).

Fixes: d83e13761d5b ("net: pse-pd: Use regulator framework within PSE framework")
Signed-off-by: Corey Leavitt <corey@leavitt.info>
Acked-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
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
-- 
2.43.0


