Return-Path: <netdev+bounces-118144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA75F950C00
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 20:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76F32284DC9
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 18:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7F11A2C1E;
	Tue, 13 Aug 2024 18:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ez2XRh9g"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4988D19E7E3;
	Tue, 13 Aug 2024 18:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723572806; cv=none; b=sXRyZCDiwBZNOiXVyKeAbnRDisKC28WM6lZVnSGQsMDnPu1TbosQVtsKny5d9GNf9IADzyQjEmzy9TXxnT2WL6Y1GsepG0+VOHCBWqWnV5ZLj9TbQSUn9I0zGoOVN+mCie8GiVbf+jUm625ZQsc3AfRlXNi5AWj9eq7SNqS5x00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723572806; c=relaxed/simple;
	bh=O3dtulhhM/axpHe4p5tksCGx3TlnoxRnwsGM1/zuj8g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LWK65GvXYFEeRiGyjwE4uWC8i12KrpUP1sNLvvULyvqh9LsqrXg9QJKOcRc8B5oRcJUJfuA99w0XdkfgOLrDp3fNQ8Oodlmk2Pgs59eUhfcEBAjFdYIejoAxlrnW1+OETxHC8bv34c5KJuLFZ7dSTw4zCRkA94+yTF6BLM7k4r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ez2XRh9g; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723572804; x=1755108804;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O3dtulhhM/axpHe4p5tksCGx3TlnoxRnwsGM1/zuj8g=;
  b=ez2XRh9gnkpe/mh9hEqX0ipoaq6W3286T1rVIdW7J0rx3tfQAKlIzySA
   P7K+AowOPyeg21B2J7sb/lrSdHIAGaBSQnN5VrJlePCYNehxOIAp1zs7u
   CdJ1Yyhfj68m68jVCMmEb7YIcrRY1+g0aiaxmzqO2Natwv3KNDbSdQ4pX
   I6YqpZmtxQo8UXiOiwMM0uRyvAQILhPs9KgzoXgW4VfzD/zy7WXjErXcY
   3U6PYOn7DEZMl5r0M2YpjWKD/qr3lOdzxBnCUHXfXYGHtXVMkLSusTrWy
   lnvD4VcY/+GTSvMb0Ojidf/4q4DV8hGoAIhPMS093gTujPHhjp7MCjHia
   w==;
X-CSE-ConnectionGUID: EsYhHSPxTQafGavfWkHnvA==
X-CSE-MsgGUID: cRLdwuB9TMKfqr89dWjcWw==
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="31118404"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Aug 2024 11:13:17 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Aug 2024 11:12:55 -0700
Received: from HYD-DK-UNGSW08.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 13 Aug 2024 11:12:51 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next v2 0/2] Adds support for lan887x phy
Date: Tue, 13 Aug 2024 23:45:13 +0530
Message-ID: <20240813181515.863208-1-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Adds support for lan887x phy and accept autoneg configuration in
phy driver only when feature is enabled in supported list.

v1 -> v2
Addresed below review comments
- Added phy library support to check supported list when autoneg is
  enabled
- Removed autoneg enabled check in lan887x phy.
- Removed of_mdio macro for LED initialization.
- Removed clearing pause frames support from supported list.

Divya Koppera (2):
  net: phy: Add phy library support to check supported list when autoneg
is enabled
  net: phy: microchip_t1: Adds support for lan887x phy

 drivers/net/phy/microchip_t1.c | 577 ++++++++++++++++++++++++++++++++-
 drivers/net/phy/phy.c          |   5 +-
 2 files changed, 580 insertions(+), 2 deletions(-)

-- 
2.34.1


