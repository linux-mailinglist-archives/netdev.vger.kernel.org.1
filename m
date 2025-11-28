Return-Path: <netdev+bounces-242622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B01CBC9303E
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 20:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5982C34A6EF
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 19:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D9C2D028A;
	Fri, 28 Nov 2025 19:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="asesjAZ6"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296E82080C8;
	Fri, 28 Nov 2025 19:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764357996; cv=none; b=Ay8tTKEyPDX35FG4jsPAvk+G2XSIpMyHaODnoVrcPm881V03EvMWhHq1ML6RCkiItQd1AZ99tEHE2ndApgYM+2CTB4rvOkkU+XQlgF43/c22UlAys0vD1aEoW2VTFNsNTpIY6Lt4pTJQJecngWXtnyVdFJx0sS/AktcOl9FYpec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764357996; c=relaxed/simple;
	bh=wsLty4558IcWAuYak+0JkFXUYqz3wMTN5pKxMgjFYYk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sYRZ0HeKwzZ88Jfdo6rG+rvcei1Y3/GUX7jcgTDIxIj1VIF85R3tmCwuOXMX478grh2ugW3jf1/ffU94XffKiM8HUCvD9F2uuQTBonloRzYLHtmPeIB43Nbgff5tE+P48xcUxt+1lA4Qxw/UL/5qYk4mqPFXxylZYWefVrwprUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=asesjAZ6; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight@runbox.com>)
	id 1vP46k-00Gl1T-19; Fri, 28 Nov 2025 20:26:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date;
	bh=mZASgNkMZf/HcfkTvdM83NcSdNPeP+6tXkbIUOeNCPQ=; b=asesjAZ6MiGFlqbcKUmZjXncMu
	MpWIMDhHrOaJ3rEku5gIFIT1m+HxDPV7lN6MU/iBycJ42IE6RujepamsJk3NogcOup89xC1EUXHcn
	EgXWrEcvkDH1BB6FT5Zlpu52QIQenTDjFLKPHJDPLgHuzKpHTLBpoeoIvjlQXD5E7A15krscqr4Ze
	EBmz7ReNJ7XeanQPcZi6d1ykcTzPbzGSMn5a/3JopMREXMOL62D47Z3bfhQVf8bVPP5G4eMtXwQnp
	jRes33g5OStKXQDDVKwGoy45Nnf9r9sgXLRPX7D02XsnYdeWLqHMHkLN3Pk9yc7Q5rbKWkYZGEq1C
	k0PcD5HQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight@runbox.com>)
	id 1vP46i-0005Q6-1a; Fri, 28 Nov 2025 20:26:16 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vP46S-001JQb-Eq; Fri, 28 Nov 2025 20:26:00 +0100
Date: Fri, 28 Nov 2025 19:25:58 +0000
From: david laight <david.laight@runbox.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org, Andrew Lunn
 <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/4] net: dsa: yt921x: Use *_ULL bitfield
 macros for VLAN_CTRL
Message-ID: <20251128192558.76f7ca56@pumpkin>
In-Reply-To: <aSmK1T4maiYysTZ0@shell.armlinux.org.uk>
References: <20251126093240.2853294-1-mmyangfl@gmail.com>
	<20251126093240.2853294-2-mmyangfl@gmail.com>
	<20251128105141.50188c6f@pumpkin>
	<aSmK1T4maiYysTZ0@shell.armlinux.org.uk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Nov 2025 11:43:17 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Fri, Nov 28, 2025 at 10:51:41AM +0000, david laight wrote:
> > On Wed, 26 Nov 2025 17:32:34 +0800
> > David Yang <mmyangfl@gmail.com> wrote:
> >   
> > > VLAN_CTRL should be treated as a 64-bit register. GENMASK and BIT
> > > macros use unsigned long as the underlying type, which will result in a
> > > build error on architectures where sizeof(long) == 4.  
> > 
> > I suspect GENMASK() should generate u32 or u64 depending on the value
> > of a constant 'high bit'.  
> 
> I suggest checking before making such statements to save embarrasment.
> The above is incorrect.

Is was a suggestion about what it would be a good idea for it to do,
not a statement about what it actually does.
I know GENMASK() generates 'unsigned long'.
The problem is that (as here) if the value is larger than u32 you get
a build error on 32bit,
Then you get the opposite problem that any portable code has to handle
the fact that the result type is (effectively) u64 on 64bit so
you get unwanted (or just unnecessary) integer promotions where the
result is used.
Given that pretty much all GENMASK() are used for hardware bit-patterns
not having a fixed size result type seems wrong.

The newly added GENMASK_U8() and GENMASK_U16() are also pointless.
Integer promotion converts the value to 'signed int' before it
is used.

>... 
> > I found code elsewhere that doesn't really want FIELD_PREP() to
> > generate a 64bit value.
> > 
> > There are actually a lot of dubious uses of 'long' throughout
> > the kernel that break on 32bit.
> > (Actually pretty much all of them!)  
> 
> If you're referring to the use of GENMASK() with bitfields larger
> than 32-bits, then as can be seen from the above, the code wouldn't
> even compile and our CI systems would be screaming about it. They
> aren't, so I think your statement here is also wrong.

No, I'm talking about a 'normal' FIELD_PREP(GENMASK(7, 5), val) having
a 64bit type on 64bit.
It tripped up my min_t(int, ) 'cast truncation test' a few times :-)

The problem with with 'long' is more pervasive.
It gets used for 'quite big' values that are clearly independent of whether
a 32bit or 64bit kernel is being built.
You're going to want to see an example, I think this overflows badly on 32bit:
static long pll1443x_calc_kdiv(int mdiv, int pdiv, int sdiv,
		unsigned long rate, unsigned long prate)
{
	long kdiv;

	/* calc kdiv = round(rate * pdiv * 65536 * 2^sdiv / prate) - (mdiv * 65536) */
	kdiv = ((rate * ((pdiv * 65536) << sdiv) + prate / 2) / prate) - (mdiv * 65536);

	return clamp_t(short, kdiv, KDIV_MIN, KDIV_MAX);
}
https://elixir.bootlin.com/linux/v6.18-rc6/source/drivers/clk/imx/clk-pll14xx.c#L120
(Spot the non-functional clamp_t() - which is why I found this code.)

I'm sure I've seen fs code comparing u64 and ulong that both hold block numbers.
Such code should really only use fixed size types.
Either a value fits in 32bits, so int or u32 is fine; or it doesn't and you
need a u64. 'long' doesn't enter into it.

	David




