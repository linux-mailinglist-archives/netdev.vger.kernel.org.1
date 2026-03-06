Return-Path: <netdev+bounces-264897-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDUMKRIpq2luaQEAu9opvQ
	(envelope-from <netdev+bounces-264897-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 20:20:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BA9226FFB
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 20:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 57BE0300D757
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 19:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AA03370EB;
	Fri,  6 Mar 2026 19:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1TbeN3B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B9F211A05;
	Fri,  6 Mar 2026 19:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772824846; cv=none; b=aQpBZjDkfiUPB6htXY44rysEbRppu3O5huFtIwuW716ReAj/Kb7OhJ4VZu3ATCW6EpiiXyygeMfwHvnubrID4S/WrNZV6xbo3AfvytYm76ocqs/84UwvYV481nmLTQIjmS/kqE266fK48FjUsjhk7QNrRg/tZfm7CpvpafeevBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772824846; c=relaxed/simple;
	bh=A6Z8C8yvwJHtik94vftQER8K1+ESpIRL7rXKW3eiiKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1CXQVuJ+DU+8jbQWA+oN+4mL8TO2CY7HsXrRoMgE6TvUPJMQ92+Cjfhu3Dgtkh1iNWhJeIsKjQDshwP/5+t0Odd7ovZ6xZedeF8Iy/PtNBPwTj+frTeBrzLjpFUnMuUyqXERUbtd2xD6J8+DViwCuyd4TYQA+jjD8nTnPp5shU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1TbeN3B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF08C4CEF7;
	Fri,  6 Mar 2026 19:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772824846;
	bh=A6Z8C8yvwJHtik94vftQER8K1+ESpIRL7rXKW3eiiKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n1TbeN3BBAfYI0RcpFU27R++g4QiLRDC80Du9ib+oP2965JKnRdEZje4Jq1/X6+N1
	 /nqWG5QDW73qbRsJf0K/ZtzOUufQmSsG7okhZL8/rL14aR3jb4YvIhnYQ8AuvfrK7M
	 ds72DSwttGAxUDX6Dboy3fPo4lZwtOACtqj9IGu94EE5HTzFOhUZ8HMDfgk8KYptRd
	 +gkDvIrF9Qi7YHo/fStFWfqpW3aKWF6pRFOV1Twf1CqDP5oRYYyETmLrFhlsF9/Hpz
	 ZBZV3Wms8AIvkYwQGKbZrrGfWYYH9bdZmf8AB6hsrqnA3Jg/fawnURD0K3LQ/AATxd
	 iqFw2GSzFADPw==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id E34001AC52CF; Fri, 06 Mar 2026 19:20:41 +0000 (GMT)
Date: Fri, 6 Mar 2026 19:20:41 +0000
From: Mark Brown <broonie@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Romain Gantois <romain.gantois@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: sfp: manage receiver and transmitter
 regulators
Message-ID: <aaspCUWel9k_ls4i@sirena.co.uk>
References: <20260303-sfp-regulators-v1-0-7101ae34cb84@bootlin.com>
 <20260303-sfp-regulators-v1-2-7101ae34cb84@bootlin.com>
 <e7a1ab5e-c34d-4ca5-93eb-4f5bcfacdb40@sirena.org.uk>
 <aab6Tqo1z-8YQ4j6@shell.armlinux.org.uk>
 <536e57fe-9738-4026-a9c9-fdb7135cbe2f@sirena.org.uk>
 <aab9bwKSubR6zxKG@shell.armlinux.org.uk>
 <1dbc679e-ad6d-49c5-86bd-3b319b899584@sirena.org.uk>
 <aacpVFhH8eV7dxHV@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/1eyKJ6WJEua7dx/"
Content-Disposition: inline
In-Reply-To: <aacpVFhH8eV7dxHV@shell.armlinux.org.uk>
X-Cookie: Think big.  Pollute the Mississippi.
X-Rspamd-Queue-Id: 48BA9226FFB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264897-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[bootlin.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action


--/1eyKJ6WJEua7dx/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 03, 2026 at 06:32:52PM +0000, Russell King (Oracle) wrote:
> On Tue, Mar 03, 2026 at 05:31:36PM +0000, Mark Brown wrote:

> > supplies?  The logs you posted looked like it was controllers requesting
> > the supplies which does look like the bindings and associated requests
> > aren't what I'd expect for something describing the hardware.

> The setup here as far as can be derived from the SoC documentation is:

> The AHCI SATA controller and COMPHY are integrated into the SoC.
> Internally, these components would be provided power by the internal
> SoC design.

> So, let's go through the supplies for the AHCI controller. The binding
> documentation states:

>   ahci-supply:
>     description: Power regulator for AHCI controller

> First, this is not listed as a required property. In this case, the
> AHCI controller is internal to the SoC, and no details are given in
> the documentation what that supply is, where it is derived from, or
> whether it's controllable.

This just shouldn't be there as a generic property for all AHCI
controllers, if there are controllers that have such a supply it should
be part of the controller specific bindings not forced on every single
controller.

>   target-supply:
>     description: Power regulator for SATA target device

> The board does not provide power to the target device, that is derived
> off-board and completely up to the user. Thus, this can't be specified.

Right, and also even within the board this is a property of the target
device not the controller.  Arguably you could say that your separate
ATX supply ends up being part of the same system for practical purposes
but it's a stretch.

>   phy-supply:
>     description: Power regulator for SATA PHY

> The PHY is an entirely separate device (the COMPHY) from the AHCI
> controller. Thus, specifying a PHY supply for this AHCI hardware is
> not relevant at the AHCI controller layer. Sure, other AHCI designs
> where the PHY is not generic may require a separate PHY supply which
> may be controllable, but here is one example where this just isn't
> relevant.

Yeah, same here.  This is a property of the PHY, and possibly of a
specific PHY.

> So, as a result of commit 962399bb7fbf ("ata: libahci_platform: Fix
> regulator_get_optional() misuse") we have now ended up with kernel
> boots issuing messages at warning severity (which means something is
> wrong and requires attention) for supplies that are not relevant to
> this SoC hardware design.

The underlying issue here being that the generic AHCI code's bindings
and hence regulator usage just don't reflect general AHCI hardware at
all, that's then causing knock on effects since as you say there's no
way for systems to provide sensible information corresponding to what
the drivers are asking for. =20

> We're now left with the annoying warning messages that - as I've
> stated above - are certainly in one case just not relevant to the
> SoC design.

I agree that we should do something here, I was working on the basis
that the bindings reflected the hardware but that seems rather far from
reality.  I'm wondering if we should have an API that lets drivers say
they're requesting a regulator for a "legacy" binding, that way we can
keep all the checking of usage and avoid fragility with mishandling of
errors but avoid complaining at users.

> > For SFP my understanding is that SFP has a physical specification which
> > includes power inputs and that these supplies are being requested by the
> > devices that consume them.  If some part of that is not the case then it
> > sounds like the bindings aren't describing the hardware (or at least are
> > a bit unclear about how they're doing so) and should be revised.  The
> > series doesn't seem to do anything at all with the supply side either,
> > I'm guessing there are some SFP controllers with integrated power
> > provisioning.

> First, please scrap the idea of "SFP controller". There's no such
> device. There's a SFP cage, which is a physical connector and a
> specification of the signals on the pins. How those signals are
> provided, or even whether they are provided is outside the scope
> of the "specification".

I see.  That's sounding like rather than having something that applies
to all SFP devices anything we do end up having should be something that
represents a SFP cage specifically, that's the thing that has the
physical specification with a known set of supplies.  With soldered down
stuff I suspect there's enough room for complication that it should be
dealt with on a device by device basis if needed.

> Given (1), it is unwise for a board with a cage to present two
> controllable supplies, as turning one supply off can result in
> power being back-fed via a module tying both together. Thus,
> specifying separate supplies could be dangerous.

I guess even if they're not controlled separately it's possible that
someone might decide that having two LDOs is part of their filtering
strategy...  It is generally easier to cope with the situation where one
supply does two consumers that are controlled together than it is to
deal with the situation where two supplies that are normally the same
are delivered by two separate regulators.  It all feels very edge casey
thugh.

> Now, if you're going to say "ah, so it has power pins, you need to
> describe them using a regulator" then I would say to you, when are
> we introducing regulators for every device we describe in DT such
> as LEDs, switches, GPIO pins, RAM, etc? Every device needs to have a
> source of power after all.

It sounds from the cover letter for this series like there's some demand
for power control of SFP cages, the cover letter isn't terribly specific
about what circumstances though.  Possibly there's some UI for this on
the system, or the hardware has some mechanism for detecting physical
insertion to the SFP cage (hopefully well in advance of the electrical
contacts being made)?  Romain, are you able to share more specifics on
the use case here?

--/1eyKJ6WJEua7dx/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmrKQYACgkQJNaLcl1U
h9AJyAf/aOr3xSlRkFQxM5FQkLmkyYkqH7j887qw30SXzASA5nJ1jE3jyYo9tMAU
6BumFwX4sA3QrEkST3HsCMUK38SMvL2WaR6u5hf1GdD84AC9JQEfb4mJ/bCeFlpY
dQSoMo1JngUbUozNiamQgnVjIlWXlhUnUnapV7CDkN+GpjSmzjEVHbZaPAtaqEBv
txcaNXusw8+CVP83kbVn/9mXDOk1FgWWVkDa4uCxJXYvj/WDwsyxaUk0AVZesY6y
Q8Jq1eTBfv82sOeXhAFtyUVOd75nt7BNfV1fRJe1ko7OF7rziE/eAEihbF87JrTh
IIsJ+CX8hnznk//lcb097NcVYwM5yQ==
=FoNH
-----END PGP SIGNATURE-----

--/1eyKJ6WJEua7dx/--

