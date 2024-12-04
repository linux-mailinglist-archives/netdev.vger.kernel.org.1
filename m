Return-Path: <netdev+bounces-149067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7E49E3F84
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 17:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21325163905
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 16:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA35720C00C;
	Wed,  4 Dec 2024 16:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfaDex+D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35714A28;
	Wed,  4 Dec 2024 16:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733329439; cv=none; b=C9BWKrXUAJmZP7QiiCNUGxkfLy16Urm8zfJcowPO75JpAllwNSjC03CGYEDEl7639ySZaM7v8Olo1JyBAZxroUtU5LbuGTKDCixo+qZSnxQ94A1wE1RpGDJng3YWGDvq5vvAx6z95pmDHMK6HtHGaG2rG9gfwLREsqhVOnUUOoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733329439; c=relaxed/simple;
	bh=gCp3VuiSIzzhFE1yRWuwo9UmejJgL3ynt7Sw4FXSQwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwkrJWRbBMSgteALLisxVlW39/2qXABtYIx27ibxn8PKbqvWRuCeb/h04f0RkqEFZWq3I/ZBZCO96HqVOIXPBy6liRxI5Oa39fWACfhXGgGlTZ7ijqRy3dpKyCr5iOBXtZKBvF61PUJNalxhl30VD3fuJ03l/zDPr2aZrOk2WP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfaDex+D; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4349cc45219so63321355e9.3;
        Wed, 04 Dec 2024 08:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733329436; x=1733934236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZopfNxUqKzOig+vq2vgMrOIZ/FkZeqWW6Q7fCMolsnI=;
        b=UfaDex+D/fSVZtLS7GlyHgsy075cgoGZ0vVvL9xcJcRm/S3MNr2iucBaJ+NIlIbXdj
         6cByJ1/2cpY2MDRI1qzQ4Qw7oe5V4GGO8dw6vhJZFXdyp5yUd4P4k9WcZvTZfieBLHep
         QoXWjerBnaptWYpJAZ29QELydwgCH6E6+gUInreAD3lmtSchxiLYt6P/HBigb+nfBkMm
         xDIR0glKOEM4FyJdPNbFkylaYyZ2/rfjZjeXCsyv2Y0AuSLdAcWPmM41LwrSRkZZEZz1
         D/pfMJ/oZ8KCaYGnV8Nod75+/cOS80+a5D3kCj6BEjb9M3mcN4P29Tnk86ECqd2MSUiK
         a4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733329436; x=1733934236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZopfNxUqKzOig+vq2vgMrOIZ/FkZeqWW6Q7fCMolsnI=;
        b=eLIem3uU5pdlaZk4WZjXMr6c+DCvVKric8sxRjkACpaXHu/IdVNyztujA8/x8Gz2Hh
         +x/RrRP5QLLS9i5Vr7CaHHUX2dYJWlTsHO4Wk0UvX9W6PJHpxgSTlEQwgUEbJYdRl2Xa
         xxYdLqs0hwdl2sHNYG5hPD9Qe8YZpBz0ej7bZBgdhqki/X7RuERs4c4BwLGs/tXzZwWg
         iG1CL0Ug8BGBIsVNap5W2LIXcRrcCKPs1k/xIU3Ek+1ju0gyaQzGFNmXnMHYe2ghyvdJ
         wFLQQaQm/qAPM+npvX+4ycoanGlFO2qPRV+QN1gyZ6evIDKuYBZp0pjlJLfGg9WHvGUH
         9bZw==
X-Forwarded-Encrypted: i=1; AJvYcCUpcsBvG4AmUhgWDTMcaGIQ0PiXBOQS96dLqjlyhFR3WRzH7ib0jXTzjdbYUedhSajed1CRHsSx@vger.kernel.org, AJvYcCV3LuZwcuebTCaQsoie+6vmLqRab4vuNHEmukLxy/xRVp23tff49g9Qj3jt8iotuCjrsQ6Jw5W+XmPW2gQ=@vger.kernel.org, AJvYcCVvTAjlGqpDvEA2MC8HpjnGYu6nIhuzYD5Pkcj9hilpfbXnCYKmUxhwSRfMJ0SpNcWFtyeCN6IL/EVs+L0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaKiGHVNrBJIEijRohttHlx2Z5P8I6/+8fMlmFAR6vnjsEyXxZ
	rYly96sQiRKTZVw8By/ofiintsAqa6nkCwNplFAy5GJL3gTn4j6B
X-Gm-Gg: ASbGnctLa4Mh9NAi9qvXrXsqY+XUegJwasS/UK+T3nK5VA8kyirNal+He4WJtSSqb2g
	z9cE4y6lrjJlxMHh3CiGFM/ZR6/TeO5T5jfa7hX7vgGf0p68Vjoo0LenVt25+gCaU7kVLeFwfNJ
	EiUE3yspOK0VPgTgoS1mj7dEzv88vmtBtmwLdQZovnVnt5hPFbxhfn6Q8XZCu535RAG5ejm8n8x
	TCc7ondW5tScWXJfQLBYgc0Z10Msro01biVNT/eaylC0NPlFDzNtTaRMJuPiiBKB4lCrlU0Z5Ji
	dqLAp+74/4i/djPSlZ2PAGaQoaila9AykLH3
X-Google-Smtp-Source: AGHT+IEBAuqD6aE0GozRqXuDmFoNCDvwnIaAsz1vt2MpdwK3ooetePeFd9j6ErzZeQHLGJ23gIUJhA==
X-Received: by 2002:a05:600c:3b23:b0:431:1868:417f with SMTP id 5b1f17b1804b1-434d09c154fmr72688655e9.17.1733329436035;
        Wed, 04 Dec 2024 08:23:56 -0800 (PST)
Received: from orome (p200300e41f281900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d04defb7sm47745125e9.0.2024.12.04.08.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 08:23:55 -0800 (PST)
Date: Wed, 4 Dec 2024 17:23:53 +0100
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
Message-ID: <mpgilwqb5zg5kb4n7r6zwbhy4uutdh6rq5s2yc6ndhcj6gqgri@qkfr4qwjj3ym>
References: <cover.1731685185.git.pnewman@connecttech.com>
 <f2a14edb5761d372ec939ccbea4fb8dfd1fdab91.1731685185.git.pnewman@connecttech.com>
 <ed2ec1c2-65c7-4768-99f1-987e5fa39a54@redhat.com>
 <20241115135940.5f898781.parker@finest.io>
 <bb52bdc1-df2e-493d-a58f-df3143715150@lunn.ch>
 <20241118084400.35f4697a.parker@finest.io>
 <984a8471-7e49-4549-9d8a-48e1a29950f6@lunn.ch>
 <20241119131336.371af397.parker@finest.io>
 <f00bccd3-62d5-46a9-b448-051894267c7a@lunn.ch>
 <20241119144729.72e048a5.parker@finest.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qqjxn4twghzwb4kk"
Content-Disposition: inline
In-Reply-To: <20241119144729.72e048a5.parker@finest.io>


--qqjxn4twghzwb4kk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/1] net: stmmac: dwmac-tegra: Read iommu stream id
 from device tree
MIME-Version: 1.0

On Tue, Nov 19, 2024 at 02:47:29PM -0500, Parker Newman wrote:
> On Tue, 19 Nov 2024 20:18:00 +0100
> Andrew Lunn <andrew@lunn.ch> wrote:
>=20
> > > I think there is some confusion here. I will try to summarize:
> > > - Ihe iommu is supported by the Tegra SOC.
> > > - The way the mgbe driver is written the iommu DT property is REQUIRE=
D.
> >
> > If it is required, please also include a patch to
> > nvidia,tegra234-mgbe.yaml and make iommus required.
> >
>=20
> I will add this when I submit a v2 of the patch.
>=20
> > > - "iommus" is a SOC DT property and is defined in tegra234.dtsi.
> > > - The mgbe device tree nodes in tegra234.dtsi DO have the iommus prop=
erty.
> > > - There are no device tree changes required to to make this patch wor=
k.
> > > - This patch works fine with existing device trees.
> > >
> > > I will add the fallback however in case there is changes made to the =
iommu
> > > subsystem in the future.
> >
> > I would suggest you make iommus a required property and run the tests
> > over the existing .dts files.
> >
> > I looked at the history of tegra234.dtsi. The ethernet nodes were
> > added in:
> >
> > 610cdf3186bc604961bf04851e300deefd318038
> > Author: Thierry Reding <treding@nvidia.com>
> > Date:   Thu Jul 7 09:48:15 2022 +0200
> >
> >     arm64: tegra: Add MGBE nodes on Tegra234
> >
> > and the iommus property is present. So the requires is safe.
> >
> > Please expand the commit message. It is clear from all the questions
> > and backwards and forwards, it does not provide enough details.
> >
>=20
> I will add more details when I submit V2.
>=20
> > I just have one open issue. The code has been like this for over 2
> > years. Why has it only now started crashing?
> >
>=20
> It is rare for Nvidia Jetson users to use the mainline kernel. Nvidia
> provides a custom kernel package with many out of tree drivers including a
> driver for the mgbe controllers.
>=20
> Also, while the Orin AGX SOC (tegra234) has 4 instances of the mgbe contr=
oller,
> the Nvidia Orin AGX devkit only uses mgbe0. Connect Tech has carrier boar=
ds
> that use 2 or more of the mgbe controllers which is why we found the bug.

Correct. Also, this was a really stupid thing that I overlooked. I don't
recall the exact circumstances, but I vaguely recall there had been
discussions about adding the tegra_dev_iommu_get_stream_id() helper
(that this patch uses) around the time that this driver was created. In
the midst of all of this I likely forgot to update the driver after the
discussions had settled.

Anyway, I agree with the conclusion that we don't need a compatibility
fallback for this, both because it would be actively wrong to do it and
we've had the required IOMMU properties in device tree since the start,
so there can't be any regressions caused by this.

I don't think it's necessary to make the iommus property required,
though, because there's technically no requirement for these devices to
be attached to an IOMMU. They usually are, and it's better if they are,
but they should be able to work correctly without an IOMMU.

Thanks, and apologies for dropping the ball on this,
Thierry

--qqjxn4twghzwb4kk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmdQghYACgkQ3SOs138+
s6GbwA//QaUQrLioM0UTRNYWW6ecsfiMO/nk5jBbz5LbMh7211gzUPPg83dUc3w8
PnF586hTlqDo6mLikH3nc7DOt18GNUfjadV8xtLuJX6kYH/VDUEvjQaznfVpfrXo
QdsbMn8MJT6DCq9Qcjvv3shtaGlDyJY/CFKkdKUVwvaw5IXzWdtoxX5Q9vF3v/W3
fxoHRE90syhc9GmFKH9ntlt1Ku+mpNOm6pWYB6QLNTMqctjXJZsxnM+EvGqL57k7
+UCaJvfR2laTf41FkDbLGziIrHmSwoZLMIh08eyIjTGFfOvKqtpO9/a5ckCo9a+t
zjlhdWI0GzRplmw2KYxkWGboZCUrGHzNSbp2GRUKaBs0MB7UVVrVCIDJ2Vj81l4f
JoVhBQUQjNXSuQtZM3GKNq/8SkuQUfdSSt7xCw1lBMBCxXtbEtz7FvbmBjd2qx5o
8vIzqLhXQNp5QfJZT+tTtWnAIm+5GEIZG2mr/pg9CCPKqtAhugSNZc18Me/IS+CM
xXZWZLTQrfmHzUq2eTe0l9iVaTwLUf9ZDF3giHwXoyposgYTugBcHzbp10v1jB4M
L/GJKcC8Lmv1vHMtTrhRJk/UWNSL4TVC7gmcvfXPQRdPB4Q9lXFTuHs0w+ggZVi4
W2Ino7yR62yUh5iLveyTQqBAv5FT2c2EkB7TECfxyb0xGOLYpTw=
=kEPd
-----END PGP SIGNATURE-----

--qqjxn4twghzwb4kk--

