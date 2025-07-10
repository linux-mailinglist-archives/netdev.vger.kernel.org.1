Return-Path: <netdev+bounces-205967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7E8B00F38
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 01:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34A1B5C48E3
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 23:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C52291C11;
	Thu, 10 Jul 2025 23:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="frrIqENr"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CA82459E1;
	Thu, 10 Jul 2025 23:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752188711; cv=none; b=dsAtRkY2UzWp6h6ibHTHwHfFeQHjkd1Ti93U3oo2ruLpSdtSA0jY0mJbhrWXLRab1OiFJyhvW4+br1NoRa3hfpVAmqVAel4wcIulZ8gFsJIVhAVmCMaV67P99qr22Sh/wtQPJew8girIJN1AHfiD4SJUYaLivduQPn7145ihoF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752188711; c=relaxed/simple;
	bh=AsL5B47N7rn88G9CKRVlNdr9ATBJ4SMCr2hWerJhB6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NktW0LJVBX+dJ5X7kPZNxEFpfoWfMBQwclIsJF+EuCJi69RDsa5TRREcfku1q/iZjel8RDLGH2tQF52I9ZaZfsnzVOD/jnrYSteV9hEGHTa173CpWCcW9KcReJ0YozCRGyrvAuymwk+d6ObUBgDo1j0hhQhHMKSZv1cmBzhkjSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=frrIqENr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=iTgnOZFNlsykscfQThRLMC9ap/4lnKTed6F778FE57I=; b=frrIqENrDbVafPwpEWHU2znUT7
	jVmHOPMF57EI5O7ED3T9SMq7HXOhRDR2CyG8GhgwCqtcJlmNKhOqtW40gBWC781FmmYaIAz7dd+EZ
	0qytB2rQtfx0Dt+GYzDiCwGSzQfDAE78i7+VvdhiwBJRwaJbKs9oYM4NZetH2KNcgNHhxQfuTdfic
	TGsoUlTlCBiRacj7NcVt63I8+vjNk6FN7V3E/jPqoLnlh9ewusNPMUwkkU7W6tePjCKR9hXmJYXIh
	+JhLa8pf6Wx/M3on23T1DP4ZS+5UzhL/d26kPMkfalMBlhx0vWAjiQAYLmavLQu5Jwbb4tD4X+bC6
	6762wEug==;
Received: from [50.53.25.54] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ua0KA-0000000DEBV-3yjZ;
	Thu, 10 Jul 2025 23:05:07 +0000
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
Subject: [PATCH net-next] net: wangxun: fix VF drivers Kconfig dependencies and help text
Date: Thu, 10 Jul 2025 16:05:06 -0700
Message-ID: <20250710230506.3292079-1-rdunlap@infradead.org>
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
 drivers/net/ethernet/wangxun/Kconfig |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

--- linux-next-20250710.orig/drivers/net/ethernet/wangxun/Kconfig
+++ linux-next-20250710/drivers/net/ethernet/wangxun/Kconfig
@@ -66,35 +66,34 @@ config TXGBE
 
 config TXGBEVF
 	tristate "Wangxun(R) 10/25/40G Virtual Function Ethernet support"
-	depends on PCI
 	depends on PCI_MSI
+	depends on PTP_1588_CLOCK_OPTIONAL
 	select LIBWX
 	select PHYLINK
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

