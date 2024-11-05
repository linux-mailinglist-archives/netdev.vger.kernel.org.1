Return-Path: <netdev+bounces-141969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1899BCCBE
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 13:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31F6C2857DA
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 12:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F4D1D47DC;
	Tue,  5 Nov 2024 12:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cwWWqUf9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37C71D5AA5
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 12:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730809812; cv=none; b=jLQ+3VST7QvmIxb/59ueEy2Vm+rnIJ1dQMMyYUifs2M7Zql19xqRJTitwNwaK1I8NPn8kc+4aHKAtf79sG0JKWMs9MqXGhOFCE8H61C+pe3/N+QC8UEK1lJJ3FSSbaMAZS0P1IHrI33SyGqZtoZcFmtobNVd6GaT3vo3JZjdckI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730809812; c=relaxed/simple;
	bh=LhDwN/xF71ghxE5wzrbVvnOsfPv37mNis1TaAQH3ftU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OOw32b8DhFoZpd61XW+8q9Ce+5A6ti6CEEDreJGIfXC2i/f4/WfgjDmkvsUQimmJgV2Fx46wlfQHEBwVSDfqwoYmvMnqX8C4Z0TTK/gXbXK2zXRHK567AfkAfLqwFh+TRx5cokeBjOEnVnysQFr5qKF2ULrtyX0FdDThzBJvSUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cwWWqUf9; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb59652cb9so48393051fa.3
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 04:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730809809; x=1731414609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DjVwsSz+QZmCGpgNC26UXoavyNmG2TWtUBkyB0m0OA=;
        b=cwWWqUf9pKsptn/DMtmam7402+mDWbLzUnx9nA3E+rGE2HquiyOgl2h237iQtzTJqt
         DiE8MTW2N9LB4n5B9tNlmamYIqqbizwJK2vhAKWEYKVzlBjkNuJ/XmtTGD15D5VIScxO
         FFXh90v+Mq+PWKQD0jPFcsZk0C+iMBhkxLDYaW31OUFQyn3wbYfnmehi/451LRdxqONJ
         C6KeXwEqJA6wHIVTKjP5VslQZ8jrgf1FyZz/98oibSH3O3Y05TbxQWz892KtquiqwE8P
         9nADFx9bLCmLBFweIf5ktN34FGEkfB0UEZYUPAGqwBDXMVc7qjhJB6k0yeUbm/1u8C/8
         XlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730809809; x=1731414609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0DjVwsSz+QZmCGpgNC26UXoavyNmG2TWtUBkyB0m0OA=;
        b=BD2ap81MH95UMsnMjdLCdow4ES8StlwkJEWPqEF7C7vjmJgLon2RRi/31dyU3jg+M3
         HwZFTx1wXBbN2OTyFqS4ANKucz3LNI0NzAw3cD8N16C2y+TJKnnoc6ZbDl4oUVck/ZNF
         9yy67POLrnUfJ3lSMUgfH9vYzLH7RfdaDNC/FODoMf3CXglfQ4ZnCbsgx12NVmvz0O7h
         Vc0xCSCGkQ11tEVYYjcfb+cea6lBJtFzCoP7+DL9qwv/iNpnLnENd6/SeUQljQ4RdtKW
         GaApZ6m1Qfsyo2Qgaq9xDXBN9SPQZEqmBaYg00ffz1dYRduz+oXKqMpCz981U70ywx6u
         ct1w==
X-Gm-Message-State: AOJu0YyFNoJoXJl1ihjEfostNwtjWYYzaM00J4mMxQFr8kRmISKEqiwj
	g1twVdV/2cZMEqSebbYyLIDwPeNaQcM1NqNAPlbjsDQnbQi+hp5giRitKiBdtf2wDdrLL94nNwa
	Ajv1zNdfhTuir3NWc0afTypQhIcJ0ZmyByzLNBL04WveS9UDztw==
X-Google-Smtp-Source: AGHT+IFHeJed7Q71TVWo/vWUGmfcRZK9cRfzFyK9Yw0d2CLVjmxW2EPvtuL926UeITrx2YJl4cMnW18Nb8t/UFk+tkg=
X-Received: by 2002:a2e:a803:0:b0:2fb:b59:816a with SMTP id
 38308e7fff4ca-2fef09d5f58mr35889181fa.45.1730809808707; Tue, 05 Nov 2024
 04:30:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730364250.git.pabeni@redhat.com> <85ee0558e07d23de03fca1d2444a8d3edb75e912.1730364250.git.pabeni@redhat.com>
 <453af1dc-b778-40c8-8ffc-5dc97d7572d0@redhat.com>
In-Reply-To: <453af1dc-b778-40c8-8ffc-5dc97d7572d0@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 5 Nov 2024 13:29:56 +0100
Message-ID: <CANn89iJmGepXYMheagmDyfS_0xTESaQc3J8rmcXGqskiaW5tdA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] ipv6: release nexthop on device removal
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 1:19=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 10/31/24 09:53, Paolo Abeni wrote:
> > diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> > index d7ce5cf2017a..ef55f330dcda 100644
> > --- a/net/ipv6/route.c
> > +++ b/net/ipv6/route.c
> > @@ -187,6 +187,7 @@ static void rt6_uncached_list_flush_dev(struct net_=
device *dev)
> >                                                  GFP_ATOMIC);
> >                               handled =3D true;
> >                       }
> > +
>
> Please do not include unrelated whitespace chang... wait! I'm talking to
> myself... in any case a v2 is needed.

Oh, I missed this patch, thanks a lot for sorting it out.

