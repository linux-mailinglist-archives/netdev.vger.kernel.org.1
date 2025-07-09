Return-Path: <netdev+bounces-205426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C18AFEA47
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 15:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D707167C7B
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 13:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9593B2DAFB4;
	Wed,  9 Jul 2025 13:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="a98vhtDz"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEF0944F;
	Wed,  9 Jul 2025 13:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752067953; cv=none; b=airE58cSZEXBDsrZw0LbaIF5eeG75O4NSfxmBGm0OTnhcdX78kQ/1NpvO0ocIVatXKuNKQhLYnMVNcDUMpE1XoT660qQyXTALdXYeqTzuIeYvwY9IHsP9AeBUWdU/JBCBR3T9RNWz9lVh5ZDhLhxDk+FBG9VeVWuc9FH7WKJ6AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752067953; c=relaxed/simple;
	bh=DHsl9XbQ4MD2lSV8MMBKbjFsiRTHhKtR409Ow1J8JJk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gIwK8f5TaXsC4LsMRYTEczG6vXlKQZGeCnZVrSSoRbHLxatPiA+NPhdazeNimva+S2yqWdnMRf9nqu6Y9KPzOKpix1GxDjY0T/XjuyUAu6dmuCCM+kv3o1L7w7T22Su+VhxypX+ibgquTPdkAC9fgvxsKtF3C1caDKi4rxHVulE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=a98vhtDz; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 86AFEA0AE6;
	Wed,  9 Jul 2025 15:32:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=NT3P40p3LmW0XVCtkAIi
	KJmhvjSKuJlnXj962iHn/x4=; b=a98vhtDzgdADP9RdAZsUCaRQOjPeHlRDZqcs
	fhGPuaZcFHHKnOuI589SBAjsEyP5rhV2me7Yncl8vUTsVPjgPLeod5YhDVPoMZl7
	z7WWy676ejNKe+Nv1P7hACTPCNyRMuEbNhYFYy52ybxGx4jYwU2OuF1OJ1ryGDIJ
	EemVnDAwWLsD/S/YrkCkK1S2X46TrQj02l+fPs60+yaIP28Ng0PeDXp87ebU2zLE
	ApDMuplz3YlyMzwo9H7/uZz8JIIsLnZJTnd11uUiFyOhxwzNk49Dm+FwOIVSDaHy
	psfgxJ71bLEWHqDCK5gqCfuHInfVNwDFrAwnaCggtomQhLWXYNcElBxCjxWfLaIx
	hGZta9It12RJnDJCar9klY5pwFOKXuJfePTFABfKNQsKI/V29qAf5IqRfpHEky5R
	Qe2bJMGChrHUtk+hznRvNK1vCFA5XyvONJUw2bwSCdY0ZWueaTqLGOnRXyc7MAtt
	AX+/rPI1G0KrRT/tU9B6OoAvbh/hoo6r4GZT7+6ydjt0aa1A1rm0WBMvQVMp2MS0
	28qoK1HRrTX0z2gs/NAQLGx8Wc8wUq0jzyD5p73clP9DzQ332Sz/R0PzpZhBNQSy
	vIHohKC3B2gDGB+6HO/MuxyNlQvDi4Rc9AFDRvm0BJWQtR0e7yPQ7Ffi0vE6Rl67
	30cQV4o=
From: Buday Csaba <buday.csaba@prolan.hu>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>, =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?=
	<csokas.bence@prolan.hu>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
	<hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 2/3] net: mdiobus: release reset_gpio in mdiobus_unregister_device()
Date: Wed, 9 Jul 2025 15:32:21 +0200
Message-ID: <20250709133222.48802-3-buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250709133222.48802-1-buday.csaba@prolan.hu>
References: <20250709133222.48802-1-buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1752067948;VERSION=7994;MC=2713203278;ID=104608;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2998FD515E657164

reset_gpio is claimed in mdiobus_register_device(), but it is not
released in mdiobus_unregister_device().
When a device uses the reset_gpio property, it becomes impossible
to unregister it and register it again, because the GPIO remains
claimed.
This patch resolves that issue.

Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
Cc: Csókás Bence <csokas.bence@prolan.hu>
---
 drivers/net/phy/mdio_bus.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 591e8fd33d8ea..a508cd81cd4ed 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -97,6 +97,7 @@ int mdiobus_unregister_device(struct mdio_device *mdiodev)
 	if (mdiodev->bus->mdio_map[mdiodev->addr] != mdiodev)
 		return -EINVAL;
 
+	gpiod_put(mdiodev->reset_gpio);
 	reset_control_put(mdiodev->reset_ctrl);
 
 	mdiodev->bus->mdio_map[mdiodev->addr] = NULL;
@@ -814,9 +815,6 @@ void mdiobus_unregister(struct mii_bus *bus)
 		if (!mdiodev)
 			continue;
 
-		if (mdiodev->reset_gpio)
-			gpiod_put(mdiodev->reset_gpio);
-
 		mdiodev->device_remove(mdiodev);
 		mdiodev->device_free(mdiodev);
 	}
-- 
2.39.5



