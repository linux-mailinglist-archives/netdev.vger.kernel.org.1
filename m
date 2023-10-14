Return-Path: <netdev+bounces-41009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5647C958A
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 19:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FEFE281F15
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 17:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A901B1A280;
	Sat, 14 Oct 2023 17:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DdUpjYB7"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3951C37;
	Sat, 14 Oct 2023 17:02:11 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B3BB7;
	Sat, 14 Oct 2023 10:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=a4JZARCX0Pv8VMrXuno0db3MocAdG6ErfH+YqMbuS/U=; b=DdUpjYB7WQU2xK11g8gcDXl6jI
	3fyUDr/ngjS2X/NwLJVATqMk2TX3T04y7ZxGE0caWTRWAG8bU1fB9lmMz4mHsxrVFPxYlknJ81Yml
	k0aaq31yg3gGf92qvc2Eoh7ERy79gRPn5GA9yRURmJckRL9x/xlyfXVioQCzynRzY11g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qri1U-002BoU-VE; Sat, 14 Oct 2023 19:01:56 +0200
Date: Sat, 14 Oct 2023 19:01:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/7] net: dsa: microchip: Set unique MAC at
 startup for WoL support
Message-ID: <d62d6c8d-9a18-473e-9773-2d6ae6eb0cc6@lunn.ch>
References: <20231013122405.3745475-1-o.rempel@pengutronix.de>
 <20231013122405.3745475-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013122405.3745475-3-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 02:24:00PM +0200, Oleksij Rempel wrote:
> Set a unique global MAC address for each switch on the network at system
> startup by syncing the switch's global MAC address with the Ethernet
> address of the DSA master interface. This is crucial for supporting
> Wake-on-LAN (WoL) functionality, as it requires a unique address for
> each switch.
> 
> Although the operation is performed only at system start and won't sync
> if the master Ethernet address changes dynamically, it lays the
> groundwork for WoL support by ensuring a unique MAC address for each
> switch.

I've not been following this patchset, so sorry if i make points
others have asked on earlier versions.

Maybe it would be good to add that the hardware only supports one MAC
address for all ports for WoL, and its this address. At least that is
my assumption.

> + * ksz_cmn_set_default_switch_mac_addr - Set the switch's global MAC address
> + *                                       from master port.

Florian is doing a search replace to make use of the word `conduit`. 


> @@ -3572,8 +3633,6 @@ static int ksz_switch_macaddr_get(struct dsa_switch *ds, int port,
>  	const unsigned char *addr = slave->dev_addr;

and this might need to change to user?


