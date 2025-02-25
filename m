Return-Path: <netdev+bounces-169626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 896F8A44DBA
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 21:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56AAD3B66C3
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 20:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5122D215769;
	Tue, 25 Feb 2025 20:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLEwx3LL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8863121504B
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 20:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740515597; cv=none; b=ux+WDLPpag3JeADvRC4UVSGyJhI/p/zGd3ezbgI74QRpSRhTu1/a7XeI/uSTp1Ie9W3bK24NPBSbKhpVFITquB8hEe7DJCqQarcvuU4yvDasu/VPPkKzhOBAVHIen/3t8nCclwdPw7A2bFXbCA1PMd3OJvIJIN4PvtgvHLkr1vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740515597; c=relaxed/simple;
	bh=n+valiEsDDDHrBxP16wgaccR8w/epUQYkjfQhgtXiHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/QBqQ1atIAafVSZY7cPEeK+ueBp3JIKn9DjFQcW3uHjHLt45mcii/5Yax9eFZ9avGehfHraxChUvEdOtD3L4wtNcLg1vhY91Wa091k6EnQl3WBloIOTzXCyNmWj8Ml3HZ7Jq6iPx5+4AIm/jrET3shh5t+gsHjazTfklTR2eHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLEwx3LL; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso37647235e9.0
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 12:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740515594; x=1741120394; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mfzXyH7NZ0CXwUyIU7zqxa+qi2bPj6GEOWtmkR9Kazg=;
        b=GLEwx3LL9N/jvkXK0HK69NcxBltObjYZqTFw1rrLyiyhPhjKsc1x7CaGDIyd9PVZmP
         HCm1oHGaAbxs/t9OntAr8+K+V+4GeecN/2RGHpNVzrpMUEew53pkVha5P8cl0uqUUOCW
         zDrUouXT+spl0YBc04chIrsC0aFyoTY+3e95kkA8zHPPjIHsyTZ3GpX/Xrzs1MNnF4xI
         aqV7FoFrN/fl8bMapWWyXMY7GRFluxtukInVXJJdtSslpgtEDTDnj/3IBnxDxSorvIhw
         WwQy6LGhkoTdOaopSibSG1n+fVBDPxh9Mf7u46re9891ohjx5IUdZ45gQFm55XAzWfSl
         pxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740515594; x=1741120394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfzXyH7NZ0CXwUyIU7zqxa+qi2bPj6GEOWtmkR9Kazg=;
        b=LEdIl0lVkYJ1QZKzZL/yzi2Earo6RvuUKuF63foLc2Xjbzb6uiz4ivLIbEvGoEpPIw
         /xfH/ofsbeE0BGIHwoDCaq02HzDl6+M9taOUR1hiCj68CzgseQ2PObtgE/24uS7dH9ii
         /pZcn/s/lruKmCDcqEeaDHeUEi3U4UlQaPfdqzc57rg8hoaX+eZh0go96YMAjMwSlZCW
         aJO8LUxDxg9Q03AJq82Vojzlfa2U4coOS5UlYNgjAemCMQlWjjhUkKgBfwzz0yZdsMHE
         YP/j6Xel7IT+A/aW6YaOf+fe8/2PijaE5zk6cH3oO2EVjJThkCQDmZyl59ozEPX11S+Y
         X38w==
X-Forwarded-Encrypted: i=1; AJvYcCWYJeIMXY0RtjzAedRQvp9Zm3cSg5c8LFw2E1ZdfbVLnvDJR/q8luQqjeTyyfxM2V+U53NsWIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj7w7TzR9cJVXecLGMxY/Z0zVUInOu6rWiJ3Ilu/QTsDctpuWC
	Nguqlu5qbvHcKORqz6OSfvNVyuocZNNQlUewMSyhgZ5ETYSxgzv1
X-Gm-Gg: ASbGncsRRFc17v0Kxk9hjOnmBH1VRKb3XBcw2buezN/wKDAmDQ9t8+v5f5IoZ8bwZ6N
	FzeD+UiKscWbhQr5hHCnRlSU/cjuhviixE9S8nRzRZJwyPybt4+hT87zrlfPNfrIwNg6F8IGMEC
	yK/xm6NzSfPwyzeoZkwSfW9rhfVvrXfLNYXvb3JIn3B3jeLSLGLgq+kVPEeS5+WyTphzVt4rV5n
	Az7Y0JOvud2Mml9Hd3K7LB6tD4inABkZ6faFM/gnX0uewe6HlbqubyhjeMsO1CA9hAgnG30M1aF
	6f9c5xAJ9mWwkYmg7lGhW0BgYe3i1VTCEgJ254uclbs0U5alhDkS5/kPqic7GC3kKFAarLPF79o
	SkZDbSmTyUWAL
X-Google-Smtp-Source: AGHT+IEOGawFqhgpNgYj/SR8/F9v9KrOsztMk0p6RFVqMJcMCZS2I8sfJ+MqQCPoKPwyjrwTYZAFuw==
X-Received: by 2002:a05:600c:4446:b0:439:9bed:9cfd with SMTP id 5b1f17b1804b1-43ab0f311f9mr49606745e9.11.1740515593421;
        Tue, 25 Feb 2025 12:33:13 -0800 (PST)
Received: from orome (p200300e41f187700f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f18:7700:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd882602sm3388780f8f.41.2025.02.25.12.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 12:33:12 -0800 (PST)
Date: Tue, 25 Feb 2025 21:33:10 +0100
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
Subject: Re: [PATCH RFC net-next 1/7] net: stmmac: provide generic transmit
 clock configuration hook
Message-ID: <qtxnw63qgwt4zbcwktooytp3uwg746gjqdhzqmszz6t2oma4ah@kzlytutixoky>
References: <Z7RrnyER5ewy0f3T@shell.armlinux.org.uk>
 <E1tkLYl-004RYv-Gz@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3tllvznwlcmcp5xs"
Content-Disposition: inline
In-Reply-To: <E1tkLYl-004RYv-Gz@rmk-PC.armlinux.org.uk>


--3tllvznwlcmcp5xs
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC net-next 1/7] net: stmmac: provide generic transmit
 clock configuration hook
MIME-Version: 1.0

On Tue, Feb 18, 2025 at 11:14:39AM +0000, Russell King (Oracle) wrote:
> Several stmmac sub-drivers which support RGMII follow the same pattern.
> They calculate the transmit clock, and then call the clk API to set a
> clock to that rate.
>=20
> Analysis of documentation suggests that the platform is responsible for
> providing the transmit clock to the DWMAC core (clk_tx_i). The expected
> rates are:
>=20
> 	10Mbps	100Mbps	1Gbps
> MII	2.5MHz	25MHz
> GMII			125MHz
> RGMI	2.5MHz	25MHz	125MHz
> RMII	2.5MHz	25MHz
>=20
> It seems some platforms require this clock to be manually configured,
> but there are outputs from the MAC core that indicate the speed, so a
> platform may use these to automatically configure the clock. Thus, we
> can't just provide one solution to configuring the clock.
>=20
> Moreover, the clock may need to be derived from one of several sources
> depending on the interface mode.
>=20
> Provide a platform hook that is passed the interface mode, speed, and
> transmit clock.
>=20
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 11 +++++++++++
>  include/linux/stmmac.h                            |  4 ++++
>  2 files changed, 15 insertions(+)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--3tllvznwlcmcp5xs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAme+KQYACgkQ3SOs138+
s6EOmw/+NeeoaUSqMoO7BHZUWvxr8/OKrzqzdp0HpmensxnadCO/WqOLakmT5co9
XTRZQVmvq+ZQC1nWfstqK4ND3ulPNRma9zkyTk++49QMi40BznccIGX/YcME3zlM
nGdEC5u9vH3xq1GBvsi0blaAouIy/8uqSnI0RXVj1RcJxWO+y99hBSKJnE0QpYzy
T19f4RuwyuQAXFkhjBoBrl8sOJ7mZObyvvZV7/DobMmmFcvWCc1ieompVEWCV9st
CJmAxheTHrPJ96/cWBPfaTLmntsZNV//h7tMjIV+vkBB1a4uVzcRELW5x5JDuC5O
XHtyvCV7Ve02iTxfPVAeK/glqo7CK6XkhK32Uhl+yKp3alu5sP50w9AMlB5LVw7o
zo3fyBvdK5+0L18tdb8fJdr36LQnYnq2Wnb3cT6DkjG/8CKMVocXMfQgfytk1FEp
sIsFNpEj72fQ7xFikWevv6FWfX+5+x3IkiWKGWc62rUBTLUeCbXV8YawYcco2Du2
RLw49bsH7J9GgTNL6ZrD0Q0owRqa0FibL3zMd+C3cl85qRq4jBmhXeluUoPi6Dkc
DI8RPv9C0noqkFN5QcoVeE8n/mTCKvzONdUL4irltre6N/iMSDMfbbxOsdnWHsGE
TWQbPh7S0dUQAbeKa1i8Y/9vALxV3CF6vOtAKvGkqhmgf18Ge3Y=
=BaLA
-----END PGP SIGNATURE-----

--3tllvznwlcmcp5xs--

