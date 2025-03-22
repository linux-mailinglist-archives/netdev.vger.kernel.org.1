Return-Path: <netdev+bounces-176925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BEEA6CB2A
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 16:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E63F01887C53
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BBA22F3B8;
	Sat, 22 Mar 2025 15:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GSwE/MeU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073F61531C8;
	Sat, 22 Mar 2025 15:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742657349; cv=none; b=ByW7aK3mZH90YciP83qvAu/h1HjC8ceILTJcf5QTKeL6cleQ3mWW6TEMleoXwe/SYY/OlMcuc/ffyaJ+ycRYJjroKYS8bCONETOnOzcbTcgEZ/WqkEJOOCbOifZKUJ0K2nTKKMpIjGgGZUMg9xLUHZ6N/JbNwcvvMrbssdfIMC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742657349; c=relaxed/simple;
	bh=LX1DsUp4v2j/eiwibU3yVN9Ap65ACr+CkNOOgJvvI80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4NmjFPs/snAbfW6bA4JuERY7wulb/1TRuaDwICNBJ0NPpg7ZSs9vPxN2KcDTAshIMwDvOwRNCFlDQXZKO2l3hylY6vwQ9av3ha4wR6txRa1Taa7vzjnlpMsdXILIHE0vXwn8oNOLRBhisl4n65LLMceVQvNdmHSLiceh+keJco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GSwE/MeU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=F6DnPCoCwNoNSr0FXhPtLlu4rkM00mEhuf5ucwx1PcY=; b=GSwE/MeU9A3ANNnVLNzEWtwzhe
	b/US4Gz2qoOEuOy10s1SViRbA3OhvDr19oHsqR2y7mI6B/gnMYG3mu8t9ZtgWRpPPthhRYjo0A34k
	fLgiLW01Ma/T1LavEHLFlsuuO5ESVCH8KGv4ZuKYKdQ0NiW4SgYvSVnJdi6j2t/jex/8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tw0mN-006jYL-MG; Sat, 22 Mar 2025 16:28:55 +0100
Date: Sat, 22 Mar 2025 16:28:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Antoine Tenart <atenart@kernel.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Subject: Re: [PATCH net-next v4 1/2] net: phy: sfp: Add support for SMBus
 module access
Message-ID: <24cff763-8312-4502-9e86-b20883ad616b@lunn.ch>
References: <20250322075745.120831-1-maxime.chevallier@bootlin.com>
 <20250322075745.120831-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250322075745.120831-2-maxime.chevallier@bootlin.com>

On Sat, Mar 22, 2025 at 08:57:44AM +0100, Maxime Chevallier wrote:
> The SFP module's eeprom and internals are accessible through an i2c bus.
> 
> It is possible that the SFP might be connected to an SMBus-only
> controller, such as the one found in some PHY devices in the VSC85xx
> family.
> 
> Introduce a set of sfp read/write ops that are going to be used if the
> i2c bus is only capable of doing smbus byte accesses.
> 
> As Single-byte SMBus transaction go against SFF-8472 and breaks the
> atomicity for diagnostics data access, hwmon is disabled in the case
> of SMBus access.
> 
> Moreover, as this may cause other instabilities, print a warning at
> probe time to indicate that the setup may be unreliable because of the
> hardware design.
> 
> As hwmon may be disabled for both broken EEPROM and smbus, the warnings
> are udpated accordingly.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

