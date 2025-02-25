Return-Path: <netdev+bounces-169631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA88A44E01
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 21:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D37F189701C
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 20:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554B618A6A8;
	Tue, 25 Feb 2025 20:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdDaVdFH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09341632D9
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 20:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740516424; cv=none; b=gR7+dagWf8K60NM5UmKIpNln3lidcSPViVZm1wfefK/lwAAtC0wd04HS/dDT9LtOS48mxONwIcN+D3Yiqi/PhYaZBb0iDbQQOSm6v2KslLgAFOfhlIlULJ7tZkdvm7DxrwIAp4kjFD+EXdOKc11NeoH2o3S9CigursTmF/xh3T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740516424; c=relaxed/simple;
	bh=Act62FROw5FKgMdYrI/D7fctk9vB8HfEjrEmQQTWIAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/28+lawyhlnRG3kdlHSsoxi1UM22nUhhzJl6nc70OA+UIL+zzW1flhX7lY4KEkMzV4jJBJH6jyj9gFxsgoYPNetlT8xOCvNuaODoQLbpHADIjxMdnsyIFW5IGcpkpomIZ9dO2wcR9ymOkZCKCObvCnkbclOmXPhPtAH+nrSdtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdDaVdFH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4394a823036so58065725e9.0
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 12:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740516420; x=1741121220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E918OTHi2yvVgDkqR2WK0eqY1K7lmB4Humnmkm0YU/k=;
        b=MdDaVdFH/W7R9JmPDdfaH1XoCPQG8EyzM4G5WfrRajBgFS+M3H0jEf5pMor2QXM5W2
         nmmYMqOcboIELv0KKoZ8Y0QM+FpcMJ+BFXb3Y30ShQjDqjm3ySkXkHtY5ivMhmLFG9ge
         jd8eSBrrMGdAzgMU2AobWMclcqAiRlMNax0xx1geOpuNLhwNg1UiFNzW2AzlM+KwRlAg
         5EzMQ7pH/FSB4yrXDv1atuFVKLaVsEKLMvfR/FPgqeMPAiYgHYYD82Q45sv6s73PrVGT
         t4OvRtqiig6oFwtXAw0f6+h490SZwqcz5y7I98pbkTEqSvWWC7Cxi2px5HREfWBrt2wL
         cYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740516420; x=1741121220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E918OTHi2yvVgDkqR2WK0eqY1K7lmB4Humnmkm0YU/k=;
        b=FGOwSkIa4E+9ztI2e5sB9PHIWtzEI4AtHMaYk0GrjpDOKgWwAnUqRpvuK/gpe6x7jI
         /yAuBxudQdojJacWZxO3awtIbOSdcwTwFWSUYv0F2A+7bJIs8T5bUlcFeSu20KbIs+We
         ZKdzqAJgDgpyScj3AmARjUGWylvEF2OPjxCSDI3O8LzvyG3vMm/thTf22G84wi/Icd5m
         84rZVby1+QZmIQmaE9Bu0nWbhqWwWNTvCrjLRU09rcNQGi1r0EOe1QKpIlJrknxVxoMs
         v+f+VhEFDOz1wjlBt5bEJseGIB/BD5Vk3hLgWZW6ntUaQvRa5puGfz1dY2Zya7JwUJ1P
         1gtA==
X-Forwarded-Encrypted: i=1; AJvYcCUp+ZOfj0CELP8sMyfG2v31FBvEEeSDjgCB9tbktGJGctHfCjFQDWF1g6L4r+Xe76N0tc+JCT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxztKF6zviAmLA7DNQ3hCgbXT+PaYBNZ6oMWpBwLkncspBWgb4q
	GMQ42L4OjFaP2pNgm9TlAVYrYJdiZ/kKvFAYjJ+1Ac99mHekfVdt
X-Gm-Gg: ASbGncv2ErEEzHqZF1gnlXu3RQkPEuY9lWkJip7VjlIuEUi+LysAkEEXiQTnX7HaXwg
	iDv8eO8O4Cgf6Ma1tcjpd3ONSl9dUG3Oo7LM/W6CcKiE/8xfbbKxaOXGLBw97FcBt0BoRHOV8P7
	RLpwKo5909xfISmBDCo62CcmWOJRqKhFZI2k3AoZeUVlbAqLiZXs3Rd9WUqcInL509kk0MFIyWI
	xSH/gaCSjLZSkZa3z9+g5OZPtdqsKI3u6ASZpqWRKTHZUNaUCjr5jwplil9IdGd7L0F+aRc7IjY
	IufYHJ50/bmptHRjzv30Jp0Dg4CLKfUB9XY70xGpe6EQ7x5S+0aKhHYI/RGfZcwrXiyE+Hgjg1H
	hzpNPzu7B2dXc
X-Google-Smtp-Source: AGHT+IEmw7lSBpfSNj3LhieZeCNYI4bj4PCJf7zwnwb1ygbIuUippUUYOdeYMqmm611SGM3iLvGYVw==
X-Received: by 2002:a05:6000:4010:b0:38f:6697:af6e with SMTP id ffacd0b85a97d-38f7077dc73mr14301433f8f.1.1740516419999;
        Tue, 25 Feb 2025 12:46:59 -0800 (PST)
Received: from orome (p200300e41f187700f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f18:7700:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab156a11bsm38026395e9.36.2025.02.25.12.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 12:46:58 -0800 (PST)
Date: Tue, 25 Feb 2025 21:46:56 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Emil Renner Berthing <kernel@esmil.dk>, 
	Eric Dumazet <edumazet@google.com>, Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev, 
	Inochi Amaoto <inochiama@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jan Petrous <jan.petrous@oss.nxp.com>, Jon Hunter <jonathanh@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Minda Chen <minda.chen@starfivetech.com>, netdev@vger.kernel.org, 
	NXP S32 Linux Team <s32@nxp.com>, Paolo Abeni <pabeni@redhat.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH RFC net-next 6/7] net: stmmac: intel: use generic
 stmmac_set_clk_tx_rate()
Message-ID: <n67c4bq7n7ejakmqmglve3os6vqvm57umysjjzexxkygvusnoo@ndee4gfnmsst>
References: <Z7RrnyER5ewy0f3T@shell.armlinux.org.uk>
 <E1tkLZB-004RZU-4A@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4kydm3gogek2i4nx"
Content-Disposition: inline
In-Reply-To: <E1tkLZB-004RZU-4A@rmk-PC.armlinux.org.uk>


--4kydm3gogek2i4nx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC net-next 6/7] net: stmmac: intel: use generic
 stmmac_set_clk_tx_rate()
MIME-Version: 1.0

On Tue, Feb 18, 2025 at 11:15:05AM +0000, Russell King (Oracle) wrote:
> Use the generic stmmac_set_clk_tx_rate() to configure the MAC transmit
> clock.
>=20
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  .../stmicro/stmmac/dwmac-intel-plat.c         | 24 +++----------------
>  1 file changed, 3 insertions(+), 21 deletions(-)

This isn't quite the same code, but the result should be the same since
clk_set_rate() will be ignored if the clock is NULL, which would be the
case for !dwmac->data->tx_clk_en.

Reviewed-by: Thierry Reding <treding@nvidia.com>

--4kydm3gogek2i4nx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAme+LEAACgkQ3SOs138+
s6FCDhAAscpV7eVp/AZQnvvZ4nw0Ad/YhFSj9yZtfDGHgapuDwrpMtuoI8uo9AXY
D8+01yo35J7QfixSJ8u9vwrs2sZQLQsWQ1a90UudQueW5LuaW+Mjp7ErJgrh4B4C
lsm3cUuv+/GblfCX4FgnceY9YHJGqoZNDzYAb+e6xmZCgFzRpT4emSCYCyVHnyS8
sELpHrLTdgJlso7x8hWn3GsSgG6te0ToqLcru4HZ+gl4zRjh8ljfx+5tUkiCSdIf
53t4tdRo/qhu/4EurhryxxJEsXSju1iYV57knOQp0QsplHARC7c4D10xVHFiYi4j
M3mTMnRYGY/d9MMsd0pr193DktSogHur2k7zUdccpE7X34CPZcmfg5wLPO/qYK0S
rJvto6QcJqqB4XagVfuoXoANvAOzlMXUviQBUHFFSumHmnwerkU0ntPzQdk5oQqt
7I+TFMNlEiKA1VpLGbTWw8cEbvj7ZPGHnVd3EQIQp24lYqK/6IZiNB5ZOC0Q9ayk
ydkm9PWQzIdlL3MFh/nho8iZ43nJF3rkTsML1leqt1/CdjHPHi+csCYATi2TqGEp
GhcrScX9mxWkBZ7xWzFfETX610z1DwlzZDuZSlLtc1ZbyxLacU8EDIqY8bha661b
8Irrrgzw/UAFApkCGAQxQ3NsIsc87T+t10FfEW8cdTCjolZd+hU=
=eyD5
-----END PGP SIGNATURE-----

--4kydm3gogek2i4nx--

