Return-Path: <netdev+bounces-169034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 125CCA42279
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 15:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FDAF7A7F1B
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 14:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580611917F1;
	Mon, 24 Feb 2025 14:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFfsv1Ow"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4F8191493;
	Mon, 24 Feb 2025 14:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405923; cv=none; b=clv6Z9htUEgF7kejIjL0CX0oiXsG9am9dJE1YSsnsa8K+7/uk58f06Te03DqlSZwj7bzoizqHRIBEs+MJYVSN2w0ykfBbszg9Or2E7CIgMhxx8dGlWsPQyD9KtBRuTFDwKHJmdc3EDvY6kBTOQw7gNywWLeDPpXOVmVDlR3ZA+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405923; c=relaxed/simple;
	bh=yaaa9DErqlOYGiiygCaNCc4wZLpOdhOh1CUotZF4UGo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rz1gJ5D0UBa6Qk7l2m1e3IDSc5TM9+hYhtIrrDddcoduQp3XhT6FLPM1p/cXSdvVoFoKO8QX2Z9db80PzKqxRLFTH4AYny1rx5a0H1CDO1eeNZBrnPL+0zQePm8snDgQKBbUZsPhTnEoctoJ30RF+aqF3QKzmFZMLNRAcDqq0Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFfsv1Ow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38532C4CEE6;
	Mon, 24 Feb 2025 14:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740405923;
	bh=yaaa9DErqlOYGiiygCaNCc4wZLpOdhOh1CUotZF4UGo=;
	h=From:To:Cc:Subject:Date:From;
	b=AFfsv1Owz3nA3xcFyVinBg8oGSoPrfQCtuFHU9NMmxE4MzSx92nI9Y9hhWG4urdLd
	 cJWR3y6nEXZemMBO1SxNoID4e3CbW7Gfl3yB81uuW4k5u7MIPZ2rsZc+9Bj27ljCG+
	 WKwHfaAixtdnK+u0grbFNNTu2c/tkpkbAuoaaD5njlIjkO31cQJM/xqLflqBx5tgOc
	 lh+HvfpOSxdLL8qoNfMzAo8LvzjC6RQpfRwUtW6OgwOU1NZR8+3dqw3xB9PjmBfGD9
	 COAKXHp2yejCCJcqd3g5qXqmT5NTLgU9ypaIqpKoePmb7B3w56zpYJeok6yPAjXjft
	 loFSHzf23v51w==
From: Arnd Bergmann <arnd@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: wangxun: fix LIBWX dependencies
Date: Mon, 24 Feb 2025 15:05:06 +0100
Message-Id: <20250224140516.1168214-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Selecting LIBWX requires that its dependencies are met first:

WARNING: unmet direct dependencies detected for LIBWX
  Depends on [m]: NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_WANGXUN [=y] && PTP_1588_CLOCK_OPTIONAL [=m]
  Selected by [y]:
  - TXGBE [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_WANGXUN [=y] && PCI [=y] && COMMON_CLK [=y] && I2C_DESIGNWARE_PLATFORM [=y]
ld.lld-21: error: undefined symbol: ptp_schedule_worker
>>> referenced by wx_ptp.c:747 (/home/arnd/arm-soc/drivers/net/ethernet/wangxun/libwx/wx_ptp.c:747)
>>>               drivers/net/ethernet/wangxun/libwx/wx_ptp.o:(wx_ptp_reset) in archive vmlinux.a

Add the smae dependency on PTP_1588_CLOCK_OPTIONAL to the two driver
using this library module.

Fixes: 06e75161b9d4 ("net: wangxun: Add support for PTP clock")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/wangxun/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/Kconfig b/drivers/net/ethernet/wangxun/Kconfig
index 6b60173fe1f5..47e3e8434b9e 100644
--- a/drivers/net/ethernet/wangxun/Kconfig
+++ b/drivers/net/ethernet/wangxun/Kconfig
@@ -26,6 +26,7 @@ config LIBWX
 config NGBE
 	tristate "Wangxun(R) GbE PCI Express adapters support"
 	depends on PCI
+	depends on PTP_1588_CLOCK_OPTIONAL
 	select LIBWX
 	select PHYLINK
 	help
@@ -43,6 +44,7 @@ config TXGBE
 	depends on PCI
 	depends on COMMON_CLK
 	depends on I2C_DESIGNWARE_PLATFORM
+	depends on PTP_1588_CLOCK_OPTIONAL
 	select MARVELL_10G_PHY
 	select REGMAP
 	select PHYLINK
-- 
2.39.5


