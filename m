Return-Path: <netdev+bounces-195082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF680ACDDD1
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 14:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 283351892F59
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 12:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DB928DB78;
	Wed,  4 Jun 2025 12:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Db0ompKE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C432C327E;
	Wed,  4 Jun 2025 12:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749039809; cv=none; b=PjcxCTBMMGhUyY27h4tbyUh+gelkEVZcM+0CvNkUir7qnF9KZ4+2ZpYGrA+XKnykjElKYhRIZAOBwcCxraWM5NDLrCfh+7EI109AT1y0IaVtUAvYq97yVU7BFllBFKZDgSQ0+n5tatj0huNbhPB+0m0q7zNH4Qt//s3NGXhJqiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749039809; c=relaxed/simple;
	bh=QaTyjEznJ1R5sNay9RQIac7K2Sj38RK5k3TLtoVPbzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ki2ruQ0jessNEVNfN95IiCJ8ra7iB2rgMFUAs5PAYUcPG6ABJQYFrrmkqUozhM8YzU8M4bCLHAL30X+TjVAHgiW0zLBCnh/0TSfoY9NdiV/qXXENiA8r65UWo2KX2wU2BkX3yrRM35eZUSKbLGywDqNWrwVG5RcFkW4SxceVd/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Db0ompKE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=7XWieguazqtxUMRi6G7yUlfR8Tu1/VnAzgOfOXGtr7c=; b=Db
	0ompKEjd/bvN9l1Nb/8IXd21AkXSBrYqRkJVu6UzHiWEXh3fFqWo8NlaMkhFdMbtgZ4Vol0lgGMEi
	7VIeePYWVWilUfF6UoVrFgd1U1/rTaJQTWvnfTyzCwZIl+Ak2hxdbiFxk140Lpb7MgTZVVQCTS3hX
	iFgyrNvRoMtfgnM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uMn9A-00EgC3-M8; Wed, 04 Jun 2025 14:23:08 +0200
Date: Wed, 4 Jun 2025 14:23:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] dt-bindings: net: ethernet-controller: Add
 informative text about RGMII delays
Message-ID: <debcb2e1-b7ef-493b-a4c4-e13d4aaf0223@lunn.ch>
References: <20250430-v6-15-rc3-net-rgmii-delays-v2-1-099ae651d5e5@lunn.ch>
 <e4db4e6f0a5a42ceacacc925adbe13747a6f948e.camel@icenowy.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e4db4e6f0a5a42ceacacc925adbe13747a6f948e.camel@icenowy.me>

> > -      # RX and TX delays are added by the MAC when required
> > +      # RX and TX delays are provided by the PCB. See below
> 
> This really sounds like a breaking change that changes the meaning of
> the definition of this item instead of simply rewording.
> 
> Everything written according to the original description is broken by
> this change.

Please give some examples. What has broken, which was not already
broken. There has been a lot of discussion about this over the last
year, so please do some careful research about what has been said, and
try not to repeat past discussion.

The whole point of this change is this is often wrongly interpreted,
and there are a lot of broken .dts files. By including a lot of text,
explaining both the pure OS agnostic DT meaning, and how Linux systems
should implement it, i hope i have made it less ambiguous.

> Although these PHYs are able to implement (or not to implement) the
> delay, it's not promised that this could be overriden by the kernel
> instead of being set up as strap pins.

If you want the kernel to not touch the PHY, use

phy-mode = 'internal'

> In addition, the Linux kernel contains a "Generic PHY" driver for any
> 802.1 c22 PHYs to work, without setting any delays.

genphy is best effort, cross your fingers, it might work if you are
luckily. Given the increasing complexity of PHYs, it is becoming less
and less likely to work. From a Maintainers perspective, i only care
if the system works with the proper PHY driver for the
hardware. Anything else is unmaintainable.

> > +#
> > +# There are a small number of cases where the MAC has hard coded
> > +# delays which cannot be disabled. The 'phy-mode' only describes the
> > +# PCB.  The inability to disable the delays in the MAC does not
> > change
> > +# the meaning of 'phy-mode'. It does however mean that a 'phy-mode'
> > of
> > +# 'rgmii' is now invalid, it cannot be supported, since both the PCB
> > +# and the MAC and PHY adding delays cannot result in a functional
> > +# link. Thus the MAC should report a fatal error for any modes which
> 
> Considering compatibilty, should this be just a warning (which usually
> means a wrong phy-mode setup) instead of a fatal error?

As i said, there are a large number of broken DT blobs. In order to
fix them, but not break backwards compatibility, some MAC and PHY
drivers are going to have to check the strapping/bootloader
configuration and issue a warning if phy-mode seems wrong, telling the
user to update there DT blob. So, yes it is just a warning for systems
that are currently broken, but i would consider it an error for
correctly implemented systems.

	Andrew

