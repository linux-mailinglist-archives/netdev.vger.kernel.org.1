Return-Path: <netdev+bounces-147495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B70619D9DF5
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 20:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 290E0284FA2
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 19:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE351DE3C6;
	Tue, 26 Nov 2024 19:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="DB9aaiEU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l88G/heT"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7291DED77
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 19:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732648841; cv=none; b=qUKcFVhyEbRMM+YdUUQnphJkFlPuHdBZK5geEun9mwwTOYVjUo/vtsD9EyNUZRa45vTidczonN0pHijJFKgj5vFAe/AZxjfwJIrcr1SrnzMl2n2t8/jkPu742z14B5KHztt9+/Qqys5xhJ8tt0c3g3QEzE5sKCtty3pfVc3x8XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732648841; c=relaxed/simple;
	bh=v3ziV3Fp/Kk7IjbUtCC8VctlZUQixYFkg5Wr3SZdRv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UstyrX7n2J9lSLUIdoegZxR+G6hEvbA8l/nMmThReFMzRQomOlq8aFLtI7uzvMTDXPpQpkm/ZQNW+vhyu0CRODO0h4/d5kGEELQl/45UpR+02hfgaVO/Km3J2Uh1/JOwMhVRJyNzvzInrZ7XprPgBa+4IeGhwDkv7ogJ2s3BAaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=DB9aaiEU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l88G/heT; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 386A425401BA;
	Tue, 26 Nov 2024 14:20:37 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 26 Nov 2024 14:20:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1732648837; x=1732735237; bh=v6m7eWalBH
	c0cawsS66P5sTQjB97KqG5WwuFw6guJpw=; b=DB9aaiEUiw3xCT0LOHCpIH5zGn
	RJLZvIFOi0BUMczHilQVO7pcxonYUgLIL4h406C6o7je27GgOY45sAzTz2JsriQr
	3tNqhw4gBOqVCof/sjuw4DKCrgyIFblnnF3tHoQuMM54IuVKoVDEWMkmhfFGnS73
	YYAXhZYJfr5amB4IEJKVO1w10I0jhUSGFac9Cnjl+a/5mPH8Gzpf/yvnEf4sYDu+
	FxHgNO3IOEktkE7fwjOjyHDlZoJMGllnp3eXm+DJ8j7i30/b+cnLSXrioNrcEofl
	SSSFd/+fAkmdpUXRcAUzMHfYJKpYQN4LqzPHbNMSDiEc/cd/jEIqq7u8id6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732648837; x=1732735237; bh=v6m7eWalBHc0cawsS66P5sTQjB97KqG5Wwu
	Fw6guJpw=; b=l88G/heTnGAFLc9oiOZlEz/yJtbt4civ/s0/0I546xCKNpbZLuy
	+7Ju818rcKGrrBWWGlKgijCE00YS08ai2juti6SkmvyvhHi6f7SLw7B/THVV0aAb
	CwSO9B6Vapdaf5nASfg0fkD579XsJucUxKKlRMoUDztzASy3zc13UDlDqRb1QwdT
	4maFjUHWgDDN6LOmm1Cb6gcWQAdg7DOgYGBLkSMieDq8/zlVUvfyJlPFISawDlzu
	6p70qRfvM1sy+txfr/d87fNEvzPDRz8ToHfBzRXHANXTCN1AZkdIhjVLGp3++6Ul
	c8d2+K8xF3FpaOVa1Q7cUiIHSVnlBSocwsQ==
X-ME-Sender: <xms:hB9GZw0GtU5xcAvc6aC43SjEmgGDh-qcjaKYXTeNL-jUSIOHGT74Ng>
    <xme:hB9GZ7FddUgL0tAMpvs2DHwhhhsAGeze-Q9724QpuaIi9nhG5A8yN5bRcfA9hML8X
    aLTqczKg7a-5I2XqA>
X-ME-Received: <xmr:hB9GZ45CsiD1sw4LZhKxlhR6CveMVFRVbwpi0qPXt7ARjmVXPGhq-EUFvZM2hfdu-nm0dRdr9T-uVqG4I69w43OaB0fj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeejgdduvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehgtdfsredttddvnecuhfhrohhmpeetlhihshhsrgcutfhoshhsuceo
    hhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpedtjeeuteekheefueelue
    fgveeiffekhfetfeeivdefheeuhfejgedvieffiefhieenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehhihesrghlhihsshgrrdhishdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghonhhtrggt
    theshhgrtghkthhivhhishdrmhgvpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:hB9GZ51WfdfKsOin3HijD9Y1L8XQLk0m0gjxvW0w6moTrVfl6fTgXQ>
    <xmx:hB9GZzGzLpeHnlJCVibzCUK1KFLKmZqzg8T9UBdzaGhj1OIexzc6Vg>
    <xmx:hB9GZy_u8oMz9_r0FMHvr8xtthx1przzPZIBstpgfuMIHgiH-xo99A>
    <xmx:hB9GZ4k1Xzgi1vquqKsdOFRF2LwFFVldo5K65JxGpupeU5IQlDIZ7g>
    <xmx:hR9GZ4SVMJBQgDLGvzCInNlhHjVzxVEVVCm51fUEyJQRuryC7IhzeybT>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Nov 2024 14:20:36 -0500 (EST)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id B076CACB6; Tue, 26 Nov 2024 20:20:34 +0100 (CET)
Date: Tue, 26 Nov 2024 20:20:34 +0100
From: Alyssa Ross <hi@alyssa.is>
To: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] libnetlink.h: Add <endian.h> for htobe64
Message-ID: <2eg6fesfobvmzhytljlsadcjwrm64ahsst2mp2orih3hizfxm3@633uklkfzeq6>
References: <20240712191209.31324-1-contact@hacktivis.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wdfgu6jktyzpogt5"
Content-Disposition: inline
In-Reply-To: <20240712191209.31324-1-contact@hacktivis.me>


--wdfgu6jktyzpogt5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 1/2] libnetlink.h: Add <endian.h> for htobe64
MIME-Version: 1.0

On Fri, Jul 12, 2024 at 09:12:08PM +0200, Haelwenn (lanodan) Monnier wrote:
> Required to build on musl (1.2.5)
>
> Signed-off-by: Haelwenn (lanodan) Monnier <contact@hacktivis.me>
> ---
>  include/libnetlink.h | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Alyssa Ross <hi@alyssa.is>

> diff --git a/include/libnetlink.h b/include/libnetlink.h
> index 30f0c2d..2b207e8 100644
> --- a/include/libnetlink.h
> +++ b/include/libnetlink.h
> @@ -3,6 +3,7 @@
>  #define __LIBNETLINK_H__ 1
>
>  #include <stdio.h>
> +#include <endian.h>
>  #include <string.h>
>  #include <asm/types.h>
>  #include <linux/netlink.h>
> --
> 2.44.2
>

--wdfgu6jktyzpogt5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRV/neXydHjZma5XLJbRZGEIw/wogUCZ0YfgQAKCRBbRZGEIw/w
osHTAQDp21LamwwuyGJAMMzJCsPu5KbEq+9CuqkRQQt70GxNtgEAprNMbjPyWXBc
6u7jkC/B52co5Aw/tSvtYE2tM1C0mwo=
=zwa1
-----END PGP SIGNATURE-----

--wdfgu6jktyzpogt5--

