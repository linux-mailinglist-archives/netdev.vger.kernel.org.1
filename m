Return-Path: <netdev+bounces-88829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595CB8A8A21
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 19:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9435C1C239A5
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 17:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C59A171E78;
	Wed, 17 Apr 2024 17:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBvDDuBT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D65171675
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 17:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713374569; cv=none; b=TyGGTmg3qK3/aLBoVp3z7y/dXwBwQl5aQRwOUZMEKtOfxPTkcDdCMUNIisPt7cPp5QSSWVuh5pUAqASjRNN7rBhiouddeO3CEjRXclTWgiy2tTcFUHtl4vSc8v1w+xXNYfQW6O+M4xfptDkiIu8wZ50ni28ba17nA0SdTuXrg/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713374569; c=relaxed/simple;
	bh=gIqsgJfSyaKqmfdIEmBsxi00/+lqM5htyVgYrc6d7Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TjxYKRH7OTfwQAeErbqf5WmdywBrDl2JdGpUAy5c3VNmZwZ56I3y/FQWy0dV/1UYedDVwEeQX3AjrSgmepH6iJUi3KBA2zxkWyDxfBpzqGMfNK+c3ykIXR3GcvHHvkweP3AfXzXhhGvtaLIG+LeUULPyeKKHrSj0MsEP39F8Mek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBvDDuBT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB2E8C072AA;
	Wed, 17 Apr 2024 17:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713374568;
	bh=gIqsgJfSyaKqmfdIEmBsxi00/+lqM5htyVgYrc6d7Pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kBvDDuBTt4l03qFCVENrQPBitDmdVd1/WIcUMTI9VXuYhQ63/EGqchgzx7NoPLdbB
	 rbH63JhNIlic9kMiajdIsspeNpcXAUTh4//wfpu4XC4QpKzyyZjLpsliEa8pcvvaiE
	 KepFDTymLF+FPPKVswzihshFKr1kT6Bs1nMNd67ET1vowvfwKCVsNDfVVvu3oNiCQR
	 OUaTH92R4fpe1RY2yrqIgN3w3PSfxQiyEMI+Z4aFk25VGO5YvYSHcZ8yLxzfte9J7J
	 9GCDpzpXQMPHDcxz6lPHQzLXTneOUxgtWe2BErHRIaApVBt4HSN6mVTI+7emTrBUle
	 WaSP+1jfWcuUA==
Date: Wed, 17 Apr 2024 18:22:44 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 09/14] net_sched: sch_fq_codel: implement
 lockless fq_codel_dump()
Message-ID: <20240417172244.GH2320920@kernel.org>
References: <20240415132054.3822230-1-edumazet@google.com>
 <20240415132054.3822230-10-edumazet@google.com>
 <20240417170739.GE2320920@kernel.org>
 <CANn89i+jt2dk4yF-k2U3iDcDgwBp-hOs9EGpdHU9F4cEcQteSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+jt2dk4yF-k2U3iDcDgwBp-hOs9EGpdHU9F4cEcQteSw@mail.gmail.com>

On Wed, Apr 17, 2024 at 07:14:10PM +0200, Eric Dumazet wrote:
> On Wed, Apr 17, 2024 at 7:07 PM Simon Horman <horms@kernel.org> wrote:
> >
> > On Mon, Apr 15, 2024 at 01:20:49PM +0000, Eric Dumazet wrote:
> > > Instead of relying on RTNL, fq_codel_dump() can use READ_ONCE()
> > > annotations, paired with WRITE_ONCE() ones in fq_codel_change().
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > ---
> > >  net/sched/sch_fq_codel.c | 57 ++++++++++++++++++++++++----------------
> > >  1 file changed, 35 insertions(+), 22 deletions(-)
> > >
> > > diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
> >
> > ...
> >
> > > @@ -529,30 +539,33 @@ static int fq_codel_dump(struct Qdisc *sch, struct sk_buff *skb)
> > >               goto nla_put_failure;
> > >
> > >       if (nla_put_u32(skb, TCA_FQ_CODEL_TARGET,
> > > -                     codel_time_to_us(q->cparams.target)) ||
> > > +                     codel_time_to_us(READ_ONCE(q->cparams.target))) ||
> > >           nla_put_u32(skb, TCA_FQ_CODEL_LIMIT,
> > > -                     sch->limit) ||
> > > +                     READ_ONCE(sch->limit)) ||
> > >           nla_put_u32(skb, TCA_FQ_CODEL_INTERVAL,
> > > -                     codel_time_to_us(q->cparams.interval)) ||
> > > +                     codel_time_to_us(READ_ONCE(q->cparams.interval))) ||
> > >           nla_put_u32(skb, TCA_FQ_CODEL_ECN,
> > > -                     q->cparams.ecn) ||
> > > +                     READ_ONCE(q->cparams.ecn)) ||
> > >           nla_put_u32(skb, TCA_FQ_CODEL_QUANTUM,
> > > -                     q->quantum) ||
> > > +                     READ_ONCE(q->quantum)) ||
> > >           nla_put_u32(skb, TCA_FQ_CODEL_DROP_BATCH_SIZE,
> > > -                     q->drop_batch_size) ||
> > > +                     READ_ONCE(q->drop_batch_size)) ||
> > >           nla_put_u32(skb, TCA_FQ_CODEL_MEMORY_LIMIT,
> > > -                     q->memory_limit) ||
> > > +                     READ_ONCE(q->memory_limit)) ||
> > >           nla_put_u32(skb, TCA_FQ_CODEL_FLOWS,
> > > -                     q->flows_cnt))
> > > +                     READ_ONCE(q->flows_cnt)))
> >
> > Hi Eric,
> >
> > I think you missed the corresponding update for q->flows_cnt
> > in fq_codel_change().
> 
> q->flows_cnt is set at init time only, it can not change yet.

Sorry, I missed that important detail.

> Blindly using READ_ONCE() in a dump seems good hygiene,
> it is not needed yet, but does no harm.

Thanks, understood.

Reviewed-by: Simon Horman <horms@kernel.org>


