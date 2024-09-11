Return-Path: <netdev+bounces-127339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFD797516B
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 14:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D29B01C22264
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 12:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87551865F6;
	Wed, 11 Sep 2024 12:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qrtomjd/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207F96F2FD;
	Wed, 11 Sep 2024 12:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726056345; cv=none; b=Ee68qLnkpmxm8lOZoLW/fU1MiBdUoViZFqiGopjjV32mPJyaEjqOY9lmjtYy9KSFtJ/mcPpzLCxLSvt0MOcE2n/RbN97MvhjMmtYcF/BFbETtkRvaRrwPJjf1aPJAc/c6dMV68267eGBUdbiUKHiG4EYfCyucejefRPXaQ/L5WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726056345; c=relaxed/simple;
	bh=pSWGESCfZCSIn/49L0VazriLwFlPwXSfbu4bYb7pzdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CfspZwbfv/vIlwSg4o9nRU24FeVRX+x4069SdsVyNt0slvUPvMSBlaNlD3PdPkwdg7jaEc6EbtEhiHjr8XKhAVtP3XTL1yF9MyJwOxXfteDLoD5nB1I898lxEEyTaeIN/3bluaCmYeeaS7TVcHH0kKr9JtivoMGr8cQhIfe7aCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qrtomjd/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hiT4ktdB8h0ynWeUnBnGAgt8pvZOzLf4GvYT1wzQK3E=; b=qrtomjd/MHg1ceJfq0+ek4eNlP
	oIT7PoBp6AqoC1rTNAUYtOeNBUJWLmNZsQhxJGmXiktIKkeHUhjqO0Czs9ZHO225xlru2dwvahvV5
	QpOjEXO4keL0vJFRLyI7I7iBpoguV5AToScLD4qsUuR80scNnxu+LHnl+n5Ci2klIyqg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1soM6D-007CWC-Ei; Wed, 11 Sep 2024 14:05:29 +0200
Date: Wed, 11 Sep 2024 14:05:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rob Herring <robh@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: ethernet-phy: Add
 master-slave role property for SPE PHYs
Message-ID: <443a53a5-71ac-4287-9951-df3c54b11b8d@lunn.ch>
References: <20240909124342.2838263-1-o.rempel@pengutronix.de>
 <20240909124342.2838263-2-o.rempel@pengutronix.de>
 <20240909162009.GA339652-robh@kernel.org>
 <c2e4539f-34ba-4fcf-a319-8fb006ee0974@lunn.ch>
 <CAL_Jsq+qJStck1OTiXg0jPR3EPEpLsu-or0pNqNh0orFjf+0uA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+qJStck1OTiXg0jPR3EPEpLsu-or0pNqNh0orFjf+0uA@mail.gmail.com>

> It seems silly to maintain both forever. I'd rather have one or the
> other than both.

It currently seems like 802.3 is going to keep with master/slave in
the body of the text. And they don't even have to deal with breaking
backwards compatibility. So i suggest we keep with master/slave, but
comment that an annex of the standard proposes alternative names of
leader/follower. But don't actually accept them.

> 
> > As to you comment about it being unclear what it means i would suggest
> > a reference to 802.3 section 1.4.389:
> >
> >   1.4.389 master Physical Layer device (PHY): Within IEEE 802.3, in a
> >   100BASE-T2, 1000BASE-T, 10BASE-T1L, 100BASE-T1, 1000BASE-T1, or any
> >   MultiGBASE-T link containing a pair of PHYs, the PHY that uses an
> >   external clock for generating its clock signals to determine the
> >   timing of transmitter and receiver operations. It also uses the
> >   master transmit scrambler generator polynomial for side-stream
> >   scrambling. Master and slave PHY status is determined during the
> >   Auto-Negotiation process that takes place prior to establishing the
> >   transmission link, or in the case of a PHY where Auto-Negotiation is
> >   optional and not used, master and slave PHY status
> 
> phy-status? Shrug.

phy-status is too generic. Maybe 'timing-role' ?

> 
> Another thought. Is it possible that h/w strapping disables auto-neg,
> but you actually want to override that and force auto-neg?

Autoneg can be used for a bunch of parameters. In automotive
situations, it is generally disabled and those parameters are
forced. In more tradition settings those parameters are
negotiated. However, even with autoneg enabled, you can force each
individual parameter, rather than negotiate it.

So we would need a DT parameter about autoneg in general. And then a
DT parameter about 'timing-role', where force-master/force-slave means
don't negotiate, and prefer-master/prefer-slave means do negotiate
with the given preference.

	Andrew

