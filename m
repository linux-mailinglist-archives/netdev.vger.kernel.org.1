Return-Path: <netdev+bounces-147483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6049D9C88
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 18:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53C56280EFE
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 17:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD721DDA18;
	Tue, 26 Nov 2024 17:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cktW2a8X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8041DD87D
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 17:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732642012; cv=none; b=Z7RX88LQxxz6rcqV7jE1EyaxY2wDNox8wlJaShML7c5vmRA9Udrc/izUjyCcp6xIkJ3iEFBCIG1oeau2xqYBumDmybq0nCMzqLuLobtkhvhzXAIs9ybehVJPV0FsL/cNFmyyaCKYTG5Rk+VTDVYyZQdoFAUYV/92bZIJeCY2KvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732642012; c=relaxed/simple;
	bh=LJ0wcGYlrdzzT+JsXpyfoU+myTRf/hm5QxtFGD6joiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPRd4lKu18PafSjWUSO279lhXxnE2FmIwjdqr6rjKWRz07jk4UUVgaAFw2iU8TtMpZiuUPTMgIMeDWNdFioJRTKtqrAU/NMLQvJ1qJrll5RkG7rkQEGHv+eOPLjwhQD40B8wbGxAhS+UC+l4+yFUsT3BkD/QANOgzdmQgvUwrLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cktW2a8X; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa5302a0901so461134466b.0
        for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 09:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732642009; x=1733246809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYVd2ErvHw3b1O97b/f+kYfa84QN9lLJolQSnD2QUys=;
        b=cktW2a8XDveT3XF9rmzg+IPRMVZjWuZt4jl7C4MbNZJROR41Zncwe93utvJjfiE/1X
         shJ7vJlKRF1zlUB3+X5WMSIJ1Suta14FvEuRteqwoPwdBvt8YwIDfLMhI7Lwb/ZdayWo
         e259/yJVfbnExZ/ymzzDC5QDlzcfVSzYd/B4KHGnNP2W4mi65mKEvMed9JZ9X/AJJ9xr
         E6I2WrYRx0l8OnxnygUJ/7rJYTAslHl46yXXKmmA0/ywQxRpIoxG0WfEkXCqXu/bjhcG
         6d7yvxWwCSv8gEUCLuszFkuG61yAi2kEPHo8+rsCE9jkqSqRB+JNcLgiNreFdgOQLFVw
         qxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732642009; x=1733246809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZYVd2ErvHw3b1O97b/f+kYfa84QN9lLJolQSnD2QUys=;
        b=TikWbEoC1HjwHxP7HPToB+ZJBbZ3eG9kScUTsSQABqTWJoUN1otV0pvkP9Jgx2VRcE
         xlsMEXyz48vIyofuZfm2vpePj/LX06eGescfAK2ERKJaKLzWWsrD18e8jShGrrn7jYK0
         VF3CDzaN4tM1cYPO2oXQTV0+JhRHAPZMjqn8BlIqzbfqC2XGrGuomT3C6CkBq4F3bkHF
         JRCYhZ2/UrWdhVlg0Wy7SsJ/cHqxtXtag+1WF3X5KnvTXqs8Fmvsx/ymBGcIPE++m7sD
         xCpwL9bHLuNUy9Nm/SmFNCEXoRMtxDK6DBSvfkxsBX1odLS5AF92KQ1qZ7tk9rPbwwvh
         KMBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhDFumKeqPWkb7zbe7bCgZSikxhD0+Hcq+e3FEug31W4M5i30ec3iZraOeNviaBH4XHF6x8gw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/3CsoYwUKlPyzP0U9BbciGTogQ9dal+tvfj9TqGzsapZMqe+u
	x0UFaKpKNqZWvy95wLL0ebktq5hK5YHK7/V6i512E+eK7igAduT6SneIC/SEl2HT1TDjkxPk2xv
	p4VThcOOm27ZD1OzM8z1WovmDh/sLKSo2K2ef
X-Gm-Gg: ASbGncsQWLcYqYd2kqnX33hslMVFfkVSx3POB99aWGtLaRzvfpNWB14GRHGpI4UOe4i
	9D/v3IWW7dKN14pkdQPg8DPQ/bKsOL/QA
X-Google-Smtp-Source: AGHT+IGaIo1OjomAHxVLtr6+fEuG0yAG9l2ER1svRfkKK0dKr0HHH1ki1oBP3DQzND2pUzzCS/++tCUsbJtC9sq5AzI=
X-Received: by 2002:a17:907:7810:b0:a9e:441c:f74d with SMTP id
 a640c23a62f3a-aa509936dedmr1311394566b.16.1732642008902; Tue, 26 Nov 2024
 09:26:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126025943.1223254-1-dongchenchen2@huawei.com> <e4477a20-8f35-43de-a7f9-a0c7570248cc@kernel.org>
In-Reply-To: <e4477a20-8f35-43de-a7f9-a0c7570248cc@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 26 Nov 2024 18:26:37 +0100
Message-ID: <CANn89iLxm+=_rm-GcJ2LenRTDThx2gkrqEJ-bEWqOGSxFVUw9Q@mail.gmail.com>
Subject: Re: [PATCH net v2] net: Fix icmp host relookup triggering ip_rt_bug
To: David Ahern <dsahern@kernel.org>
Cc: Dong Chenchen <dongchenchen2@huawei.com>, davem@davemloft.net, pabeni@redhat.com, 
	horms@kernel.org, herbert@gondor.apana.org.au, steffen.klassert@secunet.com, 
	netdev@vger.kernel.org, yuehaibing@huawei.com, zhangchangzhong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

\\

On Tue, Nov 26, 2024 at 5:23=E2=80=AFPM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 11/25/24 7:59 PM, Dong Chenchen wrote:
> > diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> > index 4f088fa1c2f2..0d51f8434187 100644
> > --- a/net/ipv4/icmp.c
> > +++ b/net/ipv4/icmp.c
> > @@ -515,7 +515,10 @@ static struct rtable *icmp_route_lookup(struct net=
 *net, struct flowi4 *fl4,
> >                         flowi4_to_flowi(fl4), NULL, 0);
> >       rt =3D dst_rtable(dst);
> >       if (!IS_ERR(dst)) {
> > -             if (rt !=3D rt2)
> > +             unsigned int addr_type =3D inet_addr_type_dev_table(net,
> > +                                                     route_lookup_dev,=
 fl4->daddr);
> > +
>
>         unsigned int addr_type;
>
>         addr_type =3D inet_addr_type_dev_table(net, route_lookup_dev,
>                                              fl4->daddr);
>
> allows the lines to meet column limits and alignment requirements.
>
> > +             if (rt !=3D rt2 || c =3D=3D RTN_LOCAL)
> >                       return rt;
> >       } else if (PTR_ERR(dst) =3D=3D -EPERM) {
> >               rt =3D NULL;
>

Also, we can avoid the expensive call to  inet_addr_type_dev_table()
and addr_type variable with :

if (rt !=3D rt2)
    return rt;
if (inet_addr_type_dev_table(net, route_lookup_dev,
                                               fl4->daddr) =3D=3D RTN_LOCAL=
)
   return rt;

