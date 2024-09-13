Return-Path: <netdev+bounces-128189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1835B9786B2
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 19:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 520381C209EE
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 17:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC548289E;
	Fri, 13 Sep 2024 17:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Hfo6QdCJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8978877F2F;
	Fri, 13 Sep 2024 17:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726248420; cv=none; b=VL+3NfqwrYuU/cg/aJ3DmsQceNdjEKG47HULqddvokvSvrWJC+2NQUcK6ySdTCX3Qo1TiWpUmPg21+a3N3/IL2IwI0b8YeUhpaBrWMe9tITMOhZn97j/VTQv5sXneUr7qUX0EsI4adITMCWM7m/PNr4iV3vgFbN41yEmDQbrRP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726248420; c=relaxed/simple;
	bh=NVHDT0pZ1zHz5uTG07jzhk7YNB3Ko4HEeOjB7XAzKsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLwv7rwdHi+/Zsrb3cGK1mo0owjC/MptFpdKQihv0JNjGEdikQaVaqMXp+/3WkNcO1UQaE/gadZqm2yqeg6zXCYxG/K42uMK3tnH3NbBh5ogq0+JV1oaVp0bA1xw4FctO4WEixnzLGpCqWyVNgLgSON3aXTZVhv90D2C/9veS3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Hfo6QdCJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=32UdeEDTGODPOGNxUz6i5sSk42ZhPb7Adwn/D1E2ONc=; b=Hfo6QdCJ9MxMuSWa/bGCLd/vhE
	hMmQl8h6OyrZLJ2CqQapkX6NNQVg1xyHAGTRyy8ACqFSPvYZS6obUAzLBnd8qwOPKUVXbs41ySUSr
	BPR449SLMCHqcu8I8wDTNeNWO5fxd11OFmDs1mmSUYk32iJwfMkClShPysvjpPC/pMpU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1spA4H-007PWh-HE; Fri, 13 Sep 2024 19:26:49 +0200
Date: Fri, 13 Sep 2024 19:26:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Conor Dooley <conor@kernel.org>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] dt-bindings: net: dsa: the adjacent DSA
 port must appear first in "link" property
Message-ID: <c2244d42-eda4-4bbc-9805-cc2c2ae38109@lunn.ch>
References: <20240913131507.2760966-1-vladimir.oltean@nxp.com>
 <20240913131507.2760966-3-vladimir.oltean@nxp.com>
 <20240913-estimate-badland-5ab577e69bab@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913-estimate-badland-5ab577e69bab@spud>

On Fri, Sep 13, 2024 at 06:04:17PM +0100, Conor Dooley wrote:
> On Fri, Sep 13, 2024 at 04:15:05PM +0300, Vladimir Oltean wrote:
> > If we don't add something along these lines, it is absolutely impossible
> > to know, for trees with 3 or more switches, which links represent direct
> > connections and which don't.
> > 
> > I've studied existing mainline device trees, and it seems that the rule
> > has been respected thus far. I've actually tested such a 3-switch setup
> > with the Turris MOX.
> 
> What about out of tree (so in u-boot or the likes)? Are there other
> users that we need to care about?
> 
> This doesn't really seem like an ABI change, if this is the established
> convention, but feels like a fixes tag and backports to stable etc are
> in order to me.

Looking at the next patch, it does not appear to change the behaviour
of existing drivers, it just adds additional information a driver may
choose to use.

As Vladimir says, all existing instances already appear to be in this
order, but that is just happen stance, because it does not matter. So
i would be reluctant to say there is an established convention.

The mv88e6xxx driver does not care about the order of the list, and
this patch series does not appear to change that. So i'm O.K. with the
code changes.

> > -      Should be a list of phandles to other switch's DSA port. This
> > -      port is used as the outgoing port towards the phandle ports. The
> > -      full routing information must be given, not just the one hop
> > -      routes to neighbouring switches
> > +      Should be a list of phandles to other switch's DSA port. This port is
> > +      used as the outgoing port towards the phandle ports. In case of trees
> > +      with more than 2 switches, the full routing information must be given.
> > +      The first element of the list must be the directly connected DSA port
> > +      of the adjacent switch.

I would prefer to weaken this, just to avoid future backwards
compatibility issues. `must` is too strong, because mv88e6xxx does not
care, and there could be DT blobs out there which do not conform to
this. Maybe 'For the SJA1105, the first element ...".

What i don't want is some future developer reading this, assume it is
actually true when it maybe is not, and making use of it in the
mv88e6xxx or the core, breaking backwards compatibility.

	Andrew

