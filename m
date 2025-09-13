Return-Path: <netdev+bounces-222779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66329B56008
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 12:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6107C3B9EEF
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 10:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234A32EBB8A;
	Sat, 13 Sep 2025 10:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zgijsq1C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23C32E8B91;
	Sat, 13 Sep 2025 10:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757758436; cv=none; b=bJ40StrmG91wT1ehsvACdzEJMPp4NlDpeRmUOlOsuVDEQ4r3PGYYISPP7A3WEZg58ZrusKgdoFKUXzNaIU7qSxjJPZowzvtpABxtYbcyw6naVtEjsmhLw4eUtE0ltnl1DEJO7dM27szHiHWDhcb8PIac3qf35mEOwKfQaoW7O0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757758436; c=relaxed/simple;
	bh=gg+p2abigytfLpQ1USOCeccuZsakIO3PMSF9uUJcR1s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XMBUiMbJ3xxJgRDaLoxWpixEEpoQxwsw3Lt0CfdMgI9d/FLKX64TsOM20yPmIHJMh9KTy7B/TH7AZ6dq3J7Qs2bqifsouEhjwO5F/1viOQxIHOozvPBOpTAI4W8F9aXNZCEjaa+rQ2jHOjWRZfA4vt5FF6wmjVvk89dHP9A+cZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zgijsq1C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3DBC4AF09;
	Sat, 13 Sep 2025 10:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757758435;
	bh=gg+p2abigytfLpQ1USOCeccuZsakIO3PMSF9uUJcR1s=;
	h=From:To:Cc:Subject:Date:From;
	b=Zgijsq1Cqn9yxYRD5qy8CtpiSOZcIb1zSWbiIzKWWGmYz2rLhtjguTJc99ruFTCIO
	 SBIHbtOsBD0up1g9TcmacgHpwE82waWENv5ohjINdzI82hO9hLHuAxUFzuwaYFqMFy
	 XpPI7sYHR75Pt1lnBCiwhseRYtwHr4oKrwLFcAhlAjsJBcnn6+GgZFIDtbXs7l9aH2
	 IqU+qxrvAufsk0IEbkX29d/zeIWyNWzJEQyxKIpn7Gde3pg+xHnuvJRZOW2hpPEOVW
	 6giKh1xVV6Egj5zGWS1YOyVDeo1oI/WNEE9rYWAQo0b9WLYDUhV1X/B8+a/6RSBDcU
	 /xzRocsjmtJWw==
Received: by wens.tw (Postfix, from userid 1000)
	id 1D62A5FC8D; Sat, 13 Sep 2025 18:13:53 +0800 (CST)
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
Subject: [PATCH net-next v6 0/6] net: stmmac: Add support for Allwinner A523 GMAC200
Date: Sat, 13 Sep 2025 18:13:43 +0800
Message-Id: <20250913101349.3932677-1-wens@kernel.org>
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

This is v6 of my Allwinner A523 GMAC200 support series.

Changes since v5:
- Use plat->phy_interface instead of plat->mac_interface (Russell)
- Link to v5
  https://lore.kernel.org/all/20250911174032.3147192-1-wens@kernel.org/

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


