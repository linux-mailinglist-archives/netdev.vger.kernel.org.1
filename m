Return-Path: <netdev+bounces-233180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 312C9C0D906
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 13:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D24F734D9BB
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 12:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED6830E0D2;
	Mon, 27 Oct 2025 12:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xOHj51J/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAB02FE58E;
	Mon, 27 Oct 2025 12:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568504; cv=none; b=ZMzTXcLIi0iwSP/YTGtO44woSbTE3rAfEq8oO3v0eYy692vHvZ++lTS8kxIQT/0lNvE8K+Xnr9cMsPExVDNzLa0I8JYSLd142cQ0cqmLu5N3Bgn+QmxVbulLBtNrXyxfceCgj2TMWh2Xr4y3sMEiXg0CRNc8U55WD3s06Hpg588=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568504; c=relaxed/simple;
	bh=P+3UXldEAR7K0LP2DEUeWZ6b1BjyHAZunBfUNmacYL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9L2TU0PCXbRYxwfpBGfR7DNxCk1ZqVonziCycDvggLlu3AXZYbuDJZmdUJLDaMjgmdx02Q/Rog9gryTGXlZvzaCZKMPbtEZLABw32Zzpsq52h7wzazpUt0f0ZP/I5g5h3qLVTbWt68YCNQshQaMLUV2m76rcEBgKMSpOzYz6DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xOHj51J/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iA7t2Iu5WmijCKzI4GOFbP1+sQVyXkrlu3SiinRY5fE=; b=xOHj51J/BGH7TW8B1tue9x+1cZ
	ciRjmO0LOkcfCgqKGjCBlhej8qpS2adZBtz83L4kTWr2SWApaY5YfMZ2y2Ezd/LwY8+ytZgOHpVEC
	5g2JJQlARRG/mEHbQFcddVjttfvRkuIDkru5t5BQhF1yh4cYwCY8enA2+QPSZI+5AZyY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vDMQs-00CBov-Nc; Mon, 27 Oct 2025 13:34:42 +0100
Date: Mon, 27 Oct 2025 13:34:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: BMC-SW <BMC-SW@aspeedtech.com>, Arnd Bergmann <arnd@arndb.de>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue6KaG?= =?utf-8?Q?=3A?= [net-next 0/3] Add Aspeed
 G7 MDIO support
Message-ID: <ad12992b-2ddf-406f-a024-dd402f8a3f0c@lunn.ch>
References: <20241118104735.3741749-1-jacky_chou@aspeedtech.com>
 <7368c77e-08fe-4130-9b62-f1008cb5a0dc@lunn.ch>
 <SEYPR06MB513478C462915513DE7BE1AE9DFCA@SEYPR06MB5134.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB513478C462915513DE7BE1AE9DFCA@SEYPR06MB5134.apcprd06.prod.outlook.com>

On Mon, Oct 27, 2025 at 02:44:23AM +0000, Jacky Chou wrote:
> Hi Andrew,
> 
> This is Jacky from ASPEED.
> Last year, I submitted a series of patches to add a new compatible string
> "aspeed,ast2700-mdio". At that time, the feedback I received was that if there
> were no functional changes, a new compatible string would not be necessary.
> Recently, we are submitting the AST2700 platform support to the Linux kernel.
> In the following discussion thread, it appears that the MDIO driver might need
> a new compatible string for the AST2700 platform:
> https://lore.kernel.org/all/b048afc1-a143-4fd0-94c9-3677339d7f56@lunn.ch/
> I would like to confirm whether this case should be submitted separately to
> net-next, and in general, if there are no hardware or design changes, is it
> still required to introduce a new compatible string?

Are you sure it is identical? And are you sure there are no bugs in
the driver which would require breaking backwards compatibility, like
you are going to be doing for the MAC driver?

Take the reset handling for example. It looks like it was added after
basic support for the 2600 has added, so it had to be optional, to not
break backwards compatibility with older DT blobs. But since there is
no support for the 2700 yet, you could make the reset mandatory,
without breaking anything.

How is the clock handled on this hardware? The MDC is currently
ticking at 2.5MHz. However many PHYs and MDIO based Ethernet switches
will happy run at a faster speed. So you could implemented
'clock-frequency'. But for that, do you need a clock listed? Should
that clock be listed now, as a mandatory property for the 2700?

Having a specific compatible and a fallback costs nothing, so i would
do it. 

	Andrew

