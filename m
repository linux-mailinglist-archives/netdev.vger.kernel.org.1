Return-Path: <netdev+bounces-253090-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6H33C54QdWmAAQEAu9opvQ
	(envelope-from <netdev+bounces-253090-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 19:34:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEFD7E7B5
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 19:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F645300B991
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 18:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E7324BBE4;
	Sat, 24 Jan 2026 18:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="m5uHArx2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039CF24886A;
	Sat, 24 Jan 2026 18:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769279640; cv=none; b=ONXRKZyAYxGVG7Gc/S/ENrjYRAAYY1vrK/+eq9tv5Nt4lbyiP3qpsgZts7SiGXrA5jcf8j7v5eGUPWCe8id5m85hV0GxuNoJkuOti1ETvlMhrqrIHFacIG1Ly1LqrDfFoAn7oogK/4OiIIJPE3gQQLCPrCpaBg5N9UKaaWYrC+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769279640; c=relaxed/simple;
	bh=LT27Zz5H1RXf/pOf4bTDusrH+HIyDnw1xZZbsQ93xj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FyO17HOkas91IAC63BEVqFO670yKNcw4XnrQwpHos1J5tx4KtCvKttWljOImGJXxW68XG/SWN12QxDbgvEGztD3GjD9NbWbMvXwsXHAb9uIxqcyMkfQ2hKEJLgXq5CJu/neBNY9jyQwptfDBVOTA8rCHnAObsIJAd2sPt5VdM/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=m5uHArx2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=lvJ/FwmflJaqI6TuSx7rexnxY5p3MpWx5wlhrdmMcvI=; b=m5
	uHArx2SeT+Y73hMcH2DwRMSLY8CipN+PRupuBqSDwd1Yzd+0bDapgSVHlJOhL7H0ZTV4KNeDNCXQw
	UUKiffoQJbRvphwethkTShhFGGDOfdGIfSGpn7yziYeWyzoauxDrYUsvNKTGRhkkW6hRHZTejoAiX
	uao1aqohQ71anSc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vjiRv-004V3q-CM; Sat, 24 Jan 2026 19:33:31 +0100
Date: Sat, 24 Jan 2026 19:33:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: netdev@vger.kernel.org, "Lucien.Jheng" <lucienzx159@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] net: phy: air_en8811h: add Airoha
 AN8811HB support
Message-ID: <aff7a69c-e72f-4cb9-8fc5-6d8d1626ab4e@lunn.ch>
References: <20260123075817.1162068-1-bjorn@mork.no>
 <20260123075817.1162068-3-bjorn@mork.no>
 <4a3430cc-5a9a-414e-9dbf-cbc34c8fd019@lunn.ch>
 <87ecnfj6kw.fsf@miraculix.mork.no>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ecnfj6kw.fsf@miraculix.mork.no>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253090-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,makrotopia.org,nxp.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0AEFD7E7B5
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 05:53:03PM +0100, Bjørn Mork wrote:
> Andrew Lunn <andrew@lunn.ch> writes:
> 
> >> +#define AN8811HB_GPIO_OUTPUT		0x5cf8b8
> >> +#define   AN8811HB_GPIO_OUTPUT_345		(BIT(3) | BIT(4) | BIT(5))
> >
> >> +	/* Configure led gpio pins as output */
> >> +	ret = air_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
> >> +				      AN8811HB_GPIO_OUTPUT_345,
> >> +				      AN8811HB_GPIO_OUTPUT_345);
> >
> > The code/comment probably does not describe what is actually happening
> > here. My _guess_ is you are setting a pinmux, disconnecting the pins
> > from the GPIO controller and connecting them to the LED controller.
> 
> Possibly.  This code is copied from the out-of-tree vendor driver.  We
> already have similar code and comment in the en8811h probe:
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/tree/drivers/net/phy/air_en8811h.c#n959
> 
> The register addresses and layouts are suspiciously similar:
> 
> #define EN8811H_GPIO_OUTPUT		0xcf8b8
> #define   EN8811H_GPIO_OUTPUT_345		(BIT(3) | BIT(4) | BIT(5))
> 
> Without any docs, or a way to test this particular feature, I
> believe the safest option is to assume that the vendor driver is
> correct.  Can't start guessing no matter how tempting it is :-)

The writing of the value to the register is likely correct. I just
think all the names and comments are wrong.

Maybe using magic numbers in this case is actually better?

And describe the intent of the code in more general terms, allow the
pins to be used to driver LEDs.

> I have no other docs either.  The code is based solely on the vendor
> driver.  But trying to reuse as much as possible of the existing en8811h
> driver instead of duplicating it like the vendor did.

That is typical of vendors, and i agree with your strategy,.

> I have two almost identical boards with this phy connected to a Mediatek
> MT7988D SoC.  I can test, and have tested, the features exposed by those
> boards.  But this is obviously a limited test environment.  There are
> for example no port LEDs on any of the boards.

So you have no idea if the LEDs actualy blink with traffic, show link
state etc?

	Andrew

