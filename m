Return-Path: <netdev+bounces-89970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2884E8AC5A4
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 09:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9172CB2114A
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 07:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DAC4CDEC;
	Mon, 22 Apr 2024 07:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="pCQ654iZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A548D482CA
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 07:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713771312; cv=none; b=NtBMc/DJwOdFs/8ENMOi6JGSVpVeP5/5/t4fmXByQBFh+S8IcUKEbjrMbgWy+/Wixv7M87utCUTQOCvluZy9TQHayB5YbXrWcHhi34qWtMdDxOzqqh4LSHQAvXS1+jFY0A95Eju6QN9aeWVWU+Rk0VaEX74O9BBRSgqt9t8AMnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713771312; c=relaxed/simple;
	bh=fBrj1dnoyR2LmahOk4WbX0ibThwyJ1nrtKoFW/2YZOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ITUkT279A6to654Qxon6K3OBxl5UFo0zrV6WtYU1G7ePtL+B/U9CbniYEmbL8dvrH5YFU5TwdUvFbiULTxzbbsW++3AVlLXDh5qN/XYSa1ZyMJIFuqXG60DmxtLcxBgdjTUgjzKkfBvG36pPyv4nWjlwQAbhsFg/K0Hfg8MSXUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=pCQ654iZ; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8CDC53FB77
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 07:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713771303;
	bh=46RCdpJ7vgBjG7tk56Uoq6fJtjN5FpgbYn8UqwNaImE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=pCQ654iZ5wIW11Ey8CSsUqFGyW5L44fhRxN4nEFlgrh4lrenXnBKrv6FopVn98w4i
	 THoSfBU3VE9znLNSeWnJQ785kplPiDieRs1irBSXvFXAfCuUD1JhLOvMY0UZs4y90k
	 0r1T8w5AjO1TeFdN/Gw3N/bXNhNoAnOMn5KYuqgHIc9nmqg/GpVBU0Lu9oofi4Ngcq
	 Yl8owgFA6YKHkCdM3TH8ORFHnE0wCQWgoTIynLph+UYje9JMUUEG7saoU4OSkaLi3S
	 dBS0ceR7bkBN3W3DIw9p+SyWkUoZTiK+szBV57Bfpghv6nocA9iODS710BDLPuMRbz
	 k9xuwBcJyI9QA==
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-4db22df35f7so2650839e0c.1
        for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 00:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713771302; x=1714376102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46RCdpJ7vgBjG7tk56Uoq6fJtjN5FpgbYn8UqwNaImE=;
        b=xDhz+pedPLm2lf4tPwZYY8ucxgHsiBFmVmL6et6yHTc6/Ey80yuHhOFV012cYZQVH1
         UX1+oEgMhWx85uAt1vaoQf23M7VCBXEeZhFfy2xzFJnpTOj5ER5XsSHXzLcuYvDobIRg
         F17y4yRmK61sAAFDnARTwcDEFuqTO5G7ojK3nqugZ/xJ+6+HXVHp6Z+MAbWjXXyucvYb
         4b+aBGNhYwIgKZHuGcxgMLp51HriREhVePyvR++VsO4Sc9/GTRqs3GdDoBJrvPPjstGy
         UCGsaGq/W5Mv/KtrK7b1o0IxcsZyvb/Nq0F3aFqOitbSCamsTTi2Af4PhsTKRcnyAO3a
         AvJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRCUdQdQmMl8FuXY1Rtpq7y3U5tUuxVcEvWUBBrRReRbW1YvXbS+UWxn9RyZWHY6jxT4uf/b7WLBWcF36e3BhY2kEbwi4k
X-Gm-Message-State: AOJu0YyadII5eWYV+RAKJIeTVkBphPrd5cZYzdBW8jDX30I0fmK4zMD4
	dvQ/LDcf9uqKGAplk1hHkzjwBrCsIXHLy7OPRRjyJLFdlm15OOpcn450Ia0JWri/46MlpCsMMRr
	TDI3Y0PZ2emGtO8y8YCzD/eYjr/Jclg9B8xQY3yv4CymiJ5hbr3MfRjw+K2DD0rSb0B/Ud8pSM0
	3oWFd+cZouPA5SPryu3PIuINXWmNFILT7ZYMm2Ma8wI0mY
X-Received: by 2002:a05:6122:2027:b0:4d4:11a6:a4ff with SMTP id l39-20020a056122202700b004d411a6a4ffmr11538023vkd.3.1713771302336;
        Mon, 22 Apr 2024 00:35:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFehc8zEqs1hmzU7+iKls2b71g++dU2LKDYThQ8eqyp3FH6CkvHWc1W5LvQ5+FS3DHVZn+FvE4vGYtHboiybk8=
X-Received: by 2002:a05:6122:2027:b0:4d4:11a6:a4ff with SMTP id
 l39-20020a056122202700b004d411a6a4ffmr11538011vkd.3.1713771302079; Mon, 22
 Apr 2024 00:35:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418145743.248109-1-aleksandr.mikhalitsyn@canonical.com> <ef5a38db-c80d-feb8-7c7d-c9b66085afba@ssi.bg>
In-Reply-To: <ef5a38db-c80d-feb8-7c7d-c9b66085afba@ssi.bg>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Mon, 22 Apr 2024 09:34:51 +0200
Message-ID: <CAEivzxejY7s_vNYbN4HJBT-RGrkYx7x1L4rfir-0EM+7EuPKew@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/2] ipvs: add READ_ONCE barrier for ipvs->sysctl_amemthresh
To: Julian Anastasov <ja@ssi.bg>
Cc: horms@verge.net.au, netdev@vger.kernel.org, lvs-devel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 21, 2024 at 1:06=E2=80=AFPM Julian Anastasov <ja@ssi.bg> wrote:
>
>
>         Hello,

Dear Julian,

Thanks a lot for the fast review and suggestions!

Kind regards,
Alex

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
>
>         Looks good to me, thanks!
>
> Acked-by: Julian Anastasov <ja@ssi.bg>
>
> > ---
> >  net/netfilter/ipvs/ip_vs_ctl.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_=
ctl.c
> > index 143a341bbc0a..32be24f0d4e4 100644
> > --- a/net/netfilter/ipvs/ip_vs_ctl.c
> > +++ b/net/netfilter/ipvs/ip_vs_ctl.c
> > @@ -94,6 +94,7 @@ static void update_defense_level(struct netns_ipvs *i=
pvs)
> >  {
> >       struct sysinfo i;
> >       int availmem;
> > +     int amemthresh;
> >       int nomem;
> >       int to_change =3D -1;
> >
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
> > @@ -145,9 +147,8 @@ static void update_defense_level(struct netns_ipvs =
*ipvs)
> >               break;
> >       case 1:
> >               if (nomem) {
> > -                     ipvs->drop_rate =3D ipvs->drop_counter
> > -                             =3D ipvs->sysctl_amemthresh /
> > -                             (ipvs->sysctl_amemthresh-availmem);
> > +                     ipvs->drop_counter =3D amemthresh / (amemthresh -=
 availmem);
> > +                     ipvs->drop_rate =3D ipvs->drop_counter;
> >                       ipvs->sysctl_drop_packet =3D 2;
> >               } else {
> >                       ipvs->drop_rate =3D 0;
> > @@ -155,9 +156,8 @@ static void update_defense_level(struct netns_ipvs =
*ipvs)
> >               break;
> >       case 2:
> >               if (nomem) {
> > -                     ipvs->drop_rate =3D ipvs->drop_counter
> > -                             =3D ipvs->sysctl_amemthresh /
> > -                             (ipvs->sysctl_amemthresh-availmem);
> > +                     ipvs->drop_counter =3D amemthresh / (amemthresh -=
 availmem);
> > +                     ipvs->drop_rate =3D ipvs->drop_counter;
> >               } else {
> >                       ipvs->drop_rate =3D 0;
> >                       ipvs->sysctl_drop_packet =3D 1;
> > --
> > 2.34.1
>
> Regards
>
> --
> Julian Anastasov <ja@ssi.bg>
>

