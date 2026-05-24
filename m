Return-Path: <netdev+bounces-291217-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2G38DfJ8E2r8BwcAu9opvQ
	(envelope-from <netdev+bounces-291217-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 00:34:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 940825C4994
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 00:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FC49301693A
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 22:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187EA37CD35;
	Sun, 24 May 2026 22:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="ZrNc8RUo"
X-Original-To: netdev@vger.kernel.org
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C2E31E83E;
	Sun, 24 May 2026 22:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779662022; cv=none; b=ia9laVhRDfVxRuCPjfwB6BYBbzLx6XlP5RVORZn82kj9YgkAgJ008MHBmT25SpkFXKOrubmwZ3K+ty6Cd7XWHp6fkK/pdnllPTzleSqHyQOLgws0t2QbKsgBAJB4nnf5HBR83oMMj4L+h/0gFvcB5oHknIwLkDxZQBV9bnzC780=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779662022; c=relaxed/simple;
	bh=lef7jDEh8cERrZ/T3PvvTpwbvOvm5W1jUTZp1eGRJok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JwOS1nAlm0aAEFQer4fbNKm7z55/cyaiW/MV1kcJJzE3z/glKiUXN/1FFDMvbEMf2ZzF91/wgZ7tBaChNbdUzpl6b6wquInegL/NxZzASYw1+NRQnIlKNPy0+cYLdpgFJ13SoGVrcrJZK5/U2pzeWXNEXfKrWTcdU1XrNNRscvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=ZrNc8RUo; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id CEB2AE832C8;
	Mon, 25 May 2026 00:33:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1779662018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i23nvziqwn5fq3xPYvwlQHH6b8y2Yc3RvN3DwqDNQOA=;
	b=ZrNc8RUoYd8xvpQru2FdlK0Zm8dRrR9aw7tKaBGoikDr/yEhuPSFoxHymfeQc7ThR6sUsk
	7VxP5rehVIjVSItMBF6PKt/0iYYAwDbrzKGVTGBUNVr5G+Qu4S/w/mSpFwx1irD0GDo3eO
	DiOrQu/+WbHFSkXVKAqzhqMeckhwToD+1wQSAf6lW/k4Px34kDVOrl5THEzD+JPhZObyjT
	/T/i99r12AUvED3M5P4w5f8nrVJEqvmROJNdBunKszYU1jvxOEJjlXhfgAY3zNR7a+ozcC
	poQ3HQMjZ7BBT3cSt8moFVoW4pQeD0aIFAaB+kSEjiBCVBn7yBalgZKM7xMFjg==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id 2Frv7o3fW5E0; Mon, 25 May 2026 00:33:38 +0200 (CEST)
Received: from p14sgen5.lan (p5784d936.dip0.t-ipconnect.de [87.132.217.54])
	by szelinsky.de (Postfix) with ESMTPSA;
	Mon, 25 May 2026 00:33:38 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net 2/2] net: pse-pd: guard against freed PI data on regulator disable
Date: Mon, 25 May 2026 00:33:06 +0200
Message-ID: <20260524223306.2570676-3-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260524223306.2570676-1-github@szelinsky.de>
References: <20260524223306.2570676-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[szelinsky.de,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[szelinsky.de:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291217-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[github@szelinsky.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[szelinsky.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.963];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[szelinsky.de:email,szelinsky.de:mid,szelinsky.de:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 940825C4994
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PSE PI regulators are devm-registered inside pse_controller_register(),
which runs before devres_add() arms the controller's own release in
devm_pse_controller_register(). On driver detach, devres unwinds in LIFO
order, so pse_controller_unregister() runs first and frees pcdev->pi via
pse_release_pis(); the regulators are torn down afterwards.

When regulator_unregister() flushes a pending disable, the regulator core
invokes pse_pi_disable(), which dereferences pcdev->pi[id] (directly and
via _pse_pi_disable() -> pse_pi_deallocate_pw_budget()). At that point the
PI array is already freed, so this is a use-after-free.

pse_release_pis() now clears pcdev->pi after freeing it, and
pse_pi_disable() bails out under the lock when pcdev->pi is NULL, so a
late disable from the regulator core is a no-op once the controller has
been unregistered.

Fixes: ffef61d6d273 ("net: pse-pd: Add support for budget evaluation strategies")
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 17f45e4b672b..9ae0df3cb5cf 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -145,6 +145,7 @@ static void pse_release_pis(struct pse_controller_dev *pcdev)
 		of_node_put(pcdev->pi[i].np);
 	}
 	kfree(pcdev->pi);
+	pcdev->pi = NULL;
 }
 
 /**
@@ -702,15 +703,21 @@ static int pse_pi_enable(struct regulator_dev *rdev)
 static int pse_pi_disable(struct regulator_dev *rdev)
 {
 	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
-	struct pse_pi *pi;
 	int id, ret;
 
 	id = rdev_get_id(rdev);
-	pi = &pcdev->pi[id];
 	mutex_lock(&pcdev->lock);
+	/* The controller may already be unregistered (pcdev->pi freed) by the
+	 * time the regulator core flushes a deferred disable during
+	 * regulator_unregister(). Bail out to avoid touching freed PI data.
+	 */
+	if (!pcdev->pi) {
+		mutex_unlock(&pcdev->lock);
+		return 0;
+	}
 	ret = _pse_pi_disable(pcdev, id);
 	if (!ret)
-		pi->admin_state_enabled = 0;
+		pcdev->pi[id].admin_state_enabled = 0;
 
 	mutex_unlock(&pcdev->lock);
 	return 0;
-- 
2.43.0


