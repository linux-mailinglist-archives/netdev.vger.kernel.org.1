Return-Path: <netdev+bounces-146622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B49729D49BF
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 10:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79599280C0A
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 09:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047C81AA7B1;
	Thu, 21 Nov 2024 09:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PNNaKEjv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E38215B14B
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 09:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732180612; cv=none; b=pTdbBgRK1v5tuo/jlsfXd3alizRkr41L6GnTi1w/LolI2e/V1SL9HSoXACzzZ8lNgkaChRZSfwGTrUboMaipW+omiqo4hw4VvAqV9VPXqNcC8l7h7yKGKVYepAG3BJSzdzSdwvO0UdP3alE0RSDlrAHpj3tjq0hCCLbvWHYcWhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732180612; c=relaxed/simple;
	bh=sGMHB3SZJK0nL3Fp3gEnDL8A4oGUDP+I19BB2TI4zKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J7F2ZiGqMgS8ulLO7CDwRKEhjOTyJqJHhpX7CFzJToxfDBdMlwfW7CY24MgTL1BXvqNSwpdk4uBZRxdbtW+nS89iTd/1t2jcx6cHrzW7pTi5aKQURGopZ+PfPpZbrLdHLEooV1Fj+Co2ABCJ2rR3kZ5WWFv3KkpOXviPsKBFYdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PNNaKEjv; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539e044d4f7so6e87.0
        for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 01:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732180609; x=1732785409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3s2WQlWvcDc80eC/0fm6XKW1SB71J8+zdjn3yfV+Yk=;
        b=PNNaKEjvVJDdVcGM1nfl5jhRztPqRo0Z5vrpm99R4ICeGxQPYIigaVuqIE83zOhb8x
         czVI4FASawfMIzqX38Fch66p+nuH168j1FMWItyA+EwWYRtpldJsVLgYXG7V00tjFE6N
         a0DR2rCFzbl2hrCicEKqA0WsW8x1/6cmvOaVREM2tTABZttCW9xALgzMGU5W6uOVlDSa
         xE1wQhp6b41rZw8BK6exV9d3vWcGfmasoHm+Bl4KUIhMcvH3NZb8IghDT1ku4xcfdlh4
         xih/8A15mYMEaJKOuNDTWgSdk6REFva4Ph00hA/0+LB89LDNRpITGHlTyWv+1yuDSen3
         u9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732180609; x=1732785409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3s2WQlWvcDc80eC/0fm6XKW1SB71J8+zdjn3yfV+Yk=;
        b=LuPTDELj+mixHyUK9Sq6Lyp0cE1LuvHADedTCo3cwKTQiZGdkSWHl0TjuzrKDh2Z5R
         LmheE5s9EW3/xkgHV6Ev6q8xqclp1uaN0/idCz0mvzj/NU3MtoxwlQmexnz+uFzr4u69
         QTw8QLjraR+76zC1cF8Ie+qLxyhCAKB/sVJiGaP/Y7b5PENGZj1YYDliTqXUkOq2RBKr
         aeDK6I7qB8wrb6VTdXa1uAe/2pwOMKoWdHh91sZTXe8pybZwtWTszaTuUSw/Ku9BbpLQ
         6PSIsM3mYj0UtwIw03jlbWGLSsCn+r5CrFbcAcB6dsG12ksdbfi/4FtXgkFJ3BSEHF3D
         Iqrg==
X-Forwarded-Encrypted: i=1; AJvYcCXVeFA4LsjN+fyJl2DlQHr+nsEBwBVu/C/KcZg9IKpkDcVVWt4dBcZsGVt2JFFzx9NfGPy223Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN1TebmScTIFIpVt2aMAn9kIkHEj8yxjXAHivd7XFJ9hsZAeAl
	ExkAqbI/Wj2gCqW2xFRC7GAHUEH2vcrELOrgSTYtZmNU4Nt5503fxj12odzqZl5u8kCcnqKdzFI
	EiRZgtsVUCMvaRq2vlV2an9gEs86guUI5gG7Q
X-Gm-Gg: ASbGncua6d0G60jWrMKDRDDiXZw95tzReqTjgowlVhvj7l3j2KG3Jgw0hqgAq6JJn1T
	V9m1L6pPIgd+qyOU7ZlwaZCTdMtWcz4Y0yTNE/AJ8cRXIrs31abI4v6hzh/kmy8mc
X-Google-Smtp-Source: AGHT+IERdoQmvN5lPzIHrV+Di//dXCzHhM/Zdnd6NCieoDUryF6n4aePZJGGrKhmaedG4aTr/as4UKQMc/ST1LTlnao=
X-Received: by 2002:ac2:5639:0:b0:53d:c049:8d60 with SMTP id
 2adb3069b0e04-53dd0a72f32mr25e87.1.1732180608351; Thu, 21 Nov 2024 01:16:48
 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121054711.818670-1-yuyanghuang@google.com> <322e75ab-8ae8-4dd0-9646-ef41d9ff2fba@redhat.com>
In-Reply-To: <322e75ab-8ae8-4dd0-9646-ef41d9ff2fba@redhat.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Thu, 21 Nov 2024 18:16:10 +0900
Message-ID: <CADXeF1Ef6h8bdHDiqAUhyZ8jg+fpgx69YBTiV6k27JYLhP4R4Q@mail.gmail.com>
Subject: Re: [PATCH net-next, v3] netlink: add IGMP/MLD join/leave notifications
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	roopa@cumulusnetworks.com, jiri@resnulli.us, stephen@networkplumber.org, 
	jimictw@google.com, prohr@google.com, liuhangbin@gmail.com, 
	nicolas.dichtel@6wind.com, andrew@lunn.ch, netdev@vger.kernel.org, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>, Patrick Ruddy <pruddy@vyatta.att-mail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>The variable 'scope' is not used below.

Thanks! I will fix it in the next version.

Thanks,
Yuyang

On Thu, Nov 21, 2024 at 6:15=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 11/21/24 06:47, Yuyang Huang wrote:
> > @@ -901,6 +904,58 @@ static struct ifmcaddr6 *mca_alloc(struct inet6_de=
v *idev,
> >       return mc;
> >  }
> >
> > +static int inet6_fill_ifmcaddr(struct sk_buff *skb, struct net_device =
*dev,
> > +                            const struct in6_addr *addr, int event)
> > +{
> > +     struct ifaddrmsg *ifm;
> > +     struct nlmsghdr *nlh;
> > +     u8 scope;
>
> The variable 'scope' is not used below.
>
> Cheers,
>
> Paolo
>

