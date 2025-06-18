Return-Path: <netdev+bounces-199101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F86ADEF34
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 16:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24ED61884956
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 14:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AFF2EACE5;
	Wed, 18 Jun 2025 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMHUvDwn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25042E8DED;
	Wed, 18 Jun 2025 14:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750256644; cv=none; b=YcumIq5DMCrrltn/R/w0xcHsahdPDirQhbAWrVwzGzc22GONJfruPg6JIYr5DVLVb4WpXBF2m8vTPfG/FpPD5vXMv1o8Dm5bu6iYTrmd/UK5CiUwC+VMaBwjUKPQIkHbNT0qCxrQqxhkzJVklbk/OMsxe5X0tuJ2ynbc1DMGwII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750256644; c=relaxed/simple;
	bh=jbtwj0PcQl52Hf+ECRiBFoySeNQq1NFpX1lg20GW3Vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OfI0/csh8LHSLWwSo9drJFmKiZ6EFijt3PS+ajsq9bpClodTMQ/Tq/mPPEtdi2g1Ls2J2MAtMLUaPyScG1kpN2IZmMLpEpxfTQlYv3VzRKNNoICYJVzouIi5BC6f5oC0i+P+Yad5i9+iKBlL9qgq0Kc13yQEciuYBeKVL1iMhWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMHUvDwn; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-32addf54a00so57291111fa.1;
        Wed, 18 Jun 2025 07:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750256641; x=1750861441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/IcyrFiwGOWpE62gt/B9Io7YT03yFKnIKHU1p3jqjyk=;
        b=WMHUvDwnNZBbJvLYppG/yTvEbXerjNgQFdYB7gKGV06xb/B2rqpQ1BgtiaVCdaI3Ju
         gFnIlFthiGunc+u6LQJ18WPQduttv42WVb8ioe4rQwoxs34zdrt7eruvNhuNxpempojc
         4Mc9XMpSiVkHyOXPFPkLlSzeayai6U3Hw/LOstu3V+dGT4B1wWsBPJIhEnZhtSDESgDh
         3agyjiCaQnzHLV9kq/jOMz8FUS4DDxKEtvDAZ+hZuSlFR3wROUkRU+qxG4wKp4ASSKJ7
         OUO6viH3Yk7NARt+xVJDF7nBJatsOsaCklAVkZn6Wlq8pFCA7j+3VVcsg+8w1fUpQx8T
         KEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750256641; x=1750861441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/IcyrFiwGOWpE62gt/B9Io7YT03yFKnIKHU1p3jqjyk=;
        b=qo1pVoAOOnJ6Uqx3MXglSK2XdZlzjtnFObFMIULsoJETXKhcnh/iPEAu+yT+7VcSkI
         Lvmd8w7M4OyogeVpWpI9FrLk2Vd56S+0L5GNQqcVK521M4G5yoH2AAnRjAelHg5VX4as
         4933wilMaYCtTx/HabqYTCS3EtAjJVBPnejbibidWbN0eOvMvK0PPfzxGxDYim3eHrw3
         PPfvFeL/BzhShnCz3wugnZpQpQxY6K3JuYWJi85NcJC3LMVbYa14gtVuO1k4hnffDWue
         pCdtRv6ANKKP1ZqPmZCDaoKTT353008ktPUmsOPth0JwT2J+nrBE1My6d1495l1yL2HQ
         myzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRvW73HCeghYsiESFkyyhvbk4Ur/Hq6r1ZipY67hpVkpIhO+4TSEHc5WjTICTndwVTl4De0+m2@vger.kernel.org, AJvYcCWtS6E1kZYf4cFWU0BP+Aahuoz7uZR7O6J98Ee2wOfENTIv+fc12zp1umD6ittn3S5hu16Im6908vCMcng=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKzJtsF99BL7qS+BiudVnycwEXDBX+X5eFsxuSrHlBET+Uzow7
	mcM6N4s9oKWEz2+OJ9T/r3mi6RX9NuO1FFBI4RtEQ7kKe1469ip5yOVf628m64Av89q5R3W+DUn
	xOyLlcL6Ko7o27L6sMEV0CEkqAcaq140=
X-Gm-Gg: ASbGnctimDZ88aDsxjrz1rQf2TTgAohx3KcJFREgT+hmR3j3gUEju841gw5Dkpwwc99
	IFLutF16qIclUy2TYa43JUJKzSi5qYs4lvXI8yhACTY754+Ia5jcJIOwknIEkAQ72njhseYnTm0
	+68faypg2cT2FcG6ZiejUSGM93AcbdLxq9sh9GUMfZoxbmAPGoeQEuRKBRCZPCuNpC7vWycU3IZ
	9nEiQ==
X-Google-Smtp-Source: AGHT+IEZh5GJLMzXVURg6y/wUKcSU6h1BN8I6BhM2UM98yCfN6NMmxeH65p8HJYUiGNaknluPkCqmJUBhgE91ih5+FI=
X-Received: by 2002:a05:651c:2120:b0:32b:4773:7a80 with SMTP id
 38308e7fff4ca-32b4a4b1834mr62679451fa.25.1750256640657; Wed, 18 Jun 2025
 07:24:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617123531.23523-1-pranav.tyagi03@gmail.com> <20250618105413.GF1699@horms.kernel.org>
In-Reply-To: <20250618105413.GF1699@horms.kernel.org>
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
Date: Wed, 18 Jun 2025 19:53:48 +0530
X-Gm-Features: Ac12FXzbQSWSku9aQkLDSeV-_P6DV8Ph-V1X5OS2vHElwTOgP6u_-N5ZVzKDCk0
Message-ID: <CAH4c4j+CN552qxSy8OpSzyZysTMW=gRKjLR-GPYV9cPuvduFkA@mail.gmail.com>
Subject: Re: [PATCH net-next] net/sched: replace strncpy with strscpy
To: Simon Horman <horms@kernel.org>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 4:24=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Tue, Jun 17, 2025 at 06:05:31PM +0530, Pranav Tyagi wrote:
> > Replace the deprecated strncpy() with strscpy() as the destination
> > buffer should be NUL-terminated and does not require any trailing
> > NUL-padding. Also, since NUL-termination is guaranteed,
> > use sizeof(conf.algo) in place of sizeof(conf.algo) - 1
> > as the size parameter.
> >
> > Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> > ---
> >  net/sched/em_text.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/sched/em_text.c b/net/sched/em_text.c
> > index 420c66203b17..1d0debfd62e5 100644
> > --- a/net/sched/em_text.c
> > +++ b/net/sched/em_text.c
> > @@ -108,7 +108,7 @@ static int em_text_dump(struct sk_buff *skb, struct=
 tcf_ematch *m)
> >       struct text_match *tm =3D EM_TEXT_PRIV(m);
> >       struct tcf_em_text conf;
> >
> > -     strncpy(conf.algo, tm->config->ops->name, sizeof(conf.algo) - 1);
> > +     strscpy(conf.algo, tm->config->ops->name, sizeof(conf.algo));
>
> Hi Pranav,
>
> Because the destination is an array I think we can use the two-argument
> version of strscpy() here.
>
>         strscpy(conf.algo, tm->config->ops->name);
>
> >       conf.from_offset =3D tm->from_offset;
> >       conf.to_offset =3D tm->to_offset;
> >       conf.from_layer =3D tm->from_layer;
>
> --
> pw-bot: changes-requested

Hi,

Thanks for the feedback. I'll update the patch accordingly
and send a v2 for the same.

Regards
Pranav Tyagi

