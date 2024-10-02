Return-Path: <netdev+bounces-131146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 593E898CF31
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 10:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C94E91F21648
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 08:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F406E195FCE;
	Wed,  2 Oct 2024 08:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+lx96e7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99D9194ACF;
	Wed,  2 Oct 2024 08:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727858827; cv=none; b=MzJeDbf8qJO/RVohJ3Gm2UJL/OcHwbPiYJXTkEbGyuQ3Em+O9vjz6y7psHCUe61GOXyM9J1ky4AIGPu2NTU3Eh5EkRuEEcxnzfXqorliCOzFpPwjT5kUtz8/YB6YeSlcU2b79WluF1yYfHq+DVvIdJY8Jt4QVqfZzxJ9fmMf1Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727858827; c=relaxed/simple;
	bh=T06SY+FA/1uKT7e+gKN04QDv17JBT5pYP2bXjFrAIWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQyE8MZaAENCfRHQFgjzHgz2yN7mJzqMRMj7+VtCD8EvDihawjQRdYvHZFnZmIGOQIUOXiAkN8xFmoNHoc6m+mPNj8a0Is0fCKQMziShPXVk2oBJ5dtAMgiySVFQkS6k1wBmFYqxM4pB5AXSsNuaIuEjFnGBxGxHg1VIto5kUUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+lx96e7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F058DC4CEC5;
	Wed,  2 Oct 2024 08:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727858827;
	bh=T06SY+FA/1uKT7e+gKN04QDv17JBT5pYP2bXjFrAIWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X+lx96e7BhbdGGAlxY40bwtIhe1ieXI4LXzmfdPeTjA5+NtuC6uPflppTHr/FJlTQ
	 YpIEjn+BLUs2zUsMMgJJOWS/2StCubAUF01mBo8YoNWAgO0XglW4v0KNsTJk4qnQF/
	 JbVKyR+eBa6F1RXbRbX/dhA+ElGhm4o8lr2V66PZZNjHCseuE1HhLsoICi5duRRWx7
	 k4kmMEuyqlj6hHhGVvUXlcbP3Khh07zbEjSIw172FJY6VORKzv9Z/TSNrhn/KMyT/5
	 hRU7+EbPp3r2SclmIXt+4XR0RDJoYQ8zteoMum5Hzjc77Vd6ouGgsMY60sGevVJwVr
	 FcZ6Jne3OiVdQ==
Date: Wed, 2 Oct 2024 09:47:01 +0100
From: Conor Dooley <conor@kernel.org>
To: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>,
	"Joseph, Abin" <Abin.Joseph@amd.com>,
	"u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
	"elfring@users.sourceforge.net" <elfring@users.sourceforge.net>,
	"Katakam, Harini" <harini.katakam@amd.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"git (AMD-Xilinx)" <git@amd.com>
Subject: Re: [PATCH net-next 1/3] dt-bindings: net: emaclite: Add clock
 support
Message-ID: <20241002-revivable-crummy-f780adec538c@spud>
References: <1727726138-2203615-1-git-send-email-radhey.shyam.pandey@amd.com>
 <1727726138-2203615-2-git-send-email-radhey.shyam.pandey@amd.com>
 <20241001-battered-stardom-28d5f28798c2@spud>
 <MN0PR12MB59539E54E8BD46575FEC01B2B7772@MN0PR12MB5953.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LWGjWgvHc6ACTYuQ"
Content-Disposition: inline
In-Reply-To: <MN0PR12MB59539E54E8BD46575FEC01B2B7772@MN0PR12MB5953.namprd12.prod.outlook.com>


--LWGjWgvHc6ACTYuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2024 at 07:06:12PM +0000, Pandey, Radhey Shyam wrote:
> > -----Original Message-----
> > From: Conor Dooley <conor@kernel.org>
> > Sent: Tuesday, October 1, 2024 10:22 PM
> > To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>
> > Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > pabeni@redhat.com; robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel=
=2Eorg;
> > Simek, Michal <michal.simek@amd.com>; Joseph, Abin <Abin.Joseph@amd.com=
>;
> > u.kleine-koenig@pengutronix.de; elfring@users.sourceforge.net; Katakam,=
 Harini
> > <harini.katakam@amd.com>; netdev@vger.kernel.org; devicetree@vger.kerne=
l.org;
> > linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; git=
 (AMD-Xilinx)
> > <git@amd.com>
> > Subject: Re: [PATCH net-next 1/3] dt-bindings: net: emaclite: Add clock=
 support
> >=20
> > On Tue, Oct 01, 2024 at 01:25:36AM +0530, Radhey Shyam Pandey wrote:
> > > From: Abin Joseph <abin.joseph@amd.com>
> > >
> > > Add s_axi_aclk AXI4 clock support and make clk optional to keep DTB
> > > backward compatibility. Define max supported clock constraints.
> >=20
> > Why was the clock not provided before, but is now?
> > Was it automatically enabled by firmware and that is no longer done?
> > I'm suspicious of the clock being made optional, but the driver doing n=
othing other
> > than enable it. That reeks of actually being required to me.
>=20
> Traditionally these IP were used on microblaze platforms which had fixed
> clocks enabled all the time. Since AXI Ethernet Lite is a PL IP, it can a=
lso
> be used on SoC platforms like Zynq UltraScale+ MPSoC which combines=20
> processing system (PS) and user-programmable logic (PL) into the same=20
> device. On these platforms instead of fixed enabled clocks it is mandatory
> to explicitly enable IP clocks for proper functionality.=20
>=20
> It gets more interesting when the PL clock is shared between two IPs=20
> and one of the drivers is clock adopted and disable the clocks after use=
=20
> and clock framework does not know about other clock users (emaclite=20
> IP using clock) and it will turn off the clocks which would lead to=20
> hang on emaclite reg access. So, it is needed to correctly model the
> clock consumers.

That means the clock _is_ required, and should be added as such in the
binding. The older platforms having a fixed clock doesn't impact whether
or not the emaclite IP itself requires the clock to function or not.
Mark it required in the binding, although of course the driver cannot
require it for backwards compatibility reasons.

> While browsing i found a similar usecase for GMII to RGMII PL IP.
> Similar to dt-bindings: net: xilinx_gmii2rgmii: Add clock support[1]
> [1]: https://lore.kernel.org/all/4ae4d926-73f0-4f30-9d83-908a92046829@ker=
nel.org/
>=20
> In this series - I noticed that Krzysztof suggested to:
> Nope, just write the description as items in clocks, instead of
> maxItems. And drop clock names, are not needed and are kind of obvious.
>=20
> So something like the below would be fine?
>=20
> +  clocks:
> +    items:
> +      - description: AXI4 clock.

This would be fine, but your patch is not the same as the one you linked
to. It was using clock-names to provide information on the clock, yours
does not do that. If there's only one clock, there's usually little
point in having clock-names, which is why Krzysztof made that
suggestion.

Cheers,
Conor.

> > >
> > > Signed-off-by: Abin Joseph <abin.joseph@amd.com>
> > > Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> > > ---
> > >  Documentation/devicetree/bindings/net/xlnx,emaclite.yaml | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/net/xlnx,emaclite.yaml
> > > b/Documentation/devicetree/bindings/net/xlnx,emaclite.yaml
> > > index 92d8ade988f6..8fcf0732d713 100644
> > > --- a/Documentation/devicetree/bindings/net/xlnx,emaclite.yaml
> > > +++ b/Documentation/devicetree/bindings/net/xlnx,emaclite.yaml
> > > @@ -29,6 +29,9 @@ properties:
> > >    interrupts:
> > >      maxItems: 1
> > >
> > > +  clocks:
> > > +    maxItems: 1
> > > +
> > >    phy-handle: true
> > >
> > >    local-mac-address: true
> > > --
> > > 2.34.1
> > >

--LWGjWgvHc6ACTYuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZv0IhQAKCRB4tDGHoIJi
0tAqAP9ILmku/+QIzGhSUpt0Bd/94GWO6IoZgy5C2TdU/bdgxwEAsoACORHcQ/mH
mj2EfA+WpOjJp+iz9+KnsuRGccrUeQo=
=BzPo
-----END PGP SIGNATURE-----

--LWGjWgvHc6ACTYuQ--

