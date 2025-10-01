Return-Path: <netdev+bounces-227517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C1BBB1C8C
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 23:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22A1C2A22FB
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 21:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21A830EF81;
	Wed,  1 Oct 2025 21:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="vsa7/HwA"
X-Original-To: netdev@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C5A1EDA0E;
	Wed,  1 Oct 2025 21:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759353077; cv=none; b=SGTrbebCbZdaVwlZY5YYkMusKvZBoRQS7EfOPpTkPT566yAtmB/BSrC5fKjofTZQO7OViQObnhQ2GOlRUClt6BsA5FU/T7RdxigNNIc3/H9CD+PVCBHMeyWxvvbfDZyzHjTokAtDvzrgvnRxfMHML74bz2HcOIV7kqjTmCme4Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759353077; c=relaxed/simple;
	bh=DtQDevFoSt04iSsMW/iJhc0ExZPMJSGfdtsTL4hnWOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=le8LmyekMULXBNulCUwIGvU8Hqq1dIFkTMr9Csnum6dIwjRwPRrttp2uqT11Ap0/e5GBDhBBCOyVrfS9oIgJ3ICzlXjkEhi0T1Di/iZ6k7U0JxElWpaXVgxFFJB90ZNjQH7Hq3ObyTMV3fA6+vn8OEtnC3eoq0cA9zCbDYOrQd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=vsa7/HwA; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 6FA4C316;
	Wed,  1 Oct 2025 23:09:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1759352983;
	bh=DtQDevFoSt04iSsMW/iJhc0ExZPMJSGfdtsTL4hnWOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vsa7/HwAqyl5xjRWRovRZUTnpIz4rheVZUUzl5odP7t9SMgtVDSKYSfBZvHhmvyTA
	 Lk387NRoE5RNrEjJQEmCq7VP8171inACQ8JiqcYxmKbB4MQO+UvM/VxMZgsRScohl3
	 bQTuTUwHr04VlbyB3zxqhjl8jnrno76krLqRRxIc=
Date: Thu, 2 Oct 2025 00:11:07 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, linux-sound@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	imx@lists.linux.dev, Vladimir Oltean <olteanv@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
	David Jander <david@protonic.nl>,
	Lucas Stach <l.stach@pengutronix.de>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Fabio Estevam <festevam@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Mark Brown <broonie@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v3 0/3] Mainline Protonic PRT8ML board
Message-ID: <20251001211107.GC25098@pendragon.ideasonboard.com>
References: <20250924-imx8mp-prt8ml-v3-0-f498d7f71a94@pengutronix.de>
 <175876283065.3268812.10851892974485151512.robh@kernel.org>
 <3a0ba202-23e5-41d1-8b0c-5501a6d73bb4@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3a0ba202-23e5-41d1-8b0c-5501a6d73bb4@pengutronix.de>

On Thu, Sep 25, 2025 at 05:10:43PM +0200, Jonas Rebmann wrote:
> Hi,
> 
> Regarding the warnings:
> 
> On 2025-09-25 03:18, Rob Herring (Arm) wrote:
> > arch/arm64/boot/dts/freescale/imx8mp-prt8ml.dtb: codec@11 (asahi-kasei,ak4458): '#sound-dai-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
> > 	from schema $id: http://devicetree.org/schemas/sound/asahi-kasei,ak4458.yaml#
> 
> Updated bindings have already been applied to broonie/sound for-next.
> 
> > arch/arm64/boot/dts/freescale/imx8mp-prt8ml.dtb: isp@32e10000 (fsl,imx8mp-isp): 'power-domain-names' does not match any of the regexes: '^pinctrl-[0-9]+$'
> > 	from schema $id: http://devicetree.org/schemas/media/rockchip-isp1.yaml#
> > arch/arm64/boot/dts/freescale/imx8mp-prt8ml.dtb: isp@32e10000 (fsl,imx8mp-isp): power-domains: [[77, 6], [77, 1]] is too long
> > 	from schema $id: http://devicetree.org/schemas/media/rockchip-isp1.yaml#
> > arch/arm64/boot/dts/freescale/imx8mp-prt8ml.dtb: isp@32e20000 (fsl,imx8mp-isp): 'power-domain-names' does not match any of the regexes: '^pinctrl-[0-9]+$'
> > 	from schema $id: http://devicetree.org/schemas/media/rockchip-isp1.yaml#
> > arch/arm64/boot/dts/freescale/imx8mp-prt8ml.dtb: isp@32e20000 (fsl,imx8mp-isp): power-domains: [[77, 6], [77, 4]] is too long
> > 	from schema $id: http://devicetree.org/schemas/media/rockchip-isp1.yaml#
> 
> This is an issue in imx8mp.dtsi, introduced in commit 9c60bc7f10d0
> ("arm64: dts: imx8mp: Add pclk clock and second power domain for the
> ISP").

The corresponding changes for the DT bindings have been applied to the
linux-media tree and included in a pull request for v6.18 ([1]).

https://lore.kernel.org/all/20251001172511.2d0514ec@sal.lan/

-- 
Regards,

Laurent Pinchart

