Return-Path: <netdev+bounces-228249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C36FEBC590D
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 17:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3751883B46
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 15:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995B22F25F3;
	Wed,  8 Oct 2025 15:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3kgxx6g9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106C763CB
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759937164; cv=none; b=itc7mWH7P6E3fsPUspc8HS3o2CD4AGdgqaJyYtSafHR0D+dJ6lA7kfxWMz03CeUkYG64KM7xoomD7c2PF9KFWbjgl1nqb2VxryqY2kg2OV/qLjMVLiFKHoDn5X+PyHpZ4uAQQXfwESxZNFRS74rZUnG7xwhWvPllihoH8T2jI44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759937164; c=relaxed/simple;
	bh=SQBWCpBgLP+/RvcD/6595vd6vOu25M0AzpXvCuHDuxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=goKjHedmPupXDa2ged0i7jdvqxDAzeI5pLjx+uu0uGvy7W1dOc3uSQx33FAmhiFzKavIRFxn8s2s3yuluPUR02MFczQsno2y54jMig1GWB+Akzkz+ocNqy8+WMLQRGRhTLucqJZy2BZNl5BSVC3gb5YtxAUmHsX/Lws8g+tXWq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3kgxx6g9; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4df2911ac5aso46470101cf.2
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 08:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759937162; x=1760541962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0oafv7DqO3zrhFHK+mNWUe5ZhHeH5fLsITg/MHv/n/w=;
        b=3kgxx6g9eH5YXvkACQKD27ixEL57UC23HGgGJQBdC8C57/SIjkqAu/ZSw9JXgMVu2Z
         0cgZAzUBDal8Q/RMvPEgfrlev3qC51wraLtgeZHWAgJ6bJJZRFeI5HmOmJAW9GfSmQHD
         VdbgLY/FffFU7mLL39YcnfQIBdG144RlqYp5to2LBZ043yf46veOZk6Fu+tgEyqw4OE+
         kNKj/yQj4gjrt4z3IySvgyaoufwfW+8gUNcuJ6yznQChbE0j3KFuxjdJnzdiNthYL7kS
         9RIwszFQvs3lo5Sq7ztLmjxlLUH5v/UTOw0F45oTbDSAXFmeqysIVlIFtoSg5PPqbNlx
         rL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759937162; x=1760541962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0oafv7DqO3zrhFHK+mNWUe5ZhHeH5fLsITg/MHv/n/w=;
        b=Jgr7ARLqNUo+jJveJpHJdBGXbLJmJXm/koOXElrphCCCCiP0c7KS7u20WoBgnjAowq
         gJLeaZyukacvDf1UmeaIpIILde0v8RXSlvF9T3LwGvxole+ySH1pOgvuMh9tAHnuXIfg
         GLi/TykG7wQSOfxTQQgOvVjV3seD6LeRYI3AOZ5zoLEkTcD2c7Vohm2emYODIVm8jPoM
         X7Lx3Uo2dgm1XcmQKkP05N0CQaoSy23K0i/UBs2D7ibSSJCjCwKmURlp/9hR2qx3nY4c
         fKZ/V6lDTF1lokWoLIsgKWZ1mIuTy9MJdPHLbd08wd5Stwnd7VPkpE632+0+52E5LaWo
         EGpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWedgCuc7SVaDUOiT1WSn65+r2kZk2/wamtworQK4a8BTZW+LLxPaFZYceUZ/ClkpiIwQ7A+Tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFGQ8me/fKZB4QJkK5OvuZKskeCzPBqhErE1+jzdrc05wDsgp7
	W3sTKgpONXtq6WpnozXwQblMDyYPkp+tGhNZCzmRgUNJuL+x7uW2vAvzcikQSCZ7lgAO41Ruwhh
	UGnb2K0xi/f4XP6/8uneraLSPm8BXsLdCbZmbnPSS
X-Gm-Gg: ASbGncsIkvf7UNvY+Pg7584RLu/DniaNutcb5+jY8NXvdo4MkwRa6ZIbklbo3MFdoX0
	hq1+uJyrdS4rD2cgMIXqXsddtZR/7LoKsZzFc9QVXwhCK1mdo7OQacMCEikGuKefCm/QVA47FPM
	ZiurqKMiJ8mmI9PwPeUICnOg5Ii9ScstlvPcA4VKQZ6gf+kX28MZ9j455wlQR68ER7KYmMZ9mxq
	OMEvP6C0cJO9pzwhCNfC+A4mS3Sut6lBuNUx0RKnqeDUOZ8jcx9tHWqEPbz0t5MkkJfDj1H
X-Google-Smtp-Source: AGHT+IHiJeavenOBUq9hxU9x3viwbIhix9jT08DZt301Re8DewR+XYd2ofUpZrOj9cfSMoSCikqwuOhZeMDSNVkU/44=
X-Received: by 2002:a05:622a:4243:b0:4b7:aff5:e8c2 with SMTP id
 d75a77b69052e-4e6ead657c4mr54597061cf.58.1759937161230; Wed, 08 Oct 2025
 08:26:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008104612.1824200-1-edumazet@google.com> <20251008104612.1824200-4-edumazet@google.com>
 <3272d2ee-dd62-4f0d-82cc-f50eb1106fcb@redhat.com>
In-Reply-To: <3272d2ee-dd62-4f0d-82cc-f50eb1106fcb@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 8 Oct 2025 08:25:49 -0700
X-Gm-Features: AS18NWA20nlh63XU-ZC7DrAIZ21xtgdBv9g0bt-T00o5n5yHyr1ArMH5CydF0GU
Message-ID: <CANn89iJT+BUfY9QCh60zZEst0tM5jq9BxyfPcq8bbkOm64H90Q@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 3/4] net: add /proc/sys/net/core/txq_reselection_ms
 control
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 8:21=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 10/8/25 12:46 PM, Eric Dumazet wrote:
> > @@ -667,6 +667,13 @@ static struct ctl_table netns_core_table[] =3D {
> >               .extra2         =3D SYSCTL_ONE,
> >               .proc_handler   =3D proc_dou8vec_minmax,
> >       },
> > +     {
> > +             .procname       =3D "txq_reselection_ms",
> > +             .data           =3D &init_net.core.sysctl_txq_reselection=
,
> > +             .maxlen         =3D sizeof(int),
> > +             .mode           =3D 0644,
> > +             .proc_handler   =3D proc_dointvec_ms_jiffies,
>
> Do we need a min value to avoid syzbot or some users tripping on bad valu=
es?

I was thinking about accepting all values. I do not think syzbot would
find any issue here,
even on a 32bit host.

0 could be the value to disable the feature, instead of

echo 2147483647 >/proc/sys/net/core/txq_reselection_ms

