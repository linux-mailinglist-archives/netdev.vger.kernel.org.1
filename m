Return-Path: <netdev+bounces-186038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FEFA9CDBE
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 18:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 994804A778F
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 16:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AF6189F20;
	Fri, 25 Apr 2025 16:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vYSTaGsA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81FC18A6A9
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 16:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745597089; cv=none; b=Fu0pwBBfOlTT3HR5usAj7v3i99r/h1Sj/wKysMvks0fWlgeeFq55IDziCCsIDRppxCbcBrslaBvmrgAiT8pnQppeTOiihNXEswzBvfRWxYdjQXm2K1ptLlzP5xIapot05IC5b8SDQRNdBc+WnQz6ULpC4t9RfW2qgrjg5p4Xm5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745597089; c=relaxed/simple;
	bh=bFKkUAXaNWSkDNCYQaIF8+v83gQhGChfc9UvcQ1DDSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbeOhjs9pnIeDAwD/f9BP55Nt5nUjazMsj7aibxbAwHAjSGY0ZmXUiAourmTqythLJ/3L0NF6DJmVtJ6ueVovwcRsTV8Pjyc/+QjgLYRNFu3NFnCtrJ+4BXGKSVywPQmMvRZ7X/qm7XbGMlN9wnwt18WiJNQ9nu4K+5PrinTI+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vYSTaGsA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=PRPGzrAgfjIrzGwHPFgdldBXNoaHoyZ2uoosewWRDHw=; b=vY
	STaGsAAwnD3Dms8wTcpvC6A4r4wnCIQSASpi1ckjVCKKf9Gi2sfLLBDeLSHCQ8n2Y88d1sL6BD+b/
	zaPJItfhXrn5A5Fi32q+gqnnv6s1GdO36AhUXy+B5Jx0UqHAdpjtHRCY2pZitgl+NaSOpqa6ahiCN
	rJFDWKyW/RU1iak=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u8LXf-00Aau1-DS; Fri, 25 Apr 2025 18:04:43 +0200
Date: Fri, 25 Apr 2025 18:04:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Matthias Schiffer <mschiffer@universe-factory.net>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Marek =?iso-8859-1?Q?Moj=EDk?= <marek.mojik@nic.cz>
Subject: Re: [PATCH net] net: dsa: qca8k: forbid management frames access to
 internal PHYs if another device is on the MDIO bus
Message-ID: <e4603452-efe9-4a56-b33d-4872a19a05b5@lunn.ch>
References: <20250425151309.30493-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250425151309.30493-1-kabel@kernel.org>

On Fri, Apr 25, 2025 at 05:13:09PM +0200, Marek Behún wrote:
> Completely forbid access to the internal switch PHYs via management
> frames if there is another MDIO device on the MDIO bus besides the QCA8K
> switch.
> 
> It seems that when internal PHYs are accessed via management frames,
> internally the switch core translates these requests to MDIO accesses
> and communicates with the internal PHYs via the MDIO bus. This
> communication leaks outside on the MDC and MDIO pins. If there is
> another PHY device connected on the MDIO bus besides the QCA8K switch,
> and the kernel tries to communicate with the PHY at the same time, the
> communication gets corrupted.
> 
> This makes the WAN PHY break on the Turris 1.x device.

Let me see if i understand the architecture correctly...

You have a host MDIO bus, which has both the QCA8K and a PHY on it.

Within the QCA8K there are a number of PHYs. Looking at qca8k-8xxx.c,
there is qca8k_mdio_write() and qca8k_mdio_read() which use a register
within the switch to access an MDIO bus for the internal PHYs. The
assumption is that the internal MDIO is isolated from the host MDIO
bus. That should be easy to prove, just read register 2 and 3 from all
32 addresses of the host MDIO bus, and make sure you don't find the
internal PHYs.

The issue is that when you use MDIO over Ethernet frames, both the
internal and external bus see the bus transaction. This happens
asynchronously to whatever the host MDIO bus driver is doing, and you
sometimes get collisions. This in theory should affect both the PHY
and the switch on the bus, but maybe because of the address being
accessed, you don't notice any issue with the switch?

The assumption is that the switch hardware interpreting the MDIO over
Ethernet is driving both the internal and external MDIO bus. Again,
this should be easy to prove, read ID registers 2 and 3 from the
address the external PHY is on, and see what you get.

I guess the real question here is, has it been proven that there are
actually two MDIO busses, not one bus with two masters? I could
theoretically see an architecture where the switch is not managed over
MDIO at all. It has an EEPROM to do sufficient configuration that you
can do all the management using Ethernet frames. The MDIO over
Ethernet then allow you to manage any external PHYs.

	 Andrew

