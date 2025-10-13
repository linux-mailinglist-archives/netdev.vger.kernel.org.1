Return-Path: <netdev+bounces-228734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1508BD357B
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 16:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF723C3A66
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 14:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E72257845;
	Mon, 13 Oct 2025 14:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ud7L3cUO"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C3D246BBA
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 14:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760364367; cv=none; b=qxq8N+pPEM5qhh5sEQaxt3UZaDMwDzC4gUVWbVgxEgIT5txGvx+cLUhJSTFcQfiIwqUvO4DubuJVm3SS1Odrzqd2qpauHT8SNjXb87SNbCzlQM76LoDpVWEVIHNf1xHossjZRNjz30uR3Rwn3JG+WBktSeL8PNvgst1czqPBcL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760364367; c=relaxed/simple;
	bh=geg8I+nETxI5ziYpbXwdwpnNQV78XDqit9OZRAJWrwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C/B5XJOKtnZx11ceqeCpryQhbykatNpk3/7XaSQqZhEyy5wMxMBlYVfu5p2mIkcYyZkoPEGpXa0nkH/m+Tt/YSdKdko1UWEAJYIzzne6QjhLlaravf7rtZCvXC57yN/l8n0XfrBsFUJP3AdHlkh9h+YZ7TOkhmm8Q0Ba4ivvLyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ud7L3cUO; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 1D4F1C093AF;
	Mon, 13 Oct 2025 14:05:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 10E40606C6;
	Mon, 13 Oct 2025 14:06:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 22B3C102F2210;
	Mon, 13 Oct 2025 16:06:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760364361; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=DJ6bl9fexgWAE7x+Dsr/tcexKmnyGVcgwz9KluNOsM8=;
	b=ud7L3cUOeTYxOIJ3MiciXTxrBA5fe6qHKgh4M0pmd/tXiH+zF1S1LNerIgAvF1CwvFkOwn
	HhAaSQ41uf0sDKhLUretd9sZpru5P5usbeSrg8Z0eE+XJ6PV4NlTFOSNTmODIgJSUCwFou
	9ynC/S/dMSKZqNEnVfcaRA2XW9Q46nR9/CojxLDAdpB1rzCkMyip1mi6kZKenzLf2Xnq3J
	BkpTli1v5xKCGT59HXtj2YJ1i138d3hgoEiOMGmZX7POoF5tpX7iJvqXXmChRnuD6UYCDh
	0UkMRbyIvR05wgyKDPZ9nzT4b8ooEKyTCBa7OhmRDPdvOTjoBZeD5/Tlz6daeA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Mon, 13 Oct 2025 16:05:31 +0200
Subject: [PATCH net-next v2 1/3] net: pse-pd: pd692x0: Replace __free macro
 with explicit kfree calls
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-feature_pd692x0_reboot_keep_conf-v2-1-68ab082a93dd@bootlin.com>
References: <20251013-feature_pd692x0_reboot_keep_conf-v2-0-68ab082a93dd@bootlin.com>
In-Reply-To: <20251013-feature_pd692x0_reboot_keep_conf-v2-0-68ab082a93dd@bootlin.com>
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


