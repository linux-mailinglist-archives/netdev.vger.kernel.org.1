Return-Path: <netdev+bounces-47475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5E57EA607
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 23:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 253AD280D46
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 22:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9CF2E62F;
	Mon, 13 Nov 2023 22:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GboDRKk4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1B9249F5;
	Mon, 13 Nov 2023 22:23:35 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3FCD51;
	Mon, 13 Nov 2023 14:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/ixNTtee1tXYvFF1HyRnYYFOqNMAUcB4cs4QBlEVS/M=; b=GboDRKk4kb3umCCSjVG3Xt9gj8
	HgWsjqM2ZXPTJFb6elv/EJNCZtLddqLwBtk2Dj90A79FkaFf2uxUn+i9AcSatpv3fYii02QEJ0yFW
	sNX0ojw+5C53kjjfkSNo9P5eTQubyADwCHPX8kxpLq/y//mZjUktxDBhUAj0J9LpXpCc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r2fL5-0006pa-Sc; Mon, 13 Nov 2023 23:23:27 +0100
Date: Mon, 13 Nov 2023 23:23:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>, kuba@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH net-next] dt-bindings: net: snps,dwmac: Do not make
 'phy-mode' required
Message-ID: <22d3ed94-2c8b-4d7d-9c19-1ab13ee2c4a4@lunn.ch>
References: <20231113204052.43688-1-festevam@gmail.com>
 <43d176e2-d95f-40dd-8e42-8d7d5ed6492c@lunn.ch>
 <3acda2a2-3c99-4a14-ab68-ab166ce08194@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3acda2a2-3c99-4a14-ab68-ab166ce08194@gmail.com>

On Mon, Nov 13, 2023 at 02:03:00PM -0800, Florian Fainelli wrote:
> On 11/13/23 13:51, Andrew Lunn wrote:
> > On Mon, Nov 13, 2023 at 05:40:52PM -0300, Fabio Estevam wrote:
> > > From: Fabio Estevam <festevam@denx.de>
> > > 
> > > The property 'phy-connection-type' can also be used to describe
> > > the interface type between the Ethernet device and the Ethernet PHY
> > > device.
> > > 
> > > Mark 'phy-mode' as a non required property.
> > 
> > Hi Fabio
> > 
> > What does the driver actually require? Will it error out if neither is
> > provided?
> > 
> > Maybe we should be changing the condition that one or the other is
> > required?

Hi Florian

 
> 'phy-connection-type' is the deprecated version of 'phy-mode'

I thought that too, but
Documentation/devicetree/bindings/net/ethernet-controller.yaml does
not mark it deprecated.

The original .txt file has a different wording:

- phy-mode: string, operation mode of the PHY interface. This is now a de-facto
  standard property; supported values are:
  * "internal" (Internal means there is not a standard bus between the MAC and
     the PHY, something proprietary is being used to embed the PHY in the MAC.)
  * "mii"
  * "gmii"

- phy-connection-type: the same as "phy-mode" property but described in the
  Devicetree Specification;

So it could technically be we cannot deprecate phy-connection-type
because it is part of the standard, and we need to accept it.

> which
> of_get_phy_mode() will fall back to if 'phy-mode' is not provided. It does
> not appear that stmmac attempts to use anything other than of_get_phy_mode()
> therefore would not it be acceptable to update the relevant .dts file such
> that it uses 'phy-mode'?

Using phy-mode would be more consistent, since its used > 10x more
than phy-connection-type.

     Andrew

