Return-Path: <netdev+bounces-138406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 237509AD660
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 23:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29E6F1C20A82
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 21:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D30155757;
	Wed, 23 Oct 2024 21:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="H30QLJv1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA8B1CEAB1
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 21:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729717792; cv=none; b=ZOd8x3lflfi25UCWhpoUXPZdnYUE53K2knHZ3Nbz5L0I+fd11FjqmA+jx87hsgXSzn36pm/nQ/YgvL8Ny/8hE22QUk02/6OYHW+p+wjp9gssIt0Vms8OUEWqycFeLTWR29FxYZm4wBvTYrLkk3xH3KD59J3ombEY0tC9gJFdJ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729717792; c=relaxed/simple;
	bh=K4UruMqFzTmN38XzIraz9t4S8oqQ8qBLTDJL9Lru6WM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XGl+40AooJakp8wp3wjn3VO3JwQWN61NddqJwcK5SuIcnTy+JRiWwnDnmbGHgXxXif33l3lKhQpRb25y2osnf/TgDxAHm5Pd88Pp2Ge102rVlOyBLE4X0j+8sUEE0X7ejhTFeyDx+wpBkgTBD4lERvE8j+GzD8+kbwjeDicnn20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=H30QLJv1; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7c1324be8easo997103a12.1
        for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 14:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1729717789; x=1730322589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omh5zPvS6uc8QZKEx+phWh3+21B1PNEw8ryXVnf1U5o=;
        b=H30QLJv1xGSw7CJrwn65iimtovHvVpDk+3BSf3rBfKShgKtrsOWWu8UYsxypwRRaOT
         AzRedn13I7fcUgQV2Mag0RBvv2xnLaxNzkNjmKNSh4PNGJXJR33WuLRr3YvwiX8bnb0A
         3PMZxsqTGDsX6XJr5V1edcqvjdI0FUudgg5QqRzXVGOgXM9ITY1sIXdVKnaBABP9lxtu
         MvODwanIYV4+OP/jFEwqx6m8cKzW2ckaWpcC6is+fq7VeHXKP2CqKJnMz1K+39YDQNnf
         56/FD+rM2UURLTWOVwchRkUG4htmP1EitjFIPYzafpR6WN6mtvQJK1IdR7L26Wn9oOyt
         1Waw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729717789; x=1730322589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=omh5zPvS6uc8QZKEx+phWh3+21B1PNEw8ryXVnf1U5o=;
        b=bSZFehGsClk5r0FKHt2DRsyu3p6lDMWZd1Up1hgxxvND8EJJsF7CdKGdsvglQXC4Ok
         fQSQ0i0i/A8pF0t3CSXXF6+K4RwStclW4STjWzMCkYFLN6JhGcJ6SnhQ41nzko6WzRpa
         1YfNKIi6bjPlivoTz80DhhotVHosiVp1IHOlys7+8bjynWnBY8rreh0+RoZ4rKrqx8Lg
         Xc0Pbzkn4mqhX4lmsvOhj8udn2HXGYsl1pRfQtJRopaMcAT6ADmIPUldR5R+5NdQfnVl
         ZyyZWA9T4pIs34etOd77xJzHRELJJM1EDAGoC4pdxGcO3fewcfsgDYW5Mgjyf902MQrw
         2uxQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7z8419tZs6+8uPAwcoVDSwLikJMfsODHhUpcWvdymDrxX5eiM79ekD9dLETWtWFwXMdACZyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVonmhfk7bo8MPTyueszbFa6OBCNB0jP6JR7aP5ps4Jh8OWmu1
	nr2/7d8fo2Xye1elsWdPIe+GBQ95U+12MBpbyMOKnwnXTP/NowJBCKqWowTLm1s=
X-Google-Smtp-Source: AGHT+IGwGGso9gJjs/PVaa5vDFPxm2EywMsP8y1alxjyiTaWN81ixjtYJJlz0WoEVy7hpQy/MWy1uA==
X-Received: by 2002:a05:6a21:38a:b0:1d9:281f:2f27 with SMTP id adf61e73a8af0-1d978659716mr6012022637.19.1729717788824;
        Wed, 23 Oct 2024 14:09:48 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13336f1sm6761899b3a.81.2024.10.23.14.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 14:09:48 -0700 (PDT)
Date: Wed, 23 Oct 2024 14:09:46 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ij@kernel.org>
Cc: chia-yu.chang@nokia-bell-labs.com, netdev@vger.kernel.org,
 dsahern@gmail.com, davem@davemloft.net, jhs@mojatatu.com,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com, Olga Albisser <olga@albisser.org>, Oliver Tilmans
 <olivier.tilmans@nokia.com>, Bob Briscoe <research@bobbriscoe.net>, Henrik
 Steen <henrist@henrist.net>
Subject: Re: [PATCH v2 iproute2-next 1/1] tc: add dualpi2 scheduler module
Message-ID: <20241023140946.2f6f66ce@hermes.local>
In-Reply-To: <76bef0ad-2d27-aa2b-fe5e-02ab5c752793@kernel.org>
References: <20241023110434.65194-1-chia-yu.chang@nokia-bell-labs.com>
	<20241023110434.65194-2-chia-yu.chang@nokia-bell-labs.com>
	<20241023085217.5ae0ea40@hermes.local>
	<76bef0ad-2d27-aa2b-fe5e-02ab5c752793@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 23 Oct 2024 22:47:00 +0300 (EEST)
Ilpo J=C3=A4rvinen <ij@kernel.org> wrote:

> On Wed, 23 Oct 2024, Stephen Hemminger wrote:
>=20
> > On Wed, 23 Oct 2024 13:04:34 +0200
> > chia-yu.chang@nokia-bell-labs.com wrote:
> >  =20
> > > + * DualPI Improved with a Square (dualpi2):
> > > + * - Supports congestion controls that comply with the Prague requir=
ements
> > > + *   in RFC9331 (e.g. TCP-Prague)
> > > + * - Supports coupled dual-queue with PI2 as defined in RFC9332
> > > + * - =20
> >=20
> > It is awkward that dualPI is referencing a variant of TCP congestion
> > control that is not supported by Linux. Why has Nokia not upstreamed
> > TCP Prague?
> >
> > I would say if dualpi2 only makes sense with TCP Prague then the conges=
tion
> > control must be upstreamed first? =20
>=20
> Hi Stephen,
>=20
> In any order, there'll be similar chicken and egg problems from the=20
> perspective of the first comer.
>=20
> The intention is to upstream Dual PI2, TCP support for AccECN (+ the L4S=
=20
> identifier support), and TCP Prague. The patches are only sent in smaller=
=20
> subsets to not overwhelm netdev and all of them are available here right=
=20
> from the start:
>=20
>   https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/
>=20
> ...As you can see, TCP Prague is among them.
>=20
> While any of those 3 main components can be used without the others due t=
o=20
> how the L4S framework is architected, the practical benefits are largely=
=20
> realized when all the components are there (and enabled which is another=
=20
> big step upstreaming alone won't address anyway). So in that sense, it=20
> doesn't matter much which of them comes first and which last, but it=20
> explains why they tend to crossreference the others [*].
>=20
> Implementation wise, L4S identifier support bits are required by the TCP=
=20
> Prague patch so TCP support for AccECN/L4S has to be upstreamed before TC=
P=20
> Prague. Dual PI2 does not have similar implementation dependencies to the=
=20
> other main components (AFAIK) but if you insist on including it last, I=20
> don't see big problem with that.
>=20
>=20
> [*] There's leeway within L4S framework so that Dual PI2 or TCP Prague=20
> could be replaced by something else that just meets the requirements.
>=20

Understood, just want to make sure that we don't end up with some component
accepted and another necessary and related piece gets rejected by kernel co=
mmunity.

