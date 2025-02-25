Return-Path: <netdev+bounces-169628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 838BCA44DE2
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 21:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86DA17A37E6
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 20:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC2A2139B0;
	Tue, 25 Feb 2025 20:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfWZ/Iy0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98BD2135D1
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 20:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740515760; cv=none; b=nSjmGT5drqg7oLxJo09dCj5VqwVZ4tGR/VcX3gMIDhJ83Vp7DzeiEO1q/tgfdaJU6iKYmLaTuhS/v7/o9G+xnV9+ITh5DC7hfz8A1TjH6AxsMpNwFZ10D29efwOlhvndc3czC/j75g7dl2q1iqkKPU9P5XYr5XbNPdGdZWl15EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740515760; c=relaxed/simple;
	bh=QMmBwMX6NbyiKavNbUAMAfaw3Yri0OGEsn2LrupgMgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDhUIr+VNnTt+DWTtoXuSspYKXpt7fcer1uH8ff4YfwSL/cJy8fehc6tLNnvnPVg3kzV6HtMwW1AiSfTSMpklPv4g5pp3Pqm7ufmEqaNTXWj3/W/4TqPlVJpEcL3p0MdW+og/HljtAez7gCgB2dBh00oB5Vtxzk+C2IoPOWgM40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MfWZ/Iy0; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4394036c0efso38734465e9.2
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 12:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740515756; x=1741120556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yRTAn8EMHBd2hfR7Y/FJYkcHDF1vc5TPWd5vqlVAC6A=;
        b=MfWZ/Iy0FzvQLF17Hm/EKKW5i6FwNWX7cisM/VqxH5PxiZ6yHC+6S9YBJMu+TgtLTS
         veDjNW2ehu4y6nz6CFM8+KLX99EY8k7M5eo4E2hk5YhQY/iabQiVbgjHe6Gx3WtBOf19
         J/2Vc0MuZ695r120WRnQ1YHSPQc3Gv4h2HymbqKZFoLSYF87Q3wW0W8qL4ZPfci8wwSQ
         eWp/KJgPvs4z0GDoEBcQzZPC9qXGofQboA8Kj0TBKhAnxBdc1A5h3sYjVYOXk1NutCWn
         El+A2bHrC46ZTY0TZ+c5+zIyxn1fidTWiAHv0TDZVrlUVSFhMmhjQTqLeN69MhlkpVho
         Qm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740515756; x=1741120556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRTAn8EMHBd2hfR7Y/FJYkcHDF1vc5TPWd5vqlVAC6A=;
        b=B5OOJHWTye62eYsr+f+xaFvgVrlOc1sJ5wje732Koxp5X1MvcuwTcsy5wP6SctZjSm
         3AH18BRCMGCwlcTLOoz3gf7FVcOihoWzvy6KkiK7GGJRPHF25Kbb8DiMOQOZnyAa9ZWc
         BQqEvArYpzhb6HfnU8bvEvKP6DZT/IJx44O29P/19Nr3A/8MLcRCPBtSp45CrYM4XUQE
         4ZVH+OcjcfMt84d7+1BEwRqlzEV9Ka6usqdVtIeZe1soUOhsTaiMMYMmOea3PZpJerCB
         JvhlXmGeOKRDVrfd3mpKx0laNw4C8hUMmr0FyXR8dZh0rn1Lecl2GiOJAjSUARusegAH
         cVlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUG8Yxq5K8+3Uw99WaxSLt4G4gHGFd14KXXIcxv5fnB4JDF7pmQr6wnHKnfk+lU5zsIK0DZ1tk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOnE5dY81C8O70GeluSosAsQuUPR4vvVn8FyCTbhaspVZf/eXT
	qRuZFfqGfJPZIIqxWWGV7msc8K65LSvb8je0zhzw72EcBgCHpDRs
X-Gm-Gg: ASbGncsjbLE80FzNeiaVYLVBiUkZLES0HN81RB7+EcURlBg6WJDm6aRN/PinIynjvaA
	88Gk2owkgJl3FepbrRPVeojm7I5yhZGeAj1+XL8rs0FDu7nZuvLbwyF5rMUctkZd116IwTGs6UX
	hwTeArlrAe5oJdK/TBbfywqPlIEWL5wq6D3Bz2uOWEgc90P7g+yYqhMm8qsyylXTR3EBDt5SK/L
	QunZ9RjeTjW7iedBfFBdPl5cU7ffrMcy27nNRxzhiYiew3k3z74Cb7HuAWLEKNM3sBy1E76xJ1i
	8Dn+f+DKrMETSLGFk2zO+cQgpV3EJCMlQHRIdwQ+BccqsUtBxQMFHcFOfhxrxUqJBxSG0haS7cS
	NyLRHvKCRcwN4
X-Google-Smtp-Source: AGHT+IHo6pk8C69B1kkZHL451iXWYmac+j4FDXKYrUt1Xc82AEnjWCz9kj00St6aZ3ajRNdoQCt+Tg==
X-Received: by 2002:a05:6000:1563:b0:38f:3b41:c952 with SMTP id ffacd0b85a97d-390d4f36811mr510967f8f.4.1740515756017;
        Tue, 25 Feb 2025 12:35:56 -0800 (PST)
Received: from orome (p200300e41f187700f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f18:7700:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8fcfc6sm3466016f8f.94.2025.02.25.12.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 12:35:54 -0800 (PST)
Date: Tue, 25 Feb 2025 21:35:52 +0100
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
Subject: Re: [PATCH RFC net-next 3/7] net: stmmac: dwc-qos-eth: use generic
 stmmac_set_clk_tx_rate()
Message-ID: <qcarhmsd6u33ij4kupaiyxvyr7jxxv2uxvr6jsnhxjd3o3axkt@z4m3zvdpxogb>
References: <Z7RrnyER5ewy0f3T@shell.armlinux.org.uk>
 <E1tkLYv-004RZ7-Ot@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vvcz2h4v3lcdr4gs"
Content-Disposition: inline
In-Reply-To: <E1tkLYv-004RZ7-Ot@rmk-PC.armlinux.org.uk>


--vvcz2h4v3lcdr4gs
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC net-next 3/7] net: stmmac: dwc-qos-eth: use generic
 stmmac_set_clk_tx_rate()
MIME-Version: 1.0

On Tue, Feb 18, 2025 at 11:14:49AM +0000, Russell King (Oracle) wrote:
> Use the generic stmmac_set_clk_tx_rate() to configure the MAC transmit
> clock.
>=20
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c    | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--vvcz2h4v3lcdr4gs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAme+KagACgkQ3SOs138+
s6GtyhAAwRIkaF1uLIs1z5IXu/G9vXd74IqnK4JNtzGrGKi7NS+cgEqC7yfhY27w
G7nD6STOdAxZbhcGZfvkiSmrRNBmcmrs2nUBr+dM0BVtgpe/vfwOPbFRWd8Xpqt4
6LYaRSYNIsaY3nAXP4+oa3LXly0Fe4axipwapPJGjl9vCnHE30kMULHJ9MhLlbAu
VZzMketr5oN/usTXWFs1gsYk1Xw1wTabBQGENezBr0+H6Pq7BLDcuWPeEV5ie46r
xTlPD/E1rNepOCxmN6uvJSnz/1ei791h7OAK9n/OMZXKSI0XsgkMresehTC2jIFG
CwG03bepYX+Y64iJejVhCgxU2g8Ji8sv0tmTY7vsCFSa98ngzKWAQK/R6H/V6xMK
vNL83T8No6JOneia+ylM4i2ESXII8LmguwJGY9mbRqqS9dmP52HZig7eww/80MFB
g6yx6n6q4Us/vFJuLgnULe8gLcTMCMiCfAtk+MMdJUqb+eQGLPqXwxsIH5106zmF
ZyRVftW1WAa3Yc8cNF43w7IBR4RDIHm8MBUI9ESyL34P7gobx/5Z0C/DudsmnuV9
4ZJO+x5JUTs/P2yCg5VfB4ERHwfPUSf8LrYEJaVY5f4M+kchTApRjyf6v8oF9add
zMdor2E+S+g69+tn77HhPDvuJzTrOnbaIxQsoIwGEIJ1IpnOBUQ=
=aWdb
-----END PGP SIGNATURE-----

--vvcz2h4v3lcdr4gs--

