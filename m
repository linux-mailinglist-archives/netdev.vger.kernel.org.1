Return-Path: <netdev+bounces-39257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F1C7BE825
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 19:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7D2D1C20C39
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A799138DC4;
	Mon,  9 Oct 2023 17:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3YVZv7j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8871038BDF
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 17:32:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E9BC433C8;
	Mon,  9 Oct 2023 17:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696872723;
	bh=T1jhTGzyYiwSzxgr8JeryuYGdjLqXTksM+snM+6dzJw=;
	h=From:To:Cc:Subject:Date:From;
	b=s3YVZv7joyPmPZ2paRgsJlDBPIrwjvuZsq3arKOYkyD3wR1wzc4Nmi4e49BfTqNrC
	 ZGGVMPStAoXBpTKNlQfeEhVyNgJS6y7ZrwGHoL8OTLgm+FAwdahBW+u4758Y3bYZ6E
	 ReB4ugUJbK366baXRNxYMqb/KnhNE9MYh7Z91Ph8SWyAN+PU5sxNlBfJg9QjUzuwOj
	 qEA9sfg+EeOQOqT3KMpKX450lw4/DHNLAdSsaem+KGJ6eY6JO9kerrRtggQLAhQATG
	 S+krstYiW7ai/lPMDCDDnvXfFw9DwAnkiAwo2SQN4Ljee5Z0WWLQOSCebXgGyt49pN
	 qNe62AaidJiYw==
Received: (nullmailer pid 2517576 invoked by uid 1000);
	Mon, 09 Oct 2023 17:32:00 -0000
From: Rob Herring <robh@kernel.org>
To: Iyappan Subramanian <iyappan@os.amperecomputing.com>, Keyur Chudgar <keyur@os.amperecomputing.com>, Quan Nguyen <quan@os.amperecomputing.com>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: mdio: xgene: Use device_get_match_data()
Date: Mon,  9 Oct 2023 12:29:04 -0500
Message-ID: <20231009172923.2457844-9-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use preferred device_get_match_data() instead of of_match_device() and
acpi_match_device() to get the driver match data. With this, adjust the
includes to explicitly include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/net/mdio/mdio-xgene.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/net/mdio/mdio-xgene.c b/drivers/net/mdio/mdio-xgene.c
index 7909d7caf45c..495fbe35b6ce 100644
--- a/drivers/net/mdio/mdio-xgene.c
+++ b/drivers/net/mdio/mdio-xgene.c
@@ -13,11 +13,13 @@
 #include <linux/io.h>
 #include <linux/mdio/mdio-xgene.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_mdio.h>
 #include <linux/of_net.h>
-#include <linux/of_platform.h>
 #include <linux/phy.h>
+#include <linux/platform_device.h>
 #include <linux/prefetch.h>
+#include <linux/property.h>
 #include <net/ip.h>
 
 u32 xgene_mdio_rd_mac(struct xgene_mdio_pdata *pdata, u32 rd_addr)
@@ -326,24 +328,11 @@ static int xgene_mdio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct mii_bus *mdio_bus;
-	const struct of_device_id *of_id;
 	struct xgene_mdio_pdata *pdata;
 	void __iomem *csr_base;
 	int mdio_id = 0, ret = 0;
 
-	of_id = of_match_device(xgene_mdio_of_match, &pdev->dev);
-	if (of_id) {
-		mdio_id = (uintptr_t)of_id->data;
-	} else {
-#ifdef CONFIG_ACPI
-		const struct acpi_device_id *acpi_id;
-
-		acpi_id = acpi_match_device(xgene_mdio_acpi_match, &pdev->dev);
-		if (acpi_id)
-			mdio_id = (enum xgene_mdio_id)acpi_id->driver_data;
-#endif
-	}
-
+	mdio_id = (uintptr_t)device_get_match_data(&pdev->dev);
 	if (!mdio_id)
 		return -ENODEV;
 
-- 
2.42.0


