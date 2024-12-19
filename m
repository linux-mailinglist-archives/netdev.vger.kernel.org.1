Return-Path: <netdev+bounces-153340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A04789F7B62
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 13:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA1D87A55E5
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 12:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BA0225798;
	Thu, 19 Dec 2024 12:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nbZ70gny"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5154225776;
	Thu, 19 Dec 2024 12:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734611434; cv=none; b=RIwFqs0f32XmNtUml2WW1pzOf9rC5bWmhNp1dEVrKfhMT47v9pMvE4400gRSQ5oKgcFw+WGr0oGBewuvCrL0z/fvzWpRFuDGVwKX3JD0B9ddqbpoH1/qfMb1I3oxCjRMSbwaPVvl47j4vxljtc+nNUsy5oD5eHeWTyejDn+s/uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734611434; c=relaxed/simple;
	bh=tN33nb0qU/qLBBFNwTd52kRE1mPxmS7rK3X6QEpFFhU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bm+CGCcOKTBnaz7HTN6HOkOcv4ydPha6D7eT7sBj2nxR6bWGhwxiRT5cmC/BLr7/grGCn8YcwFKKZ1Mm4x2y2EDJlbWTMNvptv2U/rlYRjR6BI5+RYhlI6IjpxCmZW1GTghlg5ADB4j5NPYataeBrlfFM3Pom1J8W6h74uS79sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nbZ70gny; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734611431; x=1766147431;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=tN33nb0qU/qLBBFNwTd52kRE1mPxmS7rK3X6QEpFFhU=;
  b=nbZ70gnyvu+kD7WFIUfYwtd6fFySW311FKgjb0fiExyUOvdhyJabTSIh
   SVOsKlBCOh6pGiKK4882xCegSUfX/wyAFywTjoEewNNhmfWPlPrfoSv5Q
   V4IvlImImDIlGzb5O4HxFVyCFigFbXrrNgOncEBH7dQK3RG7chfWy+44u
   7ZhFE1/unYFNyXNw8ZPrqiLGbYIuta2GCa+tsZBUf6ejwv53BkmOliZp2
   A7XxRAL2o62bibn89PEUtg8iduUpHBPUfHl60HyKwW95Jmh5rDG+IrVcz
   aeF2OQkMKd4bzhCNe43fPqujIU9BYHxWc9JlNetZ0uxfeH6JCL6HMvGhv
   A==;
X-CSE-ConnectionGUID: jaNWOFtUQEmTaiFMbbfoyw==
X-CSE-MsgGUID: bdpuli4YS2KTHlwz/XCBgQ==
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="35409648"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Dec 2024 05:30:30 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 19 Dec 2024 05:30:29 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 19 Dec 2024 05:30:23 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v8 3/5] net: phy: Kconfig: Add rds ptp library support and 1588 optional flag in Microchip phys
Date: Thu, 19 Dec 2024 18:03:09 +0530
Message-ID: <20241219123311.30213-4-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241219123311.30213-1-divya.koppera@microchip.com>
References: <20241219123311.30213-1-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Add ptp library support in Kconfig
As some of Microchip T1 phys support ptp, add dependency
of 1588 optional flag in Kconfig

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
---
v7 -> v8
- Removed string after tristate, as we are selecting symbol.

v6 -> v7
- No changes

v5 -> v6
- Renamed the config name to reflect ptp hardware used.

v4 -> v5
Addressed below review comments.
- Indentation fix
- Changed dependency check to if check for PTP_1588_CLOCK_OPTIONAL

v1 -> v2 -> v3 -> v4
- No changes
---
 drivers/net/phy/Kconfig | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 15828f4710a9..dc625f2b3ae4 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -287,8 +287,15 @@ config MICROCHIP_PHY
 
 config MICROCHIP_T1_PHY
 	tristate "Microchip T1 PHYs"
+	select MICROCHIP_PHY_RDS_PTP if NETWORK_PHY_TIMESTAMPING && \
+				  PTP_1588_CLOCK_OPTIONAL
 	help
-	  Supports the LAN87XX PHYs.
+	  Supports the LAN8XXX PHYs.
+
+config MICROCHIP_PHY_RDS_PTP
+	tristate
+	help
+	  Currently supports LAN887X T1 PHY
 
 config MICROSEMI_PHY
 	tristate "Microsemi PHYs"
-- 
2.17.1


