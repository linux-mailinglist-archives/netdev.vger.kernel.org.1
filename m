Return-Path: <netdev+bounces-149763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE4C9E7505
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 17:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73AD71884FDA
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 16:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5039F2066EE;
	Fri,  6 Dec 2024 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtQxGYUl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2CE1C3C1F;
	Fri,  6 Dec 2024 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733500870; cv=none; b=tN3ahkyYgPVXZeiFYEmwsqWKQjboSs2DYMll7D3VRKimL7Du9lT2+F4em1Ea3O3fO6v3CUH1gtMUnun1r7LAplQhH0s44RB4+vt1pUIDBFApmwZy+QJzzYgvgiEtIxyoFtwi/hBsnnncNMTDny5Ux7SeQ7DUG5eIK60EwSf4kjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733500870; c=relaxed/simple;
	bh=nkHyVXn9hwFXexQmmZfPzkG3wrfdV7n6XFRR49xBgAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSzrfM7opak6+C+Xo377LpQGm8g+x+yEb+ugCwWWNRTz0mcF6Vr9xpqDqcZKyF4DjB7i0S5oN1TJohaMP9eSxMbArUs5kU5BzeDh3uYRU1vCfqfnQAmfaNTjt/iYTMd11gx/zVEvvw9vtFmhLQfmEaRGu4KCiZMYM31FnP9S9Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtQxGYUl; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385e0e224cbso1162678f8f.2;
        Fri, 06 Dec 2024 08:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733500866; x=1734105666; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/7tkMRv0LfEGKrhCAZqfBnV77h2o33uvqq7zCrfO604=;
        b=dtQxGYUl/CxlkW6aFW38aqCvMRekn60Pxy31gveirKiIs7glyfNIDCSXZjpjX2UFM5
         JR45yc91Rix2r/VvyvKREG6aO7tq9/btHjEB6VUms2Yu/nbiK2im1f0YXEM2uP/G+ahT
         bklAvBv3xO1kLZOkxMEH0jJT8nSD7kB4B/nYvshRsIoraoMB6QdFwpc7DF/xVmz8zF+g
         NtUc0fgX5wPNSmSCWyygfMaAds0e4G2Ab71ZMC7eRFw72sldVbuYQdwIzGn7ox62jxx5
         LkD7D/w+QAUO4yzK7ABSzFFzRZdICodbODnN3Xio6DZOoOszJF46asAZQINcdC4RdBUS
         cOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733500866; x=1734105666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7tkMRv0LfEGKrhCAZqfBnV77h2o33uvqq7zCrfO604=;
        b=sr2ux14jRIRSaJvI8NxIuJGaCKamix2KG3hZj2ncCOsagZ7Euns8u4IR8bvA025sAG
         J4TECaPpYfI+HZDkOIfOFE5E07ll57xQomSw9hddoAt36GN9lWvn3JkCtqg4Dnb9X2SW
         CPOlZsFcmD2WoY2qLiDU6+2/Uc+F010f1V1hyAfzpuhAXMjgrPaDeGUVb70oNri7sum7
         D+mETKIqmYsqv8nvQXTNZgTumzlO9QUS1YI5KRJlIRZH9RPuPwn4euX4GxEeu7Kz38qY
         LrK7h3bM2q6HprofYnlWJDbUG0YpafEXM73iDI2Kt++BC1wZgZg6LtjNRbSr2whsrMwr
         gA4A==
X-Forwarded-Encrypted: i=1; AJvYcCVYCwBSagrDLOGY1S1HXN5q/KIZIH2NVGAuEhKeekFXKyWfk2igKSoVu2NZOUmRpM8CKrZyIC1WbIM+1lY=@vger.kernel.org, AJvYcCVZe5SWxyy6PoKl+AYXzu5rVk73JZrSjP7Jx8wt8mt2Vc6ybVE37QtXJ9B5Dy/HVrYKemJoJvio@vger.kernel.org, AJvYcCXYwBY39ynbhsavBy4nEVfkeBnBBOmTj5tz+dND2GFIDf6DJgPudyo1KgoHE4foahAXCfDFuAXJwRbKWqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfEfRSbStzEyV1jDZ1DydzABCwm+IBecykYNPaadIms9VKFDRN
	0GYQNbBRXpIUxnWZXuXERylRjdu75y3Or7mmqfwzmjEgEgDn0zLE
X-Gm-Gg: ASbGncswJiaC119rL6OL/DJeS4TJucjQqU+6HSt5hddt7X87UaecNKSf9BayYNAqkjn
	tZ1V8SxbXy8LrMavr5cbMWi/HxPazQcsDm/jxdLLoYwx6kch/uJvFyB47Ie3+F0pVxTeMLJtKuq
	gDrK7gbVpLRYaI/fS5/aQqZSRv1NxqbsW3XyX04IJfKmx7rn+j533urTSMA9mrVKzYTyB4tYcKP
	G4+e2YNPcnanwifL3TP70IBAdYUsLr1OYLUj+ZVEr3e+tGj+dHRbN9wOD9q3o8vCVLAwWzhl9eM
	2kaY/RvOcBQtGhB3bhmMdZaElKDmDVN3TBPJ
X-Google-Smtp-Source: AGHT+IHJ+/I98a2ypemaHSTMrtZKSn49UTYaf90HXKPusJY9lOrQVLFcHEdHzAXrYhC/yZzmSCrF+g==
X-Received: by 2002:a05:6000:4704:b0:385:e3d3:be1b with SMTP id ffacd0b85a97d-3862b3643aamr2563833f8f.28.1733500865570;
        Fri, 06 Dec 2024 08:01:05 -0800 (PST)
Received: from orome (p200300e41f281900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da0dc152sm60226915e9.25.2024.12.06.08.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 08:01:03 -0800 (PST)
Date: Fri, 6 Dec 2024 17:01:01 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Parker Newman <parker@finest.io>
Cc: Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v1 1/1] net: stmmac: dwmac-tegra: Read iommu stream id
 from device tree
Message-ID: <vyzrfrkvwwbi66zemgjywdzpk75mebr47vxaon5jwnn2vprahl@ndzjlez3ywgv>
References: <bb52bdc1-df2e-493d-a58f-df3143715150@lunn.ch>
 <20241118084400.35f4697a.parker@finest.io>
 <984a8471-7e49-4549-9d8a-48e1a29950f6@lunn.ch>
 <20241119131336.371af397.parker@finest.io>
 <f00bccd3-62d5-46a9-b448-051894267c7a@lunn.ch>
 <20241119144729.72e048a5.parker@finest.io>
 <mpgilwqb5zg5kb4n7r6zwbhy4uutdh6rq5s2yc6ndhcj6gqgri@qkfr4qwjj3ym>
 <20241204115317.008f497c.parker@finest.io>
 <uad6id6omswjm7e4eqwd75c52sy5pddtxru3bcuxlukhecvj4u@klzgrws24r2q>
 <20241206084203.2502ab95.parker@finest.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4qy5wpkxzelrrs53"
Content-Disposition: inline
In-Reply-To: <20241206084203.2502ab95.parker@finest.io>


--4qy5wpkxzelrrs53
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/1] net: stmmac: dwmac-tegra: Read iommu stream id
 from device tree
MIME-Version: 1.0

On Fri, Dec 06, 2024 at 08:42:03AM -0500, Parker Newman wrote:
> On Wed, 4 Dec 2024 19:06:30 +0100
> Thierry Reding <thierry.reding@gmail.com> wrote:
>=20
> > On Wed, Dec 04, 2024 at 11:53:17AM -0500, Parker Newman wrote:
> > > On Wed, 4 Dec 2024 17:23:53 +0100
> > > Thierry Reding <thierry.reding@gmail.com> wrote:
> > >
> > > > On Tue, Nov 19, 2024 at 02:47:29PM -0500, Parker Newman wrote:
> > > > > On Tue, 19 Nov 2024 20:18:00 +0100
> > > > > Andrew Lunn <andrew@lunn.ch> wrote:
> > > > >
> > > > > > > I think there is some confusion here. I will try to summarize:
> > > > > > > - Ihe iommu is supported by the Tegra SOC.
> > > > > > > - The way the mgbe driver is written the iommu DT property is=
 REQUIRED.
> > > > > >
> > > > > > If it is required, please also include a patch to
> > > > > > nvidia,tegra234-mgbe.yaml and make iommus required.
> > > > > >
> > > > >
> > > > > I will add this when I submit a v2 of the patch.
> > > > >
> > > > > > > - "iommus" is a SOC DT property and is defined in tegra234.dt=
si.
> > > > > > > - The mgbe device tree nodes in tegra234.dtsi DO have the iom=
mus property.
> > > > > > > - There are no device tree changes required to to make this p=
atch work.
> > > > > > > - This patch works fine with existing device trees.
> > > > > > >
> > > > > > > I will add the fallback however in case there is changes made=
 to the iommu
> > > > > > > subsystem in the future.
> > > > > >
> > > > > > I would suggest you make iommus a required property and run the=
 tests
> > > > > > over the existing .dts files.
> > > > > >
> > > > > > I looked at the history of tegra234.dtsi. The ethernet nodes we=
re
> > > > > > added in:
> > > > > >
> > > > > > 610cdf3186bc604961bf04851e300deefd318038
> > > > > > Author: Thierry Reding <treding@nvidia.com>
> > > > > > Date:   Thu Jul 7 09:48:15 2022 +0200
> > > > > >
> > > > > >     arm64: tegra: Add MGBE nodes on Tegra234
> > > > > >
> > > > > > and the iommus property is present. So the requires is safe.
> > > > > >
> > > > > > Please expand the commit message. It is clear from all the ques=
tions
> > > > > > and backwards and forwards, it does not provide enough details.
> > > > > >
> > > > >
> > > > > I will add more details when I submit V2.
> > > > >
> > > > > > I just have one open issue. The code has been like this for ove=
r 2
> > > > > > years. Why has it only now started crashing?
> > > > > >
> > > > >
> > > > > It is rare for Nvidia Jetson users to use the mainline kernel. Nv=
idia
> > > > > provides a custom kernel package with many out of tree drivers in=
cluding a
> > > > > driver for the mgbe controllers.
> > > > >
> > > > > Also, while the Orin AGX SOC (tegra234) has 4 instances of the mg=
be controller,
> > > > > the Nvidia Orin AGX devkit only uses mgbe0. Connect Tech has carr=
ier boards
> > > > > that use 2 or more of the mgbe controllers which is why we found =
the bug.
> > > >
> > > > Correct. Also, this was a really stupid thing that I overlooked. I =
don't
> > > > recall the exact circumstances, but I vaguely recall there had been
> > > > discussions about adding the tegra_dev_iommu_get_stream_id() helper
> > > > (that this patch uses) around the time that this driver was created=
=2E In
> > > > the midst of all of this I likely forgot to update the driver after=
 the
> > > > discussions had settled.
> > > >
> > > > Anyway, I agree with the conclusion that we don't need a compatibil=
ity
> > > > fallback for this, both because it would be actively wrong to do it=
 and
> > > > we've had the required IOMMU properties in device tree since the st=
art,
> > > > so there can't be any regressions caused by this.
> > > >
> > > > I don't think it's necessary to make the iommus property required,
> > > > though, because there's technically no requirement for these device=
s to
> > > > be attached to an IOMMU. They usually are, and it's better if they =
are,
> > > > but they should be able to work correctly without an IOMMU.
> > > >
> > > Thanks for confirming from the Nvidia side! I wasn't sure if they wou=
ld
> > > work without the iommu. That said, if you did NOT want to use the iom=
mu
> > > and removed the iommu DT property then the probe will fail after my p=
atch.
> > > Would we not need a guard around the writes to MGBE_WRAP_AXI_ASID0_CT=
RL as well?
> >
> > Well... frankly, I don't know. There's an override in the memory
> > controller which we set when a device is attached to an IOMMU. That's
> > usually how the stream ID is programmed. If we don't do that it will
> > typically default to a special passthrough stream ID (technically the
> > firmware can lock down those register and force them to a specific
> > stream ID all the time). I'm not sure what exactly the impact is of
> > these ASID registers (there's a few other instances where those are
> > needed). They are required if you want to use the IOMMU, but I don't
> > know what their meaning is if the IOMMU is not enabled.
> >
> > There's also different cases: the IOMMU can be disabled altogether, in
> > which case no page tables and such exist for any device and no
> > translation should happen whatsoever. But there's also the case where an
> > IOMMU is enabled, but certain devices shouldn't attach to them. I should
> > make it very clear that both of these are not recommended setups and I
> > don't know if they'll work. And they are mostly untested. I've been
> > meaning, but haven't found the time, to test some of these cases.
> >
>=20
> Yes I agree, all of those situations are very niche and not recommended f=
or
> a Tegra platform that should always have the iommu enabled anyways. Addin=
g an
> iommu bypass would probably be outside of the scope of this patch.
>=20
> I will not add a patch marking the iommu as required in the device tree
> bindings when I submit v2 unless anyone else feels different.

I was able to find a bit more information on this. Starting with
Tegra234 it's usually no longer possible to even enable bypass. It can
still be done, but it needs to be carefully coordinated between the
secure bootloader/firmware and the OS. Basically the secure firmware
can lock down the ability to bypass the IOMMU. If the firmware was
configured to allow bypass, the driver can then do so by writing the
special stream ID 0x7f into the stream ID register.

On these newer chips the memory controller override no longer has any
effect and writing the per-device stream ID registers is the only way to
attach to the IOMMU.

There's still the case where you can disable the IOMMU altogether, in
which case the IOMMU will still be bypassed, no matter what the firmware
did. My understanding is that it doesn't matter in those cases whether
we write the stream ID registers or not, they will simply get ignored.
With one exception perhaps being the bypass SID. If you write that, then
there's a protection mechanism that kicks in.

Well, after all this this still isn't entirely clear to me, but I think
what it means in a nutshell is that a) we'll want to keep the IOMMU
always on for security and because the firmware is by default configured
to not allow bypassing, b) IOMMU isn't strictly required because the
IOMMU might be completely disabled and c) we shouldn't need to
conditionalize the stream ID register writes.

That said, the tegra_dev_iommu_get_stream_id() function returns a bool
specifically to support the latter case. So the intention with the
design was that drivers would call that function and only need to write
the stream ID register if it returns true. That's not always great
because you may want (or need) to rewrite the register after suspend/
resume, in which case you probably want to resort to a cached value
rather than call that API. On the other hand the API is quite simple, so
it could serve as a cache as well.

Meh.

Thierry

--4qy5wpkxzelrrs53
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmdTH7oACgkQ3SOs138+
s6G3sQ//aw//CDbWsQhcT7/wXSO2FY6HaMU2iv0+UrpgeJbtICSJ5YRJJcsQr6VQ
uPcbHKCBjmLtUMoA6g1Kk2vIyPpUvxCmIQ++97z80fqqwkgrXn4wxt7KL6kYb0kH
Nd19oWfu1r5+uyAYza8VoyqAzpEQMv2imPJsKtKqaXWZCJD5GSyWGuuhT0XhJ8CX
222Gdj6W0MhmyubE/RoJYXW6cxWkDuL/a+LZj0OLiH0+S1dsvFfByEizPmhdBgzR
uR0PdcFLEM1ezvWBwrYBoL+Uo1I4djuysa/2/IbgEjOuSdb7WAkWmrjST2afFhzL
Nuy8qDhPpm/EZgvxKUip/1k6LtdXvtrtud8DTyqXNQfrXeAAfeODz9RIRCHbC0x3
9P6BLpqn+Df27lXlXCEK8EGPCAo482/N2b3RlgJsw/yQAFUfKlIjwDddvnjvaikA
BqxI8VLkk0w6pg7FEagOlLPO+NyM4zJbdqshKNWdNwNuVSjIX9ZyzZpiJahh4C5B
35RNi+xtbkY2T1zJN2lgpwOSsq96i7hZRXa0l6iUXRHJYlFLtHiRdg/ZBsTiAp3a
TZHY9ueGU7yOD104d3FugpcENCpwk8RyXeih4mKsnmCJ4DSKAmSHb1CBrhaEtEDH
x6VRrs3pav66ga3WrAIg+k5H0d+dAT1QJqmYotAWYj+ObOa4r9o=
=5WTo
-----END PGP SIGNATURE-----

--4qy5wpkxzelrrs53--

