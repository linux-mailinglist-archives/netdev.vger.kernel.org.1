Return-Path: <netdev+bounces-193656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 357F3AC5002
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 15:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F36781BA1F00
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 13:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4962749D9;
	Tue, 27 May 2025 13:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kkeUF6r5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D5127146A
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 13:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748353055; cv=none; b=s3c8Sx8M24wL5lXE1dX2OasylarFVAiatsmxNWAlcioCU5zjkfYpgoSFwklNru0zB5VvbKfC0Ch0FLnEgpY9RFaqPnw/mXqiVP+wae9f/1PmjdbAgl8Ea6DzcoWcKIL1rkJcLd+MSM9UlgxT6IoalW2brC2fzLAgtjmjMDobPMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748353055; c=relaxed/simple;
	bh=ifvf430JPDbe1qF9aTpOKg1CLqvI0uQ5QKpQwKYGJew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+/z4JNqkzWFokl7rg9RC/Fka1yiBeTF67CJzifer8NE8iDZPHPtOIluC48b4frTogthN35b1G507ojdF5uqNQ3TqatoT2vtL4GapfZrUo/WKtgw0tm7Vg7QDpN0l7m/lj7aYqtL0c6rpLKJhU776TBdaLZn0jag6JW9pMbdER0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kkeUF6r5; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-476af5479feso31820671cf.2
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 06:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748353052; x=1748957852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DfXclIybJgrhp7Ns7X38FYQwzivRLt7u8VY7d1k9FQ=;
        b=kkeUF6r56r1zP9RpL3Q/2ownEbl4UPJupGILb4DBSKeLJCtI4IXpGzujBGEJ3vGVB6
         UBV3rdhvZriBrbJUSvjGrPzrc6OoM3EIHphMd7MSX/MoLPMGMnlto0O3KoybSFElNSHL
         WRgx7s2+PfPHJDBPQ2q1CYHvO9TtCCcX98Q00+RaGQwXrlQP70a7dPFHO2HpQAc5hdwS
         6MZAyN+QQsGY/RPZjbA90RMxT6mtfgm76GOgXkeTDZLun+L2bvrNidlIKtiIctUOD8fU
         9h1Wi3Zb0CG7gPCPCza4EGssgCEaibo0qTkthHNbP3Zcat9T40XuaTiBiJRWPrrVcik4
         /Wag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748353052; x=1748957852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1DfXclIybJgrhp7Ns7X38FYQwzivRLt7u8VY7d1k9FQ=;
        b=bMo8xM142bQ7mjBuyIQFKIz4eF3ZQPmuLR27KZy+wn3sLOIXM/zmie0ft+V5MlS9Zn
         dzL1hYI/tL5ig36Evo1sFRg9DzM7LShADVv1+0UO7tnByhMv45BYhb+s7jyJJgXhWeOv
         eGer9XJ6r+cpgOXUk4O6dQruqB6219fPqK70p7tA3rJiEgsTMa1yfnuBlhmtAbj4bN3f
         rQBY06NS5frjnm83RmHuqkODP0P5SPe4pLCMRMrLXoKzwa4IWNUqqSJcqy9xXtDGgYgF
         Yqxzx7JWHHtBm9g7ZqBbPlCFpH+fSyENk3msxTP+8AMeHg29pm9C1zznoiaAsEjEXVDj
         /deQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPeavzCpCs2aBV34phhRxA/MTTteaPdx8S2lIMwjEhYQLn/N56/RD1j8dMGomKSlCM8qXJOS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPcVTBhJni7uzTkeuK+0nRJ41Oyn9GbEsJQXAlxF2vA2K9LPzO
	ZxvhOnIuZdq4Mt9T/99TqOQlDkTUl6gnUEp4zAVHIg+KVsDzQNwbrj5wj59E4WMTzLvOFnsTDIX
	4kwOtME7IRyh2Lpa+Ad3wUPx836TKe+1oQte7GTDX
X-Gm-Gg: ASbGncvFQu8UYuDG7h/J5pHEQD/nSqwmP56YWFttX57gwwMQ78TyA4X67DBYCflaT0u
	eqR5bMW2I9kao3NX/pDgJvzhJpNbJUuE676AfV6ytj1vwb4BT+aBdCHdfgnCozhy7MhKMTEcWxo
	Q867i7k74RrqGrQh0fMbxom0bxssqj0I8YBUDSkjVvR5l/
X-Google-Smtp-Source: AGHT+IE7m4Cq3bQJjOeyJAia21VMlshs95gl112B78zB/spj93HG+Zo7WNUPRTmVelhviwuo19ZaiquZWB2TPUAPtQk=
X-Received: by 2002:a05:622a:5512:b0:476:7eca:57e7 with SMTP id
 d75a77b69052e-49f46d31350mr213132041cf.26.1748353052042; Tue, 27 May 2025
 06:37:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527-reftrack-dbgfs-v10-0-dc55f7705691@kernel.org>
 <20250527-reftrack-dbgfs-v10-8-dc55f7705691@kernel.org> <CANn89i+PFJguSKfbiX1nWSvPA2S8O-pb7HxVT4+zkjMdD3meqg@mail.gmail.com>
In-Reply-To: <CANn89i+PFJguSKfbiX1nWSvPA2S8O-pb7HxVT4+zkjMdD3meqg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 27 May 2025 06:37:21 -0700
X-Gm-Features: AX0GCFsrSMIV6ani5r800MRwO3KbNjXkHyjYRDMotIUPivEBkfDrOZ2V5akOvLk
Message-ID: <CANn89i+qv8SsgdDv9PUG=Yuw1KMUyZC=_KqWdYOBL4p3nmcd1g@mail.gmail.com>
Subject: Re: [PATCH v10 8/9] net: add symlinks to ref_tracker_dir for netns
To: Jeff Layton <jlayton@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Qasim Ijaz <qasdev00@gmail.com>, Nathan Chancellor <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 6:35=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, May 27, 2025 at 4:34=E2=80=AFAM Jeff Layton <jlayton@kernel.org> =
wrote:
> >
> > After assigning the inode number to the namespace, use it to create a
> > unique name for each netns refcount tracker with the ns.inum and
> > net_cookie values in it, and register a symlink to the debugfs file for
> > it.
> >
> > init_net is registered before the ref_tracker dir is created, so add a
> > late_initcall() to register its files and symlinks.
> >
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  net/core/net_namespace.c | 30 +++++++++++++++++++++++++++++-
> >  1 file changed, 29 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> > index 8708eb975295ffb78de35fcf4abef7cc281f5a51..39b01af90d240df48827e5c=
3159c3e2253e0a44d 100644
> > --- a/net/core/net_namespace.c
> > +++ b/net/core/net_namespace.c
> > @@ -791,12 +791,40 @@ struct net *get_net_ns_by_pid(pid_t pid)
> >  }
> >  EXPORT_SYMBOL_GPL(get_net_ns_by_pid);
> >
> > +#ifdef CONFIG_NET_NS_REFCNT_TRACKER
> > +static void net_ns_net_debugfs(struct net *net)
> > +{
> > +       ref_tracker_dir_symlink(&net->refcnt_tracker, "netns--%lx-%u-re=
fcnt",
> > +                               net->net_cookie, net->ns.inum);
>
> With proper annotations, you should be able to catch format error as in:
>
> warning: format =E2=80=98%lx=E2=80=99 expects argument of type =E2=80=98l=
ong unsigned int=E2=80=99,
> but argument x has type =E2=80=98u64=E2=80=99 {aka =E2=80=98long long uns=
igned int=E2=80=99}
> [-Wformat=3D]

Reference:

include/linux/compiler_attributes.h:158:#define __printf(a, b)
         __attribute__((__format__(printf, a, b)))

