Return-Path: <netdev+bounces-73324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A9485BED2
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 15:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD7572836A6
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 14:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4499F56757;
	Tue, 20 Feb 2024 14:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="gz9WjqWY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3809266A7
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708439570; cv=none; b=Ohnpjze7zo+JQEirl+WEJzwXlbJ47OTYlE/hQCu5ToNUFOZ88wEiNPdLyr0kNz/ovUluocXQXO7Iy+Dil4W8zxvY0dnnvLTA76XayJCaCH4ceiCNNoBoIWwS/6AL4dotxEifQWqEXd+9gbp9uX3+Kcs7iH4D1jcV0kEsM8wCpDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708439570; c=relaxed/simple;
	bh=kCNTrCnbUX+6caHN5dUEmhVTDAmtyLkcVI9+CAoWb5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aHYSnumnrPpEKCbkELw0eLPF+lI18sy3k46nZwoGQhumEX1+zERq6gISWSPwAnS+7tbh/upSeB3tiFAq07bLWYpVMdGqb6nLe1w7Phxf6t2DoROVAMl0J4+2jIRW8Egz/UW9kevnNSgVbUtqv67HM8S3l+cBK9/uTpYvva/gVjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=gz9WjqWY; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so3664178276.1
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 06:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1708439566; x=1709044366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=na87No466PCveheqbbJ0wWNcE5MYUk2g/mycC7sjbJI=;
        b=gz9WjqWYJx8hMlu8jV+R0gKJbz2J68Dy8HlenaEqxjbLrh2pxptZ93UlpaxCVXl7mh
         rV8MnJOhRZU104hA3To20CsOBcuVmX7vSKfDoEE49rho/K7653I67ruq9gi1t+qtvVlO
         vD6d0pzfeYwyraz9UpJh5uSmUvaE/0+ubqPHLXMxDNb6+plR7cmPRGwDS6bz0/OEO4HO
         RYOM/ucfFOlFqU+WtWIwhxpHbIx4hJwog3nI1pyTDUqV1bYKy03h4L3KFG3ot5mQm8o5
         RJkF24ZSyVRSv5aHIrS8i/u45JQt4XamXUkYDWwfHfm8PtXSXhPgbS1rUaprFHpY2FxQ
         C32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708439566; x=1709044366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=na87No466PCveheqbbJ0wWNcE5MYUk2g/mycC7sjbJI=;
        b=DMp/Mfavz385j0JS3SaZEyPN8taKR79IiWCVqIROfkO/yinNPjepdZoAEJV0ie3wBI
         4crfSM1OiHC6HBha60ndNXQwDAxmVExaAf+0G7L9ayiiBJVdBkeKFci7TUJJ4g4grCLj
         kirB2SnqvYXUvkubYMaVUoQ/GZHZmwKjIIwuYGYz//UdnYtDdkWgyGgW0xPaFUQE7/h+
         8Sd625bFTNTCsZfj6YORur7FbOXhwVetgaygU4KYT81o0CQYhhxNTT8KCJePw2v//Ams
         nWJzck67j1sSftoSvvO+3+7eOuJDRUSnjauY0ZINKGzCxwRkUDVIRITsPy14aKhvpt/Z
         tltw==
X-Forwarded-Encrypted: i=1; AJvYcCW/IbqX5xcxM9CnreBhySD63lPsVUmWCTQee+pF5SHTgaHV8mwi6TxsIfEaBGVg3tq9Jd/AnB4kiy3qU3nPQBpmihyQxEpX
X-Gm-Message-State: AOJu0YzhDU45kNOhP9uOpJjYLstp+4sC8MVvZ4XHh3RnAf4Zn/g8Vs29
	KWMMBpJoQFojgFE4FGjRJfy24JSRsMAKETdh/RQ1wC6XolMQr59jgLgSWS5WGOTTdyUk0LEz034
	A7leeT2WolqUvcadXHil+yL6LsB8wJGGJeyLk
X-Google-Smtp-Source: AGHT+IF9m8pTdX30xf2s3g1yw9ciPjyf8alqHyHoeFgb0KZVxBtoVPFwQwyT4qgY69/ktYZCBhosED8OKlWr3UQHtDw=
X-Received: by 2002:a05:6902:e13:b0:dcc:a446:551 with SMTP id
 df19-20020a0569020e1300b00dcca4460551mr13799589ybb.52.1708439566366; Tue, 20
 Feb 2024 06:32:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240218194413.31742-1-maks.mishinFZ@gmail.com> <20240219095921.64594de5@hermes.local>
In-Reply-To: <20240219095921.64594de5@hermes.local>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 20 Feb 2024 09:32:35 -0500
Message-ID: <CAM0EoM=S0dcaFv-poo78PP+3KfZ=EFK51bWhdbpyMwz8MJxMug@mail.gmail.com>
Subject: Re: [PATCH] m_ife: Remove unused value
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Maks Mishin <maks.mishinfz@gmail.com>, netdev@vger.kernel.org, 
	Jamal Hadi Salim <hadi@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 12:59=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Sun, 18 Feb 2024 22:44:13 +0300
> Maks Mishin <maks.mishinfz@gmail.com> wrote:
>
> > The variable `has_optional` do not used after set the value.
> > Found by RASU JSC.
> >
> > Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
>
> Yes, it is set after used.
> The flag should be removed all together and fold the newline into
> previous clause?
>
> And since the if clauses are now single statement, the code style
> from checkpatch wants braces to be removed.
>
>
> Something like this:
>

Yes, this looks better.
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> diff --git a/tc/m_ife.c b/tc/m_ife.c
> index 162607ce7415..fce5af784e39 100644
> --- a/tc/m_ife.c
> +++ b/tc/m_ife.c
> @@ -219,7 +219,6 @@ static int print_ife(struct action_util *au, FILE *f,=
 struct rtattr *arg)
>         __u32 mmark =3D 0;
>         __u16 mtcindex =3D 0;
>         __u32 mprio =3D 0;
> -       int has_optional =3D 0;
>         SPRINT_BUF(b2);
>
>         print_string(PRINT_ANY, "kind", "%s ", "ife");
> @@ -240,12 +239,9 @@ static int print_ife(struct action_util *au, FILE *f=
, struct rtattr *arg)
>
>         if (tb[TCA_IFE_TYPE]) {
>                 ife_type =3D rta_getattr_u16(tb[TCA_IFE_TYPE]);
> -               has_optional =3D 1;
>                 print_0xhex(PRINT_ANY, "type", "type %#llX ", ife_type);
> -       }
> -
> -       if (has_optional)
>                 print_string(PRINT_FP, NULL, "%s\t", _SL_);
> +       }
>
>         if (tb[TCA_IFE_METALST]) {
>                 struct rtattr *metalist[IFE_META_MAX + 1];
> @@ -290,21 +286,17 @@ static int print_ife(struct action_util *au, FILE *=
f, struct rtattr *arg)
>
>         }
>
> -       if (tb[TCA_IFE_DMAC]) {
> -               has_optional =3D 1;
> +       if (tb[TCA_IFE_DMAC])
>                 print_string(PRINT_ANY, "dst", "dst %s ",
>                              ll_addr_n2a(RTA_DATA(tb[TCA_IFE_DMAC]),
>                                          RTA_PAYLOAD(tb[TCA_IFE_DMAC]), 0=
, b2,
>                                          sizeof(b2)));
> -       }
>
> -       if (tb[TCA_IFE_SMAC]) {
> -               has_optional =3D 1;
> +       if (tb[TCA_IFE_SMAC])
>                 print_string(PRINT_ANY, "src", "src %s ",
>                              ll_addr_n2a(RTA_DATA(tb[TCA_IFE_SMAC]),
>                                          RTA_PAYLOAD(tb[TCA_IFE_SMAC]), 0=
, b2,
>                                          sizeof(b2)));
> -       }
>
>         print_nl();
>         print_uint(PRINT_ANY, "index", "\t index %u", p->index);
>

