Return-Path: <netdev+bounces-157061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE8DA08C9C
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA3C8188E44D
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A419E210190;
	Fri, 10 Jan 2025 09:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VytiExxB"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB6D20E317;
	Fri, 10 Jan 2025 09:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502057; cv=none; b=GBosFwaE4F2N6Yc2yKfOev5w5siqCJC7LNgXiQIkqbFw6jnv+cnZum3vca3ajL4eQg6256TTpzVZr5AqeS5zrHUZVC38KDFyT1uPe8iX74YAmvWqxL8dMQuteikl7aXjnqhLbvAsLWbkAOIj1pX1jv11U3ZfNjs+WYoSsZ6Uut0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502057; c=relaxed/simple;
	bh=tD3cUWo7lU27zE+wmy4bcCZ8/cT9VzKmKwl5C7RAPpw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i/rpDBbN4NVQRFGPyY9SK2BMk3qydrxmogxSZQ/p2oYWxx1NbJ2JCgmCELSwCM1Ttlem5MVvjtCL97QodI39ASyvnqqj0Ta79TyHYVNwDq4MqXxxKavcsiARzbtpQ8nlANJjCc4iE8t16rEm+mAwryL/oos4xMGauxWPKyT0BHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VytiExxB; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C5C296000F;
	Fri, 10 Jan 2025 09:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736502053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/6oSne4dRmo8YPb3DD5PeZu5riH1oqkDi9uLp8zoJkI=;
	b=VytiExxBD3tbcr7KrEGYc7dO27CckmY66ScrrhKf8BKaDL52vMRAV0dF+bsXKyPvi56+3h
	SJh2CLv3yBrrRnVXTLlk/9Le50u3C6dva/c1U2wMyL0yQcpSsS0/TzFatU/Miy5GCsq01L
	uyryVwGgwWEqD9c1W7tDDSWaNwtasSnX2XzpJPf3sI7t66LK82riQa2Qee/PToi0m5Gukt
	Nh+/tR4Q34bhTLzK3nGx496NnYrSX0+oQ3+w8b/FSqKbOFRFoBCusNy/FOD+XE+q3jxpgm
	6Z6OF7F1repfubLdILDpW8Bul5Qn5AhE18Xg9K7qmHysTTLUIv7yVD8ByrjPyg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 10 Jan 2025 10:40:30 +0100
Subject: [PATCH net-next v3 11/12] net: pse-pd: Fix missing PI of_node
 description
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-feature_poe_arrange-v3-11-142279aedb94@bootlin.com>
References: <20250110-b4-feature_poe_arrange-v3-0-142279aedb94@bootlin.com>
In-Reply-To: <20250110-b4-feature_poe_arrange-v3-0-142279aedb94@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-Sasl: kory.maincent@bootlin.com

The PI of_node was not assigned in the regulator_config structure, leading
to failures in resolving the correct supply when different power supplies
are assigned to multiple PIs of a PSE controller. This fix ensures that the
of_node is properly set in the regulator_config, allowing accurate supply
resolution for each PI.

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/pse_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 887a477197a6..b0272616a861 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -422,6 +422,7 @@ devm_pse_pi_regulator_register(struct pse_controller_dev *pcdev,
 	rconfig.dev = pcdev->dev;
 	rconfig.driver_data = pcdev;
 	rconfig.init_data = rinit_data;
+	rconfig.of_node = pcdev->pi[id].np;
 
 	rdev = devm_regulator_register(pcdev->dev, rdesc, &rconfig);
 	if (IS_ERR(rdev)) {

-- 
2.34.1


