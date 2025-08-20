Return-Path: <netdev+bounces-215283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBC0B2DDF2
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 15:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 50CC54E54B3
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 13:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083562E426B;
	Wed, 20 Aug 2025 13:34:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15C32E2289;
	Wed, 20 Aug 2025 13:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755696867; cv=none; b=RplfNLjsvQ1VJqFRXs5dmwtdApkD1u+HkTek1wmwIPSUSZEPCkdY2bADsRAJNlTzY0ZJtRoioGAt1aX/doSN4vadrLf6I0AjcTVlLavsTq0k2KNv/hgwGfiAH2ZRba+HaLDSG/g3uIwst/uN3INQPint2urxYEDB6N38Wt84VEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755696867; c=relaxed/simple;
	bh=ecZ0orGxNAgtua+CAh5Rd3BWa+JxFXceOTCpgTfcjVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lv46VY/3X4lVE2Tk+FSe3HXDUxaGFpE7Nuih1It3cJ34oOca+joo0sY5sQjApL/VcGlK6Tqx3W1UGTgIKR2kY9EBhi53cBcee3UkpMPyzqul6ep7cTEVneQnHA5zburbQhqKkyCrD7r3TiXXAChKKhr0Rmm84mtFnxJutszwzR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uoixE-000000000Yt-239I;
	Wed, 20 Aug 2025 13:34:16 +0000
Date: Wed, 20 Aug 2025 14:34:07 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Xu Liang <lxu@maxlinear.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/3] net: phy: mxl-86110: add basic support
 for led_brightness_set op
Message-ID: <aKXOzyAg728qcylz@pidgin.makrotopia.org>
References: <a63f1487c3d36fc150fa3a920cd3ab19feb9b9f9.1755691622.git.daniel@makrotopia.org>
 <73c364ee-2712-4b95-a05b-886c3e4c4e15@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73c364ee-2712-4b95-a05b-886c3e4c4e15@lunn.ch>

On Wed, Aug 20, 2025 at 02:34:48PM +0200, Andrew Lunn wrote:
> > +# define MXL86110_COM_EXT_LED_GEN_CFG_LFM(x)		({ typeof(x) _x = (x); \
> > +							  GENMASK(1 + (3 * (_x)), \
> > +								 3 * (_x)); })
> 
> > +static int mxl86110_led_brightness_set(struct phy_device *phydev,
> > +				       u8 index, enum led_brightness value)
> > +{
> > +	u16 mask, set;
> > +	int ret;
> > +
> > +	if (index >= MXL86110_MAX_LEDS)
> > +		return -EINVAL;
> > +
> > +	/* force manual control */
> > +	set = MXL86110_COM_EXT_LED_GEN_CFG_LFE(index);
> > +	/* clear previous force mode */
> > +	mask = MXL86110_COM_EXT_LED_GEN_CFG_LFM(index);
> > +
> > +	/* force LED to be permanently on */
> > +	if (value != LED_OFF)
> > +		set |= MXL86110_COM_EXT_LED_GEN_CFG_LFME(index);
> 
> That is particularly complex. We know index is a u8, so why not
> GENMASK_U8(1 + 3 * index, 3 * index)? But set is a u16, so
> GENMASK_U16() would also be valid.

I chose this construct to avoid reusing the macro parameter as gcc would
rightously complain about that potentially having unexpected side-effects.

Eg.

#define FOO(a) ((a)+(a))

Now with var=10, when calling FOO(var++) the result will be 21 and
var will be equal to 12, which isn't intuitive without seeing the
macro definition.

Also using GENMASK_TYPE would not avoid the problem of macro
parameter reuse.

However, I agree that the macro itself is also weirdly complex and
confusing (but at the same time also very common, a quick grep reveals
hundreds of occurances of that pattern in Linux sources), so maybe we
should introduce some generic helpers for this (quite common) use-case?
I can do that, but I certainly can't take care of migrating all the
existing uses of this pattern to switch to the new helper.


