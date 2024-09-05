Return-Path: <netdev+bounces-125568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8376E96DBE3
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 16:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE54AB26F07
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 14:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A4417BA5;
	Thu,  5 Sep 2024 14:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="PbBXYSwU"
X-Original-To: netdev@vger.kernel.org
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7806DDF59;
	Thu,  5 Sep 2024 14:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725546783; cv=none; b=HH9FncR0mErrUairAFeC9SiLlWXF0aU0DTUTDqaNOFuGHE4es5JN5q7fWzF3e6zFXJuWH4AOvoRskpeQU9Pdm3UTXqxwVRzhGcqVEuTOSZLDNzo1sRRix4Ena5ZognaIa+9xZXB1EUuGHgu8P8KffNEdWfdkNE1k8YL8KwCrl6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725546783; c=relaxed/simple;
	bh=8k2tjLOucmlfkLINnLYVJ1Qqpatm+DYm269vwL1aKZk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RQyhNdodD7npGrspdUbvWrnYliq9URqpMeNuruE6HSuACX6yZZt7/h7+vQLAWvTcJkAU68Qj5ocEXz7Sl8VHOOpg03KkMqFe64WsFSIhTeiaYS31nwfu7rmtY394fn7U+L025Slpv7Z3Rix/3xe4euXJFbkGCtH9nGZcS7ILrfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=PbBXYSwU; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B12711485482;
	Thu,  5 Sep 2024 16:32:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1725546777; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=jQ5BTKSH11AkcnH09P1IugQWexJUyWmtNnz5aJsjaCI=;
	b=PbBXYSwU9oZuGh3qpEER1dm4dPvitbTljU4UFpBEvg9xmDO5oo9CC+48VkkDePkjnIhTvG
	d+gD1JjVslLOHqMgrUBQ7gLVkP9gvx24J15Sp+d6haeu+Z7l7fsvy2KLCdF27NrT7ye6Ef
	NT+P3RDS5nVLace2WztDjnuMcIrJjfWHE934YaGIqvHhKigh/dJ5RiRp5ij6ecDLnuCUMz
	d+xJFNmbJk1eGUk8udemW92Y5u7Qxtqp7AeQ7Q9ksKfMnbrXp1iDlO0t9EfA5Ot9Qps6M7
	q4RrqrHIDqKaMJjf1yr/8+9D8r+BG+jms2f0wyHzyVHaPyohMw8UunxfCBSQjQ==
From: Alexander Dahl <ada@thorsis.com>
To: netdev@vger.kernel.org
Cc: Calvin Johnson <calvin.johnson@oss.nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: mdiobus: Debug print fwnode handle instead of raw pointer
Date: Thu,  5 Sep 2024 16:32:47 +0200
Message-Id: <20240905143248.203153-1-ada@thorsis.com>
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

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
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

base-commit: 8e69c96df771ab469cec278edb47009351de4da6
-- 
2.39.2


