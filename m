Return-Path: <netdev+bounces-129511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFDA98439F
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 12:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7253AB22739
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 10:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C28194080;
	Tue, 24 Sep 2024 10:31:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from riemann.telenet-ops.be (riemann.telenet-ops.be [195.130.137.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8FD19309C
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 10:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727173891; cv=none; b=GIHzGBa13R5MwRAEiJZcm/vsSS4dRImbtG7nKjYvhzALgTkUGe1JghQiu4T9R3lcucghh192dXuTprFtjZtJo79iHsfiALp0SAVi8PiNOgErXLetNzaE981uXpe9cFb08A119xMuLxoui64ezkytWQK1yD0DT5bReqgQXnu58Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727173891; c=relaxed/simple;
	bh=BsX8pefkzF31t5V//DitLnaT98wyLGVu/CwKaLaw6y0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ei0TVQMwrtrHnNWwHSlsFXBHByydb3hN8QllGxpt5qANpEYekuobSN1EFn+mJRV7uhrzX40l5Q+HHtYFpY4tFcCmNw9RDZmlym3evFi4fwCvSPb8xQE8PE/QYEUQmtRc7m4oiVuRzgdo/YspgniDTFRuUY+vl0B51Nn/fp7KLPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
	by riemann.telenet-ops.be (Postfix) with ESMTPS id 4XCbb561YSz4xHKh
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 12:25:05 +0200 (CEST)
Received: from ramsan.of.borg ([84.195.187.55])
	by xavier.telenet-ops.be with cmsmtp
	id GAQx2D00W1C8whw01AQxc3; Tue, 24 Sep 2024 12:24:58 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1st2em-000Sjk-7Y;
	Tue, 24 Sep 2024 12:20:36 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1st2ep-00338A-M6;
	Tue, 24 Sep 2024 12:20:35 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] net: ethernet: Make OA_TC6 config symbol invisible
Date: Tue, 24 Sep 2024 12:20:32 +0200
Message-Id: <9ebc58517c35a3afc4b19c3844da74984c561268.1727173168.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to ask the user about enabling OPEN Alliance TC6
10BASE-T1x MAC-PHY support, as all drivers that use this library select
the OA_TC6 symbol.  Hence make the symbol invisible, unless when
compile-testing.

Fixes: aa58bec064ab1622 ("net: ethernet: oa_tc6: implement register write operation")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/ethernet/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index 9a542e3c9b05d877..977b42bc1e8c1e88 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -159,7 +159,7 @@ config ETHOC
 	  Say Y here if you want to use the OpenCores 10/100 Mbps Ethernet MAC.
 
 config OA_TC6
-	tristate "OPEN Alliance TC6 10BASE-T1x MAC-PHY support"
+	tristate "OPEN Alliance TC6 10BASE-T1x MAC-PHY support" if COMPILE_TEST
 	depends on SPI
 	select PHYLIB
 	help
-- 
2.34.1


