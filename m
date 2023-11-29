Return-Path: <netdev+bounces-52183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 073387FDCF7
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 17:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FB01B20F12
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 16:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899FD3AC2E;
	Wed, 29 Nov 2023 16:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZD/Jf6I/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC538F
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 08:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NCgVhmlextkqZCmZNBM3m3oICSEvqY7UTDUOfuc4Stw=; b=ZD/Jf6I/fd6uNsOWEuTnZ3UyH9
	qzp9LI3BYDJCx5TBmZP12Irg3TjVNqEAqMsSc9ypEB9My1bF2kX7gOLpcU2V3tutQX6w+nbe18hRR
	UeFaXAi4rcB1XFXYYRugUS1dSx3qQG1biaFxTuKTprMJJ/jQsMge//c3YetGWckKlL2Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r8NOu-001aZf-9Y; Wed, 29 Nov 2023 17:27:00 +0100
Date: Wed, 29 Nov 2023 17:27:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev <netdev@vger.kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH RFC net-next 0/8] DSA LED infrastructure, mv88e6xxx and
 QCA8K
Message-ID: <d8dc6d95-df81-4a8c-b5dd-9f6589e7c555@lunn.ch>
References: <20231128232135.358638-1-andrew@lunn.ch>
 <20231129123819.zrm25eieeuxndr2r@skbuf>
 <a0f8aad6-badc-49dc-a6c2-32a7a3cee863@lunn.ch>
 <20231129154336.bm4nx2pwycufbejj@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129154336.bm4nx2pwycufbejj@skbuf>

On Wed, Nov 29, 2023 at 05:43:36PM +0200, Vladimir Oltean wrote:
> On Wed, Nov 29, 2023 at 04:13:00PM +0100, Andrew Lunn wrote:
> > O.K, i need to think about this.
> > 
> > What is not obvious to me at the moment is how we glue the bits
> > together. I don't want each DSA driver having to parse the DSA part of
> > the DT representation. So the DSA core needs to call into this library
> > while parsing the DT to create the LEDs. We also need an ops structure
> > in the DSA driver which this library can use. We then need to
> > associate the ops structure the driver has with the LEDs the DSA core
> > creates in the library. Maybe we can use ds->dev as a cookie.
> > 
> > Before i get too deep into code, i will post the basic API idea for a
> > quick review.
> 
> What is the DSA portion of the DT representation? I see "leds" goes
> under the generic ethernet-controller.yaml.

I agree the properties are well defined. The problem is finding them.

       switch@0 {
                compatible = "marvell,mv88e6085";
                #address-cells = <1>;
                #size-cells = <0>;
                reg = <0>;

                ports {
                        #address-cells = <1>;
                        #size-cells = <0>;

                        port@0 {
                                reg = <0>;
                                label = "lan4";

                                leds {
                                        #address-cells = <1>;
                                        #size-cells = <0>;

                                        led@0 {
                                                reg = <0>;
                                                color = <LED_COLOR_ID_WHITE>;
                                                function = LED_FUNCTION_LAN;
                                                label = "front";
                                                default-state = "keep";
                                        };
                                };
                        };

                        port@1 {
                                reg = <1>;
                                label = "lan3";

                                leds {
                                        #address-cells = <1>;
                                        #size-cells = <0>;

                                        led@0 {
                                                reg = <0>;
                                                color = <LED_COLOR_ID_WHITE>;
                                                function = LED_FUNCTION_LAN;
                                                label = "front";
                                                default-state = "keep";
                                        };
                                };
                        };


I don't want each DSA driver having to walk this tree to find the leds
node to pass it to a library to create the LEDs. We already have code
do to this walk in the DSA core. So one option would be the DSA core
does the call to the library as it performs the walk.

Now that i've looked at the code, the core does set dp->dn to point to
the port node. So setup_port() could do the call into the library to
create the LEDs, and pass it the ops structure. That seems clean, and
should avoid DSA core changes you don't like.

       Andrew

