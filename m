Return-Path: <netdev+bounces-144815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 623DA9C8793
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25590284FB3
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F6B1F8F0B;
	Thu, 14 Nov 2024 10:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FeNAW1OA"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C381F76AC;
	Thu, 14 Nov 2024 10:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731579936; cv=none; b=O2m+nArGx8nJAuvdw1NVmxZB+TWqd23wh9lfBW3ENYRg6iAx0enARQL8FXcUt+ynbYLM9hm9VEw1oPPOMvwGvbU0Sm5vqU/eVuYVyvxsS0yc84C4YX+TWlUfaNn3+P3PTo4Ef+S6s0Uk1z0Hric+eY+YBX5vHyKyMIwYbVaysWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731579936; c=relaxed/simple;
	bh=PVZt50xKgkDZqujM6gY9ARLbzF4hPBVFADkPWTbzV6M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YKbBwHwCCsJXnmYnNkhL9esBbgGLrJbqwPjX598RhuTUYgVIlIUYbd6KScHXIvoETeK3oClKovqhRC35KxqzQH3/OZx70ea63kF85+N0hEX0gVCZvdMO8mGUgAbJLpnxFsIc2Yzva24XKq6oGGbYHHE2sfiKXWO4QfiVAKUM4PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=FeNAW1OA; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731579934; x=1763115934;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PVZt50xKgkDZqujM6gY9ARLbzF4hPBVFADkPWTbzV6M=;
  b=FeNAW1OAV7ZCbBxrqwd1p3reBpZ9YXDInlqD4a1sa1eSdwfrnUWpZpK4
   ssFePh0xAenCHPzjtIOKwGRxLENlai5GMRkXqaDzD1G35/IDxjBsdlJlo
   L+vuGPHJaPdPiuQkiAV7/PGDXbTi6WM4j/muQbmdbJZb+/Q4IKN9kWpKh
   z5fdY9uvFYJ+ue+GWkIHIFGUnYnlS4OMJoD8pU2y2TN7eL1hvTctjggK7
   si0tCXPX5Zac3vFzQgdGNNQZJpwET4w7OqSdDf+M9XEBgqXejpFQ7x1SW
   61g9DcMoOLhYxurdFn4giT8r5oxV5S2mYl+4DVsHJB1RebZaMrt84yBGh
   w==;
X-CSE-ConnectionGUID: HPV/YlKXRl6rsyfNkaR4NA==
X-CSE-MsgGUID: Hug4GU7DTUmSW5iGn49sdw==
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="37840105"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Nov 2024 03:25:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Nov 2024 03:25:11 -0700
Received: from HYD-DK-UNGSW20.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 14 Nov 2024 03:25:06 -0700
From: Tarun Alle <Tarun.Alle@microchip.com>
To: <arun.ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] net: phy: microchip_t1: Clause-45 PHY loopback support for LAN887x
Date: Thu, 14 Nov 2024 15:49:51 +0530
Message-ID: <20241114101951.382996-1-Tarun.Alle@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Adds support for clause-45 PHY loopback for the Microchip LAN887x driver.

Signed-off-by: Tarun Alle <Tarun.Alle@microchip.com>
---
 drivers/net/phy/microchip_t1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/microchip_t1.c b/drivers/net/phy/microchip_t1.c
index 71d6050b2833..b17bf6708003 100644
--- a/drivers/net/phy/microchip_t1.c
+++ b/drivers/net/phy/microchip_t1.c
@@ -2113,6 +2113,7 @@ static struct phy_driver microchip_t1_phy_driver[] = {
 		.handle_interrupt = lan887x_handle_interrupt,
 		.get_sqi	= lan887x_get_sqi,
 		.get_sqi_max	= lan87xx_get_sqi_max,
+		.set_loopback	= genphy_c45_loopback,
 	}
 };
 
-- 
2.34.1


