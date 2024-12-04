Return-Path: <netdev+bounces-149110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8AA9E43A1
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 19:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49614B38CE8
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 18:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF60A23919D;
	Wed,  4 Dec 2024 18:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GomGK+aG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7C33A1BF;
	Wed,  4 Dec 2024 18:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733335596; cv=none; b=TMrHBO+wKwG5UblvJBULhQXkAUiVjzDV34m1tAWcduUob/meDNopBzlw4liNanMfDfHZi27KvtIqVr8kZO02BYh4mdXvb0Quu+rmqABVBpBv//ph17WseAuFrFiJ1vvoQTiMD3xu3PK29pnqk7VbWDpDkjO4SEjWrUaFDk7COp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733335596; c=relaxed/simple;
	bh=MEH69J8J5ej1FCsWNbR7E55HsHJvluP+bGCwvVt4/+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXwljPj5zn408Ve2PXKrawrAyLL0vWdohyncQQgpUB80CjB2Qf9VTawLpY1kScYi2v3nJOAbrB1pzumGTKgWCmm/Y2lzo4o67EJ0JKIvc6VJojxj30ZZ8Tnzu0oPV6ApGmxB1B5z58TRMinriMbsnhjl1jrdjWAAopjVc5NrTHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GomGK+aG; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4349cc45219so707675e9.3;
        Wed, 04 Dec 2024 10:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733335593; x=1733940393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uyHKOxEKj03rgX35m/QxXvHrY0ktDc+PNXLib8Uap+M=;
        b=GomGK+aGwN8eY3FXtQsI8ZgHK2us2blO8IcMOMEZy7NpUM3NkMkrmFeNcD685/rkZe
         muDWt0SzAqlpVPQprEjYgchK5Mcj4TGlqdRXz3zfJtADJPtm5bmyFfdPoMwpb/cwNR6I
         qUjslW11xWKIEqnf6iQeeKWdxXXW+2tkns4t1i6ShbPoL+lya+f72cVMGyFvQsyY0xBd
         SLDWFcXFXRl4tZFvGIsRTpo9vAhKb35ae6ZvItS1cHktEAUManTMMGak74tnfKchGVS5
         /XUZAohlc0jJ70UuJgH664xzv9fJILXyZ11CqIJDztk1KN8RLgFiHguotgKohdgYgZw+
         QS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733335593; x=1733940393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyHKOxEKj03rgX35m/QxXvHrY0ktDc+PNXLib8Uap+M=;
        b=gtoO207nafccECDWbM0Ow9XpKweVvR9arBLEs5YD3JBA3TKqW9feMtG+Aa1lECAhz4
         C/2iz/VT5mYK4Agk4nfVbwj6rJFL8x0NcBMdbLTJ6+t4kDjxSn3idwXa1r07YpPqgKl1
         moA/l4NXB+yK8xXdIGndR6glLgX1mwI6X27Kkz+YV2FTR2SWRiEbSl1iuDAI3AG2j5QZ
         v6JW6QMQpQB4DRyIW+gl8RGYD8lnKi5H9GSdISivvj0QaLfxNvKCdNSUVvteCKBo1KlI
         IWTIrXVKiIZL4kgFI/xC9cdgFCjwVhBBhi0YG5LXfk0lSXgHjr5w4rssuFNzOvUkcT+e
         LRDg==
X-Forwarded-Encrypted: i=1; AJvYcCV0TbrZwOdueA8EyUXRE52RNyh/yUZmAn2THSW7aKuwzBDrsSgWOGHY5il84vXry0M9KE01KGAq@vger.kernel.org, AJvYcCVBb1M5Osbh/os/PnmhH3v05eZb3neEUXYNJxdUZ2kdrY0ux7rxkb+DIKUra0RSM6nl2t0WpTlbB2Fmu80=@vger.kernel.org, AJvYcCVb7SI0T1DhoNQtcdot7PuZIcrvm1+M6wTTl6xhlhaM4t7mi4VnfSiS2mlt1HX9c/lO7ivdG4SPO8983PI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+nuBav+M9o+pC/+qyaBjki0eAH1AnqwcAo8deTbwnQnMKdZdw
	TJ82f+iUQB/OhdlTQjUIbB+po4DEtg77Niv0GcftGFMhxF1p1NXs
X-Gm-Gg: ASbGnctI5glwTU6akzK3jsAHqL5z6vRBng2liA8orq1nXQDrLtfwInf81nqZfhDdKWF
	YmxuKiFfONx9Uf7Pkv1qNgya2EGw3ruTJISKBvwh4v5SodsQeQn7witCnpxbIZB/P1HmL5LVBLh
	nENnIMwssRNqwFN9TWr5bX1IBurf9ABJ8VquXnsiAO1lCMK9AC/gv9IFGqbt+KU7yyAhd1AUD5D
	/7CajJxwiirRQ4JFWAx/6oDdP1rv2amt9jxm2Wf7H9SdYo7N9oQjTtTDSQb1PtPxb3bC36OHtpf
	DSw7wR5I47f+2VingeXp7H4KlbLJ/Vnnl3AO
X-Google-Smtp-Source: AGHT+IHJCMa0Jw2obBkAdIaN6jxKiTpv9JchsF8d03P1qW1tmylQdi2YTYrJIpa49ocoRTyBhVpRnA==
X-Received: by 2002:a7b:c34f:0:b0:434:a923:9313 with SMTP id 5b1f17b1804b1-434d4101881mr42697335e9.25.1733335592675;
        Wed, 04 Dec 2024 10:06:32 -0800 (PST)
Received: from orome (p200300e41f281900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d5273131sm32003255e9.12.2024.12.04.10.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 10:06:32 -0800 (PST)
Date: Wed, 4 Dec 2024 19:06:30 +0100
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
Message-ID: <uad6id6omswjm7e4eqwd75c52sy5pddtxru3bcuxlukhecvj4u@klzgrws24r2q>
References: <ed2ec1c2-65c7-4768-99f1-987e5fa39a54@redhat.com>
 <20241115135940.5f898781.parker@finest.io>
 <bb52bdc1-df2e-493d-a58f-df3143715150@lunn.ch>
 <20241118084400.35f4697a.parker@finest.io>
 <984a8471-7e49-4549-9d8a-48e1a29950f6@lunn.ch>
 <20241119131336.371af397.parker@finest.io>
 <f00bccd3-62d5-46a9-b448-051894267c7a@lunn.ch>
 <20241119144729.72e048a5.parker@finest.io>
 <mpgilwqb5zg5kb4n7r6zwbhy4uutdh6rq5s2yc6ndhcj6gqgri@qkfr4qwjj3ym>
 <20241204115317.008f497c.parker@finest.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eyf27zncx4uh4ucn"
Content-Disposition: inline
In-Reply-To: <20241204115317.008f497c.parker@finest.io>


--eyf27zncx4uh4ucn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/1] net: stmmac: dwmac-tegra: Read iommu stream id
 from device tree
MIME-Version: 1.0

On Wed, Dec 04, 2024 at 11:53:17AM -0500, Parker Newman wrote:
> On Wed, 4 Dec 2024 17:23:53 +0100
> Thierry Reding <thierry.reding@gmail.com> wrote:
>=20
> > On Tue, Nov 19, 2024 at 02:47:29PM -0500, Parker Newman wrote:
> > > On Tue, 19 Nov 2024 20:18:00 +0100
> > > Andrew Lunn <andrew@lunn.ch> wrote:
> > >
> > > > > I think there is some confusion here. I will try to summarize:
> > > > > - Ihe iommu is supported by the Tegra SOC.
> > > > > - The way the mgbe driver is written the iommu DT property is REQ=
UIRED.
> > > >
> > > > If it is required, please also include a patch to
> > > > nvidia,tegra234-mgbe.yaml and make iommus required.
> > > >
> > >
> > > I will add this when I submit a v2 of the patch.
> > >
> > > > > - "iommus" is a SOC DT property and is defined in tegra234.dtsi.
> > > > > - The mgbe device tree nodes in tegra234.dtsi DO have the iommus =
property.
> > > > > - There are no device tree changes required to to make this patch=
 work.
> > > > > - This patch works fine with existing device trees.
> > > > >
> > > > > I will add the fallback however in case there is changes made to =
the iommu
> > > > > subsystem in the future.
> > > >
> > > > I would suggest you make iommus a required property and run the tes=
ts
> > > > over the existing .dts files.
> > > >
> > > > I looked at the history of tegra234.dtsi. The ethernet nodes were
> > > > added in:
> > > >
> > > > 610cdf3186bc604961bf04851e300deefd318038
> > > > Author: Thierry Reding <treding@nvidia.com>
> > > > Date:   Thu Jul 7 09:48:15 2022 +0200
> > > >
> > > >     arm64: tegra: Add MGBE nodes on Tegra234
> > > >
> > > > and the iommus property is present. So the requires is safe.
> > > >
> > > > Please expand the commit message. It is clear from all the questions
> > > > and backwards and forwards, it does not provide enough details.
> > > >
> > >
> > > I will add more details when I submit V2.
> > >
> > > > I just have one open issue. The code has been like this for over 2
> > > > years. Why has it only now started crashing?
> > > >
> > >
> > > It is rare for Nvidia Jetson users to use the mainline kernel. Nvidia
> > > provides a custom kernel package with many out of tree drivers includ=
ing a
> > > driver for the mgbe controllers.
> > >
> > > Also, while the Orin AGX SOC (tegra234) has 4 instances of the mgbe c=
ontroller,
> > > the Nvidia Orin AGX devkit only uses mgbe0. Connect Tech has carrier =
boards
> > > that use 2 or more of the mgbe controllers which is why we found the =
bug.
> >
> > Correct. Also, this was a really stupid thing that I overlooked. I don't
> > recall the exact circumstances, but I vaguely recall there had been
> > discussions about adding the tegra_dev_iommu_get_stream_id() helper
> > (that this patch uses) around the time that this driver was created. In
> > the midst of all of this I likely forgot to update the driver after the
> > discussions had settled.
> >
> > Anyway, I agree with the conclusion that we don't need a compatibility
> > fallback for this, both because it would be actively wrong to do it and
> > we've had the required IOMMU properties in device tree since the start,
> > so there can't be any regressions caused by this.
> >
> > I don't think it's necessary to make the iommus property required,
> > though, because there's technically no requirement for these devices to
> > be attached to an IOMMU. They usually are, and it's better if they are,
> > but they should be able to work correctly without an IOMMU.
> >
> Thanks for confirming from the Nvidia side! I wasn't sure if they would
> work without the iommu. That said, if you did NOT want to use the iommu
> and removed the iommu DT property then the probe will fail after my patch.
> Would we not need a guard around the writes to MGBE_WRAP_AXI_ASID0_CTRL a=
s well?

Well... frankly, I don't know. There's an override in the memory
controller which we set when a device is attached to an IOMMU. That's
usually how the stream ID is programmed. If we don't do that it will
typically default to a special passthrough stream ID (technically the
firmware can lock down those register and force them to a specific
stream ID all the time). I'm not sure what exactly the impact is of
these ASID registers (there's a few other instances where those are
needed). They are required if you want to use the IOMMU, but I don't
know what their meaning is if the IOMMU is not enabled.

There's also different cases: the IOMMU can be disabled altogether, in
which case no page tables and such exist for any device and no
translation should happen whatsoever. But there's also the case where an
IOMMU is enabled, but certain devices shouldn't attach to them. I should
make it very clear that both of these are not recommended setups and I
don't know if they'll work. And they are mostly untested. I've been
meaning, but haven't found the time, to test some of these cases.

Thierry

--eyf27zncx4uh4ucn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmdQmiMACgkQ3SOs138+
s6E9NBAAg1IQLMIDjLwoG2qSLXuu9qrgbn1s1FcJGJYi0aJ5A40jrzC2BMsmUQw+
rjMgze/1lUPdJ+p3uYQtKVkIGqNihbfjhPeY/f06tNey05/yb52eL6SXKWRKiQUQ
ndr0fNRwdLg2wx09qWHHpo05jBic5iKvW0RtVBOdNSZ2HYHAE/hXWxOyUbYlI8wg
1qtbxERJ8Tz0EivZjui3U0DqiPJwIjZ/qlcf97UNVxIqYJGvFdBdAt0mcSlb2029
tASjFveIuFi0d5VgRDNzBn6iYmK5GrXtiM1IbUPPuKkasFHHSu8NQrFJBBqWZaeQ
1YQr1Um3c4ZeTPVH52KXXdGIr/SfA1W/Ybp1B7JImuTkysUTQFcNQGiCGU8BwV7k
TNpCsJTUL9b+L+Rd0cjlieG7O9OUnvA4ikJaZqtc5qZVJVPbxctCe+p+UfG3uBfV
SgGXmBFiyYXisQJB5SpRjXgY12Tzrgy3v234c/zGZ9WjUqOAEl49O+VUvJWnXjIq
bI94Uh8+VY3PkEdvFk2W6eZ/Eolp+FM1LwBfQeOgraUHDKI8Plf5EHsXwhpF0tH9
HgZ0S6zdhYMi2AWoVNM0kJLPHFLrTlL4q6ighq4Pdn3jaxjbhaFMnkiQ3/r9IPiW
CZHmKP4gSmGVmLCBKbPOahWDtQaBVoM2GM9ZtraOG524LGqIXys=
=zKRe
-----END PGP SIGNATURE-----

--eyf27zncx4uh4ucn--

