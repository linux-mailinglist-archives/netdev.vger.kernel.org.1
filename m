Return-Path: <netdev+bounces-88830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A085A8A8A22
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 19:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 937E6B24D69
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 17:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE04171652;
	Wed, 17 Apr 2024 17:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZVvBtH7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA1813C8E9
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 17:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713374622; cv=none; b=RMbnb+XZksqtRmBBBo222gGdk22hiRONk4vHL4joBwJePcIJIscxhiKkTtzfBKNCxpVxngTNqvOR+2lukQ5sc0A69fmTjQl4qwbaHSTqpAe8dHK2zuqO9MqD1VAh+SFcqH9v2kXti2NjJzDu+0+dGtT4mOSj5fGUbIXWcERmOqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713374622; c=relaxed/simple;
	bh=ysw2rDp+Swxsr/NCkU/32ih13HY+hLDmiZ47nbZ6mNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgK7nXq0bADqEnBO3jUVlkBZjK4q49vsBj5+dBFiW7QAOPyod9mkeGxYOBBv2e4sB6Y+vOZ8mHA3xbSveaw4tD/7NcYNuAmvIu/DRB2u11bHGLyAeZM6YRBONzu0ykeXdfNQqUcKsHb+/IVkperkBLet7y7pl4XcaFqq2mZVWAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZVvBtH7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E81EC072AA;
	Wed, 17 Apr 2024 17:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713374622;
	bh=ysw2rDp+Swxsr/NCkU/32ih13HY+hLDmiZ47nbZ6mNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lZVvBtH7uN+uA2tzZY93e0kjM924TP8G5vDLhQ/M6KQ4z0q4vN0dRziUXfXUnqrT3
	 gJOQeAAbStWh5WOdJEnJCVmcP7gt0jht8UjXmfl5Ag6n3FrVthHDwprWi4RQ95u874
	 1yeyCids4CEWon2VPMyS8uuv8wiLC8OIDxk6CwDjRwzWXMLeuy3PhCJn6U516JeQB3
	 0EZnWZWFcmllpJ+2Ry4ljAlTP3fOoKogeZKRgwC2ubO9iAADb+In9GaiT6JSF77aKe
	 ZAbUtoIBIAjgiorOnxb40zUcalYJlSu9tOg0/yCVXp3PSHqn8DTRK2HpS+D1dxGUfj
	 D4O4qpiT0/D2A==
Date: Wed, 17 Apr 2024 18:23:38 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 10/14] net_sched: sch_fq_pie: implement lockless
 fq_pie_dump()
Message-ID: <20240417172338.GI2320920@kernel.org>
References: <20240415132054.3822230-1-edumazet@google.com>
 <20240415132054.3822230-11-edumazet@google.com>
 <20240417171349.GF2320920@kernel.org>
 <CANn89iL7nZY61RJhkWXkfa8GdTPgWY6mJ__rWk-eU6wDierG2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iL7nZY61RJhkWXkfa8GdTPgWY6mJ__rWk-eU6wDierG2Q@mail.gmail.com>

On Wed, Apr 17, 2024 at 07:15:40PM +0200, Eric Dumazet wrote:
> On Wed, Apr 17, 2024 at 7:13 PM Simon Horman <horms@kernel.org> wrote:
> >
> > On Mon, Apr 15, 2024 at 01:20:50PM +0000, Eric Dumazet wrote:
> > > Instead of relying on RTNL, fq_pie_dump() can use READ_ONCE()
> > > annotations, paired with WRITE_ONCE() ones in fq_pie_change().
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > ---
> > >  net/sched/sch_fq_pie.c | 61 +++++++++++++++++++++++-------------------
> > >  1 file changed, 34 insertions(+), 27 deletions(-)
> > >
> > > diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
> >
> > ...
> >
> > > @@ -471,22 +477,23 @@ static int fq_pie_dump(struct Qdisc *sch, struct sk_buff *skb)
> > >               return -EMSGSIZE;
> > >
> > >       /* convert target from pschedtime to us */
> > > -     if (nla_put_u32(skb, TCA_FQ_PIE_LIMIT, sch->limit) ||
> > > -         nla_put_u32(skb, TCA_FQ_PIE_FLOWS, q->flows_cnt) ||
> >
> > Hi Eric,
> >
> > I think you missed the corresponding change for q->flows_cnt
> > in fq_pie_change().
> >
> 
> net/sched/sch_fq_pie.c copied the code I wrote in fq_codel,
> q->flows_cnt is set once.

Thanks, I see it now.

Reviewed-by: Simon Horman <horms@kernel.org>


