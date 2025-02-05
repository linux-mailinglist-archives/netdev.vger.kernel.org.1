Return-Path: <netdev+bounces-163153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1060AA296F6
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 18:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BA0E3A5A94
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 17:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3571DDA18;
	Wed,  5 Feb 2025 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HHcL0D7e"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2733B4C76;
	Wed,  5 Feb 2025 17:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738775347; cv=none; b=WFGmJ2w9xrSIwznLOswfJnOmriLkG5AEQ5G5i5dds8imQ42+D3L/EmHqBgh4o4A+8sCFRxEd3GLY0WUxTEYXJwNxsYqjU3KMKC61qlcqOUXVdj6aHdfPyv14fu7kxjoVsTL0iJQ9wbwVFPbGWb+e84FAAr6wIcZtvm1TE6J4EK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738775347; c=relaxed/simple;
	bh=CbXagtJhrSGSS95bINrZ5cWssD3AwQsuc3B6gL6u2k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXeUk0WolvQbXuiq+foW5mDXwRWHLEsQJPHCLNo2HXjMbXA7A8rdDJRnfisXhbDpw4DuFvMFXDsss3klEi+Ch682tTK2Qdm+0neMSMcLQ4DCwhEq4Lm7YoLr3obvDbgCKqxGTIpadA/IL6lw1c4yOvdthrtkTerLoWmF2veQVb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HHcL0D7e; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5wOT3p+XzV1SocAEzl8vME7EDx+B302N3XwBDJwQTAw=; b=HHcL0D7eVudx5sZ9hoN8wpNrbI
	t4b0+DaMY/lTfTeq+vCdBwadnnwopZA99yGVHx3/OGzYQOnTmxaG1p3NKzw/esjxyrB9ydYL7ovmV
	MdI1fUeGPecHwBzGWYuWLR6PLvr2ovWboTs8+J/Urym3vnDNzAGn4QZ3CowwSyCtnRlQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tfitL-00BFNQ-QE; Wed, 05 Feb 2025 18:08:47 +0100
Date: Wed, 5 Feb 2025 18:08:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	dimitri.fedrau@liebherr.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/3] net: phy: Add helper for getting tx
 amplitude gain
Message-ID: <b28755b0-9104-4295-8cd3-508818445a4b@lunn.ch>
References: <20250204-dp83822-tx-swing-v3-0-9798e96500d9@liebherr.com>
 <20250204-dp83822-tx-swing-v3-2-9798e96500d9@liebherr.com>
 <Z6JUbW72_CqCY9Zq@shell.armlinux.org.uk>
 <20250205052218.GC3831@debian>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205052218.GC3831@debian>

On Wed, Feb 05, 2025 at 06:22:18AM +0100, Dimitri Fedrau wrote:
> Am Tue, Feb 04, 2025 at 05:54:53PM +0000 schrieb Russell King (Oracle):
> > On Tue, Feb 04, 2025 at 02:09:16PM +0100, Dimitri Fedrau via B4 Relay wrote:
> > >  #if IS_ENABLED(CONFIG_OF_MDIO)
> > > -static int phy_get_int_delay_property(struct device *dev, const char *name)
> > > +static int phy_get_u32_property(struct device *dev, const char *name)
> > >  {
> > >  	s32 int_delay;
> > >  	int ret;
> > > @@ -3108,7 +3108,7 @@ static int phy_get_int_delay_property(struct device *dev, const char *name)
> > >  	return int_delay;
> > 
> > Hmm. You're changing the name of this function from "int" to "u32", yet
> > it still returns "int".
> >
> 
> I just wanted to reuse code for retrieving the u32, I found
> phy_get_int_delay_property and renamed it. But the renaming from "int"
> to "u32" is wrong as you outlined.
> 
> > What range of values are you expecting to be returned by this function?
> > If it's the full range of u32 values, then that overlaps with the error
> > range returned by device_property_read_u32().
> >
> 
> Values are in percent, u8 would already be enough, so it wouldn't
> overlap with the error range.
> 
> > I'm wondering whether it would be better to follow the example set by
> > these device_* functions, and pass a pointer for the value to them, and
> > just have the return value indicating success/failure.
> >
> 
> I would prefer this, but this would mean changes in phy_get_internal_delay
> if we don't want to duplicate code, as phy_get_internal_delay relies on
> phy_get_int_delay_property and we change function parameters of
> phy_get_int_delay_property as you described. I would switch from
> static int phy_get_int_delay_property(struct device *dev, const char *name)
> to
> static int phy_get_u32_property(struct device *dev, const char *name, u32 *val)
> 
> Do you agree ?

This looks O.K. You should also rename the local variable int_delay.

Humm, that function has other issues.

static int phy_get_int_delay_property(struct device *dev, const char *name)
{
	s32 int_delay;
	int ret;

	ret = device_property_read_u32(dev, name, &int_delay);
	if (ret)
		return ret;

	return int_delay;
}

int_delay should really be a u32. if ret is not an error, there should
be a range check to ensure int_long actually fits in an s32, otherwise
-EINVAL, or maybe -ERANGE.

For delays, we never expect too much more than 2000ps, so no valid DT
blob should trigger issues here.

     Andrew

