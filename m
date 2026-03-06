Return-Path: <netdev+bounces-264849-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIAHMJXxqmncYwEAu9opvQ
	(envelope-from <netdev+bounces-264849-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:24:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 430EF223B53
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD30F3090E95
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 15:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5D9366576;
	Fri,  6 Mar 2026 15:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0uFKeBR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6632D3537FA;
	Fri,  6 Mar 2026 15:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772810455; cv=none; b=oD4Do8/4bzL2txP8ee229LP8hHHaiDuNIYMCnqRFcwbuw+tvRWsAvSFRHTJVTPO6z8NNBexjyDGKZ3mhBitFfEwmggWlLauOhhWo6Q+bZvE5Cx4hg6j3ReOStMup+qtLYF5SSr9NkRdgOM4GYG+Qoiic053bk8EyrxLdby4uzhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772810455; c=relaxed/simple;
	bh=hvXgGkf2qu+jqR+sgY8DakribYb85aMMllz2F4DP0wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNuYPQEgNf1hiS0n6LYcnnx6TSkqykxrH3PzEZMK2oYt4KKESOFZNHnkzCw8rQxTD+23UV6AhX6p5WsgtiV74NoZ+RToBiwlszznXG3qRgitZwSEKuzDxVEK4J2+aUB3ztdQmH1uUtW7xi2+VuF2cbPW5A0LfEyqBATLcfnfrYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0uFKeBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E42C4CEF7;
	Fri,  6 Mar 2026 15:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772810454;
	bh=hvXgGkf2qu+jqR+sgY8DakribYb85aMMllz2F4DP0wk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J0uFKeBR838wZP2L+gn1tFYR1pp3O0vli6BXg5dyDv8PN/I6WR3oh7MVJbVB0431b
	 9l4GNBfabH3/dN6XVbUp8AUNikkn524uPLJt3THgfe6IY7GuydW4QxZbfPHlFES1Ik
	 GDQ72WdIAa6ducWYHHkhov9T4/h6QE3IAxAdDbp71rzlaOr5pTrSO6bfZ8xvkUopBo
	 j15R8RE8eaak4c2W022F7coAtxzswahcuNBHvf1nJTHNS/niETg2dbu7CGAqzgtJCe
	 hid+bMfPNBYkFndY9iL+hicEIN3FWXILXjMBQfHlaxURfx6Xl14S+9TZotvg82doQ+
	 cCVQs/T7fD1Ew==
Date: Fri, 6 Mar 2026 15:20:48 +0000
From: Conor Dooley <conor@kernel.org>
To: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
Cc: Andrew Lunn <andrew@lunn.ch>, UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Russell King <linux@armlinux.org.uk>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 2/8] dt-bindings: net: lan9645x: add LAN9645X
 switch bindings
Message-ID: <20260306-pointless-purr-210540d4dc64@spud>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-2-bff8ca1396f5@microchip.com>
 <4088b0ff-b718-4137-8518-4c9b9764d56d@lunn.ch>
 <20260303-mosaic-debate-90cf8c8bbb33@spud>
 <1db45715a3a12b76b838d20c0e5904c3222053e7.camel@microchip.com>
 <20260305-reliant-parchment-0ff685a9c78e@spud>
 <7b62ace495084794336b19a9685d6b14ea3981a0.camel@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kHmiwYOF/7ZYzZNz"
Content-Disposition: inline
In-Reply-To: <7b62ace495084794336b19a9685d6b14ea3981a0.camel@microchip.com>
X-Rspamd-Queue-Id: 430EF223B53
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264849-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[lunn.ch,microchip.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action


--kHmiwYOF/7ZYzZNz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 06, 2026 at 04:08:01PM +0100, Jens Emil Schulz Ostergaard wrote:
> On Thu, 2026-03-05 at 18:31 +0000, Conor Dooley wrote:
> > On Thu, Mar 05, 2026 at 01:57:37PM +0100, Jens Emil Schulz Ostergaard w=
rote:
> > > On Tue, 2026-03-03 at 19:04 +0000, Conor Dooley wrote:
> > > > On Tue, Mar 03, 2026 at 03:18:45PM +0100, Andrew Lunn wrote:
> > > > > > +        properties:
> > > > > > +          microchip,led-drive-mode:
> > > > > > +            $ref: /schemas/types.yaml#/definitions/uint32
> > > > > > +            description: |
> > > > > > +              Set the LED drive mode for the copper PHY associ=
ated with
> > > > > > +              this port.
> > > > > > +
> > > > > > +                0 - LED1 and LED2 in open-drain mode
> > > > > > +                1 - LED1 in active drive mode (can be used for=
 single-LED
> > > > > > +                    configurations requiring active drive)
> > > > > > +                2 - Reserved
> > > > > > +                3 - LED1 and LED2 in active drive mode
> > > > > > +            minimum: 0
> > > > > > +            maximum: 3
> > > > >=20
> > > > > I doubt the DT Maintainers will accept that. This looks a lot lik=
e a
> > > > > value you write into a register. How are active drive and open-dr=
ain
> > > > > described in other DT bindings? Is there something you can reuse?
> > > >=20
> > > > I had a quick look and I didn't see anything really that stood out =
to me
> > > > that would be a drop-in replacement.
> > > > I also tried looking in the datasheet for more information on these
> > > > modes, but I couldn't see anything obvious. For example, there were=
 zero
> > > > hits for "drain" in either LAN9645xS or LAN9645xF datasheets.
> > > >=20
> > > > That said, yea you're right about DT maintainer feelings about it.
> > > > There's a couple things I could suggest, but I'd like to know about=
 what
> > > > mode 1 means for LED2 first. If there's actually nothing similar, w=
hat
> > > > about representing each led with a child node and having open-drain=
 be
> > > > the default with a property in the child for active-drive?
> > > >=20
> > > > >=20
> > > > > For 1, what happens to LED2? Not used at all?
> > >=20
> > > In mode 1 LED2 will be open-drain. This mode only makes sense if you =
have
> > > just 1 LED. With two LEDs mode 0 or mode 3 should be used.
> >=20
> > Could we then have child nodes for each led, and have a property in each
> > that sets the mode to either open-drain or active-drive? Or am I just
> > inserting complexity by asking for that?
>=20
> I think it sounds sensible, I will add this.


You don't need a property for each, just make one mode the default (prob
open-drain given it's the 0 setting, but whatever is default out of
reset for the part) and have the property for the other mode. Just
some bool property like "microchip,active-drive" or whatever.

--kHmiwYOF/7ZYzZNz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaarwuwAKCRB4tDGHoIJi
0mLvAP4niib63KhKJfXuRrVQ7tpWk5NdXsr7ixxEWKIyPCECQAEAoOiaNn9WsgYu
8OkUBffwCl7j3bkqGx3lsEB2giDELAM=
=4Erg
-----END PGP SIGNATURE-----

--kHmiwYOF/7ZYzZNz--

