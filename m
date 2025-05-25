Return-Path: <netdev+bounces-193285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBF2AC36A2
	for <lists+netdev@lfdr.de>; Sun, 25 May 2025 21:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB355173CB4
	for <lists+netdev@lfdr.de>; Sun, 25 May 2025 19:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3509B25F784;
	Sun, 25 May 2025 19:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tRv8tElz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2B626AFB;
	Sun, 25 May 2025 19:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748202139; cv=none; b=Kx55bvU8SfBBapmwi8PF1yYLFSj62+vXIRFeNdDi98v38EaF9dc9nbi0Ev9wmtoZW7qhxpyPcA7KAVhmn15h406TqmBt6D2HpoxQuSHUXFpclHw0uwKZm2VAGaZLCJUWO95OAs9OYPDWA2K9QK2QSmFTewHN0VyF1UJQHU/dLZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748202139; c=relaxed/simple;
	bh=9hWHDBpeJtHOsbWUFyhWWQ8ys3+lcEzg/PZcy+7Dr3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPQu2/ETwRmNv1P84+imK10OhYR7+OnAdL35pxzgLZHnXfOCaq6uOIk1mxo9rfznbMTQZTfpMlJCQRTeLdP97qdP5WrBV9hmPWu1o2eyEID9O6SyZ6yz0ruoJeF9DSHA+N8/Najfmszdaock5pqdNyu499U6t8q+kzsiGjMELIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tRv8tElz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uMNeJr2TyJIxfy/QCHZd2896lqarzp8ruZrKjjxo/WQ=; b=tRv8tElz3u9eGmgkleJV/yI2qU
	9ck3euwBfQnLLOn5tQPjfnbFazHiCAkEgksYynl6/B7/PWb8BwQWXOCiwMCUHw985MciCM460B0Vc
	2vi21zoNY2ZwIypc/Lh3zAT2sIazMZpVi5swzuMGC48RWTSwcRa00cyMRxa1ShbjmWWw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uJHEU-00Dx4H-SA; Sun, 25 May 2025 21:42:06 +0200
Date: Sun, 25 May 2025 21:42:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: george.moussalem@outlook.com
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 3/5] net: phy: qcom: at803x: Add Qualcomm IPQ5018
 Internal PHY support
Message-ID: <40b427b8-b0d0-474b-a7c6-46641d1940b9@lunn.ch>
References: <20250525-ipq5018-ge-phy-v1-0-ddab8854e253@outlook.com>
 <20250525-ipq5018-ge-phy-v1-3-ddab8854e253@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250525-ipq5018-ge-phy-v1-3-ddab8854e253@outlook.com>

> +	phy_write_mmd(phydev, MDIO_MMD_PCS, IPQ5018_PHY_MMD3_AZ_CTRL1,
> +		      IPQ5018_PHY_MMD3_AZ_CTRL1_VAL);

Using MMD3 in the name is a good idea, but PCS would be better. Not
everybody knows MDIO_MMD_PCS == 3.
	
    Andrew

---
pw-bot: cr

