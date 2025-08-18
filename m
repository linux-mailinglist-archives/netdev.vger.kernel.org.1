Return-Path: <netdev+bounces-214475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E67BCB29CA6
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 10:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A49EC1891E71
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 08:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFAC2FB995;
	Mon, 18 Aug 2025 08:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="fZwW5P+w"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1732FF64D;
	Mon, 18 Aug 2025 08:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755506760; cv=none; b=RBPInZCSpwgNbYkjTBs2FwxWu7wsGSczTI2HvLznA4Bi+osNcdp57r/29KF6dQnZE6yE4VvNC5/Pbp0PG/4ilMd+RBTskEgV9C0HyZMbtVx9alTiwyuN1zSrEWYec7DkUj5CxKknjI5fC/0Jdvj8VQoEPX1K12B2FAZmsWiPc3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755506760; c=relaxed/simple;
	bh=gkk5Punudm3E+n5nYlLeniqR/ysIUuQfCso+2reJaBI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U8yC8ZDI1oBuzHPTBA/SCgs73Coc8ezF7UPXIowl28VWZ1oyEI5iqMg5d4bNsaU4qzqNDlotbZLzrat9KQmIRzcl5ZKafpCs+nP2zntno08QyvVSYxMcX3aY7E66RD68NBa80Ygcs5I889+uEeuUvVDdOepZOeAZzboO1/yz6Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=fZwW5P+w; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1755506758; x=1787042758;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MPRALudGkzcWuuQ0MxZaK3+KIi6aEACw/1pbTObCt3w=;
  b=fZwW5P+wBbcUkWn8GvAKKViwGYz4I+IzODY7NSoMM9MN1xSm9ri3NrKH
   RZY7sqEWOoOSZfjTGZ8Pjev4oqT10ixOrXu8xIvwR+SKMenGPKJsen3LT
   qFdXU2SlrO5nApQ4fTaPoV5uz0fI13uLLeuWwX1w+bZLi+BLE9qJssY2F
   VU9rJofmNLl1Ut1zhgWIdS6znIrOpupREXpEkC30fV7MfS5jEW6bZhKei
   Q+MEAe/14HTCb1Smh8VwX8yBuRcoItn49cjPi65lVdZJ+paMaiyHMeUH5
   Bkf/x/PXfYBMSJ1nKn5CI4MLq8hpx23a//CQy3z23TV7E3XM19WM9gJxR
   w==;
X-CSE-ConnectionGUID: iOSBl41wTTq/xVAdh7ht4A==
X-CSE-MsgGUID: J0rDwryUSC2rti3XET8OwA==
X-IronPort-AV: E=Sophos;i="6.17,293,1747699200"; 
   d="scan'208";a="1291079"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 08:45:56 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:64875]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.170:2525] with esmtp (Farcaster)
 id 28691148-49b2-4270-a8ad-db7444f43ec5; Mon, 18 Aug 2025 08:45:56 +0000 (UTC)
X-Farcaster-Flow-ID: 28691148-49b2-4270-a8ad-db7444f43ec5
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 18 Aug 2025 08:45:56 +0000
Received: from HND-5CG1082HRX.ant.amazon.com (10.37.244.10) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Mon, 18 Aug 2025 08:45:54 +0000
From: Yuichiro Tsuji <yuichtsu@amazon.com>
To: <linux-usb@vger.kernel.org>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Yuichiro Tsuji
	<yuichtsu@amazon.com>,
	<syzbot+20537064367a0f98d597@syzkaller.appspotmail.com>
Subject: [PATCH] net: usb: asix_devices: Fix PHY address mask in MDIO bus initialization
Date: Mon, 18 Aug 2025 17:45:07 +0900
Message-ID: <20250818084541.1958-1-yuichtsu@amazon.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA001.ant.amazon.com (10.13.139.110) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Syzbot reported shift-out-of-bounds exception on MDIO bus initialization.

The PHY address should be masked to 5 bits (0-31). Without this
mask, invalid PHY addresses could be used, potentially causing issues
with MDIO bus operations.

Fix this by masking the PHY address with 0x1f (31 decimal) to ensure
it stays within the valid range.

Fixes: 4faff70959d5 ("net: usb: asix_devices: add phy_mask for ax88772 mdio bus")
Reported-by: syzbot+20537064367a0f98d597@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=20537064367a0f98d597
Tested-by: syzbot+20537064367a0f98d597@syzkaller.appspotmail.com
Signed-off-by: Yuichiro Tsuji <yuichtsu@amazon.com>
---
 drivers/net/usb/asix_devices.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index d9f5942ccc44..792ddda1ad49 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -676,7 +676,7 @@ static int ax88772_init_mdio(struct usbnet *dev)
 	priv->mdio->read = &asix_mdio_bus_read;
 	priv->mdio->write = &asix_mdio_bus_write;
 	priv->mdio->name = "Asix MDIO Bus";
-	priv->mdio->phy_mask = ~(BIT(priv->phy_addr) | BIT(AX_EMBD_PHY_ADDR));
+	priv->mdio->phy_mask = ~(BIT(priv->phy_addr & 0x1f) | BIT(AX_EMBD_PHY_ADDR));
 	/* mii bus name is usb-<usb bus number>-<usb device number> */
 	snprintf(priv->mdio->id, MII_BUS_ID_SIZE, "usb-%03d:%03d",
 		 dev->udev->bus->busnum, dev->udev->devnum);
-- 
2.43.5


