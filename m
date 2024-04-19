Return-Path: <netdev+bounces-89614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0898AAE51
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 14:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDF12B21A40
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 12:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD7B85633;
	Fri, 19 Apr 2024 12:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szcWe7VO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938E683CD1
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 12:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713529074; cv=none; b=gN5ibW8lgP4xhMGiVzVJE3ShBZ04t4Tu5ONg9mUzc5d50NmvYjlTohv/3u3eW8OeHjVGlv7+jfDAT1aUGxtMMO1+BlMOn51E96/cm5t/cZ41TiKpGjVe+bjxRSsQiidjUKHGpHb091/Ga92qMTLNjvC6HuA7O+2cCpcDeOA4vD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713529074; c=relaxed/simple;
	bh=rP4E9wlAIMtsEvUFO1SYLHKQl2GUloFOgrHjdVFM2go=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LyiQYeZdMMeG1+1olV55UqU9GX7cIXoUjyp08/DKDMOEmnlQha+LLenGOAvmRNHm0Kn3f2Xuj4pVsv9aErbbGaTvhytPi05hrNu/+4Mhkj2EKGnMAJ6N4yQY6REPcvJ3IxoOd4PmFLd+MbG2qIbQZGE4FxPRyRLGeFnCFnWzEH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=szcWe7VO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43CDFC072AA;
	Fri, 19 Apr 2024 12:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713529074;
	bh=rP4E9wlAIMtsEvUFO1SYLHKQl2GUloFOgrHjdVFM2go=;
	h=From:Date:Subject:To:Cc:From;
	b=szcWe7VOI3VW1niZHxLJkbY1aaFyMYSPmewNtV9NPj93Pf95nnMwJrUDjgD87fi++
	 PUtgdkv4IuwFQyR8lmKfiiRTniyTVTMRJnVuZhnPXWX+NokwY5xqfPxXDGa3zeIwvZ
	 ENMew5zdUixRL079ETB2ft3fTeghrCEndqAB/gSodutLuqr4/az2kpaR46y5m7gDPt
	 CdskFs6ZPhOUqOIP9SnzHYhQfnL512iADCNtOUS8scZRqCTKN60R5AXYdfipPQzc28
	 jihSsxFKLWjnb/8UR6jXmHsXFBpPxIqXXM/5QvvF+xvhqWAdH4n8YQn/RzonhAAI3y
	 pjtsClL2kKGgA==
From: Simon Horman <horms@kernel.org>
Date: Fri, 19 Apr 2024 13:17:48 +0100
Subject: [PATCH net-next RFC] net: dsa: mv88e6xxx: Correct check for empty
 list
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-mv88e6xx-list_empty-v1-1-64fd6d1059a8@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOtgImYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDE0NL3dwyC4tUs4oK3ZzM4pL41NyCkkrdFHNjAxNjS6CaJGMloM6CotS
 0zAqwqdFKeaklunmpFSUKQW7OSrG1tQCVPoJLcwAAAA==
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
 netdev@vger.kernel.org
X-Mailer: b4 0.12.3

Since commit a3c53be55c95 ("net: dsa: mv88e6xxx: Support multiple MDIO
busses") mv88e6xxx_default_mdio_bus() has checked that the
return value of list_first_entry() is non-NULL. This appears to be
intended to guard against the list chip->mdios being empty.
However, it is not the correct check as the implementation of
list_first_entry is not designed to return NULL for empty lists.

Instead check directly if the list is empty.

Flagged by Smatch

Signed-off-by: Simon Horman <horms@kernel.org>
---
I'm unsure if this should be considered a fix: it's been around since
v4.11 and the patch is dated January 2017. Perhaps an empty list simply
cannot occur. If so, the function could be simplified by not checking
for an empty list. And, if mdio_bus->bus, then perhaps caller may be
simplified not to check for an error condition.

It is because I am unsure that I have marked this as an RFC.

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index e950a634a3c7..a236c9fe6a74 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -131,10 +131,11 @@ struct mii_bus *mv88e6xxx_default_mdio_bus(struct mv88e6xxx_chip *chip)
 {
 	struct mv88e6xxx_mdio_bus *mdio_bus;

+	if (list_empty(&chip->mdios))
+		return NULL;
+
 	mdio_bus = list_first_entry(&chip->mdios, struct mv88e6xxx_mdio_bus,
 				    list);
-	if (!mdio_bus)
-		return NULL;

 	return mdio_bus->bus;
 }
---
 drivers/net/dsa/mv88e6xxx/chip.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index e950a634a3c7..a236c9fe6a74 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -131,10 +131,11 @@ struct mii_bus *mv88e6xxx_default_mdio_bus(struct mv88e6xxx_chip *chip)
 {
 	struct mv88e6xxx_mdio_bus *mdio_bus;
 
+	if (list_empty(&chip->mdios))
+		return NULL;
+
 	mdio_bus = list_first_entry(&chip->mdios, struct mv88e6xxx_mdio_bus,
 				    list);
-	if (!mdio_bus)
-		return NULL;
 
 	return mdio_bus->bus;
 }


