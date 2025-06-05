Return-Path: <netdev+bounces-195256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4169ACF147
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 15:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141463AB553
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 13:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4ADC272E5F;
	Thu,  5 Jun 2025 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spmW2oJY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF88272E58;
	Thu,  5 Jun 2025 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749131467; cv=none; b=c3upx0cG50pvXqxh+eHVGdU2Yv2qlzuvX4Eg3zqcDu80GRTb0bXmsiha2pHDcwAVA+RMJTZqAqurNmnet0itSyKn73cwe7VZkyCfZHdu14SCQC0ZDFHD7HZE/iQZmjkJRb8QSVPWq0z4og9h+QkrvCUjZECbyzkKW4ntAMOAg64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749131467; c=relaxed/simple;
	bh=CUuDv5BSBC048vwcKZzVjZ0CdBHLj4lB/45Mq40wZ9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3aQI1WIs/9exK5gy+NHjxW+6xJO7Ib9I48YZccBw8tgYPLHWn6rGXLCOnO2sBmVRr+VwWROGcEVmnBA6679zHJMcIwXGUXCCrhhHDWh8WdNbqszpYoSXvC9mSEOUn+lyeBDpO9FOWhnOYMmO9yWKNYS/AtHjNnDzJD6yO6/qrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spmW2oJY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE6EC4CEE7;
	Thu,  5 Jun 2025 13:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749131467;
	bh=CUuDv5BSBC048vwcKZzVjZ0CdBHLj4lB/45Mq40wZ9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=spmW2oJYhmHVT6vzAJCUPszJlMtNr3RDNNOowltKcsHqmeZKjNhKkYyzJ5s21VFFz
	 uDsXKDJiw+gb8D3iHTdH312J70c4XKw329BUljiMDcEml+8P6xSp2/u0EDhBvCO0YD
	 bBesROG/7UCwVinKib+h4/dbJ2LaMELnZBtpOVy6ksw+n9/nRM0WtNKj68+lX0cHdw
	 g2dRbvyNtlKcH3IXDToknqmkMTGXc9t97E2T08b4kz1OYv+aHeYZ3yarjkhfzon4JD
	 e58ldComiU278MN2luD2aiLyFaTdJf1yGVgI3u003wK7AuMU1goATRHqCXYj4vW47+
	 DvsOPzCO+NxLQ==
Date: Thu, 5 Jun 2025 08:51:04 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Simon Horman <horms@kernel.org>, davem@davemloft.net,
	Paolo Abeni <pabeni@redhat.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>, devicetree@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	netdev@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [net-next v12 1/7] dt-bindings: net: Add MTIP L2 switch
 description
Message-ID: <174913146314.2458620.483188376722386147.robh@kernel.org>
References: <20250522075455.1723560-1-lukma@denx.de>
 <20250522075455.1723560-2-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522075455.1723560-2-lukma@denx.de>


On Thu, 22 May 2025 09:54:49 +0200, Lukasz Majewski wrote:
> This patch provides description of the MTIP L2 switch available in some
> NXP's SOCs - e.g. imx287.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
> 
> ---
> Changes for v2:
> - Rename the file to match exactly the compatible
>   (nxp,imx287-mtip-switch)
> 
> Changes for v3:
> - Remove '-' from const:'nxp,imx287-mtip-switch'
> - Use '^port@[12]+$' for port patternProperties
> - Drop status = "okay";
> - Provide proper indentation for 'example' binding (replace 8
>   spaces with 4 spaces)
> - Remove smsc,disable-energy-detect; property
> - Remove interrupt-parent and interrupts properties as not required
> - Remove #address-cells and #size-cells from required properties check
> - remove description from reg:
> - Add $ref: ethernet-switch.yaml#
> 
> Changes for v4:
> - Use $ref: ethernet-switch.yaml#/$defs/ethernet-ports and remove already
>   referenced properties
> - Rename file to nxp,imx28-mtip-switch.yaml
> 
> Changes for v5:
> - Provide proper description for 'ethernet-port' node
> 
> Changes for v6:
> - Proper usage of
>   $ref: ethernet-switch.yaml#/$defs/ethernet-ports/patternProperties
>   when specifying the 'ethernet-ports' property
> - Add description and check for interrupt-names property
> 
> Changes for v7:
> - Change switch interrupt name from 'mtipl2sw' to 'enet_switch'
> 
> Changes for v8:
> - None
> 
> Changes for v9:
> - Add GPIO_ACTIVE_LOW to reset-gpios mdio phandle
> 
> Changes for v10:
> - None
> 
> Changes for v11:
> - None
> 
> Changes for v12:
> - Remove 'label' from required properties
> - Move the reference to $ref: ethernet-switch.yaml#/$defs/ethernet-ports
>   the proper place (under 'allOf:')
> ---
>  .../bindings/net/nxp,imx28-mtip-switch.yaml   | 150 ++++++++++++++++++
>  1 file changed, 150 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


