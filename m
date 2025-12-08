Return-Path: <netdev+bounces-243976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67349CAC37F
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 07:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4022A300CD45
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 06:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88F232A3CF;
	Mon,  8 Dec 2025 06:50:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C65A329E6E;
	Mon,  8 Dec 2025 06:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765176619; cv=none; b=AHMrd0sCKMqAp+k0/1RvaX+lYwPZH0mSHC5UwQG6OJYiTbPoaRiPfDj3BWHxbmJXI3FNyr1CzPwHuVP5lnWfSQ8ZQCBm2YuzkKVfh2yS+rw1iU6rkAYtClcAxch8fi2zvndJxPxYxTFufw4zsnvN/obuStnUkQ7DvrEdSvUOoTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765176619; c=relaxed/simple;
	bh=Fifsoq6L0rsVImG8RoDFYXbWdp8xBrChzw1XsvErTOs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=JpJps1dlhoWHpouAkvCT1Dgt5izB4Vm0vdRjjmCjsMCOKmvPWaIHn33svE7rxfqNb++cO46s+pn3JrL3/DZRwuGfhKLFEcnIvDyt/psVphXsREggy/pA52+uLFGHvTZed4ftx7yBCnyBaPmPs/NluvCsnBTyXenoXwocrZUHZ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 8 Dec
 2025 14:50:07 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 8 Dec 2025 14:50:07 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Mon, 8 Dec 2025 14:49:56 +0800
Subject: [PATCH net] net: mdio: aspeed: add dummy read to avoid
 read-after-write issue
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251208-aspeed_mdio_add_dummy_read-v1-1-0a1861ad2161@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIABN1NmkC/x3MQQrCMBAF0KuUWRtIAqWDVxEJo/Ors0haEhWl9
 O6GLt/mbdRQDY3Ow0YVH2u2lI5wGuj+lPKAM+2m6OMYomcnbQU0ZbUliWrSd86/VCHqRp7kxuy
 Zw0Q9WCtm+x75hQpedN33Px2NPj5xAAAA
X-Change-ID: 20251208-aspeed_mdio_add_dummy_read-587ab8808817
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Potin Lai
	<potin.lai@quantatw.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Jacky Chou
	<jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765176607; l=1761;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=Fifsoq6L0rsVImG8RoDFYXbWdp8xBrChzw1XsvErTOs=;
 b=9ew34t6mAacKgfcW7cQqS3ktVoIHh8IJ1JL7IPVqkV6mjia6haubldqw8OoYpIrooiBORT2ax
 eOZ9BTZwTU/AZMQO7Vjv++X9wYuBk7+ILuD+kvzOdFTEkl1jhqJMi5D
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

The Aspeed MDIO controller may return incorrect data when a read operation
follows immediately after a write. Due to a controller bug, the subsequent
read can latch stale data, causing the polling logic to terminate earlier
than expected.

To work around this hardware issue, insert a dummy read after each write
operation. This ensures that the next actual read returns the correct
data and prevents premature polling exit.

This workaround has been verified to stabilize MDIO transactions on
affected Aspeed platforms.

Fixes: 737ca352569e ("net: mdio: aspeed: move reg accessing part into separate functions")
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/mdio/mdio-aspeed.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/mdio/mdio-aspeed.c b/drivers/net/mdio/mdio-aspeed.c
index e55be6dc9ae7..7d11add3c05e 100644
--- a/drivers/net/mdio/mdio-aspeed.c
+++ b/drivers/net/mdio/mdio-aspeed.c
@@ -63,6 +63,13 @@ static int aspeed_mdio_op(struct mii_bus *bus, u8 st, u8 op, u8 phyad, u8 regad,
 
 	iowrite32(ctrl, ctx->base + ASPEED_MDIO_CTRL);
 
+	/* Workaround for read-after-write issue.
+	 * The controller may return stale data if a read follows immediately
+	 * after a write. A dummy read forces the hardware to update its
+	 * internal state, ensuring that the next real read returns correct data.
+	 */
+	(void)ioread32(ctx->base + ASPEED_MDIO_CTRL);
+
 	return readl_poll_timeout(ctx->base + ASPEED_MDIO_CTRL, ctrl,
 				!(ctrl & ASPEED_MDIO_CTRL_FIRE),
 				ASPEED_MDIO_INTERVAL_US,

---
base-commit: 0373d5c387f24de749cc22e694a14b3a7c7eb515
change-id: 20251208-aspeed_mdio_add_dummy_read-587ab8808817

Best regards,
-- 
Jacky Chou <jacky_chou@aspeedtech.com>


