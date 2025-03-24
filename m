Return-Path: <netdev+bounces-177070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B7CA6DA88
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 13:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A62B716A621
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 12:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F82225EFB8;
	Mon, 24 Mar 2025 12:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="doxrXvdx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9267125DD04
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 12:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742820973; cv=none; b=cAboRgm+hTtR0QoMa8Pdtjhfi1W6rehA7EPzeSRUgBCdCNmkNYYIZV1Wdk+xHWjqogszQIEAZ0uN4eIBUPOPEDzSqxk/+PeMZWFK4oZJHTPKze4XVepY/R2h7cSWxQYx17mGgcPGhlZz2D+a6T7OfP7hjbXR0/LZI3a3LzvmuXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742820973; c=relaxed/simple;
	bh=Bb5ashzNWlu6TPRKb3SZq8oM68pwtoH9f4wtwRqtYQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIREFCPX2U3B0zzrR3TThkjZJpzqs2r5L3klMrdQdkNIzhCrr5Uagoy7uNT5+hNZtEM3dsqkRAZy+BOzUi4BTfo65TINNR3QpW7dLB+T71Be8e+UxUGeASP3GEjyxAWrfKMH/dfJ/Y9R+9/tQ3JXhMpTxCYYUig080CXQolK9KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=doxrXvdx; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3913fdd003bso2153325f8f.1
        for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 05:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742820970; x=1743425770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bb5ashzNWlu6TPRKb3SZq8oM68pwtoH9f4wtwRqtYQc=;
        b=doxrXvdxyYtGGTFF7JEWuCuWVtoQ0ZD/FKlMJu0BlMlhNPZ+t2jGrdj3lh3LGcy1Nm
         TkLRba8CUr24B9iq689xezt/BFmnrEMdce5/y+LpXyCjOO4E6xJfPNlC22s4uHf3xX0N
         boycByc/0lXny9nwjTXnAgxz7aj0EczA/Kwr0M33OUWr9SY2tjs5lwX9LSMoUwblKTRE
         jzW++xaud7iyE0+EW9YDVQ8lhvlPdeatWTpqdluLeptwiWKOM41rjH7nYk9ChcTjUDCr
         wdq0/ZN1iKGOCUfa65d3mCnAlkq4c/9I++ooSdTOPBZrMz4XKcli8nbPBgaewIlIBdJi
         ZQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742820970; x=1743425770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bb5ashzNWlu6TPRKb3SZq8oM68pwtoH9f4wtwRqtYQc=;
        b=ekGGsMcuMATN0+GCJ0l2F2CwFsVV/lboSIY+TsWMt2YORjUr1tKiDV6hoT/Zt9ui+o
         r8P125VQ4Ewls+To0ur7qdOFHc3GROguJDnxjMxNiTM+5VifXfc8XyOPxE9rwcmszLQN
         9RXEoqXLRLPnfaq2w5rROt5duwSaJLM6sCx/zBCS3xNA+ODyt3NfSsAtJi9c74XG5zSO
         YHBcNDhsp0IUGRaj/yd3W8qnxDfaBJWwICTMfTth7jx6S1qqNYgsTH4gUBwRtNM5XPXy
         UcyTiHzk4c4yTdzU03tJggn1dGSOlcm6KlTbb2VdVxBAuCzP3DoONVodWBaQxxs3ntuT
         3JLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV7AliQsIlw+9H9YPHMLXBB1eF7BaZr42ixOP4CfqL1FckUYS0PR4YyeICpEfatQjRjnW+pZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBV68jj+MWMn5RyAQeX1XKPccR/POvb+IQBTyeNWDoTmk1FalD
	57kKV3b99hG5vxaexQJRK1iRYAHldRFve2OXNGGyjceoeZNUdYP5zqpu0koG5Ts=
X-Gm-Gg: ASbGncuSm0d++QbPr0dcovF0VXTCMLw9uzNr2PvZcaQRsccKi3708tul30x320f+Wcs
	3KkfhxzqwcgMjyf/eAbgOybV2uQQFVkGOGc80k14e5mwKa172gCoIuZNMlMEBYJZ15YmNM8rZRR
	/DiIlD7VVuZ5lDfgOcsFEdTyobNPhHIAl9ffo538n/vQ/IciRWK7+dDqNCT/SBxQpDZ/IrqDSpm
	miPqzBp9Y4rhDvqx01dDvbUH/yLtVGWVXE6Bc1iPImysUJofmjgK5kT6sou6Cc8XfMrneMKF69v
	bCYRq2U+T8dodjQQpqiKszPzE0ILuxuWNDp6LfS4RvnQ4Tk=
X-Google-Smtp-Source: AGHT+IEh+2cx2NjeBYko3qeni7OqGRsZaVwIGE91RRbMpXS3hmSeZB73isRPNemQZA8pSphOxB2XdQ==
X-Received: by 2002:a05:6000:1565:b0:38d:b028:d906 with SMTP id ffacd0b85a97d-3997f933816mr11122788f8f.21.1742820969725;
        Mon, 24 Mar 2025 05:56:09 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9e65besm11013603f8f.65.2025.03.24.05.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 05:56:09 -0700 (PDT)
Date: Mon, 24 Mar 2025 13:56:07 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jozsef Kadlecsik <kadlec@netfilter.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, cgroups@vger.kernel.org, 
	Jan Engelhardt <ej@inai.de>, Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH v2] netfilter: Make xt_cgroup independent from net_cls
Message-ID: <rpu5hl3jyvwhbvamjykjpxdxdvfmqllj4zyh7vygwdxhkpblbz@5i2abljyp2ts>
References: <20250305170935.80558-1-mkoutny@suse.com>
 <Z9_SSuPu2TXeN2TD@calendula>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6dgz5r7q7tf2aomx"
Content-Disposition: inline
In-Reply-To: <Z9_SSuPu2TXeN2TD@calendula>


--6dgz5r7q7tf2aomx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] netfilter: Make xt_cgroup independent from net_cls
MIME-Version: 1.0

Hello Pablo.

On Sun, Mar 23, 2025 at 10:20:10AM +0100, Pablo Neira Ayuso <pablo@netfilte=
r.org> wrote:
> why classid !=3D 0 is accepted for cgroup_mt_check_v0()?

It is opposite, only classid =3D=3D 0 is accepted (that should be same for
all of v0..v2). (OTOH, there should be no change in validation with
CONFIG_CGROUP_NET_CLASSID.)

> cgroup_mt_check_v0 represents revision 0 of this match, and this match
> only supports for clsid (groupsv1).
>=20
> History of revisions of cgroupsv2:
>=20
> - cgroup_mt_check_v0 added to match on clsid (initial version of this mat=
ch)
> - cgroup_mt_check_v1 is added to support cgroupsv2 matching=20
> - cgroup_mt_check_v2 is added to make cgroupsv2 matching more flexible
=20
> I mean, if !IS_ENABLED(CONFIG_CGROUP_NET_CLASSID) then xt_cgroup
> should fail for cgroup_mt_check_v0.


I considered classid =3D=3D 0 valid (regardless of CONFIG_*) as counterpart
to implementation of sock_cgroup_classid() that collapses to 0 when
!CONFIG_CGROUP_NET_CLASSID (thus at least rules with classid=3D0 remain
acceptable).

> But a more general question: why this check for classid =3D=3D 0 in
> cgroup_mt_check_v1 and cgroup_mt_check_v2?

cgroup_mt_check_v1 is for cgroupv2 OR classid matching. Similar with
cgroup_mt_check_v2.

IOW, all three versions accept classid=3D0 with !CONFIG_CGROUP_NET_CLASSID
equally because that is the value that sockets reported classid falls
back to.

But please correct me if I misunderstood the logic.

Thanks,
Michal

--6dgz5r7q7tf2aomx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ+FWZAAKCRAt3Wney77B
SRC+AP9sgXg3/nlHJXqWYQNOLruM+2kuDLj+lHSd6Lank2sSnAEAlIfDtD+FKSEZ
igeXXdA6fXYy92Cwb3N2vY8ZfDd2SQg=
=IEko
-----END PGP SIGNATURE-----

--6dgz5r7q7tf2aomx--

