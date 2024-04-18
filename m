Return-Path: <netdev+bounces-89080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A19C28A968E
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 11:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2FAE1C21D04
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 09:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD0015B10F;
	Thu, 18 Apr 2024 09:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EhIKmwmm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB80125D6
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713433535; cv=none; b=pgBhBdcTz4GrDe4jrSldgSs+qAAlcLNU1GRuKCtCZx1KYNTLsBdoJbQScDAKhbqjo2m/6hR8ZLWWnK3ookvesqEQ9MQZgcAl9bODpWmvpEAU7JY9c97f/GKkDlA+nHViCUMUaNbofBimSmgy4AJE8nWUVn46+n9EB9i4cGfSN7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713433535; c=relaxed/simple;
	bh=7l+Wo3CYORF9z1u0Mv7R456d3JEzDu4QHcw0HdGMRhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ERG9JBP0vZQAXeevXA1a5OXwQ+M4JDJ4Zqtn1+oWuKlJhMXd21kJxi6oqh90ThrN9azHBgisejv0CYcoQ6ccdWYb1a4ClUtWtjmu05rB3k5DyiDbN1dKVP1eNa5HV9Yrelb7JcQEiSv+/euuEkjGxTqzeUHgURArVMmXeyIRTXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EhIKmwmm; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56e2e851794so7952a12.0
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 02:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713433531; x=1714038331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kDRahY2MpauPyYVEokZE5bAdiJqTUNsb9jMqY0UlP0=;
        b=EhIKmwmmvca/LLtCisMNmOJeTfRvacSCNWFw1vG6zz584Z8CC7irQPxGsR0jGPq084
         zeffplRvT4m947jd3NfUUJ6eacmjCscIWA+Z9uml3MdIsbMThV2W5Eqe0gHWaqzwp1on
         4EkCBPopS3leaESmdVHglO3uhwj2pC0Nt9YdbfQLWKLdkA7Bb2Pr/iy+LUMrc6VaSGFz
         FqOhCrKgP9A1hhVpsBDU291RbyijR1DWO5xRqXOUVy/asjCibtZQHYBg2ZFYszG5rZ3W
         Re7S1f9p7lxR6KNFbj4LUogBnXPzuREbq+OXvHJScdr7eRbfRausih6MpsPwcIqLCTNG
         aPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713433531; x=1714038331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8kDRahY2MpauPyYVEokZE5bAdiJqTUNsb9jMqY0UlP0=;
        b=evv02LLJgsup8a15kJ3z41njDpULiF70nvX6omGzNOUuVlMhjSFuYDX3tj4n8g+D5e
         h+okr601+FjbEXtdXEZktp9dTMwM0EVu3oVaUvWeNOLhXm7JDV1kwg3f12Ypz4zXpRlF
         sliBI7waPnVDd9Ceqw6Cnkh5Bk8R3dukzCEmJtRFM1MXWl9eutImQweBL7GP3uprnPEi
         wkX1flXTRsxRyjE3QzzE1xckZ56VOlw+EpJqsY2/I6pphgGqEYdIwmWceRvuXOPsQZKD
         J08GJqvEV9xyYsSr5ghXsh5GMoXuZCgnJrklJP33p+mDEFwCel6rx9wW8CRPh1NSKw1L
         sHnw==
X-Forwarded-Encrypted: i=1; AJvYcCV/KuPpWQ31g/ulfB9HArzylYC8g9faDPktL2zNIjgDCVLyBOoL7ubtZqK2bZsIWEhIai6ivhACCXKbzqpGuMqVMd0fnBAp
X-Gm-Message-State: AOJu0Yy50E4bDQNneKz9UPWymqEYiEYAcgBtPd8LPx5ZN5Ial/qOThFP
	bAY+K9ZLR+8wItXw/pbgJgbjxthRGL4sPyieNd3w4tF1aGdHmrrabeDzz3Dz3K0jn6XyBF0nOlj
	U+WLppLS32PvImiUEhXNhydRRC+SQQwa20HS0
X-Google-Smtp-Source: AGHT+IFqScEzF9lTvG3JHYLX/LlUmjjLvCQX6KoWRorR0xEQSFMz6HqIi28QELYtDRr9bSkUsGM4qPzD3pAeZdjY5LE=
X-Received: by 2002:aa7:c987:0:b0:570:49e3:60a8 with SMTP id
 c7-20020aa7c987000000b0057049e360a8mr93401edt.7.1713433530514; Thu, 18 Apr
 2024 02:45:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416095343.540-1-lizheng043@gmail.com> <CANn89i+TKbGbmy0JJbyhUxQ9Zc_jj=EHv=bYXT5dUvQY7hw12g@mail.gmail.com>
 <IA1PR19MB6545F5F1940C0B326058987ABB082@IA1PR19MB6545.namprd19.prod.outlook.com>
 <3f487ef495da476e5b0564dbb024dca54e8bee10.camel@redhat.com>
In-Reply-To: <3f487ef495da476e5b0564dbb024dca54e8bee10.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 18 Apr 2024 11:45:16 +0200
Message-ID: <CANn89i+d+NSk5VooFn=AHoby5JOJ3=D1oJ1GSKCzp3ZPM1zaLw@mail.gmail.com>
Subject: Re: [PATCH] neighbour: guarantee the localhost connections be
 established successfully even the ARP table is full
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Li, James Zheng" <James.Z.Li@dell.com>, Zheng Li <lizheng043@gmail.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"davem@davemloft.net" <davem@davemloft.net>, "jmorris@namei.org" <jmorris@namei.org>, 
	"kuba@kernel.org" <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 11:33=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On Tue, 2024-04-16 at 10:36 +0000, Li, James Zheng wrote:
> > On Tuesday, April 16, 2024 6:02 PM Eric Dumazet <edumazet@google.com> w=
rote:
> > > Hmmm...
> >
> > > Loopback IPv4 can hold 2^24 different addresses, that is 16384 * 1024
> >
> > There is only one Loopback neigh "0.0.0.0 dev lo lladdr 00:00:00:00:00:=
00 NOARP"
> > existing even you have configured 2^24 different addresses on the loopb=
ack device.
>
> Eric, I think James is right, in __ipv4_neigh_lookup_noref():
>
>         if (dev->flags & (IFF_LOOPBACK | IFF_POINTOPOINT))
>                 key =3D INADDR_ANY;
>
>         return ___neigh_lookup_noref(&arp_tbl, neigh_key_eq32, arp_hashfn=
, &key, dev);
>
> So there should be at most one neigh entry over the loopback device.
> The patch looks safe to me, am I missing something?

This seems fine, thanks.

It is unfortunate ip command does not seem to display these
neighbours, for some reason.

(I am about to send a series of three patches to remove RTNL from "ip
neighbour show")

Reviewed-by: Eric Dumazet <edumazet@google.com>

