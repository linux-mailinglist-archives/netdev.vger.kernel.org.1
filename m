Return-Path: <netdev+bounces-169627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5767A44DBC
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 21:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E703B846B
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 20:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85808190051;
	Tue, 25 Feb 2025 20:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/ZBgcJ/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9514B18E050
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 20:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740515664; cv=none; b=gRtVYtwuG+zXzy83pHRxaJOZ6PelHGmUK1kcr3QZ8SntuNVjge803Ip5xrZvWwtQKY8vfe57xJkMXj6Sm9L7Q1iB1DpN0XB050B6GRTLk807QhUtrvfb2Xsd8PwLzx7v/cZEIUOFKCpqZolNDCskw/HBN6J6gxU1PAzB0WgYvXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740515664; c=relaxed/simple;
	bh=wO6gTDBz/P29n3Bnp+RwMhO5+vhL1z74WiB9k3Xfdjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4Dz4hH5l+126IMcdPfnbrOywUjDSfxSnKnjp3e3a9nrG31B1wqos1BqqFmyJ/23kWi5V1RQrvvPyAeHskZ+k7hEr1+f/AwT2h9agFgIMJNHSCO04Ja1pjdIE4/sbqNJ3LXDX7SaAk1Yl3IEutKmtUZmeGg6XjgIjl0p3fBORXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/ZBgcJ/; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4399ca9d338so37489585e9.3
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 12:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740515661; x=1741120461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Ervwt0Iiaz8TlPYAI0hebTCzxJKg0dTs5t3Xq8VOzk=;
        b=a/ZBgcJ/4Q5WCs/XIj1i3K9L3hbuKSjzh9lQCo3n2PhpnrUrdQPeFJuqWxHWLOKY/W
         JQag3WtLqAdq1krmKJcIup1K68qj/0GbibXA3YD1xytHfdJD5vCpNxq3PPkk6osDt0xs
         SSLH3q9frbSeYL8cATa8phIGHq4RUMGJo8oUsnVnruCUvSep9E+OqWgJmtPsPbKrItC4
         NMkr3JfZWihzlJMM4UaIo1iCOk/qEutO3UjwbMbcQOtIJjxMDwQF0exNnEL+Vv/skfCz
         0JjezeWCU78VVq/PGo9/ABia/2/EZcY/Sku74/4CWV3mP+IJ7sq+izc0R+sz05MTZW3/
         w6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740515661; x=1741120461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Ervwt0Iiaz8TlPYAI0hebTCzxJKg0dTs5t3Xq8VOzk=;
        b=ttiIBW0y5S7eenniWUQ7u3eL01PJd0TKvUhR9gcwIhJPtVqF9HEN02/5hlaZFWzsTH
         fjVqSpxlxJGMcB18q5CFfHAbsVEmiHNOEdhR8wXh0H0ndxVyhYuie3Mw1vCftuC19wfP
         MyHIMTgyzRgklxiXBXmA7XJ9QCvp7OaIOCPY6LzMpP/RVyOz5kNXnEEq3T462srXSOj3
         cxeHG9dD+pVXX0RUxQqZkenJOw4Tu+87YWJ0RtUiOuIhlZWfCcEtoTco+Uam8chkLW81
         LSZzcUthW2DmTXnV8EC6PJKHBVEqHi0e95oICVWafMO8fKYSCH1UMJKQXNbNrYQPhoYX
         aBhA==
X-Forwarded-Encrypted: i=1; AJvYcCVv8cPQGf1GhLTKjSH4xSvjI+tBU11xFKjr0xNmt6whzwys5k1EO4pmcfSGX4uRrzC1poi4NNw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7v2MoKunfm1KfJfOBlGuy/JAgpB7YXH1ktO/j45k0UDaTIG0n
	cWZ3riPyPQo8J7diC0GheRN5mL/ojf8yT00qsvlyNPjWtC995xBy
X-Gm-Gg: ASbGnctfkhgYNkd4zU1cmQwsnHg2jjSUj+QhYiNqlQRkPiKplMm7mGZkO8k3xela4Ie
	aWxCXDlVD37SUg34bh+RSLr4qanCvA9Bsg5HVA3DjMRMfBoj4CRsiJuvaUAUEuAdX4jiUv7NpCt
	3e5xgCK2rDFZJnZM13WtqyzLCm5V4FxuSd3Ne4M19KSJUjpwvsiTduvNHSqhtdNSKQi2UMD9tpl
	frYdY7sYdkMbxVmGhSAMS1p0AQC5IL7KWrn6xU+Ksg1+3TCGkmu/WNNvQuxKSCJ+QHy30ntfrTU
	WTUT+eWd4ocU7/WAjnlCk5/is4u+dDRejYohgE7NPKend6HBi3JbURMkvQWCX7YW0I9mZWd3aQ+
	jMPKCCZK4lpEL
X-Google-Smtp-Source: AGHT+IH4PaS/thx0o4a7besZweYaotUTeodWY36gLy1s0OvXS5nmZXjt97njg+FlwYzzfUDwC/lzFg==
X-Received: by 2002:a05:600c:468e:b0:439:9828:c44b with SMTP id 5b1f17b1804b1-43ab0f3ccddmr50953145e9.14.1740515660513;
        Tue, 25 Feb 2025 12:34:20 -0800 (PST)
Received: from orome (p200300e41f187700f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f18:7700:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab156a10fsm37694025e9.37.2025.02.25.12.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 12:34:19 -0800 (PST)
Date: Tue, 25 Feb 2025 21:34:16 +0100
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
Subject: Re: [PATCH RFC net-next 2/7] net: stmmac: provide generic
 implementation for set_clk_tx_rate method
Message-ID: <qnxvliijwsx7p7xht5mklsbpywgsx5kchsv4gagjmiuphwgoqa@tr2gidpfktxp>
References: <Z7RrnyER5ewy0f3T@shell.armlinux.org.uk>
 <E1tkLYq-004RZ1-Kw@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ub7wq6jvawxv6zt3"
Content-Disposition: inline
In-Reply-To: <E1tkLYq-004RZ1-Kw@rmk-PC.armlinux.org.uk>


--ub7wq6jvawxv6zt3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC net-next 2/7] net: stmmac: provide generic
 implementation for set_clk_tx_rate method
MIME-Version: 1.0

On Tue, Feb 18, 2025 at 11:14:44AM +0000, Russell King (Oracle) wrote:
> Provide a generic implementation for the set_clk_tx_rate method
> introduced by the previous patch, which is capable of configuring the
> MAC transmit clock for 10M, 100M and 1000M speeds for at least MII,
> GMII, RGMII and RMII interface modes.
>=20
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 ++
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 32 +++++++++++++++++++
>  2 files changed, 34 insertions(+)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--ub7wq6jvawxv6zt3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAme+KUgACgkQ3SOs138+
s6G1TxAAi/NDxcQZKCI10VHrxMsf1JqDQf5d16ugQYy/sfomsGLksVt7u4qo01eJ
56Nwsp31cLXit8KO6fh7kBhXbkKaozzFKpgvAeTCQyHM7KOmEKrIfrs7oo1fyFdR
brnyzTSp5r301ED3wgPNAwg1lbSOFDX0JhSHF4lrQwkIu7TB7FC0gMlrNVuX4ll1
6Jsi4x3YBtz+7zJh5KWFXlYnaGy2LCaYeR1JJsO5RxHtoL1QriSwcn0v8Z4GuaKN
euINPJQL8ERPhMWzGY9KhUbUyR8CY3q87LBq1+cWzCZ4G5oO7zCKe1nuWuaUMZUR
6eSfVvvpoa1DYRU7hlkllxD8WFE6adoOv9MR+5KUpMxDUN+fpGB+9kFfInnHJeOH
QagK5nVlC+2WiXyfdATHT4Kef8m++YGZPuDeEtBgzHnOZ4IK+zvlsyf69cONycCU
7oOrEmojJxKMK0A3o4/kFNccQNaPB3ZVdoRXJkZvdBjTuRZ2uvpKvYpoRb4bhAmE
CF0avGa67oZSPuTTSizHZinbOmwpUsl6RhBS6rnqsWBohLzE0gGLAtWHs7lkyI4+
wyEduelKoxYTYtcniJXK9RPPT59d5AajwDvEoA3uu3PLLfSY6FKP3Yg1eELMZS4u
0XC+px/bSRP76lDB7td0YPQFcgCAmpRW4bJgB1oK8/OGDNh1V1Q=
=85N8
-----END PGP SIGNATURE-----

--ub7wq6jvawxv6zt3--

