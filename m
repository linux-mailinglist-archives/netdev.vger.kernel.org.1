Return-Path: <netdev+bounces-131304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3005898E0AA
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 18:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E750328218A
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 16:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4C21D12F0;
	Wed,  2 Oct 2024 16:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZbI5plEk"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3663B567D;
	Wed,  2 Oct 2024 16:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727886551; cv=none; b=im4ltXp8R7RlMi4YqNOxRoW8b4Nmm06fJZNeQ1wCPbeous2cnN9I4wVr53UaD5Sf+pWGo6T45BN6HXSLOz0RshOLzvlacxYW1kn6F6fwGf+NjmugNT8otRQpb6z+N8MdZRS2qbnOqaZu4GL7nNoIRF75gn34sMloBEzxLVs392U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727886551; c=relaxed/simple;
	bh=FdyIlP5QbAoJSErExFHqxvHzcDD2538/OXE26emypME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Udb8VoZyV3N/pNcVOr8FT1ov0Br/pHblUY+wKxwx9a7C3mT28QFuri5EWSF0KNsqpgMp4g5rjF4hnC6XvpKpLzKCwKYqgvUaXar9+dbLVlN0qlfgAJRsHNhHIgjsxG+vMxUj1620HfIQN4K6HIRTNa1+W7y19rKZ6a7O7xAxauM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZbI5plEk; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C167F1BF209;
	Wed,  2 Oct 2024 16:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727886547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ro47lYTPlToHjrMRk1db8NcTTZn4FWYXgojohtwvs0E=;
	b=ZbI5plEk+PFgezSJr60mckUjxT7KeGbgQcqG7OlR4FYkhAh8iaAuB3qMnbX1tsKQoB/5/v
	jESKCdgmLeukCiUkkw6X6/dBs37V1U0LS10XKvfoablOT5zqTqjcNRYeKc/KGWpEt5AjQF
	fietJNA2SdFnX0SqeiWLqKg+bx2djpDqIrRSdsZOJdpXNfmB7En+xlg0rFFjbbC3uXt0VI
	sQbFiKhCd8ckdvX9PuClaUSSezkHy2r+2mXE65GbDJw+PViSoPnq9fQSayeQDLUWJQyD7U
	XQoZpZDqDVwLjVqs9ncCI+cNbX96Ui2gVoQlxNyNWDECltbY3cW0WVY6jlMasQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 02 Oct 2024 18:27:58 +0200
Subject: [PATCH net-next 02/12] net: pse-pd: tps23881: Correct boolean
 evaluation for bitmask checks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-feature_poe_port_prio-v1-2-787054f74ed5@bootlin.com>
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

Update misleading boolean evaluation when checking bitmask values.
The existing code directly assigned the result of bitwise operations
to a boolean variable, which is not consistent with later assignments.
This has been corrected by explicitly converting the bitmask results
to boolean using the !! operator, ensuring proper code consistency

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/tps23881.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
index 5c4e88be46ee..1a57c55f8577 100644
--- a/drivers/net/pse-pd/tps23881.c
+++ b/drivers/net/pse-pd/tps23881.c
@@ -139,9 +139,9 @@ static int tps23881_pi_is_enabled(struct pse_controller_dev *pcdev, int id)
 
 	chan = priv->port[id].chan[0];
 	if (chan < 4)
-		enabled = ret & BIT(chan);
+		enabled = !!(ret & BIT(chan));
 	else
-		enabled = ret & BIT(chan + 4);
+		enabled = !!(ret & BIT(chan + 4));
 
 	if (priv->port[id].is_4p) {
 		chan = priv->port[id].chan[1];
@@ -172,11 +172,11 @@ static int tps23881_ethtool_get_status(struct pse_controller_dev *pcdev,
 
 	chan = priv->port[id].chan[0];
 	if (chan < 4) {
-		enabled = ret & BIT(chan);
-		delivering = ret & BIT(chan + 4);
+		enabled = !!(ret & BIT(chan));
+		delivering = !!(ret & BIT(chan + 4));
 	} else {
-		enabled = ret & BIT(chan + 4);
-		delivering = ret & BIT(chan + 8);
+		enabled = !!(ret & BIT(chan + 4));
+		delivering = !!(ret & BIT(chan + 8));
 	}
 
 	if (priv->port[id].is_4p) {

-- 
2.34.1


