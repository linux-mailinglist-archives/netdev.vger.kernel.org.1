Return-Path: <netdev+bounces-214308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C105B28EBB
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 17:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B97BA1894637
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 15:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7202EBDCF;
	Sat, 16 Aug 2025 15:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bBX+Rk2K"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7CD634;
	Sat, 16 Aug 2025 15:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755356667; cv=none; b=CWY7KyYZ0C8x4cu8k6sM5a7ylEcuwyUCTk5Kwi5FK6s+Hkg7rVVn2Nx0XrOmlH4Oqbo4LZo3Q7XgUR/wLU/5OF6mi2oureE5WmdjNCLVnaHYXpxOOuyAFKyJhxsMH74XJ8db17yk9QuoACpWv3oHS+6fCo7WGkl3lhD4hHIDXDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755356667; c=relaxed/simple;
	bh=CZQ0MZgs7iA+U1IXKA1q9qrE+MeahDvGd+LUUNxs4q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7EM0hnRnQOtqY8EyybTAjwupDluq1Eq1ddnTBOnAZ8HhEhjlE6Mcu8gKt9+IDklrfeIhDvk5I5tMjEbmnoakycftlaTfCu/EjsrxlAPp660HCFvzSaj6IWRPKd2Ocs395fuzq9joqP9hmc+Zk62q8ZOvmI00MLTyzIlOTtbhNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bBX+Rk2K; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=n2sgIlUcAzPscDcOi8N90Jqt3pazwypfbRrISEI8r9E=; b=bBX+Rk2K5H6cfyBFafMLdc9yTR
	4riParkZoEBO+4KNUo3LSdK2MdYVjmsH3JNWhOBFnRMMdtvnbzSxg3pWmRv8bwSRkL2PPEoaRIA8h
	V4Ie2VdU7nvYgkdeYWxDdIja45xk6isEGIQPnhzsef5ejbO8i9JUbP7iXDVowFFl5u8s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1unIS4-004uW2-AF; Sat, 16 Aug 2025 17:04:12 +0200
Date: Sat, 16 Aug 2025 17:04:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Artur Rojek <contact@artur-rojek.eu>
Cc: Rob Landley <rob@landley.net>, Jeff Dionne <jeff@coresemi.io>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] net: j2: Introduce J-Core EMAC
Message-ID: <52aef275-0907-4510-b95c-b2b01738ce0b@lunn.ch>
References: <20250815194806.1202589-1-contact@artur-rojek.eu>
 <20250815194806.1202589-4-contact@artur-rojek.eu>
 <973c6f96-6020-43e0-a7cf-9c129611da13@lunn.ch>
 <b1a9b50471d80d51691dfbe1c0dbe6fb@artur-rojek.eu>
 <02ce17e8f00955bab53194a366b9a542@artur-rojek.eu>
 <fc6ed96e-2bab-4f2f-9479-32a895b9b1b2@lunn.ch>
 <7a4154eef1cd243e30953d3423e97ab1@artur-rojek.eu>
 <ee607928-1845-47aa-90a1-6511decda49d@lunn.ch>
 <9eab7a4ff3a72117a1a832b87425130f@artur-rojek.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9eab7a4ff3a72117a1a832b87425130f@artur-rojek.eu>

On Sat, Aug 16, 2025 at 03:40:57PM +0200, Artur Rojek wrote:
> On 2025-08-16 02:18, Andrew Lunn wrote:
> > > Yes, it's an IC+ IP101ALF 10/100 Ethernet PHY [1]. It does have both
> > > MDC
> > > and MDIO pins connected, however I suspect that nothing really
> > > configures it, and it simply runs on default register values (which
> > > allow for valid operation in 100Mb/s mode, it seems). I doubt there is
> > > another IP core to handle MDIO, as this SoC design is optimized for
> > > minimal utilization of FPGA blocks. Does it make sense to you that a
> > > MAC
> > > could run without any access to an MDIO bus?
> > 
> > It can work like that. You will likely have problems if the link ever
> > negotiates 10Mbps or 100Mbps half duplex. You generally need to change
> > something in the MAC to support different speeds and duplex. Without
> > being able to talk to the PHY over MDIO you have no idea what it has
> > negotiated with the link peer.
> 
> Thanks for the explanation. I just confirmed that there is no activity
> on the MDIO bus from board power on, up to the jcore_emac driver start
> (and past it), so most likely this SoC design does not provide any
> management interface between MAC and PHY. I guess once/if MDIO is
> implemented, we can distinguish between IP core revision compatibles,
> and properly switch between netif_carrier_*()/phylink logic.

How cut down of a SoC design is it? Is there pinmux and each pin can
also be used for GPIO? Linux has software bit-banging MDIO, if you can
make the two pins be standard Linux GPIOs, and can configure them
correctly, i _think_ open drain on MDIO. It will be slow, but it
works, and it is pretty much for free.

MDIO itself is simple, just a big shift register:

https://opencores.org/websvn/filedetails?repname=ethmac10g&path=%2Fethmac10g%2Ftrunk%2Frtl%2Fverilog%2Fmgmt%2Fmdio.v

	Andrew

