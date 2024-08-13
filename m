Return-Path: <netdev+bounces-118145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A3C950C02
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 20:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79E831F218A9
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 18:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336EC1A2C32;
	Tue, 13 Aug 2024 18:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QkbPS7ug"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E34A19E7E3;
	Tue, 13 Aug 2024 18:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723572814; cv=none; b=L63BJdeuV3IxKJmJmIdhBVTfhyb2jCma2GXM9HRr/SN2Rf6ZHdHOH9m3K1CCGYRHkQJc3utEHw3TbxiYEUxLuWaPgdJvUK0rZWx/plkMVfFgIMQFn6J8LJqeBqs5NEnBDF3XvjMCRrM7eKtF3LmGwpkGkAAmg4KMIoi0R/xcD8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723572814; c=relaxed/simple;
	bh=oTIirFSbybkmIJYXc1JctqQbDfveGsUOECrMYDztjlU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H60yY9xf0AihHnDYfdQaYn45RNea/IDrmMBv2wLFfG4DAC3BsiGTmJKpW3MwQ4K+iNRCk1w7QBbZbx2UmNig5NhhQQH2m+nzPUiXOkDXUi9Yb48i75f+5AZbv+eMqYHyMzomBNL2RLSHtkkRW/bWkbqaRtrJqcBcwilRF1nZ2v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=QkbPS7ug; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723572812; x=1755108812;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=oTIirFSbybkmIJYXc1JctqQbDfveGsUOECrMYDztjlU=;
  b=QkbPS7ugJVOqEMtou56umbdpKbTaJQ61wVgzkXtE6gODE/51Bp+IBcnp
   Ej5fRnAHwxhJs15GTsNJ1sOt9VIfG76SzozySbL/y+C63J1bLpI0DGuMe
   6f/xZTf6pAJu2WCSJ6cvZdebtz1vHlv98WfTyrENyRubaPn6lE5CtJi4U
   7PNl1b/qjiCp2LqkHnJGhfK52Ct11ahyJUi3N2KDLgOePWZFszjw5MpsS
   eQnpYgHyIl6JptT8uLVgCqxTIiZ8n/KtZkTFOcbUYX+Fl3vlH24CBsCez
   Tl3aq26dbKb7MaTHqeKcnz13nyWjD7YGaRjUoS4sPRDXXZ2y9GPgiFPRJ
   g==;
X-CSE-ConnectionGUID: v1sbJLSpTMaPZ9cGmAsWIw==
X-CSE-MsgGUID: yeaFahXrTdidwAe8R1oZVw==
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="261364145"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Aug 2024 11:13:31 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Aug 2024 11:12:59 -0700
Received: from HYD-DK-UNGSW08.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 13 Aug 2024 11:12:55 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next v2 1/2] net: phy: Add phy library support to check supported list when autoneg is enabled
Date: Tue, 13 Aug 2024 23:45:14 +0530
Message-ID: <20240813181515.863208-2-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813181515.863208-1-divya.koppera@microchip.com>
References: <20240813181515.863208-1-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Adds support in phy library to accept autoneg configuration only when
feature is enabled in supported list.

Signed-off-by: Divya.Koppera <divya.koppera@microchip.com>
---
 drivers/net/phy/phy.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 785182fa5fe0..5e028ddc03da 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1089,7 +1089,10 @@ int phy_ethtool_ksettings_set(struct phy_device *phydev,
 	if (autoneg != AUTONEG_ENABLE && autoneg != AUTONEG_DISABLE)
 		return -EINVAL;
 
-	if (autoneg == AUTONEG_ENABLE && linkmode_empty(advertising))
+	if (autoneg == AUTONEG_ENABLE &&
+	    (linkmode_empty(advertising) ||
+	     !(linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+				 phydev->supported))))
 		return -EINVAL;
 
 	if (autoneg == AUTONEG_DISABLE &&
-- 
2.34.1


