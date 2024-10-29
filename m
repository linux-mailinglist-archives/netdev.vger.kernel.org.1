Return-Path: <netdev+bounces-139929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDBA9B4A8A
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 14:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C475B24691
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 13:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88794206E72;
	Tue, 29 Oct 2024 13:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pe9yXV4V"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E72F20696C
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730206971; cv=none; b=cHVwFyvNAywu1tY079lPtDNouKyCdXFFZxN7fwAqUt0xyim02rTVp1OSk+CJg/rLjI5X35AaNd8HX/LhdT9JyB7oZRlpqzbwtT+PelzGXFDO0zEqSf2cyq+0uNgAxfviidgjyrwNPh0uqMZ0fA6SMfygXNkZXuVPt95jd3CB4EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730206971; c=relaxed/simple;
	bh=qNMFm6GFo1rM2XNW4vzKU8Z7nZJIhXxB66YmxgbGpSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDAxAwDTJ7YUwoLBCe92NmApN8qGVqeftlswmN3llKRnL84kVE2d0pItJZiTN4+iLgSp9ARABgRaFooz7lTrTznuUmGOJ+zgdeHoCqHgzOotErchHilqKK9kpcx7Kn2T/9Lx0ba1Ng5AH6/WWJiQUMumGKCGONUKOziD7nW7JRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pe9yXV4V; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=04DBDIK0W8nIhmPLOEcxXbV9njS61hrQN3CBVS5Q+Rw=; b=pe
	9yXV4Ve9/wu54CAGq1STTVerjJlAnsT9tAzc4wL4LEF1MGgikfXpnsCtaxODFRmIlwD9yf4MbIPVE
	+AY/ffnQ0OY7bhuUrIZfBbNnTPPJ+BV7PX4z6Eqd37Qd4E6YVpRVVwvDl8A+v3nvDQyFaLOGcN0Cy
	Z5yh1Tsp+6S1pkY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t5lry-00BZt0-7b; Tue, 29 Oct 2024 14:02:46 +0100
Date: Tue, 29 Oct 2024 14:02:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: Lee Trager <lee@trager.us>, netdev@vger.kernel.org, pabeni@redhat.com,
	kuba@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com
Subject: Re: [PATCH net-next 1/4] net: phy: Allow loopback speed selection
 for PHY drivers
Message-ID: <9f6262bf-b559-48e0-97f0-9d83b3c9c5f8@lunn.ch>
References: <20241028203804.41689-1-gerhard@engleder-embedded.com>
 <20241028203804.41689-2-gerhard@engleder-embedded.com>
 <adada090-97fc-4007-a473-04251d8c091f@trager.us>
 <436283e7-16c3-46ef-9970-13ddbf3a2de3@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <436283e7-16c3-46ef-9970-13ddbf3a2de3@engleder-embedded.com>

On Tue, Oct 29, 2024 at 06:58:12AM +0100, Gerhard Engleder wrote:
> On 29.10.24 00:23, Lee Trager wrote:
> > On 10/28/24 1:38 PM, Gerhard Engleder wrote:
> > > -int genphy_loopback(struct phy_device *phydev, bool enable)
> > > +int genphy_loopback(struct phy_device *phydev, bool enable, int speed)
> > >   {
> > >       if (enable) {
> > >           u16 ctl = BMCR_LOOPBACK;
> > >           int ret, val;
> > > +        if (speed == SPEED_10 || speed == SPEED_100 ||
> > > +            speed == SPEED_1000)
> > > +            phydev->speed = speed;
> > Why is this limited to 1000? Shouldn't the max loopback speed be limited
> > by max hardware speed? We currently have definitions going up to
> > SPEED_800000 so some devices should support higher than 1000.
> 
> This generic loopback implementation only supports those three speeds
> currently. If there is the need for higher speed, then there should be
> PHY specific implementations in the PHY drivers.
> 
> >   Why is speed defined as an int? It can never be negative, I normally
> > see it defined as u32.

https://elixir.bootlin.com/linux/v6.11.5/source/include/uapi/linux/ethtool.h#L2172

#define SPEED_UNKNOWN		-1

It cannot be unsigned.

	Andrew

