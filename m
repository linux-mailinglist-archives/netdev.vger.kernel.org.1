Return-Path: <netdev+bounces-97337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E51028CAE84
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 14:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 147641C213F0
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 12:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB81487BC;
	Tue, 21 May 2024 12:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WS0nnLue"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72632F5B;
	Tue, 21 May 2024 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716295695; cv=none; b=Yj93+ikYfDmTptvmNkCSBr84GoEX3arj1jMsG6JRche+EeuBH31B3jpxgx3DFRN4fgD2FVW+PCulkSWV5Qc85nSbIUHRY47HjHdRbsKYYy74ZF0F9eeaU3qp/VNKeLGlQppyTicRdJJx8YBbueNGs+SN63lOwI9ryCfxD2a9QHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716295695; c=relaxed/simple;
	bh=WH6yHvZe8ZnUhsEU59EABadEg8fdoJa3lZaDRDvNCIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHXM7nh0zHkBBgrcBlBnbvKNWOaLMyomSoRj/lbY4EnThABqdZ0d2WtdXzcx+fSWVAI7KVsOm/ocYR2rzgMesKTkAUT1VCVog3xHDpdAezk8XiSJH7XZtR+RP5xlKaOU6GkS2KpmqOIKLAHROX38wQxmZijw3cTAC+q/R1+m51k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WS0nnLue; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ubv672vfpBfLZf0g0gqsR9OC8qCCoIkzl2ciJouZUwg=; b=WS0nnLuevgRcN5fKDdqcjtMzBH
	WNi1Fp5E4puGALwTpiMuOEB1UGAN3YooKD6lYWKjiiaM7/3Uf3dGcDE+bIRVcXL5yuQFx/oIWOMPA
	V5Nv7PjFhaphyUCya/FcAUIm2X/iCUt0JJAGdOK6LsQQ9c3466KdaEVf/v2tdn5p0Z28=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s9OuJ-00Fl8b-QO; Tue, 21 May 2024 14:47:55 +0200
Date: Tue, 21 May 2024 14:47:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Larry Chiu <larry.chiu@realtek.com>
Cc: Justin Lai <justinlai0215@realtek.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"jiri@resnulli.us" <jiri@resnulli.us>,
	"horms@kernel.org" <horms@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH net-next v19 01/13] rtase: Add pci table supported in
 this module
Message-ID: <97e30c5f-1656-46d0-b06c-3607a90ec96f@lunn.ch>
References: <20240517075302.7653-1-justinlai0215@realtek.com>
 <20240517075302.7653-2-justinlai0215@realtek.com>
 <d840e007-c819-42df-bc71-536328d4f5d7@lunn.ch>
 <e5d7a77511f746bdb0b38b6174ef5de4@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5d7a77511f746bdb0b38b6174ef5de4@realtek.com>

On Tue, May 21, 2024 at 06:20:04AM +0000, Larry Chiu wrote:
> 
> >> + *  Below is a simplified block diagram of the chip and its relevant interfaces.
> >> + *
> >> + *               *************************
> >> + *               *                       *
> >> + *               *  CPU network device   *
> >> + *               *                       *
> >> + *               *   +-------------+     *
> >> + *               *   |  PCIE Host  |     *
> >> + *               ***********++************
> >> + *                          ||
> >> + *                         PCIE
> >> + *                          ||
> >> + *      ********************++**********************
> >> + *      *            | PCIE Endpoint |             *
> >> + *      *            +---------------+             *
> >> + *      *                | GMAC |                  *
> >> + *      *                +--++--+  Realtek         *
> >> + *      *                   ||     RTL90xx Series  *
> >> + *      *                   ||                     *
> >> + *      *     +-------------++----------------+    *
> >> + *      *     |           | MAC |             |    *
> >> + *      *     |           +-----+             |    *
> >> + *      *     |                               |    *
> >> + *      *     |     Ethernet Switch Core      |    *
> >> + *      *     |                               |    *
> >> + *      *     |   +-----+           +-----+   |    *
> >> + *      *     |   | MAC |...........| MAC |   |    *
> >> + *      *     +---+-----+-----------+-----+---+    *
> >> + *      *         | PHY |...........| PHY |        *
> >> + *      *         +--++-+           +--++-+        *
> >> + *      *************||****************||***********
> >> + *
> >> + *  The block of the Realtek RTL90xx series is our entire chip 
> >> + architecture,
> >> + *  the GMAC is connected to the switch core, and there is no PHY in between.
> >
> >Given this architecture, this driver cannot be used unless there is a switch driver as well. This driver is nearly ready to be merged. So what are your plans for the switch driver? Do you have a first version you can post? That will reassure us you do plan to release a switch driver, and not use a SDK in userspace.
> >
> >        Andrew
> 
> Hi Andrew,
> This GMAC is configured after the switch is boot-up and does not require a switch driver to work.

But if you cannot configure the switch, it is pointless passing the
switch packets. The Linux architecture is that Linux needs to be able
to control the switch somehow. There needs to be a driver with the
switchdev API on its upper side which connects it to the Linux network
stack. Ideally the lower side of this driver can directly write switch
registers. Alternatively it can make some sort of RPC to firmware
which configures the switch.

Before committing this MAC driver, we will want to be convinced there
is a switchdev driver for the switch.

	Andrew

