Return-Path: <netdev+bounces-161109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F40EA1D6CE
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 14:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E640160B9F
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 13:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713771FF7BB;
	Mon, 27 Jan 2025 13:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fm1MVK8O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F79C1FF7B3;
	Mon, 27 Jan 2025 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737984544; cv=none; b=OEumU8KtMsA/wA4hY6x5cyCF8rHDOnHD3/xxGGVNXQlh7pOc1+Iu0Tcc/gpDwrUx3S0XtSJvpo5dQI6a0aBL+7wPJ7i6PkPehFBDLti1o3aqft/IBvhZYSPB9Tv/ZwW44H4n7Byzg5PJtDcxqhWtVFqZvDKn16VzCof10Y/vA+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737984544; c=relaxed/simple;
	bh=mh3CDR+ykf509LxwGf2N4WrrtrOinr2AgygZBWAePzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pB4EIobHvagwq2JogmKEgQ4FjL7iNR7UPfV91K+OUwxpmtzrijMU6sAvjde0gfF/CoXg2R71UlY6q5Gx3FJNMB9f6jQSWtz0zUjQHXXsiRFCf5N8P4U4nOU7gJiBNkkyuOCCtymneBtZUGS6zs8sf+ZT8jVZ9Ku8hEoFgYSY+H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fm1MVK8O; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385f07cd1a4so4620744f8f.1;
        Mon, 27 Jan 2025 05:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737984541; x=1738589341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FvzYFhX8SUBJyGpqjsoQ6jIbjkQaAtJdp897xoVPh9M=;
        b=fm1MVK8OVXeUnJd9giyJGNB2o36Wl+RAEBivtGT5HxwqBI6svANTmMg5/xlXg8S6yO
         NoyTSsK3kF5h0of88dMXPBUOUOwLm0xoncnhuF4No2mdk/QXU7uAVtbQCnDEQZudVVz6
         IPoGVAZq88Lxht+vn+zk4HYB5xtIX6I/29Rlnf1+TsocZyByzSb77wKQOvGH9tjPO0O+
         u/kq0tBqqrVTKGwQD8n89G5FXoHfsqB8FWvydJTRjE/a/UJD11xSRoCVU8pu/prsrhJj
         OCOuDw6Eod4yNRjVI+wwbJxo4gQEFv2wo8/nXcQfcHPUk4gCfy9qHMnwc0BRFBFmE9hs
         7eaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737984541; x=1738589341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvzYFhX8SUBJyGpqjsoQ6jIbjkQaAtJdp897xoVPh9M=;
        b=ixyA2VFRYiyTx8eFNJOshproJVAKBmlfxZj6iMHiKwPC/NpOaC/pzEO2ChHhwAiRdP
         zpgVNcv4v6YNvxy9ZrGhGrn8UQSTbsBD0Vgj+m1T5OUeaohKF1UdEpo9v12Y1z2j3MTt
         sbfOtf0Gk3veBsWzOMflviBhJW4PlKcJRnZtSeocJkPJq8aaD6bkdDUTE7xJmDjsYhJp
         rF/7hYfwKMN64bv0KitNiOjOsnVf42SUE9Nd3a8nzCfZUzmdDQRRCxFX+DIvES1rYXKP
         BYP0e04J4+Oz8yhKKsESSKrn5bCmcNPB0T+x5dKPTZ8rpe+rBNA5X9hERWJD4d4na0cU
         Cbeg==
X-Forwarded-Encrypted: i=1; AJvYcCWTpGkvyORtY39iotZvBiTpEHv0UOIRrNNNE3e3fcnWWrHabcH0O/PGn2fXBBtOEbXyrL9EiePGRS23gU0=@vger.kernel.org, AJvYcCXBKe1c4k7QHgBvsLbKQsUlXfMjFw9swMZT+lv5pmo/spl/Za1hF0E9rasMZbmccB4fWibBEn+QPlxDys0=@vger.kernel.org, AJvYcCXGOtW9QRdbLqRDSepmNN2Vgjqb3mHLnGJ/97AzXlEeCMr5mxaAbFpsCNcA3W+bukA2ybQlX0/a@vger.kernel.org
X-Gm-Message-State: AOJu0YzbD9quXuC8YKGBAY2pItI/ntKxkYvY2eLDRtUlrW3oZ3gRd89y
	uGh2/7TJ39XJ9wCeN8dzf9QDzm97CoBxODbNSbk52Fmn5ByKHfuOw7F2EA==
X-Gm-Gg: ASbGncv46Y8KK1QSEmjuhWO2b+ixTJnMb9WrskCcMBk4eVzwYy0aqAF/zy2reEpT+0+
	hslRsGoGLAeLmk0tBqlxMkSnRK98wlaThOOHgMNZIyZ492CnGmaoerBVWMb79cK09TbXVZ9KY6F
	HkNdqlT/TaVnYR9vUM7NwQZmYGbSx3S0YJPWp+uzpxd4CcJdsVV3lZ8xK1zKIUwE7CLl8tl+ZMx
	lDYOEV406B6bjdIpiuZ8gbdTNjYB5JEYpiYlXe3F+uZhExAMOmdRip0GEwN98eJATTBvex2YY8t
	Vl/guNeajbbrAJ5xE+MVmqyoD9SBf7tNNAfyqH8GByXpJvI726P0N4SsguLSyqld/cY=
X-Google-Smtp-Source: AGHT+IFdDa7a3oSeFSq3XdbGtmA71EbKMopM7KAl71p/Rr59XXaBfgDYSq3pBLs5ZQTyA8iqtGNjYg==
X-Received: by 2002:adf:ef04:0:b0:385:f23a:2fe1 with SMTP id ffacd0b85a97d-38bf566f7c9mr25956570f8f.26.1737984540632;
        Mon, 27 Jan 2025 05:29:00 -0800 (PST)
Received: from orome (p200300e41f281900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a17d7a7sm11357596f8f.32.2025.01.27.05.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 05:28:58 -0800 (PST)
Date: Mon, 27 Jan 2025 14:28:56 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: Ido Schimmel <idosch@idosch.org>, Andrew Lunn <andrew@lunn.ch>, 
	Brad Griffis <bgriffis@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Joe Damato <jdamato@fastly.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/4] net: stmmac: Switch to zero-copy in
 non-XDP RX path
Message-ID: <kyskevcr5wru66s4l6p4rhx3lynshak3y2wxjfjafup3cbneca@7xpcfg5dljb2>
References: <cover.1736910454.git.0x1207@gmail.com>
 <bd7aabf4d9b6696885922ed4bef8fc95142d3004.1736910454.git.0x1207@gmail.com>
 <d465f277-bac7-439f-be1d-9a47dfe2d951@nvidia.com>
 <20250124003501.5fff00bc@orangepi5-plus>
 <e6305e71-5633-48bf-988d-fa2886e16aae@nvidia.com>
 <ccbecd2a-7889-4389-977e-10da6a00391c@lunn.ch>
 <20250124104256.00007d23@gmail.com>
 <Z5S69kb7Qz_QZqOh@shredder>
 <20250125230347.0000187b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="le5bosxlscibz3la"
Content-Disposition: inline
In-Reply-To: <20250125230347.0000187b@gmail.com>


--le5bosxlscibz3la
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next v3 1/4] net: stmmac: Switch to zero-copy in
 non-XDP RX path
MIME-Version: 1.0

On Sat, Jan 25, 2025 at 11:03:47PM +0800, Furong Xu wrote:
> Hi Thierry
>=20
> On Sat, 25 Jan 2025 12:20:38 +0200, Ido Schimmel wrote:
>=20
> > On Fri, Jan 24, 2025 at 10:42:56AM +0800, Furong Xu wrote:
> > > On Thu, 23 Jan 2025 22:48:42 +0100, Andrew Lunn <andrew@lunn.ch>
> > > wrote:=20
> > > > > Just to clarify, the patch that you had us try was not intended
> > > > > as an actual fix, correct? It was only for diagnostic purposes,
> > > > > i.e. to see if there is some kind of cache coherence issue,
> > > > > which seems to be the case?  So perhaps the only fix needed is
> > > > > to add dma-coherent to our device tree?   =20
> > > >=20
> > > > That sounds quite error prone. How many other DT blobs are
> > > > missing the property? If the memory should be coherent, i would
> > > > expect the driver to allocate coherent memory. Or the driver
> > > > needs to handle non-coherent memory and add the necessary
> > > > flush/invalidates etc. =20
> > >=20
> > > stmmac driver does the necessary cache flush/invalidates to
> > > maintain cache lines explicitly. =20
> >=20
> > Given the problem happens when the kernel performs syncing, is it
> > possible that there is a problem with how the syncing is performed?
> >=20
> > I am not familiar with this driver, but it seems to allocate multiple
> > buffers per packet when split header is enabled and these buffers are
> > allocated from the same page pool (see stmmac_init_rx_buffers()).
> > Despite that, the driver is creating the page pool with a non-zero
> > offset (see __alloc_dma_rx_desc_resources()) to avoid syncing the
> > headroom, which is only present in the head buffer.
> >=20
> > I asked Thierry to test the following patch [1] and initial testing
> > seems OK. He also confirmed that "SPH feature enabled" shows up in the
> > kernel log.
>=20
> It is recommended to disable the "SPH feature" by default unless some
> certain cases depend on it. Like Ido said, two large buffers being
> allocated from the same page pool for each packet, this is a huge waste
> of memory, and brings performance drops for most of general cases.
>=20
> Our downstream driver and two mainline drivers disable SPH by default:
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/=
drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c#n357
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/=
drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c#n471

Okay, that's something we can look into changing. What would be an
example of a use-case depending on SPH? Also, isn't this something
that should be a policy that users can configure?

Irrespective of that we should fix the problems we are seeing with
SPH enabled.

Thierry

--le5bosxlscibz3la
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmeXihUACgkQ3SOs138+
s6FoPhAAqxOsjlx6etEbkgUZAt/RbOShSCthQYEh+Lc+Fk856UbSJeQ3h2jIDUKE
LeAtoppjWnoZbrJGesP99QLBsq5R1ouYiacktzWwyp9PciXmWivAxAmdUZ5kqXsC
Y/OrrsL7PLxMlhij/qY+pMBH1UiTfuLLftMNxYAY/3w5QIAt1hfFIlA0qEb2B+ZN
C9Ir1Ma1TRKSosngX/WNlEacT9jh4mpx7zk8IcD5LEur3mEIWcGrF82zhUf+3Xi0
92sBCxHz4ydKwXTOtFZDm8EiBo43Xo9R14OTaOR9Q8Odv3Hz0ywEuMDjt4NzryXd
bm014ztiC52fmSkDCIy3TM42q3NNBVlDUJDqYZjc/9S+MBhPNyyug8WKsnz6QWiV
4DPxCw/mrKYZNOjQnUOGx/WTpkQY8lSs4LGNusP2Fg+FUcqbfnODBO6nRFOUSI4z
dI1Bn34IjnEIM+zddlYP8Q+JNbcVK3JUWF93lVX2YdJGmELCNEGMrt5TDxMOJSNm
AFTJdmNRUvGf6hM7xhqOZXABWY6/qKQhR3UaKWavOJMc5kG6gQbxsIHpHE6zWRig
jFEnol2StQW1PAm2fCdlrBdFADFzgrkfsvbIv9r/XegXU/vTIQXmLm5U4O8DJ58Q
y4HTY/66dTEmd//qV+a3jonm88YEvcXIXiaJBFvchrJflKFtHYY=
=dCSI
-----END PGP SIGNATURE-----

--le5bosxlscibz3la--

