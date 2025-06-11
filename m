Return-Path: <netdev+bounces-196551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CADC3AD53E8
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 13:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E7D63AA1A6
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 11:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5363525BF0D;
	Wed, 11 Jun 2025 11:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bqRMK5x5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FCA25BF07
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 11:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749641339; cv=none; b=upkGSXctIYUB93rCxxGRO+yq4LtzwlgowDY8mVifEIUU6B746opxyR706bF4QJFOHfU1/vkubXIX/VNF8uai/QmRDxG41Ktvt9KqTv7JBsZRmuqwV4jfHKd4Epo9N1z/woJDYJcT1yGjt+M7oe5/VkW3fSq4HIa3T19lRODXAbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749641339; c=relaxed/simple;
	bh=+iNUH6xk43jcmXrRewwpOfXNqzB8sirT6mgDhM17CMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uoHU2qqnDM1FwULrcwh4Vi/opYXCSmhcikVwSuj2Ie0tw4R6puOmEpGMRBp/Ut4LpM0XA3nIjjtcNdUi8HtvXa3/KfG6omZ+h6mB3PL4N0fopxt0L1Uk0bsthB2FY/juxW5iwrtFPKOwXhT6BACE4mMofTB9WqgBgLD/PDMqKDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bqRMK5x5; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a5a196f057so140105541cf.3
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 04:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749641336; x=1750246136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oh04zvqs+YSpNUtfn7HOfxHy42uR0hcqa9/M7g8Y2c=;
        b=bqRMK5x5En614C6WpK0lj3+7vxEWVcHPV4YrM+OJbdsBxNlgKdJpxRvSTrmg4QjNH7
         6rL7G8qtXI93KFno3dAVV26nNWGdDzxCC7Ka57R7ft+jLZajG2/SjzELDWBUCJ0YcTs3
         BXsW1UKJR+PQ3gt346uY1RoBw/Azs5FrnRGDKqVniOiyXfq3d1PRZQQAT9baeU9wa7rw
         4cmMC0+ybyYMwv72z4Qn+1V5pLsisi1+sww298AB1DWBKBfyLX3Ae/7hquZSIm6ZK9iu
         V2Z7IQ8AC1J6OikB/3gg6bIvDZes0uJWavQe54zYmCjlaJmbnXmInICQ+wHUXO1jtmOX
         LH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749641336; x=1750246136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2oh04zvqs+YSpNUtfn7HOfxHy42uR0hcqa9/M7g8Y2c=;
        b=oZjGc4qQrB8sFJDZ6RrH0ggMRjWBzf44yLNfHRXunKP8x8Uw2UxcdvxlARqhGQPJNW
         jtKmPDD27uwbvUYNfxYEgB+gaZEv+CXBnPY3nD+7TikXASAMVduP4aJho689w/DuwxsY
         Dm8dA2tDTAceRvgLSFKo/5SqhikdlE9DaWNptc3Hr8Dgp1UyHQQL83M4/Ed5U3SeRh8r
         seb65ECkwNevem2biRhSI1mPFJup1mtUJzm+GBLLUF4l2zpJiVAJFJSel8Eq0yrk/gN8
         sI4JLDPmuEWC5ZAb3F/nBYsnC+8NrKoJhQqKUlJhYQmTsdMXT31A6YH0LdnmlDVRgK3m
         KuCg==
X-Forwarded-Encrypted: i=1; AJvYcCWOTCtrANfGZuNbC1DymSwCdT/7nC+0hdEAnnt1cryw5w5L/WstJSBpJniRHcS5zWIblbk/ER4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdPEKeidO8RNhbfvD7Dq0OUdzRIsl75odkAv4RcTi9rNcWsMQw
	Z47OB+urPqaFOv+EIuNhOL5dOl/Vzz2iaRVaDN8GRfxm0txd/gzToXA9vdI7l5TW94IiA7iDABY
	iYeJME1279cxFsqi49FYe+GyHFKIVxfUbD0iuJ6+0
X-Gm-Gg: ASbGncvh7BbzkfMQLHDO4YkXy2RAwc6uAL9l7em+tRh1frJaObJD1gk2MAoNmed1SNs
	SCKWU5yAYYMWfNjAdurxXjixqmsL0RaZkK0Nfb8s6SZJAs9NUSxHfcHAn24OgTSDTylG1sAPZW9
	e77Wgc9go5CLJka5VqtCDzEV+F8bqSipLTHeDpBu/bPsILiqxyMxuXfmcqkShzp9DCqkG+xBytf
	25qPQ==
X-Google-Smtp-Source: AGHT+IEDMWCOnvibZp/kL4/gsW/5pDpxCVdSGMg7O3Et0QKbIvK99zOhpIYPM9+9N1FjoDNw/aYS78l4sgXpYYz1eUc=
X-Received: by 2002:a05:622a:1b1f:b0:476:7199:4da1 with SMTP id
 d75a77b69052e-4a714c6be41mr42108551cf.46.1749641336168; Wed, 11 Jun 2025
 04:28:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aElUZyKy7x66X3SD@v4bel-B760M-AORUS-ELITE-AX> <CANn89iJiLKn8Nb8mnTHowBM3UumJQrwKHPam0JYGfo482DoE-w@mail.gmail.com>
 <aElna+n07/Jrfxlh@v4bel-B760M-AORUS-ELITE-AX>
In-Reply-To: <aElna+n07/Jrfxlh@v4bel-B760M-AORUS-ELITE-AX>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 11 Jun 2025 04:28:44 -0700
X-Gm-Features: AX0GCFufjfb5MyqDJn3P1TmPLjOv--LQ0BxiHEctFAonMYvTWKY1idwtOAmX5_s
Message-ID: <CANn89i+Lp5n-+TQHLg1=1FauDt45w0P3mneZaiWD7gRnFesVpg@mail.gmail.com>
Subject: Re: [PATCH] net/sched: fix use-after-free in taprio_dev_notifier
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, vinicius.gomes@intel.com, jhs@mojatatu.com, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	v4bel@theori.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 4:24=E2=80=AFAM Hyunwoo Kim <imv4bel@gmail.com> wro=
te:
>
> On Wed, Jun 11, 2025 at 04:01:50AM -0700, Eric Dumazet wrote:
> > On Wed, Jun 11, 2025 at 3:03=E2=80=AFAM Hyunwoo Kim <imv4bel@gmail.com>=
 wrote:
> > >
> > > Since taprio=E2=80=99s taprio_dev_notifier() isn=E2=80=99t protected =
by an
> > > RCU read-side critical section, a race with advance_sched()
> > > can lead to a use-after-free.
> > >
> > > Adding rcu_read_lock() inside taprio_dev_notifier() prevents this.
> > >
> > > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> >
> > Looks good to me, but we need a Fixes: tag and/or a CC: stable@ o make
> > sure this patch reaches appropriate stable trees.
>
> Understood. I will submit the v2 patch after adding the tags.

Thanks, please wait ~24 hours (as described in
Documentation/process/maintainer-netdev.rst )

>
> >
> > Also please CC the author of the  patch.
>
> Does =E2=80=9CCC=E2=80=9D here refer to a patch tag, or to the email=E2=
=80=99s cc? And by
> =E2=80=9Cpatch author=E2=80=9D you mean the author of the patch
> fed87cc6718ad5f80aa739fee3c5979a8b09d3a6, right?

Exactly. Blamed patch author.

>
> >
> > It seems bug came with
> >
> > commit fed87cc6718ad5f80aa739fee3c5979a8b09d3a6
> > Author: Vladimir Oltean <vladimir.oltean@nxp.com>
> > Date:   Tue Feb 7 15:54:38 2023 +0200
> >
> >     net/sched: taprio: automatically calculate queueMaxSDU based on TC
> > gate durations
> >
> >
> >
> >
> > > ---
> > >  net/sched/sch_taprio.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> > > index 14021b812329..bd2b02d1dc63 100644
> > > --- a/net/sched/sch_taprio.c
> > > +++ b/net/sched/sch_taprio.c
> > > @@ -1320,6 +1320,7 @@ static int taprio_dev_notifier(struct notifier_=
block *nb, unsigned long event,
> > >         if (event !=3D NETDEV_UP && event !=3D NETDEV_CHANGE)
> > >                 return NOTIFY_DONE;
> > >
> > > +       rcu_read_lock();
> > >         list_for_each_entry(q, &taprio_list, taprio_list) {
> > >                 if (dev !=3D qdisc_dev(q->root))
> > >                         continue;
> > > @@ -1328,16 +1329,17 @@ static int taprio_dev_notifier(struct notifie=
r_block *nb, unsigned long event,
> > >
> > >                 stab =3D rtnl_dereference(q->root->stab);
> > >
> > > -               oper =3D rtnl_dereference(q->oper_sched);
> > > +               oper =3D rcu_dereference(q->oper_sched);
> > >                 if (oper)
> > >                         taprio_update_queue_max_sdu(q, oper, stab);
> > >
> > > -               admin =3D rtnl_dereference(q->admin_sched);
> > > +               admin =3D rcu_dereference(q->admin_sched);
> > >                 if (admin)
> > >                         taprio_update_queue_max_sdu(q, admin, stab);
> > >
> > >                 break;
> > >         }
> > > +       rcu_read_unlock();
> > >
> > >         return NOTIFY_DONE;
> > >  }
> > > --
> > > 2.34.1
> > >

