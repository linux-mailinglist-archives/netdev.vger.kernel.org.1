Return-Path: <netdev+bounces-102723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7802904607
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 23:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 565191F24D9D
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 21:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179735F874;
	Tue, 11 Jun 2024 21:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IZZ4ptLW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6642C8488
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 21:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718139682; cv=none; b=Hknxd2kapjhWL5LYSJuEY7bhiBt4j9eD6eRvfWSftW2vimZfH92H/1XlAftHZ4jOd4H8/Sa8mPy2n+4NhwjWSdGgp2z/5ET+74Nld2FFgFTTxOi0T0TDXlLruWnyQ/VEMVBvEhpK1kKLqmg/jN/SUhZ0f8KBJZjzaxkqSLbuA6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718139682; c=relaxed/simple;
	bh=6PW1nf/eWeFY2tKmIOQ1VuWT7fqIpneyYVorJAwQeL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n9YCbOx0u/mLEi82xYKO4z5Q5BemPI6Lr0r/filCKyAMzaV23zN3JGSd5A534X8qhs8se6tFcbsllhY4btkSdErY9Pf8zpdfwbFQrlwX8O7LNNs3VWXYj9sLHupMezhsulggc5c2bf/BUT6tIq5oTgCE/tVXU4hDWebvoVmqf1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IZZ4ptLW; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-62a08099115so63183007b3.0
        for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 14:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718139679; x=1718744479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIc8quk+z80Oj5qJUtipwWH7RvxlN0ArT34YBzXHKug=;
        b=IZZ4ptLW+OqUb8MStYpvMaLrYfUMJ8hPiTIpZdoJtwMGWhMhaJ0scu3lnkjMZFvOQy
         MixwuHT9pmIAMdYYpDEllQGdq6nUqIHwolxRLthcqHFAwvQsVqURKmvkaeZP+q5N420m
         uTNx5uHUeckPza9N9f8KXTk28zl70ePp/ozv+eD2NK5Yv5qWZJjPT8S2uFDUj4gV4+hI
         +WNCI7ewzXymLXBNuLEB+N7CBjKHM47NlfLS5m3rzNZqzxaAf1m1Cuf5tYtiUNXMvJHs
         HPPKrAqMGy2PkjwPosLsNGxdFj76XTJx7GpZubXRLStKWx5Eghj8ftmTlntBwlz4ZUaC
         rC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718139679; x=1718744479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIc8quk+z80Oj5qJUtipwWH7RvxlN0ArT34YBzXHKug=;
        b=TzEuUBJmsmRvYYeOMFc7o6valJzT+tnzdLJTKXc5b/vS8c3b/TaaaG96tv4GkWgfmV
         dnPF1bQDOCGymVfUg9nBBIsftxStKemn4ZVTcqcyTSVwCZ6jGMq4j6Tk/OCyZCTPtICz
         x4VjQtChuBrIjqeadfpFxvViFxQq4FHMaRFZP/jNkiLu0NSXiQ4JaZolqyUtVRHf3okA
         3Osksq5rYgqDLS8G3J6BYedUCWPOEmu5yPxKTvDQOvCw/P41wIUPD9WwSgnbc1EUUeX6
         U9tZsHtZGi/OMwTDYGSe1iaF3YADH2kezzht+30eLbub+NnLAmlRsVGU66yYOYxod/iZ
         WY+g==
X-Gm-Message-State: AOJu0YwWG35qFEOpNWqKeceSlQFu/zLdhA09ugElagcTYJMZnWtyTQA2
	Q9hdebxCi3b2jeMvuN73c2DFWX4cQoEZCtAjX2H+7XF8ThMp2owF5MBo/5KENj9X+pxh5EymqjW
	WYDTWSnfSWsMcFAlqOktFX8w9Kut9XrVQrixFGqxdobkQT1NX7w==
X-Google-Smtp-Source: AGHT+IEWcUj9ep9xaBN0Bg4UlWx61XZpNTcHBtMw5fUITZAHNLDrUirNuGDY44SYa9fueZ78AZH0WB9O4j/xjXEXaGA=
X-Received: by 2002:a81:91c5:0:b0:620:26f5:c97c with SMTP id
 00721157ae682-62cd5652979mr119836597b3.35.1718139679016; Tue, 11 Jun 2024
 14:01:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416152913.1527166-3-omosnace@redhat.com> <085faf37b4728d7c11b05f204b0d9ad6@paul-moore.com>
 <CAFqZXNvm6T9pdWmExgmuODaNupMu3zSfYyb0gebn5AwmJ+86oQ@mail.gmail.com>
 <CAHC9VhTxhcSDfYCK95UsuZixMSRNFtTGkDvBWjpagHw6328PMQ@mail.gmail.com>
 <CAFqZXNurJZ-q64gxh54YhoO_GZeFzxXE0Yta_X-DqF_CcRSvRA@mail.gmail.com>
 <CAHC9VhRjDn3yihw8fpmweWynE9nmcqaCCspM_SpM7ujUnqoGDw@mail.gmail.com> <CAFqZXNsy86uN0J41HOhjH_Rq-WRU2DVzhbJOx3xtxtB5PbwFFA@mail.gmail.com>
In-Reply-To: <CAFqZXNsy86uN0J41HOhjH_Rq-WRU2DVzhbJOx3xtxtB5PbwFFA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 11 Jun 2024 17:01:08 -0400
Message-ID: <CAHC9VhQzGx2bYpGh-7zMsVT4hh45zs7QFuU9GAOdnE7bJQOSJg@mail.gmail.com>
Subject: Re: [PATCH 2/2] cipso: make cipso_v4_skbuff_delattr() fully remove
 the CIPSO options
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 11:47=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
> On Fri, May 17, 2024 at 9:49=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On Tue, May 14, 2024 at 7:29=E2=80=AFAM Ondrej Mosnacek <omosnace@redha=
t.com> wrote:
> > > I tried to test what you describe - hopefully I got close enough:
> > >
> > > My test setup has 3 VMs (running Fedora 39 from the stock qcow2 image=
)
> > > A, B, and R, connected via separate links as A <--> R <--> B, where R
> > > acts as a router between A and B (net.ipv4.ip_forward is set to 1 on
> > > R, and the appropriate routes are set on A, B, R).
> > >
> > > The A <--> R link has subnet 10.123.123.0/24, A having address
> > > 10.123.123.2 and R having 10.123.123.1.
> > > The B <--> R link has subnet 10.123.124.0/24, B having address
> > > 10.123.124.2 and R having 10.123.124.1.
> > >
> > > The links are implemented as GRE tunnels over the main network that i=
s
> > > shared between the VMs.
> > >
> > > Netlabel configuration on A:
> > > netlabelctl cipsov4 add pass doi:16 tags:5
> > > netlabelctl map del default
> > > netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
> > > netlabelctl map add default address:::/0 protocol:unlbl
> > > netlabelctl map add default address:10.123.123.0/24 protocol:cipsov4,=
16
> > > netlabelctl map add default address:10.123.124.0/24 protocol:cipsov4,=
16
> > >
> > > Netlabel configuration on R:
> > > netlabelctl cipsov4 add pass doi:16 tags:5
> > > netlabelctl map del default
> > > netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
> > > netlabelctl map add default address:::/0 protocol:unlbl
> > > netlabelctl map add default address:10.123.123.0/24 protocol:cipsov4,=
16
> > >
> > > B has no netlabel configured.
> > >
> > > (I.e. A tries to send CIPSO-labeled packets to B, but R treats the
> > > 10.123.124.0/24 network as unlabeled, so should strip/add the CIPSO
> > > label when forwarding between A and B.)
> > >
> > > A basic TCP connection worked just fine in both directions with and
> > > without these patches applied (I installed the patched kernel on all
> > > machines, though it should only matter on machine R). I ignored the
> > > actual labels/CIPSO content - i.e. I didn't change the default SELinu=
x
> > > policy and put SELinux into permissive mode on machines A and R.
> > >
> > > Capturing the packets on R showed the following IP option content
> > > without the patches:
> > > A -> R: CIPSO
> > > R -> B: NOPs
> > > B -> R: (empty)
> > > R -> A: CIPSO
> > >
> > > With the patches this changed to:
> > > A -> R: CIPSO
> > > R -> B: (empty)
> > > B -> R: (empty)
> > > R -> A: CIPSO
> > >
> > > Is this convincing enough or do you have different scenarios in mind?
> >
> > Thanks for verifying your patch, the methodology looks good to me, but
> > as I mentioned in my previous email I would feel much better if you
> > verified this with a different client OS/stack.  Do you have access to
> > Windows/MacOS/BSD/non-Linux system you could use in place of B in your
> > test above?
>
> I don't think I can easily plug that into the framework I used for the
> testing (there doesn't seem to be a convenient way to install a
> FreeBSD VM without manual interaction and the rest is proprietary).

Surely you can perform a manual unit test with some VMs on your local
machine if whatever test automation you are using doesn't support
this.

> I still don't quite understand what exactly you expect to break under
> that scenario and why - could you elaborate on that? If anything, I'd
> expect the IP header growing along the path (which already happens
> pretty much by design in the opposite direction) to be more likely to
> cause an issue.

I'm concerned about potential oddities caused by the changes in IP
header sizes while the packet is in flight.  Every OS's network stack
is a bit different and I don't think it is too much to ask to test at
least one non-Linux network stack as a client.

--=20
paul-moore.com

