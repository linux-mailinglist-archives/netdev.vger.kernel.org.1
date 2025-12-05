Return-Path: <netdev+bounces-243684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA6BCA5D8F
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 02:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CE2E303E65C
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 01:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306C5224234;
	Fri,  5 Dec 2025 01:37:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136A91684B4;
	Fri,  5 Dec 2025 01:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764898658; cv=none; b=O4ffIj0mG0U23cAV2WWme2iyukoDzC8my2dNnLA8XAiYV/1+/fL2CWHcW54NaOiS7OjI6nbTLebODvhyFK7Wxo9NQpgouhOYJnaECIQAgK0y1pALNU1r2H/ndBpkRiKTvedpMruwl0CU9wSxtzHkzZx6alIEUdrVU7v5OeUBcFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764898658; c=relaxed/simple;
	bh=S7YMglq8xDZ86NvHllMwMpita0VXT5NdJ+3b28QfTZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=qbsNswfEWEsl2ZzjUXXEX8Z6prsxFlLRpyK+sOOycnif4iW9+bFcRjgi/myVUE3TNfEnnE9RdtSD0wTbFNiLEi6r/jghNWodXoFku0HD+BgC4Ag3XdeyGZWC+cI0h2jsh6bwykIIBPWKeGBNlrdTe3dfyZX/ifZITBNYZzmsgPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 5 Dec
 2025 09:37:27 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 5 Dec 2025 09:37:27 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Fri, 5 Dec 2025 09:37:22 +0800
Subject: [PATCH net-next] net: mdio: aspeed: add dummy read to avoid
 read-after-write issue
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251205-aspeed_mdio_add_dummy_read-v1-1-60145ae20ea7@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIAFE3MmkC/x3MQQqDMBAF0KvIrBswwUDbq5QSQv9vO4tESaxYx
 LsbXL7N26SyKKvcu00KF6065gZ76eT1jflDo2gW1ztvXe9NrBOJkKBjiEDAL6V/KIww8FdYDrf
 BOkgLpsK3rmf+kMzZZK6zPPf9AIb4G/R2AAAA
X-Change-ID: 20251205-aspeed_mdio_add_dummy_read-d58d1e49412d
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Jacky Chou
	<jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764898647; l=1685;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=S7YMglq8xDZ86NvHllMwMpita0VXT5NdJ+3b28QfTZA=;
 b=Ps7Hi70frz0jQRXPVvsI7ldWRC/vUIB2+MlTS0A8qMwi2htDxw+IuUKtQFWJ/D4fb+S5YT/WU
 +6J+70lg37kB2/KkYTcqTd2EYPL6bmdnjhSrYXB//9EmSRmeEb1bkfX
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

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/mdio/mdio-aspeed.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/mdio/mdio-aspeed.c b/drivers/net/mdio/mdio-aspeed.c
index e55be6dc9ae7..00e61b922876 100644
--- a/drivers/net/mdio/mdio-aspeed.c
+++ b/drivers/net/mdio/mdio-aspeed.c
@@ -62,6 +62,12 @@ static int aspeed_mdio_op(struct mii_bus *bus, u8 st, u8 op, u8 phyad, u8 regad,
 		| FIELD_PREP(ASPEED_MDIO_DATA_MIIRDATA, data);
 
 	iowrite32(ctrl, ctx->base + ASPEED_MDIO_CTRL);
+	/* Workaround for read-after-write issue.
+	 * The controller may return stale data if a read follows immediately
+	 * after a write. A dummy read forces the hardware to update its
+	 * internal state, ensuring that the next real read returns correct data.
+	 */
+	(void)ioread32(ctx->base + ASPEED_MDIO_CTRL);
 
 	return readl_poll_timeout(ctx->base + ASPEED_MDIO_CTRL, ctrl,
 				!(ctrl & ASPEED_MDIO_CTRL_FIRE),

---
base-commit: 8f7aa3d3c7323f4ca2768a9e74ebbe359c4f8f88
change-id: 20251205-aspeed_mdio_add_dummy_read-d58d1e49412d

Best regards,
-- 
Jacky Chou <jacky_chou@aspeedtech.com>


