Return-Path: <netdev+bounces-131312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F1598E0C2
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 18:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09CC31F243A9
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 16:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05FD1D271D;
	Wed,  2 Oct 2024 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jDuvl+Tg"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D282E1D1F4E;
	Wed,  2 Oct 2024 16:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727886556; cv=none; b=jKWc2l0OIdjPJVKWQC0ZfJpUM0YZRonw8aFaZFeecMTg89P30bBU2juThF/269dLfaBQnF6Q79q1vzgY/RQOgtE7I+grbitC3qewelCBk+h+vzVmcQ+k+lcVS3vTLMlZHCVMWEGwrgDB1wBMHTFQ9nqqaXERGuAHCsASZofwEBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727886556; c=relaxed/simple;
	bh=6fP4GiSZHpLwe8j151kxCCfVBFZI6rH3qmFV0hsMm8M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EjUg/ZA7l/EGgQnhRMnHuxn8sQeF9CxcmeBDxAyV9R/T6N1nz2T+59mlZuB9aLwxIIr0mF93OObRq2XlCadbbg0SvFAA4FT5sRRL9uO0pPOECQ+GiyjO4vXB26w4mwfc08M4nt74di1bW0wJ2rcqEPyEhPGRl/WU8NHPJUAgtJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jDuvl+Tg; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 938731BF20C;
	Wed,  2 Oct 2024 16:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727886553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ul5YyEM+HmobdSv66VP3I6i6ZUMsqXQf70IngMOL9vE=;
	b=jDuvl+TgD4NNN8Wms5GG43DxZEZ1S1qt9tcuUY8CJFH4uXutsNZ+je2UY0eubxoK3fMSQ/
	YOWwFfOtTwckdneVJoCpQQaUH4kR+EjKpy/rIYV95lVCPgcHC8q3F0vYCJ6LH6hAZxWJHG
	Nn9sjuOzydXe/5Wb6N+xwe9nsrs/mTFR8VWNSjbTZWmlPUmlrEpTz2u3WdvjmhTGWJjbau
	RAKpk+r9pBrC4PykvFxQ8BAXogVyydtLxA8o6uCs5VzrRlUBZLQpWxadHsuEffocR/ffd9
	IpTfhcUfu7jDl7A6UYNpTZsX0XyPACLbvorZfS2JRzo1/geHdZIrNSIrWx0C4w==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 02 Oct 2024 18:28:06 +0200
Subject: [PATCH net-next 10/12] net: pse-pd: Register regulator even for
 undescribed PSE PIs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-feature_poe_port_prio-v1-10-787054f74ed5@bootlin.com>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
In-Reply-To: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Ensure that regulators are registered for all PSE PIs, even those not
explicitly described in the device tree. This change lays the
groundwork for future support of regulator notifiers. Maintaining
consistent ordering between the PSE PIs regulator table and the
regulator notifier table will prevent added complexity in future
implementations.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/pse_core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 6b3893a3381c..d365fb7c8a98 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -463,10 +463,6 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
 	for (i = 0; i < pcdev->nr_lines; i++) {
 		char *reg_name;
 
-		/* Do not register regulator for PIs not described */
-		if (!pcdev->no_of_pse_pi && !pcdev->pi[i].np)
-			continue;
-
 		reg_name = devm_kzalloc(pcdev->dev, reg_name_len, GFP_KERNEL);
 		if (!reg_name)
 			return -ENOMEM;

-- 
2.34.1


