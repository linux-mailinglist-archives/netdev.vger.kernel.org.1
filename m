Return-Path: <netdev+bounces-223186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DBBB582C9
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 19:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C572A189E584
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 17:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9BC288C2A;
	Mon, 15 Sep 2025 17:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gwXZjCJA"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8252727ED
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 17:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757956038; cv=none; b=TlSDdIZoh/R5T0RQGTtUybj1W2PISl8IVA90xYBkE1DuXz/y67tC8MORX1V66/Kom6JQZEniYBmazWyInSjn3QBUgseclF+B92CyAGiw29+UsqoR7UN8nKt1CmlUJHI8JMPmjCocEbGlkQIG5tGIbLQpk/+kW5tiFtLFgqgxXmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757956038; c=relaxed/simple;
	bh=eI1aiFNYryO+t5nHeumpPB+dsVNw8uOQsJ0Hivfxi60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T4E+EGLs9noLo3t1SFuSFeisAJ5lTPP3ieAWRlHQuFzIHgIxHiXJmAxn1dAXlfNOnrmAW56f+QVIUXe5PZw+rAsD2/zX0nGQzQFlroMmrJsuFWodPCfDdwddm0wBEJxQQfloIrbinyOXKw5rSBaBDT4OVU0GsFR046uzGaowwsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gwXZjCJA; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E0CB84E40C4A;
	Mon, 15 Sep 2025 17:07:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B7BF36063F;
	Mon, 15 Sep 2025 17:07:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A4615102F2AC9;
	Mon, 15 Sep 2025 19:07:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757956027; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=G5hFWIHn9ebEQkKaq4cychymeANjC1DTgGmjV0wrK34=;
	b=gwXZjCJAl2Bi3wAyCQradf8Md2OBAKMei6tUtWuDnoTWGUiXZ41Hhcp4wfbjQ3UUG2gcly
	B2ktxdr49H2jv0OY3ca7u1KtH5VWARNddHeRAfb7Kzb64IDj8T8pUUPkWwcIUSzq6d08v+
	38vvD3d9mYCHzwsFQ5xogPt/FN5iQJQpLJEpvYofsG9LkZ1X2xSx/oAo8oMKkRtJRQmEsR
	VE7QJUrb14032Lv+19sS9uMJN1o2UxvJhOrm/TXACdy1ZXy1eRNzoxRoc59Ymr/iVAaKFn
	rAcax5xDh3elN6o2BC6vdTWLkFlGEAvXMuCugW2/qOdU1SVR7CcAlIMj09EmAQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Mon, 15 Sep 2025 19:06:26 +0200
Subject: [PATCH net-next v3 1/5] net: pse-pd: pd692x0: Replace __free macro
 with explicit kfree calls
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-feature_poe_permanent_conf-v3-1-78871151088b@bootlin.com>
References: <20250915-feature_poe_permanent_conf-v3-0-78871151088b@bootlin.com>
In-Reply-To: <20250915-feature_poe_permanent_conf-v3-0-78871151088b@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>
Cc: kernel@pengutronix.de, Dent Project <dentproject@linuxfoundation.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-Last-TLS-Session-Version: TLSv1.3

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Replace __free(kfree) with explicit kfree() calls to follow the net
subsystem policy of avoiding automatic cleanup macros as described in
the documentation.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v2:
- New patch
---
 drivers/net/pse-pd/pd692x0.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
index f4e91ba64a666..055e925c853ef 100644
--- a/drivers/net/pse-pd/pd692x0.c
+++ b/drivers/net/pse-pd/pd692x0.c
@@ -1200,9 +1200,9 @@ static void pd692x0_managers_free_pw_budget(struct pd692x0_priv *priv)
 
 static int pd692x0_setup_pi_matrix(struct pse_controller_dev *pcdev)
 {
-	struct pd692x0_manager *manager __free(kfree) = NULL;
 	struct pd692x0_priv *priv = to_pd692x0_priv(pcdev);
 	struct pd692x0_matrix port_matrix[PD692X0_MAX_PIS];
+	struct pd692x0_manager *manager;
 	int ret, nmanagers;
 
 	/* Should we flash the port matrix */
@@ -1216,7 +1216,7 @@ static int pd692x0_setup_pi_matrix(struct pse_controller_dev *pcdev)
 
 	ret = pd692x0_of_get_managers(priv, manager);
 	if (ret < 0)
-		return ret;
+		goto err_free_manager;
 
 	nmanagers = ret;
 	ret = pd692x0_register_managers_regulator(priv, manager, nmanagers);
@@ -1236,12 +1236,15 @@ static int pd692x0_setup_pi_matrix(struct pse_controller_dev *pcdev)
 		goto err_managers_req_pw;
 
 	pd692x0_of_put_managers(priv, manager, nmanagers);
+	kfree(manager);
 	return 0;
 
 err_managers_req_pw:
 	pd692x0_managers_free_pw_budget(priv);
 err_of_managers:
 	pd692x0_of_put_managers(priv, manager, nmanagers);
+err_free_manager:
+	kfree(manager);
 	return ret;
 }
 

-- 
2.43.0


