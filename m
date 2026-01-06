Return-Path: <netdev+bounces-247361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 415E2CF87BC
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 14:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0032A30221A1
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 13:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D25932ED27;
	Tue,  6 Jan 2026 13:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OUEMjvZP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D5232ED45;
	Tue,  6 Jan 2026 13:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767705118; cv=none; b=MwMSDM3X6Oj9kuNNjPUDL4NnicT/NE8yFzlvCoDeOfXIqbPHrkm3AHJTNkFxG6VXNzOYj2aHEBNq1y8SyYhI8GS1AjVyacblbaidSM5T7dwKrXKVvqUkWfernsBUptLNzj6zeH9n41JPz8gxYB5VdGE6DhlNT5n3WtHID+PW5B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767705118; c=relaxed/simple;
	bh=qaTOAXFWZbl1AtyL5KDQvymvJMGbRzbMh1U2AZvyzQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqB+I2metFb3FYqzsIiQ/z4Iyr5237fN5f3uBjcMOl7k2v4cQ7sUiM3Zpk4Jlbp+zDAIm3FOduwutHRL1/Jn1xf+g49wWVptc0L7Uc5Oe8zuW3M9PkesOqgluSBnVNIkWGwOuZtsrgJps8FeHKJW/Atry5SIZESJgp2ZyaZUTZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OUEMjvZP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vbYs8Wf38WWJ261qPiiFTtm5XkApntNc6Gpy/jwn4fs=; b=OUEMjvZPxytuXHMDESG5sn+2Kj
	EA3TR7OzGS7vAxKzMf7k/q73/C9kNVlvqeg/4fQor0WkrO3C6W1mAqVZbrPhr85U/WWw3XC06FdJ6
	/Jww39xrwk6tmzMaPkyxNKfp9YS4z8KB+UgYdPzWZtMlBjHkU6vUamsC0aoOK+cwIW4U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vd6qd-001cXP-4H; Tue, 06 Jan 2026 14:11:43 +0100
Date: Tue, 6 Jan 2026 14:11:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH RFC net-next v3 4/4] net: dsa: add basic initial driver
 for MxL862xx switches
Message-ID: <0d9bca64-75cb-441a-a0f8-6f84362e75d2@lunn.ch>
References: <cover.1765757027.git.daniel@makrotopia.org>
 <cover.1765757027.git.daniel@makrotopia.org>
 <63aa4a502c73e08e184cc74c2e9c1c939ed93f33.1765757027.git.daniel@makrotopia.org>
 <63aa4a502c73e08e184cc74c2e9c1c939ed93f33.1765757027.git.daniel@makrotopia.org>
 <20251216224317.maxhcdsuqqxnywmu@skbuf>
 <aVyCp9kvl7QXIOZX@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVyCp9kvl7QXIOZX@makrotopia.org>

> > Do the ports know not to forward packets between each other by default,
> > just to the CPU port? Which setting does that? Is address learning
> > turned off on user ports, since they are operating as standalone?
> 
> The configuration of the switch at this points depends on the default
> configuration which is attached to the firmware blob on the external
> flash chip attached to the switch IC.
> 
> It's an ongoing debate with MaxLinear to find a meaningful way to deal
> with (or rather: flush) that default configuration without needing to
> use all the API.
> 
> In the next series after that one I plan to add all basic bridge and
> bridge-port configuration API calls which can then also be used to
> create "single port bridges" for standalone ports, configure learning,

So does this mean this patch series does allow packets to flow between
ports, not just to the CPU?

That is a fundamental part of DSA, switchdev, linux. netdev interfaces
are separated by default. If this is not true, you should add a big
fat warning to the patchset indicating how it is broken and what the
plan is to fix it.

   Andrew

