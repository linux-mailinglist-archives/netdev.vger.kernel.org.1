Return-Path: <netdev+bounces-68032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F86845ABF
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 15:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB8312913AC
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 14:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E765F478;
	Thu,  1 Feb 2024 14:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="GjnY3/bf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7290626B1
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 14:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706799573; cv=none; b=OMwp9wUc672yktxgBTqxY9AryGKvra+nOZMEfLq8Dz/TxTmYqI14utqBl1I6rT6jyV67yiCrbxQj4U131AXtbrB+KBP987jOWqkLtIwg94UFmCSfKftM6/FpjpxmppMxbbDgtjTTaLMj+WcGMJENFflZjsoE7T8+LWjWSdjeypo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706799573; c=relaxed/simple;
	bh=sLCEWl1fo/Rr8LQN3ZDXWnVZZO1w/1dx0HkUBDZvODA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rs8a0mhDUlcZnYowUZgZY6ueg7/FLHljiwlvMnrTjm8u5n+NjhVAU1xKEbzKHN4fj4Wr4haxSRzrNyIoc01x2n2BmZ9lde98PvOE23AEsd4b1nNM3LhMG4FTXPsv4fqXOO4qoAAeHylK7cYYn2aIYjVP4pjPMlMxmr9evlpK7Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=GjnY3/bf; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dbed179f0faso1708364276.1
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 06:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706799570; x=1707404370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9reY9PWlNqmHuqbNOF3zjL5GkEZkM0CUBj0SoCVGjA=;
        b=GjnY3/bf2xSZ2j0XWMzLJn97vzG2HZZdSggMBV/CTkftAo8RFqPUr8uxJ99vfmgo9B
         GwLgxpNcfMfJSH6KeDpNfTMhtEHVH0wfJN+7Ph/2eoIqhxGzC7/KRt3UDC3aUmFaw+mC
         OncnvRPltJZBmW6mJEeWR1OBgIp1Iv7nvJaz7pPDGmGDYXSSNM+SHWPukF7+YZwyOh9I
         ZNLdOT2JaXAOnEPkpsoj4Y2ILI1EucO8Myz89qdByysxdywet/343M+23WY4J3I11iA+
         a8YwSUxSiOlJQYT4mvToli6LaPieAoYePSROCyAX677RZtnkHt09/oxKMARvPZ3FfRjz
         I2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706799570; x=1707404370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9reY9PWlNqmHuqbNOF3zjL5GkEZkM0CUBj0SoCVGjA=;
        b=COa2/lOFHBgrRKC07v/6uBK2LRcO+ldVV4Dx0td3pvb1QYt1FfcbpvW7qpyx2GfkiG
         kikEv/iHVSEZTs4P/y2KQq9JlscvZjnfS30c+p4wAy48Anl5AT4rvZQ/x1neDAE7kCvD
         UUenxFh2AYLfXciBZQtlmIqCm/ybID1vXPs8A6UkqHyNhGhvhGYROCjhpFaSZb2U1ch+
         SQbx4LT6GI4yPDDBCl/I+KJdy/4SCPRkvMKtBLBDwPguwIJnd7kqfNiH9qSDN/vzJvIi
         BTsU9c/e/SmD7lX+ifb5Lm4nOeJG3XyX7dESmymmj/hMlnGbA+/bRx/r/hResme0gdPv
         Vt+A==
X-Gm-Message-State: AOJu0Yw1Iylr01x5A1N7sjO8aeI6h34FTZGibUFSYCYUWkokgupw7jie
	HywKYmVQGNMkUKMARuFLp5hDZ9BaYURrY4xE6qRRRpfBQn788WPeQtQwmVnTzP08p8PJP2wifUG
	OeQIoeJ6bVQyd7Aut6AQY2Vnhyjm+/IgJsZu3
X-Google-Smtp-Source: AGHT+IFNHvtkVN/I4sFHRzZ+nYUYNkxGtlbAnXounCfmBdOBwbEdsdK9tBiqj8cEpNzJGmCYsoJNeHMSWDBzPR3oyGo=
X-Received: by 2002:a25:688b:0:b0:dc6:194b:9240 with SMTP id
 d133-20020a25688b000000b00dc6194b9240mr3188427ybc.31.1706799570687; Thu, 01
 Feb 2024 06:59:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706714667.git.dcaratti@redhat.com> <91b858e0551f900a415b2d6ed80a54d7f5ef3c33.1706714667.git.dcaratti@redhat.com>
 <CAM0EoMkE3kzL28jg-nZiwQ0HnrFtm9HNBJwU1SJk7Z++yHzrMw@mail.gmail.com> <Zbt9JmpDq3cAbq1b@dcaratti.users.ipa.redhat.com>
In-Reply-To: <Zbt9JmpDq3cAbq1b@dcaratti.users.ipa.redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 1 Feb 2024 09:59:19 -0500
Message-ID: <CAM0EoMkx7RLwRf-m8NRKOLDsuLJ8CUB4kwXojZrHTdY-vpLQ_w@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net/sched: cls_flower: add support for
 matching tunnel control flags
To: Davide Caratti <dcaratti@redhat.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Ilya Maximets <i.maximets@ovn.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Davide,

On Thu, Feb 1, 2024 at 6:14=E2=80=AFAM Davide Caratti <dcaratti@redhat.com>=
 wrote:
>
> hello Jamal, thanks for looking at this!
>
> On Wed, Jan 31, 2024 at 04:13:25PM -0500, Jamal Hadi Salim wrote:
> > On Wed, Jan 31, 2024 at 11:16=E2=80=AFAM Davide Caratti <dcaratti@redha=
t.com> wrote:
> > >
> > > extend cls_flower to match flags belonging to 'TUNNEL_FLAGS_PRESENT' =
mask
> > > inside skb tunnel metadata.
> > >
> > > Suggested-by: Ilya Maximets <i.maximets@ovn.org>
> > > Signed-off-by: Davide Caratti <dcaratti@redhat.com>
>
> [...]
>
> > > @@ -1748,6 +1753,21 @@ static int fl_set_key_cfm(struct nlattr **tb,
> > >         return 0;
> > >  }
> > >
> > > +static int fl_set_key_enc_flags(struct nlattr **tb, __be16 *flags_ke=
y,
> > > +                               __be16 *flags_mask, struct netlink_ex=
t_ack *extack)
> > > +{
> > > +       /* mask is mandatory for flags */
> > > +       if (!tb[TCA_FLOWER_KEY_ENC_FLAGS_MASK]) {
> >
> > if (NL_REQ_ATTR_CHECK(extack,...))
> >
> > > +               NL_SET_ERR_MSG(extack, "missing enc_flags mask");
> > > +               return -EINVAL;
> > > +       }
>
> right, I will change it in the v2.
>
> [...]
>
> > > @@ -1986,6 +2006,10 @@ static int fl_set_key(struct net *net, struct =
nlattr **tb,
> > >                 ret =3D fl_set_key_flags(tb, &key->control.flags,
> > >                                        &mask->control.flags, extack);
> > >
> > > +       if (tb[TCA_FLOWER_KEY_ENC_FLAGS])
> >
> > And here..
> >
> > cheers,
> > jamal
> >
> > > +               ret =3D fl_set_key_enc_flags(tb, &key->enc_flags.flag=
s,
> > > +                                          &mask->enc_flags.flags, ex=
tack);
> > > +
> > >         return ret;
>
> here I don't see any advantage in doing
>
> if (!NL_REQ_ATTR_CHECK(extack, NULL, tb, TCA_FLOWER_KEY_ENC_FLAGS))
>         ret =3D fl_set_key_enc_flags(tb, ... );
>
> return ret;
>

Ok, i was a little overzealous there. When i see tb[] my brain goes
NL_REQ_ATTR_CHECK ;->

> the attribute is not mandatory, so a call to NL_SET_ERR_ATTR_MISS()
> would do a useless/misleading assignment in extack->miss_type.
>

True.

> However, thanks for bringing the attention here :) At a second look,
> this hunk introduces a bug: in case the parsing of TCA_FLOWER_KEY_FLAGS
> fails, 'ret' is -EINVAL. If attributes TCA_FLOWER_KEY_ENC_FLAGS +
> TCA_FLOWER_KEY_ENC_FLAGS_MASK are good to go, 'ret' will be overwritten
> with 0 and flower will accept the rule... this is not intentional :)
> will fix this in the v2.
>

np ;->

cheers,
jamal

> --
> davide
>
>

