Return-Path: <netdev+bounces-131290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7018D98E068
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 18:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98B02B2CC74
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 16:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809E31D1507;
	Wed,  2 Oct 2024 16:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="b1ZgqD1b"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539701D0E0D;
	Wed,  2 Oct 2024 16:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885693; cv=none; b=Bs/JLS2R9ENfhNseU3Y+bhN1+9ZYXxNvnIlWPZAS5B2oVGVy9PJZZ3sNZK5P/eXQ/84DU42w4LGXEDr+1Ps16e4tuvTrQ/kZySWB105c8d2MG1OwyOTz52H6gt1yImyclpMmxjVtfTGxRer6X0HNizr2OoTH+nj6sY0pAZ3n8Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885693; c=relaxed/simple;
	bh=FdyIlP5QbAoJSErExFHqxvHzcDD2538/OXE26emypME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qJmCprp5Rx5PNrHNy+yc9B8MI9jXObJdWJC/fhZXP+MZ1C2yhQUZ7PODuNszQtU6BRgDCAZi9iwkl/F6LkPqNNAZnrgzG+yMZN+5Nm7oTQqRIU7kjL7Z/0NpyYpIDEmHEBpLV3UZJeckkR5nBTDNK5zNcn2uVQptaXkXdsD++fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=b1ZgqD1b; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E28F7FF809;
	Wed,  2 Oct 2024 16:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727885683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ro47lYTPlToHjrMRk1db8NcTTZn4FWYXgojohtwvs0E=;
	b=b1ZgqD1bU7HymIOpRB1dPPuSfhqk8FMH9T8uAui0s12CZaVmLezgnRfREFAEnMUfytVc5Q
	C427PJw/AJHqweGjuib9IBap5fcj8yo2rAF3u3yvGYnGru5PomwcmiZfrFadWVYK9lW1Mb
	BzVtXV7VeY/iOp0JfJyWXqq3isYTv3U/Ikiw7/bUe9OogTchJaBKmRinmf5K71JRu8ERGC
	WokKtlqqgYEBwKmp6ikysvu2UABln9NYbQKAfjvkS9MJJWFV+ANvYo0+s1Ox3Z9kmPU0Px
	5cFkW4ldUWNW0AVym5v/TGt64Qk7OZd26ZmFrYEG/tEtoP8mSw10bYf5AzTHVQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 02 Oct 2024 18:14:13 +0200
Subject: [PATCH 02/12] net: pse-pd: tps23881: Correct boolean evaluation
 for bitmask checks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-feature_poe_port_prio-v1-2-eb067b78d6cf@bootlin.com>
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


