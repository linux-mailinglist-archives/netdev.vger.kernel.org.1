Return-Path: <netdev+bounces-134169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CC1998422
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 12:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0907D284F59
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 10:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AD21BD4F1;
	Thu, 10 Oct 2024 10:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvX2gmEN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B9D47A60;
	Thu, 10 Oct 2024 10:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728557307; cv=none; b=O7O0WdvgX0PijfDK97Go72wTUvOILiNGDQ7QEhuZPHjeAREpwwEgSqZF6M6Iq9DeNNQU15rOPrn0tcfQS6XcPBC2O8+DiFSBcFVStPofKixIcRDOMUfNPRwAAldGlFL/Ge/3V36LZK6MRkCYEdxPix0GlcYIuvjC8FI28xhPpp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728557307; c=relaxed/simple;
	bh=0T9dRU9geH3kbn5TpRdK2OzXuTFir0IgYdKO0AM+3bM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TcoJ1uSeBaKFWjzA631mr36HXGOeGtIgP56u6FwW0Nz++qYKGLq/TFjUtmRg5bdWzSuYtL8YAEbe1OHF1wtOVl+WMknbVV4sG3VTPkJbIRZfVMfRL1EcQWaYEnFs4Djkf8eeL+McMZdXNyuFfIXRt8EbF0nHOT5htW2sHqjXh1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvX2gmEN; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37ce8458ae3so574757f8f.1;
        Thu, 10 Oct 2024 03:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728557304; x=1729162104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0T9dRU9geH3kbn5TpRdK2OzXuTFir0IgYdKO0AM+3bM=;
        b=QvX2gmENvRl0r6pTUxWM4pn1Y/9rqjE6/xCp/SEIpxVzqfAjR00xAYn5DIHdbp8yWp
         sta/1VYw4ra7NCperTnfbMKYZupyoCr7TD70Do1pxGWIRK3I2wL2+NHTJWxlUMy/6zK4
         SQem9BdpKeSvKC3IBcjmCDzPVbuANqJDQz1k2/vge18addDhQbdlOYFG7wMupDnYjKbC
         W/gsdzLINDiGICbN9SynnkAvFb5lt3IW7GPdH+Xgof6xZ/GjSL0B7+78+MDZauOIWJ9V
         8BjYXcqkZ2qLK5kx6d+k3QofXFsxcBCDVlasaLssghFK0suRPGqiqLu58Ci5rNQ8pO7V
         oJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728557304; x=1729162104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0T9dRU9geH3kbn5TpRdK2OzXuTFir0IgYdKO0AM+3bM=;
        b=NrKFLTp7R49xD2I4S7lcjTnihmWeIXvymMLHerm0l6u7Nk71DQT/yMgDrQ9UUfdO44
         oPCf6Z0HbVTTkp8txdqqqJV2YDyxAGFwaNfv65RGbriIl+q1X2yQOzGdDAvn0FDNL7FJ
         5PDgBQ/XJdgQoFlqrxPoKNL66rVSxuQOCL6ezEB7ODdQ1SW7UUH7AHhKasECj2ffWgkV
         I6645Ej8V4EhHkSlD8rn6r3eiccMQVIkF+qlT7mcQ0ofmiv9p/SDHu53769qEt5eB/VB
         K0dzU6oMLvlD1l2vQs33VCwBTl0m8kb7qtSS1NiR9r5vWIte2RsCj0BqRdUXJzbIWP4k
         cpZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP3UrV5taPqeDf9dDHUps0zTrcqLOGOdu8bfQkRlyFeEaPnd3PrEF9NxVOUpg9ClTvlxGC7kNTle4Ubg==@vger.kernel.org, AJvYcCWYMFFKJPNnV00VGoYjsMqYV4MAVlA4rLl/CX5C8lJWoGqUlS/8LMtr1YgFYSX65x4WA/4c9H6q@vger.kernel.org
X-Gm-Message-State: AOJu0YyOfhPqb6SvnPWkmuR4IX2gzAZfMv74IlYLl6BsvCu8SD7LUA+y
	VuPRW5jB79/hHxYbQeA1FAw+Ka9nDMhkd1gPipRu3YPK2nFapdQ/
X-Google-Smtp-Source: AGHT+IGFacz8Bxb67pDXXgq4f7zbnGvWuNGMKQTcWN2BroPEPemJxgR9KYZCWv1VkFjJTw2MeMLihA==
X-Received: by 2002:adf:f850:0:b0:37c:c51b:8d9c with SMTP id ffacd0b85a97d-37d3aae2866mr4805697f8f.38.1728557303716;
        Thu, 10 Oct 2024 03:48:23 -0700 (PDT)
Received: from orome (p200300e41f02ba00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f02:ba00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79f9c1sm1175918f8f.68.2024.10.10.03.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 03:48:23 -0700 (PDT)
Date: Thu, 10 Oct 2024 12:48:21 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Paritosh Dixit <paritoshd@nvidia.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Bhadram Varka <vbhadram@nvidia.com>, Revanth Kumar Uppala <ruppala@nvidia.com>, 
	netdev@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: dwmac-tegra: Fix link bring-up sequence
Message-ID: <dadvdpiexel5c4ckhpbk6y2sf4kwqqsgyk4i2lx44n22f4zem5@3dwaqmert2m7>
References: <20240923134410.2111640-1-paritoshd@nvidia.com>
 <qcdec6h776mb5vms54wksqmkoterxj4vt7tndtfppck2ao733t@nlhyy7yhwfgf>
 <6fdc8e96-0535-460f-a2da-cd698cff8324@nvidia.com>
 <7485182b-797d-4476-b65c-7b1311d99442@redhat.com>
 <27e70746-ffdf-40fa-a335-bc6e59e7266f@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gqvovi3vbdnz26rp"
Content-Disposition: inline
In-Reply-To: <27e70746-ffdf-40fa-a335-bc6e59e7266f@nvidia.com>


--gqvovi3vbdnz26rp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 07, 2024 at 02:50:56PM GMT, Jon Hunter wrote:
>=20
> On 01/10/2024 09:43, Paolo Abeni wrote:
> > On 9/27/24 17:28, Jon Hunter wrote:
> > > On 25/09/2024 14:40, Thierry Reding wrote:
> > > > All in all, I wonder if we wouldn't be better off increasing these
> > > > delays to the point where we can use usleep_range(). That will make
> > > > the overall lane bringup slightly longer (though it should still be=
 well
> > > > below 1ms, so hardly noticeable from a user's perspective) but has =
the
> > > > benefit of not blocking the CPU during this time.
> > >=20
> > > Yes we can certainly increase the delay and use usleep_range() as you
> > > prefer. Let us know what you would recommend here.
> >=20
> > Use of usleep_range() would be definitely preferrable.
>=20
> Thanks for the feedback.
>=20
> Thierry, let us know whether we should keep the 50/500ns ndelay() or swit=
ch
> to 10-20us usleep_range() as per the kernel documentation for less than 1=
0us
> it says the typical guidance is to use udelay.

Let's go with the usleep_range() if it works.

Thierry

--gqvovi3vbdnz26rp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmcHsPUACgkQ3SOs138+
s6HmVxAAru/WoonUjH/ZgT6te9HxStmfQleL1dO/RlYQiCp5DQQ7uCfDIm+RFu/y
ZoHTiZDvXycbAIVeMOJrYEOTFNIfRzlXykebNqaXSw2PVSAEC9WkPbpIjlReDZj3
84EDaTzLeFxitiMMEPqABo+iCU7xljKxRFY3kJG/aOwmpvhBuo2dquOLOPc57Urt
tY8Hrl4+TjCzPJfRBcO27TZvr73nN7sV8CtS/s90m/pAGcEecyadkrOHU+lLMXVH
ZtKouF5MSnmTc0V0w/Mf4xOJKXXXQHIF1PTTC6CmoRQcS6gurxN9AgWL4QVSNSkP
uIGY23yc0BzvWUrERmtyCRIiOf47Z+EtK7U91BiIDYidwbRI93+Q2FMCWXsv4T2S
tgm0LKFIso28XTZyjLG7jQv0AZ/JJSQyoW6uKmCVfVoVJIh2U6BMsT2WVuvhfQBH
tOgm381ZuhFpt8QMHalodtg8CeLRrcK5dJOpO6FB+V/LP9t8u66hvaxP5xyZQ+sr
tzNBQ1ivyDMHl8YTz7ywKq34ko8xdo6Jm6ApyjfVEFo31tYDHa/W/Sui6EXVoXTD
jzD5LgMyHBcggrSA1EW5AUhypke1MKxCItZlRxe/d2PSbPnLy1CIZvNUlUwPLcst
2nsU9pUT58bbY0KjOmbcuTOCTuH2Kh5IfxWIkuOP5xZkvz8i23o=
=Ru7G
-----END PGP SIGNATURE-----

--gqvovi3vbdnz26rp--

