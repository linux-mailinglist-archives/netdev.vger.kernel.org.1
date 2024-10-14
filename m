Return-Path: <netdev+bounces-135200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4205399CBD7
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 15:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEE651F23E94
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 13:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEF91AAE1A;
	Mon, 14 Oct 2024 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qTSMvxyj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01DB1A76CF;
	Mon, 14 Oct 2024 13:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728913642; cv=none; b=DxzdOkv7fNVFkpy/EAAzY0CDx+rDalf1GyAJayuxFjpxyULHAAYpy1hBdjUpPERQGhicYJ5cR/L/vBzuU8MZ/fD5jb9W5Q9Lb3qw+R42u0ySi7i+rLVVyCy1zMblswaJkLBYBBK1bJ3FofhQ2KeAE0lu3fOoQEKChs4c9wljnAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728913642; c=relaxed/simple;
	bh=3OAOfemYJoqMDpLWwCsskLGBMLnb24Bl6yTaO9IqrGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ps6YSREfxU/ECrDeHWGwJSCYjlZ+dl+fewCZOkGylSOvKEXDCBI8XwRI1nx6rGOebofKob4NOiJhQH1c2aIHKB5497DEegLx8lIJFIDnftUJC0Q8BIkGS0267ddlHp1Nu8CdKOxSuQGz6joIneZNsRxX9QnLAJJsZkHqG7FfjnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qTSMvxyj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=i7uD83M8HdHBtttrAgqQuwu1eZyhNYan0ZXlz7wnjPo=; b=qTSMvxyjq/zqIukuaYJf0dKMyr
	/H6go9IP3ae/pnexIcgBVZTNNmJXT7De+nOgjcptF9AjcrisS7UoWZTw+X5jhS/PMeVc6K608qhty
	ryO3YMpeMn3vkutjVMTVFWDlE5Ec4kU0hEGaZN77vrwknZr5OGMozpGQC5B1J3irFqMI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t0LPU-009vjJ-Rj; Mon, 14 Oct 2024 15:46:56 +0200
Date: Mon, 14 Oct 2024 15:46:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: jan.petrous@oss.nxp.com
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vinod Koul <vkoul@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Minda Chen <minda.chen@starfivetech.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Iyappan Subramanian <iyappan@os.amperecomputing.com>,
	Keyur Chudgar <keyur@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>
Subject: Re: [PATCH v3 05/16] net: dwmac-dwc-qos-eth: Use helper rgmii_clock
Message-ID: <1f38695e-642d-41e5-bf95-d4a4c55e416b@lunn.ch>
References: <20241013-upstream_s32cc_gmac-v3-0-d84b5a67b930@oss.nxp.com>
 <20241013-upstream_s32cc_gmac-v3-5-d84b5a67b930@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241013-upstream_s32cc_gmac-v3-5-d84b5a67b930@oss.nxp.com>

On Sun, Oct 13, 2024 at 11:27:40PM +0200, Jan Petrous via B4 Relay wrote:
> From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
> 
> ???

It does need to say something. The change is also not 100% obviously
correct. So you could explain the change a bit.


    Andrew

---
pw-bot: cr

