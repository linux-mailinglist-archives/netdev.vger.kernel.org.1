Return-Path: <netdev+bounces-244653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B577CBC157
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 23:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 89EC13007ABC
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 22:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A51D31691B;
	Sun, 14 Dec 2025 22:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gMzyM24Q"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91038315D46;
	Sun, 14 Dec 2025 22:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765751890; cv=none; b=TyuEd7PXErQpgGv9HfBrVIOM3uw3XCazNPRqaoweu3PnXwX1S8U89eUwXUC9WZ55VRU4yvAHdtIPToqWG8JEZ211owN2oyOhDoM6sK/cfmprS5qTD3slUqVisjf4VLIDM8ih/+J44CPTODrP/2esgVc22Ws6VNhQ2XrWXKH6jbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765751890; c=relaxed/simple;
	bh=hUnCsdfZYi4nNO7gvICbYycbpKRDc5Tuzh1wu2Sd284=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxUDaIpAm35XsPxoTCMHHDPYo5DEIm9m1QJ462jDvA5mm+2Jm6c2Z+mQyYm+A89RqiD7tOtyQiCWZ1qaOR0Xe6We/+7DQpWwvBZqfXpuxD23GUri/U5sQOb986L23T+jkI7HKAdUKhPMIEtHYlM3bLHuIMgh5T2jg9ir5OxPCbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gMzyM24Q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=v0KaWitLNH8CPRvB1i62xqggSZjs16OVpLh8GECRSWs=; b=gMzyM24QaIAKZuw+bqykf8GWpg
	AadUEWdwJr15GepQ0xXgZACD5HYtru9Qvse1fc0LJvfmgvPISIA0x138pJWCGMouNrYSssTfFjgBl
	9u9SmDD3GtQXZKN2PKyZfKzudonanoWHk0/zmESJ0CUJ8Ygh338Am1Vj7aux7x/tBETg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vUuit-00Gwcf-H9; Sun, 14 Dec 2025 23:37:51 +0100
Date: Sun, 14 Dec 2025 23:37:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: jan.petrous@oss.nxp.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 4/4] stmmac: s32: enable multi irqs mode
Message-ID: <d1eba807-c45d-434f-b272-ed0841c728bf@lunn.ch>
References: <20251214-dwmac_multi_irq-v1-0-36562ab0e9f7@oss.nxp.com>
 <20251214-dwmac_multi_irq-v1-4-36562ab0e9f7@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251214-dwmac_multi_irq-v1-4-36562ab0e9f7@oss.nxp.com>

On Sun, Dec 14, 2025 at 11:15:40PM +0100, Jan Petrous via B4 Relay wrote:
> From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
> 
> Signalize support for multi irq mode.
> 
> >From now, if yoused old DT node, without channel IRQs set,
> the driver fails to init with the following error:
> 
> [4.925420] s32-dwmac 4033c000.ethernet eth0: stmmac_request_irq_multi_msi: alloc rx-0  MSI -6 (error: -22)

Sorry, but that is not acceptable. You cannot break old DT blobs.

Please reverse the logic. If you find all the needed properties in DT
enable STMMAC_FLAG_MULTI_MSI_EN. If none of the properties are there,
continue using one interrupt, and if only some of the needed
properties are there but some are missing, then you can error out with
EINVAL, because the DT blob is invalid.

	Andrew

