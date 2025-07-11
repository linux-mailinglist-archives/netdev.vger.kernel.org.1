Return-Path: <netdev+bounces-206091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9B4B015CE
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 10:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6922016F4F3
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 08:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F1C1D5ADC;
	Fri, 11 Jul 2025 08:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zhc5JWcy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD6A10E9;
	Fri, 11 Jul 2025 08:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752222225; cv=none; b=N/qJW17VUWkG4MzmetmnJqihqvJw55pTY20AglAWAB6zOveTOeoZeW5N/vdInpj2fiMosKvq1SsIgFq2UeYvB66MGCZY9uPcl6lIJmn+KDhkDuV8f1d6CroHQ6R5eWUD6haucC/K7qNYveTKY617DUjY7OdQVaVD5jbZFmFTDfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752222225; c=relaxed/simple;
	bh=d5N2pwASiyaWwDVUeAu0nyMy5rXmcg51QshWHV3PQso=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kEu0AiHdJaGbhKcmT4CXyy5x/I/pDMGh056IcaT7xzH/dmXMsie5px+mJJdilDbvZZwISrQtmHzWzrWo8ktWp8BBq53ZtJZQ8SCORBrndMiMzwiI0C9max/82jNaBIzkFvgN15pwc1R0nL7nAhHZci+lW/efHy2EQgAv33cfNwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zhc5JWcy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1481AC4CEED;
	Fri, 11 Jul 2025 08:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752222224;
	bh=d5N2pwASiyaWwDVUeAu0nyMy5rXmcg51QshWHV3PQso=;
	h=From:To:Cc:Subject:Date:From;
	b=Zhc5JWcys7XTBS0CBsqPcSU58cc3NI43qYAHQFDCM5nPLDfAvV0EIX1kjb6EIRNUM
	 QFxREoJmgNJnIP9CaaRTI1zKF6BDyXhPTnLKLAkmgv/PHv10PhtnnBXg5lsBuJRhwr
	 hB0u6JfYtb2IUcghvOTdedjCQGRCPnQWuLPZutJkqJqioONkhJOjlJy/lJMyy3JFVd
	 57nfNCIa+RJad8NCBcJTG52F94jmkavBI6NLUpy6sunrVURUY+qzAClSVbwYgicGq6
	 Ielv4IbOkD/CJ9O41JGlM3Y7BNbS1sKiNMpfeqSFECZAPmrR86tlQx1RjrduFg5Jpx
	 1HhKoelRXcTNA==
From: Arnd Bergmann <arnd@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: wangxun: fix LIBWX dependencies again
Date: Fri, 11 Jul 2025 10:23:34 +0200
Message-Id: <20250711082339.1372821-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Two more drivers got added that use LIBWX and cause a build warning

WARNING: unmet direct dependencies detected for LIBWX
  Depends on [m]: NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_WANGXUN [=y] && PTP_1588_CLOCK_OPTIONAL [=m]
  Selected by [y]:
  - NGBEVF [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_WANGXUN [=y] && PCI_MSI [=y]
  Selected by [m]:
  - NGBE [=m] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_WANGXUN [=y] && PCI [=y] && PTP_1588_CLOCK_OPTIONAL [=m]

ld: drivers/net/ethernet/wangxun/libwx/wx_lib.o: in function `wx_clean_tx_irq':
wx_lib.c:(.text+0x5a68): undefined reference to `ptp_schedule_worker'
ld: drivers/net/ethernet/wangxun/libwx/wx_ethtool.o: in function `wx_nway_reset':
wx_ethtool.c:(.text+0x880): undefined reference to `phylink_ethtool_nway_reset'

Add the same dependency on PTP_1588_CLOCK_OPTIONAL to the two driver
using this library module, following the pattern from commit
8fa19c2c69fb ("net: wangxun: fix LIBWX dependencies").

Fixes: 377d180bd71c ("net: wangxun: add txgbevf build")
Fixes: a0008a3658a3 ("net: wangxun: add ngbevf build")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/wangxun/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/Kconfig b/drivers/net/ethernet/wangxun/Kconfig
index c548f4e80565..424ec3212128 100644
--- a/drivers/net/ethernet/wangxun/Kconfig
+++ b/drivers/net/ethernet/wangxun/Kconfig
@@ -68,6 +68,7 @@ config TXGBEVF
 	tristate "Wangxun(R) 10/25/40G Virtual Function Ethernet support"
 	depends on PCI
 	depends on PCI_MSI
+	depends on PTP_1588_CLOCK_OPTIONAL
 	select LIBWX
 	select PHYLINK
 	help
@@ -85,6 +86,7 @@ config TXGBEVF
 config NGBEVF
 	tristate "Wangxun(R) GbE Virtual Function Ethernet support"
 	depends on PCI_MSI
+	depends on PTP_1588_CLOCK_OPTIONAL
 	select LIBWX
 	help
 	  This driver supports virtual functions for WX1860, WX1860AL.
-- 
2.39.5


