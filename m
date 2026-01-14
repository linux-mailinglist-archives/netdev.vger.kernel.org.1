Return-Path: <netdev+bounces-249841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69ABAD1F0F0
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 14:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 880C830084E3
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 13:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1467439B4BC;
	Wed, 14 Jan 2026 13:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayuX/yIn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33FD39B4B3;
	Wed, 14 Jan 2026 13:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768396737; cv=none; b=O/kWySds6Wc6cMJBktm9N9E1/DejNERqincvNekASfbfHiBvgKRtkoF5NM3/ViZXncOmNdo/U150sjMc56HDCI6v7jewDTs8L697rP7v6CpKrAcmQc81TriJQoEUu7wlCS1g1HSpCoBM03CKHcu3c451ca5cTSMw7ibvPAUEjYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768396737; c=relaxed/simple;
	bh=GzNGsGiv+Dat6D0sdE8p2iGYKVBLSwgdtjTPkzDp6KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgP0HZmoo4kkLcirLOTLj2SWEdPw474GmZWevjrcHAwjtWHe0PlGqoVuTM7R+CevUOcAroEvd4bA4ZCwskeuIg1iJ3riOeJu/vLUdyfsun2EDMESf7y1NmgfzU2duKZcprT3ckaKbw9ak2sz6fLjMCTVUNi4XtFF9jfNs/IZmWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayuX/yIn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E64C19422;
	Wed, 14 Jan 2026 13:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768396736;
	bh=GzNGsGiv+Dat6D0sdE8p2iGYKVBLSwgdtjTPkzDp6KU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ayuX/yInGW/t2HtHRKGrsgyznv2o+2fOAGPkd0SpYjXtXQPdEbGCPnkGym489mU4Q
	 rWIQf3SEJf03N/1f4m31O9VsSL9IV0rQAjdhPGGfzKOgbDSynFuKuSMIeitLctFBSJ
	 eNcgXX7HHVaqOOs6m4CC7hYEpkg8qBpAUrW/S5Mgzbxi4LRIA4yujf4thdtsr1+cz7
	 t8JQKzcB+CUW1L60x/eZo47DBluELyYYH3dNfO6DqtG6sFcVzSqsLJxFiAccXLzfEl
	 hBXtogq3ulvLF4L+5mcUcRyIg59mcuNFHcf+h+cBx7QkLIcn2Nde9pOqKBAUW2r+Pv
	 PFHUFUdqJQWsQ==
Date: Wed, 14 Jan 2026 18:48:52 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Subject: Re: [PATCH v3 net-next 00/10] PHY polarity inversion via generic
 device tree properties
Message-ID: <aWeXvFcGNK5T6As9@vaman>
References: <20260111093940.975359-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260111093940.975359-1-vladimir.oltean@nxp.com>

On 11-01-26, 11:39, Vladimir Oltean wrote:
> Introduce "rx-polarity" and "tx-polarity" device tree properties.
> Convert two existing networking use cases - the EN8811H Ethernet PHY and
> the Mediatek LynxI PCS.
> 
> Requested merge strategy:
> Patches 1-5 through linux-phy


The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy_common_properties

for you to fetch changes up to e7556b59ba65179612bce3fa56bb53d1b4fb20db:

  phy: add phy_get_rx_polarity() and phy_get_tx_polarity() (2026-01-14 18:16:05 +0530)

----------------------------------------------------------------
phy common properties

Vladimir Oltean <vladimir.oltean@nxp.com> wrote:

Introduce "rx-polarity" and "tx-polarity" device tree properties with
Kunit tests

----------------------------------------------------------------
Vladimir Oltean (5):
      dt-bindings: phy: rename transmit-amplitude.yaml to phy-common-props.yaml
      dt-bindings: phy-common-props: create a reusable "protocol-names" definition
      dt-bindings: phy-common-props: ensure protocol-names are unique
      dt-bindings: phy-common-props: RX and TX lane polarity inversion
      phy: add phy_get_rx_polarity() and phy_get_tx_polarity()

 .../devicetree/bindings/phy/phy-common-props.yaml  | 157 ++++++++
 .../bindings/phy/transmit-amplitude.yaml           | 103 -----
 MAINTAINERS                                        |  10 +
 drivers/phy/Kconfig                                |  22 ++
 drivers/phy/Makefile                               |   2 +
 drivers/phy/phy-common-props-test.c                | 422 +++++++++++++++++++++
 drivers/phy/phy-common-props.c                     | 209 ++++++++++
 include/dt-bindings/phy/phy.h                      |   4 +
 include/linux/phy/phy-common-props.h               |  32 ++
 9 files changed, 858 insertions(+), 103 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-common-props.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/transmit-amplitude.yaml
 create mode 100644 drivers/phy/phy-common-props-test.c
 create mode 100644 drivers/phy/phy-common-props.c
 create mode 100644 include/linux/phy/phy-common-props.h

> linux-phy provides stable branch or tag to netdev
> patches 6-10 through netdev
> 
> v2 at:
> https://lore.kernel.org/netdev/20260103210403.438687-1-vladimir.oltean@nxp.com/
> Changes since v2:
> - fix bug with existing fwnode which is missing polarity properties.
>   This is supposed to return the default value, not an error. (thanks to
>   Bjørn Mork).
> - fix inconsistency between PHY_COMMON_PROPS and GENERIC_PHY_COMMON_PROPS
>   Kconfig options by using PHY_COMMON_PROPS everywhere (thanks to Bjørn
>   Mork).
> 
> v1 at:
> https://lore.kernel.org/netdev/20251122193341.332324-1-vladimir.oltean@nxp.com/
> Changes since v1:
> - API changes: split error code from returned value; introduce two new
>   helpers for simple driver cases
> - Add KUnit tests
> - Bug fixes in core code and in drivers
> - Defer XPCS patches for later (*)
> - Convert Mediatek LynxI PCS
> - Logical change: rx-polarity and tx-polarity refer to the currently
>   described block, and not necessarily to device pins
> - Apply Rob's feedback
> - Drop the "joint maintainership" idea.
> 
> (*) To simplify the generic XPCS driver, I've decided to make
> "tx-polarity" default to <PHY_POL_NORMAL>, rather than <PHY_POL_NORMAL>
> OR <PHY_POL_INVERT> for SJA1105. But in order to avoid breakage, it
> creates a hard dependency on this patch set being merged *first*:
> https://lore.kernel.org/netdev/20251118190530.580267-1-vladimir.oltean@nxp.com/
> so that the SJA1105 driver can provide an XPCS fwnode with the right
> polarity specified. All patches in context can be seen at:
> https://github.com/vladimiroltean/linux/tree/phy-polarity-inversion
> 
> Original cover letter:
> 
> Polarity inversion (described in patch 4/10) is a feature with at least
> 4 potential new users waiting for a generic description:
> - Horatiu Vultur with the lan966x SerDes
> - Daniel Golle with the MaxLinear GSW1xx switches
> - Bjørn Mork with the AN8811HB Ethernet PHY
> - Me with a custom SJA1105 board, switch which uses the DesignWare XPCS
> 
> I became interested in exploring the problem space because I was averse
> to the idea of adding vendor-specific device tree properties to describe
> a common need.
> 
> This set contains an implementation of a generic feature that should
> cater to all known needs that were identified during my documentation
> phase.
> 
> Apart from what is converted here, we also have the following, which I
> did not touch:
> - "st,px_rx_pol_inv" - its binding is a .txt file and I don't have time
>   for such a large detour to convert it to dtschema.
> - "st,pcie-tx-pol-inv" and "st,sata-tx-pol-inv" - these are defined in a
>   .txt schema but are not implemented in any driver. My verdict would be
>   "delete the properties" but again, I would prefer not introducing such
>   dependency to this series.
> 
> Vladimir Oltean (10):
>   dt-bindings: phy: rename transmit-amplitude.yaml to
>     phy-common-props.yaml
>   dt-bindings: phy-common-props: create a reusable "protocol-names"
>     definition
>   dt-bindings: phy-common-props: ensure protocol-names are unique
>   dt-bindings: phy-common-props: RX and TX lane polarity inversion
>   phy: add phy_get_rx_polarity() and phy_get_tx_polarity()
>   dt-bindings: net: airoha,en8811h: deprecate "airoha,pnswap-rx" and
>     "airoha,pnswap-tx"
>   net: phy: air_en8811h: deprecate "airoha,pnswap-rx" and
>     "airoha,pnswap-tx"
>   dt-bindings: net: pcs: mediatek,sgmiisys: deprecate "mediatek,pnswap"
>   net: pcs: pcs-mtk-lynxi: pass SGMIISYS OF node to PCS
>   net: pcs: pcs-mtk-lynxi: deprecate "mediatek,pnswap"
> 
>  .../bindings/net/airoha,en8811h.yaml          |  11 +-
>  .../bindings/net/pcs/mediatek,sgmiisys.yaml   |   7 +-
>  .../bindings/phy/phy-common-props.yaml        | 157 +++++++
>  .../bindings/phy/transmit-amplitude.yaml      | 103 -----
>  MAINTAINERS                                   |  10 +
>  drivers/net/dsa/mt7530-mdio.c                 |   4 +-
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c   |  19 +-
>  drivers/net/pcs/Kconfig                       |   1 +
>  drivers/net/pcs/pcs-mtk-lynxi.c               |  63 ++-
>  drivers/net/phy/Kconfig                       |   1 +
>  drivers/net/phy/air_en8811h.c                 |  53 ++-
>  drivers/phy/Kconfig                           |  22 +
>  drivers/phy/Makefile                          |   2 +
>  drivers/phy/phy-common-props-test.c           | 422 ++++++++++++++++++
>  drivers/phy/phy-common-props.c                | 209 +++++++++
>  include/dt-bindings/phy/phy.h                 |   4 +
>  include/linux/pcs/pcs-mtk-lynxi.h             |   5 +-
>  include/linux/phy/phy-common-props.h          |  32 ++
>  18 files changed, 979 insertions(+), 146 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-common-props.yaml
>  delete mode 100644 Documentation/devicetree/bindings/phy/transmit-amplitude.yaml
>  create mode 100644 drivers/phy/phy-common-props-test.c
>  create mode 100644 drivers/phy/phy-common-props.c
>  create mode 100644 include/linux/phy/phy-common-props.h
> 
> -- 
> 2.43.0

-- 
~Vinod

