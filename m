Return-Path: <netdev+bounces-220553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B767B468CD
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 06:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25226A47FA4
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 04:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C76925D549;
	Sat,  6 Sep 2025 04:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8DfoL2V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7D025B2E7;
	Sat,  6 Sep 2025 04:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757132022; cv=none; b=K5H7VPbVWheNycOL4FOK/oe2ZpDa09pO0QM3sK2+udf3QGIihTEmnaUKkjj9BdkQs/d7zPjvkEdki86vASkhnhqrPzwTta7bNVEQ4zJbwC0LSy50jmVbgaC9L5AALqqqjhojlsLTZ9Nam0+71Y5pq8vuLt9fWlEOWv8rMF5qUpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757132022; c=relaxed/simple;
	bh=pZsznAm2SMqGYJIXqTcdP498nuZiiRx7/0gLlH051Ek=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t5YwcawsILeghZGtrOdHYyAmsmwaDueB2M62YdMcTcK1rrxbb9fDPFRWhvEPSnF1cBcQ0PnNH4sEIlQJW4RA3kHhM3gUPHJjAKlPq2XF5H34MrW3ecoqVW44caEThfeO7yk+llr6u8LvkDVFZVPvfJg78lrnyPUiw5QRfTZSFlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8DfoL2V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06F1C4AF09;
	Sat,  6 Sep 2025 04:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757132022;
	bh=pZsznAm2SMqGYJIXqTcdP498nuZiiRx7/0gLlH051Ek=;
	h=From:To:Cc:Subject:Date:From;
	b=D8DfoL2VccSScKeWtqa0X5vyIKAxbJCrAAkPn0WuSIOQ2FzrpcATqVPT8D9nEQKch
	 zwpktn+yJvfKgiLn6ukw6L7MnQ2j/LlOo7HuX5H8hY7fenn4EUBacc/MXztpraU1/W
	 nB69k044WU8dpKUjR9ezrKsIWTSJySeZgBQKkKvYSv3WXMWntRe1aSAyR0SAyA+JRJ
	 BDAtMztUAVBIgUyPJI2Bfjw+3Ph6xyWIFpdbqpPERJM+ao1zPn+gizCUd1EfqVwAJV
	 aC7qkNsb6/S9+iF8elsNEL8EzsvWlc/KJhcdvfSUJVGJRr820BIgwtNGxw/g8E5ra+
	 HqtHfbJIDNKaw==
Received: by wens.tw (Postfix, from userid 1000)
	id 8E3445FB93; Sat, 06 Sep 2025 12:13:38 +0800 (CST)
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
Subject: [PATCH net-next v3 00/10] net: stmmac: Add support for Allwinner A523 GMAC200
Date: Sat,  6 Sep 2025 12:13:23 +0800
Message-Id: <20250906041333.642483-1-wens@kernel.org>
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

This is v3 of my Allwinner A523 GMAC200 support series.

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

Patch 3 extends the sunxi SRAM driver to allow access to the clock delay
controls for the second Ethernet controller.

Patch 4 registers the special regmap for the clock delay controls as a
syscon. This allows the new network driver to use the syscon interface,
instead of the following dance which the existing dwmac-sun8i driver
does:

    of_parse_phandle();
    of_find_device_by_node();
    dev_get_regmap();

With this change in place we can also drop the above from the
dwmac-sun8i driver.

Patch 5 adds a device node and pinmux settings for the GMAC200.

Patches 6 and 8 add missing Ethernet PHY reset settings for the
already enabled controller.

Patches 7, 9, and 10 enable the GMAC200 on three boards. I only
have the Orangepi 4A, so I am asking for people to help test the
two other boards. The RX/TX clock delay settings were taken from
their respective BSPs, though those numbers don't always work, as
is was the case for the Orangepi 4A.


Please have a look and help test on the Avaota A1. I don't expect
any issues there though, since the PHY is always on, unlike on the
Cubie A5E.

Patches 1 and 2 should go through net-next, and I will take all the
other patches through the sunxi tree.


Thanks
ChenYu


Chen-Yu Tsai (10):
  dt-bindings: net: sun8i-emac: Add A523 GMAC200 compatible
  net: stmmac: Add support for Allwinner A523 GMAC200
  soc: sunxi: sram: add entry for a523
  soc: sunxi: sram: register regmap as syscon
  arm64: dts: allwinner: a523: Add GMAC200 ethernet controller
  arm64: dts: allwinner: a527: cubie-a5e: Add ethernet PHY reset setting
  arm64: dts: allwinner: a527: cubie-a5e: Enable second Ethernet port
  arm64: dts: allwinner: t527: avaota-a1: Add ethernet PHY reset setting
  arm64: dts: allwinner: t527: avaota-a1: enable second Ethernet port
  arm64: dts: allwinner: t527: orangepi-4a: Enable Ethernet port

 .../net/allwinner,sun8i-a83t-emac.yaml        |  96 ++++++++++-
 .../arm64/boot/dts/allwinner/sun55i-a523.dtsi |  55 ++++++
 .../dts/allwinner/sun55i-a527-cubie-a5e.dts   |  31 +++-
 .../dts/allwinner/sun55i-t527-avaota-a1.dts   |  29 +++-
 .../dts/allwinner/sun55i-t527-orangepi-4a.dts |  23 +++
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  12 ++
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-sun55i.c    | 159 ++++++++++++++++++
 drivers/soc/sunxi/sunxi_sram.c                |  14 ++
 9 files changed, 414 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-sun55i.c

-- 
2.39.5


