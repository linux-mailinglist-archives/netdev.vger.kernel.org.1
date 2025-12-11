Return-Path: <netdev+bounces-244324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4C8CB4DE9
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 07:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A29D63001601
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 06:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70302286D70;
	Thu, 11 Dec 2025 06:25:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06DC28541A;
	Thu, 11 Dec 2025 06:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765434312; cv=none; b=MDmouuW3y4IM7zp4zo/kNp5CHTEEN2WxRiX4dwojAcFrKMiEuRcNubXjIRYT48xezDEoruB4nsX7YgwRaRbh1FtY/+g0mTcyOj/l5akMKz2JTR86wd4nhspB44Apo1API208USVHhoZKvrLPwpd5SYI+syC7q5o0xQNgAU5XI3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765434312; c=relaxed/simple;
	bh=/F4kIXDvh45WJxiCbdIwAGVfMvFPrac8MDCbVP75p2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=FN6VEv7b4MwbsLaFmSN65VNoWm6uvq1g3FPj8wrfvG1vUQBRAu61d0tLdwCt4gcQi0AXejngAfgm595BUI/H7Fp7/VmCcepVfXgjGiWGHsz+Z5LJloFvpM0VWwW8ndlVlK+vDdKN+ArKT4jGMAWm+3zHmCWmNDcvvTSQTh8v9Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 11 Dec
 2025 14:25:01 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 11 Dec 2025 14:25:01 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Thu, 11 Dec 2025 14:24:58 +0800
Subject: [PATCH net v3] net: mdio: aspeed: add dummy read to avoid
 read-after-write issue
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251211-aspeed_mdio_add_dummy_read-v3-1-382868869004@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIALljOmkC/43NQQ7CIBAF0Ks0rMUwaCl15T2MIVimlgWlgUpsm
 t5dghsTE+Pyz5+8v5KIwWIkp2olAZON1o85HHYV6QY93pFakzPhjNfAmaQ6TohGOWO90sYo83B
 uUQG1obVs9E1KJiU0JANTwN4+C34hI87kmo+DjbMPSxlMUKp/7AQUKNMgBWjDQcD5/TxjN+w77
 4qd+KfX/vR49upeMAHiCK1sv7xt214iS3GuHgEAAA==
X-Change-ID: 20251208-aspeed_mdio_add_dummy_read-587ab8808817
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Potin Lai
	<potin.lai@quantatw.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, "Andrew
 Jeffery" <andrew@aj.id.au>, Jacky Chou <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765434301; l=2016;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=/F4kIXDvh45WJxiCbdIwAGVfMvFPrac8MDCbVP75p2g=;
 b=oJptiug7G0Gd4SocdRv+VJ4ONlyM5fmP7zoWOeQc6wU3FZ/KkhT4lxdo14vQWCOtkRhz67Y2g
 97WIqf9bH2XBjn3dkbiQSY0jjL20PVv1/htH/ayyKn+s8t/nwgFZKHH
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

Fixes: f160e99462c6 ("net: phy: Add mdio-aspeed")
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
Changes in v3:
- Remove (void)
- Link to v2: https://lore.kernel.org/r/20251209-aspeed_mdio_add_dummy_read-v2-1-5f6061641989@aspeedtech.com

Changes in v2:
- Updated the Fixes: tag
- Link to v1: https://lore.kernel.org/r/20251208-aspeed_mdio_add_dummy_read-v1-1-0a1861ad2161@aspeedtech.com
---
 drivers/net/mdio/mdio-aspeed.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/mdio/mdio-aspeed.c b/drivers/net/mdio/mdio-aspeed.c
index e55be6dc9ae7..d6b9004c61dc 100644
--- a/drivers/net/mdio/mdio-aspeed.c
+++ b/drivers/net/mdio/mdio-aspeed.c
@@ -63,6 +63,13 @@ static int aspeed_mdio_op(struct mii_bus *bus, u8 st, u8 op, u8 phyad, u8 regad,
 
 	iowrite32(ctrl, ctx->base + ASPEED_MDIO_CTRL);
 
+	/* Workaround for read-after-write issue.
+	 * The controller may return stale data if a read follows immediately
+	 * after a write. A dummy read forces the hardware to update its
+	 * internal state, ensuring that the next real read returns correct data.
+	 */
+	ioread32(ctx->base + ASPEED_MDIO_CTRL);
+
 	return readl_poll_timeout(ctx->base + ASPEED_MDIO_CTRL, ctrl,
 				!(ctrl & ASPEED_MDIO_CTRL_FIRE),
 				ASPEED_MDIO_INTERVAL_US,

---
base-commit: 6bcb7727d9e612011b70d64a34401688b986d6ab
change-id: 20251208-aspeed_mdio_add_dummy_read-587ab8808817

Best regards,
-- 
Jacky Chou <jacky_chou@aspeedtech.com>


