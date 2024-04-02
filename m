Return-Path: <netdev+bounces-84068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 641518956DC
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 16:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BA2F28A55B
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 14:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4E312FF96;
	Tue,  2 Apr 2024 14:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDX7jZl7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A87A12BF20
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 14:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068463; cv=none; b=SYd/1CTf8DDnP1MkSCB6DXxtXoJWuKq3eXoiK/rENQM+LHcJ9IS7TeskvF+QT75IIURWAeAy6GJY0saF/hOWD2Aw3zsi40UrBX6oa3J4sb5bJIWpUvKyJ65Tc4D01pqaExD0ysebdPiLvOTbODZf3NHYvjkrmgiOhnq0n5yhDY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068463; c=relaxed/simple;
	bh=mEPYYlyv9uOcM/SzKft0D50DeLT0ZyyD7O2KlxAsQWc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dLkigho/GLLMRrKPJ+fbgSpl0Inez2e6v8DD6xmWfGoz1jtZC3VmmT22XgUsiHy/6eObXy8H67GTZ6raykraUMdA+dnKdi0GLRVhOXO935V5b9VfCFnC87XApcAMWJcp2/xceVEo1uywF7JM0NgsM2U4amCFzu8qrR7CT9pqqJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDX7jZl7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56BC5C433B1;
	Tue,  2 Apr 2024 14:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712068462;
	bh=mEPYYlyv9uOcM/SzKft0D50DeLT0ZyyD7O2KlxAsQWc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SDX7jZl7CzU94TyD3N+d4QFLVs6kYq6Os8LXlk6YC4IlXTQZogGnBv9UhOPWjMSU/
	 0+g43cSfo1bN4JN+FQBJeG339vKqsuQU9XzMPM1N5ODsdZKtHNZcxlTSK2+28zwU1j
	 9TF9O2f6uNerHY2iWXTiZWJw1v+XsIaTB9y1gf3n/gCV0XnkjNXujG1tLWDY2UEfc7
	 zXDhaVJ0WQKcAVx19NTwneQDLwuw1x2kiWjADDHxnbHVKCdrR/kgoWTdUUEiCwVThX
	 IoEsK2zkqKSfqxH/RmctztvA6KA6+gmlfBy5Fs8kufs+FaEx92ZV1/9uZmTdkKeSpB
	 OxXZ9fi0MOJvw==
Date: Tue, 2 Apr 2024 07:34:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
 <anthony.l.nguyen@intel.com>, <edumazet@google.com>, <pabeni@redhat.com>,
 <idosch@nvidia.com>, <przemyslaw.kitszel@intel.com>,
 <marcin.szycik@linux.intel.com>
Subject: Re: [PATCH net-next 2/3] ethtool: Introduce max power support
Message-ID: <20240402073421.2528ce4f@kernel.org>
In-Reply-To: <f7c6264e-9a16-4232-aba2-fde91eb51fb7@intel.com>
References: <20240329092321.16843-1-wojciech.drewek@intel.com>
	<20240329092321.16843-3-wojciech.drewek@intel.com>
	<20240329152954.26a7ce75@kernel.org>
	<f7c6264e-9a16-4232-aba2-fde91eb51fb7@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Apr 2024 13:25:07 +0200 Wojciech Drewek wrote:
> On 29.03.2024 23:29, Jakub Kicinski wrote:
> > On Fri, 29 Mar 2024 10:23:20 +0100 Wojciech Drewek wrote: =20
> >> Some modules use nonstandard power levels. Adjust ethtool
> >> module implementation to support new attributes that will allow user
> >> to change maximum power.
> >>
> >> Add three new get attributes:
> >> ETHTOOL_A_MODULE_MAX_POWER_SET (used for set as well) - currently set
> >>   maximum power in the cage =20
> >=20
> > 1) I'd keep the ETHTOOL_A_MODULE_POWER_ prefix, consistently.
> >=20
> > 2) The _SET makes it sound like an action. Can we go with
> >    ETHTOOL_A_MODULE_POWER_MAX ? Or ETHTOOL_A_MODULE_POWER_LIMIT?
> >    Yes, ETHTOOL_A_MODULE_POWER_LIMIT
> >         ETHTOOL_A_MODULE_POWER_MAX
> >         ETHTOOL_A_MODULE_POWER_MIN
> >    would sound pretty good to me. =20
>=20
> Makes sense, although ETHTOOL_A_MODULE_POWER_LIMIT does not say if
> it's max or min limit. What about:
> ETHTOOL_A_MODULE_POWER_MAX_LIMIT
> ETHTOOL_A_MODULE_POWER_UPPER_LIMIT

Is it possible to "limit" min power? =F0=9F=A7=90=EF=B8=8F
This is not HTB where "unused power" can go to the sibling cage...
> >> +		} else if (power_new.max_pwr_set < power.min_pwr_allowed) {
> >> +			NL_SET_ERR_MSG(info->extack, "Provided value is lower than minimum=
 allowed");
> >> +			return -EINVAL;
> >> +		}
> >> +	}
> >> +
> >> +	ethnl_update_policy(&power_new.policy,
> >> +			    tb[ETHTOOL_A_MODULE_POWER_MODE_POLICY], &mod);
> >> +	ethnl_update_u8(&power_new.max_pwr_reset,
> >> +			tb[ETHTOOL_A_MODULE_MAX_POWER_RESET], &mod); =20
> >=20
> > I reckon reset should not be allowed if none of the max_pwr values=20
> > are set (i.e. most likely driver doesn't support the config)? =20
>=20
> Hmmm, I think we can allow to reset if the currently set limit is the def=
ault one.
> Right now only the driver could catch such scenario because we don't have=
 a parameter
> that driver could use to inform the ethtool about the default value.
> I hope that answers your question since I'm not 100% sure if that's what =
you asked about :)

Let me put it differently. How do we know that the driver doesn't
support setting the power policy? AFAIU we assume driver supports
it when it reports min_pwr_allowed || max_pwr_allowed from get.
If that's not the case we should add a cap bit like
cap_link_lanes_supported.

So what I'm saying is that if driver doesn't support the feature,
we should error out if user space gave us any=20
tb[ETHTOOL_A_MODULE_MAX_POWER* attribute.

> >> +	if (!mod)
> >>  		return 0;
> >> =20
> >> +	if (power_new.max_pwr_reset && power_new.max_pwr_set) { =20
> >=20
> > Mmm. How is that gonna work? The driver is going to set max_pwr_set
> > to what's currently configured. So the user is expected to send
> > ETHTOOL_A_MODULE_MAX_POWER_SET =3D 0
> > ETHTOOL_A_MODULE_MAX_POWER_RESET =3D 1
> > to reset? =20
>=20
> Yes, that was my intention. Using both of those attributes at the same ti=
me is not allowed.

To be clear the code is:

 	ret =3D ops->get_module_power_cfg(dev, &power, info->extack);
 	if (ret < 0)
 		return ret;

	power_new.max_pwr_set =3D power.max_pwr_set;

	ethnl_update_u32(&power_new.max_pwr_set,
			 tb[ETHTOOL_A_MODULE_MAX_POWER_SET], &mod);
 	// ...
=20
	if (power_new.max_pwr_reset && power_new.max_pwr_set) {

so if driver reports .max_pwr_set from get we may fall into this if
I think you got it but anyway..

