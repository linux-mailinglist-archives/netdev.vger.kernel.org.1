Return-Path: <netdev+bounces-212188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 708B1B1E9F5
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 16:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3129C625E3C
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 14:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61752797A0;
	Fri,  8 Aug 2025 14:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HK8r9EDm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3125C25BEE7
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 14:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754662000; cv=none; b=UfrKvXlkFWe2plsBzq0Rhmp8D7HL6Bq5BEFofai9IpLH4yhkyBAYFktNOyHyAKxYIZz+uk+cxFSYlwxTOQeQGFuBsUVOmyBRp4TeTN/V57dB/G/XxdgNTwNpocCpm87t7sYNF8Nh6+CGS8JiGViUGnQaEFdj45gwi/Us1gMyUqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754662000; c=relaxed/simple;
	bh=Iq6OPfb0BUy4RFBX3eUrfo9zr9SoPfRQuh+fqYCnQLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfshviM4XmgNTudpogKH3rZraeZiuvA7F7NT4vBJSaF0gMyN5Ahq1LR8GvHHR0llkSCqtYoukEyuppHnh5xCzNejfvDeQoedLauCuPTyQ6U9IDcyHo+Y1YmKsZaiUz2+7XatP5AK4E4eo/QsCN4/6Gwotpfirw0377FkuQ/paDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HK8r9EDm; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b0a0870791so29551421cf.0
        for <netdev@vger.kernel.org>; Fri, 08 Aug 2025 07:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754661998; x=1755266798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ziOgj5AOK/KCYmHORFalDdaCAEaK5JFXOuVwayAxXmk=;
        b=HK8r9EDmbd5MzTcRUmlHPMzvrN3shxlR0iJElTnkj0pLIp+EPyB/8VIs0i5KAMV10R
         ESqETDrG3Xc6I4fDf26ncn7iSacCjhAJoOigbp7iH9VJ8ETXE7vnsuUVmmx8O1OVrEKe
         U+kseDaP/m/IyjcCGbM3MtiNgQhYeeIdBhcX8eRHEK9fJ1oVT9o9Q+3mYsLWaHho7twc
         MO06XOypLUi51ybX/pWPuznD/CQvdKbmaHt++uJgNcC4kMTGjbcSzxedV1WAAS4kR/Ct
         6AXnrzgYD9+iaE9lC2SyehFmDa1795ZWGMc46wdIym+cqwcJyLGI51A0lGrWxX0RrWBD
         xOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754661998; x=1755266798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ziOgj5AOK/KCYmHORFalDdaCAEaK5JFXOuVwayAxXmk=;
        b=V4gUVBBiPZpWoSsOTj/kU6lem27VUcdnvYHhhQM9fIffE1VAorXC5Uc7vWbUUFqZrN
         8atqltg9TLG+d+3ziivKbbpzXaKOberU1v7siK7/9ezCBhgXL+mXshuRaNkwHlRHi7T7
         66HdrUlxeVb+G/LP4yPsWDIX1yX83Ew1UvampkbhshgoxaimnDI4I0et1llrAOHoXvDp
         aUIJdQD9bOdeaCqW2kFk+tNwLb/vD78v+oIpMuXFuyXV95lXIoTNUQJd/OHEFTB3kwTk
         9C2adM3j5p6Qqh269UgJoSt+rvMSX2b5c8HBdxyvOItWUcJ8t1DPf/cYJ27FQFogj5Bv
         7utw==
X-Forwarded-Encrypted: i=1; AJvYcCXjD16MP+HePN+OeIHy/87OZ8QpT6j3tzZbITpuBgLczX/eH/Mf4SxZsLwxLqUiocz9NiSOM9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys5DXq84AyB5iAT1sGe6YZIqKNcz6ZJb3zSoTBdAWAc/GFX8TG
	bP8Wdlj3XttOyHVZC5ofCTsEJ621J7NXaXf8kDMuzIW7pwD9BHxi/Ig7CbYGh8jrlu1L8m1OTut
	ySgX5AG5OLn7hQJ7JCuRq4ytQex78AtI/ndtlmLQbWIApmut46l2ocRvW
X-Gm-Gg: ASbGncuDVuFErV6SP1cMkJs6kGlMvCVGOHTnXPs2puvdwliXfMv+ruC2UCWcMkFO675
	FCI5ajjsI6ewkgboUzc74TqRUmEf/OKJjK6XO8HUxxQfeedNdDaP80jrv8la8gOu/bJ+UayFPoH
	p2jQyhC5fv9/GQFs2IRHZWrWsHJguTdnUsmS8yL+FgzrNTIxmS5wdiqAhiVdEsl0sn/19VpDbog
	itkXC3cdrSatYY=
X-Google-Smtp-Source: AGHT+IHRGdX/ZHsgv2T1azwRgMELMQE11Kj9YJ9ySkdVHUQtPdOrWYZ9G4v5taRpQQUvTlquoKOl4cF58xAG4tcTuiU=
X-Received: by 2002:ac8:5a52:0:b0:4b0:6463:7d0d with SMTP id
 d75a77b69052e-4b0aee038e8mr47518731cf.42.1754661997500; Fri, 08 Aug 2025
 07:06:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806180510.3656677-1-kuba@kernel.org> <CANn89iKvW8jSrktWVd6g4m8qycp32-M=gFxwZRJ3LZi1h2Q80Q@mail.gmail.com>
 <20250806132034.55292365@kernel.org> <CANn89iLbDQ2Le-7WU2dWvr3bc4J-Jcra-rX935Or4wRXDGVViw@mail.gmail.com>
 <20250808065730.602dac6a@kernel.org>
In-Reply-To: <20250808065730.602dac6a@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 8 Aug 2025 07:06:25 -0700
X-Gm-Features: Ac12FXwxiUBJWwumM34Me8cVKTR6BwlbT11JvjUaBWegzEU4L43LQNutELiGo54
Message-ID: <CANn89iKs4AsfM_315030-08s2f_1jmzo4Hou-MDKu21q1JcXWg@mail.gmail.com>
Subject: Re: [PATCH net 1/2] tls: handle data disappearing from under the TLS ULP
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, borisp@nvidia.com, 
	john.fastabend@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	sd@queasysnail.net, will@willsroot.io, savy@syst3mfailure.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 6:57=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri, 8 Aug 2025 06:51:06 -0700 Eric Dumazet wrote:
> > > > Can a 2^32 wrap occur eventually ?
> > >
> > > Hm, good point. Is it good enough if we also check it in data_ready?
> > > That way we should notice that someone is eating our data before
> > > the seq had a chance to wrap?
> >
> > I could not understand what your suggestion was.
> >
> > Perhaps store both copued_seq and tp->bytes_received and
> >
> > check if (tp->bytes_received - strp->bytes_received) is smaller than 2^=
31 .
> >
> >               if (unlikely(strp->copied_seq !=3D tp->copied_seq ||
> >                                (tp->bytes_received -
> > strp->bytes_received >=3D (1ULL < 31)) ||
> >                             WARN_ON(tcp_inq(strp->sk) < strp->stm.full_=
len))) {
>
> Nice, I think that would work.
> I was wondering how to solve this yesterday and I realized the extra
> condition isn't really needed. We just have to handle the inq < full_len
> more carefully and remove the WARN_ON(). I posted a v2.

Ah I must have missed the v2, let me check it.

