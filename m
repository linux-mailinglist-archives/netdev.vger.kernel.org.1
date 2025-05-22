Return-Path: <netdev+bounces-192672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35752AC0C8D
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 15:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AE5E1896C72
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 13:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8A628B7F9;
	Thu, 22 May 2025 13:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fkb7+nGF"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4E32F85B
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 13:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747919994; cv=none; b=ZurnGKV6y0cPEUDSfTPq0J968Sx1/JHzmK6/r+G4QtZDeRmuHCdnh3tKMkFnH/scUFupZL2LwRNYfF0n2J0OSQCYp3+nTPLyVNo8B109jEwwQR62Tog1/dwkIcPG1e2eJQ/Iu3yPjvrIRjFyiREddGO74EWor6i2dY3pqUixDa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747919994; c=relaxed/simple;
	bh=OoUe0D3OUFbjbHWNDKuCTzdMXzlvgmA5IBnMGnJgbk8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LmEgJVnyK9Bziav/FipUXd+a1UA0UOz20I6SMTqXFEo2TGff2DAy7Co9Gwx+DlSZSVvhWuDFCtRvaoEhNLksxzD50ze53TbojAI3/b2igIs9MkCnw80Y60qoXEsiikvmps6Pr2l6k2HTBbqF/PnT1IQhcCtoH8xDumeMsHsNTf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fkb7+nGF; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747919980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EsWesO4sxz1LlUTR6SNF4pk6GAEisGaVRrkkPirpVNY=;
	b=fkb7+nGFgpQ17dT1gc1eDBaDeAOGw6YaZVwsIwFOloVzcP/dg2hAbM00XPX92tE1gTmQnM
	R0dvV0EdrsrA5seBQ9Uf22CQFScPJuMqWvksLJ2r0AetgZU/cijIpgfkLZwjKtUGHea72v
	/1a8GtD4kx3FifOaOkmgletbOCFIIJs=
From: Yajun Deng <yajun.deng@linux.dev>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH net-next] net: phy: Synchronize c45_ids to phy_id
Date: Thu, 22 May 2025 21:19:18 +0800
Message-Id: <20250522131918.31454-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The phy_id_show() function emit the phy_id for the phy device. If the phy
device is a c45 device, the phy_id is empty. In other words, phy_id_show()
only works with the c22 device.

Synchronize c45_ids to phy_id, phy_id_show() will work with both the c22
and c45 devices.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 drivers/net/phy/phy_device.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 2eb735e68dd8..6fed3e84e1a6 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -690,8 +690,12 @@ struct phy_device *phy_device_create(struct mii_bus *bus, int addr, u32 phy_id,
 	dev->pma_extable = -ENODATA;
 	dev->is_c45 = is_c45;
 	dev->phy_id = phy_id;
-	if (c45_ids)
+	if (c45_ids) {
 		dev->c45_ids = *c45_ids;
+		dev->phy_id = dev->c45_ids.device_ids[MDIO_MMD_PMAPMD];
+		if (!dev->phy_id)
+			dev->phy_id = dev->c45_ids.device_ids[MDIO_MMD_PCS];
+	}
 	dev->irq = bus->irq[addr];
 
 	dev_set_name(&mdiodev->dev, PHY_ID_FMT, bus->id, addr);
-- 
2.25.1


