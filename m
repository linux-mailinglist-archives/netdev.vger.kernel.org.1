Return-Path: <netdev+bounces-101703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B73BD8FFD1C
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 09:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C1E0282FD1
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 07:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5D54E1DD;
	Fri,  7 Jun 2024 07:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kRuCUUPE"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D5A225D6;
	Fri,  7 Jun 2024 07:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717745441; cv=none; b=Stpz0vvNR86/KkG0K8n/UQ9/abSgDd0nUMQxCC1DWpwvSbONISEqbq66/1TgOqkiJH7L1jlNl2Z5hp6gRaXjtJMw4rVqXRcFyzpC9IStojpWnzE+tzTLEEyQla5EkS13Z9uDyNrUu1r72ahwApADtbCrwSRvWFpugmUFrlLqcEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717745441; c=relaxed/simple;
	bh=YAjMVZ3ggIgJ5SUYbEnnK+9a9PzdMaGXk8lNx4zAoiE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qndULc2vpNQ2sAQzRL5gnGWbP9kYMDSUE4tL0elILwKH2Azl2ggi/3d2CDspSvgGrNuGQY6AtpqfAXkTuSMw2L1qCcV4YJf5qrh0YAz13o8iyjLblmcNbN/nXSTHFFj2fIPy9MFHXhP+LA6GvrqwjIa0RXtechQovYx9gQWNfhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kRuCUUPE; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0B6B84000D;
	Fri,  7 Jun 2024 07:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717745437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DctDY5wpYKdA8rU+Ryw9aKqZwgCO7G1RtPicZ+uP11I=;
	b=kRuCUUPEgzsga3OUcOm1MIJUwXeh7c11OGGlDPMr3YEE6fRPvwJW45hYwkiKwpSYtkwXom
	BXRyHvqsUW4DxMKJeuGVCzGNaF3WXLn2HCkS1FZtAsUX9cJBwq/GMLvG7LWdZSrI+PJ0AP
	RPg4ZTXpTaGRjfC2R8VLpcMRAtHC1mNsbp5ozDAanMM0SlWI+7aZhgKuh03vwxepxmgmft
	nLMO9/OK+G4wFxIKI9tPBKBXeiQ5bijm3RMmc7h9HRGIP/uzSDPQp+/mSdw0k1kuzkPQ0C
	GuCZnaP7CSZmGzcGZrZ0gmUIJ9XsrWnRr9R6c1KsmxsP94M/NeCgPpU/y5onhA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 07 Jun 2024 09:30:18 +0200
Subject: [PATCH net-next v2 1/8] net: pse-pd: Use EOPNOTSUPP error code
 instead of ENOTSUPP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-feature_poe_power_cap-v2-1-c03c2deb83ab@bootlin.com>
References: <20240607-feature_poe_power_cap-v2-0-c03c2deb83ab@bootlin.com>
In-Reply-To: <20240607-feature_poe_power_cap-v2-0-c03c2deb83ab@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Kory Maincent <kory.maincent@bootlin.com>, Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14-dev
X-GND-Sasl: kory.maincent@bootlin.com

From: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>

ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP as reported by
checkpatch script.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 include/linux/pse-pd/pse.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index 6d07c95dabb9..6eec24ffa866 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -167,14 +167,14 @@ static inline int pse_ethtool_get_status(struct pse_control *psec,
 					 struct netlink_ext_ack *extack,
 					 struct pse_control_status *status)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static inline int pse_ethtool_set_config(struct pse_control *psec,
 					 struct netlink_ext_ack *extack,
 					 const struct pse_control_config *config)
 {
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static inline bool pse_has_podl(struct pse_control *psec)

-- 
2.34.1


