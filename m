Return-Path: <netdev+bounces-223227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 169EBB5871E
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 00:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DADD18904AE
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 22:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FDA1F416A;
	Mon, 15 Sep 2025 22:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="r0+zydyp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043E636D;
	Mon, 15 Sep 2025 22:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757973640; cv=none; b=cz//SSa37xk9ZTPbbuqcjDqji1ctesZWclfCBft6bH5yqpIPBt+mkjVDZSiraLIH6Q8A6+mjpCUQyWNm13ttKaZP1LBg9rHO68i8Q5STpcfsAx8xtPWx42c0WzPr5THu3gE1a2qhcaGZ8rj14wJTY9Cp44wmdEcvdbl/pqgMKso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757973640; c=relaxed/simple;
	bh=F3ygx1XnJ0aZdXPNxPfZUVAlWymDtaNfcC9NQKmy9U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hi+cWmtv2xvyR+cmCi7XLxTr+n0bpduPJCwzU/VOpIbqnxZimaUfRti5uZjDvoZHz9VbxGZGsgc9xRj1mcAoKXkjpnPflAjHUMLo6EkAv2Ww+gjE162c0pkHY4wa4DTtiF2jhcUFy1SqkIlA2mwfqYkTatZoTyK6ZoupABITIJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=r0+zydyp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8z0EBcsd04kPxFgdwa+FQA4OvMZj0/Dz/kBOR+ssQSw=; b=r0+zydypdjMlbthRhc0mMesXij
	dM6h+gC9SDF6mIgxDOYrr/tj4X8u2dzC/KTIv4n8uFQszhFlxTPDN+fEKvxmtJf1d6/wV2vVtXBGK
	xMHSCyQ6GuuMdY55rUGoFIqhQXmnv0w3fTI6cSwKNN5+xVNdPVPkvYjiVD9ENn0f/dxg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uyHF9-008U8k-6s; Tue, 16 Sep 2025 00:00:15 +0200
Date: Tue, 16 Sep 2025 00:00:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
	Pascal Eberhard <pascal.eberhard@se.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: dsa: microchip: Set SPI as bus
 interface during reset for KSZ8463
Message-ID: <d7554ede-1405-4e93-8305-2085fbf38701@lunn.ch>
References: <20250912-ksz-strap-pins-v2-0-6d97270c6926@bootlin.com>
 <20250912-ksz-strap-pins-v2-3-6d97270c6926@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912-ksz-strap-pins-v2-3-6d97270c6926@bootlin.com>

On Fri, Sep 12, 2025 at 11:09:14AM +0200, Bastien Curutchet wrote:
> At reset, the KSZ8463 uses a strap-based configuration to set SPI as
> bus interface. SPI is the only bus supported by the driver. If the
> required pull-ups/pull-downs are missing (by mistake or by design to
> save power) the pins may float and the configuration can go wrong
> preventing any communication with the switch.
> 
> Introduce a ksz8463_configure_straps_spi() function called during the
> device reset. It relies on the 'strap-rxd*-gpios' OF properties and the
> 'reset' pinmux configuration to enforce SPI as bus interface.
> 
> Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>

Thanks for updating the commit messages, it is now a lot clearer why
this is needed.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

