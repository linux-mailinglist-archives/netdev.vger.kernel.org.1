Return-Path: <netdev+bounces-169630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 955DFA44DF9
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 21:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD87D3B0DDE
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 20:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6AE19F41B;
	Tue, 25 Feb 2025 20:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mC0+ebBZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08B0DF59
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 20:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740516243; cv=none; b=txQdnhPKsJejKAAcfXfq0AegirC2MvF8LTm51iDV3+SJ6vqiVJrUxQjMMWKM8FHrs4X0tuNdOFzofi/zm55+/1/s7VrO2KHmhaspclXSPhhV+LrUHmVVqBeYC79gslbXdBUNwFfHaTjDpnWVQlycbivuWMwFuj7quYHWnZw6fsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740516243; c=relaxed/simple;
	bh=km6GgyUtBYWlPDyGMWfcUJBELXq839o82rzSdqdT8ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQ60KtqMbtKUA8Om6Mcm92eLcwwdCHw4/1XSVk/SQOritrl/W/T/QHKBxWm0bgPSrDQe0pSRs9udSRw5ypVBF/KOxcAUq//1sShUKaTNP/s9I3um01EROHs/Hba5q84YuxgrUyRx+V1kZf+1OtVjCi0GPWDAC5DmKLsxjRGFiPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mC0+ebBZ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38a8b17d7a7so3463724f8f.2
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 12:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740516240; x=1741121040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=km6GgyUtBYWlPDyGMWfcUJBELXq839o82rzSdqdT8ck=;
        b=mC0+ebBZD0oeqvEl5JEc5WzS8WWrsw8T2c34WtE6Qnzg2B0YR6nNgJc0kc5TLTnPxb
         A5KCsQEpjUFwf0omviC7N1SpeDpPARDi4SPGrjtjQWdhiFRXprMQzr266Jj+N20k6vXf
         qCG1Lo+E+Ple9dSISZnTE5uJSFfBgEiLCY8ziqUoiwz+DDz/ueysTksENkcdxrW3pzhi
         sqmx/LXXBGmHjn1rnu8HLzK9ze49/IxQrsegzJnDCdd5Jec4UjL4Nt/Ijhuu7ZS4M1js
         ebH2wYfDfosU2CjiyUGqTV70NOvAEW/MuVr0jMiFXGzD/xR3sbjvpqYD6gkj2fOQdlH9
         hYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740516240; x=1741121040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=km6GgyUtBYWlPDyGMWfcUJBELXq839o82rzSdqdT8ck=;
        b=az3vtYN2SKwfopk4bJSnGYfl2VRNRZpQ9hprUtoRIjuGKNuPy7KlDLlXuLeenleYyz
         E91QSreODZdNIXbLLCJviyu/ZXO2TUZqVjkad6IA21ENwDYY+0oTfclzfZYRLFrG83Nh
         p6E73j/f03xKwTToIX0fwo0kvQaoGVqyQVeeaPLdvzwOs6yS5N5Yt+r2kXbnAFHgrvKM
         PX6syIEqVAsLCVS4Xi7YhWFTYKhZfysT2KCkHitsup9Yg/pG0Z3Fh82kONcculF4vSDL
         /GDatU5Rh9WWXo+cC5w1d8SXyVAC/4R5qxicNTbSgFbC4rzNW5OIiLLQjlywdslPxXhx
         HMvA==
X-Forwarded-Encrypted: i=1; AJvYcCXcjEAc9JZqcAsfHkrm4hmEqCx1X9fywazKdP+EoubDx5BTNajY48Qiha5uKJoH6bLEnNWi3dc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa+fbj4jUT8lVuOsLlCzpxRm8osFnLY0tq3ic/FkCJ/b7adYri
	0e95GzaY32lRZViPyUOMESo7xbRI3aIftKvnuv3cauQYa4GKEe6Y
X-Gm-Gg: ASbGnct/D2aABmyFP4PaHuUrki9q2GhZ2O113CcXONNNnW6Is0CQJ2FRLXh8M9o+SjQ
	hKg1E6+4+QL7+LLO/qbfVUL1SZsjbl/sETkFi9ejLTVvb+2k94Vt6jVYNRk1Tb8TGKa93V1vf1O
	UB65sVgtwNtSMfwV5QSLB7Nvgl8k28tbY/zihOK3Y5WB+M10eoscZcNNZ405R7IS7P05PH0cyFU
	/wE/nqAUbJmIHK7Ot7cxFiTO0nPmZS34FYiKAD5vGsFum8+AwbpAVabFwUUL73MgA9Zij2wNovN
	cCljOWcy+0kTta+zlGph7Ep07zNPsWo58s0mJnGhwehHqz/HoNsFhsH9Gtgpi0Ch1+oPcTn/Gp0
	GrE6eHtw4Y8u9
X-Google-Smtp-Source: AGHT+IFn60vNyjvN8suXWrn3N7MNMCvoYB7tyLvf0VIb/vaa4GNGBrrZf3vgpHtm6zuKbQT61XRnPw==
X-Received: by 2002:a5d:64e9:0:b0:38b:f4dc:4483 with SMTP id ffacd0b85a97d-390d4f421e7mr518360f8f.29.1740516239496;
        Tue, 25 Feb 2025 12:43:59 -0800 (PST)
Received: from orome (p200300e41f187700f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f18:7700:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd86ce49sm3473823f8f.36.2025.02.25.12.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 12:43:58 -0800 (PST)
Date: Tue, 25 Feb 2025 21:43:56 +0100
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
Subject: Re: [PATCH RFC net-next 5/7] net: stmmac: s32: use generic
 stmmac_set_clk_tx_rate()
Message-ID: <x56yik7opvpr3o5vjlxoxzxdicrz2pimsh4lkpxol7c64r6irs@t7dfqy7ybn2a>
References: <Z7RrnyER5ewy0f3T@shell.armlinux.org.uk>
 <E1tkLZ6-004RZO-0H@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ofk7odbwikmdng6s"
Content-Disposition: inline
In-Reply-To: <E1tkLZ6-004RZO-0H@rmk-PC.armlinux.org.uk>


--ofk7odbwikmdng6s
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC net-next 5/7] net: stmmac: s32: use generic
 stmmac_set_clk_tx_rate()
MIME-Version: 1.0

On Tue, Feb 18, 2025 at 11:15:00AM +0000, Russell King (Oracle) wrote:
> Use the generic stmmac_set_clk_tx_rate() to configure the MAC transmit
> clock.
>=20
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

I wonder if the clk_set_rate() call for gmac->tx_clk could also be
removed from s32_gmac_init(). Comparing to the other drivers that
doesn't seem to be relevant since ->set_clk_tx_rate() will be called
anyway when the interface is brought up.

But it might be more difficult because somebody would actually have to
go and test this, whereas this patch here is the equivalent of the
previous code, so:

Reviewed-by: Thierry Reding <treding@nvidia.com>

--ofk7odbwikmdng6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAme+K4wACgkQ3SOs138+
s6G4pQ/9HAe8mzGeYLufQVT2wUZVpeDW6XeOv6EOFIvwsgTf+44yqDw3xiulERM5
tTs3b8w6d4j3xO1PLdXoIlx3vANG5xRtGEcxXY3sB8HjmuSGWWig1zuSTAOJegbs
we7h3FfZwYlMaSJAfvQNZsX/rDN/auA0R8opcByCxOqFAqRwwJSEH+avYvvVgKEZ
Mmzov1YSzCyzB0pEEsAkdaB07XMdwl6Ee+ShlKaXzk88WS8KhxZKhYHWNFaAmqLo
1jyGoa08Vz/Y1WMhLPLCMPrjmWjrMcVjhjCNp9xmCffiJHDAec+eRfV41Cwmp6HC
wjh85xTUS/4hGh+Md5EWO8bxv9aTGHOkGwI4qVxl6xZVFJRkwZkAgrO4teY2RXy1
/flh/cJcM9x88N9LAemunvF+RuPBv5mHV8VWgnJW2a91p7hWKZWV2gxcbzEL4L8p
oKBcQDleR7I9gCunuLnQRiQlwSyw4oKX/96IQ86Dbr8th4/4pKsWtxfDPjHtqzo0
XzbRtT+vlLIFlTprG9nh5PLO/Lxs9OzJ0kiqhJh24nAwMNxbXS/msQ+m8PRWT3C/
/okF5ojWT+0ZijDIGhWi5uwBNWxiwav1tElTfJGEHIyz2qOiFZyFhUH7oi5E9iB4
rin6SAkxYbIF5XDT+zuqAifn/g0BNDr2moVdUvgImYtAMQUCLmo=
=c/GH
-----END PGP SIGNATURE-----

--ofk7odbwikmdng6s--

