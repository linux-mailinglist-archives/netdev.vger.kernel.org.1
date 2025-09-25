Return-Path: <netdev+bounces-226508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E5BBA1225
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 21:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6D41B26282
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 19:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C377531B81E;
	Thu, 25 Sep 2025 19:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="We+6+yHQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0AC2E7F17;
	Thu, 25 Sep 2025 19:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758827773; cv=none; b=QxlGI/KHGpt4LFneEJ9x6LQodWKxfXa0dxOsQ/ATzIUcMUHMg8evhrmPRL088bcZ7ZvvwS6us9g4J3h5nEQx76kk7YTDwkr1h/VplbIKyWw9D6sjYsDvFMZOU3nCu0DNRRMSVq/I0lfwelw6my7yNiFTBYkDHAR8xxaUUdl2b80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758827773; c=relaxed/simple;
	bh=LmXjoRO1EzhJd0oVq+AF4HxqnVPEE99/e7UvnoA+mZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YW842sB2VqKwogsq7f0GCu0vvI8WutWqeLClHUvIC+cZP7l7sTZY3VoBzEn16sxjB1eh2Sr8pM8uBNXIl7/CEuetiJG4Nxh6tfh+RBEw/TpSyhLfT4k+JpSF5Py2nSiWVNE2XkDhJv75Ecsmz9qXoMb3xRUR4aRAhhdTEz/JJ7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=We+6+yHQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC3F5C4AF0B;
	Thu, 25 Sep 2025 19:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758827773;
	bh=LmXjoRO1EzhJd0oVq+AF4HxqnVPEE99/e7UvnoA+mZw=;
	h=From:To:Cc:Subject:Date:From;
	b=We+6+yHQCriVASsWlyJx+3xqdTKBvD+fz+MeGQ0NsLN/Sjh+BFhbf0cdzi1LWkrMP
	 XW1iVLYKsRmDlQJg0hfq5OJC8/7cxCxxShMGoFgulyhZDiIkFWX92JpjlU56J/4Ovo
	 AbLji7YU/9aPSuuGC/N1Cjgy2HSzmGNs/uvz/RQO2MrAmpLLtbd7NEqokYztXF836E
	 qim5rFQG1uhf38wNLsMyKTewFB2NCuzoUmdVbBUVJxdNUza/zLDPCXIqM0ZgOjgGhN
	 K3bndyWvx+D9aDF950HQ61luah7hNIHPPXwFKqBSl93iV+sI9R7B484DhKHlKfjO/t
	 QeDLYSgiGkiDg==
Received: by wens.tw (Postfix, from userid 1000)
	id F369B5FCCB; Fri, 26 Sep 2025 03:16:09 +0800 (CST)
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
Subject: [PATCH net-next v8 0/2] net: stmmac: Add support for Allwinner A523 GMAC200
Date: Fri, 26 Sep 2025 03:15:57 +0800
Message-ID: <20250925191600.3306595-1-wens@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

Hi everyone,

This is v8 of my Allwinner A523 GMAC200 support series. This is based on
next-20250925.

This version only contains the DT binding and driver patches. The device
tree patches are basically the same as the previous version.


Changes since v7:
- Rebased onto next-20250925
- Split out only the patches for net-next
- Link to v7
  https://lore.kernel.org/all/20250923140247.2622602-1-wens@kernel.org/

Changes since v6:
- Collected acks for DT binding patch
- Rebased onto next-20250922
- Link to v6
  https://lore.kernel.org/all/20250913101349.3932677-1-wens@kernel.org/

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


Thanks
ChenYu

Chen-Yu Tsai (2):
  dt-bindings: net: sun8i-emac: Add A523 GMAC200 compatible
  net: stmmac: Add support for Allwinner A523 GMAC200

 .../net/allwinner,sun8i-a83t-emac.yaml        |  95 ++++++++++-
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  12 ++
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-sun55i.c    | 159 ++++++++++++++++++
 4 files changed, 265 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-sun55i.c

-- 
2.47.3


