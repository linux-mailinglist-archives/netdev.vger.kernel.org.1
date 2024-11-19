Return-Path: <netdev+bounces-146170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AB79D22C8
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 10:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30F5AB232CC
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 09:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5654B1A00EE;
	Tue, 19 Nov 2024 09:51:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0424C14AD24;
	Tue, 19 Nov 2024 09:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732009915; cv=none; b=tHvMfhKNBmIuWuaCPXo8K+NOyGq288qiIghaYZBDORsDwLg1jW83me3E4n1EezI2/GmOBjbYIt5TCDrYDJn/lodX3BX1KGwJ0EYtQWL6m9OWaM6QS2ERF5u7el+hEEu5UM4CIC3IcLWYoRv70bLOBKHVE/3K8QeRo8bIFrpCZD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732009915; c=relaxed/simple;
	bh=NEOEA02DqsWW3lYC4YWQs/ZZbW9XL0vo3dmHU46UoDs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a/VDDj567pOs5NrwsO2N6MeaR0nIsP78mpXcuT2WtihF0YjFVkHj1fmjVMneGJAfSc/fLhpOSqV/8//Yhia9SmB8Fyu9mjdURtYTh0YQBfBP41Yn1pYZd8t2TeSV/4t8DlFqY0G/2WiSTnTdy7uJjxEMQ04ceuZmOB70pj6kxiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 19 Nov
 2024 17:51:42 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 19 Nov 2024 17:51:42 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<f.fainelli@gmail.com>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
CC: <jacky_chou@aspeedtech.com>
Subject: [PATCH net v2] net: mdio: aspeed: Add dummy read for fire control
Date: Tue, 19 Nov 2024 17:51:41 +0800
Message-ID: <20241119095141.1236414-1-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

When the command bus is sometimes busy, it may cause the command is not
arrived to MDIO controller immediately. On software, the driver issues a
write command to the command bus does not wait for command complete and
it returned back to code immediately. But a read command will wait for
the data back, once a read command was back indicates the previous write
command had arrived to controller.
Add a dummy read to ensure triggering mdio controller before starting
polling the status of mdio controller to avoid polling unexpected timeout.

Fixes: a9770eac511a ("net: mdio: Move MDIO drivers into a new subdirectory")
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/mdio/mdio-aspeed.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/mdio/mdio-aspeed.c b/drivers/net/mdio/mdio-aspeed.c
index c2170650415c..373902d33b96 100644
--- a/drivers/net/mdio/mdio-aspeed.c
+++ b/drivers/net/mdio/mdio-aspeed.c
@@ -62,6 +62,8 @@ static int aspeed_mdio_op(struct mii_bus *bus, u8 st, u8 op, u8 phyad, u8 regad,
 		| FIELD_PREP(ASPEED_MDIO_DATA_MIIRDATA, data);
 
 	iowrite32(ctrl, ctx->base + ASPEED_MDIO_CTRL);
+	/* Add dummy read to ensure triggering mdio controller */
+	(void)ioread32(ctx->base + ASPEED_MDIO_CTRL);
 
 	return readl_poll_timeout(ctx->base + ASPEED_MDIO_CTRL, ctrl,
 				!(ctrl & ASPEED_MDIO_CTRL_FIRE),
-- 
2.25.1


