Return-Path: <netdev+bounces-88782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710E58A88C1
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 18:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9388E1C20A62
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 16:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D90B14883C;
	Wed, 17 Apr 2024 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cITiaTAR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57604148836
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713370913; cv=none; b=TjM+V19t9ibZbwMi91303dnJsoFLRP+RH9ZRrcKjvhFdvlViTnaxo19J8iQdaZZv58Vw4x4Pffu8hz+v+QBKFYWj2Y7PG/TfErx2X8XBkSANUP4lNjGe9Zg9KCI16VIt2m9cfkyyJUXgA723B6ndEFuU2lNmKruR1M3XA9yIcOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713370913; c=relaxed/simple;
	bh=61UJJewAuGz/IlEi/f9Mwr2h9yYY1PIb9Bx7QImB5Ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cut7QujyW12OtTPkWeks2QjGzhVgTtSZZlE5KaC2eOkUCrJwUpn2p21qdw0EshncwAmODB3qIt4ht4N2UbKJBvarjAeGNoT6m+bbLlgVUMPDiLOnMRQ03ycYXau6PFHl7VZVxHI6DwZVCKU0wGgOEUmymM0QJKdoYuBtqBl+yJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cITiaTAR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1B2C072AA;
	Wed, 17 Apr 2024 16:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713370913;
	bh=61UJJewAuGz/IlEi/f9Mwr2h9yYY1PIb9Bx7QImB5Ig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cITiaTARvdymXaxyCHeFERvXTL07bEqF2JSed3ZEmoyVOnIN7gr5KHwlSiAbIDETm
	 x2DerkOL3P6t59pDQsXCyXBEBq4vySkw2DFMms7/gSSr25yvYpS035mZbx15tgiw4i
	 +RjsH2AeOTbcbWYNf0wZ2l6S92plgI+QJpVYfnBdab4iVvsF4yAX+H66/3VV04Vb3l
	 mlsroOio6NjwsMAX6ZW1lWzjSmnAIvIJl6nxsrUcpbSvxES5rprdVU/L9BOffvk4RV
	 ZIwwyghEPJ/BAFjlt6KK7R4U6cMxJv1ML8+/HpuqePLOR8EuHp60K5z7fynGStxK5X
	 MP4/K2QyypO+g==
Date: Wed, 17 Apr 2024 17:21:48 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 05/14] net_sched: sch_codel: implement lockless
 codel_dump()
Message-ID: <20240417162148.GB2320920@kernel.org>
References: <20240415132054.3822230-1-edumazet@google.com>
 <20240415132054.3822230-6-edumazet@google.com>
 <20240417155909.GZ2320920@kernel.org>
 <CANn89iLKtpszMyzmOvj0QdQCvsyDv7S_R04SrfEdOMZb5HQexQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLKtpszMyzmOvj0QdQCvsyDv7S_R04SrfEdOMZb5HQexQ@mail.gmail.com>

On Wed, Apr 17, 2024 at 06:05:46PM +0200, Eric Dumazet wrote:
> On Wed, Apr 17, 2024 at 5:59 PM Simon Horman <horms@kernel.org> wrote:
> >
> > On Mon, Apr 15, 2024 at 01:20:45PM +0000, Eric Dumazet wrote:
> > > Instead of relying on RTNL, codel_dump() can use READ_ONCE()
> > > annotations, paired with WRITE_ONCE() ones in codel_change().
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > ---
> > >  net/sched/sch_codel.c | 29 ++++++++++++++++++-----------
> > >  1 file changed, 18 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/net/sched/sch_codel.c b/net/sched/sch_codel.c
> > > index ecb3f164bb25b33bd662c8ee07dc1b5945fd882d..3e8d4fe4d91e3ef2b7715640f6675aa5e8e2a326 100644
> > > --- a/net/sched/sch_codel.c
> > > +++ b/net/sched/sch_codel.c
> > > @@ -118,26 +118,31 @@ static int codel_change(struct Qdisc *sch, struct nlattr *opt,
> > >       if (tb[TCA_CODEL_TARGET]) {
> > >               u32 target = nla_get_u32(tb[TCA_CODEL_TARGET]);
> > >
> > > -             q->params.target = ((u64)target * NSEC_PER_USEC) >> CODEL_SHIFT;
> > > +             WRITE_ONCE(q->params.target,
> > > +                        ((u64)target * NSEC_PER_USEC) >> CODEL_SHIFT);
> > >       }
> > >
> > >       if (tb[TCA_CODEL_CE_THRESHOLD]) {
> > >               u64 val = nla_get_u32(tb[TCA_CODEL_CE_THRESHOLD]);
> > >
> > > -             q->params.ce_threshold = (val * NSEC_PER_USEC) >> CODEL_SHIFT;
> > > +             WRITE_ONCE(q->params.ce_threshold,
> > > +                        (val * NSEC_PER_USEC) >> CODEL_SHIFT);
> > >       }
> > >
> > >       if (tb[TCA_CODEL_INTERVAL]) {
> > >               u32 interval = nla_get_u32(tb[TCA_CODEL_INTERVAL]);
> > >
> > > -             q->params.interval = ((u64)interval * NSEC_PER_USEC) >> CODEL_SHIFT;
> > > +             WRITE_ONCE(q->params.interval,
> > > +                        ((u64)interval * NSEC_PER_USEC) >> CODEL_SHIFT);
> > >       }
> > >
> > >       if (tb[TCA_CODEL_LIMIT])
> > > -             sch->limit = nla_get_u32(tb[TCA_CODEL_LIMIT]);
> > > +             WRITE_ONCE(sch->limit,
> > > +                        nla_get_u32(tb[TCA_CODEL_LIMIT]));
> > >
> >
> > Hi Eric,
> >
> > Sorry to be so bothersome.
> >
> > As a follow-up to our discussion of patch 4/14 (net_choke),
> > I'm wondering if reading sch->limit in codel_qdisc_enqueue()
> > should be updated to use READ_ONCE().
> 
> No worries !
> 
> A READ_ONCE() in codel_qdisc_enqueue() is not needed
> because codel_change() writes  all the fields  under the protection of
> qdisc spinlock.
> 
> sch_tree_lock() / ... / sch_tree_unlock()
> 
> Note that I removed the READ_ONCE() in choke enqueue() in V2,
> for the same reason.

Perfect, now I understand.

With that cleared up, I'm happy with (my understanding of) this patch.

Reviewed-by: Simon Horman <horms@kernel.org>


