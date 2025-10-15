Return-Path: <netdev+bounces-229598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1790EBDED0E
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 15:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B28C482B82
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 13:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B766E24395C;
	Wed, 15 Oct 2025 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="bMXkxc0S"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6889E215191;
	Wed, 15 Oct 2025 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760535913; cv=none; b=WUVnock4Q0cBc0ak+eDY4ns78ztIesLTYCNJi9mVT6y4emHTJw1LSOuQCURf0TUyLcLySVO1Lf442gFh9aH+tDYz1sIAYjKsSicprCol4cxRBo7G1xrRNIZDsNOArbBLqfUo0z7Hq+i5S5bRyrNrUCoXMrA76gwZxyU9pP6fZ94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760535913; c=relaxed/simple;
	bh=27I5DMxpjkGpB/w9GoY+dNTqNSixi5eurRh/WxMQ+As=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PcPGy2Wq3d/s3wQ4LGC2fuYmU1JWtEp54zKtM9H6MOF+F+8ke0TzOq67cEswQofHieF6pO/cp0kLEdKjf6z/Zq45ALr9tlRaynUSpr0vPvtkKi/pTYib1C3k4xnzZLRyYbZzivd5o7uyEFkpoaUvcVWqrsQ0RUxqfxtupniLgRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=bMXkxc0S; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id F34C3A0120;
	Wed, 15 Oct 2025 15:45:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=KZywRmBuNGgBPtRDJIi8
	j/ytF4KZ877fe6F+bgM2yqU=; b=bMXkxc0Sm3QbeSQWSIW8hUmgEgD4hWPMr2wM
	WBgXNjpEwc6L5BdOmwy1NU3ZqYSuYFVgKDv3EP3WKdiopkLIrAMoP7gtYOX/TCpb
	3xfqfY8HuI+AfLwFAfUKaJ2YqyC0vI//UcecfRwJ1A9Hd4J2Ze3wUKZ0xKyqkSgT
	z+F8J1zzYYpevvIHV7fd4CZxg2wTzvAIjESNZKtwYaDX3Z6taqYi0G6EuZbS9v5v
	oPPeP7Uw+PxgA7ZDNIBP04HeYFUj2NbTfJ3UuuDuWuIaOwFdOQHOWFec1G+618jj
	oMkiQm1PUGuiqjSEu5lt+S1Y+NkiKyFfHRaY5rpsDOw0yCze+4CZoZIuMW3EtDyC
	toKu7Mf7qmDOXcfnW/CXG92SQ0FXfTCZWd7gm98NQSP/gwMK1S4DzPNKH2RNUP/6
	DMtvHfZsyJlnqQKxdx92AUJpSn5lb6q+BYe+z34Q0Lajdlp/Up1vC62v71BkFz3S
	PQ/rTEaky80qfyZkY02vN6xgxpBJm+hpEhZxE/DIRY6WiIRkyF3ohzj11JzOIWo6
	oHZ6lqhkOpEvkqnb25tfx7Bq2Fytd/YusWVzqLJdihjSowUGssi33ANlRoUCggsr
	3f1L21yk5tdxUxwgNISJS8MGsTatRfxYwePbpWPgJ61WoZc8tq6Vy0MgUDDaFVyk
	rZVL2qI=
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>
Subject: [PATCH v2 2/4] net: mdio: change property read from fwnode_property_read_u32() to device_property_read_u32()
Date: Wed, 15 Oct 2025 15:45:01 +0200
Message-ID: <20251015134503.107925-2-buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251015134503.107925-1-buday.csaba@prolan.hu>
References: <20251015134503.107925-1-buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1760535906;VERSION=8000;MC=2840115749;ID=558033;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155F64756A

Changed fwnode_property_read_u32() in mdio_device_register_reset()
to device_property_read_u32(), which is more appropriate here.

Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
---
 drivers/net/phy/mdio_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device.c
index eb8237095..d812ae2a0 100644
--- a/drivers/net/phy/mdio_device.c
+++ b/drivers/net/phy/mdio_device.c
@@ -84,9 +84,9 @@ int mdio_device_register_reset(struct mdio_device *mdiodev)
 	struct reset_control *reset;
 
 	/* Read optional firmware properties */
-	fwnode_property_read_u32(dev_fwnode(&mdiodev->dev), "reset-assert-us",
+	device_property_read_u32(&mdiodev->dev, "reset-assert-us",
 				 &mdiodev->reset_assert_delay);
-	fwnode_property_read_u32(dev_fwnode(&mdiodev->dev), "reset-deassert-us",
+	device_property_read_u32(&mdiodev->dev, "reset-deassert-us",
 				 &mdiodev->reset_deassert_delay);
 
 	/* reset-gpio, bring up deasserted */
-- 
2.39.5



