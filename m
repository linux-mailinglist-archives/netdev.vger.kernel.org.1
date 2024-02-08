Return-Path: <netdev+bounces-70247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F5084E29C
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 14:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 757251C2705C
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 13:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBBA79941;
	Thu,  8 Feb 2024 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lRfpav/j"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DBD1E485;
	Thu,  8 Feb 2024 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707400608; cv=none; b=Us9ZvfUXtTMzjJHL4K0MM/ZLJbPa0ZhHKkfFGo0QwiBUWO+Wgv/Czo5F37RZIFU/hAPYiSMi9rJ6nlKrq9NwrmXejAjnnu+iTFsmaDHSBQjQgOe/nFffY96MxrlPK4DIa3p/18LhDnRhhFz3/d0unm+7JMzezxlbhOm7+xv+moU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707400608; c=relaxed/simple;
	bh=FuVF+eJ+3ABnfmzK4oUj76/6C587TcB1yKwdLXQapuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6HDQRRyRdmX+msf0TVLrKgQxO+3MRWfElsqN3jiducaj7Eu85n8Rk1DBfCh9dqKzrujRjIUbvKvez8hhrWw4G+MR6eF4wQsgvkUPZZvoOenZPvd/S+T7tyYk3MqFyLUBN0jlh1P22KKOYn74F8qhLhcOHTkQW4SbQtSL/CaDt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lRfpav/j; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Dej5H/0l4N8S9JwfsbANmrzhys6YFfTllssE9ozh6P8=; b=lRfpav/jSMFg7FFOHIB3QgRiKg
	atqKDwftQSwxyTcLW5pAccjMVhyraxElasRoopDU0yh6CnPTJq14ROx4k/LBhCQbsTn4FkqoEfGQf
	00huKYVp70PB4+jj8/qs2qNQoOu/TCmiqdDz2ZOpycZydLwL653u+ZTjx4YNCrJ6fHbc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rY4tF-007JSy-Kl; Thu, 08 Feb 2024 14:56:33 +0100
Date: Thu, 8 Feb 2024 14:56:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"afd@ti.com" <afd@ti.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>,
	"m.felsch@pengutronix.de" <m.felsch@pengutronix.de>
Subject: Re: [PATCH v2 2/2] net: phy: dp83826: support TX data voltage tuning
Message-ID: <145e1c28-af2b-4aca-9fd3-f9d7a272516c@lunn.ch>
References: <20240207175845.764775-1-catalin.popescu@leica-geosystems.com>
 <20240207175845.764775-2-catalin.popescu@leica-geosystems.com>
 <4dc382bd-3477-45cb-8044-fc5c2c7251f4@lunn.ch>
 <f37e9df4-e1bd-4d40-bd99-3998cfd803f4@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f37e9df4-e1bd-4d40-bd99-3998cfd803f4@leica-geosystems.com>

> > I could be reading this wrong, but it looks like
> > DP83826_CFG_DAC_MINUS_DEFAULT actually means leave the value
> > unchanged? Is there anything guaranteeing it does in fact have the
> > default value in the hardware?
> >
> >          Andrew
> 
> Yes, the datasheet clearly states the default/reset values of both 
> registers VOD_CFG1 & VOD_CFG2 which are :
> - cfg_dac_minus : 30h
> - cfg_dac_plus : 10h

And the device is actually and always reset by Linux when the driver
loads? Anything the bootloader has done, or a previous kernel, will be
cleared?

Please add this explanation to the commit message.

I'm being pedantic because we have had problems like this in the past.
If a register was not actually set back to the default value, the
bootloader set it to some other value, the board can work fine. Then a
board can came along which the bootloader set the wrong value, and the
default is actually needed. Fixing the driver to actually enforce the
default breaks boards...

	 Andrew

