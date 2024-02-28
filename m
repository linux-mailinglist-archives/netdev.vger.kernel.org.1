Return-Path: <netdev+bounces-75616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B4286AB29
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 10:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF39E286167
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 09:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F328A33998;
	Wed, 28 Feb 2024 09:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dAuAuecE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7B82EAE6
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 09:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709112525; cv=none; b=FCL981oUiKOJc6cWnr3QQFcJPTeY/jd6Wjtp468H5ScCm+VURom3U6B9ifPPTQppbPBCVrpNCSZ8YyiVFAMIvebtB26IXHF/nJ1lhmpGp59bzslk9zUVnpCY8Q+XOcFA33couThS//sOuB1Mru2LivFZGTLOkIHZHuDlcBn1N2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709112525; c=relaxed/simple;
	bh=vM25Sn00GES493f3CVIVorpnKEqNDbgsBn1rAzLnBRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gT5dC/8h0a9qnJVswRhweQNjuoUeqZX3jKmwO4mmQwPmV0JU5PiqG9Xev7JbMA1maY0fe/EajfT6b+JVzo0/h3Jo+ptwoJwJSLVv4cRI+I9v7fCOKzqpdCgq9sDMIfXXTzjLrpqBAA7gg3olM4HVkdYL+YSmQSICLakSsJI3FAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dAuAuecE; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5654ef0c61fso10476a12.0
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 01:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709112522; x=1709717322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmGSAPwKHno/gXEojIx4FGx/OPgjQkEiVnRDIOYk90Q=;
        b=dAuAuecEXOM5DgvXl1DAhbyvyss2LRt/6l0dcBKqiA6mA2+07U1yA4URURdFXiG6N0
         rcZmT62CzkoONBRc2E+KoyaFM87eYK5qYyEZtHWALx1onyCVNgQYydvN8HYL/L+kZvdb
         327LtN1tYsTqimb4lgdkwY7y8Csqm9+/wnTWH1l/JQ5T07sC0CiIIHs2DyqCD3C92YBi
         Hq0Xa8MLd3nmGbA7838SfkLzboXqNjJ4DZI46upa2vD/cphHStG4gIfHISEK/He/Kn5N
         NWurqw9WWfn4ZGrnxaFZeucupsu/DgYZaTEClKqTXFiAOUf7oXPMwRNnYRI2PcB/PIy5
         Iqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709112522; x=1709717322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PmGSAPwKHno/gXEojIx4FGx/OPgjQkEiVnRDIOYk90Q=;
        b=le9khlF9OEGsdrFqLg+mD3u/WqUsJ5dckmLx9sr4cZmIR14+JO3eBdURo2QClLq8KM
         4uNb8Ypwxt8TlMFzJI8NYy3aYeoOoFRY8qSm6M771FKmPAivMgPssh32O4wvCPb7jeUr
         bTNFbfZECC+mB+Nqm3+JDPF0aJX0uZPAoMLD7fy8iwdHg4YmG508LJZq2VmPppopOY3X
         7CvE2et5MZrLfz53DaUHegnuaY+kb0gMaLh8RhHU5KXvwWBo1+hBbaqhwOu8/msuVGsb
         hJ2n5bZ+jGnZa9d2zdFpilkfVThxTsteOLdcr1QUZPBnPMcI7OVEJZW7fMw/3cWKOVvp
         eTMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsr9yTfKyWZS8TJAlzyaNIE6ixjfJsRQ0McBnKXNkvzlOK4WnFStz6d9lOQC61/OP4y/OeMvAEPejL3rmOV4dudaIofnT3
X-Gm-Message-State: AOJu0YwTkcPeajo6hmxfPlT+jPdPEgzDkeeNmrRnZX7kaKdC82eyTeai
	Kb9f+DTXpMQKs+lCxGG72vf64J5cipct9QOdcs6SFkTBlDYrK6/oMkQPHEai88G5/1mzDL3fBtY
	rEmjsnN1f9SmJsx0a7g1ks4yC5wcKB49qdDYEhVZzEdguU5Hma6k2
X-Google-Smtp-Source: AGHT+IEwenSzycenMhnI1BztlSoSzPOKV/8W7t/ramLMrvicv8hj+V7CvaNDzt75W/70sLfZHelGZep+6MEyKsGFq+A=
X-Received: by 2002:a50:9343:0:b0:565:4f70:6ed with SMTP id
 n3-20020a509343000000b005654f7006edmr40551eda.6.1709112522375; Wed, 28 Feb
 2024 01:28:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227150200.2814664-1-edumazet@google.com> <20240227150200.2814664-4-edumazet@google.com>
 <20240227185157.37355343@kernel.org> <CANn89iLwcd=Gp7X7DKsw+kG2FHA1PzwG3Up8Tb2wjA=Bz94Oxg@mail.gmail.com>
In-Reply-To: <CANn89iLwcd=Gp7X7DKsw+kG2FHA1PzwG3Up8Tb2wjA=Bz94Oxg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 28 Feb 2024 10:28:28 +0100
Message-ID: <CANn89iLefNuOXBdf2Cg8SbwAXCm=X+qZ-Cqkx8CQ=vESv-LYSg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 03/15] ipv6: addrconf_disable_ipv6() optimizations
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Jiri Pirko <jiri@nvidia.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 9:51=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Feb 28, 2024 at 3:52=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Tue, 27 Feb 2024 15:01:48 +0000 Eric Dumazet wrote:
> > > +     if (p =3D=3D &net->ipv6.devconf_dflt->disable_ipv6) {
> > > +             WRITE_ONCE(*p, newf);
> > > +             return 0;
> > > +     }
> > > +
> > >       if (!rtnl_trylock())
> > >               return restart_syscall();
> > >
> > > -     net =3D (struct net *)table->extra2;
> > >       old =3D *p;
> > >       WRITE_ONCE(*p, newf);
> > >
> > > -     if (p =3D=3D &net->ipv6.devconf_dflt->disable_ipv6) {
> > > -             rtnl_unlock();
> > > -             return 0;
> > > -     }
> > > -
> > > -     if (p =3D=3D &net->ipv6.devconf_all->disable_ipv6) {
> > > -             WRITE_ONCE(net->ipv6.devconf_dflt->disable_ipv6, newf);
> >
> > Why is this line going away? We pulled up the handling of devconf_all
> > not devconf_dflt
> >
>
> Good catch, I simply misread the line.

I note that addrconf_disable_policy() does not have a similar write.

When writing on net->ipv6.devconf_all->disable_policy, we loop over all ide=
v
to call addrconf_disable_policy_idev(),
but we do _not_ change net->ipv6.devconf_dflt->disable_policy

This seems quite strange we change net->ipv6.devconf_dflt->disable_ipv6 whe=
n
user only wanted to change net->ipv6.devconf_all->disable_policy

Oh well.

