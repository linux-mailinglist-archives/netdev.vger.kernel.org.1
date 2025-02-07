Return-Path: <netdev+bounces-163990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 372F2A2C3AF
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB17C188A7E0
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 13:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79951F63E8;
	Fri,  7 Feb 2025 13:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ikZHdtyb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED8F1F37C6;
	Fri,  7 Feb 2025 13:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738935180; cv=none; b=BdNS6QUZ1IZ/PlU/gdUSqEggyKCCq2HPley2dtkWxLqpyO9vGmF7wbL7RvcIwkadvoseXphazT1K38YVPaCO/D4gbYXuUnZqLVXGj2YurpKm7TUVeV0WDxkoTo0sOJr84KqdDDdGIG86MtMP9TuZEHeywwcmfVQy/iiZRL/AvW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738935180; c=relaxed/simple;
	bh=WFmNlRT/1piaJgm4c0NfJA8P9P62SmS6UdgYC76xKuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lk38cJ16Ey8FIinMe+8P/TJBLgRZIXuZZVPVOCRinveHpZ5g2JLjyr3lirPcz5+LPq9v0UZXetaJLaIld+i+Lmmrn7Vigp00UnhxzrPBE7SKycbYFOTZaQ+KU13X8TGMF7G8Ojh1RmGNFUXhw1rsJCxQt92PgNJ3tzaPLXtb380=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ikZHdtyb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7B6nKxsZ/sgpbYSbmczXl/HDAlWGMnjUjIEUqDEu3fE=; b=ikZHdtybyl/A4VFw2VkwQGYUTI
	I5VXMO2Dsq9C6j9NPVSnVHI8byHRtV/uaWU/t71xO8V9YWONlWrw4NkA31Qgj7jaXKhYUM+5sSJwd
	EGZH7ss/mH8O6TO7DqY00Yy1HTQRU6CUGICBH3CUAKUQ5s0GbwiSc7s9zIREc3Phv1Fs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tgOT6-00Br1x-S2; Fri, 07 Feb 2025 14:32:28 +0100
Date: Fri, 7 Feb 2025 14:32:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	David E Box <david.e.box@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Serge Semin <fancer.lancer@gmail.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v7 2/7] net: pcs: xpcs: re-initiate clause 37
 Auto-negotiation
Message-ID: <12e86fbe-9515-4b81-951c-8bf86e2939d6@lunn.ch>
References: <20250206131859.2960543-1-yong.liang.choong@linux.intel.com>
 <20250206131859.2960543-3-yong.liang.choong@linux.intel.com>
 <Z6TVmdCZeWerAZKP@shell.armlinux.org.uk>
 <564ede5d-9f53-40be-9305-63f63b384e15@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <564ede5d-9f53-40be-9305-63f63b384e15@linux.intel.com>

> Good point. I cannot find this scenario in the datasheet. Please allow me
> some time to test this scenario. I will update you with the results.

By data sheet, do you mean documentation from Synopsis, or is this an
internal document? Assuming the hardware engineers have not hacked up
the Synopsis IP too much, the Synopsis documentation is probably the
most accurate you have.

> > What about 1000BASE-X when AN is enabled or disabled and then switching
> > to SGMII?
> > 
> According to the datasheet, a soft reset is required.

Do you know if this is specific to Intels integration of the Synopsis
IP, or this is part of the core licensed IP?

We need to understand when we need a quirk because intel did something
odd, or it is part of the licensed IP and should happen for all
devices using the IP.

	Andrew

