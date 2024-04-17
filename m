Return-Path: <netdev+bounces-88828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1308A8A11
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 19:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB4101C2274C
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 17:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B851C16FF48;
	Wed, 17 Apr 2024 17:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPOvekzO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949F11487DE
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 17:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713374253; cv=none; b=WXhHKWR5a7c5CE5lFGjKlER/KhrjPSVAICjfEd3/vfJQQ0Bw5/u4BUXIehbrHzm3cvkjHLNNzwu9Bz2/pwxUE2qiXUJm+MUY1hhUOOmE/rRVvijTRmpfYPbFhjEStclst+9ZvO9P6Ib7nlE9cjZitR9oOTYfejHYrpc9Xa3FC6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713374253; c=relaxed/simple;
	bh=fh9nodipvRe6S7FIDVfMLr1jpG73ycPEFgF+HEVabHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnoZYRzjtKhFqufJU0raoJPYmMSBvPTw/1odgn2rypLIU5eumlgL7fDnljsTUMoP7N/OOgrsMgFCWQe5ug55zpXzX3K0yWRIcSsohFt52DLnHQqiPhnR/tHVMv7b1kvGel4mmN+HFeuRgJJtKKBQMDcd3PzX3hrJVftsW2i8iQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPOvekzO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8DCC072AA;
	Wed, 17 Apr 2024 17:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713374253;
	bh=fh9nodipvRe6S7FIDVfMLr1jpG73ycPEFgF+HEVabHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RPOvekzO4Ar7AD1xtwyBPyOEVD0zRrxLO4dBOWxxcLpqloOmPUZT7yqj6dIMwmRe0
	 Y6hARy+jGR13Dz+MUY9uTvdGxDh5VOtmO5fQSx+mCGSi+Rk48F07661ONvDujGmAyh
	 RaQLn6mtGMQRe/m0hCXE4kkfElM363L8FqoOaxmOua7nTKNjqmGorztVa4NYSh1QRa
	 9846lK/50gUpTo06TqYEng9dwPKvBwNwjtWCy02X/5ZwcpSuyGwLjLwvaMzVzk3JP+
	 DW90TSvCrMwB4WMUL1je7nyhIU7QuTsA5bTy+AXWEI5rI2iq0NCjyi+4zE/vwxd21M
	 MBdSzpzKbGW6g==
Date: Wed, 17 Apr 2024 18:17:28 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 07/14] net_sched: sch_ets: implement lockless
 ets_dump()
Message-ID: <20240417171728.GG2320920@kernel.org>
References: <20240415132054.3822230-1-edumazet@google.com>
 <20240415132054.3822230-8-edumazet@google.com>
 <20240417165425.GD2320920@kernel.org>
 <CANn89i+Z+Wz_V8+1vaRzVgoZCecTXd4bVhwR5Bjq9+q_3f_s4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+Z+Wz_V8+1vaRzVgoZCecTXd4bVhwR5Bjq9+q_3f_s4A@mail.gmail.com>

On Wed, Apr 17, 2024 at 07:08:17PM +0200, Eric Dumazet wrote:
> On Wed, Apr 17, 2024 at 6:54 PM Simon Horman <horms@kernel.org> wrote:
> >
> > On Mon, Apr 15, 2024 at 01:20:47PM +0000, Eric Dumazet wrote:
> > > Instead of relying on RTNL, ets_dump() can use READ_ONCE()
> > > annotations, paired with WRITE_ONCE() ones in ets_change().
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > ---
> > >  net/sched/sch_ets.c | 25 ++++++++++++++-----------
> > >  1 file changed, 14 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
> > > index 835b4460b44854a803d3054e744702022b7551f4..f80bc05d4c5a5050226e6cfd30fa951c0b61029f 100644
> > > --- a/net/sched/sch_ets.c
> > > +++ b/net/sched/sch_ets.c
> >
> > ...
> >
> > > @@ -658,11 +658,11 @@ static int ets_qdisc_change(struct Qdisc *sch, struct nlattr *opt,
> > >                       list_del(&q->classes[i].alist);
> > >               qdisc_tree_flush_backlog(q->classes[i].qdisc);
> > >       }
> > > -     q->nstrict = nstrict;
> > > +     WRITE_ONCE(q->nstrict, nstrict);
> > >       memcpy(q->prio2band, priomap, sizeof(priomap));
> >
> > Hi Eric,
> >
> > I think that writing elements of q->prio2band needs WRITE_ONCE() treatment too.
> 
> Not really, these are bytes, a cpu will not write over bytes one bit at a time.
> 
> I could add WRITE_ONCE(), but this is overkill IMO.

Thanks, armed with that understanding I'm now happy with this patch.

Reviewed-by: Simon Horman <horms@kernel.org>

> > >       for (i = 0; i < q->nbands; i++)
> > > -             q->classes[i].quantum = quanta[i];
> > > +             WRITE_ONCE(q->classes[i].quantum, quanta[i]);
> > >
> > >       for (i = oldbands; i < q->nbands; i++) {
> > >               q->classes[i].qdisc = queues[i];
> >
> > ...
> >
> > > @@ -733,6 +733,7 @@ static int ets_qdisc_dump(struct Qdisc *sch, struct sk_buff *skb)
> > >       struct ets_sched *q = qdisc_priv(sch);
> > >       struct nlattr *opts;
> > >       struct nlattr *nest;
> > > +     u8 nbands, nstrict;
> > >       int band;
> > >       int prio;
> > >       int err;
> >
> > The next few lines of this function are:
> >
> >         err = ets_offload_dump(sch);
> >         if (err)
> >                 return err;
> >
> > Where ets_offload_dump may indirectly call ndo_setup_tc().
> > And I am concerned that ndo_setup_tc() expects RTNL to be held,
> > although perhaps that assumption is out of date.
> 
> Thanks, we will add rtnl locking later only in the helper,
> or make sure it can run under RCU.
> 
> Note the patch series does not yet remove RTNL locking.

Yes, I understand that.
I was more flagging this as something that needs to be addressed.
Sorry for not being clearer.

> Clearly, masking and setting TCQ_F_OFFLOADED in sch->flags in a dump
> operation is not very nice IMO.

Yes, I noticed that too.

...

