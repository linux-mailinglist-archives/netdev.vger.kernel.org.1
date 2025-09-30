Return-Path: <netdev+bounces-227315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B00A2BAC333
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 11:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7076717CFC6
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 09:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448C92F6188;
	Tue, 30 Sep 2025 09:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="y38eQjeQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F8A2F547D
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 09:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759223625; cv=none; b=b6g6qsgOSBcFmFc2yWI+kbAYwy9b6Fb2jJz0n3eM3Vw3Awi3QFeEaCNa805GtiOrMot6B4Wq+mGZ8CAz0PtiZg9PUeGMbjsE00paveNrfjRj+xnFVPZ0fLWP3sU+EawoxezdoYQHwqq2yyaabBgZUDP0aehA2WFvlBFyxeKaNyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759223625; c=relaxed/simple;
	bh=geg8I+nETxI5ziYpbXwdwpnNQV78XDqit9OZRAJWrwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aaWAjJvjttXqyzQt/ObEo+2rAErZITCtpm22NeogszFo/VgyEmbUxR1A8li79Pa4I48qfXxzh3ZwQ4jgCNoFYloMjrXs6rzt8A45QRrKPMIHR/T8YFjBLintm/WpI5OxTXEguUv1SB/65IogwoxL/dAaRnDdH+Kgb+YO77u9HPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=y38eQjeQ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 32D741A0EC3;
	Tue, 30 Sep 2025 09:13:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0A051606E4;
	Tue, 30 Sep 2025 09:13:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7F7AF102F17CA;
	Tue, 30 Sep 2025 11:13:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759223612; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=DJ6bl9fexgWAE7x+Dsr/tcexKmnyGVcgwz9KluNOsM8=;
	b=y38eQjeQHkCpAmVNFJQ2i6p9/yrVr6GDHCQiwBHgrZCnL+f1Yt/U5rdM+SSGc8U0xWHgjo
	81Ko8MKhtWurFgJMBaK610YHymGdF0SNOJR1pI2HVuvJYenQBRQrF/hLcD8vMc+2IG9aDB
	yv2ubbDtFlUFjUMNAIQxaKaIgwmHjB4f9cPwNjVDLGO9/dCwXgw+l+QGke+rdXN4v0Q/kf
	RsTaYNF3ct+iGpInqNsNVLrfiaYMoTvY77DXNIeV5+QN9jA7ofgsAQLsL443VN6O0MUNGx
	wgNIYEwN8lZBjp/6AeppmoD6+orKAPC82gpBORIhlsGbAR6Q4KWWCE5tYzogzg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 30 Sep 2025 11:13:00 +0200
Subject: [PATCH net-next 1/3] net: pse-pd: pd692x0: Replace __free macro
 with explicit kfree calls
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-feature_pd692x0_reboot_keep_conf-v1-1-620dce7ee8a2@bootlin.com>
References: <20250930-feature_pd692x0_reboot_keep_conf-v1-0-620dce7ee8a2@bootlin.com>
In-Reply-To: <20250930-feature_pd692x0_reboot_keep_conf-v1-0-620dce7ee8a2@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, kernel@pengutronix.de, 
 Dent Project <dentproject@linuxfoundation.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-Last-TLS-Session-Version: TLSv1.3

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Replace __free(kfree) with explicit kfree() calls to follow the net
subsystem policy of avoiding automatic cleanup macros as described in
the documentation.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/pd692x0.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
index f4e91ba64a66..055e925c853e 100644
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


