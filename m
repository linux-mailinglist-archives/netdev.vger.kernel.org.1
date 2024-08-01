Return-Path: <netdev+bounces-115056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D20944FDD
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 18:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B26FC287F48
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE91913D2B7;
	Thu,  1 Aug 2024 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lPMZy1LU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D26B13BC18
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722528162; cv=none; b=n+wIKDFL5nFlOxUgnODP2VNVgmkc4Cwz3bOlCpbI+pnqR9rj0iuBOw2xH+VbpWCwtoVbQMttjQVI1HvtXXRBmO0qnh0hcI3ojGyfC9SFMWyu/O2fxWWdBEwwto6Plu3MJNUGTYEW3VrR5XMszKk+PxPWHOQiKPQNqxlB1N/zw4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722528162; c=relaxed/simple;
	bh=RyibUYDtofNzZaBVyChfG4g97UFljopq5WQ31eQy4rM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lXuxatEZgrPu2dnBJijFOOn0E+F1swOE5KaXrLflXh+TEqkuGLeY2dGZbD7Gb6RgD1iL7TxiOQF3FICCW6SaYEdr0hykTs5XjhvoPjsb6YanA+IRjXhjar6TB09JqQwEA8YEDaD8V5/OqUbr1rt5zUVJraEPyfr1y3w9aTQn8Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lPMZy1LU; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so35825a12.1
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 09:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722528159; x=1723132959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEGICo/0V9LoUdNg+uVoBf+795lGEQaYZz3WpNCHAZc=;
        b=lPMZy1LUp9j5K/f10UBr1/H0JsCPGtBRsCIeIkJcxi85+2Wq09tobWTMxeQdTKH4C5
         2fnmZ2nBVJcBDkSS5KUAKRWqmsJov5yVakrih/6LEv2z0wgZeIvCHH40n/ePhGz2i0Ji
         0zNnBjgK+Q6L14YkfqkiaEFqCgeu1HP47/RSVeiM6naibHOmWXCXrHVQdVEtKl9mGpHN
         smvpBAjjw0XuhKloRp+xtYZvMsuYsvTOOz1qSkDzjP+s0++itmZFFupwxRugmY/bCCvj
         8fWdDAs7rYrVC/F5y6oiVm91PPBo5NHKYALxL4hbIV0+Jipg6HS/C9abZTDom2VY+H3G
         6APg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722528159; x=1723132959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEGICo/0V9LoUdNg+uVoBf+795lGEQaYZz3WpNCHAZc=;
        b=wETC30F92T0kZAI5MCoPUOvvf5LViI6rLN5qRNx4J4JcuXKz02Bj4N2oIcx0D7tUhq
         9J28U3+Gzh5kxzmuc80lYe6mRoOsdD9KLPD2R+dx65M/nsasQEo2aGaELa28ZrKs+s2v
         UM6Z/DlcAsh60g3JCXB9Auy/DVv2jBtSwijUgulYcTNPbu3o3y1BTssR3pFesI1NvoBt
         MY/Kt2sCdbh8k2SRTJkdliHyBlCYQruDD3fIbIgztOSvlqI/SUQqtky6Og5sedAz8rg0
         2lZCN/7ds10EiPkcR2XgvbU+aX+sJaFgWnlC/XSH3QSGQlF8rpO4Y8KOhllJa8z6KK+f
         R+vg==
X-Gm-Message-State: AOJu0YzqYW5P2Btm1Fm0XVPh5yGLcHgf0xMEF8rGzBLRcCwJknbKVOBI
	gs1RkoC01GZTTM6976Rc3Kn9A8A+yjG+iQXyI4RWpPz31T7ESn77H/XSxZ/91nSZPcbYDnRSND6
	TPVINDpyf+XZcE7rVP9Ra+fRknk4zQKSh6hqh
X-Google-Smtp-Source: AGHT+IHGKWhegEWS1+o68tNEpOoWlRIDOMpda4yUsloIjRtvxt9VVD4v5YDhBrJfoFduhMpdEAg+GL+Ytlf9Pl/IY7c=
X-Received: by 2002:a05:6402:40c4:b0:57c:b712:47b5 with SMTP id
 4fb4d7f45d1cf-5b71bbd2aacmr148516a12.4.1722528159100; Thu, 01 Aug 2024
 09:02:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730003010.156977-1-maze@google.com> <62ae3755-f51d-4953-928f-ff2faf7cea72@redhat.com>
In-Reply-To: <62ae3755-f51d-4953-928f-ff2faf7cea72@redhat.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Thu, 1 Aug 2024 09:02:22 -0700
Message-ID: <CANP3RGd3HNMQi=_gFVjp4JiWxUk3u4V8Xyb5Gy=2W9AZjOKH2g@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv6: eliminate ndisc_ops_is_useropt()
To: Paolo Abeni <pabeni@redhat.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>, 
	=?UTF-8?B?WU9TSElGVUpJIEhpZGVha2kgLyDlkInol6Toi7HmmI4=?= <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 6:54=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 7/30/24 02:30, Maciej =C5=BBenczykowski wrote:
> > as it doesn't seem to offer anything of value.
> >
> > There's only 1 trivial user:
> >    int lowpan_ndisc_is_useropt(u8 nd_opt_type) {
> >      return nd_opt_type =3D=3D ND_OPT_6CO;
> >    }
> >
> > but there's no harm to always treating that as
> > a useropt...
>
> AFAICS there will be an user-visible difference, as the user-space could
> start receiving "unexpected" notification for such opt even when the
> kernel is built with CONFIG_6LOWPAN=3Dn.
>
> The user-space should ignore unknown/unexpected notification,so it
> should be safe, but I'm a bit unsettled by the many 'should' ;)

We've added new options to this list in the past.  Even going so far
as shipping those changes via LTS... So IMHO this doesn't seem like a
real concern.  Also the option is very unlikely to be present in
normal non 6lowpan environments.

> Cheers,
>
> Paolo
>

