Return-Path: <netdev+bounces-200391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D651EAE4CA6
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 20:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 724481671C3
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 18:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025872D3228;
	Mon, 23 Jun 2025 18:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cHljv3vo"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF7542065;
	Mon, 23 Jun 2025 18:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750702679; cv=none; b=JJDL/BQwuQlFHoHxqibGTZJFmcO4EtTv7SC8H2J8AhRNm2kv/h4TtET6nwOXJ4L4q8gzpzBu+qVj+Iu0EX47keoXB5G7mmuluvhlPdkhjtPstG6E2IazKZOOW6KIf20/YF4C0Q5zu7nmouuz/zeA1lVB074CgKv+iEAmkeNjZKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750702679; c=relaxed/simple;
	bh=pQ9xRt1uHICdtmFX8v/os4EaFlLgTRunRXJUAnYQyr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Erbz8377MFEoWRtUO6sfoXO4QpD1bfDYd5iE1LiFI6BS4+WudDfBDY3NF7FWcGm/U9z62fomjtrGEKE0K70vzgh/9LLlC58sr8v++ZHSc+7r5EM11ieUMDzxwntATIpEDleTzVAx+ZCpoguerr/fXvSjzRMRSpyAlLX1ZTE8E1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cHljv3vo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1GXg7W3rgF8fR8JO70MxOKUMa5ZEgyxSodhuCtreQpw=; b=cHljv3voGPO5Qi0Re3XTKw0TCJ
	TPyKQ7qu872qBE0SxetnMa0o6GrX6BSUi1CcXVUl160083GSvnceLn0pAJho/wmkEO+Yrl5HDgWp3
	DAoG/D+5D09ZyZHlRu3ql2jEYIrSkFKeHlteLMogRF71FDfo591/DrsWPuLrraPz5PPI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uTljk-00Gics-7N; Mon, 23 Jun 2025 20:17:44 +0200
Date: Mon, 23 Jun 2025 20:17:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Joy Zou <joy.zou@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de,
	catalin.marinas@arm.com, will@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, ulf.hansson@linaro.org,
	richardcochran@gmail.com, kernel@pengutronix.de, festevam@gmail.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-pm@vger.kernel.or, frank.li@nxp.com, ye.li@nxp.com,
	ping.bai@nxp.com, aisheng.dong@nxp.com
Subject: Re: [PATCH v6 5/9] arm64: dts: freescale: add i.MX91 11x11 EVK basic
 support
Message-ID: <8b5a8537-af16-46a1-b2ac-0374ed0f493a@lunn.ch>
References: <20250623095732.2139853-1-joy.zou@nxp.com>
 <20250623095732.2139853-6-joy.zou@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623095732.2139853-6-joy.zou@nxp.com>

> +&eqos {
> +	phy-handle = <&ethphy1>;
> +	phy-mode = "rgmii-id";
> +	pinctrl-0 = <&pinctrl_eqos>;
> +	pinctrl-1 = <&pinctrl_eqos_sleep>;
> +	pinctrl-names = "default", "sleep";
> +	status = "okay";
> +
> +	mdio {
> +		compatible = "snps,dwmac-mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clock-frequency = <5000000>;
> +
> +		ethphy1: ethernet-phy@1 {
> +			reg = <1>;
> +			realtek,clkout-disable;
> +		};
> +	};
> +};
> +
> +&fec {
> +	phy-handle = <&ethphy2>;
> +	phy-mode = "rgmii-id";
> +	pinctrl-0 = <&pinctrl_fec>;
> +	pinctrl-1 = <&pinctrl_fec_sleep>;
> +	pinctrl-names = "default", "sleep";
> +	fsl,magic-packet;
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clock-frequency = <5000000>;
> +
> +		ethphy2: ethernet-phy@2 {
> +			reg = <2>;
> +			eee-broken-1000t;
> +			realtek,clkout-disable;
> +		};

What is actually broken with EEE?  Is it actually the FEC?

	Andrew

