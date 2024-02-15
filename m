Return-Path: <netdev+bounces-72133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 803D0856AE6
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 18:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B33E91C2390D
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 17:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015A0136672;
	Thu, 15 Feb 2024 17:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="FUmy2o8z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B8D136661
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 17:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708017844; cv=none; b=azU5xWrmmwBkQSUrXwIG1U6ef6zTYm6y7Vozykj2vF6aYOYpaXK8WbkxbR2g3VsGAEA6EYNYq4lSnDfuMWj/klsOGzQlP2IGRPpjhcScuariTSO9JVPUWh5Q9oUzj04knXE1DCMotuqOojDfGg/IDi6Wwyh7rJCzEvbze4/xzGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708017844; c=relaxed/simple;
	bh=/0443loGy5tUz569Yp/S1Q3+MQhR3MGAH8oZodWdsPc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zf5wr9nnkx7oIt1UohxGzUj5mb+y/Go4Ji8q9Z4dqDEa1HX3uIyuwWhig9OHvmD8D/WrDgSEGD65UhO+tF/DIcjvYAJXQ6TgtaL6qt5Qs6Qt/9mmlNByt0+MFQdt8sX4X0n0Bw0q1q/ULtZDjTMJuo3bsVYr3DCS/npbNw9ARAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=FUmy2o8z; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d934c8f8f7so10693705ad.2
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 09:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1708017842; x=1708622642; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/0443loGy5tUz569Yp/S1Q3+MQhR3MGAH8oZodWdsPc=;
        b=FUmy2o8z/CYprWfUJyPAgvWEr1eMEKJOipw1fVRavLdTFTsjWUdiU8ZHOHxTLM1bbr
         /GbhPlwe9acSfK8YgkTdFBQe1eGsFIPvqhqSQtx1yDdI0WYupl50k9iSXthwfc/EN+KR
         L+u4bxOM8A6OmnBoyZpsPECuIuJpUj27lywp0AeuxzZbmHRFDuJXxpDxwfUoEyfgC+Ca
         a9SdhVbTmonvtjxgqm2zh68akKZIvKAyEj5btHwBHRxegXXRiECIknBjyUao8+kb2vRU
         WvP0zD2wIWGWKuhndwegwwvHVp8Zct/ECqIe5SjuC2HdWcjtYnPtPE6IOz/xZr9NSLC5
         s7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708017842; x=1708622642;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/0443loGy5tUz569Yp/S1Q3+MQhR3MGAH8oZodWdsPc=;
        b=hXHh72Dw76sNznAnn++Iltt4dtEZuzSEbT3kXc7N17Il0CtyQMCyzsannK55aic7pa
         I32qex3GnzPmXcycPhv3rcdwmmOKO6tLfeOn+j4+7rn2wm4wvhYRdHQtTNq9DnJ0gF+e
         95nngF3nKffp7Ty4+Jky0YOfXP/qdcV1DkVaV+8RmTGzxTcg/JvuV4QKBOrGqr8ev22g
         6t90oNCU7pdaVaBth7Yar4Ej24OZ4xpxkhFwBupHu0n1w3528HLrtCidw8vhlE1G2Ye9
         +d8kVBPtOw/4SU9spFzZHTSEBPih8rMSECAJ5d9aiRH6vFfBRcuIpCS2rxvDtcpsVAFP
         afNA==
X-Forwarded-Encrypted: i=1; AJvYcCW36O3wOb20CQFVFvzPwOUmCFTOYoYCnuln9JrXhLXW5jyBEo70Wcg8KPzeSGUfIrSI1+n7uKdTcy7j5JH4PrpWVYvMyEbg
X-Gm-Message-State: AOJu0YxqMJNUuf45yy1t8N+CStt7gcOeh3Kd69osTVCCi5f6mGmalNd+
	jm9k6k7sKe1UMydkseW6yfUtojVJtbFmjp4J/HE+XWenVqKt4axjj+gnG1z4OXQ=
X-Google-Smtp-Source: AGHT+IGSbneskwm9uDBxYfMqg3Yo1y+uJeeRS8rFmyh+ukno/mxPlzC27DHcddpsPnlLgMYk70HQiQ==
X-Received: by 2002:a17:903:2281:b0:1db:7052:2f75 with SMTP id b1-20020a170903228100b001db70522f75mr2870113plh.49.1708017841961;
        Thu, 15 Feb 2024 09:24:01 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id v9-20020a1709028d8900b001db7e3411f7sm1512125plo.134.2024.02.15.09.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 09:24:01 -0800 (PST)
Date: Thu, 15 Feb 2024 09:23:58 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Tristram.Ha@microchip.com, Oleksij Rempel <o.rempel@pengutronix.de>,
 UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, George McCollister
 <george.mccollister@gmail.com>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, <davem@davemloft.net>
Subject: Re: [net][hsr] Question regarding HSR RedBox functionality
 implementation (preferably on KSZ9477)
Message-ID: <20240215092358.54c86b2b@hermes.local>
In-Reply-To: <20240215125156.0d9f3cb7@wsk>
References: <20230928124127.379115e6@wsk>
	<20231003095832.4bec4c72@wsk>
	<20231003104410.dhngn3vvdfdcurga@skbuf>
	<20230922133108.2090612-1-lukma@denx.de>
	<20230926225401.bganxwmtrgkiz2di@skbuf>
	<20230928124127.379115e6@wsk>
	<20231003095832.4bec4c72@wsk>
	<20231003104410.dhngn3vvdfdcurga@skbuf>
	<20240109133234.74c47dcd@wsk>
	<20240109133234.74c47dcd@wsk>
	<20240109125205.u6yc3z4neter24ae@skbuf>
	<20240109150414.6a402fec@wsk>
	<20240214114436.67568a49@wsk>
	<20240215125156.0d9f3cb7@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tV8SGA8eh=904HgXGhQW1T_";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/tV8SGA8eh=904HgXGhQW1T_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 15 Feb 2024 12:51:56 +0100
Lukasz Majewski <lukma@denx.de> wrote:

> > to:
> > ip link add name hsr1 type hsr slave1 lan4 slave2 lan5 interlink lan3
> > supervision 45 =20
>=20
> Please find the draft proposal of iproute2 patch to add support for HSR
> interlink passing network device:
>=20
> https://github.com/lmajewski/iproute2/commit/5edf2ab77786ab49419712a4defa=
42a600fe47c2


Please post patches to mailing list for review directly.

--Sig_/tV8SGA8eh=904HgXGhQW1T_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEn2/DRbBb5+dmuDyPgKd/YJXN5H4FAmXOSK4ACgkQgKd/YJXN
5H6SMA//RT6G+pA3oWRymkCyo3rxcKUjjIbhQqJtJBRCnvEJbxlrHrC5tMXHucB2
dg1Q8UDwGWLTwpN9DRm3V1M7MOiZzSdqnuF34t+U1qTQG0Bi4ccpkU+wpIOLd8st
XH38Rwg4n/weHJncJdPRd1V3s3pL73dRDcFFSdPJFPaswyq6UnF08u4kFHs7YAcy
vdBtAXwdmJiri9XK2SU8a4o8MqbDZoc1OMiHCxT9tpldZD4/t2X8G24CAzM5Ma3B
/RA62UJ6xzvfwS5RF5nhCITh8GFhZYYfUs/RD3UxiNJitwl2m4VFTG8TIz0YfuJR
C4Mg7OhguQpFealHpiEjU7hOTP3Zfwc+Ec55YUnf8tdyAaZbNUABvFlG8ICAo3u4
It/pt5dEuBLWeSRKd5EWjd+lgAhJXoceyiJ5NCBHWwH3KO82kZeT+sh2Q9gHjrsK
+/X22kBBCWfiI4txTOLHH+TDaKbQACibxmRBoIUIduz6FGf5jq4sO0r1WMp7kZfT
ri3oRoSj8oG+nVeEq8ZLQC6IqMCg0bBNmJJhf/Cb4O4rlPXtbp85Yu+UWLS04DuO
xwZ4V3eEm3Qz3iNIlvu7FfVF0ENxaDYEMN2T7WEWVvFu668k1TOaDRuhMKSqADxb
lWmwAbnE4IE/wjL8iUozzWPu1MhK6t/4BLcvFn4lRN0gaOeUA3o=
=7aRk
-----END PGP SIGNATURE-----

--Sig_/tV8SGA8eh=904HgXGhQW1T_--

