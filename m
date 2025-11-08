Return-Path: <netdev+bounces-236968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBB9C4289E
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 07:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05029188E9EA
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 06:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC9A253B58;
	Sat,  8 Nov 2025 06:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Db0gfLFq"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B37B1E0DD9;
	Sat,  8 Nov 2025 06:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762584577; cv=none; b=St2G4rykDsZg3Is0he5yTgNcLdSR7kNqnNcVZSADQ3b+VefR23Yr+61kYCXPGiKTNn5IJ77g/+GVukDnIJsWpTmGwcpaTxIB29PJ8FFTIk/5e1Nr5F/FW72f6RmBYloFMYg0RYbX+PPh73dkZkROavuRPwOHCPzHn+68WYrVFPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762584577; c=relaxed/simple;
	bh=jz8ukvvRAvzQRhhP+ZXJiypbNhd/W6QF6sgHCvmDJDM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cvOvrnnfLdaAcO1/BwK7u3CaPOzL3gzG3igrIqPpb4ViqNi5RW/WfAwjuED0cB3V5TqanvQsUpBPlm4dTMR4p4aD3Rmp7lTM2suSK4mlXIIw9uhn1uuTqoDWYcs9AJSCLc2c/sACRUFi07pNXBzllxc2ZQeo0yo/TjqfwW3bSxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Db0gfLFq; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id DB71BA0BB0;
	Sat,  8 Nov 2025 07:49:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=VkwoXrZtvkP6dlh6Xfbrq9DIW4exw4OKLGybIVjF7UQ=; b=
	Db0gfLFqzvN9qyPD+2gFYU9vS92WCJxyT9EZ1TUDquDzLCeP716eRrdesv+18WBk
	HCx/jtGilndH6ap3ujHw59EAcW63Fss+S44F7tgJeuoA+YAdcQNcEFU8KMVAO6RB
	y+uh+u5zHxpYLHUMqDXRLp5pWJayjSNzqcR6xeJ2xz5KPtkge1kn3x3/AJ9Q171j
	vGJUfSScnSoTROygbBiSC2kZh45rOFJwfhxeE4aiGFsmXxgRr1S129xtxzZ/69M0
	Zeg+dpvKYEbBd2f7imZyvD5ZO1coOHAUV6vLQbYc2LDtXgzose6Rf83tQXe3bJE3
	WCnMW1cEWIY7bgm9NUvmBDTbGE5GAX5fQsHmYlIopixs5DXXXUmDkH9C90NaSlKp
	BidDtLUuGQrS8LyfRmxfNvkwlisfumhnOZES9DBiYxTgcxh/YfWYAp1S7wQot5vo
	W3EleRBSMAK/KLCKhW42HMdJCfRex1YzP5wYLx5inqR0KdjU8ZBWYq7wUoVppOg1
	KoJIzX5YTO5+wKz3AK5HIZFcF9iigF4tnllpC4NEhTWZWwsjgyn6sediTzyA43nb
	v/FoeR2CPsyIngom9+JK6dU+XYENwxscuQhbHCIaqvFVj/XjqK5+Oqb4lY3O0i2e
	uPlHhjGzSTQHTOTKkK2roiWiAtSxahmdeY7Qzdf/+t8=
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Bauer
	<mail@david-bauer.net>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>
Subject: [PATCH net] net: mdio: fix resource leak in mdiobus_register_device()
Date: Sat, 8 Nov 2025 07:49:22 +0100
Message-ID: <4b419377f8dd7d2f63f919d0f74a336c734f8fff.1762584481.git.buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1762584564;VERSION=8002;MC=2900412154;ID=182673;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2998FD515F667364

Fix a possible leak in mdiobus_register_device() when both a
reset-gpio and a reset-controller are present.
Clean up the already claimed reset-gpio, when the registration of
the reset-controller fails, so when an error code is returned, the
device retains its state before the registration attempt.

Link: https://lore.kernel.org/all/20251106144603.39053c81@kernel.org/
Fixes: 71dd6c0dff51 ("net: phy: add support for reset-controller")
Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
---
 drivers/net/phy/mdio_bus.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index cad6ed3aa10b..4354241137d5 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -73,8 +73,11 @@ int mdiobus_register_device(struct mdio_device *mdiodev)
 			return err;
 
 		err = mdiobus_register_reset(mdiodev);
-		if (err)
+		if (err) {
+			gpiod_put(mdiodev->reset_gpio);
+			mdiodev->reset_gpio = NULL;
 			return err;
+		}
 
 		/* Assert the reset signal */
 		mdio_device_reset(mdiodev, 1);

base-commit: 96a9178a29a6b84bb632ebeb4e84cf61191c73d5
-- 
2.39.5



