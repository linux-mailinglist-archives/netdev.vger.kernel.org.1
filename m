Return-Path: <netdev+bounces-88753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3F98A8682
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 16:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0870A28475D
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 14:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA451422D1;
	Wed, 17 Apr 2024 14:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cl9dijhY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714641422BD
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 14:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713365067; cv=none; b=Eb5SdQ3F12JAw8OM/t7f3HaAkBwW/9VpQiKefQhBJMQ3wnIjOouBL5FHJI8zqALRL27DFMuF5I9MjgT2BE2ATmpZmBlJexCmt9+Soz4IlQ46mlOG8PlmbBLb2xYtjDccPKai2k29gfkX95J3wgCVuCQ22CX8Lx+VbG+xRGpyrtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713365067; c=relaxed/simple;
	bh=9iDto58taWm3HHZzacLFPP6DkuOYsuHAEVHaOf7v5R0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYpkXPqEgXMXMWFg7dZuIsyCI+KvbnGIkjEmAz/thCr5s3LOvLmi7+8MAkXSS/nK7Xo1jfAkqp+o0zeVjv5AK+Y7fhWs+BdPjLHpqmiREaqj3HwEhgRGlJmxTKr/8yxlY8LkO1C/8YY+1Rg5dkJzN5ozBdzZ5+YpPgtcBqOyay4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cl9dijhY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0091C2BD11;
	Wed, 17 Apr 2024 14:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713365066;
	bh=9iDto58taWm3HHZzacLFPP6DkuOYsuHAEVHaOf7v5R0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cl9dijhYIwj5wEwvQCWqMwCFAfcvdkIYmitGURhQKSPmzlUw60z+MICAv0W+XRg5Y
	 d/5DV27bCbNCnarmmKSySjHmnhYhSkD+MTKH2+CH/geDfjVmeGPVewh9Qgx7EQT6cw
	 NEjIFCoYy8AHfO54JiWx2E3BvIIvC5lgZ6UeRiG8w/2v44Dw7LW6qlQqyc09OFWTj8
	 o3s5A0RZQ5+Cz65WwnJjTuCtCc+nqW2Zr1vs6gqpPxs6fjIFLGECv4XyXrpKvGP6Us
	 rzV0SC3CRwsD5X8Lo7dh/WS/dRM+cYwlEbJ/NFV2P84oisxX5zgjmR0vv1WgZwXygv
	 tSmZLYZLw911A==
Date: Wed, 17 Apr 2024 15:44:21 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 04/14] net_sched: sch_choke: implement lockless
 choke_dump()
Message-ID: <20240417144421.GY2320920@kernel.org>
References: <20240415132054.3822230-1-edumazet@google.com>
 <20240415132054.3822230-5-edumazet@google.com>
 <20240417131404.GX2320920@kernel.org>
 <CANn89iJkEzcU1-8yJF6AvYUqiE1U8-4oUcLOe73EtV=sHHnjZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJkEzcU1-8yJF6AvYUqiE1U8-4oUcLOe73EtV=sHHnjZw@mail.gmail.com>

On Wed, Apr 17, 2024 at 03:41:36PM +0200, Eric Dumazet wrote:
> On Wed, Apr 17, 2024 at 3:14 PM Simon Horman <horms@kernel.org> wrote:
> >
> > On Mon, Apr 15, 2024 at 01:20:44PM +0000, Eric Dumazet wrote:
> > > Instead of relying on RTNL, choke_dump() can use READ_ONCE()
> > > annotations, paired with WRITE_ONCE() ones in choke_change().
> > >
> > > Also use READ_ONCE(q->limit) in choke_enqueue() as the value
> > > could change from choke_change().
> >
> > Hi Eric,
> >
> > I'm wondering if you could expand on why q->limit needs this treatment
> > but not other fields, f.e. q->parms.qth_min (aka p->qth_min).
> 
> Other fields got their WRITE_ONCE() in red_set_parms()
> 
> +       WRITE_ONCE(p->qth_min, qth_min << Wlog);
> +       WRITE_ONCE(p->qth_max, qth_max << Wlog);
> +       WRITE_ONCE(p->Wlog, Wlog);
> +       WRITE_ONCE(p->Plog, Plog);

Thanks, understood.

I do wonder if other schedulers may need WRITE_ONCE() in
their enqueue() function. But I have not analysed this yet.

> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > ---
> > >  include/net/red.h     | 10 +++++-----
> > >  net/sched/sch_choke.c | 23 ++++++++++++-----------
> > >  2 files changed, 17 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/include/net/red.h b/include/net/red.h
> >
> > ...
> >
> > > @@ -244,7 +244,7 @@ static inline void red_set_parms(struct red_parms *p,
> > >               max_P = red_maxp(Plog);
> > >               max_P *= delta; /* max_P = (qth_max - qth_min)/2^Plog */
> > >       }
> > > -     p->max_P = max_P;
> > > +     WRITE_ONCE(p->max_P, max_P);
> > >       max_p_delta = max_P / delta;
> > >       max_p_delta = max(max_p_delta, 1U);
> > >       p->max_P_reciprocal  = reciprocal_value(max_p_delta);
> >
> > A little further down in this function p->Scell_log is set.
> > I think it also needs the WRITE_ONCE() treatment as it
> > is read in choke_dump().
> >
> 
> I will squash in v2 the missing WRITE_ONCE(), thanks !

Likewise, thanks.
Your proposed update looks good to me.

> diff --git a/include/net/red.h b/include/net/red.h
> index 7daf7cf6130aeccf3d81a77600f4445759f174b7..802287d52c9e37e76ba9154539f511629e4b9780
> 100644
> --- a/include/net/red.h
> +++ b/include/net/red.h
> @@ -257,7 +257,7 @@ static inline void red_set_parms(struct red_parms *p,
>         p->target_min = qth_min + 2*delta;
>         p->target_max = qth_min + 3*delta;
> 
> -       p->Scell_log    = Scell_log;
> +       WRITE_ONCE(p->Scell_log, Scell_log);
>         p->Scell_max    = (255 << Scell_log);
> 
>         if (stab)
> 

