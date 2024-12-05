Return-Path: <netdev+bounces-149247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E20569E4E3A
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 08:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 495B118818D0
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 07:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3A31B6CE3;
	Thu,  5 Dec 2024 07:26:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9A11B3949;
	Thu,  5 Dec 2024 07:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383564; cv=none; b=MxxeeTEl3E+5UECDtVGA4tpiZbC8oC/OCKWLWiIthptnWvtjxkUGS9HN8REuqDWUyWG0MxUWT/4Anbdo9nxDyNGYlja2qnb7NzzbDQYF60qrLyOv/5A5hQ5OsgR5+Gv732UbfYDZK6LkuvYA2NoHhnaotKOvcrxlZYQP6fN1ZDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383564; c=relaxed/simple;
	bh=bYNHC34m5WU0qugxK/Dcp3ZF8tDOpLyZgAgm2euoXK0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gS7UqzEf0r4iQb26IkjQ38abdMvUuoSkt96SuBVJrbajZd4iSqEXacAvje83mWWfSzdtR+PVOJkglu5NYnW3UmwtSSdaL4GP4caGbMZzFmP9Wbh03t0uuPZ38MDQjeHdcU19XlKfuEO7ZThCoawl3L+hDh9hScZdcyeio6fncfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 5 Dec
 2024 15:20:48 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 5 Dec 2024 15:20:48 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <p.zabel@pengutronix.de>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <jacky_chou@aspeedtech.com>
Subject: [PATCH net-next v4 2/7] net: faraday: Add ARM64 in FTGMAC100 for AST2700
Date: Thu, 5 Dec 2024 15:20:43 +0800
Message-ID: <20241205072048.1397570-3-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241205072048.1397570-1-jacky_chou@aspeedtech.com>
References: <20241205072048.1397570-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

AST2700 is a ARM 64-bit SoC and ftgmac100 adds support 64-bit
DMA capability in AST2700.
The ftgmac100 on Aspeed Soc 6th generation and above seperates MDIO
controller from MAC. It cannot add ARCH_ASPEED_G7 configuration at ARM64,
so here changes to select MDIO_ASPEED by ARCH_ARCH_ASPEED for Aspeed 6th
generation and above.

And remove not 64BIT and BROKEN dependency from FTGMAC100 config.
These are added for NDS32 architecture and now this NDS32 support
has been removed. Therefore, here does not need it anymore.
The ftgmac100 of AST2700 supports 64-bit operation, '!BIT64' dependency
will limit 64-bit support.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/Kconfig | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/faraday/Kconfig b/drivers/net/ethernet/faraday/Kconfig
index c699bd6bcbb9..c765663c0bbb 100644
--- a/drivers/net/ethernet/faraday/Kconfig
+++ b/drivers/net/ethernet/faraday/Kconfig
@@ -6,7 +6,7 @@
 config NET_VENDOR_FARADAY
 	bool "Faraday devices"
 	default y
-	depends on ARM || COMPILE_TEST
+	depends on ARM || ARM64 || COMPILE_TEST
 	help
 	  If you have a network (Ethernet) card belonging to this class, say Y.
 
@@ -28,10 +28,9 @@ config FTMAC100
 
 config FTGMAC100
 	tristate "Faraday FTGMAC100 Gigabit Ethernet support"
-	depends on ARM || COMPILE_TEST
-	depends on !64BIT || BROKEN
+	depends on ARM || ARM64 || COMPILE_TEST
 	select PHYLIB
-	select MDIO_ASPEED if MACH_ASPEED_G6
+	select MDIO_ASPEED if ARCH_ASPEED
 	select CRC32
 	help
 	  This driver supports the FTGMAC100 Gigabit Ethernet controller
-- 
2.25.1


