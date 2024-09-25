Return-Path: <netdev+bounces-129788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3B99860EF
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 16:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23FFB1F28796
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 14:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EEF1B29B6;
	Wed, 25 Sep 2024 13:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4Wrj4zs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87501B253E;
	Wed, 25 Sep 2024 13:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727271626; cv=none; b=fVV1VO6V3I9Ai7GpBD7aOMvGJODcauBAFicqNrgDO0iAxGpQtyenv+YPb8MOn8GtI7RQUnHab1yUdGSehQ87vbO6s4Y9wCPxSru16Tg7mz3FFsKF1A5bfehUFNTDCOzmhJvlMVyVBlMFfPqqzapIwmWbYqJ8HM7a33jqEcssOvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727271626; c=relaxed/simple;
	bh=EfOC8P2z2jj7/KISxgXA/Fv5C3o+yBW9A6I3LKnYYAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlkEM5aHl+b4ZGlWkbdW1IFI6Pb4rOm6cX4ZEqDw1aWcVfZRQBxdAUaL4AuZM34I8VcP56AZLSDvelXOMZ0dcJlvUEbngJvi94I2rigPI+f+Mk6UOviB2vm5iESVeWAJcEwMxPHGTScm5sn1uXebOEVGy1zmU7N+oPdnnHjoIp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4Wrj4zs; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so86418805e9.0;
        Wed, 25 Sep 2024 06:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727271623; x=1727876423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wq+m4ElIN8dxEP+OkTKJlI+yOSp8eW5hNmQ8P7Zf+44=;
        b=D4Wrj4zsQAsYY13o60qcw3bouNU/rQ6Ldr6ogQBvRNsUzYVPY29FZS9XBdHW+PlXCZ
         Try6YSkhf4mv456IR+KpxCX0Jg0LJpKNHskhvcZi0XLOtsJK2xzQJ4S0OHe4E94Tg6sR
         B1WL0bYo/Aam8zAE5VilsmquQWFwuqBWH+KPRP4escUk+Uywnw/TFDfRVCM8sm33Qa7N
         0ZjBW5BQNR9jHCV0IQ5/gFvcZWzY6f2dCbY0Ogge+luLchPyQesDSF2HDyY1v2BGM3R5
         eCkZdCEPdLK9NuSEfQROBKWW35ndH3R0LxTGCKrtXcFNdGg9mLilU712e9HqEBDeyd5+
         lNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727271623; x=1727876423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wq+m4ElIN8dxEP+OkTKJlI+yOSp8eW5hNmQ8P7Zf+44=;
        b=JaSXj5EblSBD5r1DQCq+YEgCm4l40lyRVaKnTm/+Vtd5Dd1lI8qARLZwp/SZQdj7bC
         UHHNtI55v3YzDdPPk1hCaTiFEggSe/9xknYMByhrVcoN9/weYkD4AhGfA029uH2rUzQ4
         147LoO7WIglWmD8EYZBZtm5qmFx78dDnuifl3xdT0lrRYPwo/DhHHn4XjmhL0iHbRlPb
         Z6YXUYqvrfYRoa1vZaOxaYuDfNOI7vbjrYFK7gt/09tFW/6cj/JHeC2g87TyHo6V8NZH
         42JYNBghGr7Wy4Tjj7/p0ulBSFxHs9y0N+LiEcuhg5fW8xmiBiDWJIvtVdxOvBbRLjM+
         Oo+A==
X-Forwarded-Encrypted: i=1; AJvYcCVCpSONHcblVROqS6494A/67A+uTqDlMsNYCtDWVHIKpyY+ZVeV4s0Yn/nDLQM8S7iPigBGzA5o94HSzw==@vger.kernel.org, AJvYcCXpleYwsDGiMLprbELht7CjzPy3Qn/ymUf/FsNYW+QT3oIOyeASANAu2CsCzMFMN+alGmZAXul0@vger.kernel.org
X-Gm-Message-State: AOJu0YzcvU96KgPWJqG2ZmGxTyvXUoJ8+tMeG05o9lcB3eltb+HodTTn
	AEmJ+BkiVdPpuzHuHchRwNaV+AsTvYUKWh+wl55VRi9ISeBuRBlT
X-Google-Smtp-Source: AGHT+IEMhRcgC3W+qwG2A2eyUG8vLnwJuDEMZ3mEVfrP1ge5x7YoHlVKvXjJofQncgUq1a/XAgSgJQ==
X-Received: by 2002:a05:600c:5116:b0:42c:b9a5:bd95 with SMTP id 5b1f17b1804b1-42e960aeb59mr29079295e9.0.1727271622689;
        Wed, 25 Sep 2024 06:40:22 -0700 (PDT)
Received: from orome (p200300e41f147300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f14:7300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2a8bd7sm4083088f8f.4.2024.09.25.06.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 06:40:22 -0700 (PDT)
Date: Wed, 25 Sep 2024 15:40:20 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Paritosh Dixit <paritoshd@nvidia.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Bhadram Varka <vbhadram@nvidia.com>, 
	Revanth Kumar Uppala <ruppala@nvidia.com>, netdev@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: dwmac-tegra: Fix link bring-up sequence
Message-ID: <qcdec6h776mb5vms54wksqmkoterxj4vt7tndtfppck2ao733t@nlhyy7yhwfgf>
References: <20240923134410.2111640-1-paritoshd@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fxewnc7or7opkwq3"
Content-Disposition: inline
In-Reply-To: <20240923134410.2111640-1-paritoshd@nvidia.com>


--fxewnc7or7opkwq3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 09:44:10AM GMT, Paritosh Dixit wrote:
> The Tegra MGBE driver sometimes fails to initialize, reporting the
> following error, and as a result, it is unable to acquire an IP
> address with DHCP:
>=20
>  tegra-mgbe 6800000.ethernet: timeout waiting for link to become ready
>=20
> As per the recommendation from the Tegra hardware design team, fix this
> issue by:
> - clearing the PHY_RDY bit before setting the CDR_RESET bit and then
> setting PHY_RDY bit before clearing CDR_RESET bit. This ensures valid
> data is present at UPHY RX inputs before starting the CDR lock.

Did you do any testing with only these changes and without the delays?
Sounds to me like the sequence was blatantly wrong before, so maybe
fixing that already fixes the issue?

> - adding the required delays when bringing up the UPHY lane. Note we
> need to use delays here because there is no alternative, such as
> polling, for these cases.

One reason why I'm hoping that's enough is because ndelay() isn't great.
For one it can return early, and it's also usually not very precise. If
I look at the boot log on a Tegra234 device, the architecture timer (off
of which the ndelay() implementation on arm64 runs) runs at 31.25 MHz so
that gives us around 32 ns of precision.

On the other hand, some of these delays are fairly long for busy loops.
I'm not too worried about those 50ns ones, but the 500ns is quite a long
time (from the point of view of a CPU).

All in all, I wonder if we wouldn't be better off increasing these
delays to the point where we can use usleep_range(). That will make
the overall lane bringup slightly longer (though it should still be well
below 1ms, so hardly noticeable from a user's perspective) but has the
benefit of not blocking the CPU during this time.

Thierry

--fxewnc7or7opkwq3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmb0EsEACgkQ3SOs138+
s6EK1w//RoADGK/VMr7NtbQ5Xbyg/c3OhGf93iccabRNxBJdCdRPvvIviIniQCbp
poBohDO8n9Fa5047FaEzfxY0N0UlGvixqowWWYAn6Uww4li/6kx+RmtUIPGzIlCn
NfXXrOYJ2FQxxhUY/OBR1FWlSoah04mxqr3Go5E+xFWVu6/1o9H7ZZiX/yi/yfOE
aRX4leYAhf8lfrKJfvx2IuqAldgmgHYArs7Bafrsv7LNWKHE+tsJAmo1O0yqvBN7
EQlmHeTlEv7CF0sh0+gEwD1F1yk6cHU6w1hNI56ie1ajHlUugu1FLZBrFbLbL2nb
qThx0LppgMI07U019PatQ9vx11f7u/Vt9Vax45zVyVZBsg+fV0sEv/9XFP2mC/Nw
CafGN18VjT7iNDDutoNK3gaFbBTCyftIdG2sVsUWHyGk52DYQlZWQFGfDbgzB4Fd
Wt/D2UNDvcatKRoST3blMnVN9cXPn6MPCBwMHlnJn3VZlzjtyPtDp2WxUO2O2p+h
WHNBek7FCBIIaqXKxzbZX21k1QB7nWIDJLe22tQh3p3y/pqG13FLU9u6eIp7Ix3r
fbdmFrDDgEY/GunF5QHh7AgM3kyPknUy1Utn60eTGloSs23yCZS2fzRPFx//iHa9
LtIKhlZdhPqHCQO241TmvFz9wXc82fuofpd2uuf9KaLssLb+QAU=
=1Wvp
-----END PGP SIGNATURE-----

--fxewnc7or7opkwq3--

