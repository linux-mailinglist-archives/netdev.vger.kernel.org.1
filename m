Return-Path: <netdev+bounces-224468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A00F1B855C3
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 16:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AD95560501
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 14:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9483F30CD9F;
	Thu, 18 Sep 2025 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+bu+Fpc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5466330CD83;
	Thu, 18 Sep 2025 14:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207021; cv=none; b=IZmSfoj34MAV3mYnpfji3iMlYAA9tUPy5vOaQRJ5lhN4Eo2VdGHYRNLoSDHBJFuegsullXdaDpLNarDv7eQkgb37ND4Pdq5QQlPszWTdwG/WvNJyX8Hc3Kze8kQNMLsJ+qN//G+kjJvpAubyqaB0WqpGuz6A8J9U58r4TKs0zwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207021; c=relaxed/simple;
	bh=EGsvc6/poxlYGOmwfkAkyjwqmGrwabohfckBDBt6qLU=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=MSGdVkZL7NfNsGCTvxqUeVtarwxxF1jhJOA/ajuYdd/oftMGpy7bKUDuPlBGor80flrKSVPRFM6TZCN4OLnyjYPgUznpw3Hhky1sp1Y+Q8fzoy3IlSpZ5CNX/Sa7UIZKoiN9516mrdlT0K0BWlGHrHaZolRUHbN/mIo0T3tdsgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+bu+Fpc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F47FC4CEFC;
	Thu, 18 Sep 2025 14:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758207020;
	bh=EGsvc6/poxlYGOmwfkAkyjwqmGrwabohfckBDBt6qLU=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=o+bu+FpcUsRQwpcYC/zXQMrb6yV0rewAe5nv6bCJ8jvkcQwdCwQkV7mQh9lhMXcPd
	 +wc+TLvcaWSi63IPrP0Vfv58sODRhE2ECtkvnqkAl1hV2A4LMWZfyhfrE388/dk63j
	 Sp7Igzr0wWoRS+5Dgp46WQYJJFO8SnaQjyQY7GcUbiLGpzgaifQqjcP2ubIfURyVRG
	 LhhlY36oyZNgifNpCzj2j+2M/RJUo7Jpxc/MYIB5WI6vz/SzLuk7mJFNxenBuM4kUE
	 CMIc2K31xXUaiCzMOZgXbBswj6svMZZRhOEZ+/JJjBuZZWKAt1ioJX8s7Z8Xg6KM8l
	 MW94YzqGNOSkQ==
Date: Thu, 18 Sep 2025 09:50:19 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
 "David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org, 
 Andrew Lunn <andrew@lunn.ch>, David Jander <david@protonic.nl>, 
 Lucas Stach <l.stach@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, 
 Paolo Abeni <pabeni@redhat.com>, Fabio Estevam <festevam@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, Eric Dumazet <edumazet@google.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, netdev@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>, 
 linux-sound@vger.kernel.org, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 linux-arm-kernel@lists.infradead.org
To: Jonas Rebmann <jre@pengutronix.de>
In-Reply-To: <20250918-imx8mp-prt8ml-v2-0-3d84b4fe53de@pengutronix.de>
References: <20250918-imx8mp-prt8ml-v2-0-3d84b4fe53de@pengutronix.de>
Message-Id: <175820686555.1653903.2952526182667328137.robh@kernel.org>
Subject: Re: [PATCH v2 0/3] Mainline Protonic PRT8ML board


On Thu, 18 Sep 2025 14:19:43 +0200, Jonas Rebmann wrote:
> This series adds the Protonic PRT8ML device tree as well as some minor
> corrections to the devicetree bindings used.
> 
> Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
> ---
> Changes in v2:
> - Dropped "ASoC: dt-bindings: asahi-kasei,ak4458: Reference common DAI
>   properties", applied to broonie/sound for-next (Thanks, Mark)
> - Updated description of the reset-gpios property in sja1105 binding to
>   address the issues of connecting this pin to GPIO (Thanks, Vladimir)
> - Added the fec, switch and phy for RJ45 onboard ethernet after
>   successful testing
> - Consistently use interrupts-extended
> - Link to v1: https://lore.kernel.org/r/20250910-imx8mp-prt8ml-v1-0-fd04aed15670@pengutronix.de
> 
> ---
> Jonas Rebmann (3):
>       dt-bindings: net: dsa: nxp,sja1105: Add reset-gpios property
>       dt-bindings: arm: fsl: Add Protonic PRT8ML
>       arm64: dts: add Protonic PRT8ML board
> 
>  Documentation/devicetree/bindings/arm/fsl.yaml     |   1 +
>  .../devicetree/bindings/net/dsa/nxp,sja1105.yaml   |   9 +
>  arch/arm64/boot/dts/freescale/Makefile             |   1 +
>  arch/arm64/boot/dts/freescale/imx8mp-prt8ml.dts    | 500 +++++++++++++++++++++
>  4 files changed, 511 insertions(+)
> ---
> base-commit: ea21fa34164c9ea0a2a5b8714c7e36f54c7fb46e
> change-id: 20250701-imx8mp-prt8ml-01be34684659
> 
> Best regards,
> --
> Jonas Rebmann <jre@pengutronix.de>
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: using specified base-commit ea21fa34164c9ea0a2a5b8714c7e36f54c7fb46e

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/freescale/' for 20250918-imx8mp-prt8ml-v2-0-3d84b4fe53de@pengutronix.de:

arch/arm64/boot/dts/freescale/imx8mp-prt8ml.dtb: codec@11 (asahi-kasei,ak4458): '#sound-dai-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/sound/asahi-kasei,ak4458.yaml#
arch/arm64/boot/dts/freescale/imx8mp-prt8ml.dtb: isp@32e10000 (fsl,imx8mp-isp): 'power-domain-names' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/media/rockchip-isp1.yaml#
arch/arm64/boot/dts/freescale/imx8mp-prt8ml.dtb: isp@32e10000 (fsl,imx8mp-isp): power-domains: [[77, 6], [77, 1]] is too long
	from schema $id: http://devicetree.org/schemas/media/rockchip-isp1.yaml#
arch/arm64/boot/dts/freescale/imx8mp-prt8ml.dtb: isp@32e20000 (fsl,imx8mp-isp): 'power-domain-names' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/media/rockchip-isp1.yaml#
arch/arm64/boot/dts/freescale/imx8mp-prt8ml.dtb: isp@32e20000 (fsl,imx8mp-isp): power-domains: [[77, 6], [77, 4]] is too long
	from schema $id: http://devicetree.org/schemas/media/rockchip-isp1.yaml#






