Return-Path: <netdev+bounces-89257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2303F8A9DDC
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 17:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF4BB281752
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 15:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E0016ABC5;
	Thu, 18 Apr 2024 15:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="AM4TGwSG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677F81649DE
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713452527; cv=none; b=MdJLOZ3ppBN1J4oNGagaeyepxtXEn8T9LmxcuMYuVCdvVRxthi/dqH5pwh24c3erOSS9QBiR4C5Ua38icO+IGBBh51VVjGzFSLD/CHWtHcwg5ybO8Jt1Ovx13KWTkaFFQKyc5PJZ3BdFKr8LH4wVW5/DB6rg8PSECRygF/1J4mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713452527; c=relaxed/simple;
	bh=DQg9N9NsmAiomB3YevtTSMmyEr0U2U0LM9Xrfnum6ck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aF/OMXSGOxyasMO41K6i+n/CTeZhqA+GZCK6UcZYqyCHoYt90ZR6eSJjlHXWK6aYvzfC0nw4oBvV/cvjoBeCAF8jr8iJNRMw0hNL6FPtrZOFr0jqImqDxj3qRyTz1UEmfq04blaiIVNcj8emIXiBrOM7sr/ZVzFY3S0P1KutroU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=AM4TGwSG; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CECE63F118
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 15:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713452521;
	bh=Uwv3V9NnGMB5Wj85PeZTAIoBr809/UIjglv9mvQKrBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=AM4TGwSGA2KJpiZtkjoweIXNpMhxetHTGIYNuXvQ+aJzpaI/k75iXn+D9z0fUuVaK
	 GbJFPuZqSowhUIrqfo4eNZx1RBqRFZ1Sh8EhfumNNbKA5sOzbUBW3nIUZ6Dk4QiWrs
	 jxJ7ku7/2gTgr/UgLBLvvaW2MBXPOENCXSAp2ZwIEQULrd8pSMk9s3PhwQhb3H/A1j
	 pcUq0jiiCpARQ/wJzqHqe0NF95JXWJJgRAIPA3yMY9xgux8mkXsrvsjuDRIHVQqNiA
	 haXOIf38WkHH2aF+AJY1yrpDDrFqhn4W0xayhpE6SEHhBrCMxNst25T7jNGAdbtgn3
	 /vbR9xfpExpgA==
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-69649f1894dso19084196d6.0
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 08:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713452521; x=1714057321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uwv3V9NnGMB5Wj85PeZTAIoBr809/UIjglv9mvQKrBw=;
        b=bKpoHa7YwV0jWehX73sHMg5xqbDb5cZ1vlAjWsPHoztDn78qIXQY8PUugu3i99DQhV
         qlaIKnYhEW5/sa9ZK2KAAxj6e+OL9xh1NkTKn/jJgwK7c9LIMKrF6ceApNVhDEjZhek7
         uxpSMQMz8u8vmR/OysD+o3X7gjGRR/STVSZyp4KA0C2tR2DulIehe63G1alurOsW3tHx
         c4DYBN+vKdK+tTEanSGgzuFPEPSOXXohE8+9iuK+NAKb+X2o9IadGKk1AZPPHVrutVOO
         37+IGWTIqv2HBBFV1pEwRd/zsIUzA9TaJvR4L8yixMKbQ61m2QY0LV1JdeWqY6bDmtUX
         seig==
X-Forwarded-Encrypted: i=1; AJvYcCW48GxBqDdA6KLots/O8vkns1XNpMBwcZCWUqbQ3N3lEHYVNuFVoyjTndlqmoh0Hfvgj1j+HKPI6GpMHkSAY/ZkBNyOB/EB
X-Gm-Message-State: AOJu0YyVrpZyAA3oHu0/L5TgSYtkVMI3Iw2VNCxbKmUy2Jq+7BEnPDeM
	9RrFORHO6KEiq1LK1b345UeXhACew01GjfAhdpGg34bzMs8A9kgKKXM+PK/J7wEmY6P9IpjzkQy
	9apvrdVXqKXWz+YeHDqz1bQvBLJ3SwIdL6JHXBi/RhzwRsZtQ/NfFOXFkE1p0/Df5XXwU8/nyhU
	5iAMLTP3JXlShEUAwuXOcRJPgHLPpfkyvXNs43uUpLNTF7
X-Received: by 2002:ad4:414f:0:b0:69b:5961:1ff4 with SMTP id z15-20020ad4414f000000b0069b59611ff4mr2636824qvp.63.1713452520910;
        Thu, 18 Apr 2024 08:02:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwnD/dVrXbHRIjywyojR4601i9J6JDecCBPGXdOo9n2JxohMovJ/J3JuT2jIjVRTbNhUbSWJ19JUCG2v0M57o=
X-Received: by 2002:ad4:414f:0:b0:69b:5961:1ff4 with SMTP id
 z15-20020ad4414f000000b0069b59611ff4mr2636758qvp.63.1713452520029; Thu, 18
 Apr 2024 08:02:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418110153.102781-1-aleksandr.mikhalitsyn@canonical.com> <eb0b4b89-9a1f-0e1b-9744-6eb3396048bd@ssi.bg>
In-Reply-To: <eb0b4b89-9a1f-0e1b-9744-6eb3396048bd@ssi.bg>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Thu, 18 Apr 2024 17:01:49 +0200
Message-ID: <CAEivzxd_Lz3o8Qmqq6wyfK_UduVL1Qm9jQ9UJaoE_O7wWPrg-Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] ipvs: add READ_ONCE barrier for ipvs->sysctl_amemthresh
To: Julian Anastasov <ja@ssi.bg>
Cc: horms@verge.net.au, netdev@vger.kernel.org, lvs-devel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 3:23=E2=80=AFPM Julian Anastasov <ja@ssi.bg> wrote:
>
>
>         Hello,

Dear Julian,

>
> On Thu, 18 Apr 2024, Alexander Mikhalitsyn wrote:
>
> > Cc: Julian Anastasov <ja@ssi.bg>
> > Cc: Simon Horman <horms@verge.net.au>
> > Cc: Pablo Neira Ayuso <pablo@netfilter.org>
> > Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
> > Cc: Florian Westphal <fw@strlen.de>
> > Suggested-by: Julian Anastasov <ja@ssi.bg>
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> > ---
> >  net/netfilter/ipvs/ip_vs_ctl.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_=
ctl.c
> > index 143a341bbc0a..daa62b8b2dd1 100644
> > --- a/net/netfilter/ipvs/ip_vs_ctl.c
> > +++ b/net/netfilter/ipvs/ip_vs_ctl.c
>
> > @@ -105,7 +106,8 @@ static void update_defense_level(struct netns_ipvs =
*ipvs)
> >       /* si_swapinfo(&i); */
> >       /* availmem =3D availmem - (i.totalswap - i.freeswap); */
> >
> > -     nomem =3D (availmem < ipvs->sysctl_amemthresh);
> > +     amemthresh =3D max(READ_ONCE(ipvs->sysctl_amemthresh), 0);
> > +     nomem =3D (availmem < amemthresh);
> >
> >       local_bh_disable();
> >
> > @@ -146,8 +148,8 @@ static void update_defense_level(struct netns_ipvs =
*ipvs)
> >       case 1:
> >               if (nomem) {
> >                       ipvs->drop_rate =3D ipvs->drop_counter
> > -                             =3D ipvs->sysctl_amemthresh /
> > -                             (ipvs->sysctl_amemthresh-availmem);
> > +                             =3D amemthresh /
> > +                             (amemthresh-availmem);
>
>         Thanks, both patches look ok except that the old styling
> is showing warnings for this patch:
>
> scripts/checkpatch.pl --strict /tmp/file1.patch
>
>         It would be great if you silence them somehow in v3...

Yeah, I have fixed this in v3. Also, I had to split multiple
assignments into different
lines because of:
>CHECK: multiple assignments should be avoided

Now everything looks fine.

>
>         BTW, est_cpulist is masked with current->cpus_mask of the
> sysctl writer process, if that is of any help. That is why I skipped
> it but lets keep it read-only for now...

That's a good point! Probably I'm too conservative ;-)

>
> >                       ipvs->sysctl_drop_packet =3D 2;
> >               } else {
> >                       ipvs->drop_rate =3D 0;
> > @@ -156,8 +158,8 @@ static void update_defense_level(struct netns_ipvs =
*ipvs)
> >       case 2:
> >               if (nomem) {
> >                       ipvs->drop_rate =3D ipvs->drop_counter
> > -                             =3D ipvs->sysctl_amemthresh /
> > -                             (ipvs->sysctl_amemthresh-availmem);
> > +                             =3D amemthresh /
> > +                             (amemthresh-availmem);
> >               } else {
> >                       ipvs->drop_rate =3D 0;
> >                       ipvs->sysctl_drop_packet =3D 1;
>
> Regards

Kind regards,
Alex

>
> --
> Julian Anastasov <ja@ssi.bg>
>

