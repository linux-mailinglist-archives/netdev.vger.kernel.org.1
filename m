Return-Path: <netdev+bounces-245021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF683CC53A0
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 22:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CCBA3021066
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 21:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4485133BBD4;
	Tue, 16 Dec 2025 21:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oReVhJ71"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BEB327C1D;
	Tue, 16 Dec 2025 21:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765920954; cv=none; b=E+UFamZu5Vh9GpVOuUZMY8tx5h6k6CZAP9wHKE8KPg6z2iFVKqp+vjX2st7R2rpwE2YdVuGlTYLKH+V13PEtNOcSBdQgVHCTi1u7VU9hWQ9oKX8Te5fbHxPMGYJEYFAIn7ND8YQ1Xwmz/xXb+ET/YJcALNMabNFGD7abQFT7dlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765920954; c=relaxed/simple;
	bh=s6aCwhxLztnFKBlB7jWXe13ZQoGKruiuU4u1mhj4bhc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ssQbOqHEW0qQc1NQUBAhULjvpTvRsbEU3WsGiSmeLPvagUAUMRBtDG66cWEzpYyt0NyoiZrOWpkf+/0yhCNf3e0PKzeZNSeiXqmDizJNLHHOWcLbaoKe0F9YMRhXzlHjisVUaGSZjMSBtF7wAzeXPHHeKHSxBPqKLbGcParZ4hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oReVhJ71; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05D4C4CEF1;
	Tue, 16 Dec 2025 21:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765920953;
	bh=s6aCwhxLztnFKBlB7jWXe13ZQoGKruiuU4u1mhj4bhc=;
	h=From:To:Cc:Subject:Date:From;
	b=oReVhJ714nIFSND2Y0Bg0BTbgV/Zgqs3smnPh/YXzp1UjULy8+xMS9S7hWGqsoCAE
	 ASTATIEYmK50uHZMRcotayEII3QvdiIvLrHwIiQmvzxuI6vY7TKGBVm5F6eVXNG8OU
	 Faivdzge8HrH38CRk8Kvs0rxxYWAIyJpwyVE64D5ibncxD6PCXs+saFmLXtvsjrgIZ
	 f6HoIQk74KrjzdTrI3j0h7EbnUxiNgXEUmOn018ypOfpizz6jf9XhEaNjiosj7PSoD
	 9KXimDTw64klkF7zBlzQG2C4kaP5T0Ebn/bZQeBOr6ImRJXiY26C57S/k8HnqxIPHO
	 hjc0Y0pDykAsg==
From: Arnd Bergmann <arnd@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: wangxun: move PHYLINK dependency
Date: Tue, 16 Dec 2025 22:35:42 +0100
Message-Id: <20251216213547.115026-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The LIBWX library code is what calls into phylink, so any user of
it has to select CONFIG_PHYLINK at the moment, with NGBEVF missing this:

x86_64-linux-ld: drivers/net/ethernet/wangxun/libwx/wx_ethtool.o: in function `wx_nway_reset':
wx_ethtool.c:(.text+0x613): undefined reference to `phylink_ethtool_nway_reset'
x86_64-linux-ld: drivers/net/ethernet/wangxun/libwx/wx_ethtool.o: in function `wx_get_link_ksettings':
wx_ethtool.c:(.text+0x62b): undefined reference to `phylink_ethtool_ksettings_get'
x86_64-linux-ld: drivers/net/ethernet/wangxun/libwx/wx_ethtool.o: in function `wx_set_link_ksettings':
wx_ethtool.c:(.text+0x643): undefined reference to `phylink_ethtool_ksettings_set'
x86_64-linux-ld: drivers/net/ethernet/wangxun/libwx/wx_ethtool.o: in function `wx_get_pauseparam':
wx_ethtool.c:(.text+0x65b): undefined reference to `phylink_ethtool_get_pauseparam'
x86_64-linux-ld: drivers/net/ethernet/wangxun/libwx/wx_ethtool.o: in function `wx_set_pauseparam':
wx_ethtool.c:(.text+0x677): undefined reference to `phylink_ethtool_set_pauseparam'

Add the 'select PHYLINK' line in the libwx option directly so this will
always be enabled for all current and future wangxun drivers, and remove
the now duplicate lines.

Fixes: a0008a3658a3 ("net: wangxun: add ngbevf build")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/wangxun/Kconfig | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/Kconfig b/drivers/net/ethernet/wangxun/Kconfig
index d138dea7d208..ec278f99d295 100644
--- a/drivers/net/ethernet/wangxun/Kconfig
+++ b/drivers/net/ethernet/wangxun/Kconfig
@@ -21,6 +21,7 @@ config LIBWX
 	depends on PTP_1588_CLOCK_OPTIONAL
 	select PAGE_POOL
 	select DIMLIB
+	select PHYLINK
 	help
 	Common library for Wangxun(R) Ethernet drivers.
 
@@ -29,7 +30,6 @@ config NGBE
 	depends on PCI
 	depends on PTP_1588_CLOCK_OPTIONAL
 	select LIBWX
-	select PHYLINK
 	help
 	  This driver supports Wangxun(R) GbE PCI Express family of
 	  adapters.
@@ -48,7 +48,6 @@ config TXGBE
 	depends on PTP_1588_CLOCK_OPTIONAL
 	select MARVELL_10G_PHY
 	select REGMAP
-	select PHYLINK
 	select HWMON if TXGBE=y
 	select SFP
 	select GPIOLIB
@@ -71,7 +70,6 @@ config TXGBEVF
 	depends on PCI_MSI
 	depends on PTP_1588_CLOCK_OPTIONAL
 	select LIBWX
-	select PHYLINK
 	help
 	  This driver supports virtual functions for SP1000A, WX1820AL,
 	  WX5XXX, WX5XXXAL.
-- 
2.39.5


