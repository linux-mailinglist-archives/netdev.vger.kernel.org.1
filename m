Return-Path: <netdev+bounces-206314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A4FB02986
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 07:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E683A7B8AB4
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 05:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4946201276;
	Sat, 12 Jul 2025 05:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="x6bC5+vo"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB0F6ADD;
	Sat, 12 Jul 2025 05:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752299948; cv=none; b=rDsmVPpMZ0pZcDKjqOslvvbsn4uKV4G1L6GNB/ZKM4FAxmc61afDExrTdVHrv9f+ZOZQXUVLXwUPvMeHpX2XtKJEOJHW1ub8bFCEEyQ/oJfrK9eUjdJ30H5RiEUreIyW65lhRb9ny2G/UOYaMa3owJENy11YPNNuGUHxF8cBxDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752299948; c=relaxed/simple;
	bh=anC/9YHi9iN7Bq89giMEAd71gSC68fpm69srlwCVaCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uvcuz4SWNndxdZGPxoz1qTZaC64DcI5JcOrq+SBe1X7nJhVEGYFaEBYcMDoZaqOcRLCrwtCLrcSqh1XXGah9yt6zmRz42L29Y3o+GlJ6R5HJDROxDEnJ4hu7yf1kNS1qyVrKkfk1KrqOYDXB/TdA2D45UJ0Pmu7vrVJrSKddzXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=x6bC5+vo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=8t5sHWjfGOeS4xJWk0tqUnTlFjRBth23Ehas1zTXft8=; b=x6bC5+voErzvchvIhrsKFuoR8A
	ngTb10kzW0wkvGyHuF1ZqnjT+Xgs1D4CC5KXjhvJeTya4b52BrjMRZMy3IXJqt+/aq1aThauC3ZNB
	t+PjBO51U/pojJPkc9N2qBis9uU5xPYD+b+WmJy4cTpIT9VT/VU5uLiXWArWy8qzCIIZ16rEXIN09
	tE87C40USn5/9eVE9fex/WbLzbXJxoYJlIjDu/Q3A9FWcU95Nx8kAfqcwSCoa7tZQF/ne2M0J8b7r
	Q2mWbhs+ZjuxNm1jDkSuNNyBamwiuxQGKJG/PFNl4SvqebjYAPEGLwtdXb61LgDISETBxB60TkaPy
	2MbPvFFQ==;
Received: from [50.53.25.54] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uaTGD-0000000GIuX-1OKc;
	Sat, 12 Jul 2025 05:58:57 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v2 net-next] net: wangxun: fix VF drivers Kconfig dependencies and help text
Date: Fri, 11 Jul 2025 22:58:56 -0700
Message-ID: <20250712055856.1732094-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On x86_64, when CONFIG_PTP_1588_CLOCK_OPTIONAL=m,
CONFIG_LIBWX can be set to 'y' by either of TXGBEVF=y or NGBEVF=y,
causing kconfig unmet direct dependencies warning messages:

WARNING: unmet direct dependencies detected for LIBWX
  Depends on [m]: NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_WANGXUN [=y] && PTP_1588_CLOCK_OPTIONAL [=m]
  Selected by [y]:
  - TXGBEVF [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_WANGXUN [=y] && PCI [=y] && PCI_MSI [=y]
  - NGBEVF [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_WANGXUN [=y] && PCI_MSI [=y]

and subsequent build errors:

ld: vmlinux.o: in function `wx_clean_tx_irq':
drivers/net/ethernet/wangxun/libwx/wx_lib.c:757:(.text+0xa48f18): undefined reference to `ptp_schedule_worker'
ld: vmlinux.o: in function `wx_get_ts_info':
drivers/net/ethernet/wangxun/libwx/wx_ethtool.c:509:(.text+0xa4a58c): undefined reference to `ptp_clock_index'
ld: vmlinux.o: in function `wx_ptp_stop':
drivers/net/ethernet/wangxun/libwx/wx_ptp.c:838:(.text+0xa4b3dc): undefined reference to `ptp_clock_unregister'
ld: vmlinux.o: in function `wx_ptp_reset':
drivers/net/ethernet/wangxun/libwx/wx_ptp.c:769:(.text+0xa4b80c): undefined reference to `ptp_schedule_worker'
ld: vmlinux.o: in function `wx_ptp_create_clock':
drivers/net/ethernet/wangxun/libwx/wx_ptp.c:532:(.text+0xa4b9d1): undefined reference to `ptp_clock_register'

Add dependency to PTP_1588_CLOCK_OPTIONAL for both txgbevf and ngbevf.
This is needed since both of them select LIBWX and it depends on
PTP_1588_CLOCK_OPTIONAL.

Drop "depends on PCI" for TXGBEVF since PCI_MSI implies that.
Drop "select PHYLINK" for TXGBEVF since the driver does not use phylink.

Move the driver name help text to the module name help text for
both drivers.

Fixes: 377d180bd71c ("net: wangxun: add txgbevf build")
Fixes: a0008a3658a3 ("net: wangxun: add ngbevf build")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
v2: also drop PHYLINK for TXGBEVF, suggested by Jiawen Wu

 drivers/net/ethernet/wangxun/Kconfig |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

--- linux-next-20250710.orig/drivers/net/ethernet/wangxun/Kconfig
+++ linux-next-20250710/drivers/net/ethernet/wangxun/Kconfig
@@ -66,35 +66,33 @@ config TXGBE
 
 config TXGBEVF
 	tristate "Wangxun(R) 10/25/40G Virtual Function Ethernet support"
-	depends on PCI
 	depends on PCI_MSI
+	depends on PTP_1588_CLOCK_OPTIONAL
 	select LIBWX
-	select PHYLINK
 	help
 	  This driver supports virtual functions for SP1000A, WX1820AL,
 	  WX5XXX, WX5XXXAL.
 
-	  This driver was formerly named txgbevf.
-
 	  More specific information on configuring the driver is in
 	  <file:Documentation/networking/device_drivers/ethernet/wangxun/txgbevf.rst>.
 
-	  To compile this driver as a module, choose M here. MSI-X interrupt
-	  support is required for this driver to work correctly.
+	  To compile this driver as a module, choose M here. The module
+	  will be called txgbevf. MSI-X interrupt support is required
+	  for this driver to work correctly.
 
 config NGBEVF
 	tristate "Wangxun(R) GbE Virtual Function Ethernet support"
 	depends on PCI_MSI
+	depends on PTP_1588_CLOCK_OPTIONAL
 	select LIBWX
 	help
 	  This driver supports virtual functions for WX1860, WX1860AL.
 
-	  This driver was formerly named ngbevf.
-
 	  More specific information on configuring the driver is in
 	  <file:Documentation/networking/device_drivers/ethernet/wangxun/ngbevf.rst>.
 
-	  To compile this driver as a module, choose M here. MSI-X interrupt
-	  support is required for this driver to work correctly.
+	  To compile this driver as a module, choose M here. The module
+	  will be called ngbefv. MSI-X interrupt support is required for
+	  this driver to work correctly.
 
 endif # NET_VENDOR_WANGXUN

