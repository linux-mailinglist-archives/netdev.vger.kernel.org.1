Return-Path: <netdev+bounces-160779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 848D8A1B6AF
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 14:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31C2B3ADDFD
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 13:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1361DA23;
	Fri, 24 Jan 2025 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTnftZVZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6DAC8DF;
	Fri, 24 Jan 2025 13:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737724564; cv=none; b=APbTKnrFTVDnwNRBzBOBXCERoGCdABXTLsgRnbUG5RPdQSZ76n7OadRVfk+S7BAsdKFEmiZIIuU2o8GuM3h8j/PM1mEdrXVGe6ijF5SiuobgQrmqt9gD7kuPd+zDnBdMajt1AJ6b88PEC//D4IZ2uLcGCnCuZQ/XdRjKUdHpI+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737724564; c=relaxed/simple;
	bh=/aG8i22svawPqpWy7vsFnq54xmVSv7aeh28lR3oZEzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmNHWevNbkkzgRKGwJuT4LV9qWzi4W+BlRmODhKnGv4+Z3yHpRpcdRlsRWWZUjDLh8bJrk22ZGbhNTbk36kiUwu29XNuV/PfftpaaaUAx0IV7yxFPBmnLKWLF6sf2Ip3mv0mE8gLf9L3u6j/DuCAoGJqp0Bk8E3jI378/Kzggw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTnftZVZ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43635796b48so13880885e9.0;
        Fri, 24 Jan 2025 05:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737724561; x=1738329361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZAh71u7iDW5TgFuwIN4/oX/du7eXN1HEZL6hdOP2kw=;
        b=WTnftZVZv/8zPQZlu7oKlPPZJ1/NeY111GqaIMNqGsjwgmtQej14uAXm9YeILmi7mL
         TZQeTb5Xd/Sws1Sw2Xq9yeKzQhpL+q49Z2ey5gTk7e0nXqzriZkrTfzcMYhC4YEsjqsb
         JZUpqrmi2ApZRgKZFtVwHe0RlrqUmVYwaSWEVWnbs0lQpjVoM0DZyvpLoR9Kn25qlZWG
         GArlrLeITp3qcTtC5sLPCuvOcuuRH/QI0fPdBhsA3CecwlFy8Syw5HuBSs/3lnwmMcy0
         7mCPccGJndoZJnODMefh18kwhhK91f9/k4n83lSzpK2ZZ6oBEhtlyV7q3rgJYiIgHluI
         l0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737724561; x=1738329361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZAh71u7iDW5TgFuwIN4/oX/du7eXN1HEZL6hdOP2kw=;
        b=jvUZ0rp5vb+t55GukNSJVQ2lMx2YrdyAy3lJVi/bLheb3JwPIZAoT+s++jNDEckYGQ
         pTYFbHP2EgK4GLAC9xkkm212rKtNScZYLeotgzK3sDzM1a7oLFdeXrJ3+ZROAyZ4COKa
         w09bKHLKfrIlnXzEG0IWGT2d8N1xvlHjstyxAZFcBMjONt+Gx9F4Ufukp/yh5P4DZ+aM
         a2t2eNvp6/9Aq/9KJ+AfH2FRl313fkS4wGb2Xs/PJVS1OlscIt7jrcsJhbV1bfPDMJ4O
         iD+WL6GQPjUoaxrU8wkBGQY8MpxTKXDJjCxixZ+CbAa6l9AblfMTReYuPRl+OCWsSiW4
         N+VA==
X-Forwarded-Encrypted: i=1; AJvYcCV1BgZrUc2wZ84gW+b5uFHraHvXHbzKd3Dav8e3fJImuLLGwHsW1Y+pdKao3/9b0gMOoMfITopYMyARGRI=@vger.kernel.org, AJvYcCWKKVGSyfjwt2RA0Fu2K7J26l03refF8S0Hde6Pea7RigwYtezPfP4dbHZWC4p+fuG7EyIchaDN@vger.kernel.org, AJvYcCXjQisru31CrH18Xxcsis0NzNEnxjb7zz6qvx2CcA4AqQ5bGscf8iyKhzZxuBmyKNJ6KKgElRGNQcQQJQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC+wITa3chaEEM4Oygw0tLAKa6PVPPZjiabFdmwfi+FW649ooY
	U6CcTw38wToZc3eXM5mDsXPobn99C+NY/qaZz2i6LCwhkQxHmkyU
X-Gm-Gg: ASbGncvikAiUFX1XYjKQ1lsfVdO8cZJhWM7XxSdXFbG90TdkXonXsuH18Pb2Lr4oopo
	QGzd/yN2xdex99lz9777Lm+tUO5XtlvCVbqq1SQB/nurEBFj+975YOZFiNWpVinyfQ5ZuLVcQwy
	vfY77KIlqFy3yE3NljmLeAMDTI+qMuXdBqToTNRw07Ym6xYeuPml2s47RXg7VIl+9gCmt3VJXId
	0PQ2ZFy9KSD3Bh9uYANx4+ind6Wtnbhs1wrJERWqZ8MRcAk5MSnTv6ee7XAFN0SWd4pBQ4iVUl4
	uszM/0f0kBuiw9k38JaU8/M1jVCR9QYnW/I/A3AU5DIeK/6jPR34Am6FZVpwvYRnwlw=
X-Google-Smtp-Source: AGHT+IEwZbXxm4SZObd9WNjYWzy5X3F1IMVKmUJqH/hwSmh0/AUzwz0DpjVKAw0L1FgMgzHEfw0kPQ==
X-Received: by 2002:a05:600c:3546:b0:434:fc5d:179c with SMTP id 5b1f17b1804b1-438b885f8ebmr72834675e9.13.1737724560477;
        Fri, 24 Jan 2025 05:16:00 -0800 (PST)
Received: from orome (p200300e41f281900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd501c2dsm25668225e9.13.2025.01.24.05.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 05:15:58 -0800 (PST)
Date: Fri, 24 Jan 2025 14:15:56 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Brad Griffis <bgriffis@nvidia.com>, 
	Jon Hunter <jonathanh@nvidia.com>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Joe Damato <jdamato@fastly.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/4] net: stmmac: Switch to zero-copy in
 non-XDP RX path
Message-ID: <qkjv53fn32qdi5jh2d6bqdfnnl5x4x74cmir6fjtstfw2ijds6@eoxctjkqij7u>
References: <cover.1736910454.git.0x1207@gmail.com>
 <bd7aabf4d9b6696885922ed4bef8fc95142d3004.1736910454.git.0x1207@gmail.com>
 <d465f277-bac7-439f-be1d-9a47dfe2d951@nvidia.com>
 <20250124003501.5fff00bc@orangepi5-plus>
 <e6305e71-5633-48bf-988d-fa2886e16aae@nvidia.com>
 <ccbecd2a-7889-4389-977e-10da6a00391c@lunn.ch>
 <20250124104256.00007d23@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qeva6rbep4nl2wrp"
Content-Disposition: inline
In-Reply-To: <20250124104256.00007d23@gmail.com>


--qeva6rbep4nl2wrp
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next v3 1/4] net: stmmac: Switch to zero-copy in
 non-XDP RX path
MIME-Version: 1.0

On Fri, Jan 24, 2025 at 10:42:56AM +0800, Furong Xu wrote:
> On Thu, 23 Jan 2025 22:48:42 +0100, Andrew Lunn <andrew@lunn.ch> wrote:
>=20
> > > Just to clarify, the patch that you had us try was not intended as an=
 actual
> > > fix, correct? It was only for diagnostic purposes, i.e. to see if the=
re is
> > > some kind of cache coherence issue, which seems to be the case?  So p=
erhaps
> > > the only fix needed is to add dma-coherent to our device tree? =20
> >=20
> > That sounds quite error prone. How many other DT blobs are missing the
> > property? If the memory should be coherent, i would expect the driver
> > to allocate coherent memory. Or the driver needs to handle
> > non-coherent memory and add the necessary flush/invalidates etc.
>=20
> stmmac driver does the necessary cache flush/invalidates to maintain cach=
e lines
> explicitly.
>=20
> See dma_sync_single_for_cpu():
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/=
include/linux/dma-mapping.h#n297
>=20
> dma_dev_need_sync() is supposed to return false for Tegra234, since the e=
thernet
> controller on Tegra234 is dma coherent by SoC design as Brad said their
> downstream device tree has dma-coherent turned on by default, and after a=
dd
> dma-coherent to mainline ethernet node, stmmac driver works fine.
> But dma-coherent property is missing in mainline Tegra234 ethernet device=
 tree
> node, dma_dev_need_sync() returns true and this is not the expected behav=
ior.

My understanding is that the Ethernet controller itself is not DMA
coherent. Instead, it is by accessing memory through the IOMMU that the
accesses become coherent. It's technically possible for the IOMMU to be
disabled via command-line, or simply compile out the driver for it, and
the devices are supposed to keep working with it (though it's not a
recommended configuration), so exclusively relying on the presence of
an IOMMU node or even a dma-coherent property is bound to fail in these
corner cases. We don't currently have a good way of describing this in
device tree, but a discussion with the DT maintainers is probably
warranted.

> The dma-coherent property in device tree node is SoC specific, so only the
> vendors know if their stmmac ethernet controller is dma coherent and
> whether their device tree are missing the critical dma-coherent property.

What I fail to understand is how dma-coherent can make a difference in
this case. If it's not present, then the driver is supposed to maintain
caches explicitly. But it seems like explicit cache maintenance actually
causes things to break. So do we need to assume that DMA coherent
devices in generally won't work if the driver manages caches explicitly?

I always figured dma-coherent was more of an optimization, but this
seems to indicate it isn't.

Thierry

--qeva6rbep4nl2wrp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmeTklsACgkQ3SOs138+
s6Fg5A//RRfim9bUu9i1xTkv/GjjLWaRJ7VtWKD5ewVFok31BQU5MKDr06GxqWN9
ARoiC9XZPn/1W8+BYFrZKgWGeT6M47a8Z74LDBbfA2seTEokZWTH8jCyk5LEiVn3
5bKSSMe/2UmmQrGHvAg5Z8FYzaQVP6BcWZoT5K6o6vxRGj9LTgNz/nXlAaFUZFRj
PfnyyrCfF8NfiMOnRtDo8HVB1rxshscjOf/SpDjq++B3rzaLnUUBPI676WlWg0Ru
jMwQbr9Q8ynJBetKGA3Fy5TrAIP2vACLqW7kn4+OJYh9Cwo9HAelQ27y5aur/gdJ
UJCX5pCDtoyVEQwtxwbinOcG1TKGDGBPYUqv/1+IWjiKuHJuAC4/qgPxNLk7sGxp
CiKDGJBYl4vXfbyS43BJj6XqyjOIyFhK2/DEJ2ep64wIi82kJlx6qx6euZ52Ie++
41xc7Ek1ZOUVpz/mou/pAMOmyawOZiSCq/ai0Zzfg8aCsFdrfotasjzUZRh80a6H
4UQgUQSPS6aVitDSga17U6+lA8z62pCx7CQwup3GYNZSma/xLlFIbXNXYlIqsh66
ByAjxG5EK7+Qz4N32+axkdd8g0D6BGesvuHFbYQ8Fo69QfUMpcznChBJUoFH3V60
pKaMDF8b3UJMzAsljZtkby9xqYTiMVqZcGUYVyNRNOkZRo7DfAI=
=kOxw
-----END PGP SIGNATURE-----

--qeva6rbep4nl2wrp--

