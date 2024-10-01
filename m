Return-Path: <netdev+bounces-130849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2429098BBFB
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 14:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C4101C21FD5
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F441BFDE7;
	Tue,  1 Oct 2024 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="abbCi0ln"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38AB1C232C
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 12:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727785230; cv=none; b=L2kgSd+s1WAZjTdlzMDTn/GmhLOIihZDUIc3qwYmhg0Vt3AEJ+IPBT8OU57LiagXfks5PoukmVbd6t5ZBdZoux9o2Ufc7ioziZaI+8vjJ+xMqG+gf02VsaKkt9wHWcmBDKmYNI/YalyqLACFLoyMNErNx4dpwZZ9w80R4nG9Oxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727785230; c=relaxed/simple;
	bh=B/Lu1Nzt6z7PWW4bTrkvN9wIORp2yRoCRG1fiX64jcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JW4zLw8LqL6WZRLBi/3ZCrsnKcuL7LwyEA2jOVmdTXVsm1YktX+PVHYrQr1TlZMK9P2CqzmkxVt02wWpdz7nKgGEJBvWjEL/IUpwjBiGwWXcC/oolDmHF41BKxYauTKaU+byWoD68myHJl0P3PxMDpdJNcppTsqtTuUjIDc0v34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=abbCi0ln; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=va9+Yz0ks7MJQZVsVNx8OqAggoBH3/VMKy6X/mvZrWQ=; b=abbCi0lnhBgBnlEZCRT6xvL6FB
	eVQJQEWYvQ9T4ZUy7qOJp7gt5BTvWHJ2QfIW3LLqIrRh8BsbXGH4mqc8Prc3pqLlmKO/Lchp/rzZC
	Y1xIX7drtlAytuzMD5CLaT717LFOm4ln80aUtxZF5D245O2ae8L4xUzQJtyQ04QB2yL8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1svbrd-008j4Z-Fk; Tue, 01 Oct 2024 14:20:25 +0200
Date: Tue, 1 Oct 2024 14:20:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
	"Parthiban.Veerasooran@microchip.com" <Parthiban.Veerasooran@microchip.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"agust@denx.de" <agust@denx.de>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>
Subject: Re: [PATCH net-next] net: dsa: lan9303: ensure chip reset and wait
 for READY status
Message-ID: <4aa51df4-ba32-486a-86a5-75ea3b19867b@lunn.ch>
References: <20241001090151.876200-1-alexander.sverdlin@siemens.com>
 <aafbddb5-c9d4-46b4-a5f2-0f56c58fc5df@microchip.com>
 <60008606d5b1f0d772aca19883c237a0c090e7d3.camel@siemens.com>
 <20241001120455.omvagohd25a5w6x4@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001120455.omvagohd25a5w6x4@skbuf>

On Tue, Oct 01, 2024 at 03:04:55PM +0300, Vladimir Oltean wrote:
> On Tue, Oct 01, 2024 at 11:57:15AM +0000, Sverdlin, Alexander wrote:
> > Hi Parthiban!
> > 
> > On Tue, 2024-10-01 at 11:30 +0000, Parthiban.Veerasooran@microchip.com wrote:
> > > I think the subject line should have "net" tag instead of "net-next" as 
> > > it is an update on the existing driver in the netdev source tree.
> > > 
> > > https://www.kernel.org/doc/Documentation/networking/netdev-FAQ.txt
> > 
> > I explicitly didn't target it for -stable because seems that nobody
> > else is affected by this issue (or have their downstream workarounds).
> 
> Explain a bit more why nobody 'else' is affected by the issue, and why
> you're not part of the 'else' people that would justify backporting to
> stable?

At a guess, they have a lot of stuff in the EEPROM, which other
don't. I've seen this before with Marvell switches. But i always worry
that the EEPROM contents are going to be break an assumption of the
driver.

	Andrew

---
pw-bot: cr

