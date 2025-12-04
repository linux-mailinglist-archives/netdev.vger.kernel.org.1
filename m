Return-Path: <netdev+bounces-243508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF80BCA2CE2
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 09:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1600530F03CA
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 08:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6DA33372D;
	Thu,  4 Dec 2025 08:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="eebi5r8t"
X-Original-To: netdev@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11B03321B0
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 08:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764836523; cv=none; b=CAqEWEQT4oQ/kTrd1hkKZvMsFAasdtDNNXyiQWkXhyhlDMgYiJLQ5OsbPpMELg8nmi7a3fUDYGmGs+/xJaLrVG3IsJ/CnKOyo3ufbRA3Zj2324LIzwpkQ27Mf62g4u+u5BMpJGLU7LhBu8EljGyAlFqCyjNIW1A+KZ90caolpCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764836523; c=relaxed/simple;
	bh=2X6lw2n+LbAnJzEAELTikYXi0+ET+Y+lUnw5yNaBnI8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g0HYfu7r6ohf23EDZEfF1hcldpj42+s8UeHuUfBswg/9T4CfqoBfYGVHVaGf+UdmSaMkSQoP0mR3XFOQEML6Uvy2yWK85MoaLOobnbwdO/m/l4CKErQupqgjrOO/dc7WVflcRPBea+/oTT6gWtF/UgZ5wQgtidAvrZXea1vT+k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=eebi5r8t; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=eebi5r8t;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10e2:d900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 5B48Le232613890
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 4 Dec 2025 08:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1764836500; bh=/HjBbQNs/+0N2sNMVYre5zf3eSKB8FE/w+r++Jr3mvw=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=eebi5r8tdGSWg2dgJwxKfaiIxq8lFy1HmwFUArRQuzNBxLinZ/CHwI5t3OMT6WQGp
	 HeZCXN8hASfMtmspanu1cdxLqunSus1QM5Hx83WH1j3B9XnPK4EdU0vx9pCPyiS0l4
	 NrscPy7ciLMjlU370NEhAA3Q9jlBAZ9Y4VY+PBZk=
Received: from miraculix.mork.no ([IPv6:2a01:799:10e2:d90a:6f50:7559:681d:630c])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 5B48LefO851748
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 4 Dec 2025 09:21:40 +0100
Received: (nullmailer pid 1797309 invoked by uid 1000);
	Thu, 04 Dec 2025 08:21:40 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "Lucien.Jheng" <lucienzx159@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>
Subject: Re: [RFC] net: phy: air_en8811h: add Airoha AN8811HB support
In-Reply-To: <20251203232402.oy4pbphj4vsqp5lb@skbuf> (Vladimir Oltean's
	message of "Thu, 4 Dec 2025 01:24:02 +0200")
Organization: m
References: <20251202102222.1681522-1-bjorn@mork.no>
	<20251202102222.1681522-1-bjorn@mork.no>
	<20251203232402.oy4pbphj4vsqp5lb@skbuf>
Date: Thu, 04 Dec 2025 09:21:39 +0100
Message-ID: <87sedq4pyk.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.4.3 at canardo.mork.no
X-Virus-Status: Clean

Vladimir Oltean <vladimir.oltean@nxp.com> writes:
> On Tue, Dec 02, 2025 at 11:22:22AM +0100, Bj=C3=B8rn Mork wrote:
>> @@ -967,32 +1157,61 @@ static int en8811h_probe(struct phy_device *phyde=
v)
>>         return 0;
>>  }
>>=20
>> -static int en8811h_config_serdes_polarity(struct phy_device *phydev)
>> +static bool airphy_invert_rx(struct phy_device *phydev)
>>  {
>>         struct device *dev =3D &phydev->mdio.dev;
>> -       int pol, default_pol;
>> -       u32 pbus_value =3D 0;
>> +       int default_pol  =3D PHY_POL_NORMAL;
>>=20
>> -       default_pol =3D PHY_POL_NORMAL;
>>         if (device_property_read_bool(dev, "airoha,pnswap-rx"))
>>                 default_pol =3D PHY_POL_INVERT;
>
> I think we can discuss whether a newly added piece of hardware (at least
> from the perspective of mainline Linux) should gain compatibility with
> deprecated device tree properties or not. My concern is that if I'm soft
> on grandfathered deprecated properties, their replacements are never
> going to be used.

Wasn't sure about this.  Now I am :-)

I'll drop the deprecated properties.

>> -       pol =3D phy_get_rx_polarity(dev_fwnode(dev), phy_modes(phydev->i=
nterface),
>> -                                 PHY_POL_NORMAL | PHY_POL_INVERT, defau=
lt_pol);
>> -       if (pol < 0)
>> -               return pol;
>> -       if (pol =3D=3D PHY_POL_INVERT)
>> -               pbus_value |=3D EN8811H_POLARITY_RX_REVERSE;
>> +       return phy_get_rx_polarity(dev_fwnode(dev), phy_modes(phydev->in=
terface),
>> +                                  PHY_POL_NORMAL | PHY_POL_INVERT, defa=
ult_pol)
>> +               =3D=3D PHY_POL_INVERT;
>
> The idea in my patches was that phy_get_rx_polarity() can return a
> negative error code (memory allocation failure, unsupported device tree
> property value like PHY_POL_AUTO, etc), which was propagated as such,
> and failed the .config_init().
>
> In your interpretation, no matter which of the above error cases took
> place, for all you care, they all mean "don't invert the polarity", and
> the show must go on. The error path that I was envisioning to bubble up
> towards the topmost caller, to attract attention that something is
> wrong, is gone.

Right.  Sorry about that.  Tried too hard to factor out the common
parts.

Will drop the refactoring. and implement error handling for the new chip
as well. Will be cleaner anyway without the deprecated properties.

> It's a bit unfortunate that in C we can't just throw an exception and
> whoever handles it handles it, but since the phy_get_rx_polarity() API
> isn't yet merged, I'd like to raise the awkwardness of error handling as
> a potential concern.
>
> You could argue that phy_get_rx_polarity() is doing too much - what's
> its business in getting the supported polarities and default polarity
> from you - can't you test by yourself if you support the value that's in
> the device tree, or fall back to a default value if nothing's there?
> Maybe, but even with these things moved out of phy_get_rx_polarity(), I
> still couldn't hide the fact that there's memory allocation inside,
> which can fail and return an error code. So I decided that if there's an
> error to handle anyway, I'd rather push the handling of unsupported
> polarities to the helper too, such that the only error that you need to
> handle is in one place. But you _do_ need to handle it.

True. Much, much better to return an error from driver probe than having
to debug arbitrary polarity mismatches..


Bj=C3=B8rn

