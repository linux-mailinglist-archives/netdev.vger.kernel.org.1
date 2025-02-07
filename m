Return-Path: <netdev+bounces-163793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B968A2B932
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 03:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0337E3A31A1
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 02:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0CA188591;
	Fri,  7 Feb 2025 02:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PkAv2Ld1"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4AB7E0FF;
	Fri,  7 Feb 2025 02:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738896237; cv=none; b=mpV1EN9ZCWN/45z1bzZLuelNKQTzMJnqhBurUbYj9n/0gxupi8JF3wHYj1qEPqFjBrN5J4p/mYJZZcfP4ENHTcSFgaWQAdYMeFfZDQFrdLnCIKl5gFLW0dTZeT2CP++DPa8dN0RAqE9KT/DHlutzuOKYHb/ARTeT13WdDl5ijjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738896237; c=relaxed/simple;
	bh=x55ztdVWpMWIFD+YnbXU+Mpg5vtUMbqKH4u/cg8trv0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h9SVNblazCLza58icCA/VTcmuKk47V4jQbJIzU/gmYJMoAUh91/10gqQuah0skEAGdf2QJmVga/77z+xfEmPJHFId7LZCTxtye2LQC9KZCNaNH/q4gH/rKR2Bo5OoDKoSzSq7u3LKVmb7tdn6dEoMuEwOViWRQH0VLeX3dBlUEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PkAv2Ld1; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1738896236; x=1770432236;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x55ztdVWpMWIFD+YnbXU+Mpg5vtUMbqKH4u/cg8trv0=;
  b=PkAv2Ld1hYEqG/IGM/cNmkUiTcuQejwNCI7AHoTUvwrk8jYF6idtwJ6o
   gnrWv+FGD4rDKzFEEdTVGx7wZXCeAxpShyp0LCCDwoPu2tlnbMgauhDbq
   6U8Soq6rHA0A38+/TOdd45tOqHPWAOFSmCHbqdQiEYH7NOQr960Zcl3+q
   o1kVJ3eaT8Fpo7fM7P/aY0GB9rin6NygD6c7JtY2qSVOlXsyAbHA0/tHO
   iw2slbRjutY1Q/0Rvwj2DKrVnXIuWB/tKD83S2QBDor0pKuFJt6sA+MTZ
   keybpJZ1Q8xYapnPUgl9xCECEPR1GCflMr5moIOepbl+eVjGKaEJnztlO
   g==;
X-CSE-ConnectionGUID: HtEgmb03QQa8PJ+IoVcYWA==
X-CSE-MsgGUID: TQnFM0foTBCIdErefi0/pQ==
X-IronPort-AV: E=Sophos;i="6.13,266,1732604400"; 
   d="scan'208";a="37381076"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Feb 2025 19:43:47 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 6 Feb 2025 19:43:09 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 6 Feb 2025 19:43:09 -0700
From: <Tristram.Ha@microchip.com>
To: Russell King <linux@armlinux.org.uk>, Woojung Huh
	<woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
	<olteanv@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, "Maxime
 Chevallier" <maxime.chevallier@bootlin.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tristram Ha
	<tristram.ha@microchip.com>
Subject: [PATCH RFC net-next v2 2/3] net: dsa: microchip: Add SGMII port support to KSZ9477 switch
Date: Thu, 6 Feb 2025 18:43:15 -0800
Message-ID: <20250207024316.25334-3-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250207024316.25334-1-Tristram.Ha@microchip.com>
References: <20250207024316.25334-1-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

The KSZ9477 DSA driver uses XPCS driver to operate its SGMII port.

Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
v2
 - update Kconfig to pass compilation test

 drivers/net/dsa/microchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/microchip/Kconfig b/drivers/net/dsa/microchip/Kconfig
index 12a86585a77f..c71d3fd5dfeb 100644
--- a/drivers/net/dsa/microchip/Kconfig
+++ b/drivers/net/dsa/microchip/Kconfig
@@ -6,6 +6,7 @@ menuconfig NET_DSA_MICROCHIP_KSZ_COMMON
 	select NET_DSA_TAG_NONE
 	select NET_IEEE8021Q_HELPERS
 	select DCB
+	select PCS_XPCS
 	help
 	  This driver adds support for Microchip KSZ8, KSZ9 and
 	  LAN937X series switch chips, being KSZ8863/8873,
-- 
2.34.1


