Return-Path: <netdev+bounces-222241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A049BB53A86
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 19:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3DEF1BC7AB2
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 17:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7679F362081;
	Thu, 11 Sep 2025 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smNZawjv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF2035A2B9;
	Thu, 11 Sep 2025 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757612436; cv=none; b=kx6mmy522B4FUKNBgazQxniAOprsN0J2lMYtZ/MuKUh7NbUeFUkOILcyiwaSQTge1k+pe11wk7zdoxt7JYPRr776kgl4Bb3ZZ4tzWarYY8hXcUtDyw1hUEuBd+Q3tf5/Ky6m+yvo1NUfhFCjP31GwMEgASu8iAtB794ghh7ELgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757612436; c=relaxed/simple;
	bh=vYog93aVwPGcrQHrhdWWZg2csKqucpy1r2ESXP87NFo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s8Oow3nJzb6phYG1gkL13elAsI5Woo3MZFIEpXN3aN9sN9eGU9EiGo4ySJT1rF1ZDmnVBuKZEhgwtKOg79XFw/XxeB+L0t8QeabkbksEHuesoHAMYjf+kmhJs51d5huDG21ups1T8kU1AVJg4fMdcnMDGAOqRI9UIWuuGgr4izE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smNZawjv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC32BC4AF09;
	Thu, 11 Sep 2025 17:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757612435;
	bh=vYog93aVwPGcrQHrhdWWZg2csKqucpy1r2ESXP87NFo=;
	h=From:To:Cc:Subject:Date:From;
	b=smNZawjvOfWS5UEukIAynejXDJXcbQIJw9Mbp4xYb8+Vdyyr42apkGaojQ/AH1uz9
	 xqpjeVdLBpLL/lf++i4DTJOyxgQus/oXTFmopDHLVVh7Z7IE5KdzGiXOk3Wv25NG7N
	 ZWCnB4MEkMhQYVGCqGGhp/y5veG6LrHhB1VmZ3t/TC7BY5b2foO3EYsuWvcaK+02tZ
	 vpAyN8XKjbxrwMT9APNhkz5vjSdpFwA4nTxI2F4BVo8QCWWhv3LEsYYNBdJAIb5fvF
	 shSopGdcL/ocfCS0rWPtVlX8DJH8szOFZNuiWGkOL2uhi3489vNvdmLjoDX2e0CrSO
	 F/6r/MvzJH4dQ==
Received: by wens.tw (Postfix, from userid 1000)
	id 03E5A5FBFA; Fri, 12 Sep 2025 01:40:32 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH net-next v5 0/6] net: stmmac: Add support for Allwinner A523 GMAC200
Date: Fri, 12 Sep 2025 01:40:26 +0800
Message-Id: <20250911174032.3147192-1-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

Hi everyone,

This is v5 of my Allwinner A523 GMAC200 support series.

Changes since v4:
- Moved clock-names list to main schema in DT binding (Rob)
- Dropped 4 patches that are already merged
- Link to v4
  https://lore.kernel.org/all/20250908181059.1785605-1-wens@kernel.org/

Changes since v3:
- driver
  - Fixed printf format specifier warning
- Link to v3
  https://lore.kernel.org/all/20250906041333.642483-1-wens@kernel.org/

Changes since v2:
- DT binding
  - Added "select" to avoid matching against all dwmac entries
- driver
  - Include "ps" unit in "... must be multiple of ..." error message
  - Use FIELD_FIT to check if delay value is in range and FIELD_MAX to get
    the maximum value
  - Reword error message for delay value exceeding maximum
  - Drop MASK_TO_VAL
- Link to v2:
  https://lore.kernel.org/all/20250813145540.2577789-1-wens@kernel.org/

Changes since v1:
- Dropped RFT tag
- Switched to generic (tx|rx)-internal-delay-ps 
- dwmac-sun55i driver bits
  - Changed dev_err() + return to dev_err_probe()
  - Added check of return value from syscon regmap write
  - Changed driver name to match file name
- sram driver bits
  - Fixed check on return value
  - Expanded commit message
- dtsi
  - Fixed typo in tx-queues-config
- cubie a5e
  - Add PHY regulator delay
- Link to v1:
  https://lore.kernel.org/all/20250701165756.258356-1-wens@kernel.org/

This series adds support for the second Ethernet controller found on the
Allwinner A523 SoC family. This controller, dubbed GMAC200, is a DWMAC4
core with an integration layer around it. The integration layer is
similar to older Allwinner generations, but with an extra memory bus
gate and separate power domain.

Patch 1 adds a new compatible string combo to the existing Allwinner
EMAC binding.

Patch 2 adds a new driver for this core and integration combo.

Patch 3 adds a device node and pinmux settings for the GMAC200.

Patches 4, 5, and 6 enable the GMAC200 on three boards. I only tested
the Orangepi 4A and Radxa Cubie A5E.


Please have a look and help test on the Avaota A1. I don't expect
any issues there though, since the PHY is always on, unlike on the
Cubie A5E.

Patches 1 and 2 should go through net-next, and I will take all the
other patches through the sunxi tree. Hopefully we can get this merged
for v6.18.


Thanks
ChenYu

Chen-Yu Tsai (6):
  dt-bindings: net: sun8i-emac: Add A523 GMAC200 compatible
  net: stmmac: Add support for Allwinner A523 GMAC200
  arm64: dts: allwinner: a523: Add GMAC200 ethernet controller
  arm64: dts: allwinner: a527: cubie-a5e: Enable second Ethernet port
  arm64: dts: allwinner: t527: avaota-a1: enable second Ethernet port
  arm64: dts: allwinner: t527: orangepi-4a: Enable Ethernet port

 .../net/allwinner,sun8i-a83t-emac.yaml        |  95 ++++++++++-
 .../arm64/boot/dts/allwinner/sun55i-a523.dtsi |  55 ++++++
 .../dts/allwinner/sun55i-a527-cubie-a5e.dts   |  28 ++-
 .../dts/allwinner/sun55i-t527-avaota-a1.dts   |  26 ++-
 .../dts/allwinner/sun55i-t527-orangepi-4a.dts |  23 +++
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  12 ++
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-sun55i.c    | 159 ++++++++++++++++++
 8 files changed, 393 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-sun55i.c

-- 
2.39.5


