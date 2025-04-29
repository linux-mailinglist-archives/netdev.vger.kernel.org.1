Return-Path: <netdev+bounces-186733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04300AA0B3A
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 14:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3024B7A7DF1
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 12:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FAC26FDA7;
	Tue, 29 Apr 2025 12:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SkZtFKRB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C42128E0F;
	Tue, 29 Apr 2025 12:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745928503; cv=none; b=swMkRb/E212yZPR2fMEa210wBGCpkrNjcFOn90hMP6Jw8ZuzlCs5a/nzAf42Ehs4jph2go0gMKbTvkF/ITL+NIwSMUClRwLiugGhywxwuU8SDR0az/B755DePBFpEtM61yH84oBC2xO7MQR6NZ4XOKGsyKZ5cjjz/d3p6/KKu4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745928503; c=relaxed/simple;
	bh=u2KDSl6Z8S8d/VXvdkeAcfQ+QeA7wKWNNDMj2h67vhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCtt/FyH3E8AYYyE2qvcPfGt9Wf/7rNXboaupqp5kW2kcFJIovij0Qsaggpwp/eH6H0tXHVqg9E6kzErjvkohGF/qQ0qka4Xjz8aHOmdxjQ1nTjJDI5AsL0xzTReci1VbqNtcTEQlfkVpVtz0+wbLNBPj3cd3ESw/t3UDCm+1rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SkZtFKRB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KBTM9WY09lm/gGdZhulr7/dP5G3uqnfHYWiy8iUJ1N4=; b=SkZtFKRBDYSjtCqVbzOhcQEuRj
	DWyy1aTiVIPrrCWaBx6JUhx9WKbn3kEKxrlq7I9x/KVZ1HuLvhkN1sL/+Z0ziDpGobC1e/avHvFAC
	psMCCdKOBLmsghcs3mywZeA3U6QJA7FBD12XTQa0tvtrNQ3osLdKcoOXs9/Fv47Zw9+E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u9jkn-00Avy8-8E; Tue, 29 Apr 2025 14:08:01 +0200
Date: Tue, 29 Apr 2025 14:08:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Whitcroft <apw@canonical.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>, Tero Kristo <kristo@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: ethernet-controller:
 update descriptions of RGMII modes
Message-ID: <d00838cc-5035-463b-9932-491c708dc7ac@lunn.ch>
References: <cover.1744710099.git.matthias.schiffer@ew.tq-group.com>
 <218a27ae2b2ef2db53fdb3573b58229659db65f9.1744710099.git.matthias.schiffer@ew.tq-group.com>
 <aAaafd8LZ3Ks-AoT@shell.armlinux.org.uk>
 <a53b5f22-d603-4b7d-9765-a1fc8571614d@lunn.ch>
 <aAe2NFFrcXDice2Z@shell.armlinux.org.uk>
 <fdc02e46e4906ba92b562f8d2516901adc85659b.camel@ew.tq-group.com>
 <9b9fc5d0-e973-4f4f-8dd5-d3896bf29093@lunn.ch>
 <b75c6a2cf10e2acf878c38f8ca2ff46708a2c0a1.camel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b75c6a2cf10e2acf878c38f8ca2ff46708a2c0a1.camel@ew.tq-group.com>

On Tue, Apr 29, 2025 at 09:24:49AM +0200, Matthias Schiffer wrote:
> On Mon, 2025-04-28 at 16:08 +0200, Andrew Lunn wrote:
> > 
> > > > However, with the yaml stuff, if that is basically becoming "DT
> > > > specification" then it needs to be clearly defined what each value
> > > > actually means for the system, and not this vague airy-fairy thing
> > > > we have now.
> > 
> >  
> > > I agree with Russell that it seems preferable to make it unambiguous whether
> > > delays are added on the MAC or PHY side, in particular for fine-tuning. If
> > > anything is left to the implementation, we should make the range of acceptable
> > > driver behavior very clear in the documentation.
> > 
> > I think we should try the "Informative" route first, see what the DT
> > Maintainers think when we describe in detail how Linux interprets
> > these values.
> 
> Oh, we should not be Linux-specific. We should describe in detail how *any OS*
> must interpret values.

There is two things here. One is related to delays on the PCB. Those
are OS agnostic and clearly you are describing hardware. But once you
get to implementing the delay in the MAC or the PHY, it is policy if
the PHY does it, or the MAC does it. Different OSes can have different
policy. We cannot force other OSes to do the same as Linux.
 
I drafted some text last night. I need to review it because i often
make typos, and then i will post it.

	Andrew

