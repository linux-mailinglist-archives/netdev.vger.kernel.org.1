Return-Path: <netdev+bounces-98778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7858D270E
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 23:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 319A71F25A29
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 21:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94B917B4E0;
	Tue, 28 May 2024 21:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nDcJBBXz"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4AD17E8EB;
	Tue, 28 May 2024 21:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716931976; cv=none; b=L+EtK6Cb8YoUlm53Eumk+UTUYBZ2M5NWcBAfNO0pu9OBqNlO5Og2QM5sTuK1lt/YGeiAcBKWFPOPr20fw42gfja6cR24RuzarqfSf6f2Ud+lE8e0aUUVoxhOnfHHxlbH3x5UPFHua7SQ1tNAEgnGG19lLtViL92HeyFndiYP8K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716931976; c=relaxed/simple;
	bh=RL/H/Q1tC4LaABceTiz3iOJPxQ9kUUPRC95anWM/vSc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JDl1p7TTnER0SWdIfOGJASiCaJtncqEPMdiV29+DJe6CuXgJH61KqC4xc79b9IDqei9sE0T3OQg08uInBPwb8iS+qdzdmV0mkxz1lqQX7fovWLIlN4AkdF+vVPEe1QyHaD72so9SJN4qHqtMGHzYkOpc03oWsLT+8GIn9ijmHNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nDcJBBXz; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1716931975; x=1748467975;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=RL/H/Q1tC4LaABceTiz3iOJPxQ9kUUPRC95anWM/vSc=;
  b=nDcJBBXzHgBe6DGPPO3sW5SLo5oSikQv3XXDy2UzpwQGqggOLdoEKCDA
   fEM4/5SlPIcnphAFQ8DEbDvkkb0egpsDQnDS39nWA7SyQgmxumchnVCGg
   f7ZjNVahc+UrNfDlNEDZlZiKvuclOUhIDB8PJYfzyh4EYSq+YEdglUydb
   JR04r+ZAzvdzv36+0CTH5HSfxZYuFp33UQ4jPv1/U4eQ62uhCHmKJURYP
   uc5ypWYX7kUOCiv5FpPfTvjHR7sf8vvtFO7rWE10bRW64IAKK+iEDdyGz
   ShuX9FCtJHBitIBLc8ZjsI3/WJMtLNJhPd0hLQEHRa2dTH8bSG/PES4cu
   g==;
X-CSE-ConnectionGUID: S+VNDRXWTBKEljlE51EzHA==
X-CSE-MsgGUID: W7LI/10jRveUlOb8Da9BJw==
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="26629078"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 May 2024 14:32:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 28 May 2024 14:32:24 -0700
Received: from hat-linux.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 28 May 2024 14:32:23 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Vivien Didelot <vivien.didelot@gmail.com>, Florian Fainelli
	<f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tristram Ha
	<tristram.ha@microchip.com>
Subject: [PATCH net] net: dsa: microchip: fix initial port flush problem
Date: Tue, 28 May 2024 14:35:45 -0700
Message-ID: <1716932145-3486-1-git-send-email-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

The very first flush in any port will flush all learned addresses in all
ports.  This can be observed by unplugging a cable from one port while
additional ports are connected and dumping the fdb entries.

This problem is caused by the initially wrong value programmed to the
register.  After the first flush the value is reset back to the normal so
the next port flush will not cause such problem again.

Fixes: b987e98e50ab ("dsa: add DSA switch driver for Microchip KSZ9477")
Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
 drivers/net/dsa/microchip/ksz9477.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index f8ad7833f5d9..7cc92b90ffea 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -356,8 +356,7 @@ int ksz9477_reset_switch(struct ksz_device *dev)
 
 	/* default configuration */
 	ksz_read8(dev, REG_SW_LUE_CTRL_1, &data8);
-	data8 = SW_AGING_ENABLE | SW_LINK_AUTO_AGING |
-	      SW_SRC_ADDR_FILTER | SW_FLUSH_STP_TABLE | SW_FLUSH_MSTP_TABLE;
+	data8 |= SW_AGING_ENABLE | SW_LINK_AUTO_AGING | SW_SRC_ADDR_FILTER;
 	ksz_write8(dev, REG_SW_LUE_CTRL_1, data8);
 
 	/* disable interrupts */
-- 
2.34.1


