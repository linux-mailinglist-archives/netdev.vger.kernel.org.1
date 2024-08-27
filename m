Return-Path: <netdev+bounces-122512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D8F9618F3
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 23:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E956B21EB7
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 21:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DB8185941;
	Tue, 27 Aug 2024 21:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJ85tb7G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C375158DCC
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 21:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724792633; cv=none; b=Olp8ha80ecqpIsQrH1/IXRGnLDTkgt2W/bduKBPksJwsivadZ5lGdYOxQAMIi39ErAXfr+Ei5VpQUmuqkt8zzGVKgjo2y8fQL0OGXH8H2B0hzzRQ659av1HzKenEknhFwEb04Nsua4guaozRc12oYTROrCdap8TJuV+ulALhVoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724792633; c=relaxed/simple;
	bh=UFXrWUwqyC2Wn8aGisnDXwFW5W6O65nELHA3IwT/T4U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WMdbb5et6kGYYE7doxhWNBfHdltcXZvLbBM39izzMl2li7wQU0BYpa/hNE4fz2sQQ4baLMFGll8sbdLgN/46f0z5AgRuyXFn40f/QXrd/E8602oXon5Pqk6Z86/wpwakjYZ8DfbnvPlSMG/Wj//e+7GwzDMw/G8jdm7QMZyW5cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJ85tb7G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32893C4AF19;
	Tue, 27 Aug 2024 21:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724792632;
	bh=UFXrWUwqyC2Wn8aGisnDXwFW5W6O65nELHA3IwT/T4U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YJ85tb7GFJGvtu0tFUTCOM0BCgMQs6sgaOyZ2gPpACgpZNAAnzyoNdUjPgiWMt0Vl
	 O9H/eAk+95aXDsAum25sNGs0DZes5ElcfCTSmitRXHoekCn5yf8ZbxVwFppDnwZ8Hi
	 k3phqSLzCzUNslYolZhsSDXjlByPDhfObA9rv2LxpNssw3dQpTxeFi284FU5aPhCR5
	 SblAo5UHgEFyegRy5J1cgmrxKnrfJpYUHF+1Jf7MXL1MSxTM2FNuaxblxb07BP08XQ
	 axQR1Kqc3kD1cC+T2lTjgVmqdIpHsOSv9PzW4wMdMyDeIyKufSOB2FzHdQOuGOzHoJ
	 MqUpBvx95Cd1A==
Date: Tue, 27 Aug 2024 14:03:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>
Subject: Re: [PATCH v3 03/12] net-shapers: implement NL get operation
Message-ID: <20240827140351.4e0c5445@kernel.org>
In-Reply-To: <CAF6piCL1CyLLVSG_jM2_EWH2ESGbNX4hHv35PjQvQh5cB19BnA@mail.gmail.com>
References: <ZsMyI0UOn4o7OfBj@nanopsycho.orion>
	<47b4ab84-2910-4501-bbc8-c6a9b251d7a5@redhat.com>
	<Zsco7hs_XWTb3htS@nanopsycho.orion>
	<20240822074112.709f769e@kernel.org>
	<cc41bdf9-f7b6-4b5c-81ad-53230206aa57@redhat.com>
	<20240822155608.3034af6c@kernel.org>
	<Zsh3ecwUICabLyHV@nanopsycho.orion>
	<c7e0547b-a1e4-4e47-b7ec-010aa92fbc3a@redhat.com>
	<ZsiQSfTNr5G0MA58@nanopsycho.orion>
	<a15acdf5-a551-4fb2-9118-770c37b47be6@redhat.com>
	<ZsxLa0Ut7bWc0OmQ@nanopsycho.orion>
	<432f8531-cf4a-480c-84f7-61954c480e46@redhat.com>
	<20240827075406.34050de2@kernel.org>
	<CAF6piCL1CyLLVSG_jM2_EWH2ESGbNX4hHv35PjQvQh5cB19BnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Aug 2024 22:43:09 +0200 Paolo Abeni wrote:
> >> The main fact is that we do not agree on the above point - unify the
> >> shaper_ops between struct net_device and struct devlink.
> >>
> >> I think a 3rd party opinion could help moving forward.
> >> @Jakub could you please share your view here? =20
> >
> > I don't mind Jiri's suggestion. Driver can declare its own helper:
> >
> > static struct drv_port *
> > drv_shaper_binding_to_port(const struct net_shaper_binding *binding)
> > {
> >       if (binding->type =3D=3D NET_SHAPER_BINDING_TYPE_NETDEV)
> >               return /* netdev_priv() ? */;
> >       if (binding->type =3D=3D NET_SHAPER_BINDING_TYPE_DEVLINK_PORT)
> >               return /* container_of() ? */;
> >       WARN_ONCE();
> >       return NULL;
> > }
> >
> > And call that instead of netdev_priv()? =20
>=20
> As I wrote this does not look like something that would help
> de-deuplicate any code, but since you both seem to agree...

To be clear. Given the helper above you can replace:

	struct iavf_adapter *adapter =3D netdev_priv(dev);

with:

	struct iavf_adapter *adapter =3D iavf_from_shaper_handle(handle);

In all the callbacks, and callbacks can now take devlink or other
"handles".

> Double checking before I rewrote a significant amount of the core code:
>=20
> In the NL API, I will replace ifindex with binding, the latter will
> include nested attributes ifindex, bus_name
> and dev_name.

Any mention of the netlink API makes me worried that the "internal
representation should be separate from the uAPI" point is not
agreed on or at least not understood :( The NL API does not need other
object types. And there's currently no uAPI gap for devlink, AFAIK.
So the conversation about "handles" if quite forward-looking.

> Note that 'struct net_shaper_binding' must include a =E2=80=98struct devl=
ink
> *=E2=80=99 as opposed to a
> =E2=80=98struct devlink_port *=E2=80=99, as mentioned in the code snippet=
 so far, or
> we will have to drop the
> shaper cache and re-introduce a get() operation.
>=20
> The ops will try to fetch the net_device or devlink according to the
> provided attributes.
> At the moment the ops will error out with ENOTSUP for netlink object.

No need to error out. Driver must not receive calls with object types
they don't support (we can add capabilities for this, later on, and
core should check, or do what Jiri suggests and just hook the ops into
different structs).

> Most core helpers
> will be re-factored to accept a 'binding *' argument in place of a
> 'struct net_device *'.
>=20
> Full netlink support (for the brave that will implement it later) will
> likely require at least an
> additional scope (devlink_port), include the net_shaper_ops and
> net_shaper_data inside
> struct devlink, and likely code adaptation inside the core.

Back to uAPI worries. FWIW I think that how we pass the handle to
drivers is of relatively little importance. It's small amount of
mechanical work to change it later. But you asked me about the proposal
so I answered. To me representing the other shaper APIs in terms of=20
the new driver facing API *within netdev* is more important.

Literally the only change I would have expected based on this branch of
the conversation is slight adjustment to the parameters to ops. Nothing
else. No netlink changes. Only core change would be to wrap the ops.

