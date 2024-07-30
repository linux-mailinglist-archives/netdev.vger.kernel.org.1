Return-Path: <netdev+bounces-114306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EAA94216F
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 22:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A84251C214E8
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 20:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC4F184553;
	Tue, 30 Jul 2024 20:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="j+skVosF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D841AA3DE;
	Tue, 30 Jul 2024 20:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722370579; cv=none; b=WwZ8z+WA+3uL18FsoXrlbPSbEu2btsSImqs/z0jnMi6OOg0Pls9mnRF2xcJrC6fsMpRySLQlPNRRX7iMILWy1HEIRkW6FpnlvEeiLmoz9bLCELn2Cj29d1pdga1zOMhmNV0iX/+zRAwqoan6jYk1EbLRN6on5Y1b2xMDDsV6udc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722370579; c=relaxed/simple;
	bh=SUJ8Wh+HYgY9gfQrI7HsX6tzocCOKfSvAWYXHyxOQNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ud00c8xwCuw0u1saMmD0pWxgiVRvx5l44CNZqLkWACwkOANYcQfSBAVOtTIm7t5R/HABeKx/NaQHg+0vrYaoKM1c5E637OUCHhAmQ4vLKVoK/JPTK3+/4C4ZD4eW7KVo4YGsxu1cowrAtTgg/cOA5d7cY+t4cA6ox5tdPSN1TVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=j+skVosF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=h4MMgFwf87QX+hHpaAgcSiLCtJ5yKMt5644D4G+2ry4=; b=j+skVosFVHalv3yCbW4oqRCjVZ
	EiQA4fVPIVmiLMRu5DO63WFg0cKZJa3SLSie5XMBfNMsdSMCXcl4uSKqyiXRHRzlfAOHpRcO6P7zc
	WyV0FWNGs6gi6j2iAcEVsoXiP+qazt5XAHjaL9Hxfc92yiVCcF2/+xCde6Mq09gO0Bx8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sYtGO-003btD-2j; Tue, 30 Jul 2024 22:16:04 +0200
Date: Tue, 30 Jul 2024 22:16:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Swathi K S <swathi.ks@samsung.com>
Cc: krzk@kernel.org, robh@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	conor+dt@kernel.org, richardcochran@gmail.com,
	mcoquelin.stm32@gmail.com, alim.akhtar@samsung.com,
	linux-fsd@tesla.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, alexandre.torgue@foss.st.com,
	peppe.cavallaro@st.com, joabreu@synopsys.com, rcsekar@samsung.com,
	ssiddha@tesla.com, jayati.sahu@samsung.com,
	pankaj.dubey@samsung.com, ravi.patel@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v4 3/4] arm64: dts: fsd: Add Ethernet support for FSYS0
 Block of FSD SoC
Message-ID: <1090d2c2-196f-4635-90a0-c73ded00cead@lunn.ch>
References: <20240730091648.72322-1-swathi.ks@samsung.com>
 <CGME20240730092907epcas5p1b81eaf13a57535e32e11709602aeee06@epcas5p1.samsung.com>
 <20240730091648.72322-4-swathi.ks@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730091648.72322-4-swathi.ks@samsung.com>

> +&ethernet_0 {
> +	status = "okay";
> +
> +	fixed-link {
> +		speed = <1000>;
> +		full-duplex;
> +	};
> +};
> +

What is the interface connected to? A switch?

	Andrew

