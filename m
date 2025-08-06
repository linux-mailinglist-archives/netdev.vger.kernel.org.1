Return-Path: <netdev+bounces-211993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8F5B1CF79
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 01:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1B4318C4B81
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 23:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A30277C8D;
	Wed,  6 Aug 2025 23:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TbHqmesG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C09F1FCF41
	for <netdev@vger.kernel.org>; Wed,  6 Aug 2025 23:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754523659; cv=none; b=MmINCwpCgePZi02FYlfoG27AE7KJRUf95veKSg8HsvV8DFjonSWKhuokvbC+P9emy9c1nWAnvp9k/DFvIjKwA7o13vOiUk2wE5o3U5pn5rgyuTB/R06DgkylO2oMJTK/3kjI+faTVm5fJvSySDshFKrS4X64YiVH4N+v9i3kRfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754523659; c=relaxed/simple;
	bh=tcWhGqSA7cZWpc5I4rzP0LAuqLWX8NoNnBwUWYwAA2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RKh7tin/6TsDKvnWtQHQyvCBpX/zPW3pspaFu27PUthY9SKr6gN/XqVZ4TDHEwNgV3hSnzKZpvL7scOTQI7OK0TIaeHnE1H03hKzaaO4McBO1xEGb2WvRO1/FIA9TuDokXD6LZScZDhXgTyQKnwJRPmEp4qFaOUbfLHbaKVKRoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TbHqmesG; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76aea119891so1552249b3a.1
        for <netdev@vger.kernel.org>; Wed, 06 Aug 2025 16:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754523657; x=1755128457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+V5MD6/KwNXDMRDn89IDlWGyGIpIEfb7ohjgwGr06Y=;
        b=TbHqmesGA/40B8T57HAYHzklvTIGqlbC8a8eMH4LQaHMyc5urt/JRR4p8fk1PmNFPG
         Wbd0NXLRckUeEJHOs+rIEGT/iQvLGpClaOmYZNjjD/wgmzL7PCN3vJRc6xAZj2p+8fGh
         +YMOv2DyFMDjp0BUdhL4SuNltoWVUmZWpq/1/fH72w5+x1wX6IxW6EZYL1HTpM5Z2WK9
         JUeDEWRDHB6CILf4htSmjkc8hE9LuV9K5NxS5gDHTxNdsFNUGyDXp+WWXYQm/XS9Gn5y
         3kg5EP3G16qh1//7cgcR6wz5ZgjoVuH8cACjXWYYb5OeA5oW5/JqCtu8YHZ1cTHksGG9
         0zNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754523657; x=1755128457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+V5MD6/KwNXDMRDn89IDlWGyGIpIEfb7ohjgwGr06Y=;
        b=sv56+CsewgM/QLTPFYyRbC1YmzKVUouI8H/0VR1Ui9X+muPAzoEmkergUlLgTvOBcE
         6q3qytdOD8r6ayB68cgGC53sp0rVgl02v4pSaaP7Q595EY70Kj2YZJcqksDEjMf0xIqN
         CK1J89ad1zrvvbZ/8r3kR/kufoGMoO+TZR1UBZP+4Q10kyjJKWa4CRLXq8hfF3Xdwu9L
         y2/vaCtcCjb3Q59XvpqZ0lB9It7peMMisTHJulyLHBoJFyvkH/RebHL0K/qAdBsSjLMc
         f6eQxOio5NKA2N6KarrAu63QGqCmoh6dkyHBcKr2YLZ4bjMwHDBsSlrZoa9h6minmoP7
         tCJA==
X-Forwarded-Encrypted: i=1; AJvYcCWQoevXIO3ukvXlTW8Js+ugO5tb2yGbpX0cf2vIFj7LHOleYmpIyDTec8kqLc280QWRzBvO8t8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCedTeV26qiOYUVIVHmNncviiw+BkG2+TXXyJSig+bf1fZgDjf
	331HbHvUU9QHtV0BKaxib9eYsrvBXunhUV1ahOKml7KsmnMpcFHlce5HVXScWtvn9WLjyDUFhO+
	NNbq93e0WOeY8g/tnFa1iQn4mxFdt3SfN1t5nq94U
X-Gm-Gg: ASbGnctQosf52mtUXVY04kywSBhqYb/IfmxeQRyPWAui3SmHDZBK/BzIzf/HNA96QII
	qFdQ6FfpTQWWSzZgIa+d4PGMCevKqA0BvnzUIBcJFRBtmfU8pvBv+EUBmB9f/lgFxx+znRdPdd6
	OAt33kDd3wFBhio2yDqZ2hGMxuvti7pLtnZURGNxtxqEc7chYlgSrfyH6T4joP2T6MItuZYKtyL
	elZJ3k8vDpZepWUN0/XKkZjz2SokhX4f3JMZg==
X-Google-Smtp-Source: AGHT+IE9xx0BslmXdh3PX3583hJLYwZKiRHlhcVZuar+6J/aRROEdJOAGMwU1KyNvxPLk9ne8tw/T2xezEOaTvSGSQY=
X-Received: by 2002:a17:903:28f:b0:234:325:500b with SMTP id
 d9443c01a7336-242b075c43amr21436795ad.22.1754523657123; Wed, 06 Aug 2025
 16:40:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805064429.77876-1-daniel.sedlak@cdn77.com>
 <fcnlbvljynxu5qlzmnjeagll7nf5mje7rwkimbqok6doso37gl@lwepk3ztjga7>
 <CAAVpQUBrNTFw34Kkh=b2bpa8aKd4XSnZUa6a18zkMjVrBqNHWw@mail.gmail.com>
 <nju55eqv56g6gkmxuavc2z2pcr26qhpmgrt76jt5dte5g4trxs@tjxld2iwdc5c>
 <CAAVpQUCCg-7kvzMeSSsKp3+Fu8pvvE5U-H5wkt=xMryNmnF5CA@mail.gmail.com> <chb7znbpkbsf7pftnzdzkum63gt7cajft2lqiqqfx7zol3ftre@7cdg4czr5k4j>
In-Reply-To: <chb7znbpkbsf7pftnzdzkum63gt7cajft2lqiqqfx7zol3ftre@7cdg4czr5k4j>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 6 Aug 2025 16:40:45 -0700
X-Gm-Features: Ac12FXyPFTWmf4LzgmzsB_A4EJ6yxnsuvE00MbfxXyp9hRdFCTtZYOCeXLJDM_E
Message-ID: <CAAVpQUB_aEcbOJR==z=KbfC1FtWi2NM_wNm_p+9vL1xqfw7cEQ@mail.gmail.com>
Subject: Re: [PATCH v4] memcg: expose socket memory pressure in a cgroup
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Daniel Sedlak <daniel.sedlak@cdn77.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, netdev@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Matyas Hurtik <matyas.hurtik@cdn77.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 4:34=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.dev=
> wrote:
>
> On Wed, Aug 06, 2025 at 03:01:44PM -0700, Kuniyuki Iwashima wrote:
> > On Wed, Aug 6, 2025 at 2:54=E2=80=AFPM Shakeel Butt <shakeel.butt@linux=
.dev> wrote:
> > >
> > > On Wed, Aug 06, 2025 at 12:20:25PM -0700, Kuniyuki Iwashima wrote:
> > > > > > -                     WRITE_ONCE(memcg->socket_pressure, jiffie=
s + HZ);
> > > > > > +                     socket_pressure =3D jiffies + HZ;
> > > > > > +
> > > > > > +                     jiffies_diff =3D min(socket_pressure - RE=
AD_ONCE(memcg->socket_pressure), HZ);
> > > > > > +                     memcg->socket_pressure_duration +=3D jiff=
ies_to_usecs(jiffies_diff);
> > > > >
> > > > > KCSAN will complain about this. I think we can use atomic_long_ad=
d() and
> > > > > don't need the one with strict ordering.
> > > >
> > > > Assuming from atomic_ that vmpressure() could be called concurrentl=
y
> > > > for the same memcg, should we protect socket_pressure and duration
> > > > within the same lock instead of mixing WRITE/READ_ONCE() and
> > > > atomic?  Otherwise jiffies_diff could be incorrect (the error is sm=
aller
> > > > than HZ though).
> > > >
> > >
> > > Yeah good point. Also this field needs to be hierarchical. So, with l=
ock
> > > something like following is needed:
> > >
> > >         if (!spin_trylock(memcg->net_pressure_lock))
> > >                 return;
> > >
> > >         socket_pressure =3D jiffies + HZ;
> > >         diff =3D min(socket_pressure - READ_ONCE(memcg->socket_pressu=
re), HZ);
> >
> > READ_ONCE() should be unnecessary here.
> >
> > >
> > >         if (diff) {
> > >                 WRITE_ONCE(memcg->socket_pressure, socket_pressure);
> > >                 // mod_memcg_state(memcg, MEMCG_NET_PRESSURE, diff);
> > >                 // OR
> > >                 // while (memcg) {
> > >                 //      memcg->sk_pressure_duration +=3D diff;
> > >                 //      memcg =3D parent_mem_cgroup(memcg);
> >
> > The parents' sk_pressure_duration is not protected by the lock
> > taken by trylock.  Maybe we need another global mutex if we want
> > the hierarchy ?
>
> We don't really need lock protection for sk_pressure_duration. The lock
> is only giving us consistent value of diff. Once we have computed the
> diff, we can add it to sk_pressure_duration of a memcg and all of its
> ancestor without lock.

Maybe I'm wrong but I was assuming two vmpressure() called
concurrently for cgroup-C and cgroup-D, and one updates
cgroup-C's duration and another updates C&D duration.

cgroup-A -> cgroup-B -> cgroup-C -> cgroup-D

Could that happen ?  Even if it's yes, we could use atomic ops.

