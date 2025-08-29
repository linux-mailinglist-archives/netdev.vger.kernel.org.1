Return-Path: <netdev+bounces-218342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFC3B3C0B9
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 18:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4328CA01E09
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 16:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CACF33438D;
	Fri, 29 Aug 2025 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="D6B66iWh"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AC332C307;
	Fri, 29 Aug 2025 16:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485006; cv=none; b=HsISaac5ig8p6h3YaXF/zjet2e5TBL4EvL6nziMsvkxjTyyIcaT6EiDUUn7JE7nyDAnKqV7ll3shEXrtsIBOofJCVMlqlNE6jWxF2rDv21zvgg9vg1O62eX8xlTwpz4nZkl0tmiXWD0P8WKzfN57TvzynXMO2i5fkOz1w0MLHFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485006; c=relaxed/simple;
	bh=eI1aiFNYryO+t5nHeumpPB+dsVNw8uOQsJ0Hivfxi60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rhQQrkPeAxRqbKxG+wqvk/sAe3psiDr3cNXMr/qgh+P8ZaPC2t+uIGrcUGSmdH147U3mrA3dJBCDi7zCYDQPYYN/yqCTxt1cCVErC1FLqaAJa8Gfh4HtEDDZGEJbOBDqJmV66HaL02Z8d1JyyTvH1fBOB304eDiBouel5UxiuGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=D6B66iWh; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 888C74E40C8A;
	Fri, 29 Aug 2025 16:30:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A77D9605F1;
	Fri, 29 Aug 2025 16:30:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 66CC91C228022;
	Fri, 29 Aug 2025 18:29:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756485000; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=G5hFWIHn9ebEQkKaq4cychymeANjC1DTgGmjV0wrK34=;
	b=D6B66iWhhIkneh6Of/grY33WCc1fdZG14R0ITLbqgX8JoY0egDLm4lqQAPPxw2tjCujfMQ
	NraUFtveckrHI4GoKj2+cXJ4wmAwCsqn12O96aRD5LXMWYRSJ2trizHmDBav5aVXH7FRTO
	7/+NHZEjFUgHniZYJ8YqBTu0bfWjj5wWGZwW0zwIho4SfMFsiQlMM0ycnYlWFg16QtrrO3
	PocKThLwG6qj1nd99lowsFu4Guwl2MsNIydEz7RUKPrALb2onj/RM/SwWPfg+4x7aN/gcH
	EsV+Z0GIlsZWs5zvqYcAXFOo6H8QHZqIYKwSaXX0h/6gXHCGwSbyMbdu9/D0Aw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 29 Aug 2025 18:28:43 +0200
Subject: [PATCH net-next v2 1/4] net: pse-pd: pd692x0: Replace __free macro
 with explicit kfree calls
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-feature_poe_permanent_conf-v2-1-8bb6f073ec23@bootlin.com>
References: <20250829-feature_poe_permanent_conf-v2-0-8bb6f073ec23@bootlin.com>
In-Reply-To: <20250829-feature_poe_permanent_conf-v2-0-8bb6f073ec23@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: kernel@pengutronix.de, Dent Project <dentproject@linuxfoundation.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 linux-doc@vger.kernel.org, 
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


