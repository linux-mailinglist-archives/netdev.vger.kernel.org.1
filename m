Return-Path: <netdev+bounces-125796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CBC96EA15
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 08:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B5831F2539E
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 06:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2F213D52C;
	Fri,  6 Sep 2024 06:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="fhTw1Flc"
X-Original-To: netdev@vger.kernel.org
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB89713C670;
	Fri,  6 Sep 2024 06:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725603800; cv=none; b=lKceR/LIQ55GYyZAPnRmkRpJcXrMq2PrOUEf2FMYAz/LfGYOtKqusNTDJ9CTsyD55wR4wwQCH9OjG2BP4+KgcQT2guBz7ITp0iEWYgv5kcdmmI+Z5D6/GdcXsR2aD4HfYp6Rqz+uxRt6oL2sscFLHU5fXZbnXWTUjk9fqL635gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725603800; c=relaxed/simple;
	bh=IwHhGYro/NG5zjDL3YhlIP/QuC/BB2rQPzhEZoYPkhY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tzcKvPUFCQtt70dhATB4ckproc7WVc0WSKWU6GyEvdxCTcNeGFCWAWzCzB5KUfgC8z6wqRZVHo9nTZyOcEvOLwryKYYWkr4vrRQQNSguFiisNNgkf2ZL1EpKLvnTjrk+ElxU9sqA3P6AV+oBH4QOuQmO+BQrGLYnkxip9oFe3zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=fhTw1Flc; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E10A11484DF4;
	Fri,  6 Sep 2024 08:23:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1725603787; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=EK/+ujBEZrydgnPYvV96ZGFur97uw+tTKiJ/4qpTXHk=;
	b=fhTw1Flcu2sTyypyGUz9h5E8uzfeYi3kHuk8aF8nDTZirfeRiHwdPkLj+WXm+h/6EKPabX
	E/b8Uis58sKO/y5RTsaXd9sbaqeW7xD/o5l3ar3t4NMEgChXG2nACded9TNkYDZZhgoolU
	E5CXjdg/Cx9XBvc/IwmfRdcrD1twAwD4RPPPEUjAaPaghJ5CmY9377ibq6pJh0bO5/tC0+
	mw8FJ++662Ou+FqYLgkJgduahmKwk3zjx+Q4fJNLHbwz1fr4pjMamSsFpMDUxuON6cu8TX
	VFenst+WeMnBPNDN1rfhj/4WH+BBqekBugo3qZraZe2w/YtfMqIlG3znrAdUdg==
From: Alexander Dahl <ada@thorsis.com>
To: netdev@vger.kernel.org
Cc: Calvin Johnson <calvin.johnson@oss.nxp.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v2] net: mdiobus: Debug print fwnode handle instead of raw pointer
Date: Fri,  6 Sep 2024 08:22:56 +0200
Message-Id: <20240906062256.11289-1-ada@thorsis.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Was slightly misleading before, because printed is pointer to fwnode,
not to phy device, as placement in message suggested.  Include header
for dev_dbg() declaration while at it.

Output before:

    [  +0.001247] mdio_bus f802c000.ethernet-ffffffff: registered phy 2612f00a fwnode at address 3

Output after:

    [  +0.001229] mdio_bus f802c000.ethernet-ffffffff: registered phy fwnode /ahb/apb/ethernet@f802c000/ethernet-phy@3 at address 3

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Alexander Dahl <ada@thorsis.com>
---

Notes:
    v2:
    - rebased on net-next
    - collected Reviewed-by tags
    
    v1:
    - Link: https://lore.kernel.org/netdev/20240905143248.203153-1-ada@thorsis.com/T/#u

 drivers/net/mdio/fwnode_mdio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
index fd02f5cbc853..b156493d7084 100644
--- a/drivers/net/mdio/fwnode_mdio.c
+++ b/drivers/net/mdio/fwnode_mdio.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/dev_printk.h>
 #include <linux/fwnode_mdio.h>
 #include <linux/of.h>
 #include <linux/phy.h>
@@ -104,7 +105,7 @@ int fwnode_mdiobus_phy_device_register(struct mii_bus *mdio,
 		return rc;
 	}
 
-	dev_dbg(&mdio->dev, "registered phy %p fwnode at address %i\n",
+	dev_dbg(&mdio->dev, "registered phy fwnode %pfw at address %i\n",
 		child, addr);
 	return 0;
 }

base-commit: 76930d3d20d595ffffe516df1b3d6a70c4f33bd6
-- 
2.39.2


