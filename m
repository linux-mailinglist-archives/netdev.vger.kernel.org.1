Return-Path: <netdev+bounces-110858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E3992EA05
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 15:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF9591F23B85
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 13:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65541607B0;
	Thu, 11 Jul 2024 13:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="M+Ze2f/H"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01F815F40A;
	Thu, 11 Jul 2024 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720706157; cv=none; b=nUZeQ2C2oUNjHB+zUCnzJWzM1lk5dLRXP26+A/niLcbybd8OZgSYpWjeSVO8CH5IZsrW9GYbBOQ8TjoaskFvECjdpvZwqe+KZnrOTqxVBo1WSCIrH5aIf364jtheP1oN9UlYMY6mgoPiEpc0YlRF6kbcW9diCF0m8yykeq7mkok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720706157; c=relaxed/simple;
	bh=YqS9RdaQZvghw3onpj5/1G8LNAAYXaqJhpZuG4nEhZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dC2nNHdI5/aoQbBhPuui+1bs1JdtVRxLEvH8YtIkNc5T6wXD8A4wrW/8jeUrrEuUb4hQgDU6/Sp4qcNMsaE5d+28CSf8jRBODEf6+EbaP/t78tBkL+TGotxFiNkiQ5fA6artMP2hopNEVsDOmw5zN3lULtOcCFsT6cdxicPuBFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=M+Ze2f/H; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6EE73C0003;
	Thu, 11 Jul 2024 13:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720706153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J7XfW627Qfdj48cFxmYq/CvblcgTyZx62zXLjChHtNA=;
	b=M+Ze2f/HYeNQQ+Fny/Sv33v4j1WztYbvADEHSDE/OHP8bzcjXo+ZZZtV+ZGKpQDDr0h2ro
	gCya6B7A88Ainp7uTlU52xKM27b8nCKkHlcK/TT329zT1eM88qpJ3TFgsZFq2tq6GKc6uB
	Rs+pXenf23M8LwBwyS/sMVnM3Q6DxTXwdsKeLRl0twXX18CEqgjspgWeC1kLnjXgba/wzL
	fc9ctdbYQLZxXmIES5ENPA7PAH91/NqLrbQqodpjIsw7PE6QEQyE/XSFBO3+a2JDOVaYkz
	vuJiR6o8kiYm0f6A4AW8SLBHjM9sGIzoV8BMRFQegbM1HHYxYT7IR+Y/d5ZeKg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 11 Jul 2024 15:55:18 +0200
Subject: [PATCH net v3 1/2] net: pse-pd: Do not return EOPNOSUPP if config
 is null
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-fix_pse_pd_deref-v3-1-edd78fc4fe42@bootlin.com>
References: <20240711-fix_pse_pd_deref-v3-0-edd78fc4fe42@bootlin.com>
In-Reply-To: <20240711-fix_pse_pd_deref-v3-0-edd78fc4fe42@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: kory.maincent@bootlin.com

For a PSE supporting both c33 and PoDL, setting config for one type of PoE
leaves the other type's config null. Currently, this case returns
EOPNOTSUPP, which is incorrect. Instead, we should do nothing if the
configuration is empty.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
Fixes: d83e13761d5b ("net: pse-pd: Use regulator framework within PSE framework")
---

Changes in v2:
- New patch to fix dealing with a null config.
---
 drivers/net/pse-pd/pse_core.c | 4 ++--
 net/ethtool/pse-pd.c          | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 795ab264eaf2..513cd7f85933 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -719,13 +719,13 @@ int pse_ethtool_set_config(struct pse_control *psec,
 {
 	int err = 0;
 
-	if (pse_has_c33(psec)) {
+	if (pse_has_c33(psec) && config->c33_admin_control) {
 		err = pse_ethtool_c33_set_config(psec, config);
 		if (err)
 			return err;
 	}
 
-	if (pse_has_podl(psec))
+	if (pse_has_podl(psec) && config->podl_admin_control)
 		err = pse_ethtool_podl_set_config(psec, config);
 
 	return err;
diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index 2c981d443f27..982995ff1628 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -183,7 +183,9 @@ ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
 	if (pse_has_c33(phydev->psec))
 		config.c33_admin_control = nla_get_u32(tb[ETHTOOL_A_C33_PSE_ADMIN_CONTROL]);
 
-	/* Return errno directly - PSE has no notification */
+	/* Return errno directly - PSE has no notification
+	 * pse_ethtool_set_config() will do nothing if the config is null
+	 */
 	return pse_ethtool_set_config(phydev->psec, info->extack, &config);
 }
 

-- 
2.34.1


