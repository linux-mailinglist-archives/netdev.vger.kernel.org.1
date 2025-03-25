Return-Path: <netdev+bounces-177326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A516EA6F45D
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 12:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3B137A4B7D
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 11:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105B9255E4E;
	Tue, 25 Mar 2025 11:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xxq7TSQO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6C2254849
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 11:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902775; cv=none; b=TuT+b2dHUdmkLt3tgzqt7qumEL0qfLe2ai7QZFov06UlM4+YqtCAyu0cVPiH8+HPt+0mRJPogVoypNpzS4Nxj4Sx0f+xw+/QdhyTsEHsn3kCRNikqbkExYB0Ylnx9W4aWTRwVyPAFsoBAeUpZLdHhiZjRRa8KnhmbkhInt3B4XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902775; c=relaxed/simple;
	bh=brDfXlaCslweCeeV8y8iTlPuY025iks0kXb6GBVuraE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sch8mGtIC5UMXYVv0VW8kVgfI3CGfFoLykS1zOlTiQ8xvSn4Y90NdG7jP1VCSNvpbGJdVWjg9dIBnPliAjkKZP3d3hAmvVizIQlyqf5zPWWrpGYAp10CiT8CS6rB/0bWV4XEkerlqoHpd2XvSbpaP6AJQU4LNXM89ZaBx1yL8gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xxq7TSQO; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4768f90bf36so53090801cf.0
        for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 04:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742902772; x=1743507572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNOgKVtPhy1rvvDEUKptUWfjFz71o0u/FSrG0eSeU9o=;
        b=Xxq7TSQOTcGQEQcihx4olVdwr0fbAKjioV9Tv3Oj5kl/0b/BBDMn5VKsRSnMRaiaml
         LNWP4GO6W51BB3ZxcRBT/WUWR50bPckDvrQeIBQ2giQRdhWacL/8+ozYSp0/E3Abft9h
         pfA/nOunQeqrt6pqSOZ9YcLsZpxlJ7HAKa4xoFdEPv62s5OE9FGPC+k3Ccm69Q/J9hNN
         qzBkl4CC+ckRH9p5Ksnh+yjrn7sfqGSubz69tdB0hpCt1BNRj6Y3oMwyjHNcsbujJuvi
         s8cnzNCPFSdTqYC0ifyEv3XuOy/sFzsIuNnqlhIckkQdf4tFIOeXUx7dWj+KE4LHYZlj
         QjXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742902772; x=1743507572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CNOgKVtPhy1rvvDEUKptUWfjFz71o0u/FSrG0eSeU9o=;
        b=q+6FgXr2GEJfr+dZb+3FPBeiVN6z5bWYcvNkbSYUg/WPwprq5Vf2xMWdQqq85jCnwY
         vtUVARR+uYHWXDzFYnpnxSWMz3igf8LBRYIeXurMdfmVnqzkm2CuGyS8CQCnIiiQ4oDE
         1zwSz9pBmPp9S6YKE1XE0r3y4c9pgctk7TPIUc1njlU35kdSlT7lTbB6Da1oKDfbJr7D
         TYpI1E3OByf8R53oWPtPZcOoR20ka9Jty/FpUbiWG4/q2JM54u99vUf31xZWZ7AYQUli
         GRZtDk7I5hOmjP0oZPgNQqlsQYiLeV5fTuNeV1Jjf2kkjHGPmJN9JXEapbN1NjrAW3m6
         eoKg==
X-Forwarded-Encrypted: i=1; AJvYcCWz2/PCMD78+3t8UWo9CpJ4I6T4cIiroJNUvGBDo0q1Cvog/zbQXdoj3vRjm/wUB4FfuYt8Znw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHVRBXZgMpgT2bOZOCJC30k06GRiqZTBeuPTeO8u/276Rw/V0N
	2OgWufyFNZiMWPmbAj5MVTRSz3GA1dRKKXIR+xzxAs01NuRg2WVfX86OTKE2FTfPOBFTJ4Mj4A9
	TiQmdi9+EM8c2a8NUuj7ctjnv0ukJSCQHwTh2
X-Gm-Gg: ASbGncvGrRXhuWc+u6Cz7+E/gFRzyO1TA+yFMYXUmgvxF3sT/c2pPeP1ZZMztSCLHOj
	ZtqXzz/8n+LkBaFD0a2+pARQmeLKa8zuHE6Y/dLj/SXDxYMIN6tT3/DpiymMy3gOghLQfCJ2UU8
	3zq91NOBUdeIccseM4WcUIK35TXA==
X-Google-Smtp-Source: AGHT+IGWD0P23h092NMAp2Q5Cn8ExAsqXrwLntFsJ4egbH8/IY9lki5XILr8YsXkBnIhKG082J4fifjL5LMAjOF7Mlo=
X-Received: by 2002:a05:622a:1f89:b0:476:7bd1:68dd with SMTP id
 d75a77b69052e-4771de7deadmr298739181cf.50.1742902772054; Tue, 25 Mar 2025
 04:39:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321043504.9729-1-danny@orbstack.dev>
In-Reply-To: <20250321043504.9729-1-danny@orbstack.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Mar 2025 12:39:21 +0100
X-Gm-Features: AQ5f1Joxn6K0trFlHayA6Pt5LH-L8gzN0iEN8TYMMPBNdEeZ2VmlIsC45nn-x60
Message-ID: <CANn89iLU6M3rvyzNuGtL2LsdYh97Nvy7TpXdGD30qq1yW1tQcA@mail.gmail.com>
Subject: Re: [PATCH v3] net: fully namespace net.core.{r,w}mem_{default,max} sysctls
To: Danny Lin <danny@orbstack.dev>
Cc: Matteo Croce <teknoraver@meta.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 5:35=E2=80=AFAM Danny Lin <danny@orbstack.dev> wrot=
e:
>
> This builds on commit 19249c0724f2 ("net: make net.core.{r,w}mem_{default=
,max} namespaced")
> by adding support for writing the sysctls from within net namespaces,
> rather than only reading the values that were set in init_net. These are
> relatively commonly-used sysctls, so programs may try to set them without
> knowing that they're in a container. It can be surprising for such attemp=
ts
> to fail with EACCES.
>
> Unlike other net sysctls that were converted to namespaced ones, many
> systems have a sysctl.conf (or other configs) that globally write to
> net.core.rmem_default on boot and expect the value to propagate to
> containers, and programs running in containers may depend on the increase=
d
> buffer sizes in order to work properly. This means that namespacing the
> sysctls and using the kernel default values in each new netns would break
> existing workloads.
>
> As a compromise, inherit the initial net.core.*mem_* values from the
> current process' netns when creating a new netns. This is not standard
> behavior for most netns sysctls, but it avoids breaking existing workload=
s.
>
> Signed-off-by: Danny Lin <danny@orbstack.dev>

Patch looks good, but see below:

> diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> index c7769ee0d9c5..aedc249bf0e2 100644
> --- a/net/core/sysctl_net_core.c
> +++ b/net/core/sysctl_net_core.c
> @@ -676,21 +676,9 @@ static struct ctl_table netns_core_table[] =3D {
>                 .extra2         =3D SYSCTL_ONE,
>                 .proc_handler   =3D proc_dou8vec_minmax,
>         },
> -       {
> -               .procname       =3D "tstamp_allow_data",
> -               .data           =3D &init_net.core.sysctl_tstamp_allow_da=
ta,
> -               .maxlen         =3D sizeof(u8),
> -               .mode           =3D 0644,
> -               .proc_handler   =3D proc_dou8vec_minmax,
> -               .extra1         =3D SYSCTL_ZERO,
> -               .extra2         =3D SYSCTL_ONE
> -       },
> -       /* sysctl_core_net_init() will set the values after this
> -        * to readonly in network namespaces
> -        */

I think you have removed this sysctl :/

