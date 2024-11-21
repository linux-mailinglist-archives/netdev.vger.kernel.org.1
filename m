Return-Path: <netdev+bounces-146656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F869D4EDC
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 15:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 904091F21E1F
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 14:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDDD1DDC38;
	Thu, 21 Nov 2024 14:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Hn2mOj1w"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD241D95B3;
	Thu, 21 Nov 2024 14:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200224; cv=none; b=reGhiQnSXGgXKDXkzeK5+VmfnRRMbFUzQbdnZmiemeiweZrKHmMCk+/W329FnuMS68cZ0qscH+h1mky2MGuGRJOhGe8ns879ayytL8JaU6+k1y8PIgHYs9lre+qNSNKo3q3VihBsQRFudfijkhpU/AD1lkvkBslGKpbWW+SV724=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200224; c=relaxed/simple;
	bh=DC/9YkU2BchaabD5ycgLbSoIt4/zucrbbySyiKTAodw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GJWMDY79jjXbe53bQau3QgY2MytMDkx/+ZRROryvLjzYKho2s9xPPICZs1j/Op9sMYwxuQxnCg/HzCJxSbN5xnJZzAqASaf+848lmplnEcO8RDhKhJ2n6WcdlkQfTm83p73H2/Hpbik4msVKwhw8Ee+WvnLFQZ4VeKwa7xWQemw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Hn2mOj1w; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B4D774000B;
	Thu, 21 Nov 2024 14:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732200215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PB4N4irPSyn5rR+E/NNWqmUZSG81ZYdtH5kOGb0VcXk=;
	b=Hn2mOj1wPiMHfblYXynxvv9q601z9o/gA4WJNSOy3/TJLNPerLtchzzAx7IBpYdTINhWwc
	SGJCzhjPy3fNZ/J8NE5Qwo3JfaqmotoZpcwZOt/VDG0I4spU13YLwsGwFvTDDbp6AU6m1c
	OtTTZKQ8flYbHNQ+yeLFDMsij5KljziJL5NB8o3ucUfIAVGb/xc5t3MeClrLuo1yQK35ev
	o9yhM0jvMj+L1NRE6WUJkQ4kvVMa5z8OWd8EQD5qnZoYJanQtlzUKZdWlgTG3fM2xQDDiU
	wh1eHuEyPT5gCxb3Mq+Bz7aqZKTfL9TZb5b0hccvr+ILOGFxi8rGhV2i1+Tt+Q==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 21 Nov 2024 15:42:28 +0100
Subject: [PATCH RFC net-next v3 02/27] regulator: core: Ignore unset max_uA
 constraints in current limit check
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-feature_poe_port_prio-v3-2-83299fa6967c@bootlin.com>
References: <20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com>
In-Reply-To: <20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
 Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

We should only consider max_uA constraints if they are explicitly defined.
In cases where it is not set, we should assume the regulator has no current
limit.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v3:
- New patch
---
 drivers/regulator/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 1179766811f5..2948a7eca734 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -497,7 +497,8 @@ static int regulator_check_current_limit(struct regulator_dev *rdev,
 		return -EPERM;
 	}
 
-	if (*max_uA > rdev->constraints->max_uA)
+	if (*max_uA > rdev->constraints->max_uA &&
+	    rdev->constraints->max_uA)
 		*max_uA = rdev->constraints->max_uA;
 	if (*min_uA < rdev->constraints->min_uA)
 		*min_uA = rdev->constraints->min_uA;

-- 
2.34.1


