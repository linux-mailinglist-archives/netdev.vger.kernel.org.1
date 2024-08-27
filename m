Return-Path: <netdev+bounces-122309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC056960A90
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0731C22C77
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 12:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56D51BCA19;
	Tue, 27 Aug 2024 12:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="h2WvBXlg"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B3919DF60;
	Tue, 27 Aug 2024 12:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724762098; cv=none; b=iCwpJwmK2qzdAhmpj28lzWKLAs1RudH8GvKKqmYcchQK0lwqo7+3fGdFF7AAKSb2NQzwFqfR0Za/ujUsI1iMwCkgtzDKlaiD598cIHMZKNovAGYnXNkg0csKRGb0riyK/JQOPoviiVygAgL4n7eC1VzTEM0S/zKAdRZVYolyc2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724762098; c=relaxed/simple;
	bh=vwi7FIOIBmwqApnPnjPtIjvisVwfbZJaVEzwJw67Aco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NiNKhS1IbV2e2cxzAW3Il1yf/khVxkd18ByuykgMgGfhRcABSNnb38GcM9VWHshO1eSAZ2uUDewYBoiPSfXM/A4QfJCETrCxyfAsCqtJ6taK5XRxIQ/79vDjKDk7crOvJC8V7pHQs9P+/Mn+WzfMblEXGGjjUz7KBUsvw+J8x/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=h2WvBXlg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nBB01xK7uCtUX4ALASTMlYsbWs/ZG0Uan6EVBQCEAig=; b=h2WvBXlgdV8t2zql2w/oc8ou+z
	tCREVkIEIre98M6j0+1Ynf53K97T5Bn9lhscis2oDjH8OdAoawKdB9ZUGueXFEdTv4knKvVrXCRkU
	TRhbaTY3duqCfOfC8S9uauPSpWoDv4arYY8y4v1jXjnWt2ed/nv4W49g2kzt9WWQn4cQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sivPJ-005odM-MO; Tue, 27 Aug 2024 14:34:45 +0200
Date: Tue, 27 Aug 2024 14:34:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: Rob Herring <robh@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"Andrei Botila (OSS)" <andrei.botila@oss.nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH v3 net-next 1/2] dt-bindings: net: tja11xx: add
 "nxp,phy-output-refclk" property
Message-ID: <25356e61-2e53-483f-916e-5a3685b5e108@lunn.ch>
References: <20240826052700.232453-1-wei.fang@nxp.com>
 <20240826052700.232453-2-wei.fang@nxp.com>
 <20240826154958.GA316598-robh@kernel.org>
 <PAXPR04MB8510228822AFFD8BD9F7414388942@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8510228822AFFD8BD9F7414388942@PAXPR04MB8510.eurprd04.prod.outlook.com>

> > This binding is completely broken. I challenge you to make it report any errors.
> > Those issues need to be addressed before you add more properties.
> > 
> Sorry, I'm not sure I fully understand what you mean, do you mean I need
> to move the "nxp,rmii-refclk-in" property out of the patternProperties?
> Just like below?
> +properties:
> +  nxp,rmii-refclk-in:
> +    type: boolean
> +    description: |
> +      The REF_CLK is provided for both transmitted and received data
> +      in RMII mode. This clock signal is provided by the PHY and is
> +      typically derived from an external 25MHz crystal. Alternatively,
> +      a 50MHz clock signal generated by an external oscillator can be
> +      connected to pin REF_CLK. A third option is to connect a 25MHz
> +      clock to pin CLK_IN_OUT. So, the REF_CLK should be configured
> +      as input or output according to the actual circuit connection.
> +      If present, indicates that the REF_CLK will be configured as
> +      interface reference clock input when RMII mode enabled.
> +      If not present, the REF_CLK will be configured as interface
> +      reference clock output when RMII mode enabled.
> +      Only supported on TJA1100 and TJA1101.
> 
> patternProperties:
>    "^ethernet-phy@[0-9a-f]+$":
> @@ -32,28 +71,6 @@ patternProperties:
>          description:
>            The ID number for the child PHY. Should be +1 of parent PHY.
> 
> -      nxp,rmii-refclk-in:
> -        type: boolean
> -        description: |
> -          The REF_CLK is provided for both transmitted and received data
> -          in RMII mode. This clock signal is provided by the PHY and is
> -          typically derived from an external 25MHz crystal. Alternatively,
> -          a 50MHz clock signal generated by an external oscillator can be
> -          connected to pin REF_CLK. A third option is to connect a 25MHz
> -          clock to pin CLK_IN_OUT. So, the REF_CLK should be configured
> -          as input or output according to the actual circuit connection.
> -          If present, indicates that the REF_CLK will be configured as
> -          interface reference clock input when RMII mode enabled.
> -          If not present, the REF_CLK will be configured as interface
> -          reference clock output when RMII mode enabled.
> -          Only supported on TJA1100 and TJA1101.
> 
> > If you want/need custom properties, then you must have a compatible string.
> > 
> I looked at the binding documentation of other PHYs and there doesn't seem to
> be any precedent for doing this. Is this a newly added dt-binding rule?
> 
> There is another question. For PHY, usually its compatible string is either
> "ethernet-phy-ieee802.3-c45" or "ethernet-phy-ieee802.3-c22". If I want to
> add a custom property to TJA11xx PHY, can I use these generic compatible
> strings? As shown below:

This is where we get into the differences between how the kernel
actually works, and how the tools work. The kernel does not need a
compatible, it reads the ID registers and uses that to load the
driver. You can optionally have a compatible with the contents of the
ID registers, and that will force the kernel to ignore the ID in the
hardware and load a specific driver.

The DT tools however require a compatible in order to match the node
in the blob to the binding in a .yaml file. Without the compatible,
the binding is not imposed, which is why you will never see an error.

So in the example, include a compatible, using the real ID.

For a real DT blob, you need to decide if you want to include a
compatible or not. The downside is that it forces the ID. It is not
unknown for board manufacturers to replace a PHY with another pin
compatible PHY. Without a compatible, the kernel will load the correct
driver, based on the ID. With a compatible it will keep using the same
driver, which is probably wrong for the hardware.

Does the PHY use the lower nibble to indicate the revision? Using a
compatible will also override the revision. So the driver cannot even
trust the revision if there is a compatible.

	Andrew

