Return-Path: <netdev+bounces-131293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D637198E090
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 18:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E97EDB2F034
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 16:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04C51D1F6F;
	Wed,  2 Oct 2024 16:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eeAH35qR"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E97C1D14E4;
	Wed,  2 Oct 2024 16:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885695; cv=none; b=HaI33inr7OiwOZGlfMN1GdgBhaMi6VqBmaUbaSGUyuLBIJsRWaviSNlTJFwoCs3rRRY/umPa63Od82g59mLhEFeT/nceFCYK51kr6vt81lK8J2rdZ58UVkn03uyVqX+pcG2xpl2DpFiZXUfAAorXih+ljVKOJIOl4etebLBeq1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885695; c=relaxed/simple;
	bh=6fP4GiSZHpLwe8j151kxCCfVBFZI6rH3qmFV0hsMm8M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KTFJxM5iR5qxGz7XOkFaFzNSqm7EwIeuqxamJ5HXg656xKB/QnybNrlMKXDPP5AluMrwNmpGimF+qxcWMSVwhw/nqG32rMbE1twTrdWaeoZljzmZybS4I3Lt/bZwQL1GKsy+83hUUtO5lpeV97U/i1rlctaoFb4IKe3gMFju9QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eeAH35qR; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 72803FF811;
	Wed,  2 Oct 2024 16:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727885690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ul5YyEM+HmobdSv66VP3I6i6ZUMsqXQf70IngMOL9vE=;
	b=eeAH35qR6wo0HlI/DnHR/+W7ZaBLCpS9kM1KlvBNpRA4uCZ1fEzlCvqGj9zF5JuLMIbU6D
	voUQdH2okeHTcXmQ5L77K0Np/6X2/Kfi8xqBYzK4cMehek8RRNvk1y1s9/QTztVVAEqqDH
	dmYk7cmuFtELQNthGalDtELz/htsr11H87xyaJtvlvsn699dlYyPccRkk5o0Okl0LMatvf
	9r9Nux6EslkB/It3Y3hIvEtfheRppvMZ8+CycV029lJulPS15dt6fN0qACf9yv3MNVm3k/
	9VH/eTZHubd8ZUHb5d+UO0ZNMkKBOIjziSYjscYUxIdvbdmiHDp962St9AeukQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 02 Oct 2024 18:14:21 +0200
Subject: [PATCH 10/12] net: pse-pd: Register regulator even for undescribed
 PSE PIs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-feature_poe_port_prio-v1-10-eb067b78d6cf@bootlin.com>
References: <20241002-feature_poe_port_prio-v1-0-eb067b78d6cf@bootlin.com>
In-Reply-To: <20241002-feature_poe_port_prio-v1-0-eb067b78d6cf@bootlin.com>
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


